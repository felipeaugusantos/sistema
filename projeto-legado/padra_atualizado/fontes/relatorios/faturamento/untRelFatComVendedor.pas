unit untRelFatComVendedor;

interface
{$WARN NO_RETVAL OFF}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls, Math,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, UniClientDataSet, DB, untTypesSistema,
  UniDataSetProvider, AppEvnts, CheckLst, ComboBoxFocus, untFuncoes, untFuncoesSimples,
  ComCtrls, BitBtnLockedIncrem, MemDS, DBAccess, untConsultas, untFuncoesConsulta,
  frxExportCSVTestabilidade, Datasnap.DBClient, cxGraphics, cxControls, untFuncFat,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DirectoryEditFocus, FileCtrl, untCadPro,
  untCadNegBussiness;

type
  TRelTotSin = Record
    fltQtdTot,
    fltTotVen,
    fltTotCus,
    fltTotCom,
    fltTotMed,
    fltTotUlt,
    fltTotMar,
    fltResult,
    fltTotIte,
    fltTotIteNF,
    fltTotComNF,
    fltTotIteOU,
    fltTotComOU,
    fltTotIteTR,
    fltTotComTR: Double;
  end;

type
  TfrmRelFatComVendedor = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblVenDig: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbTipo: TGroupBox;
    ColorLabel6: TColorLabel;
    edtTipo: TEditFocus;
    Label2: TLabel;
    lstClaFis: TMemo;
    Label1: TLabel;
    Label3: TLabel;
    shpLiberado: TShape;
    gpbOrdem: TGroupBox;
    lblOrdem2: TColorLabel;
    edtOrdem: TEditFocus;
    chkResAliq: TCheckBox;
    frxPaginaM: TfrxReport;
    gpbMargem: TGroupBox;
    ColorLabel9: TColorLabel;
    edtMargem: TEditFocus;
    frxSinVen: TfrxDBDataset;
    frxPaginaJ: TfrxReport;
    gpbAgrupar: TGroupBox;
    edtOpcAgru: TEditFocus;
    gpbEmpresa: TGroupBox;
    ColorLabel12: TColorLabel;
    edtEmpFat: TEditFocus;
    grbFilTab: TGroupBox;
    chkFilTab: TCheckBox;
    clbTabPre: TCheckListBox;
    cbxVendedor: TComboBoxFocus;
    Label4: TLabel;
    Label9: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    chkPedPen: TCheckBox;
    Label15: TLabel;
    edtCodAti: TEditFocus;
    edtAtividade: TEditFocus;
    qryResAlq: TUniQuery;
    prbProgresso: TProgressBar;
    gpbOpcao: TGroupBox;
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    ColorLabel7: TColorLabel;
    ColorLabel8: TColorLabel;
    ColorLabel10: TColorLabel;
    ColorLabel13: TColorLabel;
    ColorLabel14: TColorLabel;
    edtOpcao: TEditFocus;
    frxUserRelatorio: TfrxUserDataSet;
    cdsQtdVen: TUniClientDataSet;
    cdsQtdVenCODVEN: TStringField;
    cdsQtdVenQTDDOC: TIntegerField;
    shpMargem: TShape;
    ColorLabel11: TColorLabel;
    ColorLabel15: TColorLabel;
    ColorLabel18: TColorLabel;
    shpOpcaoRel: TShape;
    lbl1: TLabel;
    edtCodCnd: TEditFocus;
    edtDesCnd: TEditFocus;
    Label7: TLabel;
    edtCodDepProd: TEditFocus;
    edtDesDepProd: TEditFocus;
    lbl2: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    lbl5: TLabel;
    edtCliExc: TEditFocus;
    edtDesExc: TEditFocus;
    ColorLabel19: TColorLabel;
    lbl6: TLabel;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    lbl3: TLabel;
    cmbTipVen: TComboBoxFocus;
    lblOrdem1: TColorLabel;
    ColorLabel21: TColorLabel;
    ColorLabel22: TColorLabel;
    ColorLabel23: TColorLabel;
    Label10: TLabel;
    cbbComCus: TComboBoxFocus;
    chkCadCom: TCheckBox;
    frxResFai: TfrxDBDataset;
    lblLinhaGrupoIni: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    shpTipoRel: TShape;
    Label11: TLabel;
    shpGer: TShape;
    edtCodGer: TEditFocus;
    edtDesGer: TEditFocus;
    Label12: TLabel;
    shpSubGer: TShape;
    edtCodSubGer: TEditFocus;
    edtDesSubGer: TEditFocus;
    Label13: TLabel;
    edtCodPro: TEditFocus;
    edtDesPro: TEditFocus;
    rdgItePro: TRadioGroup;
    lblOrdem3: TColorLabel;
    ColorLabel16: TColorLabel;
    edtCodMarca: TEditFocus;
    Label14: TLabel;
    edtDesMarca: TEditFocus;
    chkEjeVen: TCheckBox;
    chkPDFVen: TCheckBox;
    edtDirPDF: TEditFocus;
    btnDirPDF: TBitBtnLocked;
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pAtualizaClaFis;
    procedure edtTipoExit(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);
    procedure frxGenGetValue(const VarName: String; var Value: Variant);

    function fCriaResAliquota(strCodVen: String): Boolean;
    function frxPaginaMUserFunction(const MethodName: String; var Params: Variant): Variant;
    procedure chkFilTabClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxVendedorChange(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtOpcaoExit(Sender: TObject);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure frxUserRelatorioCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxUserRelatorioFirst(Sender: TObject);
    procedure frxUserRelatorioGetValue(const VarName: string;
      var Value: Variant);
    procedure frxUserRelatorioNext(Sender: TObject);
    procedure frxUserRelatorioPrior(Sender: TObject);
    procedure frxUserRelatorioNewGetValue(Sender: TObject;
      const VarName: string; var Value: Variant);
    procedure pnlDadosClick(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepProdExit(Sender: TObject);
    procedure edtCodDepProdKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCliExcExit(Sender: TObject);
    procedure edtCliExcKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtCodGerKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGerExit(Sender: TObject);
    procedure edtCodSubGerExit(Sender: TObject);
    procedure edtCodSubGerKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProExit(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarcaExit(Sender: TObject);
    procedure edtCodMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure chkPDFVenClick(Sender: TObject);
    procedure btnDirPDFClick(Sender: TObject);

  private
    { Private declarations }
    blnOpcAgg: Boolean;
    blnFreCom: Boolean;
    intTotGeral: Integer;
    strMarMkp: String;
    strMarMkp12: String;
    strPmcPro: String;
    fltTaxRep: Double;

    arrAtividade: TConsultasArray;
    arrOperador : TConsultasArray;
    arrDep      : TConsultasArray;
    arrEmp      : TConsultasArray;
    arrCnd      : TConsultasArray;
    arrDepProd  : TConsultasArray;
    arrCliente  : TConsultasArray;
    arrCliExc   : TConsultasArray;
    arrFor      : TConsultasArray;
    arrLinGru   : TConsultasArray;
    arrGer      : TConsultasArray;
    arrSubGer   : TConsultasArray;
    arrPro      : TConsultasArray;
    arrMar      : TConsultasArray;

    strAtivid   : String;
    strOperador : String;
    strDep      : String;
    strEmp      : String;
    strCnd      : String;
    strDepProd  : String;
    strCodCli   : String;
    strCliExc   : String;
    strFor      : String;
    strLinGru   : String;
    strGer      : String;
    strSubGer   : String;
    strPro      : String;
    strMar      : String;

    intGruLev: Integer;

    qryDadSin: TUniQuery;
    cdsDadSin: TUniClientDataSet;
    dspDadSin: TUniDataSetProvider;

    qryRelat : TUniQuery;
    cdsRelat: TUniClientDataSet;
    dspRelat: TUniDataSetProvider;

    blnLibVen     : Boolean;
    blnLibOpc     : Boolean;
    blnLibTip     : Boolean;
    blnLibGer     : Boolean;
    blnLibSub     : Boolean;

    STR_OPECOM : String;
    STR_OPECO2 : String;
    STR_ITECOM : String;
    STR_ITECO2 : String;

    cdsFaixa   : TUniClientDataSet;

    stlVendedor: TStringList;

    blnIgnorarNaBaseCalculoDescontoDadoEmConfirmacao: Boolean;

    procedure pRetiraDescFF(Var strSQLAux: String);
    procedure pAtualizaMargem;
    procedure pMontaSqlPerComItem(Var strSql: String);
    Procedure pResumo;
    procedure pAbreClient(cdsDados: TUniClientDataSet;
                          qryDados: TUniQuery;
                          dspDados: TUniDataSetProvider;
                          strSQL: String);

    Procedure pCriaAggregates;
    Procedure pCriaIndicesAgrupamento;
    procedure pUserRelatorioGetValue(const VarName: string; var Value: Variant);

    procedure pIncluiQtdVendedor(strCodVen: String;
                                intQtdDoc: Integer);

    Function fCamCom(blnTotComOU:Boolean = False): String;
    Function fCamComNF: String;
    Function fCamComTR: String;
    Function fCodVen(strOrdem: String): String;
    function fRetPedidosPendentes(strCodVen: String): String;
    Function fSqlFiltros(blnServico: Boolean): String;
    Function fSqlRelatorio(strFiltroAdicional: String = ''): String;
    Function fSqlServico: String;
    Function fSqlServicoResumo: String;
    Function fSqlUnion: String;
    Function fSQLJoinCadOpe: String;
    Function fSQLJoinBase: String;

    Function fCamposGrupo: String;
    Function fCamposOrdem: String;
    Function fRetGroupingLevel: Integer;
    Function fRetIndice: String;
    Function fComTp: String;
    Function fComTpS: String;
    Function fRetQtdDoc(strCodVen: String): Integer;
    procedure pFormataRelatorioOpcao4Analitico(qckRel: TfrxReport);
    procedure pGeraExcel;
    function fStrTaxRep: String;
    function fRetClientesFilialLocal: String;
    Procedure pCriaClientFaixas;
    procedure pAddResumoPorFaixa(strCodVen,
                                 strConPag: String;
                                 fltMargem,
                                 fltVlrVen,
                                 fltVlrCus,
                                 fltTaxRep:Double);
    procedure pAddFaixasNaoInclusas;
    procedure pVerdeVermelho(edt:TEditFocus; shp:TShape; bln: Boolean);
    function fCalculaPrecoCustoItem(fltUniOri, fltQtdIte: Double; strCodIte, strCodEmp, strNumDoc, strEspDoc, strCodCli: String): Double;

    function fTemRegSerMov: Boolean;
    function fCaseCodSer: String;
    function fCaseDesSer: String;
    function fCaseQtdSer: String;
    function fCaseValSer: String;
    function fCaseCusSer: String;
    function fTabIdeSer: String;
    function fCaseIdeSer: String;
    function fCaseComSer: String;
    function fCaseVenSer: String;

    function fUsaVen2: Boolean;
    function fRetCampoPercom: String;
    procedure pExportarPDFParaCadaVendedor(qckRel: TfrxReport);
    procedure pHabilitaOpcoesPDF;
    function fComDig: Boolean;
    function fRetTabPreSelChkLis(ChkLis: TCheckListBox): String;
    procedure pCarregaChkLisTabPre(Var ChkLis: TCheckListBox);

  public
    { Public declarations }
    blnSenha      : Boolean;
    blnMostraGrupo: Boolean;
    strCodVen     : String;
    strTeste      : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  end;

var
  frmRelFatComVendedor: TfrmRelFatComVendedor;

implementation

uses untModulo, untExcel, untConstantes, untClassPanelCx;

{$R *.dfm}

Const
  SQL_PERCOM_VENDEDOR = 'IFNULL(IF(DET_CONPAG = "01000", OPE_PERCOM, OPE_PERCO2), 0)';
  SQL_PERCOM_CLIENTE_VENDEDOR = 'IF(IFNULL(CLI_PERCOM,0) > 0, CLI_PERCOM, IFNULL(IF(DET_CONPAG = "01000", OPE_PERCOM, OPE_PERCO2), 0))';

  arrVenRep: Array[0..5] Of String[20] = ('VENDEDOR 1', 'VENDEDOR 2', 'DIGITADOR', 'REPRESENTANTE', 'SUPERVISOR GERAL', 'SUPERVISOR REGIONAL');
  arrVenMin: Array[0..5] Of String[20] = ('Vendedor 1', 'Vendedor 2', 'Digitador', 'Representante', 'Supervisor Geral', 'Supervisor Regional');

  VEN_INTERNO = 0;
  VEN_EXTERNO_LOJA = 1;
  VEN_EXTERNO_DISTRIB = 2;
  VEN_TODOS = 3;

{**************************************}
{* MONTA SELECT DE RESUMO DE ALIQUOTA *}
{***********************************AF*}
function TfrmRelFatComVendedor.fCriaResAliquota(strCodVen: String): Boolean;
  Var
    STR_CNDCOM: String;
    strSelect : String;
    strSQL    : String;
    strComTP  : String;
begin
  Result := True;

  STR_OPECOM := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                ' -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                '  (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100))) ';

  STR_OPECO2 := ' IF(DET_CODVE2 IS NULL, 0, ' +
                '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, (IF(LEFT(DET_CLAFIS,1) < 5, '      +
                '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100)) ' +
                ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100)) ';

  STR_CNDCOM := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                '  - DET_TOTCOM, (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * CND_PERCOM)/100))) ';

  STR_ITECOM := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                '   -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100), '     +
                '    (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100))), 2) ';

  STR_ITECO2 := ' IF(DET_CODVE2 IS NULL, 0, ' +
                '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100), '     +
                '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100)), 2) ' +
                ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  If Not chkResAliq.Checked Then
    Exit;

  {**************************************}
  {* SELECT PRINCIPAL                   *}
  {***********************************AF*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  strSQL := strSQL + '  OPE_CODOPE AS CODVEN, ';

  Case StrToInt(edtOpcao.Text) Of
    1:
    Begin
      If (fComDig) Then
        strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, DET_PERDIG) AS PERCOM, '
      Else
      Begin
        strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  ';
        strSQL := strSQL + '      IF(IFNULL(DET_CODVE2, "") = "", DET_PERCOM, DET_PERCOM * (' + fStrTaxRep + '/100) ) ) AS PERCOM, ';
      End;

      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) AS TOTITE, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, SUM(IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTCO2, DET_TOTCO2)))                             AS TOTCO2, ';

      If (fComDig) Then
        strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, SUM(IF(LEFT(DET_CLAFIS,1) < 5, -DET_COMDIG, DET_COMDIG)))                           AS TOTCOM, '
      Else
        strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, SUM(IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTCOM, DET_TOTCOM)))                           AS TOTCOM, ';

      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, SUM(IF(LEFT(DET_CLAFIS,1) < 5, -DET_COMREP, DET_COMREP)))                             AS TOTREP  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + fSQLJoinBase;
      strSQL := strSQL + fSQLJoinCadOpe;

      strSQL := strSQL + 'WHERE    ';

      strSQL := strSQL + '  OPE_CODOPE = :CODVEN AND ';

      strSQL := strSQL + fSQLFiltros(False) ;

      strSQL := strSQL + 'GROUP BY      ';
      strSQL := strSQL + '  CODVEN, ';
      If (fComDig) Then
        strSQL := strSQL + '  DET_PERDIG  '
      Else
        strSQL := strSQL + '  PERCOM  ';
    End;

    2:
    Begin
      //strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  IFNULL(OPE_PERCOM, 0)) AS PERCOM, ';
      strSQL := strSQL + ' IF( (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ';
      strSQL := strSQL + '  IF(IFNULL(DET_CODVE2,"") = "", IFNULL(' + fRetCampoPercom + ',0), (IFNULL(' + fRetCampoPercom + ',0) * ' + fStrTaxRep + ' ) / 100) ';
      strSQL := strSQL + '  ) AS PERCOM, ';

      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')))  AS TOTITE, ';

      //strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, (SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) * IFNULL(OPE_PERCOM, 0) / 100) AS TOTCO2, ';
      strSQL := strSQL +  'SUM(' + STR_OPECO2 + ') AS TOTCO2, ';

      //strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, (SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) * IFNULL(OPE_PERCOM, 0) / 100) AS TOTCOM, ';
      strSQL := strSQL +  'SUM(' + STR_OPECOM + ') AS TOTCOM, ';

      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, (SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) * IFNULL(' + fRetCampoPercom + ', 0) / 100) AS TOTREP  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + fSQLJoinBase;
      strSQL := strSQL + fSQLJoinCadOpe;

      strSQL := strSQL + 'WHERE   ';

      strSQL := strSQL + '  OPE_CODOPE = :CODVEN AND ';

      strSQL := strSQL + fSQLFiltros(False);
      strSQL := strSQL + ' GROUP BY PERCOM '; // OPE_PERCOM
    End;

    3:
    Begin
      strSQL := strSQL + '  DET_CODVE2 AS CODVE2, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  PERCENTUAL) AS PERCOM, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  PERCENTUAL) * ('+fStrTaxRep+' / 100) AS PERCO2, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')))  AS TOTITE, ';
      If fUsaVen2 Then
        strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(DET_CODVE2 IS NULL, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * (PERCENTUAL / 100) * ('+fStrTaxRep+' / 100))) AS TOTCO2,  '
      Else
        strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL / 100)) AS TOTCO2,  ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL / 100)) AS TOTCOM,  ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL / 100)) AS TOTREP,  ';

      strSQL := strSQL + 'SUM(' + STR_ITECOM + ') AS ITECOM, ';
      strSQL := strSQL + 'SUM(' + STR_ITECO2 + ') AS ITECO2 ';

      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + fSQLJoinBase;
      strSQL := strSQL + fSQLJoinCadOpe;

      strSQL := strSQL + 'WHERE   ';

      strSQL := strSQL + '  OPE_CODOPE = :CODVEN AND ';

      strSQL := strSQL + fSQLFiltros(False);
      strSQL := strSQL + ' GROUP BY '+IIF(fUsaVen2,'CODVEN,','')+' PERCOM ';

      pMontaSqlPerComItem(strSQL);
    End;

    4:
    Begin
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  IFNULL(FOR_PERCOM, 0)) AS PERCOM, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')))  AS TOTITE, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * IFNULL(FOR_PERCOM, 0) / 100)) AS TOTCO2, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * IFNULL(FOR_PERCOM, 0) / 100)) AS TOTCOM, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * IFNULL(FOR_PERCOM, 0) / 100)) AS TOTREP  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + fSQLJoinBase;
      strSQL := strSQL + '  LEFT  JOIN CADFOR ON DET_FORITE = FOR_CODFOR ';
      strSQL := strSQL + fSQLJoinCadOpe;

      strSQL := strSQL + 'WHERE   ';

      strSQL := strSQL + '  OPE_CODOPE = :CODVEN AND ';

      strSQL := strSQL + fSQLFiltros(False);
      strSQL := strSQL + ' GROUP BY FOR_PERCOM ';
    End;

    7:
    Begin
      strComTP := '';
      strComTP := strComTP + '  IF(DET_TABPRE="1", ' + AnsiReplaceStr(fCfgSis('COMTP1', varDouble),',','.') + ', ';
      strComTP := strComTP + '  IF(DET_TABPRE="2", ' + AnsiReplaceStr(fCfgSis('COMTP2', varDouble),',','.') + ', ';
      strComTP := strComTP + '  IF(DET_TABPRE="3", ' + AnsiReplaceStr(fCfgSis('COMTP3', varDouble),',','.') + ', ';
      strComTP := strComTP + '  IF(DET_TABPRE="4", ' + AnsiReplaceStr(fCfgSis('COMTP4', varDouble),',','.') + ', ';
      strComTP := strComTP + '  IF(DET_TABPRE="5", ' + AnsiReplaceStr(fCfgSis('COMTP5', varDouble),',','.') + ', ';
      strComTP := strComTP + '  IF(DET_TABPRE="6", ' + AnsiReplaceStr(fCfgSis('COMTP6', varDouble),',','.') + ', ';
      strComTP := strComTP + '  IF(DET_TABPRE="7", ' + AnsiReplaceStr(fCfgSis('COMTP7', varDouble),',','.') + ', 0))))))) ';

      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  IFNULL(' + strComTP + ', 0)) AS PERCOM, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')))  AS TOTITE, ';

      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ((((SUM(IF(DET_CODVE2 IS NULL OR DET_CODVE2 = "", 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')))) * IFNULL(' + strComTP + ', 0) / 100) ';
      strSQL := strSQL + ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100)) AS TOTCO2, ';

      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, (SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) * IFNULL(' + strComTP + ', 0) / 100) AS TOTCOM, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, (SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) * IFNULL(' + strComTP + ', 0) / 100) AS TOTREP  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + fSQLJoinBase;
      strSQL := strSQL + fSQLJoinCadOpe;

      strSQL := strSQL + 'WHERE   ';

      strSQL := strSQL + '  OPE_CODOPE = :CODVEN AND ';

      strSQL := strSQL + fSQLFiltros(False);
      strSQL := strSQL + ' GROUP BY ' + strComTP ;
    End;

    10:
    Begin
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  IFNULL(CND_PERCOM, 0)) AS PERCOM, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')))  AS TOTITE, ';
      strSQL := strSQL + '  SUM( ' + STR_CNDCOM + ' ) AS TOTCOM, ';
      strSQL := strSQL + '  SUM( ' + STR_CNDCOM + ' ) AS TOTCO2, ';
      strSQL := strSQL + '  SUM( ' + STR_CNDCOM + ' ) AS TOTREP  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + fSQLJoinBase;
      strSQL := strSQL + '  LEFT JOIN CADCND ON CND_CODIGO = DET_CODCND ';
      strSQL := strSQL + fSQLJoinCadOpe;

      strSQL := strSQL + 'WHERE   ';

      strSQL := strSQL + '  OPE_CODOPE = :CODVEN AND ';

      strSQL := strSQL + fSQLFiltros(False);
      strSQL := strSQL + ' GROUP BY CND_PERCOM ';
    End;

    11:
    Begin
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  ' + fRetCampoPercom + ') AS PERCOM, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')))  AS TOTITE, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, (SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) * ' + fRetCampoPercom + ' / 100) AS TOTCO2, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, (SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) * ' + fRetCampoPercom + ' / 100) AS TOTCOM, ';
      strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, (SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) * ' + fRetCampoPercom + ' / 100) AS TOTREP  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + fSQLJoinBase;
      strSQL := strSQL + fSQLJoinCadOpe;

      strSQL := strSQL + 'WHERE   ';

      strSQL := strSQL + '  OPE_CODOPE = :CODVEN AND ';

      strSQL := strSQL + fSQLFiltros(False);
      strSQL := strSQL + ' GROUP BY ' + fRetCampoPercom;
    End;

  End;

  strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

  If fTemRegSerMov Then
    strSQL := strSQL + ' UNION ALL ' + fSqlServicoResumo();

  If (StrToInt(edtOpcao.Text) < 5) Or
     (StrToInt(edtOpcao.Text) = 7) Or
     (StrToInt(edtOpcao.Text) = 10) Or
     (StrToInt(edtOpcao.Text) = 11) Then
  Begin

    strSelect := '';
    strSelect := strSelect + 'SELECT  ';

    If ((edtOpcao.Text = '3') And (Not fUsaVen2) And (cbxVendedor.ItemIndex = 1)) Then
      strSelect := strSelect + '  (IF(SUM(TOTITE) = 0, 0.00, IFNULL(SUM(ITECO2), 0)) / SUM(TOTITE) * 100) AS ALIQUOTA, '
    Else If ((edtOpcao.Text = '3') And (Not fUsaVen2) And (cbxVendedor.ItemIndex = 0)) Then
      strSelect := strSelect + '  (IF(SUM(TOTITE) = 0, 0.00, IFNULL(IF(CODVE2 IS NULL, SUM(ITECOM), SUM(ITECOM - ITECO2)) ,0)) / SUM(TOTITE) * 100) AS ALIQUOTA, '
    Else If Pos(edtOpcao.Text, '2_7_'+IIF(fUsaVen2,'3_','')) > 0  Then
      strSelect := strSelect + '  (SUM(TOTCOM - TOTCO2) / SUM(TOTITE) * 100) AS ALIQUOTA, '
    Else
      strSelect := strSelect + '  (SUM(TOTCOM) / SUM(TOTITE) * 100) AS ALIQUOTA, ';

    strSelect := strSelect + '  SUM(TOTITE) AS BASE,     ';

    If ((edtOpcao.Text = '3') And (Not fUsaVen2) And (cbxVendedor.ItemIndex = 1)) Then
      strSelect := strSelect + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL(SUM(ITECO2), 0)) AS VR_COM    '
    Else If ((edtOpcao.Text = '3') And (Not fUsaVen2) And (cbxVendedor.ItemIndex = 0)) Then
      strSelect := strSelect + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL(IF(CODVE2 IS NULL, SUM(ITECOM), SUM(ITECOM - ITECO2)) ,0)) AS VR_COM    '
    Else If Pos(edtOpcao.Text, '2_7_'+IIF(fUsaVen2,'3_','')) > 0 Then
      strSelect := strSelect + '  SUM(TOTCOM - TOTCO2) AS VR_COM    '
    Else
      strSelect := strSelect + '  SUM(TOTCOM) AS VR_COM    ';

    strSelect := strSelect + 'FROM ';
    strSelect := strSelect + '  (' + strSQL + ') AS VW_RES_ALQ_GERAL  ';
    strSelect := strSelect + 'GROUP BY ';
    strSelect := strSelect + '  PERCOM ';
    strSelect := strSelect + 'ORDER BY ';
    strSelect := strSelect + '  PERCOM ';

    With qryResAlq Do
    Begin
      Close;
      SQL.Clear;

      pRetiraDescFF(strSelect);

      SQL.Add(strSelect);

      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;
      ParamByName('CODVEN').AsString := strCodVen;

      If cmbTipVen.ItemIndex <> VEN_TODOS Then
        Case cmbTipVen.ItemIndex Of
          VEN_INTERNO        : ParamByName('TIPVEN').AsString := 'I';
          VEN_EXTERNO_LOJA   : ParamByName('TIPVEN').AsString := 'E';
          VEN_EXTERNO_DISTRIB: ParamByName('TIPVEN').AsString := 'D';
        End;

      pSetaParam(edtCodDep.Text,arrDep, strDep,'CODDEP', qryResAlq);
      pSetaParam(edtCodDepProd.Text,arrDepProd, strDepProd,'CODDEPPROD', qryResAlq);
      pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryResAlq);
      pSetaParam(edtCodEmpresa.Text,arrEmp, strEmp,'CODEMP', qryResAlq);
      pSetaParam(edtCodAti.Text,arrAtividade,strAtivid,'CODATI', qryResAlq);
      pSetaParam(edtCodCnd.Text,arrCnd,strCnd,'CODCND', qryResAlq);
      pSetaParam(edtCodCli.Text,arrCliente,strCodCli,'CODCLI',qryResAlq);
      pSetaParam(edtCliExc.Text,arrCliExc,strCliExc,'CLIEXC',qryResAlq);
      pSetaParam(edtCodFor.Text,arrFor,strFor,'CODFOR',qryResAlq);
      pSetaParam(edtCodPro.Text, arrPro, strPro, 'CODITE', qryResAlq);
      pSetaParam(edtCodMarca.Text, arrMar, strMar, 'CODMAR', qryResAlq);

      Open;
    End;
  End;

  Result := True;
End;

procedure TfrmRelFatComVendedor.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  If (blnLibVen) Then
    pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrOperador, fRetNomVendRep, Nil, 'do vendedor');
  fValidaCampos(edtCodVendedor, True);

end;

procedure TfrmRelFatComVendedor.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLibVen) And
     (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrOperador, False)) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatComVendedor.edtDestinoExit(Sender: TObject);
begin
  //inherited;
  If fEmptyStr(edtDestino.Text) Or (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido com V, I ou E!', ['&Ok']);
    pSetFocus(edtDestino);
  End;

  If (edtDestino.Text = 'E') And ((chkCadCom.Enabled) Or (chkCadCom.Checked)) Then
  Begin
    chkCadCom.Enabled := False;
    chkCadCom.Checked := False;
  End
  Else
    chkCadCom.Enabled := True;
end;

procedure TfrmRelFatComVendedor.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

end;

procedure TfrmRelFatComVendedor.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatComVendedor.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtDesFor, arrFor, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmRelFatComVendedor.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComVendedor.edtCodGerExit(Sender: TObject);
begin
  inherited;

  If (blnLibGer) Then
    pEdtCodSelectExit(edtCodGer, edtDesGer, arrGer, fRetNomVendRep, nil, 'do Gerente');
  fValidaCampos(edtCodGer, True);

end;

procedure TfrmRelFatComVendedor.edtCodGerKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLibGer) Then
  Begin
    If (fPesqOperador(Self, edtCodGer, edtDesGer, nil, Key, arrGer, False, True, True)) Then
    Begin
      If fValidaCampos(edtCodGer, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelFatComVendedor.edtCodMarcaExit(Sender: TObject);
begin
  inherited;
    pEdtCodSelectExit(edtCodMarca,edtDesMarca,arrMar,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelFatComVendedor.edtCodMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMarca, edtDesMarca, Nil, Key, arrMar, False) Then
  Begin
    If fValidaCampos(edtCodMarca, True) Then
       SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComVendedor.edtCodSubGerExit(Sender: TObject);
begin
  inherited;

  If (blnLibSub) Then
    pEdtCodSelectExit(edtCodSubGer, edtDesSubGer, arrSubGer, fRetNomVendRep, Nil, 'do Sub-Gerente');
  fValidaCampos(edtCodSubGer, True);

end;

procedure TfrmRelFatComVendedor.edtCodSubGerKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLibSub) And
     (fPesqOperador(Self, edtCodSubGer, edtDesSubGer, nil, Key, arrSubGer, False, True, False, False, False, False, False, True)) Then
  Begin
    If fValidaCampos(edtCodSubGer, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelFatComVendedor.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtTipo) Then
    Begin

      If Pos(edtTipo.Text,'1234') <= 0 Then
      Begin
        fMensagem('','O campo Tipo deve ser 1,2,3 ou 4!',['&OK']);
        Result := False;
      End;

    End

    Else If (Sender = edtOpcao) Then
    Begin

      If (Pos(edtOpcao.Text,'1_2_3_4_5_6_7_8_9_10_11_12_13_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!','O campo opção deve ser 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ou 13!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = cbxVendedor) Then
    Begin

      if Not fCfgSis('USADIG', varBoolean) Then
      Begin
        If cbxVendedor.ItemIndex = 2 Then
        Begin
          fMensagem('ATENÇÃO!','O campo opção de vendedor deve ser 1, 2, 4, 5 ou 6!',['&O K']);
          Result := False;
        End;
      End

    End

    Else If (Sender = edtEmpFat) Then
    Begin

      If Pos(edtEmpFat.Text,'FP') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo (empresa do...) deve ser F ou P!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodVendedor) Then
    Begin
      Result := fValidaGerSubVen(blnLibVen, 'V', edtCodVendedor, edtDesVendedor, String(arrVenMin[cbxVendedor.ItemIndex]));
    End

    Else If (Sender = edtCodSubGer) Then
    Begin
      Result := fValidaGerSubVen(blnLibSub, 'S', edtCodSubGer, edtDesSubGer);
    End

    Else If (Sender = edtCodGer) Then
    Begin
      Result := fValidaGerSubVen(blnLibGer, 'G', edtCodGer, edtDesGer);
    End

    Else If (Sender = edtOrdem) Then
    Begin
      If edtTipo.Text = '2' Then
      Begin
        If Pos(edtOrdem.Text,'13') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!','O campo ordem deve ser 1 ou 3!',['&O K']);
          Result := False;
        End;
      End
      Else
      Begin
        If Pos(edtOrdem.Text,'123') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!','O campo ordem deve ser 1, 2 ou 3!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtOpcAgru) Then
    Begin

      If Pos(edtOpcAgru.Text,'D_C_L_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','A opção de agrupamento deve ser D, C ou L!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If (Not fEmptyStr(edtCodEmpresa.Text)) and (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = clbTabPre) Then
    Begin
      If chkFilTab.Checked And fEmptyStr(fRetTabPreSelChkLis(clbTabPre)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Selecione pelo menos uma tabela de preço!!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodDep) Then
    Begin

      If (fEmptyStr(edtCodDep.Text)) Then
        edtDesDep.Text := 'TODOS'
      Else
        pDesmarcaLista(edtCodDep, arrDep);

    End

    Else If (Sender = edtCodDepProd) Then
    Begin

      If (fEmptyStr(edtCodDepProd.Text)) Then
        edtDesDepProd.Text := 'TODOS'
      Else
        pDesmarcaLista(edtCodDepProd, arrDepProd);

    End

    Else
    If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru,arrLinGru,'', 6);
    End

    Else If (Sender = edtCodCnd) Then
    Begin
      If Not fEmptyStr(edtCodCnd.Text) Then
        pDesmarcaLista(edtCodCnd, arrCnd, 'TMP_CONDICAO')
      Else
        edtDesCnd.Text := 'TODAS';
    End

    Else If (Sender = edtCodCnd) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
         edtDesCli.Text := 'TODOS'
      Else
         pDesmarcaLista(edtCodCli, arrCliente);
    End

    Else If (Sender = edtCliExc) Then
    Begin
      If fEmptyStr(edtCliExc.Text) Then
         edtDesExc.Text := 'TODOS'
      Else
         pDesmarcaLista(edtCliExc, arrCliExc);
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
         edtDesFor.Text := 'TODOS'
      Else
         pDesmarcaLista(edtCodFor, arrFor);
    End

    Else If (Sender = edtCodPro) Then
    Begin
        pDesmarcaLista(edtCodPro, arrPro);
    End

    Else If (Sender = edtCodMarca) Then
    Begin
        pDesmarcaLista(edtCodMarca, arrMar);
    End
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelFatComVendedor.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmRelFatComVendedor.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGrupo, Nil, Key , arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatComVendedor.btnDirPDFClick(Sender: TObject);
var
  strDirPDF : string;
begin
  inherited;
  if SelectDirectory('Selecione uma pasta', '', strDirPDF) then
    edtDirPDF.Text := strDirPDF;
end;

procedure TfrmRelFatComVendedor.btnImprimirClick(Sender: TObject);
  Var
    qckRel    : TfrxReport;
    strFormatStr : String;
begin
  If (chkPDFVen.Checked) Then
  Begin
    If (fEmptyStr(edtDirPDF.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'O caminho para salvar os PDFs deve ser informado!', ['&OK']);
      pSetFocus(edtDirPDF);
      Exit;
    End;
    If (Not DirectoryExists(edtDirPDF.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'Caminho para salvar os PDFs inválido!', ['&OK']);
      pSetFocus(edtDirPDF);
      Exit;
    End;
  End;

  Try

    Try
      intTotGeral := 0;

      pnlInfo.Caption := 'Gerando Relatório...';
      pnlInfo.Repaint;

      inherited;

      If blnImprime Then
      Begin
        frxResFai.DataSet := cdsFaixa;

        If (edtTipo.Text <> '2') Or
           ((Pos(edtOpcao.Text,'5_6_8_9_') > 0) Or (edtOpcao.Text = '12') Or (edtOpcao.Text = '13')) Then
          chkResAliq.Checked := False;

        If Assigned(cdsRelat) Then
        Begin
          cdsRelat.Close;
          FreeAndNil(cdsRelat);
        End;

        cdsRelat  := TUniClientDataSet.Create(Self);

        If ((Pos(edtOpcao.Text,'5_6_8_9_') > 0) Or (edtOpcao.Text = '12') Or (edtOpcao.Text = '13')) Then
        Begin
          blnOpcAgg := Not ((edtOpcao.Text = '12') And (edtTipo.Text = '4'));

          pCriaIndicesAgrupamento;
          pCriaAggregates;

          pAbreClient(cdsRelat, qryRelat, dspRelat, fSqlUnion);
          pAtualizaMargem;

          If (chkCadCom.Visible And chkCadCom.Checked) Then
            pAddFaixasNaoInclusas;

          With cdsRelat Do
          Begin
            IndexFieldNames  := '';
            IndexName        := 'IDX_001';
            AggregatesActive := False;
            AggregatesActive := True;
          End;

        End
        Else
        Begin
          blnOpcAgg := False;
          pResumo;
        End;


        If Not cdsRelat.IsEmpty Then
        Begin

          If (edtDestino.Text = 'E') Then
            pGeraExcel

          Else
          Begin

            pCarregaConfImpr(qryCfgRel, Self.Name);
            strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
            strTipImp :=  qryCfgRel.FieldByName('REL_IDEIMP').AsString;

            {**************************************}
            {* DEFINE SE O RELATORIO É MAT OU JAT *}
            {***********************************AF*}
            If (strTipImp = 'M') Then
              qckRel := frxPaginaM
            Else
            Begin
              qckRel := frxPaginaJ;
              qckRel.DotMatrixReport           := False;
              qckRel.PrintOptions.PrintMode    := pmScale;
              qckRel.PrintOptions.PrintOnSheet := 9; //A4
            End;

            qckRel.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

            TfrxMemoView(qckRel.FindObject('rllVrCustoTit')).Visible    := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllVrCusto')).Visible       := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllVrCustoTot')).Visible    := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllVrCustoDoc')).Visible    := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllVrCustoTotGer')).Visible := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllMargemTit')).Visible     := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllMargem')).Visible        := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllMargemDoc')).Visible     := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllMargemTot')).Visible     := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllMargemTotGer')).Visible  := (edtMargem.Text = 'S');
            TfrxBand(qckRel.FindObject('rlbCabecGroupAliq')).Visible    := chkResAliq.Checked;
            TfrxBand(qckRel.FindObject('rlbRodapGroupAliq')).Visible    := chkResAliq.Checked;
            TfrxLineView(qckRel.FindObject('rllLinha2')).Visible        := Not chkResAliq.Checked;
            TfrxSubreport(qckRel.FindObject('qckResumo')).Visible       := chkResAliq.Checked;

            TfrxMemoView(qckRel.FindObject('rllTitMargem')).Visible     := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllValMargem')).Visible     := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllTotMargem')).Visible     := (edtMargem.Text = 'S');

            TfrxMemoView(qckRel.FindObject('rllResultTit')).Visible    := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllResultDet')).Visible    := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllResultDoc')).Visible    := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllResultTot')).Visible    := (edtMargem.Text = 'S');
            TfrxMemoView(qckRel.FindObject('rllResultTotGer')).Visible := (edtMargem.Text = 'S');

            If (edtTipo.Text = '1') Or (edtTipo.Text = '3') Then
              strFormatStr := '%4.4n'
            Else
              strFormatStr := '%2.2n';

            TfrxMemoView(qckRel.FindObject('rllPerComissao')).DisplayFormat.FormatStr := strFormatStr;
            TfrxMemoView(qckRel.FindObject('rllPerComissaoDoc')).DisplayFormat.FormatStr := strFormatStr;
            TfrxMemoView(qckRel.FindObject('rllPerComissaoTot')).DisplayFormat.FormatStr := strFormatStr;
            TfrxMemoView(qckRel.FindObject('rllPerComissaoTotGer')).DisplayFormat.FormatStr := strFormatStr;

            If (edtTipo.Text = '1') Then
              qckRel.Script.Variables['NOMREL']   := 'RELATÓRIO DE COMISSÃO POR VENDEDOR - SINTÉTICO DOCUMENTO ';

            If (edtTipo.Text = '2') Then
              qckRel.Script.Variables['NOMREL1']  := 'RELATÓRIO DE COMISSÃO POR VENDEDOR - SINTÉTICO VENDEDOR ';

            If (edtTipo.Text = '3') Then
              qckRel.Script.Variables['NOMREL']   := 'RELATÓRIO DE COMISSÃO POR VENDEDOR - SINTÉTICO VENDEDOR+DATA ';

            If (edtTipo.Text = '4') Then
              qckRel.Script.Variables['NOMREL']   := 'RELATÓRIO DE COMISSÃO POR VENDEDOR - ANALÍTICO ';

            qckRel.Script.Variables['REFERENTE']  := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
            qckRel.Script.Variables['REFERENTE1'] := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

            If chkFilTab.Checked Then
              qckRel.Script.Variables['TABPRE']   := 'TABELAS DE PREÇO: ' + fRetTabPreSelChkLis(clbTabPre)
            Else
              qckRel.Script.Variables['TABPRE']   := 'TABELAS DE PREÇO: TODAS';

            qckRel.Script.Variables['GERENTE']    := fStrTitulo(edtCodGer, edtDesGer, arrGer, strGer, 'GERENTE');
            qckRel.Script.Variables['TITVEN']     := arrVenRep[cbxVendedor.ItemIndex];
            qckRel.Script.Variables['VENDEDOR']   := fStrTitulo(edtCodVendedor, edtDesVendedor, arrOperador, strOperador, String(arrVenRep[cbxVendedor.ItemIndex]));

            Case cmbTipVen.ItemIndex Of
              VEN_TODOS          : qckRel.Script.Variables['TIPVEN']:= 'TIPO DE VENDEDOR: TODOS';
              VEN_INTERNO        : qckRel.Script.Variables['TIPVEN']:= 'TIPO DE VENDEDOR: INTERNO';
              VEN_EXTERNO_LOJA   : qckRel.Script.Variables['TIPVEN']:= 'TIPO DE VENDEDOR: REPRESENTANTE EXTERNO LOJA';
              VEN_EXTERNO_DISTRIB: qckRel.Script.Variables['TIPVEN']:= 'TIPO DE VENDEDOR: REPRESENTANTE EXTERNO DISTRIBUIDOR';
            End;

            qckRel.Script.Variables['DEPTO']      := fStrTitulo(edtCodDep.Text, edtDesDep, arrDep, strDep, 'DEPARTAMENTO OPERADOR');
            qckRel.Script.Variables['DEPTOPROD']  := fStrTitulo(edtCodDepProd.Text, edtDesDepProd, arrDepProd, strDepProd, 'DEPARTAMENTO PRODUTO');
            qckRel.Script.Variables['LINGRU']     := fStrTitulo(mskLinGru.Text, edtDesGrupo, arrLinGru, strLinGru, 'LINHA/GRUPO');
            qckRel.Script.Variables['OPCAO']      := 'OPÇÃO DO RELATÓRIO: ' + arrVenRep[cbxVendedor.ItemIndex];
            qckRel.Script.Variables['EMPRESA']    := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA');
            qckRel.Script.Variables['EMPRESA1']   := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA');
            qckRel.Script.Variables['ATIVIDADE']  := fStrTitulo(edtCodAti.Text,edtAtividade,arrAtividade,strAtivid,'ATIVIDADE', True);
            qckRel.Script.Variables['CONDICAO']   := fStrTitulo(edtCodCnd.Text,edtDesCnd,arrCnd,strCnd,'CONDIÇÃO DE PAGAMENTO', True);
            qckRel.Script.Variables['CLIENTE']    := fStrTitulo(edtCodCli.Text,edtDesCli,arrCliente,strCodCli,'CLIENTE');
            qckRel.Script.Variables['CLIENTEEXC'] := IfThen(fEmptyStr(edtCliExc.Text), 'CLIENTE EXCLUIR: NENHUM', fStrTitulo(edtCliExc.Text,edtDesExc,arrCliExc,strCliExc,'CLIENTE EXCLUIR', True));
            qckRel.Script.Variables['FORNECEDOR'] := fStrTitulo(edtCodFor.Text, edtDesFor, arrFor, strFor, 'FORNECEDOR');
            qckRel.Script.Variables['PRODUTO']    := fStrTitulo(edtCodPro.Text, edtDesPro, arrPro, strPro, 'PRODUTO');
            qckRel.Script.Variables['MARCA']      := fStrTitulo(edtCodMarca.Text, edtDesMarca, arrMar, strMar, 'MARCA');
            qckRel.Script.Variables['PROMOC']     := 'ITENS EM PROMOÇÃO: ' + IfThen(rdgItePro.ItemIndex = 0, 'SIM', IfThen(rdgItePro.ItemIndex = 1, 'NÃO', 'TODOS'));
            qckRel.Script.Variables['TIPPRE']     := 'COMPOSIÇÃO DE CUSTO: ' + cbbComCus.Text;

            {***********************************************}
            {* OPCAO DE ANALITICO , ALINHA OS TITULOS E    *}
            {* DETERMINA A ALTURA DAS BANDAS               *}
            {********************************************DP*}
            TfrxMemoView(qckRel.FindObject('rllCodigoTit')).Top     := TfrxMemoView(qckRel.FindObject('rllDataTit')).Top;
            TfrxMemoView(qckRel.FindObject('rllDescricaoTit')).Top  := TfrxMemoView(qckRel.FindObject('rllDataTit')).Top;
            TfrxMemoView(qckRel.FindObject('rllUnidadeTit')).Top    := TfrxMemoView(qckRel.FindObject('rllDataTit')).Top;
            TfrxMemoView(qckRel.FindObject('rllVrUnitarioTit')).Top := TfrxMemoView(qckRel.FindObject('rllDataTit')).Top;

            TfrxMemoView(qckRel.FindObject('rllCodigo')).Top        := TfrxMemoView(qckRel.FindObject('rllData')).Top;
            TfrxMemoView(qckRel.FindObject('rllDescricao')).Top     := TfrxMemoView(qckRel.FindObject('rllData')).Top;
            TfrxMemoView(qckRel.FindObject('rllUnidade')).Top       := TfrxMemoView(qckRel.FindObject('rllData')).Top;
            TfrxMemoView(qckRel.FindObject('rllVrUnitario')).Top    := TfrxMemoView(qckRel.FindObject('rllData')).Top;

            TfrxMemoView(qckRel.FindObject('mmMsgCfgSin')).Visible := blnIgnorarNaBaseCalculoDescontoDadoEmConfirmacao;
            TfrxMemoView(qckRel.FindObject('mmMsgCfgAna')).Visible := blnIgnorarNaBaseCalculoDescontoDadoEmConfirmacao;

            If strTipImp = 'M' Then
            Begin
              TfrxHeader(qckRel.FindObject('rlbTitulo')).Height       := TfrxHeader(qckRel.FindObject('rllDescricaoTit')).Height * 3;
              TfrxMasterData(qckRel.FindObject('rlbDetalhes')).Height := TfrxMemoView(qckRel.FindObject('rllDescricao')).Height;
            End
            Else
            Begin
              TfrxHeader(qckRel.FindObject('rlbTitulo')).Height       := TfrxHeader(qckRel.FindObject('rllDescricaoTit')).Height + 12;
              TfrxMasterData(qckRel.FindObject('rlbDetalhes')).Height := TfrxMemoView(qckRel.FindObject('rllDescricao')).Height + 2;
            End;

            TfrxMemoView(qckRel.FindObject('rllDataTit')).Text       := IfThen(edtTipo.Text = '3', 'DATA', 'DTA DOC.');
            TfrxMemoView(qckRel.FindObject('rllNumDocTit')).Visible  := (edtTipo.Text <> '3');
            TfrxMemoView(qckRel.FindObject('rllEmpTit')).Visible     := (edtTipo.Text <> '3');
            TfrxMemoView(qckRel.FindObject('rllDocFatTit')).Visible  := (edtTipo.Text <> '3');
            TfrxMemoView(qckRel.FindObject('rllClienteTit')).Visible := (edtTipo.Text <> '3');
            TfrxMemoView(qckRel.FindObject('rllNumDoc')).Visible     := (edtTipo.Text <> '3');
            TfrxMemoView(qckRel.FindObject('rllEmp')).Visible        := (edtTipo.Text <> '3');
            TfrxMemoView(qckRel.FindObject('rllDocFat')).Visible     := (edtTipo.Text <> '3');
            TfrxMemoView(qckRel.FindObject('rllCliente')).Visible    := (edtTipo.Text <> '3');

            TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupVend')).Visible := Pos(edtOrdem.Text, '13') > 0;
            TfrxGroupFooter(qckRel.FindObject('rlbRodapGroupVend')).Visible := Pos(edtOrdem.Text, '13') > 0;

            If (TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupVend')).Visible) Then
              TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupVend')).StartNewPage := chkEjeVen.Checked;

            Case cbxVendedor.ItemIndex Of
              0:Begin
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupVend')).Condition := 'frxUserRelatorio."CODVEN"';
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupAliq')).Condition := 'frxUserRelatorio."CODVEN"';
                End;
              1:Begin
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupVend')).Condition := 'frxUserRelatorio."CODVE2"';
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupAliq')).Condition := 'frxUserRelatorio."CODVE2"';
                End;
              2:Begin
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupVend')).Condition := 'frxUserRelatorio."CODDIG"';
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupAliq')).Condition := 'frxUserRelatorio."CODDIG"';
                End;
              3:Begin
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupVend')).Condition := 'frxUserRelatorio."CODREP"';
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupAliq')).Condition := 'frxUserRelatorio."CODREP"';
                End;
              4,
              5:Begin
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupVend')).Condition := 'frxUserRelatorio."SUPERV"';
                  TfrxGroupHeader(qckRel.FindObject('rlbCabecGroupAliq')).Condition := 'frxUserRelatorio."SUPERV"';
                End;
            End;

            TfrxMemoView(qckRel.FindObject('rllCliente')).Text    := '[frxUserRelatorio."NOMCLI"]';
            TfrxMemoView(qckRel.FindObject('rllClienteTit')).Text := 'CLIENTE';

            TfrxMemoView(qckRel.FindObject('rllQtdIte')).Visible    := False;
            TfrxMemoView(qckRel.FindObject('rllQtdIteTit')).Visible := False;
            TfrxMemoView(qckRel.FindObject('rllQtdIteGer')).Visible := False;
            TfrxMemoView(qckRel.FindObject('rllQtdIteGru')).Visible := False;

            If SameText(edtOpcAgru.Text, 'L') Then
            Begin
              TfrxMemoView(qckRel.FindObject('rllCliente')).Left    := TfrxMemoView(qckRel.FindObject('rllDataTit')).Left;
              TfrxMemoView(qckRel.FindObject('rllClienteTit')).Left := TfrxMemoView(qckRel.FindObject('rllDataTit')).Left;

              TfrxMemoView(qckRel.FindObject('rllCliente')).Text    := '[frxUserRelatorio."DESGRU"]';
              TfrxMemoView(qckRel.FindObject('rllClienteTit')).Text := 'LINHA / GRUPO';

              TfrxMemoView(qckRel.FindObject('rllQtdIte')).Visible    := True;
              TfrxMemoView(qckRel.FindObject('rllQtdIteTit')).Visible := True;
              TfrxMemoView(qckRel.FindObject('rllQtdIteGru')).Visible := True;
              TfrxMemoView(qckRel.FindObject('rllQtdIteGer')).Visible := True;

              TfrxMemoView(qckRel.FindObject('rllDataTit')).Visible   := False;
              TfrxMemoView(qckRel.FindObject('rllNumDocTit')).Visible := False;
              TfrxMemoView(qckRel.FindObject('rllEmpTit')).Visible    := False;
              TfrxMemoView(qckRel.FindObject('rllDocFatTit')).Visible := False;
              TfrxMemoView(qckRel.FindObject('rllData')).Visible   := False;
              TfrxMemoView(qckRel.FindObject('rllNumDoc')).Visible := False;
              TfrxMemoView(qckRel.FindObject('rllEmp')).Visible    := False;
              TfrxMemoView(qckRel.FindObject('rllDocFat')).Visible := False;
            End
            Else
            If SameText(edtOpcAgru.Text, 'C') Then
            Begin
              TfrxMemoView(qckRel.FindObject('rllCliente')).Left    := TfrxMemoView(qckRel.FindObject('rllDataTit')).Left;
              TfrxMemoView(qckRel.FindObject('rllClienteTit')).Left := TfrxMemoView(qckRel.FindObject('rllDataTit')).Left;

              TfrxMemoView(qckRel.FindObject('rllDataTit')).Visible   := False;
              TfrxMemoView(qckRel.FindObject('rllNumDocTit')).Visible := False;
              TfrxMemoView(qckRel.FindObject('rllEmpTit')).Visible    := False;
              TfrxMemoView(qckRel.FindObject('rllDocFatTit')).Visible := False;
              TfrxMemoView(qckRel.FindObject('rllData')).Visible   := False;
              TfrxMemoView(qckRel.FindObject('rllNumDoc')).Visible := False;
              TfrxMemoView(qckRel.FindObject('rllEmp')).Visible    := False;
              TfrxMemoView(qckRel.FindObject('rllDocFat')).Visible := False;
            End
            Else
            Begin
              {********************************}
              {* OPCAO DE RELATORIO ANALITICO *}
              {*****************************DP*}
              If edtTipo.Text <> '4' Then
              Begin
                TfrxMemoView(qckRel.FindObject('rllCliente')).Left    := TfrxMemoView(qckRel.FindObject('rllDocFat')).Left + TfrxMemoView(qckRel.FindObject('rllDocFat')).Width + 5;
                TfrxMemoView(qckRel.FindObject('rllClienteTit')).Left := TfrxMemoView(qckRel.FindObject('rllCliente')).Left;
              End;

              TfrxMemoView(qckRel.FindObject('rllDataTit')).Visible    := True;
              TfrxMemoView(qckRel.FindObject('rllData')).Visible       := True;
              TfrxMemoView(qckRel.FindObject('rllNumDocTit')).Visible  := (edtTipo.Text <> '3');
              TfrxMemoView(qckRel.FindObject('rllEmpTit')).Visible     := (edtTipo.Text <> '3');
              TfrxMemoView(qckRel.FindObject('rllDocFatTit')).Visible  := (edtTipo.Text <> '3');
              TfrxMemoView(qckRel.FindObject('rllClienteTit')).Visible := (edtTipo.Text <> '3');
              TfrxMemoView(qckRel.FindObject('rllNumDoc')).Visible     := (edtTipo.Text <> '3');
              TfrxMemoView(qckRel.FindObject('rllEmp')).Visible        := (edtTipo.Text <> '3');
              TfrxMemoView(qckRel.FindObject('rllDocFat')).Visible     := (edtTipo.Text <> '3');
            End;

            qckRel.Pages[1].Visible := Not (edtTipo.Text = '2');
            qckRel.Pages[2].Visible := (edtTipo.Text = '2');

            If (edtTipo.Text = '2') And (chkPedPen.Checked) Then
            Begin
              TfrxMemoView(qckRel.FindObject('rllPedPen')).Visible := True;
              TfrxMemoView(qckRel.FindObject('rllPedPenTit1')).Visible := True;
              TfrxMemoView(qckRel.FindObject('rllPedPenTit2')).Visible := True;
              TfrxMemoView(qckRel.FindObject('rllPedPen')).Memo.Clear;
              TfrxMemoView(qckRel.FindObject('rllPedPen')).Memo.Add('[frxUserRelatorio."TOTCOM"]');
            End
            Else
            Begin
              TfrxMemoView(qckRel.FindObject('rllPedPen')).Visible := False;
              TfrxMemoView(qckRel.FindObject('rllPedPenTit1')).Visible := False;
              TfrxMemoView(qckRel.FindObject('rllPedPenTit2')).Visible := False;
              TfrxMemoView(qckRel.FindObject('rllPedPen')).Memo.Clear;
            End;

            pFormataRelatorioOpcao4Analitico(qckRel);

            If (strTipImp = 'M') Then
              pRemoveAcentoVarRel(qckRel,['NOMREL',
                                          'NOMREL1',
                                          'REFERENTE',
                                          'REFERENTE1',
                                          'TABPRE',
                                          'GERENTE',
                                          'TITVEN',
                                          'VENDEDOR',
                                          'TIPVEN',
                                          'DEPTO',
                                          'DEPTOPROD',
                                          'LINGRU',
                                          'OPCAO',
                                          'EMPRESA',
                                          'EMPRESA1',
                                          'ATIVIDADE',
                                          'CONDICAO',
                                          'CLIENTE',
                                          'CLIENTEEXC',
                                          'FORNECEDOR',
                                          'PRODUTO',
                                          'PROMOC',
                                          'TIPPRE']);

            If (Not chkPDFVen.Checked) Then
            Begin
              If (edtDestino.Text = 'V') Then
                pPreviewReport(Self.Name, Self.Caption, qckRel)
              Else If qckRel.PrepareReport Then
                pPrintReport(Self.Name, Self.Caption, strNomImp, qckRel);
            End
            Else
            Begin
              pExportarPDFParaCadaVendedor(qckRel);
            End;
          End;

          If chkCadCom.Visible And chkCadCom.Checked Then
          Begin
            cdsFaixa.EmptyDataSet;
            stlVendedor.Clear;
          End;

        End
        Else
          pTabelaVazia;

      End;

    Except
      On E: Exception do
        pMensagensErro(E.Message, 'btnImprimirClick');
    end;

  Finally
    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';
  End;
end;

procedure TfrmRelFatComVendedor.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFatComVendedor.FormCreate(Sender: TObject);
begin
  inherited;

  strTeste := '';

  {Se resolução disponível for inferior ou igual à (1366 x 768), posiciona a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  pSetaCodIte(edtCodPro);
  cdsQtdVen.CreateDataSet;
  cdsQtdVen.Open;

  blnIgnorarNaBaseCalculoDescontoDadoEmConfirmacao := (fCfgSis('DSCFFF', varString) = 'N');
  fltTaxRep := fCfgSis('TAXREP', varDouble);
  strMarMkp := fCfgSis('MARMKP');

  If Pos(strMarMkp, '1_5_') > 0 Then
    strMarMkp12 := '1'
  Else
    strMarMkp12 := '2';

  blnFreCom := fCfgSis('FRECOM', varBoolean);

  pCarregaComposicaoCusto(cbbComCus);

  pCarregaChkLisTabPre(clbTabPre);

  qryDadSin  := fCriaQuery(nil);
  cdsDadSin  := TUniClientDataSet.Create(nil);
  dspDadSin  := TUniDataSetProvider.Create(nil);

  cdsDadSin.SetProvider(dspDadSin);
  dspDadSin.DataSet := qryDadSin;

  qryRelat  := fCriaQuery(nil);
  cdsRelat  := TUniClientDataSet.Create(nil);
  dspRelat  := TUniDataSetProvider.Create(nil);

  cdsRelat.SetProvider(dspRelat);
  dspRelat.DataSet := qryRelat;

  pAtualizaClaFis;
  strCodVen := '';

  frxPaginaM.AddFunction('function fCriaResAliquota(strCodVen: Boolean): Boolean');
  frxPaginaM.AddFunction('function fRetPedidosPendentes: String');

  frxPaginaJ.AddFunction('function fCriaResAliquota(strCodVen: Boolean): Boolean');
  frxPaginaJ.AddFunction('function fRetPedidosPendentes: String');

  qryResAlq.Connection := frmModulo.GetCurrentConnection;

  pCriaClientFaixas;
  stlVendedor := TStringList.Create;
end;

procedure TfrmRelFatComVendedor.FormDestroy(Sender: TObject);
begin
  If Assigned(qryDadSin) Then FreeAndNil(qryDadSin);
  If Assigned(cdsDadSin) Then FreeAndNil(cdsDadSin);
  If Assigned(dspDadSin) Then FreeAndNil(dspDadSin);

  If Assigned(qryRelat) Then FreeAndNil(qryRelat);
  If Assigned(cdsRelat) Then FreeAndNil(cdsRelat);
  If Assigned(dspRelat) Then FreeAndNil(dspRelat);

  If Assigned(cdsFaixa) Then FreeAndNil(cdsFaixa);

  stlVendedor.Destroy;

  inherited;
end;

procedure TfrmRelFatComVendedor.FormShow(Sender: TObject);
begin
  blnLibGer := fVerificaAcessoSistema('RCPMSG', strLoginUsuarioLogado);
  blnlibSub := fVerificaAcessoSistema('RCPMSS', strLoginUsuarioLogado);
  blnLibVen := fVerificaAcessoSistema('RFACOVD', strLoginUsuarioLogado);

  pVerdeVermelho(edtCodGer, shpGer, blnLibGer);
  pVerdeVermelho(edtCodSubGer, shpSubGer, blnlibSub);
  pVerdeVermelho(edtCodVendedor, shpLiberado, blnLibVen);

  blnLibOpc := fVerificaAcessoSistema('RFACOVO');
  blnLibTip := fVerificaAcessoSistema('RFACOVT');

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  cbxVendedor.Items.Clear;
  cbxVendedor.Items.Add('1- Vendedor 1');
  cbxVendedor.Items.Add('2- Vendedor 2');
  cbxVendedor.Items.Add('3- Digitador');
  cbxVendedor.Items.Add('4- Representante');

  If (Not blnLibVen) Then
  Begin
    edtCodVendedor.MaxLength := 10;
    edtCodVendedor.TamCampo  := 0;
    edtCodVendedor.CompZeros := False;
    edtCodVendedor.PasswordChar := '*';
    edtCodVendedor.TipoTexto := ttAlfanumerico;
    shpLiberado.Brush.Color  := clRed;
  End
  Else
  Begin
    shpLiberado.Brush.Color  := clGreen;

    cbxVendedor.Items.Add('5- Superv. Geral');
    cbxVendedor.Items.Add('6- Superv. Regional');
  End;

  If (Not blnLibOpc) Then
  Begin
    shpOpcaoRel.Brush.Color := clRed;
    edtOpcao.Text := fCfgSis('OSRCVF', varString);

    If (fEmptyStr(edtOpcao.Text)) Or (StrToInt(edtOpcao.Text) < 1) Or (StrToInt(edtOpcao.Text) > 13) Then
      edtOpcao.Text := '1';

    edtOpcaoExit(Nil);
    edtOpcao.ReadOnly := True;
  End
  Else
  Begin
    shpOpcaoRel.Brush.Color  := clGreen;
  End;

  If (Not blnLibTip) Then
  Begin
    shpTipoRel.Brush.Color := clRed;
    edtTipo.Text := fCfgSis('TSRCVF', varString);

    If (fEmptyStr(edtTipo.Text)) Or (StrToInt(edtTipo.Text) < 1) Or (StrToInt(edtTipo.Text) > 4) Then
      edtTipo.Text := '1';

    edtTipoExit(Nil);
    edtTipo.ReadOnly := True;
  End
  Else
  Begin
    shpTipoRel.Brush.Color := clGreen;
  End;

  cbxVendedor.ItemIndex := 0;

  shpMargem.Brush.Color := clGreen;
  If Not fVerificaAcessoSistema('MARREL') Then
  Begin
    shpMargem.Brush.Color := clRed;
    edtMargem.TabStop := False;
    edtMargem.ReadOnly := True;
    edtMargem.Text := 'N';
  End;

  inherited;

  shpMultSel.Visible := True;

  pHabilitaOpcoesPDF;
end;

procedure TfrmRelFatComVendedor.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin
  //'5102_5403_5405_5655_5656_6102_6108_6404_6405_6655_6656_'

  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;

End;

procedure TfrmRelFatComVendedor.edtTipoExit(Sender: TObject);
begin
  inherited;

  If SameText(edtTipo.Text,'2') Then
    edtOrdem.Text := '1';

  If SameText(edtTipo.Text, '1') Then
  Begin
    edtOpcAgru.Enabled := True;
  End
  Else
  Begin
    edtOpcAgru.Text    := 'D';
    edtOpcAgru.Enabled := False;
  End;

  pHabilitaOpcoesPDF;
end;

procedure TfrmRelFatComVendedor.edtTipoChange(Sender: TObject);
begin
  inherited;

  chkPedPen.Enabled  := False;
  chkPedPen.Checked  := False;

  If (edtTipo.Text = '1') Or (edtTipo.Text = '3') Or (edtTipo.Text = '4') Or
     ((Pos(edtOpcao.Text,'5_6_8_9_') > 0) Or (edtOpcao.Text = '12') Or (edtOpcao.Text = '13')) Then
    chkResAliq.Enabled := False
  Else If (edtTipo.Text = '2') And (edtOpcao.Text <> '8') And (edtOpcao.Text <> '13') Then
  Begin
    chkResAliq.Enabled := True;
    chkResAliq.Checked := True;
    chkPedPen.Enabled  := True;
  End;

  grbFilTab.Enabled := (edtTipo.Text = '1') Or (edtTipo.Text = '4') ;
  If Not grbFilTab.Enabled Then
    chkFilTab.Checked := False;

  pHabilitaOpcoesPDF;
end;

procedure TfrmRelFatComVendedor.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;
  If VarName = 'VS_STRMARMKP' Then
    Value := strMarMkp12;

  If VarName = 'MARGEM' Then
    Value := edtMargem.Text;

  If VarName = 'OP_COMISSAO' Then
    Value := edtOpcao.Text;

  If VarName = 'VENDEDOR' Then
    Value := cbxVendedor.ItemIndex;
end;

function TfrmRelFatComVendedor.fCalculaPrecoCustoItem(fltUniOri, fltQtdIte: Double; strCodIte, strCodEmp,
  strNumDoc, strEspDoc, strCodCli: String): Double;
  Var
    qryItem: TUniQuery;
    fltDifal, fltFcp: Double;

  procedure pGetValorICD(strAutoInc: String);
  Var
    qryAux: TUniQuery;
  Begin
    qryAux := fCriaQuery(nil);

    Try
      With qryAux Do
      Begin
        SQL.Clear;
        SQL.Add('SELECT IFNULL(ICD_PERFCP,0) AS VLR_FCP, (IFNULL(ICD_ALQUFD,0) - IFNULL(ICD_ALQINE,0)) AS VLR_DIFAL FROM MOVICD ');
        SQL.Add('WHERE ICD_SEQGER = :AUTOINC');
        ParamByName('AUTOINC').AsString := strAutoInc;

        Open;

        If not isEmpty Then
        Begin
          fltFcp   := FieldByName('VLR_FCP').AsFloat;
          fltDifal := FieldByName('VLR_DIFAL').AsFloat;
        End;
      End;
    Finally
      FreeAndNil(qryAux);
    End;
  End;

begin
  Result   := 0;
  fltFcp   := 0;
  fltDifal := 0;

  qryItem  := fCriaQuery(nil);

  Try
    qryItem.Close();
    qryItem.SQL.Clear();
    qryItem.SQL.Add('SELECT MOVDET.AUTOINCREM, DET_ALQICM, ITE_PRECUS, ITE_OUTVAL, ITE_IMPFED, ITE_DESOPE');
    qryItem.SQL.Add('FROM MOVDET INNER JOIN ITEGER ON DET_CODITE = ITE_CODITE');
    qryItem.SQL.Add('WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    qryItem.SQL.Add('AND DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_CODCLI = :CODCLI');
    qryItem.ParamByName('CODITE').AsString := strCodIte;
    qryItem.ParamByName('CODEMP').AsString := strCodEmp;
    qryItem.ParamByName('NUMDOC').AsString := Copy(strNumDoc, 1, Length(strNumDoc) - 3);
    qryItem.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItem.ParamByName('CODCLI').AsString := strCodCli;
    qryItem.Open();

    If (Not qryItem.IsEmpty) Then
    Begin
      pGetValorICD(qryItem.FieldByName('AUTOINCREM').AsString);

      Result := fCalculaPrecoCustoRealVenda(
                         fltUniOri,
                         qryItem.FieldByName('ITE_PRECUS').AsFloat,
                         qryItem.FieldByName('ITE_OUTVAL').AsFloat,
                         qryItem.FieldByName('DET_ALQICM').AsFloat,
                         qryItem.FieldByName('ITE_IMPFED').AsFloat,
                         qryItem.FieldByName('ITE_DESOPE').AsFloat,
                         fltDifal,
                         fltFcp) * fltQtdIte;
    End;
  Finally
    FreeAndNil(qryItem);
  End;
end;

Function TfrmRelFatComVendedor.fCamCom(blnTotComOU:Boolean = False): String;
Begin
  Case StrToInt(edtOpcao.Text) Of
    1 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'TOTCO2', 'TOTCOM');

    2,
    11:  Result := IfThen(cbxVendedor.ItemIndex = 1, 'OPECO2', 'OPECOM');

    3 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'ITECO2', 'ITECOM');
    4 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'FORCO2', 'FORCOM');
    5 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'MARCO2', 'MARCOM');

    6 ,
    9 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'DESCO2', 'DESCOM');

    7 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'TBPCO2', 'TBPCOM');

    8 ,
   13 :  Result := 'LUCCOM';

   10 :  Result := 'CNDCOM';
   12 :  Result := IfThen(blnTotComOU, 'TOTCOMOU','TOTCOM');
  End;
End;

Function TfrmRelFatComVendedor.fCamComNF: String;
Begin
  Case StrToInt(edtOpcao.Text) Of
    1 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'TOTCO2', 'TOTCOM');

    2 ,
    11: Result := IfThen(cbxVendedor.ItemIndex = 1, 'OPECO2', 'OPECOM');

    3 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'ITECO2', 'ITECOM');
    4 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'FORCO2', 'FORCOM');
    5 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'MARCO2', 'MARCOM');

    6 ,
    9 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'DESCO2', 'DESCOM');

    7 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'TBPCO2', 'TBPCOM');

    8 ,
   13 :  Result := 'LUCCOMNF';

   10 :  Result := 'CNDCOM';
   12 :  Result := 'TOTCOMNF';
  End;
End;

Function TfrmRelFatComVendedor.fCamComTR: String;
Begin
  Case StrToInt(edtOpcao.Text) Of
    1 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'TOTCO2', 'TOTCOM');

    2 ,
    11: Result := IfThen(cbxVendedor.ItemIndex = 1, 'OPECO2', 'OPECOM');

    3 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'ITECO2', 'ITECOM');
    4 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'FORCO2', 'FORCOM');
    5 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'MARCO2', 'MARCOM');

    6 ,
    9 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'DESCO2', 'DESCOM');

    7 :  Result := IfThen(cbxVendedor.ItemIndex = 1, 'TBPCO2', 'TBPCOM');

    8 ,
   13 :  Result := 'LUCCOMTR';

   10 :  Result := 'CNDCOM';
   12 :  Result := 'TOTCOMTR';
  End;
End;

function TfrmRelFatComVendedor.frxPaginaMUserFunction(const MethodName: String; var Params: Variant): Variant;
begin
  inherited;

  If MethodName = 'FCRIARESALIQUOTA' Then
    Result := fCriaResAliquota(Params[0])

  Else If MethodName = 'FRETPEDIDOSPENDENTES' Then
    Result := fRetPedidosPendentes(cdsRelat.FieldByName('CODVEN').AsString);

end;

procedure TfrmRelFatComVendedor.frxUserRelatorioCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  inherited;
  Eof := cdsRelat.Eof;
end;

procedure TfrmRelFatComVendedor.frxUserRelatorioFirst(Sender: TObject);
begin
  inherited;
  cdsRelat.First;
end;

procedure TfrmRelFatComVendedor.pUserRelatorioGetValue(const VarName: string;
  var Value: Variant);
begin

  With cdsRelat Do
  If blnOpcAgg Then
  Begin
    If SameText('TOTITE', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_TOTITE')

    Else If SameText('TOTCUS', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_TOTCUS')

    Else If SameText('RESULT', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_RESULT')

    Else If SameText('PERCOM', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_PERCOM')

    Else If SameText('TOTCOM', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_TOTCOM')

    Else If SameText('MARGEM', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_MARGEM')

    Else If SameText('TOTITENF', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_TOTITENF')

    Else If SameText('TOTCOMNF', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_TOTCOMNF')

    Else If SameText('TOTITETR', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_TOTITETR')

    Else If SameText('TOTCOMTR', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_TOTCOMTR')

    Else If SameText('TOTITEOU', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_TOTITEOU')

    Else If SameText('TOTCOMOU', VarName) Then
      Value := fDoubleAggregate(cdsRelat, 'AGG_TOTCOMOU')

    Else If SameText('QTDDOC', VarName) Then
      Value := fRetQtdDoc(FieldByName(Trim(fCodVen('1'))).AsString)

    Else Value := FieldByName(VarName).Value;

  End

  Else Value := FieldByName(VarName).Value;
end;


procedure TfrmRelFatComVendedor.pVerdeVermelho(edt:TEditFocus; shp:TShape; bln: Boolean);
begin
  Shp.Brush.Color := clGreen;
  If (Not bln) Then
  Begin
    Edt.MaxLength := 10;
    Edt.TamCampo  := 10;
    Edt.CompZeros := False;
    Edt.PasswordChar := '*';
    Edt.TipoTexto := ttAlfanumerico;

    Shp.Brush.Color  := clRed;
  End;
end;

procedure TfrmRelFatComVendedor.frxUserRelatorioGetValue(const VarName: string;
  var Value: Variant);
begin
  inherited;
  pUserRelatorioGetValue(VarName, Value);
end;

procedure TfrmRelFatComVendedor.frxUserRelatorioNewGetValue(Sender: TObject;
  const VarName: string; var Value: Variant);
begin
  inherited;
  pUserRelatorioGetValue(VarName, Value);
end;

procedure TfrmRelFatComVendedor.frxUserRelatorioNext(Sender: TObject);
begin
  inherited;
  With cdsRelat Do
  Begin
    Next;

    If blnOpcAgg Then
    While (Not eof) And (Not (gbFirst In GetGroupState(intGruLev))) Do
      Next;
  End;
end;

procedure TfrmRelFatComVendedor.frxUserRelatorioPrior(Sender: TObject);
begin
  inherited;
  With cdsRelat Do
  Begin
    Prior;

    If blnOpcAgg Then
    While (Not eof) And (Not (gbLast In GetGroupState(intGruLev))) Do
      Prior;
  End;
end;

procedure TfrmRelFatComVendedor.chkFilTabClick(Sender: TObject);
begin
  inherited;

  clbTabPre.Enabled := chkFilTab.Checked;
end;

procedure TfrmRelFatComVendedor.chkPDFVenClick(Sender: TObject);
begin
  inherited;
  pHabilitaOpcoesPDF;
end;

procedure TfrmRelFatComVendedor.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro, edtDesPro, arrPro, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmRelFatComVendedor.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodPro, edtDesPro, nil, Key, arrPro, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fValidaCampos(edtCodPro, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComVendedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If (ActiveControl Is TCheckListBox) Or
                  (ActiveControl Is TRadioButton) Then
                 Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatComVendedor.cbxVendedorChange(Sender: TObject);
begin
  inherited;
  lblVenDig.Caption := String(arrVenMin[cbxVendedor.ItemIndex]);
  lblOrdem1.Caption := '(1)' + String(arrVenMin[cbxVendedor.ItemIndex]) + ' "Código"';
  lblOrdem1.Repaint;

  lblOrdem3.Caption := '(3)' + String(arrVenMin[cbxVendedor.ItemIndex]) + ' "Nome"';
  lblOrdem3.Repaint;

  If cbxVendedor.ItemIndex in [4, 5] Then
  Begin
    edtOpcao.Text := '2';
    edtOpcao.Enabled := False;
  End
  Else
  Begin
    edtOpcao.Enabled := True;
  End;
end;

procedure TfrmRelFatComVendedor.pMontaSqlPerComItem(Var strSql: String);
begin
  {*************************************************************}
  {* CASO NAO TENHA O PERCENTUAL DE COMISSAO ACRESCIDO NO      *}
  {* CALCULO DO PRECO DE VENDA, UTILIZA PERCENTUAL DE COMISSAO *}
  {* DO VENDEDOR INTERNO E EXTERNO, DO CONTRARIO UTILIZA O     *}
  {* PERCENTUAL DA TABELA DE PRECO DO ITEM (ITE_COMTB?)        *}
  {**********************************************************JC*}
  If fCfgSis('PCMPRO') <> '2' Then
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'PERCENTUAL',
                                     IIF((Not fComDig),
                                                  ' IF(OPE_INTEXT = "I", IFNULL(ITE_COMVAR, 0), IF(OPE_INTEXT = "E", IFNULL(ITE_COMATA, 0), IFNULL(ITE_COMDIS, 0))) ',
                                                  ' IFNULL(ITE_COMDIG, 0) '))
  End
  Else
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'PERCENTUAL',
                                     '  CASE '                                  +
                                     '    WHEN DET_TABPRE = 1 THEN ITE_COMTB1 ' +
                                     '    WHEN DET_TABPRE = 2 THEN ITE_COMTB2 ' +
                                     '    WHEN DET_TABPRE = 3 THEN ITE_COMTB3 ' +
                                     '    WHEN DET_TABPRE = 4 THEN ITE_COMTB4 ' +
                                     '    WHEN DET_TABPRE = 5 THEN ITE_COMTB5 ' +
                                     '    WHEN DET_TABPRE = 6 THEN ITE_COMTB6 ' +
                                     '    WHEN DET_TABPRE = 7 THEN ITE_COMTB7 ' +
                                     '    ELSE ITE_COMTB1 '                     +
                                     '  END '                                  );
  End;
end;

procedure TfrmRelFatComVendedor.pnlDadosClick(Sender: TObject);
begin
  inherited;

end;

{*****************************************}
{* VERIFICA PEDIDOS PENDENTES.           *}
{**************************************MV*}
function TfrmRelFatComVendedor.fRetPedidosPendentes(strCodVen: String): String;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin
  Result := '0,00';
  If (edtTipo.Text = '2') And (chkPedPen.Checked) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM((FDO_QTDITE - FDO_QTDBAI) * ((FDO_TOTITE + FDO_VALIPI + FDO_VALRET + FDO_TOTFRE' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ' - FDO_DESESP) / FDO_QTDITE)) AS TOTPED ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' FATDOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FDO_JAFATU = 0 AND (ROUND(FDO_QTDBAI, 2) < ROUND(FDO_QTDITE, 2)) AND ';
    strSQL := strSQL + '  FDO_ESPDOC = "PD" AND ';
    strSQL := strSQL + '  FDO_CODVEN = ' + QuotedStr(strCodVen);
    strSQL := strSQL + fStrLocateEmpresa(edtCodEmpresa, arrEmp, 'FDO_CODEMP', 'CODEMP');

    qryAux := fCriaQuery(Self);

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      pSetaParam(edtCodEmpresa.Text, arrEmp, strEmp, 'CODEMP', qryAux);
      Open;
    End;
    Result := FloatToStrF(qryAux.FieldByName('TOTPED').AsFloat, ffNumber, 12, 2);

    qryAux.Close;
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmRelFatComVendedor.edtCodDepExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDep,edtDesDep,arrDep,fRetDescDepartamento,Nil,'do departamento');

end;

procedure TfrmRelFatComVendedor.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************RV*}
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatComVendedor.edtCodDepProdExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDepProd,edtDesDepProd,arrDepProd,fRetDescDepartamento,Nil,'do departamento');
end;

procedure TfrmRelFatComVendedor.edtCodDepProdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************RV*}
  If fPesqDepartamento(Self, edtCodDepProd, edtDesDepProd, Nil, Key, arrDepProd, False) Then
  Begin
    If fValidaCampos(edtCodDepProd, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComVendedor.edtOpcaoExit(Sender: TObject);
begin
  inherited;
  If SameText(edtOpcao.Text, '8') Or SameText(edtOpcao.Text, '13') Then
  Begin
    chkResAliq.Checked := False;
    chkResAliq.Enabled := False;
  End
  Else
  Begin
    chkResAliq.Checked := True;
    chkResAliq.Enabled := True;
  End;

  If SameText(edtOpcao.Text, '5') Then
    chkCadCom.Enabled := True
  Else
  Begin
    chkCadCom.Checked := False;
    chkCadCom.Enabled := False;
  End;  
end;

procedure TfrmRelFatComVendedor.edtCliExcExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCliExc.Text) Then
     edtDesExc.Text := 'NENHUM'
  Else
     pEdtCodSelectExit(edtCliExc, edtDesExc, arrCliExc, Nil, fRetNomCliente, 'do cliente a excluir');
end;

procedure TfrmRelFatComVendedor.edtCliExcKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCliExc, edtDesExc, Nil, Key, arrCliExc, False) Then
  Begin
    If fValidaCampos(edtCliExc, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComVendedor.edtCodAtiExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodAti, edtAtividade, arrAtividade, nil, fRetNomAtividade, 'da Atividade');

end;

procedure TfrmRelFatComVendedor.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtAtividade, Nil, Key, arrAtividade, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;

end;

procedure TfrmRelFatComVendedor.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCliente, Nil, fRetNomCliente, 'do cliente');
end;

procedure TfrmRelFatComVendedor.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatComVendedor.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd, edtDesCnd, arrCnd, fRetConPag, nil, 'da condição de pagamento');
end;

procedure TfrmRelFatComVendedor.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, arrCnd, False) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

Function TfrmRelFatComVendedor.fSQLFiltros(blnServico: Boolean): String;
  Var
    strFiltros: String;

    Function fSQLItensServico(blnIncluiIteSer: Boolean): String;
    Begin
      Result := '';
      If Not fEmptyStr(fCfgSis('ITESER', varString)) Then
        Result := Result + '"' + fCfgSis('ITESER', varString) + '"';

      If Not fEmptyStr(fCfgSis('SERTER', varString)) Then
        Result := Result + IfThen(Not fEmptyStr(Result),',','') + '"' + fCfgSis('SERTER', varString) + '"';

      If Not fEmptyStr(Result) Then
      Begin
        If blnIncluiIteSer Then
          Result := ' AND DET_CODITE IN ('+Result+') '
        Else
          Result := ' AND DET_CODITE NOT IN ('+Result+') '
      End;
    End;

Begin
  {**************************************}
  {* FILTROS OBRIGATÓRIOS               *}
  {***********************************AF*}
  strFiltros := '';

  strFiltros := strFiltros + 'IFNULL(OPE_CODOPE,"") <> "" AND ';

  If chkFilTab.Checked Then
    strFiltros := strFiltros + ' DET_TABPRE IN (' + fRetTabPreSelChkLis(clbTabPre) + ') AND ';

  strFiltros := strFiltros + fRetClientesFilialLocal ;

  strFiltros := strFiltros + ' DET_PROEMB <> "S"  AND ';
  strFiltros := strFiltros + ' DET_TIP_FC = "C"   AND ';

  strFiltros := strFiltros + cnsFiltroFFDVTR;

  strFiltros := strFiltros + ' (DET_DTAENT BETWEEN :DTAINI AND :DTAFIN) AND ';
  strFiltros := strFiltros + ' ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)) ';

  strFiltros := strFiltros + fSQLItensServico(blnServico);

  strFiltros := strFiltros + fStrLocate(edtCodDep,arrDep,'OPE_CODDEP', 'CODDEP');
  strFiltros := strFiltros + fStrLocate(edtCodDepProd,arrDepProd,'ITE_CODDEP', 'CODDEPPROD');
  strFiltros := strFiltros + fStrLocateLinGru(mskLinGru,arrLinGru,'CI.ITE_CODGRU', 'CODGRU');
  strFiltros := strFiltros + IfThen(edtEmpFat.Text = 'F', fStrLocateEmpresa(edtCodEmpresa,  arrEmp,  'DET_CODEMP', 'CODEMP'), fStrLocateEmpresa(edtCodEmpresa,  arrEmp, 'DET_EMPORI', 'CODEMP'));
  strFiltros := strFiltros + fStrLocate(edtCodAti,arrAtividade,'CLI_CODATI','CODATI');
  strFiltros := strFiltros + fStrLocate(edtCodCnd,arrCnd,'DET_CODCND','CODCND');
  strFiltros := strFiltros + fStrLocate(edtCodCli,arrCliente,'CLI_CODCLI','CODCLI');
  strFiltros := strFiltros + fStrLocate(edtCliExc,arrCliExc,'CLI_CODCLI','CLIEXC',False,True);
  strFiltros := strFiltros + fStrLocate(edtCodFor,arrFor,'DET_FORITE','CODFOR');
  strFiltros := strFiltros + fStrLocate(edtCodPro, arrPro, 'DET_CODITE', 'CODITE');
  strFiltros := strFiltros + fStrLocate(edtCodMarca, arrMar, 'CI.ITE_CODMAR', 'CODMAR');

  If (Not fEmptyStr(edtCodGer.Text)) Then
  Begin
    If (blnLibGer) Then
      strFiltros := strFiltros + fStrLocate(edtCodGer, arrGer, 'OPE_CODGER', 'CODGER')
    Else
      strFiltros := strFiltros + ' AND OPE_CODGER = :CODGER ';
  End;

  If (Not fEmptyStr(edtCodSubGer.Text)) Then
  begin
    If (blnLibSub) Then
      strFiltros := strFiltros + fStrLocate(edtCodSubGer, arrSubGer, 'OPE_CODSUB', 'CODSUB')
    Else
      strFiltros := strFiltros + ' AND OPE_CODSUB = :CODSUB ';
  end;

  If (Not fEmptyStr(edtCodVendedor.Text)) Then
  Begin
    If (blnLibVen) Then
      strFiltros := strFiltros + fStrLocate(edtCodVendedor, arrOperador, 'OPE_CODOPE', 'CODVEN')
    Else
      strFiltros := strFiltros + ' AND OPE_CODOPE = :CODVEN ';
  End;

  If cmbTipVen.ItemIndex <> VEN_TODOS Then
    strFiltros := strFiltros + ' AND CADOPE.OPE_INTEXT = :TIPVEN ';

  Case rdgItePro.ItemIndex Of
    0: strFiltros := strFiltros + ' AND IFNULL(DET_PROMOC,"N") <> "N" ';
    1: strFiltros := strFiltros + ' AND IFNULL(DET_PROMOC,"N")  = "N" ';
  End;

  Result := strFiltros;
End;

function TfrmRelFatComVendedor.fSQLJoinBase: String;
begin
  Result := Result + ' MOVGER ';
  Result := Result + '   INNER JOIN MOVDET ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
  Result := Result + '   INNER JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
  Result := Result + '   INNER JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
  Result := Result + '   INNER JOIN ITEGER IG ON IG.ITE_CODITE = DET_CODITE AND IG.ITE_CODEMP = DET_CODEMP ';
  Result := Result + '    LEFT JOIN CADITE CI ON CI.ITE_CODITE = DET_CODITE ';
  Result := Result + '    LEFT JOIN CADGRU ON GRU_CODGRU = CI.ITE_CODGRU ';
  Result := Result + '    LEFT JOIN MOVICD ON ICD_SEQGER = MOVDET.AUTOINCREM AND MOVDET.DET_VALRET = 0 ';
end;

function TfrmRelFatComVendedor.fSQLJoinCadOpe: String;
begin
  Case cbxVendedor.ItemIndex Of
    0: Result := ' LEFT JOIN CADOPE ON DET_CODVEN = OPE_CODOPE ';
    1: Result := ' LEFT JOIN CADOPE ON DET_CODVE2 = OPE_CODOPE ';
    2: Result := ' LEFT JOIN CADOPE ON DET_CODDIG = OPE_CODOPE ';
    3: Result := ' LEFT JOIN CADOPE ON DET_CODREP = OPE_CODOPE ';
    4: Result := ' LEFT JOIN CADOPE ON CLI_SUPGER = OPE_CODOPE ';
    5: Result := ' LEFT JOIN CADOPE ON CLI_SUPREG = OPE_CODOPE ';
  End;
end;

function TfrmRelFatComVendedor.fComDig: Boolean;
begin
  Result := (cbxVendedor.ItemIndex = 2) And (fCfgSis('USADIG', varBoolean));
end;

{**************************************}
{* PERCENTUAL POR TABELA DE PREÇOS    *}
{***********************************LU*}
Function TfrmRelFatComVendedor.fComTp: String;
Begin
  Result := '';
  Result := Result + '  IF(DET_TABPRE="1", ' + AnsiReplaceStr(fCfgSis('COMTP1', varDouble),',','.') + ', ';
  Result := Result + '  IF(DET_TABPRE="2", ' + AnsiReplaceStr(fCfgSis('COMTP2', varDouble),',','.') + ', ';
  Result := Result + '  IF(DET_TABPRE="3", ' + AnsiReplaceStr(fCfgSis('COMTP3', varDouble),',','.') + ', ';
  Result := Result + '  IF(DET_TABPRE="4", ' + AnsiReplaceStr(fCfgSis('COMTP4', varDouble),',','.') + ', ';
  Result := Result + '  IF(DET_TABPRE="5", ' + AnsiReplaceStr(fCfgSis('COMTP5', varDouble),',','.') + ', ';
  Result := Result + '  IF(DET_TABPRE="6", ' + AnsiReplaceStr(fCfgSis('COMTP6', varDouble),',','.') + ', ';
  Result := Result + '  IF(DET_TABPRE="7", ' + AnsiReplaceStr(fCfgSis('COMTP7', varDouble),',','.') + ', 0))))))) ';
End;

function TfrmRelFatComVendedor.fComTpS: String;
begin
  Result := '';
  Result := Result + '  IF(GER_TABPRE="1", ' + AnsiReplaceStr(fCfgSis('COMTP1', varDouble),',','.') + ', ';
  Result := Result + '  IF(GER_TABPRE="2", ' + AnsiReplaceStr(fCfgSis('COMTP2', varDouble),',','.') + ', ';
  Result := Result + '  IF(GER_TABPRE="3", ' + AnsiReplaceStr(fCfgSis('COMTP3', varDouble),',','.') + ', ';
  Result := Result + '  IF(GER_TABPRE="4", ' + AnsiReplaceStr(fCfgSis('COMTP4', varDouble),',','.') + ', ';
  Result := Result + '  IF(GER_TABPRE="5", ' + AnsiReplaceStr(fCfgSis('COMTP5', varDouble),',','.') + ', ';
  Result := Result + '  IF(GER_TABPRE="6", ' + AnsiReplaceStr(fCfgSis('COMTP6', varDouble),',','.') + ', ';
  Result := Result + '  IF(GER_TABPRE="7", ' + AnsiReplaceStr(fCfgSis('COMTP7', varDouble),',','.') + ', 0))))))) ';
end;

Function TfrmRelFatComVendedor.fSqlRelatorio(strFiltroAdicional: String = ''): String;
  Const
    STR_QTDITE = ' SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE)) ';

    STR_TOTCOM = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTCOM, DET_TOTCOM)) ';
    STR_TOTDIG = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -DET_COMDIG, DET_COMDIG)) ';

    STR_TOTCOMNF = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, 0, DET_TOTCOM)) ';
    STR_TOTDIGNF = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, 0, DET_COMDIG)) ';

    STR_TOTCOMTR = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTCOM, IF(LOCATE(DET_ESPDOC, "TR_DV_PD_") > 0, DET_TOTCOM, 0) )) ';
    STR_TOTDIGTR = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -DET_COMDIG, IF(LOCATE(DET_ESPDOC, "TR_DV_PD_") > 0, DET_COMDIG, 0) )) ';

    STR_TOTCO2 = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTCO2, DET_TOTCO2)) ';

    STR_TOTCO2NF = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, 0, DET_TOTCO2)) ';
    STR_TOTCO2TR = ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTCO2, IF(LOCATE(DET_ESPDOC, "TR_DV_PD_") > 0, DET_TOTCO2, 0) )) ';
  Var
    STR_CNDCOM,
    STR_CNDCOMNF,
    STR_CNDCOMTR,
    STR_CLIVEN,
    STR_CLIVENNF,
    STR_CLIVENTR,
    STR_FORCOM,
    STR_FORCOMNF,
    STR_FORCOMTR,
    STR_ITECOM,
    STR_ITECOMNF,
    STR_ITECOMTR,
    STR_OPECOMNF,
    STR_OPECOMTR,
    STR_TOTITE,
    STR_TOTITEMAR,
    STR_TOTITENF,
    STR_TOTITETR,
    STR_TBPCOM,
    STR_TBPCOMNF,
    STR_TBPCOMTR,
    STR_TBPCO2,
    STR_TBPCO2NF,
    STR_TBPCO2TR,
    STR_OPECO2NF,
    STR_OPECO2TR,
    STR_ITECO2,
    STR_ITECO2NF,
    STR_ITECO2TR,
    STR_FORCO2,
    STR_FORCO2NF,
    STR_FORCO2TR,
    STR_CLIVE2,
    STR_CLIVE2NF,
    STR_CLIVE2TR,
    strSQL,
    strCusTmp: String;

  Function fCamCom: String;
  Begin
    Case StrToInt(edtOpcao.Text) Of
      1: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TOTCO2, IfThen(fComDig, STR_TOTDIG, STR_TOTCOM));
      2: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_OPECO2, STR_OPECOM);
      3: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_ITECO2, STR_ITECOM);
      4: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_FORCO2, STR_FORCOM);
      5: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      6,
      9: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      7: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TBPCO2, STR_TBPCOM + ' - ' + STR_TBPCO2);
      8,
     13: Result := '0.00';
     10: Result := STR_CNDCOM;
     11: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_CLIVE2, STR_CLIVEN);
     12: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
    End;
  End;

  Function fRetComissaoNF: String;
  Begin
    Case StrToInt(edtOpcao.Text) Of
      1: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TOTCO2NF, IfThen(fComDig, STR_TOTDIGNF, STR_TOTCOMNF));
      2: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_OPECO2NF, STR_OPECOMNF);
      3: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_ITECO2NF, STR_ITECOMNF + IIF(fUsaVen2, ' - ' + STR_ITECO2NF, ''));
      4: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_FORCO2NF, STR_FORCOMNF);
      5: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      6,
      9: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      7: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TBPCO2NF, STR_TBPCOMNF + ' - ' + STR_TBPCO2NF);
      8,
     13: Result := '0.00';
     10: Result := STR_CNDCOMNF;
     11: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_CLIVE2NF, STR_CLIVENNF);
     12: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
    End;
  End;

  Function fRetComissaoTR: String;
  Begin
    Case StrToInt(edtOpcao.Text) Of
      1: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TOTCO2TR, IfThen(fComDig, STR_TOTDIGTR, STR_TOTCOMTR));
      2: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_OPECO2TR, STR_OPECOMTR);
      3: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_ITECO2TR, STR_ITECOMTR + IIF(fUsaVen2, ' - ' + STR_ITECO2TR, ''));
      4: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_FORCO2TR, STR_FORCOMTR);
      5: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      6,
      9: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      7: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TBPCO2TR, STR_TBPCOMTR + ' - ' + STR_TBPCO2TR);
      8,
     13: Result := '0.00';
     10: Result := STR_CNDCOMTR;
     11: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_CLIVE2TR, STR_CLIVENTR);
     12: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
    End;
  End;

Begin

  STR_OPECOM := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                ' -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                '  (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100))), 2) ';

  STR_OPECO2 := ' IF(DET_CODVE2 IS NULL, 0, ' +
                '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100)), 2) ' +
                ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_CNDCOM := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                '  - DET_TOTCOM, ' + //Quando for devolucao deve carregar a mesma comissao do documento de venda
                '  (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * CND_PERCOM)/100))), 2) ';

  STR_CNDCOMNF := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                  '  0, '   +
                  '  (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * CND_PERCOM)/100))), 2) ';

  STR_CNDCOMTR := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                '  - DET_TOTCOM, ' + //Quando for devolucao deve carregar a mesma comissao do documento de venda
                  '  0)), 2) ';

  STR_CLIVEN := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                ' -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                '  (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100))), 2) ';

  STR_CLIVENNF := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                  '  0, '     +
                  '  (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100))), 2) ';

  STR_CLIVENTR := ' ROUND(IF((DET_ESPDOC = "BR"), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                  ' -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                  '  0)), 2) ';

  STR_FORCOM := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '     +
                '   -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * FOR_PERCOM)/100), '      +
                '    (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * FOR_PERCOM)/100))), 2) ';

  STR_FORCOMNF := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '     +
                  '    0, '      +
                  '    (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * FOR_PERCOM)/100))), 2) ';

  STR_FORCOMTR := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '     +
                  '   -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * FOR_PERCOM)/100), '      +
                  '    0)), 2) ';

  STR_ITECOM := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                '   -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100), '     +
                '    (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100))), 2) ';

  STR_ITECOMNF := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                  '    0, '     +
                  '    (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100))), 2) ';

  STR_ITECOMTR := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                  '   -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100), '     +
                  '    0)), 2) ';

  STR_OPECOMNF := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                '   0, '     +
                '  (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100))), 2) ';

  STR_OPECOMTR := ' ROUND(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, '    +
                ' -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                '  0)), 2) ';

  STR_TOTITE := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')) ';

  STR_TOTITEMAR := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')) ';

  STR_TOTITENF   := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, 0, DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')) ';
  STR_TOTITETR   := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '), (DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + '))) ';

  STR_TBPCOM := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '                  +
                 '       -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * (' + fComTP + ') )/100), ' +
                 '        (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * (' + fComTP + ') )/100)), 2)) ';

  STR_TBPCOMNF := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '                  +
                  '        0, ' +
                  '        (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * (' + fComTP + ') )/100)), 2)) ';

  STR_TBPCOMTR := ' IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '                  +
                  '       -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * (' + fComTP + ') )/100), ' +
                  '        0), 2)) ';

  STR_TBPCO2 := ' IF(DET_CODVE2 IS NULL, 0, ' +
                   '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '              +
                   '   -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * (' + fComTP + ') )/100), ' +
                   '    (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * (' + fComTP + ') )/100)), 2) ' +
                ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_TBPCO2NF :=  ' IF(DET_CODVE2 IS NULL, 0, ' +
                   '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '              +
                   '    0, ' +
                   '    (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * (' + fComTP + ') )/100)), 2) ' +
                   ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_TBPCO2TR  := ' IF(DET_CODVE2 IS NULL, 0, ' +
                   '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '              +
                   '   -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * (' + fComTP + ') )/100), ' +
                   '    0), 2) ' +
                   ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_OPECO2NF := ' IF(DET_CODVE2 IS NULL, 0, ' +
                  '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                  '          0, '     +
                  '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100)), 2) ' +
                  ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_OPECO2TR := ' IF(DET_CODVE2 IS NULL, 0, ' +
                  '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                  '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                 '          0), 2) ' +
                  ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_ITECO2 := ' IF(DET_CODVE2 IS NULL, 0, ' +
                '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100), '     +
                '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100)), 2) ' +
                ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_ITECO2NF := ' IF(DET_CODVE2 IS NULL, 0, ' +
                  '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                  '          0, '     +
                  '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100)), 2) ' +
                  ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_ITECO2TR := ' IF(DET_CODVE2 IS NULL, 0, ' +
                  '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                  '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * PERCENTUAL)/100), '     +
                  '          0), 2) ' +
                  ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_FORCO2 := ' IF(DET_CODVE2 IS NULL, 0, ' +
                '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * FOR_PERCOM)/100), '     +
                '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * FOR_PERCOM)/100)), 2) ' +
                ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_FORCO2NF := ' IF(DET_CODVE2 IS NULL, 0, ' +
                  '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                  '          0, '     +
                  '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * FOR_PERCOM)/100)), 2) ' +
                  ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_FORCO2TR := ' IF(DET_CODVE2 IS NULL, 0, ' +
                  '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                  '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * FOR_PERCOM)/100), '     +
                  '          0), 2) ' +
                  ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_CLIVE2 := ' IF(DET_CODVE2 IS NULL, 0, ' +
                '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100)), 2) ' +
                ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_CLIVE2NF := ' IF(DET_CODVE2 IS NULL, 0, ' +
                  '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                  '          0, '     +
                  '          (((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100)), 2) ' +
                  ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  STR_CLIVE2TR := ' IF(DET_CODVE2 IS NULL, 0, ' +
                  '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND((ROUND(IF(LEFT(DET_CLAFIS,1) < 5, '      +
                  '         -(((DET_TOTITE - DET_DESESP - DET_DESCFF' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ') * ' + fRetCampoPercom + ')/100), '     +
                  '          0), 2) ' +
                  ' * ' + AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.') + ')/100, 2))) ';

  {**************************************}
  {* SELECT DO RELATÓRIO                *}
  {**************************************}
  {*            ATENÇÃO                 *}
  {**************************************}
  {* SE MEXER NESSE SELECT VERIFICAR A  *}
  {* PROCEDURE ACIMA QUE MONTA O RESUMO *}
  {* POR ALIQUOTA.                      *}
  {***********************************AF*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + IfThen(edtEmpFat.Text = 'F', ' DET_CODEMP AS CODEMP, ', ' DET_EMPORI AS CODEMP, ');
  strSQL := strSQL + '  DET_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  OPE_NOMOPE AS VENNOM, ';
  strSQL := strSQL + '  DET_CODVE2 AS CODVE2, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMVE2, ';
  strSQL := strSQL + '  DET_CODDIG AS CODDIG, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMDIG, ';
  strSQL := strSQL + '  DET_CODREP AS CODREP, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMREP, ';
  strSQL := strSQL + '  DET_CONPAG, ';
  strSQL := strSQL + '  CLI_PERCOM, ';
  strSQL := strSQL + '  OPE_PERCO2, ';
  strSQL := strSQL + '  OPE_PERCOM, ';
  {******************************************}
  {* CAMPO DET_TABPRE INCLUÍDO EM 07/12/2010 }
  {***************************************RV*}
  strSQL := strSQL + '  IFNULL(DET_TABPRE, "") AS TABPRE, ';
  strSQL := strSQL + '  OPE_CODOPE AS SUPERV, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMERV, ';
  strSQL := strSQL + '  DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  CONCAT(DET_NUMDOC,"-",DET_ESPDOC) AS NUMDOC, ';
  strSQL := strSQL + '  IFNULL(GRU_CODGRU, "") AS CODGRU, ';
  strSQL := strSQL + '  CONCAT(GRU_CODGRU,"-",GRU_DESGRU) AS DESGRU, ';
  strSQL := strSQL + '  IF((CLI_NOMCLI LIKE "%CONSUMIDOR%") OR (CLI_NOMCLI LIKE "%SEGURADORA%"), GER_NOMCON, CLI_NOMCLI) AS NOMCL2, ';
  strSQL := strSQL + '  IF(TRIM(DET_NUMFAT) <> "", CONCAT(DET_NUMFAT,"-",DET_TIPFAT),  "") AS NUMFAT, ';
  strSQL := strSQL + '  CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS NOMVEN, ';
  strSQL := strSQL + '  CONCAT(DET_CODCLI, "-", IF((CLI_NOMCLI LIKE "%CONSUMIDOR%") OR (CLI_NOMCLI LIKE "%SEGURADORA%"), GER_NOMCON, CLI_NOMCLI)) AS NOMCLI, ';

  strSQL := strSQL + 'SUM(' + STR_TOTITE + ') AS TOTITE, ';
  strSQL := strSQL + STR_QTDITE + ' AS QTDITE, ';

  If fCfgSis('ELCUCO', varBoolean) Then
    strCusTmp := '  ROUND(IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ', 0) * IF(IFNULL(MAR_FATCUS, 0) = 0, 1, MAR_FATCUS), 4)'
  Else
    strCusTmp := '  IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ', 0) ';

  strSQL := strSQL + '  SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -' + strCusTmp + ', ' + strCusTmp + '))) AS TOTCUS, ';

  If (fComDig) Then
    strSQL := strSQL + 'SUM(' + STR_TOTDIG + ') AS TOTCOM, '
  Else
    strSQL := strSQL + 'SUM(' + STR_TOTCOM + ') AS TOTCOM, ';

  If edtOpcao.Text = '11' Then
    strSQL := strSQL + 'SUM(' + STR_CLIVEN + ') AS OPECOM, '
  Else
    strSQL := strSQL + 'SUM(' + STR_OPECOM + ') AS OPECOM, ';

  strSQL := strSQL + 'SUM(' + STR_ITECOM + ') AS ITECOM, ';
  strSQL := strSQL + 'SUM(' + STR_FORCOM + ') AS FORCOM, ';
  strSQL := strSQL + 'SUM(' + STR_CNDCOM + ') AS CNDCOM, ';

  strSQL := strSQL + fComTP + ' AS PERTAB, ';

  strSQL := strSQL + 'SUM(' + STR_TBPCOM + ') AS TBPCOM, ';

  strSQL := strSQL + 'SUM(' + STR_TBPCO2 + ') AS TBPCO2, ';

  {**************************************}
  {* CALCULADO NA VENDA                 *}
  {***********************************AF*}
  strSQL := strSQL + 'SUM(' + STR_TOTCO2 + ') AS TOTCO2, ';
  strSQL := strSQL + '  SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -DET_COMREP, DET_COMREP))) AS TOTREP, ';

  {**********************************}
  {* CALCULA A COMISSÃO DO VENDEDOR *}
  {*******************************AF*}
  If edtOpcao.Text = '11' Then
    strSQL := strSQL +  'SUM(' + STR_CLIVE2 + ') AS OPECO2, '
  Else
    strSQL := strSQL +  'SUM(' + STR_OPECO2 + ') AS OPECO2, ';

  {*********************************}
  {* CALCULA A COMISSÃO DO PRODUTO *}
  {******************************AF*}
  strSQL := strSQL +  'SUM(' + STR_ITECO2 + ') AS ITECO2, ';

  {************************************}
  {* CALCULA A COMISSÃO DO FORNECEDOR *}
  {*********************************AF*}
  strSQL := strSQL +  'SUM(' + STR_FORCO2 + ') AS FORCO2, ';

  strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, DET_UNITAR) AS DET_UNITAR, ';
  strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, DET_UNIORI) AS DET_UNIORI, ';

  strSQL := strSQL + '  SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, DET_TOTITE' + IfThen(blnFreCom,' + DET_TOTFRE', '') + ')) AS DET_TOTITE, ';
  strSQL := strSQL + '  SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, DET_DESESP)) AS DET_DESESP, ';
  strSQL := strSQL + '  SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, DET_DESCFF)) AS COL_DESCFF, ';
  strSQL := strSQL + '  SUM(IFNULL(DET_QTDITE, 0)) AS DET_QTDITE, ';
  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  ITE_COMVAR, ';
  strSQL := strSQL + '  ITE_COMATA, ';
  strSQL := strSQL + '  ITE_COMDIS, ';

  strSQL := strSQL + '  0000000.0000 AS MARCOM, ';
  strSQL := strSQL + '  0000000.0000 AS DESCOM, ';
  strSQL := strSQL + '  0000000.0000 AS MARCO2, ';
  strSQL := strSQL + '  0000000.0000 AS DESCO2, ';
  strSQL := strSQL + '  0000000.0000 AS LUCCOM, ';
  strSQL := strSQL + '  0000000.0000 AS LUCCOMNF, ';
  strSQL := strSQL + '  0000000.0000 AS LUCCOMTR, ';
  strSQL := strSQL + '  0000000.0000 AS LUCCO2, ';
  //strSQL := strSQL + '  0000000.0000 AS CNDCOM, ';

  strSQL := strSQL + '  COUNT(DISTINCT CONCAT(DET_NUMDOC,"-",DET_ESPDOC)) AS QTDDOC, ';

  strSQL := strSQL + '  OPE_INTEXT, ';
  strSQL := strSQL + '  IFNULL(DET_CODITE, "") AS CODITE, ';
  strSQL := strSQL + '  IFNULL(DET_CODCLI, "") AS CODCLI, ';
  strSQL := strSQL + '  DET_CLAFIS AS CLAFIS, ';

  strSQL := strSQL + '  SUM((IF(LOCATE(DET_ESPDOC, "NF_EL_IF_IV_D1_") > 0, ' + STR_TOTITENF   + ', 0))) AS TOTITENF, ';
  strSQL := strSQL + '  SUM((IF(LOCATE(DET_ESPDOC, "NF_EL_IF_IV_D1_") > 0, ' + fRetComissaoNF + ', 0))) AS TOTCOMNF, ';

  strSQL := strSQL + '  SUM((IF(LOCATE(DET_ESPDOC, "TR_DV_") > 0 OR (LEFT(DET_CLAFIS,1) < 5), ' + STR_TOTITETR   + ', 0))) AS TOTITETR, ';
  strSQL := strSQL + '  SUM((IF(LOCATE(DET_ESPDOC, "TR_DV_") > 0 OR (LEFT(DET_CLAFIS,1) < 5), ' + fRetComissaoTR + ', 0))) AS TOTCOMTR, ';

  strSQL := strSQL + '  SUM((IF(LOCATE(DET_ESPDOC, "TR_DV_NF_EL_IF_IV_PD_") <= 0, ' + STR_TOTITE + ', 0))) AS TOTITEOU, ';
  strSQL := strSQL + '  SUM((IF(LOCATE(DET_ESPDOC, "TR_DV_NF_EL_IF_IV_PD_") <= 0, ' + fCamCom + ', 0))) AS TOTCOMOU, ';

  strSQL := strSQL + '   DET_CONPAG    AS CONPAG, ';
  strSQL := strSQL + '   DET_CODCND    AS CODCND, ';  
  strSQL := strSQL + '   IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  PERCENTUAL) AS PERCOM, ';
  strSQL := strSQL + '   (SUM(IFNULL(DET_TOTITE,0) - IFNULL(DET_DESESP,0)) - SUM(' + strCusTmp + ' )) AS RESULT, ';

  If Pos(strMarMkp, '1_5_') = 0 Then
    strSQL := strSQL + ' IF(SUM(' + STR_TOTITEMAR + ') = 0, 0.00, IFNULL( ( ((SUM(' + STR_TOTITEMAR + ')/SUM( IF(LEFT(DET_CLAFIS,1) < 5, -' + strCusTmp + ', ' + strCusTmp + '))) * 100) - 100 ), 0)) AS MARGEM, '
  Else
    strSQL := strSQL + ' IF(SUM(' + STR_TOTITEMAR + ') = 0, 0.00, IFNULL( ( ( 1 - (SUM( IF(LEFT(DET_CLAFIS,1) < 5, -' + strCusTmp + ', ' + strCusTmp + '))/SUM(' + STR_TOTITEMAR + '))) * 100), 100)) AS MARGEM, ';

  {********************************************************}
  {* ACRESCENTOU DUAS COLUNAS , PARA GERAR O RELATORIO    *}
  {* ANALITICO DO ITEM: A DESCRICAO DO ITEM , E A UNIDADE *}
  {**11/03/2011 - 09:24 ********************************DP*}
  strSQL := strSQL + '   CI.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   CADUNI.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   GER_ENTFAT AS ENTFAT, ';
  strSQL := strSQL + '   DET_ENTFUT AS ENTFUT,  ';
  strSQL := strSQL + '   DET_MOTFUT AS MOTFUT  ';

  pMontaSqlPerComItem(strSQL);

  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + fSQLJoinBase;
  strSQL := strSQL + '  LEFT JOIN CADFOR ON FOR_CODFOR = DET_FORITE ';
  strSQL := strSQL + '  LEFT JOIN CADCND ON CND_CODIGO = DET_CODCND ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ';

  If fCfgSis('ELCUCO', varBoolean) Then
    strSQL := strSQL + '  LEFT JOIN CADMAR ON CI.ITE_CODMAR = MAR_CODMAR ';

  strSQL := strSQL + fSQLJoinCadOpe;

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL +   fSQLFiltros(False) + ' ';
  
  If Not fEmptyStr(strFiltroAdicional) Then
     strSQL := strSQL + strFiltroAdicional;

  strSQL := strSQL + ' GROUP BY    ';

  If ((Pos(edtOpcao.Text,'5_6_8_9_') > 0) Or (edtOpcao.Text = '12') Or (edtOpcao.Text = '13')) Then
  Begin
    If (edtOpcao.Text = '12') Then
      strSQL := strSQL + fCodVen(edtOrdem.Text) + ', NUMDOC, CODEMP, CODITE, DET_UNITAR '
    Else
    Begin
      {****************************************************************}
      {* NÃO RETIRAR "(Pos(edtOpcao.Text, '5_8_') <= 0)", POIS ESTAVA *}
      {* GERANDO DIFERENÇA DE COMISSÃO NO RELATÓRIO                   *}
      {*************************************************************PZ*}
      If SameText(edtTipo.Text, '2') And (Pos(edtOpcao.Text, '5_8_') <= 0) And (Not SameText(edtOpcao.Text, '13')) Then
        strSQL := strSQL + ' NUMDOC, CODEMP, CODITE, DET_UNITAR '
      Else If SameText(edtTipo.Text, '3') And (Pos(edtOpcao.Text, '5_8_') <= 0) And (Not SameText(edtOpcao.Text, '13')) Then
        strSQL := strSQL + ' DTAENT, NUMDOC, CODEMP, CODITE, DET_UNITAR '
      Else
        strSQL := strSQL + fCodVen(edtOrdem.Text) + ', NUMDOC, CODEMP, CODITE, DET_UNITAR '
    End;
  End
  Else
    strSQL := strSQL + fCamposGrupo;

  Result := strSQL;

End;

function TfrmRelFatComVendedor.fSqlServico: String;
  Const
    STR_QTDITE = ' IF(LEFT(GER_CLAFIS, 1) < 5, -GER_QTDSER, GER_QTDSER) ';

    STR_TOTCOM = ' IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), ' +
      ' 0.00, IF(LEFT(GER_CLAFIS, 1) < 5, -GER_COMSER, GER_COMSER)) ';

    STR_TOTCOMNF = ' (IF(LOCATE(ESPDOC, "NF_EL_IF_IV_D1_") > 0, IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), 0.00, ' +
                   ' IF(LEFT(GER_CLAFIS, 1) < 5, 0, GER_COMSER)), 0)) ';

    STR_TOTCOMTR = ' (IF(LOCATE(ESPDOC, "TR_DV_") > 0 OR (LEFT(CLAFIS, 1) < 5), IF((ESPDOC = "BR") ' +
                   ' OR LOCATE(CLAFIS, ' + CLAFIS_BR + '), 0.00, IF(LEFT(CLAFIS, 1) < 5, -GER_COMSER, IF( ' +
                   ' LOCATE(ESPDOC, "TR_DV_PD_") > 0, GER_COMSER, 0))), 0)) ';


    STR_TOTCO2 = ' 0 ';

    STR_TOTCO2NF = ' 0 ';

    STR_TOTCO2TR = ' 0 ';
  Var
    STR_CNDCOM,
    STR_CNDCOMNF,
    STR_CNDCOMTR,
    STR_CLIVEN,
    STR_CLIVENNF,
    STR_CLIVENTR,
    STR_FORCOM,
    STR_FORCOMNF,
    STR_FORCOMTR,
    STR_ITECOM,
    STR_ITECOMNF,
    STR_ITECOMTR,
    STR_OPECOMNF,
    STR_OPECOMTR,
    STR_TOTITE,
    STR_TOTITEMAR,
    STR_TOTITENF,
    STR_TOTITETR,
    STR_TBPCOM,
    STR_TBPCOMNF,
    STR_TBPCOMTR,
    STR_TBPCO2,
    STR_TBPCO2NF,
    STR_TBPCO2TR,
    STR_OPECO2NF,
    STR_OPECO2TR,
    STR_ITECO2,
    STR_ITECO2NF,
    STR_ITECO2TR,
    STR_FORCO2,
    STR_FORCO2NF,
    STR_FORCO2TR,
    STR_CLIVE2,
    STR_CLIVE2NF,
    STR_CLIVE2TR,
    STR_OPECOM2,
    STR_COMSER,
    strSQL,
    strCusTmp: String;

  Function fCamCom: String;
  Begin
    Case StrToInt(edtOpcao.Text) Of
      1: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TOTCO2, STR_TOTCOM);
      2: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_OPECO2, STR_OPECOM);
      3: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_ITECO2, STR_ITECOM);
      4: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_FORCO2, STR_FORCOM);
      5: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      6,
      9: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      7: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TBPCO2, STR_TBPCOM + ' - ' + STR_TBPCO2);
      8,
     13: Result := '0.00';
     10: Result := STR_CNDCOM;
     11: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_CLIVE2, STR_CLIVEN);
     12: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
    End;
  End;

  Function fRetComissaoNF: String;
  Begin
    Case StrToInt(edtOpcao.Text) Of
      1: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TOTCO2NF, STR_TOTCOMNF);
      2: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_OPECO2NF, STR_OPECOMNF);
      3: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_ITECO2NF, STR_ITECOMNF + IIF(fUsaVen2, ' - ' + STR_ITECO2NF, ''));
      4: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_FORCO2NF, STR_FORCOMNF);
      5: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      6,
      9: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      7: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TBPCO2NF, STR_TBPCOMNF + ' - ' + STR_TBPCO2NF);
      8,
     13: Result := '0.00';
     10: Result := STR_CNDCOMNF;
     11: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_CLIVE2NF, STR_CLIVENNF);
     12: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
    End;
  End;

  Function fRetComissaoTR: String;
  Begin
    Case StrToInt(edtOpcao.Text) Of
      1: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TOTCO2TR, STR_TOTCOMTR);
      2: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_OPECO2TR, STR_OPECOMTR);
      3: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_ITECO2TR, STR_ITECOMTR + IIF(fUsaVen2, ' - ' + STR_ITECO2TR, ''));
      4: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_FORCO2TR, STR_FORCOMTR);
      5: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      6,
      9: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
      7: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_TBPCO2TR, STR_TBPCOMTR + ' - ' + STR_TBPCO2TR);
      8,
     13: Result := '0.00';
     10: Result := STR_CNDCOMTR;
     11: Result := IfThen(cbxVendedor.ItemIndex = 1, STR_CLIVE2TR, STR_CLIVENTR);
     12: Result := IfThen(cbxVendedor.ItemIndex = 1, '0.00', '0.00');
    End;
  End;

Begin

  STR_TOTITETR := ' 0 ';

  STR_CNDCOM := ' 0 ';

  STR_CNDCOMNF := ' 0 ';

  STR_CNDCOMTR := ' 0 ';

  STR_CLIVEN := ' 0 ';

  STR_CLIVENNF := ' 0 ';

  STR_CLIVENTR := ' 0 ';

  STR_FORCOM := ' 0 ';

  STR_FORCOMNF := ' 0 ';

  STR_FORCOMTR := ' 0 ';

  If (fCfgSis('AUTCEN', VarBoolean)) And  (fCfgSis('OPCVEN', VarString ) = 'CPS') Then
  Begin
    STR_ITECOM := ' ROUND(IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), 0.00, IF( ' +
                  ' LEFT(GER_CLAFIS, 1) < 5, -(((GER_VALSER) * SER_COMVEN) / 100), (((GER_VALSER) * SER_COMVEN) / 100))), 2) ';
  End
  Else
  Begin
    STR_ITECOM := STR_TOTCOM;
  End;

  STR_ITECOMNF := ' 0 ';

  STR_ITECOMTR := ' 0 ';

  STR_OPECOMNF := ' 0 ';

  STR_OPECOMTR := ' 0 ';

  STR_OPECOM := ' ROUND(IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), 0.00, ' +
                ' IF(LEFT(GER_CLAFIS,1) < 5, -((GER_VALSER * ' + fRetCampoPercom + ')/100), ((GER_VALSER * ' + fRetCampoPercom + ')/100))), 2) ';

  STR_OPECOM2 := ' ROUND(IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), 0.00, IF( ' +
                ' LEFT(GER_CLAFIS, 1) < 5, -(((GER_VALSER) * OPE_VENCSE) / 100), (((GER_VALSER) ' +
                ' * OPE_VENCSE) / 100))), 2) ';

  STR_OPECO2 := ' IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), 0.00, ' +
               ' ROUND((ROUND(IF(LEFT(GER_CLAFIS,1) < 5, -((GER_VALSER * ' + fRetCampoPercom + ')/100), ' +
               ' ((GER_VALSER * ' + fRetCampoPercom + ')/100)), 2) * 0.00)/100, 2)) ';

  STR_TOTITE := ' IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), 0.00, IF( ' +
                ' LEFT(GER_CLAFIS, 1) < 5, -GER_VALSER, GER_VALSER)) ';

  STR_TOTITEMAR := ' IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(GER_CLAFIS,1) < 5, -GER_VALSER, GER_VALSER )) ';

  STR_TOTITENF   := ' SUM((IF(LOCATE(ESPDOC, "NF_EL_IF_IV_D1_") > 0, IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), ' +
                    ' 0.00, IF(LEFT(GER_CLAFIS, 1) < 5, 0, GER_VALSER)), 0))) ';

  STR_TBPCOM :=  ' IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND(IF(LEFT(GER_CLAFIS,1) < 5, '                  +
                 '       -(((GER_VALSER' + IfThen(blnFreCom,' + GER_TOTFRE', '') + ') * (' + fComTPS + ') )/100), ' +
                 '        (((GER_VALSER' + IfThen(blnFreCom,' + GER_TOTFRE', '') + ') * (' + fComTPS + ') )/100)), 2)) ';

  STR_TBPCOMNF := ' 0 ';

  STR_TBPCOMTR := ' 0 ';

  STR_TBPCO2 := ' IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS,' + CLAFIS_BR + '), 0.00, ROUND(IF(LEFT(GER_CLAFIS,1) < 5, '                  +
                '       -(((GER_VALSER' + IfThen(blnFreCom,' + GER_TOTFRE', '') + ') * (' + fComTPS + ') )/100), ' +
                '        (((GER_VALSER' + IfThen(blnFreCom,' + GER_TOTFRE', '') + ') * (' + fComTPS + ') )/100)), 2)) ';

  STR_TBPCO2NF :=  ' 0 ';

  STR_TBPCO2TR  := ' 0 ';

  STR_OPECO2NF := ' 0 ';

  STR_OPECO2TR := ' 0 ';

  STR_ITECO2 := ' 0 ';

  STR_ITECO2NF := ' 0 ';

  STR_ITECO2TR := ' 0 ';

  STR_FORCO2 := ' 0 ';

  STR_FORCO2NF := ' 0 ';

  STR_FORCO2TR := ' 0 ';

  STR_CLIVE2 := ' 0 ';

  STR_CLIVE2NF := ' 0 ';

  STR_CLIVE2TR := ' 0 ';

  STR_COMSER := 'IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), 0.00, IF(LEFT(GER_CLAFIS, 1) < 5, -GER_COMSER, GER_COMSER))';

  {**************************************}
  {* SELECT DO RELATÓRIO                *}
  {**************************************}
  {*            ATENÇÃO                 *}
  {**************************************}
  {* SE MEXER NESSE SELECT VERIFICAR A  *}
  {* PROCEDURE ACIMA QUE MONTA O RESUMO *}
  {* POR ALIQUOTA.                      *}
  {***********************************AF*}
  strSQL := '';
  strSQL := strSQL + '  SELECT ';
  strSQL := strSQL + '    NOMCL2, ';
  strSQL := strSQL + '    DTAENT, ';
  strSQL := strSQL + '    ESPDOC, ';
  strSQL := strSQL + '    NUMDOC, ';
  strSQL := strSQL + '    NUMFAT, ';
  strSQL := strSQL + '    CODEMP, ';
  strSQL := strSQL + '    CODVEN, ';
  strSQL := strSQL + '    VENNOM, ';
  strSQL := strSQL + '    CODVE2, ';
  strSQL := strSQL + '    NOMVE2, ';
  strSQL := strSQL + '    CODDIG, ';
  strSQL := strSQL + '    NOMDIG, ';
  strSQL := strSQL + '    CODREP, ';
  strSQL := strSQL + '    NOMREP, ';
  strSQL := strSQL + '    SUPERV, ';
  strSQL := strSQL + '    NOMERV, ';
  strSQL := strSQL + '    NOMVEN, ';
  strSQL := strSQL + '    NOMCLI, ';
  strSQL := strSQL + '    DESGRU, ';
  strSQL := strSQL + '    SUM(IFNULL(QTDDOC, 0)) AS QTDDOC, ';

  If (edtTipo.Text = '4') Then Begin
    strSQL := strSQL + '    GER_CODSER AS CODITE, ';
    strSQL := strSQL + '    GER_DESSER AS DESITE, ';
    strSQL := strSQL + '    "UN"       AS SIGUNI, ';
    strSQL := strSQL + '    GER_VALSER AS DET_UNITAR, ';
    strSQL := strSQL + '    GER_QTDSER AS DET_QTDITE, ';
  End;

  strSQL := strSQL + ' IFNULL(' + STR_TOTITENF + ' ,0) AS TOTITENF, ';
  strSQL := strSQL + ' SUM(IFNULL( ' + STR_TOTCOMNF + ' ,0)) AS TOTCOMNF, ';
  strSQL := strSQL + ' IFNULL(' + STR_TOTITETR + ' ,0) AS TOTITETR, ';
  strSQL := strSQL + ' SUM(IFNULL( ' + STR_TOTCOMTR + ' ,0)) AS TOTCOMTR, ';
  strSQL := strSQL + ' SUM((IF(LOCATE(ESPDOC, "TR_DV_NF_EL_IF_IV_PD_") <= 0, IFNULL( ' + STR_TOTITE + ' ,0) , 0))) AS TOTITEOU, ';
  strSQL := strSQL + ' SUM((IF(LOCATE(ESPDOC, "TR_DV_NF_EL_IF_IV_PD_") <= 0, IFNULL( ' + STR_COMSER + ' ,0), 0))) AS TOTCOMOU, ';
  strSQL := strSQL + ' IFNULL(' + STR_TBPCOM  + ' ,0) AS TBPCOM, ';
  strSQL := strSQL + ' IFNULL(' + STR_TBPCO2  + ' ,0) AS TBPCO2, ';
  strSQL := strSQL + ' IFNULL(' + STR_OPECOM2 + ' ,0) AS OPECOM, ';
  strSQL := strSQL + ' 0 AS OPECO2, ';
  strSQL := strSQL + ' IFNULL(OPE_VENCSE, 0) AS ITECOM, ';
  strSQL := strSQL + ' 0                     AS ITECO2, ';
  strSQL := strSQL + ' 0                     AS FORCOM, ';
  strSQL := strSQL + ' 0                     AS FORCO2, ';
  strSQL := strSQL + ' 0                     AS CNDCOM, ';
  strSQL := strSQL + ' SUM(IFNULL( ' + STR_TOTITE   + ' ,0)) AS TOTITE, ';
  strSQL := strSQL + ' SUM(IFNULL( ' + STR_QTDITE   + ' ,0)) AS QTDITE, ';
  strSQL := strSQL + ' SUM(IFNULL(GER_CUSSER, 0)) AS TOTCUS, ';
  strSQL := strSQL + ' (SUM(IFNULL(GER_VALSER, 0)) - SUM(IFNULL(GER_CUSSER, 0))) AS RESULT, ';

  strCusTmp := '  IFNULL(GER_CUSSER, 0) ';

  If Pos(strMarMkp, '1_5_') = 0  Then
    strSQL := strSQL + ' IF(SUM(' + STR_TOTITEMAR + ') = 0, 0.00, IFNULL( ( ((SUM(' + STR_TOTITEMAR + ')/SUM( IF(LEFT(GER_CLAFIS,1) < 5, -' + strCusTmp + ', ' + strCusTmp + '))) * 100) - 100 ), 0)) AS MARGEM, '
  Else
    strSQL := strSQL + ' IF(SUM(' + STR_TOTITEMAR + ') = 0, 0.00, IFNULL( ( ( 1 - (SUM( IF(LEFT(GER_CLAFIS,1) < 5, -' + strCusTmp + ', ' + strCusTmp + '))/SUM(' + STR_TOTITEMAR + '))) * 100), 100)) AS MARGEM, ';

  strSQL := strSQL + '    IF(SUM(GER_VALSER) = 0, 0.00, IFNULL( IFNULL(SUM(GER_COMSER), 0) / (IFNULL(SUM(GER_VALSER), 0) / 100), 0)) AS PERCOM, ';
  strSQL := strSQL + '    SUM('+STR_COMSER+') AS TOTCOM ';

  If (cbxVendedor.ItemIndex = 1) Or (edtOpcao.Text = '10') Then
    strSQL := strSQL + ', SUM('+STR_COMSER+') AS TOTCO2 ';

  strSQL := strSQL + '  FROM ';

  strSQL := strSQL + '(SELECT GER_TABPRE,   ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + IfThen(edtEmpFat.Text = 'F', ' GER_CODEMP AS CODEMP, ', ' GER_EMPORI AS CODEMP, ');
  strSQL := strSQL + fCaseVenSer() + ' AS CODVEN, ';
  strSQL := strSQL + '  OPE_NOMOPE AS VENNOM, ';
  strSQL := strSQL + fCaseVenSer() + ' AS CODVE2, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMVE2, ';
  strSQL := strSQL + '  GER_CODDIG AS CODDIG, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMDIG, ';
  strSQL := strSQL + '  GER_CODREP AS CODREP, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMREP, ';
  strSQL := strSQL + '  DET_CONPAG, ';
  strSQL := strSQL + '  IFNULL(CLI_PERCOM, 0) AS CLI_PERCOM, ';
  strSQL := strSQL + '  IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2, ';
  strSQL := strSQL + '  IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM, ';
  strSQL := strSQL + '  IFNULL(GER_TABPRE, "") AS TABPRE, ';
  strSQL := strSQL + '  OPE_CODOPE AS SUPERV, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMERV, ';
  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS NUMDOC, ';
  strSQL := strSQL + '  IFNULL(GRUSER.GRU_CODGRU, "") AS CODGRU, ';
  strSQL := strSQL + '  CONCAT(GRUSER.GRU_CODGRU, "-", GRUSER.GRU_DESGRU) AS DESGRU, ';
  strSQL := strSQL + '  IF((CLI_NOMCLI LIKE "%CONSUMIDOR%") OR (CLI_NOMCLI LIKE "%SEGURADORA%"), GER_NOMCON, CLI_NOMCLI) AS NOMCL2, ';
  strSQL := strSQL + '  IF(TRIM(GER_NUMFAT) <> "", CONCAT(GER_NUMFAT, "-", GER_TIPFAT), "") AS NUMFAT, ';
  strSQL := strSQL + '  CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS NOMVEN, CONCAT(GER_CODCLI, "-", IF((CLI_NOMCLI LIKE "%CONSUMIDOR%") ';
  strSQL := strSQL + '    OR (CLI_NOMCLI LIKE "%SEGURADORA%"), GER_NOMCON, CLI_NOMCLI)) AS NOMCLI, ';
  strSQL := strSQL + '  T.IDESER, ';
  strSQL := strSQL + '  COUNT(DISTINCT CONCAT(GER_NUMDOC, "-", GER_ESPDOC)) AS QTDDOC, ';
  strSQL := strSQL + fCaseCodSer() + ' AS GER_CODSER, ';
  strSQL := strSQL + fCaseDesSer() + ' AS GER_DESSER, ';
  strSQL := strSQL + fCaseQtdSer() + ' AS GER_QTDSER, ';
  strSQL := strSQL + fCaseValSer() + ' AS GER_VALSER, ';
  strSQL := strSQL + fCaseCusSer() + ' AS GER_CUSSER, ';
  strSQL := strSQL + fCaseComSer() + ' AS GER_COMSER, ';
  strSQL := strSQL + '  SER_COMVEN, ';
  strSQL := strSQL + '  GER_NUMDOC, ';
  strSQL := strSQL + '  GER_CLAFIS, ';
  strSQL := strSQL + '  0000000.0000 AS ITE_COMVAR, ';
  strSQL := strSQL + '  0000000.0000 AS ITE_COMATA, ';
  strSQL := strSQL + '  0000000.0000 AS ITE_COMDIS, ';
  strSQL := strSQL + '  0000000.0000 AS MARCOM, ';
  strSQL := strSQL + '  0000000.0000 AS DESCOM, ';
  strSQL := strSQL + '  0000000.0000 AS MARCO2, ';
  strSQL := strSQL + '  0000000.0000 AS DESCO2, ';
  strSQL := strSQL + '  0000000.0000 AS LUCCOM, ';
  strSQL := strSQL + '  0000000.0000 AS LUCCOMNF, ';
  strSQL := strSQL + '  0000000.0000 AS LUCCOMTR, ';
  strSQL := strSQL + '  0000000.0000 AS LUCCO2, ';
  strSQL := strSQL + '  OPE_INTEXT, ';
  strSQL := strSQL + '  IFNULL(GER_CODCLI, "") AS CODCLI, ';
  strSQL := strSQL + '  GER_CLAFIS AS CLAFIS, ';
  strSQL := strSQL + '  GER_CONPAG AS CONPAG, ';
  strSQL := strSQL + '  GER_CODCND AS CODCND, ';
  strSQL := strSQL + '  GER_ENTFUT AS ENTFUT, ';
  strSQL := strSQL + '  OPE_VENCSE, OPE_TPCOVN, ';
  strSQL := strSQL + '  GER_TOTFRE ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + fSQLJoinBase;
  strSQL := strSQL + '     LEFT  JOIN SERMOV S   ON S.GER_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '     LEFT  JOIN CADFOR F   ON F.FOR_CODFOR = DET_FORITE ';
  strSQL := strSQL + '     LEFT  JOIN (' + fTabIdeSer + ') T ON TRUE  ';
  strSQL := strSQL + '     LEFT  JOIN CADSER     ON SER_CODSER = ' + fCaseIdeSer();
  strSQL := strSQL + '     INNER JOIN CADOPE ON ' + fCaseVenSer() + ' = OPE_CODOPE ';
  strSQL := strSQL + '     LEFT  JOIN GRUSER     ON GRUSER.GRU_CODGRU = SER_CODGRU ';
  strSQL := strSQL + '     LEFT  JOIN CADCND     ON CND_CODIGO = GER_CODCND ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL +   fSQLFiltros(True);

  strSQL := strSQL + '  GROUP BY CODVEN, NUMDOC, GER_CODSER, IDESER ';
  strSQL := strSQL + '  HAVING IFNULL(GER_CODSER, "") <> "") AS VW_SER ';

  strSQL := strSQL + '  GROUP BY  ';

  If ((Pos(edtOpcao.Text,'5_6_8_9_') > 0) Or (edtOpcao.Text = '12') Or (edtOpcao.Text = '13')) Then
  Begin
    If (edtOpcao.Text = '12') Then
      strSQL := strSQL + fCodVen(edtOrdem.Text) + ', NUMDOC, CODEMP, CODITE, DET_UNITAR '
    Else
    Begin
      {****************************************************************}
      {* NÃO RETIRAR "(Pos(edtOpcao.Text, '5_8_') <= 0)", POIS ESTAVA *}
      {* GERANDO DIFERENÇA DE COMISSÃO NO RELATÓRIO                   *}
      {*************************************************************PZ*}
      If SameText(edtTipo.Text, '2') And (Pos(edtOpcao.Text, '5_8_') <= 0) And (Not SameText(edtOpcao.Text, '13')) Then
        strSQL := strSQL + fCodVen(edtOrdem.Text)
      Else If SameText(edtTipo.Text, '3') And (Pos(edtOpcao.Text, '5_8_') <= 0) And (Not SameText(edtOpcao.Text, '13')) Then
        strSQL := strSQL + fCodVen(edtOrdem.Text) + ', DTAENT '
      Else
        strSQL := strSQL + fCodVen(edtOrdem.Text) + ', NUMDOC, CODEMP, CODITE, DET_UNITAR '
    End;
  End
  Else
    strSQL := strSQL + fCamposGrupo;

  Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);
end;

function TfrmRelFatComVendedor.fSqlServicoResumo: String;
  Var
    STR_TOTITE,
    strSQL: String;
Begin

  STR_TOTITE := ' IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), 0.00, IF( ' +
                ' LEFT(GER_CLAFIS, 1) < 5, -GER_VALSER, GER_VALSER)) ';

  strSQL := '';
  strSQL := strSQL + '  SELECT    ';
  strSQL := strSQL + '    CODVEN, ';

  if edtOpcao.Text = '3' then
    strSQL := strSQL + '    NULL AS CODVE2, ';

  strSQL := strSQL + '    IF(SUM(GER_VALSER) = 0, 0.00, IFNULL( IFNULL(SUM(GER_COMSER), 0) / (IFNULL(SUM(GER_VALSER), 0) / 100), 0)) AS PERCOM, ';
  If StrToInt(edtOpcao.Text) = 3 Then
   strSQL := strSQL + '   0.00 AS PERCO2, ';
  strSQL := strSQL + '    SUM( ' + STR_TOTITE   + ' ) AS TOTITE, ';
  strSQL := strSQL + '    0.00 AS TOTCO2, ';
  strSQL := strSQL + '    SUM(IF((ESPDOC = "BR") OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), 0.00, IF(LEFT(GER_CLAFIS, 1) < 5, -GER_COMSER, GER_COMSER))) AS TOTCOM, ';
  strSQL := strSQL + '    0.00 AS TOTREP ';

  if edtOpcao.Text = '3' then
  begin
    strSQL := strSQL + '    , 0.00 AS ITECOM, ';
    strSQL := strSQL + '    0.00 AS ITECO2 ';
  end;

  strSQL := strSQL + '  FROM ';

  strSQL := strSQL + '(SELECT ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + IfThen(edtEmpFat.Text = 'F', ' GER_CODEMP AS CODEMP, ', ' GER_EMPORI AS CODEMP, ');
  strSQL := strSQL + '  GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS NUMDOC, ';
  strSQL := strSQL + fCaseCodSer() + ' AS GER_CODSER, ';
  strSQL := strSQL + fCaseValSer() + ' AS GER_VALSER, ';
  strSQL := strSQL + fCaseComSer() + ' AS GER_COMSER, ';
  strSQL := strSQL + '  GER_CLAFIS ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + fSQLJoinBase;
  strSQL := strSQL + '    LEFT JOIN SERMOV S ON S.GER_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '    LEFT JOIN (' + fTabIdeSer + ') T ON TRUE  ';
  strSQL := strSQL + '    LEFT JOIN CADSER ON SER_CODSER = ' + fCaseIdeSer();
  strSQL := strSQL + fSQLJoinCadOpe;

  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    OPE_CODOPE = :CODVEN AND ';

  strSQL := strSQL +   fSQLFiltros(True);

  strSQL := strSQL + '  GROUP BY CODVEN, NUMDOC, GER_CODSER, IDESER ';
  strSQL := strSQL + '  HAVING IFNULL(GER_CODSER, "") <> "") AS VW_RES_ALQ_SER GROUP BY CODVEN ';

  Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);
end;

Function TfrmRelFatComVendedor.fSqlUnion: String;
Begin
  Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(fSQLRelatorio);
End;

function TfrmRelFatComVendedor.fStrTaxRep: String;
begin
  Result := AnsiReplaceStr(FloatToStrF(fltTaxRep, ffFixed,12,2),',','.');
end;

Procedure TfrmRelFatComVendedor.pResumo;
  Var
    strSQL: String;

  function fRetSQLSomaComissaoAgrupada: String;
  begin
    Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(IFNULL(TOTCOM, 0)) / (IFNULL(SUM(TOTITE), 0) / 100), 0)) AS PERCOM, ';
    Result := Result + '  SUM(IFNULL(TOTCOM, 0)) AS TOTCOM ';
    If cbxVendedor.ItemIndex = 1 Then
      Result := Result + '  ,SUM(IFNULL(TOTCO2, 0)) AS TOTCO2 ';
  end;

  function fRetColunasSelect(blnAgrupandoNotasAndServicos: Boolean=False): String;
  begin
    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + '               NOMCL2, ';
    Result := Result + '               DTAENT, ';
    Result := Result + '               ESPDOC, ';
    Result := Result + '               NUMDOC, ';
    Result := Result + '               NUMFAT, ';
    Result := Result + '               CODEMP, ';
    Result := Result + '               CODVEN, ';
    Result := Result + '               VENNOM, ';
    Result := Result + '               CODVE2, ';
    Result := Result + '               NOMVE2, ';
    Result := Result + '               CODDIG, ';
    Result := Result + '               NOMDIG, ';
    Result := Result + '               CODREP, ';
    Result := Result + '               NOMREP, ';
    Result := Result + '               SUPERV, ';
    Result := Result + '               NOMERV, ';
    Result := Result + '               NOMVEN, ';
    Result := Result + '               NOMCLI, ';
    Result := Result + '               DESGRU, ';

    Result := Result + '  SUM(QTDDOC) AS QTDDOC, ';
    {***********************************************}
    {* RELATORIO ANALITICO , DEMONSTRANDO OS ITENS *}
    {********************************************DP*}
    If edtTipo.Text = '4' Then
    Begin
      Result := Result + '             CODITE, ';
      Result := Result + '             DESITE, ';
      Result := Result + '             SIGUNI, ';
      Result := Result + '             DET_UNITAR, ';
      Result := Result + '             DET_QTDITE, ';
    End;

    Result := Result + '  SUM(TOTITENF) AS TOTITENF, ';
    Result := Result + '  SUM(TOTCOMNF) AS TOTCOMNF, ';
    Result := Result + '  SUM(TOTITETR) AS TOTITETR, ';
    Result := Result + '  SUM(TOTCOMTR) AS TOTCOMTR, ';
    Result := Result + '  SUM(TOTITEOU) AS TOTITEOU, ';
    Result := Result + '  SUM(TOTCOMOU) AS TOTCOMOU, ';

    Result := Result + '  SUM(IFNULL(TBPCOM,0)) AS TBPCOM, ';
    Result := Result + '  SUM(IFNULL(TBPCO2,0)) AS TBPCO2, ';
    Result := Result + '  SUM(IFNULL(OPECOM,0)) AS OPECOM, ';
    Result := Result + '  SUM(IFNULL(OPECO2,0)) AS OPECO2, ';
    Result := Result + '  SUM(IFNULL(ITECOM,0)) AS ITECOM, ';
    Result := Result + '  SUM(IFNULL(ITECO2,0)) AS ITECO2, ';
    Result := Result + '  SUM(IFNULL(FORCOM,0)) AS FORCOM, ';
    Result := Result + '  SUM(IFNULL(FORCO2,0)) AS FORCO2, ';
    Result := Result + '  SUM(IFNULL(CNDCOM,0)) AS CNDCOM, ';

    Result := Result + '  SUM(IFNULL(TOTITE,0)) AS TOTITE, ';
    Result := Result + '  SUM(IFNULL(QTDITE,0)) AS QTDITE, ';
    Result := Result + '  SUM(IFNULL(TOTCUS,0)) AS TOTCUS, ';
    Result := Result + '  ( SUM(IFNULL(TOTITE,0)) - SUM(IFNULL(TOTCUS,0)) ) AS RESULT, ';

    {**********************}
    { CALCULO DA MARGEM   *}
    {*******************LU*}
    If Pos(strMarMkp, '1_5_') = 0  Then
      Result := Result + ' IF(SUM(TOTITE) = 0, 0.00, IFNULL( ( ((SUM(TOTITE)/SUM(TOTCUS)) * 100) - 100 ), 0)) AS MARGEM, '
    Else
      Result := Result + ' IF(SUM(TOTITE) = 0, 0.00, IFNULL( ( ( 1 - (SUM(TOTCUS)/SUM(TOTITE))) * 100), 100)) AS MARGEM, ';

    If cbxVendedor.ItemIndex in [4,5] Then // SUPEVISOR GERAL/REGIONAL
    Begin
      If Not blnAgrupandoNotasAndServicos Then
      Begin
        Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL(SUM(OPECOM),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
        Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(OPECOM), 0)) AS TOTCOM '
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;
    End

    Else If Pos(edtOpcao.Text, '1_') > 0 Then
    Begin

      If (Not blnAgrupandoNotasAndServicos) Then
      Begin
        Case cbxVendedor.ItemIndex Of
          0,
          2: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL(IFNULL(SUM(TOTCOM),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
               Result := Result + '  IFNULL(SUM(TOTCOM), 0) AS TOTCOM ';
             End;
          1: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL(IFNULL(SUM(TOTCO2),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL(SUM(TOTCO2), 0)) AS TOTCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL(SUM(TOTCO2), 0)) AS TOTCO2 ';
             End;
          3: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL(IFNULL(SUM(TOTREP),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL(SUM(TOTREP), 0)) AS TOTCOM ';
             End;
        End;
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;

    End

    Else If ((Pos(edtOpcao.Text, '2_') > 0) Or (edtOpcao.Text = '11')) Then
    Begin

      If (Not blnAgrupandoNotasAndServicos) Then
      Begin
        Case cbxVendedor.ItemIndex Of
          0,
          2: Begin
    //           Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(OPECOM), SUM(OPECOM - OPECO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
    //           Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IF(CODVE2 IS NULL, SUM(OPECOM), SUM(OPECOM - OPECO2)) ,0)) AS TOTCOM '

               Result := Result + '  IF(                                                                                           ';
               Result := Result + '  SUM(TOTITE) = 0,                                                                              ';
               Result := Result + '  0.00,                                                                                         ';
               Result := Result + '  IF(OPECO2 <> 0.00, (IFNULL(' + fRetCampoPercom + ',0) * ' + fStrTaxRep + ' ) / 100 , IFNULL(' + fRetCampoPercom + ',0)) ';
               Result := Result + '  ) AS PERCOM,                                                                                  ';

               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(OPECOM - OPECO2) ,0)) AS TOTCOM ';
             End;
          1: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL(SUM(OPECO2),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(OPECO2), 0)) AS TOTCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(OPECO2), 0)) AS TOTCO2 ';
             End;
          3: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL(SUM(OPECOM),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(OPECOM), 0)) AS TOTCOM '
             End;
        End;
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;

    End

    Else If edtOpcao.Text = '3' Then
    Begin

      If (Not blnAgrupandoNotasAndServicos) Then
      Begin
        Case cbxVendedor.ItemIndex Of
          0,
          2: Begin
               If fUsaVen2 Then
               Begin
                 Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(ITECOM - IFNULL(ITECO2,0)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
                 Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(ITECOM - IFNULL(ITECO2,0)) ,0)) AS TOTCOM '
               End
               Else
               Begin
                 Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(ITECOM), SUM(ITECOM - ITECO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
                 Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IF(CODVE2 IS NULL, SUM(ITECOM), SUM(ITECOM - ITECO2)) ,0)) AS TOTCOM '
               End
             End;
          1: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL(SUM(ITECO2),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(ITECO2), 0)) AS TOTCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(ITECO2), 0)) AS TOTCO2 ';
             End;
          3: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL(SUM(ITECOM),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0)) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(ITECOM), 0)) AS TOTCOM '
             End;
        End;
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;

    End

    Else If edtOpcao.Text = '4' Then
    Begin

      If (Not blnAgrupandoNotasAndServicos) Then
      Begin
        Case cbxVendedor.ItemIndex Of
          0,
          2: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(FORCOM), SUM(FORCOM - FORCO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IF(CODVE2 IS NULL, SUM(FORCOM), SUM(FORCOM - FORCO2)) ,0)) AS TOTCOM '
             End;
          1: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(FORCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(FORCOM), 0)) AS TOTCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(FORCOM), 0)) AS TOTCO2 ';
             End;
          3: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(FORCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(FORCOM), 0)) AS TOTCOM '
             End;
        End;
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;

    End

    Else If (edtOpcao.Text = '5') Or (edtOpcao.Text = '12') Then
    Begin

      If (Not blnAgrupandoNotasAndServicos) Then
      Begin
        Case cbxVendedor.ItemIndex Of
          0,
          2: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(MARCOM), SUM(MARCOM - MARCO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IF(CODVE2 IS NULL, SUM(MARCOM), SUM(MARCOM - MARCO2)) ,0)) AS TOTCOM ';
             End;
          1: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(MARCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(MARCOM), 0)) AS TOTCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(MARCOM), 0)) AS TOTCO2 ';
             End;
          3: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(MARCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(MARCOM), 0)) AS TOTCOM ';
             End;
        End;
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;

    End

    Else If Pos(edtOpcao.Text, '6_9_') > 0 Then
    Begin

      If (Not blnAgrupandoNotasAndServicos) Then
      Begin
        Case cbxVendedor.ItemIndex Of
          0,
          2: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(DESCOM), SUM(DESCOM - DESCO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IF(CODVE2 IS NULL, SUM(DESCOM), SUM(DESCOM - DESCO2)) ,0)) AS TOTCOM  '
             End;
          1: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(DESCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(DESCOM), 0)) AS TOTCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(DESCOM), 0)) AS TOTCO2 ';
             End;
          3: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(DESCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(DESCOM), 0)) AS TOTCOM  '
             End;
        End;
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;

    End

    Else If edtOpcao.Text = '7' Then
    Begin

      If (Not blnAgrupandoNotasAndServicos) Then
      Begin
        Case cbxVendedor.ItemIndex Of
          0,
          2: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(IFNULL( IF(CODVE2 IS NULL, TBPCOM, TBPCOM - TBPCO2) ,0)) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, SUM(IFNULL(TBPCOM,0) - IFNULL(TBPCO2, 0))) AS TOTCOM '
             End;
          1: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(TBPCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(TBPCOM), 0)) AS TOTCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(TBPCOM), 0)) AS TOTCO2 ';
             End;
          3: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(TBPCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(TBPCOM), 0)) AS TOTCOM '
             End;
        End;
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;

    End

    Else If (edtOpcao.Text = '8') Or (edtOpcao.Text = '13') Then
    Begin

      If (Not blnAgrupandoNotasAndServicos) Then
      Begin
        Case cbxVendedor.ItemIndex Of
          0,
          2: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(LUCCOM), SUM(LUCCOM - LUCCO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IF(CODVE2 IS NULL, SUM(LUCCOM), SUM(LUCCOM - LUCCO2)) ,0)) AS TOTCOM '
             End;
          1: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(LUCCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(LUCCOM), 0)) AS TOTCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(LUCCOM), 0)) AS TOTCO2 ';
             End;
          3: Begin
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( IFNULL( SUM(LUCCOM), 0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )) AS PERCOM, ';
               Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, IFNULL( SUM(LUCCOM), 0)) AS TOTCOM '
             End;
        End;
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;

    End
    Else If edtOpcao.Text = '10' Then
    Begin

      If (Not blnAgrupandoNotasAndServicos) Then
      Begin
        Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, SUM(IFNULL(CNDCOM, 0)) / SUM(IFNULL(TOTITE, 0) / 100 )) AS PERCOM, ';
        Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, SUM(IFNULL(CNDCOM, 0))) AS TOTCOM,  ';
        Result := Result + '  IF(SUM(TOTITE) = 0, 0.00, SUM(IFNULL(CNDCOM, 0))) AS TOTCO2  '
      End
      Else
      Begin
        Result := Result + fRetSQLSomaComissaoAgrupada;
      End;

    End;
  end;
Begin

  If fTemRegSerMov Then
  Begin
    strSQL := fRetColunasSelect;
    strSQL := strSQL + 'FROM ( '+fSqlUnion+' ) AS VW_FAT ';
    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + fCamposGrupo;

    strSQL := strSQL + ' UNION ALL ' + fSqlServico();

    strSQL := fRetColunasSelect(True)+' FROM ( '+strSQL+' ) AS VW_FAT_E_SER ';
    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + fCamposGrupo;
    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + fCamposOrdem;
  End
  Else
  Begin
    strSQL := fRetColunasSelect;
    strSQL := strSQL + 'FROM ( '+fSqlUnion+' ) AS VW_FAT ';
    strSQL := strSQL + ' GROUP BY    ';
    strSQL := strSQL + fCamposGrupo;
    strSQL := strSQL + ' ORDER BY    ';
    strSQL := strSQL + fCamposOrdem;
  End;

  pAbreClient(cdsRelat, qryRelat, dspRelat, strSQL);

End;

procedure TfrmRelFatComVendedor.pRetiraDescFF(Var strSQLAux: String);
begin
  If blnIgnorarNaBaseCalculoDescontoDadoEmConfirmacao Then
  Begin
    strSQLAux := AnsiReplaceStr(strSQLAux, 'DET_DESCFF', '0.00');
  End;
  strSQLAux := AnsiReplaceStr(strSQLAux, 'COL_DESCFF', 'DET_DESCFF');
end;

procedure TfrmRelFatComVendedor.pAbreClient(cdsDados: TUniClientDataSet;
                                            qryDados: TUniQuery;
                                            dspDados: TUniDataSetProvider;
                                            strSQL: String);
Begin
  With qryDados Do
  Begin
    Close;
    cdsDados.Close;

    SQL.Clear;

    pRetiraDescFF(strSQL);

    SQL.Add(strSQL);

    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;

    If cmbTipVen.ItemIndex <> VEN_TODOS Then
      Case cmbTipVen.ItemIndex Of
        VEN_INTERNO        : ParamByName('TIPVEN').AsString := 'I';
        VEN_EXTERNO_LOJA   : ParamByName('TIPVEN').AsString := 'E';
        VEN_EXTERNO_DISTRIB: ParamByName('TIPVEN').AsString := 'D';
      End;

    pSetaParam(edtCodDep.Text,arrDep, strDep,'CODDEP', qryDados);
    pSetaParam(edtCodDepProd.Text,arrDepProd, strDepProd,'CODDEPPROD', qryDados);
    pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', qryDados);
    pSetaParam(edtCodEmpresa.Text,arrEmp, strEmp,'CODEMP', qryDados);
    pSetaParam(edtCodAti.Text,arrAtividade,strAtivid,'CODATI', qryDados);
    pSetaParam(edtCodCnd.Text,arrCnd,strCnd,'CODCND', qryDados);
    pSetaParam(edtCodCli.Text,arrCliente,strCodCli,'CODCLI',qryDados);
    pSetaParam(edtCliExc.Text,arrCliExc,strCliExc,'CLIEXC',qryDados);
    pSetaParam(edtCodFor.Text,arrFor,strFor,'CODFOR',qryDados);
    pSetaParam(edtCodPro.Text, arrPro, strPro, 'CODITE', qryDados);
    pSetaParam(edtCodMarca.Text, arrMar, strMar, 'CODMAR', qryDados);

    If (Not fEmptyStr(edtCodGer.Text)) Then
    Begin
      If (blnLibGer) Then
        pSetaParam(edtCodGer.Text, arrGer, strGer, 'CODGER', qryDados)
      Else
        ParamByName('CODGER').AsString := fRetCodVendedor(edtCodGer.Text);
    End;

    If (Not fEmptyStr(edtCodSubGer.Text)) Then
    Begin
      If (blnLibSub) Then
        pSetaParam(edtCodSubGer.Text, arrSubGer, strSubGer, 'CODSUB', qryDados)
      Else
        ParamByName('CODSUB').AsString := fRetCodVendedor(edtCodSubGer.Text);
    End;

    If (Not fEmptyStr(edtCodVendedor.Text)) Then
    Begin
      If (blnLibVen) Then
        pSetaParam(edtCodVendedor.Text, arrOperador, strOperador, 'CODVEN', qryDados)
      Else
        ParamByName('CODVEN').AsString := fRetCodVendedor(edtCodVendedor.Text);
    End;

    Open;
    pSetaClient(qryDados);

    cdsDados.SetProvider(dspDados);
    cdsDados.Open;

    pSetaClient(cdsDados);
  End;
End;

Procedure TfrmRelFatComVendedor.pCriaClientFaixas;
Begin
  cdsFaixa := TUniClientDataSet.Create(Self);
  
  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODVEN';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOMVEN';
    DataType := ftString;
    Size     := 30;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODCOM';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESFAI';
    DataType := ftString;
    Size     := 30;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MARINI';
    DataType := ftFloat;
    Precision:= 2;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MARFIN';
    DataType := ftFloat;
    Precision:= 2;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VLRVEN';
    DataType := ftFloat;
    Precision:= 2;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VLRCOM';
    DataType := ftFloat;
    Precision:= 2;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PERCOM';
    DataType := ftFloat;
    Precision:= 2;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VLRCUS';
    DataType := ftFloat;
    Precision:= 2;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MARVEN';
    DataType := ftFloat;
    Precision:= 2;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TAXREP';
    DataType := ftFloat;
    Precision:= 2;
  End;

  With cdsFaixa.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TIPPAG';
    DataType := ftString;
    Size     := 1;
  End;

  cdsFaixa.CreateDataSet;
  cdsFaixa.IndexFieldNames := 'CODVEN;DESFAI';
End;

procedure TfrmRelFatComVendedor.pAddFaixasNaoInclusas;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    i: Integer;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := ' SELECT * FROM CADCOM ORDER BY COM_CODCOM ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      First;

      prbProgresso.Max      := RecordCount;
      prbProgresso.Position := 0;
      Application.ProcessMessages;

      While Not EOF Do
      Begin
        prbProgresso.StepBy(1);
        Application.ProcessMessages;
        
        For i := 1 To stlVendedor.Count Do
        Begin
          With cdsFaixa do
          Begin
            Filtered := False;
            Filter   := ' CODVEN = ' + stlVendedor.Strings[i-1] + ' AND ' +
                        ' CODCOM = ' + qryGen.FieldByName('COM_CODCOM').AsString;
            Filtered := True;

            If IsEmpty Then
            Begin
              Insert;
              FieldByName('CODVEN').AsString := stlVendedor.Strings[i-1];
              FieldByName('NOMVEN').AsString := fRetNomVendRep(stlVendedor.Strings[i-1]);
              FieldByName('CODCOM').AsString := qryGen.FieldByName('COM_CODCOM').AsString;
              FieldByName('DESFAI').AsString := qryGen.FieldByName('COM_DESCOM').AsString;
              FieldByName('MARINI').AsFloat  := qryGen.FieldByName('COM_PERINI').AsFloat;
              FieldByName('MARFIN').AsFloat  := qryGen.FieldByName('COM_PERFIN').AsFloat;
              FieldByName('PERCOM').AsFloat  := qryGen.FieldByName('COM_PERCOM').AsFloat;
              FieldByName('MARVEN').AsFloat  := 0.00;
              FieldByName('TAXREP').AsFloat  := 0.00;
              FieldByName('TIPPAG').AsString := '';
              FieldByName('VLRVEN').AsFloat  := 0.00;
              FieldByName('VLRCUS').AsFloat  := 0.00;
              FieldByName('VLRCOM').AsFloat  := 0.00;
              Post;
            End;
          End;
        End;

        Next;
      End;

      cdsFaixa.Filtered := False;
      prbProgresso.Position := 0;      
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmRelFatComVendedor.pAddResumoPorFaixa(strCodVen,
                                                   strConPag: String;
                                                   fltMargem,
                                                   fltVlrVen,
                                                   fltVlrCus,
                                                   fltTaxRep:Double);
  Var
    strCodCom,
    strDesFai,
    strNomVen: String;

    fltMarIni,
    fltMarFin,
    fltPerCom: Double;

    i: Integer;

    blnInserir: Boolean;

  procedure pRetDadosFaixa(fltMarVen:Double);
    Var
      strSQL: String;
      qryGen: TUniQuery;
  Begin
    Try
      qryGen := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCOM ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  :VALOR >= COM_PERINI AND ';
      strSQL := strSQL + '  :VALOR <= COM_PERFIN ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('VALOR').AsFloat := RoundTo(fltMarVen, -2);
        Open;

        If Not IsEmpty Then
        Begin
          If (fStatusCndPag(strConPag) = A_VISTA) Then
            fltPerCom := FieldByName('COM_PERCOM').AsFloat
          Else
            fltPerCom := FieldByName('COM_PERCOP').AsFloat;

          fltMarIni := FieldByName('COM_PERINI').AsFloat;
          fltMarFin := FieldByName('COM_PERFIN').AsFloat;
          strCodCom := FieldByName('COM_CODCOM').AsString;
          strDesFai := FieldByName('COM_DESCOM').AsString;
        End
        Else
        Begin
          fltPerCom := 0.00;
          fltMarIni := 0.00;
          fltMarFin := 0.00;
          strCodCom := '';
          strDesFai := 'FORA DA FAIXA';
        End;

        Close;
      End;

    Finally
      FreeAndNil(qryGen);
    End;
  End;

begin
  fltMarIni := 0.00;
  fltMarFin := 0.00;
  strCodCom := EmptyStr;
  strDesFai := EmptyStr;
  strNomVen := EmptyStr;

  Try

    If Not Assigned(cdsFaixa) Then
      pCriaClientFaixas;

    With cdsFaixa Do
    Begin
      strNomVen := fRetNomVendRep(strCodVen);
      pRetDadosFaixa(fltMargem);

      If (Locate('CODVEN;CODCOM;PERCOM;TAXREP', VarArrayOf([strCodVen, strCodCom, fltPerCom, fltTaxRep]), [])) Then
        Edit
      Else
      Begin
        Insert;
        FieldByName('CODVEN').AsString := strCodVen;
        FieldByName('NOMVEN').AsString := strNomVen;
        FieldByName('CODCOM').AsString := strCodCom;
        FieldByName('DESFAI').AsString := strDesFai;
        FieldByName('MARINI').AsFloat  := fltMarIni;
        FieldByName('MARFIN').AsFloat  := fltMarFin;
        FieldByName('PERCOM').AsFloat  := fltPerCom;
        FieldByName('MARVEN').AsFloat  := fltMargem;
        FieldByName('TAXREP').AsFloat  := fltTaxRep;

        If (fStatusCndPag(strConPag) = A_VISTA) Then
          FieldByName('TIPPAG').AsString := 'V'
        Else
          FieldByName('TIPPAG').AsString := 'P';
      End;

      FieldByName('VLRVEN').AsFloat := FieldByName('VLRVEN').AsFloat + fltVlrVen;
      FieldByName('VLRCUS').AsFloat := FieldByName('VLRCUS').AsFloat + fltVlrCus;

      if (fltTaxRep > 0) then
        FieldByName('VLRCOM').AsFloat := FieldByName('VLRCOM').AsFloat + ((fltVlrVen * fltPerCom) / 100) * (fltTaxRep/100)
      Else
        FieldByName('VLRCOM').AsFloat := FieldByName('VLRCOM').AsFloat + ((fltVlrVen * fltPerCom) / 100);

      Post;

      blnInserir := True;

      If stlVendedor.Count > 0 Then
      Begin
        For i := 1 To stlVendedor.Count Do
        Begin
          If strCodVen = stlVendedor.Strings[i-1] Then
            blnInserir := False;
        End;
      End;

      If blnInserir Then stlVendedor.Add(strCodVen);
    End;

  Except
    On E: ExceptionAutCom Do
      fMensagem('',E.Message, ['&Ok']);
  End;
end;

procedure TfrmRelFatComVendedor.pHabilitaOpcoesPDF;
begin
  chkEjeVen.Enabled := (Pos(edtTipo.Text, '4_1_') > 0) And (Not chkPDFVen.Checked);
  If (Not chkEjeVen.Enabled) Then
    chkEjeVen.Checked := False;

  chkPDFVen.Enabled := (Pos(edtTipo.Text, '4_1_') > 0);
  If (Not chkPDFVen.Enabled) Then
    chkPDFVen.Checked := False;

  edtDirPDF.Enabled := (Pos(edtTipo.Text, '4_1_') > 0) And (chkPDFVen.Checked);
  If (Not edtDirPDF.Enabled) Then
    edtDirPDF.Clear;

  btnDirPDF.Enabled := edtDirPDF.Enabled;
end;

Function TfrmRelFatComVendedor.fCodVen(strOrdem: String): String;
Begin
  If strOrdem = '1' Then
  Begin
    Case cbxVendedor.ItemIndex Of
      0: Result := ' CODVEN ';
      1: Result := ' CODVE2 ';
      2: Result := ' CODDIG ';
      3: Result := ' CODREP ';
      4,
      5: Result := ' SUPERV ';
    End;
  End
  Else If strOrdem = '2' Then
  Begin
    Result := ' NUMDOC ';
  End
  Else If strOrdem = '3' Then
  Begin
    Case cbxVendedor.ItemIndex Of
      0: Result := ' VENNOM ';
      1: Result := ' NOMVE2 ';
      2: Result := ' NOMDIG ';
      3: Result := ' NOMREP ';
      4,
      5: Result := ' NOMERV ';
    End;
  End;
End;

Function  TfrmRelFatComVendedor.fCamposGrupo: String;
Begin
  Result := '';
  Case edtTipo.Text[1] Of
    '1': If SameText(edtOpcAgru.Text, 'L') Then
           Result := ' CODVEN, DESGRU '
         Else If SameText(edtOpcAgru.Text, 'C') Then
           Result := ' CODVEN, NOMCLI '
         Else
           Result := ' CODVEN, NUMDOC, CODEMP ';

    '2': Result := fCodVen(edtOrdem.Text);
    '3': Result := fCodVen(edtOrdem.Text) + ', DTAENT';
    '4': Result := fCodVen(edtOrdem.Text) + ', NUMDOC, CODITE';
  End;

End;

Function  TfrmRelFatComVendedor.fCamposOrdem: String;
Begin

  Case edtTipo.Text[1] Of
    '1': If edtOrdem.Text = '2' Then
           Result := ' NUMDOC, ' + fCodVen(edtOrdem.Text) + ', NOMCL2, DTAENT '
         Else
           Result := fCodVen(edtOrdem.Text) + ', NOMCL2, NUMDOC, DTAENT  ';

    '2': If edtOrdem.Text = '2' Then
           Result := ' NUMDOC '
         Else
           Result := fCodVen(edtOrdem.Text);

    '3': If edtOrdem.Text = '2' Then
           Result := fCodVen(edtOrdem.Text) + ', NUMDOC, DTAENT '
         Else
           Result := fCodVen(edtOrdem.Text) + ', DTAENT ';

    '4': If edtOrdem.Text = '2' Then
           Result := fCodVen(edtOrdem.Text) + ', NUMDOC, DTAENT, CODITE '
         Else
           Result := fCodVen(edtOrdem.Text) + ', NUMDOC, DTAENT, CODITE '
  End;

End;


Function TfrmRelFatComVendedor.fRetQtdDoc(strCodVen: String): Integer;
Begin
  With cdsQtdVen Do
  If Locate('CODVEN', strCodVen, []) Then
    Result := FieldByName('QTDDOC').AsInteger
  Else
    Result := 0;
End;

procedure TfrmRelFatComVendedor.pIncluiQtdVendedor(strCodVen: String;
                                                   intQtdDoc: Integer);
Begin
  With cdsQtdVen Do
  Begin
    Insert;               
    FieldByName('CODVEN').AsString  := strCodVen;
    FieldByName('QTDDOC').AsInteger := intQtdDoc;
    Post;
  End;
End;

procedure TfrmRelFatComVendedor.pAtualizaMargem;
  Var
    blnParticiona,
    blnPromo: Boolean;
    fltQtdDis,
    fltDesF07,
    fltPreCus,
    fltPreVen,
    fltComVar,
    fltComAta,
    fltComDis,
    fltUnitLiquido,
    fltTotIteLiq,
    fltPercDesconto: Double;
    fltTaxRep,
    fltTaxCom,
    fltFaiCom,
    fltPerCom: Double;
    strPRZPRO: String;
    strENTBRF: String;
    //strPmcPro: String;
    intDecUni: Integer;
    intQtdDoc: Integer;
    strVenAnt: String;
    strDocAnt: String;
    fltPorCom: Double;
    fltFatorTaxRep: Double;
    fltCusMBr: Double;
    strComPro: String;
Begin
  fltTaxRep := fCfgSis('TAXREP', varDouble);
  strPRZPRO := fCfgSis('PRZPRO');
  strENTBRF := fCfgSis('ENTBRF');
  strPmcPro := fCfgSis('PCMPRO');
  intDecUni := fCfgSis('DECUNI', varInteger);

  With cdsRelat Do
  Begin
    IndexFieldNames := 'CODVEN;NUMDOC';

    prbProgresso.Max := RecordCount;
    prbProgresso.Position := 0;
    Application.ProcessMessages;

    cdsQtdVen.EmptyDataSet;
    intQtdDoc := 0;
    strVenAnt := '';
    strDocAnt := '';

    First;

    While Not Eof Do
    Begin

      If strVenAnt <> FieldByName(Trim(fCodVen('1'))).AsString Then
      Begin
        If Not fEmptyStr(strVenAnt) Then
          pIncluiQtdVendedor(strVenAnt, intQtdDoc);

        intQtdDoc := 0;
      End;

      If strDocAnt <> FieldByName('NUMDOC').AsString Then
        Inc(intQtdDoc);

      strVenAnt := FieldByName(Trim(fCodVen('1'))).AsString;
      strDocAnt := FieldByName('NUMDOC').AsString;

      Edit;

      fltTaxCom := 0;
      If (edtOpcao.Text = '12') Then
      Begin
        fltFatorTaxRep := IfThen(cbxVendedor.ItemIndex = 1, 0, 1);

        If FieldByName('CODVE2').IsNull Then
          fltTaxCom := 0
        Else If (cbxVendedor.ItemIndex = 0) Then
          fltTaxCom := 100 - fltTaxRep
        Else If (cbxVendedor.ItemIndex = 1) Then
          fltTaxCom := fltTaxRep;

        If (fltTaxCom > 0) Then
          fltFatorTaxRep := (fltTaxCom / 100);

        fltPorCom := fRetPerComOpeMargem(FieldByName('TOTCUS').AsFloat, FieldByName('TOTITE').AsFloat, FieldByName(Trim(fCodVen('1'))).AsString) * fltFatorTaxRep;

        If (Pos(edtTipo.Text,'3_4_') > 0) Then
          FieldByName('PERCOM').AsFloat   := fltPorCom
        Else
          FieldByName('MARCOM').AsFloat   := fltPorCom;

        FieldByName('TOTCOM').AsFloat   := (fltPorCom * FieldByName('TOTITE').AsFloat) / 100;

        If (Pos(FieldByName('ESPDOC').AsString, 'NF_EL_IF_IV_D1_') > 0) And (LeftStr(FieldByName('DET_CLAFIS').AsString, 1) >= '5') Then
          FieldByName('TOTCOMNF').AsFloat := (fltPorCom * FieldByName('TOTITE').AsFloat) / 100

        Else If (Pos(FieldByName('ESPDOC').AsString, 'TR_DV_PD_') > 0) Or ((Pos(FieldByName('ESPDOC').AsString, 'NF_EL_IF_IV_D1_') > 0) And (LeftStr(FieldByName('DET_CLAFIS').AsString,1) < '5')) Then
          FieldByName('TOTCOMTR').AsFloat := (fltPorCom * FieldByName('TOTITE').AsFloat) / 100

        Else
          FieldByName('TOTCOMOU').AsFloat := (fltPorCom * FieldByName('TOTITE').AsFloat) / 100;

        If FieldByName('CODVE2').IsNull Then
          FieldByName('MARCO2').AsFloat := 0
        Else
          FieldByName('MARCO2').AsFloat := fRetPerComOpeMargem(FieldByName('TOTCUS').AsFloat, FieldByName('TOTITE').AsFloat, FieldByName('CODVE2').AsString) * fltFatorTaxRep;
      End
      Else
      Begin 
        FieldByName('MARCOM').AsFloat   := (fRetPerComMargem(fCalculaPrecoVenda(2,FieldByName('TOTCUS').AsFloat, FieldByName('TOTITE').AsFloat,0,0,0,0,0, strMarMkp, strPmcPro, intDecUni),'',IfThen(fCfgSis('USACND',varBoolean),fRetConPag(FieldByName('CODCND').AsString),FieldByName('CONPAG').AsString)) * (FieldByName('TOTITE').AsFloat - FieldByName('DET_DESCFF').AsFloat)) / 100;

        If FieldByName('CODVE2').IsNull Then
          FieldByName('MARCO2').AsFloat := 0
        Else
          FieldByName('MARCO2').AsFloat := (((fRetPerComMargem(fCalculaPrecoVenda(2,FieldByName('TOTCUS').AsFloat, FieldByName('TOTITE').AsFloat,0,0,0,0,0, strMarMkp, strPmcPro, intDecUni),'',IfThen(fCfgSis('USACND',varBoolean),fRetConPag(FieldByName('CODCND').AsString),FieldByName('CONPAG').AsString)) * (FieldByName('TOTITE').AsFloat - FieldByName('DET_DESCFF').AsFloat)) / 100) * fltTaxRep) / 100;
      End;

      If (chkCadCom.Visible And chkCadCom.Checked) Then
      Begin
        If FieldByName('CODVE2').IsNull Then
          fltTaxCom := 0
        Else If (cbxVendedor.ItemIndex = 0) Then
          fltTaxCom := 100 - fltTaxRep
        Else If (cbxVendedor.ItemIndex = 1) Then
          fltTaxCom := fltTaxRep;

        pAddResumoPorFaixa(FieldByName(Trim(fCodVen('1'))).AsString,
                           IfThen(fCfgSis('USACND',varBoolean),fRetConPag(FieldByName('CODCND').AsString),FieldByName('CONPAG').AsString),
                           fCalculaPrecoVenda(2,FieldByName('TOTCUS').AsFloat, FieldByName('TOTITE').AsFloat,0,0,0,0,0, strMarMkp, strPmcPro, intDecUni),
                           FieldByName('TOTITE').AsFloat,
                           FieldByName('TOTCUS').AsFloat,
                           fltTaxCom);
      End;

      {*****************************************}
      {* CALCULA O PERCENTUAL DE DESCONTO.     *}
      {**************************************MV*}
      fltPreCus := 0.0;
      fltPreVen := 0.0;
      fltComVar := 0.0;
      fltComAta := 0.0;
      fltComDis := 0.0;

      fltTotIteLiq := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat - FieldByName('DET_DESCFF').AsFloat) * IfThen(LeftStr(FieldByName('CLAFIS').AsString, 1) < '5', -1, 1);

      {*****************************************}
      {* CALCULA O PERCENTUAL DE DESCONTO.     *}
      {**************************************MV*}

      If FieldByName('DET_QTDITE').AsFloat <> 0 Then
        fltUnitLiquido := Abs(fltTotIteLiq) / FieldByName('DET_QTDITE').AsFloat
      Else
        fltUnitLiquido := 0;

      If FieldByName('DET_UNIORI').AsFloat <> 0 Then
        fltPercDesconto := ((FieldByName('DET_UNIORI').AsFloat - fltUnitLiquido) / FieldByName('DET_UNIORI').AsFloat) * 100
      Else
        fltPercDesconto := 0;

      fltPercDesconto := fFormataFloat(fltPercDesconto, 2);

      fltFaiCom := fRetPerComMargem(fltPercDesconto, FieldByName('OPE_INTEXT').AsString, IfThen(fCfgSis('USACND',varBoolean),fRetConPag(FieldByName('CODCND').AsString),FieldByName('CONPAG').AsString));

      If edtOpcao.Text = '9' Then
      Begin
        If (untCadPro.fRetornaPrecosPromocao(FieldByName('CODITE').AsString,
                                  FieldByName('CODCLI').AsString ,
                                  IfThen(FieldByName('DTAENT').IsNull, 0, FieldByName('DTAENT').AsDateTime),
                                  FieldByName('DET_QTDITE').AsFloat,
                                  0.0,
                                  0.0,
                                  0,
                                  fltPreCus,
                                  fltPreVen,
                                  fltComVar,
                                  fltComAta,
                                  fltComDis,
                                  fltQtdDis,
                                  fltDesF07,
                                  strComPro,
                                  strTeste,
                                  blnParticiona,
                                  blnPromo,
                                  FieldByName('TABPRE').AsString,
                                  '',
                                  strPRZPRO,
                                  strEntBrf,
                                  True,
                                  False,
                                  '-1',
                                  ((FieldByName('ENTFAT').AsString = 'S') And (FieldByName('ENTFUT').AsString = 'N')),
                                  ((FieldByName('ENTFAT').AsString = 'S') And (FieldByName('ENTFUT').AsString = 'S')),
                                  FieldByName('MOTFUT').AsString,
                                  '',
                                  '',
                                  '',
                                  nil,
                                  False,
                                  False
                                  ) )  Then
        Begin
          If (FieldByName('OPE_INTEXT').AsString = 'E') Then
            fltPerCom := fltComAta
          Else If (FieldByName('OPE_INTEXT').AsString = 'I') Then
            fltPerCom := fltComVar
          Else
            fltPerCom := fltComDis;
        End
        Else
        Begin
          If (FieldByName('OPE_INTEXT').AsString = 'E') Then
            fltPerCom := FieldByName('ITE_COMATA').AsFloat
          Else If (FieldByName('OPE_INTEXT').AsString = 'I') Then
            fltPerCom := FieldByName('ITE_COMVAR').AsFloat
          Else
            fltPerCom := FieldByName('ITE_COMDIS').AsFloat;
        End;

        fltPerCom := fltPerCom - (fltPerCom * (fltFaiCom / 100));

        FieldByName('DESCOM').AsFloat  := ( ( (fltPerCom  * fltTotIteLiq ) / 100 ) );

        If FieldByName('CODVE2').IsNull Then
          FieldByName('DESCO2').AsFloat := 0
        Else
          FieldByName('DESCO2').AsFloat  := ( ( (fltPerCom  * fltTotIteLiq ) / 100 ) * fltTaxRep) / 100;

      End
      Else
      Begin

        FieldByName('DESCOM').AsFloat  := ( ( ( fltFaiCom * fltTotIteLiq ) / 100 ) );

        If FieldByName('CODVE2').IsNull Then
          FieldByName('DESCO2').AsFloat := 0
        Else
          FieldByName('DESCO2').AsFloat  := ( ( ( fltFaiCom * fltTotIteLiq ) / 100 ) * fltTaxRep) / 100;

      End;

      If FieldByName('DET_UNITAR').AsFloat <> 0 Then
      Begin
        If (edtOpcao.Text <> '13') Then
          fltCusMBr := 0
        Else
          fltCusMBr := fCalculaPrecoCustoItem(FieldByName('DET_UNIORI').AsFloat, FieldByName('QTDITE').AsFloat, FieldByName('CODITE').AsString,
            FieldByName('CODEMP').AsString, FieldByName('NUMDOC').AsString, FieldByName('ESPDOC').AsString, FieldByName('CODCLI').AsString);

        If (edtOpcao.Text <> '13') Then Begin
          FieldByName('LUCCOM').AsFloat    := fFormataFloat(((fRetPerComLucro(IfThen(FieldByName('DET_UNITAR').AsFloat = 0, 0, FieldByName('DET_TOTITE').AsFloat / FieldByName('DET_UNITAR').AsFloat), FieldByName('DET_UNIORI').AsFloat, FieldByName('TOTCUS').AsFloat, FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat, FieldByName('ITE_COMVAR').AsFloat, 0, strMarMkp, strPmcPro, intDecUni) * fltTotIteLiq / 100)), 2);

          FieldByName('LUCCOMNF').AsFloat  := fFormataFloat(((fRetPerComLucro(IfThen(FieldByName('DET_UNITAR').AsFloat = 0, 0, FieldByName('DET_TOTITE').AsFloat / FieldByName('DET_UNITAR').AsFloat), FieldByName('DET_UNIORI').AsFloat, FieldByName('TOTCUS').AsFloat, FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat, FieldByName('ITE_COMVAR').AsFloat, 0, strMarMkp, strPmcPro, intDecUni) * fltTotIteLiq / 100)), 2);

          FieldByName('LUCCOMTR').AsFloat  := fFormataFloat(((fRetPerComLucro(IfThen(FieldByName('DET_UNITAR').AsFloat = 0, 0, FieldByName('DET_TOTITE').AsFloat / FieldByName('DET_UNITAR').AsFloat), FieldByName('DET_UNIORI').AsFloat, FieldByName('TOTCUS').AsFloat, FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat, FieldByName('ITE_COMVAR').AsFloat, 0, strMarMkp, strPmcPro, intDecUni) * fltTotIteLiq / 100)), 2);
        End Else Begin
          FieldByName('LUCCOM').AsFloat    := fFormataFloat(((fRetPerComLucro(IfThen(FieldByName('DET_UNITAR').AsFloat = 0, 0, FieldByName('DET_TOTITE').AsFloat / FieldByName('DET_UNITAR').AsFloat), FieldByName('DET_UNIORI').AsFloat, fltCusMBr, FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat, FieldByName('ITE_COMVAR').AsFloat, FieldByName('TOTCUS').AsFloat, strMarMkp, strPmcPro, intDecUni) * fltTotIteLiq / 100)), 2);

          FieldByName('LUCCOMNF').AsFloat  := fFormataFloat(((fRetPerComLucro(IfThen(FieldByName('DET_UNITAR').AsFloat = 0, 0, FieldByName('DET_TOTITE').AsFloat / FieldByName('DET_UNITAR').AsFloat), FieldByName('DET_UNIORI').AsFloat, fltCusMBr, FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat, FieldByName('ITE_COMVAR').AsFloat, FieldByName('TOTCUS').AsFloat, strMarMkp, strPmcPro, intDecUni) * fltTotIteLiq / 100)), 2);

          FieldByName('LUCCOMTR').AsFloat  := fFormataFloat(((fRetPerComLucro(IfThen(FieldByName('DET_UNITAR').AsFloat = 0, 0, FieldByName('DET_TOTITE').AsFloat / FieldByName('DET_UNITAR').AsFloat), FieldByName('DET_UNIORI').AsFloat, fltCusMBr, FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat, FieldByName('ITE_COMVAR').AsFloat, FieldByName('TOTCUS').AsFloat, strMarMkp, strPmcPro, intDecUni) * fltTotIteLiq / 100)), 2);
        End;

        If FieldByName('CODVE2').IsNull Then
          FieldByName('LUCCO2').AsFloat  := 0
        Else
          If (edtOpcao.Text <> '13') Then
            FieldByName('LUCCO2').AsFloat  := ((fRetPerComLucro(IfThen(FieldByName('DET_UNITAR').AsFloat= 0, 0, FieldByName('DET_TOTITE').AsFloat / FieldByName('DET_UNITAR').AsFloat), IfThen(StrToInt(LeftStr(FieldByName('DET_CLAFIS').AsString,1)) < 5, -FieldByName('DET_UNIORI').AsFloat, FieldByName('DET_UNIORI').AsFloat), FieldByName('TOTCUS').AsFloat, IfThen(StrToInt(LeftStr(FieldByName('DET_CLAFIS').AsString,1)) < 5, -FieldByName('DET_TOTITE').AsFloat, FieldByName('DET_TOTITE').AsFloat) - FieldByName('DET_DESESP').AsFloat, FieldByName('ITE_COMVAR').AsFloat, 0, strMarMkp, strPmcPro, intDecUni) * fltTotIteLiq / 100) * fltTaxRep) / 100
          Else
            FieldByName('LUCCO2').AsFloat  := ((fRetPerComLucro(IfThen(FieldByName('DET_UNITAR').AsFloat= 0, 0, FieldByName('DET_TOTITE').AsFloat / FieldByName('DET_UNITAR').AsFloat), IfThen(StrToInt(LeftStr(FieldByName('DET_CLAFIS').AsString,1)) < 5, -FieldByName('DET_UNIORI').AsFloat, FieldByName('DET_UNIORI').AsFloat), fltCusMBr, IfThen(StrToInt(LeftStr(FieldByName('DET_CLAFIS').AsString,1)) < 5, -FieldByName('DET_TOTITE').AsFloat, FieldByName('DET_TOTITE').AsFloat) -  FieldByName('DET_DESESP').AsFloat, FieldByName('ITE_COMVAR').AsFloat, FieldByName('TOTCUS').AsFloat, strMarMkp, strPmcPro, intDecUni) * fltTotIteLiq / 100) * fltTaxRep) / 100;

        If (edtOpcao.Text = '8') Or (edtOpcao.Text = '13') Then
        Begin
          If (Pos(FieldByName('ESPDOC').AsString, 'NF_EL_IF_IV_D1_') > 0) Then
          Begin
            FieldByName('LUCCOMNF').AsFloat := FieldByName('LUCCOMNF').AsFloat - FieldByName('LUCCO2').AsFloat;
            FieldByName('TOTCOMNF').AsFloat := FieldByName('LUCCOMNF').AsFloat;
          End
          Else If (Pos(FieldByName('ESPDOC').AsString, 'TR_DV_PD_') > 0) Then
          Begin
            FieldByName('LUCCOMTR').AsFloat := FieldByName('LUCCOMTR').AsFloat - FieldByName('LUCCO2').AsFloat;
            FieldByName('TOTCOMTR').AsFloat := FieldByName('LUCCOMTR').AsFloat;
          End
          Else
          Begin
            //FieldByName('LUCCOM').AsFloat   := FieldByName('LUCCOM').AsFloat   - FieldByName('LUCCO2').AsFloat;
            FieldByName('TOTCOMOU').AsFloat := FieldByName('LUCCOM').AsFloat - FieldByName('LUCCO2').AsFloat;
          End;
        End;
      End
      Else
      Begin
        FieldByName('LUCCOM').AsFloat  := 0;

        If FieldByName('CODVE2').IsNull Then
          FieldByName('LUCCO2').AsFloat  := 0
        Else
          FieldByName('LUCCO2').AsFloat  := 0;
      End;

      If (edtOpcao.Text <> '12') And (edtOpcao.Text <> '8') And (edtOpcao.Text <> '13') Then
      Begin
        if (edtTipo.Text = '2') and (edtOpcao.Text = '6') and (cbxVendedor.ItemIndex = 0) then
        begin
          If (Pos(FieldByName('ESPDOC').AsString, 'NF_EL_IF_IV_D1_') > 0) And (LeftStr(FieldByName('DET_CLAFIS').AsString, 1) >= '5') Then
            FieldByName('TOTCOMNF').AsFloat := FieldByName('DESCOM').AsFloat - FieldByName('DESCO2').AsFloat

          Else If (Pos(FieldByName('ESPDOC').AsString, 'TR_DV_PD_') > 0) Then
            FieldByName('TOTCOMTR').AsFloat := FieldByName('DESCOM').AsFloat - FieldByName('DESCO2').AsFloat

          Else
            FieldByName('TOTCOMOU').AsFloat := FieldByName('DESCOM').AsFloat - FieldByName('DESCO2').AsFloat;
        end
        else
        begin
          If (Pos(FieldByName('ESPDOC').AsString, 'NF_EL_IF_IV_D1_') > 0) And (LeftStr(FieldByName('DET_CLAFIS').AsString, 1) >= '5') Then
            FieldByName('TOTCOMNF').AsFloat := FieldByName(Trim(fCamComNF)).AsFloat

          Else If (Pos(FieldByName('ESPDOC').AsString, 'TR_DV_PD_') > 0) Then
            FieldByName('TOTCOMTR').AsFloat := FieldByName(Trim(fCamComTR)).AsFloat

          Else
            FieldByName('TOTCOMOU').AsFloat := FieldByName(Trim(fCamCom)).AsFloat;
        end;
      End;

      Post;
      Next;

      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    pIncluiQtdVendedor(strVenAnt, intQtdDoc);

    prbProgresso.Position := 0;

  End;
End;

Function TfrmRelFatComVendedor.fRetIndice: String;
Begin
  Result := AnsiReplaceStr(AnsiReplaceStr(fCamposGrupo, ' ', ''), ',', ';');
End;

function TfrmRelFatComVendedor.fRetCampoPercom: String;
begin
  If (SameText(fCfgSis('OPCCOM', varString), 'CV')) Or (SameText(edtOpcao.Text, '11')) Then
    Result := SQL_PERCOM_CLIENTE_VENDEDOR
  Else
    Result := SQL_PERCOM_VENDEDOR;
end;

function TfrmRelFatComVendedor.fRetClientesFilialLocal: String;
  Var
    strSQL     : String;
    qryGenerica: TUniQuery;
    strCodCli  : String;
Begin
  qryGenerica := fCriaQuery;

  Result := '';

  strSQL := ' SELECT EMP_CLIFIL FROM CADEMP ';

  With qryGenerica Do
  Begin
    CLose;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    First;

    strCodCli := '';

    While Not Eof Do
    Begin

      If Not fEmptyStr( FieldByName('EMP_CLIFIL').AsString ) Then
      Begin
        If (fEmptyStr(strCodCli)) Then
          strCodCli := strCodCli + QuotedStr(FieldByName('EMP_CLIFIL').AsString)
        Else
          strCodCli := strCodCli + ',' + QuotedStr(FieldByName('EMP_CLIFIL').AsString);
      End;

      Next;
    End;

    If (Not fEmptyStr(strCodCli)) Then
      Result := ' DET_CODCLI NOT IN (' + strCodCli + ') AND ';

    Close;
  End;

  FreeAndNil(qryGenerica);

  If (fEmptyStr(Result)) Then
    Result := '';
end;

Function TfrmRelFatComVendedor.fRetGroupingLevel: Integer;
  Var
    intContador: Integer;
    strIndice: String;
Begin
  strIndice := fRetIndice;;
  Result := 1;
  For intContador := 1 To Length(strIndice) Do
    If strIndice[intContador] = ';' Then
      Inc(Result);
End;

Procedure TfrmRelFatComVendedor.pCriaIndicesAgrupamento;
Begin
  With cdsRelat Do
  Begin
    Close;
    IndexDefs.Clear;
    With IndexDefs.AddIndexDef Do
    Begin
      Name := 'IDX_001';
      Fields := fRetIndice;
    End;
    IndexName := 'IDX_001';
  End;
End;

procedure TfrmRelFatComVendedor.pFormataRelatorioOpcao4Analitico(qckRel: TfrxReport);
begin
  {**************************************************************}
  {* NOVA OPCAO DE RELATORIO , OPCAO 4 - ANALITICO - ESTA OPCAO *}
  {* TRAZ O DETALHAMENTO DA COMISSAO, ITEM A ITEM DO DOCUMENTO  *}
  {***********************************************************DP*}
  If (edtTipo.Text = '4') Then
  Begin
    TfrxMemoView(qckRel.FindObject('rllQtdIte')).Visible        := True;
    TfrxMemoView(qckRel.FindObject('rllQtdIteTit')).Visible     := True;
    TfrxMemoView(qckRel.FindObject('rllQtdIteGer')).Visible     := True;
    TfrxMemoView(qckRel.FindObject('rllQtdIteGru')).Visible     := True;
    TfrxMemoView(qckRel.FindObject('rllCliente')).Visible       := False;
    TfrxMemoView(qckRel.FindObject('rllClienteTit')).Visible    := False;
    TfrxMemoView(qckRel.FindObject('rllCodigoTit')).Visible     := True;
    TfrxMemoView(qckRel.FindObject('rllDescricaoTit')).Visible  := True;
    TfrxMemoView(qckRel.FindObject('rllUnidadeTit')).Visible    := True;
    TfrxMemoView(qckRel.FindObject('rllVrUnitarioTit')).Visible := True;
    TfrxMemoView(qckRel.FindObject('rllCodigo')).Visible        := True;
    TfrxMemoView(qckRel.FindObject('rllDescricao')).Visible     := True;
    TfrxMemoView(qckRel.FindObject('rllUnidade')).Visible       := True;
    TfrxMemoView(qckRel.FindObject('rllVrUnitario')).Visible    := True;
    TfrxMemoView(qckRel.FindObject('rllDataTit')).Visible       := False;
    TfrxMemoView(qckRel.FindObject('rllNumDocTit')).Visible     := False;
    TfrxMemoView(qckRel.FindObject('rllEmpTit')).Visible        := False;
    TfrxMemoView(qckRel.FindObject('rllDocFatTit')).Visible     := False;
    TfrxMemoView(qckRel.FindObject('rllData')).Visible          := False;
    TfrxMemoView(qckRel.FindObject('rllNumDoc')).Visible        := False;
    TfrxMemoView(qckRel.FindObject('rllEmp')).Visible           := False;
    TfrxMemoView(qckRel.FindObject('rllDocFat')).Visible        := False;
    TfrxGroupHeader(qckRel.FindObject('grpDocumento')).Visible  := True;
    TfrxGroupFooter(qckRel.FindObject('grpfDocumento')).Visible := True;
  End
  Else
  Begin
    TfrxMemoView(qckRel.FindObject('rllCodigoTit')).Visible     := False;
    TfrxMemoView(qckRel.FindObject('rllDescricaoTit')).Visible  := False;
    TfrxMemoView(qckRel.FindObject('rllUnidadeTit')).Visible    := False;
    TfrxMemoView(qckRel.FindObject('rllVrUnitarioTit')).Visible := False;
    TfrxMemoView(qckRel.FindObject('rllCodigo')).Visible        := False;
    TfrxMemoView(qckRel.FindObject('rllDescricao')).Visible     := False;
    TfrxMemoView(qckRel.FindObject('rllUnidade')).Visible       := False;
    TfrxMemoView(qckRel.FindObject('rllVrUnitario')).Visible    := False;
    TfrxGroupHeader(qckRel.FindObject('grpDocumento')).Visible  := False;
    TfrxGroupFooter(qckRel.FindObject('grpfDocumento')).Visible := False;
  End;
end;

procedure TfrmRelFatComVendedor.pGeraExcel;
  var
    arrTip1AgrD: Array [1..11] Of Array [1..2] Of String;
    arrTip1AgrC: Array [1..07] Of Array [1..2] Of String;
    arrTip1AgrL: Array [1..08] Of Array [1..2] Of String;
    arrTip2    : Array [1..11] Of Array [1..2] Of String;
    arrTip3    : Array [1..07] Of Array [1..2] Of String;
    arrTip4    : Array [1..11] Of Array [1..2] Of String;
    objExcel   : TExcel;
    intCont    : Integer;
    intQtdCol  : Integer;
    strUltCol  : String;
    strTitulo  : String;
    strVenAnt  : String;
    strNroDoc  : String;
    strDtaDoc  : String;
    strCodEmp  : String;
    strDocFat  : String;
    strClient  : String;
    strCamPes  : String;
    fltTotBas  : Double;
    fltTotVlr  : Double;
    fltPerCom  : Double;
    fltVlrTot  : Double;
    fltVlrCus  : Double;
    fltVlrRes  : Double;
    fltVlrMar  : Double;
    fltVlrCom  : Double;
    fltQtdTotGeral : Double;
    RelTotGer  : TRelTotSin;
    RelTotVen  : TRelTotSin;
    RelTotVendedor : TRelTotSin;
    
    procedure pAgrupaClient;
      Var
        strVenAnt,
        strCliAnt,
        strLinAnt : String;
        dtaDtaAnt : TDatetime;
        cdsTemp   : TUniClientDataSet;
    begin
      cdsTemp        := TUniClientDataSet.Create(Self);
      cdsTemp.FieldDefs := cdsRelat.FieldDefs;
      cdsTemp.CreateDataSet;
      cdsTemp.Open;

      If (edtTipo.Text = '1') Then
      Begin

        If (edtOpcAgru.Text = 'C') Then
        begin
          cdsTemp.IndexFieldNames := fCodVen(edtOrdem.Text) + ';CODCLI';

          cdsRelat.IndexDefs.Clear;
          cdsRelat.IndexName := '';
          cdsRelat.IndexFieldNames := fCodVen(edtOrdem.Text) + ';CODCLI';
        End
        Else If (edtOpcAgru.Text = 'L') Then
        begin
          cdsTemp.IndexFieldNames := fCodVen(edtOrdem.Text) + ';CODGRU';

          cdsRelat.IndexDefs.Clear;
          cdsRelat.IndexName := '';
          cdsRelat.IndexFieldNames := fCodVen(edtOrdem.Text) + ';CODGRU';
        End;

      End
      Else If (edtTipo.Text = '2') Then
      Begin
        cdsTemp.IndexFieldNames := fCodVen(edtOrdem.Text);

        cdsRelat.IndexDefs.Clear;
        cdsRelat.IndexName := '';
        cdsRelat.IndexFieldNames := fCodVen(edtOrdem.Text);
      End
      Else If (edtTipo.Text = '3') Then
      Begin
        cdsTemp.IndexFieldNames := fCodVen(edtOrdem.Text) + ';DTAENT';

        cdsRelat.IndexDefs.Clear;
        cdsRelat.IndexName := '';
        cdsRelat.IndexFieldNames := fCodVen(edtOrdem.Text) + ';DTAENT';
      End;

      cdsRelat.First;
      With cdsRelat Do
      Begin

        While Not Eof Do
        Begin

          strVenAnt := FieldByName(Trim(fCodVen('1'))).AsString;

          While (Not EOF) And (FieldByName(Trim(fCodVen('1'))).AsString = strVenAnt) Do
          Begin

            If (edtTipo.Text = '1') Then
            Begin

              If (edtOpcAgru.Text = 'C') Then
              begin

                strCliAnt := FieldByName('CODCLI').AsString;

                While (Not EOF) And
                      (FieldByName(Trim(fCodVen('1'))).AsString = strVenAnt) And
                      (FieldByName('CODCLI').AsString = strCliAnt) Do
                Begin

                  If cdsTemp.Locate(Trim(fCodVen('1')) + ';CODCLI', VarArrayOf([FieldByName(Trim(fCodVen('1'))).AsString, FieldByName('CODCLI').AsString]), []) Then
                    cdsTemp.Edit
                  Else
                    cdsTemp.Insert;

                  cdsTemp.FieldByName(Trim(fCodVen('1'))).AsString       := FieldByName(Trim(fCodVen('1'))).AsString;
                  cdsTemp.FieldByName('NOMVEN').AsString            := FieldByName('NOMVEN').AsString;
                  cdsTemp.FieldByName('CODCLI').AsString            := FieldByName('CODCLI').AsString;
                  cdsTemp.FieldByName(arrTip1AgrC[01][02]).AsString := FieldByName(arrTip1AgrC[01][02]).AsString;
                  cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat + FieldByName(arrTip1AgrC[03][02]).AsFloat;

                  If (edtMargem.Text = 'S') Then
                  Begin
                    cdsTemp.FieldByName(arrTip1AgrC[04][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrC[04][02]).AsFloat + FieldByName(arrTip1AgrC[04][02]).AsFloat;
                    cdsTemp.FieldByName(arrTip1AgrC[05][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat - cdsTemp.FieldByName(arrTip1AgrC[04][02]).AsFloat;
                    cdsTemp.FieldByName(arrTip1AgrC[07][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrC[07][02]).AsFloat + FieldByName(arrTip1AgrC[07][02]).AsFloat;

                    If (cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat = 0) Then
                      cdsTemp.FieldByName(arrTip1AgrC[02][02]).AsFloat := 0
                    else
                      cdsTemp.FieldByName(arrTip1AgrC[02][02]).AsFloat := (cdsTemp.FieldByName(arrTip1AgrC[07][02]).AsFloat * 100) / cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat;

                    If (cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat = 0) Then
                    Begin
                      cdsTemp.FieldByName(arrTip1AgrC[06][02]).AsFloat := 0;
                    End
                    Else
                    Begin
                      If Pos(strMarMkp, '1_5_') = 0 Then
                        cdsTemp.FieldByName(arrTip1AgrC[06][02]).AsFloat := ((cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat / cdsTemp.FieldByName(arrTip1AgrC[04][02]).AsFloat) * 100) - 100
                      Else
                        cdsTemp.FieldByName(arrTip1AgrC[06][02]).AsFloat := (1 - (cdsTemp.FieldByName(arrTip1AgrC[04][02]).AsFloat / cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat)) * 100;
                    End;
                  end
                  Else
                  Begin
                    cdsTemp.FieldByName(arrTip1AgrC[04][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrC[04][02]).AsFloat + FieldByName(arrTip1AgrC[04][02]).AsFloat;

                    If (cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat = 0) Then
                      cdsTemp.FieldByName(arrTip1AgrC[02][02]).AsFloat := 0
                    else
                      cdsTemp.FieldByName(arrTip1AgrC[02][02]).AsFloat := (cdsTemp.FieldByName(arrTip1AgrC[04][02]).AsFloat * 100) / cdsTemp.FieldByName(arrTip1AgrC[03][02]).AsFloat;
                  End;

                  cdsTemp.Post;

                  Next;

                End;

              End
              Else If (edtOpcAgru.Text = 'L') Then
              begin

                strLinAnt := FieldByName('CODGRU').AsString;

                While (Not EOF) And
                      (FieldByName(Trim(fCodVen('1'))).AsString = strVenAnt) And
                      (FieldByName('CODGRU').AsString = strLinAnt) Do
                Begin

                  If cdsTemp.Locate(Trim(fCodVen('1')) + ';CODGRU', VarArrayOf([FieldByName(Trim(fCodVen('1'))).AsString, FieldByName('CODGRU').AsString]), []) Then
                    cdsTemp.Edit
                  Else
                    cdsTemp.Insert;

                  cdsTemp.FieldByName(Trim(fCodVen('1'))).AsString       := FieldByName(Trim(fCodVen('1'))).AsString;
                  cdsTemp.FieldByName('NOMVEN').AsString            := FieldByName('NOMVEN').AsString;
                  cdsTemp.FieldByName('CODGRU').AsString            := FieldByName('CODGRU').AsString;
                  cdsTemp.FieldByName(arrTip1AgrL[01][02]).AsString := FieldByName(arrTip1AgrL[01][02]).AsString;
                  cdsTemp.FieldByName(arrTip1AgrL[02][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrL[02][02]).AsFloat + FieldByName(arrTip1AgrL[02][02]).AsFloat;
                  cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat + FieldByName(arrTip1AgrL[04][02]).AsFloat;

                  If (edtMargem.Text = 'S') Then
                  Begin
                    cdsTemp.FieldByName(arrTip1AgrL[05][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrL[05][02]).AsFloat + FieldByName(arrTip1AgrL[05][02]).AsFloat;
                    cdsTemp.FieldByName(arrTip1AgrL[06][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat - cdsTemp.FieldByName(arrTip1AgrL[05][02]).AsFloat;
                    cdsTemp.FieldByName(arrTip1AgrL[08][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrL[08][02]).AsFloat + FieldByName(arrTip1AgrL[08][02]).AsFloat;

                    If (cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat = 0) Then
                      cdsTemp.FieldByName(arrTip1AgrL[03][02]).AsFloat := 0
                    else
                      cdsTemp.FieldByName(arrTip1AgrL[03][02]).AsFloat := (cdsTemp.FieldByName(arrTip1AgrL[08][02]).AsFloat * 100) / cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat;

                    If (cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat = 0) Then
                    Begin
                      cdsTemp.FieldByName(arrTip1AgrL[07][02]).AsFloat := 0;
                    End
                    Else
                    Begin
                      If Pos(strMarMkp, '1_5_') = 0 Then
                        cdsTemp.FieldByName(arrTip1AgrL[07][02]).AsFloat := ((cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat / cdsTemp.FieldByName(arrTip1AgrL[05][02]).AsFloat) * 100) - 100
                      Else
                        cdsTemp.FieldByName(arrTip1AgrL[07][02]).AsFloat := (1 - (cdsTemp.FieldByName(arrTip1AgrL[05][02]).AsFloat / cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat)) * 100;
                    End;
                  end
                  Else
                  Begin
                    cdsTemp.FieldByName(arrTip1AgrL[05][02]).AsFloat  := cdsTemp.FieldByName(arrTip1AgrL[05][02]).AsFloat + FieldByName(arrTip1AgrL[05][02]).AsFloat;

                    If (cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat = 0) Then
                      cdsTemp.FieldByName(arrTip1AgrL[03][02]).AsFloat := 0
                    else
                      cdsTemp.FieldByName(arrTip1AgrL[03][02]).AsFloat := (cdsTemp.FieldByName(arrTip1AgrL[05][02]).AsFloat * 100) / cdsTemp.FieldByName(arrTip1AgrL[04][02]).AsFloat;
                  End;

                  cdsTemp.Post;

                  Next;

                End;

              End;

            End
            Else
            Begin

              If (edtTipo.Text = '2') Then
              Begin

                If cdsTemp.Locate(Trim(fCodVen('1')), FieldByName(Trim(fCodVen('1'))).AsString, []) Then
                  cdsTemp.Edit
                Else
                  cdsTemp.Insert;

                cdsTemp.FieldByName(Trim(fCodVen('1'))).AsString   := FieldByName(Trim(fCodVen('1'))).AsString;
                cdsTemp.FieldByName(arrTip2[01][02]).AsString := FieldByName(arrTip2[01][02]).AsString;
                cdsTemp.FieldByName(arrTip2[02][02]).AsFloat  := cdsTemp.FieldByName(arrTip2[02][02]).AsFloat + FieldByName(arrTip2[02][02]).AsFloat;
                cdsTemp.FieldByName(arrTip2[03][02]).AsFloat  := cdsTemp.FieldByName(arrTip2[03][02]).AsFloat + FieldByName(arrTip2[03][02]).AsFloat;
                cdsTemp.FieldByName(arrTip2[04][02]).AsFloat  := cdsTemp.FieldByName(arrTip2[04][02]).AsFloat + FieldByName(arrTip2[04][02]).AsFloat;
                cdsTemp.FieldByName(arrTip2[05][02]).AsFloat  := cdsTemp.FieldByName(arrTip2[05][02]).AsFloat + FieldByName(arrTip2[05][02]).AsFloat;
                cdsTemp.FieldByName(arrTip2[06][02]).AsFloat  := cdsTemp.FieldByName(arrTip2[06][02]).AsFloat + FieldByName(arrTip2[06][02]).AsFloat;
                cdsTemp.FieldByName(arrTip2[07][02]).AsFloat  := cdsTemp.FieldByName(arrTip2[07][02]).AsFloat + FieldByName(arrTip2[07][02]).AsFloat;
                cdsTemp.FieldByName(arrTip2[08][02]).AsFloat  := cdsTemp.FieldByName(arrTip2[08][02]).AsFloat + FieldByName(arrTip2[08][02]).AsFloat;
                cdsTemp.FieldByName(arrTip2[09][02]).AsFloat  := cdsTemp.FieldByName(arrTip2[09][02]).AsFloat + FieldByName(arrTip2[09][02]).AsFloat;
                cdsTemp.FieldByName(arrTip2[10][02]).AsFloat  := fRetQtdDoc(cdsTemp.FieldByName('CODVEN').AsString);
                cdsTemp.FieldByName('TOTCUS').AsFloat         := cdsTemp.FieldByName('TOTCUS').AsFloat + FieldByName('TOTCUS').AsFloat;

                If (edtMargem.Text = 'S') Then
                Begin
                  If Pos(strMarMkp, '1_5_') = 0 Then
                    cdsTemp.FieldByName(arrTip2[11][02]).AsFloat := ((cdsTemp.FieldByName(arrTip2[08][02]).AsFloat / cdsTemp.FieldByName('TOTCUS').AsFloat) * 100) - 100
                  Else
                    cdsTemp.FieldByName(arrTip2[11][02]).AsFloat := (1 - (cdsTemp.FieldByName('TOTCUS').AsFloat / cdsTemp.FieldByName(arrTip2[08][02]).AsFloat)) * 100;
                End;

                cdsTemp.Post;

                Next;

              End
              Else If (edtTipo.Text = '3') Then
              Begin

                dtaDtaAnt := FieldByName('DTAENT').AsDateTime;

                While (Not EOF) And
                      (FieldByName(Trim(fCodVen('1'))).AsString = strVenAnt) And
                      (FieldByName('DTAENT').AsDateTime = dtaDtaAnt) Do
                Begin

                  If cdsTemp.Locate(Trim(fCodVen('1')) + ';DTAENT', VarArrayOf([FieldByName(Trim(fCodVen('1'))).AsString, FieldByName('DTAENT').AsDateTime]), []) Then
                    cdsTemp.Edit
                  Else
                    cdsTemp.Insert;

                  cdsTemp.FieldByName(Trim(fCodVen('1'))).AsString      := FieldByName(Trim(fCodVen('1'))).AsString;
                  cdsTemp.FieldByName('NOMVEN').AsString           := FieldByName('NOMVEN').AsString;
                  cdsTemp.FieldByName(arrTip3[01][02]).AsDateTime  := FieldByName(arrTip3[01][02]).AsDateTime;
                  cdsTemp.FieldByName(arrTip3[03][02]).AsFloat     := cdsTemp.FieldByName(arrTip3[03][02]).AsFloat + FieldByName(arrTip3[03][02]).AsFloat;

                  If (edtMargem.Text = 'S') Then
                  Begin
                    cdsTemp.FieldByName(arrTip3[04][02]).AsFloat   := cdsTemp.FieldByName(arrTip3[04][02]).AsFloat + FieldByName(arrTip3[04][02]).AsFloat;
                    cdsTemp.FieldByName(arrTip3[05][02]).AsFloat   := cdsTemp.FieldByName(arrTip3[03][02]).AsFloat - cdsTemp.FieldByName(arrTip3[04][02]).AsFloat;
                    cdsTemp.FieldByName(arrTip3[07][02]).AsFloat   := cdsTemp.FieldByName(arrTip3[07][02]).AsFloat + FieldByName(arrTip3[07][02]).AsFloat;

                    If Pos(strMarMkp, '1_5_') = 0 Then
                      cdsTemp.FieldByName(arrTip3[06][02]).AsFloat := ((cdsTemp.FieldByName(arrTip3[03][02]).AsFloat / cdsTemp.FieldByName(arrTip3[04][02]).AsFloat) * 100) - 100
                    Else
                      cdsTemp.FieldByName(arrTip3[06][02]).AsFloat := (1 - (cdsTemp.FieldByName(arrTip3[04][02]).AsFloat / cdsTemp.FieldByName(arrTip3[03][02]).AsFloat)) * 100;

                    cdsTemp.FieldByName(arrTip3[02][02]).AsFloat   := (cdsTemp.FieldByName(arrTip3[07][02]).AsFloat * 100) / cdsTemp.FieldByName(arrTip3[03][02]).AsFloat;
                  End
                  Else
                  Begin
                    cdsTemp.FieldByName(arrTip3[04][02]).AsFloat   := cdsTemp.FieldByName(arrTip3[04][02]).AsFloat + FieldByName(arrTip3[04][02]).AsFloat;
                    cdsTemp.FieldByName(arrTip3[02][02]).AsFloat   := (cdsTemp.FieldByName(arrTip3[04][02]).AsFloat * 100) / cdsTemp.FieldByName(arrTip3[03][02]).AsFloat;
                  End;

                  cdsTemp.Post;

                  Next;
                End;

              End;

            End;

          End;

        End;

      End;

      cdsTemp.First;

      cdsRelat.Data := cdsTemp.Data;

      If (edtTipo.Text = '3') Then
      Begin
        cdsRelat.IndexFieldNames := fCodVen(edtOrdem.Text) + ';DTAENT';
      End;

      FreeAndNil(cdsTemp);
    end;

    procedure pZeraTotais(Var recTotais: TRelTotSin);
    begin

      With recTotais Do
      Begin
        fltQtdTot   := 0;
        fltTotVen   := 0;
        fltTotCus   := 0;
        fltTotCom   := 0;
        fltTotMed   := 0;
        fltTotCus   := 0;
        fltTotUlt   := 0;
        fltTotMar   := 0;
        fltResult   := 0;
        fltTotIte   := 0;
        fltTotIteNF := 0;
        fltTotComNF := 0;
        fltTotIteOU := 0;
        fltTotComOU := 0;
        fltTotIteTR := 0;
        fltTotComTR := 0;
      End;

    end;

    procedure pSomaTotais(Var recTotais: TRelTotSin);
    begin

      With recTotais Do
      Begin

        If AnsiMatchStr(edtOpcao.Text, ['5','6','9','13']) Then
        Begin

          if not AnsiMatchStr(edtTipo.Text, ['2']) then
          begin
            fltQtdTot := fltQtdTot + cdsRelat.FieldByName('QTDITE').AsFloat;
            fltTotVen := fltTotVen + fltVlrTot;
            fltTotCus := fltTotCus + fltVlrCus;
            fltResult := fltResult + fltVlrRes;
            fltTotMar := fltTotMar + fltVlrMar;
            fltTotCom := fltTotCom + fltVlrCom;
          end
          else
          begin
            fltTotIteNF := fltTotIteNF + cdsRelat.FieldByName('TOTITENF').AsFloat;
            fltTotComNF := fltTotComNF + cdsRelat.FieldByName('TOTCOMNF').AsFloat;
            fltTotIteOU := fltTotIteOU + cdsRelat.FieldByName('TOTITEOU').AsFloat;
            fltTotComOU := fltTotComOU + cdsRelat.FieldByName('TOTCOMOU').AsFloat;
            fltTotIteTR := fltTotIteTR + cdsRelat.FieldByName('TOTITETR').AsFloat;
            fltTotComTR := fltTotComTR + cdsRelat.FieldByName('TOTCOMTR').AsFloat;

            fltTotVen   := fltTotVen   + cdsRelat.FieldByName('TOTITE').AsFloat;
            if edtOpcao.Text <> '5' then
              fltTotCom := fltTotCom + cdsRelat.FieldByName(fCamCom).AsFloat
            else
            begin
              if cbxVendedor.ItemIndex = 1 then
                fltTotCom := fltTotCom + cdsRelat.FieldByName('MARCO2').AsFloat
              else
                fltTotCom := fltTotCom + (cdsRelat.FieldByName('MARCOM').AsFloat - cdsRelat.FieldByName('MARCO2').AsFloat);
            end;
            fltTotCus   := fltTotCus   + cdsRelat.FieldByName('TOTCUS').AsFloat;
            fltTotMar   := fltTotMar   + cdsRelat.FieldByName('MARGEM').AsFloat;
            fltQtdTot   := fltQtdTot   + cdsRelat.FieldByName('QTDDOC').AsFloat;
          end;

        End
        Else
        Begin

          If AnsiMatchStr(edtTipo.Text, ['1','3','4']) Then
          Begin

            fltQtdTot := fltQtdTot + cdsRelat.FieldByName('QTDITE').AsFloat;
            fltTotVen := fltTotVen + cdsRelat.FieldByName('TOTITE').AsFloat;
            fltTotCus := fltTotCus + cdsRelat.FieldByName('TOTCUS').AsFloat;
            fltTotCom := fltTotCom + cdsRelat.FieldByName(fCamCom).AsFloat;
            fltResult := fltResult + cdsRelat.FieldByName('TOTITE').AsFloat - cdsRelat.FieldByName('TOTCUS').AsFloat;
            fltTotMar := fltTotMar + cdsRelat.FieldByName('MARGEM').AsFloat;

          End
          Else If AnsiMatchStr(edtTipo.Text, ['2']) Then
          Begin

            fltTotIteNF := fltTotIteNF + cdsRelat.FieldByName('TOTITENF').AsFloat;
            fltTotComNF := fltTotComNF + cdsRelat.FieldByName('TOTCOMNF').AsFloat;
            fltTotIteOU := fltTotIteOU + cdsRelat.FieldByName('TOTITEOU').AsFloat;
            fltTotComOU := fltTotComOU + cdsRelat.FieldByName('TOTCOMOU').AsFloat;
            fltTotIteTR := fltTotIteTR + cdsRelat.FieldByName('TOTITETR').AsFloat;
            fltTotComTR := fltTotComTR + cdsRelat.FieldByName('TOTCOMTR').AsFloat;
            fltTotVen   := fltTotVen   + cdsRelat.FieldByName('TOTITE').AsFloat;
            fltTotCom   := fltTotCom   + cdsRelat.FieldByName(fCamCom).AsFloat;
            fltTotCus   := fltTotCus   + cdsRelat.FieldByName('TOTCUS').AsFloat;
            fltTotMar   := fltTotMar   + cdsRelat.FieldByName('MARGEM').AsFloat;
            fltQtdTot   := fltQtdTot   + cdsRelat.FieldByName('QTDDOC').AsFloat;
          End;

        End;

      End;

    end;

    procedure pMontaResumo(Var recTotais: TRelTotSin; intResumo: Integer);
      Var
        strTotal : String;
        strPerCom: String;
        fltMargem: Double;
        fltComMed: Double;
        intColIni: Integer;
    begin

      intColIni := 0;

      If (edtTipo.Text = '1') Then
      Begin

        If (edtOpcAgru.Text = 'D') Then
          intColIni := 7
        Else If (edtOpcAgru.Text = 'C') Then
          intColIni := 3
        Else If (edtOpcAgru.Text = 'L') Then
          intColIni := 3;

      End
      Else If (edtTipo.Text = '2') Then
      Begin

        intColIni := 2;

      End
      Else If (edtTipo.Text = '3') Then
      Begin

        intColIni := 3;

      End
      Else If (edtTipo.Text = '4') Then
      Begin

        intColIni := 5;

      End;

      With objExcel, recTotais Do
      Begin

        If ((fltTotCom = 0) Or (fltTotVen = 0)) Then
          fltComMed := 0
        Else
          fltComMed := (fltTotCom / fltTotVen) * 100;

        If (intResumo = 1) Or (intResumo = 3) Then
        Begin

          strTotal  := 'TOTAL DO ' + String(arrVenRep[cbxVendedor.ItemIndex]) + ':';
          strPerCom := 'PERCENTUAL MÉDIO DE COMISSÃO: ';

        End
        Else If (intResumo = 2) Then
        Begin

          strTotal  := 'TOTAL GERAL: ';
          strPerCom := 'PERCENTUAL MÉDIO DE COMISSÃO GERAL: ';

        End;

        If (edtOpcao.Text <> '8') and (edtTipo.Text <> '2') Then
          ProximaLinha;

        If ((fltTotVen <> 0) And (fltTotCus <> 0)) Then
        Begin

          If Pos(strMarMkp, '1_5_') = 0 Then
            fltMargem := ((fltTotVen / fltTotCus) * 100) - 100
          Else
            fltMargem := (1 - (fltTotCus / fltTotVen)) * 100;

        End
        Else
        Begin

          If ((fltTotCus = 0) And (Pos(strMarMkp, '1_5_') > 0)) Then
            fltMargem := 100
          Else
            fltMargem := 0;

        End;

        If (edtTipo.Text = '1') Then
        Begin

          Escrever(LinhaAtual, intColIni - 2, strTotal);

          If (Pos(edtOpcAgru.Text, 'L_') > 0) Then
          Begin

            Escrever(LinhaAtual, intColIni - 1, fltQtdTot);
            Escrever(LinhaAtual, intColIni + 1, fltTotVen);

            FormatoNumerico(LinhaAtual, intColIni - 1);
            FormatoNumerico(LinhaAtual, intColIni + 1);

            If (edtMargem.Text = 'S') Then
            Begin

              Escrever(LinhaAtual, intColIni + 2, fltTotCus);
              Escrever(LinhaAtual, intColIni + 3, fltResult);
              Escrever(LinhaAtual, intColIni + 4, fltMargem);
              Escrever(LinhaAtual, intColIni + 5, fltTotCom);

              FormatoNumerico(LinhaAtual, intColIni + 2);
              FormatoNumerico(LinhaAtual, intColIni + 3);
              FormatoNumerico(LinhaAtual, intColIni + 4);
              FormatoNumerico(LinhaAtual, intColIni + 5);

            End
            Else
            Begin

              Escrever(LinhaAtual, intColIni + 2, fltTotCom);
              FormatoNumerico(LinhaAtual, intColIni + 2);

            End;

          End
          Else If (Pos(edtOpcAgru.Text, 'C_') > 0) Then
          Begin

            Escrever(LinhaAtual, intColIni, fltTotVen);

            FormatoNumerico(LinhaAtual, intColIni);

            If (edtMargem.Text = 'S') Then
            Begin

              Escrever(LinhaAtual, intColIni + 1, fltTotCus);
              Escrever(LinhaAtual, intColIni + 2, fltResult);
              Escrever(LinhaAtual, intColIni + 3, fltMargem);
              Escrever(LinhaAtual, intColIni + 4, fltTotCom);

              FormatoNumerico(LinhaAtual, intColIni + 1);
              FormatoNumerico(LinhaAtual, intColIni + 2);
              FormatoNumerico(LinhaAtual, intColIni + 3);
              FormatoNumerico(LinhaAtual, intColIni + 4);

            End
            Else
            Begin

              Escrever(LinhaAtual, intColIni + 1, fltTotCom);
              FormatoNumerico(LinhaAtual, intColIni + 1);

            End;

          End
          Else
          Begin

            Escrever(LinhaAtual, intColIni, fltTotVen);
            FormatoNumerico(LinhaAtual, intColIni);

            If (edtMargem.Text = 'S') Then
            Begin

              Escrever(LinhaAtual, intColIni + 1, fltTotCus);
              Escrever(LinhaAtual, intColIni + 2, fltResult);
              Escrever(LinhaAtual, intColIni + 3, fltMargem);
              Escrever(LinhaAtual, intColIni + 4, fltTotCom);

              FormatoNumerico(LinhaAtual, intColIni + 1);
              FormatoNumerico(LinhaAtual, intColIni + 2);
              FormatoNumerico(LinhaAtual, intColIni + 3);
              FormatoNumerico(LinhaAtual, intColIni + 4);

            End
            Else
            Begin

              Escrever(LinhaAtual, intColIni + 1, fltTotCom);
              FormatoNumerico(LinhaAtual, intColIni + 1);

            End;

          End;

          Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
          Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          ProximaLinha;

          Escrever(LinhaAtual, intColIni - 2, strPerCom);
          If (Pos(edtOpcAgru.Text, 'L_') > 0) Then
          Begin

            Escrever(LinhaAtual, intColIni, fltComMed);
            FormatoNumerico(LinhaAtual, intColIni, '#.####0,0000');

          End
          Else
          Begin

            Escrever(LinhaAtual, intColIni - 1, fltComMed);

            FormatoNumerico(LinhaAtual, intColIni - 1, '#.####0,0000');

          End;

          Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
          Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        End
        Else If (edtTipo.Text = '2') Then
        Begin

          ProximaLinha;

          If (edtOpcao.Text = '1') Then
          Begin
            Escrever(LinhaAtual, intColIni - 1, strTotal);
          End;

          Escrever(LinhaAtual, intColIni    , fltTotIteNF);
          Escrever(LinhaAtual, intColIni + 1, fltTotComNF);
          Escrever(LinhaAtual, intColIni + 2, fltTotIteOU);
          Escrever(LinhaAtual, intColIni + 3, fltTotComOU);
          Escrever(LinhaAtual, intColIni + 4, fltTotIteTR);
          Escrever(LinhaAtual, intColIni + 5, fltTotComTR);
          Escrever(LinhaAtual, intColIni + 6, fltTotVen);
          Escrever(LinhaAtual, intColIni + 7, fltTotCom);
          Escrever(LinhaAtual, intColIni + 8, fltQtdTot);

          If (edtMargem.Text = 'S') Then
            Escrever(LinhaAtual, intColIni + 9, fltMargem);

          FormatoNumerico(LinhaAtual, intColIni);
          FormatoNumerico(LinhaAtual, intColIni + 1);
          FormatoNumerico(LinhaAtual, intColIni + 2);
          FormatoNumerico(LinhaAtual, intColIni + 3);
          FormatoNumerico(LinhaAtual, intColIni + 4);
          FormatoNumerico(LinhaAtual, intColIni + 5);
          FormatoNumerico(LinhaAtual, intColIni + 6);
          FormatoNumerico(LinhaAtual, intColIni + 7);
          FormatoNumerico(LinhaAtual, intColIni + 8);

          If (edtMargem.Text = 'S') Then
            FormatoNumerico(LinhaAtual, intColIni + 9);

          Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
          Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        End
        Else If (edtTipo.Text = '3') Then
        Begin

          Escrever(LinhaAtual, intColIni - 2, strTotal);
          Escrever(LinhaAtual, intColIni    , fltTotVen);
          FormatoNumerico(LinhaAtual, intColIni);

          Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
          Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          If (edtMargem.Text = 'S') Then
          Begin

            Escrever(LinhaAtual, intColIni + 1, fltTotCus);
            Escrever(LinhaAtual, intColIni + 2, fltResult);
            Escrever(LinhaAtual, intColIni + 3, fltMargem);
            Escrever(LinhaAtual, intColIni + 4, fltTotCom);

            FormatoNumerico(LinhaAtual, intColIni + 1);
            FormatoNumerico(LinhaAtual, intColIni + 2);
            FormatoNumerico(LinhaAtual, intColIni + 3);
            FormatoNumerico(LinhaAtual, intColIni + 4);

          End
          Else
          Begin

            //Escrever(LinhaAtual, intColIni + 1, fltResult);
            Escrever(LinhaAtual, intColIni + 1, fltTotCom);

            FormatoNumerico(LinhaAtual, intColIni + 1);
            //FormatoNumerico(LinhaAtual, intColIni + 2);

          End;

          ProximaLinha;

          Escrever(LinhaAtual, intColIni - 2, strPerCom);
          Escrever(LinhaAtual, intColIni - 1, fltComMed);

          FormatoNumerico(LinhaAtual, intColIni - 1, '#.####0,0000');

          Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
          Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        End
        Else If (edtTipo.Text = '4') Then
        Begin
          If (intResumo = 3) Then
            Escrever(LinhaAtual, 2, strTotal)
          Else If (intResumo = 2) Then
            Escrever(LinhaAtual, 2, 'TOTAL DO DOCUMENTO GERAL:')
          Else
            Escrever(LinhaAtual, 2, 'TOTAL DO DOCUMENTO:');

          Escrever(LinhaAtual, intColIni    , fltQtdTot);
          Escrever(LinhaAtual, intColIni + 2, fltTotVen);

          FormatoNumerico(LinhaAtual, intColIni);
          FormatoNumerico(LinhaAtual, intColIni + 2);

          Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
          Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          If (edtMargem.Text = 'S') Then
          Begin

            Escrever(LinhaAtual, intColIni + 3, fltTotCus);
            Escrever(LinhaAtual, intColIni + 4, fltResult);
            Escrever(LinhaAtual, intColIni + 5, fltMargem);
            Escrever(LinhaAtual, intColIni + 6, fltTotCom);

            FormatoNumerico(LinhaAtual, intColIni + 3);
            FormatoNumerico(LinhaAtual, intColIni + 4);
            FormatoNumerico(LinhaAtual, intColIni + 5);
            FormatoNumerico(LinhaAtual, intColIni + 6);

          End
          Else
          Begin

            Escrever(LinhaAtual, intColIni + 3, fltTotCom);

            FormatoNumerico(LinhaAtual, intColIni + 2);

          End;

          If (intResumo <> 3) Then
          Begin
            ProximaLinha;
            Escrever(LinhaAtual, intColIni - 3, strPerCom);
          End;

          Escrever(LinhaAtual, intColIni + 1, fltComMed);
          FormatoNumerico(LinhaAtual, intColIni + 1);

          Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
          Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        End;

      End;

    end;

    procedure pFormatoNumerico(strNomCampo: String); Begin
      If ((edtTipo.Text = '1') Or (edtTipo.Text = '3')) And
         ((strNomCampo = 'PERCOM') Or ((strNomCampo = 'AGG_PERCOM'))) Then Begin
        objExcel.FormatoNumerico(objExcel.LinhaAtual, intCont, '#.####0,0000');
      End Else
        objExcel.FormatoNumerico(objExcel.LinhaAtual, intCont);
    End;
begin

  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  begin

    FreeAndNil(objExcel);
    Exit;

  End;

  intQtdCol := 0;

  With objExcel Do
  Begin

    PintarTudo(Branco);
    DefinirFonte(CourierNew, 10);

    pZeraTotais(RelTotVen);
    pZeraTotais(RelTotGer);
    pZeraTotais(RelTotVendedor);

    LinhaAtual := 1;

    If (edtTipo.Text = '1') Then
    Begin

      If (edtOpcAgru.Text = 'D') Then
        intQtdCol  := Length(arrTip1AgrD) - IfThen((edtMargem.Text = 'S'), 0, 3)
      Else If (edtOpcAgru.Text = 'C') Then
        intQtdCol  := Length(arrTip1AgrC) - IfThen((edtMargem.Text = 'S'), 0, 3)
      Else If (edtOpcAgru.Text = 'L') Then
        intQtdCol  := Length(arrTip1AgrL) - IfThen((edtMargem.Text = 'S'), 0, 3);

    End
    Else If (edtTipo.Text = '2') Then
    Begin

      intQtdCol  := Length(arrTip2) - IfThen((edtMargem.Text = 'S'), 0, 1);

    End
    Else If (edtTipo.Text = '3') Then
    Begin

      intQtdCol  := Length(arrTip3) - IfThen((edtMargem.Text = 'S'), 0, 3);

    End
    Else If (edtTipo.Text = '4') Then
    Begin

      intQtdCol  := Length(arrTip4) - IfThen((edtMargem.Text = 'S'), 0, 3);

    End;

    strUltCol  := fGetLetraAlfa(intQtdCol);

    If (edtTipo.Text = '1') Then
    Begin

      strTitulo := 'SINTÉTICO DOCUMENTO';

    End
    Else If (edtTipo.Text = '2') Then
    Begin

      strTitulo := 'SINTÉTICO VENDEDOR';

    End
    Else If (edtTipo.Text = '3') Then
    Begin

      strTitulo := 'SINTÉTICO VENDEDOR+DATA';

    End
    Else If (edtTipo.Text = '4') Then
    Begin

      strTitulo := 'ANALÍTICO';

    End;

    pnlInfo.Caption := 'Aguarde... Gerando Arquivo!';
    Application.ProcessMessages;

    Escrever(ProximaLinha, 01, fRetNomeEmpresa);
    Escrever(ProximaLinha, 01, 'RELATÓRIO DE COMISSÃO - ' + strTitulo);

    Escrever(ProximaLinha, 01, fStrTitulo(edtCodGer, edtDesGer, arrGer, strGer, 'GERENTE'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodVendedor, edtDesVendedor, arrOperador, strOperador, 'VENDEDOR'));

    Case cmbTipVen.ItemIndex Of
      VEN_TODOS          : Escrever(ProximaLinha, 01, 'TIPO DE VENDEDOR: TODOS');
      VEN_INTERNO        : Escrever(ProximaLinha, 01, 'TIPO DE VENDEDOR: INTERNO');
      VEN_EXTERNO_LOJA   : Escrever(ProximaLinha, 01, 'TIPO DE VENDEDOR: REPRESENTANTE EXTERNO LOJA');
      VEN_EXTERNO_DISTRIB: Escrever(ProximaLinha, 01, 'TIPO DE VENDEDOR: REPRESENTANTE EXTERNO DISTRIBUIDOR');
    End;

    If fEmptyStr(edtCodDep.Text) Then
      Escrever(ProximaLinha, 01, 'DEPARTAMENTO OPERADOR: TODOS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodDep.Text, edtDesDep, arrDep, strDtaDoc, 'DEPARTAMENTO OPERADOR'));

    If fEmptyStr(edtCodDepProd.Text) Then
      Escrever(ProximaLinha, 01, 'DEPARTAMENTO PRODUTO: TODOS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodDepProd.Text, edtDesDepProd, arrDepProd, strDtaDoc, 'DEPARTAMENTO PRODUTO'));

    Escrever(ProximaLinha, 01, 'OPÇÃO DO RELATÓRIO: '     + arrVenRep[cbxVendedor.ItemIndex]);

    If fEmptyStr(edtCodEmpresa.Text) Then
      Escrever(ProximaLinha, 01, 'EMPRESA: TODAS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA'));

    Escrever(ProximaLinha, 01, 'REFERENTE AO PERÍODO DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)));

    If chkFilTab.Checked Then
      Escrever(ProximaLinha, 01, 'TABELA DE PREÇOS: '     + fRetTabPreSelChkLis(clbTabPre))
    Else
      Escrever(ProximaLinha, 01, 'TABELA DE PREÇOS: '     + 'TODAS');

    If fEmptyStr(edtCodAti.Text) Then
      Escrever(ProximaLinha, 01, 'ATIVIDADE: TODAS')
    Else
      Escrever(ProximaLinha, 01, fStrTitulo(edtCodAti.Text, edtAtividade, arrAtividade, strAtivid, 'ATIVIDADE'));

    Escrever(ProximaLinha, 01, fStrTitulo(edtCodCnd.Text, edtDesCnd, arrCnd, strCnd, 'CONDIÇÃO DE PAGAMENTO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodCli.Text, edtDesCli, arrCliente, strCodCli, 'CLIENTE'));

    If fEmptyStr(edtCodCli.Text) Then
       Escrever(ProximaLinha, 01, 'CLIENTE EXCLUIR: NENHUM')
    Else
       Escrever(ProximaLinha, 01, fStrTitulo(edtCliExc.Text, edtDesExc, arrCliExc, strCliExc, 'CLIENTE EXCLUIR'));

    Escrever(ProximaLinha, 01, fStrTitulo(edtCodFor.Text, edtDesFor, arrFor, strFor, 'FORNECEDOR'));
    Escrever(ProximaLinha, 01, 'COMPOSIÇÃO DE CUSTO: ' + cbbComCus.Text);
    Escrever(ProximaLinha, 01, fStrTitulo(mskLinGru.Text, edtDesGrupo, arrLinGru, strLinGru, 'LINHA/GRUPO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodPro.Text, edtDesPro, arrPro, strPro, 'PRODUTO'));
    Escrever(ProximaLinha, 01, fStrTitulo(edtCodMarca.Text, edtDesMarca, arrMar, strMar, 'MARCA'));
    Escrever(ProximaLinha, 01, 'ITENS EM PROMOÇÃO: ' + IfThen(rdgItePro.ItemIndex = 0, 'SIM', IfThen(rdgItePro.ItemIndex = 1, 'NÃO', 'TODOS')));

    If blnIgnorarNaBaseCalculoDescontoDadoEmConfirmacao Then
      Escrever(ProximaLinha, 01, 'OBS.: Sistema configurado para não deduzir desconto dado em confirmação de documento.');

    For intCont := 1 To LinhaAtual Do
    Begin

      Mesclar    ('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
      Negrito    ('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
      Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);

    End;

    CorFundo('A2', strUltCol + '3', Cinza);
    Bordas  ('A2', strUltCol + '3', True, True, True, True);

    ProximaLinha;

  End;

  If (Pos(edtOpcao.Text,'5_6_8_9_') > 0) Or (SameText(edtOpcao.Text, '13')) Then
  Begin

    If (edtTipo.Text = '1') Then
    Begin

      If (edtMargem.Text = 'S') Then
      Begin

        arrTip1AgrD[01][01] := 'DTA DOC.';
        arrTip1AgrD[02][01] := 'DOCUMENTO';
        arrTip1AgrD[03][01] := 'EMP';
        arrTip1AgrD[04][01] := 'DOC. FAT.';
        arrTip1AgrD[05][01] := 'CLIENTE';
        arrTip1AgrD[06][01] := '%COMISSÃO';
        arrTip1AgrD[07][01] := 'VR. TOTAL';
        arrTip1AgrD[08][01] := 'VR. CUSTO';
        arrTip1AgrD[09][01] := 'RESULTADO';
        arrTip1AgrD[10][01] := '%MARGEM';
        arrTip1AgrD[11][01] := 'VR. COMISSÃO';

        arrTip1AgrD[01][02] := 'DTAENT';
        arrTip1AgrD[02][02] := 'NUMDOC';
        arrTip1AgrD[03][02] := 'CODEMP';
        arrTip1AgrD[04][02] := 'NUMFAT';
        arrTip1AgrD[05][02] := 'NOMCLI';
        arrTip1AgrD[06][02] := 'AGG_PERCOM';
        arrTip1AgrD[07][02] := 'TOTITE';
        arrTip1AgrD[08][02] := 'TOTCUS';
        arrTip1AgrD[09][02] := 'AGG_RESULT';
        arrTip1AgrD[10][02] := 'AGG_MARGEM';
        arrTip1AgrD[11][02] := fCamCom;

        arrTip1AgrC[01][01] := 'CLIENTE';
        arrTip1AgrC[02][01] := '%COMISSÃO';
        arrTip1AgrC[03][01] := 'VR. TOTAL';
        arrTip1AgrC[04][01] := 'VR. CUSTO';
        arrTip1AgrC[05][01] := 'RESULTADO';
        arrTip1AgrC[06][01] := '%MARGEM';
        arrTip1AgrC[07][01] := 'VR. COMISSÃO';

        arrTip1AgrC[01][02] := 'NOMCLI';
        arrTip1AgrC[02][02] := 'AGG_PERCOM';
        arrTip1AgrC[03][02] := 'TOTITE';
        arrTip1AgrC[04][02] := 'TOTCUS';
        arrTip1AgrC[05][02] := 'AGG_RESULT';
        arrTip1AgrC[06][02] := 'AGG_MARGEM';
        arrTip1AgrC[07][02] := fCamCom;

        arrTip1AgrL[01][01] := 'LINHA / GRUPO';
        arrTip1AgrL[02][01] := 'QUANT.';
        arrTip1AgrL[03][01] := '%COMISSÃO';
        arrTip1AgrL[04][01] := 'VR. TOTAL';
        arrTip1AgrL[05][01] := 'VR. CUSTO';
        arrTip1AgrL[06][01] := 'RESULTADO';
        arrTip1AgrL[07][01] := '%MARGEM';
        arrTip1AgrL[08][01] := 'VR. COMISSÃO';

        arrTip1AgrL[01][02] := 'DESGRU';
        arrTip1AgrL[02][02] := 'QTDITE';
        arrTip1AgrL[03][02] := 'AGG_PERCOM';
        arrTip1AgrL[04][02] := 'TOTITE';
        arrTip1AgrL[05][02] := 'TOTCUS';
        arrTip1AgrL[06][02] := 'AGG_RESULT';
        arrTip1AgrL[07][02] := 'AGG_MARGEM';
        arrTip1AgrL[08][02] := fCamCom;

      End
      Else
      Begin

        arrTip1AgrD[01][01] := 'DTA DOC.';
        arrTip1AgrD[02][01] := 'DOCUMENTO';
        arrTip1AgrD[03][01] := 'EMP';
        arrTip1AgrD[04][01] := 'DOC. FAT.';
        arrTip1AgrD[05][01] := 'CLIENTE';
        arrTip1AgrD[06][01] := '%COMISSÃO';
        arrTip1AgrD[07][01] := 'VR. TOTAL';
        //arrTip1AgrD[08][01] := 'RESULTADO';
        arrTip1AgrD[08][01] := 'VR. COMISSÃO';

        arrTip1AgrD[01][02] := 'DTAENT';
        arrTip1AgrD[02][02] := 'NUMDOC';
        arrTip1AgrD[03][02] := 'CODEMP';
        arrTip1AgrD[04][02] := 'NUMFAT';
        arrTip1AgrD[05][02] := 'NOMCLI';
        arrTip1AgrD[06][02] := 'AGG_PERCOM';
        arrTip1AgrD[07][02] := 'TOTITE';
        //arrTip1AgrD[08][02] := 'AGG_RESULT';
        arrTip1AgrD[08][02] := fCamCom;

        arrTip1AgrC[01][01] := 'CLIENTE';
        arrTip1AgrC[02][01] := '%COMISSÃO';
        arrTip1AgrC[03][01] := 'VR. TOTAL';
        //arrTip1AgrC[04][01] := 'RESULTADO';
        arrTip1AgrC[04][01] := 'VR. COMISSÃO';

        arrTip1AgrC[01][02] := 'NOMCLI';
        arrTip1AgrC[02][02] := 'AGG_PERCOM';
        arrTip1AgrC[03][02] := 'TOTITE';
        //arrTip1AgrC[04][02] := 'AGG_RESULT';
        arrTip1AgrC[04][02] := fCamCom;

        arrTip1AgrL[01][01] := 'LINHA / GRUPO';
        arrTip1AgrL[02][01] := 'QUANT.';
        arrTip1AgrL[03][01] := '%COMISSÃO';
        arrTip1AgrL[04][01] := 'VR. TOTAL';
        //arrTip1AgrL[05][01] := 'RESULTADO';
        arrTip1AgrL[05][01] := 'VR. COMISSÃO';

        arrTip1AgrL[01][02] := 'DESGRU';
        arrTip1AgrL[02][02] := 'QTDITE';
        arrTip1AgrL[03][02] := 'AGG_PERCOM';
        arrTip1AgrL[04][02] := 'TOTITE';
        //arrTip1AgrL[05][02] := 'AGG_RESULT';
        arrTip1AgrL[05][02] := fCamCom;

      End;

    End
    Else If (edtTipo.Text = '2') Then
    Begin

      If (edtMargem.Text = 'S') Then
      Begin

        arrTip2[01][01] := 'VENDEDOR';
        arrTip2[02][01] := 'VR. TOTAL';
        arrTip2[03][01] := 'VR. COMISSÃO';
        arrTip2[04][01] := 'VR. TOTAL';
        arrTip2[05][01] := 'VR. COMISSÃO';
        arrTip2[06][01] := 'VR. TOTAL';
        arrTip2[07][01] := 'VR. COMISSÃO';
        arrTip2[08][01] := 'VR. TOTAL';
        arrTip2[09][01] := 'VR. COMISSÃO';
        arrTip2[10][01] := 'DOCS.';
        arrTip2[11][01] := 'MARGEM';

        arrTip2[01][02] := 'NOMVEN';
        arrTip2[02][02] := 'TOTITENF';
        arrTip2[03][02] := fCamComNF;
        arrTip2[04][02] := 'TOTITEOU';
        arrTip2[05][02] := fCamCom(True);
        arrTip2[06][02] := 'TOTITETR';
        arrTip2[07][02] := fCamComTR;
        arrTip2[08][02] := 'TOTITE';
        arrTip2[09][02] := fCamCom;
        arrTip2[10][02] := 'QTDDOC';
        arrTip2[11][02] := 'MARGEM';
      End
      Else
      Begin

        arrTip2[01][01] := 'VENDEDOR';
        arrTip2[02][01] := 'VR. TOTAL';
        arrTip2[03][01] := 'VR. COMISSÃO';
        arrTip2[04][01] := 'VR. TOTAL';
        arrTip2[05][01] := 'VR. COMISSÃO';
        arrTip2[06][01] := 'VR. TOTAL';
        arrTip2[07][01] := 'VR. COMISSÃO';
        arrTip2[08][01] := 'VR. TOTAL';
        arrTip2[09][01] := 'VR. COMISSÃO';
        arrTip2[10][01] := 'DOCS.';

        arrTip2[01][02] := 'NOMVEN';
        arrTip2[02][02] := 'TOTITENF';
        arrTip2[03][02] := fCamComNF;
        arrTip2[04][02] := 'TOTITEOU';
        arrTip2[05][02] := fCamCom(True);
        arrTip2[06][02] := 'TOTITETR';
        arrTip2[07][02] := fCamComTR;
        arrTip2[08][02] := 'TOTITE';
        arrTip2[09][02] := fCamCom;
        arrTip2[10][02] := 'QTDDOC';

      End;

    End
    Else If (edtTipo.Text = '3') Then
    Begin

      If (edtMargem.Text = 'S') Then
      Begin

        arrTip3[01][01] := 'DATA';
        arrTip3[02][01] := '%COMISSÃO';
        arrTip3[03][01] := 'VR. TOTAL';
        arrTip3[04][01] := 'VR. CUSTO';
        arrTip3[05][01] := 'RESULTADO';
        arrTip3[06][01] := '%MARGEM';
        arrTip3[07][01] := 'VR. COMISSÃO';

        arrTip3[01][02] := 'DTAENT';
        arrTip3[02][02] := 'PERCOM';
        arrTip3[03][02] := 'TOTITE';
        arrTip3[04][02] := 'TOTCUS';
        arrTip3[05][02] := 'RESULT';
        arrTip3[06][02] := 'MARGEM';
        arrTip3[07][02] := fCamCom;

      End
      Else
      Begin

        arrTip3[01][01] := 'DATA';
        arrTip3[02][01] := '%COMISSÃO';
        arrTip3[03][01] := 'VR. TOTAL';
        //arrTip3[04][01] := 'RESULTADO';
        arrTip3[04][01] := 'VR. COMISSÃO';

        arrTip3[01][02] := 'DTAENT';
        arrTip3[02][02] := 'PERCOM';
        arrTip3[03][02] := 'TOTITE';
        //arrTip3[04][02] := 'RESULT';
        arrTip3[04][02] := fCamCom;

      End;

    End
    Else If (edtTipo.Text = '4') Then
    Begin

      If (edtMargem.Text = 'S') Then
      Begin

        arrTip4[01][01] := 'CÓDIGO';
        arrTip4[02][01] := 'DESCRIÇÃO';
        arrTip4[03][01] := 'UNID.';
        arrTip4[04][01] := 'VR. UNIT.';
        arrTip4[05][01] := 'QUANT.';
        arrTip4[06][01] := '% COMISSÃO';
        arrTip4[07][01] := 'VR. TOTAL';
        arrTip4[08][01] := 'VR. CUSTO';
        arrTip4[09][01] := 'RESULTADO';
        arrTip4[10][01] := '% MARGEM';
        arrTip4[11][01] := 'VR. COMISSÃO';

        arrTip4[01][02] := 'CODITE';
        arrTip4[02][02] := 'DESITE';
        arrTip4[03][02] := 'SIGUNI';
        arrTip4[04][02] := 'DET_UNITAR';
        arrTip4[05][02] := 'QTDITE';
        arrTip4[06][02] := 'AGG_PERCOM';
        arrTip4[07][02] := 'TOTITE';
        arrTip4[08][02] := 'TOTCUS';
        arrTip4[09][02] := 'AGG_RESULT';
        arrTip4[10][02] := 'AGG_MARGEM';
        arrTip4[11][02] := 'AGG_TOTCOM';

      End
      Else
      Begin

        arrTip4[01][01] := 'CÓDIGO';
        arrTip4[02][01] := 'DESCRIÇÃO';
        arrTip4[03][01] := 'UNID.';
        arrTip4[04][01] := 'VR. UNIT.';
        arrTip4[05][01] := 'QUANT.';
        arrTip4[06][01] := '% COMISSÃO';
        arrTip4[07][01] := 'VR. TOTAL';
        //arrTip4[08][01] := 'RESULTADO';
        arrTip4[08][01] := 'VR. COMISSÃO';

        arrTip4[01][02] := 'CODITE';
        arrTip4[02][02] := 'DESITE';
        arrTip4[03][02] := 'SIGUNI';
        arrTip4[04][02] := 'DET_UNITAR';
        arrTip4[05][02] := 'QTDITE';
        arrTip4[06][02] := 'AGG_PERCOM';
        arrTip4[07][02] := 'TOTITE';
        //arrTip4[08][02] := 'AGG_RESULT';
        arrTip4[08][02] := 'AGG_TOTCOM';

      End;

    End;

    With objExcel Do
    Begin

      With cdsRelat Do
      Begin

        If (edtTipo.Text = '2') Then
        Begin

          Escrever(LinhaAtual,  2, 'NOTA FIS/CUPOM FIS');
          Escrever(LinhaAtual,  4, 'OUTRAS');
          Escrever(LinhaAtual,  6, 'TROCA/DEVOLUÇÃO');
          Escrever(LinhaAtual,  8, 'TOTAIS');
          Escrever(LinhaAtual, 10, 'TOTAL');

          Mesclar ('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Mesclar ('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
          Mesclar ('F' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
          Mesclar ('H' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
          Mesclar ('J' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual));

          Negrito    ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
          Alinhamento('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Centro);

          CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
          CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
          Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          ProximaLinha;

        End;

        For intCont := 1 To intQtdCol Do
        Begin

          If (edtTipo.Text = '1') Then
          Begin

            If (edtOpcAgru.Text = 'D') Then
            Begin
              Escrever(LinhaAtual, intCont, arrTip1AgrD[intCont, 01]);
              Negrito (LinhaAtual, intCont, True);

              If (FieldByName(arrTip1AgrD[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                Alinhamento(LinhaAtual, intCont, Esquerda)
              Else If (FieldByName(arrTip1AgrD[intCont, 02]).DataType = ftFloat) Then
                Alinhamento(LinhaAtual, intCont, Direita)
              Else
                Alinhamento(LinhaAtual, intCont, Esquerda);

            End
            Else If (edtOpcAgru.Text = 'C') Then
            Begin

              Escrever(LinhaAtual, intCont, arrTip1AgrC[intCont, 01]);
              Negrito (LinhaAtual, intCont, True);

              If (FieldByName(arrTip1AgrC[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                Alinhamento(LinhaAtual, intCont, Esquerda)
              Else If (FieldByName(arrTip1AgrC[intCont, 02]).DataType = ftFloat) Then
                Alinhamento(LinhaAtual, intCont, Direita)
              Else
                Alinhamento(LinhaAtual, intCont, Esquerda);

            End
            Else If (edtOpcAgru.Text = 'L') Then
            Begin

              Escrever(LinhaAtual, intCont, arrTip1AgrL[intCont, 01]);
              Negrito (LinhaAtual, intCont, True);

              If (FieldByName(arrTip1AgrL[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                Alinhamento(LinhaAtual, intCont, Esquerda)
              Else If (FieldByName(arrTip1AgrL[intCont, 02]).DataType = ftFloat) Then
                Alinhamento(LinhaAtual, intCont, Direita)
              Else
                Alinhamento(LinhaAtual, intCont, Esquerda);

            End;

          End
          Else If (edtTipo.Text = '2') Then
          Begin

            Escrever(LinhaAtual, intCont, arrTip2[intCont, 01]);
            Negrito (LinhaAtual, intCont, True);

            If (FieldByName(arrTip2[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
              Alinhamento(LinhaAtual, intCont, Esquerda)
            Else If (FieldByName(arrTip2[intCont, 02]).DataType = ftFloat) Then
              Alinhamento(LinhaAtual, intCont, Direita)
            Else
              Alinhamento(LinhaAtual, intCont, Esquerda);

          End
          Else If (edtTipo.Text = '3') Then
          Begin

            Escrever(LinhaAtual, intCont, arrTip3[intCont, 01]);
            Negrito (LinhaAtual, intCont, True);

            If (FieldByName(arrTip3[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
              Alinhamento(LinhaAtual, intCont, Esquerda)
            Else If (FieldByName(arrTip3[intCont, 02]).DataType = ftFloat) Then
              Alinhamento(LinhaAtual, intCont, Direita)
            Else
              Alinhamento(LinhaAtual, intCont, Esquerda);

          End
          Else If (edtTipo.Text = '4') Then
          Begin

            Escrever(LinhaAtual, intCont, arrTip4[intCont, 01]);
            Negrito (LinhaAtual, intCont, True);

            If (FieldByName(arrTip4[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
              Alinhamento(LinhaAtual, intCont, Esquerda)
            Else If (FieldByName(arrTip4[intCont, 02]).DataType = ftFloat) Then
              Alinhamento(LinhaAtual, intCont, Direita)
            Else
              Alinhamento(LinhaAtual, intCont, Esquerda);

          End;
        End;

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        First;

        prbProgresso.Max := RecordCount;
        prbProgresso.Position := 0;
        Application.ProcessMessages;

        While Not Eof Do
        Begin

          Application.ProcessMessages;
          If (edtTipo.Text = '1') Then
          Begin

            strVenAnt := FieldByName('NOMVEN').AsString;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              Escrever(ProximaLinha, 01, String(arrVenRep[cbxVendedor.ItemIndex]) + ': ' + strVenAnt);
              Negrito (LinhaAtual,   01, True);

              Mesclar ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
              CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
              CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
              Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

            End;

            While (Not Eof) And (FieldByName('NOMVEN').AsString = strVenAnt) Do
            Begin
              If (edtOpcAgru.Text = 'D') Then
              Begin
                strNroDoc := FieldByName('NUMDOC').AsString;
                strCamPes := 'NUMDOC';
              End
              Else If (edtOpcAgru.Text = 'C') Then
              Begin
                strNroDoc := FieldByName('NOMCLI').AsString;
                strCamPes := 'NOMCLI';
              End
              Else If (edtOpcAgru.Text = 'L') Then
              Begin
                strNroDoc := FieldByName('DESGRU').AsString;
                strCamPes := 'DESGRU';
              End;

              strDtaDoc := '''' + FieldByName('DTAENT').AsString;
              strCodEmp := FieldByName('CODEMP').AsString;
              strDocFat := FieldByName('NUMFAT').AsString;
              strClient := FieldByName('NOMCLI').AsString;

              fltPerCom := 0;
              fltVlrTot := 0;
              fltVlrCus := 0;
              fltVlrRes := 0;
              fltVlrMar := 0;
              fltVlrCom := 0;

              While (Not Eof) And (FieldByName(strCamPes).AsString = strNroDoc) Do
              Begin

                fltPerCom := fDoubleAggregate(cdsRelat, 'AGG_PERCOM');
                fltVlrTot := fltVlrTot + FieldByName('TOTITE').AsFloat;
                fltVlrCus := fltVlrCus + FieldByName('TOTCUS').AsFloat;
                fltVlrRes := fDoubleAggregate(cdsRelat, 'AGG_RESULT');
                fltVlrMar := fDoubleAggregate(cdsRelat, 'AGG_MARGEM');

                If (edtOpcao.Text = '8') Then
                  fltVlrCom := fltVlrCom + fDoubleAggregate(cdsRelat, 'AGG_TOTCOM')
                Else
                  fltVlrCom := fltVlrCom + FieldByName(fCamCom).AsFloat;

                Next;

                prbProgresso.Position := Recno;
                Application.ProcessMessages;

              End;

              ProximaLinha;

              For intCont := 1 To intQtdCol Do
              Begin

                If (edtOpcAgru.Text = 'D') Then
                Begin

                  If (arrTip1AgrD[intCont, 02] = 'DTAENT') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, strDtaDoc);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = 'NUMDOC') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, strNroDoc);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = 'CODEMP') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, strCodEmp);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = 'NUMFAT') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, strDocFat);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = 'NOMCLI') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, strClient);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = 'AGG_PERCOM') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltPerCom);
                    pFormatoNumerico(arrTip1AgrD[intCont, 02]);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = 'TOTITE') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrTot);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = 'TOTCUS') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrCus);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = 'AGG_RESULT') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrRes);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = 'AGG_MARGEM') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrMar);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrD[intCont, 02] = fCamCom) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrCom);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End;

                End
                Else If (edtOpcAgru.Text = 'C') Then
                Begin

                  If (arrTip1AgrC[intCont, 02] = 'NOMCLI') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, strClient);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (arrTip1AgrC[intCont, 02] = 'AGG_PERCOM') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltPerCom);
                    pFormatoNumerico(arrTip1AgrC[intCont, 02]);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrC[intCont, 02] = 'TOTITE') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrTot);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrC[intCont, 02] = 'TOTCUS') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrCus);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrC[intCont, 02] = 'AGG_RESULT') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrRes);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrC[intCont, 02] = 'AGG_MARGEM') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrMar);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else If (arrTip1AgrC[intCont, 02] = fCamCom) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fltVlrCom);
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End;

                End
                Else If (edtOpcAgru.Text = 'L') Then
                Begin

                  If (FieldByName(arrTip1AgrL[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, '''' + FieldByName(arrTip1AgrL[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);
                    
                  End
                  Else If (FieldByName(arrTip1AgrL[intCont, 02]).DataType = ftFloat) Then
                  Begin

                    If (arrTip1AgrL[intCont, 02] = 'AGG_PERCOM') Then
                      Escrever     (LinhaAtual, intCont, fDoubleAggregate(cdsRelat, 'AGG_PERCOM'))
                    Else If (arrTip1AgrL[intCont, 02] = 'AGG_RESULT') Then
                      Escrever     (LinhaAtual, intCont, fDoubleAggregate(cdsRelat, 'AGG_RESULT'))
                    Else If (arrTip1AgrL[intCont, 02] = 'AGG_MARGEM') Then
                      Escrever     (LinhaAtual, intCont, fDoubleAggregate(cdsRelat, 'AGG_MARGEM'))
                    Else
                      Escrever     (LinhaAtual, intCont, FieldByName(arrTip1AgrL[intCont, 02]).AsFloat);
                    pFormatoNumerico(arrTip1AgrL[intCont, 02]);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else
                  Begin

                    If (arrTip1AgrL[intCont, 02] = 'AGG_PERCOM') Then
                    Begin

                      Escrever       (LinhaAtual, intCont, fDoubleAggregate(cdsRelat, 'AGG_PERCOM'));
                      pFormatoNumerico(arrTip1AgrL[intCont, 02]);
                      Alinhamento    (LinhaAtual, intCont, Direita);

                    End
                    Else If (arrTip1AgrL[intCont, 02] = 'AGG_RESULT') Then
                    Begin

                      Escrever       (LinhaAtual, intCont, fDoubleAggregate(cdsRelat, 'AGG_RESULT'));
                      FormatoNumerico(LinhaAtual, intCont);
                      Alinhamento    (LinhaAtual, intCont, Direita);

                    End
                    Else If (arrTip1AgrL[intCont, 02] = 'AGG_MARGEM') Then
                    Begin

                      Escrever       (LinhaAtual, intCont, fDoubleAggregate(cdsRelat, 'AGG_MARGEM'));
                      FormatoNumerico(LinhaAtual, intCont);
                      Alinhamento    (LinhaAtual, intCont, Direita);

                    End
                    Else
                    Begin

                      Escrever       (LinhaAtual, intCont, FieldByName(arrTip1AgrL[intCont, 02]).AsString);
                      Alinhamento    (LinhaAtual, intCont, Esquerda);

                    End;

                  End;

                End;

              End;

              Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              pSomaTotais(RelTotGer);
              pSomaTotais(RelTotVen);

            End;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              pMontaResumo(RelTotVen, 1);
              pZeraTotais(RelTotVen);

            End;

          End
          Else If (edtTipo.Text = '2') Then
          Begin
            strNroDoc := '';
            fltQtdTotGeral := 0;
            While Not Eof Do
            Begin

              strVenAnt := FieldByName('NOMVEN').AsString;
              Escrever(ProximaLinha, 01, String(arrVenRep[cbxVendedor.ItemIndex]) + ': ' + strVenAnt);

              While (Not Eof) And (FieldByName('NOMVEN').AsString = strVenAnt) Do
              Begin
                fltVlrTot := fltVlrTot + FieldByName('TOTITE').AsFloat;
                fltVlrCus := fltVlrCus + FieldByName('TOTCUS').AsFloat;
                fltVlrRes := fDoubleAggregate(cdsRelat, 'AGG_RESULT');
                fltVlrMar := fDoubleAggregate(cdsRelat, 'AGG_MARGEM');

                If (edtOpcao.Text = '8') Then
                  fltVlrCom := fltVlrCom + fDoubleAggregate(cdsRelat, 'AGG_TOTCOM')
                Else
                  fltVlrCom := fltVlrCom + FieldByName(fCamCom).AsFloat;

                pSomaTotais(RelTotVen);
                pSomaTotais(RelTotGer);

                Next;

                prbProgresso.Position := Recno;
                Application.ProcessMessages;
              End;

              RelTotVen.fltQtdTot := fRetQtdDoc( LeftStr(strVenAnt,3) );
              fltQtdTotGeral := fltQtdTotGeral + RelTotVen.fltQtdTot;
              RelTotGer.fltQtdTot := fltQtdTotGeral;

              pMontaResumo(RelTotVen, 1);
              pZeraTotais(RelTotVen);

              If chkResAliq.Checked Then
              Begin

                ProximaLinha;
                ProximaLinha;

                Escrever(LinhaAtual,  1, 'ALÍQUOTA');
                Escrever(LinhaAtual,  2, 'BASE COM.');
                Escrever(LinhaAtual,  3, 'VR. COM.');

                Alinhamento(LinhaAtual, 1, Direita);
                Alinhamento(LinhaAtual, 2, Direita);
                Alinhamento(LinhaAtual, 3, Direita);

                Bordas('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));

                Case cbxVendedor.ItemIndex Of
                  0: Begin
                      fCriaResAliquota(FieldByName('CODVEN').AsString);
                     End;
                  1: Begin
                      fCriaResAliquota(FieldByName('CODVE2').AsString);
                     End;
                  2: Begin
                      fCriaResAliquota(FieldByName('CODDIG').AsString);
                     End;
                  3: Begin
                      fCriaResAliquota(FieldByName('CODREP').AsString);
                     End;
                  4,
                  5: Begin
                      fCriaResAliquota(FieldByName('SUPERV').AsString);
                     End;
                End;

                fltTotBas := 0;
                fltTotVlr := 0;

                While Not qryResAlq.Eof Do
                Begin

                  ProximaLinha;

                  Escrever       (LinhaAtual, 1, qryResAlq.FieldByName('ALÍQUOTA').AsFloat);
                  FormatoNumerico(LinhaAtual, 1);
                  Alinhamento    (LinhaAtual, 1, Direita);

                  Escrever       (LinhaAtual, 2, qryResAlq.FieldByName('BASE').AsFloat);
                  FormatoNumerico(LinhaAtual, 2);
                  Alinhamento    (LinhaAtual, 2, Direita);

                  Escrever       (LinhaAtual, 3, qryResAlq.FieldByName('VR_COM').AsFloat);
                  FormatoNumerico(LinhaAtual, 3);
                  Alinhamento    (LinhaAtual, 3, Direita);

                  Bordas('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));

                  fltTotBas := fltTotBas + qryResAlq.FieldByName('BASE').AsFloat;
                  fltTotVlr := fltTotVlr + qryResAlq.FieldByName('VR_COM').AsFloat;

                  qryResAlq.Next;

                End;

                ProximaLinha;

                Escrever       (LinhaAtual, 1, 'TOTAL:');
                Alinhamento    (LinhaAtual, 1, Direita);

                Escrever       (LinhaAtual, 2, fltTotBas);
                FormatoNumerico(LinhaAtual, 2);
                Alinhamento    (LinhaAtual, 2, Direita);

                Escrever       (LinhaAtual, 3, fltTotVlr);
                FormatoNumerico(LinhaAtual, 3);
                Alinhamento    (LinhaAtual, 3, Direita);

                Bordas('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));

                ProximaLinha;

              End;

//              Next;

//              prbProgresso.Position := Recno;
//              Application.ProcessMessages;

            End;
            ProximaLinha;
            Escrever(LinhaAtual, 1, 'TOTAL GERAL');

          End
          Else If (edtTipo.Text = '3') Then
          Begin

            strVenAnt := FieldByName('NOMVEN').AsString;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              Escrever(ProximaLinha, 01, String(arrVenRep[cbxVendedor.ItemIndex]) + ': ' + strVenAnt);
              Negrito (LinhaAtual,   01, True);

              Mesclar ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
              CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
              CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
              Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

            End;

            While (Not Eof) And (FieldByName('NOMVEN').AsString = strVenAnt) Do
            Begin

              ProximaLinha;

              For intCont := 1 To intQtdCol Do
              Begin

                If (FieldByName(arrTip3[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                Begin

                  Escrever       (LinhaAtual, intCont, '''' + FieldByName(arrTip3[intCont, 02]).AsString);
                  Alinhamento    (LinhaAtual, intCont, Esquerda);

                End
                Else If (FieldByName(arrTip3[intCont, 02]).DataType = ftFloat) Then
                Begin

                  Escrever       (LinhaAtual, intCont, FieldByName(arrTip3[intCont, 02]).AsFloat);
                  pFormatoNumerico(arrTip3[intCont, 02]);
                  Alinhamento    (LinhaAtual, intCont, Direita);

                End
                Else
                Begin

                  Escrever       (LinhaAtual, intCont, FieldByName(arrTip3[intCont, 02]).AsString);
                  Alinhamento    (LinhaAtual, intCont, Esquerda);

                End;

              End;

              Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              pSomaTotais(RelTotGer);
              pSomaTotais(RelTotVen);

              Next;

              prbProgresso.Position := Recno;
              Application.ProcessMessages;

            End;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              pMontaResumo(RelTotVen, 1);
              pZeraTotais(RelTotVen);

            End;

          End
          Else If (edtTipo.Text = '4') Then
          Begin

            strVenAnt := FieldByName('NOMVEN').AsString;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              Escrever(ProximaLinha, 01, String(arrVenRep[cbxVendedor.ItemIndex]) + ': ' + strVenAnt);
              Negrito (LinhaAtual,   01, True);

              Mesclar ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
              CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
              CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
              Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

            End;

            While (Not Eof) And (FieldByName('NOMVEN').AsString = strVenAnt) Do
            Begin

              strNroDoc := FieldByName('NUMDOC').AsString;

              ProximaLinha;

              Escrever(LinhaAtual, 2, 'DTA. DOC.');
              Escrever(LinhaAtual, 3, 'DOCUMENTO');
              Escrever(LinhaAtual, 4, 'EMP');
              Escrever(LinhaAtual, 5, 'DOC. FAT.');
              Escrever(LinhaAtual, 6, 'CLIENTE');

              Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
              Mesclar('F' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
              Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              ProximaLinha;

              Escrever(LinhaAtual, 2, FieldByName('DTAENT').AsString);
              Escrever(LinhaAtual, 3, FieldByName('NUMDOC').AsString);
              Escrever(LinhaAtual, 4, FieldByName('CODEMP').AsString);
              Escrever(LinhaAtual, 5, FieldByName('NUMFAT').AsString);
              Escrever(LinhaAtual, 6, FieldByName('NOMCLI').AsString);

              Mesclar('F' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              While (Not Eof) And (FieldByName('NUMDOC').AsString = strNroDoc) Do
              Begin

                fltVlrTot := FieldByName('TOTITE').AsFloat;
                fltVlrCus := FieldByName('TOTCUS').AsFloat;
                fltVlrRes := fDoubleAggregate(cdsRelat, 'AGG_RESULT');
                fltVlrMar := fDoubleAggregate(cdsRelat, 'AGG_MARGEM');
                fltVlrCom := fDoubleAggregate(cdsRelat, 'AGG_TOTCOM');

                ProximaLinha;

                For intCont := 1 To intQtdCol Do
                Begin

                  If (FieldByName(arrTip4[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, '''' + FieldByName(arrTip4[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (FieldByName(arrTip4[intCont, 02]).DataType = ftFloat) Or (Pos(arrTip4[intCont, 02], 'AGG_MARGEM_AGG_RESULT_AGG_PERCOM_AGG_TOTCOM_') > 0) Then
                  Begin

                    If (Pos(arrTip4[intCont, 02], 'AGG_MARGEM_AGG_RESULT_AGG_PERCOM_AGG_TOTCOM_') > 0) Then
                      Escrever       (LinhaAtual, intCont, fDoubleAggregate(cdsRelat, arrTip4[intCont, 02]))
                    Else
                      Escrever       (LinhaAtual, intCont, FieldByName(arrTip4[intCont, 02]).AsFloat);

                    pFormatoNumerico(arrTip4[intCont, 02]);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else
                  Begin

                    Escrever       (LinhaAtual, intCont, FieldByName(arrTip4[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End;

                End;

                Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

                pSomaTotais(RelTotGer);
                pSomaTotais(RelTotVen);
                pSomaTotais(RelTotVendedor);

                Next;

                prbProgresso.Position := Recno;
                Application.ProcessMessages;

              End;

              If Pos(edtOrdem.Text, '13') > 0 Then
              Begin

                pMontaResumo(RelTotVen, 1);
                pZeraTotais(RelTotVen);

              End;
            End;

            pMontaResumo(RelTotVendedor, 3);
            pZeraTotais(RelTotVendedor);
          End;

          prbProgresso.StepBy(1);
          Application.ProcessMessages;

        End;

      End;

    End;

  End
  Else
  Begin

    If (edtTipo.Text = '1') Then
    Begin

      If (edtMargem.Text = 'S') Then
      Begin

        arrTip1AgrD[01][01] := 'DTA DOC.';
        arrTip1AgrD[02][01] := 'DOCUMENTO';
        arrTip1AgrD[03][01] := 'EMP';
        arrTip1AgrD[04][01] := 'DOC. FAT.';
        arrTip1AgrD[05][01] := 'CLIENTE';
        arrTip1AgrD[06][01] := '%COMISSÃO';
        arrTip1AgrD[07][01] := 'VR. TOTAL';
        arrTip1AgrD[08][01] := 'VR. CUSTO';
        arrTip1AgrD[09][01] := 'RESULTADO';
        arrTip1AgrD[10][01] := '%MARGEM';
        arrTip1AgrD[11][01] := 'VR. COMISSÃO';

        arrTip1AgrD[01][02] := 'DTAENT';
        arrTip1AgrD[02][02] := 'NUMDOC';
        arrTip1AgrD[03][02] := 'CODEMP';
        arrTip1AgrD[04][02] := 'NUMFAT';
        arrTip1AgrD[05][02] := 'NOMCLI';
        arrTip1AgrD[06][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip1AgrD[07][02] := 'TOTITE';
        arrTip1AgrD[08][02] := 'TOTCUS';
        arrTip1AgrD[09][02] := 'RESULT';
        arrTip1AgrD[10][02] := 'MARGEM';
        arrTip1AgrD[11][02] := fCamCom;

        arrTip1AgrC[01][01] := 'CLIENTE';
        arrTip1AgrC[02][01] := '%COMISSÃO';
        arrTip1AgrC[03][01] := 'VR. TOTAL';
        arrTip1AgrC[04][01] := 'VR. CUSTO';
        arrTip1AgrC[05][01] := 'RESULTADO';
        arrTip1AgrC[06][01] := '%MARGEM';
        arrTip1AgrC[07][01] := 'VR. COMISSÃO';

        arrTip1AgrC[01][02] := 'NOMCLI';
        arrTip1AgrC[02][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip1AgrC[03][02] := 'TOTITE';
        arrTip1AgrC[04][02] := 'TOTCUS';
        arrTip1AgrC[05][02] := 'RESULT';
        arrTip1AgrC[06][02] := 'MARGEM';
        arrTip1AgrC[07][02] := fCamCom;

        arrTip1AgrL[01][01] := 'LINHA / GRUPO';
        arrTip1AgrL[02][01] := 'QUANT.';
        arrTip1AgrL[03][01] := '%COMISSÃO';
        arrTip1AgrL[04][01] := 'VR. TOTAL';
        arrTip1AgrL[05][01] := 'VR. CUSTO';
        arrTip1AgrL[06][01] := 'RESULTADO';
        arrTip1AgrL[07][01] := '%MARGEM';
        arrTip1AgrL[08][01] := 'VR. COMISSÃO';

        arrTip1AgrL[01][02] := 'DESGRU';
        arrTip1AgrL[02][02] := 'QTDITE';
        arrTip1AgrL[03][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip1AgrL[04][02] := 'TOTITE';
        arrTip1AgrL[05][02] := 'TOTCUS';
        arrTip1AgrL[06][02] := 'RESULT';
        arrTip1AgrL[07][02] := 'MARGEM';
        arrTip1AgrL[08][02] := fCamCom;

      End
      Else
      Begin

        arrTip1AgrD[01][01] := 'DTA DOC.';
        arrTip1AgrD[02][01] := 'DOCUMENTO';
        arrTip1AgrD[03][01] := 'EMP';
        arrTip1AgrD[04][01] := 'DOC. FAT.';
        arrTip1AgrD[05][01] := 'CLIENTE';
        arrTip1AgrD[06][01] := '%COMISSÃO';
        arrTip1AgrD[07][01] := 'VR. TOTAL';
        arrTip1AgrD[08][01] := 'VR. COMISSÃO';

        arrTip1AgrD[01][02] := 'DTAENT';
        arrTip1AgrD[02][02] := 'NUMDOC';
        arrTip1AgrD[03][02] := 'CODEMP';
        arrTip1AgrD[04][02] := 'NUMFAT';
        arrTip1AgrD[05][02] := 'NOMCLI';
        arrTip1AgrD[06][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip1AgrD[07][02] := 'TOTITE';
        arrTip1AgrD[08][02] := fCamCom;

        arrTip1AgrC[01][01] := 'CLIENTE';
        arrTip1AgrC[02][01] := '%COMISSÃO';
        arrTip1AgrC[03][01] := 'VR. TOTAL';
        arrTip1AgrC[04][01] := 'VR. COMISSÃO';

        arrTip1AgrC[01][02] := 'NOMCLI';
        arrTip1AgrC[02][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip1AgrC[03][02] := 'TOTITE';
        arrTip1AgrC[04][02] := fCamCom;

        arrTip1AgrL[01][01] := 'LINHA / GRUPO';
        arrTip1AgrL[02][01] := 'QUANT.';
        arrTip1AgrL[03][01] := '%COMISSÃO';
        arrTip1AgrL[04][01] := 'VR. TOTAL';
        arrTip1AgrL[05][01] := 'VR. COMISSÃO';

        arrTip1AgrL[01][02] := 'DESGRU';
        arrTip1AgrL[02][02] := 'QTDITE';
        arrTip1AgrL[03][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip1AgrL[04][02] := 'TOTITE';
        arrTip1AgrL[05][02] := fCamCom;

      End;

    End
    Else If (edtTipo.Text = '2') Then
    Begin

      If (edtMargem.Text = 'S') Then
      Begin

        arrTip2[01][01] := 'VENDEDOR';
        arrTip2[02][01] := 'VR. TOTAL';
        arrTip2[03][01] := 'VR. COMISSÃO';
        arrTip2[04][01] := 'VR. TOTAL';
        arrTip2[05][01] := 'VR. COMISSÃO';
        arrTip2[06][01] := 'VR. TOTAL';
        arrTip2[07][01] := 'VR. COMISSÃO';
        arrTip2[08][01] := 'VR. TOTAL';
        arrTip2[09][01] := 'VR. COMISSÃO';
        arrTip2[10][01] := 'DOCS.';
        arrTip2[11][01] := 'MARGEM';

        arrTip2[01][02] := 'NOMVEN';
        arrTip2[02][02] := 'TOTITENF';
        arrTip2[03][02] := 'TOTCOMNF';
        arrTip2[04][02] := 'TOTITEOU';
        arrTip2[05][02] := 'TOTCOMOU';
        arrTip2[06][02] := 'TOTITETR';
        arrTip2[07][02] := 'TOTCOMTR';
        arrTip2[08][02] := 'TOTITE';
        arrTip2[09][02] := fCamCom;
        arrTip2[10][02] := 'QTDDOC';
        arrTip2[11][02] := 'MARGEM';

      End
      Else
      Begin

        arrTip2[01][01] := 'VENDEDOR';
        arrTip2[02][01] := 'VR. TOTAL';
        arrTip2[03][01] := 'VR. COMISSÃO';
        arrTip2[04][01] := 'VR. TOTAL';
        arrTip2[05][01] := 'VR. COMISSÃO';
        arrTip2[06][01] := 'VR. TOTAL';
        arrTip2[07][01] := 'VR. COMISSÃO';
        arrTip2[08][01] := 'VR. TOTAL';
        arrTip2[09][01] := 'VR. COMISSÃO';
        arrTip2[10][01] := 'DOCS.';

        arrTip2[01][02] := 'NOMVEN';
        arrTip2[02][02] := 'TOTITENF';
        arrTip2[03][02] := 'TOTCOMNF';
        arrTip2[04][02] := 'TOTITEOU';
        arrTip2[05][02] := 'TOTCOMOU';
        arrTip2[06][02] := 'TOTITETR';
        arrTip2[07][02] := 'TOTCOMTR';
        arrTip2[08][02] := 'TOTITE';
        arrTip2[09][02] := fCamCom;
        arrTip2[10][02] := 'QTDDOC';

      End;

    End
    Else If (edtTipo.Text = '3') Then
    Begin

      If (edtMargem.Text = 'S') Then
      Begin

        arrTip3[01][01] := 'DATA';
        arrTip3[02][01] := '%COMISSÃO';
        arrTip3[03][01] := 'VR. TOTAL';
        arrTip3[04][01] := 'VR. CUSTO';
        arrTip3[05][01] := 'RESULTADO';
        arrTip3[06][01] := '%MARGEM';
        arrTip3[07][01] := 'VR. COMISSÃO';

        arrTip3[01][02] := 'DTAENT';
        arrTip3[02][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip3[03][02] := 'TOTITE';
        arrTip3[04][02] := 'TOTCUS';
        arrTip3[05][02] := 'RESULT';
        arrTip3[06][02] := 'MARGEM';
        arrTip3[07][02] := fCamCom;

      End
      Else
      Begin

        arrTip3[01][01] := 'DATA';
        arrTip3[02][01] := '%COMISSÃO';
        arrTip3[03][01] := 'VR. TOTAL';
        arrTip3[04][01] := 'VR. COMISSÃO';

        arrTip3[01][02] := 'DTAENT';
        arrTip3[02][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip3[03][02] := 'TOTITE';
        arrTip3[04][02] := fCamCom;

      End;

    End
    Else If (edtTipo.Text = '4') Then
    Begin

      If (edtMargem.Text = 'S') Then
      Begin

        arrTip4[01][01] := 'CÓDIGO';
        arrTip4[02][01] := 'DESCRIÇÃO';
        arrTip4[03][01] := 'UNID.';
        arrTip4[04][01] := 'VR. UNIT.';
        arrTip4[05][01] := 'QUANT.';
        arrTip4[06][01] := '% COMISSÃO';
        arrTip4[07][01] := 'VR. TOTAL';
        arrTip4[08][01] := 'VR. CUSTO';
        arrTip4[09][01] := 'RESULTADO';
        arrTip4[10][01] := '% MARGEM';
        arrTip4[11][01] := 'VR. COMISSÃO';

        arrTip4[01][02] := 'CODITE';
        arrTip4[02][02] := 'DESITE';
        arrTip4[03][02] := 'SIGUNI';
        arrTip4[04][02] := 'DET_UNITAR';
        arrTip4[05][02] := 'QTDITE';
        arrTip4[06][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip4[07][02] := 'TOTITE';
        arrTip4[08][02] := 'TOTCUS';
        arrTip4[09][02] := 'RESULT';
        arrTip4[10][02] := 'MARGEM';
        arrTip4[11][02] := fCamCom;

      End
      Else
      Begin

        arrTip4[01][01] := 'CÓDIGO';
        arrTip4[02][01] := 'DESCRIÇÃO';
        arrTip4[03][01] := 'UNID.';
        arrTip4[04][01] := 'VR. UNIT.';
        arrTip4[05][01] := 'QUANT.';
        arrTip4[06][01] := '% COMISSÃO';
        arrTip4[07][01] := 'VR. TOTAL';
        arrTip4[08][01] := 'VR. COMISSÃO';

        arrTip4[01][02] := 'CODITE';
        arrTip4[02][02] := 'DESITE';
        arrTip4[03][02] := 'SIGUNI';
        arrTip4[04][02] := 'DET_UNITAR';
        arrTip4[05][02] := 'QTDITE';
        arrTip4[06][02] := IfThen(edtOpcao.Text = '12','AGG_PERCOM','PERCOM');
        arrTip4[07][02] := 'TOTITE';
        arrTip4[08][02] := fCamCom;

      End;

    End;

    With objExcel Do
    Begin

      If (edtOpcao.Text = '12') And
        ((edtTipo.Text = '2') Or  (edtTipo.Text = '3') Or
        ((edtTipo.Text = '1') And (edtOpcAgru.Text <> 'D'))) Then
      Begin
        cdsRelat.First;      
        pAgrupaClient;
        cdsRelat.First;
      End;

      With cdsRelat Do
      Begin

        If (edtTipo.Text = '2') Then
        Begin

          Escrever(LinhaAtual,  2, 'NOTA FIS/CUPOM FIS');
          Escrever(LinhaAtual,  4, 'OUTRAS');
          Escrever(LinhaAtual,  6, 'TROCA/DEVOLUÇÃO');
          Escrever(LinhaAtual,  8, 'TOTAIS');
          Escrever(LinhaAtual, 10, 'TOTAL');

          Mesclar ('B' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));
          Mesclar ('D' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
          Mesclar ('F' + IntToStr(LinhaAtual), 'G' + IntToStr(LinhaAtual));
          Mesclar ('H' + IntToStr(LinhaAtual), 'I' + IntToStr(LinhaAtual));
          Mesclar ('J' + IntToStr(LinhaAtual), 'K' + IntToStr(LinhaAtual));

          Negrito    ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
          Alinhamento('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Centro);

          CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
          CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
          Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          ProximaLinha;

        End;

        For intCont := 1 To intQtdCol Do
        Begin

          If (edtTipo.Text = '1') Then
          Begin

            If (edtOpcAgru.Text = 'D') Then
            Begin

              Escrever(LinhaAtual, intCont, arrTip1AgrD[intCont, 01]);
              Negrito (LinhaAtual, intCont, True);

              If (FieldByName(arrTip1AgrD[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                Alinhamento(LinhaAtual, intCont, Esquerda)
              Else If (FieldByName(arrTip1AgrD[intCont, 02]).DataType = ftFloat) Then
                Alinhamento(LinhaAtual, intCont, Direita)
              Else
                Alinhamento(LinhaAtual, intCont, Esquerda);

            End
            Else If (edtOpcAgru.Text = 'C') Then
            Begin

              Escrever(LinhaAtual, intCont, arrTip1AgrC[intCont, 01]);
              Negrito (LinhaAtual, intCont, True);

              If (FieldByName(arrTip1AgrC[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                Alinhamento(LinhaAtual, intCont, Esquerda)
              Else If (FieldByName(arrTip1AgrC[intCont, 02]).DataType = ftFloat) Then
                Alinhamento(LinhaAtual, intCont, Direita)
              Else
                Alinhamento(LinhaAtual, intCont, Esquerda);

            End
            Else If (edtOpcAgru.Text = 'L') Then
            Begin

              Escrever(LinhaAtual, intCont, arrTip1AgrL[intCont, 01]);
              Negrito (LinhaAtual, intCont, True);

              If (FieldByName(arrTip1AgrL[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                Alinhamento(LinhaAtual, intCont, Esquerda)
              Else If (FieldByName(arrTip1AgrL[intCont, 02]).DataType = ftFloat) Then
                Alinhamento(LinhaAtual, intCont, Direita)
              Else
                Alinhamento(LinhaAtual, intCont, Esquerda);

            End;

          End
          Else If (edtTipo.Text = '2') Then
          Begin

            Escrever(LinhaAtual, intCont, arrTip2[intCont, 01]);
            Negrito (LinhaAtual, intCont, True);

            If (FieldByName(arrTip2[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
              Alinhamento(LinhaAtual, intCont, Esquerda)
            Else If (FieldByName(arrTip2[intCont, 02]).DataType = ftFloat) Then
              Alinhamento(LinhaAtual, intCont, Direita)
            Else
              Alinhamento(LinhaAtual, intCont, Esquerda);

          End
          Else If (edtTipo.Text = '3') Then
          Begin

            Escrever(LinhaAtual, intCont, arrTip3[intCont, 01]);
            Negrito (LinhaAtual, intCont, True);

            If (FieldByName(arrTip3[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
              Alinhamento(LinhaAtual, intCont, Esquerda)
            Else If (FieldByName(arrTip3[intCont, 02]).DataType = ftFloat) Then
              Alinhamento(LinhaAtual, intCont, Direita)
            Else
              Alinhamento(LinhaAtual, intCont, Esquerda);

          End
          Else If (edtTipo.Text = '4') Then
          Begin

            Escrever(LinhaAtual, intCont, arrTip4[intCont, 01]);
            Negrito (LinhaAtual, intCont, True);

            If (FieldByName(arrTip4[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
              Alinhamento(LinhaAtual, intCont, Esquerda)
            Else If (FieldByName(arrTip4[intCont, 02]).DataType = ftFloat) Then
              Alinhamento(LinhaAtual, intCont, Direita)
            Else
              Alinhamento(LinhaAtual, intCont, Esquerda);

          End;

        End;

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        First;

        prbProgresso.Max := RecordCount;
        prbProgresso.Position := 0;
        Application.ProcessMessages;

        While Not Eof Do
        Begin

          Application.ProcessMessages;

          If (edtTipo.Text = '1') Then
          Begin

            strVenAnt := FieldByName('NOMVEN').AsString;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              ProximaLinha;

              Escrever(ProximaLinha, 01, String(arrVenRep[cbxVendedor.ItemIndex]) + ': ' + strVenAnt);
              Negrito (LinhaAtual,   01, True);
              Alinhamento(LinhaAtual, intCont, Centro);

              Mesclar ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
              CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
              CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
              Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

            End;

            While (Not Eof) And (FieldByName('NOMVEN').AsString = strVenAnt) Do
            Begin
              ProximaLinha;
              For intCont := 1 To intQtdCol Do
              Begin

                If (edtOpcAgru.Text = 'D') Then
                Begin

                  If (FieldByName(arrTip1AgrD[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, '''' + FieldByName(arrTip1AgrD[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (FieldByName(arrTip1AgrD[intCont, 02]).DataType = ftFloat) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, FieldByName(arrTip1AgrD[intCont, 02]).AsFloat);
                    pFormatoNumerico(arrTip1AgrD[intCont, 02]);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else
                  Begin

                    If (arrTip1AgrD[intCont, 02] = 'AGG_PERCOM') Then
                    Begin

                      Escrever       (LinhaAtual, intCont, fDoubleAggregate(cdsRelat, arrTip1AgrD[intCont, 02]));
                      pFormatoNumerico(arrTip1AgrD[intCont, 02]);
                      Alinhamento    (LinhaAtual, intCont, Direita);

                    End
                    Else
                    Begin

                      Escrever       (LinhaAtual, intCont, FieldByName(arrTip1AgrD[intCont, 02]).AsString);
                      Alinhamento    (LinhaAtual, intCont, Esquerda);

                    End;

                  End;

                End
                Else If (edtOpcAgru.Text = 'C') Then
                Begin

                  If (FieldByName(arrTip1AgrC[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, '''' + FieldByName(arrTip1AgrC[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (FieldByName(arrTip1AgrC[intCont, 02]).DataType = ftFloat) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, FieldByName(arrTip1AgrC[intCont, 02]).AsFloat);
                    pFormatoNumerico(arrTip1AgrC[intCont, 02]);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else
                  Begin

                    Escrever       (LinhaAtual, intCont, FieldByName(arrTip1AgrC[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End;

                End
                Else If (edtOpcAgru.Text = 'L') Then
                Begin

                  If (FieldByName(arrTip1AgrL[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, '''' + FieldByName(arrTip1AgrL[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (FieldByName(arrTip1AgrL[intCont, 02]).DataType = ftFloat) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, FieldByName(arrTip1AgrL[intCont, 02]).AsFloat);
                    pFormatoNumerico(arrTip1AgrL[intCont, 02]);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else
                  Begin

                    Escrever       (LinhaAtual, intCont, FieldByName(arrTip1AgrL[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End;

                End;

              End;

              Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              pSomaTotais(RelTotGer);
              pSomaTotais(RelTotVen);

              Next;

              prbProgresso.Position := Recno;
              Application.ProcessMessages;

            End;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              pMontaResumo(RelTotVen, 1);
              pZeraTotais(RelTotVen);

            End;

          End
          Else If (edtTipo.Text = '2') Then
          Begin

            While Not Eof Do
            Begin

              ProximaLinha;

              For intCont := 1 To intQtdCol Do
              Begin

                If (FieldByName(arrTip2[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                Begin

                  Escrever       (LinhaAtual, intCont, '''' + FieldByName(arrTip2[intCont, 02]).AsString);
                  Alinhamento    (LinhaAtual, intCont, Esquerda);

                End
                Else If (FieldByName(arrTip2[intCont, 02]).DataType = ftFloat) Then
                Begin

                  Escrever       (LinhaAtual, intCont, FieldByName(arrTip2[intCont, 02]).AsFloat);
                  pFormatoNumerico(arrTip2[intCont, 02]);
                  Alinhamento    (LinhaAtual, intCont, Direita);

                End
                Else
                Begin

                  If (arrTip2[intCont, 02] = 'AGG_MARGEM') Then
                  Begin

                    Escrever       (LinhaAtual, intCont, fDoubleAggregate(cdsRelat, 'AGG_MARGEM'));
                    FormatoNumerico(LinhaAtual, intCont);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else
                  Begin

                    Escrever       (LinhaAtual, intCont, FieldByName(arrTip2[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End;

                End;

              End;

              Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              If chkResAliq.Checked Then
              Begin

                ProximaLinha;
                ProximaLinha;

                Escrever(LinhaAtual,  1, 'ALÍQUOTA');
                Escrever(LinhaAtual,  2, 'BASE COM.');
                Escrever(LinhaAtual,  3, 'VR. COM.');

                Alinhamento(LinhaAtual, 1, Direita);
                Alinhamento(LinhaAtual, 2, Direita);
                Alinhamento(LinhaAtual, 3, Direita);

                Bordas('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));

                Case cbxVendedor.ItemIndex Of
                  0: Begin
                      fCriaResAliquota(FieldByName('CODVEN').AsString);
                     End;
                  1: Begin
                      fCriaResAliquota(FieldByName('CODVE2').AsString);
                     End;
                  2: Begin
                      fCriaResAliquota(FieldByName('CODDIG').AsString);
                     End;
                  3: Begin
                      fCriaResAliquota(FieldByName('CODREP').AsString);
                     End;
                  4,
                  5: Begin
                      fCriaResAliquota(FieldByName('SUPERV').AsString);
                     End;
                End;

                fltTotBas := 0;
                fltTotVlr := 0;

                While Not qryResAlq.Eof Do
                Begin

                  ProximaLinha;

                  Escrever       (LinhaAtual, 1, qryResAlq.FieldByName('ALIQUOTA').AsFloat);
                  FormatoNumerico(LinhaAtual, 1);
                  Alinhamento    (LinhaAtual, 1, Direita);

                  Escrever       (LinhaAtual, 2, qryResAlq.FieldByName('BASE').AsFloat);
                  FormatoNumerico(LinhaAtual, 2);
                  Alinhamento    (LinhaAtual, 2, Direita);

                  Escrever       (LinhaAtual, 3, qryResAlq.FieldByName('VR_COM').AsFloat);
                  FormatoNumerico(LinhaAtual, 3);
                  Alinhamento    (LinhaAtual, 3, Direita);

                  Bordas('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));

                  fltTotBas := fltTotBas + qryResAlq.FieldByName('BASE').AsFloat;
                  fltTotVlr := fltTotVlr + qryResAlq.FieldByName('VR_COM').AsFloat;

                  qryResAlq.Next;

                End;

                ProximaLinha;

                Escrever       (LinhaAtual, 1, 'TOTAL:');
                Alinhamento    (LinhaAtual, 1, Direita);

                Escrever       (LinhaAtual, 2, fltTotBas);
                FormatoNumerico(LinhaAtual, 2);
                Alinhamento    (LinhaAtual, 2, Direita);

                Escrever       (LinhaAtual, 3, fltTotVlr);
                FormatoNumerico(LinhaAtual, 3);
                Alinhamento    (LinhaAtual, 3, Direita);

                Bordas('A' + IntToStr(LinhaAtual), 'C' + IntToStr(LinhaAtual));

                ProximaLinha;

              End;

              pSomaTotais(RelTotGer);
              pSomaTotais(RelTotVen);

              Next;

              prbProgresso.Position := Recno;
              Application.ProcessMessages;

            End;

          End
          Else If (edtTipo.Text = '3') Then
          Begin

            strVenAnt := FieldByName('NOMVEN').AsString;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              Escrever(ProximaLinha, 01, String(arrVenRep[cbxVendedor.ItemIndex]) + ': ' + strVenAnt);
              Negrito (LinhaAtual,   01, True);

              Mesclar ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
              CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
              CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
              Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

            End;

            While (Not Eof) And (FieldByName('NOMVEN').AsString = strVenAnt) Do
            Begin

              ProximaLinha;

              For intCont := 1 To intQtdCol Do
              Begin

                If (FieldByName(arrTip3[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                Begin

                  Escrever       (LinhaAtual, intCont, '''' + FieldByName(arrTip3[intCont, 02]).AsString);
                  Alinhamento    (LinhaAtual, intCont, Esquerda);

                End
                Else If (FieldByName(arrTip3[intCont, 02]).DataType = ftFloat) Then
                Begin

                  Escrever       (LinhaAtual, intCont, FieldByName(arrTip3[intCont, 02]).AsFloat);
                  pFormatoNumerico(arrTip3[intCont, 02]);
                  Alinhamento    (LinhaAtual, intCont, Direita);

                End
                Else
                Begin

                  Escrever       (LinhaAtual, intCont, FieldByName(arrTip3[intCont, 02]).AsString);
                  Alinhamento    (LinhaAtual, intCont, Esquerda);

                End;

              End;

              Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              pSomaTotais(RelTotGer);
              pSomaTotais(RelTotVen);

              Next;

              prbProgresso.Position := Recno;
              Application.ProcessMessages;

            End;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              pMontaResumo(RelTotVen, 1);
              pZeraTotais(RelTotVen);

            End;

          End
          Else If (edtTipo.Text = '4') Then
          Begin

            strVenAnt := FieldByName('NOMVEN').AsString;

            If Pos(edtOrdem.Text, '13') > 0 Then
            Begin

              Escrever(ProximaLinha, 01, String(arrVenRep[cbxVendedor.ItemIndex]) + ': ' + strVenAnt);
              Negrito (LinhaAtual,   01, True);

              Mesclar ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
              CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
              CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
              Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

            End;

            While (Not Eof) And (FieldByName('NOMVEN').AsString = strVenAnt) Do
            Begin

              strNroDoc := FieldByName('NUMDOC').AsString;

              ProximaLinha;

              Escrever(LinhaAtual, 2, 'DTA. DOC.');
              Escrever(LinhaAtual, 3, 'DOCUMENTO');
              Escrever(LinhaAtual, 4, 'EMP');
              Escrever(LinhaAtual, 5, 'DOC. FAT.');
              Escrever(LinhaAtual, 6, 'CLIENTE');

              Negrito('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True);
              Mesclar('F' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
              Bordas ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              ProximaLinha;

              Escrever(LinhaAtual, 2, FieldByName('DTAENT').AsString);
              Escrever(LinhaAtual, 3, FieldByName('NUMDOC').AsString);
              Escrever(LinhaAtual, 4, FieldByName('CODEMP').AsString);
              Escrever(LinhaAtual, 5, FieldByName('NUMFAT').AsString);
              Escrever(LinhaAtual, 6, FieldByName('NOMCLI').AsString);

              Mesclar('F' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

              While (Not Eof) And (FieldByName('NUMDOC').AsString = strNroDoc) Do
              Begin

                ProximaLinha;

                For intCont := 1 To intQtdCol Do
                Begin

                  If (FieldByName(arrTip4[intCont, 02]).DataType in [ftDate, ftDateTime]) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, '''' + FieldByName(arrTip4[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End
                  Else If (FieldByName(arrTip4[intCont, 02]).DataType = ftFloat) Then
                  Begin

                    Escrever       (LinhaAtual, intCont, FieldByName(arrTip4[intCont, 02]).AsFloat);
                    pFormatoNumerico(arrTip4[intCont, 02]);
                    Alinhamento    (LinhaAtual, intCont, Direita);

                  End
                  Else
                  Begin

                    Escrever       (LinhaAtual, intCont, FieldByName(arrTip4[intCont, 02]).AsString);
                    Alinhamento    (LinhaAtual, intCont, Esquerda);

                  End;

                End;

                Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

                pSomaTotais(RelTotGer);
                pSomaTotais(RelTotVen);

                Next;

                prbProgresso.Position := Recno;
                Application.ProcessMessages;

              End;

              If Pos(edtOrdem.Text, '13') > 0 Then
              Begin

                pMontaResumo(RelTotVen, 1);
                pZeraTotais(RelTotVen);

              End;

            End;

          End;

          prbProgresso.StepBy(1);
          Application.ProcessMessages;

        End;

      End;

    End;

  End;

  pMontaResumo(RelTotGer, 2);
  pZeraTotais(RelTotGer);

  objExcel.OrientacaoPagina(Retrato);

  objExcel.AutoAjuste;
  objExcel.SalvarArquivo;
  objExcel.FecharArquivo;

  pnlInfo.Caption := '';
  prbProgresso.Position := 0;

  fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);

  FreeAndNil(objExcel);
  pSetFocus(mskDtaIni);

end;

Procedure TfrmRelFatComVendedor.pCriaAggregates;
Begin
  intGruLev := fRetGroupingLevel;

  With cdsRelat Do
  Begin
    Close;
    Aggregates.Clear;

    With TAggregateField.Create(cdsRelat) Do
    Begin
      FieldName     := 'AGG_TOTITE';
      DataSet       := cdsRelat;
      Expression    := 'SUM(TOTITE)';
      IndexName     := 'IDX_001';
      GroupingLevel := intGruLev;
      Active        := True;
    End;

    With TAggregateField.Create(cdsRelat) Do
    Begin
      FieldName     := 'AGG_TOTCUS';
      DataSet       := cdsRelat;
      Expression    := 'SUM(TOTCUS)';
      IndexName     := 'IDX_001';
      GroupingLevel := intGruLev;
      Active        := True;
    End;

    With TAggregateField.Create(cdsRelat) Do
    Begin
      FieldName     := 'AGG_RESULT';
      DataSet       := cdsRelat;
      Expression    := 'SUM(TOTITE) - SUM(TOTCUS)';
      IndexName     := 'IDX_001';
      GroupingLevel := intGruLev;
      Active        := True;
    End;

    If Pos(strMarMkp, '1_5_') = 0 Then
    Begin
      With TAggregateField.Create(cdsRelat) Do
      Begin
        FieldName     := 'AGG_MARGEM';
        DataSet       := cdsRelat;
        Expression    := '((SUM(TOTITE) / SUM(TOTCUS)) * 100) - 100';
        IndexName     := 'IDX_001';
        GroupingLevel := intGruLev;
        Active        := True;
      End;
    End Else
    Begin
      With TAggregateField.Create(cdsRelat) Do
      Begin
        FieldName     := 'AGG_MARGEM';
        DataSet       := cdsRelat;
        Expression    := '(1 - (SUM(TOTCUS) / SUM(TOTITE))) * 100';
        IndexName     := 'IDX_001';
        GroupingLevel := intGruLev;
        Active        := True;
      End;
    End;

    With TAggregateField.Create(cdsRelat) Do
    Begin
      FieldName     := 'AGG_TOTITENF';
      DataSet       := cdsRelat;
      Expression    := 'SUM(TOTITENF)';
      IndexName     := 'IDX_001';
      GroupingLevel := intGruLev;
      Active        := True;
    End;

    With TAggregateField.Create(cdsRelat) Do
    Begin
      FieldName     := 'AGG_TOTCOMNF';
      DataSet       := cdsRelat;
      Expression    := 'SUM(TOTCOMNF)';
      IndexName     := 'IDX_001';
      GroupingLevel := intGruLev;
      Active        := True;
    End;

    With TAggregateField.Create(cdsRelat) Do
    Begin
      FieldName     := 'AGG_TOTITETR';
      DataSet       := cdsRelat;
      Expression    := 'SUM(TOTITETR)';
      IndexName     := 'IDX_001';
      GroupingLevel := intGruLev;
      Active        := True;
    End;

    With TAggregateField.Create(cdsRelat) Do
    Begin
      FieldName     := 'AGG_TOTCOMTR';
      DataSet       := cdsRelat;
      Expression    := 'SUM(TOTCOMTR)';
      IndexName     := 'IDX_001';
      GroupingLevel := intGruLev;
      Active        := True;
    End;

    With TAggregateField.Create(cdsRelat) Do
    Begin
      FieldName     := 'AGG_TOTITEOU';
      DataSet       := cdsRelat;
      Expression    := 'SUM(TOTITEOU)';
      IndexName     := 'IDX_001';
      GroupingLevel := intGruLev;
      Active        := True;
    End;

    With TAggregateField.Create(cdsRelat) Do
    Begin
      FieldName     := 'AGG_TOTCOMOU';
      DataSet       := cdsRelat;
      Expression    := 'SUM(TOTCOMOU)';
      IndexName     := 'IDX_001';
      GroupingLevel := intGruLev;
      Active        := True;
    End;

    If cbxVendedor.ItemIndex in [4,5] Then // SUPEVISOR GERAL/REGIONAL
    Begin

      With TAggregateField.Create(cdsRelat) Do
      Begin
        FieldName     := 'AGG_PERCOM';
        DataSet       := cdsRelat;
        Expression    := '(SUM(OPECOM) / SUM(TOTITE)) * 100';
        IndexName     := 'IDX_001';
        GroupingLevel := intGruLev;
        Active        := True;
      End;

      With TAggregateField.Create(cdsRelat) Do
      Begin
        FieldName     := 'AGG_TOTCOM';
        DataSet       := cdsRelat;
        Expression    := 'SUM(OPECOM)';
        IndexName     := 'IDX_001';
        GroupingLevel := intGruLev;
        Active        := True;
      End;

    End
    Else

    Case StrToInt(edtOpcao.Text) Of
      1: Case cbxVendedor.ItemIndex Of
           0,
           2: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(TOTCOM) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(TOTCOM)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;

           1: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(TOTCO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(TOTCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;

           3: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(TOTREP) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(TOTREP)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
         End;

      2,
      11:Case cbxVendedor.ItemIndex Of
           0,
           2: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(OPECOM - OPECO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(OPECOM - OPECO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
           1: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(OPECO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(OPECO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;

           3: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(OPECOM) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(OPECOM)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
         End;

      3: Case cbxVendedor.ItemIndex Of
           0,
           2: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(ITECOM - ITECO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(ITECOM - ITECO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
           1: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(ITECO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(ITECO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
           3: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(ITECOM) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(ITECOM)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
         End;

      4: Case cbxVendedor.ItemIndex Of
           0,
           2: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(FORCOM - FORCO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(FORCOM - FORCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
           1,
           3: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(FORCOM) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(FORCOM)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
         End;

      5: Case cbxVendedor.ItemIndex Of
           0,
           2: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(MARCOM - MARCO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(MARCOM - MARCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;

           1,
           3: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(MARCO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(MARCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
         End;
      6,
      9: Case cbxVendedor.ItemIndex Of
           0,
           2: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(DESCOM - DESCO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(DESCOM - DESCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;

           1,
           3: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(DESCO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(DESCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
         End;

      7: Case cbxVendedor.ItemIndex Of
           0,
           2: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(TBPCOM - TBPCO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(TBPCOM - TBPCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

               End;
           1,
           3: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(TBPCO2) / SUM(TOTITE) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(TBPCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
         End;

      8,
     13: Case cbxVendedor.ItemIndex Of
           0,
           2: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(LUCCOM - LUCCO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(LUCCOM - LUCCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
           1,
           3: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(LUCCO2) / SUM(TOTITE)) * 100';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(LUCCO2)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
         End;

      12:Case cbxVendedor.ItemIndex Of
           0,
           2: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(TOTCOM) * 100) / SUM(TOTITE)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(TOTCOM)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;

           1,
           3: Begin

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_PERCOM';
                  DataSet       := cdsRelat;
                  Expression    := '(SUM(TOTCOM) * 100) / SUM(TOTITE)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

                With TAggregateField.Create(cdsRelat) Do
                Begin
                  FieldName     := 'AGG_TOTCOM';
                  DataSet       := cdsRelat;
                  Expression    := 'SUM(TOTCOM)';
                  IndexName     := 'IDX_001';
                  GroupingLevel := intGruLev;
                  Active        := True;
                End;

              End;
         End;

    End;

    AggregatesActive := True;
  End;

End;

function TfrmRelFatComVendedor.fCaseCodSer: String;
begin
  Result := ' CASE WHEN IDESER = "01" THEN GER_CODS01 ';
  Result := Result + ' WHEN IDESER = "02" THEN GER_CODS02 ';
  Result := Result + ' WHEN IDESER = "03" THEN GER_CODS03 ';
  Result := Result + ' WHEN IDESER = "04" THEN GER_CODS04 ';
  Result := Result + ' WHEN IDESER = "05" THEN GER_CODS05 ';
  Result := Result + ' WHEN IDESER = "06" THEN GER_CODS06 ';
  Result := Result + ' WHEN IDESER = "07" THEN GER_CODS07 ';
  Result := Result + ' WHEN IDESER = "08" THEN GER_CODS08 ';
  Result := Result + ' WHEN IDESER = "09" THEN GER_CODS09 ';
  Result := Result + ' WHEN IDESER = "10" THEN GER_CODS10 ';
  Result := Result + ' WHEN IDESER = "11" THEN GER_CODS11 ';
  Result := Result + ' WHEN IDESER = "12" THEN GER_CODS12 ';
  Result := Result + ' WHEN IDESER = "13" THEN GER_CODS13 ';
  Result := Result + ' WHEN IDESER = "14" THEN GER_CODS14 ';
  Result := Result + ' WHEN IDESER = "15" THEN GER_CODS15 ';
  Result := Result + ' WHEN IDESER = "16" THEN GER_CODS16 ';
  Result := Result + ' WHEN IDESER = "17" THEN GER_CODS17 ';
  Result := Result + ' WHEN IDESER = "18" THEN GER_CODS18 ';
  Result := Result + ' WHEN IDESER = "19" THEN GER_CODS19 ';
  Result := Result + ' WHEN IDESER = "20" THEN GER_CODS20 ';
  Result := Result + ' WHEN IDESER = "21" THEN GER_CODS21 ';
  Result := Result + ' WHEN IDESER = "22" THEN GER_CODS22 ';
  Result := Result + ' WHEN IDESER = "23" THEN GER_CODS23 ';
  Result := Result + ' WHEN IDESER = "24" THEN GER_CODS24 ';
  Result := Result + ' WHEN IDESER = "25" THEN GER_CODS25 ';
  Result := Result + ' WHEN IDESER = "26" THEN GER_CODS26 ';
  Result := Result + ' WHEN IDESER = "27" THEN GER_CODS27 ';
  Result := Result + ' WHEN IDESER = "28" THEN GER_CODS28 ';
  Result := Result + ' WHEN IDESER = "29" THEN GER_CODS29 ';
  Result := Result + ' WHEN IDESER = "30" THEN GER_CODS30 END ';
end;

function TfrmRelFatComVendedor.fCaseDesSer: String;
begin
  Result := ' CASE WHEN IDESER = "01" THEN GER_DESS01 ';
  Result := Result + ' WHEN IDESER = "02" THEN GER_DESS02 ';
  Result := Result + ' WHEN IDESER = "03" THEN GER_DESS03 ';
  Result := Result + ' WHEN IDESER = "04" THEN GER_DESS04 ';
  Result := Result + ' WHEN IDESER = "05" THEN GER_DESS05 ';
  Result := Result + ' WHEN IDESER = "06" THEN GER_DESS06 ';
  Result := Result + ' WHEN IDESER = "07" THEN GER_DESS07 ';
  Result := Result + ' WHEN IDESER = "08" THEN GER_DESS08 ';
  Result := Result + ' WHEN IDESER = "09" THEN GER_DESS09 ';
  Result := Result + ' WHEN IDESER = "10" THEN GER_DESS10 ';
  Result := Result + ' WHEN IDESER = "11" THEN GER_DESS11 ';
  Result := Result + ' WHEN IDESER = "12" THEN GER_DESS12 ';
  Result := Result + ' WHEN IDESER = "13" THEN GER_DESS13 ';
  Result := Result + ' WHEN IDESER = "14" THEN GER_DESS14 ';
  Result := Result + ' WHEN IDESER = "15" THEN GER_DESS15 ';
  Result := Result + ' WHEN IDESER = "16" THEN GER_DESS16 ';
  Result := Result + ' WHEN IDESER = "17" THEN GER_DESS17 ';
  Result := Result + ' WHEN IDESER = "18" THEN GER_DESS18 ';
  Result := Result + ' WHEN IDESER = "19" THEN GER_DESS19 ';
  Result := Result + ' WHEN IDESER = "20" THEN GER_DESS20 ';
  Result := Result + ' WHEN IDESER = "21" THEN GER_DESS21 ';
  Result := Result + ' WHEN IDESER = "22" THEN GER_DESS22 ';
  Result := Result + ' WHEN IDESER = "23" THEN GER_DESS23 ';
  Result := Result + ' WHEN IDESER = "24" THEN GER_DESS24 ';
  Result := Result + ' WHEN IDESER = "25" THEN GER_DESS25 ';
  Result := Result + ' WHEN IDESER = "26" THEN GER_DESS26 ';
  Result := Result + ' WHEN IDESER = "27" THEN GER_DESS27 ';
  Result := Result + ' WHEN IDESER = "28" THEN GER_DESS28 ';
  Result := Result + ' WHEN IDESER = "29" THEN GER_DESS29 ';
  Result := Result + ' WHEN IDESER = "30" THEN GER_DESS30 END ';
end;

function TfrmRelFatComVendedor.fCaseQtdSer: String;
begin
  Result := ' CAST(CASE WHEN IDESER = "01" THEN GER_QTDS01 ';
  Result := Result + ' WHEN IDESER = "02" THEN GER_QTDS02 ';
  Result := Result + ' WHEN IDESER = "03" THEN GER_QTDS03 ';
  Result := Result + ' WHEN IDESER = "04" THEN GER_QTDS04 ';
  Result := Result + ' WHEN IDESER = "05" THEN GER_QTDS05 ';
  Result := Result + ' WHEN IDESER = "06" THEN GER_QTDS06 ';
  Result := Result + ' WHEN IDESER = "07" THEN GER_QTDS07 ';
  Result := Result + ' WHEN IDESER = "08" THEN GER_QTDS08 ';
  Result := Result + ' WHEN IDESER = "09" THEN GER_QTDS09 ';
  Result := Result + ' WHEN IDESER = "10" THEN GER_QTDS10 ';
  Result := Result + ' WHEN IDESER = "11" THEN GER_QTDS11 ';
  Result := Result + ' WHEN IDESER = "12" THEN GER_QTDS12 ';
  Result := Result + ' WHEN IDESER = "13" THEN GER_QTDS13 ';
  Result := Result + ' WHEN IDESER = "14" THEN GER_QTDS14 ';
  Result := Result + ' WHEN IDESER = "15" THEN GER_QTDS15 ';
  Result := Result + ' WHEN IDESER = "16" THEN GER_QTDS16 ';
  Result := Result + ' WHEN IDESER = "17" THEN GER_QTDS17 ';
  Result := Result + ' WHEN IDESER = "18" THEN GER_QTDS18 ';
  Result := Result + ' WHEN IDESER = "19" THEN GER_QTDS19 ';
  Result := Result + ' WHEN IDESER = "20" THEN GER_QTDS20 ';
  Result := Result + ' WHEN IDESER = "21" THEN GER_QTDS21 ';
  Result := Result + ' WHEN IDESER = "22" THEN GER_QTDS22 ';
  Result := Result + ' WHEN IDESER = "23" THEN GER_QTDS23 ';
  Result := Result + ' WHEN IDESER = "24" THEN GER_QTDS24 ';
  Result := Result + ' WHEN IDESER = "25" THEN GER_QTDS25 ';
  Result := Result + ' WHEN IDESER = "26" THEN GER_QTDS26 ';
  Result := Result + ' WHEN IDESER = "27" THEN GER_QTDS27 ';
  Result := Result + ' WHEN IDESER = "28" THEN GER_QTDS28 ';
  Result := Result + ' WHEN IDESER = "29" THEN GER_QTDS29 ';
  Result := Result + ' WHEN IDESER = "30" THEN GER_QTDS30 END AS DECIMAL(12,2)) ';
end;

function TfrmRelFatComVendedor.fCaseValSer: String;
begin
  Result := ' CAST(IF( ';
  Result := Result + ' CASE WHEN IDESER = "01" THEN GER_IDES01 ';
  Result := Result + '      WHEN IDESER = "02" THEN GER_IDES02 ';
  Result := Result + '      WHEN IDESER = "03" THEN GER_IDES03 ';
  Result := Result + '      WHEN IDESER = "04" THEN GER_IDES04 ';
  Result := Result + '      WHEN IDESER = "05" THEN GER_IDES05 ';
  Result := Result + '      WHEN IDESER = "06" THEN GER_IDES06 ';
  Result := Result + '      WHEN IDESER = "07" THEN GER_IDES07 ';
  Result := Result + '      WHEN IDESER = "08" THEN GER_IDES08 ';
  Result := Result + '      WHEN IDESER = "09" THEN GER_IDES09 ';
  Result := Result + '      WHEN IDESER = "10" THEN GER_IDES10 ';
  Result := Result + '      WHEN IDESER = "11" THEN GER_IDES11 ';
  Result := Result + '      WHEN IDESER = "12" THEN GER_IDES12 ';
  Result := Result + '      WHEN IDESER = "13" THEN GER_IDES13 ';
  Result := Result + '      WHEN IDESER = "14" THEN GER_IDES14 ';
  Result := Result + '      WHEN IDESER = "15" THEN GER_IDES15 ';
  Result := Result + '      WHEN IDESER = "16" THEN GER_IDES16 ';
  Result := Result + '      WHEN IDESER = "17" THEN GER_IDES17 ';
  Result := Result + '      WHEN IDESER = "18" THEN GER_IDES18 ';
  Result := Result + '      WHEN IDESER = "19" THEN GER_IDES19 ';
  Result := Result + '      WHEN IDESER = "20" THEN GER_IDES20 ';
  Result := Result + '      WHEN IDESER = "21" THEN GER_IDES21 ';
  Result := Result + '      WHEN IDESER = "22" THEN GER_IDES22 ';
  Result := Result + '      WHEN IDESER = "23" THEN GER_IDES23 ';
  Result := Result + '      WHEN IDESER = "24" THEN GER_IDES24 ';
  Result := Result + '      WHEN IDESER = "25" THEN GER_IDES25 ';
  Result := Result + '      WHEN IDESER = "26" THEN GER_IDES26 ';
  Result := Result + '      WHEN IDESER = "27" THEN GER_IDES27 ';
  Result := Result + '      WHEN IDESER = "28" THEN GER_IDES28 ';
  Result := Result + '      WHEN IDESER = "29" THEN GER_IDES29 ';
  Result := Result + '      WHEN IDESER = "30" THEN GER_IDES30 END = "I", 0.00, ';

  Result := Result + ' CASE WHEN IDESER = "01" THEN GER_VALS01 ';
  Result := Result + '      WHEN IDESER = "02" THEN GER_VALS02 ';
  Result := Result + '      WHEN IDESER = "03" THEN GER_VALS03 ';
  Result := Result + '      WHEN IDESER = "04" THEN GER_VALS04 ';
  Result := Result + '      WHEN IDESER = "05" THEN GER_VALS05 ';
  Result := Result + '      WHEN IDESER = "06" THEN GER_VALS06 ';
  Result := Result + '      WHEN IDESER = "07" THEN GER_VALS07 ';
  Result := Result + '      WHEN IDESER = "08" THEN GER_VALS08 ';
  Result := Result + '      WHEN IDESER = "09" THEN GER_VALS09 ';
  Result := Result + '      WHEN IDESER = "10" THEN GER_VALS10 ';
  Result := Result + '      WHEN IDESER = "11" THEN GER_VALS11 ';
  Result := Result + '      WHEN IDESER = "12" THEN GER_VALS12 ';
  Result := Result + '      WHEN IDESER = "13" THEN GER_VALS13 ';
  Result := Result + '      WHEN IDESER = "14" THEN GER_VALS14 ';
  Result := Result + '      WHEN IDESER = "15" THEN GER_VALS15 ';
  Result := Result + '      WHEN IDESER = "16" THEN GER_VALS16 ';
  Result := Result + '      WHEN IDESER = "17" THEN GER_VALS17 ';
  Result := Result + '      WHEN IDESER = "18" THEN GER_VALS18 ';
  Result := Result + '      WHEN IDESER = "19" THEN GER_VALS19 ';
  Result := Result + '      WHEN IDESER = "20" THEN GER_VALS20 ';
  Result := Result + '      WHEN IDESER = "21" THEN GER_VALS21 ';
  Result := Result + '      WHEN IDESER = "22" THEN GER_VALS22 ';
  Result := Result + '      WHEN IDESER = "23" THEN GER_VALS23 ';
  Result := Result + '      WHEN IDESER = "24" THEN GER_VALS24 ';
  Result := Result + '      WHEN IDESER = "25" THEN GER_VALS25 ';
  Result := Result + '      WHEN IDESER = "26" THEN GER_VALS26 ';
  Result := Result + '      WHEN IDESER = "27" THEN GER_VALS27 ';
  Result := Result + '      WHEN IDESER = "28" THEN GER_VALS28 ';
  Result := Result + '      WHEN IDESER = "29" THEN GER_VALS29 ';
  Result := Result + '      WHEN IDESER = "30" THEN GER_VALS30 END) AS DECIMAL(12,2)) ';
end;

function TfrmRelFatComVendedor.fCaseVenSer: String;
begin
  Case cbxVendedor.ItemIndex Of
    0: begin
         Result := ' CASE WHEN IDESER = "01" THEN GER_VENS01 ';
         Result := Result + ' WHEN IDESER = "02" THEN GER_VENS02 ';
         Result := Result + ' WHEN IDESER = "03" THEN GER_VENS03 ';
         Result := Result + ' WHEN IDESER = "04" THEN GER_VENS04 ';
         Result := Result + ' WHEN IDESER = "05" THEN GER_VENS05 ';
         Result := Result + ' WHEN IDESER = "06" THEN GER_VENS06 ';
         Result := Result + ' WHEN IDESER = "07" THEN GER_VENS07 ';
         Result := Result + ' WHEN IDESER = "08" THEN GER_VENS08 ';
         Result := Result + ' WHEN IDESER = "09" THEN GER_VENS09 ';
         Result := Result + ' WHEN IDESER = "10" THEN GER_VENS10 ';
         Result := Result + ' WHEN IDESER = "11" THEN GER_VENS11 ';
         Result := Result + ' WHEN IDESER = "12" THEN GER_VENS12 ';
         Result := Result + ' WHEN IDESER = "13" THEN GER_VENS13 ';
         Result := Result + ' WHEN IDESER = "14" THEN GER_VENS14 ';
         Result := Result + ' WHEN IDESER = "15" THEN GER_VENS15 ';
         Result := Result + ' WHEN IDESER = "16" THEN GER_VENS16 ';
         Result := Result + ' WHEN IDESER = "17" THEN GER_VENS17 ';
         Result := Result + ' WHEN IDESER = "18" THEN GER_VENS18 ';
         Result := Result + ' WHEN IDESER = "19" THEN GER_VENS19 ';
         Result := Result + ' WHEN IDESER = "20" THEN GER_VENS20 ';
         Result := Result + ' WHEN IDESER = "21" THEN GER_VENS21 ';
         Result := Result + ' WHEN IDESER = "22" THEN GER_VENS22 ';
         Result := Result + ' WHEN IDESER = "23" THEN GER_VENS23 ';
         Result := Result + ' WHEN IDESER = "24" THEN GER_VENS24 ';
         Result := Result + ' WHEN IDESER = "25" THEN GER_VENS25 ';
         Result := Result + ' WHEN IDESER = "26" THEN GER_VENS26 ';
         Result := Result + ' WHEN IDESER = "27" THEN GER_VENS27 ';
         Result := Result + ' WHEN IDESER = "28" THEN GER_VENS28 ';
         Result := Result + ' WHEN IDESER = "29" THEN GER_VENS29 ';
         Result := Result + ' WHEN IDESER = "30" THEN GER_VENS30 END ';
       end;

    1: begin
         Result := ' CASE WHEN IDESER = "01" THEN GER_VE2S01 ';
         Result := Result + ' WHEN IDESER = "02" THEN GER_VE2S02 ';
         Result := Result + ' WHEN IDESER = "03" THEN GER_VE2S03 ';
         Result := Result + ' WHEN IDESER = "04" THEN GER_VE2S04 ';
         Result := Result + ' WHEN IDESER = "05" THEN GER_VE2S05 ';
         Result := Result + ' WHEN IDESER = "06" THEN GER_VE2S06 ';
         Result := Result + ' WHEN IDESER = "07" THEN GER_VE2S07 ';
         Result := Result + ' WHEN IDESER = "08" THEN GER_VE2S08 ';
         Result := Result + ' WHEN IDESER = "09" THEN GER_VE2S09 ';
         Result := Result + ' WHEN IDESER = "10" THEN GER_VE2S10 ';
         Result := Result + ' WHEN IDESER = "11" THEN GER_VE2S11 ';
         Result := Result + ' WHEN IDESER = "12" THEN GER_VE2S12 ';
         Result := Result + ' WHEN IDESER = "13" THEN GER_VE2S13 ';
         Result := Result + ' WHEN IDESER = "14" THEN GER_VE2S14 ';
         Result := Result + ' WHEN IDESER = "15" THEN GER_VE2S15 ';
         Result := Result + ' WHEN IDESER = "16" THEN GER_VE2S16 ';
         Result := Result + ' WHEN IDESER = "17" THEN GER_VE2S17 ';
         Result := Result + ' WHEN IDESER = "18" THEN GER_VE2S18 ';
         Result := Result + ' WHEN IDESER = "19" THEN GER_VE2S19 ';
         Result := Result + ' WHEN IDESER = "20" THEN GER_VE2S20 ';
         Result := Result + ' WHEN IDESER = "21" THEN GER_VE2S21 ';
         Result := Result + ' WHEN IDESER = "22" THEN GER_VE2S22 ';
         Result := Result + ' WHEN IDESER = "23" THEN GER_VE2S23 ';
         Result := Result + ' WHEN IDESER = "24" THEN GER_VE2S24 ';
         Result := Result + ' WHEN IDESER = "25" THEN GER_VE2S25 ';
         Result := Result + ' WHEN IDESER = "26" THEN GER_VE2S26 ';
         Result := Result + ' WHEN IDESER = "27" THEN GER_VE2S27 ';
         Result := Result + ' WHEN IDESER = "28" THEN GER_VE2S28 ';
         Result := Result + ' WHEN IDESER = "29" THEN GER_VE2S29 ';
         Result := Result + ' WHEN IDESER = "30" THEN GER_VE2S30 END ';
       end;

    2: Result := ' NULL ';
    3: Result := ' NULL ';
    4: Result := ' NULL ';
    5: Result := ' NULL ';
  End;
end;

function TfrmRelFatComVendedor.fCaseCusSer: String;
begin
  Result := ' CAST(CASE WHEN IDESER = "01" THEN GER_CUSS01 ';
  Result := Result + ' WHEN IDESER = "02" THEN GER_CUSS02 ';
  Result := Result + ' WHEN IDESER = "03" THEN GER_CUSS03 ';
  Result := Result + ' WHEN IDESER = "04" THEN GER_CUSS04 ';
  Result := Result + ' WHEN IDESER = "05" THEN GER_CUSS05 ';
  Result := Result + ' WHEN IDESER = "06" THEN GER_CUSS06 ';
  Result := Result + ' WHEN IDESER = "07" THEN GER_CUSS07 ';
  Result := Result + ' WHEN IDESER = "08" THEN GER_CUSS08 ';
  Result := Result + ' WHEN IDESER = "09" THEN GER_CUSS09 ';
  Result := Result + ' WHEN IDESER = "10" THEN GER_CUSS10 ';
  Result := Result + ' WHEN IDESER = "11" THEN GER_CUSS11 ';
  Result := Result + ' WHEN IDESER = "12" THEN GER_CUSS12 ';
  Result := Result + ' WHEN IDESER = "13" THEN GER_CUSS13 ';
  Result := Result + ' WHEN IDESER = "14" THEN GER_CUSS14 ';
  Result := Result + ' WHEN IDESER = "15" THEN GER_CUSS15 ';
  Result := Result + ' WHEN IDESER = "16" THEN GER_CUSS16 ';
  Result := Result + ' WHEN IDESER = "17" THEN GER_CUSS17 ';
  Result := Result + ' WHEN IDESER = "18" THEN GER_CUSS18 ';
  Result := Result + ' WHEN IDESER = "19" THEN GER_CUSS19 ';
  Result := Result + ' WHEN IDESER = "20" THEN GER_CUSS20 ';
  Result := Result + ' WHEN IDESER = "21" THEN GER_CUSS21 ';
  Result := Result + ' WHEN IDESER = "22" THEN GER_CUSS22 ';
  Result := Result + ' WHEN IDESER = "23" THEN GER_CUSS23 ';
  Result := Result + ' WHEN IDESER = "24" THEN GER_CUSS24 ';
  Result := Result + ' WHEN IDESER = "25" THEN GER_CUSS25 ';
  Result := Result + ' WHEN IDESER = "26" THEN GER_CUSS26 ';
  Result := Result + ' WHEN IDESER = "27" THEN GER_CUSS27 ';
  Result := Result + ' WHEN IDESER = "28" THEN GER_CUSS28 ';
  Result := Result + ' WHEN IDESER = "29" THEN GER_CUSS29 ';
  Result := Result + ' WHEN IDESER = "30" THEN GER_CUSS30 END AS DECIMAL(12,2)) ';
end;

function TfrmRelFatComVendedor.fTabIdeSer: String;
begin
  Result := 'SELECT 1 AS IDESER UNION ';
  Result := Result + ' SELECT 2 AS IDESER UNION ';
  Result := Result + ' SELECT 3 AS IDESER UNION ';
  Result := Result + ' SELECT 4 AS IDESER UNION ';
  Result := Result + ' SELECT 5 AS IDESER UNION ';
  Result := Result + ' SELECT 6 AS IDESER UNION ';
  Result := Result + ' SELECT 7 AS IDESER UNION ';
  Result := Result + ' SELECT 8 AS IDESER UNION ';
  Result := Result + ' SELECT 9 AS IDESER UNION ';
  Result := Result + ' SELECT 10 AS IDESER UNION ';
  Result := Result + ' SELECT 11 AS IDESER UNION ';
  Result := Result + ' SELECT 12 AS IDESER UNION ';
  Result := Result + ' SELECT 13 AS IDESER UNION ';
  Result := Result + ' SELECT 14 AS IDESER UNION ';
  Result := Result + ' SELECT 15 AS IDESER UNION ';
  Result := Result + ' SELECT 16 AS IDESER UNION ';
  Result := Result + ' SELECT 17 AS IDESER UNION ';
  Result := Result + ' SELECT 18 AS IDESER UNION ';
  Result := Result + ' SELECT 19 AS IDESER UNION ';
  Result := Result + ' SELECT 20 AS IDESER UNION ';
  Result := Result + ' SELECT 21 AS IDESER UNION ';
  Result := Result + ' SELECT 22 AS IDESER UNION ';
  Result := Result + ' SELECT 23 AS IDESER UNION ';
  Result := Result + ' SELECT 24 AS IDESER UNION ';
  Result := Result + ' SELECT 25 AS IDESER UNION ';
  Result := Result + ' SELECT 26 AS IDESER UNION ';
  Result := Result + ' SELECT 27 AS IDESER UNION ';
  Result := Result + ' SELECT 28 AS IDESER UNION ';
  Result := Result + ' SELECT 29 AS IDESER UNION ';
  Result := Result + ' SELECT 30 AS IDESER ';
end;

function TfrmRelFatComVendedor.fTemRegSerMov: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Text := 'SELECT COUNT(*) FROM SERMOV';
    qryGen.Open;

    Result := (qryGen.Fields[0].Value > 0);

    qryGen.Close;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmRelFatComVendedor.fUsaVen2: Boolean;
begin
  Result := (fCfgSis('REPVEN', varBoolean)) And (fCfgSis('TAXREP', varDouble) <> 0.00) And (fCfgSis('TAXREP', varDouble) <> 100);
end;

function TfrmRelFatComVendedor.fCaseIdeSer: String;
begin
  Result := ' CASE WHEN IDESER = "01" THEN GER_CODS01 ';
  Result := Result + ' WHEN IDESER = "02" THEN GER_CODS02 ';
  Result := Result + ' WHEN IDESER = "03" THEN GER_CODS03 ';
  Result := Result + ' WHEN IDESER = "04" THEN GER_CODS04 ';
  Result := Result + ' WHEN IDESER = "05" THEN GER_CODS05 ';
  Result := Result + ' WHEN IDESER = "06" THEN GER_CODS06 ';
  Result := Result + ' WHEN IDESER = "07" THEN GER_CODS07 ';
  Result := Result + ' WHEN IDESER = "08" THEN GER_CODS08 ';
  Result := Result + ' WHEN IDESER = "09" THEN GER_CODS09 ';
  Result := Result + ' WHEN IDESER = "10" THEN GER_CODS10 ';
  Result := Result + ' WHEN IDESER = "11" THEN GER_CODS11 ';
  Result := Result + ' WHEN IDESER = "12" THEN GER_CODS12 ';
  Result := Result + ' WHEN IDESER = "13" THEN GER_CODS13 ';
  Result := Result + ' WHEN IDESER = "14" THEN GER_CODS14 ';
  Result := Result + ' WHEN IDESER = "15" THEN GER_CODS15 ';
  Result := Result + ' WHEN IDESER = "16" THEN GER_CODS16 ';
  Result := Result + ' WHEN IDESER = "17" THEN GER_CODS17 ';
  Result := Result + ' WHEN IDESER = "18" THEN GER_CODS18 ';
  Result := Result + ' WHEN IDESER = "19" THEN GER_CODS19 ';
  Result := Result + ' WHEN IDESER = "20" THEN GER_CODS20 ';
  Result := Result + ' WHEN IDESER = "21" THEN GER_CODS21 ';
  Result := Result + ' WHEN IDESER = "22" THEN GER_CODS22 ';
  Result := Result + ' WHEN IDESER = "23" THEN GER_CODS23 ';
  Result := Result + ' WHEN IDESER = "24" THEN GER_CODS24 ';
  Result := Result + ' WHEN IDESER = "25" THEN GER_CODS25 ';
  Result := Result + ' WHEN IDESER = "26" THEN GER_CODS26 ';
  Result := Result + ' WHEN IDESER = "27" THEN GER_CODS27 ';
  Result := Result + ' WHEN IDESER = "28" THEN GER_CODS28 ';
  Result := Result + ' WHEN IDESER = "29" THEN GER_CODS29 ';
  Result := Result + ' WHEN IDESER = "30" THEN GER_CODS30 END ';
end;

function TfrmRelFatComVendedor.fCaseComSer: String;
begin
  Case cbxVendedor.ItemIndex Of
    0: begin
         Result := ' CASE WHEN IDESER = "01" THEN GER_CMVS01 ';
         Result := Result + ' WHEN IDESER = "02" THEN GER_CMVS02 ';
         Result := Result + ' WHEN IDESER = "03" THEN GER_CMVS03 ';
         Result := Result + ' WHEN IDESER = "04" THEN GER_CMVS04 ';
         Result := Result + ' WHEN IDESER = "05" THEN GER_CMVS05 ';
         Result := Result + ' WHEN IDESER = "06" THEN GER_CMVS06 ';
         Result := Result + ' WHEN IDESER = "07" THEN GER_CMVS07 ';
         Result := Result + ' WHEN IDESER = "08" THEN GER_CMVS08 ';
         Result := Result + ' WHEN IDESER = "09" THEN GER_CMVS09 ';
         Result := Result + ' WHEN IDESER = "10" THEN GER_CMVS10 ';
         Result := Result + ' WHEN IDESER = "11" THEN GER_CMVS11 ';
         Result := Result + ' WHEN IDESER = "12" THEN GER_CMVS12 ';
         Result := Result + ' WHEN IDESER = "13" THEN GER_CMVS13 ';
         Result := Result + ' WHEN IDESER = "14" THEN GER_CMVS14 ';
         Result := Result + ' WHEN IDESER = "15" THEN GER_CMVS15 ';
         Result := Result + ' WHEN IDESER = "16" THEN GER_CMVS16 ';
         Result := Result + ' WHEN IDESER = "17" THEN GER_CMVS17 ';
         Result := Result + ' WHEN IDESER = "18" THEN GER_CMVS18 ';
         Result := Result + ' WHEN IDESER = "19" THEN GER_CMVS19 ';
         Result := Result + ' WHEN IDESER = "20" THEN GER_CMVS20 ';
         Result := Result + ' WHEN IDESER = "21" THEN GER_CMVS21 ';
         Result := Result + ' WHEN IDESER = "22" THEN GER_CMVS22 ';
         Result := Result + ' WHEN IDESER = "23" THEN GER_CMVS23 ';
         Result := Result + ' WHEN IDESER = "24" THEN GER_CMVS24 ';
         Result := Result + ' WHEN IDESER = "25" THEN GER_CMVS25 ';
         Result := Result + ' WHEN IDESER = "26" THEN GER_CMVS26 ';
         Result := Result + ' WHEN IDESER = "27" THEN GER_CMVS27 ';
         Result := Result + ' WHEN IDESER = "28" THEN GER_CMVS28 ';
         Result := Result + ' WHEN IDESER = "29" THEN GER_CMVS29 ';
         Result := Result + ' WHEN IDESER = "30" THEN GER_CMVS30 END ';
       end;

    1: begin
         Result := ' CASE WHEN IDESER = "01" THEN GER_CV2S01 ';
         Result := Result + ' WHEN IDESER = "02" THEN GER_CV2S02 ';
         Result := Result + ' WHEN IDESER = "03" THEN GER_CV2S03 ';
         Result := Result + ' WHEN IDESER = "04" THEN GER_CV2S04 ';
         Result := Result + ' WHEN IDESER = "05" THEN GER_CV2S05 ';
         Result := Result + ' WHEN IDESER = "06" THEN GER_CV2S06 ';
         Result := Result + ' WHEN IDESER = "07" THEN GER_CV2S07 ';
         Result := Result + ' WHEN IDESER = "08" THEN GER_CV2S08 ';
         Result := Result + ' WHEN IDESER = "09" THEN GER_CV2S09 ';
         Result := Result + ' WHEN IDESER = "10" THEN GER_CV2S10 ';
         Result := Result + ' WHEN IDESER = "11" THEN GER_CV2S11 ';
         Result := Result + ' WHEN IDESER = "12" THEN GER_CV2S12 ';
         Result := Result + ' WHEN IDESER = "13" THEN GER_CV2S13 ';
         Result := Result + ' WHEN IDESER = "14" THEN GER_CV2S14 ';
         Result := Result + ' WHEN IDESER = "15" THEN GER_CV2S15 ';
         Result := Result + ' WHEN IDESER = "16" THEN GER_CV2S16 ';
         Result := Result + ' WHEN IDESER = "17" THEN GER_CV2S17 ';
         Result := Result + ' WHEN IDESER = "18" THEN GER_CV2S18 ';
         Result := Result + ' WHEN IDESER = "19" THEN GER_CV2S19 ';
         Result := Result + ' WHEN IDESER = "20" THEN GER_CV2S20 ';
         Result := Result + ' WHEN IDESER = "21" THEN GER_CV2S21 ';
         Result := Result + ' WHEN IDESER = "22" THEN GER_CV2S22 ';
         Result := Result + ' WHEN IDESER = "23" THEN GER_CV2S23 ';
         Result := Result + ' WHEN IDESER = "24" THEN GER_CV2S24 ';
         Result := Result + ' WHEN IDESER = "25" THEN GER_CV2S25 ';
         Result := Result + ' WHEN IDESER = "26" THEN GER_CV2S26 ';
         Result := Result + ' WHEN IDESER = "27" THEN GER_CV2S27 ';
         Result := Result + ' WHEN IDESER = "28" THEN GER_CV2S28 ';
         Result := Result + ' WHEN IDESER = "29" THEN GER_CV2S29 ';
         Result := Result + ' WHEN IDESER = "30" THEN GER_CV2S30 END ';
       end;

    2: Result := ' 0 ';
    3: Result := ' 0 ';
    4: Result := ' 0 ';
    5: Result := ' 0 ';
  End;


end;

procedure TfrmRelFatComVendedor.pExportarPDFParaCadaVendedor(qckRel: TfrxReport);
  Var
    stlVend : TStringList;
    intCnt : Integer;
begin
  stlVend := TStringList.Create;
  Try
    cdsRelat.First;
    While Not cdsRelat.Eof Do
    Begin
      If stlVend.IndexOF(cdsRelat.FieldByName('CODVEN').AsString) < 0 Then
        stlVend.Add(cdsRelat.FieldByName('CODVEN').AsString);
      cdsRelat.Next;
    End;

    frxExpPDF.DefaultPath := edtDirPDF.Text + '\';
    frxExpPDF.ShowDialog := False;
    frxExpPDF.ShowProgress := False;
    frxExpPDF.OverwritePrompt := False;

    prbProgresso.Max := stlVend.Count;
    prbProgresso.Position := 0;
    Application.ProcessMessages;

    For intCnt := 0 To stlVend.Count-1 Do
    Begin
      prbProgresso.StepBy(1);
      Application.ProcessMessages;

      cdsRelat.Filter := 'CODVEN = ' + QuotedStr(stlVend.Strings[intCnt]);
      cdsRelat.Filtered := True;
      Try
        frxExpPDF.FileName := stlVend.Strings[intCnt] + '.pdf';
        If (qckRel.PrepareReport()) Then
          qckRel.Export(frxExpPDF);
      Finally
        cdsRelat.Filtered := False;
        cdsRelat.Filter := '';
      End;
    End;

    fMensagem('ATENÇÃO', 'Exportação para PDF concluída!' + sLineBreak +
                         frxExpPDF.DefaultPath, ['&Ok']);
    prbProgresso.Position := 0;
  Finally
    FreeAndNil(stlVend);
  End;
end;

function TfrmRelFatComVendedor.fRetTabPreSelChkLis(ChkLis: TCheckListBox): String;

  function fRetSomenteNumeros(strTexto: String): String;
    Var
      intIndex: Integer;
  begin
    Result := '';

    If Not fEmptyStr(strTexto) Then
    Begin
      For intIndex := 1 To Length(strTexto) Do
        If CharInSet(strTexto[intIndex], ['0'..'9']) Then
          Result := Result + strTexto[intIndex];
    End;
  end;

  function fVirgula(strAux: String): String;
  begin
    If Not fEmptyStr(strAux) Then
      Result := ', ';
  end;

  Var
    intIndex: Integer;
Begin
  Result := '';
  For intIndex := 0 To ChkLis.Items.Count - 1 Do
    If ChkLis.Checked[intIndex] Then
      Result := Result + fVirgula(Result) + fRetSomenteNumeros(ChkLis.Items[intIndex]);
end;

procedure TfrmRelFatComVendedor.pCarregaChkLisTabPre(Var ChkLis: TCheckListBox);
  Var
    intIndex: Integer;
Begin
  ChkLis.Items.Clear;
  For intIndex := 1 To Length(VS_strTabPrc) Do
    If VS_strTabPrc[intIndex] = 'S' Then
      ChkLis.Items.Add('Tabela ' + IntToStr(intIndex));
end;

end.
