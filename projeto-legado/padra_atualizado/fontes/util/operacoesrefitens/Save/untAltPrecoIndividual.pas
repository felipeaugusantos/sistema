unit untAltPrecoIndividual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, DB, ComCtrls, StrUtils, QColorLabel, Uni,
  AppEvnts,  DBCtrls, DBEditFocus, UniClientDataSet, untSalvaDadosInterface,
  untFatorPreco, ComboBoxFocus, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untFuncoesRel2, TypesRel,
  cxProgressBar, Datasnap.DBClient, untTypesSistema, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, cxEditRepositoryItems, cxDBEditRepository;

type
  TRecTabPrecos = Record
    fltPreVen: Double;
    fltMarBru: Double;
    blnPreVen: Boolean;
    blnMarBru: Boolean;
  End;

  TColunasNovas = Record
    blnHabili: Boolean;
    strNomCam: String;
  End;

  TCampo = Record
    Title,
    FieldName: String;
    ReadOnly,
    Visible: Boolean;
    Properties: TcxCustomEditProperties;
  End;

  TArrCampos = Array Of TCampo;

type
  TfrmAltPrecoIndividual = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    lblFornec: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtCodMar: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesGru: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    pgbStatus: TProgressBar;
    pnlProdutos: TPanel;
    pnlFiltros: TPanel;
    chkCODITE: TCheckBox;
    chkDesIte: TCheckBox;
    chkRefere: TCheckBox;
    chkPreCom: TCheckBox;
    chkDesF01: TCheckBox;
    chkDesF02: TCheckBox;
    chkDesF03: TCheckBox;
    chkDesF04: TCheckBox;
    chkDesF05: TCheckBox;
    chkDesF06: TCheckBox;
    chkIcmEnt: TCheckBox;
    chkIpient: TCheckBox;
    chkFreEnt: TCheckBox;
    chkAcrFin: TCheckBox;
    chkSubsti: TCheckBox;
    chkPreCus: TCheckBox;
    chkIcmSai: TCheckBox;
    chkDesMax: TCheckBox;
    chkMarBr1: TCheckBox;
    chkPreVe1: TCheckBox;
    chkMarBr2: TCheckBox;
    chkPreVe2: TCheckBox;
    rdgTipAlt: TRadioGroup;
    chkArrMai: TCheckBox;
    chkMarBr3: TCheckBox;
    chkPreVe3: TCheckBox;
    chkMarMin: TCheckBox;
    chkDesOpe: TCheckBox;
    ChkCodAbf: TCheckBox;
    Label7: TLabel;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    Label9: TLabel;
    edtStatus: TEditFocus;
    ColorLabel1: TColorLabel;
    chkIteAti: TCheckBox;
    ChkClaIpi: TCheckBox;
    chkImpFed: TCheckBox;
    chkLocFis: TCheckBox;
    chkMarBr4: TCheckBox;
    chkPreVe4: TCheckBox;
    chkDesMGe: TCheckBox;
    chkMltCom: TCheckBox;
    chkCodFab: TCheckBox;
    chkMarBr5: TCheckBox;
    chkPreVe5: TCheckBox;
    chkMarBr6: TCheckBox;
    chkPreVe6: TCheckBox;
    pnlRodape: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    dbeRefere: TDBEditFocus;
    dbeUnidad: TDBEditFocus;
    chkQtpPro: TCheckBox;
    chkCprCen: TCheckBox;
    chkValFre: TCheckBox;
    chkMarBr7: TCheckBox;
    chkPreVe7: TCheckBox;
    chkDesAdb: TCheckBox;
    chkPreLiq: TCheckBox;
    Label14: TLabel;
    dbeAltPre: TDBEditFocus;
    chkSubFed: TCheckBox;
    chkOutVal: TCheckBox;
    chkComTb1: TCheckBox;
    chkComTb2: TCheckBox;
    chkComTb3: TCheckBox;
    chkComTb4: TCheckBox;
    chkComTb5: TCheckBox;
    chkComTb6: TCheckBox;
    chkComTb7: TCheckBox;
    chkTmpGar: TCheckBox;
    pnlBusca: TPanel;
    chkPesoIt: TCheckBox;
    chkInflam: TCheckBox;
    chkNvlGir: TCheckBox;
    edtClaIpi: TEditFocus;
    lbl1: TLabel;
    cdsDuplic: TUniClientDataSet;
    qryDuplicCODITE: TStringField;
    qryDuplicDESITE: TStringField;
    qryDuplicCODFAB: TStringField;
    qryDuplicCODBAR: TStringField;
    qryDuplicBAREMB: TStringField;
    qryDuplicORIGEM: TStringField;
    qryDuplicCODEMP: TStringField;
    qryDuplicCODFOR: TStringField;
    chkCodUni: TCheckBox;
    chkCodMar: TCheckBox;
    chkCodFor: TCheckBox;
    chkDiaFor: TCheckBox;
    chkComVar: TCheckBox;
    chkComAta: TCheckBox;
    chkTamLcF: TCheckBox;
    chkComPro: TCheckBox;
    chkLocSup: TCheckBox;
    chkTamLcS: TCheckBox;
    chkCodDep: TCheckBox;
    chkAbfPis: TCheckBox;
    chkAbfCof: TCheckBox;
    chkAbfIpi: TCheckBox;
    lbl2: TLabel;
    lbl4: TLabel;
    edtDocumento: TEditFocus;
    lblEspecie: TLabel;
    edtEspecie: TEditFocus;
    lblSerie: TLabel;
    edtSerie: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    chkIPISai: TCheckBox;
    lblOrdem: TLabel;
    cbxOrdem: TComboBoxFocus;
    chkSaldos: TCheckBox;
    chkMltVen: TCheckBox;
    chkAcoObj: TCheckBox;
    chkEstMin: TCheckBox;
    chkEstMax: TCheckBox;
    chkAbaMlt: TCheckBox;
    chkObrCpf: TCheckBox;
    chkSitPro: TCheckBox;
    chkCodMon: TCheckBox;
    pnlCadMon: TPanel;
    lbl3: TLabel;
    edtCodMon: TEditFocus;
    edtDesMon: TEditFocus;
    lbl5: TLabel;
    chkValObr: TCheckBox;
    pnlFiltro2: TPanel;
    lbl6: TLabel;
    chkMinTb1: TCheckBox;
    chkMinTb2: TCheckBox;
    chkMinTb3: TCheckBox;
    chkMinTb4: TCheckBox;
    chkMinTb5: TCheckBox;
    chkMinTb6: TCheckBox;
    chkMinTb7: TCheckBox;
    chkObrNfe: TCheckBox;
    chkUniCom: TCheckBox;
    chkPreMed: TCheckBox;
    chkDtaAlt: TCheckBox;
    chkPr1Ant: TCheckBox;
    chkPr2Ant: TCheckBox;
    chkPr3Ant: TCheckBox;
    chkPr4Ant: TCheckBox;
    chkPr5Ant: TCheckBox;
    chkPr6Ant: TCheckBox;
    chkPr7Ant: TCheckBox;
    chkMarMSG: TCheckBox;
    chkMarMGe: TCheckBox;
    btnConfirmaAlt: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnProPag: TBitBtnLocked;
    btnExcel: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    chkPrdGru: TCheckBox;
    Label167: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    chkImpLis: TCheckBox;
    chkAtiCom: TCheckBox;
    chkComDis: TCheckBox;
    chkNotEsp: TCheckBox;
    Label1: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    chkUsaBon: TCheckBox;
    chkPesLiq: TCheckBox;
    Label50: TLabel;
    ColorLabel2: TColorLabel;
    edtIncPis: TEditFocus;
    chkCodDic: TCheckBox;
    chkTipPro: TCheckBox;
    chkObrIba: TCheckBox;
    chkPRapel: TCheckBox;
    chkPer_CI: TCheckBox;
    chkNumFCI: TCheckBox;
    chkImpUlt: TCheckBox;
    btnEstLoj: TBitBtnLocked;
    chkProEmb: TCheckBox;
    chkInfGar: TCheckBox;
    chkMesGir: TCheckBox;
    chkImpEti: TCheckBox;
    chkCodGru: TCheckBox;
    chkTipFre: TCheckBox;
    chkVlcFre: TCheckBox;
    Label5: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    chkReaEnd: TCheckBox;
    chkRastre: TCheckBox;
    chkCodLse: TCheckBox;
    chkFATCMP: TCheckBox;
    edtExcIpi: TEditFocus;
    lbl50: TLabel;
    chkExcIpi: TCheckBox;
    chkDensid: TCheckBox;
    chkDesMSu: TCheckBox;
    chkAlMaVi: TCheckBox;
    chkLaMaVi: TCheckBox;
    chkAltVid: TCheckBox;
    chkLarVid: TCheckBox;
    chkCdCest: TCheckBox;
    chkDtaVal: TCheckBox;
    chkMarId1: TCheckBox;
    chkMarId2: TCheckBox;
    chkMarId3: TCheckBox;
    chkMarId4: TCheckBox;
    chkMarId5: TCheckBox;
    chkMarId6: TCheckBox;
    chkMarId7: TCheckBox;
    chkCodOnu: TCheckBox;
    chkUsaFle: TCheckBox;
    shpMultSel: TShape;
    chkGruCmp: TCheckBox;
    cbxMarIde: TComboBoxFocus;
    cbxTabPrc: TComboBoxFocus;
    lblMarIde: TLabel;
    lblTabPrc: TLabel;
    chkRecDev: TCheckBox;
    cdsDuplicITEAGR: TStringField;
    chkUniTri: TCheckBox;
    chkFatUTr: TCheckBox;
    pnlAviso: TPanel;
    chkAplica: TCheckBox;
    chkPraMin: TCheckBox;
    chkCusRea: TCheckBox;
    chkPenRec: TCheckBox;
    chkUtiAmp: TCheckBox;
    chkLotePD: TCheckBox;
    chkOrdSer: TCheckBox;
    chkPesObr: TCheckBox;
    chkCpesOb: TCheckBox;
    chkNvlCri: TCheckBox;
    chkNivCri: TCheckBox;
    chkComDig: TCheckBox;
    chkClaCrm: TCheckBox;
    chkObrBar: TCheckBox;
    lblCodGpr: TLabel;
    edtCodGpr: TEditFocus;
    edtDesGpr: TEditFocus;
    chkDesCnd: TCheckBox;
    btnLimpaFiltros: TBitBtnLocked;
    cxgTiposAltLevel1: TcxGridLevel;
    cxgTiposAlt: TcxGrid;
    cxvTiposAlt: TcxGridDBBandedTableView;
    cxEditRepository: TcxEditRepository;
    cxeString16: TcxEditRepositoryTextItem;
    cxeString20: TcxEditRepositoryTextItem;
    cxeString02: TcxEditRepositoryTextItem;
    cxeString03: TcxEditRepositoryTextItem;
    cxeString05: TcxEditRepositoryTextItem;
    cxeString06: TcxEditRepositoryTextItem;
    cxeString07: TcxEditRepositoryTextItem;
    cxeString08: TcxEditRepositoryTextItem;
    cxeString10: TcxEditRepositoryTextItem;
    cxeString25: TcxEditRepositoryTextItem;
    cxeString30: TcxEditRepositoryTextItem;
    cxeString50: TcxEditRepositoryTextItem;
    cxeString70: TcxEditRepositoryTextItem;
    cxeString80: TcxEditRepositoryTextItem;
    cxeString255: TcxEditRepositoryTextItem;
    cxeLocFis: TcxEditRepositoryTextItem;
    cxeLocSup: TcxEditRepositoryTextItem;
    cxeTamLcf: TcxEditRepositoryTextItem;
    cxeLocSep: TcxEditRepositoryTextItem;
    cxeDate: TcxEditRepositoryDateItem;
    cxeInt03: TcxEditRepositoryCurrencyItem;
    cxeInt11: TcxEditRepositoryCurrencyItem;
    cmbSimNao: TcxEditRepositoryLookupComboBoxItem;
    cmbClaCRM: TcxEditRepositoryLookupComboBoxItem;
    cmbNivGir: TcxEditRepositoryComboBoxItem;
    cmbNivCri: TcxEditRepositoryComboBoxItem;
    cmbFrePFU: TcxEditRepositoryLookupComboBoxItem;
    cmbEsMiDg: TcxEditRepositoryLookupComboBoxItem;
    cxeMemo: TcxEditRepositoryMemoItem;
    cxeMasFat: TcxEditRepositoryTextItem;
    cxeDecUni: TcxEditRepositoryTextItem;
    cxeDec05: TcxEditRepositoryTextItem;
    cxeDec06: TcxEditRepositoryTextItem;
    cxeMasVal: TcxEditRepositoryTextItem;
    cxeMasPer: TcxEditRepositoryTextItem;
    cxeMasMar: TcxEditRepositoryTextItem;
    cxeMasInt: TcxEditRepositoryTextItem;
    cmbTipPro: TcxEditRepositoryLookupComboBoxItem;
    cxeConsTam8: TcxEditRepositoryTextItem;
    cxeConsTam6: TcxEditRepositoryTextItem;
    cxeConsTam5: TcxEditRepositoryTextItem;
    cxeConsTam3: TcxEditRepositoryTextItem;
    cxeConsTam4: TcxEditRepositoryTextItem;
    cxeConsTam2: TcxEditRepositoryTextItem;
    cxeClassfIPI: TcxEditRepositoryTextItem;
    cxStyleRepository: TcxStyleRepository;
    cxsCorAzul: TcxStyle;
    cxsCombo: TcxStyle;
    cxsAltera: TcxStyle;
    cxsConsulta: TcxStyle;
    cxeConsTam7: TcxEditRepositoryTextItem;
    cxeFatCom: TcxEditRepositoryCurrencyItem;

    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaAltClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure edtCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure edtStatusKeyPress(Sender: TObject; var Key: Char);
    procedure btnLocProxClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtDocumentoExit(Sender: TObject);
    procedure edtCodMonKeyPress(Sender: TObject; var Key: Char);
    procedure btnProPagClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtIncPisExit(Sender: TObject);
    procedure btnEstLojClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtExcIpiExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMonExit(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodAbrExit(Sender: TObject);
    procedure cbxMarIdeChange(Sender: TObject);
    procedure pInformaAplicacao;
    procedure edtCodGprExit(Sender: TObject);
    procedure edtCodGprKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimpaFiltrosClick(Sender: TObject);
    procedure cxvTiposAltCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvTiposAltEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxeConsTam2PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeFatComPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgTiposAltExit(Sender: TObject);
    procedure cxgTiposAltEnter(Sender: TObject);
  private
    { Private declarations }
    blnVidroInteiro,
    FAltera,
    blnBloPre,
    blnUtiAmp : Boolean;
    blnOrdSer : Boolean;
    strEstEmp : String;
    blnInfMat: Boolean;
    blnValFor: Boolean;

    intInfFed,
    intInfOpe,
    intInfSai: Integer;

    strLisCam: TStringList;
    strLisUsu: TStringList;

    arrCampos: TArrCampos;

    arrLinhaGrupo,
    arrMarca,
    arrFornec,
    arrGrupoPro,
    arrGruCmp,
    arrCodGpr,
    arrCodDep,
    arrCodMon,
    arrCodAbr,
    arrLinEmp,
    arrCodUni : TConsultasArray;

    strLinGru,
    strMarca ,
    strFornec,
    strPrdGru,
    strGruCmp,
    strCodGpr,
    strCodDep,
    strCodMon,
    strCodAbr,
    strCodUni: String;

    objFatPre: TFatorPreco;

    objSalInt: TSalvaInterface;

    qryAltPre: TUniQuery;
    qryConAbf: TUniQuery;
    qryConFor: TUniQuery;
    qryConMar: TUniQuery;
    qrySitPro: TUniQuery;
    qryCadMon: TUniQuery;
    qryConGru: TUniQuery;
    qryConUni: TUniQuery;
    qryAbfIcm: TUniQuery;
    qryPreAlt: TUniQuery;
    qryPrdGru: TUniQuery;
    qryCodDic: TUniQuery;
    qryCadLse: TUniQuery;

    strTabela       : String;
    intCustoVenda   : Integer;
    strCusto        : String;
    strVenda        : String;
    colColunas      : Array Of TColunasNovas;
    blnPreMat       : Boolean;

    intConfirmando: Integer;

    fltPreCus       : Double;
    blnPreCus       : Boolean;

    arrRecTabPrecos : Array[1..7] Of TRecTabPrecos;

    strValorFiltro: String;
    strCampoFiltro: String;

    {****************************}
    { QRY GENERICA P\ USO LOCAL  }
    {*************************JB*}
    qryGen : TUniQuery;
    dtsGen : TDatasource;

    blnPerComTabela: Boolean; //Percentual de comissao por tabela de preco
    blnIteTbp: Boolean;
    blnURapel : Boolean;
    blnMarIde : Boolean;
    blnUsaFle : Boolean;
    blnLotePD : Boolean;

    strTCOPRO: String;

    intSitPro: Integer;
    intLocFis,
    intLocSup,
    intTamLcf,
    intLocSep : Integer;

    cdsSimNao,
    cdsClaCrm,
    cdsFrePFU,
    cdsEsMiDg,
    cdsTipPro: TZClient;

    Procedure pCriaCdsSimNao;
    Procedure pCriaCdsClaCRM;
    Procedure pCriaCdsFrePFU;
    Procedure pCriaCdsEsMiDg;
    Procedure pCriaCdsTipPro;

    Procedure pSalvaPosicao;
    Procedure pRestauraPosicao;

    Procedure pSalvaPosicaoUsuario;
    Procedure pRestauraPosicaoUsuario;

    procedure pTravaPrecos;

    procedure pMostraEstoqueLojas;
    procedure pAtualizaIteger(qryGenIte, qryGenPre: TUniQuery; strEmpresas: String; blnResFor: Boolean);
    procedure pVerificaDireitoAcesso;
    Procedure pBuscaUltimaAlteraoPreco;
    procedure pExportaParaExcel;
    procedure pDesabilitaCamposFator;
    procedure pAtribuiTabelas;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pLimpaCampos;
    procedure pAtualizaTemporaria(blnFiltaAlterado: Boolean; strCampoOrdem: String);
    procedure pMostraColunasAntigas(blnHabilita: Boolean);
    procedure pMostraColunasAntigasCx(blnHabilita: Boolean);

    procedure pRecalculaPrecos;

    function fRetDesAbfPisCofIpi(strTabela, strCod: String): String;

    function fCheckBox(strNome: String): TCheckBox;

    Function fRetDescricaoCadastro(strNomCam, strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;

    Function fStrToFloatSelectedField: Double;
    function fSQLAlteracaoPreco: String;
    function fGravaDados: Boolean;
    function fGravaDadosAux(pgbProgresso: TcxProgressBar): Boolean;
    function fQtdRegistrosSelecionados: Integer;
    function fMontaGrid: Boolean;
    function fMontaGridAux(pgbProgresso: TcxProgressBar): Boolean;
    function fMarcaDesmarca(blnMarcar: Boolean): Boolean;

    function fRecalculaPreCusto: Boolean;
    function fRecalculaPreVendaOuMargem: Boolean;
    function fRecalculaPreLiq: Boolean;

    function fCalcularPrecoVenda(intTab: Integer): Boolean;
    function fCalcularMargemLucro(intTab: Integer): Boolean;

    Function fColunaAtiva(strCodCam: String): Boolean;

    Procedure pMontaGridAlterados(blnAltera: Boolean);
    Function fMontaGridAlterados(cxProgresso: TcxProgressBar): Boolean;

    procedure pCarregaSelecao;
    procedure pSalvaSelecao;

    procedure pBeforeInsert(Dataset: TDataset);
    procedure pAtualizaGrid(DataSet: TDataSet);
    procedure pBeforeScroll(Dataset: TDataset);
    procedure pConfirma;
    Procedure pRecalculaPrecosFator;

    function fInativarProduto: Boolean;
    procedure pAtualizaCprCenLojas(strCodIte, strCprCen: String; blnCprCenInd: Boolean);

    function fTemConsultaTabela(strNomCam: String): Boolean;

    function fQryGen(strCampo: String): TField;
    function fEhCampoPrecoVenda(strCampo: String; Var intTabela: Integer): Boolean;
    function fEhCampoComissao(strCampo: String; Var intTabela: Integer): Boolean;
    function fEhCampoVendaOutras(strNomCam: String): Boolean;
    function fVerificaDuplic: Integer;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pAdicionaDuplic(strOri: String; qryAdic: TUniQuery; strItemAgrupamento: string);
    procedure pAtualizaDadosDuplic;

    function fValidaAbfPisCofinsIpi(strTabela, strCampo: String): Boolean;
    procedure UpdateIteger(strNomCam: String; qryGenPre : TUniQuery);

    procedure pHabilitaCamposMargemIdeal;
    procedure pAtualizaPermiteFazerVenda(strCodIte, strCodEmp, strPeFave: String);
    function fAbreviacaoAlterada: Boolean;
    procedure pUpdateAbrvFiscalCadIte(strCodAbf, strCodIte: String);

    procedure pAdicionaColuna(strTitulo: String; intIndice: Integer; blnVisible: Boolean = True);

    Function fGetMaxWidhProper(proProperties: TcxCustomEditProperties): Integer;

    Procedure pMontaCampos;

  public
    { Public declarations }
  protected
    procedure pAtualizaDados(DataSet: TDataSet);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmAltPrecoIndividual: TfrmAltPrecoIndividual;

implementation

uses  untFuncoesSimples, untConstantes,  untPesqAux, untAltPrecoDigData,
      untParCalculaPrecoCusto, untSeqTmp, untBuscaCodFabrica, untPreAlt,
      untAltPrecoDuplicidades, untFuncoesAuxiliares, untConsultas, untTConfiguracao,
      untFatMostraEstoqueEmp,untGeraExcel, untAltEst, untAltDes, untGravando,
      untFuncoesConsulta, untObservacao, untProdMargemNegativa, dxCore,
      cxCurrencyEdit, cxTextEdit, cxDBLookupComboBox, cxDropDownEdit,
      untIcmsSTParteVenda;

{$R *.dfm}


Procedure TfrmAltPrecoIndividual.pMontaCampos;
  Var
    intContador: Integer;

   Procedure pAdicionaCampo(strNomCam, strTitulo: String; blnVisible: Boolean; proProperties: TcxCustomEditProperties = Nil);
   Begin
     Inc(intContador);
     With arrCampos[intContador] Do
     Begin
       FieldName  := strNomCam;
       Title      := strTitulo;
       Visible    := blnVisible;
       Properties := proProperties;
     End;
   End;

   Procedure pAdicinaDupla(strNomCam, strTitulo: String; proProperties: TcxCustomEditProperties = Nil);
   Begin
     pAdicionaCampo(strNomCam, strTitulo, False);
     pAdicionaCampo(strNomCam + '_NOV', 'Novo ' + strTitulo, True, proProperties);
   End;

Begin
  intContador := -1;
  SetLength(arrCampos, 326);

  pAdicionaCampo('ITE_CODITE', 'Cód.Item', True);
  pAdicionaCampo('ITE_DESITE', 'Descrição', True);
  pAdicionaCampo('ITE_REFERE', 'Referência', True);
  pAdicionaCampo('ITE_SALDOS', 'Saldo', True);
  pAdicionaCampo('ITE_IMPULT', 'Preço Últ.Compra+Imp.', True);
  pAdicionaCampo('ITE_PREMED', 'Preço Médio', True);
  pAdicionaCampo('ITE_DTAALT', 'Última Alteração Preço', True);
  pAdicionaCampo('ITE_PR1ANT', 'Preço Venda 1 Ant.', True);
  pAdicionaCampo('ITE_PR2ANT', 'Preço Venda 2 Ant.', True);
  pAdicionaCampo('ITE_PR3ANT', 'Preço Venda 3 Ant.', True);
  pAdicionaCampo('ITE_PR4ANT', 'Preço Venda 4 Ant.', True);
  pAdicionaCampo('ITE_PR5ANT', 'Preço Venda 5 Ant.', True);
  pAdicionaCampo('ITE_PR6ANT', 'Preço Venda 6 Ant.', True);
  pAdicionaCampo('ITE_PR7ANT', 'Preço Venda 7 Ant.', True);

  pAdicinaDupla('ITE_CLAIPI', 'NCM / Classif. IPI', cxeClassfIPI.Properties);
  pAdicinaDupla('ITE_EXCIPI', 'Código EX IPI');
  pAdicinaDupla('ITE_PER_CI', 'Percentual (CI)');
  pAdicinaDupla('ITE_NUMFCI', 'Nº Ficha (FCI)');
  pAdicinaDupla('ITE_ITEATI', 'Ativo?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_CODABF', 'Abreviação Fiscal', cxeConsTam3.Properties);
  pAdicinaDupla('ITE_ABFPIS', 'Abrev. PIS', cxeConsTam3.Properties);
  pAdicinaDupla('ITE_ABFCOF', 'Abrev. COFINS', cxeConsTam3.Properties);
  pAdicinaDupla('ITE_ABFIPI', 'Abrev. IPI', cxeConsTam3.Properties);
  pAdicinaDupla('ITE_PRECOM', 'Pr.Compra');
  pAdicinaDupla('ITE_DESF01', 'Desc.Forn.1');
  pAdicinaDupla('ITE_DESF02', 'Desc.Forn.2');
  pAdicinaDupla('ITE_DESF03', 'Desc.Forn.3');
  pAdicinaDupla('ITE_DESF04', 'Desc.Forn.4');
  pAdicinaDupla('ITE_DESF05', 'Desc.Forn.5');
  pAdicinaDupla('ITE_DESF06', 'Desc.Forn.6');
  pAdicinaDupla('ITE_PRELIQ', 'Pr.Compra Liq');
  pAdicinaDupla('ITE_ICMENT', 'ICMS Entrada');
  pAdicinaDupla('ITE_SUBFED', '% Imp.Federais (-)');
  pAdicinaDupla('ITE_IPIENT', 'IPI Entrada');
  pAdicinaDupla('ITE_FREENT', 'Frete Entrada');
  pAdicinaDupla('ITE_VALFRE', 'Valor Frete');
  pAdicinaDupla('ITE_ACRFIN', 'Acr.Financ.');
  pAdicinaDupla('ITE_SUBSTI', '%Sub.Tributária');
  pAdicinaDupla('ITE_DESADB', '%Desc.Adic.(Bol)');
  pAdicinaDupla('ITE_PRECUS', 'Pr.Custo');
  pAdicinaDupla('ITE_CUSREA', 'Pr.Custo Real');
  pAdicinaDupla('ITE_OUTVAL', 'Outros Valores');
  pAdicinaDupla('ITE_ICMSAI', 'ICMS Saída');
  pAdicinaDupla('ITE_IPISAI', 'IPI Saída');
  pAdicinaDupla('ITE_IMPFED', '%Impostos Fed. (+)');
  pAdicinaDupla('ITE_DESOPE', '% Desp. Oper.');

  pAdicinaDupla('ITE_MARBR1', 'Marg.Bruta 1');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB1', '(%)Comissao 1');

  pAdicinaDupla('ITE_PREVE1', 'Pr. Venda 1');
  pAdicinaDupla('ITE_MARBR2', 'Marg.Bruta 2');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB2', '(%)Comissao 2');

  pAdicinaDupla('ITE_PREVE2', 'Pr. Venda 2');
  pAdicinaDupla('ITE_MARBR3', 'Marg.Bruta 3');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB3', '(%)Comissao 3');

  pAdicinaDupla('ITE_PREVE3', 'Pr. Venda 3');
  pAdicinaDupla('ITE_MARBR4', 'Marg.Bruta 4');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB4', '(%)Comissao 4');

  pAdicinaDupla('ITE_PREVE4', 'Pr. Venda 4');
  pAdicinaDupla('ITE_MARBR5', 'Marg.Bruta 5');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB5', '(%)Comissao 5');

  pAdicinaDupla('ITE_PREVE5', 'Pr. Venda 5');
  pAdicinaDupla('ITE_MARBR6', 'Marg.Bruta 6');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB6', '(%)Comissao 6');

  pAdicinaDupla('ITE_PREVE6', 'Pr. Venda 6');
  pAdicinaDupla('ITE_MARBR7', 'Marg.Bruta 7');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB7', '(%)Comissao 7');

  pAdicinaDupla('ITE_PREVE7', 'Pr. Venda 7');

  pAdicinaDupla('ITE_MARMIN', 'Margem Min. Vend.');
  pAdicinaDupla('ITE_MARMSG', 'Margem Min. Sub. Ger.');
  pAdicinaDupla('ITE_MARMGE', 'Margem Min. Ger.');
  pAdicinaDupla('ITE_LOCFIS', 'Localização Física', cxeLocFis.Properties);
  pAdicinaDupla('ITE_TAMLCF', 'Capacidade Loc. Física');
  pAdicinaDupla('ITE_LOCSUP', 'Localização Super Estoque', cxeLocsUP.Properties);
  pAdicinaDupla('ITE_TAMLCS', 'Capacidade Loc. Super Estoque');
  pAdicinaDupla('ITE_CODLSE', 'Localização de Separação', cxeConsTam3.Properties);

  If blnIteTbp Then
  Begin

    For intContador := 1 To Length(VS_strTabPrc) Do
    Begin
      pAdicinaDupla('ITE_DESMA' + intToStr(intContador), 'Desc.Máximo Vendedor '     + intToStr(intContador));
      pAdicinaDupla('ITE_DESMG' + intToStr(intContador), 'Desc.Máximo Gerente '      + intToStr(intContador));
      pAdicinaDupla('ITE_DESMS' + intToStr(intContador), 'Desc.Máximo Sub-Gerente '  + intToStr(intContador));
    End;

  End Else
  Begin

    pAdicinaDupla('ITE_DESMAX', 'Desc.Máximo Vendedor');
    pAdicinaDupla('ITE_DESMSU', 'Desconto Máximo Sub-Gerente');
    pAdicinaDupla('ITE_DESMGE', 'Desconto Máximo Gerente');

  End;

  pAdicinaDupla('ITE_MLTCOM', 'Múlt. Compra');
  pAdicinaDupla('ITE_CODFAB', 'Código de fábrica');
  pAdicinaDupla('ITE_QTPPRO', 'Qtd.Pontos Profiss.');
  pAdicinaDupla('ITE_CPRCEN', 'Compr. Centr.');
  pAdicinaDupla('ITE_MESGIR', 'Qtd. Meses para Inativação');
  pAdicinaDupla('ITE_TMPGAR', 'Tempo Garantia');
  pAdicinaDupla('ITE_INFGAR', 'Informação de Garantia');
  pAdicinaDupla('ITE_PESOIT', 'Peso Bruto');
  pAdicinaDupla('ITE_PESLIQ', 'Peso Liquido');
  pAdicinaDupla('ITE_INFLAM', 'Inflamável?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_USABON', 'Usa Bonificação?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_NVLGIR', 'Niv.Gir.Estoq.Geral', cmbNivGir.Properties);
  pAdicinaDupla('ITE_CODUNI', 'Unidade', cxeConsTam2.Properties);
  pAdicinaDupla('ITE_UNICOM', 'Unidade de Compra', cxeConsTam2.Properties);
  pAdicinaDupla('ITE_CODMAR', 'Marca', cxeConsTam6.Properties);
  pAdicinaDupla('ITE_SITPRO', 'Situação', cxeConsTam3.Properties);
  pAdicinaDupla('ITE_DTAVAL', 'Dt.Validade Preço');
  pAdicinaDupla('ITE_CODMON', 'Montadora', cxeConsTam3.Properties);
  pAdicinaDupla('ITE_CODFOR', 'Fornecedor', cxeConsTam8.Properties);
  pAdicinaDupla('ITE_DIAFOR', 'Dias entrega');
  pAdicinaDupla('ITE_PRAMIN', 'Prazo Médio Mín. Cálc. Juros');
  pAdicinaDupla('ITE_REAEND', 'Realizar endereçamento', cmbSimNao.Properties);
  pAdicinaDupla('ITE_COMVAR', 'Comis.Vend.Interno');
  pAdicinaDupla('ITE_COMATA', 'Comis.Repres.Ext.Loja');
  pAdicinaDupla('ITE_COMDIS', 'Comis.Repres.Ext.Distrib.');
  pAdicinaDupla('ITE_COMPRO', 'Comis.Profissional');
  pAdicinaDupla('ITE_CODDEP', 'Departamento', cxeConsTam3.Properties);
  pAdicinaDupla('ITE_MLTVEN', 'Múltiplo Venda');
  pAdicinaDupla('ITE_ACOOBJ', 'Acordo Obj.');
  pAdicinaDupla('ITE_VALOBR', 'Validade Obrigatória?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_ESTMIN', 'Est. Mínimo');
  pAdicinaDupla('ITE_ESTMAX', 'Est. Máximo');
  pAdicinaDupla('ITE_ABAMLT', 'Abast. Múlt. Compr.', cmbSimNao.Properties);
  pAdicinaDupla('ITE_OBRCPF', 'Ven. c/ obrig. CPF/CNPJ', cmbSimNao.Properties);
  pAdicinaDupla('ITE_OBRIBA', 'Ven. c/ obrig. cod. IBAMA', cmbSimNao.Properties);
  pAdicinaDupla('ITE_NOTESP', 'Divisível', cmbSimNao.Properties);

  pAdicinaDupla('ITE_MINTB1', 'Qtde.MínimaTab.1');
  pAdicinaDupla('ITE_MINTB2', 'Qtde.MínimaTab.2');
  pAdicinaDupla('ITE_MINTB3', 'Qtde.MínimaTab.3');
  pAdicinaDupla('ITE_MINTB4', 'Qtde.MínimaTab.4');
  pAdicinaDupla('ITE_MINTB5', 'Qtde.MínimaTab.5');
  pAdicinaDupla('ITE_MINTB6', 'Qtde.MínimaTab.6');
  pAdicinaDupla('ITE_MINTB7', 'Qtde.MínimaTab.7');

  pAdicinaDupla('ITE_OBRNFE', 'Venda com obrigat. de NFe', cmbSimNao.Properties);
  pAdicinaDupla('ITE_PRDGRU', 'Grupo Produto', cxeConsTam5.Properties);
  pAdicinaDupla('ITE_IMPLIS', 'Imprime Lista', cmbSimNao.Properties);
  pAdicinaDupla('ITE_ATICOM', 'Ativo Compras', cmbSimNao.Properties);
  pAdicinaDupla('ITE_CODDIC', 'Código DIC');
  pAdicinaDupla('ITE_TIPPRO', 'Tipo produto', cmbTipPro.Properties);
  pAdicinaDupla('ITE_PRAPEL', '% Desc. Ref. Rapel');
  pAdicinaDupla('ITE_PROEMB', 'Produto Embalagem', cmbSimNao.Properties);
  pAdicinaDupla('ITE_DENSID', 'Densidade');
  pAdicinaDupla('ITE_IMPETI', 'Imprime Etiquetas Ent. Mer.', cmbSimNao.Properties);
  pAdicinaDupla('ITE_CODGRU', 'Linha/Grupo', cxeConsTam6.Properties);
  pAdicinaDupla('ITE_TIPFRE', 'Tipo de Frete', cmbFrePFU.Properties);
  pAdicinaDupla('ITE_VLCFRE', 'Frete de Saída');
  pAdicinaDupla('ITE_RASTRE', 'Rastreabilidade', cmbSimNao.Properties);
  pAdicinaDupla('ITE_FATCMP', 'Fator madeira de M³ X Peças', cxeFatCom.Properties);
  pAdicinaDupla('ITE_LARVID', 'Largura');
  pAdicinaDupla('ITE_ALTVID', 'Altura');
  pAdicinaDupla('ITE_LAMAVI', 'Largura Máxima');
  pAdicinaDupla('ITE_ALMAVI', 'Altura Máxima');
  pAdicinaDupla('ITE_CDCEST', 'CEST', cxeConsTam7.Properties);
  pAdicinaDupla('ITE_APLICA', 'Aplicação', cxeMemo.Properties);

  pAdicinaDupla('ITE_MARID1', 'Marg.Ideal 1');
  pAdicinaDupla('ITE_MARID2', 'Marg.Ideal 2');
  pAdicinaDupla('ITE_MARID3', 'Marg.Ideal 3');
  pAdicinaDupla('ITE_MARID4', 'Marg.Ideal 4');
  pAdicinaDupla('ITE_MARID5', 'Marg.Ideal 5');
  pAdicinaDupla('ITE_MARID6', 'Marg.Ideal 6');
  pAdicinaDupla('ITE_MARID7', 'Marg.Ideal 7');
  pAdicinaDupla('ITE_CODONU', 'Classificação ONU', cxeConsTam3.Properties);
  pAdicinaDupla('ITE_PEFUTP', 'Perm. Ent. Futura Status "Previsão de Entrega"?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_PEEFUT', 'Perm. Ent. Futura Status "Aguardando Cliente"?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_PEFFPR', 'Perm. Ent. Futura Status "Falta de Produto"?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_USAFLE', 'Usa Flex?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_GRUCMP', 'Grupo de Compra', cxeConsTam3.Properties);
  pAdicinaDupla('ITE_NIVCRI', 'Nível Criticidade', cmbNivCri.Properties);
  pAdicinaDupla('ITE_NVLCRI', 'Nível Criticidade Geral', cmbNivCri.Properties);
  pAdicinaDupla('ITE_RECDEV', 'Permite Receber Devolução?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_UNITRI', 'Unidade Tribut.', cxeConsTam2.Properties);
  pAdicinaDupla('ITE_FATUTR', 'Fator Conv. Unid. Tribut.');
  pAdicinaDupla('ITE_UTIAMP', 'Aplica legislação AMPARA', cmbSimNao.Properties);
  pAdicinaDupla('ITE_ORDSER', 'Ordem de Serviço:', cmbSimNao.Properties);
  pAdicinaDupla('ITE_PESOBR', 'Controlar pesagem obrigatória (Saída):', cmbSimNao.Properties);
  pAdicinaDupla('ITE_LOTEPD', 'Obrigar definir lote (WMS) em Pedido de Venda?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_CPESOB', 'Controlar pesagem obrigatória (Entrada):', cmbSimNao.Properties);
  pAdicinaDupla('ITE_COMDIG', 'Comis.Digitador');
  pAdicinaDupla('ITE_CLACRM', 'Classif. Oferta Consumíveis', cmbClaCRM.Properties);
  pAdicinaDupla('ITE_OBRBAR', 'Obrig. Cód Barras Entrada Simplificada', cmbSimNao.Properties);
  pAdicinaDupla('ITE_FATCOM', 'Digitar complemento do produto', cmbSimNao.Properties);
  pAdicinaDupla('ITE_DESCND', 'Aplicar desconto da condição de pagamento?', cmbSimNao.Properties);
End;

function TfrmAltPrecoIndividual.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;


  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtExcIpi) Then
    Begin
      If Not fEmptyStr(edtExcIpi.Text) Then
        edtExcIpi.Text := fStrZero(edtExcIpi.Text, 3);
    End
    Else If (Sender = mskLinGru) And fEmptyStr(mskLinGru.Text) Then
      pDesmarcaLista(mskLinGru, arrLinhaGrupo,'',6)
    Else If (Sender = edtCodUni) And fEmptyStr(edtCodUni.Text) Then
      pDesmarcaLista(edtCodUni, arrCodUni, '', 2)
    Else If (Sender = edtCodMar) And fEmptyStr(edtCodMar.Text) Then
      pDesmarcaLista(edtCodMar, arrMarca, '', 6)
    Else If (Sender = edtCodAbr) And fEmptyStr(edtCodabr.Text) Then
      pDesmarcaLista(edtCodAbr, arrCodAbr, '', 3)
    Else If (Sender = edtCodFor) And fEmptyStr(edtCodFor.Text) Then
      pDesmarcaLista(edtCodFor, arrFornec, '', 8)
    Else If (Sender = edtPrdGru) And fEmptyStr(edtPrdGru.Text) Then
      pDesmarcaLista(edtPrdGru, arrGrupoPro, '', 5)
    Else If (Sender = edtGruCmp) And fEmptyStr(edtGruCmp.Text) Then
      pDesmarcaLista(edtGruCmp, arrGruCmp, '', 3)
    Else If (Sender = edtCodGpr) And fEmptyStr(edtCodGpr.Text) Then
      pDesmarcaLista(edtCodGpr, arrCodGpr, '', 6)
    Else If (Sender = edtCodDep) And fEmptyStr(edtCodDep.Text) Then
      pDesmarcaLista(edtCodDep, arrCodDep, '', 3)
    Else If (Sender = edtCodMon) And fEmptyStr(edtCodMon.Text) Then
      pDesmarcaLista(edtCodMon, arrCodMon, '', 3);

    If Not fEmptyStr(edtDocumento.Text) Then
    Begin
      If (Sender = edtCodEmpresa)Then
      Begin
        If (fEmptyStr(edtCodEmpresa.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa deve ser informada!', ['&O k']);
          Result := False;
        End
        Else If (Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
          pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrLinEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
      End
      Else If (Sender = edtEspecie)Then
      Begin
        If fEmptyStr(edtEspecie.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Espécie deve ser informada!', ['&O k']);
          Result := False;
        End
      End
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltPrecoIndividual.pAdicionaDuplic(strOri: String; qryAdic: TUniQuery; strItemAgrupamento: string);
begin
  If (strOri = 'S') Then
  Begin
    If cdsDuplic.Locate('CODITE;CODEMP;CODFOR;CODFAB;CODBAR;BAREMB', VarArrayOf([qryAdic.FieldByName('ITE_CODITE').AsString,
                                                                                qryAdic.FieldByName('ITE_CODEMP').AsString,
                                                                                qryAdic.FieldByName('ITE_CODFOR').AsString,
                                                                                qryAdic.FieldByName('ITE_CODFAB').AsString,
                                                                                qryAdic.FieldByName('ITE_CODBAR').AsString,
                                                                                qryAdic.FieldByName('ITE_BAREMB').AsString]), []) Then
     Exit;

    cdsDuplic.Append;
    cdsDuplic.FieldByName('CODITE').AsString := qryAdic.FieldByName('ITE_CODITE').AsString;
    cdsDuplic.FieldByName('DESITE').AsString := qryAdic.FieldByName('ITE_DESITE').AsString;
    cdsDuplic.FieldByName('CODEMP').AsString := qryAdic.FieldByName('ITE_CODEMP').AsString;
    cdsDuplic.FieldByName('CODFOR').AsString := qryAdic.FieldByName('ITE_CODFOR').AsString;
    cdsDuplic.FieldByName('CODFAB').AsString := qryAdic.FieldByName('ITE_CODFAB').AsString;
    cdsDuplic.FieldByName('CODBAR').AsString := qryAdic.FieldByName('ITE_CODBAR').AsString;
    cdsDuplic.FieldByName('BAREMB').AsString := qryAdic.FieldByName('ITE_BAREMB').AsString;
  End
  Else
  Begin
    If cdsDuplic.Locate('CODITE;CODEMP;CODFOR;CODFAB;CODBAR;BAREMB', VarArrayOf([qryGen.FieldByName('ITE_CODITE').AsString,
                                                                                qryGen.FieldByName('ITE_CODEMP').AsString,
                                                                                qryGen.FieldByName('ITE_CODFOR').AsString,
                                                                                qryGen.FieldByName('ITE_CODFAB_NOV').AsString,
                                                                                qryGen.FieldByName('ITE_CODBAR_NOV').AsString,
                                                                                qryGen.FieldByName('ITE_BAREMB_NOV').AsString]), []) Then
      Exit;

    cdsDuplic.Append;
    cdsDuplic.FieldByName('CODITE').AsString := qryGen.FieldByName('ITE_CODITE').AsString;
    cdsDuplic.FieldByName('DESITE').AsString := qryGen.FieldByName('ITE_DESITE').AsString;
    cdsDuplic.FieldByName('CODEMP').AsString := qryGen.FieldByName('ITE_CODEMP').AsString;
    cdsDuplic.FieldByName('CODFOR').AsString := qryGen.FieldByName('ITE_CODFOR').AsString;
    cdsDuplic.FieldByName('CODFAB').AsString := qryGen.FieldByName('ITE_CODFAB_NOV').AsString;
    cdsDuplic.FieldByName('CODBAR').AsString := qryGen.FieldByName('ITE_CODBAR_NOV').AsString;
    cdsDuplic.FieldByName('BAREMB').AsString := qryGen.FieldByName('ITE_BAREMB_NOV').AsString;
  End;
  cdsDuplic.FieldByName('ORIGEM').AsString := strOri;
  cdsDuplic.FieldByName('ITEAGR').AsString := strItemAgrupamento;
  cdsDuplic.Post;
end;

procedure TfrmAltPrecoIndividual.pAtribuiTabelas;
begin
  qryAbfIcm := fCriaQuery(Self);

  qryConGru := fCriarQuery('SELECT * FROM CADGRU WHERE FALSE', Self);
  qryConMar := fCriarQuery('SELECT * FROM CADMAR WHERE FALSE', Self);
  qrySitPro := fCriarQuery('SELECT * FROM SITPRO WHERE FALSE', Self);
  qryCadMon := fCriarQuery('SELECT * FROM CADMON WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConUni := fCriarQuery('SELECT * FROM CADUNI WHERE FALSE', Self);
  qryPrdGru := fCriarQuery('SELECT * FROM GRPPRD WHERE FALSE', Self);
  qryCodDic := fCriarQuery('SELECT * FROM CADDIC WHERE FALSE', Self);
  qryCadLse := fCriarQuery('SELECT * FROM CADLSE WHERE FALSE', Self);

  qryConAbf := qryAbfIcm;
end;

procedure TfrmAltPrecoIndividual.mskLinGruExit(Sender: TObject);
begin
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinhaGrupo, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmAltPrecoIndividual.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoIndividual.pDesabilitaCamposFator;
Begin
  If Not Assigned(objFatPre) Then
    Exit;
    
  chkMarBr2.Enabled := False;
  chkComTb2.Enabled := False;
  chkPreVe2.Enabled := False;

  chkMarBr3.Enabled := False;
  chkComTb3.Enabled := False;
  chkPreVe3.Enabled := False;

  chkMarBr4.Enabled := False;
  chkComTb4.Enabled := False;
  chkPreVe4.Enabled := False;

  chkMarBr5.Enabled := False;
  chkComTb5.Enabled := False;
  chkPreVe5.Enabled := False;

  chkMarBr6.Enabled := False;
  chkComTb6.Enabled := False;
  chkPreVe6.Enabled := False;

  chkMarBr7.Enabled := False;
  chkComTb7.Enabled := False;
  chkPreVe7.Enabled := False;

  chkMarBr2.Checked := False;
  chkComTb2.Checked := False;
  chkPreVe2.Checked := False;

  chkMarBr3.Checked := False;
  chkComTb3.Checked := False;
  chkPreVe3.Checked := False;

  chkMarBr4.Checked := False;
  chkComTb4.Checked := False;
  chkPreVe4.Checked := False;

  chkMarBr5.Checked := False;
  chkComTb5.Checked := False;
  chkPreVe5.Checked := False;

  chkMarBr6.Checked := False;
  chkComTb6.Checked := False;
  chkPreVe6.Checked := False;

  chkMarBr7.Checked := False;
  chkComTb7.Checked := False;
  chkPreVe7.Checked := False;

  chkMarId1.Checked := False;
  chkMarId2.Checked := False;
  chkMarId3.Checked := False;
  chkMarId4.Checked := False;
  chkMarId5.Checked := False;
  chkMarId6.Checked := False;
  chkMarId7.Checked := False;
End;

procedure TfrmAltPrecoIndividual.pVerificaDireitoAcesso;
Begin
  TRadioButton(rdgTipAlt.Components[0]).Enabled := fVerificaAcessoSistema('ALTICUSVEN', strLoginUsuarioLogado);
  TRadioButton(rdgTipAlt.Components[1]).Enabled := fVerificaAcessoSistema('ALTICUSMAR', strLoginUsuarioLogado);
  TRadioButton(rdgTipAlt.Components[2]).Enabled := fVerificaAcessoSistema('ALTIVENMAR', strLoginUsuarioLogado);

  If TRadioButton(rdgTipAlt.Components[0]).Enabled Then
    TRadioButton(rdgTipAlt.Components[0]).Checked := True

  Else If TRadioButton(rdgTipAlt.Components[1]).Enabled Then
    TRadioButton(rdgTipAlt.Components[1]).Checked := True

  Else If TRadioButton(rdgTipAlt.Components[2]).Enabled Then
    TRadioButton(rdgTipAlt.Components[2]).Checked := True;

  If blnBloPre Then
  Begin
    rdgTipAlt.Controls[0].Enabled := False;
    rdgTipAlt.Controls[2].Enabled := False;

    If rdgTipAlt.Controls[1].Enabled Then
      rdgTipAlt.ItemIndex := 1;
  End;
End;

procedure TfrmAltPrecoIndividual.pCarregaSelecao;
Begin
  objSalInt.fCarregaDados('', Self, Self.Name, strLoginUsuarioLogado);

  objSalInt.pCarregaMultiSelecao(arrLinhaGrupo, 'CODGRU');
  objSalInt.pCarregaMultiSelecao(arrMarca,      'CODMAR');
  objSalInt.pCarregaMultiSelecao(arrFornec,     'CODFOR');
  objSalInt.pCarregaMultiSelecao(arrGrupoPro,   'PRDGRU');
  objSalInt.pCarregaMultiSelecao(arrGruCmp,     'GRUCMP');
  objSalInt.pCarregaMultiSelecao(arrCodGpr,     'CODGPR');
  objSalInt.pCarregaMultiSelecao(arrCodDep,     'CODDEP');
  objSalInt.pCarregaMultiSelecao(arrCodMon,     'CODMON');
  objSalInt.pCarregaMultiSelecao(arrCodAbr,     'CODABF');
  objSalInt.pCarregaMultiSelecao(arrCodUni,     'CODUNI');
//  objSalInt.pCarregaMultiSelecao(arrClaIPI,     'CLAIPI');
End;

procedure TfrmAltPrecoIndividual.pSalvaSelecao;
Begin
  objSalInt.pAddMultiSelecao(arrLinhaGrupo, 'CODGRU');
  objSalInt.pAddMultiSelecao(arrMarca,      'CODMAR');
  objSalInt.pAddMultiSelecao(arrFornec,     'CODFOR');
  objSalInt.pAddMultiSelecao(arrGrupoPro,   'PRDGRU');
  objSalInt.pAddMultiSelecao(arrGruCmp,     'GRUCMP');
  objSalInt.pAddMultiSelecao(arrCodGpr,     'CODGPR');
  objSalInt.pAddMultiSelecao(arrCodDep,     'CODDEP');
  objSalInt.pAddMultiSelecao(arrCodMon,     'CODMON');
  objSalInt.pAddMultiSelecao(arrCodAbr,     'CODABF');
  objSalInt.pAddMultiSelecao(arrCodUni,     'CODUNI');
//  objSalInt.pAddMultiSelecao(arrClaIPI,     'CLAIPI');

  objSalInt.fSalvaDados('', Self.Name, strLoginUsuarioLogado, True);
End;

Procedure TfrmAltPrecoIndividual.pCriaCdsSimNao;
Begin
  cdsSimNao := TZClient.Create(Self, 'SELECT "S" AS VALCAM, "Sim" AS DESCAM UNION SELECT "N" AS VALCAM, "Não" AS DESCAM');
  cdsSimNao.fLeDados('TfrmAltPrecoGlobal.pCriaCdsSimNao');

  TcxLookupComboBoxProperties(cmbSimNao.Properties).ListSource := cdsSimNao.dtsSource;
End;

Procedure TfrmAltPrecoIndividual.pCriaCdsTipPro;
  Var
    intContador: Integer;
Begin
  cdsTipPro := TZClient.Create(Self, 'SELECT "00" AS VALCAM, CAST("" AS CHAR(40)) AS DESCAM');
  cdsTipPro.fLeDados('TfrmAltPrecoGlobal.pCriaCdSTipPro');
  cdsTipPro.EmptyDataSet;

  For intContador := Low(TIPO_PRODUTO_SPED) To High(TIPO_PRODUTO_SPED) Do
  Begin
    cdsTipPro.Append;
    cdsTipPro.FieldByName('VALCAM').AsString := TIPO_PRODUTO_SPED[intContador][0];
    cdsTipPro.FieldByName('DESCAM').AsString := TIPO_PRODUTO_SPED[intContador][0] + ' - ' + TIPO_PRODUTO_SPED[intContador][1];
    cdsTipPro.Post;
  End;

  TcxLookupComboBoxProperties(cmbTipPro.Properties).ListSource := cdsTipPro.dtsSource;
End;
Procedure TfrmAltPrecoIndividual.pCriaCdsClaCRM;
Begin
  cdsClaCrm := TZClient.Create(Self, 'SELECT "C" AS VALCAM, "Consumível" AS DESCAM UNION ' +
                                     'SELECT "P" AS VALCAM, "Principal"  AS DESCAM UNION ' +
                                     'SELECT "A" AS VALCAM, "Acessório"  AS DESCAM');

  cdsClaCrm.fLeDados('TfrmAltPrecoGlobal.pCriaCdsClaCrm');

  TcxLookupComboBoxProperties(cmbClaCRM.Properties).ListSource := cdsClaCRM.dtsSource;
End;

Procedure TfrmAltPrecoIndividual.pCriaCdsFrePFU;
Begin
  cdsFrePFU := TZClient.Create(Self, 'SELECT "P" AS VALCAM, "Percentual" AS DESCAM UNION ' +
                                     'SELECT "F" AS VALCAM, "Fixo"       AS DESCAM UNION ' +
                                     'SELECT "U" AS VALCAM, "Unitário"   AS DESCAM');

  cdsFrePFU.fLeDados('TfrmAltPrecoGlobal.pCriaCdsFrePFU');

  TcxLookupComboBoxProperties(cmbFrePFU.Properties).ListSource := cdsFrePFU.dtsSource;
End;

Procedure TfrmAltPrecoIndividual.pCriaCdsEsMiDg;
Begin
  cdsEsMiDg := TZClient.Create(Self, 'SELECT "G" AS VALCAM, "Gerado"   AS DESCAM UNION ' +
                                     'SELECT "D" AS VALCAM, "Digitado" AS DESCAM');

  cdsEsMiDg.fLeDados('TfrmAltPrecoGlobal.pCriaCdsEsMiDg');

  TcxLookupComboBoxProperties(cmbEsMiDg.Properties).ListSource := cdsEsMiDg.dtsSource;
End;

procedure TfrmAltPrecoIndividual.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
    blnAux : Boolean;

    procedure pNovaColuna(strNomCam: String);
    begin
      SetLength(colColunas, Length(colColunas) + 1);
      colColunas[Length(colColunas) - 1].blnHabili := False;
      colColunas[Length(colColunas) - 1].strNomCam := strNomCam;
    end;

begin
  blnVidroInteiro := (fCfgSis('VENVID', varBoolean)) And (Not fCfgSis('DECVID', varBoolean));

  pCriaCdsSimNao;
  pCriaCdsClaCRM;
  pCriaCdsFrePFU;
  pCriaCdsEsMiDg;
  pCriaCdsTipPro;

  objSalInt := TSalvaInterface.Create(Self);
  objSalInt.blnDeleteNaoEncontrados := False;

  pTamanhoCamposLocFis(intLocFis, intLocSup, intTamLcf, intLocSep);

  intSitPro := fCfgSis('SITEMP', varInteger);

  blnBloPre := fCfgSis('BLOPRE', varBoolean);

  strLisCam := TStringList.Create;
  strLisCam.Clear;

  strLisUsu := TStringList.Create;
  strLisUsu.Clear;

  blnUsaFle         := fCfgSis('USAFLE', varBoolean);
  blnInfMat         := fCfgSis('INFMAT', varBoolean);

  intInfFed := fCfgSis('INFFED', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);

  blnIteTbp         := fCfgSis('ITETBP', varBoolean);
  blnURapel         := fCfgSis('URAPEL', varBoolean);
  blnMarIde         := fCfgSis('MARIDE', varBoolean);
  blnUtiAmp         := fCfgSis('UTIAMP', varBoolean);
  blnOrdSer         := fCfgSis('OSPDVN', varBoolean);

  blnLotePD         := False;
  If fCfgSis('UTIWMS', VarBoolean) Then
  Begin
    If fCfgSis('WMSLOT', varBoolean) Then
      blnLotePD := True;
  End;

  chkCodDic.Visible := (fCadEmp('ESTADO') = 'SE');
  chkCodDic.Checked := chkCodDic.Visible;
  qryAltPre := fCriaQuery(Self);
  qryAltPre.SQL.Text := fSQLAlteracaoPreco;

  If fCfgSis('FATPRE', varBoolean) Then
    objFatPre := TFatorPreco.Create
  Else
    objFatPre := Nil;

  chkUniTri.Visible := (fCfgSis('UNITRI') = 'S');
  chkUniTri.Checked := chkUniTri.Visible;

  chkFatUTr.Visible := (fCfgSis('UNITRI') = 'S');
  chkFatUTr.Checked := chkFatUTr.Visible;

  chkPesLiq.Visible := (fCfgSis('PESLIQ') = 'SOMA');
  chkPesLiq.Checked := chkPesLiq.Visible;

  chkUniCom.Visible := (fCfgSis('CNVEMB') = 'S');
  chkUniCom.Checked := chkUniCom.Visible;

  chkMesGir.Visible := fCfgSis('ATICOM',varBoolean);
  chkMesGir.Checked := chkMesGir.Visible;

  chkDensid.Visible := (fCfgSis('UTIIND', varBoolean));
  chkDensid.Checked := chkDensid.Visible;

  chkPesObr.Visible := (fCfgSis('PESOBR', varBoolean));
  chkPesObr.Checked := chkPesObr.Visible;

  chkCpesOb.Visible := (fCfgSis('CPESOB', varBoolean));
  chkCpesOb.Checked := chkCpesOb.Visible;

  chkDesCnd.Visible := (fCfgSis('DESCND', varBoolean));
  chkDesCnd.Checked := chkDesCnd.Visible;

  chkTipFre.Visible := (fCfgSis('FRETRA') = '3');
  chkVlcFre.Visible := chkTipFre.Visible;
  chkTipFre.Checked := chkTipFre.Visible;
  chkVlcFre.Checked := chkTipFre.Visible;

  chkRastre.Visible := fUsaRotinaWMS;
  chkRastre.Checked := chkRastre.Visible;

  chkMarId1.Visible := fCfgSis('MARIDE', VarBoolean);
  chkMarId1.Checked := chkMarId1.Visible;

  chkMarId2.Visible := chkMarId1.Visible;
  chkMarId2.Checked := chkMarId1.Visible;

  chkMarId3.Visible := chkMarId1.Visible;
  chkMarId3.Checked := chkMarId1.Visible;

  chkMarId4.Visible := chkMarId1.Visible;
  chkMarId4.Checked := chkMarId1.Visible;

  chkMarId5.Visible := chkMarId1.Visible;
  chkMarId5.Checked := chkMarId1.Visible;

  chkMarId6.Visible := chkMarId1.Visible;
  chkMarId6.Checked := chkMarId1.Visible;

  chkMarId7.Visible := chkMarId1.Visible;
  chkMarId7.Checked := chkMarId1.Visible;

  chkFatCMP.Visible := fCfgSis('VENMAD', varBoolean);
  chkFatCMP.Checked := chkFatCMP.Visible;

  chkNotEsp.Visible := Pos(fCfgSis('TIPEXP'), '3_4_') > 0;
  chkNotEsp.Checked := chkNotEsp.Visible;

  If Not fCfgSis('CADMON', varBoolean) Then
  Begin
    pnlCadMon.Visible := False;
    //Self.Height       := Self.Height - pnlCadMon.Height;
    chkCodMon.Checked := False;
    chkCodMon.Visible := False;
  End;

  If Not blnValFor Then
  Begin
    chkdtaVal.Checked := False;
    chkdtaVal.Visible := False;
  End;

  chkPraMin.Checked := fCfgSis('PRAMIN', varBoolean);
  chkPraMin.Visible := fCfgSis('PRAMIN', varBoolean);

  blnPerComTabela   := (fCfgSis('PCMPRO') = '2');
  chkOutVal.Caption := fCfgSis('DOVCPP') + ' (+)';
  chkDesAdb.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';

  strTCOPRO := fCfgSis('TCOPRO');

  If strTCOPRO = '4' Then
    chkQtpPro.Caption := 'Pontos Por Valor';

  If (Pos(strTCOPRO, '3_4_' ) <= 0) Then
  Begin
    chkQtpPro.Checked := False;
    chkQtpPro.Visible := False;
  End;

  intConfirmando := -1;

  SetLength(colColunas, 0);

  pNovaColuna('ITE_CLAIPI_NOV');
  pNovaColuna('ITE_EXCIPI_NOV');

  pNovaColuna('ITE_GRUCMP_NOV');

  If chkCdCest.Checked Then
  Begin
    pNovaColuna('ITE_CDCEST_NOV');
  End;

  pNovaColuna('ITE_APLICA_NOV');

  pNovaColuna('ITE_PER_CI_NOV');
  pNovaColuna('ITE_NUMFCI_NOV');
  pNovaColuna('ITE_PRECOM_NOV');
  pNovaColuna('ITE_PREVE1_NOV');
  pNovaColuna('ITE_PREVE2_NOV');
  pNovaColuna('ITE_PREVE3_NOV');
  pNovaColuna('ITE_PREVE4_NOV');
  pNovaColuna('ITE_PREVE5_NOV');
  pNovaColuna('ITE_PREVE6_NOV');
  pNovaColuna('ITE_PREVE7_NOV');
  pNovaColuna('ITE_DESF01_NOV');
  pNovaColuna('ITE_DESF02_NOV');
  pNovaColuna('ITE_DESF03_NOV');
  pNovaColuna('ITE_DESF04_NOV');
  pNovaColuna('ITE_DESF05_NOV');
  pNovaColuna('ITE_DESF06_NOV');
  pNovaColuna('ITE_ICMENT_NOV');
  pNovaColuna('ITE_SUBFED_NOV');
  pNovaColuna('ITE_IPIENT_NOV');
  pNovaColuna('ITE_ABAMLT_NOV');
  pNovaColuna('ITE_FREENT_NOV');
  pNovaColuna('ITE_VALFRE_NOV');
  pNovaColuna('ITE_ACRFIN_NOV');
  pNovaColuna('ITE_SUBSTI_NOV');
  pNovaColuna('ITE_DESOPE_NOV');
  pNovaColuna('ITE_ICMSAI_NOV');
  pNovaColuna('ITE_IPISAI_NOV');

  if not blnIteTbp Then
  Begin
    pNovaColuna('ITE_DESMAX_NOV');
    pNovaColuna('ITE_DESMGE_NOV');
    pNovaColuna('ITE_DESMSU_NOV');
  End
  Else
  Begin
    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      pNovaColuna('ITE_DESMA' + intToStr(intCont) + '_NOV');
      pNovaColuna('ITE_DESMG' + intToStr(intCont) + '_NOV');
      pNovaColuna('ITE_DESMS' + intToStr(intCont) + '_NOV');
    End;
  End;

  pNovaColuna('ITE_COMVAR_NOV');
  pNovaColuna('ITE_COMATA_NOV');
  pNovaColuna('ITE_COMDIS_NOV');
  pNovaColuna('ITE_COMDIG_NOV');
  pNovaColuna('ITE_COMPRO_NOV');
  pNovaColuna('ITE_MARBR1_NOV');
  pNovaColuna('ITE_MARBR2_NOV');
  pNovaColuna('ITE_MARBR3_NOV');
  pNovaColuna('ITE_MARBR4_NOV');
  pNovaColuna('ITE_MARBR5_NOV');
  pNovaColuna('ITE_MARBR6_NOV');
  pNovaColuna('ITE_MARBR7_NOV');

  If fCfgSis('MARIDE', VarBoolean) Then
  Begin
    pNovaColuna('ITE_MARID1_NOV');
    pNovaColuna('ITE_MARID2_NOV');
    pNovaColuna('ITE_MARID3_NOV');
    pNovaColuna('ITE_MARID4_NOV');
    pNovaColuna('ITE_MARID5_NOV');
    pNovaColuna('ITE_MARID6_NOV');
    pNovaColuna('ITE_MARID7_NOV');
  End;

  If blnPerComTabela Then
  Begin
    pNovaColuna('ITE_COMTB1_NOV');
    pNovaColuna('ITE_COMTB2_NOV');
    pNovaColuna('ITE_COMTB3_NOV');
    pNovaColuna('ITE_COMTB4_NOV');
    pNovaColuna('ITE_COMTB5_NOV');
    pNovaColuna('ITE_COMTB6_NOV');
    pNovaColuna('ITE_COMTB7_NOV');
  End;

  pNovaColuna('ITE_CODABF_NOV');
  pNovaColuna('ITE_ABFPIS_NOV');
  pNovaColuna('ITE_ABFCOF_NOV');
  pNovaColuna('ITE_ABFIPI_NOV');
  pNovaColuna('ITE_INCPIS_NOV');
  pNovaColuna('ITE_COMLUB_NOV');
  pNovaColuna('ITE_IMPLIS_NOV');
  pNovaColuna('ITE_ITEATI_NOV');
  pNovaColuna('ITE_LOCFIS_NOV');
  pNovaColuna('ITE_ESTMAX_NOV');
  pNovaColuna('ITE_ESTMIN_NOV');
  pNovaColuna('ITE_TAMLCF_NOV');
  pNovaColuna('ITE_LOCSUP_NOV');
  pNovaColuna('ITE_TAMLCS_NOV');
  pNovaColuna('ITE_CODLSE_NOV');
  pNovaColuna('ITE_PRECUS_NOV');
  pNovaColuna('ITE_CUSREA_NOV');
  pNovaColuna('ITE_ABRFIS_NOV');
  pNovaColuna('ITE_OUTVAL_NOV');
  pNovaColuna('ITE_IMPFED_NOV');
  pNovaColuna('ITE_MLTCOM_NOV');
  pNovaColuna('ITE_MLTVEN_NOV');
  pNovaColuna('ITE_CODFAB_NOV');
  pNovaColuna('ITE_CODBAR_NOV');
  pNovaColuna('ITE_QTPPRO_NOV');
  pNovaColuna('ITE_CPRCEN_NOV');
  pNovaColuna('ITE_DESADB_NOV');
  pNovaColuna('ITE_MESGIR_NOV');
  pNovaColuna('ITE_TMPGAR_NOV');
  pNovaColuna('ITE_INFGAR_NOV');
  pNovaColuna('ITE_EMBALA_NOV');
  pNovaColuna('ITE_BAREMB_NOV');
  pNovaColuna('ITE_PESOIT_NOV');
  pNovaColuna('ITE_PESLIQ_NOV');
  pNovaColuna('ITE_INFLAM_NOV');
  pNovaColuna('ITE_USABON_NOV');

  If blnUsaFle Then
    pNovaColuna('ITE_USAFLE_NOV');

  pNovaColuna('ITE_OBRCPF_NOV');
  pNovaColuna('ITE_OBRIBA_NOV');
  pNovaColuna('ITE_OBRNFE_NOV');
  pNovaColuna('ITE_NVLGIR_NOV');

  If chkNvlCri.Visible Then
    pNovaColuna('ITE_NVLCRI_NOV');

  If chkNivCri.Visible Then
    pNovaColuna('ITE_NIVCRI_NOV');

  pNovaColuna('ITE_PROEMB_NOV');
  pNovaColuna('ITE_ACOOBJ_NOV');
  pNovaColuna('ITE_VALOBR_NOV');
  pNovaColuna('ITE_CODUNI_NOV');
  pNovaColuna('ITE_TIPPRO_NOV');
  pNovaColuna('ITE_UNICOM_NOV');
  pNovaColuna('ITE_UNITRI_NOV');
  pNovaColuna('ITE_FATUTR_NOV');
  pNovaColuna('ITE_CODMAR_NOV');
  pNovaColuna('ITE_SITPRO_NOV');

  If blnValFor Then
    pNovaColuna('ITE_DTAVAL_NOV');

  If fCfgSis('CADMON', varBoolean) Then
    pNovaColuna('ITE_CODMON_NOV');

  pNovaColuna('ITE_CODFOR_NOV');
  pNovaColuna('ITE_DIAFOR_NOV');

  If fCfgSis('PRAMIN', varBoolean) Then
    pNovaColuna('ITE_PRAMIN_NOV');

  pNovaColuna('ITE_REAEND_NOV');
  pNovaColuna('ITE_OBRBAR_NOV');
  pNovaColuna('ITE_FATCOM_NOV');
  pNovaColuna('ITE_CODDEP_NOV');
  pNovaColuna('ITE_NOTESP_NOV');
  pNovaColuna('ITE_PRDGRU_NOV');
  pNovaColuna('ITE_ATICOM_NOV');
  pNovaColuna('ITE_PEFUTP_NOV');
  pNovaColuna('ITE_PEEFUT_NOV');
  pNovaColuna('ITE_PEFFPR_NOV');

  if chkCodDic.Visible Then
    pNovaColuna('ITE_CODDIC_NOV');

  if chkImpEti.Visible Then
    pNovaColuna('ITE_IMPETI_NOV');

  If chkDensid.Visible Then
    pNovaColuna('ITE_DENSID_NOV');

  If chkPesObr.Visible Then
    pNovaColuna('ITE_PESOBR_NOV');

  pNovaColuna('ITE_CODGRU_NOV');
  pNovaColuna('ITE_TIPFRE_NOV');
  pNovaColuna('ITE_VLCFRE_NOV');
  pNovaColuna('ITE_CODLSE_NOV');

  If fUsaRotinaWMS Then
    pNovaColuna('ITE_RASTRE_NOV');

  pNovaColuna('ITE_FATCMP_NOV');

  pNovaColuna('ITE_LARVID_NOV');
  pNovaColuna('ITE_ALTVID_NOV');
  pNovaColuna('ITE_LAMAVI_NOV');
  pNovaColuna('ITE_ALMAVI_NOV');

  If (fCfgSis('CLAONU', varBoolean)) Then
    pNovaColuna('ITE_CODONU_NOV');

  pNovaColuna('ITE_RECDEV_NOV');

  If (blnUtiAmp) Then
    pNovaColuna('ITE_UTIAMP_NOV');

  If blnLotePD Then
    pNovaColuna('ITE_LOTEPD_NOV');

  If (blnOrdSer) Then
    pNovaColuna('ITE_ORDSER_NOV');

  pNovaColuna('ITE_CLACRM_NOV');

  pNovaColuna('ITE_CPESOB_NOV');

  If chkDesCnd.Visible Then
    pNovaColuna('ITE_DESCND_NOV');

  strCusto := 'ITE_PRECOM_NOV_' + 'ITE_DESF01_NOV_' + 'ITE_DESF02_NOV_' +
              'ITE_DESF03_NOV_' + 'ITE_DESF04_NOV_' + 'ITE_DESF05_NOV_' +
              'ITE_DESF06_NOV_' + 'ITE_ICMENT_NOV_' + 'ITE_IPIENT_NOV_' +
              'ITE_FREENT_NOV_' + 'ITE_ACRFIN_NOV_' + 'ITE_SUBSTI_NOV_' +
              'ITE_DESADB_NOV_' + 'ITE_DESOPE_NOV_' +
              'ITE_OUTVAL_NOV_' + 'ITE_IMPFED_NOV_' +
              'ITE_VALFRE_NOV_' + 'ITE_SUBFED_NOV_';

  strVenda := 'ITE_ICMSAI_NOV_' +
          //    'ITE_DESMAX_NOV_' + 'ITE_DESMGE_NOV_' + 'ITE_DESMSU_NOV_' +
              'ITE_MARBR1_NOV_' + 'ITE_COMTB1_NOV_' + 'ITE_PREVE1_NOV_' +
              'ITE_MARBR2_NOV_' + 'ITE_COMTB2_NOV_' + 'ITE_PREVE2_NOV_' +
              'ITE_MARBR3_NOV_' + 'ITE_COMTB3_NOV_' + 'ITE_PREVE3_NOV_' +
              'ITE_MARBR4_NOV_' + 'ITE_COMTB4_NOV_' + 'ITE_PREVE4_NOV_' +
              'ITE_MARBR5_NOV_' + 'ITE_COMTB5_NOV_' + 'ITE_PREVE5_NOV_' +
              'ITE_MARBR6_NOV_' + 'ITE_COMTB6_NOV_' + 'ITE_PREVE6_NOV_' +
              'ITE_MARBR7_NOV_' + 'ITE_COMTB7_NOV_' + 'ITE_PREVE7_NOV_' ;

  inherited;

  {************************}
  { INSTÂNCIA QRY GENERICA }
  {*********************JB*}
  qryGen := fCriaQuery(Self);
  dtsGen := fCriaDataSource(qryGen);

  qryGen.BeforeInsert   := pBeforeInsert;
  qryGen.AfterScroll    := pAtualizaGrid;
  qryGen.BeforeScroll   := pBeforeScroll;
  qryGen.OnFilterRecord := pFilterRecord;

  dbeCodIte.DataSource   := dtsGen;
  dbeDesIte.DataSource   := dtsGen;
  dbeRefere.DataSource   := dtsGen;
  dbeUnidad.DataSource   := dtsGen;
  dbeAltPre.DataSource   := dtsGen;

  pAtribuiTabelas;
  qryGen.BeforePost := pAtualizaDados;
  pMostraColunasAntigas(False);
  pMostraColunasAntigasCx(False);

  qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE', Self);
  fAbrirTabela(qryPreAlt);

  pnlBusca.Visible := False;

  chkUsaFle.Checked := blnUsaFle;
  chkUsaFle.Visible := blnUsaFle;

  chkLotePD.Checked := blnLotePD;
  chkLotePD.Visible := blnLotePD;

  edtDocumento.MaxLength := fTamNumDoc();
  edtDocumento.TamCampo  := edtDocumento.MaxLength;

  //CFG_INFMED Altura Ou Comprimento
  chkAlMavi.Caption := fRetornaInfMedVIDRO(False,False,True,False)+ ' (Venda Parcial)';
  chkAltVid.Caption := fRetornaInfMedVIDRO;

  if blnMarIde then
  begin
    for intCont := 1 to Length(VS_strTabPrc) do
    begin
      if VS_strTabPrc[intCont] = 'S' then
      begin
        cbxTabPrc.Items.Add(IntToStr(intCont));
      end;
    end;

    pHabilitaCamposMargemIdeal;
  end
  else
  begin
    lblMarIde.Visible  := False;
    cbxMarIde.Visible  := False;
    lblTabPrc.Visible  := False;
    cbxTabPrc.Visible  := False;

    edtDesPrdPro.Width := 236;
    edtDesGruCmp.Width := 370;
    edtDesGpr.Width    := 370;
    edtDesDep.Width    := 370;
  end;

  strEstEmp := fCadEmp('ESTADO');

  pMontaCampos;
end;

procedure TfrmAltPrecoIndividual.pTravaPrecos;
  Var
    intCont: Integer;
Begin
  If blnBloPre Then
  Begin

    For intCont := 1 To 7 Do
    Begin
      fCheckBox('chkMarBr' + IntToStr(intCont)).Enabled := False;
      fCheckBox('chkMarBr' + IntToStr(intCont)).Checked := False;

      fCheckBox('chkPreVe' + IntToStr(intCont)).Enabled := False;
      fCheckBox('chkPreVe' + IntToStr(intCont)).Checked := False;
    End;

  End;
End;

procedure TfrmAltPrecoIndividual.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);

end;

procedure TfrmAltPrecoIndividual.edtCodUniExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodUni, nil, arrCodUni ,fRetNomUnidade, Nil, 'da Unidade');
end;

procedure TfrmAltPrecoIndividual.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, nil, nil, qryConUni, Key, arrCodUni, False) Then
  Begin
    if fValidaCampos(edtCodUni, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoIndividual.edtDocumentoExit(Sender: TObject);
begin
  inherited;

  cbxOrdem.ItemIndex := 0;
  If fEmptyStr(edtDocumento.Text) Then
  Begin
    edtSerie.Clear;
    edtCodEmpresa.Clear;
    edtDesEmpresa.Clear;
    edtCodFor.Clear;
    edtNomFor.Clear;
    edtEspecie.Text    := 'NF';
    lblEspecie.Enabled := False;
    lblSerie.Enabled   := False;
    lblEmpresa.Enabled := False;
    lblOrdem.Enabled   := False;
    edtEspecie.Enabled := False;
    edtSerie.Enabled   := False;
    cbxOrdem.Enabled   := False;
    edtCodEmpresa.Enabled := False;
    lblFornec.Caption  := 'Fornecedor:';
    pSetFocus(edtCodFor);
  End
  Else
  Begin
    lblEspecie.Enabled := True;
    lblSerie.Enabled   := True;
    lblEmpresa.Enabled := True;
    lblOrdem.Enabled   := True;
    edtEspecie.Enabled := True;
    edtSerie.Enabled   := True;
    edtCodEmpresa.Enabled := True;
    cbxOrdem.Enabled   := True;
    lblFornec.Caption  := 'Forn. Doc.:';
    pSetFocus(edtEspecie);
  End;

end;



procedure TfrmAltPrecoIndividual.edtExcIpiExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtExcIpi.Text) Then
    edtExcIpi.Text := fStrZero(edtExcIpi.Text, 3);
end;

procedure TfrmAltPrecoIndividual.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmAltPrecoIndividual.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE COMPRA *}
  {*********************************RV*}
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmAltPrecoIndividual.edtIncPisExit(Sender: TObject);
begin
  inherited;
  pSetFocus(chkCODITE);
end;

procedure TfrmAltPrecoIndividual.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupoPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmAltPrecoIndividual.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupoPro, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoIndividual.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmAltPrecoIndividual.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoIndividual.edtCodMonExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMon, edtDesMon, arrCodMon, fRetNomMontadora, nil, 'do Departamento');
end;

procedure TfrmAltPrecoIndividual.edtCodMonKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMontadora(Self, edtCodMon, edtDesMon, Nil, Key, arrCodMon, False) Then
  Begin
    If fValidaCampos(edtCodMon, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoIndividual.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmAltPrecoIndividual.edtCodForKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoIndividual.edtCodGprExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGpr, edtDesGpr,    arrCodGpr, fRetNomeGrupoPrecos, Nil, 'do Grupo de Preço');
end;

procedure TfrmAltPrecoIndividual.edtCodGprKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoPrecos(Self, edtCodGpr, edtDesGpr, Nil, Key, arrCodGpr, False) Then
  Begin
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{************************************}
{* CRIA TEMPORARIA                  *}
{*********************************AF*}
procedure TfrmAltPrecoIndividual.pCriaTemporaria;
  Var
    strSQL    : String;
    strTabPrc : String;
    intCorre  : Integer;
    qryGenTmp : TUniQuery;
Begin
  Try
    strTabPrc := '';

    qryGenTmp := fCriaQuery(Self);

    strTabela := 'TMP_ALTPRE' + fRetSeqTmp;

    strSQL := '';
    strSQL := strSQL + 'DROP TABLE IF EXISTS ' + strTabela + '; ';

    {******************************}
    {* SELECT PARA CARREGAR DADOS *}
    {***************************AF*}
    strSQL := strSQL + 'CREATE TABLE ' + strTabela + '( ';
    strSQL := strSQL + '  ITE_CODITE VARCHAR(05), ';
    strSQL := strSQL + '  ITE_DESITE VARCHAR(70), ';
    strSQL := strSQL + '  ITE_IMPULT NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_PREDOL CHAR(1), ';
    strSQL := strSQL + '  ITE_REFERE VARCHAR(16), ';
    strSQL := strSQL + '  ITE_SALDOS NUMERIC(12, 4), ';  //Saldo atual
    strSQL := strSQL + '  ITE_PREMED NUMERIC(12, 4), ';  // PREÇO MEDIO
    strSQL := strSQL + '  ITE_DTAALT DATE, ';            // DATA TA ULTIMA ALTERAÇÃO DE PREÇO
    strSQL := strSQL + '  ITE_PR1ANT NUMERIC(12, 4), ';  // PREÇO VENDA 1 ANTERIOR
    strSQL := strSQL + '  ITE_PR2ANT NUMERIC(12, 4), ';  // PREÇO VENDA 2 ANTERIOR
    strSQL := strSQL + '  ITE_PR3ANT NUMERIC(12, 4), ';  // PREÇO VENDA 3 ANTERIOR
    strSQL := strSQL + '  ITE_PR4ANT NUMERIC(12, 4), ';  // PREÇO VENDA 4 ANTERIOR
    strSQL := strSQL + '  ITE_PR5ANT NUMERIC(12, 4), ';  // PREÇO VENDA 5 ANTERIOR
    strSQL := strSQL + '  ITE_PR6ANT NUMERIC(12, 4), ';  // PREÇO VENDA 6 ANTERIOR
    strSQL := strSQL + '  ITE_PR7ANT NUMERIC(12, 4), ';  // PREÇO VENDA 7 ANTERIOR

    strSQL := strSQL + '  ITE_CODGRU_NOV VARCHAR(06), ';
    strSQL := strSQL + '  ITE_CODGRU VARCHAR(06), ';
    strSQL := strSQL + '  ITE_TIPFRE_NOV VARCHAR(1), ';
    strSQL := strSQL + '  ITE_TIPFRE VARCHAR(1), ';
    strSQL := strSQL + '  ITE_VLCFRE_NOV NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_VLCFRE NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_CLAIPI_NOV VARCHAR(10), '; //Classificação de IPI
    strSQL := strSQL + '  ITE_CLAIPI VARCHAR(10), ';
    strSQL := strSQL + '  ITE_EXCIPI_NOV CHAR(3), '; //Código EX IPI
    strSQL := strSQL + '  ITE_EXCIPI CHAR(3), ';
    strSQL := strSQL + '  ITE_GRUCMP_NOV VARCHAR(3), '; //Grupo de compra
    strSQL := strSQL + '  ITE_GRUCMP VARCHAR(3), ';
    strSQL := strSQL + '  ITE_RECDEV_NOV VARCHAR(1), '; //Recebe Devolução
    strSQL := strSQL + '  ITE_RECDEV VARCHAR(1), ';

    strSQL := strSQL + '  ITE_CDCEST_NOV CHAR(7), '; //Código CEST
    strSQL := strSQL + '  ITE_CDCEST CHAR(7), ';
    strSQL := strSQL + '  ITE_APLICA_NOV CHAR(255), '; //Código CEST
    strSQL := strSQL + '  ITE_APLICA CHAR(255), ';
    strSQL := strSQL + '  ITE_NOVO_REAL TEXT, ';

    strSQL := strSQL + '  ITE_PER_CI_NOV NUMERIC(12,2), ';
    strSQL := strSQL + '  ITE_PER_CI NUMERIC(12,2), ';
    strSQL := strSQL + '  ITE_NUMFCI_NOV VARCHAR(50), ';
    strSQL := strSQL + '  ITE_NUMFCI VARCHAR(50), ';
    strSQL := strSQL + '  ITE_ABRFIS_NOV VARCHAR(40), '; //Abreviação Fiscal
    strSQL := strSQL + '  ITE_ABRFIS VARCHAR(40), ';
    strSQL := strSQL + '  ITE_PRECOM_NOV NUMERIC(12, 4), '; //Preço de compra
    strSQL := strSQL + '  ITE_PRECOM NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_PREVE1_NOV NUMERIC(12, 4), '; //Preço de Venda 1
    strSQL := strSQL + '  ITE_PREVE1 NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_PREVE2_NOV NUMERIC(12, 4), '; //Preço de Venda 2
    strSQL := strSQL + '  ITE_PREVE2 NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_PREVE3_NOV NUMERIC(12, 4), '; //Preço de Venda 3
    strSQL := strSQL + '  ITE_PREVE3 NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_PREVE4_NOV NUMERIC(12, 4), '; //Preço de Venda 4
    strSQL := strSQL + '  ITE_PREVE4 NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_PREVE5_NOV NUMERIC(12, 4), '; //Preço de Venda 5
    strSQL := strSQL + '  ITE_PREVE5 NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_PREVE6_NOV NUMERIC(12, 4), '; //Preço de Venda 6
    strSQL := strSQL + '  ITE_PREVE6 NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_PREVE7_NOV NUMERIC(12, 4), '; //Preço de Venda 7
    strSQL := strSQL + '  ITE_PREVE7 NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_DESF01_NOV NUMERIC(12, 2), '; //% Desc. Fornec. 01
    strSQL := strSQL + '  ITE_DESF01 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_DESF02_NOV NUMERIC(12, 2), '; //% Desc. Fornec. 02
    strSQL := strSQL + '  ITE_DESF02 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_DESF03_NOV NUMERIC(12, 2), '; //% Desc. Fornec. 03
    strSQL := strSQL + '  ITE_DESF03 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_DESF04_NOV NUMERIC(12, 2), '; //% Desc. Fornec. 04
    strSQL := strSQL + '  ITE_DESF04 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_DESF05_NOV NUMERIC(12, 2), '; //% Desc. Fornec. 05
    strSQL := strSQL + '  ITE_DESF05 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_DESF06_NOV NUMERIC(12, 2), '; //% Desc. Fornec. 06
    strSQL := strSQL + '  ITE_DESF06 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_ICMENT_NOV NUMERIC(12, 2), '; //% ICMS Entrada
    strSQL := strSQL + '  ITE_ICMENT NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_SUBFED_NOV NUMERIC(12, 2), '; //% Impostos Federais (-)
    strSQL := strSQL + '  ITE_SUBFED NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_IPIENT_NOV NUMERIC(12, 2), '; //% IPI Entrada
    strSQL := strSQL + '  ITE_IPIENT NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_ABAMLT_NOV CHAR(1), '; //Abastecimento Múltiplo
    strSQL := strSQL + '  ITE_ABAMLT CHAR(1), ';
    strSQL := strSQL + '  ITE_FREENT_NOV NUMERIC(12, 2), '; //% Frete Entrada
    strSQL := strSQL + '  ITE_FREENT NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_VALFRE_NOV NUMERIC(12, 2), '; //Valor Frete Entrada
    strSQL := strSQL + '  ITE_VALFRE NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_ACRFIN_NOV NUMERIC(12, 2), '; //% Acresc.Financ.
    strSQL := strSQL + '  ITE_ACRFIN NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_SUBSTI_NOV NUMERIC(12, 2), '; //% Subst. Tributária
    strSQL := strSQL + '  ITE_SUBSTI NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_DESADB_NOV NUMERIC(12, 2), '; //% Desconto Adicional (Boleto)
    strSQL := strSQL + '  ITE_DESADB NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_OUTVAL_NOV NUMERIC(12, 4), '; //Outros Valores
    strSQL := strSQL + '  ITE_OUTVAL NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_ICMSAI_NOV NUMERIC(12, 2), '; //% ICMS Saída
    strSQL := strSQL + '  ITE_ICMSAI NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_IPISAI_NOV NUMERIC(12, 2), '; //% IPI Saída
    strSQL := strSQL + '  ITE_IPISAI NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_IMPFED_NOV NUMERIC(12, 2), '; //% Impostos Federais
    strSQL := strSQL + '  ITE_IMPFED NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MLTCOM_NOV NUMERIC(12,2), '; //Múltiplo para Compra
    strSQL := strSQL + '  ITE_MLTCOM NUMERIC(12,2), ';
    strSQL := strSQL + '  ITE_MLTVEN_NOV NUMERIC(12,4), '; //Múltiplo para Venda
    strSQL := strSQL + '  ITE_MLTVEN NUMERIC(12,4), ';
    strSQL := strSQL + '  ITE_DESOPE_NOV NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_DESOPE NUMERIC(12, 2), ';

    if not blnIteTbp Then
    Begin
      strSQL := strSQL + '  ITE_DESMAX_NOV NUMERIC(12, 2), '; //% Desc.Maximo
      strSQL := strSQL + '  ITE_DESMAX NUMERIC(12, 2), ';
      strSQL := strSQL + '  ITE_DESMGE_NOV NUMERIC(12, 2), '; //% Desc.Maximo Gerente
      strSQL := strSQL + '  ITE_DESMGE NUMERIC(12, 2), ';
      strSQL := strSQL + '  ITE_DESMSU_NOV NUMERIC(12, 2), '; //% Desc.Maximo Sub-Gerente
      strSQL := strSQL + '  ITE_DESMSU NUMERIC(12, 2), ';
    End
    Else
    Begin
      For intCorre := 1 To Length(VS_strTabPrc) Do
      Begin
        strSQL := strSQL + '  ITE_DESMA' + intToStr(intCorre) + '_NOV NUMERIC(12, 2), '; //% Desc.Maximo
        strSQL := strSQL + '  ITE_DESMA' + intToStr(intCorre) + ' NUMERIC(12, 2), ';
        strSQL := strSQL + '  ITE_DESMG' + intToStr(intCorre) + '_NOV NUMERIC(12, 2), '; //% Desc.Maximo Gerente
        strSQL := strSQL + '  ITE_DESMG' + intToStr(intCorre) + ' NUMERIC(12, 2), ';
        strSQL := strSQL + '  ITE_DESMS' + intToStr(intCorre) + '_NOV NUMERIC(12, 2), '; //% Desc.Maximo Gerente
        strSQL := strSQL + '  ITE_DESMS' + intToStr(intCorre) + ' NUMERIC(12, 2), ';
      End;

    End;

    strSQL := strSQL + '  ITE_COMVAR_NOV NUMERIC(12, 2), '; //% Comis. Vendedor Interno
    strSQL := strSQL + '  ITE_COMVAR NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMATA_NOV NUMERIC(12, 2), '; //% Comis. Repres. Ext. Loja
    strSQL := strSQL + '  ITE_COMATA NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMDIS_NOV NUMERIC(12, 2), '; //% Comis. Repres. Ext. Distribuidor
    strSQL := strSQL + '  ITE_COMDIS NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMDIG_NOV NUMERIC(12, 2), '; //% Comis. Digitador
    strSQL := strSQL + '  ITE_COMDIG NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMPRO_NOV NUMERIC(12, 2), '; //% Comis. Profissional
    strSQL := strSQL + '  ITE_COMPRO NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_QTPPRO_NOV DECIMAL(14, 2), '; //Quantidade de Prontos Profissional
    strSQL := strSQL + '  ITE_QTPPRO DECIMAL(14, 2), ';

    strSQL := strSQL + '  ITE_CPRCEN_NOV CHAR(1), '; //Compra centralizada
    strSQL := strSQL + '  ITE_CPRCEN CHAR(1), ';
    strSQL := strSQL + '  ITE_PESOIT_NOV DECIMAL(14,3), '; //Peso
    strSQL := strSQL + '  ITE_PESOIT DECIMAL(14,3), ';
    strSQL := strSQL + '  ITE_PESLIQ_NOV DECIMAL(14,3), '; //Peso
    strSQL := strSQL + '  ITE_PESLIQ DECIMAL(14,3), ';
    strSQL := strSQL + '  ITE_INFLAM_NOV CHAR(1), '; //Produto Inflamável
    strSQL := strSQL + '  ITE_INFLAM CHAR(1), ';
    strSQL := strSQL + '  ITE_USABON_NOV CHAR(1), '; //Usa bonificação?
    strSQL := strSQL + '  ITE_USABON CHAR(1), ';
    strSQL := strSQL + '  ITE_USAFLE_NOV CHAR(1), '; //Usa Flex?
    strSQL := strSQL + '  ITE_USAFLE CHAR(1), ';
    strSQL := strSQL + '  ITE_OBRCPF_NOV CHAR(1), '; //Venda c/ obrigat. CPF/CNPJ
    strSQL := strSQL + '  ITE_OBRCPF CHAR(1), ';
    strSQL := strSQL + '  ITE_OBRIBA_NOV CHAR(1), '; //Venda c/ obrigat. Cód IBAMA
    strSQL := strSQL + '  ITE_OBRIBA CHAR(1), ';
    strSQL := strSQL + '  ITE_OBRNFE_NOV CHAR(1), '; //Venda c/ obrigat. NFe
    strSQL := strSQL + '  ITE_OBRNFE CHAR(1), ';
    strSQL := strSQL + '  ITE_NVLGIR_NOV CHAR(1), '; //Nível de Giro de Estoque
    strSQL := strSQL + '  ITE_NVLGIR CHAR(1), ';

    strSQL := strSQL + '  ITE_NVLCRI_NOV CHAR(1), '; //Nível de Criticidade de Estoque Geral
    strSQL := strSQL + '  ITE_NVLCRI CHAR(1), ';

    strSQL := strSQL + '  ITE_NIVCRI_NOV CHAR(1), '; //Nível de Criticidade de Estoque
    strSQL := strSQL + '  ITE_NIVCRI CHAR(1), ';

    strSQL := strSQL + '  ITE_PROEMB_NOV CHAR(1), '; //Produto Embalagem
    strSQL := strSQL + '  ITE_PROEMB CHAR(1), ';
    strSQL := strSQL + '  ITE_ACOOBJ_NOV VARCHAR(20), '; //Acordo de Objetivos
    strSQL := strSQL + '  ITE_ACOOBJ VARCHAR(20), ';
    strSQL := strSQL + '  ITE_VALOBR_NOV CHAR(1), '; //Validade Obrigatória
    strSQL := strSQL + '  ITE_VALOBR CHAR(1), ';

    strSQL := strSQL + '  ITE_MARBR1_NOV NUMERIC(12, 2), '; //% Margem Bruta 1
    strSQL := strSQL + '  ITE_MARBR1 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARBR2_NOV NUMERIC(12, 2), '; //% Margem Bruta 2
    strSQL := strSQL + '  ITE_MARBR2 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARBR3_NOV NUMERIC(12, 2), '; //% Margem Bruta 3
    strSQL := strSQL + '  ITE_MARBR3 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARBR4_NOV NUMERIC(12, 2), '; //% Margem Bruta 4
    strSQL := strSQL + '  ITE_MARBR4 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARBR5_NOV NUMERIC(12, 2), '; //% Margem Bruta 5
    strSQL := strSQL + '  ITE_MARBR5 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARBR6_NOV NUMERIC(12, 2), '; //% Margem Bruta 6
    strSQL := strSQL + '  ITE_MARBR6 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARBR7_NOV NUMERIC(12, 2), '; //% Margem Bruta 7
    strSQL := strSQL + '  ITE_MARBR7 NUMERIC(12, 2), ';

    strSQL := strSQL + '  ITE_MARID1_NOV NUMERIC(12, 2), '; //% Margem Ideal 1
    strSQL := strSQL + '  ITE_MARID1 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARID2_NOV NUMERIC(12, 2), '; //% Margem Ideal 2
    strSQL := strSQL + '  ITE_MARID2 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARID3_NOV NUMERIC(12, 2), '; //% Margem Ideal 3
    strSQL := strSQL + '  ITE_MARID3 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARID4_NOV NUMERIC(12, 2), '; //% Margem Ideal 4
    strSQL := strSQL + '  ITE_MARID4 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARID5_NOV NUMERIC(12, 2), '; //% Margem Ideal 5
    strSQL := strSQL + '  ITE_MARID5 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARID6_NOV NUMERIC(12, 2), '; //% Margem Ideal 6
    strSQL := strSQL + '  ITE_MARID6 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_MARID7_NOV NUMERIC(12, 2), '; //% Margem Ideal 7
    strSQL := strSQL + '  ITE_MARID7 NUMERIC(12, 2), ';

    strSQL := strSQL + '  ITE_COMTB1_NOV NUMERIC(12, 2), '; //% Comissao Tabela 1
    strSQL := strSQL + '  ITE_COMTB1 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMTB2_NOV NUMERIC(12, 2), '; //% Comissao Tabela 2
    strSQL := strSQL + '  ITE_COMTB2 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMTB3_NOV NUMERIC(12, 2), '; //% Comissao Tabela 3
    strSQL := strSQL + '  ITE_COMTB3 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMTB4_NOV NUMERIC(12, 2), '; //% Comissao Tabela 4
    strSQL := strSQL + '  ITE_COMTB4 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMTB5_NOV NUMERIC(12, 2), '; //% Comissao Tabela 5
    strSQL := strSQL + '  ITE_COMTB5 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMTB6_NOV NUMERIC(12, 2), '; //% Comissao Tabela 6
    strSQL := strSQL + '  ITE_COMTB6 NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_COMTB7_NOV NUMERIC(12, 2), '; //% Comissao Tabela 7
    strSQL := strSQL + '  ITE_COMTB7 NUMERIC(12, 2), ';

    strSQL := strSQL + '  ITE_CODABF_NOV VARCHAR(03), '; //Abrev. Fiscal
    strSQL := strSQL + '  ITE_CODABF VARCHAR(03), ';
    strSQL := strSQL + '  ITE_ABFPIS_NOV VARCHAR(03), '; //Abrev. PIS
    strSQL := strSQL + '  ITE_ABFPIS VARCHAR(03), ';
    strSQL := strSQL + '  ITE_ABFCOF_NOV VARCHAR(03), '; //Abrev. COFINS
    strSQL := strSQL + '  ITE_ABFCOF VARCHAR(03), ';
    strSQL := strSQL + '  ITE_ABFIPI_NOV VARCHAR(03), '; //Abrev. IPI
    strSQL := strSQL + '  ITE_ABFIPI VARCHAR(03), ';
    strSQL := strSQL + '  ITE_INCPIS_NOV CHAR(1), '; //Incide PIS?
    strSQL := strSQL + '  ITE_INCPIS CHAR(1), ';
    strSQL := strSQL + '  ITE_COMLUB_NOV VARCHAR(1), '; //Combustível/Lubrificante?
    strSQL := strSQL + '  ITE_COMLUB VARCHAR(1), ';
    strSQL := strSQL + '  ITE_IMPLIS_NOV VARCHAR(1), '; //Imp. Lista?
    strSQL := strSQL + '  ITE_IMPLIS VARCHAR(1), ';
    strSQL := strSQL + '  ITE_ITEATI_NOV VARCHAR(1), '; //Ativo?
    strSQL := strSQL + '  ITE_ITEATI VARCHAR(1), ';
    strSQL := strSQL + '  ITE_LOCFIS_NOV VARCHAR('+IntToStr(intLocFis)+'),';//Local. Fisica
    strSQL := strSQL + '  ITE_LOCFIS VARCHAR('+IntToStr(intLocFis)+'),';
    strSQL := strSQL + '  ITE_ESTMAX_NOV NUMERIC(14,3),  ';  //Estoque Máximo
    strSQL := strSQL + '  ITE_ESTMAX NUMERIC(14,3),      ';
    strSQL := strSQL + '  ITE_ESTMIN_NOV NUMERIC(14,3),  ';  //Estoque Mínimo
    strSQL := strSQL + '  ITE_ESTMIN NUMERIC(14,3),      ';
    strSQL := strSQL + '  ITE_TAMLCF_NOV VARCHAR(30), '; //Tamanho Local. Fisica
    strSQL := strSQL + '  ITE_TAMLCF VARCHAR(30), ';
    strSQL := strSQL + '  ITE_LOCSUP_NOV VARCHAR(10), '; //Local. Super Estoque
    strSQL := strSQL + '  ITE_LOCSUP VARCHAR(10), ';
    strSQL := strSQL + '  ITE_TAMLCS_NOV VARCHAR(30), '; //Tamanho Local. Super Estoque
    strSQL := strSQL + '  ITE_TAMLCS VARCHAR(30), ';
    strSQL := strSQL + '  ITE_CODLSE_NOV VARCHAR(10), '; //Local. de Separação
    strSQL := strSQL + '  ITE_CODLSE VARCHAR(10), ';
    strSQL := strSQL + '  ITE_PRECUS_NOV NUMERIC(12, 4), '; //Preço de Custo
    strSQL := strSQL + '  ITE_PRECUS NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_CUSREA_NOV NUMERIC(12, 4), '; //Preço de Custo
    strSQL := strSQL + '  ITE_CUSREA NUMERIC(12, 4), ';
    strSQL := strSQL + '  ITE_CODEMP VARCHAR(3), ';
    strSQL := strSQL + '  ITE_MARMIN_NOV NUMERIC(12, 2), '; //Margem Mínima Vendedor
    strSQL := strSQL + '  ITE_MARMIN NUMERIC(12, 2),     ';
    strSQL := strSQL + '  ITE_MARMSG_NOV NUMERIC(12, 2), '; //Margem Mínima Sub gerente
    strSQL := strSQL + '  ITE_MARMSG NUMERIC(12, 2),     ';
    strSQL := strSQL + '  ITE_MARMGE_NOV NUMERIC(12, 2), '; //Margem Mínima Gerente
    strSQL := strSQL + '  ITE_MARMGE NUMERIC(12, 2),     ';
    strSQL := strSQL + '  ITE_CODFAB_NOV VARCHAR(35),    ';
    strSQL := strSQL + '  ITE_CODFAB VARCHAR(35),        ';
    strSQL := strSQL + '  ITE_CODBAR_NOV VARCHAR(15),    ';
    strSQL := strSQL + '  ITE_CODBAR VARCHAR(15),        ';
    strSQL := strSQL + '  ITE_MESGIR_NOV INTEGER(3),     ';
    strSQL := strSQL + '  ITE_MESGIR INTEGER(3),         ';
    strSQL := strSQL + '  ITE_TMPGAR_NOV INTEGER(6),     ';
    strSQL := strSQL + '  ITE_TMPGAR INTEGER(6),         ';
    strSQL := strSQL + '  ITE_INFGAR_NOV VARCHAR(50),    ';
    strSQL := strSQL + '  ITE_INFGAR VARCHAR(50),        ';
    strSQL := strSQL + '  ITE_EMBALA_NOV NUMERIC(12,' +  IntToStr(DEC_EMBALAGEM) + '),  ';
    strSQL := strSQL + '  ITE_EMBALA NUMERIC(12,' +  IntToStr(DEC_EMBALAGEM) + '),      ';
    strSQL := strSQL + '  ITE_BAREMB_NOV VARCHAR(15),    ';
    strSQL := strSQL + '  ITE_BAREMB VARCHAR(15),        ';
    strSQL := strSQL + '  ITE_CODUNI_NOV CHAR(2), ';        //Unidade
    strSQL := strSQL + '  ITE_CODUNI CHAR(2), ';
    strSQL := strSQL + '  ITE_TIPPRO_NOV CHAR(2), ';        //Tipo do produto
    strSQL := strSQL + '  ITE_TIPPRO CHAR(2), ';
    strSQL := strSQL + '  ITE_UNICOM_NOV CHAR(2), ';        //Unidade de Compra
    strSQL := strSQL + '  ITE_UNICOM CHAR(2), ';
    strSQL := strSQL + '  ITE_UNITRI_NOV CHAR(2), ';        //Unidade de Compra
    strSQL := strSQL + '  ITE_UNITRI CHAR(2), ';
    strSQL := strSQL + '  ITE_FATUTR_NOV DECIMAL(16,6), ';        //Unidade Tributaria
    strSQL := strSQL + '  ITE_FATUTR DECIMAL(16,6), ';
    strSQL := strSQL + '  ITE_CODMAR_NOV CHAR(' + IntToStr(fTamCodMar) + '), ';        //Marca
    strSQL := strSQL + '  ITE_CODMAR CHAR(' + IntToStr(fTamCodMar) + '), ';
    strSQL := strSQL + '  ITE_SITPRO_NOV CHAR(3), ';        //Situação do Produto
    strSQL := strSQL + '  ITE_SITPRO CHAR(3), ';

    strSQL := strSQL + '  ITE_DTAVAL_NOV DATE, ';           //Data de Validade de Preço
    strSQL := strSQL + '  ITE_DTAVAL DATE, ';

    strSQL := strSQL + '  ITE_CODMON_NOV CHAR(3), ';        //Código da Montadora
    strSQL := strSQL + '  ITE_CODMON CHAR(3), ';
    strSQL := strSQL + '  ITE_CODFOR_NOV VARCHAR(8), ';     //Fornecedor
    strSQL := strSQL + '  ITE_CODFOR VARCHAR(8), ';
    strSQL := strSQL + '  ITE_DIAFOR_NOV INTEGER, ';
    strSQL := strSQL + '  ITE_DIAFOR INTEGER, ';
    strSQL := strSQL + '  ITE_PRAMIN_NOV INT(3), ';
    strSQL := strSQL + '  ITE_PRAMIN INT(3),     ';
    strSQL := strSQL + '  ITE_REAEND_NOV CHAR(1), ';
    strSQL := strSQL + '  ITE_REAEND CHAR(1), ';
    strSQL := strSQL + '  ITE_OBRBAR_NOV CHAR(1), ';
    strSQL := strSQL + '  ITE_OBRBAR CHAR(1),    ';
    strSQL := strSQL + '  ITE_FATCOM_NOV CHAR(1), ';
    strSQL := strSQL + '  ITE_FATCOM CHAR(1),    ';
    strSQL := strSQL + '  ITE_CODDEP_NOV CHAR(3), ';
    strSQL := strSQL + '  ITE_CODDEP CHAR(3),     ';
    strSQL := strSQL + '  ITE_NOTESP_NOV CHAR(1), ';
    strSQL := strSQL + '  ITE_NOTESP CHAR(1),     ';

    strSQL := strSQL + '  ITE_PEFUTP_NOV CHAR(1), ';
    strSQL := strSQL + '  ITE_PEFUTP CHAR(1),     ';
    strSQL := strSQL + '  ITE_PEEFUT_NOV CHAR(1), ';
    strSQL := strSQL + '  ITE_PEEFUT CHAR(1),     ';
    strSQL := strSQL + '  ITE_PEFFPR_NOV CHAR(1), ';
    strSQL := strSQL + '  ITE_PEFFPR CHAR(1),     ';

    strSQL := strSQL + '  ITE_MINTB1     NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB1_NOV NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB2     NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB2_NOV NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB3     NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB3_NOV NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB4     NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB4_NOV NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB5     NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB5_NOV NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB6     NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB6_NOV NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB7     NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_MINTB7_NOV NUMERIC(12,4),  ';
    strSQL := strSQL + '  ITE_PRDGRU CHAR(05), ';
    strSQL := strSQL + '  ITE_PRDGRU_NOV CHAR(05), ';
    strSQL := strSQL + '  ITE_ATICOM     VARCHAR(1),  ';
    strSQL := strSQL + '  ITE_ATICOM_NOV VARCHAR(1),  ';
    strSQL := strSQL + '  ITE_CODDIC     VARCHAR(7),  ';
    strSQL := strSQL + '  ITE_CODDIC_NOV VARCHAR(7),  ';
    strSQL := strSQL + '  ITE_IMPETI     VARCHAR(7),  ';
    strSQL := strSQL + '  ITE_IMPETI_NOV VARCHAR(7),  ';

    strSQL := strSQL + '  ITE_PRAPEL_NOV NUMERIC(12,2),'; //Unidade
    strSQL := strSQL + '  ITE_PRAPEL NUMERIC(12,2),  ';

    strSQL := strSQL + '  ITE_PRELIQ NUMERIC(12, 2), ';
    strSQL := strSQL + '  ITE_PRELIQ_NOV NUMERIC(12, 2), ';

    strSQL := strSQL + '  ITE_ALTPRE DATE, ';
    strSQL := strSQL + '  ALTERA VARCHAR(1), ';
    strSQL := strSQL + '  ITE_DESUNI VARCHAR(20), ';
    strSQL := strSQL + '  ITE_ORDINC VARCHAR(20), ';

    strSQL := strSQL + '  ITE_DENSID DECIMAL(12,4), ';
    strSQL := strSQL + '  ITE_DENSID_NOV DECIMAL(12,4), ';
    strSQL := strSQL + '  ITE_FATCMP DECIMAL(12,4), ';
    strSQL := strSQL + '  ITE_FATCMP_NOV DECIMAL(12,4), ';

    strSQL := strSQL + '  ITE_RASTRE CHAR(1), ';
    strSQL := strSQL + '  ITE_RASTRE_NOV CHAR(1), ';

    strSQL := strSQL + '  ITE_LARVID_NOV NUMERIC(12,5),  '; // Largura
    strSQL := strSQL + '  ITE_LARVID     NUMERIC(12,5),  ';
    strSQL := strSQL + '  ITE_ALTVID_NOV NUMERIC(12,5),  '; // Altura
    strSQL := strSQL + '  ITE_ALTVID     NUMERIC(12,5),  ';
    strSQL := strSQL + '  ITE_LAMAVI_NOV NUMERIC(12,5),  '; // Largura Máxima
    strSQL := strSQL + '  ITE_LAMAVI     NUMERIC(12,5),  ';
    strSQL := strSQL + '  ITE_ALMAVI_NOV NUMERIC(12,5),  '; // Altura Máxima
    strSQL := strSQL + '  ITE_ALMAVI     NUMERIC(12,5),  ';

    strSQL := strSQL + '  ITE_UTIAMP_NOV CHAR(1),  ';
    strSQL := strSQL + '  ITE_UTIAMP     CHAR(1),  ';

    strSQL := strSQL + '  ITE_PESOBR_NOV CHAR(1),  ';
    strSQL := strSQL + '  ITE_PESOBR     CHAR(1),  ';

    strSQL := strSQL + '  ITE_LOTEPD_NOV CHAR(1),  ';
    strSQL := strSQL + '  ITE_LOTEPD     CHAR(1),  ';

    strSQL := strSQL + '  ITE_ORDSER_NOV CHAR(1),  ';
    strSQL := strSQL + '  ITE_ORDSER     CHAR(1),  ';

    strSQL := strSQL + '  ITE_CLACRM_NOV CHAR(1),  ';
    strSQL := strSQL + '  ITE_CLACRM     CHAR(1),  ';

    strSQL := strSQL + '  ITE_CPESOB_NOV CHAR(1),  ';
    strSQL := strSQL + '  ITE_CPESOB     CHAR(1),  ';

    strSQL := strSQL + '  ITE_DESCND_NOV CHAR(1),  ';
    strSQL := strSQL + '  ITE_DESCND     CHAR(1),  ';

    strSQL := strSQL + '  ITE_CODONU_NOV CHAR(3),        ';
    strSQL := strSQL + '  ITE_CODONU     CHAR(3),        ';

    strSQL := strSQL + '  AUTOINCREM INT NOT NULL AUTO_INCREMENT PRIMARY KEY,';
    strSQL := strSQL + '  KEY IDX_CODITE(ITE_CODITE) ) ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    If (Not fEmptyStr(edtDocumento.Text)) Then
      strSQL := strSQL + ' DISTINCT ';

    strSQL := strSQL + '  I.ITE_CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  IFNULL(G.ITE_PREDOL, "N") AS ITE_PREDOL, ';
    strSQL := strSQL + '  I.ITE_REFERE, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';        //atual
    strSQL := strSQL + '  G.ITE_PREMED,       ';  // PREÇO MEDIO
    strSQL := strSQL + '  NULL AS ITE_DTAALT, ';  // DATA TA ULTIMA ALTERAÇÃO DE PREÇO
    strSQL := strSQL + '  NULL AS ITE_PR1ANT, ';  // PREÇO VENDA 1 ANTERIOR
    strSQL := strSQL + '  NULL AS ITE_PR2ANT, ';  // PREÇO VENDA 2 ANTERIOR
    strSQL := strSQL + '  NULL AS ITE_PR3ANT, ';  // PREÇO VENDA 3 ANTERIOR
    strSQL := strSQL + '  NULL AS ITE_PR4ANT, ';  // PREÇO VENDA 4 ANTERIOR
    strSQL := strSQL + '  NULL AS ITE_PR5ANT, ';  // PREÇO VENDA 5 ANTERIOR
    strSQL := strSQL + '  NULL AS ITE_PR6ANT, ';  // PREÇO VENDA 6 ANTERIOR
    strSQL := strSQL + '  NULL AS ITE_PR7ANT, ';  // PREÇO VENDA 7 ANTERIOR

    strSQL := strSQL + '  I.ITE_CODGRU AS "ITE_CODGRU_NOV", ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  I.ITE_TIPFRE AS "ITE_TIPFRE_NOV", ';
    strSQL := strSQL + '  I.ITE_TIPFRE, ';
    strSQL := strSQL + '  I.ITE_VLCFRE AS "ITE_VLCFRE_NOV", ';
    strSQL := strSQL + '  I.ITE_VLCFRE, ';
    strSQL := strSQL + '  I.ITE_CLAIPI AS "ITE_CLAIPI_NOV", '; //Classificação de IPI
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_EXCIPI AS "ITE_EXCIPI_NOV", '; //Código EX IPI
    strSQL := strSQL + '  I.ITE_EXCIPI, ';
    strSQL := strSQL + '  I.ITE_GRUCMP AS "ITE_GRUCMP_NOV", '; //
    strSQL := strSQL + '  I.ITE_GRUCMP, ';
    strSQL := strSQL + '  G.ITE_RECDEV AS "ITE_RECDEV_NOV", '; // Recebe Devolução
    strSQL := strSQL + '  G.ITE_RECDEV, ';
    strSQL := strSQL + '  I.ITE_CDCEST AS "ITE_CDCEST_NOV", '; //Código CEST
    strSQL := strSQL + '  I.ITE_CDCEST, ';

    strSQL := strSQL + '  CAST(I.ITE_APLICA AS CHAR(255)) AS "ITE_APLICA_NOV", '; //Código CEST
    strSQL := strSQL + '  CAST(I.ITE_APLICA AS CHAR(255)) , ';
    strSQL := strSQL + '  I.ITE_APLICA AS ITE_NOVO_REAL, ';

    strSQL := strSQL + '  I.ITE_PER_CI AS "ITE_PER_CI_NOV", ';
    strSQL := strSQL + '  I.ITE_PER_CI, ';
    strSQL := strSQL + '  I.ITE_NUMFCI AS "ITE_NUMFCI_NOV", ';
    strSQL := strSQL + '  I.ITE_NUMFCI, ';
    strSQL := strSQL + '  A.ABF_DESABF AS "ITE_DESABF_NOV", '; //Abreviação Fiscal
    strSQL := strSQL + '  A.ABF_DESABF, ';
    strSQL := strSQL + '  G.ITE_PRECOM AS "ITE_PRECOM_NOV", '; //Preço de compra
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS "ITE_PREVE1_NOV", '; //Preço de Venda 1
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2 AS "ITE_PREVE2_NOV", '; //Preço de Venda 2
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3 AS "ITE_PREVE3_NOV", '; //Preço de Venda 3
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4 AS "ITE_PREVE4_NOV", '; //Preço de Venda 4
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5 AS "ITE_PREVE5_NOV", '; //Preço de Venda 5
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6 AS "ITE_PREVE6_NOV", '; //Preço de Venda 6
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7 AS "ITE_PREVE7_NOV", '; //Preço de Venda 7
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_DESF01 AS "ITE_DESF01_NOV", '; //% Desc. Fornec. 01
    strSQL := strSQL + '  G.ITE_DESF01, ';
    strSQL := strSQL + '  G.ITE_DESF02 AS "ITE_DESF02_NOV", '; //% Desc. Fornec. 02
    strSQL := strSQL + '  G.ITE_DESF02, ';
    strSQL := strSQL + '  G.ITE_DESF03 AS "ITE_DESF03_NOV", '; //% Desc. Fornec. 03
    strSQL := strSQL + '  G.ITE_DESF03, ';
    strSQL := strSQL + '  G.ITE_DESF04 AS "ITE_DESF04_NOV", '; //% Desc. Fornec. 04
    strSQL := strSQL + '  G.ITE_DESF04, ';
    strSQL := strSQL + '  G.ITE_DESF05 AS "ITE_DESF05_NOV", '; //% Desc. Fornec. 05
    strSQL := strSQL + '  G.ITE_DESF05, ';
    strSQL := strSQL + '  G.ITE_DESF06 AS "ITE_DESF06_NOV", '; //% Desc. Fornec. 06
    strSQL := strSQL + '  G.ITE_DESF06, ';
    strSQL := strSQL + '  G.ITE_ICMENT AS "ITE_ICMENT_NOV", '; //% ICMS Entrada
    strSQL := strSQL + '  G.ITE_ICMENT, ';
    strSQL := strSQL + '  G.ITE_SUBFED AS "ITE_SUBFED_NOV", '; //% Impostos Federais (-)
    strSQL := strSQL + '  G.ITE_SUBFED, ';
    strSQL := strSQL + '  G.ITE_IPIENT AS "ITE_IPIENT_NOV", '; //% IPI Entrada
    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_ABAMLT AS "ITE_ABAMLT_NOV", '; //Abastecimento Múltiplo
    strSQL := strSQL + '  G.ITE_ABAMLT, ';
    strSQL := strSQL + '  G.ITE_FREENT AS "ITE_FREENT_NOV", '; //% Frete Entrada
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_VALFRE AS "ITE_VALFRE_NOV", '; //% Frete Entrada
    strSQL := strSQL + '  G.ITE_VALFRE, ';
    strSQL := strSQL + '  G.ITE_ACRFIN AS "ITE_ACRFIN_NOV", '; //% Acresc.Financ.
    strSQL := strSQL + '  G.ITE_ACRFIN, ';
    strSQL := strSQL + '  G.ITE_SUBSTI AS "ITE_SUBSTI_NOV", '; //% Subst. Tributária
    strSQL := strSQL + '  G.ITE_SUBSTI, ';
    strSQL := strSQL + '  G.ITE_DESADB AS "ITE_DESADB_NOV", '; //% Desconto Adicional (Boleto)
    strSQL := strSQL + '  G.ITE_DESADB, ';
    strSQL := strSQL + '  G.ITE_OUTVAL AS "ITE_OUTVAL_NOV", '; //Outros Valores
    strSQL := strSQL + '  G.ITE_OUTVAL, ';
    strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI_NOV", '; //% ICMS Saída
    strSQL := strSQL + '  G.ITE_ICMSAI, ';
    strSQL := strSQL + '  G.ITE_IPISAI AS "ITE_IPISAI_NOV", '; //% IPI Saída
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED_NOV", '; //% Impostos Federais
    strSQL := strSQL + '  G.ITE_IMPFED, ';
    strSQL := strSQL + '  I.ITE_MLTCOM AS "ITE_MLTCOM_NOV", '; //Múltiplo para Compra
    strSQL := strSQL + '  I.ITE_MLTCOM, ';
    strSQL := strSQL + '  I.ITE_MLTVEN AS "ITE_MLTVEN_NOV", '; //Múltiplo para Venda
    strSQL := strSQL + '  I.ITE_MLTVEN, ';
    strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
    strSQL := strSQL + '  G.ITE_DESOPE, ';

    if not blnIteTbp Then
    Begin
      strSQL := strSQL + '  G.ITE_DESMAX AS "ITE_DESMAX_NOV", '; //% Desc.Maximo
      strSQL := strSQL + '  G.ITE_DESMAX, ';
      strSQL := strSQL + '  G.ITE_DESMGE AS "ITE_DESMGE_NOV", '; //% Desc.Maximo Gerente
      strSQL := strSQL + '  G.ITE_DESMGE, ';
      strSQL := strSQL + '  G.ITE_DESMSU AS "ITE_DESMSU_NOV", '; //% Desc.Maximo Sub-Gerente
      strSQL := strSQL + '  G.ITE_DESMSU, ';
    End
    Else
    Begin
      For intCorre := 1 To Length(VS_strTabPrc) Do
        strSQL := strSQL + fAddIteTbp(intCorre);

    End;

    strSQL := strSQL + '  G.ITE_COMVAR AS "ITE_COMVAR_NOV", '; //% Comis.Vendedor Interno
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA AS "ITE_COMATA_NOV", '; //% Comis. Repres. Ext. Loja
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS AS "ITE_COMDIS_NOV", '; //% Comis. Repres. Ext. Distribuidor
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_COMDIG AS "ITE_COMDIG_NOV", '; //% Comis. Digitador
    strSQL := strSQL + '  G.ITE_COMDIG, ';
    strSQL := strSQL + '  G.ITE_COMPRO AS "ITE_COMPRO_NOV", '; //% Comis.Profissional
    strSQL := strSQL + '  G.ITE_COMPRO, ';
    strSQL := strSQL + '  G.ITE_QTPPRO AS "ITE_QTPPRO_NOV", '; //Quantidade de pontos para profissional/Pontos Por Valor
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  G.ITE_CPRCEN AS "ITE_CPRCEN_NOV", '; //Compra centralizada
    strSQL := strSQL + '  G.ITE_CPRCEN, ';
    strSQL := strSQL + '  I.ITE_PESOIT AS "ITE_PESOIT_NOV", '; //Peso
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ AS "ITE_PESLIQ_NOV", '; //Peso
    strSQL := strSQL + '  I.ITE_PESLIQ, ';
    strSQL := strSQL + '  I.ITE_INFLAM AS "ITE_INFLAM_NOV", '; //Produto Inflamável
    strSQL := strSQL + '  I.ITE_INFLAM, ';
    strSQL := strSQL + '  I.ITE_USABON AS "ITE_USABON_NOV", '; //Usa bonificação?
    strSQL := strSQL + '  I.ITE_USABON, ';
    strSQL := strSQL + '  I.ITE_USAFLE AS "ITE_USAFLE_NOV", '; //Usa Flex?
    strSQL := strSQL + '  I.ITE_USAFLE, ';
    strSQL := strSQL + '  I.ITE_OBRCPF AS "ITE_OBRCPF_NOV", '; //Venda c/ obrigat. CPF/CNPJ
    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  I.ITE_OBRIBA AS "ITE_OBRIBA_NOV", '; //Venda c/ obrigat. Cod IBAMA
    strSQL := strSQL + '  I.ITE_OBRIBA, ';
    strSQL := strSQL + '  I.ITE_OBRNFE AS "ITE_OBRNFE_NOV", '; //Venda c/ obrigat. NFe
    strSQL := strSQL + '  I.ITE_OBRNFE, ';
    strSQL := strSQL + '  I.ITE_NVLGIR AS "ITE_NVLGIR_NOV", '; //Nível de Giro de Estoque
    strSQL := strSQL + '  I.ITE_NVLGIR, ';

    strSQL := strSQL + '  I.ITE_NVLCRI AS "ITE_NVLCRI_NOV", '; //Nível de Criticidade de Estoque Geral
    strSQL := strSQL + '  I.ITE_NVLCRI, ';

    strSQL := strSQL + '  G.ITE_NIVCRI AS "ITE_NIVCRI_NOV", '; //Nível de Criticidade de Estoque
    strSQL := strSQL + '  G.ITE_NIVCRI, ';

    strSQL := strSQL + '  I.ITE_PROEMB AS "ITE_PROEMB_NOV", '; //Produto Embalagem
    strSQL := strSQL + '  I.ITE_PROEMB, ';
    strSQL := strSQL + '  I.ITE_ACOOBJ AS "ITE_ACOOBJ_NOV", '; //Acordo de Objetivos
    strSQL := strSQL + '  I.ITE_ACOOBJ, ';
    strSQL := strSQL + '  I.ITE_VALOBR AS "ITE_VALOBR_NOV", '; //Valida Obrigatória
    strSQL := strSQL + '  I.ITE_VALOBR, ';

    strSQL := strSQL + '  G.ITE_MARBR1 AS "ITE_MARBR1_NOV", '; //% Margem Bruta 1
    strSQL := strSQL + '  G.ITE_MARBR1, ';
    strSQL := strSQL + '  G.ITE_MARBR2 AS "ITE_MARBR2_NOV", '; //% Margem Bruta 2
    strSQL := strSQL + '  G.ITE_MARBR2, ';
    strSQL := strSQL + '  G.ITE_MARBR3 AS "ITE_MARBR3_NOV", '; //% Margem Bruta 3
    strSQL := strSQL + '  G.ITE_MARBR3, ';
    strSQL := strSQL + '  G.ITE_MARBR4 AS "ITE_MARBR4_NOV", '; //% Margem Bruta 4
    strSQL := strSQL + '  G.ITE_MARBR4, ';
    strSQL := strSQL + '  G.ITE_MARBR5 AS "ITE_MARBR5_NOV", '; //% Margem Bruta 5
    strSQL := strSQL + '  G.ITE_MARBR5, ';
    strSQL := strSQL + '  G.ITE_MARBR6 AS "ITE_MARBR6_NOV", '; //% Margem Bruta 6
    strSQL := strSQL + '  G.ITE_MARBR6, ';
    strSQL := strSQL + '  G.ITE_MARBR7 AS "ITE_MARBR7_NOV", '; //% Margem Bruta 7
    strSQL := strSQL + '  G.ITE_MARBR7, ';

    strSQL := strSQL + '  G.ITE_MARID1 AS "ITE_MARID1_NOV", '; //% Margem Ideal 1
    strSQL := strSQL + '  G.ITE_MARID1, ';
    strSQL := strSQL + '  G.ITE_MARID2 AS "ITE_MARID2_NOV", '; //% Margem Ideal 2
    strSQL := strSQL + '  G.ITE_MARID2, ';
    strSQL := strSQL + '  G.ITE_MARID3 AS "ITE_MARID3_NOV", '; //% Margem Ideal 3
    strSQL := strSQL + '  G.ITE_MARID3, ';
    strSQL := strSQL + '  G.ITE_MARID4 AS "ITE_MARID4_NOV", '; //% Margem Ideal 4
    strSQL := strSQL + '  G.ITE_MARID4, ';
    strSQL := strSQL + '  G.ITE_MARID5 AS "ITE_MARID5_NOV", '; //% Margem Ideal 5
    strSQL := strSQL + '  G.ITE_MARID5, ';
    strSQL := strSQL + '  G.ITE_MARID6 AS "ITE_MARID6_NOV", '; //% Margem Ideal 6
    strSQL := strSQL + '  G.ITE_MARID6, ';
    strSQL := strSQL + '  G.ITE_MARID7 AS "ITE_MARID7_NOV", '; //% Margem Ideal 7
    strSQL := strSQL + '  G.ITE_MARID7, ';

    strSQL := strSQL + '  G.ITE_COMTB1 AS "ITE_COMTB1_NOV", '; //% Comissao Tabela 1
    strSQL := strSQL + '  G.ITE_COMTB1, ';
    strSQL := strSQL + '  G.ITE_COMTB2 AS "ITE_COMTB2_NOV", '; //% Comissao Tabela 2
    strSQL := strSQL + '  G.ITE_COMTB2, ';
    strSQL := strSQL + '  G.ITE_COMTB3 AS "ITE_COMTB3_NOV", '; //% Comissao Tabela 3
    strSQL := strSQL + '  G.ITE_COMTB3, ';
    strSQL := strSQL + '  G.ITE_COMTB4 AS "ITE_COMTB4_NOV", '; //% Comissao Tabela 4
    strSQL := strSQL + '  G.ITE_COMTB4, ';
    strSQL := strSQL + '  G.ITE_COMTB5 AS "ITE_COMTB5_NOV", '; //% Comissao Tabela 5
    strSQL := strSQL + '  G.ITE_COMTB5, ';
    strSQL := strSQL + '  G.ITE_COMTB6 AS "ITE_COMTB6_NOV", '; //% Comissao Tabela 6
    strSQL := strSQL + '  G.ITE_COMTB6, ';
    strSQL := strSQL + '  G.ITE_COMTB7 AS "ITE_COMTB7_NOV", '; //% Comissao Tabela 7
    strSQL := strSQL + '  G.ITE_COMTB7, ';

    If fCfgSIs('TIPABF') = '1' Then
    Begin
      strSQL := strSQL + '  I.ITE_CODABF AS "ITE_CODABF_NOV", '; //Abrev. Fiscal
      strSQL := strSQL + '  I.ITE_CODABF, ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_CODABF AS "ITE_CODABF_NOV", '; //Abrev. Fiscal
      strSQL := strSQL + '  G.ITE_CODABF, ';
    End;

    If fCfgSis('TPABPC') = '1' Then
    Begin
      strSQL := strSQL + '  I.ITE_ABFPIS AS "ITE_ABFPIS_NOV", '; //Abrev. PIS
      strSQL := strSQL + '  I.ITE_ABFPIS, ';
      strSQL := strSQL + '  I.ITE_ABFCOF AS "ITE_ABFCOF_NOV", '; //Abrev. COFINS
      strSQL := strSQL + '  I.ITE_ABFCOF, ';
      strSQL := strSQL + '  I.ITE_ABFIPI AS "ITE_ABFIPI_NOV", '; //Abrev. IPI
      strSQL := strSQL + '  I.ITE_ABFIPI, ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_ABFPIS AS "ITE_ABFPIS_NOV", '; //Abrev. PIS
      strSQL := strSQL + '  G.ITE_ABFPIS, ';
      strSQL := strSQL + '  G.ITE_ABFCOF AS "ITE_ABFCOF_NOV", '; //Abrev. COFINS
      strSQL := strSQL + '  G.ITE_ABFCOF, ';
      strSQL := strSQL + '  G.ITE_ABFIPI AS "ITE_ABFIPI_NOV", '; //Abrev. IPI
      strSQL := strSQL + '  G.ITE_ABFIPI, ';
    End;

    strSQL := strSQL + '  I.ITE_INCPIS AS "ITE_INCPIS_NOV", '; //Incide PIS?
    strSQL := strSQL + '  I.ITE_INCPIS, ';
    strSQL := strSQL + '  I.ITE_COMLUB AS "ITE_COMLUB_NOV", '; //Combustível/Lubrificante?
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  G.ITE_IMPLIS AS "ITE_IMPLIS_NOV", '; //Imp. Lista?
    strSQL := strSQL + '  G.ITE_IMPLIS, ';
    strSQL := strSQL + '  I.ITE_ITEATI AS "ITE_ITEATI_NOV", '; //Ativo?
    strSQL := strSQL + '  I.ITE_ITEATI, ';
    strSQL := strSQL + '  G.ITE_LOCFIS AS "ITE_LOCFIS_NOV", '; //Local. Fisica
    strSQL := strSQL + '  G.ITE_LOCFIS, ';
    strSQL := strSQL + '  G.ITE_ESTMAX AS "ITE_ESTMAX_NOV", '; //Estoque Máximo
    strSQL := strSQL + '  G.ITE_ESTMAX, ';
    strSQL := strSQL + '  G.ITE_ESTMIN AS "ITE_ESTMIN_NOV", '; //Estoque Mínimo
    strSQL := strSQL + '  G.ITE_ESTMIN, ';
    strSQL := strSQL + '  G.ITE_TAMLCF AS "ITE_TAMLCF_NOV", '; //Tamanho Local. Fisica
    strSQL := strSQL + '  G.ITE_TAMLCF, ';
    strSQL := strSQL + '  G.ITE_LOCSUP AS "ITE_LOCSUP_NOV", '; //Local. Super Estoque
    strSQL := strSQL + '  G.ITE_LOCSUP, ';
    strSQL := strSQL + '  G.ITE_TAMLCS AS "ITE_TAMLCS_NOV", '; //Tamanho Local. Super Estoque
    strSQL := strSQL + '  G.ITE_TAMLCS, ';
    strSQL := strSQL + '  G.ITE_CODLSE AS "ITE_CODLSE_NOV", '; //Local. de Separação
    strSQL := strSQL + '  G.ITE_CODLSE, ';

    strSQL := strSQL + '  G.ITE_PRECUS AS "ITE_PRECUS_NOV", '; //Preço de Custo
    strSQL := strSQL + '  G.ITE_PRECUS, ';

    strSQL := strSQL + ' IF((1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100) <> 0, ';
    strSQL := strSQL + '     ((IFNULL(G.ITE_PRECUS, 0) + IFNULL(G.ITE_OUTVAL, 0)) / (1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100)), 0) AS ITE_CUSREA_NOV, ';

    strSQL := strSQL + ' IF((1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100) <> 0, ';
    strSQL := strSQL + '     ((IFNULL(G.ITE_PRECUS, 0) + IFNULL(G.ITE_OUTVAL, 0)) / (1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100)), 0) AS ITE_CUSREA, ';

    strSQL := strSQL + '  G.ITE_CODEMP, ';
    strSQL := strSQL + '  G.ITE_MARMIN AS "ITE_MARMIN_NOV", '; //Margem Mínima Vendedor
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG AS "ITE_MARMSG_NOV", '; //Margem Mínima Sub Gerente
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE AS "ITE_MARMGE_NOV", '; //Margem Mínima Gerente
    strSQL := strSQL + '  G.ITE_MARMGE, ';
    strSQL := strSQL + '  I.ITE_CODFAB AS "ITE_CODFAB_NOV", '; //Código de fábrica
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODBAR AS "ITE_CODBAR_NOV", '; //Código de barras
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  I.ITE_MESGIR AS "ITE_MESGIR_NOV", '; //Tempo de Garantia
    strSQL := strSQL + '  I.ITE_MESGIR, ';
    strSQL := strSQL + '  I.ITE_TMPGAR AS "ITE_TMPGAR_NOV", '; //Tempo de Garantia
    strSQL := strSQL + '  I.ITE_TMPGAR, ';
    strSQL := strSQL + '  I.ITE_INFGAR AS "ITE_INFGAR_NOV", '; //Informação de Garantia
    strSQL := strSQL + '  I.ITE_INFGAR, ';
    strSQL := strSQL + '  I.ITE_EMBALA AS "ITE_EMBALA_NOV", '; //Embalagem
    strSQL := strSQL + '  I.ITE_EMBALA, ';
    strSQL := strSQL + '  I.ITE_BAREMB AS "ITE_BAREMB_NOV", '; //Código de barras Embalagem
    strSQL := strSQL + '  I.ITE_BAREMB, ';
    strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI_NOV", '; //Unidade
    strSQL := strSQL + '  I.ITE_CODUNI, ';
    strSQL := strSQL + '  G.ITE_TIPPRO AS "ITE_TIPPRO_NOV", '; //Unidade
    strSQL := strSQL + '  G.ITE_TIPPRO, ';
    strSQL := strSQL + '  I.ITE_UNICOM AS "ITE_UNICOM_NOV", '; //Unidade de Compra
    strSQL := strSQL + '  I.ITE_UNICOM, ';
    strSQL := strSQL + '  I.ITE_UNITRI AS "ITE_UNITRI_NOV", '; //Unidade de Compra
    strSQL := strSQL + '  I.ITE_UNITRI, ';
    strSQL := strSQL + '  I.ITE_FATUTR AS "ITE_FATUTR_NOV", '; //Unidade de Compra
    strSQL := strSQL + '  I.ITE_FATUTR, ';
    strSQL := strSQL + '  I.ITE_CODMAR AS "ITE_CODMAR_NOV", '; //Marca
    strSQL := strSQL + '  I.ITE_CODMAR, ';
    strSQL := strSQL + '  G.ITE_SITPRO AS "ITE_SITPRO_NOV", '; //Situação do Produto
    strSQL := strSQL + '  G.ITE_SITPRO, ';
    strSQL := strSQL + '  G.ITE_DTAVAL AS "ITE_DTAVAL_NOV", '; //Data de Validade de Preço
    strSQL := strSQL + '  G.ITE_DTAVAL, ';
    strSQL := strSQL + '  I.ITE_CODMON AS "ITE_CODMON_NOV", '; //Montadora
    strSQL := strSQL + '  I.ITE_CODMON, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR_NOV", '; //Fornecedor
    strSQL := strSQL + '  I.ITE_CODFOR, ';
    strSQL := strSQL + '  I.ITE_DIAFOR AS "ITE_DIAFOR_NOV", '; //Dias para entrega do fornecedor
    strSQL := strSQL + '  I.ITE_DIAFOR, ';

    strSQL := strSQL + '  G.ITE_PRAMIN AS "ITE_PRAMIN_NOV", ';
    strSQL := strSQL + '  G.ITE_PRAMIN, ';

    strSQL := strSQL + '  I.ITE_REAEND AS "ITE_REAEND_NOV", '; //Realizar endereçamento do produto
    strSQL := strSQL + '  I.ITE_REAEND, ';

    strSQL := strSQL + '  I.ITE_OBRBAR AS "ITE_OBRBAR_NOV", '; //Obrigatório o Código de Barras na Entrada Simplificada
    strSQL := strSQL + '  I.ITE_OBRBAR, ';

    strSQL := strSQL + '  I.ITE_FATCOM AS "ITE_FATCOM_NOV", '; //Digitar complemento do produto
    strSQL := strSQL + '  I.ITE_FATCOM, ';

    strSQL := strSQL + '  I.ITE_CODDEP AS "ITE_CODDEP_NOV", '; //Departamento
    strSQL := strSQL + '  I.ITE_CODDEP, ';
    strSQL := strSQL + '  I.ITE_NOTESP AS "ITE_NOTESP_NOV", ';
    strSQL := strSQL + '  I.ITE_NOTESP, ';

    strSQL := strSQL + '  I.ITE_PEFUTP AS "ITE_PEFUTP_NOV", ';
    strSQL := strSQL + '  I.ITE_PEFUTP, ';
    strSQL := strSQL + '  I.ITE_PEEFUT AS "ITE_PEEFUT_NOV", ';
    strSQL := strSQL + '  I.ITE_PEEFUT, ';
    strSQL := strSQL + '  I.ITE_PEFFPR AS "ITE_PEFFPR_NOV", ';
    strSQL := strSQL + '  I.ITE_PEFFPR, ';

    strSQL := strSQL + '  G.ITE_MINTB1,  ';
    strSQL := strSQL + '  G.ITE_MINTB1 AS ITE_MINTB1_NOV,  ';
    strSQL := strSQL + '  G.ITE_MINTB2,  ';
    strSQL := strSQL + '  G.ITE_MINTB2 AS ITE_MINTB2_NOV,  ';
    strSQL := strSQL + '  G.ITE_MINTB3,  ';
    strSQL := strSQL + '  G.ITE_MINTB3 AS ITE_MINTB3_NOV,  ';
    strSQL := strSQL + '  G.ITE_MINTB4,  ';
    strSQL := strSQL + '  G.ITE_MINTB4 AS ITE_MINTB4_NOV,  ';
    strSQL := strSQL + '  G.ITE_MINTB5,  ';
    strSQL := strSQL + '  G.ITE_MINTB5 AS ITE_MINTB5_NOV,  ';
    strSQL := strSQL + '  G.ITE_MINTB6,  ';
    strSQL := strSQL + '  G.ITE_MINTB6 AS ITE_MINTB6_NOV,  ';
    strSQL := strSQL + '  G.ITE_MINTB7,  ';
    strSQL := strSQL + '  G.ITE_MINTB7 AS ITE_MINTB7_NOV,  ';

    strSQL := strSQL + '  I.ITE_PRDGRU,  ';                   // Grupo de Produto
    strSQL := strSQL + '  I.ITE_PRDGRU AS ITE_PRDGRU_NOV,  ';

    strSQL := strSQL + '  I.ITE_ATICOM,  ';                   // ATIVO COMPRAS
    strSQL := strSQL + '  I.ITE_ATICOM AS ITE_ATICOM_NOV,  ';

    strSQL := strSQL + '  I.ITE_CODDIC,  ';
    strSQL := strSQL + '  I.ITE_CODDIC AS ITE_CODDIC_NOV,  ';

    strSQL := strSQL + '  I.ITE_IMPETI,  ';
    strSQL := strSQL + '  I.ITE_IMPETI AS ITE_IMPETI_NOV,  ';

    strSQL := strSQL + ' I.ITE_PRAPEL AS ITE_PRAPEL_NOV,'; //Unidade
    strSQL := strSQL + ' I.ITE_PRAPEL,  ';


    strSQL := strSQL + '  G.ITE_PRECOM * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF01 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF02 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF03 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF04 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF05 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF06 / 100) ) AS ITE_PRELIQ_NOV, ';

    strSQL := strSQL + '  G.ITE_PRECOM * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF01 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF02 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF03 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF04 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF05 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF06 / 100) ) AS ITE_PRELIQ, ';

    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '     MAX(ALT_DTAALT) ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + '     PREALT ';
    strSQL := strSQL + '   WHERE ';
    strSQL := strSQL + '     ALT_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '     ALT_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '  ) AS ITE_ALTPRE, ';

    strSQL := strSQL + '  "N" AS ALTERA, ';
    strSQL := strSQL + '  CONCAT(I.ITE_CODUNI,"-",U.UNI_DESUNI) AS ITE_DESUNI, ';
    If (Not fEmptyStr(edtDocumento.Text)) Then
      strSQL := strSQL + '  D.AUTOINCREM, '
    Else
      strSQL := strSQL + '  NULL, ';

    strSQL := strSQL + '  I.ITE_DENSID, ';
    strSQL := strSQL + '  I.ITE_DENSID AS ITE_DENSID_NOV, ';

    strSQL := strSQL + '  I.ITE_FATCMP,  ';
    strSQL := strSQL + '  I.ITE_FATCMP AS ITE_FATCMP_NOV,  ';

    strSQL := strSQL + '  I.ITE_RASTRE, ';
    strSQL := strSQL + '  I.ITE_RASTRE AS ITE_RASTRE_NOV, ';

    strSQL := strSQL + '  I.ITE_LARVID AS "ITE_LARVID_NOV", '; // Largura
    strSQL := strSQL + '  I.ITE_LARVID, ';
    strSQL := strSQL + '  I.ITE_ALTVID AS "ITE_ALTVID_NOV", '; // Altura
    strSQL := strSQL + '  I.ITE_ALTVID, ';
    strSQL := strSQL + '  I.ITE_LAMAVI AS "ITE_LAMAVI_NOV", '; // Largura Máxima
    strSQL := strSQL + '  I.ITE_LAMAVI, ';
    strSQL := strSQL + '  I.ITE_ALMAVI AS "ITE_ALMAVI_NOV", '; // Altura Máxima
    strSQL := strSQL + '  I.ITE_ALMAVI, ';

    strSQL := strSQL + '  I.ITE_UTIAMP AS "ITE_UTIAMP_NOV",  ';
    strSQL := strSQL + '  I.ITE_UTIAMP,  ';

    strSQL := strSQL + '  G.ITE_PESOBR AS "ITE_PESOBR_NOV", ';
    strSQL := strSQL + '  G.ITE_PESOBR, ';

    strSQL := strSQL + '  I.ITE_LOTEPD AS "ITE_LOTEPD_NOV",  ';
    strSQL := strSQL + '  I.ITE_LOTEPD,  ';

    strSQL := strSQL + '  I.ITE_ORDSER AS "ITE_ORDSER_NOV",  ';
    strSQL := strSQL + '  I.ITE_ORDSER,  ';

    strSQL := strSQL + '  I.ITE_CLACRM AS "ITE_CLACRM_NOV",  ';
    strSQL := strSQL + '  I.ITE_CLACRM,  ';

    strSQL := strSQL + '  G.ITE_CPESOB AS "ITE_CPESOB_NOV",  ';
    strSQL := strSQL + '  G.ITE_CPESOB,  ';

    strSQL := strSQL + '  I.ITE_DESCND AS "ITE_DESCND_NOV",  ';
    strSQL := strSQL + '  I.ITE_DESCND,  ';

    strSQL := strSQL + '  I.ITE_CODONU AS "ITE_CODONU_NOV", ';
    strSQL := strSQL + '  I.ITE_CODONU, ';

    strSQL := strSQL + '  NULL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';

    If (Not fEmptyStr(edtDocumento.Text)) Then
      strSQL := strSQL + '  MOVDET D, ';

    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADUNI U  ';
    strSQL := strSQL + 'WHERE I.ITE_CODUNI = U.UNI_CODUNI  ';
    strSQL := strSQL + '  AND I.ITE_CODITE = G.ITE_CODITE  ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  AND I.ITE_CODABF = A.ABF_CODABF '
    Else
      strSQL := strSQL + '  AND G.ITE_CODABF = A.ABF_CODABF ';

    If (Not fEmptyStr(edtDocumento.Text)) Then
    Begin
      strSQL := strSQL + '  AND I.ITE_CODITE = D.DET_CODITE  ';
      strSQL := strSQL + '  AND D.DET_NUMDOC = :NUMDOC       ';
      strSQL := strSQL + '  AND D.DET_ESPDOC = :ESPDOC      ';
      strSQL := strSQL + '  AND D.DET_CODEMP = :DOCEMP     ';

      strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'D.DET_CODFOR', 'CODFOR');
      If (Not fEmptyStr(edtSerie.Text)) Then
        strSQL := strSQL + ' AND IFNULL(D.DET_SERIE_, "") = :SERDOC   ';
    End
    Else
      strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'I.ITE_CODFOR', 'CODFOR');

    strSQL := strSQL + ' AND A.ABF_ESTADO = :ESTADO  ';
    strSQL := strSQL + ' AND G.ITE_CODEMP = :CODEMP ';

    strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinhaGrupo, 'ITE_CODGRU','CODGRU');

    If Not fEmptyStr(edtDesIte.Text) Then
      strSQL := strSQL + '  AND I.ITE_DESITE LIKE :DESITE ';

    If Not fEmptyStr(edtRefere.Text) Then
      strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';

    strSQL := strSQL + fStrLocate(edtCodUni , arrCodUni  , 'I.ITE_CODUNI', 'CODUNI');
    strSQL := strSQL + fStrLocate(edtCodMar , arrMarca   , 'I.ITE_CODMAR', 'CODMAR');
    strSQL := strSQL + fStrLocate(edtCodMon , arrCodMon  , 'I.ITE_CODMON', 'CODMON');
    strSQL := strSQL + fStrLocate(edtPrdGru , arrGrupoPro, 'I.ITE_PRDGRU', 'PRDGRU');
    strSQL := strSQL + fStrLocate(edtGruCmp , arrGruCmp  , 'I.ITE_GRUCMP', 'GRUCMP');
    strSQL := strSQL + fStrLocate(edtCodGpr , arrCodGpr  , 'I.ITE_CODGPR', 'CODGPR');
    strSQL := strSQL + fStrLocate(edtCodDep , arrCodDep  , 'I.ITE_CODDEP', 'CODDEP');

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + fStrLocate(edtCodAbr , arrCodAbr , 'I.ITE_CODABF', 'CODABF')
    Else
      strSQL := strSQL + fStrLocate(edtCodAbr , arrCodAbr , 'G.ITE_CODABF', 'CODABF');

    If (chkPenRec.Checked) Then
      strSQL := strSQL + ' AND G.ITE_PEFAVE = "N" ';

    If Not fEmptyStr(edtClaIpi.Text) Then
      strSQL := strSQL + '  AND I.ITE_CLAIPI LIKE :CLAIPI ';

    If Not fEmptyStr(edtExcIpi.Text) Then
      strSQL := strSQL + '  AND I.ITE_EXCIPI = :EXCIPI ';

    If (Pos(edtStatus.Text, 'SN') > 0) Then
      strSQL := strSQL + '  AND I.ITE_ITEATI = :ITEATI ';

    If (Pos(edtIncPis.Text, 'SN') > 0) Then
      strSQL := strSQL + '  AND I.ITE_INCPIS = :INCPIS ';

    If fCfgSis('MARIDE', VarBoolean) Then
    Begin
      strTabPrc := cbxTabPrc.Text;

      Case cbxMarIde.ItemIndex Of
        1 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' >= G.ITE_MARBR' + strTabPrc;
        2 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' <= G.ITE_MARBR' + strTabPrc;
        3 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' >  G.ITE_MARBR' + strTabPrc;
        4 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' <  G.ITE_MARBR' + strTabPrc;
        5 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' =  G.ITE_MARBR' + strTabPrc;
      End;
    End;
    If (Not fEmptyStr(edtDocumento.Text)) Then
      strSQL := strSQL + ' GROUP BY G.ITE_CODITE ';


    strSQL := strSQL + '  ORDER BY ';
    strSQL := strSQL + '    ITE_DESITE ';

    strSQL := 'INSERT INTO ' + strTabela + ' ' + strSQL;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');

      If Not fEmptyStr(edtDocumento.Text) Then
      Begin
        ParamByName('NUMDOC').AsString := edtDocumento.Text;
        ParamByName('ESPDOC').AsString := edtEspecie.Text;

        If Not fEmptyStr(edtSerie.Text) Then
          ParamByName('SERDOC').AsString := edtSerie.Text;
        If Not fEmptyStr(edtCodEmpresa.Text) Then
          ParamByName('DOCEMP').AsString := edtCodEmpresa.Text;
      End;


      If Not fEmptyStr(edtDesIte.Text) Then
        ParamByName('DESITE').AsString := edtDesIte.Text + '%';

      If Not fEmptyStr(edtRefere.Text) Then
        ParamByName('REFERE').AsString := edtRefere.Text + '%';

      If Not fEmptyStr(edtClaIpi.Text) Then
        ParamByName('CLAIPI').AsString := edtClaIpi.Text + '%';

      If Not fEmptyStr(edtExcIpi.Text) Then
        ParamByName('EXCIPI').AsString := edtExcIpi.Text;

      If (Pos(edtStatus.Text, 'SN') > 0) Then
        ParamByName('ITEATI').AsString := edtStatus.Text;

      If (Pos(edtIncPis.Text, 'SN') > 0) Then
        ParamByName('INCPIS').AsString := edtIncPis.Text;

      pSetaParam(mskLinGru.Text   , arrLinhaGrupo, strLinGru, 'CODGRU', qryGenTmp);
      pSetaParam(edtCodMar.Text   , arrMarca,      strMarca , 'CODMAR', qryGenTmp);
      pSetaParam(edtCodFor.Text   , arrFornec,     strFornec, 'CODFOR', qryGenTmp);
      pSetaParam(edtPrdGru.Text   , arrGrupoPro,   strPrdGru, 'PRDGRU', qryGenTmp);
      pSetaParam(edtGruCmp.Text   , arrGruCmp,     strGruCmp, 'GRUCMP', qryGenTmp);
      pSetaParam(edtCodGpr.Text   , arrCodGpr,     strCodGpr, 'CODGPR', qryGenTmp);
      pSetaParam(edtCodDep.Text   , arrCodDep,     strCodDep, 'CODDEP', qryGenTmp);
      pSetaParam(edtCodUni.Text   , arrCodUni,     strCodUni, 'CODUNI', qryGenTmp);
      pSetaParam(edtCodMon.Text   , arrCodMon,     strCodMon, 'CODMON', qryGenTmp);
      pSetaParam(edtCodAbr.Text   , arrCodAbr,     strCodAbr, 'CODABF', qryGenTmp);

      Try
        Screen.Cursor := crSQLWait;
        ExecSQL;
      Finally
        Screen.Cursor := crDefault;
      End;

      Close;

      If (chkDtaAlt.Checked Or
          chkPr1Ant.Checked Or
          chkPr2Ant.Checked Or
          chkPr3Ant.Checked Or
          chkPr4Ant.Checked Or
          chkPr5Ant.Checked Or
          chkPr6Ant.Checked Or
          chkPr7Ant.Checked) Then
        pBuscaUltimaAlteraoPreco;

      If fEmptyStr(edtDocumento.Text) Then
       pAtualizaTemporaria(False, '')
      Else
      Begin
        If (cbxOrdem.ItemIndex = 0) Then
           pAtualizaTemporaria(False, 'ITE_DESITE')
        Else
           pAtualizaTemporaria(False, 'ITE_ORDINC');
      End;

    End;

  Except
    pMensagensErro('Erro ao tentar criar a tabela ' + strTabela + '!','[pCriaTemporaria]');
  End;

  If Assigned(qryGenTmp) Then
    FreeAndNil(qryGenTmp);
End;

procedure TfrmAltPrecoIndividual.pAtualizaTemporaria(blnFiltaAlterado: Boolean; strCampoOrdem: String);
  Var
    intContador: Integer;
    strVendaReadOnly: String;
Begin
  If fTabelaExiste(strTabela) Then
  Begin

    With qryGen Do
    Begin
      DisableControls;

      SQL.Clear;

      If blnFiltaAlterado Then
        SQL.Add('SELECT * FROM ' + strTabela + ' WHERE ALTERA = "S"' + IIF(fEmptyStr(strCampoOrdem), '', ' ORDER BY ' + strCampoOrdem))
      Else
        SQL.Add('SELECT * FROM ' + strTabela + IIF(fEmptyStr(strCampoOrdem), '', ' ORDER BY ' + strCampoOrdem));

      Open;

      (FieldByName('ITE_SALDOS')     As TFloatField).DisplayFormat := '#,###0.000';
      (FieldByName('ITE_MLTVEN')     As TFloatField).DisplayFormat := '#,###0.0000';
      (FieldByName('ITE_MLTVEN_NOV')     As TFloatField).DisplayFormat := '#,###0.0000';

      (FieldByName('ITE_PREMED') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PR1ANT') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PR2ANT') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PR3ANT') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PR4ANT') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PR5ANT') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PR6ANT') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PR7ANT') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

      (FieldByName('ITE_PRECOM_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PRECOM')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE1_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE1')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE2_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE2')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE3_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE3')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE4_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE4')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE5_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE5')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE6_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE6')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE7_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PREVE7')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

      (FieldByName('ITE_DESF01_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF01')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF02_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF02')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF03_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF03')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF04_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF04')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF05_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF05')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF06_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESF06')     As TFloatField).DisplayFormat := '#,##0.00';

      (FieldByName('ITE_PRELIQ_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_PRELIQ')     As TFloatField).DisplayFormat := '#,##0.00';

      (FieldByName('ITE_ICMENT_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_ICMENT')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_SUBFED_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_SUBFED')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_IPIENT_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_IPIENT')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_FREENT_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_FREENT')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_VALFRE_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_VALFRE')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_ACRFIN_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_ACRFIN')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_SUBSTI_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_SUBSTI')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESADB_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESADB')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_OUTVAL_NOV') As TFloatField).DisplayFormat := '#,##0.000';
      (FieldByName('ITE_OUTVAL')     As TFloatField).DisplayFormat := '#,##0.000';
      (FieldByName('ITE_ICMSAI_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_ICMSAI')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_IPISAI_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_IPISAI')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_IMPFED_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_IMPFED')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESOPE_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESOPE')     As TFloatField).DisplayFormat := '#,##0.00';

      if not blnIteTbp Then
      Begin
        (FieldByName('ITE_DESMAX_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMAX')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMGE_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMGE')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMSU_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMSU')     As TFloatField).DisplayFormat := '#,##0.00';
      End
      Else
      Begin
        For intContador := 1 To Length(VS_strTabPrc) Do
        Begin
          (FieldByName('ITE_DESMA' + intToStr(intContador) + '_NOV') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESMA' + intToStr(intContador))          As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESMG' + intToStr(intContador) + '_NOV') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESMG' + intToStr(intContador))          As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESMS' + intToStr(intContador) + '_NOV') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESMS' + intToStr(intContador))          As TFloatField).DisplayFormat := '#,##0.00';
        End;

      End;

      (FieldByName('ITE_COMVAR_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMVAR')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMATA_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMATA')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMDIS_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMDIS')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMDIG_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMDIG')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMPRO_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMPRO')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_QTPPRO_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_QTPPRO')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR1_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR1')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR2_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR2')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR3_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR3')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR4_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR4')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR5_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR5')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR6_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR6')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR7_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARBR7')     As TFloatField).DisplayFormat := '#,##0.00';

      If fCfgSis('MARIDE', VarBoolean) Then
      Begin
        (FieldByName('ITE_MARID1_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID1')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID2_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID2')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID3_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID3')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID4_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID4')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID5_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID5')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID6_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID6')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID7_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARID7')     As TFloatField).DisplayFormat := '#,##0.00';
      End;

      (FieldByName('ITE_COMTB1_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB1')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB2_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB2')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB3_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB3')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB4_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB4')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB5_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB5')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB6_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB6')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB7_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMTB7')     As TFloatField).DisplayFormat := '#,##0.00';  

      (FieldByName('ITE_PRECUS_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_PRECUS')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

      (FieldByName('ITE_CUSREA_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
      (FieldByName('ITE_CUSREA')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

      (FieldByName('ITE_MARMIN_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMIN')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMSG_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMSG')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMGE_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMGE')     As TFloatField).DisplayFormat := '#,##0.00';

      (FieldByName('ITE_EMBALA_NOV') As TFloatField).DisplayFormat := fMskDigitos(DEC_EMBALAGEM);
      (FieldByName('ITE_EMBALA')     As TFloatField).DisplayFormat := fMskDigitos(DEC_EMBALAGEM);
      (FieldByName('ITE_PESOIT_NOV') As TFloatField).DisplayFormat := '#,##0.000';
      (FieldByName('ITE_PESOIT')     As TFloatField).DisplayFormat := '#,##0.000';
      (FieldByName('ITE_PESLIQ_NOV') As TFloatField).DisplayFormat := '#,##0.000';
      (FieldByName('ITE_PESLIQ')     As TFloatField).DisplayFormat := '#,##0.000';

      (FieldByName('ITE_MINTB1_NOV') As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB1')     As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB2_NOV') As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB2')     As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB3_NOV') As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB3')     As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB4_NOV') As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB4')     As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB5_NOV') As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB5')     As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB6_NOV') As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB6')     As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB7_NOV') As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_MINTB7')     As TFloatField).DisplayFormat := '#,##0.0000';

      if blnURapel then
      begin
        (FieldByName('ITE_PRAPEL_NOV') As TFloatField).DisplayFormat := '#,##0.000';
        (FieldByName('ITE_PRAPEL')     As TFloatField).DisplayFormat := '#,##0.000';
      end;

      (FieldByName('ITE_PER_CI')     As TFloatField).DisplayFormat := '#,###0.00';
      (FieldByName('ITE_PER_CI_NOV') As TFloatField).DisplayFormat := '#,###0.00';

      (FieldByName('ITE_DENSID')     As TFloatField).DisplayFormat := '#,###0.0000';
      (FieldByName('ITE_DENSID_NOV') As TFloatField).DisplayFormat := '#,###0.0000';

      (FieldByName('ITE_FATCMP')     As TFloatField).DisplayFormat := '#,###0.0000';
      (FieldByName('ITE_FATCMP_NOV') As TFloatField).DisplayFormat := '#,###0.0000';

      (FieldByName('ITE_LARVID_NOV') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_LARVID')     As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_ALTVID_NOV') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_ALTVID')     As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_LAMAVI_NOV') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_LAMAVI')     As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_ALMAVI_NOV') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_ALMAVI')     As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
    End;

    For intContador := 0 To dbgTiposAlt.Columns.Count -1 Do
    Begin

      //*************************************************//
      // SE O VALOR DA VARIAVEL ESTIVE CONTIDO EM [1,2]  //
      // ENTAO O CALCULO E DO PRECO DE CUSTO             //
      //**********************************************ED*//
      If intCustoVenda In[0,1] Then
      Begin

        If intCustoVenda = 0 Then
        Begin
          strVendaReadOnly := AnsiReplaceStr(strVenda, 'ITE_MARBR', '');
          strVendaReadOnly := AnsiReplaceStr(strVendaReadOnly, 'ITE_ICMSAI', '');
        End Else
        Begin
          strVendaReadOnly := AnsiReplaceStr(strVenda, 'ITE_PREVE', '');
          strVendaReadOnly := AnsiReplaceStr(strVendaReadOnly, 'ITE_ICMSAI', '');
        End;

        strVendaReadOnly := AnsiReplaceStr(strVendaReadOnly, 'ITE_COMTB', '');

        If (Pos(dbgTiposAlt.Columns[intContador].FieldName,strVendaReadOnly +
              'ITE_CODITE_ITE_PRELIQ_ITE_PRECUS_NOV_ITE_SALDOS_ITE_DTAALT_ITE_PREMED_ITE_IMPULT_' +
              'ITE_PR1ANT_ITE_PR2ANT_ITE_PR3ANT_ITE_PR4ANT_ITE_PR5ANT_ITE_PR6ANT_ITE_PR7ANT_ITE_CUSREA_ITE_CUSREA_NOV') > 0) Then
          dbgTiposAlt.Columns[intContador].ReadOnly := True
        Else
          dbgTiposAlt.Columns[intContador].ReadOnly := False;

      End
      Else
      Begin

        If (Pos(dbgTiposAlt.Columns[intContador].FieldName,strCusto +
               'ITE_CODITE_ITE_PRELIQ_ITE_PRECUS_NOV_ITE_SALDOS_ITE_DTAALT_ITE_PREMED_ITE_IMPULT_' +
               'ITE_PR1ANT_ITE_PR2ANT_ITE_PR3ANT_ITE_PR4ANT_ITE_PR5ANT_ITE_PR6ANT_ITE_PR7ANT_ITE_CUSREA_ITE_CUSREA_NOV') > 0) Then
          dbgTiposAlt.Columns[intContador].ReadOnly := True
        Else
          dbgTiposAlt.Columns[intContador].ReadOnly := False;

      End;
    End;

    For intContador := Low(arrCampos) To High(arrCampos) Do
    Begin

      //*************************************************//
      // SE O VALOR DA VARIAVEL ESTIVE CONTIDO EM [1,2]  //
      // ENTAO O CALCULO E DO PRECO DE CUSTO             //
      //**********************************************ED*//
      If intCustoVenda In[0,1] Then
      Begin

        If intCustoVenda = 0 Then
        Begin
          strVendaReadOnly := AnsiReplaceStr(strVenda, 'ITE_MARBR', '');
          strVendaReadOnly := AnsiReplaceStr(strVendaReadOnly, 'ITE_ICMSAI', '');
        End Else
        Begin
          strVendaReadOnly := AnsiReplaceStr(strVenda, 'ITE_PREVE', '');
          strVendaReadOnly := AnsiReplaceStr(strVendaReadOnly, 'ITE_ICMSAI', '');
        End;

        strVendaReadOnly := AnsiReplaceStr(strVendaReadOnly, 'ITE_COMTB', '');

        If (Pos(arrCampos[intContador].FieldName, strVendaReadOnly +
              'ITE_CODITE_ITE_PRELIQ_ITE_PRECUS_NOV_ITE_SALDOS_ITE_DTAALT_ITE_PREMED_ITE_IMPULT_' +
              'ITE_PR1ANT_ITE_PR2ANT_ITE_PR3ANT_ITE_PR4ANT_ITE_PR5ANT_ITE_PR6ANT_ITE_PR7ANT_ITE_CUSREA_ITE_CUSREA_NOV') > 0) Then
          arrCampos[intContador].ReadOnly := True
        Else
          arrCampos[intContador].ReadOnly := False;

      End
      Else
      Begin

        If (Pos(arrCampos[intContador].FieldName, strCusto +
               'ITE_CODITE_ITE_PRELIQ_ITE_PRECUS_NOV_ITE_SALDOS_ITE_DTAALT_ITE_PREMED_ITE_IMPULT_' +
               'ITE_PR1ANT_ITE_PR2ANT_ITE_PR3ANT_ITE_PR4ANT_ITE_PR5ANT_ITE_PR6ANT_ITE_PR7ANT_ITE_CUSREA_ITE_CUSREA_NOV') > 0) Then
          arrCampos[intContador].ReadOnly := True
        Else
          arrCampos[intContador].ReadOnly := False;

      End;
    End;

    qryGen.EnableControls;
  End;
End;

procedure TfrmAltPrecoIndividual.FormActivate(Sender: TObject);
begin
  inherited;
  pVerificaDireitoAcesso;
end;

procedure TfrmAltPrecoIndividual.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  SetLength(arrCampos, 0);

  qryGen.BeforePost := Nil;

  {**********************}
  { DESTROY QRY GENERICA }
  {*******************JB*}
  FreeAndNil(qryGen);

  FreeAndNil(qryAbfIcm);
  FreeAndNil(qryPrdGru);
  FreeAndNil(qryCodDic);
  FreeAndNil(qryConGru);
  FreeAndNil(qryCadLse);

  If Not fEmptyStr(strTabela) Then
  Begin

    If fTabelaExiste(strTabela) Then
    Begin
      pDeletaTemporaria;
    End;

  End;

  fFecharTabela(qryPreAlt);

  FreeAndNil(strLisCam);
  FreeAndNil(strLisUsu);

  pSalvaSelecao;
end;

procedure TfrmAltPrecoIndividual.pDeletaTemporaria;
  Var
    qryGenTmp: TUniQuery;
Begin
  Try

    qryGenTmp := fCriaQuery(Self);

    If Not fEmptyStr(strTabela) Then
    Begin

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('DROP TABLE ' + strTabela);
        ExecSQL;
        CLose;
      End;

    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;
End;

{****************}
{* LIMPA CAMPOS *}
{*************AF*}
procedure TfrmAltPrecoIndividual.pLimpaCampos;
Begin
  mskLinGru.Clear;
  edtDesGru.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtCodUni.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtCodAbr.Clear;
  edtDesAbr.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodMon.Clear;
  edtDesMon.Clear;
  edtGruCmp.Clear;
  edtCodDep.Clear;
  edtDesDep.Clear;
  edtPrdGru.Clear;
  edtClaIpi.Clear;
  edtExcIpi.Clear;

  edtSerie.Clear;
  edtEspecie.Clear;
  edtDocumento.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  edtDocumentoExit(Self);
End;

Function TfrmAltPrecoIndividual.fStrToFloatSelectedField: Double;
Begin
  If dbgTiposAlt.SelectedField.IsNull Then
    Result := -1
  Else
    Result := fStrToFloat(dbgTiposAlt.SelectedField.Value);
End;

Function TfrmAltPrecoIndividual.fColunaAtiva(strCodCam: String): Boolean;
Begin
  Result := SameText(dbgTiposAlt.SelectedField.FieldName, strCodCam);
End;



{********************************}
{* ATUALIZA DADOS DE ALTERAÇÕES *}
{*****************************AF*}
procedure TfrmAltPrecoIndividual.pAtualizaDados(DataSet: TDataSet);
  Var
    intContador: Integer;
    strSQL:      String;
    qryConsAbr:  TUniQuery;
    qryConsUni:  TUniQuery;
    qryConsMar:  TUniQuery;
    qryConsFor:  TUniQuery;
Begin
  If fColunaAtiva('ITE_CODABF_NOV') Then
  Begin

    Try
      qryConsAbr := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ABFICM ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ABF_CODABF = :CODABF ';

      With qryConsAbr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODABF').AsString := fStrZero(qryGen.FieldByName('ITE_CODABF_NOV').AsString, 3);
        Open;
      End;

      If qryConsAbr.RecordCount > 0 Then
      Begin
        qryGen.FieldByName('ITE_CODABF_NOV').AsString := fStrZero(qryGen.FieldByName('ITE_CODABF_NOV').AsString, 3);
        dbgTiposAlt.SelectedField.FocusControl;
      End
      Else
      Begin
        fMensagem('','Código da Abreviação ICMS não encontrado!',['&OK']);
        dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_CODABF').AsString;
        dbgTiposAlt.SelectedField.FocusControl;
        Exit;
      End;
    Finally
      FreeAndNil(qryConsAbr);
    End;

  End

  Else If fColunaAtiva('ITE_CLAIPI_NOV') Then
  Begin
    If Not fEmptyStr(dbgTiposAlt.SelectedField.Value) And (Length(dbgTiposAlt.SelectedField.Value) <> MAX_CLAIPI) Then
    Begin
      fMensagem('ATENÇÃO', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_EXCIPI_NOV') Then
  Begin
    If Not fEmptyStr(dbgTiposAlt.SelectedField.Value) And (Length(dbgTiposAlt.SelectedField.Value) <> 3) Then
    Begin
      fMensagem('ATENÇÃO', 'O código EX do IPI deve ter 3 caracteres!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  End

  
  Else If fColunaAtiva('ITE_PER_CI_NOV') Then
  Begin
    If Not fValidaEscala(dbgTiposAlt.SelectedField.AsString, 0, 100) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Percentual (CI) deve estar entre 0 e 100!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_PRAPEL_NOV') Then
  Begin
    If fStrToFloatSelectedField < 0  Then
    Begin
      fMensagem('','O campo Desconto Referênte Rapel deve ser maior ou igual a zero!',['&OK']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_IMPFED_NOV') Then
  Begin
    If fStrToFloatSelectedField < 0  Then
    Begin
      fMensagem('','O campo Impostos Federais (+) deve ser maior ou igual a zero!',['&OK']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;
  End

  Else If fColunaAtiva('ITE_SUBFED_NOV') Then
  Begin
    If fStrToFloatSelectedField < 0  Then
    Begin
      fMensagem('','O campo Impostos Federais (-) deve ser maior ou igual a zero!',['&OK']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;
  End

  Else If fColunaAtiva('ITE_ABFPIS_NOV') Then
  Begin
    If (Not fValidaAbfPisCofinsIpi('PISSAI', 'ITE_ABFPIS')) Then
      Exit;
  End

  Else If fColunaAtiva('ITE_ABFCOF_NOV') Then
  Begin
    If (Not fValidaAbfPisCofinsIpi('COFSAI', 'ITE_ABFCOF')) Then
      Exit;
  End

  Else If fColunaAtiva('ITE_ABFIPI_NOV') Then
  Begin
    If (Not fValidaAbfPisCofinsIpi('IPISAI', 'ITE_ABFIPI')) Then
      Exit;
  End

  Else If fColunaAtiva('ITE_INFLAM_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Inflamável?" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_USABON_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Usa Bonificação?" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_USAFLE_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Gerar Flex?" deve ser (S)im ou (N)ão!', ['&OK']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_LOTEPD_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Obrigar definir lote (WMS) em Pedido de Venda?" deve ser (S)im ou (N)ão!', ['&OK']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_VALOBR_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Validade Obrigatória?" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_OBRCPF_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Venda com obrigatoriedade de CPF/CNPJ?" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_OBRIBA_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Venda com obrigatoriedade de código IBAMA?" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_OBRNFE_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Venda com obrigatoriedade de NFe?" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_NVLGIR_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'ABC') <= 0) Then
    Begin
      fMensagem('', 'O campo "Nível de Giro de Estoque" deve ser (A), (B) ou (C)!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_NVLCRI_NOV') Or fColunaAtiva('ITE_NIVCRI_NOV') Then
  Begin
    dbgTiposAlt.SelectedField.Value := UpperCase(dbgTiposAlt.SelectedField.Value);

    If (Pos(dbgTiposAlt.SelectedField.Value, 'XYZ') <= 0) Then
    Begin
      fMensagem('', 'O campo "Nível de Criticidade de Estoque" deve ser (X), (Y) ou (Z)!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End


  Else If fColunaAtiva('ITE_PROEMB_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Produto Embalagem" deve ser (S) ou (N)!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End
  Else If fColunaAtiva('ITE_DIAFOR_NOV') Then
  Begin

    If (dbgTiposAlt.SelectedField.Value < 0) Then
    Begin
      fMensagem('', 'Dias para entrega do fornecedor deve ser maior ou igual à zero', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_PRAMIN_NOV') Then
  Begin

    If (dbgTiposAlt.SelectedField.Value < 0) Then
    Begin
      fMensagem('', 'Prazo médio mínimo para cálculo de juros deve ser maior ou igual à zero', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_REAEND_NOV') Then
  Begin
    dbgTiposAlt.SelectedField.Value := UpperCase(dbgTiposAlt.SelectedField.Value);

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Realizar endereçamento do produto" deve ser (S) ou (N)!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_OBRBAR_NOV') Then
  Begin
    dbgTiposAlt.SelectedField.Value := UpperCase(dbgTiposAlt.SelectedField.Value);

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Obrigatório o Código de Barras na Entrada Simplificada" deve ser (S) ou (N)!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_PEFUTP_NOV') Then
  Begin
    dbgTiposAlt.SelectedField.Value := UpperCase(dbgTiposAlt.SelectedField.Value);

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Permitir Entrega Futura com Status "Previsão de Entrega"?" deve ser (S) ou (N)!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_PEEFUT_NOV') Then
  Begin
    dbgTiposAlt.SelectedField.Value := UpperCase(dbgTiposAlt.SelectedField.Value);

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Permitir Entrega Futura com Status "Aguardando o Cliente"?" deve ser (S) ou (N)!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_PEFFPR_NOV') Then
  Begin
    dbgTiposAlt.SelectedField.Value := UpperCase(dbgTiposAlt.SelectedField.Value);

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Permitir Entrega Futura com Status "Falta de Produto"?" deve ser (S) ou (N)!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_CODDEP_NOV') Then
  Begin
    If dbgTiposAlt.DataSource.DataSet.State = dsEdit Then
      dbgTiposAlt.SelectedField.AsString := fStrZero(dbgTiposAlt.SelectedField.AsString, 3);

    If fEmptyStr(fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[dbgTiposAlt.SelectedField.AsString])) Then
    Begin
      fMensagem('', 'Departamento não encontrado!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End
  Else If fColunaAtiva('ITE_CDCEST_NOV') Then
  Begin
    If dbgTiposAlt.DataSource.DataSet.State = dsEdit Then
      dbgTiposAlt.SelectedField.AsString := dbgTiposAlt.SelectedField.AsString;

    If not fEmptyStr(dbgTiposAlt.SelectedField.AsString) Then
    Begin
      If fEmptyStr(fCampoTabela('CES_DESCRI','CDCEST',['CES_CDCEST'],[dbgTiposAlt.SelectedField.AsString])) Then
      Begin
        fMensagem('', 'Classificação CEST não encontrada!', ['&Ok']);
        dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      End;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
       Exit;
  End

  Else If fColunaAtiva('ITE_GRUCMP_NOV') Then
  Begin
    If dbgTiposAlt.DataSource.DataSet.State = dsEdit Then
      dbgTiposAlt.SelectedField.AsString := dbgTiposAlt.SelectedField.AsString;

    If fEmptyStr(fCampoTabela('GRU_DESCRI','GRU_COMPRA',['GRU_CODIGO'],[dbgTiposAlt.SelectedField.AsString])) Then
    Begin
      fMensagem('', 'Grupo de Compra não encontrado!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;
  End

  Else If fColunaAtiva('ITE_NOTESP_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Divisível" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_RECDEV_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Permite Receber Devolução" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_UTIAMP_NOV') Then
  begin
    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Aplica Legislação Ampara" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;
  End

  Else If fColunaAtiva('ITE_ORDSER_NOV') Then
  begin
    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Ordem de Serviço" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;
  End

  Else If fColunaAtiva('ITE_CLACRM_NOV') Then
  begin
    If (Pos(dbgTiposAlt.SelectedField.Value, 'CPA') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo "Classificação Oferta de Consumíveis" deve ser (C)onsumível, (P)rincipal ou (A)cessório!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;
  End

  Else If fColunaAtiva('ITE_CPESOB_NOV') Then
  begin
    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Controlar pesagem obrigatória ( Entrada ) ?" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;
  End

  Else If fColunaAtiva('ITE_DESCND_NOV') Then
  begin
    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Aplicar desconto da condição de pagamento?" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;
  End

  Else If fColunaAtiva('ITE_ITEATI_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo "Ativo" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End
    Else If (dbgTiposAlt.SelectedField.Value <> dbgTiposAlt.SelectedField.OldValue) And
            (dbgTiposAlt.SelectedField.Value = 'N')                                 Then
    Begin

      If (Not fInativarProduto) Then
      Begin
        dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
        Exit;
      End;

    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
    Begin
      Exit;
    End;

  End
  Else If fColunaAtiva('ITE_CODUNI_NOV') Then
  Begin

    Try
      qryConsUni := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADUNI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  UNI_CODUNI = :CODUNI ';

      With qryConsUni Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODUNI').AsString := qryGen.FieldByName('ITE_CODUNI_NOV').AsString;
        Open;
      End;

      If qryConsUni.RecordCount > 0 Then
      Begin
        qryGen.FieldByName('ITE_CODUNI_NOV').AsString := qryGen.FieldByName('ITE_CODUNI_NOV').AsString;
        dbgTiposAlt.SelectedField.FocusControl;
      End
      Else
      Begin
        fMensagem('','Código da Unidade não encontrado!',['&OK']);
        dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_CODUNI').AsString;
        dbgTiposAlt.SelectedField.FocusControl;
        Exit;
      End;
    Finally
      FreeAndNil(qryConsUni);
    End;

  End

  Else If fColunaAtiva('ITE_TIPPRO_NOV') Then
  Begin
    If Not fTipoProdutoValido(qryGen.FieldByName('ITE_TIPPRO_NOV').AsString) Then
    Begin
      fMensagem('','Tipo de produto inválido!',['&OK']);
      dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_TIPPRO').AsString;
      dbgTiposAlt.SelectedField.FocusControl;
      Exit;
    End;
  End

  Else If fColunaAtiva('ITE_UNICOM_NOV') Then
  Begin

    Try
      qryConsUni := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADUNI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  UNI_CODUNI = :CODUNI ';

      With qryConsUni Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODUNI').AsString := qryGen.FieldByName('ITE_UNICOM_NOV').AsString;
        Open;
      End;

      If qryConsUni.RecordCount > 0 Then
      Begin
        qryGen.FieldByName('ITE_UNICOM_NOV').AsString := qryGen.FieldByName('ITE_UNICOM_NOV').AsString;
        dbgTiposAlt.SelectedField.FocusControl;
      End
      Else
      Begin
        fMensagem('','Código da Unidade não encontrado!',['&OK']);
        dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_UNICOM').AsString;
        dbgTiposAlt.SelectedField.FocusControl;
        Exit;
      End;
    Finally
      FreeAndNil(qryConsUni);
    End;

  End

  Else If fColunaAtiva('ITE_UNITRI_NOV') Then
  Begin

    Try
      qryConsUni := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADUNI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  UNI_CODUNI = :CODUNI ';

      With qryConsUni Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODUNI').AsString := qryGen.FieldByName('ITE_UNITRI_NOV').AsString;
        Open;
      End;

      If qryConsUni.RecordCount > 0 Then
      Begin
        qryGen.FieldByName('ITE_UNITRI_NOV').AsString := qryGen.FieldByName('ITE_UNITRI_NOV').AsString;
        dbgTiposAlt.SelectedField.FocusControl;
      End
      Else
      Begin
        fMensagem('','Código da Unidade não encontrado!',['&OK']);
        dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_UNITRI').AsString;
        dbgTiposAlt.SelectedField.FocusControl;
        Exit;
      End;
    Finally
      FreeAndNil(qryConsUni);
    End;

  End

  Else If fColunaAtiva('ITE_FATUTR_NOV') Then
  Begin

    If fStrToFloatSelectedField < 0 Then
    Begin
      fMensagem('', 'O fator de conversão da unidade tributária deve ser maior ou igual a zero!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;

  End

  Else If fColunaAtiva('ITE_CODMAR_NOV') Then
  Begin

    Try
      qryConsMar := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADMAR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  MAR_CODMAR = :CODMAR ';

      With qryConsMar Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODMAR').AsString := fStrZero(qryGen.FieldByName('ITE_CODMAR_NOV').AsString, fTamCodMar);
        Open;
      End;

      If qryConsMar.RecordCount > 0 Then
      Begin
        qryGen.FieldByName('ITE_CODMAR_NOV').AsString := fStrZero(qryGen.FieldByName('ITE_CODMAR_NOV').AsString, fTamCodMar);
        dbgTiposAlt.SelectedField.FocusControl;
      End
      Else
      Begin
        fMensagem('','Código da Marca não encontrado!',['&OK']);
        dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_CODMAR').AsString;
        dbgTiposAlt.SelectedField.FocusControl;
        Exit;
      End;
    Finally
      FreeAndNil(qryConsMar);
    End;

  End

  Else If fColunaAtiva('ITE_SITPRO_NOV') Then
  Begin

    If fEmptyStr(qryGen.FieldByName('ITE_SITPRO_NOV').AsString) Then
    Begin
      qryGen.FieldByName('ITE_SITPRO_NOV').Clear;
      dbgTiposAlt.SelectedField.FocusControl;
    End

    Else If Not fEmptyStr(fRetNomSituacaoProduto(fStrZero(qryGen.FieldByName('ITE_SITPRO_NOV').AsString, 3))) Then
    Begin
      qryGen.FieldByName('ITE_SITPRO_NOV').AsString := fStrZero(qryGen.FieldByName('ITE_SITPRO_NOV').AsString, 3);
      dbgTiposAlt.SelectedField.FocusControl;
    End
    Else
    Begin
      fMensagem('','Código da Situação do Produto não encontrado!',['&OK']);
      dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_SITPRO').AsString;
      dbgTiposAlt.SelectedField.FocusControl;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_DTAVAL_NOV') And blnValFor Then
  Begin
    If fEmptyStr(qryGen.FieldByName('ITE_DTAVAL_NOV').AsString) Then
    Begin
      qryGen.FieldByName('ITE_DTAVAL_NOV').Clear;
      dbgTiposAlt.SelectedField.FocusControl;
    End
    Else If (qryGen.FieldByName('ITE_DTAVAL_NOV').AsDateTime <= 0) Then
    Begin
      fMensagem('','Data de Validade de Preço inválida!',['&OK']);
      dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_DTAVAL').AsDateTime;
      dbgTiposAlt.SelectedField.FocusControl;
      Exit;
    End
    Else If (qryGen.FieldByName('ITE_DTAVAL_NOV').AsDateTime <= fNow) Then
    Begin
      fMensagem('','Data da Validade de Preço precisa ser maior ou igual que a data atual!',['&OK']);
      dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_DTAVAL').AsDateTime;
      dbgTiposAlt.SelectedField.FocusControl;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_CODMON_NOV') Then
  Begin

    If fEmptyStr(qryGen.FieldByName('ITE_CODMON_NOV').AsString) Then
    Begin
      qryGen.FieldByName('ITE_CODMON_NOV').Clear;
      dbgTiposAlt.SelectedField.FocusControl;
    End

    Else If Not fEmptyStr(fRetNomSituacaoProduto(fStrZero(qryGen.FieldByName('ITE_CODMON_NOV').AsString, 3))) Then
    Begin
      qryGen.FieldByName('ITE_CODMON_NOV').AsString := fStrZero(qryGen.FieldByName('ITE_CODMON_NOV').AsString, 3);
      dbgTiposAlt.SelectedField.FocusControl;
    End
    Else
    Begin
      fMensagem('','Código da Montadora não encontrado!',['&OK']);
      dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_CODMON').AsString;
      dbgTiposAlt.SelectedField.FocusControl;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_CODFOR_NOV') Then
  Begin

    Try
      qryConsFor := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADFOR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  FOR_CODFOR = :CODFOR ';

      With qryConsFor Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODFOR').AsString := fStrZero(qryGen.FieldByName('ITE_CODFOR_NOV').AsString, 8);
        Open;
      End;

      If qryConsFor.RecordCount > 0 Then
      Begin
        qryGen.FieldByName('ITE_CODFOR_NOV').AsString := fStrZero(qryGen.FieldByName('ITE_CODFOR_NOV').AsString, 8);
        dbgTiposAlt.SelectedField.FocusControl;
      End
      Else
      Begin
        fMensagem('','Código do Fornecedor não encontrado!',['&OK']);
        dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_CODFOR').AsString;
        dbgTiposAlt.SelectedField.FocusControl;
        Exit;
      End;
    Finally
      FreeAndNil(qryConsFor);
    End;

  End

  Else If fColunaAtiva('ITE_COMVAR_NOV') Then
  Begin

    If fStrToFloatSelectedField < 0 Then
    Begin
      fMensagem('', 'A comissão do "vendedor interno" deve ser maior ou igual a zero!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;

  End

  Else If fColunaAtiva('ITE_COMATA_NOV') Then
  Begin

    If fStrToFloatSelectedField < 0 Then
    Begin
      fMensagem('', 'A comissão do "representante externo loja" deve ser maior ou igual a zero!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;

  End

  Else If fColunaAtiva('ITE_COMDIS_NOV') Then
  Begin

    If fStrToFloatSelectedField < 0 Then
    Begin
      fMensagem('', 'A comissão do "representante externo distribuidor" deve ser maior ou igual a zero!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;

  End

  Else If fColunaAtiva('ITE_COMDIG_NOV') Then
  Begin

    If (fStrToFloatSelectedField < 0) Or (fStrToFloatSelectedField > 100) Then
    Begin
      fMensagem('', 'A comissão do digitador deve ser um valor inteiro entre 0 e 100!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;

  End

  Else If fColunaAtiva('ITE_ABAMLT_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'A opção de abastecer com múltiplo de compra deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_COMPRO_NOV') Then
  Begin

    If fStrToFloatSelectedField < 0 Then
    Begin
      fMensagem('', 'A comissão do profissional deve ser maior ou igual a zero!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;
  End

  Else If fColunaAtiva('ITE_PRDGRU_NOV') Then
  Begin

    If fEmptyStr(qryGen.FieldByName('ITE_PRDGRU_NOV').AsString) Then
    Begin
      qryGen.FieldByName('ITE_PRDGRU_NOV').Clear;
      dbgTiposAlt.SelectedField.FocusControl;
    End

    Else If Not fEmptyStr(fRetNomeGrupoProduto(fStrZero(qryGen.FieldByName('ITE_PRDGRU_NOV').AsString, 5))) Then
    Begin
      qryGen.FieldByName('ITE_PRDGRU_NOV').AsString := fStrZero(qryGen.FieldByName('ITE_PRDGRU_NOV').AsString, 5);
      dbgTiposAlt.SelectedField.FocusControl;
    End
    Else
    Begin
      fMensagem('','Código do Grupo de Produto não encontrado!',['&OK']);
      dbgTiposAlt.SelectedField.Value := qryGen.FieldByName('ITE_PRDGRU').AsString;
      dbgTiposAlt.SelectedField.FocusControl;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_IMPLIS_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'A opção de imprimir lista deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_IMPETI_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'O campo Imprime Etiqueta na Entrada de Mercadorias deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  End

  Else If fColunaAtiva('ITE_ATICOM_NOV') Then
  Begin

    If (Pos(dbgTiposAlt.SelectedField.Value, 'SN') <= 0) Then
    Begin
      fMensagem('', 'A opção de ativo para compras deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  End
  Else If fColunaAtiva('ITE_CODDIC_NOV') Then
  Begin

    If (not fEmptyStr(dbgTiposAlt.SelectedField.Value) and (fEmptyStr(fRetDesDic(dbgTiposAlt.SelectedField.Value))) ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Código DIC não Cadastrado!', ['&O k']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  End
  Else If fColunaAtiva('ITE_DENSID_NOV') Then
  Begin

    If fStrToFloatSelectedField < 0 Then
    Begin
      fMensagem('', 'Densidade deve ser maior ou igual a Zero!', ['&OK']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
    End;

  End
  Else If fColunaAtiva('ITE_CODGRU_NOV') Then
  begin
    if fEmptyStr(fRetNomeSoGrupo(dbgTiposAlt.SelectedField.Value)) then
    Begin
      fMensagem('ATENÇÃO!', 'Grupo não encontrado / Linha não permitida!', ['&O k']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;
  end
  Else If fColunaAtiva('ITE_TIPFRE_NOV') Then
  begin
    dbgTiposAlt.SelectedField.Value := UpperCase(dbgTiposAlt.SelectedField.Value);

    If Not (Pos(dbgTiposAlt.SelectedField.Value, 'PFU') > 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de frete deve ser (P)ERCENTUAL, (F)IXO ou (U)NITÁRIO!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  end
  Else If fColunaAtiva('ITE_VLCFRE_NOV') Then
  begin

    If (fStrToFloatSelectedField < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Frete de saída deve ser maior ou igual a Zero!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;

  end
  Else If fColunaAtiva('ITE_RASTRE_NOV') Then
  Begin

    If (Pos(UpperCase(dbgTiposAlt.SelectedField.Value), 'SN') <= 0) Then
    Begin
      fMensagem('', 'A opção de "Utilizar controle de rastreabilidade" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End
    Else
      dbgTiposAlt.SelectedField.Value := UpperCase(dbgTiposAlt.SelectedField.Value);

  End
  Else If fColunaAtiva('ITE_PESOBR_NOV') Then
  Begin

    If (Pos(UpperCase(dbgTiposAlt.SelectedField.Value), 'SN') <= 0) Then
    Begin
      fMensagem('', 'A opção de "Controlar pesagem obrigatória" deve ser (S)im ou (N)ão!', ['&Ok']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End
    Else
      dbgTiposAlt.SelectedField.Value := UpperCase(dbgTiposAlt.SelectedField.Value);

  End
  Else If fColunaAtiva('ITE_CODLSE_NOV') Then
  Begin
    If (not fEmptyStr(dbgTiposAlt.SelectedField.Value) and (fEmptyStr(fRetLocSep(dbgTiposAlt.SelectedField.Value))) ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Localização de Separação não Cadastrada!', ['&O k']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;
  End
  Else If fColunaAtiva('ITE_FATCMP_NOV') Then
  Begin
    If fStrToFloatSelectedField < 0  Then
    Begin
      fMensagem('','O campo "Fator madeira de M³ X Peças" deve ser maior ou igual a zero!',['&OK']);
      dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      Exit;
    End;
  End
  Else If (fCfgSis('CLAONU', varBoolean)) And fColunaAtiva('ITE_CODONU_NOV') Then
  Begin
    If dbgTiposAlt.DataSource.DataSet.State = dsEdit Then
      dbgTiposAlt.SelectedField.AsString := dbgTiposAlt.SelectedField.AsString;

    If not fEmptyStr(dbgTiposAlt.SelectedField.AsString) Then
    Begin
      If fEmptyStr(fCampoTabela('ONU_DESCRI','CADONU',['ONU_CODONU'],[dbgTiposAlt.SelectedField.AsString])) Then
      Begin
        fMensagem('', 'Classificação ONU não encontrada!', ['&Ok']);
        dbgTiposAlt.SelectedField.Value := dbgTiposAlt.SelectedField.OldValue;
      End;
    End
    Else If dbgTiposAlt.SelectedField.Value = dbgTiposAlt.SelectedField.OldValue Then
       Exit;
  End;

  With qryGen Do
  Begin

    If (Active) And (Not IsEmpty) Then
    Begin
      pRecalculaPrecos;
      FieldByName('ALTERA').AsString := 'S';

      For intContador := 0 To Length(colColunas)-1 Do
      Begin

        If colColunas[intcontador].strNomCam = dbgTiposAlt.SelectedField.FieldName Then
          colColunas[intcontador].blnHabili := True;

      End;

    End;

  End;
End;

procedure TfrmAltPrecoIndividual.pAtualizaDadosDuplic;
  Var
    strSQL: String;
    qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery(Self);
  With cdsDuplic Do
  Begin
    Filtered := False;
    Filter := 'ORIGEM = ' + QuotedStr('N');
    Filtered := True;
    First;
    While Not Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + strTabela + ' ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  ITE_CODFAB_NOV = :CODFAB, ';
      strSQL := strSQL + '  ITE_CODBAR_NOV = :CODBAR, ';
      strSQL := strSQL + '  ITE_BAREMB_NOV = :BAREMB  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_CODITE     = :CODITE  ';

      qryUpd.Close;
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add(strSQL);
      qryUpd.ParamByName('CODFAB').AsString := FieldByName('CODFAB').AsString;
      qryUpd.ParamByName('CODBAR').AsString := FieldByName('CODBAR').AsString;
      qryUpd.ParamByName('BAREMB').AsString := FieldByName('BAREMB').AsString;
      qryUpd.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;
      qryUpd.ExecSQL;

      Next;
    End;
  End;
  FreeAndNil(qryUpd);
end;

{************************}
{* RECALCULA OS VALORES *}
{*********************AF*}
procedure TfrmAltPrecoIndividual.pRecalculaPrecos;
  Var
    intContador: Integer;
    intAux: Integer;
begin
  With qryGen Do
  Begin

    For intContador := 0 To Length(colColunas)-1 Do
    Begin
      If colColunas[intContador].strNomCam = 'ITE_PRECUS_NOV' Then
        blnPreCus := colColunas[intContador].blnHabili

      Else If fEhCampoPrecoVenda(colColunas[intContador].strNomCam, intAux) Then
      Begin
        If LeftStr(colColunas[intContador].strNomCam, 9) = 'ITE_PREVE' Then
          arrRecTabPrecos[intAux].blnPreVen := colColunas[intContador].blnHabili
        Else
          arrRecTabPrecos[intAux].blnMarBru := colColunas[intContador].blnHabili;
      End;

    End;

    //*************************************************//
    //                                                 //
    // RECALCULA O PRECO DE CUSTO DE ACORDO COM A OPC. //
    // SELECIONADA.                                    //
    // 1 - RECALCULA ALTERANDO O PRECO DE VENDA        //
    // 2 - RECALCULA ALTERANDO A MARGEM DE VENDA       //
    //                                                 //
    //**********************************************ED*//
    If ( intCustoVenda In[0,1] )                                                                      Or
       (Pos(dbgTiposAlt.SelectedField.FieldName, 'ITE_DESMAX_NOV_ITE_DESMGE_NOV_ITE_DESMSU_NOV') > 0) Then
    Begin
      fRecalculaPreCusto;
    End
    Else
    Begin
      fRecalculaPreVendaOuMargem;
    End;

    fRecalculaPreLiq;

    For intContador := 0 To Length(colColunas)-1 Do
    Begin
      If Pos(colColunas[intContador].strNomCam, 'ITE_PRECUS_NOV-ITE_CUSREA_NOV') > 0 Then
        colColunas[intContador].blnHabili := blnPreCus

      Else If fEhCampoPrecoVenda(colColunas[intContador].strNomCam, intAux) Then
      Begin
        If LeftStr(colColunas[intContador].strNomCam, 9) = 'ITE_PREVE' Then
          colColunas[intContador].blnHabili := arrRecTabPrecos[intAux].blnPreVen
        Else
          colColunas[intContador].blnHabili := arrRecTabPrecos[intAux].blnMarBru;
      End;

    End;

  End;
end;

function TfrmAltPrecoIndividual.fVerificaDuplic: Integer;
  Var
    strSQL: String;
    qryDup: TUniQuery;
    qryTmp: TUniQuery;

    function fValidaTemp: Boolean;
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ITE_CODEMP, ';
      strSQL := strSQL + '  ITE_CODFOR, ';
      strSQL := strSQL + '  ITE_CODITE, ';
      strSQL := strSQL + '  ITE_DESITE, ';
      strSQL := strSQL + '  ITE_CODFAB, ';
      strSQL := strSQL + '  ITE_CODBAR, ';
      strSQL := strSQL + '  ITE_BAREMB  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + strTabela + '  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_CODITE <> :CODITE AND ';
      strSQL := strSQL + ' (ITE_CODFAB  = :CODFAB AND ';
      strSQL := strSQL + '  ITE_CODFOR  = :CODFOR AND ';
      strSQL := strSQL + '  IFNULL(ITE_CODFAB, "") <> "") OR ';

      strSQL := strSQL + '  ITE_CODITE <> :CODITE AND ';
      strSQL := strSQL + ' (ITE_CODFAB_NOV  = :CODFAB AND ';
      strSQL := strSQL + '  ITE_CODFOR  = :CODFOR AND ';
      strSQL := strSQL + '  IFNULL(ITE_CODFAB_NOV, "") <> "") OR ';

      strSQL := strSQL + '  (ITE_CODBAR = :CODBAR AND ';
      strSQL := strSQL + '   IFNULL(ITE_CODBAR, "") <> "" AND ';
      strSQL := strSQL + '   ITE_CODITE <> :CODITE) OR ';

      strSQL := strSQL + '  (ITE_CODBAR_NOV = :CODBAR AND ';
      strSQL := strSQL + '   IFNULL(ITE_CODBAR_NOV, "") <> "" AND ';
      strSQL := strSQL + '   ITE_CODITE <> :CODITE) ';

      If Not fEmptyStr(qryGen.FieldByName('ITE_BAREMB_NOV').AsString) Then
      Begin
        strSQL := strSQL + ' OR (IFNULL(ITE_BAREMB, "") <> "" AND ITE_BAREMB = :BAREMB AND ITE_CODITE <> :CODITE) ';
        strSQL := strSQL + ' OR (IFNULL(ITE_BAREMB_NOV, "") <> "" AND ITE_BAREMB_NOV = :BAREMB AND ITE_CODITE <> :CODITE) ';
      End;

      qryTmp.Close;
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add(strSQL);
      qryTmp.ParamByName('CODITE').AsString := qryGen.FieldByName('ITE_CODITE').AsString;
      qryTmp.ParamByName('CODFAB').AsString := qryGen.FieldByName('ITE_CODFAB_NOV').AsString;
      qryTmp.ParamByName('CODFOR').AsString := qryGen.FieldByName('ITE_CODFOR').AsString;
      qryTmp.ParamByName('CODBAR').AsString := qryGen.FieldByName('ITE_CODBAR_NOV').AsString;
      If Not fEmptyStr(qryGen.FieldByName('ITE_BAREMB_NOV').AsString) Then
        qryTmp.ParamByName('BAREMB').AsString := qryGen.FieldByName('ITE_BAREMB_NOV').AsString;
      qryTmp.Open;
      If (qryTmp.RecordCount > 0) Then
      Begin
        While Not qryTmp.Eof Do
        Begin
          pAdicionaDuplic('N', qryGen, qryGen.FieldByName('ITE_CODITE').AsString + ' - ' +
                                  qryGen.FieldByName('ITE_DESITE').AsString);
          qryTmp.Next;
        End;
      End;
      Result := True;
    end;
begin
  qryDup := fCriaQuery(Self);
  qryTmp := fCriaQuery(Self);
  cdsDuplic.CreateDataSet;

  With qryGen Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Application.ProcessMessages;
      Screen.Cursor := crHourGlass;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ITE_CODEMP, ';
      strSQL := strSQL + '  ITE_CODFOR, ';
      strSQL := strSQL + '  ITE_CODITE, ';
      strSQL := strSQL + '  ITE_DESITE, ';
      strSQL := strSQL + '  ITE_CODFAB, ';
      strSQL := strSQL + '  ITE_CODBAR, ';
      strSQL := strSQL + '  ITE_BAREMB  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_CODITE <> :CODITE AND ';
      strSQL := strSQL + ' (ITE_CODFAB  = :CODFAB AND ';
      strSQL := strSQL + '  ITE_CODFOR  = :CODFOR AND ';
      strSQL := strSQL + '  IFNULL(ITE_CODFAB, "") <> "") OR ';
      strSQL := strSQL + '  (ITE_CODBAR = :CODBAR AND ';
      strSQL := strSQL + '  IFNULL(ITE_CODBAR, "") <> "" AND ';      
      strSQL := strSQL + '  ITE_CODITE <> :CODITE) ';
      If Not fEmptyStr(FieldByName('ITE_BAREMB_NOV').AsString) Then
        strSQL := strSQL + ' OR (IFNULL(ITE_BAREMB, "") <> "" AND ITE_BAREMB = :BAREMB AND ITE_CODITE <> :CODITE) ';

      qryDup.Close;
      qryDup.SQL.Clear;
      qryDup.SQL.Add(strSQL);
      qryDup.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      qryDup.ParamByName('CODFAB').AsString := FieldByName('ITE_CODFAB_NOV').AsString;
      qryDup.ParamByName('CODFOR').AsString := FieldByName('ITE_CODFOR').AsString;
      qryDup.ParamByName('CODBAR').AsString := FieldByName('ITE_CODBAR_NOV').AsString;
      If Not fEmptyStr(FieldByName('ITE_BAREMB_NOV').AsString) Then
        qryDup.ParamByName('BAREMB').AsString := FieldByName('ITE_BAREMB_NOV').AsString;
      qryDup.Open;

      If (qryDup.RecordCount > 0) Then
        pAdicionaDuplic('S', qryDup, qryGen.FieldByName('ITE_CODITE').AsString + ' - ' +
                                     qryGen.FieldByName('ITE_DESITE').AsString);

      While Not qryDup.Eof Do
      Begin
        pAdicionaDuplic('N', qryGen, qryGen.FieldByName('ITE_CODITE').AsString + ' - ' +
                                     qryGen.FieldByName('ITE_DESITE').AsString);
        qryDup.Next;
      End;

      fValidaTemp;

      Next;
    End;
  End;
  Result := cdsDuplic.RecordCount;
  If (cdsDuplic.RecordCount > 0) Then
  Begin
    cdsDuplic.IndexFieldNames := 'CODFAB;CODFOR;CODBAR;BAREMB';
    Try
      pCriarFormularios(TfrmAltPrecoDuplicidades, frmAltPrecoDuplicidades);
      frmAltPrecoDuplicidades.ShowModal;

      If (frmAltPrecoDuplicidades.ModalResult = mrOk) Then
        pAtualizaDadosDuplic
      eLSE
        Result := -1
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

    FreeAndNil(frmAltPrecoDuplicidades);
  End;
  Screen.Cursor := crDefault;
  cdsDuplic.Close;
  FreeAndNil(qryTmp);
  FreeAndNil(qryDup);
  qryGen.EnableControls;
end;

function TfrmAltPrecoIndividual.fValidaAbfPisCofinsIpi(strTabela,
  strCampo: String): Boolean;
  Var
    strSQL: String;
    qryConsAbr: TUniQuery;
Begin
  Result := False;
  Try
    qryConsAbr := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ' + strTabela + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  APC_CODAPC = :CODAPC ';

    With qryConsAbr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODAPC').AsString := fStrZero(qryGen.FieldByName(strCampo + '_NOV').AsString, 3);
      Open;
    End;

    If qryConsAbr.RecordCount > 0 Then
    Begin
      qryGen.FieldByName(strCampo + '_NOV').AsString := fStrZero(qryGen.FieldByName(strCampo + '_NOV').AsString, 3);
      dbgTiposAlt.SelectedField.FocusControl;
      Result := True;
    End
    Else
    Begin
      fMensagem('','Código da Abreviação não encontrado!',['&OK']);
      dbgTiposAlt.SelectedField.Value := qryGen.FieldByName(strCampo).AsString;
      dbgTiposAlt.SelectedField.FocusControl;
      Exit;
    End;
  Finally
    FreeAndNil(qryConsAbr);
  End;
    
end;

procedure TfrmAltPrecoIndividual.btnProPagClick(Sender: TObject);
begin
  inherited;
  If (pnlFiltros.Visible) Then
  Begin
    pnlFiltros.Visible := False;
    pnlFiltro2.Visible := True;
    pnlFiltro2.BringToFront;
    btnProPag.Caption  := '[F4] Página Ant.';
  End
  Else
  Begin
    pnlFiltros.Visible := True;
    pnlFiltros.BringToFront;
    pnlFiltro2.Visible := False;
    btnProPag.Caption  := '[F4] Próx.Página';
  End;
end;

procedure TfrmAltPrecoIndividual.btnConfirmaAltClick(Sender: TObject);
begin
  If Not fEmptyStr(edtDocumento.Text) Then
    If Not fVerificaCampos Then
      Exit;
  If InterlockedIncrement(intConfirmando) = 0 Then
  Begin

    Try
      pConfirma;
      InterlockedDecrement(intConfirmando);
    Except
      InterlockedDecrement(intConfirmando);
    End;

  End
  Else
    InterlockedDecrement(intConfirmando)
end;

procedure TfrmAltPrecoIndividual.pAtualizaIteger(qryGenIte, qryGenPre: TUniQuery; strEmpresas: String; blnResFor: Boolean);
  Var
    strSQL: String;
    strUpdTipPro: String;
    strUpdSitPro: String;
    qryTmp: TUniQuery;
    qryGen: TUniQuery;
Begin
  With qryGenPre Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'UPDATE                  ';
    strSQL := strSQL + '  ITEGER                ';
    strSQL := strSQL + 'SET                     ';
    strSQL := strSQL + '  ITE_PRECOM = :PRECOM, ';
    strSQL := strSQL + '  ITE_DESF01 = :DESF01, ';
    strSQL := strSQL + '  ITE_DESF02 = :DESF02, ';
    strSQL := strSQL + '  ITE_DESF03 = :DESF03, ';
    strSQL := strSQL + '  ITE_DESF04 = :DESF04, ';
    strSQL := strSQL + '  ITE_DESF05 = :DESF05, ';
    strSQL := strSQL + '  ITE_DESF06 = :DESF06, ';
    strSQL := strSQL + '  ITE_ICMENT = :ICMENT, ';
    strSQL := strSQL + '  ITE_SUBFED = :SUBFED, ';
    strSQL := strSQL + '  ITE_IPIENT = :IPIENT, ';
    strSQL := strSQL + '  ITE_FREENT = :FREENT, ';
    strSQL := strSQL + '  ITE_VALFRE = :VALFRE, ';
    strSQL := strSQL + '  ITE_ACRFIN = :ACRFIN, ';
    strSQL := strSQL + '  ITE_SUBSTI = :SUBSTI, ';
    strSQL := strSQL + '  ITE_DESADB = :DESADB, ';
    strSQL := strSQL + '  ITE_IPISAI = :IPISAI, ';
    strSQL := strSQL + '  ITE_PRECUS = :PRECUS, ';
    strSQL := strSQL + '  ITE_TIPPRO = :TIPPRO, ';
    strSQL := strSQL + '  ITE_RECDEV = :RECDEV  ';

    If fCfgSis('TPSPED') = '1' Then
      strSQL := strSQL + ', ITE_TIPPRO = :TIPPRO  ';

    If intSitPro = 2 Then
      strSQL := strSQL + ' , ITE_SITPRO = :SITPRO ';

    If Not blnResFor Then
    Begin
      strSQL := strSQL + ', ';

      If blnInfMat And (intInfSai = 1) Then
        strSQL := strSQL + '  ITE_ICMSAI = IF(:EMPLOG = ITE_CODEMP, :ICMSAI, ITE_ICMSAI), '
      Else
        strSQL := strSQL + '  ITE_ICMSAI = :ICMSAI, ';

      If blnInfMat And (intInfFed = 1) Then
        strSQL := strSQL + '  ITE_IMPFED = IF(:EMPLOG = ITE_CODEMP, :IMPFED, ITE_IMPFED), '
      Else
        strSQL := strSQL + '  ITE_IMPFED = :IMPFED, ';

      If blnInfMat And (intInfOpe = 1) Then
        strSQL := strSQL + '  ITE_DESOPE = IF(:EMPLOG = ITE_CODEMP, :DESOPE, ITE_DESOPE), '
      Else
        strSQL := strSQL + '  ITE_DESOPE = :DESOPE, ';

      strSQL := strSQL + '  ITE_OUTVAL = :OUTVAL, ';

      strSQL := strSQL + '  ITE_ABAMLT = :ABAMLT, ';

      If not blnIteTbp Then
      Begin
        strSQL := strSQL + '  ITE_DESMAX = :DESMAX, ';
        strSQL := strSQL + '  ITE_DESMGE = :DESMGE, ';
        strSQL := strSQL + '  ITE_DESMSU = :DESMSU, ';
      End;

      strSQL := strSQL + '  ITE_NIVCRI = :NIVCRI, ';

      strSQL := strSQL + '  ITE_MARBR1 = :MARBR1, ';
      strSQL := strSQL + '  ITE_MARBR2 = :MARBR2, ';
      strSQL := strSQL + '  ITE_MARBR3 = :MARBR3, ';
      strSQL := strSQL + '  ITE_MARBR4 = :MARBR4, ';
      strSQL := strSQL + '  ITE_MARBR5 = :MARBR5, ';
      strSQL := strSQL + '  ITE_MARBR6 = :MARBR6, ';
      strSQL := strSQL + '  ITE_MARBR7 = :MARBR7, ';

      If fCfgSis('MARIDE', VarBoolean) Then
      Begin
        strSQL := strSQL + '  ITE_MARID1 = :MARID1, ';
        strSQL := strSQL + '  ITE_MARID2 = :MARID2, ';
        strSQL := strSQL + '  ITE_MARID3 = :MARID3, ';
        strSQL := strSQL + '  ITE_MARID4 = :MARID4, ';
        strSQL := strSQL + '  ITE_MARID5 = :MARID5, ';
        strSQL := strSQL + '  ITE_MARID6 = :MARID6, ';
        strSQL := strSQL + '  ITE_MARID7 = :MARID7, ';
      End;

      strSQL := strSQL + '  ITE_COMTB1 = :COMTB1, ';
      strSQL := strSQL + '  ITE_COMTB2 = :COMTB2, ';
      strSQL := strSQL + '  ITE_COMTB3 = :COMTB3, ';
      strSQL := strSQL + '  ITE_COMTB4 = :COMTB4, ';
      strSQL := strSQL + '  ITE_COMTB5 = :COMTB5, ';
      strSQL := strSQL + '  ITE_COMTB6 = :COMTB6, ';
      strSQL := strSQL + '  ITE_COMTB7 = :COMTB7, ';

      strSQL := strSQL + '  ITE_PREVE1 = :PREVE1, ';
      strSQL := strSQL + '  ITE_PREVE2 = :PREVE2, ';
      strSQL := strSQL + '  ITE_PREVE3 = :PREVE3, ';
      strSQL := strSQL + '  ITE_PREVE4 = :PREVE4, ';
      strSQL := strSQL + '  ITE_PREVE5 = :PREVE5, ';
      strSQL := strSQL + '  ITE_PREVE6 = :PREVE6, ';
      strSQL := strSQL + '  ITE_PREVE7 = :PREVE7, ';

      strSQL := strSQL + '  ITE_MARMIN = :MARMIN, ';
      strSQL := strSQL + '  ITE_MARMSG = :MARMSG, ';
      strSQL := strSQL + '  ITE_MARMGE = :MARMGE, ';

      strSQL := strSQL + '  ITE_QTPPRO = :QTPPRO, ';
      strSQL := strSQL + '  ITE_COMVAR = :COMVAR, ';
      strSQL := strSQL + '  ITE_COMATA = :COMATA, ';
      strSQL := strSQL + '  ITE_COMDIS = :COMDIS, ';
      strSQL := strSQL + '  ITE_COMDIG = :COMDIG, ';
      strSQL := strSQL + '  ITE_COMPRO = :COMPRO, ';

      If (chkPesObr.Visible) And (chkPesObr.Checked) Then
        strSQL := strSQL + '  ITE_PESOBR = :PESOBR, ';

      If blnValFor Then
        strSQL := strSQL + '  ITE_DTAVAL = :DTAVAL, ';

      strSQL := strSQL + '  ITE_MINTB1 = :MINTB1, ';
      strSQL := strSQL + '  ITE_MINTB2 = :MINTB2, ';
      strSQL := strSQL + '  ITE_MINTB3 = :MINTB3, ';
      strSQL := strSQL + '  ITE_MINTB4 = :MINTB4, ';
      strSQL := strSQL + '  ITE_MINTB5 = :MINTB5, ';
      strSQL := strSQL + '  ITE_MINTB6 = :MINTB6, ';
      strSQL := strSQL + '  ITE_MINTB7 = :MINTB7, ';
      strSQL := strSQL + '  ITE_CPESOB = :CPESOB  ';

    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';

    If blnResFor Then
      strSQL := strSQL + '  LOCATE(ITE_CODEMP, :CODEMP) = 0 '
    Else
      strSQL := strSQL + '  LOCATE(ITE_CODEMP, :CODEMP) > 0 ';

    qryGenIte.Close;
    qryGenIte.SQL.Clear;
    qryGenIte.SQL.Add(strSQL);

    qryGenIte.ParamByName('NIVCRI').AsString  := FieldByName('ITE_NIVCRI_NOV').AsString;
    qryGenIte.ParamByName('PRECOM').AsFloat  := FieldByName('ITE_PRECOM_NOV').AsFloat;
    qryGenIte.ParamByName('DESF01').AsFloat  := FieldByName('ITE_DESF01_NOV').AsFloat;
    qryGenIte.ParamByName('DESF02').AsFloat  := FieldByName('ITE_DESF02_NOV').AsFloat;
    qryGenIte.ParamByName('DESF03').AsFloat  := FieldByName('ITE_DESF03_NOV').AsFloat;
    qryGenIte.ParamByName('DESF04').AsFloat  := FieldByName('ITE_DESF04_NOV').AsFloat;
    qryGenIte.ParamByName('DESF05').AsFloat  := FieldByName('ITE_DESF05_NOV').AsFloat;
    qryGenIte.ParamByName('DESF06').AsFloat  := FieldByName('ITE_DESF06_NOV').AsFloat;
    qryGenIte.ParamByName('ICMENT').AsFloat  := FieldByName('ITE_ICMENT_NOV').AsFloat;
    qryGenIte.ParamByName('SUBFED').AsFloat  := FieldByName('ITE_SUBFED_NOV').AsFloat;
    qryGenIte.ParamByName('IPIENT').AsFloat  := FieldByName('ITE_IPIENT_NOV').AsFloat;
    qryGenIte.ParamByName('FREENT').AsFloat  := FieldByName('ITE_FREENT_NOV').AsFloat;
    qryGenIte.ParamByName('VALFRE').AsFloat  := FieldByName('ITE_VALFRE_NOV').AsFloat;
    qryGenIte.ParamByName('ACRFIN').AsFloat  := FieldByName('ITE_ACRFIN_NOV').AsFloat;
    qryGenIte.ParamByName('SUBSTI').AsFloat  := FieldByName('ITE_SUBSTI_NOV').AsFloat;
    qryGenIte.ParamByName('DESADB').AsFloat  := FieldByName('ITE_DESADB_NOV').AsFloat;
    qryGenIte.ParamByName('IPISAI').AsFloat  := FieldByName('ITE_IPISAI_NOV').AsFloat;
    qryGenIte.ParamByName('PRECUS').AsFloat  := FieldByName('ITE_PRECUS_NOV').AsFloat;
    qryGenIte.ParamByName('TIPPRO').AsString := FieldByName('ITE_TIPPRO_NOV').AsString;
    qryGenIte.ParamByName('RECDEV').AsString := FieldByName('ITE_RECDEV_NOV').AsString;

    If fCfgSis('TPSPED') = '1' Then
      qryGenIte.ParamByName('TIPPRO').AsString := FieldByName('ITE_TIPPRO_NOV').AsString;

    If intSitPro = 2 Then
      qryGenIte.ParamByName('SITPRO').AsString  := FieldByName('ITE_SITPRO_NOV').AsString;

    If Not blnResFor Then
    Begin

      qryGenIte.ParamByName('OUTVAL').AsFloat  := FieldByName('ITE_OUTVAL_NOV').AsFloat;
      qryGenIte.ParamByName('ICMSAI').AsFloat  := FieldByName('ITE_ICMSAI_NOV').AsFloat;
      qryGenIte.ParamByName('IMPFED').AsFloat  := FieldByName('ITE_IMPFED_NOV').AsFloat;
      qryGenIte.ParamByName('DESOPE').AsFloat  := FieldByName('ITE_DESOPE_NOV').AsFloat;

      qryGenIte.ParamByName('ABAMLT').AsString := FieldByName('ITE_ABAMLT_NOV').AsString;
      if not blnIteTbp Then
      Begin
        qryGenIte.ParamByName('DESMAX').AsFloat := FieldByName('ITE_DESMAX_NOV').AsFloat;
        qryGenIte.ParamByName('DESMGE').AsFloat := FieldByName('ITE_DESMGE_NOV').AsFloat;
        qryGenIte.ParamByName('DESMSU').AsFloat := FieldByName('ITE_DESMSU_NOV').AsFloat;
      End;

      qryGenIte.ParamByName('MARBR1').AsFloat  := FieldByName('ITE_MARBR1_NOV').AsFloat;
      qryGenIte.ParamByName('MARBR2').AsFloat  := FieldByName('ITE_MARBR2_NOV').AsFloat;
      qryGenIte.ParamByName('MARBR3').AsFloat  := FieldByName('ITE_MARBR3_NOV').AsFloat;
      qryGenIte.ParamByName('MARBR4').AsFloat  := FieldByName('ITE_MARBR4_NOV').AsFloat;
      qryGenIte.ParamByName('MARBR5').AsFloat  := FieldByName('ITE_MARBR5_NOV').AsFloat;
      qryGenIte.ParamByName('MARBR6').AsFloat  := FieldByName('ITE_MARBR6_NOV').AsFloat;
      qryGenIte.ParamByName('MARBR7').AsFloat  := FieldByName('ITE_MARBR7_NOV').AsFloat;

      If fCfgSis('MARIDE', VarBoolean) Then
      Begin
       qryGenIte.ParamByName('MARID1').AsFloat  := FieldByName('ITE_MARID1_NOV').AsFloat;
       qryGenIte.ParamByName('MARID2').AsFloat  := FieldByName('ITE_MARID2_NOV').AsFloat;
       qryGenIte.ParamByName('MARID3').AsFloat  := FieldByName('ITE_MARID3_NOV').AsFloat;
       qryGenIte.ParamByName('MARID4').AsFloat  := FieldByName('ITE_MARID4_NOV').AsFloat;
       qryGenIte.ParamByName('MARID5').AsFloat  := FieldByName('ITE_MARID5_NOV').AsFloat;
       qryGenIte.ParamByName('MARID6').AsFloat  := FieldByName('ITE_MARID6_NOV').AsFloat;
       qryGenIte.ParamByName('MARID7').AsFloat  := FieldByName('ITE_MARID7_NOV').AsFloat;
      End;

      qryGenIte.ParamByName('COMTB1').AsFloat  := FieldByName('ITE_COMTB1_NOV').AsFloat;
      qryGenIte.ParamByName('COMTB2').AsFloat  := FieldByName('ITE_COMTB2_NOV').AsFloat;
      qryGenIte.ParamByName('COMTB3').AsFloat  := FieldByName('ITE_COMTB3_NOV').AsFloat;
      qryGenIte.ParamByName('COMTB4').AsFloat  := FieldByName('ITE_COMTB4_NOV').AsFloat;
      qryGenIte.ParamByName('COMTB5').AsFloat  := FieldByName('ITE_COMTB5_NOV').AsFloat;
      qryGenIte.ParamByName('COMTB6').AsFloat  := FieldByName('ITE_COMTB6_NOV').AsFloat;
      qryGenIte.ParamByName('COMTB7').AsFloat  := FieldByName('ITE_COMTB7_NOV').AsFloat;

      qryGenIte.ParamByName('PREVE1').AsFloat  := FieldByName('ITE_PREVE1_NOV').AsFloat;
      qryGenIte.ParamByName('PREVE2').AsFloat  := FieldByName('ITE_PREVE2_NOV').AsFloat;
      qryGenIte.ParamByName('PREVE3').AsFloat  := FieldByName('ITE_PREVE3_NOV').AsFloat;
      qryGenIte.ParamByName('PREVE4').AsFloat  := FieldByName('ITE_PREVE4_NOV').AsFloat;
      qryGenIte.ParamByName('PREVE5').AsFloat  := FieldByName('ITE_PREVE5_NOV').AsFloat;
      qryGenIte.ParamByName('PREVE6').AsFloat  := FieldByName('ITE_PREVE6_NOV').AsFloat;
      qryGenIte.ParamByName('PREVE7').AsFloat  := FieldByName('ITE_PREVE7_NOV').AsFloat;

      qryGenIte.ParamByName('MARMIN').AsFloat  := FieldByName('ITE_MARMIN_NOV').AsFloat;
      qryGenIte.ParamByName('MARMSG').AsFloat  := FieldByName('ITE_MARMSG_NOV').AsFloat;
      qryGenIte.ParamByName('MARMGE').AsFloat  := FieldByName('ITE_MARMGE_NOV').AsFloat;

      qryGenIte.ParamByName('QTPPRO').AsFloat  := FieldByName('ITE_QTPPRO_NOV').AsFloat;

      qryGenIte.ParamByName('COMVAR').AsFloat  := FieldByName('ITE_COMVAR_NOV').AsFloat;
      qryGenIte.ParamByName('COMATA').AsFloat  := FieldByName('ITE_COMATA_NOV').AsFloat;
      qryGenIte.ParamByName('COMDIS').AsFloat  := FieldByName('ITE_COMDIS_NOV').AsFloat;
      qryGenIte.ParamByName('COMDIG').AsFloat  := FieldByName('ITE_COMDIG_NOV').AsFloat;
      qryGenIte.ParamByName('COMPRO').AsFloat  := FieldByName('ITE_COMPRO_NOV').AsFloat;

      If (chkPesObr.Visible) And (chkPesObr.Checked) Then
        qryGenIte.ParamByName('PESOBR').AsString := FieldByName('ITE_PESOBR_NOV').AsString;

      If (chkCpesOb.Visible) And (chkCpesOb.Checked) Then
        qryGenIte.ParamByName('CPESOB').AsString := FieldByName('ITE_CPESOB_NOV').AsString;

      If blnValFor Then
        qryGenIte.ParamByName('DTAVAL').AsDateTime := FieldByName('ITE_DTAVAL_NOV').AsDateTime;

      qryGenIte.ParamByName('MINTB1').AsFloat  := FieldByName('ITE_MINTB1_NOV').AsFloat;
      qryGenIte.ParamByName('MINTB2').AsFloat  := FieldByName('ITE_MINTB2_NOV').AsFloat;
      qryGenIte.ParamByName('MINTB3').AsFloat  := FieldByName('ITE_MINTB3_NOV').AsFloat;
      qryGenIte.ParamByName('MINTB4').AsFloat  := FieldByName('ITE_MINTB4_NOV').AsFloat;
      qryGenIte.ParamByName('MINTB5').AsFloat  := FieldByName('ITE_MINTB5_NOV').AsFloat;
      qryGenIte.ParamByName('MINTB6').AsFloat  := FieldByName('ITE_MINTB6_NOV').AsFloat;
      qryGenIte.ParamByName('MINTB7').AsFloat  := FieldByName('ITE_MINTB7_NOV').AsFloat;
    End;

    qryGenIte.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
    qryGenIte.ParamByName('CODEMP').AsString := strEmpresas;

    If qryGenIte.Params.FindParam('EMPLOG') <> Nil Then
      qryGenIte.ParamByName('EMPLOG').AsString := VS_strCodEmp;

    qryGenIte.ExecSQL;
    qryGenIte.Close;

    If fCfgSis('TPSPED') = '2' Then
    Begin
      strUpdTipPro := '';
      strUpdTipPro := strUpdTipPro + 'UPDATE ';
      strUpdTipPro := strUpdTipPro + '  ITEGER ';
      strUpdTipPro := strUpdTipPro + 'SET ';
      strUpdTipPro := strUpdTipPro + '  ITE_TIPPRO = ' + QuotedStr(FieldByName('ITE_TIPPRO_NOV').AsString) + ' ';
      strUpdTipPro := strUpdTipPro + 'WHERE ';
      strUpdTipPro := strUpdTipPro + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString) + ' AND ';
	    strUpdTipPro := strUpdTipPro + '  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

      qryTmp := fCriaQuery;
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add(strUpdTipPro);
      qryTmp.ExecSQL;

      FreeAndNil(qryTmp);
    End;

    If intSitPro = 1 Then
    Begin
      strUpdSitPro := '';
      strUpdSitPro := strUpdSitPro + 'UPDATE ';
      strUpdSitPro := strUpdSitPro + '  ITEGER ';
      strUpdSitPro := strUpdSitPro + 'SET ';
      strUpdSitPro := strUpdSitPro + '  ITE_SITPRO = ' + QuotedStr(FieldByName('ITE_SITPRO_NOV').AsString) + ' ';
      strUpdSitPro := strUpdSitPro + 'WHERE ';
      strUpdSitPro := strUpdSitPro + '  ITE_CODITE = ' + QuotedStr(FieldByName('ITE_CODITE').AsString);

      qryGen := fCriaQuery;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strUpdSitPro);
      qryGen.ExecSQL;

      FreeAndNil(qryGen);
    End;

    If blnInfMat Then
      pRecalculaItensResponsavelFornecedor(strEmpresas, FieldByName('ITE_CODITE').AsString, blnResFor);

  End;
End;

procedure TfrmAltPrecoIndividual.pAtualizaPermiteFazerVenda(strCodIte,
  strCodEmp, strPeFave: String);
  Var
    qryAltGer : TUniQuery;
begin
  qryAltGer := fCriaQuery(Self);
  Try
    qryAltGer.Close;
    qryAltGer.SQL.Clear;
    qryAltGer.SQL.Add(' UPDATE ITEGER ');
    qryAltGer.SQL.Add('    SET ITE_PEFAVE = :PEFAVE ');
    qryAltGer.SQL.Add('  WHERE ITE_CODITE = :CODITE ');
    qryAltGer.SQL.Add('    AND ITE_CODEMP = :CODEMP ');
    qryAltGer.ParamByName('PEFAVE').AsString := strPeFave;
    qryAltGer.ParamByName('CODITE').AsString := strCodIte;
    qryAltGer.ParamByName('CODEMP').AsString := strCodEmp;
    qryAltGer.ExecSQL;
  Finally
    FreeAndNil(qryAltGer);
  End;
end;

{***************}
{* GRAVA DADOS *}
{************AF*}
function TfrmAltPrecoIndividual.fGravaDados: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    With frmGravando Do
    Begin
      fExecutarAcao := fGravaDadosAux;
      lblGravando.Caption := 'Aguarde, atualizando itens...';
      ShowModal;
      Result := blnConfirma;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.fGravaDados]');
      Result := False;
    End;
  End;

  FreeAndNil(frmGravando);
End;

function TfrmAltPrecoIndividual.fGravaDadosAux(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSQL         : String;
    strSQL2        : String;
    strEmpresas    : String;
    strLocalErro   : String;
    qryGenPre      : TUniQuery;
    qryGenIte      : TUniQuery;
    qryGenEmp      : TUniQuery;
    qryIteTbp      : TUniQuery;
    blnCprCenInd   : Boolean;
    intCorre       : Integer;
    intTbpAux      : Integer;
    strProPri      : String;
    stlEmpFilial   : TStringList;
    strEmpFilial   : String;

  Const
    strInsTbp : String = ' INSERT INTO ITETBP (ITE_CODITE, ITE_CODEMP, ITE_TABPRE,  ITE_DESMAX, ITE_DESMGE, ITE_DESMSU) ' +
                                      'VALUES (   :CODITE,    :CODEMP,    :TABPRE,     :DESMAX,    :DESMGE,    :DESMSU);';


    strUptTbp : String = 'UPDATE ITETBP SET ITE_DESMAX = :DESMAX, ITE_DESMGE = :DESMGE, ITE_DESMSU = :DESMSU ' +
                         'WHERE ITE_CODITE = :CODITE   ' +
                         '  AND ITE_CODEMP = :CODEMP   ' +
                         '  AND ITE_TABPRE = :TABPRE;  ' ;

  Procedure pSetParametrosIteTbp(strTabPre : String; fltMaxDes : Double = 0; fltMaxDge : Double = 0; fltMaxDSu : Double = 0;strCodEmp:String = '');
  Begin
    With qryIteTbp Do
    Begin
      ParamByName('CODITE').AsString := qryGenPre.FieldByName('ITE_CODITE').AsString;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('TABPRE').AsString := strTabPre;
      if Params.FindParam('DESMAX') <> NIl Then
        ParamByName('DESMAX').AsFloat     := fltMaxDes;
      if Params.FindParam('DESMGE') <> NIl Then
        ParamByName('DESMGE').AsFloat     := fltMaxDge;
      if Params.FindParam('DESMSU') <> NIl Then
        ParamByName('DESMSU').AsFloat     := fltMaxDSu;
    End;
  End;

Begin
  Result := False;
  qryGenPre := fCriaQuery(Self);
  qryGenIte := fCriaQuery(Self);
  qryGenEmp := fCriaQuery(Self);
  qryIteTbp := fCriaQuery(Self);

  stlEmpFilial :=  TStringList.Create;
  strEmpFilial :=  '';

  Try
    Try
    fStartTransaction;

    strEmpresas := fRetEmpresasUsamPrecoMatriz;
    fRetEmpresasUsamPrecoMatriz(stlEmpFilial);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strTabela;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ALTERA = "S" ';

    If (frmAltPrecoDigData.dtaData = VS_Date) Then
    Begin
      With qryGenPre Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

          If fCfgSis('MARNEG', varBoolean) Then
          Begin
            If Not TProdMargemNegativa.fLiberaMargemNegativa(qryGenPre, qryGenPre, rotAltPrecoIndividual) Then
              Exit;
          End;

        pgbProgresso.Position       := 0;
        pgbProgresso.Properties.Max := RecordCount;
        Application.ProcessMessages;

        If Not IsEmpty Then
        Begin

          strSQL2 := '';
          strSQL2 := strSQL2 + 'UPDATE ';
          strSQL2 := strSQL2 + '  CADITE ';
          strSQL2 := strSQL2 + 'SET ';
          strSQL2 := strSQL2 + '  ITE_DESITE = :DESITE, ';
          strSQL2 := strSQL2 + '  ITE_REFERE = :REFERE, ';
          strSQL2 := strSQL2 + '  ITE_ITEATI = :ITEATI, ';

          If fCfgSIs('TIPABF') = '1' Then
            strSQL2 := strSQL2 + '  ITE_CODABF = :CODABF, ';

          If fCfgSis('TPABPC') = '1' Then
          Begin
            strSQL2 := strSQL2 + '  ITE_ABFPIS = :ABFPIS, ';
            strSQL2 := strSQL2 + '  ITE_ABFCOF = :ABFCOF, ';
            strSQL2 := strSQL2 + '  ITE_ABFIPI = :ABFIPI, ';
          End;

          strSQL2 := strSQL2 + '  ITE_ABFPIS = :ABFPIS, ';
          strSQL2 := strSQL2 + '  ITE_ABFCOF = :ABFCOF, ';
          strSQL2 := strSQL2 + '  ITE_ABFIPI = :ABFIPI, ';

          strSQL2 := strSQL2 + '  ITE_CLAIPI = :CLAIPI, ';
          strSQL2 := strSQL2 + '  ITE_EXCIPI = :EXCIPI, ';
          strSQL2 := strSQL2 + '  ITE_GRUCMP = :GRUCMP, ';
          strSQL2 := strSQL2 + '  ITE_CDCEST = :CDCEST, ';
          strSQL2 := strSQL2 + '  ITE_APLICA = :APLICA, ';
          strSQL2 := strSQL2 + '  ITE_PER_CI = :PER_CI, ';
          strSQL2 := strSQL2 + '  ITE_NUMFCI = :NUMFCI, ';
          strSQL2 := strSQL2 + '  ITE_MLTCOM = :MLTCOM, ';
          strSQL2 := strSQL2 + '  ITE_MLTVEN = :MLTVEN, ';
          strSQL2 := strSQL2 + '  ITE_CODFAB = :CODFAB, ';
          strSQL2 := strSQL2 + '  ITE_CODBAR = :CODBAR, ';
          strSQL2 := strSQL2 + '  ITE_MESGIR = :MESGIR, ';
          strSQL2 := strSQL2 + '  ITE_TMPGAR = :TMPGAR, ';
          strSQL2 := strSQL2 + '  ITE_INFGAR = :INFGAR, ';
          strSQL2 := strSQL2 + '  ITE_EMBALA = :EMBALA, ';
          strSQL2 := strSQL2 + '  ITE_BAREMB = :BAREMB, ';
          strSQL2 := strSQL2 + '  ITE_PESOIT = :PESOIT, ';
          strSQL2 := strSQL2 + '  ITE_PESLIQ = :PESLIQ, ';
          strSQL2 := strSQL2 + '  ITE_INFLAM = :INFLAM, ';
          strSQL2 := strSQL2 + '  ITE_USABON = :USABON, ';
          strSQL2 := strSQL2 + '  ITE_USAFLE = :USAFLE, ';
          strSQL2 := strSQL2 + '  ITE_OBRCPF = :OBRCPF, ';
          strSQL2 := strSQL2 + '  ITE_OBRIBA = :OBRIBA, ';
          strSQL2 := strSQL2 + '  ITE_OBRNFE = :OBRNFE, ';
          strSQL2 := strSQL2 + '  ITE_NVLGIR = :NVLGIR, ';

          strSQL2 := strSQL2 + '  ITE_NVLCRI = :NVLCRI, ';

          strSQL2 := strSQL2 + '  ITE_PROEMB = :PROEMB, ';
          strSQL2 := strSQL2 + '  ITE_ACOOBJ = :ACOOBJ, ';
          strSQL2 := strSQL2 + '  ITE_VALOBR = :VALOBR, ';
          strSQL2 := strSQL2 + '  ITE_CODUNI = :CODUNI, ';
          strSQL2 := strSQL2 + '  ITE_UNICOM = :UNICOM, ';
          strSQL2 := strSQL2 + '  ITE_UNITRI = :UNITRI, ';
          strSQL2 := strSQL2 + '  ITE_FATUTR = :FATUTR, ';
          strSQL2 := strSQL2 + '  ITE_CODMAR = :CODMAR, ';
          If intSitPro = 1 Then
            strSQL2 := strSQL2 + '  ITE_SITPRO = :SITPRO, ';
          strSQL2 := strSQL2 + '  ITE_CODMON = :CODMON, ';
          strSQL2 := strSQL2 + '  ITE_CODFOR = :CODFOR, ';
          strSQL2 := strSQL2 + '  ITE_DIAFOR = :DIAFOR, ';
          strSQL2 := strSQL2 + '  ITE_REAEND = :REAEND, ';
          strSQL2 := strSQL2 + '  ITE_OBRBAR = :OBRBAR, ';
          strSQL2 := strSQL2 + '  ITE_FATCOM = :FATCOM, ';
          strSQL2 := strSQL2 + '  ITE_CODDEP = :CODDEP, ';
          strSQL2 := strSQL2 + '  ITE_NOTESP = :NOTESP, ';
          strSQL2 := strSQL2 + '  ITE_PRDGRU = :PRDGRU, ';
          strSQL2 := strSQL2 + '  ITE_ATICOM = :ATICOM, ';
          strSQL2 := strSQL2 + '  ITE_CODDIC = :CODDIC, ';
          strSQL2 := strSQL2 + '  ITE_IMPETI = :IMPETI, ';
          strSQL2 := strSQL2 + '  ITE_FATCMP = :FATCMP, ';

          strSQL2 := strSQL2 + '  ITE_PEFUTP = :PEFUTP, ';
          strSQL2 := strSQL2 + '  ITE_PEEFUT = :PEEFUT, ';
          strSQL2 := strSQL2 + '  ITE_PEFFPR = :PEFFPR, ';

          If (chkDensid.Visible) And (chkDensid.Checked) Then
            strSQL2 := strSQL2 + '  ITE_DENSID = :DENSID, ';

          if blnURapel then
            strSQL2 := strSQL2 + '  ITE_PRAPEL = :PRAPEL,  ';

          If fUsaRotinaWMS Then
            strSQL2 := strSQL2 + '  ITE_RASTRE = :RASTRE, ';

          strSQL2 := strSQL2 + '  ITE_DTAALT = :DTAALT, ';
          strSQL2 := strSQL2 + '  ITE_HULALT = :HULALT, ';
          strSQL2 := strSQL2 + '  ITE_CODOPE = :CODOPE, ';
          strSQL2 := strSQL2 + '  ITE_CODGRU = :CODGRU, ';
          strSQL2 := strSQL2 + '  ITE_TIPFRE = :TIPFRE, ';
          strSQL2 := strSQL2 + '  ITE_VLCFRE = :VLCFRE, ';

          strSQL2 := strSQL2 + '  ITE_LARVID = :LARVID, ';
          strSQL2 := strSQL2 + '  ITE_ALTVID = :ALTVID, ';
          strSQL2 := strSQL2 + '  ITE_LAMAVI = :LAMAVI, ';
          strSQL2 := strSQL2 + '  ITE_ALMAVI = :ALMAVI, ';
          strSQL2 := strSQL2 + '  ITE_UTIAMP = :UTIAMP, ';
          strSQL2 := strSQL2 + '  ITE_LOTEPD = :LOTEPD, ';
          strSQL2 := strSQL2 + '  ITE_ORDSER = :ORDSER, ';
          strSQL2 := strSQL2 + '  ITE_UTIAMP = :UTIAMP, ';
          strSQL2 := strSQL2 + '  ITE_LOTEPD = :LOTEPD, ';
          strSQL2 := strSQL2 + '  ITE_DESCND = :DESCND, ';
          strSQL2 := strSQL2 + '  ITE_CLACRM = :CLACRM  ';

          If (fCfgSis('CLAONU', varBoolean)) Then
            strSQL2 := strSQL2 + ' , ITE_CODONU = :CODONU  ';

          strSQL2 := strSQL2 + 'WHERE ';
          strSQL2 := strSQL2 + '  ITE_CODITE = :CODITE  ';

         // pgbStatus.Visible := True;
         // pgbStatus.Max     := RecordCount;

          While Not Eof Do
          Begin
            strLocalErro    := '';

            {*****************************************}
            {* TRATAMENTO DA LOCALIZAÇÃO FÍSICA      *}
            {**************************************MV*}
            If (FieldByName('ITE_LOCFIS_NOV').AsString <> FieldByName('ITE_LOCFIS').AsString) Then
              UpdateIteger('ITE_LOCFIS', qryGenPre);

            If (FieldByName('ITE_LOCSUP_NOV').AsString <> FieldByName('ITE_LOCSUP').AsString) Then
              UpdateIteger('ITE_LOCSUP', qryGenPre);

            If (FieldByName('ITE_TAMLCF_NOV').AsString <> FieldByName('ITE_TAMLCF').AsString) Then
              UpdateIteger('ITE_TAMLCF', qryGenPre);

            If (FieldByName('ITE_TAMLCS_NOV').AsString <> FieldByName('ITE_TAMLCS').AsString) Then
              UpdateIteger('ITE_TAMLCS', qryGenPre);

            {**********************************}
            {* TRATAMENTO DO ESTOQUE MÁXIMO   *}
            {*******************************CI*}
            If (FieldByName('ITE_ESTMAX_NOV').AsString <> FieldByName('ITE_ESTMAX').AsString) Then
              UpdateIteger('ITE_ESTMAX', qryGenPre);

            If (FieldByName('ITE_ESTMIN_NOV').AsString <> FieldByName('ITE_ESTMIN').AsString) Then
              UpdateIteger('ITE_ESTMIN', qryGenPre);

            {*****************************************}
            {* TRATAMENTO DA ABREVIAÇÃO FISCAL       *}
            {**************************************MV*}
            If (FieldByName('ITE_CODABF_NOV').AsString <> FieldByName('ITE_CODABF').AsString) And (fCfgSIs('TIPABF') = '2') Then
                UpdateIteger('ITE_CODABF', qryGenPre);

            If fCfgSis('CLPVDI', varBoolean) Then
              pAtualizaPermiteFazerVenda(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, 'S');

            {******************************************}
            {* TRATAMENTO DA LOCALIZAÇÃO DE SEPARAÇÃO *}
            {***************************************MM*}
            If (FieldByName('ITE_CODLSE_NOV').AsString <> FieldByName('ITE_CODLSE').AsString) Then
              UpdateIteger('ITE_CODLSE', qryGenPre);

            If (FieldByName('ITE_PRAMIN_NOV').AsInteger <> FieldByName('ITE_PRAMIN').AsInteger) Then
              UpdateIteger('ITE_PRAMIN', qryGenPre);

            If fCfgSis('TPABPC') = '2' Then
            Begin
              strSQL := '';
              strSQL := strSQL + 'UPDATE ';
              strSQL := strSQL + '  ITEGER ';
              strSQL := strSQL + 'SET ';
              strSQL := strSQL + '  ITE_ABFPIS = :ABFPIS, ';
              strSQL := strSQL + '  ITE_ABFCOF = :ABFCOF, ';
              strSQL := strSQL + '  ITE_ABFIPI = :ABFIPI ';
              strSQL := strSQL + 'WHERE ';
              strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
              strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

              qryGenIte.Close;
              qryGenIte.SQL.Clear;
              qryGenIte.SQL.Add(strSQL);

              If fEmptyStr(FieldByName('ITE_ABFPIS_NOV').AsString) Then
                qryGenIte.ParamByName('ABFPIS').Value := Null
              else
                qryGenIte.ParamByName('ABFPIS').AsString := fStrZero(FieldByName('ITE_ABFPIS_NOV').AsString, 3);

              If fEmptyStr(FieldByName('ITE_ABFCOF_NOV').AsString) Then
                qryGenIte.ParamByName('ABFCOF').Value := Null
              Else
                qryGenIte.ParamByName('ABFCOF').AsString := fStrZero(FieldByName('ITE_ABFCOF_NOV').AsString, 3);

              If fEmptyStr(FieldByName('ITE_ABFIPI_NOV').AsString) Then
                qryGenIte.ParamByName('ABFIPI').Value := Null
              Else
                qryGenIte.ParamByName('ABFIPI').AsString := fStrZero(FieldByName('ITE_ABFIPI_NOV').AsString, 3);

              qryGenIte.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
              qryGenIte.ParamByName('CODEMP').AsString := VS_strCodEmp;

              qryGenIte.ExecSQL;
              qryGenIte.Close;
            End;

            pAtualizaIteger(qryGenIte, qryGenPre, strEmpresas, False);

            If blnInfMat And fEhEmpresaResponsavelFornecedor(FieldByName('ITE_CODFOR_NOV').AsString) Then
              pAtualizaIteger(qryGenIte, qryGenPre, strEmpresas, True);

            if FieldByName('ITE_IMPLIS_NOV').AsString <> FieldByName('ITE_IMPLIS').AsString Then
              pAtualizaImpLisLojas(FieldByName('ITE_IMPLIS_NOV').AsString, FieldByName('ITE_CODITE').AsString);

            If (FieldByName('ITE_CPRCEN_NOV').AsString <> FieldByName('ITE_CPRCEN').AsString) Then
            Begin
              blnCprCenInd := fCfgSis('CPRIND', varBoolean);
              pAtualizaCprCenLojas(FieldByName('ITE_CODITE').AsString,
                                   FieldByName('ITE_CPRCEN_NOV').AsString,
                                   blnCprCenInd);
            End;

            qryGenIte.Close;
            qryGenIte.SQL.Clear;
            qryGenIte.SQL.Add(strSQL2);

            qryGenIte.ParamByName('PESOIT').AsFloat  := FieldByName('ITE_PESOIT_NOV').AsFloat;
            qryGenIte.ParamByName('PESLIQ').AsFloat  := FieldByName('ITE_PESLIQ_NOV').AsFloat;
            qryGenIte.ParamByName('DESITE').AsString := FieldByName('ITE_DESITE').AsString;
            qryGenIte.ParamByName('REFERE').AsString := FieldByName('ITE_REFERE').AsString;
            qryGenIte.ParamByName('ITEATI').AsString := FieldByName('ITE_ITEATI_NOV').AsString;

            qryGenIte.ParamByName('FATCMP').AsString := FieldByName('ITE_FATCMP_NOV').AsString;

            If fCfgSIs('TIPABF') = '1' Then
              qryGenIte.ParamByName('CODABF').AsString := fStrZero(FieldByName('ITE_CODABF_NOV').AsString, 3);

            If (chkDensid.Visible) And (chkDensid.Checked) Then
              qryGenIte.ParamByName('DENSID').AsFloat := FieldByName('ITE_DENSID_NOV').AsFloat;

            If fUsaRotinaWMS Then
              qryGenIte.ParamByName('RASTRE').AsString := FieldByName('ITE_RASTRE_NOV').AsString;

            If fCfgSis('TPABPC') = '1' Then
            Begin
              If fEmptyStr(FieldByName('ITE_ABFPIS_NOV').AsString) Then
                qryGenIte.ParamByName('ABFPIS').Value := Null
              else
                qryGenIte.ParamByName('ABFPIS').AsString := fStrZero(FieldByName('ITE_ABFPIS_NOV').AsString, 3);

              If fEmptyStr(FieldByName('ITE_ABFCOF_NOV').AsString) Then
                qryGenIte.ParamByName('ABFCOF').Value := Null
              Else
                qryGenIte.ParamByName('ABFCOF').AsString := fStrZero(FieldByName('ITE_ABFCOF_NOV').AsString, 3);

              If fEmptyStr(FieldByName('ITE_ABFIPI_NOV').AsString) Then
                qryGenIte.ParamByName('ABFIPI').Value := Null
              Else
                qryGenIte.ParamByName('ABFIPI').AsString := fStrZero(FieldByName('ITE_ABFIPI_NOV').AsString, 3);
            End;

            qryGenIte.ParamByName('CLAIPI').AsString  := FieldByName('ITE_CLAIPI_NOV').AsString;
            qryGenIte.ParamByName('EXCIPI').AsString  := FieldByName('ITE_EXCIPI_NOV').AsString;
            qryGenIte.ParamByName('PER_CI').AsString  := FieldByName('ITE_PER_CI_NOV').AsString;
            qryGenIte.ParamByName('NUMFCI').AsString  := FieldByName('ITE_NUMFCI_NOV').AsString;
            qryGenIte.ParamByName('MLTCOM').AsFloat   := FieldByName('ITE_MLTCOM_NOV').AsFloat;
            qryGenIte.ParamByName('MLTVEN').AsFloat   := FieldByName('ITE_MLTVEN_NOV').AsFloat;
            qryGenIte.ParamByName('CODFAB').AsString  := FieldByName('ITE_CODFAB_NOV').AsString;
            qryGenIte.ParamByName('CODBAR').AsString  := FieldByName('ITE_CODBAR_NOV').AsString;
            qryGenIte.ParamByName('MESGIR').AsInteger := FieldByName('ITE_MESGIR_NOV').AsInteger;
            qryGenIte.ParamByName('TMPGAR').AsInteger := FieldByName('ITE_TMPGAR_NOV').AsInteger;
            qryGenIte.ParamByName('INFGAR').AsString  := FieldByName('ITE_INFGAR_NOV').AsString;
            qryGenIte.ParamByName('EMBALA').AsFloat   := FieldByName('ITE_EMBALA_NOV').AsFloat;
            qryGenIte.ParamByName('BAREMB').AsString  := FieldByName('ITE_BAREMB_NOV').AsString;
            qryGenIte.ParamByName('INFLAM').AsString  := FieldByName('ITE_INFLAM_NOV').AsString;
            qryGenIte.ParamByName('USABON').AsString  := FieldByName('ITE_USABON_NOV').AsString;
            qryGenIte.ParamByName('USAFLE').AsString  := FieldByName('ITE_USAFLE_NOV').AsString;
            qryGenIte.ParamByName('OBRCPF').AsString  := FieldByName('ITE_OBRCPF_NOV').AsString;
            qryGenIte.ParamByName('OBRIBA').AsString  := FieldByName('ITE_OBRIBA_NOV').AsString;
            qryGenIte.ParamByName('OBRNFE').AsString  := FieldByName('ITE_OBRNFE_NOV').AsString;
            qryGenIte.ParamByName('NVLGIR').AsString  := FieldByName('ITE_NVLGIR_NOV').AsString;

            qryGenIte.ParamByName('NVLCRI').AsString  := FieldByName('ITE_NVLCRI_NOV').AsString;

            qryGenIte.ParamByName('PROEMB').AsString  := FieldByName('ITE_PROEMB_NOV').AsString;
            qryGenIte.ParamByName('ACOOBJ').AsString  := FieldByName('ITE_ACOOBJ_NOV').AsString;
            qryGenIte.ParamByName('VALOBR').AsString  := FieldByName('ITE_VALOBR_NOV').AsString;

            qryGenIte.ParamByName('CODUNI').AsString  := FieldByName('ITE_CODUNI_NOV').AsString;
            If fEmptyStr(qryGenIte.ParamByName('CODUNI').AsString) Then
              qryGenIte.ParamByName('CODUNI').Clear;

            qryGenIte.ParamByName('UNICOM').AsString  := FieldByName('ITE_UNICOM_NOV').AsString;
            If fEmptyStr(qryGenIte.ParamByName('UNICOM').AsString) Then
              qryGenIte.ParamByName('UNICOM').Clear;

            qryGenIte.ParamByName('UNITRI').AsString  := FieldByName('ITE_UNITRI_NOV').AsString;
            If fEmptyStr(qryGenIte.ParamByName('UNITRI').AsString) Then
              qryGenIte.ParamByName('UNITRI').Clear;

            qryGenIte.ParamByName('FATUTR').Value  := FieldByName('ITE_FATUTR_NOV').Value;

            qryGenIte.ParamByName('CODMAR').AsString  := FieldByName('ITE_CODMAR_NOV').AsString;
            If fEmptyStr(qryGenIte.ParamByName('CODMAR').AsString) Then
              qryGenIte.ParamByName('CODMAR').Clear;

            If intSitPro = 1 Then
            Begin
              qryGenIte.ParamByName('SITPRO').AsString  := FieldByName('ITE_SITPRO_NOV').AsString;
              If fEmptyStr(qryGenIte.ParamByName('SITPRO').AsString) Then
                qryGenIte.ParamByName('SITPRO').Clear;
            End;

            qryGenIte.ParamByName('CODMON').AsString  := FieldByName('ITE_CODMON_NOV').AsString;
            If fEmptyStr(qryGenIte.ParamByName('CODMON').AsString) Then
              qryGenIte.ParamByName('CODMON').Clear;

            qryGenIte.ParamByName('CODFOR').AsString  := FieldByName('ITE_CODFOR_NOV').AsString;
            If fEmptyStr(qryGenIte.ParamByName('CODFOR').AsString) Then
              qryGenIte.ParamByName('CODFOR').Clear;

            qryGenIte.ParamByName('DIAFOR').AsInteger := FieldByName('ITE_DIAFOR_NOV').AsInteger;

            qryGenIte.ParamByName('REAEND').AsString  := FieldByName('ITE_REAEND_NOV').AsString;

            qryGenIte.ParamByName('OBRBAR').AsString  := FieldByName('ITE_OBRBAR_NOV').AsString;

            qryGenIte.ParamByName('FATCOM').AsString  := FieldByName('ITE_FATCOM_NOV').AsString;

            qryGenIte.ParamByName('PEFUTP').AsString  := FieldByName('ITE_PEFUTP_NOV').AsString;
            qryGenIte.ParamByName('PEEFUT').AsString  := FieldByName('ITE_PEEFUT_NOV').AsString;
            qryGenIte.ParamByName('PEFFPR').AsString  := FieldByName('ITE_PEFFPR_NOV').AsString;

            If Not fEmptyStr(FieldByName('ITE_CODDEP_NOV').AsString) Then
              qryGenIte.ParamByName('CODDEP').AsString  := FieldByName('ITE_CODDEP_NOV').AsString
            Else
              qryGenIte.ParamByName('CODDEP').Clear;

            If Not fEmptyStr(FieldByName('ITE_GRUCMP_NOV').AsString) Then
              qryGenIte.ParamByName('GRUCMP').AsString  := FieldByName('ITE_GRUCMP_NOV').AsString
            Else
              qryGenIte.ParamByName('GRUCMP').Clear;
            If Not fEmptyStr(FieldByName('ITE_CDCEST_NOV').AsString) Then
              qryGenIte.ParamByName('CDCEST').AsString  := FieldByName('ITE_CDCEST_NOV').AsString
            Else
              qryGenIte.ParamByName('CDCEST').Clear;

            If Not fEmptyStr(FieldByName('ITE_DESCND_NOV').AsString) Then
              qryGenIte.ParamByName('DESCND').AsString  := FieldByName('ITE_DESCND_NOV').AsString
            Else
              qryGenIte.ParamByName('DESCND').Clear;

            If Not fEmptyStr(FieldByName('ITE_NOVO_REAL').AsString) Then
              qryGenIte.ParamByName('APLICA').AsString  := FieldByName('ITE_NOVO_REAL').AsString
            Else
              qryGenIte.ParamByName('APLICA').Clear;

            If Not fEmptyStr(FieldByName('ITE_NOTESP_NOV').AsString) Then
              qryGenIte.ParamByName('NOTESP').AsString  := FieldByName('ITE_NOTESP_NOV').AsString
            Else
              qryGenIte.ParamByName('NOTESP').Clear;

            If Not fEmptyStr(FieldByName('ITE_PRDGRU_NOV').AsString) Then
              qryGenIte.ParamByName('PRDGRU').AsString  := FieldByName('ITE_PRDGRU_NOV').AsString
            Else
              qryGenIte.ParamByName('PRDGRU').Clear;

            qryGenIte.ParamByName('ATICOM').AsString  := FieldByName('ITE_ATICOM_NOV').AsString;
            qryGenIte.ParamByName('CODDIC').AsString  := FieldByName('ITE_CODDIC_NOV').AsString;
            If fEmptyStr(qryGenIte.ParamByName('CODDIC').AsString) Then
              qryGenIte.ParamByName('CODDIC').Clear;

            qryGenIte.ParamByName('IMPETI').AsString  := FieldByName('ITE_IMPETI_NOV').AsString;

            qryGenIte.ParamByName('CODITE').AsString  := FieldByName('ITE_CODITE').AsString;

            qryGenIte.ParamByName('DTAALT').AsDateTime := VS_Date;
            qryGenIte.ParamByName('HULALT').AsDateTime := fNow;
            qryGenIte.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
            qryGenIte.ParamByName('CODGRU').AsString   := FieldByName('ITE_CODGRU_NOV').AsString;
            qryGenIte.ParamByName('TIPFRE').AsString   := FieldByName('ITE_TIPFRE_NOV').AsString;
            qryGenIte.ParamByName('VLCFRE').AsString   := FieldByName('ITE_VLCFRE_NOV').AsString;

            qryGenIte.ParamByName('LARVID').AsFloat    := FieldByName('ITE_LARVID_NOV').AsFloat;
            qryGenIte.ParamByName('ALTVID').AsFloat    := FieldByName('ITE_ALTVID_NOV').AsFloat;
            qryGenIte.ParamByName('LAMAVI').AsFloat    := FieldByName('ITE_LAMAVI_NOV').AsFloat;
            qryGenIte.ParamByName('ALMAVI').AsFloat    := FieldByName('ITE_ALMAVI_NOV').AsFloat;
            qryGenIte.ParamByName('UTIAMP').AsString   := FieldByName('ITE_UTIAMP_NOV').AsString;
            qryGenIte.ParamByName('LOTEPD').AsString   := FieldByName('ITE_LOTEPD_NOV').AsString;
            qryGenIte.ParamByName('ORDSER').AsString   := FieldByName('ITE_ORDSER_NOV').AsString;
            qryGenIte.ParamByName('CLACRM').AsString   := FieldByName('ITE_CLACRM_NOV').AsString;

            If (fCfgSis('CLAONU', varBoolean)) Then
              If (FieldByName('ITE_CODONU_NOV').Value = Null) Then
                qryGenIte.ParamByName('CODONU').Value    := Null
              Else
                qryGenIte.ParamByName('CODONU').AsString := FieldByName('ITE_CODONU_NOV').AsString;

            if blnURapel then
              qryGenIte.ParamByName('PRAPEL').AsFloat  := FieldByName('ITE_PRAPEL_NOV').AsFloat;

            TAltDes.pSalvaLogCompara(FieldByName('ITE_CODITE').AsString,
                                     strLoginUsuarioLogado,
                                     FieldByName('ITE_DESITE').AsString,
                                     FieldByName('ITE_REFERE').AsString,
                                     FieldByName('ITE_CODUNI_NOV').AsString);

            qryGenIte.ExecSQL;
            qryGenIte.Close;

            fAtualizaBarFabIte(FieldByName('ITE_CODITE').AsString);

            {***********************************}
            {* GRAVA LOG DE LOCALIZAÇÃO FÍSICA *}
            {********************************PZ*}
            If (FieldByName('ITE_LOCFIS_NOV').AsString <> FieldByName('ITE_LOCFIS').AsString) Then
            Begin
              If (Not fGravaLogLocFisica(FieldByName('ITE_CODITE').AsString,
                                         FieldByName('ITE_LOCFIS').AsString,
                                         FieldByName('ITE_LOCFIS_NOV').AsString, 1)) Then
              Begin
                fRollBack;
                FreeAndNil(qryGenPre);
                FreeAndNil(qryGenIte);
                FreeAndNil(qryGenEmp);
                Exit;
              End;
            End;

            If (FieldByName('ITE_LOCSUP_NOV').AsString <> FieldByName('ITE_LOCSUP').AsString) Then
            Begin
              If (Not fGravaLogLocFisica(FieldByName('ITE_CODITE').AsString,
                                         FieldByName('ITE_LOCSUP').AsString,
                                         FieldByName('ITE_LOCSUP_NOV').AsString, 2)) Then
              Begin
                fRollBack;
                FreeAndNil(qryGenPre);
                FreeAndNil(qryGenIte);
                FreeAndNil(qryGenEmp);
                Exit;
              End;
            End;


            {*****************************************}
            {* GRAVA PREALT                          *}
            {**************************************AF*}
            strLocalErro := '[fGravaPreAlt]';
            fGravaPreAlt(FieldByName('ITE_CODITE').AsString,
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

                         'ALTERACAO DE PRECOS INDIVIDUAL');

            pAtualizaItensGrupoPrecos(FieldByName('ITE_CODITE').AsString,
                                      'ALTERACAO DE PRECOS INDIVIDUAL');


            if blnIteTbp Then
            Begin
              For intCorre := 1 To Length(VS_strTabPrc) Do
              Begin
                For strEmpFilial In stlEmpFilial Do
                Begin
                qryIteTbp.Close;
                qryIteTbp.SQL.Clear;
                qryIteTbp.SQL.Add( 'SELECT COUNT(0) AS QTDREG   ' );
                qryIteTbp.SQL.Add( 'FROM ITETBP                 ' );
                qryIteTbp.SQL.Add( 'WHERE ITE_CODITE = :CODITE  ' );
                qryIteTbp.SQL.Add( '  AND ITE_CODEMP = :CODEMP  ' );
                qryIteTbp.SQL.Add( '  AND ITE_TABPRE = :TABPRE  ' );

                pSetParametrosIteTbp(intToStr(intCorre),0,0,0,strEmpFilial);

                qryIteTbp.Open;

                intTbpAux := qryIteTbp.FieldByName('QTDREG').AsInteger;

                qryIteTbp.Close;
                qryIteTbp.SQL.Clear;
                qryIteTbp.SQL.Add( IIF(intTbpAux > 0, strUptTbp, strInsTbp) );

                pSetParametrosIteTbp(intToStr(intCorre),
                                     FieldByName('ITE_DESMA' + intToStr(intCorre) + '_NOV').AsFloat,
                                     FieldByName('ITE_DESMG' + intToStr(intCorre) + '_NOV').AsFloat,
                                     FieldByName('ITE_DESMS' + intToStr(intCorre) + '_NOV').AsFloat,
                                     strEmpFilial);

                qryIteTbp.ExecSQL;
                qryIteTbp.Close;
                End;
              End;



            End;

            Next;
          //  pgbStatus.StepBy(1);

            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;
          End;

         // pgbStatus.Visible := False;
        End
        Else
        Begin

          fMensagem('','Não há dados para serem alterados!',['&OK']);
          Result := False;
          Exit;

        End;

        Close;
      End;
    End
    Else
    Begin
      {************************************}
      {* FAZ A GRAVAÇÃO EM PREITE PARA Q, *}
      {* NA DATA ESPECIFICADA, OS PREÇOS  *}
      {* SEJAM ALTERADOS NA TABELA ITEGER *}
      {*********************************ER*}

      With qryGenPre Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        pgbProgresso.Position       := 0;
        pgbProgresso.Properties.Max := RecordCount;
        Application.ProcessMessages;

        If Not IsEmpty Then
        Begin
         // pgbStatus.Visible := True;
         // pgbStatus.Max     := RecordCount;

          strProPri := fRetSequencial('PROPRI', VS_strCodEmp);

          While Not Eof Do
          Begin
            strLocalErro    := '';

            pIncluiPreIte(qryGenIte, qryGenPre, frmAltPrecoDigData.dtaData,
                                    'ALTERACAO DE PRECOS INDIVIDUAL', strProPri);

            If (FieldByName('ITE_CODABF_NOV').AsString <> FieldByName('ITE_CODABF').AsString) Then
            Begin
              If (fCfgSIs('TIPABF') = '2') Then
                UpdateIteger('ITE_CODABF', qryGenPre)
              Else
                pUpdateAbrvFiscalCadIte(FieldByName('ITE_CODABF_NOV').AsString, FieldByName('ITE_CODITE').AsString);

              If fCfgSis('CLPVDI', varBoolean) Then
                pAtualizaPermiteFazerVenda(FieldByName('ITE_CODITE').AsString, VS_strCodEmp, 'N');
            End;

            Next;
         //   pgbStatus.StepBy(1);

            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;
          End;

          pgbStatus.Visible := False;
        End
        Else
        Begin

          fMensagem('','Não há dados para serem alterados!',['&OK']);
          Result := False;
          Exit;

        End;

        Close;
      End;
    End;

    Result := True;

    fCommit;
  Except on E: Exception do
  Begin
    pMensagensErro(E.Message, strLocalErro);
    Result := False;

    fRollBack;
  End;
  End;

  Finally
  FreeAndNil(qryGenPre);
  FreeAndNil(qryGenIte);
  FreeAndNil(qryGenEmp);
  FreeAndNil(qryIteTbp);
  FreeAndNil(stlEmpFilial);
End;
End;

procedure TfrmAltPrecoIndividual.pMostraColunasAntigas(blnHabilita: Boolean);
  Var
    intContador : Integer;
    intContador2: Integer;
Begin
  dbgTiposAlt.ReadOnly := blnHabilita;

  If qryGen.Active And (Not qryGen.IsEmpty) Then
    qryGen.First;

  If Not blnHabilita Then
  Begin

    For intContador := 0 To dbgTiposAlt.Columns.Count -1 Do
    Begin
      {******************************************}
      {* TIRA A PALAVRA NOVO DO COMEÇO DO CAMPO *}
      {***************************************AF*}
      If Pos('Novo',dbgTiposAlt.Columns.Items[intContador].Title.Caption) > 0 Then
        dbgTiposAlt.Columns.Items[intContador].Title.Caption := Trim(AnsiReplaceStr(dbgTiposAlt.Columns.Items[intContador].Title.Caption,'Novo',''));
      {******************************************}
      {* TIRA A PALAVRA NOVA DO COMEÇO DO CAMPO *}
      {***************************************RV*}
      If Pos('Nova',dbgTiposAlt.Columns.Items[intContador].Title.Caption) > 0 Then
        dbgTiposAlt.Columns.Items[intContador].Title.Caption := Trim(AnsiReplaceStr(dbgTiposAlt.Columns.Items[intContador].Title.Caption,'Nova',''));

      {************************************}
      {* NAO MOSTRA OS CAMPOS ORIGINAIS   *}
      {*********************************AF*}
      If (Pos('NOV',dbgTiposAlt.Columns.Items[intContador].FieldName) > 0) And
         (Pos('ITE_PRELIQ',dbgTiposAlt.Columns.Items[intContador].FieldName) = 0) Then
        dbgTiposAlt.Columns.Items[intContador].Visible := True
      Else
      Begin

        If Pos(dbgTiposAlt.Columns.Items[intContador].FieldName,
            'ITE_CODITE_ITE_PRELIQ_ITE_DESITE_ITE_REFERE_ITE_SALDOS__ITE_DTAALT_ITE_PREMED_' +
             'ITE_PR1ANT_ITE_PR2ANT_ITE_PR3ANT_ITE_PR4ANT_ITE_PR5ANT_ITE_PR6ANT_ITE_PR7ANT') > 0 Then
          dbgTiposAlt.Columns.Items[intContador].Visible := True
        Else
          dbgTiposAlt.Columns.Items[intContador].Visible := False;

      End;
    End;

   // pRestauraPosicaoUsuario;
  End
  Else
  Begin

    For intContador := 0 To dbgTiposAlt.Columns.Count -1 Do
    Begin

      {******************************************}
      {* COLOCA A PALAVRA NOVO NOS CAMPOS NOVOS *}
      {***************************************AF*}
      If (Pos('NOV',dbgTiposAlt.Columns.Items[intContador].FieldName) > 0) And (Pos('Novo',dbgTiposAlt.Columns.Items[intContador].Title.Caption) <= 0) Then
        dbgTiposAlt.Columns.Items[intContador].Title.Caption := 'Novo ' + dbgTiposAlt.Columns.Items[intContador].Title.Caption;

      If ( Pos('ITE_QTPPRO', dbgTiposAlt.Columns.Items[intContador].FieldName) > 0 ) And (Pos(fCfgSis('TCOPRO'), '3_4_' ) <= 0) Then
      Begin
        dbgTiposAlt.Columns.Items[intContador].Visible := False;
        Continue;
      End;

      {****************************************}
      {* MOSTRA OS CAMPOS QUE FORAM ALTERADOS *}
      {*************************************AF*}
      If (Pos('NOV',dbgTiposAlt.Columns.Items[intContador].FieldName) > 0) Then
      Begin

        For intContador2 := 0 To Length(colColunas)-1 Do
        Begin

          If dbgTiposAlt.Columns.Items[intContador].FieldName = colColunas[intContador2].strNomCam Then
          Begin
            dbgTiposAlt.Columns.Items[intContador].Visible := colColunas[intContador2].blnHabili;
            Continue;
          End;

        End;

      End
      Else
      Begin
        dbgTiposAlt.Columns.Items[intContador].Visible := True;
      End;
    End;
  End;
End;

{**************************}
{* MOSTRA COLUNAS OCULTAS *}
{***********************AF*}
procedure TfrmAltPrecoIndividual.pMostraColunasAntigasCx(blnHabilita: Boolean);
  Var
    intContador : Integer;
    intContador2: Integer;
Begin
  cxvTiposAlt.OptionsData.Editing := blnHabilita;

  If qryGen.Active And (Not qryGen.IsEmpty) Then
    qryGen.First;

  If Not blnHabilita Then
  Begin

    For intContador := Low(arrCampos) To High(arrCampos) Do
    Begin
      {******************************************}
      {* TIRA A PALAVRA NOVO DO COMEÇO DO CAMPO *}
      {***************************************AF*}
      If Pos('Novo', arrCampos[intContador].Title) > 0 Then
        arrCampos[intContador].Title := Trim(AnsiReplaceStr(arrCampos[intContador].Title, 'Novo',''));

      {************************************}
      {* NAO MOSTRA OS CAMPOS ORIGINAIS   *}
      {*********************************AF*}
      If (Pos('NOV', arrCampos[intContador].FieldName) > 0) And
         (Pos('ITE_PRELIQ', arrCampos[intContador].FieldName) = 0) Then
        arrCampos[intContador].Visible := True
      Else
      Begin

        If Pos(arrCampos[intContador].FieldName,
            'ITE_CODITE_ITE_PRELIQ_ITE_DESITE_ITE_REFERE_ITE_SALDOS__ITE_DTAALT_ITE_PREMED_' +
             'ITE_PR1ANT_ITE_PR2ANT_ITE_PR3ANT_ITE_PR4ANT_ITE_PR5ANT_ITE_PR6ANT_ITE_PR7ANT') > 0 Then
          arrCampos[intContador].Visible := True
        Else
          arrCampos[intContador].Visible := False;

      End;

    End;

   // pRestauraPosicaoUsuario;
  End
  Else
  Begin

    For intContador := Low(arrCampos) To High(arrCampos) Do
    Begin

      {******************************************}
      {* COLOCA A PALAVRA NOVO NOS CAMPOS NOVOS *}
      {***************************************AF*}
      If (Pos('NOV', arrCampos[intContador].FieldName) > 0) And (Pos('Novo', arrCampos[intContador].Title) <= 0) Then
        arrCampos[intContador].Title := 'Novo ' + arrCampos[intContador].Title;

      If ( Pos('ITE_QTPPRO', arrCampos[intContador].FieldName) > 0 ) And (Pos(strTCOPRO, '3_4_' ) <= 0) Then
      Begin
        arrCampos[intContador].Visible := False;
        Continue;
      End;

      {****************************************}
      {* MOSTRA OS CAMPOS QUE FORAM ALTERADOS *}
      {*************************************AF*}
      If (Pos('NOV', arrCampos[intContador].FieldName) > 0) Then
      Begin

        For intContador2 := 0 To Length(colColunas)-1 Do
        Begin

          If arrCampos[intContador].FieldName = colColunas[intContador2].strNomCam Then
          Begin
            arrCampos[intContador].Visible := colColunas[intContador2].blnHabili;
            Continue;
          End;

        End;

      End
      Else
      Begin
        arrCampos[intContador].Visible := True;
      End;
    End;

  End;
End;

procedure TfrmAltPrecoIndividual.btnSairClick(Sender: TObject);
begin

  If qryGen.State = dsEdit Then
  Begin
    qryGen.Cancel;
  End
  Else
  Begin

    If (pnlCabecalho.Visible) And (Not pnlCabecalho.Enabled) Then
    Begin

      If fMensagem('','Cancela registros?',['&Sim','&Não'],2) = 1 Then
      Begin
        dbgTiposAlt.OnExit  := Nil;
        qryGen.BeforeScroll := Nil;
        pDeletaTemporaria;
        fFecharTabela(qryGen);
        pnlCabecalho.Enabled := True;
      //  pLimpaCampos;
        dbgTiposAlt.Enabled := False;
        pnlFiltros.Visible  := True;
        pnlFiltro2.Visible  := True;
        pnlBusca.Visible    := False;
        btnExcel.Visible    := False;

        If blnBloPre Then
        Begin

          If rdgTipAlt.Controls[1].Enabled Then
            rdgTipAlt.ItemIndex := 1

        End Else
        Begin

          If rdgTipAlt.Controls[0].Enabled Then
            rdgTipAlt.ItemIndex := 0;

        End;

        chkArrMai.Checked   := False;
        pSetFocus(mskLinGru);

        btnMarcar.Visible    := True;
        btnDesmarcar.Visible := True;
        btnEstLoj.Visible    := False;
      End;

    End
    Else If (pnlCabecalho.Visible) And (pnlCabecalho.Enabled) Then
    Begin
      inherited;
    End
    Else
    Begin
      pnlCabecalho.Visible := True;
      pMostraColunasAntigas(False);
      pMostraColunasAntigasCx(False);
      pAtualizaTemporaria(False,'');
      fMontaGrid;
    End;

  End;

end;

procedure TfrmAltPrecoIndividual.cbxMarIdeChange(Sender: TObject);
begin
  inherited;

  pHabilitaCamposMargemIdeal;
end;

function TfrmAltPrecoIndividual.fRetDesAbfPisCofIpi(strTabela, strCod: String): String;
  Var
    qryAbf: TUniQuery;
begin
  qryAbf := fCriaQuery(Self);
  qryAbf.SQL.Add('SELECT APC_DESCRI FROM ' + strTabela +  ' WHERE APC_CODAPC = :CODAPC');
  qryAbf.ParamByName('CODAPC').AsString := strCod;
  qryAbf.Open;

  Result := qryAbf.FieldByName('APC_DESCRI').AsString;

  FreeAndNil(qryAbf);
end;

Function TfrmAltPrecoIndividual.fRetDescricaoCadastro(strNomCam, strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;
Begin
  Result  := '';
  blnErro := False;

  If fEmptyStr(strCodCad) Then
    Exit;

  If AnsiEndsStr('_NOV', strNomCam) Then
    strNomCam := AnsiReplaceStr(strNomCam, '_NOV', '');

  If SameText(strNomCam, 'ITE_CODFOR') Then
  Begin
    Result := fRetNomFornecedor(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODGPR') Then
  Begin
    Result := fRetNomeGrupoPrecos(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_PRDGRU') Then
  Begin
    Result := fRetNomeGrupoProduto(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODABF') Then
  Begin
    Result := fRetDesAbfIcm(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_ABFPIS') Then
  Begin
    Result := fRetDesAbfPisCofIpi('PISSAI', strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_ABFCOF') Then
  Begin
    Result := fRetDesAbfPisCofIpi('COFSAI', strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_ABFIPI') Then
  Begin
    Result := fRetDesAbfPisCofIpi('IPISAI', strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODMAR') Then
  Begin
    Result := fRetNomMarca(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODMON') Then
  Begin
    Result := fRetNomMontadora(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODUNI') Then
  Begin
    Result := fRetNomUnidade(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_UNICOM') Then
  Begin
    Result := fRetNomUnidade(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_UNITRI') Then
  Begin
    Result := fRetNomUnidade(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODGRU') Then
  Begin

    If blnValidar And (RightStr(strCodCad, 3) = '000') Then
    Begin
      pMensagemOk('Linha não permitida!');
      Exit;
    End;

    If blnValidar Then
      Result := fRetNomeLinhaGrupo(strCodCad)
    Else
      Result := fRetNomeSoGrupo(strCodCad);

  End

  Else If SameText(strNomCam, 'ITE_CODDEP') Then
  Begin
    Result := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'], [strCodCad]);
  End

  Else If SameText(strNomCam, 'ITE_GRUCMP') Then
  Begin
    Result := fRetDescGrupoCompra(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODONU') Then
  Begin
    Result := fRetDescClassificacaoOnu(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODDIC') Then
  Begin
    Result := fRetDesDic(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CODLSE') Then
  Begin
    Result := fRetLocSep(strCodCad);
  End

  Else If SameText(strNomCam, 'ITE_CDCEST') Then
  Begin
    Result := fCampoTabela('CES_DESCRI','CDCEST',['CES_CDCEST'], [strCodCad]);
  End

  Else If SameText(strNomCam, 'ITE_SITPRO') Then
  Begin
    Result := fRetNomSituacaoProduto(strCodCad);
  End;

  If blnValidar And fEmptyStr(Result) Then
  Begin
    pMensagemOk('Código não encontrado!');
    blnErro := True;
  End;
End;

procedure TfrmAltPrecoIndividual.cxeConsTam2PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    strCodigo: String;
begin
  inherited;

  If Not Assigned(cxvTiposAlt.Controller.FocusedColumn) Then
    Exit;

  strCodigo := DisplayValue;

  If (Not fEmptyStr(strCodigo)) And (TcxTextEdit(Sender).Properties.MaxLength > 0) Then
    DisplayValue := fStrZero(strCodigo, TcxTextEdit(Sender).Properties.MaxLength);

  fRetDescricaoCadastro(TcxGridDBBandedColumn(cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName, DisplayValue, True, Error);

  If Error Then
    ErrorText := '';
end;

procedure TfrmAltPrecoIndividual.cxeFatComPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  {*****************************************************}
  {*   Caso não esteja configura para o uso  do        *}
  {*   "Fator de conversão madeira de M3 para Peças"   *}
  {*   Limpa o valor de Key                            *}
  {*****************************************************}
  if not fMostrarFatorConversaoMadeira(qryGen.FieldByName('ITE_CODITE').AsString) Then
  Begin
    Error := True;

    ErrorText := '';

    pMensagemOk('Para poder editar este valor é necessário marcar o parâmetro em Configurações da Empresa "Utilizar rotinas de venda de madeira? = SIM" ' +
                'e no Cadastro de Unidade relacionado ao Produto tem que estar checado o parâmetro "Permite informar metragem no faturamento".');
  End;

end;

procedure TfrmAltPrecoIndividual.cxgTiposAltEnter(Sender: TObject);
begin
  inherited;

  pnlCabecalho.Enabled := False;
end;

procedure TfrmAltPrecoIndividual.cxgTiposAltExit(Sender: TObject);
begin
  inherited;

  If qryGen.State = dsEdit Then
    qryGen.Post;

  pBeforeScroll(dtsGen.DataSet);
end;

procedure TfrmAltPrecoIndividual.cxvTiposAltCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Not pnlCabecalho.Visible Then
  Begin

    If Pos('nov', LowerCase(TcxGridDBBandedColumn(AViewInfo.Item).DataBinding.FieldName)) > 0 Then
    Begin
      ACanvas.Brush.Color := clSilver;
    End;

  End

end;

procedure TfrmAltPrecoIndividual.cxvTiposAltEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  Var
    qryDados: TUniQuery;
    arrSelecao: TConsultasArray;
    strNomCam: String;

  Procedure pSalva(strDado: String);
  Begin
    Key := #0;
    AEdit.EditValue := strDado;
    AEdit.PostEditValue;
    Key := #0;

    Keybd_Event(VK_RETURN, 0, 0, 0);
  End;

begin
  inherited;

  strNomCam := TcxGridDBBandedColumn(AItem).DataBinding.FieldName;

  If AnsiEndsStr('_NOV', strNomCam) Then
    strNomCam := AnsiReplaceStr(strNomCam, '_NOV', '');

  If blnVidroInteiro And
     (Pos(strNomCam, 'ITE_LARVID_ITE_ALTVID_ITE_LAMAVI_ITE_ALMAVI') > 0) And
     CharInSet(Key, [',','.','-']) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fEntraCons(Key) Then
  Begin

    With cxvTiposAlt.DataController.DataSource.DataSet Do
    If fTemConsultaTabela(strNomCam) Then
    Begin

      qryDados := fCriaQuery;

      If SameText(strNomCam, 'ITE_CODFOR') And
         fPesqFornecedor(conForSimples, Self, Nil, Nil, qryDados, Key, arrSelecao, True) And
         (Not fEmptyStr(qryDados.FieldByName('FOR_CODFOR').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('FOR_CODFOR').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODGPR') And
              fPesqGrupoPrecos(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('GPR_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('GPR_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_PRDGRU') And
              fPesqGrupoProduto(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('PRD_CODGRU').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('PRD_CODGRU').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODABF') And
              fPesqAbrevFiscal(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('ABF_CODABF').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('ABF_CODABF').AsString);

      End

      Else If SameText(strNomCam, 'ITE_ABFPIS') And
              fPesqPISSAI(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

      End

      Else If SameText(strNomCam, 'ITE_ABFCOF') And
              fPesqCOFSAI(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

      End


      Else If SameText(strNomCam, 'ITE_ABFIPI') And
              fPesqIPISAI(Self, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODMAR') And
              fPesqMarcas(Self, Nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('MAR_CODMAR').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('MAR_CODMAR').AsString);

      End

      Else If SameText(strNomCam, 'ITE_SITPRO') And
              fPesqSituacaoProduto(Self, Nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('SIT_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('SIT_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODMON') And
              fPesqMontadora(Self, Nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('MON_CODMON').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('MON_CODMON').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODUNI') And
              fPesqUnidade(Self, Nil, nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

      End

      Else If SameText(strNomCam, 'ITE_UNICOM') And
              fPesqUnidade(Self, Nil, nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

      End

      Else If SameText(strNomCam, 'ITE_UNITRI') And
              fPesqUnidade(Self, Nil, nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODGRU') And
              fPesqGrupo(Self, Nil, nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('GRU_CODGRU').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('GRU_CODGRU').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODDEP') And
              fPesqDepartamento(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('DEP_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('DEP_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_GRUCMP') And
              fPesqGrupoCompra(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('GRU_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('GRU_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODONU') And
              fPesqClassificacaoOnu(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('ONU_CODONU').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('ONU_CODONU').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODDIC') And
              fPesqDic(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('DIC_CODDIC').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('DIC_CODDIC').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CODLSE') And
              fPesqLocSep(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('LSE_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('LSE_CODIGO').AsString);

      End

      Else If SameText(strNomCam, 'ITE_CDCEST') And
              fPesqCest(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('CES_CDCEST').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('CES_CDCEST').AsString);

      End

      Else If SameText(strNomCam, 'ITE_SITPRO') And
              fPesqSituacaoProduto(Self, Nil, Nil, qryDados, Key, arrSelecao) And
              (Not fEmptyStr(qryDados.FieldByName('SIT_CODIGO').AsString)) Then
      Begin

        pSalva(qryDados.FieldByName('CES_CDCEST').AsString);

      End;

      FreeAndNil(qryDados);
    End;

  End;

end;

function TfrmAltPrecoIndividual.fTemConsultaTabela(strNomCam: String): Boolean;
Begin
  If AnsiEndsStr('_NOV', strNomCam) Then
    strNomCam := AnsiReplaceStr(strNomCam, '_NOV', '');

  Result := Pos(strNomCam, 'ITE_CODFOR_ITE_CODGPR_ITE_PRDGRU_ITE_CODABF_ITE_ABFPIS_ITE_ABFCOF_ITE_ABFIPI_' +
                           'ITE_CODMAR_ITE_NOMCAM_ITE_CODMON_ITE_CODUNI_ITE_UNICOM_ITE_UNITRI_ITE_CODGRU_' +
                           'ITE_CODDEP_ITE_GRUCMP_ITE_CODONU_ITE_CODDIC_ITE_CODLSE_ITE_CDCEST_ITE_SITPRO') > 0;
End;

function TfrmAltPrecoIndividual.fQtdRegistrosSelecionados: Integer;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' ' + strTabela + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ALTERA = "S" ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := FieldByName('QTD').AsInteger;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function TfrmAltPrecoIndividual.fMontaGrid: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    With frmGravando Do
    Begin
      fExecutarAcao := fMontaGridAux;
      lblGravando.Caption := 'Aguarde, selecionando itens...';
      ShowModal;
      Result := blnConfirma;

      If Result then
       pSetFocus(dbgTiposAlt);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.fMontaGrid]');
      Result := False;
    End;
  End;

  FreeAndNil(frmGravando);
End;

Function TfrmAltPrecoIndividual.fGetMaxWidhProper(proProperties: TcxCustomEditProperties): Integer;
  Var
    intContador: Integer;
Begin
  Result := 0;

  If Not Assigned(proProperties) Then
    Exit;

  If proProperties.ClassType = TcxLookupComboBoxProperties Then
  Begin

    With TcxLookupComboBoxProperties(proProperties).ListSource.DataSet Do
    Begin
      First;

      While Not Eof Do
      Begin

        If Self.Canvas.TextWidth(FieldByName('DESCAM').AsString) > Result Then
          Result := Self.Canvas.TextWidth(FieldByName('DESCAM').AsString);

        Next;
      End;

    End;

  End

  Else If proProperties.ClassType = TcxComboBoxProperties Then
  Begin

    For intContador := 0 To TcxComboBoxProperties(proProperties).Items.Count - 1 Do
      If Self.Canvas.TextWidth(TcxComboBoxProperties(proProperties).Items[intContador]) > Result Then
        Result := Self.Canvas.TextWidth(TcxComboBoxProperties(proProperties).Items[intContador]);

  End;

  If Result > 0 Then
    Inc(Result, 10);
End;

procedure TfrmAltPrecoIndividual.pAdicionaColuna(strTitulo: String; intIndice: Integer; blnVisible: Boolean = True);
  Var
    cxItem: TcxCustomGridTableItem;
    intMax: Integer;
Begin
  cxItem := cxvTiposAlt.FindItemByName(arrCampos[intIndice].FieldName);

  If Not Assigned(cxItem) Then
  Begin
    cxItem         := cxvTiposAlt.DataController.CreateItemByField(qryGen.FieldByName(arrCampos[intIndice].FieldName));
    cxItem.Name    := arrCampos[intIndice].FieldName;
    cxItem.Caption := strTitulo;

    If Assigned(arrCampos[intIndice].Properties) Then
    Begin
      cxItem.PropertiesClassName := arrCampos[intIndice].Properties.ClassName;
      cxItem.Properties := arrCampos[intIndice].Properties;
    End;

    If strTCOPRO = '4' Then
    Begin
      If SameText(arrCampos[intIndice].FieldName, 'ITE_QTPPRO') Then
        cxItem.Caption := 'Pontos por Valor';

      If SameText(arrCampos[intIndice].FieldName, 'ITE_QTPPRO_NOV') Then
        cxItem.Caption := 'Novo Pontos por Valor';
    End;

    If SameText(arrCampos[intIndice].FieldName, 'ITE_ALTVID') Then
      cxItem.Caption := fRetornaInfMedVIDRO

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_ALTVID_NOV') Then
      cxItem.Caption := 'Novo ' + fRetornaInfMedVIDRO

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_ALMAVI') Then
      cxItem.Caption :=  fRetornaInfMedVIDRO(False,False,True,False)

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_ALMAVI_NOV') Then
      cxItem.Caption := 'Novo ' + fRetornaInfMedVIDRO(False,False,True,False)

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_OUTVAL') Then
      cxItem.Caption := chkOutVal.Caption

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_OUTVAL_NOV') Then
      cxItem.Caption := 'Novo ' + chkOutVal.Caption

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_DESADB') Then
    Begin
      cxItem.Caption := chkDesAdb.Caption;
      TcxGridDBBandedColumn(cxItem).Width := 163;
    End

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_DESADB_NOV') Then
    Begin
      cxItem.Caption := 'Novo ' + chkDesAdb.Caption;
      TcxGridDBBandedColumn(cxItem).Width := 163 + 40;
    End;

    If Pos('ITE_APLICA', arrCampos[intIndice].FieldName) > 0 Then
      TcxGridDBBandedColumn(cxItem).Width := 352

    Else If arrCampos[intIndice].FieldName = 'ITE_DESITE' Then
      TcxGridDBBandedColumn(cxItem).Width := 296
    Else
      TcxGridDBBandedColumn(cxItem).Width := Self.Canvas.TextWidth(strTitulo) + 10;

    intMax := fGetMaxWidhProper(cxItem.Properties);

    If intMax > TcxGridDBBandedColumn(cxItem).Width Then
      TcxGridDBBandedColumn(cxItem).Width := intMax;

    cxItem.Options.Editing := Not arrCampos[intIndice].ReadOnly;

    If Pos(arrCampos[intIndice].FieldName, 'ITE_CODITE-ITE_DESITE') = 0 Then
      TcxGridDBBandedColumn(cxItem).Position.BandIndex := 1;

    cxvTiposAlt.Bands[TcxGridDBBandedColumn(cxItem).Position.BandIndex].Width :=
      cxvTiposAlt.Bands[TcxGridDBBandedColumn(cxItem).Position.BandIndex].Width +  TcxGridDBBandedColumn(cxItem).Width;
  End;

  cxItem.Visible := blnVisible;

  If SameText('ITE_DESITE', arrCampos[intIndice].FieldName) Then
    TcxGridDBColumn(cxItem).SortOrder := soAscending;
End;

function TfrmAltPrecoIndividual.fMontaGridAux(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intContador : Integer;
    strNomCam   : String;
begin
  pgbProgresso.Properties.Max := 0;
  pgbProgresso.Position       := 0;
  Application.ProcessMessages;

  intCustoVenda := rdgTipAlt.ItemIndex;

  pCriaTemporaria;

  For intContador := 0 To Length(colColunas) -1 Do
  Begin
    colColunas[intContador].blnHabili := False;
  End;

  Result := True;

  pgbProgresso.Position       := 0;
  pgbProgresso.Properties.Max := dbgTiposAlt.Columns.Count + 1;
  Application.ProcessMessages;

  //*************************************************//
  // EFETUA UM CONTADOR NO GRID E FAZ A VERIFICACAO  //
  // SE O CHECKBOX CORRESPONDENTE ESTA MARCADO OU    //
  // OU NAO, HABILITANDO OU NAO A COLUNA ATUAL       //
  //**********************************************ED*//
  For intContador := 0 To dbgTiposAlt.Columns.Count-1 Do
  Begin

    //*************************************************//
    // CARREGA NA VARIAVEL O NOME DO CAMPO. EX.:       //
    // ITE_CODITE = CODITE                             //
    //**********************************************ED*//
    Try
      strNomCam := Copy(dbgTiposAlt.Columns[intContador].FieldName, 5, 6);

      If Not( fEmptyStr(strNomCam) ) Then
      Begin

        If blnIteTbp and SameText( Copy(strNomCam,1, 5), 'DESMA') then
        Begin
          strNomCam := 'DESMAX';
        End
        Else
        If blnIteTbp and SameText( Copy(strNomCam,1, 5), 'DESMG') Then
        Begin
          strNomCam := 'DESMGE';
        End;
        If blnIteTbp and SameText( Copy(strNomCam,1, 5), 'DESMS') Then
        Begin
          strNomCam := 'DESMSU';
        End;

        If (TCheckBox(fComponentByName(pnlFiltros, 'chk' + strNomCam)) <> Nil) Then
        Begin
          If Not( TCheckBox(fComponentByName(pnlFiltros, 'chk' + strNomCam) ).Checked ) Then
          Begin
            dbgTiposAlt.Columns[intContador].Visible := False
          End Else
          Begin
            If (intContador < 14) Or ((intContador >= 14) And
                                      (RightStr(dbgTiposAlt.Columns[intContador].FieldName, 4) = '_NOV') And
                                      (Not SameText(strNomCam, 'PRELIQ'))) Then
              dbgTiposAlt.Columns[intContador].Visible := True;
          End;
        End
        else If (TCheckBox(fComponentByName(pnlFiltro2, 'chk' + strNomCam)) <> Nil) Then
        Begin
          If Not( TCheckBox(fComponentByName(pnlFiltro2, 'chk' + strNomCam) ).Checked ) Then
            dbgTiposAlt.Columns[intContador].Visible := False
          Else
          Begin
            If (intContador < 14) Or ((intContador >= 14) And
                                      (RightStr(dbgTiposAlt.Columns[intContador].FieldName, 4) = '_NOV') And
                                      (Not SameText(strNomCam, 'PRELIQ'))) Then
              dbgTiposAlt.Columns[intContador].Visible := True;
          End;
        End;

      End;
    Except
      Result := False;
    End;

    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;


  pgbProgresso.Position       := 0;
  pgbProgresso.Properties.Max := qryGen.Fields.Count + 1;
  Application.ProcessMessages;


  For intContador := Low(arrCampos) To High(arrCampos) Do
  Begin

    //*************************************************//
    // CARREGA NA VARIAVEL O NOME DO CAMPO. EX.:       //
    // ITE_CODITE = CODITE                             //
    //**********************************************ED*//
    Try
      strNomCam := Copy(arrCampos[intContador].FieldName, 5, 6);

      If Not( fEmptyStr(strNomCam) ) Then
      Begin

        If blnIteTbp and SameText( Copy(strNomCam,1, 5), 'DESMA') then
        Begin
          strNomCam := 'DESMAX';
        End
        Else
        If blnIteTbp and SameText( Copy(strNomCam,1, 5), 'DESMG') Then
        Begin
          strNomCam := 'DESMGE';
        End;
        If blnIteTbp and SameText( Copy(strNomCam,1, 5), 'DESMS') Then
        Begin
          strNomCam := 'DESMSU';
        End;

        If (TCheckBox(fComponentByName(pnlFiltros, 'chk' + strNomCam)) <> Nil) Then
        Begin
          If Not( TCheckBox(fComponentByName(pnlFiltros, 'chk' + strNomCam) ).Checked ) Then
          Begin
            arrCampos[intContador].Visible := False
          End Else
          Begin
            If (intContador < 14) Or ((intContador >= 14) And
                                      (RightStr(arrCampos[intContador].FieldName, 4) = '_NOV') And
                                      (Not SameText(strNomCam, 'PRELIQ'))) Then
              arrCampos[intContador].Visible := True;
          End;
        End
        else If (TCheckBox(fComponentByName(pnlFiltro2, 'chk' + strNomCam)) <> Nil) Then
        Begin
          If Not( TCheckBox(fComponentByName(pnlFiltro2, 'chk' + strNomCam) ).Checked ) Then
            arrCampos[intContador].Visible := False
          Else
          Begin
            If (intContador < 14) Or ((intContador >= 14) And
                                      (RightStr(arrCampos[intContador].FieldName, 4) = '_NOV') And
                                      (Not SameText(strNomCam, 'PRELIQ'))) Then
              arrCampos[intContador].Visible := True;
          End;
        End;

      End;
    Except
      Result := False;
    End;

    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  //*************************************************//
  // VERIFICA QUAL TIPO DE ALTERACAO SERA UTILIZADA  //
  //**********************************************ED*//
  If rdgTipAlt.ItemIndex <= -1 Then
  Begin
    fMensagem('','É necessário selecionar o tipo de alteração de preço!',['&OK']);
    Exit;
  End;

  pMontaGridAlterados(True);

  cxvTiposAlt.DataController.DataSource := dtsGen;

  dbgTiposAlt.Enabled := True;
//  pSetFocus(dbgTiposAlt);
end;

Procedure TfrmAltPrecoIndividual.pMontaGridAlterados(blnAltera: Boolean);
  var
    frmGravando: TfrmGravando;
Begin
  FAltera := blnAltera;

  TfrmGravando.fExecuta(fMontaGridAlterados, frmGravando, 'Montando dados para alteração, aguarde...');
End;

Function TfrmAltPrecoIndividual.fMontaGridAlterados(cxProgresso: TcxProgressBar): Boolean;
  Var
    intContador : Integer;
Begin
  qryGen.DisableControls;

  cxvTiposAlt.DataController.DataSource := Nil;

  cxProgresso.Properties.Max := Length(arrCampos);

  cxvTiposAlt.BeginUpdate;

  cxvTiposAlt.ClearItems;
  cxvTiposAlt.Bands[0].Width := 0;
  cxvTiposAlt.Bands[1].Width := 0;

  For intContador := Low(arrCampos) To High(arrCampos) Do
  Begin
    If arrCampos[intContador].Visible Then
      pAdicionaColuna(IIF(FAltera, Trim(AnsiReplaceStr(arrCampos[intContador].Title, 'Novo', '')), arrCampos[intContador].Title),
                      intContador);

    cxProgresso.Position := cxProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  cxvTiposAlt.DataController.DataSource := dtsGen;

  cxvTiposAlt.OptionsData.Editing := FAltera;

  cxvTiposAlt.EndUpdate;

  qryGen.EnableControls;

  Result := True;
End;

procedure TfrmAltPrecoIndividual.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirmaAlt.Click;
  End
  Else If (Key = VK_Return) And (Assigned(ActiveControl)) And (ActiveControl.Name = 'chkNotEsp') Then
  Begin
    btnProPag.Click;
    pSetFocus(pnlFiltro2);
  End
  Else If (Key = VK_Return) And (Assigned(ActiveControl)) And (ActiveControl.Name = '') And pnlFiltros.Visible Then
  Begin
    pSetFocus(chkArrMai);
  End
  Else If (Key = VK_Escape) And (Assigned(ActiveControl)) And (ActiveControl.Name = '') Then
  Begin
    btnSair.Click;
  End
  Else If Key = VK_F2 Then
  Begin
    btnMarcar.Click;
  End
  Else If Key = VK_F3 Then
  Begin
    If btnDesmarcar.Visible Then
      btnDesmarcar.Click
    Else
      btnEstLoj.Click
  End
  Else If Key = VK_F4 Then
  Begin
    btnProPag.Click;
  End
  Else If (Key = VK_F5) And (pnlBusca.Visible) Then
  Begin
    btnIniBus.Click;
  End
  Else If (Key = VK_F6) And (pnlBusca.Visible) Then
  Begin
    btnLocProx.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnExcel.Click;
  End;

  Case Key Of
    VK_F8: btnLimpaFiltros.Click;
  End;
end;


function TfrmAltPrecoIndividual.fMarcaDesmarca(blnMarcar: Boolean): Boolean;
  Var
    intContador : Integer;
begin

  Try
    Result := True;
    For intContador := 0 To Self.ComponentCount -1 Do
    Begin
      If (Self.Components[intContador] Is TCheckBox) Then
      Begin
        If TCheckBox(Self.Components[intContador]).Visible Then
        Begin
          If Not TCheckBox(Self.Components[intContador]).Enabled Then
            TCheckBox(Self.Components[intContador]).Checked := FALSE
          Else If (TCheckBox(Self.Components[intContador]).Tag = 90) Then
            TCheckBox(Self.Components[intContador]).Checked := blnMarcar;
        End;
      End;
    End;
  Except
    Result := False;
  End;

  pDesabilitaCamposFator;
end;

procedure TfrmAltPrecoIndividual.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If Not btnMarcar.Visible Then
    Exit;

  fMarcaDesmarca(True);

  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    chkLocFis.Checked := False;
    chkLocSup.Checked := False;
  End;

end;

procedure TfrmAltPrecoIndividual.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  If Not btnDesmarcar.Visible Then
    Exit;

  fMarcaDesmarca(False);
end;

procedure TfrmAltPrecoIndividual.pExportaParaExcel;
  Var
    objGeraExcel: TGeraExcel;
    intContador: Integer;
Begin
  Try
    objGeraExcel := TGeraExcel.Create(qryGen, pgbStatus);

    With qryGen, objGeraExcel Do
    Begin
      DisableControls;

      For intContador := 0 To dbgTiposAlt.Columns.Count - 1 Do
        If dbgTiposAlt.Columns[intContador].Visible Then
          AddCampo(dbgTiposAlt.Columns[intContador].FieldName, dbgTiposAlt.Columns[intContador].Title.Caption);

      First;

      Application.ProcessMessages;
      
      If fGerarRelatorio Then
      Begin
        fMensagem('','Arquivo gerado com sucesso!',['&OK']);
      End;

      First;
      EnableControls;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.pExportaParaExcel]');
    End;
  End;

  FreeAndNil(objGeraExcel);

End;

procedure TfrmAltPrecoIndividual.pMostraEstoqueLojas;
Begin
  If (Not qryGen.Active) or (fEmptyStr(qryGen.FieldByName('ITE_CODITE').AsString)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    With frmFatMostraEstoqueEmp, qryGen Do
    Begin
      strCodIte    := FieldByName('ITE_CODITE').AsString;
      fltQtdIte    := 0;
      strTabPre    := '';
      blnPedCorte  := False;
      edtItem.Text := FieldByName('ITE_CODITE').AsString + ' - ' + fRetNomProduto(FieldByName('ITE_CODITE').AsString);
      pnlSelecEmpresa.Visible := False;

      ShowModal;
    End;


  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);
End;  

procedure TfrmAltPrecoIndividual.btnEstLojClick(Sender: TObject);
begin
  inherited;

  If Not btnEstLoj.Visible Then
    Exit;

  pMostraEstoqueLojas;
end;

procedure TfrmAltPrecoIndividual.btnExcelClick(Sender: TObject);
begin
  inherited;
  If btnExcel.Visible Then
    pExportaParaExcel;
end;

function TfrmAltPrecoIndividual.fAbreviacaoAlterada: Boolean;
  Var
    qryTemp : TUniQuery;
begin
  Result := False;

  If fEmptyStr(strTabela) Then
    Exit;

  qryTemp := fCriaQuery(Self);
  Try
    With qryTemp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT COUNT(*) AS CNT ');
      SQL.Add('   FROM ' + strTabela);
      SQL.Add('  WHERE ALTERA = "S" ');
      SQL.Add('    AND ITE_CODABF_NOV <> ITE_CODABF ');
      Open;
      Result := (FieldByName('CNT').AsInteger > 0);
      Close;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmAltPrecoIndividual.fCalcularMargemLucro(intTab: Integer): Boolean;
  Var
    strCodSit : String;
    fltIcmsST : Double;
    blnCalcSt : Boolean;
    fltPreComLiq : Double;
begin
  Try
    Result := True;
    {****************************}
    {* RECALCULA PREÇO DE VENDA *}
    {*************************AF*}
    If chkArrMai.Checked Then
    Begin
      arrRecTabPrecos[intTab].fltPreVen := fQryGen('PREVE' + IntToStr(intTab)).AsFloat;
      fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat := fArredondaMais(fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat, True);
      arrRecTabPrecos[intTab].blnPreVen := arrRecTabPrecos[intTab].fltPreVen <> fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat;
    End;

    {****************************}
    {* RECALCULA MARGEM BRUTA   *}
    {*************************AF*}
    arrRecTabPrecos[intTab].fltMarBru := fQryGen('MARBR' + IntToStr(intTab)).AsFloat;

    fltPreComLiq := fCalculaPrecoCompraLiq(fQryGen('PRECOM_NOV').AsFloat,
                                           fQryGen('DESF01_NOV').AsFloat,
                                           fQryGen('DESF02_NOV').AsFloat,
                                           fQryGen('DESF03_NOV').AsFloat,
                                           fQryGen('DESF04_NOV').AsFloat,
                                           fQryGen('DESF05_NOV').AsFloat,
                                           fQryGen('DESF06_NOV').AsFloat,
                                           (fQryGen('PREDOL').AsString = 'S'));

    strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fQryGen('CODABF_NOV').AsString, strEstEmp]);
    fltIcmsST := fGetIcmsSTParteVenda(fQryGen('CODABF_NOV').AsString,
                                      '_SAI_CCO', strCodSit, strEstEmp,
                                      fltPreComLiq, fQryGen('IPIENT_NOV').AsFloat,
                                      fQryGen('ICMSAI_NOV').AsFloat,
                                      strEstEmp, blnCalcSt);

    fQryGen('MARBR' + IntToStr(intTab) + '_NOV').AsFloat :=
      fCalculaPrecoVenda(2,
                         fQryGen('PRECUS_NOV').AsFloat + fQryGen('OUTVAL_NOV').AsFloat,
                         fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat,
                         fQryGen('MARBR' + IntToStr(intTab) + '_NOV').AsFloat,
                         fQryGen('ICMSAI_NOV').AsFloat,
                         fQryGen('IMPFED_NOV').AsFloat,
                         fQryGen('DESOPE_NOV').AsFloat,
                         fQryGen('COMTB' + IntToStr(intTab) + '_NOV').AsFloat,
                         '',
                         '',
                         -1,
                         fltIcmsST,
                         blnCalcSt);

    arrRecTabPrecos[intTab].blnMarBru := arrRecTabPrecos[intTab].fltMarBru <> fQryGen('MARBR' + IntToStr(intTab) + '_NOV').AsFloat;
  Except
    Result := False;
  End;
end;

function TfrmAltPrecoIndividual.fCalcularPrecoVenda(intTab: Integer): Boolean;
  Var
    strCodSit : String;
    fltIcmsST : Double;
    blnCalcSt : Boolean;
    fltPreComLiq : Double;

begin
  Try
    Result := True;

    arrRecTabPrecos[intTab].fltPreVen := fQryGen('PREVE' + IntToStr(intTab)).AsFloat;

    fltPreComLiq := fCalculaPrecoCompraLiq(fQryGen('PRECOM_NOV').AsFloat,
                                           fQryGen('DESF01_NOV').AsFloat,
                                           fQryGen('DESF02_NOV').AsFloat,
                                           fQryGen('DESF03_NOV').AsFloat,
                                           fQryGen('DESF04_NOV').AsFloat,
                                           fQryGen('DESF05_NOV').AsFloat,
                                           fQryGen('DESF06_NOV').AsFloat,
                                           (fQryGen('PREDOL').AsString = 'S'));

    strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fQryGen('CODABF_NOV').AsString, strEstEmp]);
    fltIcmsST := fGetIcmsSTParteVenda(fQryGen('CODABF_NOV').AsString,
                                      '_SAI_CCO', strCodSit, strEstEmp,
                                      fltPreComLiq, fQryGen('IPIENT_NOV').AsFloat,
                                      fQryGen('ICMSAI_NOV').AsFloat,
                                      strEstEmp, blnCalcSt);

    fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat :=
      fCalculaPrecoVenda(1, fQryGen('PRECUS_NOV').AsFloat + fQryGen('OUTVAL_NOV').AsFloat,
                            fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat,
                            fQryGen('MARBR' + IntToStr(intTab) + '_NOV').AsFloat,
                            fQryGen('ICMSAI_NOV').AsFloat,
                            fQryGen('IMPFED_NOV').AsFloat,
                            fQryGen('DESOPE_NOV').AsFloat,
                            fQryGen('COMTB' + IntToStr(intTab) + '_NOV').AsFloat,
                            '',
                            '',
                            -1,
                            fltIcmsST,
                            blnCalcSt);

    If chkArrMai.Checked Then
    Begin
      fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat := fArredondaMais(fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat, True);
    End;

    arrRecTabPrecos[intTab].blnPreVen := arrRecTabPrecos[intTab].fltPreVen <> fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat;
  Except
    Result := False;
  End;
end;

function TfrmAltPrecoIndividual.fRecalculaPreCusto: Boolean;
  Var
    cpcParams: TParCalculaPrecoCusto;
    intTab: Integer;
    objConversor: IConversorMoedaCusto;
begin

  Try
    Result := True;

    Try
      cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

      With qryGen Do
      Begin
        {**********************************}
        {* RECALCULA PREÇOS DE CUSTO      *}
        {*******************************JB*}
        fltPreCus := FieldByName('ITE_PRECUS_NOV').AsFloat;
        With cpcParams Do
        Begin
          curPreCom := FieldByName('ITE_PRECOM_NOV').AsFloat;
          curDesF01 := FieldByName('ITE_DESF01_NOV').AsFloat;
          curDesF02 := FieldByName('ITE_DESF02_NOV').AsFloat;
          curDesF03 := FieldByName('ITE_DESF03_NOV').AsFloat;
          curDesF04 := FieldByName('ITE_DESF04_NOV').AsFloat;
          curDesF05 := FieldByName('ITE_DESF05_NOV').AsFloat;
          curDesF06 := FieldByName('ITE_DESF06_NOV').AsFloat;
          curICMSEnt:= FieldByName('ITE_ICMENT_NOV').AsFloat;
          curIPIEnt := FieldByName('ITE_IPIENT_NOV').AsFloat;
          curFrete  := FieldByName('ITE_FREENT_NOV').AsFloat;
          curValFre := FieldByName('ITE_VALFRE_NOV').AsFloat;
          curAcrFin := FieldByName('ITE_ACRFIN_NOV').AsFloat;
          curSubsti := FieldByName('ITE_SUBSTI_NOV').AsFloat;
          curDesAdb := FieldByName('ITE_DESADB_NOV').AsFloat;
          curSubFed := FieldByName('ITE_SUBFED_NOV').AsFloat;
        End;

        objConversor := Nil;
        If (FieldByName('ITE_PREDOL').AsString = 'S') Then
          objConversor := TConversorMoedaCusto.Create;

        FieldByName('ITE_PRECUS_NOV').AsFloat := cpcParams.fCalculaPrecoCusto(objConversor);

        FieldByName('ITE_CUSREA_NOV').AsFloat := fCalculaCustoReal(FieldByName('ITE_PRECUS_NOV').AsFloat,
                                                                   FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                                                   FieldByName('ITE_IMPFED_NOV').AsFloat,
                                                                   FieldByName('ITE_DESOPE_NOV').AsFloat,
                                                                   FieldByName('ITE_OUTVAL_NOV').AsFloat);

        FieldByName('ITE_CUSREA').AsFloat := fCalculaCustoReal(FieldByName('ITE_PRECUS').AsFloat,
                                                               FieldByName('ITE_ICMSAI').AsFloat,
                                                               FieldByName('ITE_IMPFED').AsFloat,
                                                               FieldByName('ITE_DESOPE').AsFloat,
                                                               FieldByName('ITE_OUTVAL').AsFloat);


        blnPreCus :=  fltPreCus <> FieldByName('ITE_PRECUS_NOV').AsFloat;

        {************************************************************************}
        {* RECALCULA O PRECO DE VENDA OU A MARGEM APOS ALTERAR O PRECO DE CUSTO *}
        {*********************************************************************JC*}
        For intTab := 1 To Length(arrRecTabPrecos) Do
        Begin
          If ( intCustoVenda = 0 ) Then
            fCalcularPrecoVenda(intTab)

          Else If ( intCustoVenda = 1 ) Then
            fCalcularMargemLucro(intTab);
        End;

        pRecalculaPrecosFator;

      End;

    Finally
      FreeAndNil(cpcParams);
    End;

  Except
    Result := False;
  End;

End;

Procedure TfrmAltPrecoIndividual.pRecalculaPrecosFator;
  Var
    intIndice: Integer;
Begin
  If Not Assigned(objFatPre) Then
    Exit;

  For intIndice := 2 To 7 Do
  Begin
    arrRecTabPrecos[intIndice].fltPreVen := fQryGen('PREVE' + IntToStr(intIndice) + '_NOV').AsFloat;

    fQryGen('PREVE' + IntToStr(intIndice) + '_NOV').AsFloat :=
       objFatPre.fCalculaPrecoVendaFator(fQryGen('PREVE1_NOV').AsFloat, intIndice);

    If chkArrMai.Checked Then
    Begin
      fQryGen('PREVE' + IntToStr(intIndice) + '_NOV').AsFloat :=
        fArredondaMais(fQryGen('PREVE' + IntToStr(intIndice) + '_NOV').AsFloat, True);
    End;

    fCalcularMargemLucro(intIndice);

    arrRecTabPrecos[intIndice].blnPreVen :=
      arrRecTabPrecos[intIndice].fltPreVen <> fQryGen('PREVE' + IntToStr(intIndice) + '_NOV').AsFloat;
  End;

End;

function TfrmAltPrecoIndividual.fRecalculaPreVendaOuMargem: Boolean;
  Var
    intTab: Integer;
    strNomCam: String;
begin

  Try
    Result := True;

    With qryGen Do
    Begin

      strNomCam := dbgTiposAlt.SelectedField.FieldName;

      If (fEhCampoComissao(strNomCam, intTab)) Or         //COMISSAO DA TABELA
         (fEhCampoPrecoVenda(strNomCam, intTab)) Or       //MARGEM OU PRECO DE VENDA
         (fEhCampoVendaOutras(strNomCam)) Then            //OUTROS CAMPOS DE VENDA
      Begin

        If fEhCampoVendaOutras(strNomCam) Then            //CASO FOR OUTROS RECALCULA PARA TODAS AS TABELAS
        Begin
          For intTab := 1 To length(arrRecTabPrecos) Do
            fCalcularMargemLucro(intTab);
        End
        Else                                                  //CASO NAO RECALCULA SOMENTE DA TABELA SELECIONADA
        Begin
          If (Pos('ITE_MARBR', strNomCam) > 0) And (Pos('_NOV', strNomCam) > 0) Then
            fCalcularPrecoVenda(intTab)
          Else
            fCalcularMargemLucro(intTab);
        End;

        pRecalculaPrecosFator;
      End;

    End;

  Except
    Result := False;
  End;

end;

procedure TfrmAltPrecoIndividual.edtCodAbrExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodAbr, edtDesAbr, arrCodAbr, fRetDesAbfIcm, Nil, 'da Abreviação Fiscal');
end;

procedure TfrmAltPrecoIndividual.edtCodAbrKeyPress(Sender: TObject;
  var Key: Char);
begin

  If fPesqAbrevFiscal(Self, edtCodAbr, edtDesAbr, qryConAbf, Key, arrCodAbr, False) Then
  Begin
    If fValidaCampos(edtCodAbr, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmAltPrecoIndividual.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrCodDep, fRetDescDepartamento, nil, 'do Departamento');
end;

procedure TfrmAltPrecoIndividual.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoIndividual.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples,
                Self,
                edtCodEmpresa,
                edtDesEmpresa,
                Nil,
                Key,
                arrLinEmp,
                True,
                True) Then
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmAltPrecoIndividual.edtStatusKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Not CharInSet(UpperCase(Key)[1],['S', 'N', 'T'])) Then
    Key := #0;
end;

function TfrmAltPrecoIndividual.fCheckBox(strNome: String): TCheckBox;
Begin
  Result := TCheckBox(Self.FindComponent(strNome));
end;

procedure TfrmAltPrecoIndividual.FormShow(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  pSetFocus(mskLinGru);

  blnPreMat := fCampoTabela('EMP_PREMAT','CADEMP',['EMP_CODEMP'],[VS_strCodEmp]) = 'S';

  If VS_strCodEmp = fCfgSis('EMPMAT') Then
    blnPreMat := False;

  chkPreCom.Enabled := (Not blnPreMat);
  chkPreCom.Checked := (Not blnPreMat);
  chkPreCom.Visible := (Not blnPreMat);

  chkDesF01.Enabled := (Not blnPreMat);
  chkDesF02.Enabled := (Not blnPreMat);
  chkDesF03.Enabled := (Not blnPreMat);
  chkDesF04.Enabled := (Not blnPreMat);
  chkDesF05.Enabled := (Not blnPreMat);
  chkDesF06.Enabled := (Not blnPreMat);

  chkDesF01.Checked := (Not blnPreMat);
  chkDesF02.Checked := (Not blnPreMat);
  chkDesF03.Checked := (Not blnPreMat);
  chkDesF04.Checked := (Not blnPreMat);
  chkDesF05.Checked := (Not blnPreMat);
  chkDesF06.Checked := (Not blnPreMat);

  chkDesF01.Visible := (Not blnPreMat);
  chkDesF02.Visible := (Not blnPreMat);
  chkDesF03.Visible := (Not blnPreMat);
  chkDesF04.Visible := (Not blnPreMat);
  chkDesF05.Visible := (Not blnPreMat);
  chkDesF06.Visible := (Not blnPreMat);

  chkIcmEnt.Enabled := (Not blnPreMat);
  chkIcmEnt.Checked := (Not blnPreMat);
  chkIcmEnt.Visible := (Not blnPreMat);

  chkIpiEnt.Enabled := (Not blnPreMat);
  chkIpiEnt.Checked := (Not blnPreMat);
  chkIpiEnt.Visible := (Not blnPreMat);

  chkFreEnt.Enabled := (Not blnPreMat);
  chkFreEnt.Checked := (Not blnPreMat);
  chkFreEnt.Visible := (Not blnPreMat);

  chkValFre.Enabled := (Not blnPreMat);
  chkValFre.Checked := (Not blnPreMat);
  chkValFre.Visible := (Not blnPreMat);

  chkAcrFin.Enabled := (Not blnPreMat);
  chkAcrFin.Checked := (Not blnPreMat);
  chkAcrFin.Visible := (Not blnPreMat);

  chkSubsti.Enabled := (Not blnPreMat);
  chkSubsti.Checked := (Not blnPreMat);
  chkSubsti.Visible := (Not blnPreMat);

  chkDesAdb.Enabled := (Not blnPreMat);
  chkDesAdb.Checked := (Not blnPreMat);
  chkDesAdb.Visible := (Not blnPreMat);

  chkImpFed.Enabled := (Not blnPreMat);
  chkImpFed.Checked := (Not blnPreMat);
  chkImpFed.Visible := (Not blnPreMat);

  chkDesOpe.Enabled := (Not blnPreMat);
  chkDesOpe.Checked := (Not blnPreMat);
  chkDesOpe.Visible := (Not blnPreMat);

  chkPreCus.Enabled := (Not blnPreMat);
  chkPreCus.Checked := (Not blnPreMat);
  chkPreCus.Visible := (Not blnPreMat);

  chkCusRea.Enabled := (Not blnPreMat);
  chkCusRea.Checked := (Not blnPreMat);
  chkCusRea.Visible := (Not blnPreMat);

  chkOutVal.Enabled := (Not blnPreMat);
  chkOutVal.Checked := (Not blnPreMat);
  chkOutVal.Visible := (Not blnPreMat);

  chkIcmSai.Enabled := (Not blnPreMat);
  chkIcmSai.Checked := (Not blnPreMat);
  chkIcmSai.Visible := (Not blnPreMat);

  chkIpiSai.Enabled := (Not blnPreMat);
  chkIpiSai.Checked := (Not blnPreMat);
  chkIpiSai.Visible := (Not blnPreMat);

  chkMarMin.Enabled := (Not blnPreMat);
  chkMarMin.Checked := (Not blnPreMat);
  chkMarMin.Visible := (Not blnPreMat);

  chkMarMSG.Enabled := (Not blnPreMat);
  chkMarMSG.Checked := (Not blnPreMat);
  chkMarMSG.Visible := (Not blnPreMat);

  chkMarMGe.Enabled := (Not blnPreMat);
  chkMarMGe.Checked := (Not blnPreMat);
  chkMarMGe.Visible := (Not blnPreMat);

  chkPRapel.Enabled := blnURapel;
  chkPRapel.Checked := blnURapel;
  chkPRapel.Visible := blnURapel;

  chkUtiAmp.Enabled := blnUtiAmp;
  chkUtiAmp.Checked := blnUtiAmp;
  chkUtiAmp.Visible := blnUtiAmp;

  chkOrdSer.Enabled := blnOrdSer;
  chkOrdSer.Checked := blnOrdSer;
  chkOrdSer.Visible := blnOrdSer;

  For intCont := 1 To Length(VS_strTabPrc) Do
  Begin
    fCheckBox('chkMarId' + IntToStr(intCont)).Enabled := (VS_strTabPrc[intCont] = 'S') And (Not blnPreMat) And blnMarIde;

    fCheckBox('chkMarBr' + IntToStr(intCont)).Enabled := (VS_strTabPrc[intCont] = 'S') And (Not blnPreMat);
    fCheckBox('chkMarBr' + IntToStr(intCont)).Checked := (VS_strTabPrc[intCont] = 'S') And (Not blnPreMat);

    fCheckBox('chkPreVe' + IntToStr(intCont)).Enabled := (VS_strTabPrc[intCont] = 'S') And (Not blnPreMat);
    fCheckBox('chkPreVe' + IntToStr(intCont)).Checked := (VS_strTabPrc[intCont] = 'S') And (Not blnPreMat);

    fCheckBox('chkMarId' + IntToStr(intCont)).Visible := (Not blnPreMat) And blnMarIde;

    fCheckBox('chkMarBr' + IntToStr(intCont)).Visible := (Not blnPreMat);
    fCheckBox('chkPreVe' + IntToStr(intCont)).Visible := (Not blnPreMat);

    fCheckBox('chkComTb' + IntToStr(intCont)).Enabled := (VS_strTabPrc[intCont] = 'S') And (Not blnPreMat) And blnPerComTabela;
    fCheckBox('chkComTb' + IntToStr(intCont)).Checked := (VS_strTabPrc[intCont] = 'S') And (Not blnPreMat) And blnPerComTabela;
    fCheckBox('chkComTb' + IntToStr(intCont)).Visible := (Not blnPreMat) And blnPerComTabela;

    If Not fCheckBox('chkComTb' + IntToStr(intCont)).Visible Then
    Begin
      fCheckBox('chkPreVe' + IntToStr(intCont)).Top := fCheckBox('chkPreVe' + IntToStr(intCont)).Top - 17;
    End;

    fCheckBox('chkPr' + IntToStr(intCont) + 'Ant').Enabled := (VS_strTabPrc[intCont] = 'S');
    fCheckBox('chkPr' + IntToStr(intCont) + 'Ant').Checked := (VS_strTabPrc[intCont] = 'S');
  End;

  btnSair.Left := (pnlBotoes.Width - btnSair.Width - 3);

  chkComDig.Visible := fCfgSis('USADIG', varBoolean);

  If fCfgSis('PCMPRO') <> '1' Then
  Begin
    chkComVar.Visible := False;
    chkComAta.Visible := False;
    chkComDis.Visible := False;

    chkComVar.Checked := False;
    chkComAta.Checked := False;
    chkComDis.Checked := False;

    chkComDig.Visible := False;
  End;

  If Not chkComDig.Visible Then
    chkComDig.Checked := False;

  If Not ((fCfgSis('ORIPRO') = '2') Or (fCfgSis('TCOPRO') = '4')) Then
  Begin
    chkComPro.Visible := False;
    chkComPro.checked := chkComPro.Visible;
  End;

  pDesabilitaCamposFator;

  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    chkLocFis.Visible := False;
    chkLocSup.Visible := False;
    chkLocFis.Checked := False;
    chkLocSup.Checked := False;
  End;

  If Not fCfgSis('GRUSEP', varBoolean) Then
  Begin
    chkCodLse.Visible := False;
    chkCodLse.Checked := False;
  End;

  If Not fCfgSis('TREMTA', varBoolean) Then
  Begin
    chkProEmb.Visible := False;
    chkProEmb.Checked := False;
  End;

  If Not fCfgSis('ENTETI', varBoolean) Then
  Begin
    chkImpEti.Visible := False;
    chkImpEti.Checked := False;
  End;

  If Not (fCfgSis('USACON', VarBoolean) And (fCfgSis('CONFME') = '1')) Then
  Begin
    chkReaEnd.Visible := False;
    chkReaEnd.Checked := False;
  End;

  If Not fCfgSis('VENVID', varBoolean) Then
  Begin
    chkLarVid.Visible := False;
    chkLarVid.Checked := False;

    chkAltVid.Visible := False;
    chkAltVid.Checked := False;

    chkLaMaVi.Visible := False;
    chkLaMaVi.Checked := False;

    chkAlMaVi.Visible := False;
    chkAlMaVi.Checked := False;
  End;

  blnValFor := fCfgSis('VALFOR', VarBoolean);

  chkDtaVal.Enabled := blnValFor;
  chkDtaVal.Checked := blnValFor;
  chkDtaVal.Visible := blnValFor;

  chkCodOnu.Checked := fCfgSis('CLAONU', varBoolean);
  chkCodOnu.Visible := chkCodOnu.Checked;

  chkPenRec.Visible := fCfgSis('CLPVDI', varBoolean);
  chkPenRec.Checked := chkPenRec.Visible;

  chkLotePD.Visible := False;
  chkLotePD.Checked := False;

  If fCfgSis('UTIWMS', VarBoolean) Then
  Begin

    If fCfgSis('WMSLOT', varBoolean) Then
      chkLotePD.Visible := True;
  End;

  pTravaPrecos;

  pCarregaSelecao;
end;

procedure TfrmAltPrecoIndividual.pBeforeInsert(Dataset: TDataset);
begin
  Abort;
end;

function TfrmAltPrecoIndividual.fInativarProduto: Boolean;
  Var
    qryTmpIteger: TUniQuery;
    strSQL      : String;
    strCodEmp   : String;
begin
  inherited;

  Result := True;

  qryTmpIteger := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + ' ITEGER.ITE_CODEMP, ITE_SALDOS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + '  INNER JOIN CADITE ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADITE.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_SALDOS + ( ITE_SAL_ML / IF( ITE_CNV_ML > 0, ITE_CNV_ML, 1 )) <> 0 ';
  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  ITEGER.ITE_CODEMP ';

  With qryTmpIteger Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := dbgTiposAlt.DataSource.DataSet.FieldByName('ITE_CODITE').AsString;
    Open;

    strCodEmp := '';

    While Not Eof Do
    Begin
      strCodEmp := strCodEmp + FieldByName('ITE_CODEMP').AsString + ', ';
      Next;
    End;

    Close;
    FreeAndNil(qryTmpIteger);

  End;

  If strCodEmp <> '' Then
  Begin

    strCodEmp := Copy(strCodEmp, 1, Length(strCodEmp) - 2);

    fMensagem('', 'Este produto possui saldo na(s) empresa(s): ' + strCodEmp + '. ' + #13 + 'Não é possível inativa - lo !', ['&O K']);

    Result := False;

  End;

end;

procedure TfrmAltPrecoIndividual.pAtualizaGrid(DataSet: TDataSet);
begin
  If dtsGen.State = dsEdit Then
    dtsGen.DataSet.Post;
end;

procedure TfrmAltPrecoIndividual.pAtualizaCprCenLojas(strCodIte,
  strCprCen: String; blnCprCenInd: Boolean);
  Var
    qryUpd: TUniQuery;
begin

  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  ITEGER ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  ITE_CPRCEN = :CPRCEN ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  ITE_CODITE = :CODITE ');

  If (blnCprCenInd) Then
    qryUpd.SQL.Add('  AND ITE_CODEMP = :CODEMP ');

  qryUpd.ParamByName('CPRCEN').AsString := strCprCen;

  qryUpd.ParamByName('CODITE').AsString := strCodIte;

  If (blnCprCenInd) Then
    qryUpd.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

procedure TfrmAltPrecoIndividual.pConfirma;
  Var
    strMensagem: String;
    intRetorno : Integer;
begin
  inherited;

  //*************************************************//
  // VERIFICA SE O PANEL DE FILTROS ESTA VISIVEL     //
  // SE SIM ENTAO MONTA O GRID E ESCONDE O PANEL     //
  //**********************************************ED*//
  If (pnlFiltros.Visible) Or (pnlFiltro2.Visible) Then
  Begin
    btnMarcar.Visible    := False;
    btnDesmarcar.Visible := False;
    btnEstLoj.Visible    := True;

    If (fMontaGrid) Then
    Begin
      pSalvaPosicao;

      pnlFiltros.Visible := False;
      pnlFiltro2.Visible := False;
      pnlBusca.Visible   := chkCodFab.Checked;
      btnExcel.Visible   := True;
      dbgTiposAlt.SelectedIndex := 1;
    End

  End
  Else
  Begin

    If (qryGen.Active) And (Not qryGen.IsEmpty) And (Not fEmptyStr(strTabela)) Then
    Begin
      qryGen.First;

      If pnlCabecalho.Visible Then
      Begin

        If (fQtdRegistrosSelecionados > 0) Then
        Begin
          pRestauraPosicao;

          qryGen.DisableControls;
          pAtualizaTemporaria(True, '');

          intRetorno := fVerificaDuplic;

          // NAO TEM DUPLICIDADE
          If (intRetorno = 0) Then
          Begin
            pMostraColunasAntigas(True);

            pMostraColunasAntigasCx(True);

            pMontaGridAlterados(False);

            pnlCabecalho.Visible := False;
          End

          // CANCELOU OPERACAO
          Else If (intRetorno = -1) Then
          Begin
            pAtualizaTemporaria(False, '');
            pMontaGridAlterados(False);
          End

          Else
          Begin
            pConfirma;

            Exit;
          End;

          qryGen.EnableControls;
        End
        Else
        Begin
          fMensagem('', 'É necessário selecionar pelo menos 1 produto!', ['&Ok']);
        End;

      End
      Else
      Begin

        If fMensagem('','Confirma alteração de dados?',['&Sim','&Não']) = 1 Then
        Begin
          Try
            {*************************************************************}
            {* CHAMA FORM PARA DIGITAÇÃO DA DATA DE ALTERAÇÃO DOS PREÇOS *}
            {**********************************************************ER*}
            pCriarFormularios(TfrmAltPrecoDigData, frmAltPrecoDigData);

            {******************************************************}
            {* ROTINA INCLUSA NOVAMENTE EM 31/03/2008 A PEDIDO DO *}
            {* RONALDO - PIPOCOPOS                                *}
            {***************************************************LU*}
            frmAltPrecoDigData.ShowModal;

            If frmAltPrecoDigData.blnConfirma Then
            Begin
              If frmAltPrecoDigData.dtaData = VS_Date Then
                strMensagem := 'Os preços serão alterados imediatamente. Confirma?'
              Else
              Begin
                strMensagem := 'Os preços serão alterados no dia '+DateToStr(frmAltPrecoDigData.dtaData)+'.';

                If (fCfgSis('CLPVDI', varBoolean)) And (fAbreviacaoAlterada) Then
                  strMensagem := strMensagem + sLineBreak + '* Os produtos estarão bloqueados para venda até que a efetivação de preços do dia seja feita!';

                strMensagem := strMensagem + ' Confirma?';
              End;

              If fMensagem('Confirmação',strMensagem,['&Sim','&Não']) = 1 Then
              Begin
                If fGravaDados Then
                Begin
                  fMensagem('','Dados alterados com sucesso!',['&OK']);

                  pMostraColunasAntigas(False);
                  pMostraColunasAntigasCx(True);

                  pnlCabecalho.Visible := True;

                  dbgTiposAlt.OnExit  := Nil;
                  qryGen.BeforeScroll := Nil;
                  pDeletaTemporaria;
                  fFecharTabela(qryGen);
                  pnlCabecalho.Enabled := True;
             //     pLimpaCampos;
                  dbgTiposAlt.Enabled := False;
                  pnlFiltros.Visible  := True;
                  pnlBusca.Visible    := False;
                  btnExcel.Visible    := False;
                  pSetFocus(mskLinGru);
                End;
              End;
            End;

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '[frmAltPrecoIndividual.btnConfirmaAltClick_1]');
            End;
          End;

          pFreeAndNil(frmAltPrecoDigData);

          btnMarcar.Visible    := True;
          btnDesmarcar.Visible := True;
          btnEstLoj.Visible    := False;

        End;
      End;
    End
    Else
      fMensagem('','Não há dados para serem alterados!',['&OK']);

  End;

end;

function TfrmAltPrecoIndividual.fQryGen(strCampo: String): TField;
begin
  Result := qryGen.FieldByName('ITE_' + strCampo);
end;

function TfrmAltPrecoIndividual.fEhCampoComissao(strCampo: String; Var intTabela: Integer): Boolean;
begin
  Result := (Pos('ITE_COMTB', strCampo) > 0) And (Pos('_NOV', strCampo) > 0);
  If Result Then
    intTabela := StrToInt(Copy(strCampo, 10, 1));
end;

function TfrmAltPrecoIndividual.fEhCampoPrecoVenda(strCampo: String; Var intTabela: Integer): Boolean;
begin
  Result := (Pos(LeftStr(strCampo, 9), 'ITE_PREVE_ITE_MARBR_') > 0) And (Pos('_NOV', strCampo) > 0);
  If Result Then
    intTabela := StrToInt(Copy(strCampo, 10, 1));
end;

function TfrmAltPrecoIndividual.fEhCampoVendaOutras(strNomCam: String): Boolean;
  Const
    CAMPOS_VENDA_OUTROS = 'ITE_OUTVAL_NOV_ITE_ICMSAI_NOV_ITE_IMPFED_NOV_ITE_DESOPE_NOV_';
begin
  Result := (Pos(strNomCam, CAMPOS_VENDA_OUTROS) > 0);
end;

procedure TfrmAltPrecoIndividual.btnLimpaFiltrosClick(Sender: TObject);
begin
  inherited;

  pLimpaCampos;
end;

procedure TfrmAltPrecoIndividual.btnLocProxClick(Sender: TObject);
begin
  inherited;

  If (qryGen.Active) And (Not fEmptyStr(strCampoFiltro)) Then
    qryGen.FindNext;

end;

procedure TfrmAltPrecoIndividual.btnIniBusClick(Sender: TObject);
begin
  inherited;

  If (Not qryGen.Active) Or (qryGen.IsEmpty) Then
    Exit;

  Try
    pCriarFormularios(TfrmBuscaCodFabrica, frmBuscaCodFabrica);
    frmBuscaCodFabrica.ShowModal;

    If (Not fEmptyStr(frmBuscaCodFabrica.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBuscaCodFabrica.strValorFiltro;
      strCampoFiltro := frmBuscaCodFabrica.strCampoFiltro;
      qryGen.FindFirst;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBuscaCodFabrica.btnIniBusClick]');
    End;
  End;

  FreeAndNil(frmBuscaCodFabrica);

end;

procedure TfrmAltPrecoIndividual.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmAltPrecoIndividual.pHabilitaCamposMargemIdeal;
begin
  if cbxMarIde.ItemIndex = 0 then
  begin
    cbxTabPrc.ItemIndex := -1;
    lblTabPrc.Enabled   := False;
    cbxTabPrc.Enabled   := False;
  end
  else
  begin
    if cbxTabPrc.ItemIndex = -1 then
      cbxTabPrc.ItemIndex := 0;

    lblTabPrc.Enabled   := True;
    cbxTabPrc.Enabled   := True;
  end;
end;

procedure TfrmAltPrecoIndividual.pInformaAplicacao;
var
  strValor: string;
begin
  If fColunaAtiva('ITE_APLICA_NOV') Then
  begin
    strValor := TfrmObservacao.fObservacao('Aplicação.',
                                           dbgTiposAlt.DataSource.DataSet.FieldByName('ITE_NOVO_REAL').AsString,
                                           0, tpiInputQuery, 200, true, 'Aplicação do Item');
    If Not fEmptyStr(strValor) Then
    Begin
      dbgTiposAlt.DataSource.DataSet.Edit;
      dbgTiposAlt.DataSource.DataSet.FieldByName('ITE_NOVO_REAL').AsString := strValor;
      dbgTiposAlt.SelectedField.AsString := strValor;
      dbgTiposAlt.DataSource.DataSet.Post;
    End;
  end;
end;

function TfrmAltPrecoIndividual.fRecalculaPreLiq: Boolean;
Begin
  fQryGen('PRELIQ').AsFloat :=( ( fQryGen('PRECOM_NOV').AsFloat             ) *
                                ( 1 - (fQryGen('DESF01_NOV').AsFloat / 100) ) *
                                ( 1 - (fQryGen('DESF02_NOV').AsFloat / 100) ) *
                                ( 1 - (fQryGen('DESF03_NOV').AsFloat / 100) ) *
                                ( 1 - (fQryGen('DESF04_NOV').AsFloat / 100) ) *
                                ( 1 - (fQryGen('DESF05_NOV').AsFloat / 100) ) *
                                ( 1 - (fQryGen('DESF06_NOV').AsFloat / 100) ) );
  Result := True;                              
End;

procedure TfrmAltPrecoIndividual.UpdateIteger(strNomCam: String; qryGenPre : TUniQuery);
Var
    qryGenIte: TUniQuery;
    strSQL:    String;
Begin
  Try
    {********************************************}
    {* GRAVA LOG EST. MIN. E MAX QUANDO ALTERADO*}
    {*****************************************GB*}
    If Pos(strNomCam, 'ITE_ESTMAX;ITE_ESTMIN') > 0 Then
    Begin
      TAltEst.fGravaLog(Self,
                        qryGenPre.FieldByName('ITE_CODITE').AsString,
                        VS_strCodEmp,
                        IIF(strNomCam = 'ITE_ESTMIN', qryGenPre.FieldByName( strNomCam + '_NOV').AsFloat,0),
                        IIF(strNomCam = 'ITE_ESTMAX', qryGenPre.FieldByName( strNomCam + '_NOV').AsFloat,0),
                        (strNomCam = 'ITE_ESTMIN'),
                        (strNomCam = 'ITE_ESTMAX')
                       );
    End;



    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + strNomCam + ' = :' + strNomCam ;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    qryGenIte.Close;
    qryGenIte.SQL.Clear;
    qryGenIte.SQL.Add(strSQL);

    qryGenIte.ParamByName(strNomCam ).AsString := qryGenPre.FieldByName( strNomCam + '_NOV').AsString;

    qryGenIte.ParamByName('CODITE').AsString := qryGenPre.FieldByName('ITE_CODITE').AsString;
    qryGenIte.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryGenIte.ExecSQL;
    qryGenIte.Close;

  Finally
    FreeAndNil(qryGenIte);
  End;

End;

procedure TfrmAltPrecoIndividual.pBeforeScroll(Dataset: TDataset);
  Var
    fltEstIte: Double;
Begin
  If qryGen.IsEmpty Then
    Exit;
    
  If chkEstMin.Checked Then
  Begin
    If (IIF(qryGen.FieldByName('ITE_ESTMIN_NOV').Value = null, -1, qryGen.FieldByName('ITE_ESTMIN_NOV').Value) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Mínimo deve ser maior ou igual a Zero!', ['&Ok']);
      Abort;
      Exit;
    End;

    If Not chkEstMax.Checked Then
      // Busca o estoque máximo na tabela ITEGER
      fltEstIte := fCampoTabela('ITE_ESTMAX', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'],
                                [qryGen.FieldByName('ITE_CODITE').AsString, VS_strCodEmp])
    Else
      fltEstIte := qryGen.FieldByName('ITE_ESTMAX_NOV').AsFloat;

    If (qryGen.FieldByName('ITE_ESTMIN_NOV').Value > fltEstIte) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Mínimo deve ser menor ou igual ao Estoque Máximo!!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;

  If chkEstMax.Checked Then
  Begin
    If ((IIF(qryGen.FieldByName('ITE_ESTMAX_NOV').Value = null, -1, qryGen.FieldByName('ITE_ESTMAX_NOV').Value)) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Máximo deve ser maior ou igual a Zero!', ['&Ok']);
      Abort;
      Exit;
    End;

    If Not chkEstMin.Checked Then
      // Busca o estoque mínimo na tabela ITEGER
      fltEstIte := fCampoTabela('ITE_ESTMIN', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'],
                                [qryGen.FieldByName('ITE_CODITE').AsString, VS_strCodEmp])
    Else
      fltEstIte := qryGen.FieldByName('ITE_ESTMIN_NOV').AsFloat;

    If (qryGen.FieldByName('ITE_ESTMAX_NOV').Value < fltEstIte) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Máximo deve ser maior ou igual ao Estoque Mínimo!!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;

  If chkLarVid.Checked Then
  Begin
    If (Not fEmptyStr(qryGen.FieldByName('ITE_LARVID_NOV').AsString)) Then
    Begin
      If (qryGen.FieldByName('ITE_LARVID_NOV').Value < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Largura deve ser maior ou igual a zero!', ['&Ok']);
        Abort;
        Exit;
      End;
    End;
  End;

  If chkAltVid.Checked Then
  Begin
    If (Not fEmptyStr(qryGen.FieldByName('ITE_ALTVID_NOV').AsString)) Then
    Begin
      If (qryGen.FieldByName('ITE_ALTVID_NOV').Value < 0) Then
      Begin
        fMensagem('ATENÇÃO!', fRetornaInfMedVIDRO(False,False,False,True,False)+' deve ser maior ou igual a zero!', ['&Ok']);
        Abort;
        Exit;
      End;
    End;
  End;

  If chkLaMaVi.Checked Then
  Begin
    If (Not fEmptyStr(qryGen.FieldByName('ITE_LAMAVI_NOV').AsString)) Then
    Begin
      If (qryGen.FieldByName('ITE_LAMAVI_NOV').Value < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Largura Máxima deve ser maior ou igual a zero!', ['&Ok']);
        Abort;
        Exit;
      End;
    End;
  End;

  If chkAlMaVi.Checked Then
  Begin
    If (Not fEmptyStr(qryGen.FieldByName('ITE_ALMAVI_NOV').AsString)) Then
    Begin
      If (qryGen.FieldByName('ITE_ALMAVI_NOV').Value < 0) Then
      Begin
        fMensagem('ATENÇÃO!', fRetornaInfMedVIDRO(False,False,True,True,False)+' deve ser maior ou igual a zero!', ['&Ok']);
        Abort;
        Exit;
      End;
    End;
  End;

End;

function TfrmAltPrecoIndividual.fSQLAlteracaoPreco: String;
  Var
    strSQL: String;
Begin
  strSQL := ' /*  untAltPrecoIndividual.fSQLAlteracaoPreco */';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   ALT_DTAALT, ';
  strSQL := strSQL + '   ALT_VE1ANT, ';
  strSQL := strSQL + '   ALT_VE2ANT, ';
  strSQL := strSQL + '   ALT_VE3ANT, ';
  strSQL := strSQL + '   ALT_VE4ANT, ';
  strSQL := strSQL + '   ALT_VE5ANT, ';
  strSQL := strSQL + '   ALT_VE6ANT, ';
  strSQL := strSQL + '   ALT_VE7ANT  ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   PREALT  ';
  strSQL := strSQL + ' WHERE     ';
  strSQL := strSQL + '   ALT_CODITE = :CODITE AND ';
  strSQL := strSQL + '   ALT_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   (ROUND(ALT_VE1ANT, 4) <> ROUND(ALT_VE1ATU, 4) OR ';
  strSQL := strSQL + '    ROUND(ALT_VE2ANT, 4) <> ROUND(ALT_VE2ATU, 4) OR ';
  strSQL := strSQL + '    ROUND(ALT_VE3ANT, 4) <> ROUND(ALT_VE3ATU, 4) OR ';
  strSQL := strSQL + '    ROUND(ALT_VE4ANT, 4) <> ROUND(ALT_VE4ATU, 4) OR ';
  strSQL := strSQL + '    ROUND(ALT_VE5ANT, 4) <> ROUND(ALT_VE5ATU, 4) OR ';
  strSQL := strSQL + '    ROUND(ALT_VE6ANT, 4) <> ROUND(ALT_VE6ATU, 4) OR ';
  strSQL := strSQL + '    ROUND(ALT_VE7ANT, 4) <> ROUND(ALT_VE7ATU, 4))    ';
  strSQL := strSQL + ' ORDER BY   ';
  strSQL := strSQL + '   ALT_DTAALT DESC LIMIT 1  ';

  Result := strSQL;
End;

Procedure TfrmAltPrecoIndividual.pBuscaUltimaAlteraoPreco;
  Var
    qryTemp  : TUniQuery;
    qryUpDate: TUniQuery;
Begin
  qryUpDate := fCriaQuery;
  With qryUpDate, SQL Do
  Begin
    Clear;
    Add('UPDATE ' + strTabela);
    Add('SET');
    Add('  ITE_DTAALT = :DTAALT,');
    Add('  ITE_PR1ANT = :PR1ANT,');
    Add('  ITE_PR2ANT = :PR2ANT,');
    Add('  ITE_PR3ANT = :PR3ANT,');
    Add('  ITE_PR4ANT = :PR4ANT,');
    Add('  ITE_PR5ANT = :PR5ANT,');
    Add('  ITE_PR6ANT = :PR6ANT,');
    Add('  ITE_PR7ANT = :PR7ANT ');
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE');
  End;

  qryTemp := fCriaQuery;
  qryTemp.SQL.Text := 'SELECT ITE_CODITE FROM ' +  strTabela;
  qryTemp.Open;

  pgbStatus.Position := 0;
  pgbStatus.Max      := qryTemp.RecordCount;
  pgbStatus.Visible  := True;

  While Not qryTemp.Eof Do
  Begin

    With qryAltPre Do
    Begin
      Close;
      ParamByName('CODITE').AsString := qryTemp.FieldByName('ITE_CODITE').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        qryUpDate.Close;
        qryUpDate.ParamByName('DTAALT').AsDateTime := FieldByName('ALT_DTAALT').AsDateTime;
        qryUpDate.ParamByName('PR1ANT').AsFloat    := FieldByName('ALT_VE1ANT').AsFloat;
        qryUpDate.ParamByName('PR2ANT').AsFloat    := FieldByName('ALT_VE2ANT').AsFloat;
        qryUpDate.ParamByName('PR3ANT').AsFloat    := FieldByName('ALT_VE3ANT').AsFloat;
        qryUpDate.ParamByName('PR4ANT').AsFloat    := FieldByName('ALT_VE4ANT').AsFloat;
        qryUpDate.ParamByName('PR5ANT').AsFloat    := FieldByName('ALT_VE5ANT').AsFloat;
        qryUpDate.ParamByName('PR6ANT').AsFloat    := FieldByName('ALT_VE6ANT').AsFloat;
        qryUpDate.ParamByName('PR7ANT').AsFloat    := FieldByName('ALT_VE7ANT').AsFloat;
        qryUpDate.ParamByName('CODITE').AsString   := qryTemp.FieldByName('ITE_CODITE').AsString;

        qryUpDate.ExecSQL;
      End;
    End;

    qryTemp.Next;

    pgbStatus.StepBy(1);
    Application.ProcessMessages;
  End;

  qryTemp.Close;
  FreeAndNil(qryTemp);
  FreeAndNil(qryUpDate);

  pgbStatus.Visible := False;

End;

Procedure TfrmAltPrecoIndividual.pSalvaPosicao;
  Var
    intContador: Integer;
Begin
  If strLisCam.Count = 0 Then
  Begin
    For intContador := 0 To dbgTiposAlt.Columns.Count -1 Do
      If Assigned(dbgTiposAlt.Columns[intContador].Field) Then
        strLisCam.Add(dbgTiposAlt.Columns[intContador].FieldName);
  End;
End;

Procedure TfrmAltPrecoIndividual.pRestauraPosicao;
  Var
    intIndice, intContador: Integer;
Begin
  pSalvaPosicaoUsuario;

  For intIndice := 0 To strLisCam.Count -1 Do
    For intContador := 0 To dbgTiposAlt.Columns.Count -1 Do
      If Assigned(dbgTiposAlt.Columns[intContador].Field) And (dbgTiposAlt.Columns[intContador].FieldName = strLisCam[intIndice]) Then
        dbgTiposAlt.Columns[intContador].Index := intIndice;
End;

Procedure TfrmAltPrecoIndividual.pSalvaPosicaoUsuario;
  Var
    intContador: Integer;
Begin
  strLisUsu.Clear;

  For intContador := 0 To dbgTiposAlt.Columns.Count -1 Do
    If Assigned(dbgTiposAlt.Columns[intContador].Field) Then
      strLisUsu.Add(dbgTiposAlt.Columns[intContador].FieldName);
End;

procedure TfrmAltPrecoIndividual.pUpdateAbrvFiscalCadIte(strCodAbf, strCodIte: String);
  Var
    qryCadIte : TUniQuery;
begin
  qryCadIte := fCriaQuery(Self);
  Try
    With qryCadIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE CADITE ');
      SQL.Add('    SET ITE_CODABF = :CODABF ');
      SQL.Add('  WHERE ITE_CODITE = :CODITE ');
      ParamByName('CODABF').AsString := strCodAbf;
      ParamByName('CODITE').AsString := strCodIte;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryCadIte);
  End;
end;

Procedure TfrmAltPrecoIndividual.pRestauraPosicaoUsuario;
  Var
    intIndice, intContador: Integer;
    cxItem: TcxCustomGridTableItem;
Begin
  For intIndice := 0 To strLisUsu.Count -1 Do
    For intContador := 0 To cxvTiposAlt.ColumnCount -1 Do
    Begin
      cxItem := cxvTiposAlt.GetColumnByFieldName(strLisUsu[intIndice]);

      If Assigned(cxItem) Then
        cxItem.Index := intIndice;
    End;
End;


end.

