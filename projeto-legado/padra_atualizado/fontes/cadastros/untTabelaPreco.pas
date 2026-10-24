unit untTabelaPreco;

interface

Uses
  Variants,
  Windows,
  Classes,
  SysUtils,
  Controls,
  ComCtrls,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untZClient,
  cxProgressBar,
  untFuncoesSimples,
  untGravando,
  untExcel,
  untPreAlt_Trigger,
  untParCalculaPrecoCusto,
  untIteBar,
  untTypesTabelaPreco,
  Vcl.Graphics,
  ShellApi;

Const
  TArrCamposRecPrecos:  Array[1..19] Of String =
    ('ITE_PRECOM',
     'ITE_DESF01',
     'ITE_ICMSAI',
     'ITE_SUBFED',
     'ITE_IPIENT',
     'ITE_FREENT',
     'ITE_VALFRE',
     'ITE_ACRFIN',
     'ITE_SUBSTI',
     'ITE_DESADB',

     'ITE_TCIFCU',
     'ITE_TSCUST',
     'ITE_DEPICP',
     'ITE_DEICMS',
     'ITE_FATREG',

     'ITE_OUTVAL',
     'ITE_ICMSAI',
     'ITE_IMPFED',
     'ITE_DESOPE');


Type
  TDisplayRecPrecos = Array[1..19] Of String;


  TrecPrecos = Record
    fltPreCom,
    fltDesF01,
    fltDesF02,
    fltDesF03,
    fltDesF04,
    fltDesF05,
    fltDesF06,
    fltIcmEnt,
    fltSubFed,
    fltIpiEnt,
    fltFreEnt,
    fltValFre,
    fltAcrFin,
    fltSubsti,
    fltDesAdb,
    fltTcifcu,
    fltTscust,
    fltDepico,
    fltDeicms,
    fltFatReg,
    fltOutVal,
    fltIcmSai,
    fltImpFed,
    fltDesOpe,
    fltPreVen: Double;
  End;

  TTabelaPreco = Class(TZClient)
  Private
    FTabPreHeranca: TUniQuery;
    FCodTabHeranca: String;

    strCodForHeranca,
    strNomTabHeranca,

    FEmpOri,
    FEmpDes: String;

    FMarcados : TStringList;

    stlEmpresasPrecosMatriz: TStringList;
    stlListaItensDeletados: TStringList;
    strFiltroEmpresasPrecosMatriz,
    strEmpresasPrecosMatriz: String;

    cpcParams: TParCalculaPrecoCusto;

    FQuantidadeInicialRegistros,
    FQuantidadeAutIncDisponivel,
    FQuantidadeAutDetDisponivel: Integer;

    strAgrupadorPreAlt: String;


    intInfFed,
    intInfOpe,
    intInfSai: Integer;

    FAutTabDet,
    FNomArq : String;
    FCodTab,
    FCodFor : String;

    FEmpresas: TUniQuery;
    FTabDetEmpresas: TZClient;

    FPreFor,
    FMarcar,
    FAtualizaPrecos: Boolean;

    FNovPre: TZClient;
    FTipAtu: String;

    frmGravando: TfrmGravando;

    qryUpdateCadIte,
    qryUpdateIteger: TUniQuery;

    qryUpdFor: TUniQuery;
    qryUpdDet: TUniQuery;

    objIteBar: TIteBar;
    strFiltroOriginal: String;
    intRecNoOriginal: Integer;
    blnFilteredOriginal: Boolean;

    Function fAtualizaCadIte: Boolean;
    Function fSQLAtualizaCadIte: String;
    Procedure pAtualizaCadIteGeral(cxProgresso: TCxProgressBar);

    Function fSQLEmpresas: String;
    Function fSQLFiltroEmpresas: String;

    Function fSQLTabDet: String;
    function fRetInTabelas: String;


    Function fAtualizaCustosIteger: Boolean;
    function fVariantToFloat(AVariant: Variant): Double;

    function fRetPrecoCusto(dataSet: TDataSet; strNov: String = '';  fltIcmEnt: Double = -1; fltSubst: Double = -1; fltSubFed: Double = -1): Double;

    function fCalculaCustoReal(dataSet: TDataSet): Double;

    Function fSQLTabelaPreco: String;

    Function fFiltroUsaPrecoMatriz: String;

    Function fAtualizaDadosComunsITEFOR: String;
    Function fAtualizaDadosComunsTABDET: String;

    Procedure pFormataCamposITEFOR(cdsItens: TUniClientDataSet);

    Procedure pFormataCamposTABDET(cdsItens: TUniClientDataSet);

    Function fGravaHeranca(qryTabPre: TUniQuery; strCodTab: String; strCodFor, strNomTab: string): Boolean;
    function fMontaHeranca(cxProgressBar : TcxProgressBar) : Boolean;

    Procedure pCopiaTabelaHeranca(cdsDestino: TZClient; strSQL: String; cxProgressBar : TcxProgressBar);

    Procedure pCarregaDadosSugestaoItem(strCodIte: String);

    function fImportaTXTProgresso(pgbProgresso: TcxProgressBar): Boolean;
    function fIntToTipoLocalizacaoItem(int: integer): TTipoLocalizacaoItem;
    function fExisteItemCodBarCarregado(strCodBar: String;
      var strCodIte: String): Boolean;
    function fExisteItemCodFabCarregado(strCodFab: String;
      var strCodIte: String): Boolean;
    function fExisteIteBar(strCodBar: String; var strCodIte: String): Boolean;
    function fExisteItemCodBar(strCodBar: String;
      var strCodIte: String): Boolean;
    function fExisteItemCodFab(strCodFab, strCodFor: String;
      var strCodIte: String; blnBuscaPorRefere: Boolean): Boolean;
    function fExisteItemCodItemFornecedor(strCodItemF, strCodFor: String; var strCodIte: String; blnSoTabAti: Boolean = True): Boolean;
    procedure pCarregaDadosSugestaoHeranca(strCodIte, strCodEmp: String);
    function fSQLItensSelecao: String;
    function fCriaCdsInconsistencia: TUniClientDataSet;
    Procedure pRecalculaPrecosNovPre;

    Function fCarregaPrecosPrg(prgProgresso: TCXProgressBar): Boolean;
    Function fCarregaPrecos: Boolean;
    Function fSQLNovosPrecos: String;
    Function fSQLIteger: String;
    Function fMarcaTodosPrg(prgProgresso: TCXProgressBar): Boolean;
    Function fAtualizaPrecosItensPrg(prgProgresso: TCXProgressBar): Boolean;
    Procedure pAtualizaPrecoNovPre(qryIteger: TUniQuery; strEmpresas, strAgrupadorPreAlt: String; blnResFor: Boolean);

    Function fAtualizaAlteradosIteforPrg(prgProgresso: TCXProgressBar): Boolean;
    function fAjustaSeqGerTabDet: Boolean;

    Function fAjustaCodFabricaCodBarras(prgProgresso: TCXProgressBar): Boolean;

    Function fAtualizaAlteradosTabDetPrg(prgProgresso: TCXProgressBar): Boolean;

    Procedure pAtualizaDadosComunsIteFor;
    Procedure pAtualizaDadosComunsTabDet;

    Function fUpdateIteger(blnResFor: Boolean): String;

    Function fCarregaDicionariosPrg(prgProgre: TCxProgressBar): Boolean;

    Procedure pBeforePostNovPre(dataSet: TDataSet);

    Procedure pCarregaDicionarios;

    Function fRetAutoIncremDet: String;

    Function fSalvaItensProgresso(cxProgresso: TCxProgressBar): Boolean;
    Function fSalvaItensProgressoTabDet(cxProgresso: TCxProgressBar): Boolean;
    procedure pAtualizaAutoincremParaPrecus;

    function fSalvaClient(strTabela: String; Dados: TZClient): Boolean;

    Function fSalvaDetCus: Boolean;
    function fTrataFloatString(strValor: String): String;


    Function fSQLUpdateTabDet(blnResFor: Boolean): String;
    Function fAtualizaEmpresasTabDet(blnResFor: Boolean; cxProgresso: TCxProgressBar): Boolean;

    Procedure pAtualizaDisplayIteFor(dataSet: TDataSet);

    Procedure pAfterPostItefor(dataSet: TDataSet);

    Function fGeraTabDetEmpresas: Boolean;

    Procedure pAtualizaEmpresasUsamPrecoMatrizTabPrd;

    Function fUsaPrecoMatriz(strCodEmp: String): Boolean;

    function fMarcaTabDetProgresso(cxProgresso: TcxProgressbar): Boolean;

    Procedure pAlteraValor(strNomCam: String; fltValor: Double; Var blnAlterado: Boolean);
    Procedure pCopiaPrecos(Var recPrecos: TrecPrecos);
    Procedure pSetaPrecos(recPrecos: TrecPrecos; Var blnAlterado: Boolean);
    Function fCopiaPrecosProgresso(cxProgresso: TcxProgressbar): Boolean;

    Procedure pInicializaDisplayRecPrecos;

    Procedure pSetaSqlPrecosVenda(qryPreVen: TUniQuery; blnFiltraItem: Boolean);
    Procedure pFormataIteger(cdsItens: TZClient);
    Function fCarregaPrecosVenda(strCodTab: String): Boolean;
    Procedure pRecalculaPrecoVenda(opcMarPre: TopcMarPre);

    Procedure pSetaMasterPreVen;

  //  Function fUpdateItegerTabPrd: String;

    Function fSQLLeIteger: String;
    function fExisteItemCodIte(ACodIte: String; Var strCodIte: String): Boolean;

  Public
    intDecUni: Integer;
    cdsIteSel: TZClient;
    strCodForDef: String;
    blnInclusaoItem: Boolean;
    FIncIte,
    FIncDet: TZClient;

    blnSufram,
    blnInfMat: Boolean;
    strFrmCus: String;
    strTPABPC: String;
    intTipAbf: Integer;

    opcAlteraPreco: TopcAltPre;

    arrDisplayRecPrecos: TDisplayRecPrecos;

    blnTabPrD: Boolean;

    cdsPreVen: TZClient;
    cdsEmpresas,
    cdsTabDet: TZClient;
    blnIncluindoTabela : Boolean;

    stlCamposParaCopiar: TStringList;

    dicCodBar: TDicionario;
    dicCodFab: TDicionario;
    FopcMarPre : TopcMarPre;
    blnProcessoDeImportacao: Boolean;
    ImportacaoOpcMarPre : TopcMarPre;

    constructor Create(Owner: TComponent); Reintroduce;
    procedure RecreateCdsInsert;
    Destructor Destroy; override;
    procedure pFiltraItem(strCodEmp: String);
    procedure RestauraFiltro;

    Procedure pIniciaValores(cdsItens:TUniClientDataSet; var AcdsTabDet: TZclient; AstrCodIte: String = ''; AstrTabela: String = '');
    Procedure pCopiaDadosInsert(dtsItens: TDataSet; blnTestarChaves: Boolean);
    Procedure pCopiaDadosInsertTabDet(dtsItens: TDataSet; blnTestarChaves: Boolean);
    Procedure pCopiaDadosSelecao;

    function fImportaTXT(strNomArq, strCodFor: String): Boolean;

    Function fCopiaPrecos: Boolean;

    Function fMontaPrecosVenda(opcMarPre: TopcMarPre): Boolean;

    Function fOpcCalculo(dataSet: TDataSet): TopcMarPre;

    Function fExportaTabela(strCodTab,
                            strNomTab,
                            strCodFor,
                            strNomFor: String): Boolean;

    Procedure pAfterCancelTabDet(dataSet: TDataSet);
    Procedure pAfterPostTabDet(dataSet: TDataSet);
    Procedure pBeforePostTabDet(dataSet: TDataSet);
    procedure cdsIteSelAfterScroll(DataSet: TDataSet);
    procedure cdsIteSelBeforeDelete(DataSet: TDataSet);

    Function fAjustaAtivaCompras(qryTabela: TUniQuery; blnForcarDesmarcacao: Boolean = False): Boolean;
    Function fCarregaItens(strCodTab, strCodFor: String): Boolean;
    Function fSalvaItens(strCodTab, strCodFor: String): Boolean;
    Function fRetTabelaAtiva(strCodFor: String): String;
    Function fComparaPrecos: Boolean;
    Function fTemProdutoMarcado: Boolean;

    Procedure pExcluiItem;
    Procedure pCarregaItemAlteracao(strCodIte: String; blnBuscaPorChave: Boolean; dtsIteFor, dtsTabDet: TDataSource);
    Procedure pExcluiItemSelecao;
    Function fHerancaTabela(qryTabPre: TUniQuery; strCodFor, strNomTab: string): Boolean;

    Procedure pMarcaNovosPrecos;
    Procedure pMarcaTodos(blnMarcar: Boolean);
    Procedure pPostNovoPreco;

    Procedure pFiltraEmpresaCorrenteTabDet(blnFiltrar: Boolean; strCodEmp: String = '');

    Procedure pCalculaPrecoMargem(dataSet: TDataSet; fltComTbl: Double);

    Class Function fSQLUpdatePrecoRevistaGerencial: String;
    Class Function fRetTotalItensTabelaAtiva(strCodFor: String): Integer;
    Class Function fRetTotalItensTabela(strCodTab: String): Integer;
    Class Function fRetTotalItensPrincipal(strCodFor: String): Integer;
    Class Procedure pSQUpdatePrecoRevistaFilias(qryTabDet: TUniQuery; dtsTabGir: TDataSet);

    Procedure pSetaMasterTabDet(cdsTabDet: TZClient; dtsMaster: TDataSource);

    Procedure pLimpaMasterTabDet(cdsTabDet: TZClient);

    Procedure pMarcaTodosTabDet(blnMarcar: Boolean);
    Procedure pMarcaDesmarcaTabDet;
    Function fItemMarcadoTabDet(strCodIte: String): Boolean;

    Property stlMarcados: TStringList Read FMarcados;
    Property strEmpOri: String Read FEmpOri Write FEmpOri;
    Property strEmpDes: String Read FEmpDes Write FEmpDes;

  End;

implementation

Uses
  Math,
  StrUtils,
  untConstantes,
  untPreAlt,
  untGeraExcel,
  untTConfiguracao,
  untCadTabelaPrecosHeranca,
  untTabelaPrecoInconsistencia,
  untTypesSistema,
  untAtuCadProdutosIteFor, untCalculaComposicaoCusto, untTValidaExcel,
  untGeraExcelHtml,
  untTabelasDoItem;

Const
  ARR_CAMPOS_COMUNS : Array[0..16] Of String[20] = (
      'ITE_MLTVEN_ITEM',
      'ITE_DESITE',
      'ITE_CODITF',
      'ITE_UNICOM',
      'ITE_MLTCOM',
      'ITE_DIAFOR',
      'ITE_CLAIPI',
      'ITE_DESFAB',
      'ITE_CODFAB',
      'ITE_CNVCUS',
      'TFO_EMBALA',
      'TFO_BAREMB',
      'TFO_REFERE',
      'TFO_CODBAR',
      'TFO_SITPRO',
      'TFO_NOTESP',
      'TFO_PESOIT');

constructor TTabelaPreco.Create(Owner: TComponent);
Begin
  intRecNoOriginal := -1;
  blnProcessoDeImportacao := False;
  Inherited Create(Owner, fSQLTabelaPreco);
  If fCfgSis('FORCAL', varString) = 'P' Then
    FopcMarPre := opcPrecoVenda
  Else
    FopcMarPre := opcMargem;
  blnIncluindoTabela  := False;

  cdsPreVen := TZClient.Create(Self);

  objIteBar := TIteBar.Create(opcOperacoes);

  FMarcados := TStringList.Create;
  FMarcados.Sorted := True;

  cdsEmpresas := TZClient.Create(Self, fSQLFiltroEmpresas);
  cdsEmpresas.fLeDados('TTabelaPreco.Create');

  stlEmpresasPrecosMatriz := TStringList.Create;
  strEmpresasPrecosMatriz := fRetEmpresasUsamPrecoMatriz(stlEmpresasPrecosMatriz);
  strFiltroEmpresasPrecosMatriz := fFiltroUsaPrecoMatriz;

  FCodTabHeranca := '';

  blnTabPrD := fCfgSis('TABPRD', varBoolean);

  blnInfMat := fCfgSis('INFMAT', varBoolean);
  intTipAbf := fCfgSIs('TIPABF', varInteger);
  strTPABPC := fCfgSis('TPABPC');

  blnSufram := fCfgSis('SUFRAM', varBoolean);
  strFrmCus := fCfgSis('FRMCUS', varString);

  intInfFed := fCfgSis('INFFED', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);



  Self.IndexFieldNames := 'AUTOINCREM';
  Self.AfterPost       := pAfterPostItefor;

  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  FEmpresas := fCriaQuery(Self);
  FEmpresas.SQL.Text := fSQLEmpresas;

  FTabDetEmpresas := TZClient.Create(Self, fSQLTabDet);
  FTabDetEmpresas.IndexFieldNames := 'ITE_CODTAB;ITE_CODFOR;ITE_CODITE;ITE_CODEMP';

  cdsTabDet := TZClient.Create(Self, fSQLTabDet);
  pSetaMasterTabDet(cdsTabDet, Self.dtsSource);

  FAtualizaPrecos := False;

  intDecUni := fCfgSis('DECUNI', varInteger);

  cdsIteSel := TZClient.Create(Self);

  FIncIte := TZClient.Create(Self, fSQLTabelaPreco);
  FIncIte.fAbreClient(True, 'TTabelaPreco.Create');
  pFormataCamposITEFOR(FIncIte);

  FIncDet := TZClient.Create(Self, fSQLTabDet);
  FIncDet.fAbreClient(True, 'TTabelaPreco.Create');
  pFormataCamposTABDET(FIncDet);

  FIncDet.BeforePost := pBeforePostTabDet;

  FNovPre := TZClient.Create(Self, fSQLNovosPrecos);

  FTipAtu := fCfgSis('ATPVMB');
  FPreFor := fCfgSis('PREFOR', VarBoolean);

  qryUpdFor := fCriaQuery(Self);
  qryUpdFor.SQL.Text := fAtualizaDadosComunsITEFOR;

  qryUpdDet := fCriaQuery(Self);
  qryUpdDet.SQL.Text := fAtualizaDadosComunsTABDET;

  dicCodBar := TDicionario.Create;
  dicCodFab := TDicionario.Create;

  pInicializaDisplayRecPrecos;

  stlCamposParaCopiar := TStringList.Create;
  stlCamposParaCopiar.Sorted := True;
  stlListaItensDeletados := TStringList.Create;

  If blnTabPrD Then
  Begin
    qryUpdateIteger := fCriaQuery(Self);
    qryUpdateIteger.SQL.Text := fSQLLeIteger;

    qryUpdateCadIte := fCriaQuery(Self);
    qryUpdateCadIte.SQL.Text := fSQLAtualizaCadIte;
  End;
End;

Destructor TTabelaPreco.Destroy;
Begin
  FreeAndNil(dicCodBar);
  FreeAndNil(dicCodFab);
  FreeAndNil(stlEmpresasPrecosMatriz);

  FMarcados.Clear;
  FreeAndNil(FMarcados);

  FreeAndNil(stlCamposParaCopiar);

  If Assigned(stlListaItensDeletados) Then
    FreeAndNil(stlListaItensDeletados);

  Inherited;
End;

Procedure TTabelaPreco.pInicializaDisplayRecPrecos;
Begin
  arrDisplayRecPrecos[01] := 'Preço de Compra';
  arrDisplayRecPrecos[02] := 'Descontos de 1 a 6 (-)';
  arrDisplayRecPrecos[03] := 'ICMS Entrada (-)';
  arrDisplayRecPrecos[04] := 'Impostos Federais (-)';
  arrDisplayRecPrecos[05] := 'IPI Entrada (+)';
  arrDisplayRecPrecos[06] := 'Frete (+)';
  arrDisplayRecPrecos[07] := fCfgSis('DESVFR') + ' (+)';
  arrDisplayRecPrecos[08] := 'Acréscimo Financeiro (+)';
  arrDisplayRecPrecos[09] := 'Sub. Tributária (+)';
  arrDisplayRecPrecos[10] := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
  arrDisplayRecPrecos[11] := 'TCIF (+):';
  arrDisplayRecPrecos[12] := 'TS (+)';
  arrDisplayRecPrecos[13] := 'Desconto PIS/COFINS (-)';
  arrDisplayRecPrecos[14] := 'Desconto ICMS (-)';
  arrDisplayRecPrecos[15] := 'Fator Regional (+)';
  arrDisplayRecPrecos[16] := fCfgSis('DOVCPP') + ' (+)';
  arrDisplayRecPrecos[17] := 'ICMS Saída (+)';
  arrDisplayRecPrecos[18] := 'Impostos Federais (+)';
  arrDisplayRecPrecos[19] := 'Despesas Operacionais (+)';
End;

Function TTabelaPreco.fFiltroUsaPrecoMatriz: String;
Begin
  Result := '';

  If stlEmpresasPrecosMatriz.Count > 0 Then
    Result := Result + 'ITE_CODEMP IN (' + fCommaText(stlEmpresasPrecosMatriz, True) + ')';

  If Not Result.IsEmpty Then
    Result := ' (' + Result + ') ';
End;

Function TTabelaPreco.fSQLTabelaPreco: String;
Begin
  Result :=          'SELECT                        ';

  Result := Result + '  F.*,                         ';

  Result := Result + '  "N" AS ALTERADO,            ';
  Result := Result + '  "N" AS EXCLUIDO,            ';

  Result := Result + '  IFNULL(D.ITE_PRECOM, 0.0) AS PRECOM,     ';

  Result := Result + '  IFNULL(D.ITE_PRECOM,0.0) * ';
  Result := Result + '  ( 1 - (IFNULL(D.ITE_DESF01, 0.0) / 100) ) * ';
  Result := Result + '  ( 1 - (IFNULL(D.ITE_DESF02, 0.0) / 100) ) * ';
  Result := Result + '  ( 1 - (IFNULL(D.ITE_DESF03, 0.0) / 100) ) * ';
  Result := Result + '  ( 1 - (IFNULL(D.ITE_DESF04, 0.0) / 100) ) * ';
  Result := Result + '  ( 1 - (IFNULL(D.ITE_DESF05, 0.0) / 100) ) * ';
  Result := Result + '  ( 1 - (IFNULL(D.ITE_DESF06,0.0) / 100) ) AS COMLIQ, ';

  Result := Result + '  IFNULL(D.ITE_PRECUS,0.0) AS PRECUS,               ';

  Result := Result + '  C.ITE_DESITE, ';
  Result := Result + '  C.ITE_CODUNI, ';
  Result := Result + '  C.ITE_MLTVEN AS ITE_MLTVEN_ITEM, ';
  Result := Result + '  IF(C.ITE_CODFOR = :CODFOR, "SIM", "NÃO") AS PRINC, ';
  Result := Result + '  UNI_SIGUNI   AS ITE_SIGUNI,  ';
  Result := Result + '  C.ITE_REFERE   AS ITE_REFERE ';
  Result := Result + 'FROM                                                 ';
  Result := Result + '  ITEFOR F                                           ';
  Result := Result + '  INNER JOIN CADITE C ON C.ITE_CODITE = F.ITE_CODITE ';

  Result := Result + '  LEFT JOIN TABDET D ';
  Result := Result + '     ON D.ITE_CODITE = F.ITE_CODITE ';
  Result := Result + '    AND D.ITE_CODTAB = F.ITE_CODTAB ';
  Result := Result + '    AND D.ITE_CODFOR = F.ITE_CODFOR ';
  Result := Result + '    AND D.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Result := Result + '  LEFT  JOIN CADUNI   ON   UNI_CODUNI = C.ITE_CODUNI ';
  Result := Result + 'WHERE                                                ';
  Result := Result + '  F.ITE_CODTAB = :CODTAB                         ';
End;

Function TTabelaPreco.fSQLTabDet: String;
Begin
  Result :=          'SELECT                        ';
  Result := Result + '  D.AUTOINCREM,';
  Result := Result + '  D.ITE_CODITE,';
  Result := Result + '  D.ITE_CODEMP,';
  Result := Result + '  D.ITE_DESF01,';
  Result := Result + '  D.ITE_DESF02,';
  Result := Result + '  D.ITE_DESF03,';
  Result := Result + '  D.ITE_DESF04,';
  Result := Result + '  D.ITE_DESF05,';
  Result := Result + '  D.ITE_DESF06,';
  Result := Result + '  D.ITE_PRECOM,';
  Result := Result + '  D.ITE_ICMENT,';
  Result := Result + '  D.ITE_IPIENT,';
  Result := Result + '  D.ITE_FREENT,';
  Result := Result + '  D.ITE_VALFRE,';
  Result := Result + '  D.ITE_ACRFIN,';
  Result := Result + '  D.ITE_SUBSTI,';
  Result := Result + '  D.ITE_DESADB,';
  Result := Result + '  D.ITE_PRECUS,';
  Result := Result + '  D.ITE_IMPFED,';
  Result := Result + '  D.ITE_SUBFED,';
  If blnTabPrD Then
  Begin


    Result := Result + '  IF(DC.DET_TABELA = 1 AND ITE_TABPR1 = D.ITE_CODTAB, ITE_PREVE1 * IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS),';
    Result := Result + '  IF(DC.DET_TABELA = 2 AND ITE_TABPR2 = D.ITE_CODTAB, ITE_PREVE2 * IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS),';
    Result := Result + '  IF(DC.DET_TABELA = 3 AND ITE_TABPR3 = D.ITE_CODTAB, ITE_PREVE3 * IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS),';
    Result := Result + '  IF(DC.DET_TABELA = 4 AND ITE_TABPR4 = D.ITE_CODTAB, ITE_PREVE4 * IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS),';
    Result := Result + '  IF(DC.DET_TABELA = 5 AND ITE_TABPR5 = D.ITE_CODTAB, ITE_PREVE5 * IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS),';
    Result := Result + '  IF(DC.DET_TABELA = 6 AND ITE_TABPR6 = D.ITE_CODTAB, ITE_PREVE6 * IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS),';
    Result := Result + '  IF(DC.DET_TABELA = 7 AND ITE_TABPR7 = D.ITE_CODTAB, ITE_PREVE7 * IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS), DC.DET_PREVEN))))))) AS ITE_PREVEN,';

    Result := Result + '  IF(DC.DET_TABELA = 1 AND ITE_TABPR1 = D.ITE_CODTAB, ITE_MARBR1,  ';
    Result := Result + '  IF(DC.DET_TABELA = 2 AND ITE_TABPR2 = D.ITE_CODTAB, ITE_MARBR2,';
    Result := Result + '  IF(DC.DET_TABELA = 3 AND ITE_TABPR3 = D.ITE_CODTAB, ITE_MARBR3,';
    Result := Result + '  IF(DC.DET_TABELA = 4 AND ITE_TABPR4 = D.ITE_CODTAB, ITE_MARBR4,';
    Result := Result + '  IF(DC.DET_TABELA = 5 AND ITE_TABPR5 = D.ITE_CODTAB, ITE_MARBR5,';
    Result := Result + '  IF(DC.DET_TABELA = 6 AND ITE_TABPR6 = D.ITE_CODTAB, ITE_MARBR6,';
    Result := Result + '  IF(DC.DET_TABELA = 7 AND ITE_TABPR7 = D.ITE_CODTAB, ITE_MARBR7, DC.DET_MARBRU))))))) AS ITE_MARBRU,';

    Result := Result + '  DC.DET_OUTVAL AS ITE_OUTVAL,';
    Result := Result + '  DC.DET_ICMSAI AS ITE_ICMSAI,';
    Result := Result + '  DC.DET_DESOPE AS ITE_DESOPE,';
    Result := Result + '  D.ITE_MARBRU AS ITE_MARGIR,';
    Result := Result + '  D.ITE_PREVEN AS ITE_VENGIR,';



  End
  Else
  Begin
    Result := Result + '  D.ITE_OUTVAL,';
    Result := Result + '  D.ITE_ICMSAI,';
    Result := Result + '  D.ITE_DESOPE,';
    Result := Result + '  ITE_MARBRU,';
    Result := Result + '  ITE_PREVEN,';
  End;

  Result := Result + '  D.ITE_CODABF,';
  Result := Result + '  D.ITE_DESGER,';
  Result := Result + '  D.ITE_PROGER,';
  Result := Result + '  D.ITE_ABFIPI,';
  Result := Result + '  D.ITE_ABFCOF,';
  Result := Result + '  D.ITE_ABFPIS,';

  Result := Result + '  D.ITE_PREREV,';
  Result := Result + '  D.ITE_MARFEC,';
  Result := Result + '  D.ITE_CODTAB,';
  Result := Result + '  D.ITE_TCIFCU,';
  Result := Result + '  D.ITE_TSCUST,';
  Result := Result + '  D.ITE_DEPICO,';
  Result := Result + '  D.ITE_DEICMS,';
  Result := Result + '  D.ITE_FATREG,';
  Result := Result + '  D.ITE_EXCIPI,';
  Result := Result + '  D.ITE_PREDOL,';
  Result := Result + '  D.ITE_CODFOR,';
  Result := Result + '  D.ITE_COMTBL,';
  Result := Result + '  D.ITE_SEQGER,';
  Result := Result + '  ITE_PROCESSADO,';

  Result := Result + '  "N" AS ALTERADO,            ';
  Result := Result + '  "N" AS EXCLUIDO,             ';


  If blnTabPrD Then
  Begin

    Result := Result + '  D.ITE_PRECOM /IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS CNV_PRECOM,  ';
    Result := Result + '  C.ITE_INCPIS, ';
    Result := Result + '  IF(DC.DET_TABELA = 1 AND ITE_TABPR1 = D.ITE_CODTAB, 1,  ';
    Result := Result + '  IF(DC.DET_TABELA = 2 AND ITE_TABPR2 = D.ITE_CODTAB, 1,';
    Result := Result + '  IF(DC.DET_TABELA = 3 AND ITE_TABPR3 = D.ITE_CODTAB, 1,';
    Result := Result + '  IF(DC.DET_TABELA = 4 AND ITE_TABPR4 = D.ITE_CODTAB, 1,';
    Result := Result + '  IF(DC.DET_TABELA = 5 AND ITE_TABPR5 = D.ITE_CODTAB, 1,';
    Result := Result + '  IF(DC.DET_TABELA = 6 AND ITE_TABPR6 = D.ITE_CODTAB, 1,';
    Result := Result + '  IF(DC.DET_TABELA = 7 AND ITE_TABPR7 = D.ITE_CODTAB, 1, 0))))))) AS CUSATI,';

    Result := Result + '  IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS ITE_CNVCUS, ';


    Result := Result + '  IF(DC.DET_TABELA = 1 AND ITE_TABPR1 = D.ITE_CODTAB, ITE_PREVE1,';
    Result := Result + '  IF(DC.DET_TABELA = 2 AND ITE_TABPR2 = D.ITE_CODTAB, ITE_PREVE2,';
    Result := Result + '  IF(DC.DET_TABELA = 3 AND ITE_TABPR3 = D.ITE_CODTAB, ITE_PREVE3,';
    Result := Result + '  IF(DC.DET_TABELA = 4 AND ITE_TABPR4 = D.ITE_CODTAB, ITE_PREVE4,';
    Result := Result + '  IF(DC.DET_TABELA = 5 AND ITE_TABPR5 = D.ITE_CODTAB, ITE_PREVE5,';
    Result := Result + '  IF(DC.DET_TABELA = 6 AND ITE_TABPR6 = D.ITE_CODTAB, ITE_PREVE6,';
    Result := Result + '  IF(DC.DET_TABELA = 7 AND ITE_TABPR7 = D.ITE_CODTAB, ITE_PREVE7, DC.DET_PREVEN/IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS)))))))) AS CNV_PREVEN,';

    Result := Result + '  DC.DET_OUTVAL/IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS CNV_OUTVAL,';
    Result := Result + '  D.ITE_PREVEN/IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS CNV_VENGIR,';

    Result := Result + '  (D.ITE_PRECUS + IFNULL(DC.DET_OUTVAL, 0)) / ';
    Result := Result + '   (1 - (IFNULL(DC.DET_ICMSAI, 0) + IFNULL(D.ITE_IMPFED, 0) + IFNULL(DC.DET_DESOPE, 0)) / 100)/IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS CNV_CUSREA, ';

    Result := Result + '  D.ITE_PRECUS/IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS CNV_PRECUS, ';
    Result := Result + '  D.ITE_VALFRE/IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS CNV_VALFRE, ';

    Result := Result + '  D.ITE_PRECOM * ';
    Result := Result + '  ( 1 - (D.ITE_DESF01 / 100) ) * ';
    Result := Result + '  ( 1 - (D.ITE_DESF02 / 100) ) * ';
    Result := Result + '  ( 1 - (D.ITE_DESF03 / 100) ) * ';
    Result := Result + '  ( 1 - (D.ITE_DESF04 / 100) ) * ';
    Result := Result + '  ( 1 - (D.ITE_DESF05 / 100) ) * ';
    Result := Result + '  ( 1 - (D.ITE_DESF06 / 100) )/IF(IFNULL(F.ITE_CNVCUS, 0) <= 0, 1, F.ITE_CNVCUS) AS CNV_COMLIQ, ';

  End;

  Result := Result + '  0.0000 AS ITE_VENDOL ,';

  If blnTabPrD Then
    Result := Result + '  DC.DET_TABELA AS TABELA, ';

  Result := Result + '  D.ITE_PRECOM * ';
  Result := Result + '  ( 1 - (D.ITE_DESF01 / 100) ) * ';
  Result := Result + '  ( 1 - (D.ITE_DESF02 / 100) ) * ';
  Result := Result + '  ( 1 - (D.ITE_DESF03 / 100) ) * ';
  Result := Result + '  ( 1 - (D.ITE_DESF04 / 100) ) * ';
  Result := Result + '  ( 1 - (D.ITE_DESF05 / 100) ) * ';
  Result := Result + '  ( 1 - (D.ITE_DESF06 / 100) ) AS ITE_COMLIQ, ';

  If Not blnTabPrD Then
  Begin
    Result := Result + '  (D.ITE_PRECUS + IFNULL(D.ITE_OUTVAL, 0)) / ';
    Result := Result + '   (1 - (IFNULL(D.ITE_ICMSAI, 0) + IFNULL(D.ITE_IMPFED, 0) + IFNULL(D.ITE_DESOPE, 0)) / 100) AS ITE_CUSREA, ';
  End
  Else
  Begin
    Result := Result + '  (D.ITE_PRECUS + IFNULL(DC.DET_OUTVAL, 0)) / ';
    Result := Result + '   (1 - (IFNULL(DC.DET_ICMSAI, 0) + IFNULL(D.ITE_IMPFED, 0) + IFNULL(DC.DET_DESOPE, 0)) / 100) AS ITE_CUSREA, ';
  End;
  Result := Result + '  IF(D.ITE_PREREV > 0, ((D.ITE_PREREV - D.ITE_PREVEN) / D.ITE_PREREV) * 100, 0) AS ITE_DESREV, ';

  Result := Result + '  IF(D.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', ';
  Result := Result + '       (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "CFG_FORCAL" AND SIS_CODEMP = D.ITE_CODEMP), "M") AS FORCAL ';

  Result := Result + 'FROM                                                 ';
  If Not blnTabPrD Then
    Result := Result + '  TABDET D                                           '
  Else
  begin
    Result := Result + '  DETCUS DC';
    Result := Result + '  INNER JOIN TABDET D ON D.AUTOINCREM = DC.DET_SEQDET ';
    Result := Result + '  INNER JOIN CADITE C ON C.ITE_CODITE = D.ITE_CODITE ';
    Result := Result + '  INNER JOIN ITEFOR F ON F.AUTOINCREM = D.ITE_SEQGER ';
    Result := Result + '  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = D.ITE_CODITE  ';
    Result := Result + '                  AND ITEGER.ITE_CODEMP = D.ITE_CODEMP  ';
  End;
  Result := Result + ' WHERE                                                ';
  Result := Result + '      D.ITE_CODTAB = :CODTAB                         ';

  If blnTabPrD Then
    Result := Result + '  AND DC.DET_TABELA IN (' + fRetInTabelas + ')';

  If Not blnTabPrD Then
    Result := Result + '  AND D.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
End;

function TTabelaPreco.fRetInTabelas: String;
var i: integer;
Begin
  Result := '-1';
  For i := 1 To 7 do
  Begin
    If VS_strTabPrc[i] = 'S' Then
      Result := Result + ',' + i.ToString;

  End;
End;


Procedure TTabelaPreco.pSetaMasterTabDet(cdsTabDet: TZClient; dtsMaster: TDataSource);
Begin
  cdsTabDet.IndexFieldNames := 'ITE_CODITE';
  cdsTabDet.MasterSource    := dtsMaster;
  cdsTabDet.MasterFields    := 'ITE_CODITE';
End;

Procedure TTabelaPreco.pLimpaMasterTabDet(cdsTabDet: TZClient);
Begin
  cdsTabDet.MasterSource    := Nil;
  cdsTabDet.MasterFields    := '';
  cdsTabDet.IndexFieldNames := 'ITE_CODTAB;ITE_CODFOR;ITE_CODITE;ITE_CODEMP';
End;

Procedure TTabelaPreco.pFiltraEmpresaCorrenteTabDet(blnFiltrar: Boolean; strCodEmp: String = '');
Begin
  If blnFiltrar Then
    If strCodEmp.IsEmpty Then
      cdsTabDet.Filter := 'ITE_CODEMP = ' + QuotedStr(VS_strCodEmp)
    Else
      cdsTabDet.Filter := 'ITE_CODEMP = ' + QuotedStr(strCodEmp);

  cdsTabDet.Filtered := blnFiltrar;
End;

procedure TTabelaPreco.pFiltraItem(strCodEmp: String);
  var
    strCoditeSel: String;
begin
  strCoditeSel := cdsTabDet.FieldByName('ITE_CODITE').AsString;
  intRecNoOriginal := cdsTabDet.RecNo;
  strFiltroOriginal := cdsTabDet.Filter;
  blnFilteredOriginal := cdsTabDet.Filtered;
  cdsTabDet.Filtered := False;
  If strFiltroOriginal = '' Then
  begin
    If fEmptyStr(strCodEmp) Then
      cdsTabDet.Filter := 'ITE_CODEMP = ' + QuotedStr(VS_strCodEmp)
    Else
      cdsTabDet.Filter := 'ITE_CODEMP = ' + QuotedStr(strCodEmp);
  End;

  cdsTabDet.Filter := cdsTabDet.Filter + ' AND ITE_CODITE = ' + QuotedStr(strCoditeSel);

  cdsTabDet.Filtered := True;
end;

procedure TTabelaPreco.RecreateCdsInsert;
begin
  If Assigned(FIncDet) Then
    FreeAndNil(FIncDet);
  FIncDet := TZClient.Create(Self, fSQLTabDet);
  FIncDet.fAbreClient(True, 'TTabelaPreco.Create');
  pFormataCamposTABDET(FIncDet);

end;

procedure TTabelaPreco.RestauraFiltro;
begin
  cdsTabDet.Filtered := False;
  cdsTabDet.Filter := strFiltroOriginal;
  cdsTabDet.Filtered := blnFilteredOriginal;
  If intRecNoOriginal > 0 Then
    cdsTabDet.RecNo := intRecNoOriginal;
End;

Procedure TTabelaPreco.pFormataCamposITEFOR(cdsItens: TUniClientDataSet);
Begin
  With cdsItens Do
  Begin
    TFloatField(FieldByName('PRECOM')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('PRECUS')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('COMLIQ')).DisplayFormat := fMskDigitos(intDecUni);

    TFloatField(FieldByName('TFO_EMBALA')).DisplayFormat := fMskDigitos(DEC_EMBALAGEM);
    TFloatField(FieldByName('TFO_PESOIT')).DisplayFormat := fMskDigitos(fCfgSis('DECBRU', varInteger));
    TFloatField(FieldByName('ITE_CNVCUS')).DisplayFormat := '#,##0.0000';
  End;
End;

Procedure TTabelaPreco.pFormataCamposTABDET(cdsItens: TUniClientDataSet);
Begin
  With cdsItens Do
  Begin
    TFloatField(FieldByName('ITE_PRECOM')).DisplayFormat := fMskDigitos(intDecUni);
    If blnTabPrd Then
    Begin
      TFloatField(FieldByName('CNV_PRECOM')).DisplayFormat := fMskDigitos(intDecUni);
      TFloatField(FieldByName('CNV_VALFRE')).DisplayFormat := fMskDigitos(intDecUni);
      TFloatField(FieldByName('CNV_COMLIQ')).DisplayFormat := fMskDigitos(intDecUni);
      TFloatField(FieldByName('CNV_PRECUS')).DisplayFormat := fMskDigitos(intDecUni);
      TFloatField(FieldByName('CNV_OUTVAL')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('CNV_CUSREA')).DisplayFormat := fMskDigitos(intDecUni);
      TFloatField(FieldByName('CNV_PREVEN')).DisplayFormat := fMskDigitos(intDecUni);
      TFloatField(FieldByName('CNV_VENGIR')).DisplayFormat := fMskDigitos(intDecUni);
    End;
    TFloatField(FieldByName('ITE_DESF01')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESF02')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESF03')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESF04')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESF05')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESF06')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_COMLIQ')).DisplayFormat := fMskDigitos(intDecUni);

    TFloatField(FieldByName('ITE_ICMENT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_SUBFED')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_IPIENT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_FREENT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_VALFRE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_ACRFIN')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_SUBSTI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESADB')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PRECUS')).DisplayFormat := fMskDigitos(intDecUni);

    TFloatField(FieldByName('ITE_OUTVAL')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('ITE_ICMSAI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_IMPFED')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESOPE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_TCIFCU')).DisplayFormat := '#,##0.000000';
    TFloatField(FieldByName('ITE_TSCUST')).DisplayFormat := '#,##0.000000';
    TFloatField(FieldByName('ITE_DEPICO')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DEICMS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_FATREG')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_CUSREA')).DisplayFormat := fMskDigitos(intDecUni);

    TFloatField(FieldByName('ITE_MARBRU')).DisplayFormat := fMskDigitos(2);
    TFloatField(FieldByName('ITE_COMTBL')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVEN')).DisplayFormat := fMskDigitos(intDecUni);

    TFloatField(FieldByName('ITE_PREREV')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_DESREV')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARFEC')).DisplayFormat := '#,##0.00';
  End;
End;

Function TTabelaPreco.fCarregaItens(strCodTab, strCodFor: String): Boolean;
Begin
  Try
    qryQuery.ParamByName('CODTAB').AsString := strCodTab;
    qryQuery.ParamByName('CODFOR').AsString := strCodFor;
    FCodFor := strCodFor;
    cdsTabDet.qryQuery.ParamByName('CODTAB').AsString := strCodTab;

    Result := fLeDados('TTabelaPreco.fCarregaItens', True, 'Carrgando dados...') And
              cdsTabDet.fLeDados('TTabelaPreco.fCarregaItens', True, 'Carrgando dados por empresa...');

    If Result And blnTabPrD Then
      Result := fCarregaPrecosVenda(strCodTab);

    If Result Then
    Begin
      FQuantidadeInicialRegistros := Self.RecordCount;

      pFormataCamposITEFOR(Self);

      pFormataCamposTABDET(cdsTabDet);

      pAlinhaCampoCentro('ITE_PREDOL');

      pCarregaDicionarios;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelaPreco.fCarregaItens]');
    End;
  End;
End;

Function TTabelaPreco.fSQLFiltroEmpresas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   EMP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   CONCAT(EMP_CODEMP, " - ", EMP_NOMEMP) AS NOMEMP ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADEMP ';

  Result := strSQL;
End;


Function TTabelaPreco.fSQLEmpresas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   EMP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "PADPIS") AS PADPIS, ';
  strSQL := strSQL + '   (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "PADCOF") AS PADCOF  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADEMP ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   EMP_CODEMP <> ' + QuotedStr(VS_strCodEmp);

  Result := strSQL;
End;

Function TTabelaPreco.fGeraTabDetEmpresas: Boolean;
  Var
    intContador: Integer;
Begin
  FEmpresas.First;

  While Not FEmpresas.Eof Do
  Begin
    FTabDetEmpresas.Append;

    For intContador := 0 To FTabDetEmpresas.Fields.Count - 1 Do
      FTabDetEmpresas.Fields[intContador].Value := cdsTabDet.FieldByName(FTabDetEmpresas.Fields[intContador].FieldName).Value;

    FTabDetEmpresas.FieldByName('ITE_CODEMP').AsString := FEmpresas.FieldByName('CODEMP').AsString;

    FTabDetEmpresas.FieldByName('AUTOINCREM').AsString := fRetAutoIncremDet;

    If not fEmptyStr(FEmpresas.FieldByName('PADPIS').AsString) Then
      FTabDetEmpresas.FieldByName('ITE_ABFPIS').AsString := FEmpresas.FieldByName('PADPIS').AsString
    Else If fEmptyStr(FTabDetEmpresas.FieldByName('ITE_ABFPIS').AsString) Then
      FTabDetEmpresas.FieldByName('ITE_ABFPIS').Clear;

    If not fEmptyStr(FEmpresas.FieldByName('PADCOF').AsString) Then
      FTabDetEmpresas.FieldByName('ITE_ABFCOF').AsString := FEmpresas.FieldByName('PADCOF').AsString
    Else If fEmptyStr(FTabDetEmpresas.FieldByName('ITE_ABFCOF').AsString) Then
      FTabDetEmpresas.FieldByName('ITE_ABFCOF').Clear;

    FTabDetEmpresas.Post;

    FEmpresas.Next;
  End;

  Result := True;
End;

function TTabelaPreco.fSalvaClient(strTabela: String; Dados: TZClient): Boolean;
var qryComand: TUniQuery;
    strFields, strParams: string;
    i: integer;
begin
  If blnTabPrd Then
  Begin
    Try
      qryComand := fCriaQuery;
      Try
        strFields := '';
        strParams := '';

        For i := 0 To Dados.Fields.Count -1 do
        begin
          If (Dados.Fields[i].FieldName = 'ALTERADO') Then
            Break;

          If (Dados.Fields[i].FieldName = 'ITE_PREVEN') Or
             (Dados.Fields[i].FieldName = 'ITE_MARBRU') Then
           continue;

          If (Dados.Fields[i].FieldName = 'ITE_MARGIR') Then
          begin
            strFields := strFields + IIF(strFields<> '', ',' ,'') + 'ITE_MARBRU' ;
            strParams := strParams + IIF(strParams<> '', ',' ,'') + ':ITE_MARBRU';
          End
          Else If (Dados.Fields[i].FieldName = 'ITE_VENGIR') Then
          Begin
            strFields := strFields + IIF(strFields<> '', ',' ,'') + 'ITE_PREVEN' ;
            strParams := strParams + IIF(strParams<> '', ',' ,'') + ':ITE_PREVEN';
          End
          Else
          Begin
            strFields := strFields + IIF(strFields<> '', ',' ,'') +  Dados.Fields[i].FieldName;
            strParams := strParams + IIF(strParams<> '', ',' ,'') + ':'+ Dados.Fields[i].FieldName;
          End;
        End;

        qryComand.SQL.Add('REPLACE INTO '+strTabela+'(' + strFields + ') VALUES (' +strParams + ');');

        Dados.First;
        While not Dados.Eof Do
        Begin
          For i := 0 To Dados.Fields.Count -1 do
          Begin
            If Dados.Fields[i].FieldName = 'ALTERADO' Then
              Break;
            If (Dados.Fields[i].FieldName = 'ITE_MARGIR') Then
              qryComand.ParamByName('ITE_MARBRU').Value := Dados.FieldByName('ITE_MARGIR').Value
            Else If (Dados.Fields[i].FieldName = 'ITE_VENGIR') Then
              qryComand.ParamByName('ITE_PREVEN').Value := Dados.FieldByName('ITE_VENGIR').Value
            Else
            qryComand.ParamByName(Dados.Fields[i].FieldName).Value := Dados.Fields[i].Value;
          End;
          qryComand.ExecSQL;
          Dados.Next;
        End;
        Result := True;
      Finally
        FreeAndNil(qryComand);
      End;
    Except
      on e: Exception do
      Begin
        raise e;
      End;
    End;
  End
  Else
  Begin
    Try
       qryComand := fCriaQuery;
       Try
         strFields := '';
         strParams := '';

         For i := 0 To Dados.Fields.Count -1 do
         begin
           If Dados.Fields[i].FieldName = 'ALTERADO' Then
             Break;

           strFields := strFields + IIF(strFields<> '', ',' ,'') +  Dados.Fields[i].FieldName;
           strParams := strParams + IIF(strParams<> '', ',' ,'') + ':'+ Dados.Fields[i].FieldName;
         End;
         qryComand.SQL.Add('REPLACE INTO '+strTabela+'(' + strFields + ') VALUES (' +strParams + ');');

         Dados.First;
         While not Dados.Eof Do
         Begin
           For i := 0 To Dados.Fields.Count -1 do
           Begin
             If Dados.Fields[i].FieldName = 'ALTERADO' Then
               Break;
             qryComand.ParamByName(Dados.Fields[i].FieldName).Value := Dados.Fields[i].Value;
           End;
           qryComand.ExecSQL;
           Dados.Next;
         End;
         Result := True;
       Finally
         FreeAndNil(qryComand);
       End;
    Except
      on e: Exception do
      Begin
        raise e;
      End;
    End;
  End;
end;

Function TTabelaPreco.fSalvaItens(strCodTab, strCodFor: String): Boolean;
Begin
  FCodTab := strCodTab;
  FCodFor := strCodFor;

  Result := TfrmGravando.fExecuta(fSalvaItensProgresso, frmGravando, 'Salvando dados, aguarde...');

  If Result Then
    FCodTabHeranca := '';
End;

Function TTabelaPreco.fRetAutoIncremDet: String;
Begin
  If FQuantidadeAutDetDisponivel > 0 Then
  Begin
    Result := FAutTabDet;
    Dec(FQuantidadeAutDetDisponivel);
    FAutTabDet := fNextAutoIncrem(FAutTabDet)
  End

  Else Result := fRetAutoIncrem('TABDET', VS_strCodEmp);
End;

Function TTabelaPreco.fSalvaItensProgresso(cxProgresso: TCxProgressBar): Boolean;
  Var
    strAutIteFor: String;
Begin
  Try
    DisableControls;

    pLimpaMasterTabDet(cdsTabDet);
    pFiltraEmpresaCorrenteTabDet(False);

    If Not FEmpresas.Active Then
      FEmpresas.Open;

    FQuantidadeAutIncDisponivel := Self.RecordCount - FQuantidadeInicialRegistros;

    If FQuantidadeAutIncDisponivel <= 0 Then
      FQuantidadeAutIncDisponivel := 1;

    strAutIteFor := fRetAutoIncrem('ITEFOR', VS_strCodEmp, FQuantidadeAutIncDisponivel);

    FQuantidadeAutDetDisponivel := FQuantidadeAutIncDisponivel * (FEmpresas.RecordCount + 1);

    FAutTabDet := fRetAutoIncrem('TABDET', VS_strCodEmp, FQuantidadeAutDetDisponivel);

    Filter   := 'AUTOINCREM IS NULL';
    Filtered := True;

    cxProgresso.Properties.Max := RecordCount;
    cxProgresso.Position := 0;

    First;

    While Not Eof Do
    Begin
      Edit;

      If FQuantidadeAutIncDisponivel > 0 Then
      Begin
        FieldByName('AUTOINCREM').AsString := strAutIteFor;
        Dec(FQuantidadeAutIncDisponivel);
        strAutIteFor := fNextAutoIncrem(strAutIteFor)
      End

      Else FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITEFOR', VS_strCodEmp);

      If fEmptyStr(FieldByName('TFO_SITPRO').AsString) Then
        FieldByName('TFO_SITPRO').Clear;


      FieldByName('ITE_CODFOR').AsString := FCodFor;
      FieldByName('ITE_CODTAB').AsString := FCodTab;
      FieldByName('ITE_CODEMP').AsString := VS_strCodEmp;
      Post;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Filtered := False;

    Result := fSalva;

    If Result And blnTabPrD Then
      pAtualizaCadIteGeral(cxProgresso);

    Result := Result And
              fSalvaItensProgressoTabDet(cxProgresso);

    Result := Result And // ATUALIZA DADOS COMUNS ITEFOR
              fAtualizaAlteradosIteforPrg(cxProgresso);

    Result := Result And // ATUALIZA DADOS COMUNS TABDET
              fAtualizaAlteradosTabDetPrg(cxProgresso);

    If Result And FAtualizaPrecos Then  // VE SE ATUALIZA PREÇOS QUANDO NÃO USA TABPRD
      Result := fAtualizaPrecosItensPrg(cxProgresso);

    Result := Result and fAjustaSeqGerTabDet;

    Result := Result And fAjustaCodFabricaCodBarras(cxProgresso);

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TTabelaPreco.fSalvaItens]');
    End;
  End;

  Try
    Filter   := '';
    Filtered := False;

    cdsTabDet.AfterPost  := pAfterPostTabDet;
    cdsTabDet.BeforePost := pBeforePostTabDet;

    pSetaMasterTabDet(cdsTabDet, Self.dtsSource);
    pFiltraEmpresaCorrenteTabDet(True);
  Except
    On E : Exception Do
    Begin
      pMensagensErro(e.Message, '[TTabelaPreco.fSalvaItens]');
    End;
  End;

  EnableControls;
End;

function TTabelaPreco.fAjustaSeqGerTabDet: Boolean;
var qryComand: TUniQuery;
Begin
  Result := True;
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('UPDATE TABDET D');
    qryComand.SQL.Add(' INNER JOIN ITEFOR F ON F.ITE_CODTAB = D.ITE_CODTAB AND F.ITE_CODITE = D.ITE_CODITE AND F.ITE_CODFOR = D.ITE_CODFOR');
    qryComand.SQL.Add('   SET D.ITE_SEQGER =  F.AUTOINCREM');
    qryComand.SQL.Add(' WHERE D.ITE_SEQGER IS NULL');

    qryComand.ExecSQL;
  finally
    FreeAndNil(qryComand);
  End;
end;

Function TTabelaPreco.fAtualizaAlteradosIteforPrg(prgProgresso: TCXProgressBar): Boolean;
Begin
  Try

    Self.Filter   := 'ALTERADO = ' + QuotedStr('S');
    Self.Filtered := True;

    frmGravando.lblGravando.Caption := 'Atualizando dados comuns a outras tabelas, aguarde...';
    prgProgresso.Properties.Max := Self.RecordCount;
    prgProgresso.Position := 0;

    Self.DisableControls;

    Self.First;

    Result := True;

    While Not Self.Eof Do
    Begin
      pAtualizaDadosComunsItefor;

      Self.Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TTabelaPreco.fAtualizaAlteradosIteforPrg]');
    End;
  End;

  Self.Filtered := False;
  Self.EnableControls;
End;

Function TTabelaPreco.fAtualizaAlteradosTabDetPrg(prgProgresso: TCXProgressBar): Boolean;
Begin
  Try

    cdsTabDet.Filter   := 'ALTERADO = ' + QuotedStr('S');
    cdsTabDet.Filtered := True;

    frmGravando.lblGravando.Caption := 'Atualizando dados comuns a outras tabelas por empresa, aguarde...';
    prgProgresso.Properties.Max := cdsTabDet.RecordCount;
    prgProgresso.Position := 0;



    If blnTabPrD And (Not cdsTabDet.IsEmpty) Then
      pPreAltDefineVariaveisAltPre(fNow, 'TABELA PREÇOS FORNECEDOR', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    cdsTabDet.First;

    Result := True;

    While Not cdsTabDet.Eof Do
    Begin
      Self.Locate('ITE_CODITE', cdsTabDet.FieldByName('ITE_CODITE').AsString, []);
      pAtualizaDadosComunsTabDet;

      If blnTabPrD Then
        fAtualizaCustosIteger;

      cdsTabDet.Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TTabelaPreco.fAtualizaAlteradosTabDetPrg]');
    End;
  End;

  cdsTabDet.Filtered := False;

End;

function TTabelaPreco.fRetPrecoCusto(dataSet: TDataSet; strNov: String = '';  fltIcmEnt: Double = -1; fltSubst: Double = -1; fltSubFed: Double = -1): Double;
  Var
    blnUtilizarConversorDeMoeda: Boolean;
begin
  If fltIcmEnt = -1 Then
    fltIcmEnt := dataSet.FieldByName('ITE_ICMENT' + strNov).AsFloat;

  If fltSubst = -1 Then
    fltSubst := dataSet.FieldByName('ITE_SUBSTI' + strNov).AsFloat;

  If fltSubFed = -1 Then
    fltSubFed := dataSet.FieldByName('ITE_SUBFED' + strNov).AsFloat;

  cpcParams.curPreCom := dataSet.FieldByName('ITE_PRECOM' + strNov).AsFloat;
  cpcParams.curDesF01 := dataSet.FieldByName('ITE_DESF01' + strNov).AsFloat;
  cpcParams.curDesF02 := dataSet.FieldByName('ITE_DESF02' + strNov).AsFloat;
  cpcParams.curDesF03 := dataSet.FieldByName('ITE_DESF03' + strNov).AsFloat;
  cpcParams.curDesF04 := dataSet.FieldByName('ITE_DESF04' + strNov).AsFloat;
  cpcParams.curDesF05 := dataSet.FieldByName('ITE_DESF05' + strNov).AsFloat;
  cpcParams.curDesF06 := dataSet.FieldByName('ITE_DESF06' + strNov).AsFloat;
  cpcParams.curICMSEnt:= fltIcmEnt;
  cpcParams.curIPIEnt := dataSet.FieldByName('ITE_IPIENT' + strNov).AsFloat;
  cpcParams.curFrete  := dataSet.FieldByName('ITE_FREENT' + strNov).AsFloat;
  cpcParams.curAcrFin := dataSet.FieldByName('ITE_ACRFIN' + strNov).AsFloat;
  cpcParams.curSubsti := fltSubst;
  cpcParams.curValFre := dataSet.FieldByName('ITE_VALFRE' + strNov).AsFloat;
  cpcParams.curDesAdb := dataSet.FieldByName('ITE_DESADB' + strNov).AsFloat;
  cpcParams.curSubFed := fltSubFed;

  if blnSufram and (strFrmCus = '4') then
  begin
    cpcParams.curTCIFCu := dataSet.FieldByName('ITE_TCIFCU' + strNov).AsFloat;
    cpcParams.curTSCust := dataSet.FieldByName('ITE_TSCUST' + strNov).AsFloat;
    cpcParams.curDePiCo := dataSet.FieldByName('ITE_DEPICO' + strNov).AsFloat;
    cpcParams.curDeICMS := dataSet.FieldByName('ITE_DEICMS' + strNov).AsFloat;
    cpcParams.curFatReg := dataSet.FieldByName('ITE_FATREG' + strNov).AsFloat;
  end
  else
  begin
    cpcParams.curTCIFCu := 0;
    cpcParams.curTSCust := 0;
    cpcParams.curDePiCo := 0;
    cpcParams.curDeICMS := 0;
    cpcParams.curFatReg := 0;
  end;

  blnUtilizarConversorDeMoeda := dataSet.FieldByName('ITE_PREDOL' + strNov).AsString = 'S';

  Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);
end;

function TTabelaPreco.fCalculaCustoReal(dataSet: TDataSet): Double;
Begin
  Result := untfuncoesSimples.fCalculaCustoReal(dataSet.FieldByName('ITE_PRECUS').AsFloat,
                                                dataSet.FieldByName('ITE_ICMSAI').AsFloat,
                                                dataSet.FieldByName('ITE_IMPFED').AsFloat,
                                                dataSet.FieldByName('ITE_DESOPE').AsFloat,
                                                dataSet.FieldByName('ITE_OUTVAL').AsFloat);
End;

Procedure TTabelaPreco.pBeforePostTabDet(dataSet: TDataSet);
var
  CalculaComposicaoCusto: TCalculaComposicaoCusto;
Begin
  If blnTabPrd Then
  Begin
    CalculaComposicaoCusto := TCalculaComposicaoCusto.fRetCustoTabDet(dataSet.FieldByName('ITE_IPIENT').AsFloat,
                                                                      fIncidePis(dataSet.FieldByName('ITE_CODITE').AsString),
                                                                      IIf(strCodForDef = '',  dataSet.FieldByName('ITE_CODFOR').AsString, strCodForDef),
                                                                      dataSet.FieldByName('ITE_CODABF').AsString,
                                                                      dataSet.FieldByName('AUTOINCREM').AsString,
                                                                      dataSet.FieldByName('TABELA').AsString,
                                                                      dataSet.FieldByName('ITE_CODEMP').AsString);

    Try
      If CalculaComposicaoCusto.BlnSemST then
      Begin
        DataSet.FieldByName('ITE_ICMENT').AsFloat := CalculaComposicaoCusto.AliquotaICMSEnt;
        DataSet.FieldByName('ITE_ICMSAI').AsFloat := CalculaComposicaoCusto.AliquotaICMSSai;
        DataSet.FieldByName('ITE_SUBSTI').AsFloat := 0;
      End
      Else
      begin
        DataSet.FieldByName('ITE_ICMENT').AsFloat := 0;
        DataSet.FieldByName('ITE_ICMSAI').AsFloat := 0;
        DataSet.FieldByName('ITE_SUBSTI').AsFloat := CalculaComposicaoCusto.AliquotaST;
      End;

      DataSet.FieldByName('ITE_IMPFED').AsFloat := CalculaComposicaoCusto.ImpFed;
      DataSet.FieldByName('ITE_SUBFED').AsFloat := CalculaComposicaoCusto.SubFed;


      If Assigned(DataSet.FindField('ITE_IVA')) Then
        dataSet.FieldByName('ITE_IVA').AsFloat := CalculaComposicaoCusto.IVAFornecedor;

    Finally
      FreeAndNil(CalculaComposicaoCusto);
    End;
    dataSet.FieldByName('CNV_COMLIQ').AsFloat :=
      untfuncoesSimples.fCalculaPrecoCompraLiq(dataSet.FieldByName('CNV_PRECOM').AsFloat,
                                               dataSet.FieldByName('ITE_DESF01').AsFloat,
                                               dataSet.FieldByName('ITE_DESF02').AsFloat,
                                               dataSet.FieldByName('ITE_DESF03').AsFloat,
                                               dataSet.FieldByName('ITE_DESF04').AsFloat,
                                               dataSet.FieldByName('ITE_DESF05').AsFloat,
                                               dataSet.FieldByName('ITE_DESF06').AsFloat,
                                               intDecUni,
                                               dataSet.FieldByName('ITE_PREDOL').AsString = 'S');

    dataSet.FieldByName('CNV_PRECUS').AsFloat := fRetPrecoCusto(dataSet) / dataSet.FieldByName('ITE_CNVCUS').AsFloat;

    dataSet.FieldByName('CNV_CUSREA').AsFloat := fCalculaCustoReal(dataSet)/ dataSet.FieldByName('ITE_CNVCUS').AsFloat;
  End;


  dataSet.FieldByName('ITE_COMLIQ').AsFloat :=
    untfuncoesSimples.fCalculaPrecoCompraLiq(dataSet.FieldByName('ITE_PRECOM').AsFloat,
                                             dataSet.FieldByName('ITE_DESF01').AsFloat,
                                             dataSet.FieldByName('ITE_DESF02').AsFloat,
                                             dataSet.FieldByName('ITE_DESF03').AsFloat,
                                             dataSet.FieldByName('ITE_DESF04').AsFloat,
                                             dataSet.FieldByName('ITE_DESF05').AsFloat,
                                             dataSet.FieldByName('ITE_DESF06').AsFloat,
                                             intDecUni,
                                             dataSet.FieldByName('ITE_PREDOL').AsString = 'S');

  dataSet.FieldByName('ITE_PRECUS').AsFloat := fRetPrecoCusto(dataSet);

  dataSet.FieldByName('ITE_CUSREA').AsFloat := fCalculaCustoReal(dataSet);

  pCalculaPrecoMargem(dataSet, dataSet.FieldByName('ITE_COMTBL').AsFloat);
End;

Procedure TTabelaPreco.pCalculaPrecoMargem(dataSet: TDataSet; fltComTbl: Double);
var intOpcao: integer;
Begin
  If blnTabPrD Then
  Begin

    If blnProcessoDeImportacao Then
    Begin
      If ImportacaoOpcMarPre =  opcPrecoVenda Then
         intOpcao := 1
       Else
         intOpcao := 2;
    End
    Else
    Begin
      If fOpcCalculo(dataSet) = opcPrecoVenda Then
         intOpcao := 1
       Else
         intOpcao := 2;
    End;


    dataSet.FieldByName(IIf(intOpcao = 1, 'ITE_PREVEN',  'ITE_MARBRU')).AsFloat := fCalculaPrecoVenda(intOpcao,
                                                              dataSet.FieldByName('ITE_PRECUS').AsFloat + dataSet.FieldByName('ITE_OUTVAL').AsFloat,
                                                              dataSet.FieldByName('ITE_PREVEN').AsFloat,
                                                              dataSet.FieldByName('ITE_MARBRU').AsFloat,
                                                              dataSet.FieldByName('ITE_ICMSAI').AsFloat,
                                                              dataSet.FieldByName('ITE_IMPFED').AsFloat,
                                                              dataSet.FieldByName('ITE_DESOPE').AsFloat,
                                                              fltComTbl);

    dataSet.FieldByName('CNV_PREVEN').AsFloat := dataSet.FieldByName('ITE_PREVEN').AsFloat/dataSet.FieldByName('ITE_CNVCUS').AsFloat;

    If dataSet.FieldByName('ITE_PREREV').AsFloat > 0 Then
      dataSet.FieldByName('ITE_DESREV').AsFloat :=  RoundTo(((dataSet.FieldByName('ITE_PREREV').AsFloat
         - dataSet.FieldByName('ITE_PREVEN').AsFloat) / dataSet.FieldByName('ITE_PREREV').AsFloat) * 100, -2)
    Else
      dataSet.FieldByName('ITE_DESREV').AsFloat := 0;

    If blnTabPrD Then
    Begin
       If dataSet.FieldByName('ITE_MARGIR').AsFloat > 0 Then
         dataSet.FieldByName('ITE_VENGIR').AsFloat := fCalculaPrecoVenda(1,
                                                    dataSet.FieldByName('CNV_PRECUS').AsFloat + dataSet.FieldByName('CNV_OUTVAL').AsFloat,
                                                    dataSet.FieldByName('CNV_PREVEN').AsFloat,
                                                    dataSet.FieldByName('ITE_MARGIR').AsFloat,
                                                    dataSet.FieldByName('ITE_ICMSAI').AsFloat,
                                                    dataSet.FieldByName('ITE_IMPFED').AsFloat,
                                                    dataSet.FieldByName('ITE_DESOPE').AsFloat,
                                                    dataSet.FieldByName('ITE_COMTBL').AsFloat);
    End;
  End;
End;

Function TTabelaPreco.fSalvaItensProgressoTabDet(cxProgresso: TCxProgressBar): Boolean;
var intTabelaAtiva: Integer;
Begin
  Result := FTabDetEmpresas.fLeDados('TTabelaPreco.fSalvaItensProgresso');

  If Result Then
  Begin
    frmGravando.Caption := 'Salvando dados por empresa, aguarde...';

    cdsTabDet.AfterPost  := Nil;
    cdsTabDet.BeforePost := Nil;

    intTabelaAtiva := fRetPrimeiraTabPrecoAtiva;
    If Not blnTabPrD Then
      cdsTabDet.Filter   := 'AUTOINCREM IS NULL'
    Else
      cdsTabDet.Filter   := 'AUTOINCREM IS NULL AND TABELA = ' + intTabelaAtiva.ToString;
    cdsTabDet.Filtered := True;

    cxProgresso.Properties.Max := cdsTabDet.RecordCount;
    cxProgresso.Position := 0;

    cdsTabDet.First;
    Try

      While Not cdsTabDet.Eof Do
      Begin
        cdsTabDet.Edit;
        If cdsTabDet.FieldByName('ITE_CODITE').AsString <> Self.FieldByName('ITE_CODITE').AsString Then
        Begin
          Self.First;
          Self.Locate('ITE_CODITE', cdsTabDet.FieldByName('ITE_CODITE').AsString, []);
            cdsTabDet.FieldByName('ITE_SEQGER').AsString := Self.FieldByName('AUTOINCREM').AsString;
        End;

        If cdsTabDet.FieldByName('ITE_CODITE').AsString = Self.FieldByName('ITE_CODITE').AsString Then
          cdsTabDet.FieldByName('ITE_SEQGER').AsString := Self.FieldByName('AUTOINCREM').AsString;

        cdsTabDet.FieldByName('AUTOINCREM').AsString := fRetAutoIncremDet;
        cdsTabDet.FieldByName('ITE_CODFOR').AsString := FCodFor;
        cdsTabDet.FieldByName('ITE_CODTAB').AsString := FCodTab;

        If FCodTabHeranca.IsEmpty Then
        Begin
          Result := fGeraTabDetEmpresas;
          If Not Result Then
            Break;
        End;

        cdsTabDet.Post;

        cxProgresso.Position := cxProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    Finally
      If blnTabPrD Then
      Begin
        cdsTabDet.Filter   := 'TABELA = ' + intTabelaAtiva.ToString;
        cdsTabDet.Filtered := True;

      End
      Else
      Begin
        cdsTabDet.Filter   := '';
        cdsTabDet.Filtered := False;
      End;
    End;
    Result := Result And fSalvaClient('TABDET', cdsTabDet);

    Result := Result And FTabDetEmpresas.fSalva;

    If Not blnTabPrD Then
    Begin
      Result := Result And fAtualizaEmpresasTabDet(False, cxProgresso);

      If blnInfMat And fEhEmpresaResponsavelFornecedor(FCodFor) Then
        Result := Result And fAtualizaEmpresasTabDet(True, cxProgresso);
    End;

    cdsTabDet.Filtered := False;
    If blnTabPrD Then
    Begin
      pAtualizaAutoincremParaPrecus;
      Result := Result And fSalvaDetCus;
    End;
  End;
End;


procedure TTabelaPreco.pAtualizaAutoincremParaPrecus;
var
  cdsDados: TZClient;
  strFilterIni: String;
  blnFilteredIni: Boolean;
begin
  blnFilteredIni := cdsTabDet.Filtered;
  strFilterIni   := cdsTabdet.Filter;
  cdsDados := TZClient.Create(nil);
  Try
    cdsDados.Data := cdsTabDet.Data;

    cdsDados.Filtered := False;
    cdsDados.Filter :=  'AUTOINCREM <> ' + QuotedStr('');
    cdsDados.Filtered := True;



    cdsTabDet.Filtered := False;
    cdsTabdet.Filter :=  'AUTOINCREM IS NULL';
    cdsTabdet.Filtered := True;

    while not cdsTabdet.IsEmpty Do
    Begin
      cdsDados.First;
      cdsDados.Locate('ITE_CODITE;ITE_CODEMP', VarArrayOf([cdsTabdet.FieldByName('ITE_CODITE').AsString,
                                                            cdsTabdet.FieldByName('ITE_CODEMP').AsString]), []);
      cdsTabdet.Edit;
      cdsTabDet.FieldByName('AUTOINCREM').AsString := cdsDados.FieldByName('AUTOINCREM').AsString;
      cdsTabdet.Post;
    End;

  Finally
    cdsTabDet.Filtered := False;
    If strFilterIni <> '' Then
      cdsTabdet.Filter := strFilterIni;
    cdsTabDet.Filtered := blnFilteredIni;

    FreeAndNil(cdsDados);
  End;


End;

function TTabelaPreco.fTrataFloatString(strValor: String): String;
begin
  result := AnsiReplaceStr(AnsiReplaceStr(strValor, '.', ''), ',', '.');
  If fEmptyStr(result) Then
    Result := '0';
end;


Function TTabelaPreco.fSalvaDetCus: Boolean;
var qryComand: TUniQuery;
    strAutoIncrem: String;
    i: integer;
    strConteudo: String;
    intContador: integer;
begin
  Result := True;
  cdsTabDet.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP;TABELA';

  cdsTabDet.First;
  qryComand := fCriaQuery;
  Try
    Try
      intContador := 0;
      qryComand.SQL.Clear;
      while not cdsTabDet.Eof do
      Begin
        If cdsTabDet.FieldByName('EXCLUIDO').AsString <> 'S' Then
        Begin
          If cdsTabDet.FieldByName('AUTOINCREM').Value <> '' Then
          Begin
            strAutoIncrem := cdsTabDet.FieldByName('AUTOINCREM').Value;

            For i := 1 To  7 do
            Begin
              If VS_strTabPrc[i] = 'N' Then
              Begin
                strConteudo := '';
                strConteudo := strConteudo + 'REPLACE INTO DETCUS (DET_SEQDET, DET_TABELA,  DET_ICMSAI, DET_DESOPE, DET_OUTVAL, DET_MARBRU, DET_PREVEN) VALUES (';
                strConteudo := strConteudo +  QuotedStr(strAutoIncrem) + ',';
                strConteudo := strConteudo +  QuotedStr(i.ToString) + ',';
                strConteudo := strConteudo +  fTrataFloatString('0') + ',';
                strConteudo := strConteudo +  fTrataFloatString('0') + ',';
                strConteudo := strConteudo +  fTrataFloatString('0') + ',';
                strConteudo := strConteudo +  fTrataFloatString('0') + ',';
                strConteudo := strConteudo +  fTrataFloatString('0') + ');';
                qryComand.SQL.Add(strConteudo);
                Inc(intContador);
              End;
            End;
          End;
          strConteudo := '';
          strConteudo := strConteudo + 'REPLACE INTO DETCUS (DET_SEQDET, DET_TABELA,  DET_ICMSAI, DET_DESOPE, DET_OUTVAL, DET_MARBRU, DET_PREVEN) VALUES (';
          strConteudo := strConteudo +  QuotedStr(strAutoIncrem) + ',';
          strConteudo := strConteudo +  QuotedStr(cdsTabDet.FieldByName('TABELA').AsString) + ',';
          strConteudo := strConteudo +  fTrataFloatString(cdsTabDet.FieldByName('ITE_ICMSAI').AsString) + ',';
          strConteudo := strConteudo +  fTrataFloatString(cdsTabDet.FieldByName('ITE_DESOPE').AsString) + ',';
          strConteudo := strConteudo +  fTrataFloatString(cdsTabDet.FieldByName('ITE_OUTVAL').AsString) + ',';
          strConteudo := strConteudo +  fTrataFloatString(cdsTabDet.FieldByName('ITE_MARBRU').AsString) + ',';
          strConteudo := strConteudo +  fTrataFloatString(cdsTabDet.FieldByName('ITE_PREVEN').AsString) + ');';

          qryComand.SQL.Add(strConteudo);
          Inc(intContador);
        End;
        cdsTabDet.Next;
        If (cdsTabDet.Eof) Or (intContador > 300) Then
        Begin
          intContador := 0;
          qryComand.ExecSQL;
          qryComand.SQL.Clear;
        End
      End;



    Except
      on E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TTabelaPreco.fSalvaDetCus]');
      End;
    End;
  Finally
    FreeAndNil(qryComand);
  End;
End;

Function TTabelaPreco.fSQLUpdateTabDet(blnResFor: Boolean): String;
  Var
    strSQL: String;
Begin
  Result := '';

  Try

    If stlEmpresasPrecosMatriz.Count = 0 Then
      Exit;

    strSQL := 'UPDATE TABDET SET ';
    strSQL := strSQL + '   ITE_DESF01 = :ITE_DESF01,';
    strSQL := strSQL + '   ITE_DESF02 = :ITE_DESF02,';
    strSQL := strSQL + '   ITE_DESF03 = :ITE_DESF03,';
    strSQL := strSQL + '   ITE_DESF04 = :ITE_DESF04,';
    strSQL := strSQL + '   ITE_DESF05 = :ITE_DESF05,';
    strSQL := strSQL + '   ITE_DESF06 = :ITE_DESF06,';
    strSQL := strSQL + '   ITE_PRECOM = :ITE_PRECOM,';
    strSQL := strSQL + '   ITE_ICMENT = :ITE_ICMENT,';
    strSQL := strSQL + '   ITE_SUBFED = :ITE_SUBFED,';
    strSQL := strSQL + '   ITE_IPIENT = :ITE_IPIENT,';
    strSQL := strSQL + '   ITE_FREENT = :ITE_FREENT,';
    strSQL := strSQL + '   ITE_VALFRE = :ITE_VALFRE,';
    strSQL := strSQL + '   ITE_ACRFIN = :ITE_ACRFIN,';
    strSQL := strSQL + '   ITE_SUBSTI = :ITE_SUBSTI,';
    strSQL := strSQL + '   ITE_DESADB = :ITE_DESADB,';
    strSQL := strSQL + '   ITE_PRECUS = :ITE_PRECUS,';
    strSQL := strSQL + '   ITE_CODABF = :ITE_CODABF,';
    strSQL := strSQL + '   ITE_ABFPIS = :ITE_ABFPIS ';

    If Not blnResFor Then
    Begin
      If (Not blnInfMat) Or (intInfFed = 2) Then
       strSQL := strSQL + ', ITE_IMPFED = :ITE_IMPFED ';

      If (Not blnInfMat) Or (intInfOpe = 2)  Then
        strSQL := strSQL + ', ITE_DESOPE = :ITE_DESOPE ';

      If (Not blnInfMat) Or (intInfSai = 2)  Then
        strSQL := strSQL + ', ITE_ICMSAI = :ITE_ICMSAI ';

      strSQL := strSQL + ', ITE_OUTVAL = :ITE_OUTVAL ';
      strSQL := strSQL + ', ITE_DESGER = :ITE_DESGER ';
      strSQL := strSQL + ', ITE_PROGER = :ITE_PROGER ';
      strSQL := strSQL + ', ITE_MARBRU = :ITE_MARBRU ';
      strSQL := strSQL + ', ITE_PREVEN = :ITE_PREVEN ';
      strSQL := strSQL + ', ITE_PREREV = :ITE_PREREV ';
      strSQL := strSQL + ', ITE_MARFEC = :ITE_MARFEC ';
      strSQL := strSQL + ', ITE_TCIFCU = :ITE_TCIFCU ';
      strSQL := strSQL + ', ITE_TSCUST = :ITE_TSCUST ';
      strSQL := strSQL + ', ITE_DEPICO = :ITE_DEPICO ';
      strSQL := strSQL + ', ITE_DEICMS = :ITE_DEICMS ';
      strSQL := strSQL + ', ITE_FATREG = :ITE_FATREG ';
      strSQL := strSQL + ', ITE_EXCIPI = :ITE_EXCIPI ';
      strSQL := strSQL + ', ITE_PREDOL = :ITE_PREDOL ';
    End;

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '       ITE_CODITE = :ITE_CODITE ';
    strSQL := strSQL + '   AND ITE_CODFOR = :ITE_CODFOR ';
    strSQL := strSQL + '   AND ITE_CODTAB = :ITE_CODTAB ';

    If blnResFor Then
      strSQL := strSQL + '   AND ITE_CODEMP NOT IN (' + fCommaText(stlEmpresasPrecosMatriz, True)  + ') '
    Else
      strSQL := strSQL + '   AND ITE_CODEMP IN (' + fCommaText(stlEmpresasPrecosMatriz, True)  + ') ';

    Result := strSQL;

  Finally

  End;

End;

Function TTabelaPreco.fAtualizaEmpresasTabDet(blnResFor: Boolean; cxProgresso: TCxProgressBar): Boolean;
  Var
    qryUpdate: TUniQuery;
    strSQL: String;
    intContador: Integer;
Begin
  Result := True;

  strSQL := fSQLUpdateTabDet(blnResFor);

  If strSQL.IsEmpty Then
    Exit;

  qryUpdate := fCriaQuery;
  qryUpdate.SQL.Text := strSQL;

  cdsTabDet.filter   := 'ALTERADO = ' +QuotedStr('S');
  cdsTabDet.filtered := True;
  cdsTabDet.First;

  cxProgresso.Properties.Max := cdsTabDet.RecordCount;
  cxProgresso.Position := 0;

  While Not cdsTabDet.Eof Do
  Begin
    qryUpdate.Close;

    For intContador := 0 To qryUpdate.ParamCount - 1 Do
      qryUpdate.Params[intContador].Value := cdsTabDet.FieldByName(qryUpdate.Params[intContador].Name).Value;

    qryUpdate.ExecSQL;

    cdsTabDet.Next;

    cxProgresso.Position := cxProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  FreeAndNil(qryUpdate)
End;

Procedure TTabelaPreco.pExcluiItem;
Begin
  If (Not Self.IsEmpty) And fPergunta('Confirma a exclusão do Item?') Then
  Begin
    If (Self.UpdateStatus = usInserted) And cdsTabDet.Locate('ITE_CODITE', Self.FieldByName('ITE_CODITE').AsString, []) Then
      cdsTabDet.Delete;

{    cdsTabDet.First;

    While not cdsTabDet.Eof Do
    Begin
      cdsTabDet.Edit;
      cdsTabDet.FieldByName('EXCLUIDO').AsString := 'S';
      cdsTabDet.Post;
      cdsTabDet.Next;
    End;}

    cdsTabDet.Filtered := False;
    while cdsTabDet.Locate('ITE_CODITE', Self.FieldByName('ITE_CODITE').AsString, []) do
    Begin
      cdsTabDet.Delete;
      cdsTabDet.First;
    End;

    stlListaItensDeletados.Add(Self.FieldByName('ITE_CODITE').AsString);
    Self.Delete;
  End;
End;

Procedure TTabelaPreco.pCopiaDadosInsert(dtsItens: TDataSet; blnTestarChaves: Boolean);
  Var
    intContador: Integer;
Begin
  If Locate('ITE_CODITE', dtsItens.FieldByName('ITE_CODITE').AsString, []) Then
    Edit
  Else
    Insert;

  For intContador := 0 To dtsItens.FieldCount - 1 Do
    If (Not blnTestarChaves) Or
       (Self.State = dsInsert) Or
       (Pos(Fields[intContador].FieldName, 'AUTOINCREM-ITE_CODEMP-ITE_CODITE-ITE_CODFOR-ITE_CODTAB') <= 0) Then
      Fields[intContador].Value := dtsItens.Fields[intContador].Value;

  Post;
End;

Procedure TTabelaPreco.pCopiaDadosInsertTabDet(dtsItens: TDataSet; blnTestarChaves: Boolean);
  Var
    intContador: Integer;
Begin
  dtsItens.First;
  While not dtsItens.Eof do
  begin
    If blnTabPrd Then
    Begin
      If cdsTabDet.Locate('ITE_CODITE;TABELA', VarArrayOf([Self.FieldByName('ITE_CODITE').AsString, dtsItens.FieldByName('TABELA').AsString]), []) Then
        cdsTabDet.Edit
      Else
        cdsTabDet.Insert;
    End
    Else
    Begin
      If cdsTabDet.Locate('ITE_CODITE', Self.FieldByName('ITE_CODITE').AsString, []) Then
        cdsTabDet.Edit
      Else
        cdsTabDet.Insert;
    End;

    For intContador := 0 To dtsItens.FieldCount - 1 Do
      If (Not blnTestarChaves) Or
         (cdsTabDet.State = dsInsert) Or
         (Pos(cdsTabDet.Fields[intContador].FieldName, 'AUTOINCREM-ITE_CODEMP-ITE_CODITE-ITE_CODFOR-ITE_CODTAB') <= 0) Then
        cdsTabDet.Fields[intContador].Value := dtsItens.Fields[intContador].Value;

    cdsTabDet.FieldByName('ITE_CODITE').AsString := Self.FieldByName('ITE_CODITE').AsString;
    cdsTabDet.FieldByName('ITE_CODEMP').AsString := VS_strCodEmp;
    cdsTabDet.Post;


    dtsItens.Next;

  End;
End;

Procedure TTabelaPreco.pIniciaValores(cdsItens:TUniClientDataSet; var AcdsTabDet: TZClient; AstrCodIte: String = ''; AstrTabela: String = '');
var i: integer;
    CalculaComposicaoCusto : TCalculaComposicaoCusto;
Begin
  If cdsItens.State = dsInsert Then
  Begin
    cdsItens.FieldByName('ITE_DIAFOR').AsInteger := 0;
    cdsItens.FieldByName('ITE_MLTCOM').AsInteger := 1;
    cdsItens.FieldByName('ITE_CNVCUS').AsFloat   := 1;
  End;

  If AcdsTabDet.State = dsInsert Then
  Begin
    If blnTabPrD Then
    Begin
      for i := 1 To 7 do
      begin
        If AstrTabela <> '' Then
          If AstrTabela <> i.ToString Then
            Continue;
        blnInclusaoItem := True;
        If VS_strTabPrc[i] = 'S' Then
        Begin
          CalculaComposicaoCusto := TCalculaComposicaoCusto.fRetCustoTabDet(0,
                                                                            True,
                                                                            '',
                                                                            '',
                                                                            '',
                                                                            i.ToString,
                                                                            VS_StrCodEmp);
          Try

            If AcdsTabDet.State <> dsInsert Then
              AcdsTabDet.Insert;

            AcdsTabDet.FieldByName('TABELA').AsInteger := i;
            AcdsTabDet.FieldByName('ITE_CODITE').AsString := AstrCodIte;
            AcdsTabDet.FieldByName('ITE_PRECOM').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_DESF01').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_DESF02').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_DESF03').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_DESF04').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_DESF05').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_DESF06').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_ICMENT').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_SUBFED').AsFloat := CalculaComposicaoCusto.SubFed;
            AcdsTabDet.FieldByName('ITE_IPIENT').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_FREENT').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_VALFRE').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_ACRFIN').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_SUBSTI').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_DESADB').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_PRECUS').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_OUTVAL').AsFloat := CalculaComposicaoCusto.OutVal;
            AcdsTabDet.FieldByName('ITE_ICMSAI').AsFloat := CalculaComposicaoCusto.AliquotaICMSSai;
            AcdsTabDet.FieldByName('ITE_IMPFED').AsFloat := CalculaComposicaoCusto.ImpFed;
            AcdsTabDet.FieldByName('ITE_DESOPE').AsFloat := CalculaComposicaoCusto.DesOpe;;
            AcdsTabDet.FieldByName('ITE_TCIFCU').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_TSCUST').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_DEPICO').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_DEICMS').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_FATREG').AsFloat := 0;
            AcdsTabDet.FieldByName('ITE_CNVCUS').AsFloat := 1;
            AcdsTabDet.FieldByName('ITE_PREDOL').AsString := 'N';
            AcdsTabDet.Post;
          Finally
            FreeAndNil(CalculaComposicaoCusto);
          End;

          blnInclusaoItem := False;

        End;
      End;
    End
    Else
    Begin
      AcdsTabDet.FieldByName('ITE_PREDOL').AsString := 'N';
      AcdsTabDet.FieldByName('ITE_PRECOM').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DESF01').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DESF02').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DESF03').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DESF04').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DESF05').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DESF06').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_ICMENT').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_SUBFED').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_IPIENT').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_FREENT').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_VALFRE').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_ACRFIN').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_SUBSTI').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DESADB').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_PRECUS').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_OUTVAL').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_ICMSAI').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_IMPFED').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DESOPE').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_TCIFCU').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_TSCUST').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DEPICO').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_DEICMS').AsFloat := 0;
      AcdsTabDet.FieldByName('ITE_FATREG').AsFloat := 0;
    End;

  End;

End;

Procedure TTabelaPreco.pCarregaDadosSugestaoItem(strCodIte: String);
  Var
    intContador: Integer;
    qrySugest: TUniQuery;
    strNomeCampo: String;
    CalculaComposicaoCusto : TCalculaComposicaoCusto;
Begin
  qrySugest := fCriaQuery;

  With qrySugest, SQL Do
  Begin
    Clear;

    Add('SELECT  ');

    If intTipAbf = 1 Then
       Add(' C.ITE_CODABF, ')
    Else
       Add(' I.ITE_CODABF, ');

    Add(' C.*, I.* ');

    Add('FROM      ');
    Add('  CADITE C');
    Add('INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND ');
    Add('                       I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
    Add('WHERE     ');
    Add('  C.ITE_CODITE = ' + QuotedStr(strCodIte));

    Open;
  End;
  FIncDet.First;
  while not FIncDet.Eof do
  Begin
    FIncDet.edit;
    For intContador := 0 To FIncIte.FieldCount - 1 Do
    Begin
      strNomeCampo := AnsiReplaceStr(FIncIte.Fields[intContador].FieldName, 'TFO_', 'ITE_');

      If (qrySugest.FindField(strNomeCampo) <> Nil) And
         (Pos(FIncIte.Fields[intContador].FieldName, 'AUTOINCREM_ITE_CODEMP_ITE_CODITE_ITE_CODFOR_') <= 0) Then
        FIncIte.Fields[intContador].Value :=  qrySugest.FieldByName(strNomeCampo).Value;

    End;

    For intContador := 0 To FIncDet.FieldCount - 1 Do
    Begin
      strNomeCampo := FIncDet.Fields[intContador].FieldName;

      If (qrySugest.FindField(strNomeCampo) <> Nil) And
         (Pos(strNomeCampo, 'AUTOINCREM_ITE_CODEMP_ITE_CODITE_ITE_CODFOR_') <= 0) Then
        FIncDet.Fields[intContador].Value :=  qrySugest.FieldByName(strNomeCampo).Value;
    End;
    If blnTabPrd Then
    Begin
      CalculaComposicaoCusto := TCalculaComposicaoCusto.fRetCustoTabDet(0,
                                                                        True,
                                                                        '',
                                                                        '',
                                                                        '',
                                                                        FIncDet.FieldByName('TABELA').AsString,
                                                                        VS_StrCodEmp);
      Try
        FIncDet.FieldByName('ITE_SUBFED').AsFloat := CalculaComposicaoCusto.SubFed;
        FIncDet.FieldByName('ITE_OUTVAL').AsFloat := CalculaComposicaoCusto.OutVal;
        FIncDet.FieldByName('ITE_ICMSAI').AsFloat := CalculaComposicaoCusto.AliquotaICMSSai;
        FIncDet.FieldByName('ITE_IMPFED').AsFloat := CalculaComposicaoCusto.ImpFed;
        FIncDet.FieldByName('ITE_DESOPE').AsFloat := CalculaComposicaoCusto.DesOpe;
      Finally
        FreeAndNil(CalculaComposicaoCusto);
      End;
    End;



    FIncDet.Post;

    FIncDet.Next;
  End;


  FreeAndNil(qrySugest);
End;

Procedure TTabelaPreco.pCarregaItemAlteracao(strCodIte: String; blnBuscaPorChave: Boolean; dtsIteFor, dtsTabDet: TDataSource);
Begin

  If (FIncIte.State = dsInsert) Then
  Begin
    If Locate('ITE_CODITE', strCodIte, []) Then
    Begin

      dtsIteFor.DataSet := Self;
      dtsTabDet.DataSet := cdsTabDet;
      opcAlteraPreco := opcAlteraItem;

    End Else
    Begin

      If blnBuscaPorChave Then
        pCarregaDadosSugestaoItem(strCodIte);

    End;

  End;

End;

Function TTabelaPreco.fAjustaAtivaCompras(qryTabela: TUniQuery; blnForcarDesmarcacao: Boolean = False): Boolean;
  Var
    qryTabPre: TUniQuery;
Begin
  Try
    qryTabPre := fCriaQuery(Self);

    If qryTabela.FieldByName('TAB_ATICMP').AsString = 'S' Then
    Begin

      With qryTabPre, SQL Do
      Begin
        Clear;
        Add('UPDATE TABPRE SET TAB_ATICMP = "N"');
        Add('WHERE');
        Add('  TAB_CODTAB <> :CODTAB AND ');
        Add('  TAB_CODFOR = :CODFOR      ');

        ParamByName('CODFOR').AsString := qryTabela.FieldByName('TAB_CODFOR').AsString;
        ParamByName('CODTAB').AsString := qryTabela.FieldByName('TAB_CODTAB').AsString;

        ExecSQL;
      End;

    End Else If not blnForcarDesmarcacao Then
    Begin

      With qryTabPre, SQL Do
      Begin
        Clear;
        Add('SELECT * FROM TABPRE');
        Add('WHERE');
        Add('  TAB_CODFOR = :CODFOR AND ');
        Add('  TAB_ATICMP = "S"  ');

        ParamByName('CODFOR').AsString := qryTabela.FieldByName('TAB_CODFOR').AsString;

        Open;

        If IsEmpty Then
        Begin
          qryTabela.Edit;
          qryTabela.FieldByName('TAB_ATICMP').AsString := 'S';
          qryTabela.Post;
        End;

      End;

    End;

    FreeAndNil(qryTabPre);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelaPreco.fAjustaAtivaCompras]');
    End;
  End;
End;

function TTabelaPreco.fAjustaCodFabricaCodBarras(prgProgresso: TCXProgressBar): Boolean;
Var
  intContador: Integer;
begin

  Try
    Self.DisableControls;

    Try
      frmGravando.lblGravando.Caption := 'Atualizando Código Fábrica e código de Barras, aguarde...';
      prgProgresso.Properties.Max := Self.RecordCount;
      prgProgresso.Position := 0;

      Self.Filtered := False;
      Result := True;
      Self.First;

      While Not Self.Eof Do
      Begin
        Result := fAtualizaBarFabIte(Self.FieldByName('ITE_CODITE').AsString);

        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
    	  If Not Result Then
      		Exit;

        Self.Next;
      End;

      If stlListaItensDeletados.Count > 0 Then
      Begin
        frmGravando.lblGravando.Caption := 'Atualizando Código Fábrica e código de Barras dos itens deletados, aguarde...';
        prgProgresso.Properties.Max := Self.RecordCount;
        prgProgresso.Position := 0;

        For intContador := 0 To stlListaItensDeletados.Count - 1 Do
        Begin
          Result := fAtualizaBarFabIte(stlListaItensDeletados[intContador]);
          prgProgresso.Position := prgProgresso.Position + 1;
          Application.ProcessMessages;
        End;

        stlListaItensDeletados.Clear;
      End;

    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(e.Message, '[TTabelaPreco.fAtualizaAlteradosIteforPrg]');
      End;
    End;
  Finally
    Self.EnableControls;
  End;
end;

Procedure TTabelaPreco.pCopiaDadosSelecao;
Begin
  Try
 //   Self.DisableControls;  // NÃO COLOCAR PQ NÃO FUNCIONA O MASTER SOURCE

    With cdsIteSel Do
    Begin
      First;

      While Not Eof Do
      Begin
        if FIncIte.State in dsEditModes Then
        Begin
          FIncIte.FieldByName('ITE_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          FIncIte.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
        End;

        pCopiaDadosInsert(FIncIte, True);
        pCopiaDadosInsertTabDet(FIncDet, True);

        Next;
      End;

    End;

  Finally
  //  Self.EnableControls;
  End;
End;

Procedure TTabelaPreco.pExcluiItemSelecao;
Begin
  With cdsIteSel Do
  If (Not IsEmpty) And fPergunta('Confirma a exclusão do Item?') Then
    Delete;
End;

Function TTabelaPreco.fHerancaTabela(qryTabPre: TUniQuery; strCodFor, strNomTab: string): Boolean;
Begin
  Try
    Result := False;

    pCriarFormularios(TfrmCadTabelaPrecosHeranca, frmCadTabelaPrecosHeranca);

    If Assigned(frmCadTabelaPrecosHeranca) Then
    With frmCadTabelaPrecosHeranca Do
    If ShowModal = mrOk Then
    Begin
      Result := fGravaHeranca(qryTabPre, edtCodTab.Text, strCodFor, strNomTab)
    End;

    FreeAndNil(frmCadTabelaPrecosHeranca);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelaPreco.fHerancaTabela]');
    End;
  End;

End;

Function TTabelaPreco.fGravaHeranca(qryTabPre: TUniQuery; strCodTab: String; strCodFor, strNomTab: String): Boolean;
Begin
  FTabPreHeranca := qryTabPre;
  FCodTabHeranca := strCodTab;

  strCodForHeranca := strCodFor;
  strNomTabHeranca := strNomTab;


  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fMontaHeranca;
  frmGravando.lblGravando.Caption := 'Carregado herança, por favor aguarde...';
  frmGravando.ShowModal;
  Result := frmGravando.blnConfirma;
  FreeAndNil(frmGravando);
End;

Procedure TTabelaPreco.pCopiaTabelaHeranca(cdsDestino: TZClient; strSQL: String; cxProgressBar : TcxProgressBar);
  Var
    qryTabAux: TUniQuery;
    intIndex : Integer;
Begin
  qryTabAux := fCriaQuery(Self);
  qryTabAux.Close;
  qryTabAux.SQL.Clear;
  qryTabAux.SQL.Text := strSQL;
  qryTabAux.ParamByName('CODTAB').AsString := FCodTabHeranca;
  qryTabAux.Open;

  cxProgressBar.Properties.Max := qryTabAux.RecordCount;
  cxProgressBar.Position := 0;

  While not qryTabAux.Eof Do
  Begin
    cdsDestino.Insert;
    For intIndex := 0 To cdsDestino.Fields.Count -1 Do
      cdsDestino.Fields[intIndex].Value := qryTabAux.Fields[intIndex].Value;

    cdsDestino.FieldByName('AUTOINCREM').Clear;
    cdsDestino.FieldByName('ITE_CODTAB').Clear;

    cdsDestino.Post;

    cxProgressBar.Position := cxProgressBar.Position + 1;

    qryTabAux.Next;
  End;

  FreeAndNil(qryTabAux);
End;

function TTabelaPreco.fMontaHeranca(cxProgressBar : TcxProgressBar) : Boolean;
  Var
    qryTabAux: TUniQuery;
Begin
  Result := True;

  cdsTabDet.AfterPost  := Nil;
  cdsTabDet.BeforePost := Nil;
  pLimpaMasterTabDet(cdsTabDet);

  qryTabAux := fCriaQuery(Self);
  qryTabAux.SQL.Text := 'SELECT * FROM TABPRE WHERE TAB_CODTAB = :CODTAB';
  qryTabAux.ParamByName('CODTAB').AsString := FCodTabHeranca;
  qryTabAux.Open;

  FTabPreHeranca.FieldByName('TAB_NOMTAB').AsString := strNomTabHeranca;
  FTabPreHeranca.FieldByName('TAB_CODFOR').AsString := strCodForHeranca;
  FTabPreHeranca.FieldByName('TAB_ATICMP').AsString := 'N';
  FreeAndNil(qryTabAux);

  pCopiaTabelaHeranca(Self, fSQLTabelaPreco, cxProgressBar);
  pCopiaTabelaHeranca(cdsTabDet, fSQLTabDet, cxProgressBar);

  pFormataCamposITEFOR(Self);
End;

Function  TTabelaPreco.fRetTabelaAtiva(strCodFor: String): String;
  Var
    qryTabPre: TUniQuery;
Begin
  qryTabPre := fCriaQuery(Self);
  With qryTabPre, SQL Do
  Begin
    Add('SELECT * FROM TABPRE');
    Add('WHERE');
    Add('  TAB_CODFOR = :CODFOR');
    Add('ORDER BY');
    Add('  TAB_ATICMP DESC');
    ParamByName('CODFOR').AsString := strCodFor;
    Open;

    If IsEmpty Then
    Begin
      qryTabPre.Insert;

      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TABPRE', VS_strCodEmp);
      FieldByName('TAB_CODTAB').AsString := fAtualizaProCod('TABPRE', 'TAB_CODTAB');
      FieldByName('TAB_ATICMP').AsString := 'S';
      FieldByName('TAB_CODEMP').AsString := VS_strCodEmp;
      FieldByName('TAB_CODFOR').AsString := strCodFor;
      FieldByName('TAB_NOMTAB').AsString := 'TABELA FORNECEDOR ' + strCodFor;

      Post;
    End;

    Result := FieldByName('TAB_CODTAB').AsString;
  End;
  FreeAndNil(qryTabPre);
End;

function TTabelaPreco.fImportaTXT(strNomArq, strCodFor: String): Boolean;
begin
  Try
    FNomArq := strNomArq;
    FCodFor := strCodFor;
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Importando Arquivo...';
    frmGravando.fExecutarAcao := fImportaTXTProgresso;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    FreeAndNil(frmGravando);
  End;

end;

function TTabelaPreco.fImportaTXTProgresso(pgbProgresso: TcxProgressBar): Boolean;
  Var
    frmTabelaPrecoInconsistencia: TfrmTabelaPrecoInconsistencia;
    ArrTipoIdentificao: TStringArray;
    opcTipoLocalizacaoItem: TtipoLocalizacaoItem;

  function fProximoCampo(Var strLinha : String) : String;
    Var
      intPos : Integer;
  Begin
    intPos := Pos('|', strLinha);
    If intPos <= 0 Then
      intPos := Length(strLinha)+1;
    Result   := Copy(strLinha, 0, intPos -1);
    strLinha := Copy(strLinha, intPos+1, Length(strLinha));
  End;

  Var
    strCodIte,
    strLinha,
    strCodBar,
    strCodFab,
    strDesFab,
    strPrecom,
    strDesF01,
    strDesF02,
    strDesF03,
    strDesF04,
    strDesF05,
    strDesF06,
    strIPIEnt,
    strClaIpi,
    strCodAbr,
    strMltCom,
    strDiaFor,
    strUniCom,
    strIcmEnt,
    strSubFed,
    strFreEnt,
    strValFre,
    strAcrFin,
    strSubsti,
    strDesAdb,
    strOutVal,
    strIcmSai,
    strImpFed,
    strDesOpe,
    strTabela,
    strImpIte,
    strCnvCus   : String;
    intIndex    : Integer;
    stlArquivo  : TStringList;
    qryDados    : TUniQuery;
    cdsErros    : TUniClientDataSet;
    TipoArquivo : TTipoArquivo;
    objValidadorExcel: TValidadorExcel;
    intContador: Integer;
    intValIni:integer;
    strAutIncTabDet: String;
    blnIncidePis: Boolean;

    CalculaComposicaoCusto : TCalculaComposicaoCusto;
    fltComLiq: Double;

  procedure pAdicionaErro(strDescri : String);
  Begin
    cdsErros.Insert;
    cdsErros.FieldByName('CODBAR').AsString := strCodBar;
    cdsErros.FieldByName('CODFAB').AsString := strCodFab;
    cdsErros.FieldByName('DESFAB').AsString := strDesFab;
    cdsErros.FieldByName('DESF01').AsString := strDesF01;
    cdsErros.FieldByName('DESF02').AsString := strDesF02;
    cdsErros.FieldByName('DESF03').AsString := strDesF03;
    cdsErros.FieldByName('DESF04').AsString := strDesF04;
    cdsErros.FieldByName('DESF05').AsString := strDesF05;
    cdsErros.FieldByName('DESF06').AsString := strDesF06;
    cdsErros.FieldByName('PRECOM').AsString := strPrecom;
    cdsErros.FieldByName('IPIENT').AsString := strIPIEnt;
    cdsErros.FieldByName('DESCRI').AsString := strDescri;
    cdsErros.FieldByName('CLAIPI').AsString := strClaIpi;
    cdsErros.FieldByName('CODABR').AsString := strCodAbr;
    cdsErros.FieldByName('MLTCOM').AsString := strMltCom;
    cdsErros.FieldByName('DIAFOR').AsString := strDiaFor;
    cdsErros.FieldByName('UNICOM').AsString := strUniCom;
    cdsErros.FieldByName('ICMENT').AsString := strIcmEnt;
    cdsErros.FieldByName('SUBFED').AsString := strSubFed;
    cdsErros.FieldByName('FREENT').AsString := strFreEnt;
    cdsErros.FieldByName('VALFRE').AsString := strValFre;
    cdsErros.FieldByName('ACRFIN').AsString := strAcrFin;
    cdsErros.FieldByName('SUBSTI').AsString := strSubsti;
    cdsErros.FieldByName('DESADB').AsString := strDesAdb;
    cdsErros.FieldByName('OUTVAL').AsString := strOutVal;
    cdsErros.FieldByName('ICMSAI').AsString := strIcmSai;
    cdsErros.FieldByName('IMPFED').AsString := strImpFed;
    cdsErros.FieldByName('DESOPE').AsString := strDesOpe;
    cdsErros.FieldByName('CNVCUS').AsString := strCnvCus;
    cdsErros.Post;
  End;


  function fLocalizaItem: Boolean;
  begin
    Result := True;
    strCodIte := '';
    case opcTipoLocalizacaoItem  of
      tliCodBarOuFornecedor_CodFabrica : Begin
                                           If fEmptyStr(strCodBar) Or ((Not fExisteItemCodBarCarregado(strCodBar, strCodIte)) And (Not fExisteItemCodBar(strCodBar, strCodIte))) Then
                                             If fEmptyStr(strCodFab) Or ((Not fExisteItemCodFabCarregado(strCodFab, strCodIte)) And (Not fExisteItemCodFab(strCodFab, FCodFor, strCodIte, False))) Then
                                               If fEmptyStr(strCodBar) Or (Not fExisteItemCodItemFornecedor(strCodBar, FCodFor, strCodIte, False)) Then
                                                  if fEmptyStr(strCodBar) Or (not fExisteIteBar(strCodBar, strCodIte)) Then
                                                  Begin
                                                    pAdicionaErro('FORNECEDOR + CÓDIGO DE FABRICA E CÓDIGO DE BARRAS NÃO ENCONTRADO');
                                                    Exit(False);
                                                  End;
                                         End;
      tliCodBarras: begin
                      If fEmptyStr(strCodBar) Or ((Not fExisteItemCodBarCarregado(strCodBar, strCodIte)) And (Not fExisteItemCodBar(strCodBar, strCodIte))) Then
                        If fEmptyStr(strCodBar) Or (Not fExisteItemCodItemFornecedor(strCodBar, FCodFor, strCodIte, False)) Then
                          if fEmptyStr(strCodBar) Or (not fExisteIteBar(strCodBar, strCodIte)) Then
                          Begin
                            pAdicionaErro('CÓDIGO DE BARRAS NÃO ENCONTRADO');
                            Exit(False);
                          End;
                    End;
      tliFornecedor_CodFabrica: Begin
                                  If fEmptyStr(strCodFab) Or ((Not fExisteItemCodFabCarregado(strCodFab, strCodIte)) And (Not fExisteItemCodFab(strCodFab, FCodFor, strCodIte, False))) Then
                                  Begin
                                    pAdicionaErro('FORNECEDOR + CÓDIGO DE FÁBRICA NÃO ENCONTRADO');
                                    Exit(False);
                                  End;
                                End;
      tliCodItem:   Begin
                      If fEmptyStr(strImpIte) Or (Not fExisteItemCodIte(strImpIte, strCodIte)) Then
                          Begin
                            pAdicionaErro('ITEM NÃO ENCONTRADO');
                            Exit(False);
                          End;
                    End;
    End;
  End;
  procedure pProcessaDados;
    Var
      intContador : Integer;
      intTabela: integer;
  Begin
    If blnTabPrd And ((strTabela = '') Or (Pos(strTabela, '_1_2_3_4_5_6_7') = -1)) Then
    Begin
      pAdicionaErro('TABELA DE PREÇO NÃO FOI INFORMADA OU INVÁLIDA!');
      Exit;
    End;

    If not fLocalizaItem then
      Exit;

    qryDados.Close;
    qryDados.ParamByName('CODITE').AsString := strCodIte;
    qryDados.Open;

    if not qryDados.IsEmpty Then
    Begin
      FIncIte.Insert;
      FIncDet.Insert;

      pIniciaValores(FIncIte, FIncDet, strCodIte, strTabela);

      cdsIteSel.Insert;
      If blnTabPrd then
        FIncDet.Locate('TABELA', strTabela, []);
      If Not (FIncDet.State in dsEditModes) Then
        FIncDet.Edit;
      Try

        For intContador := 0 To qryDados.FieldCount-1 do
        Begin
          if cdsIteSel.FindField( qryDados.Fields[intContador].FieldName) <> Nil Then
            cdsIteSel.FieldByName(qryDados.Fields[intContador].FieldName).AsVariant := qryDados.Fields[intContador].AsVariant;

          If FIncIte.FindField( qryDados.Fields[intContador].FieldName) <> Nil Then
            FIncIte.FieldByName(qryDados.Fields[intContador].FieldName).AsVariant := qryDados.Fields[intContador].AsVariant;

          If cdsTabDet.Fields[intContador].FieldName <> 'TABELA' Then
            If FIncDet.FindField( qryDados.Fields[intContador].FieldName) <> Nil Then
              FIncDet.FieldByName(qryDados.Fields[intContador].FieldName).AsVariant := qryDados.Fields[intContador].AsVariant;
        End;

        If cdsTabDet.FieldByname('ITE_CODITE').AsString = strCodIte Then
        Begin
          For intContador := 0 To cdsTabDet.FieldCount-1 do
          Begin
            if cdsIteSel.FindField( cdsTabDet.Fields[intContador].FieldName) <> Nil Then
              cdsIteSel.FieldByName(cdsTabDet.Fields[intContador].FieldName).AsVariant := cdsTabDet.Fields[intContador].AsVariant;
            If cdsTabDet.Fields[intContador].FieldName <> 'TABELA' Then
              If FIncDet.FindField( cdsTabDet.Fields[intContador].FieldName) <> Nil Then
                FIncDet.FieldByName(cdsTabDet.Fields[intContador].FieldName).AsVariant := cdsTabDet.Fields[intContador].AsVariant;
          End;
        End;
        cdsIteSel.Post;
        strAutIncTabDet := '';
        If blnTabPrd then
        begin
          If Self.Locate('ITE_CODITE', strCodIte , []) Then
          If cdsTabDet.Locate('ITE_CODITE', strCodIte , []) Then
          Begin
            If cdsTabDet.FieldByname('ITE_CODITE').AsString = strCodIte Then
            For intTabela := 1 To 7 do
            Begin
              If FIncDet.Locate('TABELA;ITE_CODITE', VarArrayOf([intTabela.ToString, strCodIte]), []) Then
                If cdsTabDet.Locate('TABELA;ITE_CODITE', VarArrayOf([intTabela.ToString, strCodIte]) , []) Then
              Begin
                strAutIncTabDet := cdsTabDet.FieldByName('AUTOINCREM').AsString;
                FIncDet.Edit;
                For intContador := 0 To cdsTabDet.FieldCount-1 do
                Begin
                  If FIncDet.FindField( cdsTabDet.Fields[intContador].FieldName) <> Nil Then
                    FIncDet.FieldByName(cdsTabDet.Fields[intContador].FieldName).AsVariant := cdsTabDet.Fields[intContador].AsVariant;
                End;
                FIncDet.post;
              End;
            End;
          End;
        End;

      Except
        On E : Exception Do
        Begin
          pAdicionaErro(E.Message);
        End;
      End;


      Try

       // FCadEmp.First;

      //  While Not FCadEmp.Eof Do

        Begin
          If blnTabPrd then
          Begin
            intTabela := StrToInt(strTabela);
            FIncDet.Locate('TABELA;ITE_CODITE', VarArrayOf([intTabela.ToString, strCodIte]), []);
            FIncDet.Edit;
          End
          Else
            pCarregaDadosSugestaoHeranca(strCodIte, VS_strCodEmp {FCadEmp.FieldByName('EMP_CODEMP').AsString});

          FIncIte.FieldByName('ITE_CODITE').AsString := qryDados.FieldByName('ITE_CODITE').AsString;
          FIncIte.FieldByName('ITE_CODEMP').AsString := VS_strCodEmp; //FCadEmp.FieldByName('EMP_CODEMP').AsString;

          FIncIte.FieldByName('ITE_DESITE').AsString := qryDados.FieldByName('ITE_DESITE').AsString;

          If (Not fEmptyStr(strDiaFor)) And (Not SameText('NULL', UpperCase(strDiaFor))) Then
            FIncIte.FieldByName('ITE_DIAFOR').AsInteger := StrToInt(strDiaFor);

          If (Not fEmptyStr(strClaIpi)) And (Not SameText('NULL', UpperCase(strClaIpi))) Then
            FIncIte.FieldByName('ITE_CLAIPI').AsString := strClaIpi
          Else
            FIncIte.FieldByName('ITE_CLAIPI').AsString := qryDados.FieldByName('ITE_CLAIPI').AsString;

          If (Not fEmptyStr(strCodAbr)) And (Not SameText('NULL', UpperCase(strCodAbr))) Then
            FIncIte.FieldByName('ITE_CODABF').AsString := strCodAbr
          Else
            FIncIte.FieldByName('ITE_CODABF').Value := qryDados.FieldByName('ITE_CODABF').Value;

          If (Not fEmptyStr(strMltCom)) And (Not SameText('NULL', UpperCase(strMltCom))) Then
            FIncIte.FieldByName('ITE_MLTCOM').AsFloat  := fStrToFloat(AnsiReplaceStr(strMltCom, '.', ''))
          Else
            FIncIte.FieldByName('ITE_MLTCOM').AsString := qryDados.FieldByName('ITE_MLTCOM').AsString;

          If (Not fEmptyStr(strCnvCus)) And (Not SameText('NULL', UpperCase(strCnvCus))) Then
            FIncIte.FieldByName('ITE_CNVCUS').AsInteger := StrToInt(strCnvCus)
          Else
          Begin
            If Self.FieldByName('ITE_CODITE').AsString = FIncIte.FieldByName('ITE_CODITE').AsString then
              FIncIte.FieldByName('ITE_CNVCUS').AsInteger:= Self.FieldByName('ITE_CNVCUS').AsInteger
            Else
              FIncIte.FieldByName('ITE_CNVCUS').AsInteger:= 1;
          End;

          If (Not fEmptyStr(strUniCom)) And (Not SameText('NULL', UpperCase(strUniCom))) Then
            FIncIte.FieldByName('ITE_UNICOM').AsString := strUniCom
          Else
            FIncIte.FieldByName('ITE_UNICOM').AsString := qryDados.FieldByName('ITE_UNICOM').AsString;

          If (Not fEmptyStr(strDesFab)) And (Not SameText('NULL', UpperCase(strDesFab))) Then
            FIncIte.FieldByName('ITE_DESFAB').AsString := strDesFab;

          If (Not fEmptyStr(strCodFab)) And (Not SameText('NULL', UpperCase(strCodFab))) Then
            FIncIte.FieldByName('ITE_CODFAB').AsString := strCodFab;

          If (opcTipoLocalizacaoItem = tliFornecedor_CodFabrica) And (Not fEmptyStr(strCodBar)) And (Not SameText('NULL', UpperCase(strCodBar))) Then
            FIncIte.FieldByName('TFO_CODBAR').AsString := strCodBar;

         // TABDET
          If blnTabPrd then
          Begin
            FIncDet.Locate('TABELA;ITE_CODITE', VarArrayOf([intTabela.ToString, strCodIte]), []);
            FIncDet.Edit;
          End;



          FIncDet.FieldByName('ITE_CODITE').AsString := qryDados.FieldByName('ITE_CODITE').AsString;
          FIncDet.FieldByName('ITE_CODEMP').AsString := VS_strCodEmp; //FCadEmp.FieldByName('EMP_CODEMP').AsString;

          If (Not fEmptyStr(strDesF01)) And (Not SameText('NULL', UpperCase(strDesF01))) Then
            FIncDet.FieldByName('ITE_DESF01').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF01, '.', ''));

          If (Not fEmptyStr(strDesF02)) And (Not SameText('NULL', UpperCase(strDesF02))) Then
            FIncDet.FieldByName('ITE_DESF02').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF02, '.', ''));

          If (Not fEmptyStr(strDesF03)) And (Not SameText('NULL', UpperCase(strDesF03))) Then
            FIncDet.FieldByName('ITE_DESF03').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF03, '.', ''));

          If (Not fEmptyStr(strDesF04)) And (Not SameText('NULL', UpperCase(strDesF04))) Then
            FIncDet.FieldByName('ITE_DESF04').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF04, '.', ''));

          If (Not fEmptyStr(strDesF05)) And (Not SameText('NULL', UpperCase(strDesF05))) Then
            FIncDet.FieldByName('ITE_DESF05').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF05, '.', ''));

          If (Not fEmptyStr(strDesF06)) And (Not SameText('NULL', UpperCase(strDesF06))) Then
            FIncDet.FieldByName('ITE_DESF06').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF06, '.', ''));

          If (Not fEmptyStr(strPreCom)) And (Not SameText('NULL', UpperCase(strPreCom))) Then
            FIncDet.FieldByName('ITE_PRECOM').AsFloat  := fStrToFloat(AnsiReplaceStr(strPrecom, '.', ''));

          If (Not fEmptyStr(strIPIEnt)) And (Not SameText('NULL', UpperCase(strIPIEnt))) Then
            FIncDet.FieldByName('ITE_IPIENT').AsFloat  := fStrToFloat(AnsiReplaceStr(strIPIEnt, '.', ''));

          if fStrToFloat(strLinha) > 0 Then
            FIncDet.FieldByName('ITE_PRECOM').AsFloat := fStrToFloat(strLinha);

          If (Not fEmptyStr(strIcmEnt)) And (Not SameText('NULL', UpperCase(strIcmEnt))) Then
            FIncDet.FieldByName('ITE_ICMENT').AsFloat  := fStrToFloat(AnsiReplaceStr(strIcmEnt, '.', ''));

          If (Not fEmptyStr(strFreEnt)) And (Not SameText('NULL', UpperCase(strFreEnt))) Then
            FIncDet.FieldByName('ITE_FREENT').AsFloat  := fStrToFloat(AnsiReplaceStr(strFreEnt, '.', ''));

          If (Not fEmptyStr(strValFre)) And (Not SameText('NULL', UpperCase(strValFre))) Then
            FIncDet.FieldByName('ITE_VALFRE').AsFloat  := fStrToFloat(AnsiReplaceStr(strValFre, '.', ''));

          If (Not fEmptyStr(strAcrFin)) And (Not SameText('NULL', UpperCase(strAcrFin))) Then
            FIncDet.FieldByName('ITE_ACRFIN').AsFloat  := fStrToFloat(AnsiReplaceStr(strAcrFin, '.', ''));

          If (Not fEmptyStr(strSubsti)) And (Not SameText('NULL', UpperCase(strSubsti))) Then
            FIncDet.FieldByName('ITE_SUBSTI').AsFloat  := fStrToFloat(AnsiReplaceStr(strSubsti, '.', ''));

          If (Not fEmptyStr(strDesAdb)) And (Not SameText('NULL', UpperCase(strDesAdb))) Then
            FIncDet.FieldByName('ITE_DESADB').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesAdb, '.', ''));

          If (Not fEmptyStr(strSubFed)) And (Not SameText('NULL', UpperCase(strSubFed))) Then
            FIncDet.FieldByName('ITE_SUBFED').AsFloat  := fStrToFloat(AnsiReplaceStr(strSubFed, '.', ''));

          If (Not fEmptyStr(strImpFed)) And (Not SameText('NULL', UpperCase(strImpFed))) Then
            FIncDet.FieldByName('ITE_IMPFED').AsFloat  := fStrToFloat(AnsiReplaceStr(strImpFed, '.', ''));

          If (Not fEmptyStr(strOutVal)) And (Not SameText('NULL', UpperCase(strOutVal))) Then
            FIncDet.FieldByName('ITE_OUTVAL').AsFloat  := fStrToFloat(AnsiReplaceStr(strOutVal, '.', ''));

          If (Not fEmptyStr(strIcmSai)) And (Not SameText('NULL', UpperCase(strIcmSai))) Then
            FIncDet.FieldByName('ITE_ICMSAI').AsFloat  := fStrToFloat(AnsiReplaceStr(strIcmSai, '.', ''));

          If (Not fEmptyStr(strDesOpe)) And (Not SameText('NULL', UpperCase(strDesOpe))) Then
            FIncDet.FieldByName('ITE_DESOPE').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesOpe, '.', ''));

          If (Not fEmptyStr(strCodAbr)) And (Not SameText('NULL', UpperCase(strCodAbr))) Then
            FIncDet.FieldByName('ITE_CODABF').AsString := strCodAbr;

          If Not blntabPrd then
          Begin
            FIncIte.Post;
            FIncDet.Post;
          End;

          If blntabPrd then
          begin
            fltComLiq := FIncDet.FieldByName('ITE_PRECOM').AsFloat  *
                            ( 1 - (FIncDet.FieldByName('ITE_DESF01').AsFloat / 100) ) *
                            ( 1 - (FIncDet.FieldByName('ITE_DESF02').AsFloat / 100) ) *
                            ( 1 - (FIncDet.FieldByName('ITE_DESF03').AsFloat / 100) ) *
                            ( 1 - (FIncDet.FieldByName('ITE_DESF04').AsFloat / 100) ) *
                            ( 1 - (FIncDet.FieldByName('ITE_DESF05').AsFloat / 100) ) *
                            ( 1 - (FIncDet.FieldByName('ITE_DESF06').AsFloat / 100) ) ;
            blnIncidePis := fIncidePis(strCodIte);

            CalculaComposicaoCusto := TCalculaComposicaoCusto.fRetCustoTabDet(FIncDet.FieldByName('ITE_IPIENT').AsFloat,
                                                                              blnIncidePis,
                                                                              strCodForDef,
                                                                              FIncIte.FieldByName('ITE_CODABF').AsString,
                                                                              strAutIncTabDet,
                                                                              strTabela, VS_StrCodEmp);
            Try
              If CalculaComposicaoCusto.blnSemST Then
              begin
                If Not((Not fEmptyStr(strIcmSai)) And (Not SameText('NULL', UpperCase(strIcmSai)))) Then
                  FIncDet.FieldByName('ITE_ICMSAI').AsFloat := CalculaComposicaoCusto.AliquotaICMSSai;
                FIncDet.FieldByName('ITE_ICMENT').AsFloat := CalculaComposicaoCusto.AliquotaICMSEnt;
                FIncDet.FieldByName('ITE_SUBSTI').AsFloat := 0
              End
              Else
              Begin
                FIncDet.FieldByName('ITE_ICMSAI').AsFloat := 0;
                FIncDet.FieldByName('ITE_ICMENT').AsFloat := 0;
                FIncDet.FieldByName('ITE_SUBSTI').AsFloat := CalculaComposicaoCusto.AliquotaST;
              End;

              If Not((Not fEmptyStr(strSubFed)) And (Not SameText('NULL', UpperCase(strSubFed)))) Then
                FIncDet.FieldByName('ITE_IMPFED').AsFloat := CalculaComposicaoCusto.ImpFed;

              If Not ((Not fEmptyStr(strSubFed)) And (Not SameText('NULL', UpperCase(strSubFed)))) Then
                FIncDet.FieldByName('ITE_SUBFED').AsFloat := CalculaComposicaoCusto.SubFed;

              If Not((Not fEmptyStr(strDesOpe)) And (Not SameText('NULL', UpperCase(strDesOpe)))) Then
                FIncDet.FieldByName('ITE_DESOPE').AsFloat := CalculaComposicaoCusto.DesOpe;

              If Not ((Not fEmptyStr(strOutVal)) And (Not SameText('NULL', UpperCase(strOutVal)))) Then
                FIncDet.FieldByName('ITE_OUTVAL').AsFloat := CalculaComposicaoCusto.OutVal;

              If Not blnIncidePis Then
              Begin
                FIncDet.FieldByName('ITE_SUBFED').AsFloat := 0;
                FIncDet.FieldByName('ITE_IMPFED').AsFloat := 0;
              End;

            Finally
              FreeAndNil(CalculaComposicaoCusto);
            End;



            FIncIte.Post;
            FIncDet.Post;

            FIncDet.Edit;
            FIncDet.FieldByName('ITE_CNVCUS').Value := FIncIte.FieldByName('ITE_CNVCUS').AsInteger;
            FIncDet.FieldByName('CNV_PRECOM').Value := FIncDet.FieldByName('ITE_PRECOM').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
            If (Not fEmptyStr(strOutVal)) And (Not SameText('NULL', UpperCase(strOutVal))) Then
            Begin
              FIncDet.FieldByName('CNV_OUTVAL').Value := FIncDet.FieldByName('ITE_OUTVAL').AsFloat;
              FIncDet.FieldByName('ITE_OUTVAL').Value := FIncDet.FieldByName('CNV_OUTVAL').Value * FIncDet.FieldByName('ITE_CNVCUS').AsInteger;
            End;

            If (Not fEmptyStr(strValFre)) And (Not SameText('NULL', UpperCase(strValFre))) Then
            Begin
              FIncDet.FieldByName('CNV_VALFRE').Value := FIncDet.FieldByName('ITE_VALFRE').AsFloat;
              FIncDet.FieldByName('ITE_VALFRE').Value := FIncDet.FieldByName('CNV_VALFRE').Value * FIncDet.FieldByName('ITE_CNVCUS').AsInteger;
            End;
            FIncDet.FieldByName('CNV_PREVEN').Value := FIncDet.FieldByName('ITE_PREVEN').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
            FIncDet.FieldByName('CNV_VENGIR').Value := FIncDet.FieldByName('ITE_VENGIR').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
            FIncDet.FieldByName('CNV_CUSREA').Value := FIncDet.FieldByName('ITE_CUSREA').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
            FIncDet.FieldByName('CNV_COMLIQ').Value := FIncDet.FieldByName('ITE_COMLIQ').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
            FIncDet.FieldByName('CNV_PRECUS').Value := FIncDet.FieldByName('ITE_PRECUS').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
            FIncDet.Post;

            For intTabela := 1 To 7 Do
            Begin
              If intTabela.ToString <> strTabela Then
              Begin
                If FIncDet.Locate('TABELA;ITE_CODITE', VarArrayOf([intTabela.ToString, strCodIte]), []) Then
                Begin
                  FIncDet.Edit;

                  If (Not fEmptyStr(strDesF01)) And (Not SameText('NULL', UpperCase(strDesF01))) Then
                    FIncDet.FieldByName('ITE_DESF01').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF01, '.', ''));

                  If (Not fEmptyStr(strDesF02)) And (Not SameText('NULL', UpperCase(strDesF02))) Then
                    FIncDet.FieldByName('ITE_DESF02').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF02, '.', ''));

                  If (Not fEmptyStr(strDesF03)) And (Not SameText('NULL', UpperCase(strDesF03))) Then
                    FIncDet.FieldByName('ITE_DESF03').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF03, '.', ''));

                  If (Not fEmptyStr(strDesF04)) And (Not SameText('NULL', UpperCase(strDesF04))) Then
                    FIncDet.FieldByName('ITE_DESF04').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF04, '.', ''));

                  If (Not fEmptyStr(strDesF05)) And (Not SameText('NULL', UpperCase(strDesF05))) Then
                    FIncDet.FieldByName('ITE_DESF05').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF05, '.', ''));

                  If (Not fEmptyStr(strDesF06)) And (Not SameText('NULL', UpperCase(strDesF06))) Then
                    FIncDet.FieldByName('ITE_DESF06').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesF06, '.', ''));

                  If (Not fEmptyStr(strPreCom)) And (Not SameText('NULL', UpperCase(strPreCom))) Then
                    FIncDet.FieldByName('ITE_PRECOM').AsFloat  := fStrToFloat(AnsiReplaceStr(strPrecom, '.', ''));

                  If (Not fEmptyStr(strIPIEnt)) And (Not SameText('NULL', UpperCase(strIPIEnt))) Then
                    FIncDet.FieldByName('ITE_IPIENT').AsFloat  := fStrToFloat(AnsiReplaceStr(strIPIEnt, '.', ''));

                  if fStrToFloat(strLinha) > 0 Then
                    FIncDet.FieldByName('ITE_PRECOM').AsFloat := fStrToFloat(strLinha);

                  If (Not fEmptyStr(strIcmEnt)) And (Not SameText('NULL', UpperCase(strIcmEnt))) Then
                    FIncDet.FieldByName('ITE_ICMENT').AsFloat  := fStrToFloat(AnsiReplaceStr(strIcmEnt, '.', ''));

                  If (Not fEmptyStr(strFreEnt)) And (Not SameText('NULL', UpperCase(strFreEnt))) Then
                    FIncDet.FieldByName('ITE_FREENT').AsFloat  := fStrToFloat(AnsiReplaceStr(strFreEnt, '.', ''));

                  If (Not fEmptyStr(strValFre)) And (Not SameText('NULL', UpperCase(strValFre))) Then
                    FIncDet.FieldByName('ITE_VALFRE').AsFloat  := fStrToFloat(AnsiReplaceStr(strValFre, '.', ''));

                  If (Not fEmptyStr(strAcrFin)) And (Not SameText('NULL', UpperCase(strAcrFin))) Then
                    FIncDet.FieldByName('ITE_ACRFIN').AsFloat  := fStrToFloat(AnsiReplaceStr(strAcrFin, '.', ''));

                  If (Not fEmptyStr(strSubsti)) And (Not SameText('NULL', UpperCase(strSubsti))) Then
                    FIncDet.FieldByName('ITE_SUBSTI').AsFloat  := fStrToFloat(AnsiReplaceStr(strSubsti, '.', ''));

                  If (Not fEmptyStr(strDesAdb)) And (Not SameText('NULL', UpperCase(strDesAdb))) Then
                    FIncDet.FieldByName('ITE_DESADB').AsFloat  := fStrToFloat(AnsiReplaceStr(strDesAdb, '.', ''));

                  If (Not fEmptyStr(strSubFed)) And (Not SameText('NULL', UpperCase(strSubFed))) Then
                    FIncDet.FieldByName('ITE_SUBFED').AsFloat  := fStrToFloat(AnsiReplaceStr(strSubFed, '.', ''));

                  If (Not fEmptyStr(strImpFed)) And (Not SameText('NULL', UpperCase(strImpFed))) Then
                    FIncDet.FieldByName('ITE_IMPFED').AsFloat  := fStrToFloat(AnsiReplaceStr(strImpFed, '.', ''));



                  fltComLiq := FIncDet.FieldByName('ITE_PRECOM').AsFloat  *
                                  ( 1 - (FIncDet.FieldByName('ITE_DESF01').AsFloat / 100) ) *
                                  ( 1 - (FIncDet.FieldByName('ITE_DESF02').AsFloat / 100) ) *
                                  ( 1 - (FIncDet.FieldByName('ITE_DESF03').AsFloat / 100) ) *
                                  ( 1 - (FIncDet.FieldByName('ITE_DESF04').AsFloat / 100) ) *
                                  ( 1 - (FIncDet.FieldByName('ITE_DESF05').AsFloat / 100) ) *
                                  ( 1 - (FIncDet.FieldByName('ITE_DESF06').AsFloat / 100) ) ;

                  CalculaComposicaoCusto := TCalculaComposicaoCusto.fRetCustoTabDet(FIncDet.FieldByName('ITE_IPIENT').AsFloat,
                                                                                    blnIncidePis,
                                                                                    strCodForDef,
                                                                                    FIncIte.FieldByName('ITE_CODABF').AsString,
                                                                                    strAutIncTabDet,
                                                                                    intTabela.ToString,
                                                                                    VS_StrCodEmp);
                  Try
                    If CalculaComposicaoCusto.blnSemST Then
                    begin
                      FIncDet.FieldByName('ITE_ICMENT').AsFloat := CalculaComposicaoCusto.AliquotaICMSEnt;
                      FIncDet.FieldByName('ITE_SUBSTI').AsFloat := 0
                    End
                    Else
                    Begin
                      FIncDet.FieldByName('ITE_ICMSAI').AsFloat := 0;
                      FIncDet.FieldByName('ITE_ICMENT').AsFloat := 0;
                      FIncDet.FieldByName('ITE_SUBSTI').AsFloat := CalculaComposicaoCusto.AliquotaST;
                    End;

                    If Not((Not fEmptyStr(strSubFed)) And (Not SameText('NULL', UpperCase(strSubFed)))) Then
                      FIncDet.FieldByName('ITE_IMPFED').AsFloat := CalculaComposicaoCusto.ImpFed;

                    If Not ((Not fEmptyStr(strSubFed)) And (Not SameText('NULL', UpperCase(strSubFed)))) Then
                      FIncDet.FieldByName('ITE_SUBFED').AsFloat := CalculaComposicaoCusto.SubFed;

                    If Not((Not fEmptyStr(strDesOpe)) And (Not SameText('NULL', UpperCase(strDesOpe)))) Then
                      FIncDet.FieldByName('ITE_DESOPE').AsFloat := CalculaComposicaoCusto.DesOpe;

                    If Not ((Not fEmptyStr(strOutVal)) And (Not SameText('NULL', UpperCase(strOutVal)))) Then
                      FIncDet.FieldByName('ITE_OUTVAL').AsFloat := CalculaComposicaoCusto.OutVal;

                    If Not blnIncidePis Then
                    Begin
                      FIncDet.FieldByName('ITE_SUBFED').AsFloat := 0;
                      FIncDet.FieldByName('ITE_IMPFED').AsFloat := 0;
                    End;

                  Finally
                    FreeAndNil(CalculaComposicaoCusto);
                  End;



                  FIncDet.Post;
                  FIncDet.Edit;
                  FIncDet.FieldByName('ITE_CNVCUS').Value := FIncIte.FieldByName('ITE_CNVCUS').AsInteger;
                  FIncDet.FieldByName('CNV_PRECOM').Value := FIncDet.FieldByName('ITE_PRECOM').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;

                  If (Not fEmptyStr(strOutVal)) And (Not SameText('NULL', UpperCase(strOutVal))) Then
                  Begin
                    FIncDet.FieldByName('CNV_OUTVAL').Value := FIncDet.FieldByName('ITE_OUTVAL').AsFloat;
                    FIncDet.FieldByName('ITE_OUTVAL').Value := FIncDet.FieldByName('CNV_OUTVAL').Value * FIncDet.FieldByName('ITE_CNVCUS').AsInteger;
                  End;

                  If (Not fEmptyStr(strValFre)) And (Not SameText('NULL', UpperCase(strValFre))) Then
                  Begin
                    FIncDet.FieldByName('CNV_VALFRE').Value := FIncDet.FieldByName('ITE_VALFRE').AsFloat;
                    FIncDet.FieldByName('ITE_VALFRE').Value := FIncDet.FieldByName('CNV_VALFRE').Value * FIncDet.FieldByName('ITE_CNVCUS').AsInteger;
                  End;

                  FIncDet.FieldByName('CNV_PREVEN').Value := FIncDet.FieldByName('ITE_PREVEN').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
                  FIncDet.FieldByName('CNV_VENGIR').Value := FIncDet.FieldByName('ITE_VENGIR').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
                  FIncDet.FieldByName('CNV_CUSREA').Value := FIncDet.FieldByName('ITE_CUSREA').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
                  FIncDet.FieldByName('CNV_COMLIQ').Value := FIncDet.FieldByName('ITE_COMLIQ').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
                  FIncDet.FieldByName('CNV_PRECUS').Value := FIncDet.FieldByName('ITE_PRECUS').AsFloat / FIncDet.FieldByName('ITE_CNVCUS').AsInteger ;
                  FIncDet.Post;


                End;
              End;
            End;
          End;

         // FCadEmp.Next;
        End;

      Except
        On E : Exception Do
        Begin
          pAdicionaErro(E.Message);
        End;
      End;

    End
    Else If not fEmptyStr(strCodIte) And fProdutoCadastrado(strCodIte) Then
      pAdicionaErro('ITEM INATIVO');

  End;

begin
  pAddDados(ArrTipoIdentificao, 'Código de Barras, se não, Fornecedor + Código Fabrica');
  pAddDados(ArrTipoIdentificao, 'Código de Barras(Atualiza Código de Fabrica, se preenchido)');
  pAddDados(ArrTipoIdentificao, 'Fornecedor + Código Fabrica(Atualiza Código de Barra, se preenchido)');
  pAddDados(ArrTipoIdentificao, 'Código do Item (Atualiza o Código de Fábrica, se preenchido)');
  opcTipoLocalizacaoItem := fIntToTipoLocalizacaoItem(fGetMenu('Escolha a forma de indentificar o produto:', ArrTipoIdentificao, 1, True, False, 300));

  FIncIte.EmptyDataSet;
  FIncDet.EmptyDataSet;

  TipoArquivo := tpaTexto;
  If (LowerCase(ExtractFileExt(FNomArq)) ='csv') Or
     (Pos('xls', LowerCase(ExtractFileExt(FNomArq))) > 0) Then
  TipoArquivo := tpaExcel;
  stlArquivo := TStringList.Create;
  If TipoArquivo = tpaExcel then
    objValidadorExcel := TValidadorExcel.Create(FNomArq, 29, 'D', '');
  qryDados   := fCriarQuery( fSQLItensSelecao + ' AND I.ITE_CODITE = :CODITE', Self);
  cdsErros   := fCriaCdsInconsistencia;
  Try
    If blnTabPrd Then
    Begin
      blnProcessoDeImportacao := True;

      If fMensagem('','Recalcular: ', ['Preço de Venda', 'Margem Bruta'], 1, False, 1, 200) = 1 Then
        ImportacaoOpcMarPre :=  opcPrecoVenda
      Else
        ImportacaoOpcMarPre :=  opcMargem;
      TTabelasDoItem.pInciaProcessoImportacao(ImportacaoOpcMarPre);
    End;

    With cdsIteSel, qryQuery  Do
    Begin
      SQL.Text := fSQLItensSelecao + ' AND FALSE ';
      fAbreClient(True, 'TTabelaPreco.fImportaTXTProgresso');
    End;


    If Assigned(objValidadorExcel) Then
    Begin
      intValIni := IIf(objValidadorExcel.fTemTitulo('D', True), 1 , 0);
      For intContador := intValIni To (objValidadorExcel.ArquivoCSV.Count -1) Do
      Begin
          strCodBar := Trim(objValidadorExcel.fGetValueCSV(intContador, 'A'));
          strCodFab := Trim(objValidadorExcel.fGetValueCSV(intContador, 'B'));
          strDesFab := Trim(objValidadorExcel.fGetValueCSV(intContador, 'C'));
          strPrecom := Trim(objValidadorExcel.fGetValueCSV(intContador, 'D'));
          strDesF01 := Trim(objValidadorExcel.fGetValueCSV(intContador, 'E'));
          strDesF02 := Trim(objValidadorExcel.fGetValueCSV(intContador, 'F'));
          strDesF03 := Trim(objValidadorExcel.fGetValueCSV(intContador, 'G'));
          strDesF04 := Trim(objValidadorExcel.fGetValueCSV(intContador, 'H'));
          strDesF05 := Trim(objValidadorExcel.fGetValueCSV(intContador, 'I'));
          strDesF06 := Trim(objValidadorExcel.fGetValueCSV(intContador, 'J'));
          strIPIEnt := Trim(objValidadorExcel.fGetValueCSV(intContador, 'K'));
          strClaIpi := Trim(objValidadorExcel.fGetValueCSV(intContador, 'L'));
          strCodAbr := Trim(objValidadorExcel.fGetValueCSV(intContador, 'M'));
          If strCodAbr <> '' THen
            strCodAbr := fStrZero(strCodAbr, IIf(fCfgSis('USASAN', varBoolean), 7 ,3));
          strMltCom := Trim(objValidadorExcel.fGetValueCSV(intContador, 'N'));
          strDiaFor := Trim(objValidadorExcel.fGetValueCSV(intContador, 'O'));
          strUniCom := Trim(objValidadorExcel.fGetValueCSV(intContador, 'P'));
          strIcmEnt := Trim(objValidadorExcel.fGetValueCSV(intContador, 'Q'));
          strSubFed := Trim(objValidadorExcel.fGetValueCSV(intContador, 'R'));
          strFreEnt := Trim(objValidadorExcel.fGetValueCSV(intContador, 'S'));
          strValFre := Trim(objValidadorExcel.fGetValueCSV(intContador, 'T'));
          strAcrFin := Trim(objValidadorExcel.fGetValueCSV(intContador, 'U'));
          strSubsti := Trim(objValidadorExcel.fGetValueCSV(intContador, 'V'));
          strDesAdb := Trim(objValidadorExcel.fGetValueCSV(intContador, 'W'));
          strOutVal := Trim(objValidadorExcel.fGetValueCSV(intContador, 'X'));
          strIcmSai := Trim(objValidadorExcel.fGetValueCSV(intContador, 'Y'));
          strImpFed := Trim(objValidadorExcel.fGetValueCSV(intContador, 'Z'));
          strDesOpe := Trim(objValidadorExcel.fGetValueCSV(intContador, 'AA'));
          strCnvCus := Trim(objValidadorExcel.fGetValueCSV(intContador, 'AB'));
          strTabela := Trim(objValidadorExcel.fGetValueCSV(intContador, 'AC'));
          Try
            strImpIte := Trim(objValidadorExcel.fGetValueCSV(intContador, 'AD'));
          Except
            strImpIte := '';
          End;

          if ((not fEmptyStr(strCodBar)) Or (not fEmptyStr(strCodFab))) Then
            pProcessaDados;

          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;
      End;

    End

    Else
    begin
      Case TipoArquivo Of
        tpaExcel : Begin
                    stlArquivo.LoadFromFile(FNomArq);

                    pgbProgresso.Properties.Max := stlArquivo.Count;

                    For intIndex := 0 To stlArquivo.Count - 1 Do
                    Begin

                      strLinha := stlArquivo[intIndex];

                      strCodBar := Trim(fProximoCampo(strLinha));
                      strCodFab := Trim(fProximoCampo(strLinha));
                      strDesFab := Trim(fProximoCampo(strLinha));
                      strPrecom := Trim(fProximoCampo(strLinha));
                      strDesF01 := Trim(fProximoCampo(strLinha));
                      strDesF02 := Trim(fProximoCampo(strLinha));
                      strDesF03 := Trim(fProximoCampo(strLinha));
                      strDesF04 := Trim(fProximoCampo(strLinha));
                      strDesF05 := Trim(fProximoCampo(strLinha));
                      strDesF06 := Trim(fProximoCampo(strLinha));
                      strIPIEnt := Trim(fProximoCampo(strLinha));
                      strClaIpi := Trim(fProximoCampo(strLinha));
                      strCodAbr := Trim(fProximoCampo(strLinha));
                      strMltCom := Trim(fProximoCampo(strLinha));
                      strDiaFor := Trim(fProximoCampo(strLinha));
                      strUniCom := Trim(fProximoCampo(strLinha));
                      strIcmEnt := Trim(fProximoCampo(strLinha));
                      strSubFed := Trim(fProximoCampo(strLinha));
                      strFreEnt := Trim(fProximoCampo(strLinha));
                      strValFre := Trim(fProximoCampo(strLinha));
                      strAcrFin := Trim(fProximoCampo(strLinha));
                      strSubsti := Trim(fProximoCampo(strLinha));
                      strDesAdb := Trim(fProximoCampo(strLinha));
                      strOutVal := Trim(fProximoCampo(strLinha));
                      strIcmSai := Trim(fProximoCampo(strLinha));
                      strImpFed := Trim(fProximoCampo(strLinha));
                      strDesOpe := Trim(fProximoCampo(strLinha));
                      strCnvCus := Trim(fProximoCampo(strLinha));
                      strTabela := Trim(fProximoCampo(strLinha));
                      strImpIte := Trim(fProximoCampo(strLinha));

                      pProcessaDados;

                      pgbProgresso.Position := pgbProgresso.Position + 1;
                      Application.ProcessMessages;
                    End;

                  End;
      End;
    End;
    cdsIteSel.First;

    if cdsErros.RecordCount > 0 Then
    Begin
      pCriarFormularios(TfrmTabelaPrecoInconsistencia, frmTabelaPrecoInconsistencia);
      frmTabelaPrecoInconsistencia.frxRelatorio.DataSet := cdsErros;
      pPreviewReport('frmTabelaPrecoInconsistencia', 'Tabela de Preços Inconsistências', frmTabelaPrecoInconsistencia.frxReport);
      FreeAndNil(frmTabelaPrecoInconsistencia);
    End;

    Result := True;
  Finally
    If assigned(objValidadorExcel) Then
      FreeAndNil(objValidadorExcel);
    FreeAndNil(cdsErros);
    FreeAndNil(qryDados);
    FreeAndNil(stlArquivo);
    blnProcessoDeImportacao := False;
    TTabelasDoItem.pFinalizaProcessoImportacao;

  End;

end;

function TTabelaPreco.fIntToTipoLocalizacaoItem(
  int: integer): TTipoLocalizacaoItem;
begin
  Result := tliCodBarOuFornecedor_CodFabrica;
  case int of
    1: result := tliCodBarOuFornecedor_CodFabrica;
    2: result := tliCodBarras;
    3: result := tliFornecedor_CodFabrica;
    4: result := tliCodItem;
  End;

end;

Function TTabelaPreco.fExisteItemCodBarCarregado(strCodBar: String; Var strCodIte: String): Boolean;
Begin
  Result := Self.Locate('TFO_CODBAR', strCodBar, []);
  If Result Then
    strCodIte := Self.FieldByName('ITE_CODITE').AsString;
End;

Function TTabelaPreco.fExisteItemCodFabCarregado(strCodFab: String; Var strCodIte: String): Boolean;
Begin
  Result := Self.Locate('ITE_CODFAB', strCodFab, []);
  If Result Then
    strCodIte := Self.FieldByName('ITE_CODITE').AsString;
End;

Function TTabelaPreco.fExisteItemCodBar(strCodBar: String; Var strCodIte: String): Boolean;
  Var
    qryGen: TUniquery;
Begin
  strCodIte := '';

  If fEmptyStr(strCodBar) Then
  Begin
    Result := False;
    Exit;
  End;

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT ITE_CODITE FROM CADITE');
    Add('WHERE');
    Add('  ITE_CODBAR = :CODBAR');

    ParamByName('CODBAR').AsString := strCodBar;

    Open;
    Result := Not IsEmpty;
    If Result Then
      strCodIte := FieldByName('ITE_CODITE').AsString;
    Close;
  End;

  FreeAndNil(qryGen);
End;


function TTabelaPreco.fExisteIteBar(strCodBar: String; Var strCodIte : String) : Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;

begin
  Try

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_CODITE AS CODITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEBAR ';
    strSQL := strSQL + 'INNER JOIN CADITE ON ITE_CODITE = BAR_CODITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  BAR_CODBAR = :CODBAR  ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBAR').AsString := strCodBar;
      Open;
      If IsEmpty Then
        Result := False
      Else
      Begin
        Result := True;
        strCodIte := FieldByName('CODITE').AsString;
      End;
      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

Function TTabelaPreco.fExisteItemCodItemFornecedor(strCodItemF, strCodFor: String; Var strCodIte: String; blnSoTabAti : Boolean): Boolean;
  Var
    qryGen: TUniquery;
Begin
  strCodIte := '';
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT ');
    Add('  ITE_CODITE  ');
    Add('FROM ');
    Add('  ITEFOR ');

    If fCfgSis('TABPRF', varBoolean) And blnSoTabAti Then
    Begin
      Add('INNER JOIN TABPRE ON ITE_CODTAB = TAB_CODTAB AND ');
      Add('                     TAB_ATICMP = "S"            ');
    End;

    Add('WHERE');

    Add('  ITE_CODFOR = :CODFOR AND ');
    If fCfgSis('TABPRF', varBoolean) Then
      Add('  ITE_CODFAB = :CODITF     ')
    Else
      Add('  ITE_CODITF = :CODITF     ');

    ParamByName('CODITF').AsString := strCodItemF;
    ParamByName('CODFOR').AsString := strCodFor;

    Open;
    Result := Not IsEmpty;

    If Result Then
      strCodIte := FieldByName('ITE_CODITE').AsString;

    Close;
  End;

  FreeAndNil(qryGen);
End;

Function TTabelaPreco.fExisteItemCodFab(strCodFab, strCodFor: String; Var strCodIte: String; blnBuscaPorRefere : Boolean): Boolean;
  Var
    qryGen: TUniquery;
    strIte: String;
Begin
	strIte   	:= '';
  strCodIte := '';

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT ');
    Add('  ITE_CODITE, ');
    Add('  ITE_DESITE, ');
    Add('  UNI_SIGUNI  ');
    Add('FROM ');
    Add('  CADITE ');
    Add('  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ');
    Add('WHERE');

    if blnBuscaPorRefere Then
      Add('  ITE_REFERE = :CODFAB ')
    Else
      Add('  ITE_CODFAB = :CODFAB ');

    If Not fEmptyStr(strCodFor) Then
      Add('  AND ITE_CODFOR = :CODFOR ');

    ParamByName('CODFAB').AsString := strCodFab;

    If Not fEmptyStr(strCodFor) Then
      ParamByName('CODFOR').AsString := strCodFor;

    Open;
    Result := Not IsEmpty;
    If Result Then
    Begin
       strCodIte := FieldByName('ITE_CODITE').AsString;
    End;

    Close;

  End;

  FreeAndNil(qryGen);

  if (not Result) And (Not blnBuscaPorRefere) Then
    Result := fExisteItemCodFab(strCodFab, strCodFor, strCodIte, True);
End;

Function TTabelaPreco.fExisteItemCodIte(ACodIte: String; Var strCodIte: String): Boolean;
  Var
    qryGen: TUniquery;
Begin
  If fEmptyStr(ACodIte) Then
  Begin
    Result := False;
    Exit;
  End;

  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Add('SELECT COUNT(1) AS QTD FROM CADITE');
    qryGen.SQL.Add('WHERE ITE_CODITE = :CODITE');
    qryGen.ParamByName('CODITE').AsString := ACodIte;
    qryGen.Open;
    Result := qryGen.FieldByName('QTD').AsInteger > 0;
    If Result Then
      strCodIte := ACodIte;
    qryGen.Close;
  Finally
    FreeAndNil(qryGen);
  End;
End;

Procedure TTabelaPreco.pCarregaDadosSugestaoHeranca(strCodIte, strCodEmp: String);
  Var
    intContador: Integer;
Begin
//  If Self.Locate('ITE_CODITE;ITE_CODEMP', VarArrayOf([strCodIte, strCodEmp]), []) Then
  If Self.Locate('ITE_CODITE', strCodIte, []) Then
  Begin
    For intContador := 0 To FIncIte.FieldCount - 1 Do
       If (Self.FindField(FIncIte.Fields[intContador].FieldName) <> Nil) And
          (Pos(FIncIte.Fields[intContador].FieldName,
          'AUTOINCREM-ITE_CODEMP-ITE_CODITE-ITE_CODFOR_') <= 0) Then
         FIncIte.Fields[intContador].Value :=
           Self.FieldByName(FIncIte.Fields[intContador].FieldName).Value;


  End;
End;

function TTabelaPreco.fSQLItensSelecao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  I.ITE_CODITE,        ';
  strSQL := strSQL + '  I.ITE_CODBAR,        ';
  strSQL := strSQL + '  I.ITE_CODGRU,        ';
  strSQL := strSQL + '  I.ITE_DESITE,        ';
  strSQL := strSQL + '  I.ITE_REFERE AS TFO_REFERE, ';
  strSQL := strSQL + '  I.ITE_BAREMB AS TFO_BAREMB, ';
  strSQL := strSQL + '  I.ITE_EMBALA AS TFO_EMBALA, ';
  strSQL := strSQL + '  I.ITE_CODBAR AS TFO_CODBAR, ';
  strSQL := strSQL + '  I.ITE_CODFAB,        ';
  strSQL := strSQL + '  I.ITE_DIAFOR,        ';
  strSQL := strSQL + '  I.ITE_PESOIT AS TFO_PESOIT, ';
  strSQL := strSQL + '  I.ITE_NOTESP AS TFO_NOTESP, ';
  strSQL := strSQL + '  I.ITE_SITPRO AS TFO_SITPRO, ';
  strSQL := strSQL + '  I.ITE_ABFPIS, ';
  strSQL := strSQL + '  I.ITE_ABFCOF, ';
  strSQL := strSQL + '  I.ITE_ABFIPI, ';

  strSQL := strSQL + '  UNI_SIGUNI,        ';
  strSQL := strSQL + '  ITE_CODFOR,        ';
  strSQL := strSQL + '  FOR_NOMFOR,        ';
  strSQL := strSQL + '  I.ITE_CODMAR,        ';
  strSQL := strSQL + '  MAR_DESMAR,        ';

  If intTipAbf = 1 Then
    strSQL := strSQL + '  I.ITE_CODABF,    '
  Else
    strSQL := strSQL + '  G.ITE_CODABF,    ';

  strSQL := strSQL + '  I.ITE_EXCIPI,        ';
  strSQL := strSQL + '  I.ITE_CLAIPI,        ';
  strSQL := strSQL + '  I.ITE_MLTCOM,        ';
  strSQL := strSQL + '  I.ITE_UNICOM         ';

  strSQL := strSQL + ' FROM                ';
  strSQL := strSQL + '   CADITE I          ';

  strSQL := strSQL + ' INNER JOIN ITEGER G       ';
  strSQL := strSQL + '    ON G.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '   AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = I.ITE_CODFOR ';
  strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = I.ITE_CODMAR ';

  strSQL := strSQL + ' WHERE               ';
  strSQL := strSQL + '   I.ITE_ITEATI = "S"  ';

  Result := strSQL;
end;

function TTabelaPreco.fCriaCdsInconsistencia : TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODBAR';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODFAB';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESFAB';
    DataType := ftString;
    Size     := 60;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESF01';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESF02';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESF03';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESF04';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESF05';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESF06';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PRECOM';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'IPIENT';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESCRI';
    DataType := ftString;
    Size     := 100;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CLAIPI';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODABR';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MLTCOM';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DIAFOR';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'UNICOM';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ICMENT';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'SUBFED';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FREENT';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALFRE';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ACRFIN';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'SUBSTI';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESADB';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'OUTVAL';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ICMSAI';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'IMPFED';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESOPE';
    DataType := ftString;
    Size     := 20;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CNVCUS';
    DataType := ftString;
    Size     := 20;
  End;
  Result.CreateDataSet;
End;

procedure TTabelaPreco.cdsIteSelAfterScroll(DataSet: TDataSet);
begin
  FIncIte.Locate('ITE_CODITE', VarArrayOf([cdsIteSel.FieldByName('ITE_CODITE').AsString]), []);
end;

procedure TTabelaPreco.cdsIteSelBeforeDelete(DataSet: TDataSet);
begin
  While FIncDet.Locate('ITE_CODITE', VarArrayOf([cdsIteSel.FieldByName('ITE_CODITE').AsString]), []) Do
    FIncDet.Delete;

  While FIncIte.Locate('ITE_CODITE', VarArrayOf([cdsIteSel.FieldByName('ITE_CODITE').AsString]), []) Do
    FIncIte.Delete;
end;

Function TTabelaPreco.fSQLIteger: String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT          ';
  strSQL := strSQL + '   G.ITE_CODITE, ';
  strSQL := strSQL + '   C.ITE_CODFOR, ';
  strSQL := strSQL + '   C.ITE_CODFAB, ';
  strSQL := strSQL + '     FOR_NOMFOR, ';

  For intContador := 1 To 7 Do
  Begin
    strSQL := strSQL + '   ITE_MARBR' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '   ITE_PREVE' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '   ITE_COMTB' + IntToStr(intContador) + ', ';
  End;

  strSQL := strSQL + ' ITE_PREDOL,  ';
  strSQL := strSQL + ' ITE_PRECOM,  ';
  strSQL := strSQL + ' ITE_DESF01,  ';
  strSQL := strSQL + ' ITE_DESF02,  ';
  strSQL := strSQL + ' ITE_DESF03,  ';
  strSQL := strSQL + ' ITE_DESF04,  ';
  strSQL := strSQL + ' ITE_DESF05,  ';
  strSQL := strSQL + ' ITE_DESF06,  ';
  strSQL := strSQL + ' ITE_ICMENT,  ';
  strSQL := strSQL + ' ITE_SUBFED,  ';
  strSQL := strSQL + ' ITE_IPIENT,  ';
  strSQL := strSQL + ' ITE_FREENT,  ';
  strSQL := strSQL + ' ITE_VALFRE,  ';
  strSQL := strSQL + ' ITE_ACRFIN,  ';
  strSQL := strSQL + ' ITE_SUBSTI,  ';
  strSQL := strSQL + ' ITE_DESADB,  ';
  strSQL := strSQL + ' ITE_PRECUS,  ';
  strSQL := strSQL + ' ITE_OUTVAL,  ';
  strSQL := strSQL + ' ITE_ICMSAI,  ';
  strSQL := strSQL + ' ITE_IMPFED,  ';
  strSQL := strSQL + ' ITE_DESOPE,  ';
  strSQL := strSQL + ' ITE_TCIFCU,  ';
  strSQL := strSQL + ' ITE_TSCUST,  ';
  strSQL := strSQL + ' ITE_DEPICO,  ';
  strSQL := strSQL + ' ITE_DEICMS,  ';
  strSQL := strSQL + ' ITE_PREALT,  ';
  strSQL := strSQL + ' ITE_FATREG   ';

  strSQL := strSQL + ' FROM       ';
  strSQL := strSQL + '   ITEGER G ';
  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + ' LEFT  JOIN CADFOR   ON   FOR_CODFOR =   ITE_CODFOR ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   G.ITE_CODITE = :CODITE AND G.ITE_CODEMP = :CODEMP ';

  Result := strSQL;
End;

Function TTabelaPreco.fSQLNovosPrecos: String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT        ';
  strSQL := strSQL + '   C.ITE_CODITE, ';
  strSQL := strSQL + '   ITE_CODFAB, ';
  strSQL := strSQL + '   ITE_CODFAB AS ITE_CODFAB_NOV, ';
  strSQL := strSQL + '   ITE_DESITE, ';
  strSQL := strSQL + '   ITE_CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR, ';
  strSQL := strSQL + '   ITE_PREALT, ';

  strSQL := strSQL + '   "Preço de Venda" AS TIPATU, ';
  strSQL := strSQL + '   "S" AS MARDES, ';

  For intContador := 1 To 7 Do
  Begin
    strSQL := strSQL + '   ITE_MARBR' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '   ITE_PREVE' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '   ITE_COMTB' + IntToStr(intContador) + ', ';

    strSQL := strSQL + '   ITE_MARBR' + IntToStr(intContador) + ' AS ITE_MARBR' + IntToStr(intContador) + '_NOV, ';
    strSQL := strSQL + '   ITE_PREVE' + IntToStr(intContador) + ' AS ITE_PREVE' + IntToStr(intContador) + '_NOV, ';
  End;

  strSQL := strSQL + ' ITE_PREDOL,  ';
  strSQL := strSQL + ' ITE_PRECOM,  ';
  strSQL := strSQL + ' ITE_DESF01,  ';
  strSQL := strSQL + ' ITE_DESF02,  ';
  strSQL := strSQL + ' ITE_DESF03,  ';
  strSQL := strSQL + ' ITE_DESF04,  ';
  strSQL := strSQL + ' ITE_DESF05,  ';
  strSQL := strSQL + ' ITE_DESF06,  ';
  strSQL := strSQL + ' ITE_ICMENT,  ';
  strSQL := strSQL + ' ITE_SUBFED,  ';
  strSQL := strSQL + ' ITE_IPIENT,  ';

  strSQL := strSQL + ' ITE_FREENT,  ';
  strSQL := strSQL + ' ITE_VALFRE,  ';
  strSQL := strSQL + ' ITE_ACRFIN,  ';
  strSQL := strSQL + ' ITE_SUBSTI,  ';
  strSQL := strSQL + ' ITE_DESADB,  ';
  strSQL := strSQL + ' ITE_PRECUS,  ';
  strSQL := strSQL + ' ITE_OUTVAL,  ';
  strSQL := strSQL + ' ITE_ICMSAI,  ';
  strSQL := strSQL + ' ITE_IMPFED,  ';
  strSQL := strSQL + ' ITE_DESOPE,  ';
  strSQL := strSQL + ' ITE_TCIFCU,  ';
  strSQL := strSQL + ' ITE_TSCUST,  ';
  strSQL := strSQL + ' ITE_DEPICO,  ';
  strSQL := strSQL + ' ITE_DEICMS,  ';
  strSQL := strSQL + ' ITE_FATREG,  ';

  strSQL := strSQL + ' ITE_PREDOL AS ITE_PREDOL_NOV,  ';
  strSQL := strSQL + ' ITE_PRECOM AS ITE_PRECOM_NOV,  ';
  strSQL := strSQL + ' ITE_DESF01 AS ITE_DESF01_NOV,  ';
  strSQL := strSQL + ' ITE_DESF02 AS ITE_DESF02_NOV,  ';
  strSQL := strSQL + ' ITE_DESF03 AS ITE_DESF03_NOV,  ';
  strSQL := strSQL + ' ITE_DESF04 AS ITE_DESF04_NOV,  ';
  strSQL := strSQL + ' ITE_DESF05 AS ITE_DESF05_NOV,  ';
  strSQL := strSQL + ' ITE_DESF06 AS ITE_DESF06_NOV,  ';
  strSQL := strSQL + ' ITE_ICMENT AS ITE_ICMENT_NOV,  ';
  strSQL := strSQL + ' ITE_SUBFED AS ITE_SUBFED_NOV,  ';
  strSQL := strSQL + ' ITE_IPIENT AS ITE_IPIENT_NOV,  ';
  strSQL := strSQL + ' ITE_FREENT AS ITE_FREENT_NOV,  ';
  strSQL := strSQL + ' ITE_VALFRE AS ITE_VALFRE_NOV,  ';
  strSQL := strSQL + ' ITE_ACRFIN AS ITE_ACRFIN_NOV,  ';
  strSQL := strSQL + ' ITE_SUBSTI AS ITE_SUBSTI_NOV,  ';
  strSQL := strSQL + ' ITE_DESADB AS ITE_DESADB_NOV,  ';
  strSQL := strSQL + ' ITE_PRECUS AS ITE_PRECUS_NOV,  ';
  strSQL := strSQL + ' ITE_OUTVAL AS ITE_OUTVAL_NOV,  ';
  strSQL := strSQL + ' ITE_ICMSAI AS ITE_ICMSAI_NOV,  ';
  strSQL := strSQL + ' ITE_IMPFED AS ITE_IMPFED_NOV,  ';
  strSQL := strSQL + ' ITE_DESOPE AS ITE_DESOPE_NOV,  ';
  strSQL := strSQL + ' ITE_TCIFCU AS ITE_TCIFCU_NOV,  ';
  strSQL := strSQL + ' ITE_TSCUST AS ITE_TSCUST_NOV,  ';
  strSQL := strSQL + ' ITE_DEPICO AS ITE_DEPICO_NOV,  ';
  strSQL := strSQL + ' ITE_DEICMS AS ITE_DEICMS_NOV,  ';
  strSQL := strSQL + ' ITE_FATREG AS ITE_FATREG_NOV   ';

  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   CADITE C ';
  strSQL := strSQL + '   LEFT  JOIN CADFOR   ON   FOR_CODFOR =   ITE_CODFOR ';
  strSQL := strSQL + '   INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND FALSE ';

  Result := strSQL;
End;

Function TTabelaPreco.fCarregaPrecos: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Carregando preços, aguarde...';
    frmGravando.fExecutarAcao := fCarregaPrecosPrg;

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TTabelaPreco.fCarregaPrecos]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Function TTabelaPreco.fCarregaPrecosPrg(prgProgresso: TCXProgressBar): Boolean;
  Var
    qryIteger: TUniQuery;
    intContador: Integer;
    fltCnvCus,
    fltPreCus: Double;
Begin
  Try
    prgProgresso.Properties.Max := Self.RecordCount;

    FNovPre.Filtered := False;

    Result := FNovPre.fAbreClient(True);

    If Not Result Then
    Begin
      pMensagemOk(FNovPre.strMsgErr);
      Exit;
    End;

    FNovPre.pAlinhaCampoCentro('ITE_CODITE');
    FNovPre.pAlinhaCampoCentro('TIPATU');
    FNovPre.pAlinhaCampoCentro('ITE_CODFOR');

    qryIteger := fCriaQuery;

    qryIteger.SQL.Text := fSQLIteger;

    FNovPre.BeforePost := Nil;

    pLimpaMasterTabDet(cdsTabDet);
    cdsTabDet.IndexFieldNames := 'ITE_CODITE';

    DisableControls;
    First;

    While Not Eof Do
    Begin
      qryIteger.Close;
      qryIteger.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      qryIteger.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryIteger.Open;

      If cdsTabDet.FindKey([FieldByName('ITE_CODITE').AsString]) Then
      Begin
        If Self.FieldByName('ITE_CNVCUS').AsFloat <> 0 Then
          fltCnvCus := Self.FieldByName('ITE_CNVCUS').AsFloat
        Else
          fltCnvCus := 1;

        fltPreCus := RoundTo(cdsTabDet.FieldByName('ITE_PRECUS').AsFloat / fltCnvCus, - intDecUni);

        If (Not qryIteger.IsEmpty) And (fltPreCus > 0) And
           (RoundTo(fltPreCus, - intDecUni) <>  RoundTo(qryIteger.FieldByName('ITE_PRECUS').AsFloat, - intDecUni)) Then
        Begin
          FNovPre.Insert;

          For intContador := 0 To qryIteger.Fields.Count - 1 Do
            FNovPre.FieldbyName(qryIteger.Fields[intContador].FieldName).Value := qryIteger.Fields[intContador].Value;

          FNovPre.FieldByName('ITE_DESITE').AsString     := FieldByName('ITE_DESITE').AsString;
          FNovPre.FieldByName('ITE_CODFAB_NOV').AsString := FieldByName('ITE_CODFAB').AsString;

          FNovPre.FieldByName('MARDES').AsString := 'S';

          If FTipAtu = 'P' Then
            FNovPre.FieldByName('TIPATU').AsString := 'Preço de Venda'
          Else
            FNovPre.FieldByName('TIPATU').AsString := 'Margem';

          FNovPre.FieldByName('ITE_PREDOL_NOV').Value   := cdsTabDet.FieldByName('ITE_PREDOL').Value;
          FNovPre.FieldByName('ITE_PRECOM_NOV').AsFloat := cdsTabDet.FieldByName('ITE_PRECOM').AsFloat / fltCnvCus;
          FNovPre.FieldByName('ITE_DESF01_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DESF01').AsFloat;
          FNovPre.FieldByName('ITE_DESF02_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DESF02').AsFloat;
          FNovPre.FieldByName('ITE_DESF03_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DESF03').AsFloat;
          FNovPre.FieldByName('ITE_DESF04_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DESF04').AsFloat;
          FNovPre.FieldByName('ITE_DESF05_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DESF05').AsFloat;
          FNovPre.FieldByName('ITE_DESF06_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DESF06').AsFloat;
          FNovPre.FieldByName('ITE_ICMENT_NOV').AsFloat := cdsTabDet.FieldByName('ITE_ICMENT').AsFloat;
          FNovPre.FieldByName('ITE_SUBFED_NOV').AsFloat := cdsTabDet.FieldByName('ITE_SUBFED').AsFloat;
          FNovPre.FieldByName('ITE_IPIENT_NOV').AsFloat := cdsTabDet.FieldByName('ITE_IPIENT').AsFloat;
          FNovPre.FieldByName('ITE_FREENT_NOV').AsFloat := cdsTabDet.FieldByName('ITE_FREENT').AsFloat;
          FNovPre.FieldByName('ITE_VALFRE_NOV').AsFloat := cdsTabDet.FieldByName('ITE_VALFRE').AsFloat;
          FNovPre.FieldByName('ITE_ACRFIN_NOV').AsFloat := cdsTabDet.FieldByName('ITE_ACRFIN').AsFloat;
          FNovPre.FieldByName('ITE_SUBSTI_NOV').AsFloat := cdsTabDet.FieldByName('ITE_SUBSTI').AsFloat;
          FNovPre.FieldByName('ITE_DESADB_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DESADB').AsFloat;
          FNovPre.FieldByName('ITE_OUTVAL_NOV').AsFloat := cdsTabDet.FieldByName('ITE_OUTVAL').AsFloat;
          FNovPre.FieldByName('ITE_ICMSAI_NOV').AsFloat := cdsTabDet.FieldByName('ITE_ICMSAI').AsFloat;
          FNovPre.FieldByName('ITE_IMPFED_NOV').AsFloat := cdsTabDet.FieldByName('ITE_IMPFED').AsFloat;
          FNovPre.FieldByName('ITE_DESOPE_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DESOPE').AsFloat;
          FNovPre.FieldByName('ITE_TCIFCU_NOV').AsFloat := cdsTabDet.FieldByName('ITE_TCIFCU').AsFloat;
          FNovPre.FieldByName('ITE_TSCUST_NOV').AsFloat := cdsTabDet.FieldByName('ITE_TSCUST').AsFloat;
          FNovPre.FieldByName('ITE_DEPICO_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DEPICO').AsFloat;
          FNovPre.FieldByName('ITE_DEICMS_NOV').AsFloat := cdsTabDet.FieldByName('ITE_DEICMS').AsFloat;
          FNovPre.FieldByName('ITE_FATREG_NOV').AsFloat := cdsTabDet.FieldByName('ITE_FATREG').AsFloat;

          FNovPre.FieldByName('ITE_PRECUS_NOV').AsFloat := fRetPrecoCusto(FNovPre, '_NOV');

          pRecalculaPrecosNovPre;

          FNovPre.Post;
        End;

      End; {If cdsTabDet.FindKey(FieldByName('ITE_CODITE').AsString) Then}

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    FreeAndNil(qryIteger);

    Result := True;

    FNovPre.BeforePost := pBeforePostNovPre;

    EnableControls;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TTabelaPreco.fCarregaPrecosPrg]');
    End;
  End;

End;

Procedure TTabelaPreco.pRecalculaPrecosNovPre;
  Var
    intContador: Integer;
Begin
  For intContador := 1 To 7 Do
  Begin

    If FNovPre.FieldByName('TIPATU').AsString[1] = 'P' Then
    Begin
      FNovPre.FieldByName('ITE_MARBR' + IntToStr(intContador) + '_NOV').AsFloat := FNovPre.FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat;

      FNovPre.FieldByName('ITE_PREVE' + IntToStr(intContador) + '_NOV').AsFloat :=
            fCalculaPrecoVenda(1,
                               FNovPre.FieldByName('ITE_PRECUS_NOV').AsFloat + FNovPre.FieldByName('ITE_OUTVAL_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_PREVE' + IntToStr(intContador) + '_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_MARBR' + IntToStr(intContador) + '_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_ICMSAI_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_IMPFED_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_DESOPE_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat);

    End Else
    Begin
      FNovPre.FieldByName('ITE_PREVE' + IntToStr(intContador) + '_NOV').AsFloat := FNovPre.FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat;

      FNovPre.FieldByName('ITE_MARBR' + IntToStr(intContador) + '_NOV').AsFloat :=
            fCalculaPrecoVenda(2,
                               FNovPre.FieldByName('ITE_PRECUS_NOV').AsFloat + FNovPre.FieldByName('ITE_OUTVAL_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_PREVE' + IntToStr(intContador) + '_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_MARBR' + IntToStr(intContador) + '_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_ICMSAI_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_IMPFED_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_DESOPE_NOV').AsFloat,
                               FNovPre.FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat);
    End;

  End;
End;

Function TTabelaPreco.fComparaPrecos: Boolean;
  Var
    frmAtuCadProdutosIteFor : TfrmAtuCadProdutosIteFor;
Begin
  Try
    If blnTabPrD Then
    Begin
      Result := True;
      Exit;
    End;

    If Not FPreFor Then
    Begin
      Result := True;
      Exit;
    End;

    If Not fCarregaPrecos Then
    Begin
      Result := False;
      Exit;
    End;

    If FNovPre.IsEmpty Then
    Begin
      Result := True;
      Exit;
    End;

    pCriarFormularios(TfrmAtuCadProdutosIteFor, frmAtuCadProdutosIteFor);

    frmAtuCadProdutosIteFor.objTabPre := Self;
    frmAtuCadProdutosIteFor.cxvItens.DataController.DataSource := FNovPre.dtsSource;

    Result := frmAtuCadProdutosIteFor.ShowModal = mrOk;

    FAtualizaPrecos := Result And frmAtuCadProdutosIteFor.blnAtuPre;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TTabelaPreco.fComparaPrecos]');
      Result := False;
    End;
  End;

  FreeAndNil(frmAtuCadProdutosIteFor);
End;

Procedure TTabelaPreco.pMarcaNovosPrecos;
Begin
  With FNovPre Do
  Begin
    If IsEmpty Then
      Exit;

    Edit;

    If FieldByName('MARDES'). AsString = 'N' Then
      FieldByName('MARDES'). AsString := 'S'
    Else
      FieldByName('MARDES'). AsString := 'N';

    Post;
  End;
End;

Function TTabelaPreco.fMarcaTodosPrg(prgProgresso: TCXProgressBar): Boolean;
Begin
  With FNovPre Do
  Try
    prgProgresso.Properties.Max := Self.RecordCount;

    DisableControls;

    FNovPre.BeforePost := Nil;

    First;

    While Not Eof Do
    Begin

      Edit;

      If FMarcar Then
        FieldByName('MARDES'). AsString := 'S'
      Else
        FieldByName('MARDES'). AsString := 'N';

      Post;

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Result := True;

    EnableControls;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TTabelaPreco.fCarregaPrecosPrg]');
    End;
  End;

  FNovPre.BeforePost := pBeforePostNovPre;

End;

Procedure TTabelaPreco.pMarcaTodos(blnMarcar: Boolean);
Begin
  Try
    FMarcar := blnMarcar;

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Atualizando, aguarde...';

    frmGravando.fExecutarAcao := fMarcaTodosPrg;

    frmGravando.ShowModal;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(e.Message, '[TTabelaPreco.pMarcaTodos]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Function TTabelaPreco.fTemProdutoMarcado: Boolean;
Begin
  With FNovPre Do
  Result := Locate('MARDES', 'S', []);
End;

Procedure TTabelaPreco.pBeforePostNovPre(dataSet: TDataSet);
Begin
  pRecalculaPrecosNovPre;
End;

Procedure TTabelaPreco.pPostNovoPreco;
Begin
  With FNovPre Do
  If State = dsEdit Then
    Post;
End;

Function TTabelaPreco.fUpdateIteger(blnResFor: Boolean): String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE ITEGER G, CADITE C SET ';

  strSQL := strSQL + '   C.ITE_CODFAB = IF(:ITE_CODFAB_NOV <> "", :ITE_CODFAB_NOV, C.ITE_CODFAB), ';

  strSQL := strSQL + ' ITE_PREDOL = :ITE_PREDOL_NOV,  ';
  strSQL := strSQL + ' ITE_PRECOM = :ITE_PRECOM_NOV,  ';
  strSQL := strSQL + ' ITE_PREALT = :PREALT,  ';
  strSQL := strSQL + ' ITE_DESF01 = :ITE_DESF01_NOV,  ';
  strSQL := strSQL + ' ITE_DESF02 = :ITE_DESF02_NOV,  ';
  strSQL := strSQL + ' ITE_DESF03 = :ITE_DESF03_NOV,  ';
  strSQL := strSQL + ' ITE_DESF04 = :ITE_DESF04_NOV,  ';
  strSQL := strSQL + ' ITE_DESF05 = :ITE_DESF05_NOV,  ';
  strSQL := strSQL + ' ITE_DESF06 = :ITE_DESF06_NOV,  ';
  strSQL := strSQL + ' ITE_IPIENT = :ITE_IPIENT_NOV,  ';
  strSQL := strSQL + ' ITE_FREENT = :ITE_FREENT_NOV,  ';
  strSQL := strSQL + ' ITE_VALFRE = :ITE_VALFRE_NOV,  ';
  strSQL := strSQL + ' ITE_ICMENT = :ITE_ICMENT_NOV,  ';
  strSQL := strSQL + ' ITE_SUBFED = :ITE_SUBFED_NOV,  ';
  strSQL := strSQL + ' ITE_ACRFIN = :ITE_ACRFIN_NOV,  ';
  strSQL := strSQL + ' ITE_SUBSTI = :ITE_SUBSTI_NOV,  ';
  strSQL := strSQL + ' ITE_PRECUS = :ITE_PRECUS_NOV   ';

  If Not blnResFor Then
  Begin
    strSQL := strSQL + ' , ';

    For intContador := 1 To 7 Do
    Begin
      strSQL := strSQL + '   ITE_MARBR' + IntToStr(intContador) + ' = :ITE_MARBR' + IntToStr(intContador) + '_NOV, ';
      strSQL := strSQL + '   ITE_PREVE' + IntToStr(intContador) + ' = :ITE_PREVE' + IntToStr(intContador) + '_NOV, ';
    End;

    strSQL := strSQL + ' ITE_DESADB = :ITE_DESADB_NOV,  ';
    strSQL := strSQL + ' ITE_OUTVAL = :ITE_OUTVAL_NOV,  ';
    strSQL := strSQL + ' ITE_TCIFCU = :ITE_TCIFCU_NOV,  ';
    strSQL := strSQL + ' ITE_TSCUST = :ITE_TSCUST_NOV,  ';
    strSQL := strSQL + ' ITE_DEPICO = :ITE_DEPICO_NOV,  ';
    strSQL := strSQL + ' ITE_DEICMS = :ITE_DEICMS_NOV,  ';
    strSQL := strSQL + ' ITE_FATREG = :ITE_FATREG_NOV   ';

    If (Not blnInfMat) Or (intInfSai = 2)  Then
      strSQL := strSQL + ', ITE_ICMSAI = :ITE_ICMSAI_NOV ';

    If (Not blnInfMat) Or (intInfFed = 2) Then
      strSQL := strSQL + ', ITE_IMPFED = :ITE_IMPFED_NOV ';

    If (Not blnInfMat) Or (intInfOpe = 2)  Then
      strSQL := strSQL + ', ITE_DESOPE = :ITE_DESOPE_NOV ';
  End;

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   G.ITE_CODITE = C.ITE_CODITE AND  ';
  strSQL := strSQL + '   G.ITE_CODITE = :ITE_CODITE AND       ';

  If blnResFor Then
    strSQL := strSQL + '   LOCATE(G.ITE_CODEMP, :CODEMP) = 0    '
  Else
    strSQL := strSQL + '   LOCATE(G.ITE_CODEMP, :CODEMP) > 0    ';

  Result := strSQL;
End;

Function TTabelaPreco.fAtualizaDadosComunsITEFOR: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE ITEFOR                                        ';
  strSQL := strSQL + ' SET  ';

  strSQL := strSQL + '   TFO_PESOIT = :PESOIT,    ';
  strSQL := strSQL + '   ITE_CLAIPI = :CLAIPI,    ';
  strSQL := strSQL + '   TFO_CODBAR = :CODBAR,    ';
  strSQL := strSQL + '   ITE_CODFAB = :CODFAB,    ';
  strSQL := strSQL + '   TFO_SITPRO = :SITPRO,    ';
  strSQL := strSQL + '   TFO_NOTESP = :NOTESP,    ';
  strSQL := strSQL + '   ITE_MLTCOM = :MLTCOM,    ';
  strSQL := strSQL + '   ITE_UNICOM = :UNICOM,    ';
  strSQL := strSQL + '   TFO_REFERE = :REFERE     ';

  strSQL := strSQL + ' WHERE                                                ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE AND                           ';
  strSQL := strSQL + '   ITE_CODFOR = :CODFOR                               ';

  Result := strSQL;
End;

Function TTabelaPreco.fAtualizaDadosComunsTABDET: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE TABDET D                   ';

  strSQL := strSQL + ' INNER JOIN TABDET O               ';
  strSQL := strSQL + '    ON O.ITE_CODITE = D.ITE_CODITE ';
  strSQL := strSQL + '   AND O.ITE_CODFOR = D.ITE_CODFOR ';
  strSQL := strSQL + '   AND O.ITE_SEQGER = D.ITE_SEQGER ';
//  strSQL := strSQL + '   AND O.ITE_CODEMP = D.ITE_CODEMP ';

  strSQL := strSQL + ' SET                            ';
  strSQL := strSQL + '   D.ITE_CODABF = O.ITE_CODABF, ';
  strSQL := strSQL + '   D.ITE_ABFPIS = O.ITE_ABFPIS, ';
  strSQL := strSQL + '   D.ITE_ABFCOF = O.ITE_ABFCOF  ';

  strSQL := strSQL + ' WHERE O.ITE_CODITE = :CODITE ';
  strSQL := strSQL + '   AND O.ITE_CODFOR = :CODFOR ';
  strSQL := strSQL + '   AND O.ITE_CODTAB = :CODTAB ';
  strSQL := strSQL + '   AND O.ITE_SEQGER = :SEQGER';
  strSQL := strSQL + '   AND O.ITE_CODEMP = :CODEMP';


  Result := strSQL;
End;

Procedure TTabelaPreco.pAtualizaDadosComunsIteFor;
Begin
  qryUpdFor.Close;
  qryUpdFor.ParamByName('PESOIT').AsFloat  := Self.FieldByName('TFO_PESOIT').AsFloat;
  qryUpdFor.ParamByName('CLAIPI').AsString := Self.FieldByName('ITE_CLAIPI').AsString;
  qryUpdFor.ParamByName('REFERE').AsString := Self.FieldByName('TFO_REFERE').AsString;
  qryUpdFor.ParamByName('CODBAR').AsString := Self.FieldByName('TFO_CODBAR').AsString;
  qryUpdFor.ParamByName('CODFAB').AsString := Self.FieldByName('ITE_CODFAB').AsString;
  qryUpdFor.ParamByName('NOTESP').AsString := Self.FieldByName('TFO_NOTESP').AsString;
  qryUpdFor.ParamByName('MLTCOM').AsFloat := Self.FieldByName('ITE_MLTCOM').AsFloat;

  qryUpdFor.ParamByName('SITPRO').AsString := Self.FieldByName('TFO_SITPRO').AsString;
  If fEmptyStr(FieldByName('TFO_SITPRO').AsString) Then
    qryUpdFor.ParamByName('SITPRO').Clear;

  qryUpdFor.ParamByName('UNICOM').AsString := Self.FieldByName('ITE_UNICOM').AsString;
  If fEmptyStr(FieldByName('ITE_UNICOM').AsString) Then
    qryUpdFor.ParamByName('UNICOM').Clear;

  qryUpdFor.ParamByName('CODITE').AsString := Self.FieldByName('ITE_CODITE').AsString;
  qryUpdFor.ParamByName('CODFOR').AsString := Self.FieldByName('ITE_CODFOR').AsString;
  qryUpdFor.ExecSQL;
End;

Procedure TTabelaPreco.pAtualizaDadosComunsTabDet;
Begin
  qryUpdDet.Close;
  qryUpdDet.ParamByName('CODTAB').AsString := cdsTabDet.FieldByName('ITE_CODTAB').AsString;
  qryUpdDet.ParamByName('CODITE').AsString := cdsTabDet.FieldByName('ITE_CODITE').AsString;
  qryUpdDet.ParamByName('CODFOR').AsString := cdsTabDet.FieldByName('ITE_CODFOR').AsString;

  qryUpdDet.ParamByName('SEQGER').AsString := Self.FieldByName('AUTOINCREM').AsString;
  qryUpdDet.ParamByName('CODEMP').AsString := cdsTabDet.FieldByName('ITE_CODEMP').AsString;

  qryUpdDet.ExecSQL;
End;

Procedure TTabelaPreco.pAtualizaPrecoNovPre(qryIteger: TUniQuery; strEmpresas, strAgrupadorPreAlt: String; blnResFor: Boolean);
  Var
    intContador: Integer;
Begin
  qryIteger.Close;
  qryIteger.SQL.Text := fUpdateIteger(blnResFor);

  For intContador := 0 To qryIteger.Params.Count - 1 Do
    If (qryIteger.Params[intContador].Name <> 'CODEMP') And (qryIteger.Params[intContador].Name <> 'PREALT') Then
      qryIteger.Params[intContador].Value := FNovPre.FieldByName(qryIteger.Params[intContador].Name).Value;

  qryIteger.ParamByName('CODEMP').AsString := strEmpresas;
  qryIteger.ParamByName('PREALT').AsString := strAgrupadorPreAlt;

  qryIteger.ExecSQL;

  If blnInfMat Then
    pRecalculaItensResponsavelFornecedor(strEmpresas, FNovPre.FieldByName('ITE_CODITE').AsString, blnResFor);
End;

Function TTabelaPreco.fAtualizaPrecosItensPrg(prgProgresso: TCXProgressBar): Boolean;
  Var
    qryIteger: TUniQuery;
    strEmpresas: String;
    strAgrupadorPreAlt: String;
Begin
  With FNovPre Do
  Try
    qryIteger := fCriaQuery;

    Filter   := 'MARDES = ' + QuotedStr('S');
    Filtered := True;

    strEmpresas := fRetEmpresasUsamPrecoMatriz;

    frmGravando.lblGravando.Caption := 'Atualizando preços, aguarde...';
    prgProgresso.Properties.Max := RecordCount;
    prgProgresso.Position := 0;

    DisableControls;

    First;

    Result := True;

    pPreAltDefineVariaveisAltPre(fNow, 'TABELA PREÇOS FORNECEDOR', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    While Not Eof Do
    Begin
      pAtualizaPrecoNovPre(qryIteger, strEmpresas, strAgrupadorPreAlt, False);

      If blnInfMat And fEhEmpresaResponsavelFornecedor(FieldByName('ITE_CODFOR').AsString) Then
        pAtualizaPrecoNovPre(qryIteger, strEmpresas, strAgrupadorPreAlt, True);

      If (Not VS_blnPreAltViaTrigger) Then
        Result := fGravaPreAlt(FieldByName('ITE_CODITE').AsString,
                               FieldByName('ITE_PRECUS').AsFloat,
                               FieldByName('ITE_PRECUS_NOV').AsFloat,

                               FieldByName('ITE_PREVE1').AsFloat,
                               FieldByName('ITE_PREVE1_NOV').AsFloat,

                               FieldByName('ITE_MARBR1').AsFloat,
                               FieldByName('ITE_MARBR1_NOV').AsFloat,

                               FieldByName('ITE_PREVE2').AsFloat,
                               FieldByName('ITE_PREVE2_NOV').AsFloat,

                               FieldByName('ITE_MARBR2').AsFloat,
                               FieldByName('ITE_MARBR2_NOV').AsFloat,

                               FieldByName('ITE_PREVE3').AsFloat,
                               FieldByName('ITE_PREVE3_NOV').AsFloat,

                               FieldByName('ITE_MARBR3').AsFloat,
                               FieldByName('ITE_MARBR3_NOV').AsFloat,

                               FieldByName('ITE_PREVE4').AsFloat,
                               FieldByName('ITE_PREVE4_NOV').AsFloat,

                               FieldByName('ITE_MARBR4').AsFloat,
                               FieldByName('ITE_MARBR4_NOV').AsFloat,

                               FieldByName('ITE_PREVE5').AsFloat,
                               FieldByName('ITE_PREVE5_NOV').AsFloat,

                               FieldByName('ITE_MARBR5').AsFloat,
                               FieldByName('ITE_MARBR5_NOV').AsFloat,

                               FieldByName('ITE_PREVE6').AsFloat,
                               FieldByName('ITE_PREVE6_NOV').AsFloat,

                               FieldByName('ITE_MARBR6').AsFloat,
                               FieldByName('ITE_MARBR6_NOV').AsFloat,

                               FieldByName('ITE_PREVE7').AsFloat,
                               FieldByName('ITE_PREVE7_NOV').AsFloat,

                               FieldByName('ITE_MARBR7').AsFloat,
                               FieldByName('ITE_MARBR7_NOV').AsFloat,

                               FieldByName('ITE_PRECOM').AsFloat,
                               FieldByName('ITE_PRECOM_NOV').AsFloat,

                               'TABELA PREÇOS FORNECEDOR',

                               Nil,
                               '',
                               strLoginUsuarioLogado);

      If Not Result Then
        Break;

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    EnableControls;

    FreeAndNil(qryIteger);
    strAgrupadorPreAlt := '';;

  Except
    On E : Exception Do
    Begin
      Result := False;
      strAgrupadorPreAlt := '';;
      pMensagensErro(e.Message, '[TTabelaPreco.fAtualizaPrecosItensPrg]');
    End;
  End;

End;

Procedure TTabelaPreco.pCarregaDicionarios;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(fCarregaDicionariosPrg, frmGravando, 'Carregando dados, aguarde...');
End;

Function TTabelaPreco.fCarregaDicionariosPrg(prgProgre: TCxProgressBar): Boolean;
Begin
  Try
    Result := True;

    dicCodBar.Limpar;
    dicCodFab.Limpar;

    DisableControls;

    First;

    If Assigned(prgProgre) Then
    Begin
      prgProgre.Properties.Max := RecordCount;
      prgProgre.Visible  := True;
      prgProgre.Position := 0;
      Application.ProcessMessages;
    End;

    While Not Eof Do
    Begin

      If Not fEmptyStr(FieldByName('TFO_CODBAR').AsString) Then
        dicCodBar[FieldByName('TFO_CODBAR').AsString] := FieldByName('ITE_CODITE').AsString;

      If Not fEmptyStr(FieldByName('TFO_BAREMB').AsString) Then
        dicCodBar[FieldByName('TFO_BAREMB').AsString] := FieldByName('ITE_CODITE').AsString;

      If Not fEmptyStr(FieldByName('ITE_CODFAB').AsString) Then
        dicCodFab[FieldByName('ITE_CODFAB').AsString] := FieldByName('ITE_CODITE').AsString;

      If Assigned(prgProgre) Then
      Begin
        prgProgre.Position := prgProgre.Position + 1;
        Application.ProcessMessages;
      End;

      Next;
    End;

    If Assigned(prgProgre) Then
    Begin
      prgProgre.Visible  := False;
      prgProgre.Position := 0;
      Application.ProcessMessages;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelaPreco.pCarregaDicionarios]');
    End;
  End;

  EnableControls;
End;

Procedure TTabelaPreco.pAfterPostItefor(dataSet: TDataSet);
Begin
  If dataSet.UpdateStatus = usModified Then
  Begin
    dataSet.AfterPost := Nil;
    dataSet.Edit;
    dataSet.FieldByName('ALTERADO').AsString := 'S';
    dataSet.Post;
    dataSet.AfterPost := pAfterPostItefor;
  End;

End;

Procedure TTabelaPreco.pAtualizaDisplayIteFor(dataSet: TDataSet);
  Var
    blnSalvar: Boolean;
Begin
  If (dataSet.FieldByName('ITE_CODEMP').AsString = VS_strCodEmp) And
     ((Self.FieldByName('ITE_CODITE').AsString = dataSet.FieldByName('ITE_CODITE').AsString) Or
      Self.Locate('ITE_CODITE', dataSet.FieldByName('ITE_CODITE').AsString, [])) Then
  Begin
    If Not (Self.State In dsEditModes) Then
    Begin
      blnSalvar := True;
      Self.Edit;
    End Else
    Begin
      blnSalvar := False;
    End;

    Self.FieldByName('PRECUS').Value := dataSet.FieldByName('ITE_PRECUS').Value;
    Self.FieldByName('PRECOM').Value := dataSet.FieldByName('ITE_PRECOM').Value;
    Self.FieldByName('COMLIQ').Value := dataSet.FieldByName('ITE_COMLIQ').Value;

    If blnSalvar Then
      Self.Post;
  End;
End;

Procedure TTabelaPreco.pAfterCancelTabDet(dataSet: TDataSet);
Begin
  pRecalculaPrecoVenda(fOpcCalculo(dataSet));
End;

Procedure TTabelaPreco.pAfterPostTabDet(dataSet: TDataSet);
Begin

  dataSet.AfterPost := Nil;
  dataSet.BeforePost := Nil;
  Try

    If dataSet.UpdateStatus = usModified Then
    Begin
      dataSet.Edit;
      dataSet.FieldByName('ALTERADO').AsString := 'S';
      dataSet.Post;
    End;

    pAtualizaDisplayIteFor(dataSet);

     If blnTabPrD Then
     Begin
       pRecalculaPrecoVenda(fOpcCalculo(dataSet));
       pAtualizaEmpresasUsamPrecoMatrizTabPrd;
     End;
  Finally
    dataSet.AfterPost  := pAfterPostTabDet;
    dataSet.BeforePost := pBeforePostTabDet;

  End;

End;

Function TTabelaPreco.fUsaPrecoMatriz(strCodEmp: String): Boolean;
Begin
  Result := Pos(strCodEmp, strEmpresasPrecosMatriz) > 0;
End;

function TTabelaPreco.fVariantToFloat(AVariant: Variant): Double;
begin
  If AVariant = null then
    Result := 0
  Else
    Result := AVariant;
end;

Procedure TTabelaPreco.pAtualizaEmpresasUsamPrecoMatrizTabPrd;
  Var
    fltPrecoVenda: Double;
    strFilter: String;
    blnFiltered: Boolean;
    intRecNo: Integer;
    strCodEmp: String;
Begin
  If strFiltroEmpresasPrecosMatriz.IsEmpty Then
    Exit;

  If Pos(cdsTabDet.FieldByName('ITE_CODEMP').AsString, strEmpresasPrecosMatriz) = 0 Then
    Exit;

  intRecNo    := cdsTabDet.RecNo;
  strFilter   := cdsTabDet.Filter;
  blnFiltered := cdsTabDet.Filtered;
  fltPrecoVenda := 0;

  Try

    cdsTabDet.Filter   := ' ITE_CODITE = ' + QuotedStr(cdsTabDet.FieldByName('ITE_CODITE').AsString) + ' AND ' + strFiltroEmpresasPrecosMatriz;
    cdsTabDet.Filtered := True;


    cdsTabDet.IndexFieldNames := 'ITE_CODITE;TABELA;ITE_CODEMP';
    strCodEmp := '';
    cdsTabDet.First;
    While Not cdsTabDet.Eof Do
    Begin
      If strCodEmp  <> cdsTabDet.FieldByName('ITE_CODEMP').AsString Then
        fltPrecoVenda := cdsTabDet.FieldByName('ITE_PREVEN').AsFloat;

      cdsTabDet.Edit;
      cdsTabDet.FieldByName('ITE_PREVEN').AsFloat := fltPrecoVenda;

      If cdsTabDet.FieldByName('ITE_PREVEN').AsFloat > 0 Then
        cdsTabDet.FieldByName('ITE_MARBRU').AsFloat := fCalculaPrecoVenda(2,
                                                                cdsTabDet.FieldByName('ITE_PRECUS').AsFloat + cdsTabDet.FieldByName('ITE_OUTVAL').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_PREVEN').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_MARBRU').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_ICMSAI').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_IMPFED').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_DESOPE').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_COMTBL').AsFloat)
      Else
      Begin
        cdsTabDet.FieldByName('ITE_MARBRU').AsFloat := 0;
        cdsTabDet.FieldByName('ITE_PREVEN').AsFloat := fCalculaPrecoVenda(1,
                                                                cdsTabDet.FieldByName('ITE_PRECUS').AsFloat + cdsTabDet.FieldByName('ITE_OUTVAL').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_PREVEN').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_MARBRU').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_ICMSAI').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_IMPFED').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_DESOPE').AsFloat,
                                                                cdsTabDet.FieldByName('ITE_COMTBL').AsFloat)
      End;

      If cdsTabDet.FieldByName('ITE_PREREV').AsFloat > 0 Then
        cdsTabDet.FieldByName('ITE_DESREV').AsFloat :=  RoundTo(((cdsTabDet.FieldByName('ITE_PREREV').AsFloat
           - cdsTabDet.FieldByName('ITE_PREVEN').AsFloat) / cdsTabDet.FieldByName('ITE_PREREV').AsFloat) * 100, -2)
      Else
        cdsTabDet.FieldByName('ITE_DESREV').AsFloat := 0;
      If blnTabPrD Then
        If cdsTabDet.FieldByName('ITE_MARGIR').AsFloat > 0 Then
          cdsTabDet.FieldByName('ITE_VENGIR').AsFloat := fCalculaPrecoVenda(1,
                                                                            cdsTabDet.FieldByName('ITE_PRECUS').AsFloat + cdsTabDet.FieldByName('ITE_OUTVAL').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_PREVEN').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_MARGIR').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_ICMSAI').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_IMPFED').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_DESOPE').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_COMTBL').AsFloat);
      cdsTabDet.Post;

      pRecalculaPrecoVenda(fOpcCalculo(cdsTabDet));

      cdsTabDet.Next;
    End;

  Finally
    cdsTabDet.Filter   := strFilter;
    cdsTabDet.Filtered := blnFiltered;
    cdsTabDet.RecNo    := intRecNo;
  End;
End;

Function TTabelaPreco.fExportaTabela(strCodTab,
                                     strNomTab,
                                     strCodFor,
                                     strNomFor: String): Boolean;
  Var
    qryExporta : TUniQuery;
    objExcel   : TGeraArquivo;
    strSQL: String;
    FontFieldValues,
    FontFieldTitle: TFont;

begin

  Try
    Try
      qryExporta := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + ' SELECT F.ITE_CODITE,         ';
      strSQL := strSQL + '        ITE_DESITE,                                 ';
      strSQL := strSQL + '        F.ITE_CODFAB,                               ';
      strSQL := strSQL + '        F.ITE_DESFAB,                               ';
      strSQL := strSQL + '        F.ITE_CLAIPI,                               ';
      strSQL := strSQL + '        F.ITE_DIAFOR,                               ';
      strSQL := strSQL + '        F.ITE_CODABF,                               ';
      strSQL := strSQL + '        F.ITE_MLTCOM,                               ';
      strSQL := strSQL + '        F.ITE_UNICOM,                               ';
      strSQL := strSQL + '        F.ITE_CNVCUS,                               ';

      strSQL := strSQL + '          UNI_DESUNI,                               ';
      strSQL := strSQL + '        D.ITE_PRECOM, ';
      strSQL := strSQL + '        D.ITE_DESF01,                               ';
      strSQL := strSQL + '        D.ITE_DESF02,                               ';
      strSQL := strSQL + '        D.ITE_DESF03,                               ';
      strSQL := strSQL + '        D.ITE_DESF04,                               ';
      strSQL := strSQL + '        D.ITE_DESF05,                               ';
      strSQL := strSQL + '        D.ITE_DESF06,                               ';
      strSQL := strSQL + '        D.ITE_ICMENT,                               ';
      strSQL := strSQL + '        D.ITE_SUBFED,                               ';
      strSQL := strSQL + '        D.ITE_IPIENT,                               ';
      strSQL := strSQL + '        D.ITE_FREENT,                               ';
      strSQL := strSQL + '        D.ITE_VALFRE,                               ';
      strSQL := strSQL + '        D.ITE_ACRFIN,                               ';
      strSQL := strSQL + '        D.ITE_SUBSTI,                               ';
      strSQL := strSQL + '        D.ITE_DESADB,                               ';
      strSQL := strSQL + '        D.ITE_PRECUS,                               ';
      strSQL := strSQL + '        D.ITE_OUTVAL,                               ';
      strSQL := strSQL + '        D.ITE_ICMSAI,                               ';
      strSQL := strSQL + '        D.ITE_IMPFED,                               ';
      strSQL := strSQL + '        D.ITE_DESOPE,                               ';

      strSQL := strSQL + '        D.ITE_TCIFCU,                               ';
      strSQL := strSQL + '        D.ITE_TSCUST,                               ';
      strSQL := strSQL + '        D.ITE_DEPICO,                               ';
      strSQL := strSQL + '        D.ITE_DEICMS,                               ';
      strSQL := strSQL + '        D.ITE_FATREG                                ';

      strSQL := strSQL + ' FROM ITEFOR F                                      ';

      strSQL := strSQL + '   INNER JOIN TABDET D ON D.ITE_CODITE = F.ITE_CODITE ';
      strSQL := strSQL + '                      AND D.ITE_CODTAB = F.ITE_CODTAB ';
      strSQL := strSQL + '                      AND D.ITE_CODFOR = F.ITE_CODFOR ';
      strSQL := strSQL + '                      AND D.ITE_CODEMP = :CODEMP      ';

      strSQL := strSQL + '   INNER JOIN CADITE I ON I.ITE_CODITE = F.ITE_CODITE ';
      strSQL := strSQL + '   INNER JOIN CADUNI U ON U.UNI_CODUNI = F.ITE_UNICOM ';

      strSQL := strSQL + ' WHERE F.ITE_CODTAB = :CODTAB                         ';

      qryExporta.SQL.Text := strSQL;
      qryExporta.ParamByName('CODTAB').AsString := strCodTab;
      qryExporta.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryExporta.Open;

//      objExcel := TGeraExcel.Create(qryExporta, Nil);
      objExcel := TGeraArquivo.create(taHtml, qryExporta, nil);
      objExcel.blnShowFrmGravando := True;
      With objExcel Do
      Begin
        objExcel.protegeEstrutura := false;
        objExcel.DesbloquerTodasAsColunas  := True;
        objExcel.pAddTitulo('Tabela de Preços do Fornecedor', TGeraArquivo.fSetFont(12, [fsBold]));

        objExcel.pAddTitulo('Código ' + strCodTab, TGeraArquivo.fSetFont(12, [fsBold]));
        objExcel.pAddTitulo('Descrição ' + strNomTab, TGeraArquivo.fSetFont(12, [fsBold]));
        objExcel.pAddTitulo('Fornecedor '+ strCodFor + ' - ' + strNomFor, TGeraArquivo.fSetFont(12, [fsBold]));

        FontFieldValues:= TGeraArquivo.fSetFont(10, [], clBlack);
        FontFieldTitle := TGeraArquivo.fSetFont(10, [], clWhite);

        objExcel.AddCampo('ITE_CODITE', 'Código do Item', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESITE', 'Descrição', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_CODFAB', 'Código de Fábrica', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESFAB', 'Descrição do Fabricante', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_CLAIPI', 'NCM / Classificação de IPI', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DIAFOR', 'Dias para entrega do Fornecedor', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_MLTCOM', 'Múltiplo para Compra', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_UNICOM', 'Unidade de Compra', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('UNI_DESUNI', 'Descrição Unidade de Compra', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_PRECOM', 'Preço Compra', FontFieldTitle, FontFieldValues, fMskDigitos(intDecUni, False), tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESF01', 'Desconto 01 (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESF02', 'Desconto 02 (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESF03', 'Desconto 03 (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESF04', 'Desconto 04 (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESF05', 'Desconto 05 (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESF06', 'Desconto 06 (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_ICMENT', 'ICMS Entrada (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_SUBFED', 'Impostos Federais (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_IPIENT', 'IPI Entrada (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_FREENT', 'Frete (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_VALFRE', 'Valor Frete (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_ACRFIN', 'Acréscimo Finan. (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_SUBSTI', 'Sub. Tributária (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESADB', 'Descontos Adicionais (Boleto) (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_PRECUS', 'Preço de Custo', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_OUTVAL', 'Outros Valores (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_ICMSAI', 'ICMS Saída (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_IMPFED', 'Impostos Federais (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DESOPE', 'Despesas Operacionais (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_CNVCUS', 'Divisor Conversão p/ Custo', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);

        objExcel.AddCampo('ITE_TCIFCU', 'TCIF (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_TSCUST', 'TS (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DEPICO', 'Desconto PIS/COFINS (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_DEICMS', 'Desconto ICMS (-)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);
        objExcel.AddCampo('ITE_FATREG', 'Fator Regional (+)', FontFieldTitle, FontFieldValues, '', tahtmlUndef, False);

        Result := objExcel.fGerarRelatorio;
        If Result Then
          ShellExecute(Application.Handle, 'open', Pchar(strFile), '', '', SW_SHOWNORMAL);

      End;

    Finally
      FreeAndNil(qryExporta);
      If Assigned(objExcel) Then
        FreeAndNil(objExcel);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelaPreco.fExportaTabela]');
    End;
  End;

end;

Class Function TTabelaPreco.fSQLUpdatePrecoRevistaGerencial: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE TABDET D           ';
  strSQL := strSQL + ' SET                       ';
  strSQL := strSQL + '   D.ITE_MARBRU = :MARBRU, ';
  strSQL := strSQL + '   D.ITE_MARFEC = :MARBRU, ';
  strSQL := strSQL + '   D.ITE_PREVEN = :PREVEN, ';
  strSQL := strSQL + '   D.ITE_PREREV = :PREREV  ';
  strSQL := strSQL + ' WHERE                     ';
  strSQL := strSQL + '   D.AUTOINCREM = :AUTINC  ';

  Result := strSQL;
end;

Class Function TTabelaPreco.fRetTotalItensTabela(strCodTab: String): Integer;
  Var
    qryContag: TUniQuery;
Begin
  qryContag := fCriaQuery;

  With qryContag, SQL Do
  Begin
    Clear;
    Add('SELECT COUNT(*) AS QTDITE FROM ITEFOR');
    Add('INNER JOIN TABPRE ON TAB_CODTAB = ITE_CODTAB ');

    Add('WHERE ');
    Add('  TAB_CODTAB = ' + QuotedStr(strCodTab));

    Open;

    Result := FieldByName('QTDITE').AsInteger;

    Close;

  End;

  FreeAndNil(qryContag);
End;

Class Function TTabelaPreco.fRetTotalItensTabelaAtiva(strCodFor: String): Integer;
  Var
    qryContag: TUniQuery;
Begin
  If fEmptyStr(strCodFor) Then
  Begin
    Result := 0;
    Exit;
  End;

  qryContag := fCriaQuery;

  With qryContag, SQL Do
  Begin
    Clear;
    Add('SELECT COUNT(*) AS QTDITE FROM ITEFOR');
    Add('INNER JOIN TABPRE ON TAB_CODTAB = ITE_CODTAB AND ');
    Add('                     TAB_ATICMP = "S"            ');

    Add('WHERE ');
    Add('  TAB_CODFOR IN (' + strCodFor + ')');

    Open;

    Result := FieldByName('QTDITE').AsInteger;

    Close;

  End;

  FreeAndNil(qryContag);
End;

Class Function TTabelaPreco.fRetTotalItensPrincipal(strCodFor: String): Integer;
  Var
    qryContag: TUniQuery;
Begin
  If fEmptyStr(strCodFor) Then
  Begin
    Result := 0;
    Exit;
  End;

  qryContag := fCriaQuery;

  With qryContag, SQL Do
  Begin
    Clear;
    Add('SELECT COUNT(*) AS QTDITE FROM CADITE');
    Add('WHERE ');
    Add('  ITE_CODFOR  = ' + QuotedStr(strCodFor));

    Open;

    Result := FieldByName('QTDITE').AsInteger;

    Close;

  End;

  FreeAndNil(qryContag);
End;

Class Procedure TTabelaPreco.pSQUpdatePrecoRevistaFilias(qryTabDet: TUniQuery; dtsTabGir: TDataSet);
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT * FROM TABDET         ';
  strSQL := strSQL + ' WHERE                        ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE AND   ';
  strSQL := strSQL + '   ITE_CODTAB = :CODTAB AND   ';
  strSQL := strSQL + '   ITE_CODFOR = :CODFOR AND   ';
  strSQL := strSQL + '   ITE_CODEMP <> ' + QuotedStr(VS_strCodEmp) + ' ';

  With qryTabDet Do
  Begin
    qryTabDet.SQL.Text := strSQL;
    Close;
    ParamByName('CODITE').AsString := dtsTabGir.FieldByName('CODITE').AsString;
    ParamByName('CODTAB').AsString := dtsTabGir.FieldByName('CODTAB').AsString;
    ParamByName('CODFOR').AsString := dtsTabGir.FieldByName('CODFOR').AsString;
    Open;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('ITE_PREVEN').AsFloat := dtsTabGir.FieldByName('PREVEN').AsFloat;
      FieldByName('ITE_PREREV').AsFloat := dtsTabGir.FieldByName('PREREV').AsFloat;

      FieldByName('ITE_MARBRU').AsFloat := RoundTo(fCalculaPrecoVenda(2,
                                                FieldByName('ITE_PRECUS').AsFloat,
                                                FieldByName('ITE_PREVEN').AsFloat,
                                                FieldByName('ITE_MARBRU').AsFloat,
                                                FieldByName('ITE_ICMSAI').AsFloat,
                                                FieldByName('ITE_IMPFED').AsFloat,
                                                FieldByName('ITE_DESOPE').AsFloat,
                                                FieldByName('ITE_COMTBL').AsFloat), -2);

      FieldByName('ITE_MARFEC').AsFloat := FieldByName('ITE_MARBRU').AsFloat;

      Post;
      Next;
    End;

  End;
end;

Function TTabelaPreco.fOpcCalculo(dataSet: TDataSet): TopcMarPre;
Begin
  If dataSet.IsEmpty Then
    Result := FopcMarPre
  Else
  Begin
    If dataSet.FieldByName('FORCAL').AsString = 'P' Then
      Result := opcPrecoVenda
    Else
      Result := opcMargem;
  End;
End;

function TTabelaPreco.fMarcaTabDetProgresso(cxProgresso: TcxProgressbar): Boolean;
  Var
    intRecNo: Integer;
Begin
  If Not FMarcar Then
  Begin
    FMarcados.Clear;
    Result := True;
    Exit;
  End;

  If cdsTabDet.IsEmpty Then
  Begin
    Result := True;
    Exit;
  End;

  intRecNo := cdsTabDet.RecNo;

  cxProgresso.Properties.Max := RecordCount;
  cxProgresso.Position := 0;
  cdsTabDet.First;
  While Not cdsTabDet.Eof Do
  Begin

    If FMarcar Then
      FMarcados.Add(cdsTabDet.FieldByName('ITE_CODITE').AsString);

    cdsTabDet.Next;
    cxProgresso.Position := cxProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  cdsTabDet.RecNo := intRecNo;
  Result := True;
End;

Procedure TTabelaPreco.pMarcaTodosTabDet(blnMarcar: Boolean);
Begin
  Try
    Try
      cdsTabDet.DisableControls;
      FMarcar := blnMarcar;
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fMarcaTabDetProgresso;
      frmGravando.lblGravando.Caption := 'Aguarde, ' + IIF(blnMarcar, '', 'des')  + 'marcando itens...';
      frmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TTabelaPreco.pMarcaTodosTabDet');
      End;
    End;
  Finally
    FreeAndNil(frmGravando)
  End;

  cdsTabDet.EnableControls;
End;

Procedure TTabelaPreco.pMarcaDesmarcaTabDet;
  Var
    intIndex: Integer;
Begin
  If FMarcados.Find(cdsTabDet.FieldByName('ITE_CODITE').AsString, intIndex) Then
    FMarcados.Delete(intIndex)
  Else
    FMarcados.Add(cdsTabDet.FieldByName('ITE_CODITE').AsString);
End;

Function TTabelaPreco.fItemMarcadoTabDet(strCodIte: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := FMarcados.Find(strCodIte, intIndex);
End;

Function TTabelaPreco.fCopiaPrecos: Boolean;
  Var
    prcBeforePost: Procedure(dataSet: TDataSet) Of Object;
Begin
  prcBeforePost := Self.BeforePost;

  Try
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fCopiaPrecosProgresso;
      frmGravando.lblGravando.Caption := 'Aguarde, copiando preços...';
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TTabelaPreco.fCopiaPrecos');
      End;
    End;
  Finally
    FreeAndNil(frmGravando)
  End;

  Self.BeforePost := prcBeforePost;

  If Result Then
    FMarcados.Clear;
End;

Function TTabelaPreco.fCopiaPrecosProgresso(cxProgresso: TcxProgressbar): Boolean;
  Var
    intContador,
    intRecNo: Integer;
    recPrecos: TrecPrecos;
    strIndexFields,
    strFilter: String;
    blnAlterado,
    blnFiltered: Boolean;
    prcAfperPost: Procedure(dataSet: TDataSet) Of Object;
Begin
  Result := True;

  If cdsTabDet.IsEmpty Then
    Exit;

  strFilter      := cdsTabDet.Filter;
  blnFiltered    := cdsTabDet.Filtered;
  strIndexFields := cdsTabDet.IndexFieldNames;
  prcAfperPost   := cdsTabDet.AfterPost;
  intRecNo       := cdsTabDet.RecNo;

  Try
    cdsTabDet.DisableControls;

    cdsTabDet.AfterPost := Nil;

    cdsTabDet.IndexFieldNames := 'ITE_CODEMP;ITE_CODITE';

    cxProgresso.Properties.Max := FMarcados.Count;
    cxProgresso.Position := 0;

    For intContador := 0 To FMarcados.Count - 1 Do
    Begin
      cdsTabDet.Filter   := 'ITE_CODITE = ' + QuotedStr(FMarcados[intContador]) +
                  IIF(fEmptyStr(FEmpDes), '', ' AND ITE_CODEMP IN (' + FEmpDes + ', ' + QuotedStr(FEmpOri) + ')');

      cdsTabDet.Filtered := True;

      If cdsTabDet.Locate('ITE_CODEMP', FEmpOri, []) Then
      Begin
        pCopiaPrecos(recPrecos);

        cdsTabDet.First;
        While Not cdsTabDet.Eof Do
        Begin
          If cdsTabDet.FieldByName('ITE_CODEMP').AsString <> FEmpOri Then
          Begin
            cdsTabDet.Edit;

            pSetaPrecos(recPrecos, blnAlterado);

            If blnAlterado Then
            Begin
              cdsTabDet.FieldByName('ALTERADO').AsString := 'S';

              pBeforePostTabDet(cdsTabDet);

              pAtualizaDisplayIteFor(cdsTabDet);
            End;

            cdsTabDet.Post;
          End;
          cdsTabDet.Next;
        End;
      End;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TTabelaPreco.fCopiaPrecosProgresso');
    End;
  End;

  cdsTabDet.Filter          := strFilter;
  cdsTabDet.Filtered        := blnFiltered;
  cdsTabDet.IndexFieldNames := strIndexFields;
  cdsTabDet.RecNo           := intRecNo;
  cdsTabDet.AfterPost       := prcAfperPost;

  cdsTabDet.EnableControls;
End;

Procedure TTabelaPreco.pCopiaPrecos(Var recPrecos: TrecPrecos);
Begin
  With recPrecos Do
  Begin
    fltPreCom := cdsTabDet.FieldByName('ITE_PRECOM').AsFloat;
    fltDesF01 := cdsTabDet.FieldByName('ITE_DESF01').AsFloat;
    fltDesF02 := cdsTabDet.FieldByName('ITE_DESF02').AsFloat;
    fltDesF03 := cdsTabDet.FieldByName('ITE_DESF03').AsFloat;
    fltDesF04 := cdsTabDet.FieldByName('ITE_DESF04').AsFloat;
    fltDesF05 := cdsTabDet.FieldByName('ITE_DESF05').AsFloat;
    fltDesF06 := cdsTabDet.FieldByName('ITE_DESF06').AsFloat;
    fltIcmEnt := cdsTabDet.FieldByName('ITE_ICMENT').AsFloat;
    fltSubFed := cdsTabDet.FieldByName('ITE_SUBFED').AsFloat;
    fltIpiEnt := cdsTabDet.FieldByName('ITE_IPIENT').AsFloat;
    fltFreEnt := cdsTabDet.FieldByName('ITE_FREENT').AsFloat;
    fltValFre := cdsTabDet.FieldByName('ITE_VALFRE').AsFloat;
    fltAcrFin := cdsTabDet.FieldByName('ITE_ACRFIN').AsFloat;
    fltSubsti := cdsTabDet.FieldByName('ITE_SUBSTI').AsFloat;
    fltDesAdb := cdsTabDet.FieldByName('ITE_DESADB').AsFloat;
    fltTcifcu := cdsTabDet.FieldByName('ITE_TCIFCU').AsFloat;
    fltTscust := cdsTabDet.FieldByName('ITE_TSCUST').AsFloat;
    fltDepico := cdsTabDet.FieldByName('ITE_DEPICO').AsFloat;
    fltDeicms := cdsTabDet.FieldByName('ITE_DEICMS').AsFloat;
    fltFatReg := cdsTabDet.FieldByName('ITE_FATREG').AsFloat;
    fltOutVal := cdsTabDet.FieldByName('ITE_OUTVAL').AsFloat;
    fltIcmSai := cdsTabDet.FieldByName('ITE_ICMSAI').AsFloat;
    fltImpFed := cdsTabDet.FieldByName('ITE_IMPFED').AsFloat;
    fltDesOpe := cdsTabDet.FieldByName('ITE_DESOPE').AsFloat;
    fltPreVen := cdsTabDet.FieldByName('ITE_PREVEN').AsFloat;
  End;
End;

Procedure TTabelaPreco.pAlteraValor(strNomCam: String; fltValor: Double; Var blnAlterado: Boolean);
  Var
    intIndex: Integer;
    strNomCamFind: String;
Begin
  If Pos('ITE_DESF0', strNomCam) > 0 Then
    strNomCamFind := 'ITE_DESF01'
  Else
    strNomCamFind := strNomCam;

  If stlCamposParaCopiar.Find(strNomCamFind, intIndex) Then
  Begin
    If RoundTo(cdsTabDet.FieldByName(strNomCam).AsFloat, -4) <> RoundTo(fltValor, -4) Then
      blnAlterado := True;

    cdsTabDet.FieldByName(strNomCam).AsFloat := fltValor;
  End;
End;

Procedure TTabelaPreco.pSetaPrecos(recPrecos: TrecPrecos; Var blnAlterado: Boolean);
  Var
    fltPreCusNov: Double;
Begin
  pAlteraValor('ITE_PRECOM', recPrecos.fltPreCom, blnAlterado);
  pAlteraValor('ITE_DESF01', recPrecos.fltDesF01, blnAlterado);
  pAlteraValor('ITE_DESF02', recPrecos.fltDesF02, blnAlterado);
  pAlteraValor('ITE_DESF03', recPrecos.fltDesF03, blnAlterado);
  pAlteraValor('ITE_DESF04', recPrecos.fltDesF04, blnAlterado);
  pAlteraValor('ITE_DESF05', recPrecos.fltDesF05, blnAlterado);
  pAlteraValor('ITE_DESF06', recPrecos.fltDesF06, blnAlterado);
  pAlteraValor('ITE_ICMENT', recPrecos.fltIcmEnt, blnAlterado);
  pAlteraValor('ITE_SUBFED', recPrecos.fltSubFed, blnAlterado);
  pAlteraValor('ITE_IPIENT', recPrecos.fltIpiEnt, blnAlterado);
  pAlteraValor('ITE_FREENT', recPrecos.fltFreEnt, blnAlterado);
  pAlteraValor('ITE_VALFRE', recPrecos.fltValFre, blnAlterado);
  pAlteraValor('ITE_ACRFIN', recPrecos.fltAcrFin, blnAlterado);
  pAlteraValor('ITE_SUBSTI', recPrecos.fltSubsti, blnAlterado);
  pAlteraValor('ITE_DESADB', recPrecos.fltDesAdb, blnAlterado);
  pAlteraValor('ITE_TCIFCU', recPrecos.fltTcifcu, blnAlterado);
  pAlteraValor('ITE_TSCUST', recPrecos.fltTscust, blnAlterado);
  pAlteraValor('ITE_DEPICO', recPrecos.fltDepico, blnAlterado);
  pAlteraValor('ITE_DEICMS', recPrecos.fltDeicms, blnAlterado);
  pAlteraValor('ITE_FATREG', recPrecos.fltFatReg, blnAlterado);
  pAlteraValor('ITE_OUTVAL', recPrecos.fltOutVal, blnAlterado);
  pAlteraValor('ITE_ICMSAI', recPrecos.fltIcmSai, blnAlterado);
  pAlteraValor('ITE_IMPFED', recPrecos.fltImpFed, blnAlterado);
  pAlteraValor('ITE_DESOPE', recPrecos.fltDesOpe, blnAlterado);

  fltPreCusNov := fRetPrecoCusto(cdsTabDet);

  If (RoundTo(cdsTabDet.FieldByName('ITE_PRECUS').AsFloat, -4) <> RoundTo(fltPreCusNov, -4)) Then
     blnAlterado := True;

  cdsTabDet.FieldByName('ITE_PRECUS').AsFloat := fltPreCusNov;

  If (RoundTo(cdsTabDet.FieldByName('ITE_PREVEN').AsFloat, -4) <> RoundTo(recPrecos.fltPreVen, -4)) And
     fUsaPrecoMatriz(cdsTabDet.FieldByName('ITE_CODEMP').AsString) Then
  Begin
    blnAlterado := True;
    cdsTabDet.FieldByName('ITE_PREVEN').AsFloat := recPrecos.fltPreVen;

    If cdsTabDet.FieldByName('ITE_PREVEN').AsFloat > 0 Then
      cdsTabDet.FieldByName('ITE_MARBRU').AsFloat := fCalculaPrecoVenda(2,
                                                              cdsTabDet.FieldByName('ITE_PRECUS').AsFloat,
                                                              cdsTabDet.FieldByName('ITE_PREVEN').AsFloat,
                                                              cdsTabDet.FieldByName('ITE_MARBRU').AsFloat,
                                                              cdsTabDet.FieldByName('ITE_ICMSAI').AsFloat,
                                                              cdsTabDet.FieldByName('ITE_IMPFED').AsFloat,
                                                              cdsTabDet.FieldByName('ITE_DESOPE').AsFloat,
                                                              cdsTabDet.FieldByName('ITE_COMTBL').AsFloat)
    Else
      cdsTabDet.FieldByName('ITE_MARBRU').AsFloat := 0;

      If blnTabPrD Then
        If cdsTabDet.FieldByName('ITE_MARGIR').AsFloat > 0 Then
          cdsTabDet.FieldByName('ITE_VENGIR').AsFloat := fCalculaPrecoVenda(1,
                                                                            cdsTabDet.FieldByName('ITE_PRECUS').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_PREVEN').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_MARGIR').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_ICMSAI').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_IMPFED').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_DESOPE').AsFloat,
                                                                            cdsTabDet.FieldByName('ITE_COMTBL').AsFloat);

  End;
End;

Procedure TTabelaPreco.pSetaSqlPrecosVenda(qryPreVen: TUniQuery; blnFiltraItem: Boolean);
  Var
    intIndice: Integer;
Begin
  With qryPreVen.SQL Do
  Begin
    Clear;

    For intIndice := 1 to 7 Do
    Begin
      Add('SELECT ');
      Add('  "N"                                  AS ALTERADO,');
      Add(   IntToStr(intIndice) +              ' AS NROTAB,');
      Add('  ITE_CODEMP                           AS CODEMP,');
      Add('  ITE_CODITE                           AS CODITE,');

      Add('  ITE_IMPFED ,');
      Add('  ITE_SUBFED ,');
      Add('  ITE_DESOPE ,');
      Add('  ITE_OUTVAL ,');
      Add('  ITE_ICMSAI ,');
      Add('  ITE_ICMENT ,');
      Add('  ITE_SUBSTI ,');
      Add('  ITE_PRECUS ,');

      Add('  ITE_PREVE' + IntToStr(intIndice) + ' AS PREVEN,');
      Add('  ITE_COMTB' + IntToStr(intIndice) + ' AS COMTBL,');
      Add('  ITE_MARBR' + IntToStr(intIndice) + ' AS MARBRU,');
      Add('  ITE_PREVE' + IntToStr(intIndice) + ' AS PREORI,');
      Add('  ITE_COMTB' + IntToStr(intIndice) + ' AS COMORI,');
      Add('  ITE_MARBR' + IntToStr(intIndice) + ' AS MARORI ');

      Add('FROM');
      Add('  ITEGER');
      Add('WHERE');

      If blnFiltraItem Then
      Begin
        Add('  ITE_CODITE = :CODITE AND ');
        Add('  ITE_CODEMP = :CODEMP AND ');
      End;

      Add('  ITE_TABPR' + IntToStr(intIndice) + ' = :CODTAB');

      If intIndice <> 7 Then
        Add(' UNION ALL ');

    End;
  End;
End;

Procedure TTabelaPreco.pFormataIteger(cdsItens: TZClient);
Begin
  With cdsItens Do
  Begin
    TFloatField(FieldByName('PREVEN')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('MARBRU')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('PREORI')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('MARORI')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('COMTBL')).DisplayFormat := '#,##0.00';

    FieldByName('NROTAB').Alignment := taCenter;

  End;
End;

Function TTabelaPreco.fCarregaPrecosVenda(strCodTab: String): Boolean;
Begin
  pSetaSqlPrecosVenda(cdsPreVen.qryQuery, False);
  cdsPreVen.qryQuery.ParamByName('CODTAB').AsString := strCodTab;

  Result := cdsPreVen.fAbreClient(True, 'TTabelaPreco.fCarregaPrecosVenda');

  If Result Then
  Begin
    pFormataIteger(cdsPreVen);
    pSetaMasterPreVen;
  End;
End;

Procedure TTabelaPreco.pSetaMasterPreVen;
Begin
  cdsPreVen.IndexFieldNames := 'CODITE;CODEMP';
  cdsPreVen.MasterSource    := cdsTabDet.dtsSource;
  cdsPreVen.MasterFields    := 'ITE_CODITE;ITE_CODEMP';
End;

Function TTabelaPreco.fMontaPrecosVenda(opcMarPre: TopcMarPre): Boolean;
Begin
  Try
    pRecalculaPrecoVenda(opcMarPre);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TTabelaPreco.fMontaPrecosVenda');
    End;
  End;
End;

Procedure TTabelaPreco.pRecalculaPrecoVenda(opcMarPre: TopcMarPre);
  Var
    intMarPre: Integer;
    strNomCam: String;

    fltImpFed,
    fltSubFed,
    fltDesOpe,
    fltOutVal,
    fltIcmEnt,
    fltIcmSai,
    fltSubsti: Double;

Begin
  If Not blnTabPrD Then
    Exit;

  If opcMarPre = opcMargem Then
  Begin
    intMarPre := 2;
    strNomCam := 'MARBRU';
  End Else
  Begin
    intMarPre := 1;
    strNomCam := 'PREVEN';
  End;

  cdsPreVen.DisableControls;
  cdsPreVen.First;
  While Not cdsPreVen.Eof Do
  Begin
    If (cdsPreVen.FieldByName('CODITE').AsString <> cdsTabDet.FieldByName('ITE_CODITE').AsString) Or
       (cdsPreVen.FieldByName('CODEMP').AsString <> cdsTabDet.FieldByName('ITE_CODEMP').AsString) Then
      Break;

    cdsPreVen.Edit;


    CalculaComposicaoCusto := TCalculaComposicaoCusto.fCalcula(fIncidePis(cdsTabDet.FieldByName('ITE_CODITE').AsString),
                                                               100,
                                                               FCodFor,
                                                               cdsTabDet.FieldByName('ITE_CODABF').AsString,
                                                               cdsTabDet.FieldByName('ITE_IPIENT').AsFloat,
                                                               cpcParams,
                                                               cdsPreVen.FieldByName('NROTAB').AsString);

    Try
      If CalculaComposicaoCusto.BlnSemST then
      Begin
        fltIcmEnt := CalculaComposicaoCusto.AliquotaICMSEnt;
        fltIcmSai := CalculaComposicaoCusto.AliquotaICMSSai;
        fltSubsti := 0;
      End
      Else
      begin
        fltIcmEnt := 0;
        fltIcmSai := 0;
        fltSubsti := CalculaComposicaoCusto.AliquotaST;
      End;


      fltImpFed := CalculaComposicaoCusto.ImpFed;
      fltSubFed := CalculaComposicaoCusto.SubFed;
      fltDesOpe := CalculaComposicaoCusto.DesOpe;
      fltOutVal := CalculaComposicaoCusto.OutVal;


      cdsPreVen.FieldByName('ITE_IMPFED').AsFloat := fltImpFed;
      cdsPreVen.FieldByName('ITE_SUBFED').AsFloat := fltSubFed;
      cdsPreVen.FieldByName('ITE_DESOPE').AsFloat := fltDesOpe;
      cdsPreVen.FieldByName('ITE_OUTVAL').AsFloat := fltOutVal / IIF(Self.FieldByName('ITE_CNVCUS').AsFloat <> 0, Self.FieldByName('ITE_CNVCUS').AsFloat, 1);
      cdsPreVen.FieldByName('ITE_ICMSAI').AsFloat := fltIcmSai;
      cdsPreVen.FieldByName('ITE_ICMENT').AsFloat := fltIcmEnt;
      cdsPreVen.FieldByName('ITE_SUBSTI').AsFloat := fltSubsti;

      If (fltSubFed <> cdsTabDet.FieldByName('ITE_SUBFED').AsFloat) Or
         (fltIcmEnt <> cdsTabDet.FieldByName('ITE_ICMENT').AsFloat) Or
         (fltSubsti <> cdsTabDet.FieldByName('ITE_SUBSTI').AsFloat) Then
        cdsPreVen.FieldByName('ITE_PRECUS').AsFloat := fRetPrecoCusto(cdsTabDet, '', fltIcmEnt, fltSubsti, fltSubFed)/ IIF(Self.FieldByName('ITE_CNVCUS').AsFloat <> 0, Self.FieldByName('ITE_CNVCUS').AsFloat, 1)
      Else
        cdsPreVen.FieldByName('ITE_PRECUS').AsFloat := cdsTabDet.FieldByName('ITE_PRECUS').AsFloat / IIF(Self.FieldByName('ITE_CNVCUS').AsFloat <> 0, Self.FieldByName('ITE_CNVCUS').AsFloat, 1);
    Finally
      FreeAndNil(CalculaComposicaoCusto);
    End;

    If opcMarPre = opcMargem Then
      cdsPreVen.FieldByName('PREVEN').AsFloat := cdsPreVen.FieldByName('PREORI').AsFloat
    Else
      cdsPreVen.FieldByName('MARBRU').AsFloat := cdsPreVen.FieldByName('MARORI').AsFloat;

{    If (opcMarPre = opcMargem) And (cdsTabDet.FieldByName('ITE_PREVEN').AsFloat > 0) Then
      cdsPreVen.FieldByName('PREVEN').AsFloat := cdsTabDet.FieldByName('ITE_PREVEN').AsFloat /
                                         IIF(Self.FieldByName('ITE_CNVCUS').AsFloat <> 0, Self.FieldByName('ITE_CNVCUS').AsFloat, 1);}


    cdsPreVen.FieldByName(strNomCam).AsFloat :=
                   fCalculaPrecoVenda(intMarPre,
                                      cdsPreVen.FieldByName('ITE_PRECUS').AsFloat + cdsPreVen.FieldByName('ITE_OUTVAL').AsFloat,
                                      cdsPreVen.FieldByName('PREVEN').AsFloat,
                                      cdsPreVen.FieldByName('MARBRU').AsFloat,
                                      cdsPreVen.FieldByName('ITE_ICMSAI').AsFloat,
                                      cdsPreVen.FieldByName('ITE_IMPFED').AsFloat,
                                      cdsPreVen.FieldByName('ITE_DESOPE').AsFloat,
                                      cdsPreVen.FieldByName('COMORI').AsFloat);

    If (cdsPreVen.FieldByName('MARBRU').Value <> cdsPreVen.FieldByName('MARBRU').OldValue) Or
       (cdsPreVen.FieldByName('PREVEN').Value <> cdsPreVen.FieldByName('PREVEN').OldValue) Then
      cdsPreVen.FieldByName('ALTERADO').AsString := 'S';



    cdsPreVen.Post;
    If cdsTabDet.State in dsEditModes Then
      cdsTabDet.FieldByName('FORCAL').AsString :=  IIf(opcMarPre = opcMargem, 'M', 'P');
    cdsPreVen.Next;
  End;
  cdsPreVen.EnableControls;
End;


Function TTabelaPreco.fSQLLeIteger: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '   *     ';
  strSQL := strSQL + ' FROM    ';
  strSQL := strSQL + '   ITEGER  ';
  strSQL := strSQL + ' WHERE     ';
  strSQL := strSQL + '   ITE_CODITE = :ITE_CODITE AND   ';
  strSQL := strSQL + '   ITE_CODEMP = :ITE_CODEMP       ';

  Result := strSQL;
End;

Function TTabelaPreco.fAtualizaCustosIteger: Boolean;
// ATUALIZA TODAS OS CAMPOS DO TABDET PARA O ITEGER
Begin
  Result := True;

  If cdsPreVen.IsEmpty Then
    Exit;

  cdsPreVen.First;

  qryUpdateIteger.Close;
  qryUpdateIteger.ParamByName('ITE_CODITE').AsString := cdsTabDet.FieldByName('ITE_CODITE').AsString;
  qryUpdateIteger.ParamByName('ITE_CODEMP').AsString := cdsTabDet.FieldByName('ITE_CODEMP').AsString;
  qryUpdateIteger.Open;
  qryUpdateIteger.Edit;


  If cdsTabDet.FieldByName('CUSATI').AsInteger = 1 Then
  Begin

    If fRetPrimeiraTabPrecoAtiva = cdsTabDet.FieldByName('TABELA').AsInteger Then
    Begin

      qryUpdateIteger.FieldByName('ITE_EXCIPI').AsString  := cdsTabDet.FieldByName('ITE_EXCIPI').AsString;

      If intTipAbf = 2 Then
      Begin
        qryUpdateIteger.FieldByName('ITE_CODABF').AsString  := cdsTabDet.FieldByName('ITE_CODABF').AsString;

        If fEmptyStr(qryUpdateIteger.FieldByName('ITE_CODABF').AsString) Then
          qryUpdateIteger.FieldByName('ITE_CODABF').Clear;
      End;

      If strTPABPC = '2' Then
      Begin
        qryUpdateIteger.FieldByName('ITE_ABFPIS').AsString  := cdsTabDet.FieldByName('ITE_ABFPIS').AsString;
        qryUpdateIteger.FieldByName('ITE_ABFCOF').AsString  := cdsTabDet.FieldByName('ITE_ABFCOF').AsString;
        qryUpdateIteger.FieldByName('ITE_ABFIPI').AsString  := cdsTabDet.FieldByName('ITE_ABFIPI').AsString;

        If fEmptyStr(qryUpdateIteger.FieldByName('ITE_ABFPIS').AsString) Then
          qryUpdateIteger.FieldByName('ITE_ABFPIS').Clear;

        If fEmptyStr(qryUpdateIteger.FieldByName('ITE_ABFCOF').AsString) Then
          qryUpdateIteger.FieldByName('ITE_ABFCOF').Clear;

        If fEmptyStr(qryUpdateIteger.FieldByName('ITE_ABFIPI').AsString) Then
          qryUpdateIteger.FieldByName('ITE_ABFIPI').Clear;
      End;


      qryUpdateIteger.FieldByName('ITE_CODITE').AsString := cdsTabDet.FieldByName('ITE_CODITE').AsString;
      qryUpdateIteger.FieldByName('ITE_CODEMP').AsString := cdsTabDet.FieldByName('ITE_CODEMP').AsString;

      If fRetPrimeiraTabPrecoAtiva = cdsTabDet.FieldByName('TABELA').AsInteger Then
      Begin
        qryUpdateIteger.FieldByName('ITE_PRECOM').AsFloat := cdsTabDet.FieldByName('ITE_PRECOM').AsFloat /
                                                 IIF(Self.FieldByName('ITE_CNVCUS').AsFloat <> 0,
                                                      Self.FieldByName('ITE_CNVCUS').AsFloat, 1);

        qryUpdateIteger.FieldByName('ITE_DESF01').AsFloat := cdsTabDet.FieldByName('ITE_DESF01').AsFloat;
        qryUpdateIteger.FieldByName('ITE_DESF02').AsFloat := cdsTabDet.FieldByName('ITE_DESF02').AsFloat;
        qryUpdateIteger.FieldByName('ITE_DESF03').AsFloat := cdsTabDet.FieldByName('ITE_DESF03').AsFloat;
        qryUpdateIteger.FieldByName('ITE_DESF04').AsFloat := cdsTabDet.FieldByName('ITE_DESF04').AsFloat;
        qryUpdateIteger.FieldByName('ITE_DESF05').AsFloat := cdsTabDet.FieldByName('ITE_DESF05').AsFloat;
        qryUpdateIteger.FieldByName('ITE_DESF06').AsFloat := cdsTabDet.FieldByName('ITE_DESF06').AsFloat;
        qryUpdateIteger.FieldByName('ITE_ICMENT').AsFloat := cdsTabDet.FieldByName('ITE_ICMENT').AsFloat;
        qryUpdateIteger.FieldByName('ITE_SUBFED').AsFloat := cdsTabDet.FieldByName('ITE_SUBFED').AsFloat;
        qryUpdateIteger.FieldByName('ITE_IPIENT').AsFloat := cdsTabDet.FieldByName('ITE_IPIENT').AsFloat;
        qryUpdateIteger.FieldByName('ITE_FREENT').AsFloat := cdsTabDet.FieldByName('ITE_FREENT').AsFloat;

        qryUpdateIteger.FieldByName('ITE_VALFRE').AsFloat := cdsTabDet.FieldByName('ITE_VALFRE').AsFloat /
                                                 IIF(Self.FieldByName('ITE_CNVCUS').AsFloat <> 0,
                                                      Self.FieldByName('ITE_CNVCUS').AsFloat, 1);

        qryUpdateIteger.FieldByName('ITE_ACRFIN').AsFloat := cdsTabDet.FieldByName('ITE_ACRFIN').AsFloat;
        qryUpdateIteger.FieldByName('ITE_SUBSTI').AsFloat := cdsTabDet.FieldByName('ITE_SUBSTI').AsFloat;
        qryUpdateIteger.FieldByName('ITE_DESADB').AsFloat := cdsTabDet.FieldByName('ITE_DESADB').AsFloat;

        qryUpdateIteger.FieldByName('ITE_PRECUS').AsFloat := cdsTabDet.FieldByName('ITE_PRECUS').AsFloat/
                                               IIF(Self.FieldByName('ITE_CNVCUS').AsFloat <> 0,
                                                    Self.FieldByName('ITE_CNVCUS').AsFloat, 1);;

        qryUpdateIteger.FieldByName('ITE_OUTVAL').AsFloat := cdsTabDet.FieldByName('ITE_OUTVAL').AsFloat/ IIF(Self.FieldByName('ITE_CNVCUS').AsFloat <> 0,
                                                                                                                 Self.FieldByName('ITE_CNVCUS').AsFloat, 1);

        qryUpdateIteger.FieldByName('ITE_ICMSAI').AsFloat := cdsTabDet.FieldByName('ITE_ICMSAI').AsFloat;
        qryUpdateIteger.FieldByName('ITE_IMPFED').AsFloat := cdsTabDet.FieldByName('ITE_IMPFED').AsFloat;
        qryUpdateIteger.FieldByName('ITE_DESOPE').AsFloat := cdsTabDet.FieldByName('ITE_DESOPE').AsFloat;
      End;
    End;


    qryUpdateIteger.FieldByName('ITE_PREVE' + cdsTabDet.FieldByName('TABELA').AsString).AsFloat := cdsTabDet.FieldByName('ITE_PREVEN').AsFloat/
                                                                                                   IIF(Self.FieldByName('ITE_CNVCUS').AsFloat <> 0,
                                                                                                        Self.FieldByName('ITE_CNVCUS').AsFloat, 1);
    qryUpdateIteger.FieldByName('ITE_MARBR' + cdsTabDet.FieldByName('TABELA').AsString).AsFloat := cdsTabDet.FieldByName('ITE_MARBRU').AsFloat;

    qryUpdateIteger.FieldByName('ITE_PREALT').AsString := strAgrupadorPreAlt;

  End;


  If (Not VS_blnPreAltViaTrigger) Then
    Result := fGravaPreAlt(qryUpdateIteger.FieldByName('ITE_CODITE').AsString,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_PRECUS').OldValue),
                           qryUpdateIteger.FieldByName('ITE_PRECUS').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_PREVE1').OldValue),
                           qryUpdateIteger.FieldByName('ITE_PREVE1').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_MARBR1').OldValue),
                           qryUpdateIteger.FieldByName('ITE_MARBR1').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_PREVE2').OldValue),
                           qryUpdateIteger.FieldByName('ITE_PREVE2').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_MARBR2').OldValue),
                           qryUpdateIteger.FieldByName('ITE_MARBR2').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_PREVE3').OldValue),
                           qryUpdateIteger.FieldByName('ITE_PREVE3').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_MARBR3').OldValue),
                           qryUpdateIteger.FieldByName('ITE_MARBR3').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_PREVE4').OldValue),
                           qryUpdateIteger.FieldByName('ITE_PREVE4').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_MARBR4').OldValue),
                           qryUpdateIteger.FieldByName('ITE_MARBR4').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_PREVE5').OldValue),
                           qryUpdateIteger.FieldByName('ITE_PREVE5').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_MARBR5').OldValue),
                           qryUpdateIteger.FieldByName('ITE_MARBR5').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_PREVE6').OldValue),
                           qryUpdateIteger.FieldByName('ITE_PREVE6').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_MARBR6').OldValue),
                           qryUpdateIteger.FieldByName('ITE_MARBR6').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_PREVE7').OldValue),
                           qryUpdateIteger.FieldByName('ITE_PREVE7').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_MARBR7').OldValue),
                           qryUpdateIteger.FieldByName('ITE_MARBR7').AsFloat,

                           fVariantToFloat(qryUpdateIteger.FieldByName('ITE_PRECOM').OldValue),
                           qryUpdateIteger.FieldByName('ITE_PRECOM').AsFloat,

                           'TABELA PREÇOS FORNECEDOR',

                           Nil,
                           '',
                           strLoginUsuarioLogado);

  qryUpdateIteger.Post;


End;

Function TTabelaPreco.fSQLAtualizaCadIte: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE CADITE SET  ';
  strSQL := strSQL + '   ITE_REFERE = :TFO_REFERE, ';

  strSQL := strSQL + '   ITE_BAREMB = IFNULL(:TFO_BAREMB, ITE_BAREMB), ';
  strSQL := strSQL + '   ITE_EMBALA = IF(:TFO_BAREMB IS NULL, ITE_EMBALA, :TFO_EMBALA), ';

  strSQL := strSQL + '   ITE_CODBAR = IFNULL(:TFO_CODBAR, ITE_CODBAR), ';

  strSQL := strSQL + '   ITE_PESOIT = :TFO_PESOIT, ';
  strSQL := strSQL + '   ITE_NOTESP = :TFO_NOTESP, ';
  strSQL := strSQL + '   ITE_UNICOM = :ITE_UNICOM, ';
  strSQL := strSQL + '   ITE_SITPRO = :TFO_SITPRO, ';
  strSQL := strSQL + '   ITE_PRDGRU = :TFO_PRDGRU, ';

  strSQL := strSQL + '   ITE_CODFAB = :ITE_CODFAB, ';
  strSQL := strSQL + '   ITE_DESFAB = :ITE_DESFAB, ';
  strSQL := strSQL + '   ITE_CLAIPI = :ITE_CLAIPI, ';
  strSQL := strSQL + '   ITE_DIAFOR = :ITE_DIAFOR, ';
  strSQL := strSQL + '   ITE_MLTCOM = :ITE_MLTCOM, ';

  strSQL := strSQL + '   ITE_CODABF = IFNULL(:ITE_CODABF, ITE_CODABF), ';
  strSQL := strSQL + '   ITE_ABFPIS = IFNULL(:ITE_ABFPIS, ITE_ABFPIS), ';
  strSQL := strSQL + '   ITE_ABFCOF = IFNULL(:ITE_ABFCOF, ITE_ABFCOF), ';
  strSQL := strSQL + '   ITE_ABFIPI = IFNULL(:ITE_ABFIPI, ITE_ABFIPI)  ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       ITE_CODITE = :ITE_CODITE ';
  strSQL := strSQL + '   AND ITE_CODFOR = :ITE_CODFOR ';

  Result := strSQL;
End;

Function TTabelaPreco.fAtualizaCadIte: Boolean;
  Var
    blnPrincipal: Boolean;
    strFilter: String;
Begin
  strFilter := '';
  If cdsTabDet.Filtered then
  Begin
    strFilter := cdsTabDet.Filter;
    cdsTabDet.Filtered := False;

  End;
  cdsTabDet.Filter := 'ITE_CODITE = ' + QuotedStr(Self.FieldByName('ITE_CODITE').AsString) +
                      'AND ITE_CODEMP = ' + QuotedStr(VS_StrCodEmp);
  cdsTabDet.Filtered := True;
  Try

    qryUpdateCadIte.Close;
    qryUpdateCadIte.ParamByName('ITE_CODITE').AsString := Self.FieldByName('ITE_CODITE').AsString;
    qryUpdateCadIte.ParamByName('ITE_CODFOR').AsString := Self.FieldByName('ITE_CODFOR').AsString;

    If Not fEmptyStr(Self.FieldByName('TFO_CODBAR').AsString) Then
    Begin
      qryUpdateCadIte.ParamByName('TFO_CODBAR').AsString  := Self.FieldByName('TFO_CODBAR').AsString;

      objIteBar.pCarregaDados(Self.FieldByName('ITE_CODITE').AsString);

      objIteBar.pIncluiCodigo(Self.FieldByName('TFO_CODBAR').AsString,
                              1,    // fltEmbala
                              True, // blnPrinci
                              True, // blnCompra
                              True, // blnExbFat
                              0,    // fltPreVen
                              '',   // strDescri
                              '',   // strTabPre
                              Self.FieldByName('ITE_CODFOR').AsString,
                              0,0,0,0,0,0,0,0);

       objIteBar.pSalvaDados(Self.FieldByName('ITE_CODITE').AsString);
     End;

    If Not fEmptyStr(Self.FieldByName('TFO_BAREMB').AsString) Then
    Begin
      qryUpdateCadIte.ParamByName('TFO_BAREMB').AsString  := Self.FieldByName('TFO_BAREMB').AsString;
      qryUpdateCadIte.ParamByName('TFO_EMBALA').AsFloat   := Self.FieldByName('TFO_EMBALA').AsFloat;

      objIteBar.IncluiPrincipalParaCompras(Self.FieldByName('ITE_CODITE').AsString,
                                           Self.FieldByName('TFO_BAREMB').AsString,
                                           Self.FieldByName('TFO_EMBALA').AsFloat,
                                           blnPrincipal);

      If blnPrincipal Then
        qryUpdateCadIte.ParamByName('TFO_CODBAR').AsString  := Self.FieldByName('TFO_BAREMB').AsString;
    End;

    qryUpdateCadIte.ParamByName('TFO_REFERE').AsString  := Self.FieldByName('TFO_REFERE').AsString;
    qryUpdateCadIte.ParamByName('ITE_CODFAB').AsString  := Self.FieldByName('ITE_CODFAB').AsString;
    qryUpdateCadIte.ParamByName('ITE_DESFAB').AsString  := Self.FieldByName('ITE_DESFAB').AsString;
    qryUpdateCadIte.ParamByName('ITE_CLAIPI').AsString  := Self.FieldByName('ITE_CLAIPI').AsString;
    qryUpdateCadIte.ParamByName('ITE_DIAFOR').AsInteger := Self.FieldByName('ITE_DIAFOR').AsInteger;
    qryUpdateCadIte.ParamByName('TFO_PESOIT').Value     := Self.FieldByName('TFO_PESOIT').Value;
    qryUpdateCadIte.ParamByName('ITE_MLTCOM').AsFloat   := Self.FieldByName('ITE_MLTCOM').AsFloat;
    qryUpdateCadIte.ParamByName('TFO_NOTESP').AsString  := Self.FieldByName('TFO_NOTESP').AsString;

    If (intTipAbf = 1)  Then
    Begin
      qryUpdateCadIte.ParamByName('ITE_CODABF').AsString  := cdsTabDet.FieldByName('ITE_CODABF').AsString;

      If fEmptyStr(qryUpdateCadIte.ParamByName('ITE_CODABF').AsString) Then
        qryUpdateCadIte.ParamByName('ITE_CODABF').Clear;
    End;

    If strTPABPC = '1' Then
    Begin
      qryUpdateCadIte.ParamByName('ITE_ABFPIS').AsString  := cdsTabDet.FieldByName('ITE_ABFPIS').AsString;
      qryUpdateCadIte.ParamByName('ITE_ABFCOF').AsString  := cdsTabDet.FieldByName('ITE_ABFCOF').AsString;
      qryUpdateCadIte.ParamByName('ITE_ABFIPI').AsString  := cdsTabDet.FieldByName('ITE_ABFIPI').AsString;

      If fEmptyStr(qryUpdateCadIte.ParamByName('ITE_ABFPIS').AsString) Then
        qryUpdateCadIte.ParamByName('ITE_ABFPIS').Clear;

      If fEmptyStr(qryUpdateCadIte.ParamByName('ITE_ABFCOF').AsString) Then
        qryUpdateCadIte.ParamByName('ITE_ABFCOF').Clear;

      If fEmptyStr(qryUpdateCadIte.ParamByName('ITE_ABFIPI').AsString) Then
        qryUpdateCadIte.ParamByName('ITE_ABFIPI').Clear;
    End;

    If fEmptyStr(Self.FieldByName('ITE_UNICOM').AsString) Then
      qryUpdateCadIte.ParamByName('ITE_UNICOM').Clear
    Else
      qryUpdateCadIte.ParamByName('ITE_UNICOM').AsString  := Self.FieldByName('ITE_UNICOM').AsString;

    If fEmptyStr(Self.FieldByName('TFO_PRDGRU').AsString) Then
      qryUpdateCadIte.ParamByName('TFO_PRDGRU').Clear
    Else
      qryUpdateCadIte.ParamByName('TFO_PRDGRU').AsString := Self.FieldByName('TFO_PRDGRU').AsString;

    If fEmptyStr(Self.FieldByName('TFO_SITPRO').AsString) Then
      qryUpdateCadIte.ParamByName('TFO_SITPRO').Clear
    Else
      qryUpdateCadIte.ParamByName('TFO_SITPRO').AsString  := Self.FieldByName('TFO_SITPRO').AsString;

    qryUpdateCadIte.Execute;

    Result := True;
  Finally
    cdsTabDet.Filtered := False;
    If strFilter <> '' Then
    Begin
      cdsTabDet.Filter := strFilter;
      cdsTabDet.Filtered := True;
    End
    Else
      cdsTabDet.Filter := '';
  End;
End;

Procedure TTabelaPreco.pAtualizaCadIteGeral(cxProgresso: TCxProgressBar);
Begin
  cxProgresso.Properties.Max := RecordCount;
  cxProgresso.Position := 0;

  Self.Filter   := 'ALTERADO = ' + QuotedStr('S');
  Self.Filtered := True;

  Self.First;

  While Not Self.Eof Do
  Begin
   fAtualizaCadIte;

   Self.Next;

   cxProgresso.Position := cxProgresso.Position + 1;
   Application.ProcessMessages;
  End;

  Self.Filtered := False;
End;

end.

