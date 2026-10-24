unit untReformaPrecosLoader;

{*************************************************************************}
{* CARREGA A libReformaPrecos.dll (ABAS 2 E 3 DE PRECOS) POR LoadLibrary, *}
{* NO PADRAO DE untInicializarDllAutTin. SEM A DLL NA PASTA DO EXE A     *}
{* TELA SEGUE SO COM A ABA 1 E NENHUM ERRO E MOSTRADO.                   *}
{*************************************************************************}

interface

uses
  Windows, Reforma.Contrato.Host, Reforma.Contrato.Exportacao, Reforma.Contrato.Convert;

type
  TReformaPrecosLoader = class
  private
    FintDll: HMODULE;
    FblnIncompativel: Boolean;
    FblnFalhou: Boolean;
    FblnFalhaAvisada: Boolean;
    FstrFalha: String;
    FfVersao: TReformaVersaoContrato;
    FpInicializar: TReformaInicializar;
    FfCriarAba2: TReformaCriarAba;
    FfCriarAba3: TReformaCriarAba;
    FpCarregar: TReformaCarregar;
    FpEntrarAba: TReformaEntrarAba;
    FpAtualizarAtual: TReformaAtualizarAtual;
    FpConfirmarEdicao: TReformaConfirmarEdicao;
    FpFinalizar: TReformaFinalizar;
    FfPendente: TReformaPendente;
    FfGravar: TReformaGravar;
    FpDescartar: TReformaDescartar;
    FpAbrirConvert: TReformaAbrirConvert;
    FfConvertDisponivel: TReformaConvertDisponivel;
    FfAssinatura: TReformaAssinatura;
    FfAbaVisivel: TReformaAbaVisivel;
    // Aba 4 "Calculo Convert" (contrato 11): classica e grid vertical.
    FfCriarAba4,
    FfCriarAba4Grid: TReformaCriarAba;
    FblnInicializou: Boolean;
    // Chamada de dentro do Except da rotina que falhou: guarda o motivo e desliga o plugin.
    procedure pRegistraFalha(Const AstrOperacao: String);
  public
    destructor Destroy; override;

    function fCarregar: Boolean;
    // A DLL existe na pasta mas foi compilada de outro contrato (ou e anterior a versao): o host avisa.
    property blnIncompativel: Boolean read FblnIncompativel;
    // Falha em rotina de exibicao da DLL (montagem das abas, carga, atualizacao, confirmacao): nenhuma excecao sai
    // daqui. O plugin se desliga (as chamadas seguintes nao fazem nada), o cadastro segue como sem ele e o motivo
    // fica em strFalha. Gravar e abrir o Convert sao outra coisa: falhando, levantam Exception do host.
    property blnFalhou: Boolean read FblnFalhou;
    property strFalha: String read FstrFalha;
    // True uma unica vez depois da falha: o host avisa o usuario fora da transacao da gravacao.
    function fFalhaNaoAvisada(out AstrFalha: String): Boolean;
    procedure pInicializar(Const AobjHost: IReformaHost);
    // REFTRI-03: a DLL decide se a aba (2 ou 3) aparece; o host so obedece. Chamar depois de pInicializar. Falha da
    // DLL desliga o plugin (blnFalhou) e devolve True.
    function fAbaVisivel(Const AintAba: Integer): Boolean;
    // Devolve o handle do frame criado dentro de AintPaiHandle; AintAba = 2 ou 3. Zero se a DLL falhou.
    function fCriarAba(Const AintAba: Integer; Const AintPaiHandle: NativeUInt): NativeUInt;
    // Aba 4 "Calculo Convert": AblnGrid nos hosts cuja aba 1 e grid vertical (150.x). Zero se a DLL falhou.
    function fCriarAba4(Const AintPaiHandle: NativeUInt; Const AblnGrid: Boolean): NativeUInt;
    procedure pCarregar(Const AstrCodIte: String);
    procedure pEntrarAba(Const AintAba: Integer);
    procedure pAtualizarAtual;
    procedure pConfirmarEdicao;
    // A simulacao das abas 2 e 3 mudou desde a carga e ha ITEREF no banco: so entao o host manda gravar.
    function fPendente: Boolean;
    // Depois de uma falha fPendente responde False sem perguntar a DLL. Este pergunta assim mesmo, para o host
    // nao perder em silencio uma simulacao por gravar; se a DLL nao responder, considera que havia.
    function fPendenteAposFalha: Boolean;
    // Chamada dentro da transacao do cadastro, depois do ITEGER. False: AstrMensagem diz o motivo e o host
    // desfaz a transacao inteira. Falha da DLL levanta Exception do host, com o mesmo efeito.
    // AstrCodigoItem: codigo do produto que o cadastro acabou de gravar (na inclusao so existe a partir dai).
    function fGravar(Const AstrCodigoItem: String; out AstrMensagem: String): Boolean;
    procedure pDescartar;
    // REFTRI-02: a DLL desta pasta esta apta ao Convert. Sem excecao: falha = False.
    function fConvertDisponivel(Const AstrOperador: String; Const AdtaData: TDateTime): Boolean;
    // Abre o Convert (menu do principal, sem o cadastro). Falha da DLL levanta Exception do host (pFalhaDll).
    procedure pAbrirConvert(Const AobjHost: IReformaConvertHost);
  end;

implementation

uses
  SysUtils, Forms, Reforma.Contrato.Assinatura, untFuncoesSimples;

// Motivo da excecao em curso, lido de dentro de um Except sem classe: o objeto e de outro modulo (a DLL), entao
// "is" e "On E: Exception" nao batem no host, mas o layout de Exception e o mesmo.
function fMotivoDaExcecao: String;
Begin
  Result := '';
  Try
    If ExceptObject <> nil Then
      Result := Exception(ExceptObject).Message;
  Except
    // O cast para Exception pode falhar sozinho (objeto de outro modulo, ou nao e um Exception de
    // verdade): nunca deixa escapar, porque esta funcao roda de dentro do Except que protege a
    // fronteira com a DLL.
  End;
End;

// Gravacao e acao do usuario: a falha chega ao host como Exception dele. O fGravaItem chama a gravacao dentro da
// transacao do cadastro e o On E: Exception dele nao pegaria a excecao da DLL; assim ele desfaz o produto junto.
procedure pFalhaDll(Const AstrOperacao: String);
Begin
  Raise Exception.Create('Falha na ' + NOME_DLL + ' (' + AstrOperacao + '): ' + fMotivoDaExcecao);
End;

{ TReformaPrecosLoader }

destructor TReformaPrecosLoader.Destroy;
begin
  // Os frames assinam a simulacao da DLL: ela desmonta tudo antes de sair da memoria.
  // Excecao da DLL tem classe de outro modulo: o Except e sem classe. Se ela falhar ao desmontar, fica
  // carregada (descarregar com janela dela ainda viva derruba o exe) e o fechamento da tela segue.
  Try
    If FblnInicializou And Assigned(FpFinalizar) Then
      FpFinalizar;

    If FintDll <> 0 Then
      FreeLibrary(FintDll);
  Except
    // Sem mensagem: a tela ja esta fechando. Fica o rastro no log do sistema.
    pGravaLogErrArquivoLocal('Falha ao finalizar a ' + NOME_DLL + ' (a DLL fica carregada): ' + fMotivoDaExcecao,
                             fRetornaStack, 'TReformaPrecosLoader.Destroy');
  End;

  inherited;
end;

procedure TReformaPrecosLoader.pRegistraFalha(Const AstrOperacao: String);
begin
  // A DLL nunca e descarregada daqui: o objeto da excecao dela e liberado so quando o Except que chamou termina, e
  // a classe dele mora no modulo da DLL.
  If FblnFalhou Then
    Exit;

  FblnFalhou := True;
  FstrFalha := AstrOperacao + ': ' + fMotivoDaExcecao;
end;

function TReformaPrecosLoader.fFalhaNaoAvisada(out AstrFalha: String): Boolean;
begin
  AstrFalha := FstrFalha;
  Result := FblnFalhou And (Not FblnFalhaAvisada);

  If Result Then
    FblnFalhaAvisada := True;
end;

function TReformaPrecosLoader.fCarregar: Boolean;
begin
  Result := False;

  If FintDll <> 0 Then
  Begin
    Result := True;
    Exit;
  End;

  FintDll := LoadLibrary(PChar(ExtractFilePath(Application.ExeName) + NOME_DLL));
  If FintDll = 0 Then
    Exit;

  // Primeira chamada, antes de qualquer outra: DLL sem o export e DLL de versao diferente sao recusadas.
  @FfVersao := GetProcAddress(FintDll, EXPORT_VERSAO);
  If (Not Assigned(FfVersao)) Or (FfVersao() <> VERSAO_CONTRATO) Then
  Begin
    FblnIncompativel := True;
    FreeLibrary(FintDll);
    FintDll := 0;
    Exit;
  End;

  @FpInicializar := GetProcAddress(FintDll, EXPORT_INICIALIZAR);
  @FfCriarAba2 := GetProcAddress(FintDll, EXPORT_CRIAR_ABA2);
  @FfCriarAba3 := GetProcAddress(FintDll, EXPORT_CRIAR_ABA3);
  @FpCarregar := GetProcAddress(FintDll, EXPORT_CARREGAR);
  @FpEntrarAba := GetProcAddress(FintDll, EXPORT_ENTRAR_ABA);
  @FpAtualizarAtual := GetProcAddress(FintDll, EXPORT_ATUALIZAR_ATUAL);
  @FpConfirmarEdicao := GetProcAddress(FintDll, EXPORT_CONFIRMAR_EDICAO);
  @FpFinalizar := GetProcAddress(FintDll, EXPORT_FINALIZAR);
  @FfPendente := GetProcAddress(FintDll, EXPORT_PENDENTE);
  @FfGravar := GetProcAddress(FintDll, EXPORT_GRAVAR);
  @FpDescartar := GetProcAddress(FintDll, EXPORT_DESCARTAR);
  @FpAbrirConvert := GetProcAddress(FintDll, EXPORT_ABRIR_CONVERT);
  @FfConvertDisponivel := GetProcAddress(FintDll, EXPORT_CONVERT_DISPONIVEL);
  @FfAssinatura := GetProcAddress(FintDll, EXPORT_ASSINATURA);
  @FfAbaVisivel := GetProcAddress(FintDll, EXPORT_ABA_VISIVEL);
  @FfCriarAba4 := GetProcAddress(FintDll, EXPORT_CRIAR_ABA4);
  @FfCriarAba4Grid := GetProcAddress(FintDll, EXPORT_CRIAR_ABA4_GRID);

  Result := Assigned(FpInicializar) And Assigned(FfCriarAba2) And Assigned(FfCriarAba3) And
            Assigned(FpCarregar) And Assigned(FpEntrarAba) And Assigned(FpAtualizarAtual) And
            Assigned(FpConfirmarEdicao) And Assigned(FpFinalizar) And Assigned(FfPendente) And
            Assigned(FfGravar) And Assigned(FpDescartar) And Assigned(FpAbrirConvert) And
            Assigned(FfConvertDisponivel) And Assigned(FfAssinatura) And Assigned(FfAbaVisivel) And
            Assigned(FfCriarAba4) And Assigned(FfCriarAba4Grid);

  // Handshake estrutural: VERSAO_CONTRATO e um numero que alguem tem que lembrar de subir; a assinatura
  // (RTTI sobre as interfaces de Reforma.Contrato.Host/Gravacao, ver Reforma.Contrato.Assinatura) pega
  // sozinha a mudanca de estrutura que ficou sem o bump manual.
  If Result And (FfAssinatura() <> fReformaCalculaAssinatura) Then
    Result := False;

  // DLL de outra versao (ou de outra estrutura de contrato): descarrega e a tela segue sem as abas.
  // Export faltando e assinatura divergente tambem sao contrato diferente: o host avisa igual.
  If Not Result Then
  Begin
    FblnIncompativel := True;
    FreeLibrary(FintDll);
    FintDll := 0;
  End;
end;

procedure TReformaPrecosLoader.pInicializar(Const AobjHost: IReformaHost);
begin
  // Marcado antes da chamada: se a DLL falhar no meio, o destrutor ainda manda ela desmontar o que montou.
  FblnInicializou := True;

  Try
    FpInicializar(AobjHost);
  Except
    pRegistraFalha('pInicializar');
  End;
end;

function TReformaPrecosLoader.fAbaVisivel(Const AintAba: Integer): Boolean;
begin
  Result := True;

  If FblnFalhou Then
    Exit;

  Try
    Result := FfAbaVisivel(AintAba);
  Except
    pRegistraFalha('fAbaVisivel');
    Result := True;
  End;
end;

function TReformaPrecosLoader.fCriarAba(Const AintAba: Integer; Const AintPaiHandle: NativeUInt): NativeUInt;
begin
  Result := 0;

  If FblnFalhou Then
    Exit;

  Try
    If AintAba = 2 Then
      Result := FfCriarAba2(AintPaiHandle)
    Else
      Result := FfCriarAba3(AintPaiHandle);
  Except
    pRegistraFalha('fCriarAba' + IntToStr(AintAba));
  End;
end;

function TReformaPrecosLoader.fCriarAba4(Const AintPaiHandle: NativeUInt; Const AblnGrid: Boolean): NativeUInt;
begin
  Result := 0;

  If FblnFalhou Then
    Exit;

  Try
    If AblnGrid Then
      Result := FfCriarAba4Grid(AintPaiHandle)
    Else
      Result := FfCriarAba4(AintPaiHandle);
  Except
    pRegistraFalha('fCriarAba4');
  End;
end;

procedure TReformaPrecosLoader.pCarregar(Const AstrCodIte: String);
begin
  If FblnFalhou Then
    Exit;

  Try
    FpCarregar(AstrCodIte);
  Except
    pRegistraFalha('pCarregar');
  End;
end;

procedure TReformaPrecosLoader.pEntrarAba(Const AintAba: Integer);
begin
  If FblnFalhou Then
    Exit;

  Try
    FpEntrarAba(AintAba);
  Except
    pRegistraFalha('pEntrarAba');
  End;
end;

procedure TReformaPrecosLoader.pAtualizarAtual;
begin
  If FblnFalhou Then
    Exit;

  Try
    FpAtualizarAtual;
  Except
    pRegistraFalha('pAtualizarAtual');
  End;
end;

procedure TReformaPrecosLoader.pConfirmarEdicao;
begin
  If FblnFalhou Then
    Exit;

  Try
    FpConfirmarEdicao;
  Except
    pRegistraFalha('pConfirmarEdicao');
  End;
end;

function TReformaPrecosLoader.fPendente: Boolean;
begin
  Result := False;

  If FblnFalhou Then
    Exit;

  Try
    Result := FfPendente;
  Except
    pRegistraFalha('fPendente');
    Result := False;
  End;
end;

function TReformaPrecosLoader.fPendenteAposFalha: Boolean;
begin
  Result := False;

  If (Not FblnFalhou) Or (Not Assigned(FfPendente)) Then
    Exit;

  // A DLL nunca e descarregada aqui dentro (ver pRegistraFalha): so a resposta muda.
  Try
    Result := FfPendente;
  Except
    Result := True;
  End;
end;

function TReformaPrecosLoader.fGravar(Const AstrCodigoItem: String; out AstrMensagem: String): Boolean;
begin
  Result := True;
  AstrMensagem := '';

  // Plugin desligado por falha de exibicao: nao ha simulacao confiavel para gravar.
  If FblnFalhou Then
    Exit;

  Try
    Result := FfGravar(AstrCodigoItem, AstrMensagem);
  Except
    pFalhaDll('fGravar');
  End;
end;

procedure TReformaPrecosLoader.pDescartar;
begin
  If FblnFalhou Then
    Exit;

  Try
    FpDescartar;
  Except
    pRegistraFalha('pDescartar');
  End;
end;

function TReformaPrecosLoader.fConvertDisponivel(Const AstrOperador: String; Const AdtaData: TDateTime): Boolean;
begin
  Result := False;

  If FblnFalhou Or (Not Assigned(FfConvertDisponivel)) Then
    Exit;

  Try
    Result := FfConvertDisponivel(AstrOperador, AdtaData);
  Except
    pRegistraFalha('fConvertDisponivel');
    Result := False;
  End;
end;

procedure TReformaPrecosLoader.pAbrirConvert(Const AobjHost: IReformaConvertHost);
begin
  Try
    FpAbrirConvert(AobjHost);
  Except
    pFalhaDll('pAbrirConvert');
  End;
end;

end.
