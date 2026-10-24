unit untReformaGravacaoHost;

{*************************************************************************}
{* PORTA DE BANCO DO PLUGIN libReformaPrecos (Reforma.Contrato.*): CONSULTA, *}
{* TRANSACAO E GRAVACAO COM LOGREP. SAIU DO untReformaHostAdapter PARA SER  *}
{* USADA TAMBEM FORA DO CADASTRO DE PRODUTOS (SUBIDA DO AUTCOM, CONVERT).   *}
{*************************************************************************}

interface

uses
  Windows, Uni, Reforma.Contrato.Gravacao, Reforma.Contrato.Host;

type
  // Transacao aberta para o plugin (Convert). Liberar sem Confirmar desfaz.
  TReformaTransacao = class(TInterfacedObject, IReformaTransacao)
  private
    FblnAberta: Boolean;
    FstrErro: String;
  public
    // AstrErro preenchido: a transacao nao abriu. Confirmar devolve o motivo e Desfazer nao faz nada.
    constructor Create(Const AstrErro: String = '');
    destructor Destroy; override;

    function Confirmar: TResultadoGravacao;
    procedure Desfazer;
  end;

  // Porta de escrita do plugin: a LOGREP nasce do gancho do UniDAC que so existe no exe (untModuloReplicacao),
  // entao quem executa e o host. Nenhuma excecao volta para a DLL: tudo vira TResultadoGravacao.
  TReformaGravacao = class(TInterfacedObject, IReformaGravacao)
  private
    function fResultado(Const AblnSucesso: Boolean; Const AintLinhas: Integer; Const AstrMensagem: String): TResultadoGravacao;
    function fIdentificadorValido(Const AstrNome: String): Boolean;
    function fMontaSql(Const AComando: TComandoGravacao; out AstrSql: String; out AstrErro: String): Boolean;
    procedure pPreencheParametros(Const AqryGrava: TUniQuery; Const AComando: TComandoGravacao);
  public
    function Executar(Const AComando: TComandoGravacao): TResultadoGravacao;
    function ExecutarSql(Const AstrSql: String; Const AarrParametros: Array Of TValorCampo): TResultadoGravacao;
    function IniciarTransacao: IReformaTransacao;
    function TabelaDisponivel(Const AstrTabela: String): Boolean;
  end;

  TReformaConsulta = class(TInterfacedObject, IReformaConsulta)
  private
    FqryConsulta: TUniQuery;
  public
    constructor Create(Const AstrSql: String);
    destructor Destroy; override;

    procedure DefinirParametro(Const AstrNome: String; Const AvarValor: Variant);
    procedure Abrir;
    function Vazia: Boolean;
    function ValorCampo(Const AstrNome: String): Variant;
    // Contrato 6: navegacao.
    function Proximo: Boolean;
    function Fim: Boolean;
  end;

  // So o banco, sem o cadastro de produtos: o plugin prepara as tabelas dele com isto (subida do autcom).
  TReformaBancoHost = class(TInterfacedObject, IReformaBancoHost)
  public
    function AbrirConsulta(Const AstrSql: String): IReformaConsulta;
    function Gravacao: IReformaGravacao;
  end;

// Subida do autcom: com a libReformaPrecos.dll na pasta do exe, cria as tabelas que o plugin espera e acrescenta
// as colunas e os indices que faltam. Sem a DLL, ou DLL de outro contrato, nada acontece. Falha nao impede o
// sistema de subir: vai para o log.
procedure pReformaPrepararBanco;

implementation

uses
  SysUtils, Classes, Variants, DB, Forms, untConstantes, untFuncoesSimples,
  Reforma.Contrato.Exportacao, Reforma.Contrato.Assinatura;

// Estas rotinas rodam chamadas pela DLL, e a excecao do host nao pode atravessar para ela (outra classe Exception:
// "is" e "On E: Exception" nao batem la). Falha no rollback nao tem o que a DLL faca: a conexao e quem decide.
procedure pRollBackSemExcecao;
begin
  Try
    fRollBack;
  Except
    On E: Exception Do
      // So log: o chamador nao pode saber (a conexao decide o estado da transacao), mas sem isso uma
      // falha aqui fica muda - transacao presa e lock no banco sem nenhum rastro.
      pLog('REFTRI pRollBackSemExcecao: ' + E.Message);
  End;
end;

{ TReformaTransacao }

constructor TReformaTransacao.Create(Const AstrErro: String);
begin
  inherited Create;
  FstrErro := AstrErro;
  FblnAberta := AstrErro = '';
end;

destructor TReformaTransacao.Destroy;
begin
  // Plugin que esqueceu de confirmar ou falhou no meio: nunca deixa transacao aberta.
  If FblnAberta Then
    pRollBackSemExcecao;

  inherited;
end;

function TReformaTransacao.Confirmar: TResultadoGravacao;
begin
  Result.Sucesso := False;
  Result.LinhasAfetadas := 0;
  Result.Mensagem := '';

  If Not FblnAberta Then
  Begin
    If FstrErro <> '' Then
      Result.Mensagem := FstrErro
    Else
      Result.Mensagem := 'A transacao ja foi encerrada.';
    Exit;
  End;

  Try
    // fCommit levanta erro quando a LOGREP falhou (blnErroLogRep): nada do que foi gravado fica.
    If fCommit Then
      Result.Sucesso := True
    Else
    Begin
      pRollBackSemExcecao;
      Result.Mensagem := 'Nao foi possivel confirmar a transacao.';
    End;
  Except
    On E: Exception Do
    Begin
      pRollBackSemExcecao;
      Result.Mensagem := E.Message;
    End;
  End;

  FblnAberta := False;
end;

procedure TReformaTransacao.Desfazer;
begin
  If FblnAberta Then
  Begin
    pRollBackSemExcecao;
    FblnAberta := False;
  End;
end;

{ TReformaGravacao }

function TReformaGravacao.fResultado(Const AblnSucesso: Boolean; Const AintLinhas: Integer; Const AstrMensagem: String): TResultadoGravacao;
begin
  Result.Sucesso := AblnSucesso;
  Result.LinhasAfetadas := AintLinhas;
  Result.Mensagem := AstrMensagem;
end;

function TReformaGravacao.fIdentificadorValido(Const AstrNome: String): Boolean;
  Var
    intPos: Integer;
begin
  Result := (AstrNome <> '') And CharInSet(AstrNome[1], ['A'..'Z', 'a'..'z']);

  If Not Result Then
    Exit;

  For intPos := 2 To Length(AstrNome) Do
    If Not CharInSet(AstrNome[intPos], ['A'..'Z', 'a'..'z', '0'..'9', '_']) Then
    Begin
      Result := False;
      Exit;
    End;
end;

function TReformaGravacao.fMontaSql(Const AComando: TComandoGravacao; out AstrSql: String; out AstrErro: String): Boolean;
  Var
    intPos: Integer;
    intChave: Integer;
    intCampos: Integer;
    strColunas: String;
    strValores: String;
    strAtualiza: String;
    strCondicao: String;
begin
  Result := False;
  AstrSql := '';
  AstrErro := '';
  intChave := Length(AComando.Chave);
  intCampos := Length(AComando.Campos);

  // A tabela e escolha do plugin (ITEREF, REFPRE...): o host so confere que e um identificador, como os campos.
  If Not fIdentificadorValido(AComando.Tabela) Then
  Begin
    AstrErro := 'Nome de tabela invalido: ' + AComando.Tabela;
    Exit;
  End;

  For intPos := 0 To intChave - 1 Do
    If Not fIdentificadorValido(AComando.Chave[intPos].Nome) Then
    Begin
      AstrErro := 'Nome de campo invalido: ' + AComando.Chave[intPos].Nome;
      Exit;
    End;

  For intPos := 0 To intCampos - 1 Do
    If Not fIdentificadorValido(AComando.Campos[intPos].Nome) Then
    Begin
      AstrErro := 'Nome de campo invalido: ' + AComando.Campos[intPos].Nome;
      Exit;
    End;

  // Parametros: :P0..:P(n-1) na ordem chave, depois campos (pPreencheParametros usa a mesma ordem).
  strCondicao := '';
  For intPos := 0 To intChave - 1 Do
  Begin
    If intPos > 0 Then
      strCondicao := strCondicao + ' AND ';

    strCondicao := strCondicao + AComando.Chave[intPos].Nome + ' = :P' + IntToStr(intPos);
  End;

  Case AComando.Operacao Of
    ogInserir, ogSubstituir:
    Begin
      If (intChave + intCampos = 0) Or ((AComando.Operacao = ogSubstituir) And (intCampos = 0)) Then
      Begin
        AstrErro := 'Comando de gravacao sem campos.';
        Exit;
      End;

      strColunas := '';
      strValores := '';
      For intPos := 0 To intChave + intCampos - 1 Do
      Begin
        If intPos > 0 Then
        Begin
          strColunas := strColunas + ', ';
          strValores := strValores + ', ';
        End;

        If intPos < intChave Then
          strColunas := strColunas + AComando.Chave[intPos].Nome
        Else
          strColunas := strColunas + AComando.Campos[intPos - intChave].Nome;

        strValores := strValores + ':P' + IntToStr(intPos);
      End;

      AstrSql := 'INSERT INTO ' + AComando.Tabela + ' (' + strColunas + ') VALUES (' + strValores + ')';

      // Insere ou atualiza pela chave unica (empresa + item); a chave nao entra na lista do UPDATE.
      If AComando.Operacao = ogSubstituir Then
      Begin
        strAtualiza := '';
        For intPos := 0 To intCampos - 1 Do
        Begin
          If intPos > 0 Then
            strAtualiza := strAtualiza + ', ';

          strAtualiza := strAtualiza + AComando.Campos[intPos].Nome + ' = VALUES(' + AComando.Campos[intPos].Nome + ')';
        End;

        AstrSql := AstrSql + ' ON DUPLICATE KEY UPDATE ' + strAtualiza;
      End;
    End;

    ogAtualizar:
    Begin
      If (intChave = 0) Or (intCampos = 0) Then
      Begin
        AstrErro := 'Atualizacao exige chave e campos.';
        Exit;
      End;

      strAtualiza := '';
      For intPos := 0 To intCampos - 1 Do
      Begin
        If intPos > 0 Then
          strAtualiza := strAtualiza + ', ';

        strAtualiza := strAtualiza + AComando.Campos[intPos].Nome + ' = :P' + IntToStr(intChave + intPos);
      End;

      AstrSql := 'UPDATE ' + AComando.Tabela + ' SET ' + strAtualiza + ' WHERE ' + strCondicao;
    End;

    ogExcluir:
    Begin
      If intChave = 0 Then
      Begin
        AstrErro := 'Exclusao exige chave.';
        Exit;
      End;

      AstrSql := 'DELETE FROM ' + AComando.Tabela + ' WHERE ' + strCondicao;
    End;
  End;

  Result := AstrSql <> '';
end;

procedure TReformaGravacao.pPreencheParametros(Const AqryGrava: TUniQuery; Const AComando: TComandoGravacao);
  Var
    intPos: Integer;
    intChave: Integer;
begin
  intChave := Length(AComando.Chave);

  For intPos := 0 To intChave - 1 Do
    AqryGrava.ParamByName('P' + IntToStr(intPos)).Value := AComando.Chave[intPos].Valor;

  // A exclusao so usa a chave.
  If AComando.Operacao <> ogExcluir Then
    For intPos := 0 To Length(AComando.Campos) - 1 Do
      AqryGrava.ParamByName('P' + IntToStr(intChave + intPos)).Value := AComando.Campos[intPos].Valor;
end;

function TReformaGravacao.Executar(Const AComando: TComandoGravacao): TResultadoGravacao;
  Var
    qryGrava: TUniQuery;
    strSql: String;
    strErro: String;
    blnTransacaoPropria: Boolean;
begin
  If Not fMontaSql(AComando, strSql, strErro) Then
  Begin
    Result := fResultado(False, 0, strErro);
    Exit;
  End;

  // Dentro da gravacao do produto vale a transacao do cadastro. Fora dela o comando vai sozinho numa
  // transacao: a LOGREP precisa do LOG_IDTRAN.
  blnTransacaoPropria := Not fInTransaction;
  Result := fResultado(False, 0, '');

  Try
    If blnTransacaoPropria Then
      fStartTransaction;

    qryGrava := fCriaQuery(nil);
    Try
      qryGrava.SQL.Text := strSql;
      pPreencheParametros(qryGrava, AComando);
      qryGrava.ExecSQL;
      Result := fResultado(True, Integer(qryGrava.RowsAffected), '');
    Finally
      FreeAndNil(qryGrava);
    End;

    If blnTransacaoPropria Then
      If Not fCommit Then
        Raise Exception.Create('Nao foi possivel confirmar a gravacao do plugin.');
  Except
    On E: Exception Do
    Begin
      If blnTransacaoPropria Then
        pRollBackSemExcecao;

      // A excecao fica aqui: a DLL tem outra classe Exception e nao a reconheceria.
      Result := fResultado(False, 0, E.Message);
    End;
  End;
end;

// Generico de proposito: e a porta de comandos em lote do plugin (Convert), que nao fica presa a uma tabela.
// So roda dentro de uma transacao ja aberta pelo host, com parametros (sem concatenar valor), e a LOGREP nasce
// do gancho do UniDAC do exe como em qualquer gravacao. Executar grava uma linha na tabela que o plugin indicar.
function TReformaGravacao.ExecutarSql(Const AstrSql: String; Const AarrParametros: Array Of TValorCampo): TResultadoGravacao;
  Var
    qryGrava: TUniQuery;
    intPos: Integer;
begin
  // Comando em lote (Convert): so dentro de uma transacao, para o rollback valer para tudo.
  If Not fInTransaction Then
  Begin
    Result := fResultado(False, 0, 'ExecutarSql exige uma transacao aberta.');
    Exit;
  End;

  Result := fResultado(False, 0, '');

  Try
    qryGrava := fCriaQuery(nil);
    Try
      qryGrava.SQL.Text := AstrSql;
      For intPos := Low(AarrParametros) To High(AarrParametros) Do
        qryGrava.ParamByName(AarrParametros[intPos].Nome).Value := AarrParametros[intPos].Valor;

      qryGrava.ExecSQL;
      Result := fResultado(True, Integer(qryGrava.RowsAffected), '');
    Finally
      FreeAndNil(qryGrava);
    End;
  Except
    On E: Exception Do
      Result := fResultado(False, 0, E.Message);
  End;
end;

function TReformaGravacao.IniciarTransacao: IReformaTransacao;
begin
  // O cadastro ja tem a transacao dele (fGravaItem): o chamador participa dela e nao confirma nem desfaz.
  Result := Nil;

  If fInTransaction Then
    Exit;

  Try
    fStartTransaction;
    Result := TReformaTransacao.Create;
  Except
    // A excecao fica aqui (a DLL tem outra classe Exception): a transacao que nao abriu devolve o motivo no
    // Confirmar, e o ExecutarSql dela recusa o comando por nao haver transacao.
    On E: Exception Do
      Result := TReformaTransacao.Create('Nao foi possivel iniciar a transacao: ' + E.Message);
  End;
end;

function TReformaGravacao.TabelaDisponivel(Const AstrTabela: String): Boolean;
begin
  Result := fIdentificadorValido(AstrTabela) And fTabelaExiste(AstrTabela, True);
end;

{ TReformaConsulta }

constructor TReformaConsulta.Create(Const AstrSql: String);
begin
  inherited Create;
  FqryConsulta := fCriaQuery(nil);
  FqryConsulta.SQL.Text := AstrSql;
end;

destructor TReformaConsulta.Destroy;
begin
  FreeAndNil(FqryConsulta);
  inherited;
end;

procedure TReformaConsulta.DefinirParametro(Const AstrNome: String; Const AvarValor: Variant);
begin
  FqryConsulta.ParamByName(AstrNome).Value := AvarValor;
end;

procedure TReformaConsulta.Abrir;
begin
  FqryConsulta.Open;
end;

function TReformaConsulta.Vazia: Boolean;
begin
  Result := FqryConsulta.IsEmpty;
end;

function TReformaConsulta.ValorCampo(Const AstrNome: String): Variant;
  Var
    fldCampo: TField;
begin
  Result := Null;

  fldCampo := FqryConsulta.FindField(AstrNome);
  If Assigned(fldCampo) Then
    Result := fldCampo.Value;
end;

function TReformaConsulta.Proximo: Boolean;
begin
  FqryConsulta.Next;
  Result := Not FqryConsulta.Eof;
end;

function TReformaConsulta.Fim: Boolean;
begin
  Result := FqryConsulta.Eof;
end;

{ TReformaBancoHost }

function TReformaBancoHost.AbrirConsulta(Const AstrSql: String): IReformaConsulta;
begin
  Result := TReformaConsulta.Create(AstrSql);
end;

function TReformaBancoHost.Gravacao: IReformaGravacao;
begin
  Result := TReformaGravacao.Create;
end;

// Motivo da excecao em curso, lido de dentro de um Except sem classe: o objeto pode ser de outro modulo (a DLL).
function fMotivoExcecaoPreparacao: String;
begin
  Result := '';
  If ExceptObject <> nil Then
    Result := Exception(ExceptObject).Message;
end;

procedure pReformaPrepararBanco;
  Var
    strDll,
    strMensagem: String;
    intDll: HMODULE;
    fVersao: TReformaVersaoContrato;
    fAssinatura: TReformaAssinatura;
    fPreparar: TReformaPrepararBanco;
    objBanco: IReformaBancoHost;
begin
  strDll := ExtractFilePath(Application.ExeName) + NOME_DLL;
  If Not FileExists(strDll) Then
    Exit;

  intDll := LoadLibrary(PChar(strDll));
  If intDll = 0 Then
    Exit;

  Try
    // Mesmo handshake do cadastro (untReformaPrecosLoader): DLL de outro contrato nao mexe no banco.
    @fVersao := GetProcAddress(intDll, EXPORT_VERSAO);
    @fAssinatura := GetProcAddress(intDll, EXPORT_ASSINATURA);
    @fPreparar := GetProcAddress(intDll, EXPORT_PREPARAR_BANCO);

    If (Not Assigned(fVersao)) Or (Not Assigned(fAssinatura)) Or (Not Assigned(fPreparar)) Then
      Exit;
    If (fVersao() <> VERSAO_CONTRATO) Or (fAssinatura() <> fReformaCalculaAssinatura) Then
      Exit;

    objBanco := TReformaBancoHost.Create;
    Try
      If (Not fPreparar(objBanco, strMensagem)) And (strMensagem <> '') Then
        pLog('REFTRI pReformaPrepararBanco: ' + strMensagem);
      // A preparacao liga a CFG_REFCIS das empresas com EMP_REFCON = 'S' (lojas: o CADEMP replica, a CFGSIS nao); o
      // cache do fCfgSis le de novo.
      If Assigned(dicConfiguracoes) Then
        dicConfiguracoes.Clear;
    Except
      pLog('REFTRI pReformaPrepararBanco: ' + fMotivoExcecaoPreparacao);
    End;
  Finally
    FreeLibrary(intDll);
  End;
end;

end.
