unit untReformaConvertHost;

{*************************************************************************}
{* HOST DO CONVERT (REFTRI-02): IMPLEMENTA IReformaConvertHost SEM O     *}
{* CADASTRO DE PRODUTOS ABERTO. O CALCULO E A GRAVACAO SEGUEM O MOTOR    *}
{* NATIVO DESTA VERSAO (AS CONTAS DO CADASTRO DE PRODUTOS E DA          *}
{* EFETIVACAO DE PRECOS, SO EM MEMORIA, E SQL DE CONJUNTO NO ITEGER); A  *}
{* DLL SO DECIDE O QUE CONVERTER. NENHUMA EXCECAO VOLTA                  *}
{* PARA A DLL: TUDO VIRA TResultadoGravacao.                             *}
{*************************************************************************}

interface

uses
  Reforma.Contrato.Tipos, Reforma.Contrato.Gravacao, Reforma.Contrato.Host, Reforma.Contrato.Convert;

  // Chamadas pelo untPrincipal.
  // Plugin na pasta, do contrato desta versao e apto ao Convert (visibilidade do menu).
  function fReformaConvertDisponivel: Boolean;
  // Abre a tela do Convert da DLL. As validacoes de acesso, empresa e servidor sao do untPrincipal.
  procedure pReformaAbrirConvert;
  // Aba 4 "Calculo Convert" do cadastro de produtos (contrato 11, IReformaCalculoConvert): o CalcularItem do Convert so
  // da logada, com os campos da tela (AarrBase) no lugar dos gravados. Nada e gravado.
  function fReformaCalcularItemBase(Const AOpcao: TOpcaoConversao; Const ArecEntrada: TEntradaConversao;
    Const AarrBase: TArray<TValorCampo>; out ArecValores: TValoresConversao): TResultadoGravacao;
  function fReformaDecimaisConvert: Integer;

implementation

uses
  Windows, SysUtils, Classes, Variants, DB, Forms, Generics.Collections, Vcl.Themes, Uni, cxProgressBar,
  untConstantes, untFuncoesSimples, untGravando, untTBatchSQL, untPreAlt, untPreAlt_Trigger,
  untParCalculaPrecoCusto, untTConfiguracao, untFatorPreco, untCadProdutos,
  Reforma.Contrato.Exportacao, untReformaGravacaoHost, untReformaPrecosLoader, untTLog,
  untHorarioSistema, untAtuVarGlobais, untCfgRepositorio;

Const
  STR_TITULO_CONVERT = 'Ativar Preços Reforma Tributária';
  STR_LOCAL_CONVERT  = 'REFORMA TRIBUTARIA - CONVERT';
  STR_LOCAL_REVERSAO = 'REFORMA TRIBUTARIA - REVERSAO';

type
  // Os campos do item numa empresa que entram nas contas do cadastro (fRetPrecoCusto, fRetPrecoVenda,
  // pRecalculaPrecosFator e pRecalculaItensResponsavelFornecedor).
  TReformaLinhaCalculo = record
    CodEmp, CodAbf, PreDol: String;
    PreCom: Double;
    DesF: Array[1..6] Of Double;
    IcmEnt, IpiEnt, FreEnt, ValFre, AcrFin, Substi, DesAdb, SubFed, AlqFed: Double;
    TCifCu, TSCust, DePiCo, DeICMS, FatReg: Double;
    PreCus, OutVal, IcmSai, ImpFed, DesOpe: Double;
    PreVen, MarBru, ComTbl: Array[1..QUANTIDADE_TABELAS_PRECO] Of Double;
  end;

  TReformaConvertHost = class(TInterfacedObject, IReformaBancoHost, IReformaConvertHost)
  private
    FobjGravacao: IReformaGravacao;
    // Um REGPRE por execucao (como a efetivacao): nasce no 1o lote aplicado; IniciarCalculo comeca outra execucao.
    FstrAgrupador: String;
    FdicColunas: TDictionary<String, Boolean>;

    // Calculo (IniciarCalculo .. FinalizarCalculo).
    FcpcParams: TParCalculaPrecoCusto;
    FobjFatPre: TFatorPreco;
    FqryItem,
    FqryEmpresas: TUniQuery;
    FlstFornecedoresResp,
    FlstEmpresasF: TStringList;
    FintDecUni: Integer;
    FstrMarMkp,
    FstrEstado: String;
    FblnTipAbfIteger,
    FblnSuframaCusto,
    FblnInfMat,
    FblnFatPre: Boolean;
    FintInfOpe,
    FintInfSai: Integer;

    function fResultado(Const AblnSucesso: Boolean; Const AintLinhas: Integer; Const AstrMensagem: String): TResultadoGravacao;
    function fColunaExiste(Const AstrTabela, AstrColuna: String): Boolean;
    function fRotinaExiste(Const AstrRotina: String): Boolean;
    function fCascataItegerPrePro: Boolean;
    function fSqlPreProDoIteger(Const AstrOrigem: String): String;
    function fTabelaAtiva(Const AintTabela: Integer): Boolean;
    function fTipoParametroLote(Const AvarValor: Variant): TFieldType;
    function fListaEmpresasF: TStringList;
    procedure pLiberarCalculo;
    function fCalculaTabela(Const AintOpcao: Integer; Const ArecLinha: TReformaLinhaCalculo; Const AintTabela: Integer;
      Const AfltMargem: Double; Const AstrMarMkp, AstrPcmPro: String; Const AintDecUni: Integer;
      Const AstrMarMkpSt, AstrEstado: String; Const AintDecUniLiq: Integer): Double;
    function fLinhaDaConsulta(Const AqryOrigem: TUniQuery; Const AstrCampoAbf: String): TReformaLinhaCalculo;
    function fValoresDaLinha(Const ArecLinha: TReformaLinhaCalculo; Const AchrOrigem: Char): TValoresConversao;
    procedure pMargemPelaConfiguracao(Var ArecLinha: TReformaLinhaCalculo; Const AqryConfig: TUniQuery);
  private
    // Aba 4 do cadastro (CalcularItemBase): so a logada, com os campos da tela no lugar dos gravados.
    FblnModoBase: Boolean;
    // Reverter (contrato 11): historico da reversao, comecado no primeiro lote dela.
    FstrAgrupadorReversao: String;
    FarrBase: TArray<TValorCampo>;
    procedure pAplicarBase(Var ArecLinha: TReformaLinhaCalculo);
    function fGravarLote(Const AstrChave: String; Const AintLote: Integer;
      Const AblnReverter: Boolean): TResultadoGravacao;
  public
    function CalcularItemBase(Const ArecEntrada: TEntradaConversao; Const AarrBase: TArray<TValorCampo>;
      out ArecValores: TValoresConversao): TResultadoGravacao;
    constructor Create;
    destructor Destroy; override;

    // IReformaBancoHost
    function AbrirConsulta(Const AstrSql: String): IReformaConsulta;
    function Gravacao: IReformaGravacao;

    // IReformaConvertHost
    function CodigoEmpresa: String;
    function Operador: String;
    function DataHora: TDateTime;
    function DecimaisUnitarios: Integer;
    function TabelasAtivas: String;
    function EmpresasPrecoMatriz: String;
    function UsaPrePro: Boolean;
    function ConfiguracaoTexto(Const AstrChave: String): String;
    function EstiloVisual: String;
    function JanelaPrincipal: NativeUInt;
    procedure Mensagem(Const AstrTitulo, AstrTexto: String);
    procedure MostrarLista(Const AstrTitulo, AstrTexto: String; Const AarrLinhas: TArray<String>);
    function Confirmar(Const AstrTitulo, AstrTexto: String): Boolean;
    function ExecutarComProgresso(Const AstrTitulo: String; Const AobjTarefa: IReformaTarefa): TResultadoGravacao;
    function ExecutarLote(Const AarrComandos: TArray<TComandoSql>): TResultadoGravacao;
    function IniciarCalculo(Const AOpcao: TOpcaoConversao): TResultadoGravacao;
    function CalcularItem(Const ArecEntrada: TEntradaConversao; out AarrValores: TListaValoresConversao): TResultadoGravacao;
    procedure FinalizarCalculo;
    function AplicarLote(Const AstrChave: String; Const AintLote: Integer): TResultadoGravacao;
    function AtivarReforma(Const AstrCodigoEmpresa: String): TResultadoGravacao;
    function ReverterLote(Const AstrChave: String; Const AintLote: Integer;
      Const AblnPrimeiroLote: Boolean): TResultadoGravacao;
    function DesativarReforma(Const AstrCodigoEmpresa: String): TResultadoGravacao;
    function CamposCustoDaLogada(Const AchrOrigem: Char): String;
    function EmpresasPrecoDe(Const AstrCodigoEmpresa: String): String;
    function TrocarEmpresa(Const AstrCodigoEmpresa: String): TResultadoGravacao;
  end;

  // Ponte TfrmGravando (metodo of object) -> IReformaTarefa da DLL.
  TReformaExecucaoGravando = class
  private
    FobjTarefa: IReformaTarefa;
    FrecResultado: TResultadoGravacao;
  public
    constructor Create(Const AobjTarefa: IReformaTarefa);
    function fExecutar(pgbProgresso: TcxProgressBar): Boolean;
    property recResultado: TResultadoGravacao read FrecResultado;
  end;

  TReformaProgresso = class(TInterfacedObject, IReformaProgresso)
  private
    FpgbProgresso: TcxProgressBar;
  public
    constructor Create(Const ApgbProgresso: TcxProgressBar);
    procedure Definir(Const AstrTexto: String; Const AintMaximo: Integer);
    procedure Avancar(Const AintQuantidade: Integer);
  end;

{ TReformaExecucaoGravando }

constructor TReformaExecucaoGravando.Create(Const AobjTarefa: IReformaTarefa);
begin
  inherited Create;
  FobjTarefa := AobjTarefa;
  FrecResultado.Sucesso := False;
  FrecResultado.LinhasAfetadas := 0;
  FrecResultado.Mensagem := 'A tarefa do plugin não foi executada.';
end;

function TReformaExecucaoGravando.fExecutar(pgbProgresso: TcxProgressBar): Boolean;
  Var
    objProgresso: IReformaProgresso;
begin
  Try
    // Na variavel: criado direto no parametro const da interface o objeto nunca seria liberado.
    objProgresso := TReformaProgresso.Create(pgbProgresso);
    FrecResultado := FobjTarefa.Executar(objProgresso);
  Except
    // Excecao da DLL (classe de outro modulo): nada e descarregado aqui.
    FrecResultado.Sucesso := False;
    FrecResultado.LinhasAfetadas := 0;
    FrecResultado.Mensagem := 'Falha na execução da tarefa do plugin.';
  End;
  Result := FrecResultado.Sucesso;
end;

{ TReformaProgresso }

constructor TReformaProgresso.Create(Const ApgbProgresso: TcxProgressBar);
begin
  inherited Create;
  FpgbProgresso := ApgbProgresso;
end;

procedure TReformaProgresso.Definir(Const AstrTexto: String; Const AintMaximo: Integer);
begin
  Try
    pInformacao(AstrTexto, FpgbProgresso);
    pProgresso(0, AintMaximo, FpgbProgresso);
    pProcessMessages(True);
  Except
    On E: Exception Do
      pLog('REFTRI Convert (progresso): ' + E.Message);
  End;
end;

procedure TReformaProgresso.Avancar(Const AintQuantidade: Integer);
begin
  Try
    If Assigned(FpgbProgresso) Then
      pProgresso(Trunc(FpgbProgresso.Position) + AintQuantidade, Trunc(FpgbProgresso.Properties.Max), FpgbProgresso);
    pProcessMessages;
  Except
    On E: Exception Do
      pLog('REFTRI Convert (progresso): ' + E.Message);
  End;
end;

{ TReformaConvertHost }

constructor TReformaConvertHost.Create;
begin
  inherited Create;
  FobjGravacao := TReformaGravacao.Create;
  FdicColunas := TDictionary<String, Boolean>.Create;
  FstrAgrupador := '';
end;

destructor TReformaConvertHost.Destroy;
begin
  pLiberarCalculo;
  FreeAndNil(FdicColunas);
  FobjGravacao := Nil;
  inherited;
end;

function TReformaConvertHost.fResultado(Const AblnSucesso: Boolean; Const AintLinhas: Integer;
  Const AstrMensagem: String): TResultadoGravacao;
begin
  Result.Sucesso := AblnSucesso;
  Result.LinhasAfetadas := AintLinhas;
  Result.Mensagem := AstrMensagem;
end;

// Coluna que varia por base (ITE_ALQFED, PRO_ALQFED): lida uma vez do information_schema.
function TReformaConvertHost.fColunaExiste(Const AstrTabela, AstrColuna: String): Boolean;
  Var
    qryColuna: TUniQuery;
    strChave: String;
begin
  strChave := UpperCase(AstrTabela + '.' + AstrColuna);
  If FdicColunas.TryGetValue(strChave, Result) Then
    Exit;

  qryColuna := fCriaQuery(nil);
  Try
    qryColuna.SQL.Text := 'SELECT COUNT(*) AS QTD FROM information_schema.COLUMNS ' +
                          'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :TABELA AND COLUMN_NAME = :COLUNA';
    qryColuna.ParamByName('TABELA').AsString := AstrTabela;
    qryColuna.ParamByName('COLUNA').AsString := AstrColuna;
    qryColuna.Open;
    Result := qryColuna.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryColuna);
  End;

  FdicColunas.AddOrSetValue(strChave, Result);
end;

// Funcao do banco usada pelo trigger (fCalculaPrecodeCustoTARE): lida uma vez do information_schema.
function TReformaConvertHost.fRotinaExiste(Const AstrRotina: String): Boolean;
  Var
    qryRotina: TUniQuery;
    strChave: String;
begin
  strChave := 'ROTINA.' + UpperCase(AstrRotina);
  If FdicColunas.TryGetValue(strChave, Result) Then
    Exit;

  qryRotina := fCriaQuery(nil);
  Try
    qryRotina.SQL.Text := 'SELECT COUNT(*) AS QTD FROM information_schema.ROUTINES ' +
                          'WHERE ROUTINE_SCHEMA = DATABASE() AND UPPER(ROUTINE_NAME) = :ROTINA';
    qryRotina.ParamByName('ROTINA').AsString := UpperCase(AstrRotina);
    qryRotina.Open;
    Result := qryRotina.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryRotina);
  End;

  FdicColunas.AddOrSetValue(strChave, Result);
end;

// Base com trigger que copia o ITEGER para a PREPRO (age com @_PREPRO_ATUALIZA_ITEGER NULL): lida uma vez.
function TReformaConvertHost.fCascataItegerPrePro: Boolean;
  Var
    qryTrigger: TUniQuery;
begin
  If FdicColunas.TryGetValue('TRIGGER.ITEGER_PREPRO', Result) Then
    Exit;

  Result := fColunaExiste('PREPRO', 'PRO_CODITE') And fColunaExiste('PREPRO', 'PRO_NROTAB');
  If Result Then
  Begin
    qryTrigger := fCriaQuery(nil);
    Try
      qryTrigger.SQL.Text := 'SELECT COUNT(*) AS QTD FROM information_schema.TRIGGERS ' +
                             'WHERE TRIGGER_SCHEMA = DATABASE() AND EVENT_OBJECT_TABLE = ''ITEGER'' ' +
                             'AND EVENT_MANIPULATION = ''UPDATE'' AND UPPER(ACTION_STATEMENT) LIKE ''%UPDATE PREPRO%''';
      qryTrigger.Open;
      Result := qryTrigger.FieldByName('QTD').AsInteger > 0;
    Finally
      FreeAndNil(qryTrigger);
    End;
  End;

  FdicColunas.AddOrSetValue('TRIGGER.ITEGER_PREPRO', Result);
end;

// A copia que os triggers ITEGER -> PREPRO fazem (T_ITEGER_BEFORE/AFTER_UPDATE_PREPRO), por conjunto: o ITEGER do lote
// ja gravado vai para todas as linhas da PREPRO do item e da empresa (custo em todas; preco, margem, comissao, margem
// ideal e minimo pela tabela). So as colunas que existem nas duas tabelas. O filtro vai por parametro (CHAVE_P, LOTE_P e
// APLICADO_P, outros nomes que os do UPDATE do ITEGER no mesmo texto), que o chamador preenche.
function TReformaConvertHost.fSqlPreProDoIteger(Const AstrOrigem: String): String;
  Const
    ARR_CUSTO: Array[0..28] Of String =
    ('PRECOM', 'PREDOL', 'DESF01', 'DESF02', 'DESF03', 'DESF04', 'DESF05', 'DESF06', 'ICMENT', 'SUBFED', 'ALQENT',
     'ALQFED', 'IPIENT', 'FREENT', 'VALFRE', 'ACRFIN', 'SUBSTI', 'DESADB', 'PRECUS', 'TCIFCU', 'TSCUST', 'DEPICO',
     'DEICMS', 'FATREG', 'OUTVAL', 'ICMSAI', 'IMPFED', 'DESOPE', 'REGPRO');
    // Coluna da PREPRO -> prefixo da coluna do ITEGER por tabela (ITE_MARBR1..7 etc.).
    ARR_TABELA: Array[0..4, 0..1] Of String =
    (('PRO_MARBRU', 'ITE_MARBR'), ('PRO_COMTBL', 'ITE_COMTB'), ('PRO_PREVEN', 'ITE_PREVE'),
     ('PRO_MARIDE', 'ITE_MARID'), ('PRO_MINTBL', 'ITE_MINTB'));
    // Argumentos de custo do fCalculaPrecodeCustoTARE, na ordem do trigger (depois do PRECOM).
    ARR_TARE: Array[0..13] Of String =
    ('DESF01', 'DESF02', 'DESF03', 'DESF04', 'DESF05', 'DESF06', 'IPIENT', 'SUBSTI', 'ICMENT', 'FREENT', 'VALFRE',
     'ACRFIN', 'SUBFED', 'DESADB');
  Var
    strSet,
    strCampo,
    strCase,
    strJoin,
    strTare: String;
    intPar,
    intTabela: Integer;

  // Valor da PREPRO depois deste UPDATE: o do ITEGER (copiado acima) ou o que ja estava.
  function fNovo(Const AstrCampo: String): String;
  begin
    If fColunaExiste('ITEGER', 'ITE_' + AstrCampo) Then
      Result := 'G.ITE_' + AstrCampo
    Else
      Result := 'P.PRO_' + AstrCampo;
  end;

begin
  strSet := '';
  For strCampo In ARR_CUSTO Do
    If fColunaExiste('PREPRO', 'PRO_' + strCampo) And fColunaExiste('ITEGER', 'ITE_' + strCampo) Then
    Begin
      If strSet <> '' Then
        strSet := strSet + ', ';
      strSet := strSet + 'P.PRO_' + strCampo + ' = G.ITE_' + strCampo;
    End;

  For intPar := Low(ARR_TABELA) To High(ARR_TABELA) Do
    If fColunaExiste('PREPRO', ARR_TABELA[intPar, 0]) And fColunaExiste('ITEGER', ARR_TABELA[intPar, 1] + '1') Then
    Begin
      strCase := '';
      For intTabela := 1 To QUANTIDADE_TABELAS_PRECO Do
        strCase := strCase + ' WHEN ' + IntToStr(intTabela) + ' THEN G.' + ARR_TABELA[intPar, 1] + IntToStr(intTabela);
      If strSet <> '' Then
        strSet := strSet + ', ';
      strSet := strSet + 'P.' + ARR_TABELA[intPar, 0] + ' = CASE P.PRO_NROTAB' + strCase + ' ELSE P.' +
                ARR_TABELA[intPar, 0] + ' END';
    End;

  // PRO_CUSTAR (custo TARE) como o trigger T_PREPRO_BEFORE_UPDATE_PROALT calcula com 'SIM': com 'NAO' ele nao
  // recalcula e o custo ficava o de antes. Custo novo do ITEGER e as 4 configuracoes da empresa da linha (como o 150.x).
  strJoin := '';
  If fColunaExiste('PREPRO', 'PRO_CUSTAR') And fColunaExiste('PREPRO', 'PRO_REDTAR') And
     fColunaExiste('PREPRO', 'PRO_USATAR') And fRotinaExiste('fCalculaPrecodeCustoTARE') Then
  Begin
    strJoin := 'LEFT JOIN CFGSIS CDEC ON CDEC.SIS_CODEMP = P.PRO_CODEMP AND CDEC.SIS_CODCFG = ''CFG_DECUNI'' ' +
               'LEFT JOIN CFGSIS COPE ON COPE.SIS_CODEMP = P.PRO_CODEMP AND COPE.SIS_CODCFG = ''CFG_OPEADI'' ' +
               'LEFT JOIN CFGSIS CFRM ON CFRM.SIS_CODEMP = P.PRO_CODEMP AND CFRM.SIS_CODCFG = ''CFG_FRMCUS'' ' +
               'LEFT JOIN CFGSIS CRED ON CRED.SIS_CODEMP = P.PRO_CODEMP AND CRED.SIS_CODCFG = ''CFG_REDTAR'' ';
    strTare := '';
    For strCampo In ARR_TARE Do
      strTare := strTare + ', IFNULL(' + fNovo(strCampo) + ', 0)';
    If strSet <> '' Then
      strSet := strSet + ', ';
    strSet := strSet + 'P.PRO_CUSTAR = fCalculaPrecodeCustoTARE(CFRM.SIS_VALCFG, COPE.SIS_VALCFG, CDEC.SIS_VALCFG, ' +
              fNovo('PRECOM') + strTare + ', IFNULL(P.PRO_REDTAR, 0), IFNULL(IF(CRED.SIS_VALCFG = ''S'', TRUE, FALSE), ' +
              'FALSE), IF(P.PRO_USATAR = ''S'', TRUE, FALSE))';
  End;

  Result := 'UPDATE PREPRO P INNER JOIN ' + AstrOrigem + ' F ON F.ITE_CODEMP = P.PRO_CODEMP AND F.ITE_CODITE = P.PRO_CODITE ' +
            'INNER JOIN ITEGER G ON G.ITE_CODEMP = F.ITE_CODEMP AND G.ITE_CODITE = F.ITE_CODITE ' + strJoin +
            'SET ' + strSet +
            ' WHERE F.REF_CHAVE = :CHAVE_P AND F.REF_LOTE = :LOTE_P AND F.REF_APLICADO = :APLICADO_P';
end;

function TReformaConvertHost.fTabelaAtiva(Const AintTabela: Integer): Boolean;
begin
  Result := (AintTabela <= Length(VS_strTabPrc)) And SameText(VS_strTabPrc[AintTabela], 'S');
end;

// O TBatchSQL grava o texto sem aspas com ftUnknown: todo tipo que a DLL manda tem o seu.
function TReformaConvertHost.fTipoParametroLote(Const AvarValor: Variant): TFieldType;
begin
  Case VarType(AvarValor) And varTypeMask Of
    varEmpty, varNull:
      Result := ftString;
    varSmallint, varInteger, varShortInt, varByte, varWord, varLongWord, varInt64:
      Result := ftLargeint;
    varSingle, varDouble, varCurrency:
      Result := ftFloat;
    varString, varUString, varOleStr:
      Result := ftString;
  Else
    Raise Exception.Create('Tipo de parâmetro não suportado no lote: ' + IntToStr(VarType(AvarValor)));
  End;
end;

// fRetEmpresasUsamPrecoMatriz ('L_F1_F2_') sem a logada.
function TReformaConvertHost.fListaEmpresasF: TStringList;
  Var
    stlPartes: TStringList;
    intPos: Integer;
begin
  Result := TStringList.Create;
  stlPartes := TStringList.Create;
  Try
    stlPartes.Delimiter := '_';
    stlPartes.StrictDelimiter := True;
    stlPartes.DelimitedText := fRetEmpresasUsamPrecoMatriz;
    For intPos := 0 To stlPartes.Count - 1 Do
      If (Trim(stlPartes[intPos]) <> '') And (Trim(stlPartes[intPos]) <> VS_strCodEmp) And
         (Result.IndexOf(Trim(stlPartes[intPos])) < 0) Then
        Result.Add(Trim(stlPartes[intPos]));
  Finally
    FreeAndNil(stlPartes);
  End;
end;

function TReformaConvertHost.AbrirConsulta(Const AstrSql: String): IReformaConsulta;
begin
  Result := TReformaConsulta.Create(AstrSql);
end;

function TReformaConvertHost.Gravacao: IReformaGravacao;
begin
  Result := FobjGravacao;
end;

function TReformaConvertHost.CodigoEmpresa: String;
begin
  Result := VS_strCodEmp;
end;

function TReformaConvertHost.Operador: String;
begin
  Result := strLoginUsuarioLogado;
end;

function TReformaConvertHost.DataHora: TDateTime;
begin
  Result := fNow;
end;

// Mesma regra do cadastro de produtos (intDecUni).
function TReformaConvertHost.DecimaisUnitarios: Integer;
begin
  Result := 2;
  Try
    Result := fCfgSis('DECUNI', varInteger);
    If Result > fTamPrecoIteger Then
      Result := 4;
  Except
    On E: Exception Do
      pLog('REFTRI Convert (DecimaisUnitarios): ' + E.Message);
  End;
end;

function TReformaConvertHost.TabelasAtivas: String;
begin
  Result := VS_strTabPrc;
end;

function TReformaConvertHost.EmpresasPrecoMatriz: String;
  Var
    stlEmpresas: TStringList;
    intPos: Integer;
begin
  Result := '';
  Try
    stlEmpresas := fListaEmpresasF;
    Try
      For intPos := 0 To stlEmpresas.Count - 1 Do
      Begin
        If Result <> '' Then
          Result := Result + ';';
        Result := Result + stlEmpresas[intPos];
      End;
    Finally
      FreeAndNil(stlEmpresas);
    End;
  Except
    On E: Exception Do
      pLog('REFTRI Convert (EmpresasPrecoMatriz): ' + E.Message);
  End;
end;

// Nesta versao o preco mora no ITEGER (a PREPRO, quando existe, vem por trigger do ITEGER).
function TReformaConvertHost.UsaPrePro: Boolean;
begin
  Result := False;
end;

function TReformaConvertHost.ConfiguracaoTexto(Const AstrChave: String): String;
begin
  Result := '';
  Try
    Result := VarToStr(fCfgSis(AstrChave));
  Except
    On E: Exception Do
      pLog('REFTRI Convert (ConfiguracaoTexto ' + AstrChave + '): ' + E.Message);
  End;
end;

function TReformaConvertHost.EstiloVisual: String;
begin
  // Mesma condicao do TReformaHostAdapter.EstiloVisual (TfrmPai.FormActivate).
  Result := '';
  Try
    If (Not blnUsuarioLogadoUtilizaModoClassico) And (TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME) Then
      Result := TStyleManager.ActiveStyle.Name;
  Except
    Result := '';
  End;
end;

function TReformaConvertHost.JanelaPrincipal: NativeUInt;
begin
  Result := 0;
  If Assigned(Application.MainForm) Then
    Result := Application.MainForm.Handle;
end;

procedure TReformaConvertHost.Mensagem(Const AstrTitulo, AstrTexto: String);
begin
  Try
    fMensagem(AstrTitulo, AstrTexto, ['&Ok']);
  Except
    On E: Exception Do
      pLog('REFTRI Convert (Mensagem): ' + E.Message);
  End;
end;

// Tratamento da DLL que devolve mais de um item: cabecalho e a lista na tela de log (TfrmLog).
procedure TReformaConvertHost.MostrarLista(Const AstrTitulo, AstrTexto: String; Const AarrLinhas: TArray<String>);
  Var
    lstConteudo: TStringList;
    strLinha: String;
begin
  Try
    lstConteudo := TStringList.Create;
    Try
      lstConteudo.Add(AstrTexto);
      lstConteudo.Add('');
      For strLinha In AarrLinhas Do
        lstConteudo.Add(strLinha);
      TfrmLog.pShowLog(AstrTitulo, lstConteudo, 800, 600);
    Finally
      lstConteudo.Free;
    End;
  Except
    On E: Exception Do
      pLog('REFTRI Convert (MostrarLista): ' + E.Message);
  End;
end;

function TReformaConvertHost.Confirmar(Const AstrTitulo, AstrTexto: String): Boolean;
begin
  Result := False;
  Try
    Result := fMensagem(AstrTitulo, AstrTexto, ['&Sim', '&Não'], 2) = 1;
  Except
    On E: Exception Do
      pLog('REFTRI Convert (Confirmar): ' + E.Message);
  End;
end;

function TReformaConvertHost.ExecutarComProgresso(Const AstrTitulo: String; Const AobjTarefa: IReformaTarefa): TResultadoGravacao;
  Var
    frmEspera: TfrmGravando;
    objExecucao: TReformaExecucaoGravando;
begin
  frmEspera := Nil;
  Try
    objExecucao := TReformaExecucaoGravando.Create(AobjTarefa);
    Try
      pCriarFormularios(TfrmGravando, frmEspera);
      Try
        frmEspera.lblGravando.Caption := AstrTitulo;
        frmEspera.fExecutarAcao := objExecucao.fExecutar;
        frmEspera.blnTempoRestante := True;
        frmEspera.ShowModal;
        Result := objExecucao.recResultado;
      Finally
        FreeAndNil(frmEspera);
      End;
    Finally
      FreeAndNil(objExecucao);
    End;
  Except
    On E: Exception Do
      Result := fResultado(False, 0, E.Message);
  End;
end;

// Varios comandos num so ExecSQL (TBatchSQL: parametro vira literal), como a efetivacao de precos (FobjBatchPrePro).
function TReformaConvertHost.ExecutarLote(Const AarrComandos: TArray<TComandoSql>): TResultadoGravacao;
  Var
    objBatch: TBatchSQL;
    qryLote: TUniQuery;
    intCmd,
    intPar: Integer;
begin
  Try
    If Not fInTransaction Then
      Exit(fResultado(False, 0, 'ExecutarLote exige transação aberta.'));
    If Length(AarrComandos) = 0 Then
      Exit(fResultado(True, 0, ''));

    qryLote := fCriaQuery(nil);
    objBatch := TBatchSQL.Create(nil);
    Try
      objBatch.BatchSize := Length(AarrComandos);
      objBatch.StopOnError := True;
      For intCmd := 0 To High(AarrComandos) Do
      Begin
        objBatch.BeginCommand(AarrComandos[intCmd].Sql);
        For intPar := 0 To High(AarrComandos[intCmd].Parametros) Do
          objBatch.AddParam(AarrComandos[intCmd].Parametros[intPar].Nome,
                            AarrComandos[intCmd].Parametros[intPar].Valor,
                            fTipoParametroLote(AarrComandos[intCmd].Parametros[intPar].Valor));
        objBatch.EndCommand;
      End;
      objBatch.Execute(qryLote);
      Result := fResultado(True, Length(AarrComandos), '');
    Finally
      FreeAndNil(objBatch);
      FreeAndNil(qryLote);
    End;
  Except
    On E: Exception Do
      Result := fResultado(False, 0, E.Message);
  End;
end;

procedure TReformaConvertHost.pLiberarCalculo;
begin
  FreeAndNil(FqryItem);
  FreeAndNil(FqryEmpresas);
  FreeAndNil(FlstFornecedoresResp);
  FreeAndNil(FlstEmpresasF);
  FreeAndNil(FobjFatPre);
  FreeAndNil(FcpcParams);
end;

function TReformaConvertHost.IniciarCalculo(Const AOpcao: TOpcaoConversao): TResultadoGravacao;
  Var
    qryEmpFor: TUniQuery;
begin
  Try
    pLiberarCalculo;
    // Nova execucao: o historico (REGPRE) desta comeca no proximo lote aplicado.
    FstrAgrupador := '';

    // O cadastro nao recalcula com blnPreMat: a empresa que recebe os precos da matriz nao converte.
    If fPreMat Then
      Exit(fResultado(False, 0, 'Empresa recebe os preços da matriz.'));

    // Configuracoes lidas uma vez, como o FormCreate/FormShow do cadastro de produtos.
    FintDecUni := fCfgSis('DECUNI', varInteger);
    If FintDecUni > fTamPrecoIteger Then
      FintDecUni := 4;
    FstrMarMkp := fCfgSis('MARMKP');
    FstrEstado := fCadEmp('ESTADO');
    FblnTipAbfIteger := fCfgSis('TIPABF') = '2';
    FblnSuframaCusto := fCfgSis('SUFRAM', varBoolean) And (fCfgSis('FRMCUS', varString) = '4');
    FblnInfMat := fCfgSis('INFMAT', varBoolean);
    FintInfOpe := fCfgSis('INFOPE', varInteger);
    FintInfSai := fCfgSis('INFSAI', varInteger);
    FblnFatPre := fCfgSis('FATPRE', varBoolean);

    // Mesma linha do cadastro de produtos (FormCreate).
    FcpcParams := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao, True, True, False);

    If FblnFatPre Then
      FobjFatPre := TFatorPreco.Create;

    FlstEmpresasF := fListaEmpresasF;
    FlstEmpresasF.Sorted := True;

    // O item na logada, com a abreviacao e o fornecedor do CADITE.
    FqryItem := fCriaQuery(nil);
    FqryItem.SQL.Text := 'SELECT G.*, C.ITE_CODABF AS CAD_CODABF, C.ITE_CODFOR AS CAD_CODFOR ' +
                         'FROM ITEGER G INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ' +
                         'WHERE G.ITE_CODITE = :CODITE AND G.ITE_CODEMP = :CODEMP';

    // O item em todas as empresas, com a configuracao de cada uma: a mesma consulta de
    // pRecalculaItensResponsavelFornecedor (margem pela configuracao da empresa), sem o LOCATE.
    FqryEmpresas := fCriaQuery(nil);
    FqryEmpresas.SQL.Text :=
      'SELECT ITEGER.*, PCMPRO.SIS_VALCFG AS PCMPRO, DECUNI.SIS_VALCFG AS DECUNI, MARMKP.SIS_VALCFG AS MARMKP, ' +
      '       CID_ESTADO, IF(TIPABF.SIS_VALCFG = 1, CADITE.ITE_CODABF, ITEGER.ITE_CODABF) AS CFG_CODABF ' +
      '  FROM ITEGER ' +
      '  INNER JOIN CFGSIS AS TIPABF ON TIPABF.SIS_CODCFG = "CFG_TIPABF" AND TIPABF.SIS_CODEMP = ITEGER.ITE_CODEMP ' +
      '  INNER JOIN CFGSIS AS DECUNI ON DECUNI.SIS_CODCFG = "CFG_DECUNI" AND DECUNI.SIS_CODEMP = ITEGER.ITE_CODEMP ' +
      '  INNER JOIN CFGSIS AS MARMKP ON MARMKP.SIS_CODCFG = "CFG_MARMKP" AND MARMKP.SIS_CODEMP = ITEGER.ITE_CODEMP ' +
      '  INNER JOIN CFGSIS AS PCMPRO ON PCMPRO.SIS_CODCFG = "CFG_PCMPRO" AND PCMPRO.SIS_CODEMP = ITEGER.ITE_CODEMP ' +
      '  INNER JOIN CADEMP ON EMP_CODEMP = ITEGER.ITE_CODEMP ' +
      '  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ' +
      '  INNER JOIN CADITE ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ' +
      ' WHERE ITEGER.ITE_CODITE = :CODITE';

    // RN25: a logada e responsavel pelos fornecedores da EMPFOR dela; lida uma vez.
    FlstFornecedoresResp := TStringList.Create;
    FlstFornecedoresResp.Sorted := True;
    FlstFornecedoresResp.Duplicates := dupIgnore;
    If FblnInfMat Then
    Begin
      qryEmpFor := fCriaQuery(nil);
      Try
        qryEmpFor.SQL.Text := 'SELECT EFR_CODFOR FROM EMPFOR WHERE EFR_CODEMP = :CODEMP';
        qryEmpFor.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryEmpFor.Open;
        While Not qryEmpFor.Eof Do
        Begin
          FlstFornecedoresResp.Add(qryEmpFor.FieldByName('EFR_CODFOR').AsString);
          qryEmpFor.Next;
        End;
      Finally
        FreeAndNil(qryEmpFor);
      End;
    End;

    Result := fResultado(True, 0, '');
  Except
    On E: Exception Do
    Begin
      pLiberarCalculo;
      Result := fResultado(False, 0, E.Message);
    End;
  End;
end;

procedure TReformaConvertHost.FinalizarCalculo;
begin
  Try
    pLiberarCalculo;
  Except
    On E: Exception Do
      pLog('REFTRI Convert (FinalizarCalculo): ' + E.Message);
  End;
end;

// fCalculaPrecoVenda do cadastro com a configuracao informada (a da logada: MARMKP e PCMPRO vazios e DECUNI -1, como
// fRetPrecoVenda/pRecalculaPrecosFator; a de outra empresa: a dela, como pRecalculaItensResponsavelFornecedor).
function TReformaConvertHost.fCalculaTabela(Const AintOpcao: Integer; Const ArecLinha: TReformaLinhaCalculo;
  Const AintTabela: Integer; Const AfltMargem: Double; Const AstrMarMkp, AstrPcmPro: String; Const AintDecUni: Integer;
  Const AstrMarMkpSt, AstrEstado: String; Const AintDecUniLiq: Integer): Double;
  Var
    fltIcmsSTParteVenda: Double;
    blnST: Boolean;
begin
  blnST := False;
  fltIcmsSTParteVenda := untFuncoesSimples.fGetIcmsSTParteVenda(blnST, ArecLinha.CodAbf,
                           untFuncoesSimples.fCalculaPrecoCompraLiq(ArecLinha.PreCom, ArecLinha.DesF[1], ArecLinha.DesF[2],
                             ArecLinha.DesF[3], ArecLinha.DesF[4], ArecLinha.DesF[5], ArecLinha.DesF[6], AintDecUniLiq,
                             ArecLinha.PreDol = 'S'),
                           ArecLinha.IpiEnt, ArecLinha.IcmSai, AstrMarMkpSt, AstrEstado);

  Result := fCalculaPrecoVenda(AintOpcao,
                               ArecLinha.PreCus + ArecLinha.OutVal,
                               ArecLinha.PreVen[AintTabela],
                               AfltMargem,
                               ArecLinha.IcmSai,
                               ArecLinha.ImpFed,
                               ArecLinha.DesOpe,
                               ArecLinha.ComTbl[AintTabela],
                               AstrMarMkp,
                               AstrPcmPro,
                               AintDecUni,
                               fltIcmsSTParteVenda,
                               blnST);
end;

function TReformaConvertHost.fLinhaDaConsulta(Const AqryOrigem: TUniQuery; Const AstrCampoAbf: String): TReformaLinhaCalculo;
  Var
    intPos: Integer;
begin
  Result := Default(TReformaLinhaCalculo);
  Result.CodEmp := AqryOrigem.FieldByName('ITE_CODEMP').AsString;
  Result.CodAbf := AqryOrigem.FieldByName(AstrCampoAbf).AsString;
  Result.PreDol := AqryOrigem.FieldByName('ITE_PREDOL').AsString;
  Result.PreCom := AqryOrigem.FieldByName('ITE_PRECOM').AsFloat;
  For intPos := 1 To 6 Do
    Result.DesF[intPos] := AqryOrigem.FieldByName('ITE_DESF0' + IntToStr(intPos)).AsFloat;
  Result.IcmEnt := AqryOrigem.FieldByName('ITE_ICMENT').AsFloat;
  Result.IpiEnt := AqryOrigem.FieldByName('ITE_IPIENT').AsFloat;
  Result.FreEnt := AqryOrigem.FieldByName('ITE_FREENT').AsFloat;
  Result.ValFre := AqryOrigem.FieldByName('ITE_VALFRE').AsFloat;
  Result.AcrFin := AqryOrigem.FieldByName('ITE_ACRFIN').AsFloat;
  Result.Substi := AqryOrigem.FieldByName('ITE_SUBSTI').AsFloat;
  Result.DesAdb := AqryOrigem.FieldByName('ITE_DESADB').AsFloat;
  Result.SubFed := AqryOrigem.FieldByName('ITE_SUBFED').AsFloat;
  Result.TCifCu := AqryOrigem.FieldByName('ITE_TCIFCU').AsFloat;
  Result.TSCust := AqryOrigem.FieldByName('ITE_TSCUST').AsFloat;
  Result.DePiCo := AqryOrigem.FieldByName('ITE_DEPICO').AsFloat;
  Result.DeICMS := AqryOrigem.FieldByName('ITE_DEICMS').AsFloat;
  Result.FatReg := AqryOrigem.FieldByName('ITE_FATREG').AsFloat;
  Result.PreCus := AqryOrigem.FieldByName('ITE_PRECUS').AsFloat;
  Result.OutVal := AqryOrigem.FieldByName('ITE_OUTVAL').AsFloat;
  Result.IcmSai := AqryOrigem.FieldByName('ITE_ICMSAI').AsFloat;
  Result.ImpFed := AqryOrigem.FieldByName('ITE_IMPFED').AsFloat;
  Result.DesOpe := AqryOrigem.FieldByName('ITE_DESOPE').AsFloat;
  For intPos := 1 To QUANTIDADE_TABELAS_PRECO Do
  Begin
    Result.PreVen[intPos] := AqryOrigem.FieldByName('ITE_PREVE' + IntToStr(intPos)).AsFloat;
    Result.MarBru[intPos] := AqryOrigem.FieldByName('ITE_MARBR' + IntToStr(intPos)).AsFloat;
    Result.ComTbl[intPos] := AqryOrigem.FieldByName('ITE_COMTB' + IntToStr(intPos)).AsFloat;
  End;
end;

function TReformaConvertHost.fValoresDaLinha(Const ArecLinha: TReformaLinhaCalculo; Const AchrOrigem: Char): TValoresConversao;
  Var
    intTabela: Integer;
begin
  Result := Default(TValoresConversao);
  Result.CodigoEmpresa := ArecLinha.CodEmp;
  Result.Origem := AchrOrigem;
  Result.PrecoCompra := ArecLinha.PreCom;
  Result.PrecoCusto := ArecLinha.PreCus;
  Result.ImpostoFederal := ArecLinha.ImpFed;
  Result.SubFederal := ArecLinha.SubFed;
  Result.AliquotaFederal := ArecLinha.AlqFed;
  Result.DespesaOperacional := ArecLinha.DesOpe;
  Result.IcmsSaida := ArecLinha.IcmSai;
  Result.OutrosValores := ArecLinha.OutVal;
  For intTabela := 1 To QUANTIDADE_TABELAS_PRECO Do
  Begin
    Result.PrecoVenda[intTabela] := ArecLinha.PreVen[intTabela];
    Result.MargemBruta[intTabela] := ArecLinha.MarBru[intTabela];
    Result.Comissao[intTabela] := ArecLinha.ComTbl[intTabela];
  End;
end;

// Margem de todas as tabelas pela configuracao da propria empresa da linha, mantendo o preco: o corpo de
// pRecalculaItensResponsavelFornecedor (efetivacao com INFMAT e responsavel pelo fornecedor).
procedure TReformaConvertHost.pMargemPelaConfiguracao(Var ArecLinha: TReformaLinhaCalculo; Const AqryConfig: TUniQuery);
  Var
    intTabela,
    intDecUni: Integer;
begin
  intDecUni := AqryConfig.FieldByName('DECUNI').AsInteger;
  For intTabela := 1 To QUANTIDADE_TABELAS_PRECO Do
    ArecLinha.MarBru[intTabela] := fCalculaTabela(2, ArecLinha, intTabela, ArecLinha.MarBru[intTabela],
                                     AqryConfig.FieldByName('MARMKP').AsString, AqryConfig.FieldByName('PCMPRO').AsString,
                                     intDecUni, AqryConfig.FieldByName('MARMKP').AsString,
                                     AqryConfig.FieldByName('CID_ESTADO').AsString, intDecUni);
end;

// Aba 4: os campos da tela (nome do ITEGER) na linha da logada.
procedure TReformaConvertHost.pAplicarBase(Var ArecLinha: TReformaLinhaCalculo);
  Var
    intPos,
    intNumero: Integer;
    strNome,
    strRaiz: String;
    fltValor: Double;
begin
  For intPos := 0 To High(FarrBase) Do
  Begin
    strNome := UpperCase(FarrBase[intPos].Nome);
    If strNome = 'ITE_PREDOL' Then
    Begin
      ArecLinha.PreDol := VarToStr(FarrBase[intPos].Valor);
      Continue;
    End;

    fltValor := FarrBase[intPos].Valor;
    strRaiz := Copy(strNome, 1, 9);
    intNumero := StrToIntDef(Copy(strNome, 10, 1), 0);
    If (Length(strNome) = 10) And (intNumero >= 1) And (intNumero <= QUANTIDADE_TABELAS_PRECO) And
       ((strRaiz = 'ITE_PREVE') Or (strRaiz = 'ITE_MARBR') Or (strRaiz = 'ITE_COMTB')) Then
    Begin
      If strRaiz = 'ITE_PREVE' Then
        ArecLinha.PreVen[intNumero] := fltValor
      Else If strRaiz = 'ITE_MARBR' Then
        ArecLinha.MarBru[intNumero] := fltValor
      Else
        ArecLinha.ComTbl[intNumero] := fltValor;
    End
    Else If (strRaiz = 'ITE_DESF0') And (intNumero >= 1) And (intNumero <= 6) Then
      ArecLinha.DesF[intNumero] := fltValor
    Else If strNome = 'ITE_PRECOM' Then
      ArecLinha.PreCom := fltValor
    Else If strNome = 'ITE_ICMENT' Then
      ArecLinha.IcmEnt := fltValor
    Else If strNome = 'ITE_IPIENT' Then
      ArecLinha.IpiEnt := fltValor
    Else If strNome = 'ITE_FREENT' Then
      ArecLinha.FreEnt := fltValor
    Else If strNome = 'ITE_VALFRE' Then
      ArecLinha.ValFre := fltValor
    Else If strNome = 'ITE_ACRFIN' Then
      ArecLinha.AcrFin := fltValor
    Else If strNome = 'ITE_SUBSTI' Then
      ArecLinha.Substi := fltValor
    Else If strNome = 'ITE_DESADB' Then
      ArecLinha.DesAdb := fltValor
    Else If strNome = 'ITE_SUBFED' Then
      ArecLinha.SubFed := fltValor
    Else If strNome = 'ITE_TCIFCU' Then
      ArecLinha.TCifCu := fltValor
    Else If strNome = 'ITE_TSCUST' Then
      ArecLinha.TSCust := fltValor
    Else If strNome = 'ITE_DEPICO' Then
      ArecLinha.DePiCo := fltValor
    Else If strNome = 'ITE_DEICMS' Then
      ArecLinha.DeICMS := fltValor
    Else If strNome = 'ITE_FATREG' Then
      ArecLinha.FatReg := fltValor
    Else If strNome = 'ITE_PRECUS' Then
      ArecLinha.PreCus := fltValor
    Else If strNome = 'ITE_OUTVAL' Then
      ArecLinha.OutVal := fltValor
    Else If strNome = 'ITE_ICMSAI' Then
      ArecLinha.IcmSai := fltValor
    Else If strNome = 'ITE_IMPFED' Then
      ArecLinha.ImpFed := fltValor
    Else If strNome = 'ITE_DESOPE' Then
      ArecLinha.DesOpe := fltValor;
  End;
end;

// Aba 4 do cadastro (contrato 11): o mesmo CalcularItem, so a logada, com a base da tela. Exige IniciarCalculo.
function TReformaConvertHost.CalcularItemBase(Const ArecEntrada: TEntradaConversao; Const AarrBase: TArray<TValorCampo>;
  out ArecValores: TValoresConversao): TResultadoGravacao;
  Var
    arrValores: TListaValoresConversao;
begin
  ArecValores := Default(TValoresConversao);
  Try
    FarrBase := AarrBase;
    FblnModoBase := True;
    Try
      Result := CalcularItem(ArecEntrada, arrValores);
    Finally
      FblnModoBase := False;
      FarrBase := Nil;
    End;
    If Result.Sucesso And (Length(arrValores) > 0) Then
      ArecValores := arrValores[0];
  Except
    On E: Exception Do
      Result := fResultado(False, 0, E.Message);
  End;
end;

function fReformaCalcularItemBase(Const AOpcao: TOpcaoConversao; Const ArecEntrada: TEntradaConversao;
  Const AarrBase: TArray<TValorCampo>; out ArecValores: TValoresConversao): TResultadoGravacao;
  Var
    objHost: TReformaConvertHost;
    intfHost: IReformaConvertHost;
begin
  ArecValores := Default(TValoresConversao);
  objHost := TReformaConvertHost.Create;
  // A interface segura a contagem de referencia: o objeto sai junto com ela.
  intfHost := objHost;
  Result := objHost.IniciarCalculo(AOpcao);
  If Not Result.Sucesso Then
    Exit;
  Try
    Result := objHost.CalcularItemBase(ArecEntrada, AarrBase, ArecValores);
  Finally
    objHost.FinalizarCalculo;
  End;
end;

function fReformaDecimaisConvert: Integer;
  Var
    intfHost: IReformaConvertHost;
begin
  intfHost := TReformaConvertHost.Create;
  Result := intfHost.DecimaisUnitarios;
end;

function TReformaConvertHost.CalcularItem(Const ArecEntrada: TEntradaConversao;
  out AarrValores: TListaValoresConversao): TResultadoGravacao;
  Var
    recLogada,
    recLinha: TReformaLinhaCalculo;
    lstValores: TList<TValoresConversao>;
    intTabela: Integer;
    strCodEmp: String;
    blnResponsavel: Boolean;
    blnFatorAtivo: Array[1..QUANTIDADE_TABELAS_PRECO] Of Boolean;
    intPos: Integer;
begin
  AarrValores := Nil;
  Try
    If Not Assigned(FqryItem) Then
      Exit(fResultado(False, 0, 'O cálculo não foi iniciado.'));

    FqryItem.Close;
    FqryItem.ParamByName('CODITE').AsString := ArecEntrada.CodigoItem;
    FqryItem.ParamByName('CODEMP').AsString := VS_strCodEmp;
    FqryItem.Open;
    If FqryItem.IsEmpty Then
      Exit(fResultado(False, 0, 'O item não existe na empresa logada.'));

    {**************************************************************}
    {* LOGADA: pRecalculaPrecos DO CADASTRO, SO EM MEMORIA, COM O *}
    {* PRECO DE COMPRA, A DESPESA E A COMISSAO DA DLL E OS        *}
    {* FEDERAIS ZERADOS                                           *}
    {**************************************************************}
    If FblnTipAbfIteger Then
      recLogada := fLinhaDaConsulta(FqryItem, 'ITE_CODABF')
    Else
      recLogada := fLinhaDaConsulta(FqryItem, 'CAD_CODABF');
    // Aba 4 do cadastro: os campos da tela no lugar dos gravados, antes de qualquer conta.
    If FblnModoBase Then
      pAplicarBase(recLogada);
    blnResponsavel := FblnInfMat And (FlstFornecedoresResp.IndexOf(FqryItem.FieldByName('CAD_CODFOR').AsString) >= 0);

    recLogada.PreCom := ArecEntrada.PrecoCompra;
    recLogada.ImpFed := 0;
    recLogada.SubFed := 0;
    recLogada.AlqFed := 0;
    recLogada.DesOpe := ArecEntrada.DespesaOperacional;
    For intTabela := 1 To QUANTIDADE_TABELAS_PRECO Do
      recLogada.ComTbl[intTabela] := ArecEntrada.Comissao[intTabela];

    // fRetPrecoCusto
    With FcpcParams Do
    Begin
      curPreCom  := recLogada.PreCom;
      curDesF01  := recLogada.DesF[1];
      curDesF02  := recLogada.DesF[2];
      curDesF03  := recLogada.DesF[3];
      curDesF04  := recLogada.DesF[4];
      curDesF05  := recLogada.DesF[5];
      curDesF06  := recLogada.DesF[6];
      curICMSEnt := recLogada.IcmEnt;
      curIPIEnt  := recLogada.IpiEnt;
      curFrete   := recLogada.FreEnt;
      curAcrFin  := recLogada.AcrFin;
      curSubsti  := recLogada.Substi;
      curValFre  := recLogada.ValFre;
      curDesAdb  := recLogada.DesAdb;
      curSubFed  := recLogada.SubFed;
      If FblnSuframaCusto Then
      Begin
        curTCIFCu := recLogada.TCifCu;
        curTSCust := recLogada.TSCust;
        curDePiCo := recLogada.DePiCo;
        curDeICMS := recLogada.DeICMS;
        curFatReg := recLogada.FatReg;
      End
      Else
      Begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      End;
    End;
    recLogada.PreCus := FcpcParams.fCalculaPrecoCusto(recLogada.PreDol = 'S');

    // pRecalculaPrecos com intPreMar = 2 (o preco e o alvo, a margem e recalculada) e pRecalculaPrecosFator.
    For intTabela := 1 To QUANTIDADE_TABELAS_PRECO Do
    Begin
      blnFatorAtivo[intTabela] := FblnFatPre And (intTabela >= 2) And FobjFatPre.fTabelaAtiva(intTabela);
      If Not blnFatorAtivo[intTabela] Then
      Begin
        If ArecEntrada.Alvos[intTabela].Modo = mtcMantemPreco Then
        Begin
          recLogada.PreVen[intTabela] := ArecEntrada.Alvos[intTabela].Valor;
          recLogada.MarBru[intTabela] := fCalculaTabela(2, recLogada, intTabela, recLogada.MarBru[intTabela], '', '', -1,
                                           FstrMarMkp, FstrEstado, FintDecUni);
        End
        Else
        Begin
          recLogada.MarBru[intTabela] := ArecEntrada.Alvos[intTabela].Valor;
          recLogada.PreVen[intTabela] := fCalculaTabela(1, recLogada, intTabela, recLogada.MarBru[intTabela], '', '', -1,
                                           FstrMarMkp, FstrEstado, FintDecUni);
        End;
      End;
    End;
    For intTabela := 2 To QUANTIDADE_TABELAS_PRECO Do
      If blnFatorAtivo[intTabela] Then
      Begin
        recLogada.PreVen[intTabela] := FobjFatPre.fCalculaPrecoVendaFator(recLogada.PreVen[1], intTabela);
        recLogada.MarBru[intTabela] := fCalculaTabela(2, recLogada, intTabela, 0, '', '', -1, FstrMarMkp, FstrEstado,
                                         FintDecUni);
      End;

    lstValores := TList<TValoresConversao>.Create;
    Try
      lstValores.Add(fValoresDaLinha(recLogada, 'L'));

      {***************************************************************}
      {* DEMAIS EMPRESAS DO ITEM: AS QUE USAM O PRECO DA LOGADA E,   *}
      {* COM INFMAT E A LOGADA RESPONSAVEL PELO FORNECEDOR, AS OUTRAS *}
      {***************************************************************}
      If (FlstEmpresasF.Count > 0) Or FblnInfMat Then
      Begin
        FqryEmpresas.Close;
        FqryEmpresas.ParamByName('CODITE').AsString := ArecEntrada.CodigoItem;
        FqryEmpresas.Open;
        While Not FqryEmpresas.Eof Do
        Begin
          strCodEmp := FqryEmpresas.FieldByName('ITE_CODEMP').AsString;
          recLinha := fLinhaDaConsulta(FqryEmpresas, 'CFG_CODABF');

          If strCodEmp = VS_strCodEmp Then
          Begin
            // Com INFMAT a efetivacao refaz tambem a margem da logada pela configuracao dela, mantendo o preco.
            If FblnInfMat Then
            Begin
              recLogada.CodAbf := recLinha.CodAbf;
              pMargemPelaConfiguracao(recLogada, FqryEmpresas);
              lstValores[0] := fValoresDaLinha(recLogada, 'L');
            End;
          End
          Else If (Not FblnModoBase) And (FlstEmpresasF.IndexOf(strCodEmp) >= 0) Then
          Begin
            // Usa o preco da logada: custo, preco e comissao dela, federais zerados; DESOPE/ICMSAI proprios so com
            // INFMAT e INFOPE/INFSAI = 1 (regra da efetivacao).
            recLinha.PreDol := recLogada.PreDol;
            recLinha.PreCom := recLogada.PreCom;
            recLinha.DesF := recLogada.DesF;
            recLinha.IcmEnt := recLogada.IcmEnt;
            recLinha.IpiEnt := recLogada.IpiEnt;
            recLinha.FreEnt := recLogada.FreEnt;
            recLinha.ValFre := recLogada.ValFre;
            recLinha.AcrFin := recLogada.AcrFin;
            recLinha.Substi := recLogada.Substi;
            recLinha.DesAdb := recLogada.DesAdb;
            recLinha.TCifCu := recLogada.TCifCu;
            recLinha.TSCust := recLogada.TSCust;
            recLinha.DePiCo := recLogada.DePiCo;
            recLinha.DeICMS := recLogada.DeICMS;
            recLinha.FatReg := recLogada.FatReg;
            recLinha.PreCus := recLogada.PreCus;
            recLinha.OutVal := recLogada.OutVal;
            recLinha.SubFed := 0;
            recLinha.AlqFed := 0;
            recLinha.ImpFed := 0;
            If Not (FblnInfMat And (FintInfOpe = 1)) Then
              recLinha.DesOpe := recLogada.DesOpe;
            If Not (FblnInfMat And (FintInfSai = 1)) Then
              recLinha.IcmSai := recLogada.IcmSai;
            recLinha.PreVen := recLogada.PreVen;
            recLinha.ComTbl := recLogada.ComTbl;
            recLinha.MarBru := recLogada.MarBru;
            If FblnInfMat Then
              pMargemPelaConfiguracao(recLinha, FqryEmpresas);
            lstValores.Add(fValoresDaLinha(recLinha, 'F'));
          End
          Else If (Not FblnModoBase) And blnResponsavel Then
          Begin
            // Responsavel pelo fornecedor: so o custo da logada, os campos do cadastro (pAtualizaIteGer(True)); preco,
            // IMPFED, DESOPE e comissao proprios; margem refeita pela configuracao dela.
            recLinha.PreDol := recLogada.PreDol;
            recLinha.PreCom := recLogada.PreCom;
            recLinha.DesF := recLogada.DesF;
            recLinha.IcmEnt := recLogada.IcmEnt;
            recLinha.IpiEnt := recLogada.IpiEnt;
            recLinha.FreEnt := recLogada.FreEnt;
            recLinha.ValFre := recLogada.ValFre;
            recLinha.AcrFin := recLogada.AcrFin;
            recLinha.Substi := recLogada.Substi;
            recLinha.DesAdb := recLogada.DesAdb;
            recLinha.PreCus := recLogada.PreCus;
            recLinha.SubFed := 0;
            recLinha.AlqFed := 0;
            pMargemPelaConfiguracao(recLinha, FqryEmpresas);
            lstValores.Add(fValoresDaLinha(recLinha, 'R'));
          End;

          FqryEmpresas.Next;
        End;
      End;

      // TListaValoresConversao (array of) e outro tipo que o TArray<T> do ToArray.
      SetLength(AarrValores, lstValores.Count);
      For intPos := 0 To lstValores.Count - 1 Do
        AarrValores[intPos] := lstValores[intPos];
    Finally
      FreeAndNil(lstValores);
    End;

    Result := fResultado(True, Length(AarrValores), '');
  Except
    On E: Exception Do
    Begin
      AarrValores := Nil;
      Result := fResultado(False, 0, E.Message);
    End;
  End;
end;

// ITEREF (chave + lote) no produto, por conjunto, como a efetivacao de precos desta versao (RN14/RN25).
// Aplicar: ITEREF (valores novos) nas linhas ainda nao aplicadas (REF_APLICADO = 'N'). Reverter (contrato 11): ITEREO
// (valores de antes) nas linhas ja aplicadas ('S'), com o historico num agrupador proprio. O mesmo comando nos dois
// sentidos: mesma gravacao sem cascata, mesma LOGREP.
function TReformaConvertHost.fGravarLote(Const AstrChave: String; Const AintLote: Integer;
  Const AblnReverter: Boolean): TResultadoGravacao;
  Var
    qryAplica: TUniQuery;
    strOrigem,
    strAplicado,
    strLocal,
    strAgrupador: String;
    strTabela: String;
    strCampo: String;
    intTabela: Integer;
    blnCascata: Boolean;
begin
  If AblnReverter Then
  Begin
    strOrigem := 'ITEREO';
    strAplicado := 'S';
    strLocal := STR_LOCAL_REVERSAO;
  End
  Else
  Begin
    strOrigem := 'ITEREF';
    strAplicado := 'N';
    strLocal := STR_LOCAL_CONVERT;
  End;
  blnCascata := False;
  Try
    If Not fInTransaction Then
      Exit(fResultado(False, 0, 'AplicarLote exige transação aberta.'));

    qryAplica := fCriaQuery(nil);
    Try
      // Historico pelo trigger PREALT: um REGPRE por execucao (so insere com a chave vazia).
      If VS_blnPreAltViaTrigger Then
      Begin
        If AblnReverter Then
          strAgrupador := FstrAgrupadorReversao
        Else
          strAgrupador := FstrAgrupador;
        pPreAltDefineVariaveisAltPre(fNow, strLocal, strLoginUsuarioLogado, VS_strCodEmp, strAgrupador);
        If AblnReverter Then
          FstrAgrupadorReversao := strAgrupador
        Else
          FstrAgrupador := strAgrupador;
      End;

      // Um comando para o ITEGER e o CADITE (pAtualizaUltimaAlteracaoItem dos itens). ITE_PEFAVE nao e mais gravado e
      // ALQFED/ALQENT ficam zerados (usuario, 2026-10-05; o ALQENT vem 0 da ITEREF).
      // Sem cascata (2026-10-06): na base com trigger ITEGER -> PREPRO (age com a variavel NULL) cada linha do ITEGER
      // regravava a PREPRO tabela a tabela (7 UPDATEs; na base com um trigger BEFORE e outro AFTER, 14). Com 'NAO' os
      // triggers de copia nao agem e a PREPRO recebe do ITEGER os mesmos campos num comando so (fSqlPreProDoIteger).
      // PREALT e DALTPR nao dependem da variavel. O comando comeca com SET: vai inteiro para a LOGREP.
      blnCascata := fCascataItegerPrePro;
      If blnCascata Then
        qryAplica.SQL.Add('SET @_PREPRO_ATUALIZA_ITEGER = ''NAO''; ');
      qryAplica.SQL.Add('UPDATE ITEGER G ');
      qryAplica.SQL.Add(' INNER JOIN ' + strOrigem + ' F ON F.ITE_CODEMP = G.ITE_CODEMP AND F.ITE_CODITE = G.ITE_CODITE ');
      qryAplica.SQL.Add(' INNER JOIN CADITE C ON C.ITE_CODITE = F.ITE_CODITE ');
      qryAplica.SQL.Add('   SET C.ITE_DTAALT = :DTAALT, C.ITE_HULALT = :HULALT, C.ITE_CODOPE = :CODOPE, ');
      qryAplica.SQL.Add('       G.ITE_PREALT = :PREALT, ');
      qryAplica.SQL.Add('       G.ITE_PRECOM = F.ITE_PRECOM, ');
      qryAplica.SQL.Add('       G.ITE_PRECUS = F.ITE_PRECUS, ');
      qryAplica.SQL.Add('       G.ITE_IMPFED = F.ITE_IMPFED, ');
      qryAplica.SQL.Add('       G.ITE_SUBFED = F.ITE_SUBFED, ');
      If fColunaExiste('ITEGER', 'ITE_ALQFED') And fColunaExiste(strOrigem, 'ITE_ALQFED') Then
      Begin
        If AblnReverter Then
          qryAplica.SQL.Add('       G.ITE_ALQFED = F.ITE_ALQFED, ')
        Else
          qryAplica.SQL.Add('       G.ITE_ALQFED = 0, ');
      End;
      // ALQENT da origem: 0 na conversao (ITEREF) e o de antes no Reverter (ITEREO). Nao esta em CamposCustoDaLogada.
      If fColunaExiste('ITEGER', 'ITE_ALQENT') And fColunaExiste(strOrigem, 'ITE_ALQENT') Then
        qryAplica.SQL.Add('       G.ITE_ALQENT = F.ITE_ALQENT, ');
      qryAplica.SQL.Add('       G.ITE_DESOPE = F.ITE_DESOPE, ');
      qryAplica.SQL.Add('       G.ITE_ICMSAI = F.ITE_ICMSAI, ');
      // Calculado (TReformaLinhaCalculo.OutVal): F recebe o da logada, como o cadastro.
      qryAplica.SQL.Add('       G.ITE_OUTVAL = F.ITE_OUTVAL, ');
      // Custo que as outras empresas recebem da logada (CamposCustoDaLogada 'F' contem os de 'R').
      For strCampo In CamposCustoDaLogada('F').Split([';']) Do
        If fColunaExiste(strOrigem, strCampo) And fColunaExiste('ITEGER', strCampo) Then
          qryAplica.SQL.Add('       G.' + strCampo + ' = F.' + strCampo + ', ');
      For intTabela := 1 To QUANTIDADE_TABELAS_PRECO Do
      Begin
        strTabela := IntToStr(intTabela);
        qryAplica.SQL.Add('       G.ITE_PREVE' + strTabela + ' = F.ITE_PREVE' + strTabela + ', ');
        qryAplica.SQL.Add('       G.ITE_MARBR' + strTabela + ' = F.ITE_MARBR' + strTabela + ', ');
        If intTabela < QUANTIDADE_TABELAS_PRECO Then
          qryAplica.SQL.Add('       G.ITE_COMTB' + strTabela + ' = F.ITE_COMTB' + strTabela + ', ')
        Else
          qryAplica.SQL.Add('       G.ITE_COMTB' + strTabela + ' = F.ITE_COMTB' + strTabela + ' ');
      End;
      qryAplica.SQL.Add(' WHERE F.REF_CHAVE = :CHAVE AND F.REF_LOTE = :LOTE AND F.REF_APLICADO = :APLICADO ');
      If blnCascata Then
        qryAplica.SQL.Add('; ' + fSqlPreProDoIteger(strOrigem) + '; SET @_PREPRO_ATUALIZA_ITEGER = NULL; ');
      // Sem trigger o agrupador fica vazio, como a efetivacao.
      If AblnReverter Then
        qryAplica.ParamByName('PREALT').AsString := FstrAgrupadorReversao
      Else
        qryAplica.ParamByName('PREALT').AsString := FstrAgrupador;
      qryAplica.ParamByName('DTAALT').AsDate := VS_Date;
      qryAplica.ParamByName('HULALT').AsDateTime := fNow;
      qryAplica.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryAplica.ParamByName('CHAVE').AsString := AstrChave;
      qryAplica.ParamByName('LOTE').AsInteger := AintLote;
      qryAplica.ParamByName('APLICADO').AsString := strAplicado;
      If blnCascata Then
      Begin
        qryAplica.ParamByName('CHAVE_P').AsString := AstrChave;
        qryAplica.ParamByName('LOTE_P').AsInteger := AintLote;
        qryAplica.ParamByName('APLICADO_P').AsString := strAplicado;
      End;
      qryAplica.ExecSQL;

      // Sem o trigger, o historico item a item, como a efetivacao: valores antigos da ITEREO e novos da ITEREF.
      If Not VS_blnPreAltViaTrigger Then
      Begin
        qryAplica.SQL.Clear;
        qryAplica.SQL.Add('SELECT F.ITE_CODITE, O.ITE_PRECUS AS CUSANT, F.ITE_PRECUS AS CUSATU, ');
        qryAplica.SQL.Add('       O.ITE_PRECOM AS COMANT, F.ITE_PRECOM AS COMATU');
        For intTabela := 1 To QUANTIDADE_TABELAS_PRECO Do
        Begin
          strTabela := IntToStr(intTabela);
          qryAplica.SQL.Add('     , O.ITE_PREVE' + strTabela + ' AS VE' + strTabela + 'ANT, F.ITE_PREVE' + strTabela +
                            ' AS VE' + strTabela + 'ATU, O.ITE_MARBR' + strTabela + ' AS MA' + strTabela +
                            'ANT, F.ITE_MARBR' + strTabela + ' AS MA' + strTabela + 'ATU');
        End;
        // Reverter: o antigo (O) e o que a conversao gravou (ITEREF) e o novo (F) e o de antes dela (ITEREO).
        If AblnReverter Then
          qryAplica.SQL.Add('  FROM ITEREO F INNER JOIN ITEREF O ')
        Else
          qryAplica.SQL.Add('  FROM ITEREF F INNER JOIN ITEREO O ');
        qryAplica.SQL.Add('    ON O.REF_CHAVE = F.REF_CHAVE AND O.ITE_CODEMP = F.ITE_CODEMP AND O.ITE_CODITE = F.ITE_CODITE ');
        qryAplica.SQL.Add(' WHERE F.REF_CHAVE = :CHAVE AND F.REF_LOTE = :LOTE AND F.REF_ORIGEM = ''L'' ');
        qryAplica.SQL.Add('   AND F.REF_APLICADO = :APLICADO ');
        qryAplica.ParamByName('CHAVE').AsString := AstrChave;
        qryAplica.ParamByName('LOTE').AsInteger := AintLote;
        qryAplica.ParamByName('APLICADO').AsString := strAplicado;
        qryAplica.Open;
        While Not qryAplica.Eof Do
        Begin
          With qryAplica Do
            If Not fGravaPreAlt(FieldByName('ITE_CODITE').AsString,
                                FieldByName('CUSANT').AsFloat, FieldByName('CUSATU').AsFloat,
                                FieldByName('VE1ANT').AsFloat, FieldByName('VE1ATU').AsFloat,
                                FieldByName('MA1ANT').AsFloat, FieldByName('MA1ATU').AsFloat,
                                FieldByName('VE2ANT').AsFloat, FieldByName('VE2ATU').AsFloat,
                                FieldByName('MA2ANT').AsFloat, FieldByName('MA2ATU').AsFloat,
                                FieldByName('VE3ANT').AsFloat, FieldByName('VE3ATU').AsFloat,
                                FieldByName('MA3ANT').AsFloat, FieldByName('MA3ATU').AsFloat,
                                FieldByName('VE4ANT').AsFloat, FieldByName('VE4ATU').AsFloat,
                                FieldByName('MA4ANT').AsFloat, FieldByName('MA4ATU').AsFloat,
                                FieldByName('VE5ANT').AsFloat, FieldByName('VE5ATU').AsFloat,
                                FieldByName('MA5ANT').AsFloat, FieldByName('MA5ATU').AsFloat,
                                FieldByName('VE6ANT').AsFloat, FieldByName('VE6ATU').AsFloat,
                                FieldByName('MA6ANT').AsFloat, FieldByName('MA6ATU').AsFloat,
                                FieldByName('VE7ANT').AsFloat, FieldByName('VE7ATU').AsFloat,
                                FieldByName('MA7ANT').AsFloat, FieldByName('MA7ATU').AsFloat,
                                FieldByName('COMANT').AsFloat, FieldByName('COMATU').AsFloat,
                                strLocal, Nil, '', strLoginUsuarioLogado) Then
              Exit(fResultado(False, 0, 'Não foi possível gravar o histórico de preços do item ' +
                                        FieldByName('ITE_CODITE').AsString + '.'));
          qryAplica.Next;
        End;
        qryAplica.Close;
      End;

      Result := fResultado(True, 0, '');
    Finally
      // A variavel volta a NULL (sem replicar) mesmo que o comando tenha parado no meio.
      If blnCascata Then
      Begin
        qryAplica.SQL.Text := STR_SQL_NAO_REPLICAR + ' SET @_PREPRO_ATUALIZA_ITEGER = NULL';
        qryAplica.ExecSQL;
      End;
      FreeAndNil(qryAplica);
    End;
  Except
    On E: Exception Do
      Result := fResultado(False, 0, E.Message);
  End;
end;

function TReformaConvertHost.AplicarLote(Const AstrChave: String; Const AintLote: Integer): TResultadoGravacao;
begin
  Result := fGravarLote(AstrChave, AintLote, False);
end;

// Reverter (contrato 11): o AplicarLote ao contrario. O primeiro lote da reversao comeca o historico dela.
function TReformaConvertHost.ReverterLote(Const AstrChave: String; Const AintLote: Integer;
  Const AblnPrimeiroLote: Boolean): TResultadoGravacao;
begin
  If AblnPrimeiroLote Then
    FstrAgrupadorReversao := '';
  Result := fGravarLote(AstrChave, AintLote, True);
end;

// Os campos de custo que a empresa recebe da logada, como o cadastro (pAtualizaIteGer): os mesmos que CalcularItem
// copia para F e R.
function TReformaConvertHost.CamposCustoDaLogada(Const AchrOrigem: Char): String;
begin
  If AchrOrigem = 'F' Then
    Result := 'ITE_PREDOL;ITE_DESF01;ITE_DESF02;ITE_DESF03;ITE_DESF04;ITE_DESF05;ITE_DESF06;ITE_ICMENT;ITE_IPIENT;ITE_FREENT;ITE_VALFRE;ITE_ACRFIN;ITE_SUBSTI;ITE_DESADB;ITE_TCIFCU;ITE_TSCUST;ITE_DEPICO;ITE_DEICMS;ITE_FATREG'
  Else If AchrOrigem = 'R' Then
    Result := 'ITE_PREDOL;ITE_DESF01;ITE_DESF02;ITE_DESF03;ITE_DESF04;ITE_DESF05;ITE_DESF06;ITE_ICMENT;ITE_IPIENT;ITE_FREENT;ITE_VALFRE;ITE_ACRFIN;ITE_SUBSTI;ITE_DESADB'
  Else
    Result := '';
end;

{*************************************************************}
{* CONVERSAO POR GRUPO DE PRECO (REFTRI-02, 2026-10-06): A    *}
{* TELA DO CONVERT MONTA OS GRUPOS E CONVERTE CADA UM LOGADO  *}
{* NA EMPRESA DO GRUPO                                        *}
{*************************************************************}

// fRetEmpresasUsamPrecoMatriz como se a empresa estivesse logada (o mesmo caminho do TMonitoramentoEmpresasPrecoMatriz:
// a funcao le as configuracoes da empresa logada). A logada volta no Finally.
function TReformaConvertHost.EmpresasPrecoDe(Const AstrCodigoEmpresa: String): String;
  Var
    strEmpresaLogada: String;
    stlPartes: TStringList;
    intPos: Integer;
begin
  Result := '';
  strEmpresaLogada := VS_strCodEmp;
  stlPartes := TStringList.Create;
  Try
    Try
      pSetaEmpresaLogada(AstrCodigoEmpresa);
      stlPartes.Delimiter := '_';
      stlPartes.StrictDelimiter := True;
      stlPartes.DelimitedText := fRetEmpresasUsamPrecoMatriz;
      For intPos := 0 To stlPartes.Count - 1 Do
        If Trim(stlPartes[intPos]) <> '' Then
        Begin
          If Result <> '' Then
            Result := Result + ';';
          Result := Result + Trim(stlPartes[intPos]);
        End;
    Except
      On E: Exception Do
        pLog('REFTRI Convert (EmpresasPrecoDe): ' + E.Message);
    End;
  Finally
    pSetaEmpresaLogada(strEmpresaLogada);
    FreeAndNil(stlPartes);
  End;
end;

// Troca interna da empresa logada, sem senha e sem tela: o mesmo que a rotina automatica do autcom
// (pFuncoesDiariasAutomatico) e a parte de configuracao do logoff fazem. Menus, timers, TEF e plugins nao mudam: a tela
// do Convert volta para a empresa original no fim.
function TReformaConvertHost.TrocarEmpresa(Const AstrCodigoEmpresa: String): TResultadoGravacao;
  Var
    qryEmpresa: TUniQuery;
begin
  Try
    If fInTransaction Then
      Exit(fResultado(False, 0, 'Há uma transação aberta: a empresa não pode ser trocada agora.'));

    qryEmpresa := fCriaQuery(nil);
    Try
      qryEmpresa.SQL.Text := 'SELECT COUNT(*) AS QTD FROM CADEMP WHERE EMP_CODEMP = :CODEMP';
      qryEmpresa.ParamByName('CODEMP').AsString := AstrCodigoEmpresa;
      qryEmpresa.Open;
      If qryEmpresa.FieldByName('QTD').AsInteger = 0 Then
        Exit(fResultado(False, 0, 'Empresa ' + AstrCodigoEmpresa + ' não encontrada.'));
    Finally
      FreeAndNil(qryEmpresa);
    End;

    pSetaEmpresaLogada(AstrCodigoEmpresa);
    VS_blnEmpLogadaPertenceBaseEmpFisica := fEmpLogadaPertenceBaseEmpFisica(True);
    fAjustaDataSistema;
    DefinirTimeZoneEmSessaoMySql(fGetConexao, AstrCodigoEmpresa);
    If Not pAtuVarGlobais Then
      Exit(fResultado(False, 0, 'As configurações da empresa ' + AstrCodigoEmpresa + ' não foram carregadas.'));
    VS_CfgJaVerificadas := False;
    TfrmCfgRepositorio.pMontaArrConfiguracoes;

    Result := fResultado(True, 0, '');
  Except
    On E: Exception Do
      Result := fResultado(False, 0, E.Message);
  End;
end;

function TReformaConvertHost.AtivarReforma(Const AstrCodigoEmpresa: String): TResultadoGravacao;
  Var
    qryCfg: TUniQuery;
begin
  Try
    If Not fInTransaction Then
      Exit(fResultado(False, 0, 'AtivarReforma exige transação aberta.'));

    qryCfg := fCriaQuery(nil);
    Try
      // Sem CLIENT_FOUND_ROWS o UPDATE de um valor ja 'S' afeta 0 linhas: a existencia e conferida antes.
      qryCfg.SQL.Text := 'SELECT COUNT(*) AS QTD FROM CFGSIS WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG';
      qryCfg.ParamByName('CODEMP').AsString := AstrCodigoEmpresa;
      qryCfg.ParamByName('CODCFG').AsString := 'CFG_REFCIS';
      qryCfg.Open;
      If qryCfg.FieldByName('QTD').AsInteger = 0 Then
        Exit(fResultado(False, 0, 'Configuração CFG_REFCIS não encontrada para a empresa ' + AstrCodigoEmpresa + '.'));
      qryCfg.Close;

      qryCfg.SQL.Text := 'UPDATE CFGSIS SET SIS_VALCFG = :VALCFG WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG';
      qryCfg.ParamByName('VALCFG').AsString := 'S';
      qryCfg.ParamByName('CODEMP').AsString := AstrCodigoEmpresa;
      qryCfg.ParamByName('CODCFG').AsString := 'CFG_REFCIS';
      qryCfg.ExecSQL;
    Finally
      FreeAndNil(qryCfg);
    End;

    // Cache do fCfgSis (chave sem o CFG_ + empresa): esta estacao passa a ler o valor novo.
    If Assigned(dicConfiguracoes) Then
      dicConfiguracoes.Remove('REFCIS' + AstrCodigoEmpresa);

    Result := fResultado(True, 1, '');
  Except
    On E: Exception Do
      Result := fResultado(False, 0, E.Message);
  End;
end;

// Reverter (contrato 11): CFG_REFCIS = 'N', o inverso de AtivarReforma.
function TReformaConvertHost.DesativarReforma(Const AstrCodigoEmpresa: String): TResultadoGravacao;
  Var
    qryCfg: TUniQuery;
begin
  Try
    If Not fInTransaction Then
      Exit(fResultado(False, 0, 'DesativarReforma exige transação aberta.'));

    qryCfg := fCriaQuery(nil);
    Try
      // Sem CLIENT_FOUND_ROWS o UPDATE de um valor ja 'N' afeta 0 linhas: a existencia e conferida antes.
      qryCfg.SQL.Text := 'SELECT COUNT(*) AS QTD FROM CFGSIS WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG';
      qryCfg.ParamByName('CODEMP').AsString := AstrCodigoEmpresa;
      qryCfg.ParamByName('CODCFG').AsString := 'CFG_REFCIS';
      qryCfg.Open;
      If qryCfg.FieldByName('QTD').AsInteger = 0 Then
        Exit(fResultado(False, 0, 'Configuração CFG_REFCIS não encontrada para a empresa ' + AstrCodigoEmpresa + '.'));
      qryCfg.Close;

      qryCfg.SQL.Text := 'UPDATE CFGSIS SET SIS_VALCFG = :VALCFG WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG';
      qryCfg.ParamByName('VALCFG').AsString := 'N';
      qryCfg.ParamByName('CODEMP').AsString := AstrCodigoEmpresa;
      qryCfg.ParamByName('CODCFG').AsString := 'CFG_REFCIS';
      qryCfg.ExecSQL;
    Finally
      FreeAndNil(qryCfg);
    End;

    // Cache do fCfgSis (chave sem o CFG_ + empresa): esta estacao passa a ler o valor novo.
    If Assigned(dicConfiguracoes) Then
      dicConfiguracoes.Remove('REFCIS' + AstrCodigoEmpresa);

    Result := fResultado(True, 1, '');
  Except
    On E: Exception Do
      Result := fResultado(False, 0, E.Message);
  End;
end;

{ Rotinas do untPrincipal }

function fReformaConvertDisponivel: Boolean;
  Var
    objLoader: TReformaPrecosLoader;
begin
  Result := False;
  objLoader := TReformaPrecosLoader.Create;
  Try
    Try
      // A regra (operador 998 ou a data) e da DLL; o host so informa.
      Result := objLoader.fCarregar And objLoader.fConvertDisponivel(strLoginUsuarioLogado, fNow);
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(objLoader);
  End;
end;

procedure pReformaAbrirConvert;
  Var
    objLoader: TReformaPrecosLoader;
    objHost: IReformaConvertHost;
    intForm: Integer;
begin
  {*****************************************************}
  {* A DLL PODE ESTAR CARREGADA PELO CADASTRO: A TELA  *}
  {* DO CONVERT SO ABRE COM O CADASTRO FECHADO         *}
  {*****************************************************}
  For intForm := 0 To Screen.FormCount - 1 Do
    If Screen.Forms[intForm] Is TfrmCadProdutos Then
    Begin
      fMensagem(STR_TITULO_CONVERT, 'Feche o Cadastro de Produtos antes de ativar os preços da Reforma Tributária.', ['&Ok']);
      Exit;
    End;

  objLoader := TReformaPrecosLoader.Create;
  Try
    // So a carga e a versao: a regra de quem pode usar a DLL confere ao abrir a tela, com a mensagem dela.
    If Not objLoader.fCarregar Then
    Begin
      fMensagem(STR_TITULO_CONVERT, 'O plugin da Reforma Tributária (' + NOME_DLL + ') não está disponível ou é de outra versão.', ['&Ok']);
      Exit;
    End;

    // Referencia do host aqui: o objeto vive ate a tela da DLL fechar e soltar as dela.
    objHost := TReformaConvertHost.Create;
    Try
      objLoader.pAbrirConvert(objHost);
    Except
      On E: Exception Do
        fMensagem(STR_TITULO_CONVERT, E.Message, ['&Ok']);
    End;
  Finally
    objHost := Nil;
    // Fora do Except: a DLL nunca e descarregada enquanto uma excecao dela esta sendo tratada.
    FreeAndNil(objLoader);
  End;
end;

end.
