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
  cxData, cxDataStorage, cxEdit, cxNavigator, untZClient, System.IOUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView, untTAvisoAlteracaoPreco,
  cxGridDBBandedTableView, cxEditRepositoryItems, cxDBEditRepository, untMsgLiberacao, untILiberacao, untLiberacaoFactory,
  untTEditFocusWithTConsultasArray, untTCalculaVariacaoPreco, untIteBar, untPreAlt_Trigger,
  untCadLote, untTGerenciaItegerPermiteEdicao, cxDataUtils, untFrameAlteraPrecoIndividual, cxContainer, cxGroupBox, Math;

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

  TMomentoOperacao = (moIndefinido, moFiltros, moAlteracao, moConfimacaoAlteraco);

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
    rdgTipAlt: TRadioGroup;
    chkArrMai: TCheckBox;
    Label7: TLabel;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    Label9: TLabel;
    edtStatus: TEditFocus;
    ColorLabel1: TColorLabel;
    pnlRodape: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    dbeCodIte: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    dbeRefere: TDBEditFocus;
    dbeUnidad: TDBEditFocus;
    Label14: TLabel;
    dbeAltPre: TDBEditFocus;
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
    lblOrdem: TLabel;
    cbxOrdem: TComboBoxFocus;
    pnlCadMon: TPanel;
    lbl3: TLabel;
    edtCodMon: TEditFocus;
    edtDesMon: TEditFocus;
    btnConfirmaAlt: TBitBtnLocked;
    btnExcel: TBitBtnLocked;
    Label167: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    Label1: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    Label50: TLabel;
    ColorLabel2: TColorLabel;
    edtIncPis: TEditFocus;
    btnEstLoj: TBitBtnLocked;
    Label5: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    edtExcIpi: TEditFocus;
    lbl50: TLabel;
    shpMultSel: TShape;
    cbxMarIde: TComboBoxFocus;
    cbxTabPrc: TComboBoxFocus;
    lblMarIde: TLabel;
    lblTabPrc: TLabel;
    cdsDuplicITEAGR: TStringField;
    pnlAviso: TPanel;
    chkPenRec: TCheckBox;
    lblCodGpr: TLabel;
    edtCodGpr: TEditFocus;
    edtDesGpr: TEditFocus;
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
    cmbCarEst: TcxEditRepositoryComboBoxItem;
    cmbClaCRM: TcxEditRepositoryLookupComboBoxItem;
    cmbNivGir: TcxEditRepositoryComboBoxItem;
    cmbNivCri: TcxEditRepositoryComboBoxItem;
    cmbRspGar: TcxEditRepositoryComboBoxItem;
    cmbFrePFU: TcxEditRepositoryLookupComboBoxItem;
    cmbMltRca: TcxEditRepositoryLookupComboBoxItem;
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
    cxeConsTamLse: TcxEditRepositoryTextItem;
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
    cxePCAPM3: TcxEditRepositoryCurrencyItem;
    Label8: TLabel;
    cmbSimNaoFornecedor: TcxEditRepositoryComboBoxItem;
    cmbPerVda: TcxEditRepositoryLookupComboBoxItem;
    dtsPermissaoVenda: TDataSource;
    dtsParametros: TDataSource;
    cdsParametros: TUniClientDataSet;
    cdsParametrosCAMPO: TStringField;
    cdsParametrosMARCADO: TBooleanField;
    cdsParametrosDESCRI: TStringField;
    pnlBusca: TPanel;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    cdsParametrosVISIVEL: TIntegerField;
    pnlInfoCotDol: TPanel;
    cxeBarPrinVendaCompra: TcxEditRepositoryTextItem;
    pnlFiltros: TPanel;
    cxGrid: TcxGrid;
    cxGridView: TcxGridDBTableView;
    cxGridViewCAMPO: TcxGridDBColumn;
    cxGridViewDESCRI: TcxGridDBColumn;
    cxGridViewMARCADO: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    Panel1: TPanel;
    lbl5: TLabel;
    Panel2: TPanel;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnLimpaFiltros: TBitBtnLocked;
    Label15: TLabel;
    dbePosEmb: TDBEditFocus;
    dbeDtaUve: TDBEditFocus;
    cxBtnMontadora: TcxEditRepositoryButtonItem;
    lblAtivoCompras: TLabel;
    edtAtivoCompras: TEditFocus;
    ColorLabel3: TColorLabel;
    edtExpEcomm: TEditFocus;
    ColorLabel4: TColorLabel;
    Label17: TLabel;
    cxBtnCklMerGar: TcxEditRepositoryButtonItem;
    cmbTpEstM: TcxEditRepositoryLookupComboBoxItem;
    pnlGridResultado: TPanel;
    cmbTipRet: TcxEditRepositoryLookupComboBoxItem;
    gpbNvgiro: TcxGroupBox;
    ColorLabel8: TColorLabel;
    edtGirEst: TEditFocus;
    chkNOReordenaGrid: TCheckBox;

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
    procedure edtCodGprExit(Sender: TObject);
    procedure edtCodGprKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimpaFiltrosClick(Sender: TObject);
    procedure cxeConsTam2PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeFatComPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgTiposAltExit(Sender: TObject);
    procedure cxgTiposAltEnter(Sender: TObject);
    procedure cxeMasPerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeMasFatPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeInt03PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeClassfIPIPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeString03PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cmbSimNaoPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeDatePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxGridViewDataControllerFilterChanged(Sender: TObject);
    procedure cxGridViewDESCRIGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cdsParametrosBeforePost(DataSet: TDataSet);
    procedure cxeBarPrinVendaCompraPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeString70PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxBtnMontadoraPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtAtivoComprasExit(Sender: TObject);
    procedure edtAtivoComprasKeyPress(Sender: TObject; var Key: Char);
    procedure cxBtnCklMerGarPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cmbEsMiDgPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cmbTpEstMPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edtGirEstKeyPress(Sender: TObject; var Key: Char);


  private
    { Private declarations }
    MomentoOperacao: TMomentoOperacao;
    blnAlterouAlgumRegistro: Boolean;
    blnTABPRD: Boolean;
    blnVidroInteiro,
    FAltera,
    blnBloPre,
    blnUtiAmp : Boolean;
    blnCodGpc : Boolean;
    blnOrdSer : Boolean;
    strEstEmp : String;
    blnInfMat: Boolean;
    blnValFor: Boolean;

    FrameAlteraPrecoIndividual: TFrameAlteraPrecoIndividual;

    intDecUni,
    intDecQtd,
    intInfFed,
    intInfOpe,
    intInfSai: Integer;

    objAvisoAlteracaoPreco: TAvisoAlteracaoPreco;

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

    cdsParamsRestaurado: TUniClientDataSet;

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
    qryDetCus: TUniQuery;


    strTabela       : String;
    intCustoVenda   : Integer;
    strCusto        : String;
    strVenda        : String;
    colColunas      : Array Of TColunasNovas;
    blnPreMat       : Boolean;

    blnRestaurandoCopiaSeg: Boolean;

    intConfirmando: Integer;

    fltPreCus       : Double;
    blnPreCus       : Boolean;

    strAgrupadorPreAlt: String;

    arrRecTabPrecos : Array[1..7] Of TRecTabPrecos;

    strMARMKP: String;
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

    strTraLoc: String;

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
    cdsTpEstM,
    cdsTipPro,
    cdsTipRet,
    cdsMltRca: TZClient;
    objIteBar: TIteBar;
    qryIteCom: TUniQuery;



    ColumnDesIte :TcxCustomGridTableItem;


    blnCodBar,
    blnCodBarPrincipal: Boolean;

    strTCOMTB : String;
    strFileExcel: String;

    blnUtilizaChecklistGarantia: Boolean;
    FPermVendaIgualTodasEmp: Boolean;
    blnUsaBef : Boolean;

    Procedure pCriaCdsSimNao;
    Procedure pCriaCdsClaCRM;
    Procedure pCriaCdsFrePFU;
    Procedure pCriaCdsEsMiDg;
    Procedure pCriaCdsTipPro;
    Procedure pCriaCdsTpEstM;
    Procedure pCriaCdsMltRca;
    Procedure pCriaCdsTipRet;


    Procedure pSalvaPosicao;
    Procedure pRestauraPosicao;

    Procedure pSalvaPosicaoUsuario(strLisUsu: TStringList);
    Procedure pRestauraPosicaoUsuario;


    procedure pCdsDuplicAfterScroll(DataSet: TDataSet);

    procedure pMostraEstoqueLojas;
    procedure pAtualizaIteger(qryGenIte, qryGenPre: TUniQuery; strEmpresas: String; blnResFor, IsAgendado: Boolean);
    procedure pAtualizaDesSit(qryGenIte, qryGenPre: TUniQuery);
    procedure pVerificaDireitoAcesso;
    Procedure pBuscaUltimaAlteraoPreco;
    procedure pExportaParaExcel;
    procedure pAtribuiTabelas;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria(blnAposAlteracaoEfetivada: Boolean = True);
    procedure pLimpaCampos;
    procedure pAtualizaTemporaria(blnFiltraAlterado: Boolean; strCampoOrdem: String);
    procedure pMostraColunasAntigasCx(blnHabilita: Boolean);

    function fRecalculaPrecos: Boolean;

    function fRetCotacaoAtualDolarCompra(Var strDtaCotDol: String): Double;

    procedure pGravaMontadoras(strCodIte: String; strListaMontadoras: String; qryComand: TUniQuery);
    function fRemoveQuebra(strInput: String): String;
    Procedure NextMomentoOperacao;
    Procedure BackMomentoOperacao;


    function fSQLAlteracaoPreco: String;
    function fGravaDados: Boolean;
    function fGravaDadosAux(pgbProgresso: TcxProgressBar): Boolean;
    function fGeraArquivoAux(pgbProgresso: TcxProgressBar): Boolean;
    function fQtdRegistros(blnTodos: Boolean = False): Integer;
    function fMontaGrid: Boolean;
    function fMontaGridAux(pgbProgresso: TcxProgressBar): Boolean;
    procedure pMarcaDesmarca(blnMarcar: Boolean);

    function fRecalculaPreCusto: Boolean;
    function fRecalculaPreVendaOuMargem: Boolean;
    function fRecalculaPreLiq: Boolean;

    function fCalcularPrecoVenda(intTab: Integer): Boolean;
    function fCalcularMargemLucro(intTab: Integer): Boolean;

    Function fValidaValor(strValor: String): Boolean;

    Procedure pMontaGridAlterados(blnAltera: Boolean);overload;
    Procedure pMontaGridAlterados(blnAltera: Boolean; Out blnResult: Boolean);overload;
    Function fMontaGridAlterados(cxProgresso: TcxProgressBar): Boolean;

    procedure pCarregaSelecao;
    procedure pDesmarcaCheckBoxWhenInvisible;
    procedure pSalvaSelecao;
    procedure pValidaEstoqueDigitado;

    procedure pBeforeInsert(Dataset: TDataset);
    procedure pAtualizaGrid(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pBeforePost(Dataset: TDataset);
    procedure pConfirma(blnRestaurando : Boolean = False);
    Procedure pRecalculaPrecosFator;

    function fInativarProduto: Boolean;
    procedure pAtualizaCprCenLojas(strCodIte, strCprCen: String; blnCprCenInd: Boolean);


    function fQryGen(strCampo: String): TField;
    function fEhCampoPrecoVenda(strCampo: String; Var intTabela: Integer): Boolean;
    function fEhCampoComissao(strCampo: String; Var intTabela: Integer): Boolean;
    function fEhCampoVendaOutras(strNomCam: String): Boolean;
    function fVerificaDuplic: Integer;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pAdicionaDuplic(strOri: String; qryAdic: TUniQuery; strItemAgrupamento: string);
    procedure pAtualizaDadosDuplic;

    procedure UpdateIteger(strNomCam: String; qryGenPre : TUniQuery);

    procedure pHabilitaCamposMargemIdeal;
    function fAbreviacaoAlterada: Boolean;
    procedure pUpdateAbrvFiscalCadIte(strCodAbf, strCodIte: String);

    procedure pAdicionaColuna(strTitulo: String; intIndice: Integer; blnVisible: Boolean = True);
    procedure OnHeaderClick(Sender: TObject);

    Function fGetMaxWidhProper(proProperties: TcxCustomEditProperties): Integer;

    Procedure pMontaCampos;
    function fRetCampoDesc(strField: string): TCampo;
    function fValidaMargem(intTabPreco: Integer): Boolean;
    procedure pSetaDisplayLabelGenPre(qryGenPre: TUniQuery);

    procedure pCriarCopiaSeguranca(strTabela: String);

    procedure pAlimentaCdsParametros;
    function fCampoMarcado(strCampo: String): Boolean;
    function fCampoVisivel(strCampo: String): Boolean;
    function fCampoRetDescriParamtro(strCampo: String): string;
    procedure pCampoMarcaDesmarca(strCampo: String; blnMarca: Boolean);

    function RemoveAcento(const pText: string): string;
    procedure pGravaIteCom(strCodIte, strTabPre, strNomCam: String; fltPerCom: Double);
    function fGetSqlUpdateCADITE(AQuery: TUniQuery): string;
    procedure pUpdateCADITE(AQuery: TUniQuery);
    function fGetSqlUpdateITEGER(IsAgendado, blnResFor: Boolean): string;
    function fValidaPrecoCustoReal(qryGen: TUniQuery): boolean;
    procedure pValidaDescontoMaximoOperador(Dataset : TDataset);
    procedure pValidaMargemMinimaOperador(Dataset : TDataset);
    function fFormatarCampo(objCampo: TField): Variant;
    procedure pGravarLogCpr(const qryGenPre: TUniQuery);
    function fGenIte(strCodIte: String): TUniQuery;
    procedure pInserirLog(strCodIte, strNomCam: String; objCampo,
      objCampoNovo: TField);
    function fRetornaSQLPrecoIndividual(Campos: String = ''): String;
    function fValidarEXPSIT: boolean;
    procedure pCalcularVariacoes(Dataset : TDataset);
    procedure pCarregarCopiasSeguranca;
    procedure pAjustarCdsParametros;
    procedure pAlteraTitDesadb;

    function ValidarCaractereInvalido(const Acampo, Acaractere: string; qryGen: TUniQuery): Boolean;
  public
    TipoOpcaoDeTrava : TTipoOpcaoDeTrava;
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
      untIcmsSTParteVenda, untTipoPermissaoVenda, untGeraExcelHtml, cxGridExportLink,
      untValidaHierarquia, untCopiasAltIndividual,untSelMontadoras,
      untController.CheckListGarantia, untCampoItegerPermiteEdicao;

{$R *.dfm}


Procedure TfrmAltPrecoIndividual.pMontaCampos;
  Var
    intCont,
    intContador: Integer;

   Procedure pAdicionaCampo(strNomCam, strTitulo: String; blnVisible: Boolean; proProperties: TcxCustomEditProperties = Nil; strFieldDesc: string = ''; strFieldDescTitle: String = '');
   Begin
     Inc(intContador);
     SetLength(arrCampos, intContador + 1);

     With arrCampos[intContador] Do
     Begin

       FieldName  := strNomCam;
       Title      := strTitulo;
       Visible    := blnVisible;
       Properties := proProperties;
       blnTemDescricao := ((strFieldDesc <> '') And (strFieldDesc <> '_NOV'));
       blnCampoDescricao := False;
     End;

     If arrCampos[intContador].blnTemDescricao Then
     Begin
       Inc(intContador);
       SetLength(arrCampos, intContador + 1);

       Begin
         With arrCampos[intContador] Do
         Begin
           FieldName  := strFieldDesc;
           Title      := strFieldDescTitle;
           Visible    := blnVisible;
           ReadOnly    := True;
           Properties := proProperties;
           blnCampoDescricao := True;
         End;
       End;
     End;
   End;

   Procedure pAdicinaDupla(strNomCam, strTitulo: String; proProperties: TcxCustomEditProperties = Nil; strFieldDesc: string = ''; strFieldDescTitle: String = '');
   Begin
     pAdicionaCampo(strNomCam, strTitulo, False, proProperties);
     pAdicionaCampo(strNomCam + '_NOV', 'Novo ' + strTitulo, True, proProperties, strFieldDesc, strFieldDescTitle);
   End;

Begin
  intContador := -1;

  pAdicionaCampo('ITE_CODITE', 'Cód.Item', True);
  pAdicionaCampo('ITE_DESITE', 'Descrição', True);
  pAdicionaCampo('ITE_DESSIM', 'Descrição Simplificada', True);
  pAdicionaCampo('ITE_DESFAB', 'Descrição do Fabricante', True);
  pAdicionaCampo('ITE_DIFICM', 'Diferimento de ICMS na Entrada', True, cmbSimNao.Properties);

  pAdicionaCampo('ITE_MSGLV1', 'Mensagem Livre 1', True);
  pAdicionaCampo('ITE_MSGLV2', 'Mensagem Livre 2', True);
  pAdicionaCampo('ITE_REFERE', 'Referência', True);

  pAdicionaCampo('ITE_SALDOS', 'Saldo', True);
  pAdicionaCampo('ITE_IMPULT', 'Preço Últ.Compra+Imp.', True);
  pAdicionaCampo('ITE_PREULT', 'Preço Última Compra', True);
  pAdicionaCampo('ITE_DTAULT', 'Data Última Compra', True);
  pAdicionaCampo('ITE_QTDUCO', 'Quantidade Última Compra', True);

  pAdicionaCampo('ITE_PREMED', 'Preço Médio', True);
  pAdicionaCampo('ITE_DTAALT', 'Última Alteração Preço', True);
  pAdicionaCampo('ITE_DTAUAP', 'Data Últ. Atualização do Produto', True);
  pAdicionaCampo('ITE_PR1ANT', 'Preço Venda 1 Ant.', True);
  pAdicionaCampo('ITE_PR2ANT', 'Preço Venda 2 Ant.', True);
  pAdicionaCampo('ITE_PR3ANT', 'Preço Venda 3 Ant.', True);
  pAdicionaCampo('ITE_PR4ANT', 'Preço Venda 4 Ant.', True);
  pAdicionaCampo('ITE_PR5ANT', 'Preço Venda 5 Ant.', True);
  pAdicionaCampo('ITE_PR6ANT', 'Preço Venda 6 Ant.', True);
  pAdicionaCampo('ITE_PR7ANT', 'Preço Venda 7 Ant.', True);
  pAdicionaCampo('ITE_BARPRV', 'Principal de Vendas', True, cxeBarPrinVendaCompra.Properties);
  pAdicionaCampo('ITE_EMBPRV', 'Qtd. Principal de Vendas', True);
  pAdicionaCampo('ITE_BARPRC', 'Prinicipal de Compras', True, cxeBarPrinVendaCompra.Properties);
  pAdicionaCampo('ITE_EMBPRC', 'Qtd. Principal de Compras', True);

  pAdicinaDupla('ITE_CODBAR', 'Código de Barras', cxeString70.Properties);


  pAdicinaDupla('ITE_CLAIPI', 'NCM / Classif. IPI', cxeClassfIPI.Properties);
  pAdicinaDupla('ITE_EXCIPI', 'Código EX IPI', cxeString03.Properties);
  pAdicinaDupla('ITE_PER_CI', 'Percentual (CI)', cxeMasPer.Properties);
  pAdicinaDupla('ITE_PIMPTC', 'Percentual de Imposto de Importação', cxeMasPer.Properties);
  pAdicinaDupla('ITE_NUMFCI', 'Nº Ficha (FCI)', cxeString50.Properties);
  pAdicinaDupla('ITE_ITEATI', 'Ativo?', cmbSimNao.Properties);

  If fCfgSis('MARMOR', varBoolean) Then
  pAdicinaDupla('ITE_GRAMAR', 'Produto mármore / granito?', cmbSimNao.Properties);

  pAdicinaDupla('ITE_EXPPOK', 'Exporta Tablet', cmbSimNao.Properties);

  pAdicinaDupla('ITE_IMPDIR', 'Importação Direta', cmbSimNao.Properties);
  pAdicinaDupla('ITE_USAPPF', 'Utiliza Pauta Fiscal?', cmbSimNao.Properties);

  pAdicinaDupla('ITE_ABFPIS', 'Abrev. PIS', cxeConsTam3.Properties, 'APC_DESPIS', 'Desc. PIS');
  pAdicinaDupla('ITE_ABFCOF', 'Abrev. COFINS', cxeConsTam3.Properties,'APC_DESCOF', 'Desc. COFINS');
  pAdicinaDupla('ITE_ABFIPI', 'Abrev. IPI', cxeConsTam3.Properties, 'APC_DESIPI', 'Desc. IPI');
  If fCfgSis('USASAN') = 'S' Then
    pAdicinaDupla('ITE_CODABF', 'Abreviação Fiscal', cxeConsTam7.Properties, 'ABF_DESABF', 'Desc. Abrev. ICMS' )
  Else
    pAdicinaDupla('ITE_CODABF', 'Abreviação Fiscal', cxeConsTam3.Properties, 'ABF_DESABF', 'Desc. Abrev. ICMS' );

  pAdicinaDupla('ITE_PRECOM', 'Pr.Compra');
  pAdicinaDupla('ITE_DESF01', 'Desc.Forn.1', cxeMasPer.Properties);
  pAdicinaDupla('ITE_DESF02', 'Desc.Forn.2', cxeMasPer.Properties);
  pAdicinaDupla('ITE_DESF03', 'Desc.Forn.3', cxeMasPer.Properties);
  pAdicinaDupla('ITE_DESF04', 'Desc.Forn.4', cxeMasPer.Properties);
  pAdicinaDupla('ITE_DESF05', 'Desc.Forn.5', cxeMasPer.Properties);
  pAdicinaDupla('ITE_DESF06', 'Desc.Forn.6', cxeMasPer.Properties);
  pAdicinaDupla('ITE_PRELIQ', 'Pr.Compra Liq');
  pAdicinaDupla('ITE_ICMENT', 'ICMS Entrada');
  pAdicinaDupla('ITE_SUBFED', '% Imp.Federais (-)', cxeMasPer.Properties);
  pAdicinaDupla('ITE_IPIENT', 'IPI Entrada', cxeMasPer.Properties);
  pAdicinaDupla('ITE_FREENT', 'Frete Entrada', cxeMasPer.Properties);
  pAdicinaDupla('ITE_VALFRE',  fCfgSis('DESVFR'));
  pAdicinaDupla('ITE_ACRFIN', 'Acr.Financ.', cxeMasPer.Properties);
  pAdicinaDupla('ITE_SUBSTI', '%Sub.Tributária', cxeMasPer.Properties);
  pAdicinaDupla('ITE_DESADB', '%' + fCfgSis('DESADI'), cxeMasPer.Properties);
  pAdicinaDupla('ITE_PRECUS', 'Pr.Custo');
  pAdicinaDupla('ITE_CUSREA', 'Pr.Custo Real');
  pAdicinaDupla('ITE_OUTVAL', fCfgSis('DOVCPP'));
  pAdicinaDupla('ITE_ICMSAI', 'ICMS Saída', cxeMasPer.Properties);
  pAdicinaDupla('ITE_IPISAI', 'IPI Saída', cxeMasPer.Properties);
  pAdicinaDupla('ITE_IMPFED', '%Impostos Fed. (+)', cxeMasPer.Properties);
  pAdicinaDupla('ITE_DESOPE', '% Desp. Oper.', cxeMasPer.Properties);

  if fCfgSis('MARPAD') = 'S' Then
    pAdicinaDupla('ITE_MARPAD', '% Marg. Pad', cxeMasPer.Properties);

  pAdicinaDupla('ITE_MARBR1', 'Marg.Bruta 1');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB1', '(%)' + strTCOMTB +  ' 1', cxeMasPer.Properties);

  pAdicinaDupla('ITE_PREVE1', 'Pr. Venda 1');
  pAdicinaDupla('ITE_MARBR2', 'Marg.Bruta 2');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB2', '(%)' + strTCOMTB +  ' 2', cxeMasPer.Properties);

  pAdicinaDupla('ITE_PREVE2', 'Pr. Venda 2');
  pAdicinaDupla('ITE_MARBR3', 'Marg.Bruta 3');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB3', '(%)' + strTCOMTB +  ' 3', cxeMasPer.Properties);

  pAdicinaDupla('ITE_PREVE3', 'Pr. Venda 3');
  pAdicinaDupla('ITE_MARBR4', 'Marg.Bruta 4');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB4', '(%)' + strTCOMTB +  ' 4', cxeMasPer.Properties);

  pAdicinaDupla('ITE_PREVE4', 'Pr. Venda 4');
  pAdicinaDupla('ITE_MARBR5', 'Marg.Bruta 5');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB5', '(%)' + strTCOMTB +  ' 5', cxeMasPer.Properties);

  pAdicinaDupla('ITE_PREVE5', 'Pr. Venda 5');
  pAdicinaDupla('ITE_MARBR6', 'Marg.Bruta 6');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB6', '(%)' + strTCOMTB +  ' 6', cxeMasPer.Properties);

  pAdicinaDupla('ITE_PREVE6', 'Pr. Venda 6');
  pAdicinaDupla('ITE_MARBR7', 'Marg.Bruta 7');

  If blnPerComTabela Then
    pAdicinaDupla('ITE_COMTB7', '(%)' + strTCOMTB +  ' 7', cxeMasPer.Properties);

  pAdicinaDupla('ITE_PREVE7', 'Pr. Venda 7');

  If Not TipoOpcaoDeTrava.fOpcaoDeTravaEhPorAtividade Then
  Begin

    pAdicinaDupla('ITE_MARMIN', 'Margem Min. Vend. Júnior');
    pAdicinaDupla('ITE_MARMMV', 'Margem Min. Vend. Master');

    pAdicinaDupla('ITE_MARMSG', 'Margem Min. Sub. Ger. Júnior');
    pAdicinaDupla('ITE_MARMMS', 'Margem Min. Sub. Ger. Master');

    pAdicinaDupla('ITE_MARMGE', 'Margem Min. Ger. Júnior');
    pAdicinaDupla('ITE_MARMMG', 'Margem Min. Ger. Master');

  End;

  pAdicinaDupla('ITE_LOCFIS', 'Localização Física', cxeLocFis.Properties, 'ITE_LOCFIS', 'Localização Física');
  pAdicinaDupla('ITE_TAMLCF', 'Capacidade Loc. Física');
  pAdicinaDupla('ITE_LOCSUP', 'Localização Super Estoque', cxeLocSup.Properties, 'ITE_LOCSUP', 'Localização Super Estoque');
  pAdicinaDupla('ITE_TAMLCS', 'Capacidade Loc. Super Estoque');
  pAdicinaDupla('ITE_CODLSE', 'Localização de Separação', cxeConsTamLse.Properties, 'ITE_CODLSE', 'Localização de Separação');

  pAdicinaDupla('ITE_USAPFD', 'Produto controlado pela PF', cmbSimNao.Properties);
  pAdicinaDupla('ITE_USAPCV', 'Produto controlado pela PC', cmbSimNao.Properties);


  If Not TipoOpcaoDeTrava.fOpcaoDeTravaEhPorAtividade Then
  Begin

    If blnIteTbp Then
    Begin

      For intCont := 1 To Length(VS_strTabPrc) Do
      Begin
        pAdicinaDupla('ITE_DESMA' + intToStr(intCont), 'Desc.Máximo Vendedor Júnior '     + intToStr(intCont));
        pAdicinaDupla('ITE_DESVM' + intToStr(intCont), 'Desc.Máximo Vendedor Master '     + intToStr(intCont));

        pAdicinaDupla('ITE_DESMS' + intToStr(intCont), 'Desc.Máximo Sub-Gerente Júnior '  + intToStr(intCont));
        pAdicinaDupla('ITE_DESSM' + intToStr(intCont), 'Desc.Máximo Sub-Gerente Master '  + intToStr(intCont));

        pAdicinaDupla('ITE_DESMG' + intToStr(intCont), 'Desc.Máximo Gerente Júnior '      + intToStr(intCont));
        pAdicinaDupla('ITE_DESGM' + intToStr(intCont), 'Desc.Máximo Gerente Master '      + intToStr(intCont));
      End;

    End Else
    Begin
      pAdicinaDupla('ITE_DESMAX', 'Desc.Máximo Vendedor Júnior');
      pAdicinaDupla('ITE_DESMVM', 'Desc.Máximo Vendedor Master');

      pAdicinaDupla('ITE_DESMSU', 'Desc.Máximo Sub-Gerente Júnior');
      pAdicinaDupla('ITE_DESMSM', 'Desc.Máximo Sub-Gerente Master');

      pAdicinaDupla('ITE_DESMGE', 'Desc.Máximo Gerente Júnior');
      pAdicinaDupla('ITE_DESMGM', 'Desc.Máximo Gerente Master');
    End;

  End;

  pAdicinaDupla('ITE_MLTCOM', 'Múlt. Compra');
  pAdicinaDupla('ITE_CODFAB', 'Código de fábrica');
  pAdicinaDupla('ITE_QTPPRO', 'Qtd.Pontos Profiss.');
  pAdicinaDupla('ITE_CPRCEN', 'Compr. Centr.');
  pAdicinaDupla('ITE_MESGIR', 'Qtd. Meses para Inativação');
  pAdicinaDupla('ITE_TMPGAR', 'Tempo Garantia');
  pAdicinaDupla('ITE_INFGAR', 'Informação de Garantia');
  pAdicinaDupla('ITE_RSPGAR', 'Responsável pela Garantia', cmbRspGar.Properties);
  pAdicinaDupla('ITE_PESOIT', 'Peso Bruto');
  pAdicinaDupla('ITE_PESLIQ', 'Peso Liquido');
  pAdicinaDupla('ITE_INFLAM', 'Inflamável?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_USABON', 'Usa Bonificação?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_NVLGIR', 'Niv.Gir.Estoq.Geral', cmbNivGir.Properties);
  pAdicinaDupla('ITE_CODUNI', 'Unidade', cxeConsTam2.Properties, 'UNI_DESUNI','Desc. Unidade');
  pAdicinaDupla('ITE_UNICOM', 'Unidade de Compra', cxeConsTam2.Properties);
  pAdicinaDupla('ITE_CODMAR', 'Marca', cxeConsTam6.Properties, 'MAR_DESMAR', 'Desc. Marca' );
  pAdicinaDupla('ITE_SITPRO', 'Situação', cxeConsTam3.Properties, 'SIT_DESCRI', 'Desc. Situação ');
  pAdicinaDupla('ITE_DTAVAL', 'Dt.Validade Preço', cxeDate.Properties);
  pAdicinaDupla('ITE_CODMON', 'Montadora', cxBtnMontadora.Properties);
  pAdicinaDupla('ITE_CODFOR', 'Fornecedor', cxeConsTam8.Properties, 'FOR_NOMFOR', 'Desc. Fornecedor');
  pAdicinaDupla('ITE_DIAFOR', 'Dias entrega', cxeInt11.Properties);
  pAdicinaDupla('ITE_PRAMIN', 'Prazo Médio Mín. Cálc. Juros', cxeInt03.Properties);
  pAdicinaDupla('ITE_REAEND', 'Realizar endereçamento', cmbSimNao.Properties);
  pAdicinaDupla('ITE_DTAEPI', 'Dt.Validade Certificado EPI', cxeDate.Properties);

  If (fCfgSis('OPCCOM') <> 'PPT') Then
  begin
    pAdicinaDupla('ITE_COMVAR', 'Comis.Vend.Interno', cxeMasPer.Properties);
    pAdicinaDupla('ITE_COMATA', 'Comis.Repres.Ext.Loja', cxeMasPer.Properties);
    pAdicinaDupla('ITE_COMDIS', 'Comis.Repres.Ext.Distrib.', cxeMasPer.Properties);
  end;
  pAdicinaDupla('ITE_COMPRO', 'Comis.Profissional', cxeMasPer.Properties);
  pAdicinaDupla('ITE_CODDEP', 'Departamento', cxeConsTam3.Properties, 'DEP_DESCRI', 'Desc. Departamento');
  pAdicinaDupla('ITE_MLTVEN', 'Múltiplo Venda');
  pAdicinaDupla('ITE_ACOOBJ', 'Acordo Obj.');
  pAdicinaDupla('ITE_VALOBR', 'Validade Obrigatória?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_ESTMIN', 'Est. Mínimo');
  pAdicinaDupla('ITE_ESTMAX', 'Est. Máximo');
  pAdicinaDupla('ITE_MINDIG', 'Est. Mínimo Digitado');
  pAdicinaDupla('ITE_MAXDIG', 'Est. Máximo Digitado');
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
  pAdicinaDupla('ITE_PRDGRU', 'Grupo Produto', cxeConsTam5.Properties, 'PRD_DESGRU', 'Desc. Grupo Produto');
  pAdicinaDupla('ITE_IMPLIS', 'Imprime Lista', cmbSimNao.Properties);
  pAdicinaDupla('ITE_ATICOM', 'Ativo Compras', cmbSimNao.Properties);
  pAdicinaDupla('ITE_CODDIC', 'Código DIC');
  pAdicinaDupla('ITE_TIPPRO', 'Tipo produto', cmbTipPro.Properties);
  pAdicinaDupla('ITE_PRAPEL', '% Desc. Ref. Rapel', cxeMasPer.Properties);
  pAdicinaDupla('ITE_PROEMB', 'Produto Embalagem', cmbSimNao.Properties);
  pAdicinaDupla('ITE_DENSID', 'Densidade', cxeMasVal.Properties);
  pAdicinaDupla('ITE_IMPETI', 'Imprime Etiquetas Ent. Mer.', cmbSimNao.Properties);
  pAdicinaDupla('ITE_CODGRU', 'Linha/Grupo', cxeConsTam6.Properties, 'GRU_DESGRU', 'Desc. Linha/Grupo');
  pAdicinaDupla('ITE_TIPFRE', 'Tipo de Frete', cmbFrePFU.Properties);
  pAdicinaDupla('ITE_ESMIDG', 'Opção para estoque mínimo', cmbEsMiDg.Properties);

  if fCfgSis('MINPRO', varBoolean) Then
    pAdicinaDupla('ITE_TPESTM', 'Tipo do Estoque Mínimo', cmbTpEstM.Properties);

  pAdicinaDupla('ITE_VLCFRE', 'Frete de Saída', cxeMasPer.Properties);
  pAdicinaDupla('ITE_RASTRE', 'Rastreabilidade', cmbSimNao.Properties);

  pAdicinaDupla('ITE_FATCMP', 'Fator madeira de M³ X Peças', cxeFatCom.Properties);
  pAdicinaDupla('ITE_FATPM3', 'Fator Peças de madeira para M³', cxePCAPM3.Properties);


  pAdicinaDupla('ITE_LARVID', 'Largura');
  pAdicinaDupla('ITE_ALTVID', 'Altura');
  pAdicinaDupla('ITE_LAMAVI', 'Largura Máxima');
  pAdicinaDupla('ITE_ALMAVI', 'Altura Máxima');
  pAdicinaDupla('ITE_CDCEST', 'CEST', cxeConsTam7.Properties, 'CES_DESCRI','Desc. CEST');
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
  pAdicinaDupla('ITE_GRUCMP', 'Grupo de Compra', cxeConsTam3.Properties, 'GRU_DESCRI', 'Desc. Grupo Compra');
  pAdicinaDupla('ITE_CODGPR', 'Grupo de Preço', cxeConsTam6.Properties, 'GPR_DESCRI', 'Desc. Grupo preço');
  pAdicinaDupla('ITE_NIVCRI', 'Nível Criticidade', cmbNivCri.Properties);
  pAdicinaDupla('ITE_NVLCRI', 'Nível Criticidade Geral', cmbNivCri.Properties);
  pAdicinaDupla('ITE_RECDEV', 'Permite Receber Devolução?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_UNITRI', 'Unidade Tribut.', cxeConsTam2.Properties);
  pAdicinaDupla('ITE_FATUTR', 'Fator Conv. Unid. Tribut.', cxeDec06.Properties);
  pAdicinaDupla('ITE_UTIAMP', 'Aplica legislação AMPARA', cmbSimNao.Properties);
  pAdicinaDupla('ITE_ORDSER', 'Ordem de Serviço:', cmbSimNao.Properties);
  pAdicinaDupla('ITE_PESOBR', 'Controlar pesagem obrigatória (Saída):', cmbSimNao.Properties);
  pAdicinaDupla('ITE_LOTEPD', 'Obrigar definir lote (WMS) em Pedido de Venda?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_CAREST', 'Item estrutura em OR/PD/VN, carregar os itens da estrutura da seguinte forma?', cmbCarEst.Properties);
  pAdicinaDupla('ITE_CPESOB', 'Controlar pesagem obrigatória (Entrada):', cmbSimNao.Properties);
  pAdicinaDupla('ITE_COMDIG', 'Comis.Digitador', cxeMasPer.Properties);
  pAdicinaDupla('ITE_CLACRM', 'Classif. Oferta Consumíveis', cmbClaCRM.Properties);
  pAdicinaDupla('ITE_OBRBAR', 'Obrig. Cód Barras Entrada Simplificada', cmbSimNao.Properties);
  pAdicinaDupla('ITE_FATCOM', 'Digitar complemento do produto', cmbSimNao.Properties);
  pAdicinaDupla('ITE_DESCND', 'Aplicar desconto da condição de pagamento?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_CRODOC', 'Produto em Cross Docking?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_DESCHK', 'Desobrigar conferência no check-out?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_PERVDA', 'Permitir venda para', cmbPerVda.Properties);
  pAdicinaDupla('ITE_DESTAQ', 'Destaque', cmbSimNao.Properties);

  pAdicinaDupla('ITE_CICMDE', 'Calcular ICMS Desonerado ?', cmbSimNao.Properties);
  pAdicinaDupla('ITE_CDPIOP', 'Considerar desconto de PIS/COFINS na base de cálculo do ICMS Operações Próprias ?', cmbSimNaoFornecedor.Properties);
  pAdicinaDupla('ITE_DIDIOP', 'Considerar desconto de ICMS Desonerado na base de cálculo do ICMS Operações Próprias ?', cmbSimNaoFornecedor.Properties);

  pAdicinaDupla('ITE_TCIFCU', '% TCIF', cxeMasPer.Properties);
  pAdicinaDupla('ITE_TSCUST', '% TS', cxeMasPer.Properties);
  pAdicinaDupla('ITE_DEPICO', '% Desconto PIS/COFINS', cxeMasPer.Properties);
  pAdicinaDupla('ITE_DEICMS', '% Desconto ICMS', cxeMasPer.Properties);
  pAdicinaDupla('ITE_FATREG', '% Fator Regional', cxeMasPer.Properties);

  If fCfgSis('OPCCOM', varString) = 'VT' Then
  Begin
    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      If VS_strTabPrc[intCont] = 'S' Then
      Begin
        pAdicinaDupla('COM_VENIN' + intToStr(intCont), 'Com. Ven. Int. T. '     + intToStr(intCont));
        pAdicinaDupla('COM_VENEX' + intToStr(intCont), 'Com. Ven. Ext. T. '     + intToStr(intCont));
      End;
    End;
  End;

  pAdicinaDupla('ITE_CODGPC', 'Classificação Global do Produto - GPC', cxeConsTam8.Properties, 'GPC_DESGPC', 'Desc. Classificação Global do Produto - GPC');
  pAdicinaDupla('ITE_APERET', 'Apenas Retira', cmbSimNao.Properties);
  pAdicinaDupla('ITE_APEENT', 'Apenas Entrega', cmbSimNao.Properties);

  If (fCfgSis('MOEXSI') <> 0) Then
  Begin
    pAdicinaDupla('ITE_NOMECO', 'Nome do Produto - E-Commerce');
    pAdicinaDupla('ITE_APLECO', 'Aplicação - E-Commerce');
    pAdicinaDupla('ITE_DESECO', 'Descrição do Produto - E-Commerce');
    pAdicinaDupla('ITE_EXPALT', 'Altura - E-Commerce');
    pAdicinaDupla('ITE_EXPPRO', 'Profundidade - E-Commerce');
    pAdicinaDupla('ITE_EXPLAR', 'Largura - E-Commerce');
    pAdicinaDupla('ITE_BAREXP', 'Obrig. Cód. Barras Expedição', cmbSimNao.Properties);
    pAdicinaDupla('ITE_SEPBAR', 'Obrig. Cód. Barras Sep. Coletor', cmbSimNao.Properties);
    pAdicinaDupla('ITE_EXPSIT', 'Exportação para E-Commerce', cmbSimNao.Properties);
  End;
  If fCfgSis('EMPCAR', varBoolean) Then
    pAdicinaDupla('ITE_EMPCAR', 'Emp. resp. carregamento e entrega do item', cxeConsTam3.Properties, 'EMP_NOMEMP', 'Desc. Emp. resp. carregamento e entrega do item');

  if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
    pAdicinaDupla('ITE_EMPSUG', 'Sugestão para empresa multi-loja no faturamento', cxeConsTam3.Properties, 'EMP_NOMEMPSUG', 'Desc. empresa sugestão para multi-loja no faturamento');

  if blnUtilizaChecklistGarantia then
  begin
  	pAdicinaDupla('ITE_CODATC', 'Assistência Técnica', cxeConsTam5.Properties);
  	pAdicinaDupla('TMP_CKLGAR', 'Checklist Garantia de Mercadoria', cxBtnCklMerGar.Properties);
  	pAdicinaDupla('TMP_CKLTRO', 'Checklist Troca de Mercadoria', cxBtnCklMerGar.Properties);
  end;

  If fCfgSis('SEPEXC', varBoolean) Then
    pAdicinaDupla('ITE_SEPEXC', 'Item de Separação Exclusiva', cmbSimNao.Properties);

  pAdicinaDupla('ITE_SOBENC', 'Sob encomenda?', cmbSimNao.Properties);

  If fCfgSis('UTPEST', varBoolean) Then
  Begin
    pAdicinaDupla('ITE_QTDPES', 'Qtde mín. estoque para ponta de estoque');
    pAdicinaDupla('ITE_PORPES', '% de desconto aplicado para ponta de estoque', cxeMasPer.Properties);
  End;
  If fCfgSis('UTIABA', varBoolean) Then
    pAdicinaDupla('ITE_MLTRCA', 'Múltiplo na rotina Citel Abastece?', cmbMltRca.Properties);

  If fCfgSis('ETIDCE', varBoolean) Then
    pAdicinaDupla('ITE_NECEXP', 'Sem necessidade de expedição', cmbSimNao.Properties);

  If fCfgSis('LOCRET', varBoolean) Then
    pAdicinaDupla('ITE_TIPRET', 'Tipo de Retirada', cmbTipRet.Properties);


  If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
  Begin
    pAdicinaDupla('ITE_NFEIDP', 'NFe, Imprimir o lote na descrição do produto?', cmbSimNao.Properties);
    pAdicinaDupla('ITE_NFCIDP', 'NFCe, Imprimir o lote na descrição do produto?', cmbSimNao.Properties);
  End;

  If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
    pAdicinaDupla('ITE_LOTRAP', 'Obrigar a digitar o número do lote no Cadastro Rápido?', cmbSimNao.Properties);

  If fCfgSis('TRITTE', varBoolean) Then
    pAdicinaDupla('ITE_TRITTE', 'Permitir utilizar em Transferência de Estoque?', cmbSimNao.Properties);

  pAdicinaDupla('ITE_ITEBAS', 'Produto Base', cmbSimNao.Properties);

  If fCfgSis('CDPHAB', varBoolean) Then
    pAdicinaDupla('ITE_CLBPIN', 'Permite pontuar no Clube do Pintor?', cmbSimNao.Properties);

  If blnUsaBef Then
    pAdicinaDupla('ITE_USABEF', 'Possui Benefício Fiscal?', cmbSimNao.Properties);
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
      pDesmarcaLista(edtCodAbr, arrCodAbr, '', IIf(fCfgSis('USASAN') = 'S', 7, 3))
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

function TfrmAltPrecoIndividual.fValidaMargem(intTabPreco: Integer): Boolean;
  Var
    fltMargem  : Double;
    fltComissao: Double;
    MSG_VALIDACAO_MARGEM : String;
begin
  Result := true;

  If (Pos(strMARMKP, '1_5_2') > 0) Then
  Begin
    MSG_VALIDACAO_MARGEM := 'Tabela de Preço '+(IntToStr(intTabPreco))+'. A soma do ( ICMS Saída + Impostos Federais + Despesas Operacionais + Margem Bruta ' +
                             IIF(fCfgSis('PCMPRO') <> '1', ' + ' + strTCOMTB, '') + '  ) não pode ser superior a 100%.';
    Result := True;
    If intTabPreco In [1..Length(VS_strTabPrc)] Then
    If VS_strTabPrc[intTabPreco]= 'S' Then
    Begin
      If strMarMkp = '2' Then
        fltMargem := fMarkupToMargem(fQryGen('MARBR' + IntToStr(intTabPreco) + '_NOV').AsFloat)
      Else
        fltMargem   := fQryGen('MARBR' + IntToStr(intTabPreco) + '_NOV').AsFloat;
      fltComissao := fQryGen('COMTB' + IntToStr(intTabPreco) + '_NOV').AsFloat;

      Result := Not ( ( fltMargem + fltComissao     +
                        fQryGen('ICMSAI_NOV').AsFloat +
                        fQryGen('IMPFED_NOV').AsFloat +
                        fQryGen('DESOPE_NOV').AsFloat ) > 100);
      If Not Result Then
      Begin
        fMensagem('', MSG_VALIDACAO_MARGEM, ['&Ok']);
      End;
    End;
  End;
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

procedure TfrmAltPrecoIndividual.pAfterPost(DataSet: TDataSet);
begin
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

procedure TfrmAltPrecoIndividual.NextMomentoOperacao;
begin
  case MomentoOperacao of
    moIndefinido: MomentoOperacao := moFiltros;
    moFiltros   :  MomentoOperacao := moAlteracao;
    moAlteracao :  MomentoOperacao :=    moConfimacaoAlteraco;
    moConfimacaoAlteraco:  MomentoOperacao := moConfimacaoAlteraco;
  End;
end;

procedure TfrmAltPrecoIndividual.BackMomentoOperacao;
begin
  case MomentoOperacao of
    moIndefinido: MomentoOperacao := moIndefinido;
    moFiltros   :  MomentoOperacao := moFiltros;
    moAlteracao :  MomentoOperacao :=    moFiltros;
    moConfimacaoAlteraco:  MomentoOperacao := moAlteracao;
  End;
end;


procedure TfrmAltPrecoIndividual.OnHeaderClick(Sender: TObject);
begin
  FrameAlteraPrecoIndividual.chkSuspendeOrdenacao.Checked := False;
  TThread.CreateAnonymousThread(
  procedure
  begin
      TThread.Sleep(500);
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        FrameAlteraPrecoIndividual.chkSuspendeOrdenacao.Checked := True;
      end);
  end).Start;


end;

procedure TfrmAltPrecoIndividual.pDesmarcaCheckBoxWhenInvisible;
  var i: Integer;
begin
  For i := 0 To Self.ComponentCount -1 do
  Begin
    If Self.Components[i] is TCheckBox Then
      If Not TCheckBox(Self.Components[i]).Visible Then
        TCheckBox(Self.Components[i]).Checked := False;
  End;
end;


procedure TfrmAltPrecoIndividual.pValidaEstoqueDigitado;
  var
    fltEstIte: Double;
begin
  If fCampoMarcado('MINDIG') Then
  Begin
    If (IIF(qryGen.FieldByName('ITE_MINDIG_NOV').Value = null, -1, qryGen.FieldByName('ITE_MINDIG_NOV').Value) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Mínimo Digitado deve ser maior ou igual a Zero!', ['&Ok']);
      Abort;
      Exit;
    End;

    If Not fCampoMarcado('MAXDIG') Then
      // Busca o estoque máximo na tabela ITEGER
      fltEstIte := fCampoTabela('ITE_MAXDIG', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'],
                                [qryGen.FieldByName('ITE_CODITE').AsString, VS_strCodEmp])
    Else
      fltEstIte := qryGen.FieldByName('ITE_MAXDIG_NOV').AsFloat;

    If (qryGen.FieldByName('ITE_MINDIG_NOV').Value > fltEstIte) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Mínimo Digitado deve ser menor ou igual ao Estoque Máximo Digitado!!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;

  If fCampoMarcado('MAXDIG') Then
  Begin
    If ((IIF(qryGen.FieldByName('ITE_MAXDIG_NOV').Value = null, -1, qryGen.FieldByName('ITE_MAXDIG_NOV').Value)) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Máximo Digitado deve ser maior ou igual a Zero!', ['&Ok']);
      Abort;
      Exit;
    End;

    If Not fCampoMarcado('MINDIG') Then
      // Busca o estoque mínimo na tabela ITEGER
      fltEstIte := fCampoTabela('ITE_MINDIG', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'],
                                [qryGen.FieldByName('ITE_CODITE').AsString, VS_strCodEmp])
    Else
      fltEstIte := qryGen.FieldByName('ITE_MINDIG_NOV').AsFloat;

    If (qryGen.FieldByName('ITE_MAXDIG_NOV').Value < fltEstIte) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Máximo Digitado deve ser maior ou igual ao Estoque Mínimo Digitado!!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;
end;

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

function TfrmAltPrecoIndividual.RemoveAcento(const pText: string): string;
  type
    USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(pText));
  end;

procedure TfrmAltPrecoIndividual.pCarregaSelecao;
Begin
  objSalInt.fCarregaDados(strTabela, Self, Self.Name+strTabela, strLoginUsuarioLogado);

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
  objSalInt.pCarregaDataGrid(cdsParametros);
  cdsParametros.First;
  cdsParametros.LogChanges := False;

  cdsParametros.First;
  //  objSalInt.pCarregaMultiSelecao(arrClaIPI,     'CLAIPI');

   pDesmarcaCheckBoxWhenInvisible;

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
  objSalInt.pAddDataGrid(cdsParametros);
//  objSalInt.pAddMultiSelecao(arrClaIPI,     'CLAIPI');

  objSalInt.fSalvaDados(strTabela, Self.Name+strTabela, strLoginUsuarioLogado, True);
  objSalInt.fSalvaDados('', Self.Name, strLoginUsuarioLogado, True);
End;

procedure TfrmAltPrecoIndividual.pSetaDisplayLabelGenPre(qryGenPre: TUniQuery);
begin
  qryGenPre.FieldByName('ITE_PESOIT').DisplayLabel := 'Peso do Item';
  qryGenPre.FieldByName('ITE_PESLIQ').DisplayLabel := 'Peso Líquido';
	qryGenPre.FieldByName('ITE_ITEATI').DisplayLabel := 'Ativo/Inativo';
 	qryGenPre.FieldByName('ITE_GRAMAR').DisplayLabel := 'Produto mármore / granito?';


  qryGenPre.FieldByName('ITE_BARPRV').DisplayLabel := 'Principal de Vendas';
  qryGenPre.FieldByName('ITE_EMBPRV').DisplayLabel := 'Qtd. Principal de Vendas';
  qryGenPre.FieldByName('ITE_BARPRC').DisplayLabel := 'Prinicipal de Compras';
  qryGenPre.FieldByName('ITE_EMBPRC').DisplayLabel := 'Qtd. Prinicipal de Compras';

  qryGenPre.FieldByName('ITE_EXPPOK').DisplayLabel := 'Exporta Tablet';

  qryGenPre.FieldByName('ITE_IMPDIR').DisplayLabel := 'Importação Direta';
	qryGenPre.FieldByName('ITE_USAPPF').DisplayLabel := 'Utiliza Pauta Fiscal?';

  qryGenPre.FieldByName('ITE_FATCMP').DisplayLabel := 'Fator conversão madeira de M³ p/ Peças';
  qryGenPre.FieldByName('ITE_FATPM3').DisplayLabel := 'Fator conversão Peças de madeira p/ M³';
	qryGenPre.FieldByName('ITE_CODABF').DisplayLabel := 'Abreviação Fiscal';
	qryGenPre.FieldByName('ITE_DENSID').DisplayLabel := 'Densidada';
  qryGenPre.FieldByName('ITE_RASTRE').DisplayLabel := 'Controle de Rastreabilidade do produto';
  qryGenPre.FieldByName('ITE_ABFPIS').DisplayLabel := 'Abreviação PIS';
  qryGenPre.FieldByName('ITE_ABFCOF').DisplayLabel := 'Abreviação COFINS';
  qryGenPre.FieldByName('ITE_ABFIPI').DisplayLabel := 'Abreviação IPI';
  qryGenPre.FieldByName('ITE_CLAIPI').DisplayLabel := 'NCM / Classificação de IPI';
  qryGenPre.FieldByName('ITE_EXCIPI').DisplayLabel := 'Código EX IPI';
  qryGenPre.FieldByName('ITE_PER_CI').DisplayLabel := 'Percentual (CI)';
  qryGenPre.FieldByName('ITE_PIMPTC').DisplayLabel := 'Percentual de Imposto de Importação';
  qryGenPre.FieldByName('ITE_NUMFCI').DisplayLabel := 'Nº Ficha (FCI)';
  qryGenPre.FieldByName('ITE_MLTCOM').DisplayLabel := 'Múltiplo de Compra';
  qryGenPre.FieldByName('ITE_MLTVEN').DisplayLabel := 'Múltiplo de Venda';
  qryGenPre.FieldByName('ITE_CODFAB').DisplayLabel := 'Código de Fábrica';
  qryGenPre.FieldByName('ITE_CODBAR').DisplayLabel := 'Código de Barras';
  qryGenPre.FieldByName('ITE_EMBALA').DisplayLabel := 'Quant. da Embalagem';
  qryGenPre.FieldByName('ITE_INFGAR').DisplayLabel := 'Informações da Garantia ';
  qryGenPre.FieldByName('ITE_RSPGAR').DisplayLabel := 'Responsável pela Garantia ';
  qryGenPre.FieldByName('ITE_MESGIR').DisplayLabel := 'Quant.meses sem venda p/inativação compras';
  qryGenPre.FieldByName('ITE_TMPGAR').DisplayLabel := 'Tempo de Garantia';
  qryGenPre.FieldByName('ITE_BAREMB').DisplayLabel := 'Código de Barras da Embalagem';
  qryGenPre.FieldByName('ITE_INFLAM').DisplayLabel := 'Produto inflamável';
  qryGenPre.FieldByName('ITE_USABON').DisplayLabel := 'Permitir utilizar item em bonificação';
  qryGenPre.FieldByName('ITE_USAFLE').DisplayLabel := 'Gerar FLEX do Produto';
  qryGenPre.FieldByName('ITE_OBRCPF').DisplayLabel := 'Venda com obrigatoriedade de CPF/CNPJ';
  qryGenPre.FieldByName('ITE_OBRIBA').DisplayLabel := 'Venda com obrigatoriedade de código IBAMA';
  qryGenPre.FieldByName('ITE_OBRNFE').DisplayLabel := 'Venda com obrigatoriedade de NFe';
  qryGenPre.FieldByName('ITE_NVLGIR').DisplayLabel := 'Nível de Giro';
  qryGenPre.FieldByName('ITE_NVLGIR').DisplayLabel := 'Nível de Criticidade de Estoque';
  qryGenPre.FieldByName('ITE_PROEMB').DisplayLabel := 'Produto Embalagem';
  qryGenPre.FieldByName('ITE_ACOOBJ').DisplayLabel := 'Acordos Objetivos';
  qryGenPre.FieldByName('ITE_VALOBR').DisplayLabel := 'Validade Obrigatória';
  qryGenPre.FieldByName('ITE_CODUNI').DisplayLabel := 'Unidade';
  qryGenPre.FieldByName('ITE_UNICOM').DisplayLabel := 'Unidade de Compra';
  qryGenPre.FieldByName('ITE_UNITRI').DisplayLabel := 'Unidade de tributação';
  qryGenPre.FieldByName('ITE_FATUTR').DisplayLabel := 'Fator de conversão da unidade de tributação';
  qryGenPre.FieldByName('ITE_CODMAR').DisplayLabel := 'Marca';
  qryGenPre.FieldByName('ITE_SITPRO').DisplayLabel := 'Situação do Produto';
	qryGenPre.FieldByName('ITE_CODMON').DisplayLabel := 'Montadora';
	qryGenPre.FieldByName('ITE_CODFOR').DisplayLabel := 'Fornecedor';
  qryGenPre.FieldByName('ITE_DIAFOR').DisplayLabel := 'Dias de Entrega do Fornecedor';
  qryGenPre.FieldByName('ITE_REAEND').DisplayLabel := 'Realizar endereçamento do produto';
  qryGenPre.FieldByName('ITE_OBRBAR').DisplayLabel := 'Obrigatório o Código de Barras na Entrada Simplificada';
  qryGenPre.FieldByName('ITE_PEEFUT').DisplayLabel := 'Ent.Fut. com Status "Aguardando Cliente"';
  qryGenPre.FieldByName('ITE_PEFUTP').DisplayLabel := 'Ent.Fut. com Status "Previsão de Entrega"';
  qryGenPre.FieldByName('ITE_PEFFPR').DisplayLabel := 'Ent.Fut. com Status "Falta de Produto"';
  qryGenPre.FieldByName('ITE_CODDEP').DisplayLabel := 'Departamento';
  qryGenPre.FieldByName('ITE_GRUCMP').DisplayLabel := 'Grupo de Compra';
  qryGenPre.FieldByName('ITE_CODGPR').DisplayLabel := 'Grupo de Preço';
  qryGenPre.FieldByName('ITE_CDCEST').DisplayLabel := 'Classificação CEST';
  qryGenPre.FieldByName('ITE_DESCND').DisplayLabel := 'Aplicar desconto da condição de pagamento';
  qryGenPre.FieldByName('ITE_APLICA').DisplayLabel := 'Aplicação';
  qryGenPre.FieldByName('ITE_NOTESP').DisplayLabel := 'Divisível';
  qryGenPre.FieldByName('ITE_PRDGRU').DisplayLabel := 'Grupo de Produto';
  qryGenPre.FieldByName('ITE_ATICOM').DisplayLabel := 'Ativo para Compras';
  qryGenPre.FieldByName('ITE_CODDIC').DisplayLabel := 'Código DIC';
  qryGenPre.FieldByName('ITE_IMPETI').DisplayLabel := 'Imprimir Etiqueta Entrada Mercadorias';
  qryGenPre.FieldByName('ITE_CODITE').DisplayLabel := 'Código';
  qryGenPre.FieldByName('ITE_DTAALT').DisplayLabel := 'Última alteração';
  qryGenPre.FieldByName('ITE_DTAUAP').DisplayLabel := 'Última Atualização do Produto';
  qryGenPre.FieldByName('ITE_CODGRU').DisplayLabel := 'Grupo';
  qryGenPre.FieldByName('ITE_TIPFRE').DisplayLabel := 'Tipo de Frete';
  qryGenPre.FieldByName('ITE_VLCFRE').DisplayLabel := fCfgSis('DESVFR');
  qryGenPre.FieldByName('ITE_LARVID').DisplayLabel := 'Largura';
  qryGenPre.FieldByName('ITE_ALTVID').DisplayLabel := 'Altura';
  qryGenPre.FieldByName('ITE_LAMAVI').DisplayLabel := 'Largura Máxima';
  qryGenPre.FieldByName('ITE_ALMAVI').DisplayLabel := 'Altura Máxima';
  qryGenPre.FieldByName('ITE_UTIAMP').DisplayLabel := 'Aplica legislação AMPARA';
  qryGenPre.FieldByName('ITE_LOTEPD').DisplayLabel := 'LOTEPD';
  qryGenPre.FieldByName('ITE_LOTEPD').DisplayLabel := 'Ordem de Serviço';
  qryGenPre.FieldByName('ITE_CLACRM').DisplayLabel := 'Classificação Oferta de Consumíveis';
  qryGenPre.FieldByName('ITE_CODONU').DisplayLabel := 'Classificação ONU';
  qryGenPre.FieldByName('ITE_PRAPEL').DisplayLabel := 'Desconto Referente Rapel';
  qryGenPre.FieldByName('ITE_PERVDA').DisplayLabel := 'Permitir venda para';
  qryGenPre.FieldByName('ITE_CAREST').DisplayLabel := 'Item estrutura em OR/PD/VN, carregar os itens da estrutura da seguinte forma';
  qryGenPre.FieldByName('ITE_BAREXP').DisplayLabel := 'Obrig. Cód. Barras Expedição';
  qryGenPre.FieldByName('ITE_SEPBAR').DisplayLabel := 'Obrig. Cód. Barras Sep. Coletor';
  qryGenPre.FieldByName('ITE_EXPSIT').DisplayLabel := 'Exportação para E-Commerce';

  If blnUtilizaChecklistGarantia Then
    qryGenPre.FieldByName('ITE_CODATC').DisplayLabel := 'Assistência técnica';

  If fCfgSis('MINPRO', varBoolean) Then
    qryGenPre.FieldByName('ITE_TPESTM').DisplayLabel := 'Tipo do Estoque Mínimo';

  If fCfgSis('SEPEXC', varBoolean) Then
    qryGenPre.FieldByName('ITE_SEPEXC').DisplayLabel := 'Item de Separação Exclusiva';

  If fCfgSis('UTIABA', varBoolean) Then
    qryGenPre.FieldByName('ITE_MLTRCA').DisplayLabel := 'Múltiplo na rotina Citel Abastece?';

  If fCfgSis('UTPEST', varBoolean) Then
  Begin
    qryGenPre.FieldByName('ITE_QTDPES').DisplayLabel := 'Qtde mín. estoque para ponta de estoque';
    qryGenPre.FieldByName('ITE_PORPES').DisplayLabel := '% de desconto aplicado para ponta de estoque';
  End;

  If fCfgSis('ETIDCE', varBoolean) Then
    qryGenPre.FieldByName('ITE_NECEXP').DisplayLabel := 'Sem necessidade de expedição';

  If fCfgSis('LOCRET', varBoolean) Then
    qryGenPre.FieldByName('ITE_TIPRET').DisplayLabel := 'Tipo de Retirada';


  If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
  Begin
    qryGenPre.FieldByName('ITE_NFEIDP').DisplayLabel := 'NFe, Imprimir o lote na descrição do produto?';
    qryGenPre.FieldByName('ITE_NFCIDP').DisplayLabel := 'NFCe, Imprimir o lote na descrição do produto?';
  End;

  If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
    qryGenPre.FieldByName('ITE_LOTRAP').DisplayLabel := 'Obrigar a digitar o número do lote no Cadastro Rápido?';

  If fCfgSis('TRITTE', varBoolean) Then
    qryGenPre.FieldByName('ITE_TRITTE').DisplayLabel := 'Permitir utilizar em Transferência de Estoque?';

  If fCfgSis('CDPHAB', varBoolean) Then
  Begin
    qryGenPre.FieldByName('ITE_CLBPIN').DisplayLabel := 'Permite pontuar no Clube do Pintor';
    qryGenPre.FieldByName('ITE_CLBPIN_NOV').DisplayLabel := 'Permite pontuar no Clube do Pintor';
  End;

  If blnUsaBef Then
  Begin
    qryGenPre.FieldByName('ITE_USABEF').DisplayLabel := 'Possui Benefício Fiscal';
    qryGenPre.FieldByName('ITE_USABEF_NOV').DisplayLabel := 'Possui Benefício Fiscal';
  End;
end;

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


procedure TfrmAltPrecoIndividual.pCriaCdsTipRet;
var
  intCnt: Integer;
  lstLocRet: TStrings;
begin
  cdsTipRet := TZClient.Create(Self, 'SELECT "00" AS VALCAM, CAST("" AS CHAR(40)) AS DESCAM');
  cdsTipRet.fLeDados('TfrmAltPrecoIndividual.pCriaCdsTipRet');
  cdsTipRet.EmptyDataSet;

  lstLocRet := TStringList.Create;
  try
      pCarregaLocalRetira(lstLocRet);
      for intCnt := 0 to lstLocRet.Count - 1 do
      begin
          cdsTipRet.Append;
          cdsTipRet.FieldByName('VALCAM').AsString := fRetSiglaLocalRetira(lstLocRet.Strings[intCnt]);
          cdsTipRet.FieldByName('DESCAM').AsString := lstLocRet.Strings[intCnt];
          cdsTipRet.Post;
      end;
      TcxLookupComboBoxProperties(cmbTipRet.Properties).ListSource := cdsTipRet.dtsSource;
  finally
    FreeAndNil(lstLocRet);
  end;
end;

procedure TfrmAltPrecoIndividual.pCriarCopiaSeguranca(strTabela: String);
var
  qryAux: TUniQuery;
  strPathCds: String;
begin
  qryAux := fCriaQuery;
  Try
    Try
      fStartTransaction;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('  DELETE FROM ALTIND WHERE IND_CODOPE = :CODOPE AND IND_CODEMP = :CODEMP AND IND_TABELA = :TABELA; ');
      qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ParamByName('TABELA').AsString := strTabela;
      qryAux.ExecSQL;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('  INSERT INTO ALTIND (AUTOINCREM, IND_TABELA, IND_CODOPE, IND_DTAALT, IND_HRAALT, IND_CODEMP, IND_QTDREG, IND_PARAMS, IND_EDITOU) ');
      qryAux.SQL.Add('              VALUES (:AUTINC, :TABELA, :CODOPE, :DTAALT, :HRAALT, :CODEMP, :QTDREG, :CDSPAR, :EDITOU)                ');
      qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('ALTIND', VS_strCodEmp);
      qryAux.ParamByName('TABELA').AsString := strTabela;
      qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryAux.ParamByName('DTAALT').AsDate := fNow;
      qryAux.ParamByName('HRAALT').AsDateTime := fNow;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ParamByName('QTDREG').AsInteger := fQtdRegistros(True);
      qryAux.ParamByName('EDITOU').AsInteger := IIF(blnAlterouAlgumRegistro, 1, 0);

      strPathCds := ExtractFilePath(ParamStr(0)) + 'params_' + strTabela+'.xml';
      cdsParametros.SaveToFile(strPathCds);
      qryAux.ParamByName('CDSPAR').LoadFromFile(strPathCds, ftBlob);
      TFile.Delete(strPathCds);

      qryAux.ExecSQL;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollback;
        pMensagensErro('Erro ao tentar criar a cópia de segurança da tabela ' + strTabela + '!','[pCriarCopiaSeguranca]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

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

procedure TfrmAltPrecoIndividual.pCriaCdsMltRca;
begin
  cdsMltRca := TZClient.Create(Self, 'SELECT "V" AS VALCAM, "VENDA"   AS DESCAM UNION ' +
                                     'SELECT "C" AS VALCAM, "COMPRA" AS DESCAM');

  cdsMltRca.fLeDados('TfrmAltPrecoGlobal.pCriaCdsMltRca');

  TcxLookupComboBoxProperties(cmbMltRca.Properties).ListSource := cdsMltRca.dtsSource;
end;

Procedure TfrmAltPrecoIndividual.pCriaCdsEsMiDg;
Begin
  cdsEsMiDg := TZClient.Create(Self, 'SELECT "G" AS VALCAM, "Gerado"   AS DESCAM UNION ' +
                                     'SELECT "D" AS VALCAM, "Digitado" AS DESCAM');

  cdsEsMiDg.fLeDados('TfrmAltPrecoGlobal.pCriaCdsEsMiDg');

  TcxLookupComboBoxProperties(cmbEsMiDg.Properties).ListSource := cdsEsMiDg.dtsSource;
End;

Procedure TfrmAltPrecoIndividual.pCriaCdsTpEstM;
Begin
  cdsTpEstM := TZClient.Create(Self, 'SELECT "" AS VALCAM, "" AS DESCAM UNION ' +
                                     'SELECT "D" AS VALCAM, "Digitado" AS DESCAM UNION ' +
                                     'SELECT "N" AS VALCAM, "Novo" AS DESCAM UNION ' +
                                     'SELECT "S" AS VALCAM, "Sazonal" AS DESCAM');

  cdsTpEstM.fLeDados('TfrmAltPrecoGlobal.pCriaCdsTpEstM');

  TcxLookupComboBoxProperties(cmbTpEstM.Properties).ListSource := cdsTpEstM.dtsSource;
End;

procedure TfrmAltPrecoIndividual.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
    intContador : Integer;

    procedure pNovaColuna(strNomCam: String);
    begin
      SetLength(colColunas, Length(colColunas) + 1);
      colColunas[Length(colColunas) - 1].blnHabili := False;
      colColunas[Length(colColunas) - 1].strNomCam := strNomCam;
    end;

begin
  blnUtilizaChecklistGarantia := TCheckListGarantiaController.fUtilizaCadastroCheckListGarantia;
  strTCOPRO := fCfgSis('TCOPRO');
  qryDetCus := fCriaQuery(Self);
  qryDetCus.SQL.Add('UPDATE DETCUS SET DET_PREVEN = :PREVEN, DET_MARBRU = :MARBRU WHERE DET_SEQDET = :SEQDET AND DET_TABELA = :TABELA');
  MomentoOperacao := moIndefinido;
  edtCodAbr.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  TipoOpcaoDeTrava := fCfgSis('TRADES', varInteger);

  qryIteCom := fCriarQuery('SELECT * FROM COMITE WHERE COM_CODITE = :CODITE AND COM_TABPRE = :TABPRE', Self);
  blnTABPRD :=  fCfgSis('TABPRD', varBoolean);
  FPermVendaIgualTodasEmp := (fCfgSis('PERVDA', varString) = '1');

  pSetaCodIte(qryDuplicCODITE);

  objAvisoAlteracaoPreco := TAvisoAlteracaoPreco.Create;

  blnVidroInteiro := (fCfgSis('VENVID', varBoolean)) And (Not fCfgSis('DECVID', varBoolean));
  strMARMKP := fCfgSis('MARMKP');

  intDecUni := fCfgSis('DECUNI', varInteger);
  intDecQtd := fCfgSis('DECQTD', varInteger);

  If fCfgSis('PCMPRO') = '2' Then
    strTCOMTB := 'Comissão'
  else  If fCfgSis('PCMPRO') = '3' Then
    strTCOMTB := fCfgSis('TCOMTB');

  blnPerComTabela   := (fCfgSis('PCMPRO') <> '1');

  pCriaCdsSimNao;
  pCriaCdsClaCRM;
  pCriaCdsFrePFU;
  pCriaCdsEsMiDg;
  pCriaCdsTpEstM;
  pCriaCdsTipPro;
  pCriaCdsTipRet;

  If fCfgSis('UTIABA', varBoolean) Then
    pCriaCdsMltRca;

  dtsPermissaoVenda.DataSet := TTipoPermissaoVenda.Dataset;

  objSalInt := TSalvaInterface.Create(Self);
  objSalInt.blnDeleteNaoEncontrados := False;

  objIteBar := TIteBar.Create(opcOperacoes);

  pTamanhoCamposLocFis(intLocFis, intLocSup, intTamLcf, intLocSep);

  intSitPro := fCfgSis('SITEMP', varInteger);

  blnBloPre := fCfgSis('BLOPRE', varBoolean);

  strLisCam := TStringList.Create;
  strLisCam.Clear;

  strLisUsu := TStringList.Create;
  strLisUsu.Clear;
  strLisUsu.Sorted := True;

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
  blnCodGpc         := fCfgSis('GS1CNP', varBoolean);

  If fCfgSIs('CADLOC', varBoolean) Then
    strTraLoc := fCfgSIs('TRALOC');

  blnLotePD         := False;
  If fCfgSis('UTIWMS', VarBoolean) Then
  Begin
    If fCfgSis('WMSLOT', varBoolean) Then
      blnLotePD := True;
  End;

  blnUsaBef := fCfgSis('USABEF', VarString) = 'S';

  qryAltPre := fCriaQuery(Self);
  qryAltPre.SQL.Text := fSQLAlteracaoPreco;

  If fCfgSis('FATPRE', varBoolean) Then
    objFatPre := TFatorPreco.Create
  Else
    objFatPre := Nil;

  If Not fCfgSis('CADMON', varBoolean) Then
    pnlCadMon.Visible := False;

  intConfirmando := -1;

  SetLength(colColunas, 0);
  //deve ficar antes de pAlimentaCdsParametros,
  //pois vários campos são ocultos dinamicamente
  pCarregaSelecao;

  pAlimentaCdsParametros;

  pCarregarCopiasSeguranca;

  pNovaColuna('ITE_CLAIPI_NOV');
  pNovaColuna('ITE_EXCIPI_NOV');

  pNovaColuna('ITE_GRUCMP_NOV');
  pNovaColuna('ITE_CODGPR_NOV');

  pNovaColuna('ITE_CDCEST_NOV');

  pNovaColuna('ITE_APLICA_NOV');

  pNovaColuna('ITE_PER_CI_NOV');
  pNovaColuna('ITE_PIMPTC_NOV');
  pNovaColuna('ITE_NUMFCI_NOV');
  pNovaColuna('ITE_PRECOM_NOV');
  pNovaColuna('ITE_PREVE1_NOV');
  pNovaColuna('ITE_PREVE1_VAR');
  pNovaColuna('ITE_PREVE2_NOV');
  pNovaColuna('ITE_PREVE2_VAR');
  pNovaColuna('ITE_PREVE3_NOV');
  pNovaColuna('ITE_PREVE3_VAR');
  pNovaColuna('ITE_PREVE4_NOV');
  pNovaColuna('ITE_PREVE4_VAR');
  pNovaColuna('ITE_PREVE5_NOV');
  pNovaColuna('ITE_PREVE5_VAR');
  pNovaColuna('ITE_PREVE6_NOV');
  pNovaColuna('ITE_PREVE6_VAR');
  pNovaColuna('ITE_PREVE7_NOV');
  pNovaColuna('ITE_PREVE7_VAR');
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

  if fCfgSis('MARPAD') = 'S' Then
  Begin
    pNovaColuna('ITE_MARPAD_NOV');
    pNovaColuna('ITE_MARPAD_VAR');
  End;

  if not blnIteTbp Then
  Begin
    pNovaColuna('ITE_DESMAX_NOV');
    pNovaColuna('ITE_DESMVM_NOV');

    pNovaColuna('ITE_DESMGE_NOV');
    pNovaColuna('ITE_DESMGM_NOV');

    pNovaColuna('ITE_DESMSU_NOV');
    pNovaColuna('ITE_DESMSM_NOV');
  End
  Else
  Begin
    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      pNovaColuna('ITE_DESMA' + intToStr(intCont) + '_NOV');
      pNovaColuna('ITE_DESVM' + intToStr(intCont) + '_NOV');

      pNovaColuna('ITE_DESMG' + intToStr(intCont) + '_NOV');
      pNovaColuna('ITE_DESGM' + intToStr(intCont) + '_NOV');

      pNovaColuna('ITE_DESMS' + intToStr(intCont) + '_NOV');
      pNovaColuna('ITE_DESSM' + intToStr(intCont) + '_NOV');
    End;
  End;

  If (fCfgSis('OPCCOM') <> 'PPT') Then
  begin
    pNovaColuna('ITE_COMVAR_NOV');
    pNovaColuna('ITE_COMATA_NOV');
    pNovaColuna('ITE_COMDIS_NOV');
  end;
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
  pNovaColuna('ITE_GRAMAR_NOV');

  pNovaColuna('ITE_EXPPOK_NOV');

  pNovaColuna('ITE_IMPDIR_NOV');
  pNovaColuna('ITE_USAPPF_NOV');

  pNovaColuna('ITE_LOCFIS_NOV');
  pNovaColuna('ITE_ESTMAX_NOV');
  pNovaColuna('ITE_ESTMIN_NOV');
  pNovaColuna('ITE_MAXDIG_NOV');
  pNovaColuna('ITE_MINDIG_NOV');
  pNovaColuna('ITE_TAMLCF_NOV');
  pNovaColuna('ITE_LOCSUP_NOV');
  pNovaColuna('ITE_USAPCV_NOV');
  pNovaColuna('ITE_USAPFD_NOV');
  pNovaColuna('ITE_TAMLCS_NOV');
  pNovaColuna('ITE_CODLSE_NOV');
  pNovaColuna('ITE_PRECUS_NOV');
  pNovaColuna('ITE_PRECUS_VAR');
  pNovaColuna('ITE_CUSREA_NOV');
//  pNovaColuna('ITE_ABRFIS_NOV');
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
  If fCampoVisivel('RSPGAR') Then
  Begin
    pNovaColuna('ITE_TMPGAR_NOV');
    pNovaColuna('ITE_INFGAR_NOV');
    pNovaColuna('ITE_RSPGAR_NOV');
  End;
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

  If fCampoVisivel('NVLCRI') Then
    pNovaColuna('ITE_NVLCRI_NOV');

  If fCampoVisivel('NIVCRI') Then
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

  pNovaColuna('ITE_DTAEPI_NOV');

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

  if fCampoVisivel('CODDIC') Then
    pNovaColuna('ITE_CODDIC_NOV');

  if fCampoVisivel('IMPETI') Then
    pNovaColuna('ITE_IMPETI_NOV');

  If fCampoVisivel('DENSID') Then
    pNovaColuna('ITE_DENSID_NOV');

  If fCampoVisivel('PESOBR') Then
    pNovaColuna('ITE_PESOBR_NOV');

  pNovaColuna('ITE_CAREST_NOV');

  pNovaColuna('ITE_CODGRU_NOV');
  pNovaColuna('ITE_TIPFRE_NOV');
  pNovaColuna('ITE_VLCFRE_NOV');
  pNovaColuna('ITE_CODLSE_NOV');

  If fUsaRotinaWMS Then
    pNovaColuna('ITE_RASTRE_NOV');

  pNovaColuna('ITE_FATCMP_NOV');
  pNovaColuna('ITE_FATPM3_NOV');

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
  pNovaColuna('ITE_PERVDA_NOV');

  pNovaColuna('ITE_CPESOB_NOV');

  If fCampoVisivel('DESCND') Then
    pNovaColuna('ITE_DESCND_NOV');

  If fCampoVisivel('DESCHK') Then
    pNovaColuna('ITE_DESCHK_NOV');

  If Pos(fCadEmp('ESTADO'), ESTADOS_REGRA_ZONA_FRANCA ) > 0 Then
  begin
    pNovaColuna('ITE_CICMDE_NOV');
    pNovaColuna('ITE_CDPIOP_NOV');
    pNovaColuna('ITE_DIDIOP_NOV');
  End;

  pNovaColuna('ITE_TCIFCU_NOV');
  pNovaColuna('ITE_TSCUST_NOV');
  pNovaColuna('ITE_DEPICO_NOV');
  pNovaColuna('ITE_DEICMS_NOV');
  pNovaColuna('ITE_FATREG_NOV');


  If (blnCodGpc) Then
    pNovaColuna('ITE_CODGPC_NOV');

  If fCampoVisivel('APERET') Then
    pNovaColuna('ITE_APERET_NOV');

  If fCampoVisivel('APEENT') Then
    pNovaColuna('ITE_APEENT_NOV');

  If fCampoVisivel('NOMECO') Then
    pNovaColuna('ITE_NOMECO_NOV');

  If fCampoVisivel('APLECO') Then
    pNovaColuna('ITE_APLECO_NOV');

  If fCampoVisivel('DESECO') Then
    pNovaColuna('ITE_DESECO_NOV');

  If fCampoVisivel('EXPALT') Then
    pNovaColuna('ITE_EXPALT_NOV');

  If fCampoVisivel('EXPLAR') Then
    pNovaColuna('ITE_EXPLAR_NOV');

  If fCampoVisivel('EXPPRO') Then
    pNovaColuna('ITE_EXPPRO_NOV');

  If fCampoVisivel('BAREXP') Then
    pNovaColuna('ITE_BAREXP_NOV');

  If fCampoVisivel('SEPBAR') Then
    pNovaColuna('ITE_SEPBAR_NOV');

  If fCampoVisivel('EXPSIT') Then
    pNovaColuna('ITE_EXPSIT_NOV');

  If fCfgSis('OPCCOM', varString) = 'VT' Then
  Begin
    For intContador := 1 To Length(VS_strTabPrc) Do
    Begin
      If VS_strTabPrc[intContador] = 'S' Then
      Begin
        pNovaColuna('COM_VENIN'+IntToStr(intContador)+'_NOV');
        pNovaColuna('COM_VENEX'+IntToStr(intContador)+'_NOV');
      End;
    End;
  End;

  If fCampoVisivel('EMPCAR') Then
    pNovaColuna('ITE_EMPCAR_NOV');

  If fCampoVisivel('EMPSUG') Then
    pNovaColuna('ITE_EMPSUG_NOV');

  if blnUtilizaChecklistGarantia then
  begin
    pNovaColuna('ITE_CODATC_NOV');
    pNovaColuna('TMP_CKLGAR_NOV');
    pNovaColuna('TMP_CKLTRO_NOV');
  end;

  If fCfgSis('SEPEXC', varBoolean) Then
    pNovaColuna('ITE_SEPEXC_NOV');

  if fCfgSis('MINPRO', varBoolean) Then
    pNovaColuna('ITE_TPESTM_NOV');

  If fCampoVisivel('SOBENC') Then
    pNovaColuna('ITE_SOBENC_NOV');

  If fCfgSis('UTPEST', varBoolean) Then
  Begin
    pNovaColuna('ITE_QTDPES_NOV');
    pNovaColuna('ITE_PORPES_NOV');
  End;

  If fCfgSis('UTIABA', varBoolean) Then
    pNovaColuna('ITE_MLTRCA_NOV');

  If fCampoVisivel('NECEXP') Then
    pNovaColuna('ITE_NECEXP_NOV');

  If fCampoVisivel('TIPRET') Then
    pNovaColuna('ITE_TIPRET_NOV');


  If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
  Begin
    If fCampoVisivel('NFEIDP') Then
      pNovaColuna('ITE_NFEIDP_NOV');

    If fCampoVisivel('NFCIDP') Then
      pNovaColuna('ITE_NFCIDP_NOV');
  End;

  If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
  Begin
    If fCampoVisivel('LOTRAP') Then
      pNovaColuna('ITE_LOTRAP_NOV');
  End;

  If fCfgSis('TRITTE', varBoolean) Then
    pNovaColuna('ITE_TRITTE_NOV');

  If fCampoVisivel('ITEBAS') Then
    pNovaColuna('ITE_ITEBAS_NOV');

  If fCampoVisivel('CLBPIN') Then
    pNovaColuna('ITE_CLBPIN_NOV');

  If blnUsaBef Then
    pNovaColuna('ITE_USABEF_NOV');

  strCusto := 'ITE_PRECOM_NOV_' + 'ITE_DESF01_NOV_' + 'ITE_DESF02_NOV_' +
              'ITE_DESF03_NOV_' + 'ITE_DESF04_NOV_' + 'ITE_DESF05_NOV_' +
              'ITE_DESF06_NOV_' + 'ITE_ICMENT_NOV_' + 'ITE_IPIENT_NOV_' +
              'ITE_FREENT_NOV_' + 'ITE_ACRFIN_NOV_' + 'ITE_SUBSTI_NOV_' +
              'ITE_DESADB_NOV_' + 'ITE_DESOPE_NOV_' + 'ITE_OUTVAL_NOV_' +
              'ITE_IMPFED_NOV_' + 'ITE_VALFRE_NOV_' + 'ITE_SUBFED_NOV_' +
              'ITE_TCIFCU_NOV_' + 'ITE_TSCUST_NOV_' +
              'ITE_DEPICO_NOV_' + 'ITE_DEICMS_NOV_' + 'ITE_FATREG_NOV_';


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
  qryGen.AfterPost      := pAfterPost;
  qryGen.BeforePost     := pBeforePost;
  qryGen.OnFilterRecord := pFilterRecord;

  dbeCodIte.DataSource   := dtsGen;
  dbeDesIte.DataSource   := dtsGen;
  dbeRefere.DataSource   := dtsGen;
  dbeUnidad.DataSource   := dtsGen;
  dbeAltPre.DataSource   := dtsGen;
  dbePosEmb.DataSource   := dtsGen;
  dbeDtaUve.DataSource   := dtsGen;

  pAtribuiTabelas;
  qryGen.BeforePost := pAtualizaDados;
  pMostraColunasAntigasCx(False);

  qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE', Self);
  fAbrirTabela(qryPreAlt);

  pnlBusca.Visible := False;

  edtDocumento.MaxLength := fTamNumDoc();
  edtDocumento.TamCampo  := edtDocumento.MaxLength;

  //CFG_INFMED Altura Ou Comprimento
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
  cxeConsTamLse.Properties.MaxLength := fTamCodLse;

  pMontaCampos;

  cdsParametros.First;

  If Not blnRestaurandoCopiaSeg Then
    blnAlterouAlgumRegistro:= False;
end;

procedure TfrmAltPrecoIndividual.pAjustarCdsParametros;
begin
  Try
    cdsParametros.DisableControls;
    cdsParametros.First;
    While Not cdsParametros.Eof Do
    Begin
      cdsParametros.Edit;
      cdsParametrosMARCADO.AsBoolean := cdsParamsRestaurado.Locate('CAMPO', cdsParametros.FieldByName('CAMPO').AsString, []);
      cdsParametros.Post;
      cdsParametros.Next;
    End;
    cdsParametros.EnableControls;

  Finally
    FreeAndNil(cdsParamsRestaurado);
  End;
end;

procedure TfrmAltPrecoIndividual.pCarregarCopiasSeguranca;
var
  frmCopiasAltIndividual: TfrmCopiasAltIndividual;
begin
  Try
    MomentoOperacao := moFiltros;
    frmCopiasAltIndividual := TfrmCopiasAltIndividual.Create(Nil);
    If frmCopiasAltIndividual.blnMostrarForm Then
      frmCopiasAltIndividual.ShowModal;
  Finally
    strTabela := frmCopiasAltIndividual.strTabela;
    blnRestaurandoCopiaSeg := frmCopiasAltIndividual.blnRestaurou;
    If blnRestaurandoCopiaSeg Then
    Begin
      cdsParamsRestaurado := frmCopiasAltIndividual.cdsParamsRestaurado;
      pAjustarCdsParametros;

      MomentoOperacao := moFiltros;

      blnAlterouAlgumRegistro := frmCopiasAltIndividual.blnHouveEdicao;

    End;
    FreeAndNil(frmCopiasAltIndividual);
  End;
end;

procedure TfrmAltPrecoIndividual.FormDestroy(Sender: TObject);
begin

  inherited;
  If Assigned(FrameAlteraPrecoIndividual) Then
  Begin
    FrameAlteraPrecoIndividual.pLiberaOrdenacao;
    FreeAndNil(FrameAlteraPrecoIndividual.lstOrdemResgistros);
  End;

  If Assigned(FrameAlteraPrecoIndividual) Then
    FreeAndNil(FrameAlteraPrecoIndividual);

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);

  If Assigned(objIteBar) Then
    FreeAndNil(objIteBar);

  If Assigned(objAvisoAlteracaoPreco) Then
    FreeAndNil(objAvisoAlteracaoPreco);

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

procedure TfrmAltPrecoIndividual.edtGirEstKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Not CharInSet(UpperCase(Key)[1],['A', 'B', 'C', 'T'])) Then
    Key := #0;
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
  cdsParametros.Locate('CAMPO','CODITE', []);
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
    strSQLFields : String;
    strCamposTemporary: String;
    strTabPrc : String;
    intCorre  : Integer;
    qryGenTmp : TUniQuery;
    intContador: Integer;
    i: integer;


    procedure pAddCampoTableTemporary(strCampo: String; strTipoCampo: string; blnInsereNovo: Boolean = True; blnVirgulaFim: Boolean = True);
    Begin
      If blnInsereNovo Then
      Begin
        strSQL := strSQL + strCampo + '_NOV ' + strTipoCampo + ',';
        strCamposTemporary :=  strCamposTemporary +  strCampo + '_NOV,';
      End;
      strSQL := strSQL + strCampo + ' ' + strTipoCampo + IIf(blnVirgulaFim, ',', '');
      strCamposTemporary :=  strCamposTemporary +  strCampo + IIf(blnVirgulaFim, ',', '');
    End;


    procedure pAddCampoSelect(strAlias: String; strComand: String; blnInsereNovo: Boolean = True);
    begin
      If blnInsereNovo Then
        strSQLFields := strSQLFields + ' ' + strComand + ' AS ' + strAlias + '_NOV,';
      strSQLFields := strSQLFields + ' ' + strComand + ' AS ' + strAlias + ','
    End;
Begin
  Try
    strTabPrc := '';

    qryGenTmp := fCriaQuery(Self);

    strTabela := 'ALTPRE_TMP_' + fRetSeqTmp;

    strSQL := '';

    {******************************}
    {* SELECT PARA CARREGAR DADOS *}
    {***************************AF*}
     strSQLFields := '';

	If fTabelaExiste(strTabela) Then
      strSQL := strSQL + 'DROP TABLE ' + strTabela + ';';

    strSQL := strSQL + 'CREATE TABLE ' + strTabela + '( ';

    pAddCampoTableTemporary('ITE_CODITE'   , fRetornaTipoDoCampo('CADITE', 'ITE_CODITE'), False);
    pAddCampoSelect('ITE_CODITE', 'I.ITE_CODITE', False);

    pAddCampoTableTemporary('ITE_DESITE'   ,'VARCHAR('+fRetFieldCharLength('CADITE', 'ITE_DESITE')+')', False);
    pAddCampoSelect('ITE_DESITE', 'I.ITE_DESITE', False);

    pAddCampoTableTemporary('ITE_DESSIM'   ,'VARCHAR(70)', False);
    pAddCampoSelect('ITE_DESSIM', 'I.ITE_DESSIM', False);

    pAddCampoTableTemporary('ITE_DESFAB'   ,'VARCHAR(70)', False);
    pAddCampoSelect('ITE_DESFAB', 'I.ITE_DESFAB', False);

    pAddCampoTableTemporary('ITE_DIFICM'   ,'VARCHAR(1)', False);
    pAddCampoSelect('ITE_DIFICM', 'I.ITE_DIFICM', False);

    pAddCampoTableTemporary('ITE_MSGLV1'   ,'VARCHAR(50)', False);
    pAddCampoSelect('ITE_MSGLV1', 'I.ITE_MSGLV1', False);

    pAddCampoTableTemporary('ITE_MSGLV2'   ,'VARCHAR(50)', False);
    pAddCampoSelect('ITE_MSGLV2', 'I.ITE_MSGLV2', False);

    pAddCampoTableTemporary('ITE_IMPULT'   ,'NUMERIC(12, 4)', False);
    pAddCampoSelect('ITE_IMPULT', 'G.ITE_IMPULT', False);

    pAddCampoTableTemporary('ITE_PREULT'   ,'NUMERIC(12, 4)', False);
    pAddCampoSelect('ITE_PREULT', 'G.ITE_PREULT', False);

    pAddCampoTableTemporary('ITE_DTAULT'   ,'DATE', False);
    pAddCampoSelect('ITE_DTAULT', 'G.ITE_DTAULT', False);

    pAddCampoTableTemporary('ITE_QTDUCO'   ,'NUMERIC(12, 4)', False);
    pAddCampoSelect('ITE_QTDUCO', 'G.ITE_QTDUCO', False);

    pAddCampoTableTemporary('ITE_PREDOL'   ,'CHAR(1)', False);
    pAddCampoSelect('ITE_PREDOL', 'IFNULL(G.ITE_PREDOL, "N")', False);

    pAddCampoTableTemporary('ITE_REFERE'   ,'VARCHAR(' + fTamRefere.ToString+')', False);
    pAddCampoSelect('ITE_REFERE', 'I.ITE_REFERE', False);

    pAddCampoTableTemporary('ITE_SALDOS'   ,'NUMERIC(12, 4)', False);
    pAddCampoSelect('ITE_SALDOS', 'G.ITE_SALDOS', False);

    pAddCampoTableTemporary('ITE_PREMED'   ,'NUMERIC(12, 4)', False);
    pAddCampoSelect('ITE_PREMED', 'G.ITE_PREMED', False);

    pAddCampoTableTemporary('ITE_DTAALT'   ,'DATE', False);
    pAddCampoSelect('ITE_DTAALT', 'NULL', False);

    pAddCampoTableTemporary('ITE_DTAUAP'   ,'DATE', False);
    pAddCampoSelect('ITE_DTAUAP', 'I.ITE_DTAALT', False);


    For i := 1 To 7 do
    Begin
     pAddCampoTableTemporary('ITE_PR'+i.tostring+'ANT'   ,'NUMERIC(12, 4)', False);
     pAddCampoSelect('ITE_PR'+i.tostring+'ANT', 'NULL', False);
    End;

    pAddCampoTableTemporary('ITE_CODGRU'    ,'VARCHAR(06)');
    pAddCampoSelect('ITE_CODGRU', 'I.ITE_CODGRU');

    pAddCampoTableTemporary('GRU_DESGRU'    ,'VARCHAR(70)');
    pAddCampoSelect('GRU_DESGRU', 'GRU_DESGRU');

    pAddCampoTableTemporary('ITE_TIPFRE'    ,'VARCHAR(1)');
    pAddCampoSelect('ITE_TIPFRE', 'I.ITE_TIPFRE');

    pAddCampoTableTemporary('ITE_ESMIDG'    ,'VARCHAR(1)');
    pAddCampoSelect('ITE_ESMIDG', 'G.ITE_ESMIDG');

    if fCfgSis('MINPRO', varBoolean) Then
    Begin
      pAddCampoTableTemporary('ITE_TPESTM'  ,'VARCHAR(1)');
      pAddCampoSelect('ITE_TPESTM', 'G.ITE_TPESTM');
    End;

    pAddCampoTableTemporary('ITE_VLCFRE'    ,'NUMERIC(12, 4)');
    pAddCampoSelect('ITE_VLCFRE', 'I.ITE_VLCFRE');

    pAddCampoTableTemporary('ITE_CLAIPI'    ,'VARCHAR(10)');
    pAddCampoSelect('ITE_CLAIPI', 'I.ITE_CLAIPI');

    pAddCampoTableTemporary('ITE_EXCIPI'    ,'CHAR(3)');
    pAddCampoSelect('ITE_EXCIPI', 'I.ITE_EXCIPI');

    pAddCampoTableTemporary('ITE_GRUCMP'    ,'VARCHAR(3)');
    pAddCampoSelect('ITE_GRUCMP', 'I.ITE_GRUCMP');

    pAddCampoTableTemporary('GRU_DESCRI'    ,'VARCHAR(40)');
    pAddCampoSelect('GRU_DESCRI', 'GRU_DESCRI');

    pAddCampoTableTemporary('ITE_CODGPR'    ,'VARCHAR(6)');
    pAddCampoSelect('ITE_CODGPR', 'I.ITE_CODGPR');

    pAddCampoTableTemporary('GPR_DESCRI'    ,'VARCHAR(40)');
    pAddCampoSelect('GPR_DESCRI', 'GPR_DESCRI');

    pAddCampoTableTemporary('ITE_RECDEV'    ,'VARCHAR(1)');
    pAddCampoSelect('ITE_RECDEV', 'G.ITE_RECDEV');

    pAddCampoTableTemporary('ITE_CDCEST'    ,'CHAR(7)');
    pAddCampoSelect('ITE_CDCEST', 'I.ITE_CDCEST');

    pAddCampoTableTemporary('CES_DESCRI'    ,'CHAR(255)');
    pAddCampoSelect('CES_DESCRI', 'CONVERT(CES_DESCRI, CHAR(255))');

    pAddCampoTableTemporary('ITE_APLICA'    ,'TEXT');
    pAddCampoSelect('ITE_APLICA', 'REPLACE(I.ITE_APLICA, "<<csq>>", "\n")');

    pAddCampoTableTemporary('ITE_PER_CI'    ,'NUMERIC(12,2)');
    pAddCampoSelect('ITE_PER_CI', 'I.ITE_PER_CI');

    pAddCampoTableTemporary('ITE_PIMPTC'    ,'NUMERIC(12,2)');
    pAddCampoSelect('ITE_PIMPTC', 'I.ITE_PIMPTC');

    pAddCampoTableTemporary('ITE_NUMFCI'    ,'VARCHAR(50)');
    pAddCampoSelect('ITE_NUMFCI', 'I.ITE_NUMFCI');

    pAddCampoTableTemporary('ITE_PRECOM'    ,'NUMERIC(12, 4)');
    pAddCampoSelect('ITE_PRECOM', 'G.ITE_PRECOM');

    For i := 1 To 7 do
    Begin
     pAddCampoTableTemporary('ITE_PREVE' + i.ToString    ,'NUMERIC(12, 4)');
     pAddCampoSelect('ITE_PREVE' + i.ToString, 'G.ITE_PREVE' + i.ToString );
     pAddCampoTableTemporary('ITE_PREVE'+ i.ToString+ '_VAR','NUMERIC(12, 4)', False);
     pAddCampoSelect('ITE_PREVE'+ i.ToString+ '_VAR' + i.ToString, '0.0000', False);
    End;

    For i:= 1 To 6 Do
    Begin
     pAddCampoTableTemporary('ITE_DESF0' + i.ToString,' NUMERIC(12, 2)');
     pAddCampoSelect('ITE_DESF0' + i.ToString, 'G.ITE_DESF0' + i.ToString );
    End;

    pAddCampoTableTemporary('ITE_ICMENT',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_ICMENT', 'G.ITE_ICMENT');

    pAddCampoTableTemporary('ITE_SUBFED',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_SUBFED', 'G.ITE_SUBFED');

    pAddCampoTableTemporary('ITE_IPIENT',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_IPIENT', 'G.ITE_IPIENT');

    pAddCampoTableTemporary('ITE_ABAMLT',' CHAR(1)');
    pAddCampoSelect('ITE_ABAMLT', 'G.ITE_ABAMLT');

    pAddCampoTableTemporary('ITE_FREENT',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_FREENT', 'G.ITE_FREENT');

    pAddCampoTableTemporary('ITE_VALFRE',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_VALFRE', 'G.ITE_VALFRE');

    pAddCampoTableTemporary('ITE_ACRFIN',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_ACRFIN', 'G.ITE_ACRFIN');

    pAddCampoTableTemporary('ITE_SUBSTI',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_SUBSTI', 'G.ITE_SUBSTI');

    pAddCampoTableTemporary('ITE_DESADB',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_DESADB', 'G.ITE_DESADB');

    pAddCampoTableTemporary('ITE_OUTVAL',' NUMERIC(12, 4)');
    pAddCampoSelect('ITE_OUTVAL', 'G.ITE_OUTVAL');

    pAddCampoTableTemporary('ITE_ICMSAI',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_ICMSAI', 'G.ITE_ICMSAI');

    pAddCampoTableTemporary('ITE_IPISAI',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_IPISAI', 'G.ITE_IPISAI');

    pAddCampoTableTemporary('ITE_IMPFED',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_IMPFED', 'G.ITE_IMPFED');

    pAddCampoTableTemporary('ITE_MLTCOM',' NUMERIC(12,2)');
    pAddCampoSelect('ITE_MLTCOM', 'I.ITE_MLTCOM');

    pAddCampoTableTemporary('ITE_MLTVEN',' NUMERIC(12,4)');
    pAddCampoSelect('ITE_MLTVEN', 'I.ITE_MLTVEN');

    pAddCampoTableTemporary('ITE_DESOPE',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_DESOPE', 'G.ITE_DESOPE');

    if fCfgSis('MARPAD') = 'S' Then
    Begin
      pAddCampoTableTemporary('ITE_MARPAD',' NUMERIC(12, 2)');
      pAddCampoSelect('ITE_MARPAD', 'G.ITE_MARPAD');
    End;

    pAddCampoTableTemporary('ITE_TCIFCU',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_TCIFCU', 'G.ITE_TCIFCU');

    pAddCampoTableTemporary('ITE_TSCUST',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_TSCUST', 'G.ITE_TSCUST');

    pAddCampoTableTemporary('ITE_DEPICO',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_DEPICO', 'G.ITE_DEPICO');

    pAddCampoTableTemporary('ITE_DEICMS',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_DEICMS', 'G.ITE_DEICMS');

    pAddCampoTableTemporary('ITE_FATREG',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_FATREG', 'G.ITE_FATREG');

    if not blnIteTbp Then
    Begin
       pAddCampoTableTemporary('ITE_DESMAX'  ,'NUMERIC(12, 2)');
       pAddCampoSelect('ITE_DESMAX', 'IFNULL(G.ITE_DESMAX,0)');

       pAddCampoTableTemporary('ITE_DESMGE'  ,'NUMERIC(12, 2)');
       pAddCampoSelect('ITE_DESMGE', 'IFNULL(G.ITE_DESMGE,0)');

       pAddCampoTableTemporary('ITE_DESMSU'  ,'NUMERIC(12, 2)');
       pAddCampoSelect('ITE_DESMSU', 'IFNULL(G.ITE_DESMSU,0)');

       pAddCampoTableTemporary('ITE_DESMVM'  ,'NUMERIC(12, 2)');
       pAddCampoSelect('ITE_DESMVM', 'IFNULL(G.ITE_DESMVM,0)');

       pAddCampoTableTemporary('ITE_DESMGM'  ,'NUMERIC(12, 2)');
       pAddCampoSelect('ITE_DESMGM', 'IFNULL(G.ITE_DESMGM,0)');

       pAddCampoTableTemporary('ITE_DESMSM'  ,'NUMERIC(12, 2)');
       pAddCampoSelect('ITE_DESMSM', 'IFNULL(G.ITE_DESMSM,0)');

    End
    Else
    Begin
      For intCorre := 1 To Length(VS_strTabPrc) Do
      Begin
        pAddCampoTableTemporary('ITE_DESMA' + intToStr(intCorre) ,'NUMERIC(12, 2)');
        pAddCampoTableTemporary('ITE_DESMG' + intToStr(intCorre) ,'NUMERIC(12, 2)');
        pAddCampoTableTemporary('ITE_DESMS' + intToStr(intCorre) ,'NUMERIC(12, 2)');

        pAddCampoTableTemporary('ITE_DESVM' + intToStr(intCorre) ,'NUMERIC(12, 2)');
        pAddCampoTableTemporary('ITE_DESGM' + intToStr(intCorre) ,'NUMERIC(12, 2)');
        pAddCampoTableTemporary('ITE_DESSM' + intToStr(intCorre) ,'NUMERIC(12, 2)');
        strSQLFields := strSQLFields + fAddIteTbp(intCorre);
      End;
    End;

    If (fCfgSis('OPCCOM') <> 'PPT') Then
    begin
      pAddcampoTableTemporary('ITE_COMVAR',' NUMERIC(12, 2)');
      pAddCampoSelect('ITE_COMVAR', 'G.ITE_COMVAR');

      pAddcampoTableTemporary('ITE_COMATA',' NUMERIC(12, 2)');
      pAddCampoSelect('ITE_COMATA', 'G.ITE_COMATA');

      pAddcampoTableTemporary('ITE_COMDIS',' NUMERIC(12, 2)');
      pAddCampoSelect('ITE_COMDIS', 'G.ITE_COMDIS');
    end;
    pAddcampoTableTemporary('ITE_COMDIG',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_COMDIG', 'G.ITE_COMDIG');

    pAddcampoTableTemporary('ITE_COMPRO',' NUMERIC(12, 2)');
    pAddCampoSelect('ITE_COMPRO', 'G.ITE_COMPRO');

    pAddcampoTableTemporary('ITE_QTPPRO',' DECIMAL(14, 2)');
    pAddCampoSelect('ITE_QTPPRO', 'G.ITE_QTPPRO');

    pAddcampoTableTemporary('ITE_CPRCEN',' CHAR(1)');
    pAddCampoSelect('ITE_CPRCEN', 'G.ITE_CPRCEN');

    pAddcampoTableTemporary('ITE_PESOIT',' DECIMAL(14,4)');
    pAddCampoSelect('ITE_PESOIT', 'I.ITE_PESOIT');

    pAddcampoTableTemporary('ITE_PESLIQ',' DECIMAL(14,4)');
    pAddCampoSelect('ITE_PESLIQ', 'I.ITE_PESLIQ');

    pAddcampoTableTemporary('ITE_INFLAM',' CHAR(1)');
    pAddCampoSelect('ITE_INFLAM', 'I.ITE_INFLAM');

    pAddcampoTableTemporary('ITE_USABON',' CHAR(1)');
    pAddCampoSelect('ITE_USABON', 'I.ITE_USABON');

    pAddcampoTableTemporary('ITE_USAFLE',' CHAR(1)');
    pAddCampoSelect('ITE_USAFLE', 'I.ITE_USAFLE');

    pAddcampoTableTemporary('ITE_OBRCPF',' CHAR(1)');
    pAddCampoSelect('ITE_OBRCPF', 'I.ITE_OBRCPF');

    pAddcampoTableTemporary('ITE_OBRIBA',' CHAR(1)');
    pAddCampoSelect('ITE_OBRIBA', 'I.ITE_OBRIBA');

    pAddcampoTableTemporary('ITE_OBRNFE',' CHAR(1)');
    if fCfgSis('NFEPEP', varBoolean) then
      pAddCampoSelect('ITE_OBRNFE', 'G.ITE_OBRNFE')
    else
      pAddCampoSelect('ITE_OBRNFE', 'I.ITE_OBRNFE');

    pAddcampoTableTemporary('ITE_NVLGIR',' CHAR(1)');
    pAddCampoSelect('ITE_NVLGIR', 'I.ITE_NVLGIR');

    pAddcampoTableTemporary('ITE_NVLCRI',' CHAR(1)');
    pAddCampoSelect('ITE_NVLCRI', 'I.ITE_NVLCRI');

    pAddcampoTableTemporary('ITE_NIVCRI',' CHAR(1)');
    pAddCampoSelect('ITE_NIVCRI', 'G.ITE_NIVCRI');

    pAddcampoTableTemporary('ITE_PROEMB',' CHAR(1)');
    pAddCampoSelect('ITE_PROEMB', 'I.ITE_PROEMB');

    pAddcampoTableTemporary('ITE_ACOOBJ',' VARCHAR(20)');
    pAddCampoSelect('ITE_ACOOBJ', 'I.ITE_ACOOBJ');

    pAddcampoTableTemporary('ITE_VALOBR',' CHAR(1)');
    pAddCampoSelect('ITE_VALOBR', 'I.ITE_VALOBR');

    For i := 1 To 7 do
    Begin
      pAddCampoTableTemporary('ITE_MARBR' +i.Tostring, 'NUMERIC(18, ' + fRetPrecisaoMargemItem.ToString + ')');
      pAddCampoSelect('ITE_MARBR' +i.Tostring, 'G.ITE_MARBR' +i.Tostring);

      pAddCampoTableTemporary('ITE_MARID' +i.Tostring, 'NUMERIC(12,2)');
      pAddCampoSelect('ITE_MARID' +i.Tostring, 'G.ITE_MARID' +i.Tostring);

      pAddCampoTableTemporary('ITE_COMTB' +i.Tostring, 'NUMERIC(12,2)');
      pAddCampoSelect('ITE_COMTB' +i.Tostring, 'G.ITE_COMTB' +i.Tostring);
    End;

    pAddcampoTableTemporary('ITE_CODABF','VARCHAR('+IIf(fCfgSis('USASAN') = 'S', '7', '3') + ')');
    If fCfgSIs('TIPABF') = '1' Then
      pAddCampoSelect('ITE_CODABF', 'I.ITE_CODABF')
    Else
      pAddCampoSelect('ITE_CODABF', 'G.ITE_CODABF');

    pAddcampoTableTemporary('ABF_DESABF','VARCHAR(100)');
    pAddCampoSelect('ABF_DESABF', 'ABF_DESABF');

    pAddcampoTableTemporary('ITE_ABFPIS','VARCHAR(03)');
    pAddcampoTableTemporary('ITE_ABFCOF','VARCHAR(03)');
    pAddcampoTableTemporary('ITE_ABFIPI','VARCHAR(03)');

    If fCfgSis('TPABPC') = '1' Then
    Begin
      pAddCampoSelect('ITE_ABFPIS', 'I.ITE_ABFPIS');
      pAddCampoSelect('ITE_ABFCOF', 'I.ITE_ABFCOF');
      pAddCampoSelect('ITE_ABFIPI', 'I.ITE_ABFIPI');
    End
    Else
    Begin
      pAddCampoSelect('ITE_ABFPIS', 'G.ITE_ABFPIS');
      pAddCampoSelect('ITE_ABFCOF', 'G.ITE_ABFCOF');
      pAddCampoSelect('ITE_ABFIPI', 'G.ITE_ABFIPI');
    End;


    pAddcampoTableTemporary('APC_DESPIS','VARCHAR(50)');
    pAddCampoSelect('APC_DESPIS', 'PIS.APC_DESCRI');

    pAddcampoTableTemporary('APC_DESCOF','VARCHAR(50)');
    pAddCampoSelect('APC_DESCOF', 'COF.APC_DESCRI');

    pAddcampoTableTemporary('APC_DESIPI','VARCHAR(50)');
    pAddCampoSelect('APC_DESIPI', 'IPI.APC_DESCRI');

    pAddcampoTableTemporary('ITE_INCPIS','CHAR(1)');
    pAddCampoSelect('ITE_INCPIS', 'I.ITE_INCPIS');

    pAddcampoTableTemporary('ITE_COMLUB','VARCHAR(1)');
    pAddCampoSelect('ITE_COMLUB', 'I.ITE_COMLUB');

    pAddcampoTableTemporary('ITE_IMPLIS','VARCHAR(1)');
    pAddCampoSelect('ITE_IMPLIS', 'G.ITE_IMPLIS');

    pAddcampoTableTemporary('ITE_ITEATI','VARCHAR(1)');
    pAddCampoSelect('ITE_ITEATI', 'I.ITE_ITEATI');

    pAddcampoTableTemporary('ITE_GRAMAR','VARCHAR(1)');
    pAddCampoSelect('ITE_GRAMAR', 'I.ITE_GRAMAR');

    pAddcampoTableTemporary('ITE_BARPRI','VARCHAR(70)', False);
    pAddCampoSelect('ITE_BARPRI', 'B.BAR_CODBAR', False);

    pAddcampoTableTemporary('ITE_BARPRV','VARCHAR(70)', False);
    pAddCampoSelect('ITE_BARPRV', 'B.BAR_CODBAR', False);

    pAddcampoTableTemporary('ITE_EMBPRI','DECIMAL (20,' +  IntToStr(DEC_EMBALAGEM) + ')', False);
    pAddCampoSelect('ITE_EMBPRI', 'B.BAR_EMBALA', False);

    pAddcampoTableTemporary('ITE_EMBPRV','DECIMAL (20,8)', False);
    pAddCampoSelect('ITE_EMBPRV', 'B.BAR_EMBALA', False);

    pAddcampoTableTemporary('ITE_BARPRP','VARCHAR(70)', False);
    pAddCampoSelect('ITE_BARPRP', 'E.BAR_CODBAR', False);

    pAddcampoTableTemporary('ITE_BARPRC','VARCHAR(70)', False);
    pAddCampoSelect('ITE_BARPRC', 'E.BAR_CODBAR', False);

    pAddcampoTableTemporary('ITE_EMBPRC','DECIMAL (20,8)', False);
    pAddCampoSelect('ITE_EMBPRC', 'E.BAR_EMBALA', False);

    pAddcampoTableTemporary('ITE_EMBPRP','DECIMAL (20,' +  IntToStr(DEC_EMBALAGEM) + ')', False);
    pAddCampoSelect('ITE_EMBPRP', 'E.BAR_EMBALA', False);

    pAddcampoTableTemporary('ITE_EXPPOK','CHAR(1)');
    pAddCampoSelect('ITE_EXPPOK', 'I.ITE_EXPPOK');

    pAddcampoTableTemporary('ITE_IMPDIR','CHAR(1)');

    If fCfgSIs('IMPDIG') = '1' Then
      pAddCampoSelect('ITE_IMPDIR', 'I.ITE_IMPDIR')
    Else
      pAddCampoSelect('ITE_IMPDIR', 'G.ITE_IMPDIR');

    pAddcampoTableTemporary('ITE_USAPPF',' CHAR(1)');

    If fCfgSIs('TIPABF') = '1' Then
      pAddCampoSelect('ITE_USAPPF', 'I.ITE_USAPPF')
    Else
      pAddCampoSelect('ITE_USAPPF', 'G.ITE_USAPPF');

    pAddcampoTableTemporary('ITE_LOCFIS','VARCHAR('+IntToStr(intLocFis)+')');
    pAddCampoSelect('ITE_LOCFIS', 'G.ITE_LOCFIS');

    pAddcampoTableTemporary('ITE_ESTMAX','NUMERIC(14,3)');
    pAddCampoSelect('ITE_ESTMAX', 'G.ITE_ESTMAX');

    pAddcampoTableTemporary('ITE_ESTMIN','NUMERIC(14,3)');
    pAddCampoSelect('ITE_ESTMIN', 'G.ITE_ESTMIN');

    pAddcampoTableTemporary('ITE_MAXDIG','NUMERIC(14,3)');
    pAddCampoSelect('ITE_MAXDIG', 'G.ITE_MAXDIG');

    pAddcampoTableTemporary('ITE_MINDIG','NUMERIC(12,3)');
    pAddCampoSelect('ITE_MINDIG', 'G.ITE_MINDIG');

    pAddcampoTableTemporary('ITE_TAMLCF','VARCHAR(30)');
    pAddCampoSelect('ITE_TAMLCF', 'G.ITE_TAMLCF');

    pAddcampoTableTemporary('ITE_LOCSUP','VARCHAR('+IntToStr(intLocSup)+')');
    pAddCampoSelect('ITE_LOCSUP', 'G.ITE_LOCSUP');

    pAddcampoTableTemporary('ITE_TAMLCS','VARCHAR(30)');
    pAddCampoSelect('ITE_TAMLCS', 'G.ITE_TAMLCS');

    pAddcampoTableTemporary('ITE_CODLSE','VARCHAR(10)');
    pAddCampoSelect('ITE_CODLSE', 'G.ITE_CODLSE');

    pAddcampoTableTemporary('ITE_PRECUS','NUMERIC(12, 4)');
    pAddCampoSelect('ITE_PRECUS', 'G.ITE_PRECUS');

    pAddcampoTableTemporary('ITE_PRECUS_VAR','NUMERIC(12, 4)', False);
    pAddCampoSelect('ITE_PRECUS_VAR', '0.00', False);

    pAddcampoTableTemporary('ITE_CUSREA','NUMERIC(12, 4)');
    pAddCampoSelect('ITE_CUSREA', ' IF((1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100) <> 0, ' +
                                      ' ((IFNULL(G.ITE_PRECUS, 0) + IFNULL(G.ITE_OUTVAL, 0)) / (1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100)), 0) ');


    pAddcampoTableTemporary('ITE_CODEMP','VARCHAR(3)', False);
    pAddCampoSelect('ITE_CODEMP', 'G.ITE_CODEMP', False);

    pAddcampoTableTemporary('ITE_MARMIN','NUMERIC(12, 2)');
    pAddCampoSelect('ITE_MARMIN', 'G.ITE_MARMIN');

    pAddcampoTableTemporary('ITE_MARMSG','NUMERIC(12, 2)');
    pAddCampoSelect('ITE_MARMSG', 'G.ITE_MARMSG');

    pAddcampoTableTemporary('ITE_MARMGE','NUMERIC(12, 2)');
    pAddCampoSelect('ITE_MARMGE', 'G.ITE_MARMGE');

    pAddcampoTableTemporary('ITE_MARMMV','NUMERIC(12, 2)');
    pAddCampoSelect('ITE_MARMMV', 'G.ITE_MARMMV');

    pAddcampoTableTemporary('ITE_MARMMS','NUMERIC(12, 2)');
    pAddCampoSelect('ITE_MARMMS', 'G.ITE_MARMMS');

    pAddcampoTableTemporary('ITE_MARMMG','NUMERIC(12, 2)');
    pAddCampoSelect('ITE_MARMMG', 'G.ITE_MARMMG');

    pAddcampoTableTemporary('ITE_CODFAB','VARCHAR(35)');
    pAddCampoSelect('ITE_CODFAB', 'I.ITE_CODFAB');

    pAddcampoTableTemporary('ITE_CODBAR','VARCHAR(15)');
    pAddCampoSelect('ITE_CODBAR', 'I.ITE_CODBAR');

    pAddcampoTableTemporary('ITE_MESGIR','INTEGER(3)');
    pAddCampoSelect('ITE_MESGIR', 'I.ITE_MESGIR');

    pAddcampoTableTemporary('ITE_TMPGAR','INTEGER(6)');
    pAddCampoSelect('ITE_TMPGAR', 'I.ITE_TMPGAR');

    pAddcampoTableTemporary('ITE_INFGAR','VARCHAR(50)');
    pAddCampoSelect('ITE_INFGAR', 'I.ITE_INFGAR');

    pAddcampoTableTemporary('ITE_RSPGAR','VARCHAR(50)');
    pAddCampoSelect('ITE_RSPGAR', 'I.ITE_RSPGAR');

    pAddcampoTableTemporary('ITE_EMBALA','DECIMAL(20,' +  IntToStr(DEC_EMBALAGEM) + ')');
    pAddCampoSelect('ITE_EMBALA', 'I.ITE_EMBALA');

    pAddcampoTableTemporary('ITE_BAREMB','VARCHAR(15)');
    pAddCampoSelect('ITE_BAREMB', 'I.ITE_BAREMB');

    pAddcampoTableTemporary('ITE_CODUNI','CHAR(2)');
    pAddCampoSelect('ITE_CODUNI', 'I.ITE_CODUNI');

    pAddCampoTableTemporary('UNI_DESUNI'    ,'VARCHAR(40)');
    pAddCampoSelect('UNI_DESUNI', 'UNI_DESUNI');

    pAddcampoTableTemporary('ITE_TIPPRO','CHAR(2)');
    pAddCampoSelect('ITE_TIPPRO', 'G.ITE_TIPPRO');

    pAddcampoTableTemporary('ITE_UNICOM','CHAR(2)');
    pAddCampoSelect('ITE_UNICOM', 'I.ITE_UNICOM');

    pAddcampoTableTemporary('ITE_UNITRI','CHAR(2)');
    pAddCampoSelect('ITE_UNITRI', 'I.ITE_UNITRI');

    pAddcampoTableTemporary('ITE_FATUTR','DECIMAL(16,6)');
    pAddCampoSelect('ITE_FATUTR', 'I.ITE_FATUTR');

    pAddcampoTableTemporary('ITE_CODMAR','CHAR(' + IntToStr(fTamCodMar) + ')');
    pAddCampoSelect('ITE_CODMAR', 'I.ITE_CODMAR');

    pAddcampoTableTemporary('MAR_DESMAR','CHAR(30)');
    pAddCampoSelect('MAR_DESMAR', 'MAR_DESMAR');

    pAddcampoTableTemporary('ITE_USAPFD','CHAR(1)');
    pAddCampoSelect('ITE_USAPFD', 'I.ITE_USAPFD');

    pAddcampoTableTemporary('ITE_USAPCV','CHAR(1)');
    pAddCampoSelect('ITE_USAPCV', 'I.ITE_USAPCV');

    pAddcampoTableTemporary('ITE_SITPRO','CHAR(3)');
    pAddCampoSelect('ITE_SITPRO', 'G .ITE_SITPRO');

    pAddcampoTableTemporary('SIT_DESCRI','CHAR(50)');
    pAddCampoSelect('SIT_DESCRI', 'SIT_DESCRI');

    pAddcampoTableTemporary('ITE_DTAVAL','DATE');
    pAddCampoSelect('ITE_DTAVAL', 'G.ITE_DTAVAL');

    pAddcampoTableTemporary('ITE_DTAEPI','DATE');
    pAddCampoSelect('ITE_DTAEPI', 'I.ITE_DTAEPI');

    pAddcampoTableTemporary('ITE_CODMON','CHAR(255)');
    pAddCampoSelect('ITE_CODMON', '(SELECT GROUP_CONCAT(ITM_CODMON) FROM ITEMON WHERE ITM_CODITE = I.ITE_CODITE)');

    pAddcampoTableTemporary('ITE_CODFOR','VARCHAR(8)');
    pAddCampoSelect('ITE_CODFOR', 'I.ITE_CODFOR');

    pAddcampoTableTemporary('FOR_NOMFOR','VARCHAR(60)');
    pAddCampoSelect('FOR_NOMFOR', 'FOR_NOMFOR');

    pAddcampoTableTemporary('ITE_DIAFOR','INTEGER');
    pAddCampoSelect('ITE_DIAFOR', 'I.ITE_DIAFOR');

    pAddcampoTableTemporary('ITE_PRAMIN','INT(3)');
    pAddCampoSelect('ITE_PRAMIN', 'G.ITE_PRAMIN');

    pAddcampoTableTemporary('ITE_REAEND','CHAR(1)');
    pAddCampoSelect('ITE_REAEND', 'I.ITE_REAEND');

    pAddcampoTableTemporary('ITE_OBRBAR','CHAR(1)');
    pAddCampoSelect('ITE_OBRBAR', 'I.ITE_OBRBAR');

    pAddcampoTableTemporary('ITE_FATCOM','CHAR(1)');
    pAddCampoSelect('ITE_FATCOM', 'I.ITE_FATCOM');

    pAddcampoTableTemporary('ITE_CODDEP','CHAR(3)');
    pAddCampoSelect('ITE_CODDEP', 'I.ITE_CODDEP');

    pAddcampoTableTemporary('DEP_DESCRI','CHAR(40)');
    pAddCampoSelect('DEP_DESCRI', 'DEP_DESCRI');

    pAddcampoTableTemporary('ITE_NOTESP','CHAR(1)');
    pAddCampoSelect('ITE_NOTESP', 'I.ITE_NOTESP');

    pAddcampoTableTemporary('ITE_PEFUTP','CHAR(1)');
    pAddCampoSelect('ITE_PEFUTP', 'I.ITE_PEFUTP');

    pAddcampoTableTemporary('ITE_PEEFUT','CHAR(1)');
    pAddCampoSelect('ITE_PEEFUT', 'I.ITE_PEEFUT');

    pAddcampoTableTemporary('ITE_PEFFPR','CHAR(1)');
    pAddCampoSelect('ITE_PEFFPR', 'I.ITE_PEFFPR');

    For i := 1 To 7 do
    begin
      pAddcampoTableTemporary('ITE_MINTB' +i.ToString ,'NUMERIC(12,4)');
      pAddCampoSelect('ITE_MINTB' +i.ToString, 'G.ITE_MINTB' +i.ToString);
    End;


    pAddcampoTableTemporary('ITE_PRDGRU','CHAR(05)');
    pAddCampoSelect('ITE_PRDGRU', 'I.ITE_PRDGRU');

    pAddcampoTableTemporary('PRD_DESGRU','CHAR(40)');
    pAddCampoSelect('PRD_DESGRU', 'PRD_DESGRU');


    pAddcampoTableTemporary('ITE_ATICOM','VARCHAR(1)');
    pAddCampoSelect('ITE_ATICOM', 'I.ITE_ATICOM');

    pAddcampoTableTemporary('ITE_CODDIC','VARCHAR(7)');
    pAddCampoSelect('ITE_CODDIC', 'I.ITE_CODDIC');

    pAddcampoTableTemporary('ITE_IMPETI','VARCHAR(7)');
    pAddCampoSelect('ITE_IMPETI', 'I.ITE_IMPETI');

    pAddcampoTableTemporary('ITE_PRAPEL','NUMERIC(12,2)');
    pAddCampoSelect('ITE_PRAPEL', 'I.ITE_PRAPEL');

    pAddcampoTableTemporary('ITE_PRELIQ','NUMERIC(12, 2)');
    pAddCampoSelect('ITE_PRELIQ',   'CAST(G.ITE_PRECOM *  ' +
                                    '   ( 1 - (G.ITE_DESF01 / 100) ) * ' +
                                    '   ( 1 - (G.ITE_DESF02 / 100) ) * ' +
                                    '   ( 1 - (G.ITE_DESF03 / 100) ) * ' +
                                    '   ( 1 - (G.ITE_DESF04 / 100) ) * ' +
                                    '   ( 1 - (G.ITE_DESF05 / 100) ) * ' +
                                    '   ( 1 - (G.ITE_DESF06 / 100) ) AS DECIMAL(12,2))');

    pAddcampoTableTemporary('ITE_ALTPRE',' DATE', False);
    pAddCampoSelect('ITE_ALTPRE',  '  (SELECT ' +
                                   '     MAX(ALT_DTAALT) ' +
                                   '   FROM ' +
                                   '     PREALT ' +
                                   '   WHERE '+
                                   '     ALT_CODEMP = :CODEMP AND  '+
                                   '     ALT_CODITE = I.ITE_CODITE)', False);


    pAddcampoTableTemporary('ITE_POSEMB','VARCHAR(3)',False);
    pAddCampoSelect('ITE_POSEMB',  ' IF((SELECT COUNT(1) FROM ITEEMB ' +
                                   '      WHERE ITB_CODITE = I.ITE_CODITE ' +
                                   '        AND ITB_CODEMP = G.ITE_CODEMP) > 0,"Sim","Não") ', False);


    pAddcampoTableTemporary('ALTERA','VARCHAR(1)', False);
    pAddCampoSelect('ALTERA', '"N"', False);

    pAddcampoTableTemporary('ITE_DESUNI','VARCHAR(20)', False);
    pAddCampoSelect('ITE_DESUNI', 'CONCAT(I.ITE_CODUNI,"-",U.UNI_DESUNI)',False);

    pAddcampoTableTemporary('ITE_ORDINC','VARCHAR(20)', False);
    If (Not fEmptyStr(edtDocumento.Text)) Then
      pAddCampoSelect('ITE_ORDINC', 'D.AUTOINCREM',False)
    Else
      pAddCampoSelect('ITE_ORDINC', 'NULL',False);

    pAddcampoTableTemporary('ITE_DENSID','DECIMAL(12,4)');
    pAddCampoSelect('ITE_DENSID', 'I.ITE_DENSID');

    pAddcampoTableTemporary('ITE_FATCMP','DECIMAL(12,4)');
    pAddCampoSelect('ITE_FATCMP', 'I.ITE_FATCMP');

    pAddcampoTableTemporary('ITE_FATPM3','DECIMAL(14,6)');
    pAddCampoSelect('ITE_FATPM3', 'I.ITE_FATPM3');

    pAddcampoTableTemporary('ITE_RASTRE','CHAR(1)');
    pAddCampoSelect('ITE_RASTRE', 'I.ITE_RASTRE');

    pAddcampoTableTemporary('ITE_LARVID','NUMERIC(12,5)');
    pAddCampoSelect('ITE_LARVID', 'I.ITE_LARVID');

    pAddcampoTableTemporary('ITE_ALTVID','NUMERIC(12,5)');
    pAddCampoSelect('ITE_ALTVID', 'I.ITE_ALTVID');

    pAddcampoTableTemporary('ITE_LAMAVI','NUMERIC(12,5)');
    pAddCampoSelect('ITE_LAMAVI', 'I.ITE_LAMAVI');

    pAddcampoTableTemporary('ITE_ALMAVI','NUMERIC(12,5)');
    pAddCampoSelect('ITE_ALMAVI', 'I.ITE_ALMAVI');

    pAddcampoTableTemporary('ITE_UTIAMP','CHAR(1)');
    pAddCampoSelect('ITE_UTIAMP', 'I.ITE_UTIAMP');

    pAddcampoTableTemporary('ITE_PESOBR','CHAR(1)');
    pAddCampoSelect('ITE_PESOBR', 'G.ITE_PESOBR');

    pAddcampoTableTemporary('ITE_CAREST','CHAR(14)');
    pAddCampoSelect('ITE_CAREST', 'IF(I.ITE_CAREST = "I", "ITEM ESTRUTURA", "SUB-PRODUTOS")');

    pAddcampoTableTemporary('ITE_LOTEPD','CHAR(1)');
    pAddCampoSelect('ITE_LOTEPD', 'I.ITE_LOTEPD');

    pAddcampoTableTemporary('ITE_ORDSER','CHAR(1)');
    pAddCampoSelect('ITE_ORDSER', 'I.ITE_ORDSER');

    pAddcampoTableTemporary('ITE_CLACRM','CHAR(1)');
    pAddCampoSelect('ITE_CLACRM', 'I.ITE_CLACRM');

    pAddcampoTableTemporary('ITE_PERVDA','CHAR(1)');
    pAddCampoSelect('ITE_PERVDA', IIF(FPermVendaIgualTodasEmp, 'I.ITE_PERVDA', 'G.ITE_PEVNDA'));

    pAddcampoTableTemporary('ITE_CPESOB','CHAR(1)');
    pAddCampoSelect('ITE_CPESOB', 'G.ITE_CPESOB');

    pAddcampoTableTemporary('ITE_DESCND','CHAR(1)');
    pAddCampoSelect('ITE_DESCND', 'I.ITE_DESCND');

    pAddcampoTableTemporary('ITE_CODONU','CHAR(3)');
    pAddCampoSelect('ITE_CODONU', 'I.ITE_CODONU');

    pAddcampoTableTemporary('ITE_CRODOC','CHAR(1)');
    pAddCampoSelect('ITE_CRODOC', 'DE.ITE_CRODOC');

    pAddcampoTableTemporary('ITE_DESTAQ','CHAR(1)');
    pAddCampoSelect('ITE_DESTAQ', 'DE.ITE_DESTAQ');

    pAddcampoTableTemporary('ITE_DESCHK','CHAR(1)');
    pAddCampoSelect('ITE_DESCHK', 'G.ITE_DESCHK');

    If blnTABPRD  then
    Begin

      For intContador := 1 To Length(VS_strTabPrc) Do
      Begin
        pAddcampoTableTemporary('ITE_PREDOL' + IntToStr(intContador), 'CHAR(1)',False);
        pAddCampoSelect('ITE_PREDOL' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_PREDOL, "")', False);

        pAddcampoTableTemporary('ITE_CODABF' + IntToStr(intContador), 'CHAR('+IIf(fCfgSis('USASAN') = 'S', '7', '3')+')',False);
        pAddCampoSelect('ITE_CODABF' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_CODABF, "")', False);

        pAddcampoTableTemporary('ITE_USAPPF' + IntToStr(intContador), 'CHAR(1)',False);
        pAddCampoSelect('ITE_USAPPF' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_USAPPF, "")', False);

        pAddcampoTableTemporary('ITE_PRECOM' + IntToStr(intContador), 'NUMERIC(12, 4)',False);
        pAddCampoSelect('ITE_PRECOM' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_PRECOM, G.ITE_PRECOM) ', False);

        pAddcampoTableTemporary('ITE_DESF01' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DESF01' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_DESF01, G.ITE_DESF01) ', False);

        pAddcampoTableTemporary('ITE_DESF02' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DESF02' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_DESF02, G.ITE_DESF02) ', False);

        pAddcampoTableTemporary('ITE_DESF03' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DESF03' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_DESF03, G.ITE_DESF03) ', False);

        pAddcampoTableTemporary('ITE_DESF04' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DESF04' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_DESF04, G.ITE_DESF04) ', False);

        pAddcampoTableTemporary('ITE_DESF05' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DESF05' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_DESF05, G.ITE_DESF05) ', False);

        pAddcampoTableTemporary('ITE_DESF06' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DESF06' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_DESF06, G.ITE_DESF06) ', False);

        pAddcampoTableTemporary('ITE_ICMENT' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_ICMENT' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_ICMENT, G.ITE_ICMENT) ', False);

        pAddcampoTableTemporary('ITE_SUBFED' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_SUBFED' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_SUBFED, G.ITE_SUBFED) ', False);

        pAddcampoTableTemporary('ITE_IPIENT' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_IPIENT' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_IPIENT, G.ITE_IPIENT) ', False);

        pAddcampoTableTemporary('ITE_FREENT' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_FREENT' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_FREENT, G.ITE_FREENT) ', False);

        pAddcampoTableTemporary('ITE_VALFRE' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_VALFRE' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_VALFRE, G.ITE_VALFRE) ', False);

        pAddcampoTableTemporary('ITE_ACRFIN' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_ACRFIN' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_ACRFIN, G.ITE_ACRFIN) ', False);

        pAddcampoTableTemporary('ITE_DESADB' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DESADB' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_DESADB, G.ITE_DESADB) ', False);

        pAddcampoTableTemporary('ITE_PRECUS' + IntToStr(intContador), 'NUMERIC(12, 4)',False);
        pAddCampoSelect('ITE_PRECUS' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_PRECUS, G.ITE_PRECUS) ', False);

        pAddcampoTableTemporary('ITE_OUTVAL' + IntToStr(intContador), 'NUMERIC(12, 4)',False);
        pAddCampoSelect('ITE_OUTVAL' + IntToStr(intContador), 'IFNULL(DC' + IntToStr(intContador) + '.DET_OUTVAL, G.ITE_OUTVAL) ', False);

        pAddcampoTableTemporary('ITE_ICMSAI' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_ICMSAI' + IntToStr(intContador), 'IFNULL(DC' + IntToStr(intContador) + '.DET_ICMSAI, G.ITE_ICMSAI) ', False);

        pAddcampoTableTemporary('ITE_IMPFED' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_IMPFED' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_IMPFED, G.ITE_IMPFED) ', False);

        pAddcampoTableTemporary('ITE_DESOPE' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DESOPE' + IntToStr(intContador), 'IFNULL(DC' + IntToStr(intContador) + '.DET_DESOPE, G.ITE_DESOPE) ', False);

        pAddcampoTableTemporary('ITE_TCIFCU' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_TCIFCU' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_TCIFCU, G.ITE_TCIFCU) ', False);

        pAddcampoTableTemporary('ITE_TSCUST' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_TSCUST' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_TSCUST, G.ITE_TSCUST) ', False);

        pAddcampoTableTemporary('ITE_DEPICO' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DEPICO' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_DEPICO, G.ITE_DEPICO) ', False);

        pAddcampoTableTemporary('ITE_DEICMS' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_DEICMS' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_DEICMS, G.ITE_DEICMS) ', False);

        pAddcampoTableTemporary('ITE_FATREG' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_FATREG' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.ITE_FATREG, G.ITE_FATREG) ', False);

        pAddcampoTableTemporary('ITE_CNVCUS' + IntToStr(intContador), 'NUMERIC(12, 2)',False);
        pAddCampoSelect('ITE_CNVCUS' + IntToStr(intContador), 'IFNULL(IF' + IntToStr(intContador) + '.ITE_CNVCUS, 1) ', False);

        pAddcampoTableTemporary('AUTINC' + IntToStr(intContador), 'VARCHAR(20)',False);
        pAddCampoSelect('AUTINC' + IntToStr(intContador), 'IFNULL(D' + IntToStr(intContador) + '.AUTOINCREM, "") ', False);
      End;
    End;

    pAddcampoTableTemporary('ITE_CICMDE','CHAR(1)');
    pAddCampoSelect('ITE_CICMDE', 'G.ITE_CICMDE');

    pAddcampoTableTemporary('ITE_CDPIOP','CHAR(1)');
    pAddCampoSelect('ITE_CDPIOP', 'G.ITE_CDPIOP');

    pAddcampoTableTemporary('ITE_DIDIOP','CHAR(1)');
    pAddCampoSelect('ITE_DIDIOP', 'G.ITE_DIDIOP');

    pAddcampoTableTemporary('ITE_CODGPC','CHAR(8)');
    pAddCampoSelect('ITE_CODGPC', 'I.ITE_CODGPC');

    pAddcampoTableTemporary('GPC_DESGPC','CHAR(100)');
    pAddCampoSelect('GPC_DESGPC', 'GPC_DESGPC');

    pAddcampoTableTemporary('ITE_APERET','CHAR(1)');
    pAddCampoSelect('ITE_APERET', 'G.ITE_APERET');

    pAddcampoTableTemporary('ITE_APEENT','CHAR(1)');
    pAddCampoSelect('ITE_APEENT', 'G.ITE_APEENT');

    pAddcampoTableTemporary('ITE_NOMECO','VARCHAR(200)');
    pAddCampoSelect('ITE_NOMITE', 'DE.ITE_NOMITE');

    pAddcampoTableTemporary('ITE_APLECO','TEXT');
    pAddCampoSelect('ITE_APLITE', 'DE.ITE_APLITE');

    pAddcampoTableTemporary('ITE_DESECO','TEXT');
    pAddCampoSelect('ITE_DESITE', 'DE.ITE_DESITE');

    pAddcampoTableTemporary('ITE_EXPALT','DECIMAL(12,3)');
    pAddCampoSelect('ITE_EXPALT', 'DE.ITE_EXPALT');

    pAddcampoTableTemporary('ITE_EXPLAR','DECIMAL(12,3)');
    pAddCampoSelect('ITE_EXPLAR', 'DE.ITE_EXPLAR');

    pAddcampoTableTemporary('ITE_EXPPRO','DECIMAL(12,3)');
    pAddCampoSelect('ITE_EXPPRO', 'DE.ITE_EXPPRO');

    pAddcampoTableTemporary('ITE_BAREXP','CHAR(1)');
    pAddCampoSelect('ITE_BAREXP', 'I.ITE_BAREXP');

    pAddcampoTableTemporary('ITE_SEPBAR','CHAR(1)');
    pAddCampoSelect('ITE_SEPBAR', 'I.ITE_SEPBAR');

    pAddcampoTableTemporary('ITE_EXPSIT','CHAR(1)');
    pAddCampoSelect('ITE_EXPSIT', 'I.ITE_EXPSIT');


    If fCfgSis('OPCCOM', varString) = 'VT' Then
    Begin
      For intCorre := 1 To Length(VS_strTabPrc) Do
      Begin
        If VS_strTabPrc[intCorre] = 'S' Then
        Begin
          pAddcampoTableTemporary('COM_VENIN' + intToStr(intCorre) ,'DECIMAL(6,2)');
          pAddCampoSelect('COM_VENIN' + intToStr(intCorre), 'IFNULL((SELECT COM_VENINT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ),0)');

          pAddcampoTableTemporary('COM_VENEX' + intToStr(intCorre) ,'DECIMAL(6,2)');
          pAddCampoSelect('COM_VENEX' + intToStr(intCorre), 'IFNULL((SELECT COM_VENEXT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ),0)');

        End;
      End;
    End;

    If fCfgSis('EMPCAR', varBoolean) Then
    Begin
      pAddcampoTableTemporary('ITE_EMPCAR','CHAR(3)');
      pAddCampoSelect('ITE_EMPCAR', 'I.ITE_EMPCAR');

      pAddcampoTableTemporary('EMP_NOMEMP','VARCHAR(60)');
      pAddCampoSelect('EMP_NOMEMP', 'CAR.EMP_NOMEMP');

    End;

    if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
    Begin
      pAddcampoTableTemporary('ITE_EMPSUG', 'CHAR(3)');
      pAddCampoSelect('ITE_EMPSUG', 'I.ITE_EMPSUG');

      pAddcampoTableTemporary('EMP_NOMEMPSUG', 'VARCHAR(60)');
      pAddCampoSelect('EMP_NOMEMPSUG', 'SUG.EMP_NOMEMP');
    End;

    pAddcampoTableTemporary('ITE_DTAUVE', 'DATE', False);
    pAddcampoSelect('ITE_DTAUVE', 'G.ITE_DTAUVE', False);

    if blnUtilizaChecklistGarantia then
    begin
      pAddcampoTableTemporary('ITE_CODATC', 'VARCHAR(5)');
      pAddcampoSelect('ITE_CODATC', 'G.ITE_CODATC');


      pAddcampoTableTemporary('TMP_CKLGAR', 'TEXT');
      pAddcampoSelect('TMP_CKLGAR', 'CAST("" AS CHAR(10000))');

      pAddcampoTableTemporary('TMP_CKLTRO', 'TEXT');
      pAddcampoSelect('TMP_CKLTRO', 'CAST("" AS CHAR(10000))');
    end;

    If fCfgSis('SEPEXC', varBoolean) Then
    Begin
      pAddcampoTableTemporary('ITE_SEPEXC', 'CHAR(1)');
      pAddCampoSelect('ITE_SEPEXC', 'I.ITE_SEPEXC');
    End;

    pAddcampoTableTemporary('ITE_SOBENC', 'CHAR(1)');
    pAddcampoSelect('ITE_SOBENC', 'G.ITE_SOBENC');

    If fCfgSis('UTPEST', varBoolean) Then
    Begin
      pAddcampoTableTemporary('ITE_QTDPES', 'DECIMAL(12,4)');
      pAddCampoSelect('ITE_QTDPES', 'I.ITE_QTDPES');

      pAddcampoTableTemporary('ITE_PORPES', 'DECIMAL(12,2)');
      pAddCampoSelect('ITE_PORPES', 'I.ITE_PORPES');
    End;

    If fCfgSis('UTIABA', varBoolean) Then
    Begin
      pAddcampoTableTemporary('ITE_MLTRCA', 'CHAR(1)');
      pAddcampoSelect('ITE_MLTRCA', 'G.ITE_MLTRCA');
    End;

    If fCfgSis('ETIDCE', varBoolean) Then
    Begin
      pAddcampoTableTemporary('ITE_NECEXP','CHAR(1)');
      pAddCampoSelect('ITE_NECEXP', 'I.ITE_NECEXP');
    End;

    If fCfgSis('LOCRET', varBoolean) Then
    Begin
      pAddcampoTableTemporary('ITE_TIPRET','CHAR(2)');
      pAddCampoSelect('ITE_TIPRET', 'G.ITE_TIPRET');
    End;


    If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
    Begin
      pAddcampoTableTemporary('ITE_NFEIDP','CHAR(1)');
      pAddCampoSelect('ITE_NFEIDP', 'I.ITE_NFEIDP');

      pAddcampoTableTemporary('ITE_NFCIDP','CHAR(1)');
      pAddCampoSelect('ITE_NFCIDP', 'I.ITE_NFCIDP');
    End;

    If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
    Begin
      pAddcampoTableTemporary('ITE_LOTRAP','CHAR(1)');
      pAddCampoSelect('ITE_LOTRAP', 'I.ITE_LOTRAP');
    End;

    If fCfgSis('TRITTE', varBoolean) Then
    Begin
      pAddcampoTableTemporary('ITE_TRITTE', 'CHAR(1)');
      pAddCampoSelect('ITE_TRITTE', 'I.ITE_TRITTE');
    End;

    pAddcampoTableTemporary('ITE_ITEBAS',' CHAR(1)');
    pAddCampoSelect('ITE_ITEBAS', 'I.ITE_ITEBAS');

    If fCfgSis('CDPHAB', varBoolean) Then
    Begin
      pAddcampoTableTemporary('ITE_CLBPIN', 'CHAR(1)');
      pAddCampoSelect('ITE_CLBPIN', 'I.ITE_CLBPIN');
    End;

    If blnUsaBef Then
    Begin
      pAddcampoTableTemporary('ITE_USABEF', 'CHAR(1)');
      pAddCampoSelect('ITE_USABEF', 'I.ITE_USABEF');
    End;

    strSQL := strSQL + '  AUTOINCREM INT NOT NULL AUTO_INCREMENT PRIMARY KEY,';
    strSQL := strSQL + '  KEY IDX_CODITE(ITE_CODITE) ) ';

    strSQL := strSQL + '  ;ALTER TABLE  ' + strTabela + ' ENGINE = MYISAM;';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

    strSQL := fRetornaSQLPrecoIndividual(strSQLFields);

    strSQL := strSQL + '  WHERE TRUE ';
    If (Not fEmptyStr(edtDocumento.Text)) Then
    Begin
      strSQL := strSQL + '  AND I.ITE_CODITE = D.DET_CODITE  ';
      strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'D.DET_CODFOR', 'CODFOR');
      If (Not fEmptyStr(edtSerie.Text)) Then
        strSQL := strSQL + ' AND IFNULL(D.DET_SERIE_, "") = :SERDOC   ';
    End
    Else
      strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'I.ITE_CODFOR', 'CODFOR');

    strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinhaGrupo, 'ITE_CODGRU','CODGRU');

    If Not fEmptyStr(edtDesIte.Text) Then
      strSQL := strSQL + '  AND I.ITE_DESITE LIKE :DESITE ';

    If Not fEmptyStr(edtRefere.Text) Then
      strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';
    If Not fEmptyStr(edtCodMon.Text) Then
    Begin
     strSQL := strSQL + '  AND (SELECT COUNT(1) FROM ITEMON ';
     strSQL := strSQL + '        WHERE TRUE ';
     strSQL := strSQL + fStrLocate(edtCodMon , arrCodMon, 'ITM_CODMON', 'CODMON');
     strSQL := strSQL + '        AND  ITM_CODITE = I.ITE_CODITE) > 0 ';
    End;

    strSQL := strSQL + fStrLocate(edtCodUni , arrCodUni  , 'I.ITE_CODUNI', 'CODUNI');
    strSQL := strSQL + fStrLocate(edtCodMar , arrMarca   , 'I.ITE_CODMAR', 'CODMAR');
//    strSQL := strSQL + fStrLocate(edtCodMon , arrCodMon  , 'I.ITE_CODMON', 'CODMON');
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

    If (Pos(edtAtivoCompras.Text, 'SN') > 0) Then
      strSQL := strSQL + '  AND I.ITE_ATICOM = :ATICOM ';

   If (Pos(edtExpEcomm.Text, 'SN') > 0) Then
      strSQL := strSQL + '  AND I.ITE_EXPSIT = :EXPSIT ';


   If edtGirEst.Text <> 'T' Then
   Begin
     if fCfgSis('TIPGIR', VarString)  = 'S' Then
       strSQL := strSQL + ' AND G.ITE_NIVGIR = ' + QuotedStr(edtGirEst.Text)
     Else
       strSQL := strSQL + ' AND I.ITE_NVLGIR = ' + QuotedStr(edtGirEst.Text);
   End;


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


    { Quando tem uma massa grande de registros Req: 385934                                     }
    { ORDER BY CAUSANDO #HY001Out of sort memory, consider increasing server sort buffer size. }
    { strSQL := strSQL + '  ORDER BY ';       }
    { strSQL := strSQL + '    I.ITE_DESITE '; }

    strSQL := Trim('INSERT INTO ' + strTabela + ' (' + strCamposTemporary + 'AUTOINCREM) ' +  strSQL);

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

      If (Pos(edtAtivoCompras.Text, 'SN') > 0) Then
        ParamByName('ATICOM').AsString := edtAtivoCompras.Text;

      If (Pos(edtExpEcomm.Text, 'SN') > 0) Then
        ParamByName('EXPSIT').AsString := edtExpEcomm.Text;

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

      If  fCampoMarcado('DTAALT') Or
          fCampoMarcado('PR1ANT') Or
          fCampoMarcado('PR2ANT') Or
          fCampoMarcado('PR3ANT') Or
          fCampoMarcado('PR4ANT') Or
          fCampoMarcado('PR5ANT') Or
          fCampoMarcado('PR6ANT') Or
          fCampoMarcado('PR7ANT') Then
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

procedure TfrmAltPrecoIndividual.pAtualizaTemporaria(blnFiltraAlterado: Boolean; strCampoOrdem: String);
Var
  intContador: Integer;
  strVendaReadOnly: String;
  strFatPreMarBR: String;
  strFatPrePreve: String;
  strFatPreComTb: String;
Begin
  If Not fTabelaExiste(strTabela) Then
    Exit;

  Try

    With qryGen Do
    Begin
      DisableControls;

        Close;
        SQL.Clear;

      If blnFiltraAlterado Then
        SQL.Add('SELECT * FROM ' + strTabela + ' WHERE ALTERA = "S"' + IIF(fEmptyStr(strCampoOrdem), '', ' ORDER BY ' + strCampoOrdem))
      Else
        SQL.Add('SELECT * FROM ' + strTabela + IIF(fEmptyStr(strCampoOrdem), '', ' ORDER BY ' + strCampoOrdem));

      Open;

      (FieldByName('ITE_SALDOS')     As TFloatField).DisplayFormat := '#,###0.000';
      (FieldByName('ITE_QTDUCO')     As TFloatField).DisplayFormat := '#,###0.000';
      (FieldByName('ITE_PREULT')     As TFloatField).DisplayFormat := '#,####0.0000';
      (FieldByName('ITE_MLTVEN')     As TFloatField).DisplayFormat := '#,###0.0000';
      (FieldByName('ITE_MLTVEN_NOV') As TFloatField).DisplayFormat := '#,###0.0000';

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

      If fCfgSis('MARPAD') = 'S' Then
      Begin
        (FieldByName('ITE_MARPAD_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_MARPAD')     As TFloatField).DisplayFormat := '#,##0.00';
      End;

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
      (FieldByName('ITE_TCIFCU_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_TCIFCU')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_TSCUST_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_TSCUST')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DEPICO_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DEPICO')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DEICMS_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DEICMS')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_FATREG_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_FATREG')     As TFloatField).DisplayFormat := '#,##0.00';

      if not blnIteTbp Then
      Begin
        (FieldByName('ITE_DESMAX_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMAX')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMGE_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMGE')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMSU_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMSU')     As TFloatField).DisplayFormat := '#,##0.00';

        (FieldByName('ITE_DESMVM_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMVM')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMGM_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMGM')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMSM_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_DESMSM')     As TFloatField).DisplayFormat := '#,##0.00';
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

          (FieldByName('ITE_DESVM' + intToStr(intContador) + '_NOV') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESVM' + intToStr(intContador))          As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESGM' + intToStr(intContador) + '_NOV') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESGM' + intToStr(intContador))          As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESSM' + intToStr(intContador) + '_NOV') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('ITE_DESSM' + intToStr(intContador))          As TFloatField).DisplayFormat := '#,##0.00';
        End;

      End;

      If (fCfgSis('OPCCOM') <> 'PPT') Then
      begin
        (FieldByName('ITE_COMVAR_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_COMVAR')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_COMATA_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_COMATA')     As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_COMDIS_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_COMDIS')     As TFloatField).DisplayFormat := '#,##0.00';
      end;
      (FieldByName('ITE_COMDIG_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMDIG')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMPRO_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_COMPRO')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_QTPPRO_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_QTPPRO')     As TFloatField).DisplayFormat := '#,##0.00';

      (FieldByName('ITE_MARBR1_NOV') As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR1')     As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR2_NOV') As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR2')     As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR3_NOV') As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR3')     As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR4_NOV') As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR4')     As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR5_NOV') As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR5')     As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR6_NOV') As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR6')     As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR7_NOV') As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);
      (FieldByName('ITE_MARBR7')     As TFloatField).DisplayFormat := fMskDigitos(fRetPrecisaoMargemItem);

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

      (FieldByName('ITE_MARMMV_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMMV')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMMS_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMMS')     As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMMG_NOV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_MARMMG')     As TFloatField).DisplayFormat := '#,##0.00';

      (FieldByName('ITE_EMBALA_NOV') As TFloatField).DisplayFormat := fMskDigitos(DEC_EMBALAGEM);
      (FieldByName('ITE_EMBALA')     As TFloatField).DisplayFormat := fMskDigitos(DEC_EMBALAGEM);
      (FieldByName('ITE_PESOIT_NOV') As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_PESOIT')     As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_PESLIQ_NOV') As TFloatField).DisplayFormat := '#,##0.0000';
      (FieldByName('ITE_PESLIQ')     As TFloatField).DisplayFormat := '#,##0.0000';

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

      (FieldByName('ITE_PIMPTC')     As TFloatField).DisplayFormat := '#,###0.00';
      (FieldByName('ITE_PIMPTC_NOV') As TFloatField).DisplayFormat := '#,###0.00';

      (FieldByName('ITE_DENSID')     As TFloatField).DisplayFormat := '#,###0.0000';
      (FieldByName('ITE_DENSID_NOV') As TFloatField).DisplayFormat := '#,###0.0000';

      (FieldByName('ITE_FATCMP')     As TFloatField).DisplayFormat := '#,###0.0000';
      (FieldByName('ITE_FATCMP_NOV') As TFloatField).DisplayFormat := '#,###0.0000';

      (FieldByName('ITE_FATPM3')     As TFloatField).DisplayFormat := '#,###0.000000';
      (FieldByName('ITE_FATPM3_NOV') As TFloatField).DisplayFormat := '#,###0.000000';

      (FieldByName('ITE_LARVID_NOV') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_LARVID')     As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_ALTVID_NOV') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_ALTVID')     As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_LAMAVI_NOV') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_LAMAVI')     As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_ALMAVI_NOV') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');
      (FieldByName('ITE_ALMAVI')     As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00000');

      if fCfgSis('UTPEST', varBoolean) then
      begin
        (FieldByName('ITE_QTDPES_NOV') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', VarInteger));
        (FieldByName('ITE_QTDPES')     As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', VarInteger));
        (FieldByName('ITE_PORPES_NOV') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('ITE_PORPES')     As TFloatField).DisplayFormat := '#,##0.00';
      end;

      If fCfgSis('OPCCOM', varString) = 'VT' Then
      Begin
        For intContador := 1 To Length(VS_strTabPrc) Do
        Begin
          If VS_strTabPrc[intContador] = 'S' Then
          Begin
            (FieldByName('COM_VENEX'+IntToStr(intContador)+'_NOV') As TFloatField).DisplayFormat := '#,##0.000';
            (FieldByName('COM_VENEX'+IntToStr(intContador))        As TFloatField).DisplayFormat := '#,##0.000';
            (FieldByName('COM_VENIN'+IntToStr(intContador)+'_NOV') As TFloatField).DisplayFormat := '#,##0.000';
            (FieldByName('COM_VENIN'+IntToStr(intContador))        As TFloatField).DisplayFormat := '#,##0.000';
          End;
        End;
      End;
    End;

    If Assigned(objFatPre) Then
      For intContador := 2 To 7 Do
        If objFatPre.fTabelaAtiva(intContador) Then
          strFatPreMarBR := strFatPreMarBR + '_ITE_MARBR' + (intContador).ToString ;
    strFatPrePreve := strFatPreMarBR.Replace('ITE_MARBR','ITE_PREVE');
    strFatPreComTb := strFatPreMarBR.Replace('ITE_MARBR','ITE_COMTB');

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
          strVendaReadOnly := strVendaReadOnly + strFatPreMarBR;
        End Else
        Begin
          strVendaReadOnly := AnsiReplaceStr(strVenda, 'ITE_PREVE', '');
          strVendaReadOnly := AnsiReplaceStr(strVendaReadOnly, 'ITE_ICMSAI', '');
          strVendaReadOnly := strVendaReadOnly + strFatPrePreve;
        End;

        strVendaReadOnly := AnsiReplaceStr(strVendaReadOnly, 'ITE_COMTB', '');
        strVendaReadOnly := strVendaReadOnly + strFatPreComTb;

        If (Pos(LeftStr(arrCampos[intContador].FieldName, 10), strVendaReadOnly +
              'ITE_CODITE_ITE_PRELIQ_ITE_PRECUS_NOV_ITE_SALDOS_ITE_DTAALT_ITE_PREMED_ITE_IMPULT_ITE_PREULT_ITE_DTAULT_ITE_QTDUCO_' +
              'ITE_PR1ANT_ITE_PR2ANT_ITE_PR3ANT_ITE_PR4ANT_ITE_PR5ANT_ITE_PR6ANT_ITE_PR7ANT_ITE_CUSREA_ITE_CUSREA_NOV_ITE_DTAUAP') > 0) Then
          arrCampos[intContador].ReadOnly := True
        Else
          arrCampos[intContador].ReadOnly := False;

      End
      Else
      Begin

        If (Pos(LeftStr(arrCampos[intContador].FieldName, 10), strCusto +
            strFatPrePreve +
            strFatPreComTb +
            strFatPreMarBR +
               'ITE_CODITE_ITE_PRELIQ_ITE_PRECUS_NOV_ITE_SALDOS_ITE_DTAALT_ITE_PREMED_ITE_IMPULT_ITE_PREULT_ITE_DTAULT_ITE_QTDUCO_' +
               'ITE_PR1ANT_ITE_PR2ANT_ITE_PR3ANT_ITE_PR4ANT_ITE_PR5ANT_ITE_PR6ANT_ITE_PR7ANT_ITE_CUSREA_ITE_CUSREA_NOV_ITE_DTAUAP') > 0) Then
          arrCampos[intContador].ReadOnly := True
        Else
          arrCampos[intContador].ReadOnly := False;

      End;
    End;
  Finally
    qryGen.EnableControls;
    If Assigned(FrameAlteraPrecoIndividual) Then
      FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource := dtsGen;
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
  If Assigned(FrameAlteraPrecoIndividual) Then
    FrameAlteraPrecoIndividual.pLiberaOrdenacao;
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
  FreeAndNil(qryIteCom);

  fFecharTabela(qryPreAlt);

  FreeAndNil(strLisCam);
  FreeAndNil(strLisUsu);

end;

procedure TfrmAltPrecoIndividual.pDeletaTemporaria(blnAposAlteracaoEfetivada: Boolean = True);
  Var
    qryGenTmp: TUniQuery;
    blnDeletarCopia: Boolean;
Begin
  Try
    qryGenTmp := fCriaQuery(Self);

    If Assigned(ColumnDesIte) Then
      FreeAndNil(ColumnDesIte);

    If Not fEmptyStr(strTabela) Then
    Begin
      blnDeletarCopia := blnAposAlteracaoEfetivada;
      qryGenTmp.Close;
      If Not blnAposAlteracaoEfetivada Then
        blnDeletarCopia := fMensagem('', 'Deseja manter a cópia de segurança atual ?', ['&Sim', '&Não']) = 2;

      If blnDeletarCopia Then
      Begin
        qryGenTmp.SQL.Clear;
        qryGenTmp.SQL.Add('DROP TABLE ' + strTabela + ';');
        qryGenTmp.ExecSQL;

        qryGenTmp.Close;
        qryGenTmp.SQL.Clear;

        qryGenTmp.SQL.Add('DELETE FROM ALTIND ');
        qryGenTmp.SQL.Add(' WHERE IND_TABELA = :TABELA ');
        qryGenTmp.SQL.Add('   AND IND_CODOPE = :CODOPE ');
        qryGenTmp.SQL.Add('   AND IND_CODEMP = :CODEMP ');
        qryGenTmp.ParamByName('TABELA').AsString := strTabela;
        qryGenTmp.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        qryGenTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;

        qryGenTmp.ExecSQL;
        qryGenTmp.CLose;
      End
      Else
      Begin
        If blnAlterouAlgumRegistro Then
        qryGenTmp.SQL.Clear;
        qryGenTmp.SQL.Add('UPDATE ALTIND SET IND_EDITOU = 1 WHERE IND_TABELA = ' + QuotedStr(strTabela));
        qryGenTmp.ExecSQL;
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

{********************************}
{* ATUALIZA DADOS DE ALTERAÇÕES *}
{*****************************AF*}
procedure TfrmAltPrecoIndividual.pAtualizaDados(DataSet: TDataSet);
  function fGetCampoFocado: TField;
  var
    strCampoFocado: String;
    campo: TField;
  begin
    strCampoFocado := TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName;
    campo := FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.FieldByName(strCampoFocado);

    Result := campo;
  end;

  function fValidaLocalizacoesFisicas: Boolean;
  var
    objCadLot: TCadLot;
    strItem,
    strLote,
    strCodIte: String;
    fltSalLot,
    fltSalLotML : Double;
    campo: TField;
    blnCadLoc: Boolean;
  begin
    campo := fGetCampoFocado;
    strCodIte := qryGen.FieldByName('ITE_CODITE').Value;
    objCadLot := TCadLot.Create(Nil);
    blnCadLoc := fCfgSis('CADLOC', varBoolean);

    If Not blnCadLoc Then
      Exit(True)
    Else If Not (Pos(campo.FieldName, '_ITE_LOCFIS_NOV_ITE_LOCSUP_NOV') > 0) Then
      Exit(True)
    Else If (Pos(campo.FieldName, '_ITE_LOCFIS_NOV') > 0) And (fEmptyStr(qryGen.FieldByName('ITE_LOCFIS_NOV').AsString)) Then
      Exit(True)
    Else If (Pos(campo.FieldName, '_ITE_LOCSUP_NOV') > 0) And (fEmptyStr(qryGen.FieldByName('ITE_LOCSUP_NOV').AsString)) Then
      Exit(True);

    If fEmptyStr(fRetNomLocFisica(campo.AsString)) Then
    Begin
      pMensagemOk('Localização não encontrada!');
      Exit(False);
    End;

    If strTraLoc <> 'N' Then
    Begin
      Try
        If (campo.FieldName = 'ITE_LOCFIS_NOV') And (objCadLot.fTemProdutoComLocAdicional(campo.AsString, strItem, fltSalLot, fltSalLotML, dbeCodIte.Text)) Then
        Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa localização física adicional!');
          If (strTraLoc = 'T') Then
            Exit(False);
        End;

        If objCadLot.fTemProdutoComLocFisica(qryGen.FieldByName(campo.FieldName).AsString, strItem, fltSalLot, fltSalLotML, strCodIte) Then
        Begin
          pMensagemOk('O produto ' + fRetNomProduto(strItem) + ' já está cadastrado com essa localização física!');
          If (strTraLoc = 'T') Then
            Exit(False);
        End
        Else If objCadLot.fTemLoteComLocFisica(campo.AsString, strItem, strLote, fltSalLot, fltSalLotML) Then
        Begin
          pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                      ' (' + objCadLot.strTitLab + ' ' + strLote + ') já está cadastrado com essa localização física!');
          If (strTraLoc = 'T') Then
            Exit(False);
        End;
      Finally
        FreeAndNil(objCadLot);
      End;
    End;

    Result := True;

  end;
  procedure pValidaValoresNulos;
  var
    campo: TField;
  begin
    campo := fGetCampoFocado;

    If fEmptyStr(campo.AsString) Then
    Begin
      Case campo.DataType Of
        ftString:  campo.AsString  :=    '';
        ftFloat:   campo.AsFloat   :=   0.0;
        ftInteger: campo.AsInteger :=     0;
        ftBoolean: campo.AsBoolean := False;
      End;
    End;
  End;

  function fValidaNCM: Boolean;
  Var
    campo: TField;
  Begin
    campo := fGetCampoFocado;
    Result := True;

    If (Not SameText(campo.FieldName, 'ITE_CLAIPI_NOV')) Then
      Exit;

    If fEmptyStr(campo.AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Campo NCM / Classif. IPI deve ser informado!', ['&Ok']);
      Result := False;
    End;
  End;

  function fValidaMarca: Boolean;
  Var
    campo: TField;
  Begin
    campo := fGetCampoFocado;
    Result := True;

    If (Not SameText(campo.FieldName, 'ITE_CODMAR_NOV')) Then
      Exit;

    If fEmptyStr(campo.AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Campo Marca deve ser informado!', ['&Ok']);
      Result := False;
    End;
  End;

Var
  intContador: Integer;
Begin
  pValidaValoresNulos;
  pCalcularVariacoes(DataSet);


  If Not fValidaLocalizacoesFisicas Then
  Begin
    DataSet.Cancel;
    Exit;
  End;

  If Not fValidaNCM Then
  Begin
    DataSet.Cancel;
    Exit;
  End;

  If Not fValidaMarca Then
  Begin
    DataSet.Cancel;
    Exit;
  End;

  pValidaDescontoMaximoOperador(Dataset);
  pValidaMargemMinimaOperador(Dataset);

  With qryGen Do
  Begin

    If (Active) And (Not IsEmpty) Then
    Begin
      FieldByName('ALTERA').AsString := 'S';
      blnAlterouAlgumRegistro := True;
      For intContador := 0 To Length(colColunas)-1 Do
      Begin
        If colColunas[intcontador].strNomCam = TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName Then
          colColunas[intcontador].blnHabili := True;
      End;
      // Se não teve alteração nos campos que devem recalcular preco então não recalcula
      If Not ((FieldByName('ITE_PRECOM').Value <> FieldByName('ITE_PRECOM_NOV').Value) Or
            (FieldByName('ITE_DESF01').Value <> FieldByName('ITE_DESF01_NOV').Value) Or
            (FieldByName('ITE_DESF02').Value <> FieldByName('ITE_DESF02_NOV').Value) Or
            (FieldByName('ITE_DESF03').Value <> FieldByName('ITE_DESF03_NOV').Value) Or
            (FieldByName('ITE_DESF04').Value <> FieldByName('ITE_DESF04_NOV').Value) Or
            (FieldByName('ITE_DESF05').Value <> FieldByName('ITE_DESF05_NOV').Value) Or
            (FieldByName('ITE_DESF06').Value <> FieldByName('ITE_DESF06_NOV').Value) Or
            (FieldByName('ITE_ICMENT').Value <> FieldByName('ITE_ICMENT_NOV').Value) Or
            (FieldByName('ITE_IPIENT').Value <> FieldByName('ITE_IPIENT_NOV').Value) Or
            (FieldByName('ITE_FREENT').Value <> FieldByName('ITE_FREENT_NOV').Value) Or
            (FieldByName('ITE_ACRFIN').Value <> FieldByName('ITE_ACRFIN_NOV').Value) Or
            (FieldByName('ITE_SUBSTI').Value <> FieldByName('ITE_SUBSTI_NOV').Value) Or
            (FieldByName('ITE_VALFRE').Value <> FieldByName('ITE_VALFRE_NOV').Value) Or
            (FieldByName('ITE_DESADB').Value <> FieldByName('ITE_DESADB_NOV').Value) Or
            (FieldByName('ITE_SUBFED').Value <> FieldByName('ITE_SUBFED_NOV').Value) Or
            (FieldByName('ITE_OUTVAL').Value <> FieldByName('ITE_OUTVAL_NOV').Value) Or
            (FieldByName('ITE_PRECUS').Value <> FieldByName('ITE_PRECUS_NOV').Value) Or
            (FieldByName('ITE_ICMSAI').Value <> FieldByName('ITE_ICMSAI_NOV').Value) Or
            (FieldByName('ITE_IMPFED').Value <> FieldByName('ITE_IMPFED_NOV').Value) Or
            (FieldByName('ITE_DESOPE').Value <> FieldByName('ITE_DESOPE_NOV').Value) Or

            (FieldByName('ITE_MARBR1').Value <> FieldByName('ITE_MARBR1_NOV').Value) Or
            (FieldByName('ITE_PREVE1').Value <> FieldByName('ITE_PREVE1_NOV').Value) Or
            (FieldByName('ITE_COMTB1').Value <> FieldByName('ITE_COMTB1_NOV').Value) Or
            (FieldByName('ITE_MARBR2').Value <> FieldByName('ITE_MARBR2_NOV').Value) Or
            (FieldByName('ITE_PREVE2').Value <> FieldByName('ITE_PREVE2_NOV').Value) Or
            (FieldByName('ITE_COMTB2').Value <> FieldByName('ITE_COMTB2_NOV').Value) Or
            (FieldByName('ITE_MARBR3').Value <> FieldByName('ITE_MARBR3_NOV').Value) Or
            (FieldByName('ITE_PREVE3').Value <> FieldByName('ITE_PREVE3_NOV').Value) Or
            (FieldByName('ITE_COMTB3').Value <> FieldByName('ITE_COMTB3_NOV').Value) Or
            (FieldByName('ITE_MARBR4').Value <> FieldByName('ITE_MARBR4_NOV').Value) Or
            (FieldByName('ITE_PREVE4').Value <> FieldByName('ITE_PREVE4_NOV').Value) Or
            (FieldByName('ITE_COMTB4').Value <> FieldByName('ITE_COMTB4_NOV').Value) Or
            (FieldByName('ITE_MARBR5').Value <> FieldByName('ITE_MARBR5_NOV').Value) Or
            (FieldByName('ITE_PREVE5').Value <> FieldByName('ITE_PREVE5_NOV').Value) Or
            (FieldByName('ITE_COMTB5').Value <> FieldByName('ITE_COMTB5_NOV').Value) Or
            (FieldByName('ITE_MARBR6').Value <> FieldByName('ITE_MARBR6_NOV').Value) Or
            (FieldByName('ITE_PREVE6').Value <> FieldByName('ITE_PREVE6_NOV').Value) Or
            (FieldByName('ITE_COMTB6').Value <> FieldByName('ITE_COMTB6_NOV').Value) Or
            (FieldByName('ITE_MARBR7').Value <> FieldByName('ITE_MARBR7_NOV').Value) Or
            (FieldByName('ITE_PREVE7').Value <> FieldByName('ITE_PREVE7_NOV').Value) Or
            (FieldByName('ITE_COMTB7').Value <> FieldByName('ITE_COMTB7_NOV').Value) Or

            (FieldByName('ITE_TCIFCU').Value <> FieldByName('ITE_TCIFCU_NOV').Value) Or
            (FieldByName('ITE_TSCUST').Value <> FieldByName('ITE_TSCUST_NOV').Value) Or
            (FieldByName('ITE_DEPICO').Value <> FieldByName('ITE_DEPICO_NOV').Value) Or
            (FieldByName('ITE_DEICMS').Value <> FieldByName('ITE_DEICMS_NOV').Value) Or
            (FieldByName('ITE_FATREG').Value <> FieldByName('ITE_FATREG_NOV').Value) Or


            (FieldByName('ITE_MARID1').Value <> FieldByName('ITE_MARID1_NOV').Value) Or
            (FieldByName('ITE_MARID2').Value <> FieldByName('ITE_MARID2_NOV').Value) Or
            (FieldByName('ITE_MARID3').Value <> FieldByName('ITE_MARID3_NOV').Value) Or
            (FieldByName('ITE_MARID4').Value <> FieldByName('ITE_MARID4_NOV').Value) Or
            (FieldByName('ITE_MARID5').Value <> FieldByName('ITE_MARID5_NOV').Value) Or
            (FieldByName('ITE_MARID6').Value <> FieldByName('ITE_MARID6_NOV').Value) Or
            (FieldByName('ITE_MARID7').Value <> FieldByName('ITE_MARID7_NOV').Value)) Then
        Exit;
      If Not fRecalculaPrecos Then
        DataSet.Cancel;
    End;

  End;


End;

procedure TfrmAltPrecoIndividual.pAtualizaDadosDuplic;
  Var
    strSQL: String;
    qryUpd: TUniQuery;
    blnAlterouDados: Boolean;
begin
  blnAlterouDados := False;

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

      blnAlterouDados := True;

      Next;
    End;

    Filtered := False;
  End;

  If blnAlterouDados Then
  Begin
    qryGen.Close;
    qryGen.Open;
  End;

  FreeAndNil(qryUpd);
end;

procedure TfrmAltPrecoIndividual.pAtualizaDesSit(qryGenIte,
  qryGenPre: TUniQuery);
begin
   Try
    Try
      qryGenIte.SQL.Text := ' SELECT * FROM DESSIT WHERE ITE_CODITE = :CODITE ';
      qryGenIte.Close;
      qryGenIte.ParamByName('CODITE').AsString := qryGenPre.fieldbyname('ITE_CODITE').AsString;
      qryGenIte.Open;

      If qryGenIte.IsEmpty Then
         qryGenIte.Insert
      Else
        qryGenIte.Edit;

      qryGenIte.FieldByName('ITE_CODITE').AsString := qryGenPre.FieldByName('ITE_CODITE').AsString;
      qryGenIte.FieldByName('ITE_CRODOC').AsString := qryGenPre.FieldByName('ITE_CRODOC_NOV').AsString;
      qryGenIte.FieldByName('ITE_DESTAQ').AsString := qryGenPre.FieldByName('ITE_DESTAQ_NOV').AsString;
      qryGenIte.FieldByName('ITE_NOMITE').AsString := qryGenPre.FieldByName('ITE_NOMECO_NOV').AsString;
      qryGenIte.FieldByName('ITE_EXPALT').AsFloat  := qryGenPre.FieldByName('ITE_EXPALT_NOV').AsFloat;
      qryGenIte.FieldByName('ITE_EXPLAR').AsFloat  := qryGenPre.FieldByName('ITE_EXPLAR_NOV').AsFloat;
      qryGenIte.FieldByName('ITE_EXPPRO').AsFloat  := qryGenPre.FieldByName('ITE_EXPPRO_NOV').AsFloat;

      If Not fEmptyStr(qryGenPre.FieldByName('ITE_APLECO_NOV').AsString) Then
        qryGenIte.FieldByName('ITE_APLITE').AsString := qryGenPre.FieldByName('ITE_APLECO_NOV').AsString;

      If Not fEmptyStr(qryGenPre.FieldByName('ITE_DESECO_NOV').AsString) Then
        qryGenIte.FieldByName('ITE_DESITE').AsString := qryGenPre.FieldByName('ITE_DESECO_NOV').AsString;

      qryGenIte.Post;
    Finally
  qryGenIte.SQL.Clear;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Erro ao atualizar a tabela DESSIT '+ #13#10 + E.Message);
  End;
end;

{************************}
{* RECALCULA OS VALORES *}
{*********************AF*}
function TfrmAltPrecoIndividual.fRecalculaPrecos: Boolean;
  Var
    intContador: Integer;
    intAux: Integer;
begin
  Result := True;

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
    If ( intCustoVenda In[0,1] ) Or
       (Pos(TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName, 'ITE_DESMAX_NOV_ITE_DESMGE_NOV_ITE_DESMSU_NOV_ITE_DESMVM_NOV_ITE_DESMGM_NOV_ITE_DESMSM_NOV') > 0) Then
    Begin
      Result := Result And fRecalculaPreCusto;
    End
    Else
    Begin
      Result := Result And fRecalculaPreVendaOuMargem;
    End;

    Result := Result And fRecalculaPreLiq;

    If Not Result Then
      Exit;

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

      //#EXLUIVAZIOPARA NÃO VALIDAR SE cÓDIGO DE BARRAS FOR VAZIO
      strSQL := strSQL + '  (IFNULL(ITE_CODBAR, "#EXLUIVAZIO#") = :CODBAR AND ';

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
  Try
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
        //#EXLUIVAZIOPARA NÃO VALIDAR SE cÓDIGO DE BARRAS FOR VAZIO
        strSQL := strSQL + '  (IFNULL(ITE_CODBAR, "#EXLUIVAZIO#") = :CODBAR AND ';
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
        If Not fEmptyStr(qryGen.FieldByName('ITE_BAREMB_NOV').AsString) Then
          qryDup.ParamByName('BAREMB').AsString := FieldByName('ITE_BAREMB_NOV').AsString;

        qryDup.Open;

        If (qryDup.RecordCount > 0) Then
        Begin
          pAdicionaDuplic('S', qryDup, qryGen.FieldByName('ITE_CODITE').AsString + ' - ' +
                                       qryGen.FieldByName('ITE_DESITE').AsString);
        End;

        While Not qryDup.Eof Do
        Begin
          pAdicionaDuplic('N', qryGen, qryGen.FieldByName('ITE_CODITE').AsString + ' - ' +
                                       qryGen.FieldByName('ITE_DESITE').AsString);
          qryDup.Next;
        End;

        qryDup.Close;
        qryDup.SQL.Clear;
        qryDup.SQL.Add('SELECT      ');
        qryDup.SQL.Add('ITE_CODEMP, ');
        qryDup.SQL.Add('ITE_CODFOR, ');
        qryDup.SQL.Add('ITE_CODITE, ');
        qryDup.SQL.Add('ITE_DESITE, ');
        qryDup.SQL.Add('ITE_CODFAB, ');
        qryDup.SQL.Add('BAR_CODBAR AS ITE_CODBAR, ');
        qryDup.SQL.Add('ITE_BAREMB  ');
        qryDup.SQL.Add('FROM ITEBAR ');
        qryDup.SQL.Add('INNER JOIN CADITE ON ITE_CODITE = BAR_CODITE');
        qryDup.SQL.Add('                  AND ITE_CODITE <> :CODITE');
        qryDup.SQL.Add('                  AND BAR_CODBAR  = :CODBAR');
        qryDup.SQL.Add('                  AND IFNULL(BAR_CODBAR, "")  <> ""');

        qryDup.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
        qryDup.ParamByName('CODBAR').AsString := FieldByName('ITE_CODBAR_NOV').AsString;

        qryDup.Open;

        If (qryDup.RecordCount > 0) Then
        Begin
          pAdicionaDuplic('S', qryDup, qryGen.FieldByName('ITE_CODITE').AsString + ' - ' +
                                       qryGen.FieldByName('ITE_DESITE').AsString);
        End;

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
        cdsDuplic.AfterScroll := pCdsDuplicAfterScroll;

        pCriarFormularios(TfrmAltPrecoDuplicidades, frmAltPrecoDuplicidades);
        frmAltPrecoDuplicidades._objIteBar:= objIteBar;
        frmAltPrecoDuplicidades._cdsDuplic:= cdsDuplic;
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

      cdsDuplic.AfterScroll := Nil;

      FreeAndNil(frmAltPrecoDuplicidades);
    End;
  Finally
    Screen.Cursor := crDefault;
    cdsDuplic.Close;
    FreeAndNil(qryTmp);
    FreeAndNil(qryDup);
    qryGen.EnableControls;
  End;
end;

procedure TfrmAltPrecoIndividual.btnConfirmaAltClick(Sender: TObject);
begin
  pSetFocus(btnConfirmaAlt);
  cdsParametros.DisableControls;

  If Not fEmptyStr(edtDocumento.Text) Then
    If Not fVerificaCampos Then
      Exit;
  If InterlockedIncrement(intConfirmando) = 0 Then
  Begin

    Try
      if (blnCodBarPrincipal And blnCodBar) then
      Begin
        cdsParametros.Locate('CAMPO', 'BARPRV', []);
        If cdsParametrosMARCADO.AsBoolean Then
        Begin
          cdsParametros.Edit;
          cdsParametrosMARCADO.AsBoolean:= False;
          cdsParametros.Post;
        End;
        cdsParametros.First;
      End;
      pConfirma;
      InterlockedDecrement(intConfirmando);
    Except
      InterlockedDecrement(intConfirmando);
    End;

  End
  Else
    InterlockedDecrement(intConfirmando);

  cdsParametros.EnableControls;
  cdsParametros.First;

end;

procedure TfrmAltPrecoIndividual.pAtualizaIteger(qryGenIte, qryGenPre: TUniQuery; strEmpresas: String; blnResFor, IsAgendado: Boolean);
  Var
    strUpdTipPro: String;
    strUpdSitPro: String;
    qryTmp: TUniQuery;
    qryGen: TUniQuery;
    i: integer;
Begin
  With qryGenPre Do
  Begin
    qryGenIte.Close;
    qryGenIte.SQL.Clear;
    qryGenIte.SQL.Text := fGetSqlUpdateITEGER(IsAgendado, blnResFor);

    qryGenIte.ParamByName('NIVCRI').AsString  := FieldByName('ITE_NIVCRI_NOV').AsString;
    if not(IsAgendado) then
    begin
      qryGenIte.ParamByName('PREALT').AsString  := strAgrupadorPreAlt;
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
      qryGenIte.ParamByName('TCIFCU').AsFloat  := FieldByName('ITE_TCIFCU_NOV').AsFloat;
      qryGenIte.ParamByName('TSCUST').AsFloat  := FieldByName('ITE_TSCUST_NOV').AsFloat;
      qryGenIte.ParamByName('DEPICO').AsFloat  := FieldByName('ITE_DEPICO_NOV').AsFloat;
      qryGenIte.ParamByName('DEICMS').AsFloat  := FieldByName('ITE_DEICMS_NOV').AsFloat;
      qryGenIte.ParamByName('FATREG').AsFloat  := FieldByName('ITE_FATREG_NOV').AsFloat;
      qryGenIte.ParamByName('PRECUS').AsFloat  := FieldByName('ITE_PRECUS_NOV').AsFloat;
    end;
    qryGenIte.ParamByName('IPISAI').AsFloat  := FieldByName('ITE_IPISAI_NOV').AsFloat;
    if fCfgSis('NFEPEP', varBoolean) Then
      qryGenIte.ParamByName('OBRNFE').AsString  := FieldByName('ITE_OBRNFE_NOV').AsString;


    qryGenIte.ParamByName('RECDEV').AsString := FieldByName('ITE_RECDEV_NOV').AsString;
    qryGenIte.ParamByName('DESCHK').AsString := FieldByName('ITE_DESCHK_NOV').AsString;

    qryGenIte.ParamByName('CICMDE').AsString := FieldByName('ITE_CICMDE_NOV').AsString;
    qryGenIte.ParamByName('CDPIOP').AsString := FieldByName('ITE_CDPIOP_NOV').AsString;
    qryGenIte.ParamByName('DIDIOP').AsString := FieldByName('ITE_DIDIOP_NOV').AsString;

    if (not FPermVendaIgualTodasEmp) then
      qryGenIte.ParamByName('PERVDA').AsString := FieldByName('ITE_PERVDA_NOV').AsString;

    If fCfgSis('TPSPED') = '1' Then
      qryGenIte.ParamByName('TIPPRO').AsString := FieldByName('ITE_TIPPRO_NOV').AsString;

    If intSitPro = 2 Then
      qryGenIte.ParamByName('SITPRO').AsString  := FieldByName('ITE_SITPRO_NOV').AsString;

    If Not blnResFor Then
    Begin
      if not(IsAgendado) then
      begin
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

          qryGenIte.ParamByName('DESMVM').AsFloat := FieldByName('ITE_DESMVM_NOV').AsFloat;
          qryGenIte.ParamByName('DESMGM').AsFloat := FieldByName('ITE_DESMGM_NOV').AsFloat;
          qryGenIte.ParamByName('DESMSM').AsFloat := FieldByName('ITE_DESMSM_NOV').AsFloat;
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
        qryGenIte.ParamByName('MARMMV').AsFloat  := FieldByName('ITE_MARMMV_NOV').AsFloat;
      end;
      qryGenIte.ParamByName('MARMSG').AsFloat  := FieldByName('ITE_MARMSG_NOV').AsFloat;
      qryGenIte.ParamByName('MARMGE').AsFloat  := FieldByName('ITE_MARMGE_NOV').AsFloat;

      qryGenIte.ParamByName('MARMMS').AsFloat  := FieldByName('ITE_MARMMS_NOV').AsFloat;
      qryGenIte.ParamByName('MARMMG').AsFloat  := FieldByName('ITE_MARMMG_NOV').AsFloat;

      qryGenIte.ParamByName('QTPPRO').AsFloat  := FieldByName('ITE_QTPPRO_NOV').AsFloat;

      If fCfgSis('MARPAD') = 'S' Then
        qryGenIte.ParamByName('MARPAD').AsFloat  := FieldByName('ITE_MARPAD_NOV').AsFloat;

      If (fCfgSis('OPCCOM') <> 'PPT') Then
      begin
        qryGenIte.ParamByName('COMVAR').AsFloat  := FieldByName('ITE_COMVAR_NOV').AsFloat;
        qryGenIte.ParamByName('COMATA').AsFloat  := FieldByName('ITE_COMATA_NOV').AsFloat;
        qryGenIte.ParamByName('COMDIS').AsFloat  := FieldByName('ITE_COMDIS_NOV').AsFloat;
      end;
      qryGenIte.ParamByName('COMDIG').AsFloat  := FieldByName('ITE_COMDIG_NOV').AsFloat;
      qryGenIte.ParamByName('COMPRO').AsFloat  := FieldByName('ITE_COMPRO_NOV').AsFloat;

      If fCampoVisivel('PESOBR') And (cdsParametrosMARCADO.AsBoolean) Then
        qryGenIte.ParamByName('PESOBR').AsString := FieldByName('ITE_PESOBR_NOV').AsString;

      If fCampoVisivel('CPESOB') And (cdsParametrosMARCADO.AsBoolean) Then
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
    if blnUtilizaChecklistGarantia then
    qryGenIte.ParamByName('CODATC').AsString := FieldByName('ITE_CODATC_NOV').AsString;
    qryGenIte.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
    qryGenIte.ParamByName('CODEMP').AsString := strEmpresas;

    If qryGenIte.Params.FindParam('EMPLOG') <> Nil Then
      qryGenIte.ParamByName('EMPLOG').AsString := VS_strCodEmp;

    If qryGenIte.Params.FindParam('SOBENC') <> Nil Then
      qryGenIte.ParamByName('SOBENC').AsString := FieldByName('ITE_SOBENC_NOV').AsString;

    If qryGenIte.Params.FindParam('MLTRCA') <> Nil Then
      qryGenIte.ParamByName('MLTRCA').AsString := Copy(FieldByName('ITE_MLTRCA_NOV').AsString,1,1);

    If fCfgSis('LOCRET', varBoolean) Then
      qryGenIte.ParamByName('TIPRET').AsString := FieldByName('ITE_TIPRET_NOV').AsString;

    If qryGenIte.Params.FindParam('ITEBAS') <> Nil Then
      qryGenIte.ParamByName('ITEBAS').AsString := FieldByName('ITE_ITEBAS_NOV').AsString;

    qryGenIte.ExecSQL;
    If blnTabPrd Then
    Begin
      For i:= 1 To 7 Do
      begin
        If FieldByname('AUTINC' + i.ToString).AsString <> '' Then
        Begin
          qryDetCus.ParamByName('PREVEN').AsFloat := qryGenPre.FieldByName('ITE_PREVE'+i.ToString+'_NOV').AsFloat * qryGenPre.FieldByName('ITE_CNVCUS'+i.ToString).AsFloat;
          qryDetCus.ParamByName('MARBRU').AsFloat := qryGenPre.FieldByName('ITE_MARBR'+i.ToString+'_NOV').AsFloat;
          qryDetCus.ParamByName('SEQDET').AsString:= qryGenPre.FieldByname('AUTINC' + i.ToString).AsString;
          qryDetCus.ParamByName('TABELA').AsString:= i.ToString;
          qryDetCus.ExecSQL;
        End;
      End;
    End;


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
    intContador    : Integer;
    ObjCalculaVariacaoPreco : TCalculaVariacaoPreco;
    blnLOGCPR      : Boolean;

    blnComErro: Boolean;

  Const
    strInsTbp : String = ' INSERT INTO ITETBP (ITE_CODITE, ITE_CODEMP, ITE_TABPRE,  ITE_DESMAX, ITE_DESMGE, ITE_DESMSU, ITE_DESVMM, ITE_DESGMM, ITE_DESSMM) ' +
                                      'VALUES (   :CODITE,    :CODEMP,    :TABPRE,     :DESMAX,    :DESMGE,    :DESMSU,    :DESVMM,    :DESGMM,    :DESSMM);';


    strUptTbp : String = 'UPDATE ITETBP SET ITE_DESMAX = :DESMAX, ITE_DESMGE = :DESMGE, ITE_DESMSU = :DESMSU, ITE_DESVMM = :DESVMM, ITE_DESGMM = :DESGMM, ITE_DESSMM = :DESSMM ' +
                         'WHERE ITE_CODITE = :CODITE   ' +
                         '  AND ITE_CODEMP = :CODEMP   ' +
                         '  AND ITE_TABPRE = :TABPRE;  ' ;

  Procedure pSetParametrosIteTbp(strTabPre : String; fltMaxDes : Double = 0; fltMaxDge : Double = 0; fltMaxDSu : Double = 0;
                                                     fltMaxVmm : Double = 0; fltMaxGmm : Double = 0; fltMaxSmm : Double = 0;  strCodEmp:String = '');
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

      if Params.FindParam('DESVMM') <> NIl Then
        ParamByName('DESVMM').AsFloat     := fltMaxVmm;
      if Params.FindParam('DESGMM') <> NIl Then
        ParamByName('DESGMM').AsFloat     := fltMaxGmm;
      if Params.FindParam('DESSMM') <> NIl Then
        ParamByName('DESSMM').AsFloat     := fltMaxSmm;
    End;
  End;

Begin
  blnLOGCPR := fCfgSis('LOGCPR', VarBoolean);
  Result := False;
  blnComErro := False;

  qryGenPre := fCriaQuery(Self);
  qryGenIte := fCriaQuery(Self);
  qryGenEmp := fCriaQuery(Self);
  qryIteTbp := fCriaQuery(Self);

  stlEmpFilial :=  TStringList.Create;
  strEmpFilial :=  '';
  If Assigned(untFuncoesSimples.PrcSuspenteTimerPrincipal) Then
    untFuncoesSimples.PrcSuspenteTimerPrincipal(True);
  Try
    Try

    pPreAltDefineVariaveisAltPre(fNow, 'ALTERACAO DE PRECOS INDIVIDUAL', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    strEmpresas := fRetEmpresasUsamPrecoMatriz(Nil {stlEmpFilial}, ''{strCodEmp}, ''{strEmpPar}, True{blnSomenteAtivas});
    fRetEmpresasUsamPrecoMatriz(stlEmpFilial, ''{strCodEmp}, ''{strEmpPar}, True{blnSomenteAtivas});

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

        ObjCalculaVariacaoPreco := TCalculaVariacaoPreco.Create;

        If not ObjCalculaVariacaoPreco.fTravaPrecosForaPermitido(qryGenPre) Then
          Exit(False);
        FreeAndNil(ObjCalculaVariacaoPreco);

        If fCfgSis('MARNEG', varBoolean) Then
        Begin
          If Not TProdMargemNegativa.fLiberaMargemNegativa(qryGenPre, qryGenPre, rotAltPrecoIndividual) Then
            Exit;
        End;

        VS_blnGravaLogTransacao := False;
        VS_GravaUsuRep := 'N';

        pgbProgresso.Position       := 0;
        pgbProgresso.Properties.Max := RecordCount;
        Application.ProcessMessages;

        If Not IsEmpty Then
        Begin
         // pgbStatus.Visible := True;
         // pgbStatus.Max     := RecordCount;

          pSetaDisplayLabelGenPre(qryGenPre);

          First;

          While Not Eof Do
          Begin
            fStartTransaction;

            Try
              If blnLOGCPR Then
                pGravarLogCpr(qryGenPre);
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

              If (FieldByName('ITE_ESMIDG_NOV').AsString <> FieldByName('ITE_ESMIDG').AsString) Then
                UpdateIteger('ITE_ESMIDG', qryGenPre);

              If fCfgSis('MINPRO', varBoolean) Then
              Begin
                If (FieldByName('ITE_TPESTM_NOV').AsString <> FieldByName('ITE_TPESTM').AsString) Then
                  UpdateIteger('ITE_TPESTM', qryGenPre);
              End;

              {**********************************}
              {* TRATAMENTO DO ESTOQUE MÁXIMO DIGITADO  *}
              {*******************************  *}
              If (FieldByName('ITE_MAXDIG_NOV').AsFloat <> FieldByName('ITE_MAXDIG').AsFloat) Then
                UpdateIteger('ITE_MAXDIG', qryGenPre);

              If (FieldByName('ITE_MINDIG_NOV').AsFloat <> FieldByName('ITE_MINDIG').AsFloat) Then
                UpdateIteger('ITE_MINDIG', qryGenPre);
              {*****************************************}
              {* TRATAMENTO DA ABREVIAÇÃO FISCAL       *}
              {**************************************MV*}
              If (FieldByName('ITE_CODABF_NOV').AsString <> FieldByName('ITE_CODABF').AsString) And (fCfgSIs('TIPABF') = '2') Then
                  UpdateIteger('ITE_CODABF', qryGenPre);


              If (FieldByName('ITE_IMPDIR_NOV').AsString <> FieldByName('ITE_IMPDIR').AsString) And (fCfgSIs('IMPDIG') = '2') Then
                  UpdateIteger('ITE_IMPDIR', qryGenPre);

              If (FieldByName('ITE_USAPPF_NOV').AsString <> FieldByName('ITE_USAPPF').AsString) And (fCfgSIs('TIPABF') = '2') Then
                UpdateIteger('ITE_USAPPF', qryGenPre);

              pBloquearLiberarProdutoParaVendaEmTodasEmpresasQueUsamEssePreco(FieldByName('ITE_CODITE').AsString, 'S');

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

              pAtualizaIteger(qryGenIte, qryGenPre, strEmpresas, False, False);

              If blnInfMat And fEhEmpresaResponsavelFornecedor(FieldByName('ITE_CODFOR_NOV').AsString) Then
                pAtualizaIteger(qryGenIte, qryGenPre, strEmpresas, True, False);

              if FieldByName('ITE_IMPLIS_NOV').AsString <> FieldByName('ITE_IMPLIS').AsString Then
                pAtualizaImpLisLojas(FieldByName('ITE_IMPLIS_NOV').AsString, FieldByName('ITE_CODITE').AsString);

              if (FieldByName('ITE_APERET_NOV').AsString <> FieldByName('ITE_APERET').AsString) Then
                pAtualizaApeRetLojas(FieldByName('ITE_APERET_NOV').AsString, FieldByName('ITE_CODITE').AsString);

              if (FieldByName('ITE_APEENT_NOV').AsString <> FieldByName('ITE_APEENT').AsString) Then
                pAtualizaApeEntLojas(FieldByName('ITE_APEENT_NOV').AsString, FieldByName('ITE_CODITE').AsString);

              If (FieldByName('ITE_CRODOC_NOV').AsString <> FieldByName('ITE_CRODOC').AsString) Or
                 (FieldByName('ITE_DESTAQ_NOV').AsString <> FieldByName('ITE_DESTAQ').AsString) Or
                 (FieldByName('ITE_NOMECO_NOV').AsString <> FieldByName('ITE_NOMECO').AsString) Or
                 (FieldByName('ITE_APLECO_NOV').AsString <> FieldByName('ITE_APLECO').AsString) Or
                 (FieldByName('ITE_DESECO_NOV').AsString <> FieldByName('ITE_DESECO').AsString) Or
                 (FieldByName('ITE_EXPALT_NOV').AsString <> FieldByName('ITE_EXPALT').AsString) Or
                 (FieldByName('ITE_EXPLAR_NOV').AsString <> FieldByName('ITE_EXPLAR').AsString) Or
                 (FieldByName('ITE_EXPPRO_NOV').AsString <> FieldByName('ITE_EXPPRO').AsString) Then
                 pAtualizaDesSit(qryGenIte, qryGenPre);

              If (FieldByName('ITE_CPRCEN_NOV').AsString <> FieldByName('ITE_CPRCEN').AsString) Then
              Begin
                blnCprCenInd := fCfgSis('CPRIND', varBoolean);
                pAtualizaCprCenLojas(FieldByName('ITE_CODITE').AsString,
                                     FieldByName('ITE_CPRCEN_NOV').AsString,
                                     blnCprCenInd);
              End;

              qryGenIte.Close;
              pUpdateCADITE(qryGenPre);

              fAtualizaBarFabIte(FieldByName('ITE_CODITE').AsString);



              {***********************************}
              {* GRAVA LOG DE LOCALIZAÇÃO FÍSICA *}
              {********************************PZ*}
              If fGeraLogLocFis(FieldByName('ITE_LOCFIS_NOV').AsString,FieldByName('ITE_LOCFIS').AsString) Then
              Begin
                If (Not fGravaLogLocFisica(FieldByName('ITE_CODITE').AsString,
                                           FieldByName('ITE_LOCFIS').AsString,
                                           FieldByName('ITE_LOCFIS_NOV').AsString, 1, '')) Then
                Begin
                  fRollBack;
                  FreeAndNil(qryGenPre);
                  FreeAndNil(qryGenIte);
                  FreeAndNil(qryGenEmp);
                  Exit;
                End;
              End;

              If fGeraLogLocFis(FieldByName('ITE_LOCSUP_NOV').AsString, FieldByName('ITE_LOCSUP').AsString) Then
              Begin
                If (Not fGravaLogLocFisica(FieldByName('ITE_CODITE').AsString,
                                           FieldByName('ITE_LOCSUP').AsString,
                                           FieldByName('ITE_LOCSUP_NOV').AsString, 2, '')) Then
                Begin
                  fRollBack;
                  FreeAndNil(qryGenPre);
                  FreeAndNil(qryGenIte);
                  FreeAndNil(qryGenEmp);
                  Exit;
                End;
              End;

              If fCfgSis('OPCCOM', varString) = 'VT' Then
              Begin
                For intContador := 1 To Length(VS_strTabPrc) Do
                Begin
                  If VS_strTabPrc[intContador] = 'S' Then
                  Begin
                    //if chkVenInt.Checked Then
                      pGravaIteCom(FieldByName('ITE_CODITE').AsString,
                                  intToStr(intContador),
                                  'COM_VENINT',
                                  FieldByName('COM_VENIN'+intToStr(intContador)+'_NOV').AsFloat);

                    //if chkVenExt.Checked Then
                      pGravaIteCom(FieldByName('ITE_CODITE').AsString,
                                  intToStr(intContador),
                                  'COM_VENEXT',
                                  FieldByName('COM_VENEX'+intToStr(intContador)+'_NOV').AsFloat);
                  End;
                End;
              End;


              {*****************************************}
              {* GRAVA PREALT                          *}
              {**************************************AF*}
              strLocalErro := '[fGravaPreAlt]';
              If (Not VS_blnPreAltViaTrigger) Then
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

                           'ALTERACAO DE PRECOS INDIVIDUAL',

                           Nil,
                           '',
                           strLoginUsuarioLogado);

              pAtualizaItensGrupoPrecos(FieldByName('ITE_CODITE').AsString,
                                        'ALTERACAO DE PRECOS INDIVIDUAL', strAgrupadorPreAlt);


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

                    pSetParametrosIteTbp(intToStr(intCorre),0,0,0,0,0,0,strEmpFilial);

                    qryIteTbp.Open;

                    intTbpAux := qryIteTbp.FieldByName('QTDREG').AsInteger;

                    qryIteTbp.Close;
                    qryIteTbp.SQL.Clear;
                    qryIteTbp.SQL.Add( IIF(intTbpAux > 0, strUptTbp, strInsTbp) );

                    pSetParametrosIteTbp(intToStr(intCorre),
                                         FieldByName('ITE_DESMA' + intToStr(intCorre) + '_NOV').AsFloat,
                                         FieldByName('ITE_DESMG' + intToStr(intCorre) + '_NOV').AsFloat,
                                         FieldByName('ITE_DESMS' + intToStr(intCorre) + '_NOV').AsFloat,
                                         FieldByName('ITE_DESVM' + intToStr(intCorre) + '_NOV').AsFloat,
                                         FieldByName('ITE_DESGM' + intToStr(intCorre) + '_NOV').AsFloat,
                                         FieldByName('ITE_DESSM' + intToStr(intCorre) + '_NOV').AsFloat,
                                         strEmpFilial);

                    qryIteTbp.ExecSQL;
                    qryIteTbp.Close;
                  End;
                End;
              End;

              if blnUtilizaChecklistGarantia then
                TCheckListGarantiaController.pAtualizarChecklist(qryGenPre);

              fCommit;

            Except
              on E: Exception do
              Begin
                blnComErro := True;
                fRollBack;

                VS_blnGravaLogTransacao := True;
                VS_GravaUsuRep := 'S';

                pMensagensErro(E.Message, strLocalErro);
                Result := False;
                Break;
              End;
            End;

            Next;
          //  pgbStatus.StepBy(1);

            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;
          End; {While Not Eof Do}

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
         // pgbStatus.Visible := True;
         // pgbStatus.Max     := RecordCount;

          strProPri := fRetSequencial('PROPRI', VS_strCodEmp);

          While Not Eof Do
          Begin
            fStartTransaction;

            Try
              strLocalErro    := '';

              pIncluiPreIte(qryGenIte, qryGenPre, frmAltPrecoDigData.dtaData,
                                      'ALTERACAO DE PRECOS INDIVIDUAL', strProPri);

              If (FieldByName('ITE_CODABF_NOV').AsString <> FieldByName('ITE_CODABF').AsString) Then
              Begin
                If (fCfgSIs('TIPABF') = '2') Then
                  UpdateIteger('ITE_CODABF', qryGenPre)
                Else
                  pUpdateAbrvFiscalCadIte(FieldByName('ITE_CODABF_NOV').AsString, FieldByName('ITE_CODITE').AsString);

                pBloquearLiberarProdutoParaVendaEmTodasEmpresasQueUsamEssePreco(FieldByName('ITE_CODITE').AsString, 'N');
              End;

              pAtualizaIteger(qryGenIte, qryGenPre, strEmpresas, False, True);

              If (FieldByName('ITE_CRODOC_NOV').AsString <> FieldByName('ITE_CRODOC').AsString) Or
                 (FieldByName('ITE_DESTAQ_NOV').AsString <> FieldByName('ITE_DESTAQ').AsString) Or
                 (FieldByName('ITE_NOMECO_NOV').AsString <> FieldByName('ITE_NOMECO').AsString) Or
                 (FieldByName('ITE_APLECO_NOV').AsString <> FieldByName('ITE_APLECO').AsString) Or
                 (FieldByName('ITE_DESECO_NOV').AsString <> FieldByName('ITE_DESECO').AsString) Or
                 (FieldByName('ITE_EXPALT_NOV').AsString <> FieldByName('ITE_EXPALT').AsString) Or
                 (FieldByName('ITE_EXPLAR_NOV').AsString <> FieldByName('ITE_EXPLAR').AsString) Or
                 (FieldByName('ITE_EXPPRO_NOV').AsString <> FieldByName('ITE_EXPPRO').AsString) Then
                 pAtualizaDesSit(qryGenIte, qryGenPre);

              If blnInfMat And fEhEmpresaResponsavelFornecedor(FieldByName('ITE_CODFOR_NOV').AsString) Then
                pAtualizaIteger(qryGenIte, qryGenPre, strEmpresas, True, True);

              pUpdateCADITE(qryGenPre);

              fCommit;

            Except
              on E: Exception do
              Begin
                blnComErro := True;

                fRollBack;

                VS_blnGravaLogTransacao := True;
                VS_GravaUsuRep := 'S';

                pMensagensErro(E.Message, strLocalErro);
                Result := False;
                Break;
              End;
            End;

            Next;
         //   pgbStatus.StepBy(1);

            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;
          End; {While Not Eof Do}

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

    Result := Not blnComErro;

  Except on E: Exception do
    Begin
      VS_blnGravaLogTransacao := True;
      VS_GravaUsuRep := 'S';

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
    If Assigned(untFuncoesSimples.PrcSuspenteTimerPrincipal) Then
      untFuncoesSimples.PrcSuspenteTimerPrincipal(False);

    VS_blnGravaLogTransacao := True;
    VS_GravaUsuRep := 'S';
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
//  FrameAlteraPrecoIndividual.cxvTiposAlt.OptionsData.Editing := blnHabilita;

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
  Try
    If qryGen.State = dsEdit Then
      qryGen.Cancel;

    case MomentoOperacao of
       moAlteracao: Begin
                      If fMensagem('','Cancela registros?',['&Sim','&Não'],2) = 1 Then
                      Begin

                        If Assigned(ColumnDesIte) Then
                          FreeAndNil(ColumnDesIte);

                        qryGen.BeforeScroll := Nil;
                        pDeletaTemporaria(False);
                        fFecharTabela(qryGen);
                        pnlCabecalho.Enabled := True;
                      //  pLimpaCampos;
                        FrameAlteraPrecoIndividual.cxgTiposAlt.Enabled := False;
                        pnlFiltros.Visible  := True;
                        btnEstLoj.Visible := False;
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
                        BackMomentoOperacao;
                      End;
                    End;

      moConfimacaoAlteraco :Begin
                              If Assigned(ColumnDesIte) Then
                                FreeAndNil(ColumnDesIte);

                              pnlCabecalho.Visible := True;
                              blnAlterouAlgumRegistro := False;
                              pMostraColunasAntigasCx(False);
                              pAtualizaTemporaria(False,'');
                              fMontaGrid;
                              pRestauraPosicaoUsuario;
                              FrameAlteraPrecoIndividual.blnProcessoConfirmacao := False;
                              BackMomentoOperacao;
                            End;

      moFiltros: inherited;

    End;
  Finally
    If Assigned(FrameAlteraPrecoIndividual) Then
      FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource := dtsGen;
    qryGen.EnableControls;
    blnCodBarPrincipal:= False;
    blnCodBar:= False;
    blnRestaurandoCopiaSeg := False;
  End;
end;

procedure TfrmAltPrecoIndividual.cbxMarIdeChange(Sender: TObject);
begin
  inherited;

  pHabilitaCamposMargemIdeal;
end;

procedure TfrmAltPrecoIndividual.cdsParametrosBeforePost(DataSet: TDataSet);
begin
  inherited;

  If ((cdsParametrosCAMPO.AsString = 'CODITE') Or
      (cdsParametrosCAMPO.AsString = 'DESITE')) And
      (Not cdsParametrosMARCADO.AsBoolean) Then
    cdsParametrosMARCADO.AsBoolean :=  True;

  If (cdsParametrosCAMPO.AsString = 'BARPRV') And
      (cdsParametrosMARCADO.AsBoolean) Then
     blnCodBarPrincipal:= True
  Else
  If (cdsParametrosCAMPO.AsString = 'BARPRV') And
      (Not cdsParametrosMARCADO.AsBoolean) Then
     blnCodBarPrincipal:= False;

  If (cdsParametrosCAMPO.AsString = 'CODBAR') And
      (cdsParametrosMARCADO.AsBoolean) Then
     blnCodBar:= True
  Else
  If (cdsParametrosCAMPO.AsString = 'CODBAR') And
      (Not cdsParametrosMARCADO.AsBoolean) Then
     blnCodBar:= False;



end;

procedure TfrmAltPrecoIndividual.pCdsDuplicAfterScroll(DataSet: TDataSet);
begin
  cdsDuplic.ReadOnly := cdsDuplic.FieldByName('ORIGEM').AsString <> 'N';
end;

procedure TfrmAltPrecoIndividual.cmbEsMiDgPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  if fCfgSis('MINPRO', varBoolean) Then
  Begin
    if DisplayValue = 'Gerado' Then
    Begin
      With FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet Do
      Begin
        Edit;
        FieldByName('ITE_TPESTM_NOV').AsString := '';
        FieldByName('ITE_ESMIDG_NOV').AsString := 'G';
        Post;
      End;
      ErrorText := '';
      Error     := False;
    End
    Else If DisplayValue = 'Digitado' Then
    Begin
      With FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet Do
      Begin
        Edit;
        FieldByName('ITE_TPESTM_NOV').AsString := 'D';
        FieldByName('ITE_ESMIDG_NOV').AsString := 'D';
        Post;
      End;
      ErrorText := '';
      Error     := False;
    End;
  End;
end;

procedure TfrmAltPrecoIndividual.cmbSimNaoPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If (Pos(LeftStr(TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName, 10), 'ITE_ITEATI') > 0) And
     (DisplayValue = 'Não') And
     (Not fInativarProduto) Then
  Begin
    Error := True;
    ErrorText := '';
  End;
end;

procedure TfrmAltPrecoIndividual.cmbTpEstMPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  if fCfgSis('MINPRO', varBoolean) Then
  Begin
    if (FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.FieldByName('ITE_ESMIDG_NOV').AsString = 'G') and (Trim(DisplayValue) <> '') Then
    Begin
      pMensagemOk('Quando o campo "Opção Estoque Mínimo" for "G" este campo deve ser vazio!');
      With FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet Do
      Begin
        Edit;
        FieldByName('ITE_TPESTM_NOV').AsString := '';
        Post;
      End;
      ErrorText := '';
      Error     := False;
    End
    Else If (FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.FieldByName('ITE_ESMIDG_NOV').AsString = 'D') and (Trim(DisplayValue) = '') Then
    Begin
      pMensagemOk('Quando o campo "Opção Estoque Mínimo" for "D" este campo não deve ser vazio!');
      With FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet Do
      Begin
        Edit;
        FieldByName('ITE_TPESTM_NOV').AsString := 'D';
        Post;
      End;
      ErrorText := '';
      Error     := False;
    End;
  End;
end;

procedure TfrmAltPrecoIndividual.cxeBarPrinVendaCompraPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    strCodigo: String;
    blnValidaCodBarra: Boolean;
begin
  inherited;

  If Not Assigned(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn) Then
    Exit;

  strCodigo := DisplayValue;

  If (Not fEmptyStr(strCodigo)) And (TcxTextEdit(Sender).Properties.MaxLength > 0) Then
    DisplayValue := strCodigo;

  blnValidaCodBarra:= objIteBar.fValidaCodBar(DisplayValue);

  If Not(blnValidaCodBarra) Then
    Error:= True;

  If Error Then
    ErrorText := '';
end;


procedure TfrmAltPrecoIndividual.cxBtnCklMerGarPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Type
    TProcExibirChecklist = reference to procedure(const pstrCodIte: String; var pstrSerializado: String; pstrCodEmp: String = '');

  CONST
    CPO_NOME_GARANTIA: String =  'TMP_CKLGAR';
    CPO_NOME_TROCA: String = 'TMP_CKLTRO';

  Var
    strCodIte: String;
    blnCklGar,
    blnCklTro: Boolean;
    strJson: String;
    strFieldName: String;
    objCampo, objCampoNovo: TField;
    lpExibir: TProcExibirChecklist;
    enuGrupo: TGrupoCheckList;
begin
  inherited;
  strCodIte := FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.FieldByName('ITE_CODITE').AsString;
  blnCklGar := pos(CPO_NOME_GARANTIA, FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.Controller.FocusedItem.Name) > 0 ;
  blncklTro := pos(CPO_NOME_TROCA, FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.Controller.FocusedItem.Name) > 0 ;

  if blnCklGar then
  begin
    strFieldName := CPO_NOME_GARANTIA;
    enuGrupo := TGrupoCheckList.Garantia;
    lpExibir := TCheckListGarantiaController.pExibirChecklistGarantiaAlt;
  end
  else if blnCklTro then
  begin
    strFieldName := CPO_NOME_TROCA;
    enuGrupo := TGrupoCheckList.Troca;
    lpExibir := TCheckListGarantiaController.pExibirChecklistTrocaAlt;
  end
  else
    Exit;

  objCampo := qryGen.FieldByName(strFieldName);
  objCampoNovo := qryGen.FieldByName(strFieldName+'_NOV');

  Try
    qryGen.Edit;
    If objCampo.AsString = EmptyStr then
    begin
      strJson :=  TCheckListGarantiaController.fChecklistAsStringJson(strCodIte, VS_strCodEmp, enuGrupo);
      objCampo.AsString := strJson;
    end
    else
      strJson := objCampoNovo.AsString;

    lpExibir(strCodIte, strJson);
    objCampoNovo.AsString := strJson;
  Except
    On E: Exception do
    begin
      qryGen.Cancel;
    end;
  End;
end;

procedure TfrmAltPrecoIndividual.cxBtnMontadoraPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var strMonSel: String;
begin
  inherited;
  strMonSel :=  TfrmSelMontadoras.fSelecionaMontadoras(FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.FieldByName('ITE_CODITE').AsString,
                                                       FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.FieldByName('ITE_CODMON_NOV').AsString);
  If (strMonSel <> FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.FieldByName('ITE_CODMON_NOV').AsString) Then
  Begin
    FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.Edit;
    FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.FieldByName('ITE_CODMON_NOV').AsString := strMonSel;
    FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSet.Post
  End;


end;

procedure TfrmAltPrecoIndividual.cxeClassfIPIPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fEmptyStr(DisplayValue) Then
  Begin

    If Length(DisplayValue) <> MAX_CLAIPI Then
    Begin
      Error := True;
      ErrorText := '';
      fMensagem('', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&OK']);
    End;

  End;

end;

procedure TfrmAltPrecoIndividual.cxeConsTam2PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    strCodigo: String;
    strDescricao: string;
    strCampoFocado: String;
    campo: TCampo;
begin
  inherited;

  If Not Assigned(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn) Then
    Exit;

  strCampoFocado := TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName;

  strCodigo := DisplayValue;

  If (((Not fEmptyStr(strCodigo)) And (TcxTextEdit(Sender).Properties.MaxLength > 0)) And (Pos('%', strCodigo) <= 0 )) Then
    DisplayValue := fStrZero(strCodigo, TcxTextEdit(Sender).Properties.MaxLength);

  strDescricao := FrameAlteraPrecoIndividual.fRetDescricaoCadastro(strCampoFocado, DisplayValue, True, Error);

  If (strDescricao <> '') And (strCampoFocado <> '') Then
  Begin
    campo := fRetCampoDesc(strCampoFocado);
    If (campo.FieldName <> '') And (  Not (campo.FieldName = strCampoFocado)) Then
    Begin
      If qryGen.State in dsEditModes Then
      Begin
        qryGen.FieldByName(campo.FieldName).AsString := strDescricao;
      End;
    End;
  end;
  If Error Then
    ErrorText := '';
end;

procedure TfrmAltPrecoIndividual.cxeDatePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If (Pos(LeftStr(TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName, 10), 'ITE_DTAVAL') > 0) And
     (StrToDate(DisplayValue) <= fNow) Then
  Begin
    fMensagem('','Data da Validade de Preço precisa ser maior ou igual que a data atual!',['&OK']);

    Error := True;

    ErrorText := '';

    Exit;
  End;

end;

procedure TfrmAltPrecoIndividual.cxeFatComPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    fltValor: Double;
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

    Exit;
  End;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If Not TryStrToFloat(DisplayValue, fltValor) Then
  Begin
    Error := True;
    ErrorText := '';
  End Else
  Begin

    If Not fValidaValor(DisplayValue) Then
    Begin
      Error := True;
      ErrorText := '';
      Exit;
    End

  End;

end;

procedure TfrmAltPrecoIndividual.cxeInt03PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    intValor: Integer;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If Not TryStrToInt(DisplayValue, intValor) Then
  Begin
    Error := True;
    ErrorText := '';
  End

  Else If Not fValidaValor(DisplayValue) Then
  Begin
    Error := True;
    ErrorText := '';
  End;

end;

Function TfrmAltPrecoIndividual.fValidaValor(strValor: String): Boolean;
Begin

  Result := True;

  If (Pos(LeftStr(TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName, 10), 'ITE_FATUTR') > 0) And
     (fStrToFloat(strValor) <= 0) Then
  Begin
    Result := False;
    pMensagemOk('O ' + TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).Caption + ' deve se maior que zero!');
  End

  Else If (Pos('MARBR', TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName) = 0) And
          (fStrToFloat(strValor) < 0) Then
  Begin
    Result := False;

    pMensagemOk('O ' + TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).Caption + ' deve se maior ou igual a zero!');
  End;

End;

procedure TfrmAltPrecoIndividual.cxeMasFatPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    fltValor: Double;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If Not TryStrToFloat(DisplayValue, fltValor) Then
  Begin
    Error := True;
    ErrorText := '';
  End Else
  Begin

    If Not fValidaValor(DisplayValue) Then
    Begin
      Error := True;
      ErrorText := '';
    End

  End;
end;

procedure TfrmAltPrecoIndividual.cxeMasPerPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    fltValor: Double;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If Not TryStrToFloat(DisplayValue, fltValor) Then
  Begin
    Error := True;
    ErrorText := '';
  End Else
  Begin

    If Not fValidaValor(DisplayValue) Then
    Begin
      Error := True;
      ErrorText := '';
    End

    Else If (Pos(LeftStr(TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName, 10),
                 'ITE_PER_CI-ITE_PIMPTC-ITE_COMDIG-ITE_IMPFED-ITE_DESSIT-ITE_DESOPE-ITE_PORPES') > 0) And
            (Not fValidaEscala(DisplayValue, 0, 100)) Then
    Begin
      Error := True;
      ErrorText := '';

      pMensagemOk('O ' + TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).Caption + ' deve estar entre 0 e 100!');
    End;

  End;

end;

procedure TfrmAltPrecoIndividual.cxeString03PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fEmptyStr(DisplayValue) Then
  Begin

    If (Pos(LeftStr(TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName, 10), 'ITE_EXCIPI') > 0) And
       (StrToIntDef(DisplayValue, -1) <= 0) Or
       (StrToIntDef(DisplayValue, -1) > 11) Then
    Begin
      fMensagem('', 'O campo EX IPI deve ser (vazio) ou estar na faixa de 1 até 11!', ['&OK']);
      Error := True;
      ErrorText := '';
    End;

 End;

end;

procedure TfrmAltPrecoIndividual.cxeString70PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    strCodigo: String;
    blnValidaCodBarra: Boolean;
begin
  inherited;

  If Not Assigned(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn) Then
    Exit;

  strCodigo := DisplayValue;

  If (Not fEmptyStr(strCodigo)) And (TcxTextEdit(Sender).Properties.MaxLength > 0) Then
    DisplayValue := strCodigo;

  blnValidaCodBarra:= objIteBar.fValidaCodBar(DisplayValue);

  If Not(blnValidaCodBarra) Then
    Error:= True;

  If Error Then
    ErrorText := '';
end;

procedure TfrmAltPrecoIndividual.cxGridViewDESCRIGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  AText := Copy(AText, 1, pos('|', AText) -1);
end;

procedure TfrmAltPrecoIndividual.cxGridViewDataControllerFilterChanged(Sender: TObject);
  var
  I: Integer;
  strFiltro, S: string;

begin
  inherited;

  If cxGridView.ViewData.FilterRow.Focused then
  begin
    for I := 0 to cxGridView.ColumnCount - 1 do
    begin
      S := VarToStr(cxGridView.ViewData.FilterRow.Values[I]);
      if (Length(S)> 0) and (S[1] <> '%') then
        cxGridView.ViewData.FilterRow.Values[I] := '%' + S;
    end;
  end;
  strFiltro := cxGridView.DataController.Filter.FilterText;
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

  pBeforePost(dtsGen.DataSet);
end;

function TfrmAltPrecoIndividual.fQtdRegistros(blnTodos: Boolean = False): Integer;
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
    If Not blnTodos Then
    Begin
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ALTERA = "S" ';
    End;

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
       pSetFocus(FrameAlteraPrecoIndividual.cxgTiposAlt);
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
  objDataSet: TDataSet;
  strFieldName: string;
Begin
  Result := 0;

  If Not Assigned(proProperties) Then
    Exit;

  If proProperties.ClassType = TcxLookupComboBoxProperties Then
  Begin
    objDataSet := TcxLookupComboBoxProperties(proProperties).ListSource.DataSet;
    strFieldName := TcxLookupComboBoxProperties(proProperties).ListFieldNames;

    if not Assigned(objDataSet.FindField(strFieldName)) then
    begin
      if TcxLookupComboBoxProperties(proProperties).ListColumns.Count = 0 then
        exit;

      strFieldName := TcxLookupComboBoxProperties(proProperties).ListColumns[0].FieldName;
      if not Assigned(objDataSet.FindField(strFieldName)) then
        exit;
    end;

    objDataSet.First;
    While Not objDataSet.Eof Do
    Begin
      If Self.Canvas.TextWidth(objDataSet.FieldByName(strFieldName).AsString) > Result Then
        Result := Self.Canvas.TextWidth(objDataSet.FieldByName(strFieldName).AsString);
      objDataSet.Next;
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

function TfrmAltPrecoIndividual.fGetSqlUpdateCADITE(AQuery: TUniQuery): string;
begin
  Result :=  'UPDATE CADITE ' +
             '   SET ITE_DESITE = :DESITE,  ' +
             '       ITE_DESSIM = :DESSIM,  ' +
             '       ITE_DESFAB = :DESFAB,  ' +
             '       ITE_DIFICM = :DIFICM,  ' +
             '       ITE_MSGLV1 = :MSGLV1,  ' +
             '       ITE_MSGLV2 = :MSGLV2,  ' +
             '       ITE_REFERE = :REFERE,  ' +
             '       ITE_ITEATI = :ITEATI,  ' +
             '       ITE_GRAMAR = :GRAMAR,  ' +
             '       ITE_USAPFD = :USAPFD,  ' +
             '       ITE_USAPCV = :USAPCV,  ' +
             '       ITE_EXPPOK = :EXPPOK,  ';


  If (AQuery.FieldByName('ITE_ITEATI_NOV').AsString = 'N') And (AQuery.FieldByName('ITE_ITEATI').AsString = 'S') Then
    Result := Result + ' ITE_DTAINA = CURDATE(), '
  Else If (AQuery.FieldByName('ITE_ITEATI_NOV').AsString = 'S') And (AQuery.FieldByName('ITE_ITEATI').AsString = 'N') Then
    Result := Result + ' ITE_DTAINA = NULL, ';

  If fCfgSIs('TIPABF') = '1' Then
    Result := Result + '  ITE_CODABF = :CODABF, ';

  If fCfgSIs('IMPDIG') = '1' Then
    Result := Result + '  ITE_IMPDIR = :IMPDIR, ';

  If fCfgSIs('TIPABF') = '1' Then
    Result := Result + '  ITE_USAPPF = :USAPPF, ';

  If fCfgSis('TPABPC') = '1' Then
  Begin
    Result := Result + '  ITE_ABFPIS = :ABFPIS, ' +
                       '  ITE_ABFCOF = :ABFCOF, ' +
                       '  ITE_ABFIPI = :ABFIPI, ';
  End;

  Result := Result + '  ITE_CLAIPI = :CLAIPI, ' +
                     '  ITE_EXCIPI = :EXCIPI, ' +
                     '  ITE_GRUCMP = :GRUCMP, ' +
                     '  ITE_CODGPR = :CODGPR, ' +
                     '  ITE_CDCEST = :CDCEST, ' +
                     '  ITE_APLICA = :APLICA, ' +
                     '  ITE_PER_CI = :PER_CI, ' +
                     '  ITE_PIMPTC = :PIMPTC, ' +
                     '  ITE_NUMFCI = :NUMFCI, ' +
                     '  ITE_MLTCOM = :MLTCOM, ' +
                     '  ITE_MLTVEN = :MLTVEN, ' +
                     '  ITE_CODFAB = :CODFAB, ' +
                     '  ITE_CODBAR = :CODBAR, ' +
                     '  ITE_MESGIR = :MESGIR, ';

  If fCampoVisivel('TMPGAR') And (cdsParametrosMARCADO.AsBoolean) Then
    Result := Result + '  ITE_TMPGAR = :TMPGAR, ' ;

  If fCampoVisivel('INFGAR') And (cdsParametrosMARCADO.AsBoolean) Then
    Result := Result + '  ITE_INFGAR = :INFGAR, ';

  If fCampoVisivel('RSPGAR') And (cdsParametrosMARCADO.AsBoolean) Then
    Result := Result + '  ITE_RSPGAR = :RSPGAR, ';

  if not fCfgSis('NFEPEP', varBoolean) then
  begin
    Result := Result +  '  ITE_OBRNFE = :OBRNFE, ';
  end;

  Result := Result + '  ITE_EMBALA = :EMBALA, ' +
                     '  ITE_BAREMB = :BAREMB, ' +
                     '  ITE_PESOIT = :PESOIT, ' +
                     '  ITE_PESLIQ = :PESLIQ, ' +
                     '  ITE_INFLAM = :INFLAM, ' +
                     '  ITE_USABON = :USABON, ' +
                     '  ITE_USAFLE = :USAFLE, ' +
                     '  ITE_OBRCPF = :OBRCPF, ' +
                     '  ITE_OBRIBA = :OBRIBA, ' +
                     IIf(not fCfgSis('NFEPEP', varBoolean), ' ITE_OBRNFE = :OBRNFE, ', '') +
                     '  ITE_NVLGIR = :NVLGIR, ' +
                     '  ITE_NVLCRI = :NVLCRI, ' +
                     '  ITE_PROEMB = :PROEMB, ' +
                     '  ITE_ACOOBJ = :ACOOBJ, ' +
                     '  ITE_VALOBR = :VALOBR, ' +
                     '  ITE_CODUNI = :CODUNI, ' +
                     '  ITE_UNICOM = :UNICOM, ' +
                     '  ITE_UNITRI = :UNITRI, ' +
                     '  ITE_FATUTR = :FATUTR, ' +
                     '  ITE_ITEBAS = :ITEBAS, ' +
                     '  ITE_CODMAR = :CODMAR, ';
  If intSitPro = 1 Then
    Result := Result + '  ITE_SITPRO = :SITPRO, ';

    Result := Result + '  ITE_CODMON = :CODMON, ' +
                       '  ITE_CODFOR = :CODFOR, ' +
                       '  ITE_DIAFOR = :DIAFOR, ' +
                       '  ITE_REAEND = :REAEND, ' +
                       '  ITE_OBRBAR = :OBRBAR, ' +
                       '  ITE_FATCOM = :FATCOM, ' +
                       '  ITE_CODDEP = :CODDEP, ' +
                       '  ITE_NOTESP = :NOTESP, ' +
                       '  ITE_PRDGRU = :PRDGRU, ' +
                       '  ITE_ATICOM = :ATICOM, ' +
                       '  ITE_CODDIC = :CODDIC, ' +
                       '  ITE_IMPETI = :IMPETI, ' +
                       '  ITE_FATCMP = :FATCMP, ' +
                       '  ITE_FATPM3 = :FATPM3, ' +
                       '  ITE_PEFUTP = :PEFUTP, ' +
                       '  ITE_PEEFUT = :PEEFUT, ' +
                       '  ITE_PEFFPR = :PEFFPR, ';

  If fCampoVisivel('DENSID') And (cdsParametrosMARCADO.AsBoolean) Then
    Result := Result + '  ITE_DENSID = :DENSID, ';

  if blnURapel then
    Result := Result + '  ITE_PRAPEL = :PRAPEL,  ';

  If fUsaRotinaWMS Then
    Result := Result + '  ITE_RASTRE = :RASTRE, ';

  Result := Result + '  ITE_DTAALT = :DTAALT, ' +
                     '  ITE_HULALT = :HULALT, ' +
                     '  ITE_CODOPE = :CODOPE, ' +
                     '  ITE_CODGRU = :CODGRU, ' +
                     '  ITE_TIPFRE = :TIPFRE, ' +
                     '  ITE_VLCFRE = :VLCFRE, ' +
                     '  ITE_LARVID = :LARVID, ' +
                     '  ITE_ALTVID = :ALTVID, ' +
                     '  ITE_LAMAVI = :LAMAVI, ' +
                     '  ITE_ALMAVI = :ALMAVI, ' +
                     '  ITE_UTIAMP = :UTIAMP, ' +
                     '  ITE_LOTEPD = :LOTEPD, ' +
                     '  ITE_ORDSER = :ORDSER, ' +
                     '  ITE_UTIAMP = :UTIAMP, ' +
                     '  ITE_CODGPC = :CODGPC, ' +
                     '  ITE_LOTEPD = :LOTEPD, ' +
                     '  ITE_DESCND = :DESCND, ' +
                     '  ITE_CLACRM = :CLACRM, ' +
                     '  ITE_CAREST = :CAREST, ' +
                     IIF(FPermVendaIgualTodasEmp, '  ITE_PERVDA = :PERVDA, ', '') +
                     '  ITE_BAREXP = :BAREXP, ' +
                     '  ITE_SEPBAR = :SEPBAR, ' +
                     '  ITE_EXPSIT = :EXPSIT, ' +
                     '  ITE_DTAEPI = :DTAEPI  ';


  If (fCfgSis('CLAONU', varBoolean)) Then
    Result := Result + ' , ITE_CODONU = :CODONU  ';

  If (fCfgSis('EMPCAR', varBoolean)) Then
    Result := Result + ' , ITE_EMPCAR = :EMPCAR  ';

  if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
    Result := Result + ' , ITE_EMPSUG = :EMPSUG  ';

  If fCfgSis('SEPEXC', varBoolean) Then
    Result := Result + ' , ITE_SEPEXC = :SEPEXC ';

  If fCfgSis('UTPEST', varBoolean) Then
  Begin
    Result := Result + ' , ITE_QTDPES = :QTDPES ';
    Result := Result + ' , ITE_PORPES = :PORPES ';
  End;

  If fCfgSis('ETIDCE', varBoolean) Then
    Result := Result + ' , ITE_NECEXP = :NECEXP ';


  If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
  Begin
    Result := Result + ' , ITE_NFEIDP = :NFEIDP ';
    Result := Result + ' , ITE_NFCIDP = :NFCIDP ';
  End;

  If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
    Result := Result + ' , ITE_LOTRAP = :LOTRAP ';

  If fCfgSis('TRITTE', varBoolean) Then
    Result := Result + ' , ITE_TRITTE = :TRITTE ';

  If fCfgSis('CDPHAB', varBoolean) Then
    Result := Result + ' , ITE_CLBPIN = :CLBPIN ';

  If blnUsaBef Then
    Result := Result + ' , ITE_USABEF = :USABEF ';

  Result := Result + 'WHERE ITE_CODITE = :CODITE ';
end;

function TfrmAltPrecoIndividual.fGetSqlUpdateITEGER(IsAgendado, blnResFor: Boolean): string;
begin
    Result := Result + ' UPDATE ITEGER                                        ' +
                       '  INNER JOIN CADEMP ON EMP_CODEMP = ITEGER.ITE_CODEMP ' +
                       '  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID        ' +
                       '    SET                                               ' +
                       IfThen(Not(IsAgendado),
                       '        ITE_PRECOM = :PRECOM,                         ' +
                       '        ITE_DESF01 = :DESF01,                         ' +
                       '        ITE_DESF02 = :DESF02,                         ' +
                       '        ITE_DESF03 = :DESF03,                         ' +
                       '        ITE_DESF04 = :DESF04,                         ' +
                       '        ITE_DESF05 = :DESF05,                         ' +
                       '        ITE_DESF06 = :DESF06,                         ' +
                       '        ITE_ICMENT = :ICMENT,                         ' +
                       '        ITE_SUBFED = :SUBFED,                         ' +
                       '        ITE_IPIENT = :IPIENT,                         ' +
                       '        ITE_FREENT = :FREENT,                         ' +
                       '        ITE_VALFRE = :VALFRE,                         ' +
                       '        ITE_ACRFIN = :ACRFIN,                         ' +
                       '        ITE_PREALT = :PREALT,                         ' +
                       '        ITE_SUBSTI = :SUBSTI,                         ' +
                       '        ITE_DESADB = :DESADB,                         ' +
                       '        ITE_TCIFCU = :TCIFCU,                         ' +
                       '        ITE_TSCUST = :TSCUST,                         ' +
                       '        ITE_DEPICO = :DEPICO,                         ' +
                       '        ITE_DEICMS = :DEICMS,                         ' +
                       '        ITE_FATREG = :FATREG,                         ' +
                       '        ITE_PRECUS = :PRECUS,                         ')+

                       '        ITE_IPISAI = :IPISAI,                         ' +
                       '        ITE_RECDEV = :RECDEV,                         ' +
                       '        ITE_DESCHK = :DESCHK,                         ' +
                       '        ITE_CICMDE = IF(LOCATE(CID_ESTADO, "' + ESTADOS_REGRA_ZONA_FRANCA + '") = 0, "N", :CICMDE), ' +
                       '        ITE_CDPIOP = IF(LOCATE(CID_ESTADO, "' + ESTADOS_REGRA_ZONA_FRANCA + '") = 0, "N", :CDPIOP), ' +
                       '        ITE_DIDIOP = IF(LOCATE(CID_ESTADO, "' + ESTADOS_REGRA_ZONA_FRANCA + '") = 0, "N", :DIDIOP)  ';

    If fCfgSis('MARPAD') = 'S' Then
      Result := Result + ',ITE_MARPAD = :MARPAD ';

    If fCfgSis('TPSPED') = '1' Then
      Result := Result + ', ITE_TIPPRO = :TIPPRO  ';

    If intSitPro = 2 Then
      Result := Result + ',  ITE_SITPRO = :SITPRO ';

    if (not FPermVendaIgualTodasEmp) then
      Result := Result + ',  ITE_PEVNDA = :PERVDA ';

    Result := Result + ',  ITE_NIVCRI = :NIVCRI ';

    If Not blnResFor Then
    Begin
      Result := Result + ', ';

      If blnInfMat And (intInfSai = 1) Then
        Result := Result + IfThen(Not(IsAgendado),'  ITE_ICMSAI = IF(:EMPLOG = ITE_CODEMP, :ICMSAI, ITE_ICMSAI), ')
      Else
        Result := Result + IfThen(Not(IsAgendado),'  ITE_ICMSAI = :ICMSAI, ');

      If blnInfMat And (intInfFed = 1) Then
        Result := Result + IfThen(Not(IsAgendado),'  ITE_IMPFED = IF(:EMPLOG = ITE_CODEMP, :IMPFED, ITE_IMPFED), ')
      Else
        Result := Result + IfThen(Not(IsAgendado),'  ITE_IMPFED = :IMPFED, ');

      If blnInfMat And (intInfOpe = 1) Then
        Result := Result + IfThen(Not(IsAgendado),'  ITE_DESOPE = IF(:EMPLOG = ITE_CODEMP, :DESOPE, ITE_DESOPE), ')
      Else
        Result := Result + IfThen(Not(IsAgendado),'  ITE_DESOPE = :DESOPE, ');

        Result := Result + IfThen(Not(IsAgendado), '  ITE_OUTVAL = :OUTVAL, ' +
                                                   '  ITE_ABAMLT = :ABAMLT, ',
                                                   '  ITE_ABAMLT = :ABAMLT, ');

      If not blnIteTbp Then
      Begin
        if Not(IsAgendado) then
        Begin
          Result := Result + '  ITE_DESMAX = :DESMAX, ' +
                             '  ITE_DESMGE = :DESMGE, ' +
                             '  ITE_DESMSU = :DESMSU, ';

          Result := Result + '  ITE_DESMVM = :DESMVM, ' +
                             '  ITE_DESMGM = :DESMGM, ' +
                             '  ITE_DESMSM = :DESMSM, ';
        End;
      End;

      if Not(IsAgendado) then
      begin
        Result := Result + '  ITE_MARBR1 = :MARBR1, ' +
                           '  ITE_MARBR2 = :MARBR2, ' +
                           '  ITE_MARBR3 = :MARBR3, ' +
                           '  ITE_MARBR4 = :MARBR4, ' +
                           '  ITE_MARBR5 = :MARBR5, ' +
                           '  ITE_MARBR6 = :MARBR6, ' +
                           '  ITE_MARBR7 = :MARBR7, ' +
                           '  ITE_COMTB1 = :COMTB1, ' +
                           '  ITE_COMTB2 = :COMTB2, ' +
                           '  ITE_COMTB3 = :COMTB3, ' +
                           '  ITE_COMTB4 = :COMTB4, ' +
                           '  ITE_COMTB5 = :COMTB5, ' +
                           '  ITE_COMTB6 = :COMTB6, ' +
                           '  ITE_COMTB7 = :COMTB7, ' +
                           '  ITE_PREVE1 = :PREVE1, ' +
                           '  ITE_PREVE2 = :PREVE2, ' +
                           '  ITE_PREVE3 = :PREVE3, ' +
                           '  ITE_PREVE4 = :PREVE4, ' +
                           '  ITE_PREVE5 = :PREVE5, ' +
                           '  ITE_PREVE6 = :PREVE6, ' +
                           '  ITE_PREVE7 = :PREVE7, ' +
                           '  ITE_MARMIN = :MARMIN, ' +
                           '  ITE_MARMMV = :MARMMV, ';

        If fCfgSis('MARIDE', VarBoolean) Then
        Begin
          Result := Result + '  ITE_MARID1 = :MARID1, ' +
                             '  ITE_MARID2 = :MARID2, ' +
                             '  ITE_MARID3 = :MARID3, ' +
                             '  ITE_MARID4 = :MARID4, ' +
                             '  ITE_MARID5 = :MARID5, ' +
                             '  ITE_MARID6 = :MARID6, ' +
                             '  ITE_MARID7 = :MARID7, ';
        End;
      end;
      Result := Result + '  ITE_MARMSG = :MARMSG, ' +
                         '  ITE_MARMGE = :MARMGE, ' +
                         '  ITE_MARMMS = :MARMMS, ' +
                         '  ITE_MARMMG = :MARMMG, ' ;

      Result := Result + '  ITE_QTPPRO = :QTPPRO, ';
      If (fCfgSis('OPCCOM') <> 'PPT') Then
      begin
        Result := Result + '  ITE_COMVAR = :COMVAR, ' +
                           '  ITE_COMATA = :COMATA, ' +
                           '  ITE_COMDIS = :COMDIS, ';
      end;
      Result := Result + '  ITE_COMDIG = :COMDIG, ' +
                         '  ITE_COMPRO = :COMPRO, ';

      If fCampoVisivel('PESOBR') And (cdsParametrosMARCADO.AsBoolean) Then
        Result := Result + '  ITE_PESOBR = :PESOBR, ';

      If blnValFor Then
        Result := Result + '  ITE_DTAVAL = :DTAVAL, ';

      if fCfgSis('NFEPEP', varBoolean) then
        Result := Result + '  ITE_OBRNFE = :OBRNFE, ';

      Result := Result + '  ITE_MINTB1 = :MINTB1, ' +
                         '  ITE_MINTB2 = :MINTB2, ' +
                         '  ITE_MINTB3 = :MINTB3, ' +
                         '  ITE_MINTB4 = :MINTB4, ' +
                         '  ITE_MINTB5 = :MINTB5, ' +
                         '  ITE_MINTB6 = :MINTB6, ' +
                         '  ITE_MINTB7 = :MINTB7, ' +
                         '  ITE_CPESOB = :CPESOB  ';

    End;

    if blnUtilizaChecklistGarantia then
    Result := Result + ', ITE_CODATC = :CODATC ';

    Result := Result + ', ITE_SOBENC = :SOBENC ';

    If fCfgSis('UTIABA', varBoolean) Then
      Result := Result + ', ITE_MLTRCA = :MLTRCA ';

    If fCfgSis('LOCRET', varBoolean) Then
      Result := Result + ' , ITE_TIPRET = :TIPRET ';

    Result := Result + 'WHERE ITE_CODITE = :CODITE AND ';

    If blnResFor Then
      Result := Result + '  LOCATE(ITE_CODEMP, :CODEMP) = 0 '
    Else
      Result := Result + '  LOCATE(ITE_CODEMP, :CODEMP) > 0 ';
end;

procedure TfrmAltPrecoIndividual.pAdicionaColuna(strTitulo: String; intIndice: Integer; blnVisible: Boolean = True);
  Var
    cxItem: TcxCustomGridTableItem;
    intMax: Integer;
Begin
  cxItem := FrameAlteraPrecoIndividual.cxvTiposAlt.FindItemByName(arrCampos[intIndice].FieldName);

  If Not Assigned(cxItem) Then
  Begin
    cxItem         := FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.CreateItemByField(qryGen.FieldByName(arrCampos[intIndice].FieldName));
    cxItem.Name    := arrCampos[intIndice].FieldName;
    cxItem.Caption := strTitulo;

    If qryGen.FieldByName(arrCampos[intIndice].FieldName).DataType In [ftFloat, ftInteger, ftWord] Then
      TcxGridDBBandedColumn(cxItem).HeaderAlignmentHorz := taRightJustify;
    If chkNOReordenaGrid.Checked Then
      TcxGridDBBandedColumn(cxItem).OnHeaderClick := OnHeaderClick;

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
      cxItem.Caption := fCampoRetDescriParamtro('OUTVAL')

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_OUTVAL_NOV') Then
      cxItem.Caption := 'Novo ' + fCampoRetDescriParamtro('OUTVAL')

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_VALFRE') Then
      cxItem.Caption := fCampoRetDescriParamtro('VALFRE')

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_VALFRE_NOV') Then
      cxItem.Caption := 'Novo ' + fCampoRetDescriParamtro('VALFRE')

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_DESADB') Then
    Begin
      cxItem.Caption := IIF(Not fEmptyStr(fCampoRetDescriParamtro('DESABD')), fCampoRetDescriParamtro('DESABD'), fCfgSis('DESADI'));
      TcxGridDBBandedColumn(cxItem).Width := 163;
    End

    Else If SameText(arrCampos[intIndice].FieldName, 'ITE_DESADB_NOV') Then
    Begin
      cxItem.Caption := IIF(Not fEmptyStr(fCampoRetDescriParamtro('DESABD')), fCampoRetDescriParamtro('DESABD'), fCfgSis('DESADI'));
      TcxGridDBBandedColumn(cxItem).Width := 163 + 40;
    End;

    If Pos('ITE_APLICA', arrCampos[intIndice].FieldName) > 0 Then
      TcxGridDBBandedColumn(cxItem).Width := 352

    Else If Pos('ITE_LOCFIS', arrCampos[intIndice].FieldName) > 0 Then
      TcxGridDBBandedColumn(cxItem).Width := 130

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

    If TcxGridDBBandedColumn(cxItem).Width = 64 Then
      TcxGridDBBandedColumn(cxItem).Width := 65;

    If TcxGridDBBandedColumn(cxItem).Width < 60 Then
      TcxGridDBBandedColumn(cxItem).Width := 60;
  End;

  cxItem.Visible := blnVisible;

  If blnVisible Then
  Begin
    If Not FrameAlteraPrecoIndividual.GerenciaColunaGrid.Campo[cxItem.Name].blnFalha Then
      TcxGridDBBandedColumn(cxItem).Width := FrameAlteraPrecoIndividual.GerenciaColunaGrid.Campo[cxItem.Name].width;

    FrameAlteraPrecoIndividual.cxvTiposAlt.Bands[TcxGridDBBandedColumn(cxItem).Position.BandIndex].Width :=
      FrameAlteraPrecoIndividual.cxvTiposAlt.Bands[TcxGridDBBandedColumn(cxItem).Position.BandIndex].Width +  TcxGridDBBandedColumn(cxItem).Width;
  End;

  If SameText('ITE_DESITE', arrCampos[intIndice].FieldName) And ((Not cbxOrdem.Enabled) Or (cbxOrdem.ItemIndex = 0)) Then
  begin
    TcxGridDBColumn(cxItem).SortOrder := soAscending;
    ColumnDesIte := cxItem;
  End;
End;

function TfrmAltPrecoIndividual.fMontaGridAux(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intContador : Integer;
    strNomCam,
    strNomCpy   : String;
    blnResult: boolean;
begin
  blnResult := False;
  pgbProgresso.Properties.Max := 0;
  pgbProgresso.Position       := 0;
  Application.ProcessMessages;

  intCustoVenda := rdgTipAlt.ItemIndex;

  If Not blnRestaurandoCopiaSeg Then
    pCriaTemporaria;

  pCriarCopiaSeguranca(strTabela);

  For intContador := 0 To Length(colColunas) -1 Do
  Begin
    colColunas[intContador].blnHabili := False;
  End;

  Result := True;

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
      strNomCpy := Copy(strNomCam,1, 5);

      If Not( fEmptyStr(strNomCam) ) Then
      Begin

        If (SameText( strNomCam, 'EMBPRV')) then
          strNomCam := 'BARPRV';
        If (SameText( strNomCam, 'EMBPRC')) then
          strNomCam := 'BARPRC';
        If blnIteTbp Then
        Begin
          If (SameText( strNomCpy, 'DESMA')) And (arrCampos[intContador].FieldName <> 'MAR_DESMAR') then
          Begin
            strNomCam := 'DESMAX';
          End
          Else
          If SameText( strNomCpy, 'DESMG') Then
          Begin
            strNomCam := 'DESMGE';
          End
          Else
          If SameText( strNomCpy, 'DESMS') Then
          Begin
            strNomCam := 'DESMSU';
          End
          Else
          If SameText( strNomCpy, 'DESVM') Then
          Begin
            strNomCam := 'DESMVM';
          End
          Else
          If SameText( strNomCpy, 'DESSM') Then
          Begin
            strNomCam := 'DESMSM';
          End
          Else
          If SameText( strNomCpy, 'DESGM') Then
          Begin
            strNomCam := 'DESMGM';
          End;
        End;

        If blnIteTbp and SameText( Copy(strNomCam,1, 5), 'DESVM') Then
        Begin
          strNomCam := 'DESVMM';
        End;

        If blnIteTbp and SameText( Copy(strNomCam,1, 5), 'DESSM') Then
        Begin
          strNomCam := 'DESSMM';
        End;

        If blnIteTbp and SameText( Copy(strNomCam,1, 5), 'DESGM') Then
        Begin
          strNomCam := 'DESGMM';
        End;

        if SameText( Copy(strNomCam,1, 5), 'VENIN') then
        Begin
          strNomCam := 'VENINT';
        End
        Else if SameText( Copy(strNomCam,1, 5), 'VENEX') then
        Begin
          strNomCam := 'VENEXT';
        End;

        If (Not fCampoMarcado(strNomCam)) And (Not arrCampos[intContador].blnCampoDescricao) Then
        Begin
          arrCampos[intContador].Visible := False
        End Else
        Begin
          If (intContador < 14) Or ((intContador >= 14) And
                                    (RightStr(arrCampos[intContador].FieldName, 4) = '_NOV')) Then
            arrCampos[intContador].Visible := True;
        End;


        If (arrCampos[intContador].blnTemDescricao) Then
        Begin
          arrCampos[intContador + 1].Visible := (arrCampos[intContador].Visible);
          arrCampos[intContador + 1].ReadOnly := True;
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

  pMontaGridAlterados(True, blnResult);
  result := result and blnResult;

  FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource := dtsGen;

  FrameAlteraPrecoIndividual.cxgTiposAlt.Enabled := True;
  pSetFocus(FrameAlteraPrecoIndividual.cxgTiposAlt);
end;

Procedure TfrmAltPrecoIndividual.pMontaGridAlterados(blnAltera: Boolean);
  Var
    blnResult: Boolean;
begin
  pMontaGridAlterados(blnAltera, blnResult);
End;

procedure TfrmAltPrecoIndividual.pMontaGridAlterados(blnAltera: Boolean;
  out blnResult: Boolean);
  var
    frmGravando: TfrmGravando;
Begin
  FAltera := blnAltera;

  blnResult := TfrmGravando.fExecuta(fMontaGridAlterados, frmGravando, 'Montando dados para alteração, aguarde...');
end;

Function TfrmAltPrecoIndividual.fMontaGridAlterados(cxProgresso: TcxProgressBar): Boolean;
  Var
    intContador : Integer;
Begin
  Try
    qryGen.DisableControls;

    If qryGen.State = dsInactive Then
      qryGen.Open;

//    FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource := Nil;

    If fCampoMarcado('APLICA') Then
      cxeMemo.Properties.VisibleLineCount := 5
    Else
      cxeMemo.Properties.VisibleLineCount := 1;

    FrameAlteraPrecoIndividual.cxvTiposAlt.OptionsView.CellAutoHeight :=  fCampoMarcado('APLICA');

    cxProgresso.Properties.Max := Length(arrCampos);


    FrameAlteraPrecoIndividual.cxvTiposAlt.BeginUpdate;
    Try
      FrameAlteraPrecoIndividual.cxvTiposAlt.ClearItems;
      FrameAlteraPrecoIndividual.cxvTiposAlt.Bands[0].Width := 0;
      FrameAlteraPrecoIndividual.cxvTiposAlt.Bands[1].Width := 0;

      For intContador := Low(arrCampos) To High(arrCampos) Do
      Begin
        If arrCampos[intContador].Visible Then
          pAdicionaColuna(IIF(FAltera, Trim(AnsiReplaceStr(arrCampos[intContador].Title, 'Novo', '')), arrCampos[intContador].Title),
                          intContador);

        cxProgresso.Position := cxProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    Finally
      FrameAlteraPrecoIndividual.cxvTiposAlt.EndUpdate;
    End;    

    Result := True;
  Finally
//    FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource := dtsGen;

    FrameAlteraPrecoIndividual.cxvTiposAlt.OptionsData.Editing := FAltera;


    qryGen.EnableControls;
  End;
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
    btnDesmarcar.Click;
  End
  Else If Key = VK_F6 Then
  Begin
    If btnDesmarcar.Visible Then
      btnDesmarcar.Click
    Else
      btnEstLoj.Click
  End
  Else If (Key = VK_F5) And (pnlBusca.Visible) Then
  Begin
    btnIniBus.Click;
  End
  Else If (Key = VK_F9) And (pnlBusca.Visible) Then
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


procedure TfrmAltPrecoIndividual.pMarcaDesmarca(blnMarcar: Boolean);
begin
  cdsParametros.First;
  While not cdsParametros.Eof Do
  Begin
    cdsParametros.Edit;
    cdsParametrosMarcado.AsBoolean := blnMarcar;
    cdsParametros.Post;
    cdsParametros.Next;
  End;
  cdsParametros.First;
end;

procedure TfrmAltPrecoIndividual.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If Not btnMarcar.Visible Then
    Exit;

  cdsParametros.DisableControls;
  pMarcaDesmarca(True);
  cdsParametros.EnableControls;

  If (fUsaRotinaWMS) And  (fCfgSis('CTLEST') = '2') Then
  Begin
    pCampoMarcaDesmarca('LOCFIS', False);
    pCampoMarcaDesmarca('LOCSUP', False);
  End;

end;

procedure TfrmAltPrecoIndividual.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  If Not btnDesmarcar.Visible Then
    Exit;

  cdsParametros.DisableControls;
  pMarcaDesmarca(False);
  cdsParametros.EnableControls;
end;

procedure TfrmAltPrecoIndividual.pExportaParaExcel;
  Var
    strLista: TStringList;
    dlgOpen    : TOpenDialog;
    frmGerandoExcel: TfrmGravando;
    Result: Boolean;
Begin
  Try
    Try
      Result := False;
      strLista := TStringList.Create;
      strLista.Sorted := True;

      pSalvaPosicaoUsuario(strLista);

      Application.ProcessMessages;

      qryGen.DisableControls;

      strFileExcel := '';
      dlgOpen     := TOpenDialog.Create(Self);
      dlgOpen.Filter := 'Arquivos do Excel(csv))|*.csv';
      If dlgOpen.Execute Then
      Begin
        pCriarFormularios(TfrmGravando, frmGerandoExcel);
        Try

          With frmGerandoExcel Do
          Begin
            strFileExcel := dlgOpen.FileName;
            fExecutarAcao := fGeraArquivoAux;
            lblGravando.Caption := 'Aguarde, Gerando aquivo...';
            ShowModal;
            Result := blnConfirma;
          End;
        Finally
          FreeAndNil(frmGerandoExcel);
        End;
      End;


      If Result Then
        pMensagemOk('Arquivo gerado com sucesso!');

      qryGen.First;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.pExportaParaExcel]');
      End;
    End;
  Finally
      qryGen.EnableControls;
      FreeAndNil(strLista);
  End;

End;

procedure TfrmAltPrecoIndividual.pMostraEstoqueLojas;
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
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
    If blnTABPRD Then
    begin
      fltPreComLiq := fCalculaPrecoCompraLiq((fQryGen('PRECOM' + IntToStr(intTab)).AsFloat  / fQryGen('CNVCUS' + IntToStr(intTab)).AsFloat),
                                             fQryGen('DESF01' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF02' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF03' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF04' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF05' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF06' + IntToStr(intTab)).AsFloat,
                                             intDecUni,
                                             (fQryGen('PREDOL' + IntToStr(intTab)).AsString = 'S'));

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fQryGen('CODABF' + IntToStr(intTab)).AsString, strEstEmp]);
      fltIcmsST := fGetIcmsSTParteVenda(fQryGen('CODABF' + IntToStr(intTab)).AsString,
                                        '_SAI_CCO', strCodSit, strEstEmp,
                                        fltPreComLiq, fQryGen('IPIENT' + IntToStr(intTab)).AsFloat,
                                        fQryGen('ICMSAI' + IntToStr(intTab)).AsFloat,
                                        strEstEmp, blnCalcSt);

      fQryGen('MARBR' + IntToStr(intTab) + '_NOV').AsFloat :=
        fCalculaPrecoVenda(2,
                           ((fQryGen('PRECUS' + IntToStr(intTab)).AsFloat + fQryGen('OUTVAL' + IntToStr(intTab)).AsFloat ) / fQryGen('CNVCUS' + IntToStr(intTab)).AsFloat),
                           fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat,
                           fQryGen('MARBR' + IntToStr(intTab) + '_NOV').AsFloat,
                           fQryGen('ICMSAI' + IntToStr(intTab)).AsFloat,
                           fQryGen('IMPFED' + IntToStr(intTab)).AsFloat,
                           fQryGen('DESOPE' + IntToStr(intTab)).AsFloat,
                           fQryGen('COMTB' + IntToStr(intTab) + '_NOV').AsFloat,
                           '',
                           '',
                           -1,
                           fltIcmsST,
                           blnCalcSt);
    End
    Else
    Begin



      fltPreComLiq := fCalculaPrecoCompraLiq(fQryGen('PRECOM_NOV').AsFloat,
                                             fQryGen('DESF01_NOV').AsFloat,
                                             fQryGen('DESF02_NOV').AsFloat,
                                             fQryGen('DESF03_NOV').AsFloat,
                                             fQryGen('DESF04_NOV').AsFloat,
                                             fQryGen('DESF05_NOV').AsFloat,
                                             fQryGen('DESF06_NOV').AsFloat,
                                             intDecUni,
                                             (fQryGen('PREDOL').AsString = 'S'));

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fQryGen('CODABF_NOV').AsString, strEstEmp]);
      fltIcmsST := fGetIcmsSTParteVenda(fQryGen('CODABF_NOV').AsString,
                                        '_SAI_CCO', strCodSit, strEstEmp,
                                        fltPreComLiq, fQryGen('IPIENT_NOV').AsFloat,
                                      fQryGen('ICMSAI_NOV').AsFloat,
                                      strEstEmp, blnCalcSt);

    fQryGen('PRELIQ_NOV').AsFloat := fltPreComLiq;

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

    End;
    arrRecTabPrecos[intTab].blnMarBru := arrRecTabPrecos[intTab].fltMarBru <> fQryGen('MARBR' + IntToStr(intTab) + '_NOV').AsFloat;

    Result := fValidaMargem(intTab);
    If Not Result Then
      Exit;

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
    arrRecTabPrecos[intTab].fltPreVen := fQryGen('PREVE' + IntToStr(intTab)).AsFloat;
    If blnTABPRD Then
    Begin
      fltPreComLiq := fCalculaPrecoCompraLiq((fQryGen('PRECOM' + IntToStr(intTab)).AsFloat / fQryGen('CNVCUS' + IntToStr(intTab)).AsFloat),
                                             fQryGen('DESF01' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF02' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF03' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF04' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF05' + IntToStr(intTab)).AsFloat,
                                             fQryGen('DESF06' + IntToStr(intTab)).AsFloat,
                                             intDecUni,
                                             (fQryGen('PREDOL' + IntToStr(intTab)).AsString = 'S'));

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fQryGen('CODABF' + IntToStr(intTab)).AsString, strEstEmp]);
      fltIcmsST := fGetIcmsSTParteVenda(fQryGen('CODABF' + IntToStr(intTab)).AsString,
                                        '_SAI_CCO', strCodSit, strEstEmp,
                                        fltPreComLiq, fQryGen('IPIENT' + IntToStr(intTab)).AsFloat,
                                        fQryGen('ICMSAI' + IntToStr(intTab)).AsFloat,
                                        strEstEmp, blnCalcSt);
      fQryGen('PRELIQ_NOV').AsFloat := fltPreComLiq;

      fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat :=
        fCalculaPrecoVenda(1, Roundto(((fQryGen('PRECUS' + IntToStr(intTab)).AsFloat + fQryGen('OUTVAL' + IntToStr(intTab)).AsFloat) / fQryGen('CNVCUS' + IntToStr(intTab)).AsFloat),-6),
                              fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat,
                              fQryGen('MARBR' + IntToStr(intTab) + '_NOV').AsFloat,
                              fQryGen('ICMSAI' + IntToStr(intTab)).AsFloat,
                              fQryGen('IMPFED' + IntToStr(intTab)).AsFloat,
                              fQryGen('DESOPE' + IntToStr(intTab)).AsFloat,
                              fQryGen('COMTB' + IntToStr(intTab) + '_NOV').AsFloat,
                              '',
                              '',
                              -1,
                              fltIcmsST,
                              blnCalcSt);
    End
    Else
    Begin

      fltPreComLiq := fCalculaPrecoCompraLiq(fQryGen('PRECOM_NOV').AsFloat,
                                             fQryGen('DESF01_NOV').AsFloat,
                                             fQryGen('DESF02_NOV').AsFloat,
                                             fQryGen('DESF03_NOV').AsFloat,
                                             fQryGen('DESF04_NOV').AsFloat,
                                             fQryGen('DESF05_NOV').AsFloat,
                                             fQryGen('DESF06_NOV').AsFloat,
                                             intDecUni,
                                             (fQryGen('PREDOL').AsString = 'S'));

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fQryGen('CODABF_NOV').AsString, strEstEmp]);
      fltIcmsST := fGetIcmsSTParteVenda(fQryGen('CODABF_NOV').AsString,
                                        '_SAI_CCO', strCodSit, strEstEmp,
                                        fltPreComLiq, fQryGen('IPIENT_NOV').AsFloat,
                                        fQryGen('ICMSAI_NOV').AsFloat,
                                        strEstEmp, blnCalcSt);
      fQryGen('PRELIQ_NOV').AsFloat := fltPreComLiq;

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
    End;

    If chkArrMai.Checked Then
    Begin
      fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat := fArredondaMais(fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat, True);
    End;

    arrRecTabPrecos[intTab].blnPreVen := arrRecTabPrecos[intTab].fltPreVen <> fQryGen('PREVE' + IntToStr(intTab) + '_NOV').AsFloat;

    Result := fValidaMargem(intTab);
    If Not Result Then
      Exit;

  Except
    Result := False;
  End;
end;


function TfrmAltPrecoIndividual.fRetCampoDesc(strField: string): TCampo;
var i : integer;
begin
  For i := 0 To High(arrCampos) do
  Begin
    If arrCampos[i].FieldName = strField Then
    Begin
      If arrCampos[i].blnTemDescricao Then
        exit(arrCampos[i + 1])
      Else
      Begin
        Result.Title := '';
        Result.FieldName := '';
        Result.ReadOnly := True;
        Result.Visible := False;
        Result.Properties:= Nil;
        Result.blnTemDescricao := False;
      end;
    End;
  End
end;

function TfrmAltPrecoIndividual.fRetCotacaoAtualDolarCompra(
  var strDtaCotDol: String): Double;
  Var
    strSQL : String;
    qryCotDol : TUniQuery;
begin
  Try
    qryCotDol := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + '  SELECT                              ';
    strSQL := strSQL + '         MOE_DTAMOE,                  ';
    strSQL := strSQL + '         MOE_DOLCOM                   ';
    strSQL := strSQL + '    FROM CADMOE                       ';
    strSQL := strSQL + '   WHERE MOE_DTAMOE <= CURRENT_DATE() ';
    strSQL := strSQL + '   ORDER BY MOE_DTAMOE DESC           ';
    strSQL := strSQL + '   LIMIT 1                            ';

    With qryCotDol Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    End;

    If (qryCotDol.RecordCount = 1) Then
    Begin
      strDtaCotDol := qryCotDol.FieldbyName('MOE_DTAMOE').AsString;
      Result       := qryCotDol.FieldbyName('MOE_DOLCOM').AsFloat;
    End
    Else
    Begin
      strDtaCotDol := '';
      Result       := 0;
    End;
  Finally
    FreeAndNil(qryCotDol);
  End;
end;

function TfrmAltPrecoIndividual.fRecalculaPreCusto: Boolean;
  Var
    cpcParams: TParCalculaPrecoCusto;
    intTab: Integer;
    blnUtilizarConversorDeMoedas: boolean;
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
        IF blnTABPRD Then
        Begin
        End
        Else
        begin
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

            if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
            begin
              curTCIFCu := FieldByName('ITE_TCIFCU_NOV').AsFloat;
              curTSCust := FieldByName('ITE_TSCUST_NOV').AsFloat;
              curDePiCo := FieldByName('ITE_DEPICO_NOV').AsFloat;
              curDeICMS := FieldByName('ITE_DEICMS_NOV').AsFloat;
              curFatReg := FieldByName('ITE_FATREG_NOV').AsFloat;
            end
            else
            begin
              curTCIFCu := 0;
              curTSCust := 0;
              curDePiCo := 0;
              curDeICMS := 0;
              curFatReg := 0;
            end;
          End;

          blnUtilizarConversorDeMoedas := (FieldByName('ITE_PREDOL').AsString = 'S');



          FieldByName('ITE_PRECUS_NOV').AsFloat := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoedas);

          FieldByName('ITE_PRECUS_VAR').AsFloat := ABS(((FieldByName('ITE_PRECUS_NOV').AsFloat /  FieldByName('ITE_PRECUS').AsFloat) -1) * 100.00);

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
        End;

        {************************************************************************}
        {* RECALCULA O PRECO DE VENDA OU A MARGEM APOS ALTERAR O PRECO DE CUSTO *}
        {*********************************************************************JC*}
        For intTab := 1 To Length(arrRecTabPrecos) Do
        Begin
          If ( intCustoVenda = 0 ) Then
          Begin
            Result := fCalcularPrecoVenda(intTab);
            If Not Result Then
              Exit;
          End
          Else If ( intCustoVenda = 1 ) Then
          Begin
            Result := fCalcularMargemLucro(intTab);
            If Not Result Then
              Exit;
          End;
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

    If objFatPre.fTabelaAtiva(intIndice) Then
      fQryGen('PREVE' + IntToStr(intIndice) + '_NOV').AsFloat :=
         objFatPre.fCalculaPrecoVendaFator(fQryGen('PREVE1_NOV').AsFloat, intIndice);

    If chkArrMai.Checked Then
    Begin
      fQryGen('PREVE' + IntToStr(intIndice) + '_NOV').AsFloat :=
        fArredondaMais(fQryGen('PREVE' + IntToStr(intIndice) + '_NOV').AsFloat, True);
    End;

    fCalcularMargemLucro(intIndice);

    arrRecTabPrecos[intIndice].blnPreVen :=
      fQryGen('PREVE' + IntToStr(intIndice)).AsFloat <> fQryGen('PREVE' + IntToStr(intIndice) + '_NOV').AsFloat;
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

      strNomCam := TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName;

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
          Begin
            Result := fCalcularPrecoVenda(intTab);
            If Not Result Then
              Exit;
          End
          Else
          Begin
            Result := fCalcularMargemLucro(intTab);
            If Not Result Then
              Exit;
          End;
        End;

        pRecalculaPrecosFator;
      End;

    End;

  Except
    Result := False;
  End;

end;

procedure TfrmAltPrecoIndividual.edtAtivoComprasExit(Sender: TObject);
begin
  inherited;
  cdsParametros.Locate('CAMPO','CODITE', []);
end;

procedure TfrmAltPrecoIndividual.edtAtivoComprasKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Not CharInSet(UpperCase(Key)[1],['S', 'N', 'T'])) Then
    Key := #0;
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

procedure TfrmAltPrecoIndividual.FormShow(Sender: TObject);
begin
  inherited;  

  pSetFocus(mskLinGru);

  chkPenRec.Visible := fCfgSis('CLPVDI', varBoolean);
  //chkPenRec.Checked := chkPenRec.Visible;   REQ ORIGINAL 81640 PEDE PARA TRAZER DESMARCADO, TRAZER MARCADO IMPACTA NA RESTAURAÇÃO DA CÓPIA DE SEG.


  If pnlCadMon.Visible Then
  Begin
    If chkPenRec.Visible Then
      pnlCabecalho.Height := 265
    Else
      pnlCabecalho.Height := 241;
  End;

  btnSair.Left := (pnlBotoes.Width - btnSair.Width - 3);

  If blnRestaurandoCopiaSeg Then
  Begin
    //pnlFiltros.Visible := False;
    If fEmptyStr(edtDocumento.Text) Then
       pAtualizaTemporaria(False, '')
    Else
    Begin
      If (cbxOrdem.ItemIndex = 0) Then
         pAtualizaTemporaria(False, 'ITE_DESITE')
      Else
         pAtualizaTemporaria(False, 'ITE_ORDINC');
    End;
    pConfirma(True);
  End;

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
    ParamByName('CODITE').AsString := FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource.DataSet.FieldByName('ITE_CODITE').AsString;
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

function TfrmAltPrecoIndividual.fValidarEXPSIT: boolean;
Begin
  if (fCfgSis('MOEXSI') = 0) Then
    Exit(False);
  Result := (qryGen.FindField('ITE_EXPSIT_NOV') <> Nil) And
    (qryGen.FieldByName('ITE_EXPSIT_NOV').AsString = 'S') And
    (fEmptyStr(qryGen.FieldByName('ITE_NOMECO_NOV').AsString) Or
    fEmptyStr(qryGen.FieldByName('ITE_APLECO_NOV').AsString));
End;

function TfrmAltPrecoIndividual.fValidaPrecoCustoReal(qryGen: TUniQuery): boolean;
var
  objLiberacao : ILiberacao;
  objLinha  : TLinhaMsgLibera;
  objTabela : TRegistroMsgLiberaTabela;
  I, X : Integer;
  lstProdutos : TStringList;
  blnResultado : boolean;
  strConfig: String;
begin
  strConfig := fCfgSis('TABPRC');

  lstProdutos := TStringList.Create;

  With qryGen Do
  Begin
    First;

    While not Eof do
    Begin
      If ((strConfig[1] = 'S') AND (FieldByName('ITE_PREVE1_NOV').AsFloat > 0) And (FieldByName('ITE_PREVE1_NOV').AsFloat <> FieldByName('ITE_PREVE1').AsFloat) And (FieldByName('ITE_PREVE1_NOV').AsFloat < FieldByName('ITE_CUSREA_NOV').AsFloat)) Or
         ((strConfig[2] = 'S') AND (FieldByName('ITE_PREVE2_NOV').AsFloat > 0) And (FieldByName('ITE_PREVE2_NOV').AsFloat <> FieldByName('ITE_PREVE2').AsFloat) And (FieldByName('ITE_PREVE2_NOV').AsFloat < FieldByName('ITE_CUSREA_NOV').AsFloat)) Or
         ((strConfig[3] = 'S') AND (FieldByName('ITE_PREVE3_NOV').AsFloat > 0) And (FieldByName('ITE_PREVE3_NOV').AsFloat <> FieldByName('ITE_PREVE3').AsFloat) And (FieldByName('ITE_PREVE3_NOV').AsFloat < FieldByName('ITE_CUSREA_NOV').AsFloat)) Or
         ((strConfig[4] = 'S') AND (FieldByName('ITE_PREVE4_NOV').AsFloat > 0) And (FieldByName('ITE_PREVE4_NOV').AsFloat <> FieldByName('ITE_PREVE4').AsFloat) And (FieldByName('ITE_PREVE4_NOV').AsFloat < FieldByName('ITE_CUSREA_NOV').AsFloat)) Or
         ((strConfig[5] = 'S') AND (FieldByName('ITE_PREVE5_NOV').AsFloat > 0) And (FieldByName('ITE_PREVE5_NOV').AsFloat <> FieldByName('ITE_PREVE5').AsFloat) And (FieldByName('ITE_PREVE5_NOV').AsFloat < FieldByName('ITE_CUSREA_NOV').AsFloat)) Or
         ((strConfig[6] = 'S') AND (FieldByName('ITE_PREVE6_NOV').AsFloat > 0) And (FieldByName('ITE_PREVE6_NOV').AsFloat <> FieldByName('ITE_PREVE6').AsFloat) And (FieldByName('ITE_PREVE6_NOV').AsFloat < FieldByName('ITE_CUSREA_NOV').AsFloat)) Or
         ((strConfig[7] = 'S') AND (FieldByName('ITE_PREVE7_NOV').AsFloat > 0) And (FieldByName('ITE_PREVE7_NOV').AsFloat <> FieldByName('ITE_PREVE7').AsFloat) And (FieldByName('ITE_PREVE7_NOV').AsFloat < FieldByName('ITE_CUSREA_NOV').AsFloat)) Then

         lstProdutos.Add(FieldByName('ITE_CODITE').AsString);

      Next;
    End;

    If lstProdutos.Count = 0 Then
      blnResultado := True
    Else
    Begin
      objLiberacao := TLiberacaoFactory.fGetLiberacao;
      objLiberacao.Clear;

      With objLiberacao.objMsgLibera do
      Begin
        pAddTexto('LIBERAÇÃO DE PREÇO DE VENDA ABAIXO DO CUSTO REAL');
        pAddQuebra();
        pAddTexto('Os produtos abaixo ficarão com o preço de venda menor que o preço de custo real.');
        pAddTexto('Esta mensagem tem por objetivo evitar erros operacionais.');
        pAddTexto('Será permitido liberação com senha para finalizar o procedimento mesmo assim, para casos onde realmente é');
        pAddTexto('o objetivo manter desta forma.');
      End;

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      With objLinha Do
      Begin
        enuTipoLinha := tlCabecalho;
        pAddColuna(''  , 'CÓD.'          , 7  , alCentro   , teAutcom);
        pAddColuna(''  , 'DESCRIÇÃO'     , 55 , alEsquerda , teAutcom);
        pAddColuna(''  , 'UN'            , 4  , alCentro   , teAutcom);
        pAddColuna(''  , 'PR.CUSTO '     , 15 , alDireita  , teAutcom);
        pAddColuna(''  , 'PR.CUSTO REAL ', 15 , alDireita  , teAutcom);
      For I := 1 to Length(strConfig) Do
        Begin
          If strConfig[I] = 'S' Then
            pAddColuna(''  , 'PR. VENDA '+ IntToStr(I) , 15 , alDireita  , teAutcom);
        End;
      End;

      objTabela.lstLinhas.Add(objLinha);

      For I := 0 to lstProdutos.Count-1 Do
      Begin
        Locate('ITE_CODITE', lstProdutos[I], []);

        objLinha  := TLinhaMsgLibera.Create;
        With objLinha do
        Begin
          enuTipoLinha := tlValor;
          pAddColuna('CÓD.'          , FieldByName('ITE_CODITE').AsString , 7  , alCentro);
          pAddColuna('DESCRIÇÃO'     , FieldByName('ITE_DESITE').AsString , 55 , alEsquerda);
          pAddColuna('UN'            , FieldByName('ITE_UNICOM').AsString , 4  , alCentro  );
          pAddColuna('PR.CUSTO '     , FormatFloat('#,##0.00', FieldByName('ITE_PRECUS_NOV').AsFloat) , 15 , alDireita );
          pAddColuna('PR.CUSTO REAL ', FormatFloat('#,##0.00', FieldByName('ITE_CUSREA_NOV').AsFloat) , 15 , alDireita );
        For X := 1 to Length(strConfig) Do
          Begin
            If strConfig[X] = 'S' Then
               pAddColuna('PR. VENDA '+ IntToStr(X) , FormatFloat('#,##0.00', FieldByName('ITE_PREVE'+IntToStr(X)+'_NOV').AsFloat) , 15 , alDireita );
          End;
        End;
        objTabela.lstLinhas.Add(objLinha);
      End;

      With objLiberacao Do
      Begin
        objMsgLibera.lstRegistros.Add(objTabela);

        strDirAce  := 'VMENCU';
        strMsgSen  := 'Liberação de preço de venda abaixo do custo real';
        strCodOpe  := strLoginUsuarioLogado;
        intLargura := 1900;
      End;

      blnResultado := objLiberacao.fLibera;
    End;
  End;

  Result := blnResultado;
end;

procedure TfrmAltPrecoIndividual.pAlteraTitDesadb;
Var
  cxItem: TcxCustomGridTableItem;
begin
  cxItem := FrameAlteraPrecoIndividual.cxvTiposAlt.FindItemByName('ITE_DESADB_NOV');

  If (Pos(cxItem.Caption, 'Novo') <= 0) Then
    cxItem.Caption := 'Novo ' + cxItem.Caption;
end;

procedure TfrmAltPrecoIndividual.pConfirma(blnRestaurando : Boolean = False);
  Var
    strMensagem: String;
    intRetorno : Integer;
    fltValCotDol: Double;
    strDtaCotDol: String;
begin
  inherited;
  Try
    //*************************************************//
    // VERIFICA SE O PANEL DE FILTROS ESTA VISIVEL     //
    // SE SIM ENTAO MONTA O GRID E ESCONDE O PANEL     //
    //**********************************************ED*//
    case MomentoOperacao Of
      moFiltros: Begin
                   Self.WindowState := wsMaximized;
                   btnMarcar.Visible    := False;
                   btnDesmarcar.Visible := False;
                   btnEstLoj.Visible    := True;
                   pnlCabecalho.Enabled := False;

                   If Assigned(FrameAlteraPrecoIndividual) Then
                     FreeAndNil(FrameAlteraPrecoIndividual);
                   FrameAlteraPrecoIndividual := TFrameAlteraPrecoIndividual.fCriaFrameAlteraPrecoIndividual(Self,
                                                                                                              arrCampos,
                                                                                                              pnlGridResultado,
                                                                                                              qryGen);


                   FrameAlteraPrecoIndividual.pCarregaPosicionamento;
                   If (fMontaGrid) Then
                   Begin
                     pSalvaSelecao;
                     pSalvaPosicao;
                     pnlFiltros.Visible := False;
                     If (fCfgSis('COTDOR', varBoolean)) Then
                     Begin
                       fltValCotDol := fRetCotacaoAtualDolarCompra(strDtaCotDol);
                                        If (fltValCotDol > 0) Then
                       Begin
                          pnlInfoCotDol.Visible := True;
                         pnlInfoCotDol.Caption := 'Cotação do Dólar de Compra: $' + FormatFloat('#,##0.00', fltValCotDol) + ' (' + strDtaCotDol + ') - ' +
                                                  'Os valores de custos em Dólar ($) estão sendo exibidos em Real (R$)';
                       End;
                     End;
                     pnlBusca.Visible   := fCampoVisivel('CODFAB');
                     btnExcel.Visible   := True;
                     FrameAlteraPrecoIndividual.cxvTiposAlt.NavigatorButtons.First.Click;
                     NextMomentoOperacao;
                   End
                   Else
                     fMensagem('','Não há dados para serem alterados!',['&OK']);

                 End;


      moAlteracao : Begin
                      If (Not blnAlterouAlgumRegistro) Then
                      begin
                        fMensagem('', 'É necessário selecionar pelo menos 1 produto!', ['&Ok']);
                        Exit;
                      End;

                      if (not ValidarCaractereInvalido('ITE_DESITE', '|', qryGen)) then
                      begin
                        fMensagem('ATENÇÃO!','Caractere inválido "|" encontrado na Descrição!',['&OK']);
                        Exit;
                      end;

                      if (not ValidarCaractereInvalido('ITE_DESSIM', '|', qryGen)) then
                      begin
                        fMensagem('ATENÇÃO!','Caractere inválido "|" encontrado na Descrição Simplificada!',['&OK']);
                        Exit;
                      end;

                      if (not ValidarCaractereInvalido('ITE_REFERE', '|', qryGen)) then
                      begin
                        fMensagem('ATENÇÃO!','Caractere inválido "|" encontrado na Referência!',['&OK']);
                        Exit;
                      end;

                      if (not ValidarCaractereInvalido('ITE_CODFAB_NOV', '|', qryGen)) then
                      begin
                        fMensagem('ATENÇÃO!', 'Caractere inválido "|" encontrado no Cód. Fábrica!',['&OK']);
                        Exit;
                      end;

                      pRestauraPosicao;
                      qryGen.DisableControls;
                      pAtualizaTemporaria(True, '');

                      FrameAlteraPrecoIndividual.blnProcessoConfirmacao := True;

                      intRetorno := fVerificaDuplic;

                      // NAO TEM DUPLICIDADE
                      If (intRetorno <> -1) Then
                      Begin
                        pMostraColunasAntigasCx(True);

                        pMontaGridAlterados(False);

                        pnlCabecalho.Visible := False;
                        NextMomentoOperacao;

                      End
                      // CANCELOU OPERACAO
                      Else If (intRetorno = -1) Then
                      Begin
                        pAtualizaTemporaria(False, '');
                        pMontaGridAlterados(True);

                        Self.WindowState := wsMaximized;
                      End;


                      Self.WindowState := wsMaximized;
                      qryGen.EnableControls;
                      FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource.DataSet := qryGen;

                      pAlteraTitDesadb;

                    End;


    moConfimacaoAlteraco: Begin
                            If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
                              Exit;

                            If fMensagem('','Confirma alteração de dados?',['&Sim','&Não']) = 1 Then
                            Begin
                              Try

                                If Not fValidaPrecoCustoReal(qryGen) Then
                                  Exit;

                                If fCfgSis('MONPRC', varBoolean) Then
                                Begin
                                  objAvisoAlteracaoPreco.FcdsDados := qryGen;
                                  If Not objAvisoAlteracaoPreco.fVerificaOscilacao(tpAltInd) Then
                                    Exit;
                                End;

                                {*************************************************************}
                                {* CHAMA FORM PARA DIGITAÇÃO DA DATA DE ALTERAÇÃO DOS PREÇOS *}
                                {**********************************************************ER*}
                                pCriarFormularios(TfrmAltPrecoDigData, frmAltPrecoDigData);

                                {******************************************************}
                                {* ROTINA INCLUSA NOVAMENTE EM 31/03/2008 A PEDIDO DO *}
                                {* RONALDO - PIPOCOPOS                                *}
                                {***************************************************LU*}
                                If fCfgSis('TABPRD', VarBoolean) Then
                                begin
                                  frmAltPrecoDigData.dtaData := VS_Date;
                                  frmAltPrecoDigData.blnConfirma := True;
                                End
                                Else
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

                                      pMostraColunasAntigasCx(True);

                                      pnlCabecalho.Visible := True;

                                      qryGen.BeforeScroll := Nil;
                                      pDeletaTemporaria;
                                      pSalvaSelecao;
                                      fFecharTabela(qryGen);
                                      pnlCabecalho.Enabled := True;
                                 //     pLimpaCampos;
                                      FrameAlteraPrecoIndividual.cxgTiposAlt.Enabled := False;
                                      pnlFiltros.Visible  := True;
                                      btnEstLoj.Visible := False;
                                      pnlBusca.Visible    := False;
                                      btnExcel.Visible    := False;
                                      blnRestaurandoCopiaSeg := False;
                                      MomentoOperacao :=  moFiltros;

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

                              pMontaCampos;

                              pFreeAndNil(frmAltPrecoDigData);

                              btnMarcar.Visible    := True;
                              btnDesmarcar.Visible := True;
                              btnEstLoj.Visible    := False;

                              blnAlterouAlgumRegistro:= False;

                              Self.WindowState := wsMaximized;
                            End;
                          End;
    End;


  Finally
    If Assigned(FrameAlteraPrecoIndividual) Then
    Begin
      if FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource = Nil then
        FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource := dtsGen;
      if FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource.DataSet.ControlsDisabled then
        FrameAlteraPrecoIndividual.cxvTiposAlt.DataController.DataSource.DataSet.EnableControls;
    End;
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
  If Assigned(DataSet.FindField(strCampoFiltro)) Then
    Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmAltPrecoIndividual.pGravaIteCom(strCodIte, strTabPre,
  strNomCam: String; fltPerCom: Double);
begin
  qryIteCom.Close;
  qryIteCom.ParamByName('CODITE').AsString := strCodIte;
  qryIteCom.ParamByName('TABPRE').AsString := strTabPre;
  qryIteCom.Open;

  If qryIteCom.IsEmpty Then
  Begin
    qryIteCom.Insert;
    qryIteCom.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMITE', vs_strCodEmp);
    qryIteCom.FieldByName('COM_CODITE').AsString := strCodIte;
    qryIteCom.FieldByName('COM_TABPRE').AsString := strTabPre;
  End
  Else
    qryIteCom.Edit;

  qryIteCom.FieldByName(strNomCam).AsFloat  := fltPerCom;

  qryIteCom.Post;
end;

procedure TfrmAltPrecoIndividual.pGravarLogCpr(const qryGenPre: TUniQuery);
var
  strCodIte,
  strNomCam: String;
  intCont: Integer;
  qryGenIte: TUniQuery;
  qryGenCadIte: TUniQuery;
  strCampo: String;
  strCampoNovo: String;
  objCampo,
  objCampoNovo: TField;
begin
  strNomCam := '';
  strCodIte := qryGenPre.FieldByName('ITE_CODITE').AsString;
  qryGenIte := fGenIte(strCodIte);
  qryGenCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE');
  Try
    For intCont := 0 To qryGenPre.Fields.Count - 1 Do
    Begin
      strCampo := qryGenPre.Fields[intCont].FieldName;
      If strCampo = 'ALTERA' Then
        Continue;

      //A LogCpr grava apenas campos da CADITE
      If (qryGenCadIte.FindField(strCampo) = nil) Then
        Continue;

      strCampoNovo := strCampo + '_NOV';
      objCampo := qryGenPre.FindField(strCampo);
      objCampoNovo := qryGenPre.FindField(strCampoNovo);

      If Not Assigned(objCampoNovo) Then
      Begin
        objCampoNovo := objCampo;
        objCampo := qryGenIte.FindField(strCampo);
      End;

      if
        (objCampo <> Nil) And
        (objCampoNovo <> Nil) And
        (objCampo.Value <> objCampoNovo.Value) Then
      Begin
        strNomCam := fUpper(qryGenPre.FindField(strCampo).DisplayLabel);
        pInserirLog(strCodIte, strNomCam, objCampo, objCampoNovo);
      End;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;


procedure TfrmAltPrecoIndividual.pHabilitaCamposMargemIdeal;
begin
  if cbxMarIde.ItemIndex = 0 then
  begin
    cbxTabPrc.ItemIndex := -1;
    lblTabPrc.Enabled:= False;
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

function TfrmAltPrecoIndividual.ValidarCaractereInvalido(const Acampo,
  Acaractere: string; qryGen: TUniQuery): Boolean;
begin
  Result := True;

  qryGen.DisableControls;
  qryGen.First;

  try
    While not qryGen.Eof do
    Begin
      if (qryGen.FieldByName('ALTERA').AsString = 'S') and (Pos(Acaractere, qryGen.FieldByName(Acampo).AsString) > 0) then
      begin
        Result := False;
        Exit;
      end;

      qryGen.Next;
    End;
  finally
    qryGen.EnableControls;
  end;
end;

procedure TfrmAltPrecoIndividual.pCalcularVariacoes(Dataset : TDataset);
var
  strCampoFocado,
  strCampoPreve: String;
begin
  strCampoFocado := TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Controller.FocusedColumn).DataBinding.FieldName;
  If (Pos('PREVE', strCampoFocado) > 0) Then
  Begin
    strCampoPreve := 'ITE_PREVE'+Copy(strCampoFocado, 10, 1);
    If Dataset.FieldByName(strCampoPreve).AsFloat > 0 Then
      Dataset.FieldByName(strCampoPreve+'_VAR').AsFloat := ABS(((Dataset.FieldByName(strCampoPreve+'_NOV').AsFloat /  Dataset.FieldByName(strCampoPreve).AsFloat) -1) * 100.00);
  End;

end;

procedure TfrmAltPrecoIndividual.pBeforePost(Dataset: TDataset);
  Var
    fltEstIte: Double;
Begin
  If qryGen.IsEmpty Then
    Exit;

  If fValidarEXPSIT Then
  Begin
    fMensagem('ATENÇÃO!', 'É obrigatório o preenchimento do "Nome do produto E-Commecer" e "Aplicação - E-Commecer" para o produto ' +
      qryGen.FieldByName('ITE_CODITE').AsString + ' - ' + qryGen.FieldByName('ITE_DESITE').AsString, ['&O k']);
    Abort;
  End;

  pValidaEstoqueDigitado;
  pValidaDescontoMaximoOperador(Dataset);
  pValidaMargemMinimaOperador(Dataset);

  If fCampoMarcado('ESTMIN') Then
  Begin
    If (IIF(qryGen.FieldByName('ITE_ESTMIN_NOV').Value = null, -1, qryGen.FieldByName('ITE_ESTMIN_NOV').Value) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Mínimo deve ser maior ou igual a Zero!', ['&Ok']);
      Abort;
      Exit;
    End;

    If Not fCampoMarcado('ESTMAX') Then
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

  If fCampoMarcado('ESTMAX') Then
  Begin
    If ((IIF(qryGen.FieldByName('ITE_ESTMAX_NOV').Value = null, -1, qryGen.FieldByName('ITE_ESTMAX_NOV').Value)) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Máximo deve ser maior ou igual a Zero!', ['&Ok']);
      Abort;
      Exit;
    End;

    If Not fCampoMarcado('ESTMIN') Then
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

  If fCampoMarcado('LARVID')Then
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

  If fCampoMarcado('ALTVID') Then
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

  If fCampoMarcado('LAMAVI') Then
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

  If fCampoMarcado('ALMAVI') Then
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

  If fCampoMarcado('CLAIPI') Then
  Begin
    If (fEmptyStr(qryGen.FieldByName('ITE_CLAIPI_NOV').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Campo NCM / Classif. IPI deve ser informado!', ['&Ok']);
      Abort;
      Exit;
    End;
  End;

  If fCampoMarcado('CODMAR') Then
  Begin
    If (fEmptyStr(qryGen.FieldByName('ITE_CODMAR_NOV').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Campo Marca deve ser informado!', ['&Ok']);
      Abort;
      Exit;
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
        qryUpDate.ParamByName('PR1ANT').AsFloat    := FieldByName('ALT_VE1ANT').AsFloat  ;
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
    For intContador := 0 To FrameAlteraPrecoIndividual.cxvTiposAlt.ColumnCount -1 Do
      strLisCam.Add(TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Columns[intContador]).DataBinding.FieldName);
  End;
End;

Procedure TfrmAltPrecoIndividual.pRestauraPosicao;
  Var
    intIndice, intContador: Integer;
Begin
  pSalvaPosicaoUsuario(strLisUsu);
  If Assigned(FrameAlteraPrecoIndividual) Then
  Begin
    For intIndice := 0 To strLisCam.Count -1 Do
      For intContador := 0 To FrameAlteraPrecoIndividual.cxvTiposAlt.ColumnCount -1 Do
        If TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Columns[intContador]).DataBinding.FieldName = strLisCam[intIndice] Then
          FrameAlteraPrecoIndividual.cxvTiposAlt.Columns[intContador].Index := intIndice;
  End;
End;

Procedure TfrmAltPrecoIndividual.pSalvaPosicaoUsuario(strLisUsu: TStringList);
  Var
    intContador: Integer;
Begin
  strLisUsu.Clear;
  If Assigned(FrameAlteraPrecoIndividual) Then
  Begin
    For intContador := 0 To FrameAlteraPrecoIndividual.cxvTiposAlt.ColumnCount -1 Do
      If FrameAlteraPrecoIndividual.cxvTiposAlt.Columns[intContador].Visible Then
        strLisUsu.Add(IntToStr(TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Columns[intContador]).Position.BandIndex) + ' ' +
                      fStrZero(IntToStr(TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Columns[intContador]).Position.VisibleColIndex), 3) + ' ' +
           TcxGridDBBandedColumn(FrameAlteraPrecoIndividual.cxvTiposAlt.Columns[intContador]).DataBinding.FieldName);
  End;
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

procedure TfrmAltPrecoIndividual.pUpdateCADITE(AQuery: TUniQuery);
var
  qryGenIte: TUniQuery;
begin
  qryGenIte := fCriaQuery(Self);
  try
    If AQuery.FieldByName('ITE_CODMON').AsString  <> AQuery.FieldByName('ITE_CODMON_NOV').AsString Then
      pGravaMontadoras(AQuery.FieldByName('ITE_CODITE').AsString,
                       AQuery.FieldByName('ITE_CODMON_NOV').AsString,
                       qryGenIte);

    qryGenIte.SQL.Text := fGetSqlUpdateCADITE(AQuery);

    If (Not fEmptyStr(AQuery.FieldByName('ITE_CODBAR_NOV').AsString)) And  (AQuery.FieldByName('ITE_CODBAR_NOV').AsString <> AQuery.FieldByName('ITE_CODBAR').AsString) Then
    Begin
      objIteBar.pCarregaDados(AQuery.FieldByName('ITE_CODITE').AsString);

      if objIteBar.cdsIteBar.IsEmpty then
        qryGenIte.ParamByName('CODBAR').AsString := AQuery.FieldByName('ITE_CODBAR_NOV').AsString
      Else
        qryGenIte.ParamByName('CODBAR').AsString  := AQuery.FieldByName('ITE_CODBAR').AsString;



      objIteBar.pIncluiCodigo(AQuery.FieldByName('ITE_CODBAR_NOV').AsString,
                                           1,
                                           objIteBar.cdsIteBar.IsEmpty, objIteBar.cdsIteBar.IsEmpty, True,
                                           0, '', '', '', 0,0,0,0,0,0,0,0, objIteBar.cdsIteBar.IsEmpty);
      objIteBar.pSalvaDados(AQuery.FieldByName('ITE_CODITE').AsString, True);

    End
    Else
    Begin
      If ((Not fEmptyStr(AQuery.FieldByName('ITE_BARPRV').AsString)) And (Not(AQuery.FieldByName('ITE_BARPRV').IsNull)) And
        (AQuery.FieldByName('ITE_BARPRV').AsString <> AQuery.FieldByName('ITE_BARPRI').AsString)) Then
        qryGenIte.ParamByName('CODBAR').AsString := AQuery.FieldByName('ITE_BARPRV').AsString
      Else
        qryGenIte.ParamByName('CODBAR').AsString  := AQuery.FieldByName('ITE_CODBAR').AsString;
    End;


    If ((Not fEmptyStr(AQuery.FieldByName('ITE_BARPRV').AsString)) And (Not(AQuery.FieldByName('ITE_BARPRV').IsNull)) And
       ((AQuery.FieldByName('ITE_BARPRV').AsString <> AQuery.FieldByName('ITE_BARPRI').AsString) Or
        (AQuery.FieldByName('ITE_EMBPRV').AsString <> AQuery.FieldByName('ITE_EMBPRI').AsString))) Then
    Begin

      objIteBar.pCarregaDados(AQuery.FieldByName('ITE_CODITE').AsString);

      If objIteBar.fCodigoDeBarrasExiste(AQuery.FieldByName('ITE_BARPRV').AsString) Then
      Begin

        objIteBar.pIncluiCodigo(AQuery.FieldByName('ITE_BARPRV').AsString,
                                             AQuery.FieldByName('ITE_EMBPRV').AsCurrency,
                                             True,
                                             objIteBar.fEhPrincipal(AQuery.FieldByName('ITE_CODITE').AsString,
                                                                    AQuery.FieldByName('ITE_BARPRV').AsString, ttpCompra),
                                             True,
                                             0, '', '', '', 0,0,0,0,0,0,0,0, objIteBar.cdsIteBar.IsEmpty);
        objIteBar.pSalvaDados(AQuery.FieldByName('ITE_CODITE').AsString, True);

      End
      Else
      Begin

        objIteBar.pIncluiCodigo(AQuery.FieldByName('ITE_BARPRV').AsString,
                                             AQuery.FieldByName('ITE_EMBPRV').AsCurrency,
                                             True, objIteBar.cdsIteBar.IsEmpty, True,
                                             0, '', '', '', 0,0,0,0,0,0,0,0, objIteBar.cdsIteBar.IsEmpty);
        objIteBar.pSalvaDados(AQuery.FieldByName('ITE_CODITE').AsString, True);

      End;

    End;


    If ((Not fEmptyStr(AQuery.FieldByName('ITE_BARPRC').AsString)) And (Not(AQuery.FieldByName('ITE_BARPRC').IsNull)) And
        ((AQuery.FieldByName('ITE_BARPRC').AsString <> AQuery.FieldByName('ITE_BARPRP').AsString) Or
         (AQuery.FieldByName('ITE_EMBPRC').AsString <> AQuery.FieldByName('ITE_EMBPRP').AsString))) Then
    Begin

      objIteBar.pCarregaDados(AQuery.FieldByName('ITE_CODITE').AsString);

      If objIteBar.fCodigoDeBarrasExiste(AQuery.FieldByName('ITE_BARPRC').AsString) Then
      Begin

        objIteBar.pIncluiCodigo(AQuery.FieldByName('ITE_BARPRC').AsString,
                                             AQuery.FieldByName('ITE_EMBPRC').AsCurrency,
                                             objIteBar.fEhPrincipal(AQuery.FieldByName('ITE_CODITE').AsString,
                                                                    AQuery.FieldByName('ITE_BARPRC').AsString, ttpVenda),
                                             True, True,
                                             0, '', '', '', 0,0,0,0,0,0,0,0, objIteBar.cdsIteBar.IsEmpty);
        objIteBar.pSalvaDados(AQuery.FieldByName('ITE_CODITE').AsString, True);

      End
      Else
      Begin

        objIteBar.pIncluiCodigo(AQuery.FieldByName('ITE_BARPRC').AsString,
                                             AQuery.FieldByName('ITE_EMBPRC').AsCurrency,
                                             objIteBar.cdsIteBar.IsEmpty, True, True,
                                             0, '', '', '', 0,0,0,0,0,0,0,0, objIteBar.cdsIteBar.IsEmpty);
        objIteBar.pSalvaDados(AQuery.FieldByName('ITE_CODITE').AsString, True);

      End;

    End;

    qryGenIte.ParamByName('PESOIT').AsFloat  := AQuery.FieldByName('ITE_PESOIT_NOV').AsFloat;
    qryGenIte.ParamByName('PESLIQ').AsFloat  := AQuery.FieldByName('ITE_PESLIQ_NOV').AsFloat;
    qryGenIte.ParamByName('DESITE').AsString := AQuery.FieldByName('ITE_DESITE').AsString;
    qryGenIte.ParamByName('DESSIM').AsString := AQuery.FieldByName('ITE_DESSIM').AsString;
    qryGenIte.ParamByName('DESFAB').AsString := AQuery.FieldByName('ITE_DESFAB').AsString;

    qryGenIte.ParamByName('USAPFD').AsString := AQuery.FieldByName('ITE_USAPFD').AsString;
    qryGenIte.ParamByName('USAPCV').AsString := AQuery.FieldByName('ITE_USAPCV').AsString;

    qryGenIte.ParamByName('DIFICM').AsString := AQuery.FieldByName('ITE_DIFICM').AsString;

    qryGenIte.ParamByName('MSGLV1').AsString := AQuery.FieldByName('ITE_MSGLV1').AsString;
    qryGenIte.ParamByName('MSGLV2').AsString := AQuery.FieldByName('ITE_MSGLV2').AsString;

    qryGenIte.ParamByName('REFERE').AsString := AQuery.FieldByName('ITE_REFERE').AsString;
    qryGenIte.ParamByName('ITEATI').AsString := AQuery.FieldByName('ITE_ITEATI_NOV').AsString;
    qryGenIte.ParamByName('GRAMAR').AsString := AQuery.FieldByName('ITE_GRAMAR_NOV').AsString;

    qryGenIte.ParamByName('EXPPOK').AsString := AQuery.FieldByName('ITE_EXPPOK_NOV').AsString;

    If fCfgSIs('IMPDIG') = '1' Then
      qryGenIte.ParamByName('IMPDIR').AsString := AQuery.FieldByName('ITE_IMPDIR_NOV').AsString;

    If fCfgSIs('TIPABF') = '1' Then
      qryGenIte.ParamByName('USAPPF').AsString := AQuery.FieldByName('ITE_USAPPF_NOV').AsString;

    qryGenIte.ParamByName('FATCMP').AsFloat := AQuery.FieldByName('ITE_FATCMP_NOV').AsFloat;

    qryGenIte.ParamByName('FATPM3').AsFloat := AQuery.FieldByName('ITE_FATPM3_NOV').AsFloat;

    If fCfgSIs('TIPABF') = '1' Then
      qryGenIte.ParamByName('CODABF').AsString := fStrZero(AQuery.FieldByName('ITE_CODABF_NOV').AsString, IIf(fCfgSis('USASAN') = 'S', 7, 3));

    If fCampoVisivel('DENSID') And (cdsParametrosMARCADO.AsBoolean) Then
      qryGenIte.ParamByName('DENSID').AsFloat := AQuery.FieldByName('ITE_DENSID_NOV').AsFloat;

    If fUsaRotinaWMS Then
      qryGenIte.ParamByName('RASTRE').AsString := AQuery.FieldByName('ITE_RASTRE_NOV').AsString;

    If fCfgSis('TPABPC') = '1' Then
    Begin
      If fEmptyStr(AQuery.FieldByName('ITE_ABFPIS_NOV').AsString) Then
        qryGenIte.ParamByName('ABFPIS').Value := Null
      else
        qryGenIte.ParamByName('ABFPIS').AsString := fStrZero(AQuery.FieldByName('ITE_ABFPIS_NOV').AsString, 3);

      If fEmptyStr(AQuery.FieldByName('ITE_ABFCOF_NOV').AsString) Then
        qryGenIte.ParamByName('ABFCOF').Value := Null
      Else
        qryGenIte.ParamByName('ABFCOF').AsString := fStrZero(AQuery.FieldByName('ITE_ABFCOF_NOV').AsString, 3);

      If fEmptyStr(AQuery.FieldByName('ITE_ABFIPI_NOV').AsString) Then
        qryGenIte.ParamByName('ABFIPI').Value := Null
      Else
        qryGenIte.ParamByName('ABFIPI').AsString := fStrZero(AQuery.FieldByName('ITE_ABFIPI_NOV').AsString, 3);
    End;

    qryGenIte.ParamByName('CLAIPI').AsString  := AQuery.FieldByName('ITE_CLAIPI_NOV').AsString;
    qryGenIte.ParamByName('EXCIPI').AsString  := AQuery.FieldByName('ITE_EXCIPI_NOV').AsString;
    qryGenIte.ParamByName('PER_CI').AsString  := AQuery.FieldByName('ITE_PER_CI_NOV').AsString;
    qryGenIte.ParamByName('PIMPTC').AsFloat   := AQuery.FieldByName('ITE_PIMPTC_NOV').AsFloat;
    qryGenIte.ParamByName('NUMFCI').AsString  := AQuery.FieldByName('ITE_NUMFCI_NOV').AsString;
    qryGenIte.ParamByName('MLTCOM').AsFloat   := AQuery.FieldByName('ITE_MLTCOM_NOV').AsFloat;
    qryGenIte.ParamByName('MLTVEN').AsFloat   := AQuery.FieldByName('ITE_MLTVEN_NOV').AsFloat;
    qryGenIte.ParamByName('CODFAB').AsString  := AQuery.FieldByName('ITE_CODFAB_NOV').AsString;

    qryGenIte.ParamByName('MESGIR').AsInteger := AQuery.FieldByName('ITE_MESGIR_NOV').AsInteger;

    If fCampoVisivel('RSPGAR') And (cdsParametrosMARCADO.AsBoolean) Then
      qryGenIte.ParamByName('RSPGAR').AsString  := AQuery.FieldByName('ITE_RSPGAR_NOV').AsString;
    If fCampoVisivel('TMPGAR') And (cdsParametrosMARCADO.AsBoolean) Then
      qryGenIte.ParamByName('TMPGAR').AsInteger := AQuery.FieldByName('ITE_TMPGAR_NOV').AsInteger;
    If fCampoVisivel('INFGAR') And (cdsParametrosMARCADO.AsBoolean) Then
      qryGenIte.ParamByName('INFGAR').AsString  := AQuery.FieldByName('ITE_INFGAR_NOV').AsString;

    If ((Not fEmptyStr(AQuery.FieldByName('ITE_BARPRC').AsString)) And (Not(AQuery.FieldByName('ITE_BARPRC').IsNull)) And
        (AQuery.FieldByName('ITE_BARPRC').AsString <> AQuery.FieldByName('ITE_BARPRP').AsString)) Then
      qryGenIte.ParamByName('EMBALA').AsFloat   := 1
    Else
      qryGenIte.ParamByName('EMBALA').AsFloat   := AQuery.FieldByName('ITE_EMBALA_NOV').AsFloat;

    If (Not fEmptyStr(AQuery.FieldByName('ITE_BARPRC').AsString)) And (Not(AQuery.FieldByName('ITE_BARPRC').IsNull)) Then
    Begin
      qryGenIte.ParamByName('BAREMB').AsString := AQuery.FieldByName('ITE_BARPRC').AsString;
      {qryGenIte.ParamByName('EMBALA').AsFloat := 1;}
    End
    Else
      qryGenIte.ParamByName('BAREMB').AsString := AQuery.FieldByName('ITE_BAREMB_NOV').AsString;

    qryGenIte.ParamByName('INFLAM').AsString  := AQuery.FieldByName('ITE_INFLAM_NOV').AsString;
    qryGenIte.ParamByName('USABON').AsString  := AQuery.FieldByName('ITE_USABON_NOV').AsString;
    qryGenIte.ParamByName('USAFLE').AsString  := AQuery.FieldByName('ITE_USAFLE_NOV').AsString;
    qryGenIte.ParamByName('OBRCPF').AsString  := AQuery.FieldByName('ITE_OBRCPF_NOV').AsString;
    qryGenIte.ParamByName('OBRIBA').AsString  := AQuery.FieldByName('ITE_OBRIBA_NOV').AsString;

    if not fCfgSis('NFEPEP', varBoolean) then
       qryGenIte.ParamByName('OBRNFE').AsString  := AQuery.FieldByName('ITE_OBRNFE_NOV').AsString;

    qryGenIte.ParamByName('NVLGIR').AsString  := AQuery.FieldByName('ITE_NVLGIR_NOV').AsString;

    qryGenIte.ParamByName('NVLCRI').AsString  := AQuery.FieldByName('ITE_NVLCRI_NOV').AsString;

    qryGenIte.ParamByName('PROEMB').AsString  := AQuery.FieldByName('ITE_PROEMB_NOV').AsString;
    qryGenIte.ParamByName('ACOOBJ').AsString  := AQuery.FieldByName('ITE_ACOOBJ_NOV').AsString;
    qryGenIte.ParamByName('VALOBR').AsString  := AQuery.FieldByName('ITE_VALOBR_NOV').AsString;

    qryGenIte.ParamByName('CODUNI').AsString  := AQuery.FieldByName('ITE_CODUNI_NOV').AsString;
    If fEmptyStr(qryGenIte.ParamByName('CODUNI').AsString) Then
      qryGenIte.ParamByName('CODUNI').Clear;

    qryGenIte.ParamByName('UNICOM').AsString  := AQuery.FieldByName('ITE_UNICOM_NOV').AsString;
    If fEmptyStr(qryGenIte.ParamByName('UNICOM').AsString) Then
      qryGenIte.ParamByName('UNICOM').Clear;

    qryGenIte.ParamByName('UNITRI').AsString  := AQuery.FieldByName('ITE_UNITRI_NOV').AsString;
    If fEmptyStr(qryGenIte.ParamByName('UNITRI').AsString) Then
      qryGenIte.ParamByName('UNITRI').Clear;

    qryGenIte.ParamByName('FATUTR').Value  := AQuery.FieldByName('ITE_FATUTR_NOV').Value;

    qryGenIte.ParamByName('CODMAR').AsString  := AQuery.FieldByName('ITE_CODMAR_NOV').AsString;
    If fEmptyStr(qryGenIte.ParamByName('CODMAR').AsString) Then
      qryGenIte.ParamByName('CODMAR').Clear;

    If intSitPro = 1 Then
    Begin
      qryGenIte.ParamByName('SITPRO').AsString  := AQuery.FieldByName('ITE_SITPRO_NOV').AsString;
      If fEmptyStr(qryGenIte.ParamByName('SITPRO').AsString) Then
        qryGenIte.ParamByName('SITPRO').Clear;
    End;

    qryGenIte.ParamByName('CODMON').Clear;

    qryGenIte.ParamByName('CODFOR').AsString  := AQuery.FieldByName('ITE_CODFOR_NOV').AsString;
    If fEmptyStr(qryGenIte.ParamByName('CODFOR').AsString) Then
      qryGenIte.ParamByName('CODFOR').Clear;

    qryGenIte.ParamByName('DIAFOR').AsInteger := AQuery.FieldByName('ITE_DIAFOR_NOV').AsInteger;

    qryGenIte.ParamByName('REAEND').AsString  := AQuery.FieldByName('ITE_REAEND_NOV').AsString;

    qryGenIte.ParamByName('OBRBAR').AsString  := AQuery.FieldByName('ITE_OBRBAR_NOV').AsString;

    qryGenIte.ParamByName('FATCOM').AsString  := AQuery.FieldByName('ITE_FATCOM_NOV').AsString;

    qryGenIte.ParamByName('PEFUTP').AsString  := AQuery.FieldByName('ITE_PEFUTP_NOV').AsString;
    qryGenIte.ParamByName('PEEFUT').AsString  := AQuery.FieldByName('ITE_PEEFUT_NOV').AsString;
    qryGenIte.ParamByName('PEFFPR').AsString  := AQuery.FieldByName('ITE_PEFFPR_NOV').AsString;

    If Not fEmptyStr(AQuery.FieldByName('ITE_CODDEP_NOV').AsString) Then
      qryGenIte.ParamByName('CODDEP').AsString  := AQuery.FieldByName('ITE_CODDEP_NOV').AsString
    Else
      qryGenIte.ParamByName('CODDEP').Clear;

    If Not fEmptyStr(AQuery.FieldByName('ITE_GRUCMP_NOV').AsString) Then
      qryGenIte.ParamByName('GRUCMP').AsString  := AQuery.FieldByName('ITE_GRUCMP_NOV').AsString
    Else
      qryGenIte.ParamByName('GRUCMP').Clear;

    If Not fEmptyStr(AQuery.FieldByName('ITE_CODGPR_NOV').AsString) Then
      qryGenIte.ParamByName('CODGPR').AsString  := AQuery.FieldByName('ITE_CODGPR_NOV').AsString
    Else
      qryGenIte.ParamByName('CODGPR').Clear;

    If Not fEmptyStr(AQuery.FieldByName('ITE_CDCEST_NOV').AsString) Then
      qryGenIte.ParamByName('CDCEST').AsString  := AQuery.FieldByName('ITE_CDCEST_NOV').AsString
    Else
      qryGenIte.ParamByName('CDCEST').Clear;

    If Not fEmptyStr(AQuery.FieldByName('ITE_DESCND_NOV').AsString) Then
      qryGenIte.ParamByName('DESCND').AsString  := AQuery.FieldByName('ITE_DESCND_NOV').AsString
    Else
      qryGenIte.ParamByName('DESCND').Clear;

    If Not fEmptyStr(AQuery.FieldByName('ITE_APLICA_NOV').AsString) Then
      qryGenIte.ParamByName('APLICA').AsString  := AnsiReplaceStr(AQuery.FieldByName('ITE_APLICA_NOV').AsString, #13#10, '<<csq>>')
    Else
      qryGenIte.ParamByName('APLICA').Clear;

    If Not fEmptyStr(AQuery.FieldByName('ITE_NOTESP_NOV').AsString) Then
      qryGenIte.ParamByName('NOTESP').AsString  := AQuery.FieldByName('ITE_NOTESP_NOV').AsString
    Else
      qryGenIte.ParamByName('NOTESP').Clear;

    If Not fEmptyStr(AQuery.FieldByName('ITE_PRDGRU_NOV').AsString) Then
      qryGenIte.ParamByName('PRDGRU').AsString  := AQuery.FieldByName('ITE_PRDGRU_NOV').AsString
    Else
      qryGenIte.ParamByName('PRDGRU').Clear;

    qryGenIte.ParamByName('ATICOM').AsString  := AQuery.FieldByName('ITE_ATICOM_NOV').AsString;
    qryGenIte.ParamByName('CODDIC').AsString  := AQuery.FieldByName('ITE_CODDIC_NOV').AsString;
    If fEmptyStr(qryGenIte.ParamByName('CODDIC').AsString) Then
      qryGenIte.ParamByName('CODDIC').Clear;

    qryGenIte.ParamByName('IMPETI').AsString  := AQuery.FieldByName('ITE_IMPETI_NOV').AsString;

    qryGenIte.ParamByName('CODITE').AsString  := AQuery.FieldByName('ITE_CODITE').AsString;

    qryGenIte.ParamByName('DTAALT').AsDateTime := VS_Date;
    qryGenIte.ParamByName('HULALT').AsDateTime := fNow;
    qryGenIte.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
    qryGenIte.ParamByName('CODGRU').AsString   := AQuery.FieldByName('ITE_CODGRU_NOV').AsString;
    qryGenIte.ParamByName('TIPFRE').AsString   := AQuery.FieldByName('ITE_TIPFRE_NOV').AsString;
    qryGenIte.ParamByName('VLCFRE').AsString   := AQuery.FieldByName('ITE_VLCFRE_NOV').AsString;

    qryGenIte.ParamByName('LARVID').AsFloat    := AQuery.FieldByName('ITE_LARVID_NOV').AsFloat;
    qryGenIte.ParamByName('ALTVID').AsFloat    := AQuery.FieldByName('ITE_ALTVID_NOV').AsFloat;
    qryGenIte.ParamByName('LAMAVI').AsFloat    := AQuery.FieldByName('ITE_LAMAVI_NOV').AsFloat;
    qryGenIte.ParamByName('ALMAVI').AsFloat    := AQuery.FieldByName('ITE_ALMAVI_NOV').AsFloat;
    qryGenIte.ParamByName('UTIAMP').AsString   := AQuery.FieldByName('ITE_UTIAMP_NOV').AsString;
    qryGenIte.ParamByName('LOTEPD').AsString   := AQuery.FieldByName('ITE_LOTEPD_NOV').AsString;
    qryGenIte.ParamByName('CAREST').AsString   := AQuery.FieldByName('ITE_CAREST_NOV').AsString;
    qryGenIte.ParamByName('ORDSER').AsString   := AQuery.FieldByName('ITE_ORDSER_NOV').AsString;
    qryGenIte.ParamByName('CLACRM').AsString   := AQuery.FieldByName('ITE_CLACRM_NOV').AsString;

    if FPermVendaIgualTodasEmp then
      qryGenIte.ParamByName('PERVDA').AsString   := AQuery.FieldByName('ITE_PERVDA_NOV').AsString;

    qryGenIte.ParamByName('BAREXP').AsString   := AQuery.FieldByName('ITE_BAREXP_NOV').AsString;
    qryGenIte.ParamByName('SEPBAR').AsString   := AQuery.FieldByName('ITE_SEPBAR_NOV').AsString;
    qryGenIte.ParamByName('EXPSIT').AsString   := AQuery.FieldByName('ITE_EXPSIT_NOV').AsString;

    If fDataValida(AQuery.FieldByName('ITE_DTAEPI_NOV').AsDateTime) Then
      qryGenIte.ParamByName('DTAEPI').AsDateTime := AQuery.FieldByName('ITE_DTAEPI_NOV').AsDateTime
    Else
       qryGenIte.ParamByName('DTAEPI').Clear;

    If Not fEmptyStr(AQuery.FieldByName('ITE_CODGPC_NOV').AsString) Then
      qryGenIte.ParamByName('CODGPC').AsString  := AQuery.FieldByName('ITE_CODGPC_NOV').AsString
    Else
      qryGenIte.ParamByName('CODGPC').Clear;

    If (fCfgSis('CLAONU', varBoolean)) Then
      If (AQuery.FieldByName('ITE_CODONU_NOV').AsString = '') Then
        qryGenIte.ParamByName('CODONU').Value    := Null
      Else
        qryGenIte.ParamByName('CODONU').AsString := AQuery.FieldByName('ITE_CODONU_NOV').AsString;

    If fCfgSis('EMPCAR', varBoolean) Then
    Begin
      If Not fEmptyStr(AQuery.FieldByName('ITE_EMPCAR_NOV').AsString) Then
        qryGenIte.ParamByName('EMPCAR').AsString := AQuery.FieldByName('ITE_EMPCAR_NOV').AsString
      Else
        qryGenIte.ParamByName('EMPCAR').Clear;
    End;

    if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
    Begin
      If Not fEmptyStr(AQuery.FieldByName('ITE_EMPSUG_NOV').AsString) Then
        qryGenIte.ParamByName('EMPSUG').AsString := AQuery.FieldByName('ITE_EMPSUG_NOV').AsString
      Else
        qryGenIte.ParamByName('EMPSUG').Clear;
    End;

    If fCfgSis('SEPEXC', varBoolean) Then
      qryGenIte.ParamByName('SEPEXC').AsString := AQuery.FieldByName('ITE_SEPEXC_NOV').AsString;

    If fCfgSis('UTPEST', varBoolean) Then
    Begin
      qryGenIte.ParamByName('QTDPES').AsString := AQuery.FieldByName('ITE_QTDPES_NOV').AsString;
      qryGenIte.ParamByName('PORPES').AsString := AQuery.FieldByName('ITE_PORPES_NOV').AsString;
    End;

    if blnURapel then
      qryGenIte.ParamByName('PRAPEL').AsFloat  := AQuery.FieldByName('ITE_PRAPEL_NOV').AsFloat;

    If fCfgSis('ETIDCE', varBoolean) Then
      qryGenIte.ParamByName('NECEXP').AsString  := AQuery.FieldByName('ITE_NECEXP_NOV').AsString;


    If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
    Begin
      qryGenIte.ParamByName('NFEIDP').AsString  := AQuery.FieldByName('ITE_NFEIDP_NOV').AsString;
      qryGenIte.ParamByName('NFCIDP').AsString  := AQuery.FieldByName('ITE_NFCIDP_NOV').AsString;
    End;

    If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
      qryGenIte.ParamByName('LOTRAP').AsString  := AQuery.FieldByName('ITE_LOTRAP_NOV').AsString;

    If fCfgSis('TRITTE', varBoolean) Then
      qryGenIte.ParamByName('TRITTE').AsString := AQuery.FieldByName('ITE_TRITTE_NOV').AsString;

    qryGenIte.ParamByName('ITEBAS').AsString  := AQuery.FieldByName('ITE_ITEBAS_NOV').AsString;

    If fCfgSis('CDPHAB', varBoolean) Then
      qryGenIte.ParamByName('CLBPIN').AsString := AQuery.FieldByName('ITE_CLBPIN_NOV').AsString;

    If blnUsaBef Then
      qryGenIte.ParamByName('USABEF').AsString := AQuery.FieldByName('ITE_USABEF_NOV').AsString;

    TAltDes.pSalvaLogCompara(AQuery.FieldByName('ITE_CODITE').AsString,
                             strLoginUsuarioLogado,
                             AQuery.FieldByName('ITE_DESITE').AsString,
                             AQuery.FieldByName('ITE_REFERE').AsString,
                             AQuery.FieldByName('ITE_CODUNI_NOV').AsString);

    qryGenIte.ExecSQL;
    qryGenIte.Close;
  finally
    FreeAndNil(qryGenIte);
  end;
end;

Procedure TfrmAltPrecoIndividual.pRestauraPosicaoUsuario;
  Var
    intW0,
    intW1,
    intBand,
    intPos,
    intIndice: Integer;
    cxItem: TcxCustomGridTableItem;
Begin
  intW0 := 0;
  intW1 := 0;

  For intIndice := 0 To strLisUsu.Count -1 Do
  Begin
    intBand := StrToIntDef(LeftStr(strLisUsu[intIndice], 1), 1);

    intPos  := StrToIntDef(Copy(strLisUsu[intIndice], 3, 3), intIndice);

    cxItem := FrameAlteraPrecoIndividual.cxvTiposAlt.GetColumnByFieldName(Copy(strLisUsu[intIndice], 7, Length(strLisUsu[intIndice]) - 6));

    If Assigned(cxItem) Then
    Begin
      TcxGridDBBandedColumn(cxItem).Position.BandIndex  := intBand;
      TcxGridDBBandedColumn(cxItem).Position.ColIndex   := intPos;

      If intBand = 0 Then
        Inc(intW0, TcxGridDBBandedColumn(cxItem).Width)
      Else
        Inc(intW1, TcxGridDBBandedColumn(cxItem).Width);
    End;

  End;

  FrameAlteraPrecoIndividual.cxvTiposAlt.Bands[0].Width := intW0;
  FrameAlteraPrecoIndividual.cxvTiposAlt.Bands[1].Width := intW1;
End;


procedure TfrmAltPrecoIndividual.pAlimentaCdsParametros;
  var
    intCont: Integer;
    blnVisibilidade: Boolean;
    GerenciaItegerPermiteEdicao : TGerenciaItegerPermiteEdicao;

  procedure pIncluiParametro(ACampo, ADescricao: String; blnVisible: boolean = True);
  Begin
    If fCampoVisivel(ACampo) Then
    Begin
      cdsParametros.Edit;
      cdsParametrosVISIVEL.AsInteger :=  IIf(blnVisible, 1, 0);
      If cdsParametrosMARCADO.AsBoolean Then
        cdsParametrosMARCADO.AsBoolean :=  IIf(blnVisible, 1, 0);

      If pos(cdsParametrosCAMPO.AsString, 'VALFRE_MARMIN_MARMMV_MARMSG_MARMMS_MARMGE_MARMMG_DESMAX_DESMVM_DESMSU_DESMSM_DESMGE_DESMGM_') > 0 Then
        cdsParametrosDESCRI.AsString := ADescricao   + '|' + RemoveAcento(ADescricao);

      cdsParametros.Post;
    End
    Else
    Begin
      cdsParametros.Append;
      cdsParametrosMARCADO.AsBoolean :=  IIf(blnVisible, 1, 0);;
      cdsParametrosCAMPO.AsString :=  ACampo;
      cdsParametrosVISIVEL.AsInteger :=  IIf(blnVisible, 1, 0);
      cdsParametrosDESCRI.AsString :=  ADescricao   + '|' + RemoveAcento(ADescricao);
      cdsParametros.Post;
    End;
  End;

begin
  cdsParametros.DisableControls;
  GerenciaItegerPermiteEdicao := TGerenciaItegerPermiteEdicao.Create;
  Try
    GerenciaItegerPermiteEdicao.pSetaEmpresa(VS_StrCodEmp, '');

    pIncluiParametro('CODITE', 'Código do Item');
    pIncluiParametro('DESITE', 'Descrição');
    pIncluiParametro('DESSIM', 'Descrição Simplificada');
    pIncluiParametro('DESFAB', 'Descrição do Fabricante');
    pIncluiParametro('DIFICM', 'Diferimento de ICMS na Entrada');
    pIncluiParametro('MSGLV1', 'Mensagem Livre 1');
    pIncluiParametro('MSGLV2', 'Mensagem Livre 2');

    pIncluiParametro('REFERE', 'Referência');
    pIncluiParametro('CODBAR', 'Código de Barras');
    pIncluiParametro('ITEATI', 'Ativo / Inativo');
    pIncluiParametro('GRAMAR', 'Produto mármore / granito?',  fCfgSis('MARMOR', varBoolean));
    pIncluiParametro('EXPPOK', 'Exporta Tablet');

    pIncluiParametro('IMPDIR', 'Importação Direta', fCfgSis('IMPDIR', varBoolean));
    pIncluiParametro('USAPPF', 'Utiliza Pauta Fiscal?', fCfgSis('USA_PF', varBoolean));

    pIncluiParametro('BARPRV', 'Código de Barras/Qtd. Principal de Vendas');
    pIncluiParametro('BARPRC', 'Código de Barras/Qtd. Principal de Compras');

    pIncluiParametro('SALDOS', 'Saldos');
    pIncluiParametro('ABFPIS', 'Abreviação PIS');
    pIncluiParametro('ABFCOF', 'Abreviação COFINS');
    pIncluiParametro('ABFIPI', 'Abreviação IPI');
    pIncluiParametro('CLAIPI', 'NCM / Classificação do IPI');
    pIncluiParametro('PER_CI', 'Percentual (CI)');
    pIncluiParametro('PIMPTC', 'Percentual de Imposto de Importação');
    pIncluiParametro('NUMFCI', 'nº Ficha(FCI)');
    pIncluiParametro('CODUNI', 'Unidade');
    pIncluiParametro('CODMAR', 'Marca');
    pIncluiParametro('CODFOR', 'Fornecedor');
    pIncluiParametro('CODDEP', 'Departamento');
    pIncluiParametro('DIAFOR', 'Dias para Entrega do Fornecedor');
    pIncluiParametro('OBRCPF', 'Venda com obrigatoriedade CPF/CNPJ?');
    pIncluiParametro('OBRIBA', 'Venda com obrigatoriedade Cód Ibama?');
    pIncluiParametro('SITPRO', 'Situação do Produto');
    pIncluiParametro('DTAVAL', 'Data de Validade De Preço da tabela do Fornecedor', fCfgSis('VALFOR', VarBoolean));
    pIncluiParametro('PESOBR', 'Controlar Pesagem obrigatória(Saída)?', fCfgSis('PESOBR', varBoolean));

    pIncluiParametro('DTAEPI', 'Data Validade Certificado EPI');

    blnPreMat := fCampoTabela('EMP_PREMAT','CADEMP',['EMP_CODEMP'],[VS_strCodEmp]) = 'S';

    If VS_strCodEmp = fCfgSis('EMPMAT') Then
      blnPreMat := False;
    blnVisibilidade :=  (Not blnPreMat) and (Not blnTABPRD);
    pIncluiParametro('IMPULT', 'Preço Última compra + Impostos', Not blnPreMat);
    pIncluiParametro('CODABF', 'Abreviação Fiscal');
    pIncluiParametro('PRECOM', 'Preço de Compra', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_PRECOM'));
    pIncluiParametro('DESF01', 'Desconto Fornecedor 1', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF01'));
    pIncluiParametro('DESF02', 'Desconto Fornecedor 2', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF02'));
    pIncluiParametro('DESF03', 'Desconto Fornecedor 3', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF03'));
    pIncluiParametro('DESF04', 'Desconto Fornecedor 4', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF04'));
    pIncluiParametro('DESF05', 'Desconto Fornecedor 5', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF05'));
    pIncluiParametro('DESF06', 'Desconto Fornecedor 6', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF06'));
    pIncluiParametro('PRELIQ', 'Preço de Compra Líquido', blnVisibilidade);
    pIncluiParametro('ICMENT', 'ICMS de Entrada',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ICMENT'));
    pIncluiParametro('SUBFED', 'Impostos Federais(-)',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_SUBFED'));
    pIncluiParametro('IPIENT', 'IPI de Entrada',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IPIENT'));
    pIncluiParametro('FREENT', 'Frete',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_FREENT'));
    pIncluiParametro('VALFRE', fCfgSis('DESVFR'),blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_VALFRE'));
    pIncluiParametro('ACRFIN', 'Acréscimo Financeiro',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ACRFIN'));
    pIncluiParametro('SUBSTI', 'Substituição',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_SUBSTI'));
    pIncluiParametro('PRECUS', 'Preço de Custo',blnVisibilidade);
    pIncluiParametro('CUSREA', 'Preço de Custo Real',blnVisibilidade);
    pIncluiParametro('DESOPE', 'Despesas Operacionais',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESOPE'));

    pIncluiParametro('MARPAD', 'Margem Padrão',fCfgSis('MARPAD') = 'S');

    pIncluiParametro('OUTVAL', fCfgSis('DOVCPP') + ' (+)',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_OUTVAL'));
    pIncluiParametro('ICMSAI', 'Icms Saída',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ICMSAI'));
    pIncluiParametro('IPISAI', 'IPI Saída',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IPISAI'));
    pIncluiParametro('DESADB', fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESADB'));
    pIncluiParametro('IMPFED', 'Impostos Federais(+)',blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IMPFED'));

    blnVisibilidade := (Not blnPreMat) And ((fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4'));

    pIncluiParametro('TCIFCU', 'TCIF', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_TCIFCU'));
    pIncluiParametro('TSCUST', 'TS', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_TSCUST'));
    pIncluiParametro('DEPICO', 'Desconto PIS/COFINS', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DEPICO'));
    pIncluiParametro('DEICMS', 'Desconto ICMS', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DEICMS'));
    pIncluiParametro('FATREG', 'Fator Regional', blnVisibilidade And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_FATREG'));

    If Not TipoOpcaoDeTrava.fOpcaoDeTravaEhPorAtividade Then
    Begin

      pIncluiParametro('MARMIN', 'Margem Mínima Vendedor Júnior', Not blnPreMat);
      pIncluiParametro('MARMMV', 'Margem Mínima Vendedor Master', Not blnPreMat);

      pIncluiParametro('MARMSG', 'Margem Mínima Sub Gerente Júnior', Not blnPreMat);
      pIncluiParametro('MARMMS', 'Margem Mínima Sub Gerente Master', Not blnPreMat);

      pIncluiParametro('MARMGE', 'Margem Mínima Gerente Júnior', Not blnPreMat);
      pIncluiParametro('MARMMG', 'Margem Mínima Gerente Master', Not blnPreMat);

    End;

    pIncluiParametro('PRAPEL', 'Desconto Referênte Rapel', fCfgSis('URAPEL', varBoolean));
    pIncluiParametro('UTIAMP', 'Aplicar legislação AMPARA?', fCfgSis('UTIAMP', varBoolean));
    pIncluiParametro('ORDSER', 'Ordem de Serviço', fCfgSis('OSPDVN', varBoolean));
    pIncluiParametro('CODGPC', 'Classificação Global do Produto GPC', fCfgSis('GS1CNP', varBoolean));


    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      blnMarIde := fCfgSis('MARIDE', VarBoolean);

      pIncluiParametro('MARID' + IntToStr(intCont), 'Margem Ideal ' + IntToStr(intCont), (VS_strTabPrc[intCont] = 'S') And (Not blnPreMat) And blnMarIde );

      pIncluiParametro('MARBR' + IntToStr(intCont), 'Margem Bruta ' + IntToStr(intCont), (Not blnPreMat) And (Not blnBloPre) And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_MARBR' + IntToStr(intCont)));
      pIncluiParametro('PREVE' + IntToStr(intCont), 'Preço de Venda ' + IntToStr(intCont), (Not blnPreMat) And (Not blnBloPre) And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_PREVE' + IntToStr(intCont)));

      pIncluiParametro('COMTB' + IntToStr(intCont), strTCOMTB + ' Tabela ' + IntToStr(intCont), (Not blnPreMat) And blnPerComTabela And  GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_COMTB' + IntToStr(intCont)));
      pIncluiParametro('PR' + IntToStr(intCont) + 'ANT', 'Preço de venda ' + IntToStr(intCont) + ' Anterior', (VS_strTabPrc[intCont] = 'S'));
    End;

    pIncluiParametro('GRUCMP', 'Grupo de Compra');
    pIncluiParametro('CODGPR', 'Grupo de Preço');
    pIncluiParametro('NVLCRI', 'Nivel de Criticidade Geral');
    pIncluiParametro('NIVCRI', 'Nível de Criticidade');
    pIncluiParametro('DTAULT', 'Data da Última Compra');
    pIncluiParametro('PREULT', 'Último preço de Compra');
    pIncluiParametro('QTDUCO', 'Quantidade Última Compra');
    pIncluiParametro('ACOOBJ', 'Acordo de Objetivos');
    pIncluiParametro('VALOBR', 'Validade Obrigatória');
    pIncluiParametro('TIPPRO', 'Tipo de Produto(SPED)');

    pIncluiParametro('CODONU', 'Classificação ONU', fCfgSis('CLAONU', varBoolean));

    pIncluiParametro('CODMON', 'Montadora', fCfgSis('CADMON', varBoolean));

    pIncluiParametro('MLTCOM', 'Múltiplo de Compra');
    pIncluiParametro('MLTVEN', 'Múltiplo de Venda');
    pIncluiParametro('CODFAB', 'Código de Fábrica');
    pIncluiParametro('CPRCEN', 'Campra Centralizada');
    pIncluiParametro('ABAMLT', 'Nas Filias, Abastecer Múltiplo de Compra');
    pIncluiParametro('PESOIT', 'Peso Bruto');
    pIncluiParametro('PESLIQ', 'Peso Líquido', (fCfgSis('PESLIQ') = 'SOMA'));
    pIncluiParametro('INFLAM', 'Produto Inflamável');


    If strTCOPRO = '4' Then
      pIncluiParametro('QTPPRO', 'Pontos Por Valor', Not (Pos(strTCOPRO, '3_4_' ) <= 0))
    Else
      pIncluiParametro('QTPPRO', 'Quantidade Pontos para Profissionais',Not (Pos(strTCOPRO, '3_4_' ) <= 0));

    pIncluiParametro('OBRNFE', 'Venda Com Obrigat. NFe?');
    pIncluiParametro('NVLGIR', 'Nível de Estoque Geral');

    pIncluiParametro('PROEMB', 'Produto Embalagem', fCfgSis('TREMTA', varBoolean));

    pIncluiParametro('USAFLE', 'Gerar Flex?', fCfgSis('USAFLE', varBoolean));
    pIncluiParametro('CPESOB', 'Controlar pesagem obrigatória(Entrada)?', (fCfgSis('CPESOB', varBoolean)));

    pIncluiParametro('MESGIR', 'Qunatidade Meses para inativar', fCfgSis('ATICOM',varBoolean) );

    pIncluiParametro('LOTEPD', 'Obrigar Definir lote (WMS) em PD?', blnLotePD);
    pIncluiParametro('COMDIG', 'Comissão Digitador', fCfgSis('USADIG', varBoolean) And fCfgSis('PCMPRO') = '1');

    If (fCfgSis('OPCCOM') <> 'PPT') Then
    begin
      pIncluiParametro('COMVAR', 'Comissão Vendador Interno', fCfgSis('PCMPRO') = '1');
      pIncluiParametro('COMATA', 'Comissão Repres. Ext. Loja', fCfgSis('PCMPRO') = '1');
      pIncluiParametro('COMDIS', 'Comissão Repres. Ext. Distrib.', fCfgSis('PCMPRO') = '1');
    end;

    pIncluiParametro('COMPRO', 'Comissão Profiss.', ((fCfgSis('ORIPRO')<> '2') Or (fCfgSis('TCOPRO') <> '4')));

    pIncluiParametro('LOCFIS', 'Localização Fisica', Not (fUsaRotinaWMS And (fCfgSis('CTLEST') = '2')));
    pIncluiParametro('LOCSUP', 'Localização Super Estoque', Not (fUsaRotinaWMS And (fCfgSis('CTLEST') = '2')));
    pIncluiParametro('TAMLCF', 'Capacidade Localização física');
    pIncluiParametro('TAMLCS', 'Capacidade Localização Super Estoque');

    pIncluiParametro('CODLSE', 'Localização de Separação', fCfgSis('GRUSEP', varBoolean));

    pIncluiParametro('USAPFD', 'Produto controlado pela polícia federal');
    pIncluiParametro('USAPCV', 'Produto controlado pela polícia civil');

    pIncluiParametro('ESTMIN', 'Estoque Mínimo');
    pIncluiParametro('ESTMAX', 'Estoque Máximo');
    pIncluiParametro('MINDIG', 'Estoque Mínimo Digitado');
    pIncluiParametro('MAXDIG', 'Estoque Máximo Digitado');

    If Not TipoOpcaoDeTrava.fOpcaoDeTravaEhPorAtividade Then
    Begin

      pIncluiParametro('DESMAX', 'Desconto Máximo Vendedor Júnior');
      pIncluiParametro('DESMVM', 'Desconto Máximo Vendedor Master');

      pIncluiParametro('DESMSU', 'Desconto Máximo Sub Gerente Júnior');
      pIncluiParametro('DESMSM', 'Desconto Máximo Sub Gerente Master');

      pIncluiParametro('DESMGE', 'Desconto Máximo Gerente Júnior');
      pIncluiParametro('DESMGM', 'Desconto Máximo Gerente Master');

    End;

    pIncluiParametro('CAREST', 'Item estrutura em OR/PD/VN, carregar os itens da estrutura da seguinte forma?');

    pIncluiParametro('CDCEST', 'Código CEST');
    pIncluiParametro('CLACRM', 'Classif Oferta de Consumíveis');

    pIncluiParametro('APERET', 'Apenas Retira', fCfgSis('APERET', varBoolean));

    pIncluiParametro('APEENT', 'Apenas Entrega' , fCfgSis('APERET', varBoolean));

    pIncluiParametro('NOMECO', 'Nome do Produto - E-Commerce', (fCfgSis('MOEXSI') <> 0));
    pIncluiParametro('APLECO', 'Aplicação - E-Commerce', (fCfgSis('MOEXSI') <> 0));
    pIncluiParametro('DESECO', 'Descrição do Produto - E-Commerce', (fCfgSis('MOEXSI') <> 0));
    pIncluiParametro('EXPALT', 'Altura do Produto - E-Commerce', (fCfgSis('MOEXSI') <> 0));
    pIncluiParametro('EXPLAR', 'Largura do Produto - E-Commerce', (fCfgSis('MOEXSI') <> 0));
    pIncluiParametro('EXPPRO', 'Profundidade do Produto - E-Commerce', (fCfgSis('MOEXSI') <> 0));
    pIncluiParametro('BAREXP', 'Obrig. Cód. Barras Expedição', (fCfgSis('MOEXSI') <> 0));
    pIncluiParametro('SEPBAR', 'Obrig. Cód. Barras Sep. Coletor', (fCfgSis('MOEXSI') <> 0));
    pIncluiParametro('EXPSIT', 'Exportação para E-Commecer');

    pIncluiParametro('MINTB1', 'Quantidade Mínima Tabela de Preço 1');
    pIncluiParametro('MINTB2', 'Quantidade Mínima Tabela de Preço 2');
    pIncluiParametro('MINTB3', 'Quantidade Mínima Tabela de Preço 3');
    pIncluiParametro('MINTB4', 'Quantidade Mínima Tabela de Preço 4');
    pIncluiParametro('MINTB5', 'Quantidade Mínima Tabela de Preço 5');
    pIncluiParametro('MINTB6', 'Quantidade Mínima Tabela de Preço 6');
    pIncluiParametro('MINTB7', 'Quantidade Mínima Tabela de Preço 7');
    pIncluiParametro('UNICOM', 'Unidade de Compra', (fCfgSis('CNVEMB') = 'S'));
    pIncluiParametro('UNITRI', 'Unidade Tributária', (fCfgSis('UNITRI') = 'S'));
    pIncluiParametro('FATUTR', 'FAtor de Conversão Unidade Tributária', (fCfgSis('UNITRI') = 'S'));
    pIncluiParametro('PREMED', 'Preço Médio');
    pIncluiParametro('DTAALT', 'Data da Úlitma Alteração de Preço');
    pIncluiParametro('IMPLIS', 'Imprime Lista');
    pIncluiParametro('CODDIC', 'Código DIC', (fCadEmp('ESTADO') = 'SE'));

    pIncluiParametro('IMPETI', 'Imprime Etiqueta na Entrada de Mercadoria', fCfgSis('ENTETI', varBoolean) );

    pIncluiParametro('EXCIPI', 'Código EX Ipi');
    pIncluiParametro('DENSID', 'Densidade', (fCfgSis('UTIIND', varBoolean)));
    pIncluiParametro('APLICA', 'Aplicação');
    pIncluiParametro('DESCND', 'Aplicar desconto da condição de pagto?', (fCfgSis('DESCND', varBoolean)));
    pIncluiParametro('CRODOC', 'Produto em Cross Docking');
    pIncluiParametro('DESTAQ', 'Destaque');

    pIncluiParametro('DESCHK', 'Desobrigar conferência no check-out?', (fCfgSis('ITECFO', varBoolean) And fCfgSis('DESCHK', varBoolean)));
    pIncluiParametro('PRDGRU', 'Grupo de Produto');
    pIncluiParametro('ATICOM', 'Ativo compras');
    pIncluiParametro('USABON', 'Usa Bonificação?');
    pIncluiParametro('NOTESP', 'Divisível', Pos(fCfgSis('TIPEXP'), '3_4_') > 0 );
    pIncluiParametro('CODGRU', 'Linha/Grupo');
    pIncluiParametro('PEFUTP', 'Perm. Ent. Futura Status "Previsão de Entrega"?');
    pIncluiParametro('PEEFUT', 'Perm. Ent. Futura Status "Aguardando Cliente"?');
    pIncluiParametro('RECDEV', 'Permite Receber Devolução?');
    pIncluiParametro('PRAMIN', 'Prazo Médio Mínimo para Cálculo de Juros', fCfgSis('PRAMIN', varBoolean));
    pIncluiParametro('OBRBAR', 'Obrigatório o Código Barras na ENtrada Simplificada');
    pIncluiParametro('FATCOM', 'Digitar complemento do produto');
    pIncluiParametro('ESMIDG', 'Opção para estoque mínimo');

    if fCfgSis('MINPRO', varBoolean) Then
      pIncluiParametro('TPESTM', 'Tipo do Estoque Mínimo', True);


    pIncluiParametro('PEFFPR', 'Permitir Entrega Fuitura Status "Falta de Produto"?');

    pIncluiParametro('REAEND', 'Realizar endereçamento do produto', (fCfgSis('USACON', VarBoolean) And (fCfgSis('CONFME') = '1')));

    pIncluiParametro('RASTRE', 'Utilizar COntrole de Rastreabilidade do Produto', fUsaRotinaWMS);
    pIncluiParametro('FATCMP', 'Fator de Conversão Madeira de m³ para peças', fCfgSis('VENMAD', varBoolean) and fCfgSis('M3PPCA', varBoolean) );
    pIncluiParametro('FATPM3', 'Fator de conversão Madeira de Peças para M³', fCfgSis('VENMAD', varBoolean) and fCfgSis('PCAPM3', varBoolean) );

    blnVisibilidade := fCfgSis('VENVID', varBoolean);

    pIncluiParametro('LARVID', 'Largura', blnVisibilidade);
    pIncluiParametro('ALTVID', 'Altura', blnVisibilidade);
    pIncluiParametro('LAMAVI', fRetornaInfMedVIDRO(False,False,True,False)+ ' (Venda Parcial)', blnVisibilidade);
    pIncluiParametro('ALMAVI', fRetornaInfMedVIDRO, blnVisibilidade);


    blnVisibilidade := (Pos(fCadEmp('ESTADO'), ESTADOS_REGRA_ZONA_FRANCA ) > 0) And ((fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4'));
    pIncluiParametro('CICMDE', 'Calcular ICMS Desonerado?', blnVisibilidade);
    pIncluiParametro('CDPIOP', 'Considerar desconto de PIS/COFINS na base de cálculo do ICMS Operações Próprias?', blnVisibilidade);
    pIncluiParametro('DIDIOP', 'Considerar Descont de ICMS Desonerado na base de Cálculo do ICMS Operações Próprias?', blnVisibilidade);

    pIncluiParametro('PERVDA', 'Permitir venda para');

    blnVisibilidade := fCfgSis('GARANT', varBoolean);
    pIncluiParametro('RSPGAR', 'Responsável pela Garantia', blnVisibilidade);
    pIncluiParametro('TMPGAR', 'Tempo de Garantia', blnVisibilidade);
    pIncluiParametro('INFGAR', 'Informações Garantia', blnVisibilidade);


    pIncluiParametro('EMPCAR', 'Emp. resp. carregamento e entrega do item', fCfgSis('EMPCAR', varBoolean));
    pIncluiParametro('EMPSUG', 'Sugestão para empresa multi-loja no faturamento', (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)));

    blnVisibilidade := (fCfgSis('FRETRA') = '3');
    pIncluiParametro('TIPFRE', 'Tipo de Frete', blnVisibilidade);
    pIncluiParametro('VLCFRE', 'Frete de Saída', blnVisibilidade);

    If fCfgSis('OPCCOM', varString) = 'VT' Then
    Begin
      pIncluiParametro('VENINT', 'Com. Ven. Interno');
      pIncluiParametro('VENEXT', 'Com. Ven. Externo');
    End;

    if blnUtilizaChecklistGarantia then
    begin
      pIncluiParametro('CODATC', 'Assistência Técnica');
      pIncluiParametro('CKLGAR', 'Checklist Garantia Mercadoria');
      pIncluiParametro('CKLTRO', 'Checklist Troca Mercadoria');
    end;
    pIncluiParametro('DTAUAP', 'Data Última Atualização do Produto');
    pIncluiParametro('SEPEXC', 'Item de Separação Exclusiva', fCfgSis('SEPEXC', varBoolean));

    pIncluiParametro('SOBENC', 'Sob encomenda?', True);

    if fCfgSis('UTPEST', varBoolean) then
    begin
      pIncluiParametro('QTDPES', 'Qtde mín. estoque para ponta de estoque', fCfgSis('UTPEST', varBoolean));
      pIncluiParametro('PORPES', '% de desconto aplicado para ponta de estoque', fCfgSis('UTPEST', varBoolean));
    end;

    If fCfgSis('UTIABA', varBoolean) Then
      pIncluiParametro('MLTRCA', 'Múltiplo na rotina Citel Abastece?', True);

    If fCfgSis('ETIDCE', varBoolean) Then
      pIncluiParametro('NECEXP', 'Sem necessidade de expedição', True);

    If fCfgSis('LOCRET', varBoolean) Then
      pIncluiParametro('TIPRET', 'Tipo de Retirada', True);


    If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
    Begin
      pIncluiParametro('NFEIDP', 'NFe, Imprimir o lote na descrição do produto?', True);
      pIncluiParametro('NFCIDP', 'NFCe, Imprimir o lote na descrição do produto?', True);
    End;

    If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
      pIncluiParametro('LOTRAP', 'Obrigar a digitar o número do lote no Cadastro Rápido?', True);

    pIncluiParametro('TRITTE', 'Permitir utilizar em Transferência de Estoque?', fCfgSis('TRITTE', varBoolean));

    pIncluiParametro('ITEBAS', 'Produto Base', True);

    pIncluiParametro('CLBPIN', 'Permite pontuar no Clube do Pintor', fCfgSis('CDPHAB', varBoolean));

    If blnUsaBef Then
      pIncluiParametro('USABEF', 'Possui Benefício Fiscal', True);

    cdsParametros.Filtered := False;
    cdsParametros.Filter := 'VISIVEL = 1';
    cdsParametros.Filtered := True;

    cdsParametros.First;
  Finally
    cdsParametros.EnableControls;
    FreeAndNil(GerenciaItegerPermiteEdicao);
  End;
End;

function TfrmAltPrecoIndividual.fCampoMarcado(strCampo: String): Boolean;
begin
  Result := False;
  If cdsParametros.Locate('CAMPO', strCampo, []) Then
    Result := cdsParametros.FieldByName('MARCADO').AsBoolean
//  Else
//    pMensagemOk('Não encontrei o campo ' + strCampo);
end;


procedure TfrmAltPrecoIndividual.pCampoMarcaDesmarca(strCampo: String; blnMarca: Boolean);
begin
  If cdsParametros.Locate('CAMPO', strCampo, []) Then
  Begin
    cdsParametros.Edit;
    cdsParametros.FieldByName('MARCADO').AsBoolean := blnMarca;
    cdsParametros.Post;
  End;
end;

function TfrmAltPrecoIndividual.fCampoVisivel(strCampo: String): Boolean;
begin
  Result :=  cdsParametros.Locate('CAMPO', strCampo, []);
End;

function TfrmAltPrecoIndividual.fCampoRetDescriParamtro(strCampo: String): String;
begin
  If cdsParametros.Locate('CAMPO', strCampo, []) Then
    Result := cdsParametrosDESCRI.AsString;
End;

procedure TfrmAltPrecoIndividual.pValidaDescontoMaximoOperador(Dataset : TDataset);
var
  objValidaHierarquia : TValidaHierarquia;
  recResultado        : TResultado;
  intCont             : Integer;
begin

  objValidaHierarquia := TValidaHierarquia.Create(Self);

  Try

    If Not blnIteTbp Then
    Begin

      objValidaHierarquia.pSetVendedorJunior(Dataset.FieldByName('ITE_DESMAX_NOV').AsFloat);
      objValidaHierarquia.pSetVendedorMaster(Dataset.FieldByName('ITE_DESMVM_NOV').AsFloat);
      objValidaHierarquia.pSetSubGerenJunior(Dataset.FieldByName('ITE_DESMSU_NOV').AsFloat);
      objValidaHierarquia.pSetSubGerenMaster(Dataset.FieldByName('ITE_DESMSM_NOV').AsFloat);
      objValidaHierarquia.pSetGerente_Junior(Dataset.FieldByName('ITE_DESMGE_NOV').AsFloat);
      objValidaHierarquia.pSetGerente_Master(Dataset.FieldByName('ITE_DESMGM_NOV').AsFloat);

      recResultado := objValidaHierarquia.fValidarDescontoMaximoOperador;

      If recResultado.TemInconsistencia Then
      Begin
        fMensagem('ATENÇÃO!', recResultado.Mensagem, ['&Ok']);
        Abort;
      End;

    End
    Else
    Begin

      For intCont := 1 To Length(VS_strTabPrc) Do
      Begin

        objValidaHierarquia.pLimpar;
        objValidaHierarquia.pSetVendedorJunior(Dataset.FieldByName('ITE_DESMA' + intToStr(intCont) + '_NOV').Value);
        objValidaHierarquia.pSetVendedorMaster(Dataset.FieldByName('ITE_DESVM' + intToStr(intCont) + '_NOV').Value);
        objValidaHierarquia.pSetSubGerenJunior(Dataset.FieldByName('ITE_DESMS' + intToStr(intCont) + '_NOV').Value);
        objValidaHierarquia.pSetSubGerenMaster(Dataset.FieldByName('ITE_DESSM' + intToStr(intCont) + '_NOV').Value);
        objValidaHierarquia.pSetGerente_Junior(Dataset.FieldByName('ITE_DESMG' + intToStr(intCont) + '_NOV').Value);
        objValidaHierarquia.pSetGerente_Master(Dataset.FieldByName('ITE_DESGM' + intToStr(intCont) + '_NOV').Value);

        recResultado := objValidaHierarquia.fValidarDescontoMaximoOperador;

        If recResultado.TemInconsistencia Then
        Begin
          fMensagem('ATENÇÃO!', recResultado.Mensagem, ['&Ok']);
          Abort;
        End;

      End;

    End;

  Finally
    FreeAndNil(objValidaHierarquia);
  End;

End;

procedure TfrmAltPrecoIndividual.pValidaMargemMinimaOperador(Dataset : TDataset);
var
  objValidaHierarquia : TValidaHierarquia;
  recResultado        : TResultado;
begin
  If Not Assigned(FrameAlteraPrecoIndividual.cxvTiposAlt.FindItemByName('ITE_MARMIN_NOV')) Then
    Exit;

  objValidaHierarquia := TValidaHierarquia.Create(Self);

  Try

    objValidaHierarquia.pSetVendedorJunior(Dataset.FieldByName('ITE_MARMIN_NOV').Value);
    objValidaHierarquia.pSetVendedorMaster(Dataset.FieldByName('ITE_MARMMV_NOV').Value);
    objValidaHierarquia.pSetSubGerenJunior(Dataset.FieldByName('ITE_MARMSG_NOV').Value);
    objValidaHierarquia.pSetSubGerenMaster(Dataset.FieldByName('ITE_MARMMS_NOV').Value);
    objValidaHierarquia.pSetGerente_Junior(Dataset.FieldByName('ITE_MARMGE_NOV').Value);
    objValidaHierarquia.pSetGerente_Master(Dataset.FieldByName('ITE_MARMMG_NOV').Value);

    recResultado := objValidaHierarquia.fValidarMargemMinimaOperador;

    If recResultado.TemInconsistencia Then
    Begin
      fMensagem('ATENÇÃO!', recResultado.Mensagem, ['&Ok']);
      Abort;
    End;

  Finally
    FreeAndNil(objValidaHierarquia);
  End;
End;

function TfrmAltPrecoIndividual.fFormatarCampo(objCampo: TField): Variant;
Begin
  Result := objCampo.Text;

  if objCampo.IsNull then
    Exit(objCampo.Value);

  case objCampo.DataType of
    ftTime: Result := FormatDateTime('HH:NN', objCampo.AsVariant);
    ftDate: Result := FormatDateTime('DD/MM/YYYY', objCampo.AsVariant);
    ftDateTime: Result := FormatDateTime('DD/MM/YYYY HH:NN', objCampo.AsDateTime);
  end;
End;

function TfrmAltPrecoIndividual.fGenIte(strCodIte: String): TUniQuery;
Begin
  Result := fCriaQuery(Self);
  Result.SQL.Add(fRetornaSQLPrecoIndividual);
  Result.SQL.Add('WHERE I.ITE_CODITE = :CODITE');
  Result.SQL.Add('GROUP BY G.ITE_CODITE');
  Result.SQL.Add('ORDER BY ITE_DESITE');
  Result.ParamByName('CODITE').AsString := strCodIte;
  Result.ParamByName('CODEMP').AsString := VS_strCodEmp;
  If Result.FindParam('ESTADO') <> Nil Then
    Result.ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
  Result.Open;
  Result.Active := Not Result.IsEmpty;
End;

function TfrmAltPrecoIndividual.fGeraArquivoAux(
  pgbProgresso: TcxProgressBar): Boolean;
var
  aFile : TStringList;
  Campo: TCampo;
  strLinha: String;
begin
  aFile := TStringList.Create;
  Result := True;
  Try
//    aFile.DefaultEncoding := TEncoding.ASCII;
    strFileExcel :=  ChangeFileExt(strFileExcel, '.csv');
    DeleteFile(strFileExcel);
    dtsGen.DataSet.First;
    strLinha := '';
    for Campo in arrCampos do
      If Campo.Visible Then
        strLinha := strLinha + Campo.Title+ ';';

    aFile.Add(strLinha);
    pgbProgresso.Properties.Max := dtsGen.DataSet.RecordCount- 1;
    while not dtsGen.DataSet.Eof do
    Begin
      strLinha := '';
      for Campo in arrCampos do
        If Campo.Visible Then
          strLinha := strLinha + fRemoveQuebra(dtsGen.DataSet.FieldByName(Campo.FieldName).AsString) + ';';
      aFile.Add(strLinha);
      Application.ProcessMessages;
      pgbProgresso.Position := dtsGen.DataSet.recNo;

      dtsGen.DataSet.Next;
    End;
    aFile.SaveToFile(strFileExcel);
  Finally
    FreeAndNil(aFile);
  End;


end;

procedure TfrmAltPrecoIndividual.pInserirLog(strCodIte, strNomCam: String; objCampo, objCampoNovo: TField);
Var
   qryLogCpr: TUniQuery;
Begin
  qryLogCpr := fCriaQuery(Self);
  Try
    qryLogCpr.Close;
    qryLogCpr.SQL.Clear;
    qryLogCpr.SQL.Add(fSQLLogCpr);
    qryLogCpr.ParamByName('CODITE').AsString := strCodIte;
    qryLogCpr.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryLogCpr.ParamByName('DTAALT').AsDateTime := VS_Date;
    qryLogCpr.ParamByName('HORALT').AsDateTime := fTime();
    qryLogCpr.ParamByName('EMPLOG').AsString := VS_strCodEmp;
    qryLogCpr.ParamByName('EMPFIS').AsString := fRetEmpresaFisica;
    qryLogCpr.ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGCPR', VS_strCodEmp);
    qryLogCpr.ParamByName('NOMCAM').AsString := strNomCam;
    qryLogCpr.ParamByName('VALANT').Value := fFormatarCampo(objCampo);
    qryLogCpr.ParamByName('VALPOS').Value := fFormatarCampo(objCampoNovo);
    qryLogCpr.ExecSQL;
  Finally
    FreeAndNil(qryLogCpr);
  End;
End;

function TfrmAltPrecoIndividual.fRetornaSQLPrecoIndividual(Campos: String = ''): String;
Var
  strSQL: String;
  intContador,
  intCorre: Integer;
Begin
  strSQL := strSQL + 'SELECT ';

  If (Not fEmptyStr(edtDocumento.Text)) Then
    strSQL := strSQL + ' DISTINCT ';


  If Campos = '' Then
  Begin
    strSQL := strSQL + '  I.ITE_CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESSIM, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_DIFICM, ';
    strSQL := strSQL + '  I.ITE_MSGLV1, ';
    strSQL := strSQL + '  I.ITE_MSGLV2, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_DTAULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
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
    strSQL := strSQL + '  GRU_DESGRU AS GRU_DESGRU_NOV, ';
    strSQL := strSQL + '  GRU_DESGRU, ';

    strSQL := strSQL + '  I.ITE_TIPFRE AS "ITE_TIPFRE_NOV", ';
    strSQL := strSQL + '  I.ITE_TIPFRE, ';
    strSQL := strSQL + '  G.ITE_ESMIDG AS "ITE_ESMIDG_NOV", ';
    strSQL := strSQL + '  G.ITE_ESMIDG, ';

    if fCfgSis('MINPRO', varBoolean) Then
    Begin
      strSQL := strSQL + ' G.ITE_TPESTM AS "ITE_TPESTM_NOV", ';
      strSQL := strSQL + ' G.ITE_TPESTM, ';
    End;

    strSQL := strSQL + '  I.ITE_VLCFRE AS "ITE_VLCFRE_NOV", ';
    strSQL := strSQL + '  I.ITE_VLCFRE, ';
    strSQL := strSQL + '  I.ITE_CLAIPI AS "ITE_CLAIPI_NOV", '; //Classificação de IPI
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_EXCIPI AS "ITE_EXCIPI_NOV", '; //Código EX IPI
    strSQL := strSQL + '  I.ITE_EXCIPI, ';

    strSQL := strSQL + '  I.ITE_GRUCMP AS "ITE_GRUCMP_NOV", '; //
    strSQL := strSQL + '  I.ITE_GRUCMP, ';
    strSQL := strSQL + '  GRU_DESCRI AS "GRU_DESCRI_NOV", '; //
    strSQL := strSQL + '  GRU_DESCRI, ';

    strSQL := strSQL + '  I.ITE_CODGPR AS "ITE_CODGPR_NOV", '; //
    strSQL := strSQL + '  I.ITE_CODGPR, ';
    strSQL := strSQL + '  GPR_DESCRI AS "GPR_DESCRI_NOV", '; //
    strSQL := strSQL + '  GPR_DESCRI, ';

    strSQL := strSQL + '  G.ITE_RECDEV AS "ITE_RECDEV_NOV", '; // Recebe Devolução
    strSQL := strSQL + '  G.ITE_RECDEV, ';

    strSQL := strSQL + '  I.ITE_CDCEST AS "ITE_CDCEST_NOV", '; //Código CEST
    strSQL := strSQL + '  I.ITE_CDCEST, ';
    strSQL := strSQL + '  CONVERT(CES_DESCRI, CHAR(255)) AS "CES_DESCRI_NOV", '; //Código CEST
    strSQL := strSQL + '  CONVERT(CES_DESCRI, CHAR(255)) AS CES_DESCRI, ';


    strSQL := strSQL + '  REPLACE(I.ITE_APLICA, "<<csq>>", "\n") AS "ITE_APLICA_NOV", ';
    strSQL := strSQL + '  REPLACE(I.ITE_APLICA, "<<csq>>", "\n") AS ITE_APLICA,         ';

    strSQL := strSQL + '  I.ITE_PER_CI AS "ITE_PER_CI_NOV", ';
    strSQL := strSQL + '  I.ITE_PER_CI, ';

    strSQL := strSQL + '  I.ITE_PIMPTC AS "ITE_PIMPTC_NOV", ';
    strSQL := strSQL + '  I.ITE_PIMPTC, ';

    strSQL := strSQL + '  I.ITE_NUMFCI AS "ITE_NUMFCI_NOV", ';
    strSQL := strSQL + '  I.ITE_NUMFCI, ';
    strSQL := strSQL + '  G.ITE_PRECOM AS "ITE_PRECOM_NOV", '; //Preço de compra
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS "ITE_PREVE1_NOV", '; //Preço de Venda 1
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  0.0 AS "ITE_PREVE1_VAR", ';
    strSQL := strSQL + '  G.ITE_PREVE2 AS "ITE_PREVE2_NOV", '; //Preço de Venda 2
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  0.0 AS "ITE_PREVE2_VAR", ';
    strSQL := strSQL + '  G.ITE_PREVE3 AS "ITE_PREVE3_NOV", '; //Preço de Venda 3
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  0.0 AS "ITE_PREVE3_VAR", ';
    strSQL := strSQL + '  G.ITE_PREVE4 AS "ITE_PREVE4_NOV", '; //Preço de Venda 4
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  0.0 AS "ITE_PREVE4_VAR", ';
    strSQL := strSQL + '  G.ITE_PREVE5 AS "ITE_PREVE5_NOV", '; //Preço de Venda 5
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  0.0 AS "ITE_PREVE5_VAR", ';
    strSQL := strSQL + '  G.ITE_PREVE6 AS "ITE_PREVE6_NOV", '; //Preço de Venda 6
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  0.0 AS "ITE_PREVE6_VAR", ';
    strSQL := strSQL + '  G.ITE_PREVE7 AS "ITE_PREVE7_NOV", '; //Preço de Venda 7
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  0.0 AS "ITE_PREVE7_VAR", ';
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
    strSQL := strSQL + '  G.ITE_TCIFCU AS "ITE_TCIFCU_NOV", '; //% TCIF (+)
    strSQL := strSQL + '  G.ITE_TCIFCU, ';
    strSQL := strSQL + '  G.ITE_TSCUST AS "ITE_TSCUST_NOV", '; //% TS (+)
    strSQL := strSQL + '  G.ITE_TSCUST, ';
    strSQL := strSQL + '  G.ITE_DEPICO AS "ITE_DEPICO_NOV", '; //% Desconto PIS/COFINS (-)
    strSQL := strSQL + '  G.ITE_DEPICO, ';
    strSQL := strSQL + '  G.ITE_DEICMS AS "ITE_DEICMS_NOV", '; //% Desconto ICMS (-)
    strSQL := strSQL + '  G.ITE_DEICMS, ';
    strSQL := strSQL + '  G.ITE_FATREG AS "ITE_FATREG_NOV", '; //% Fator Regional (+)
    strSQL := strSQL + '  G.ITE_FATREG, ';

    if not blnIteTbp Then
      Begin
        strSQL := strSQL + '  IFNULL(G.ITE_DESMAX,0) AS "ITE_DESMAX_NOV", '; //% Desc.Maximo Júnior
        strSQL := strSQL + '  IFNULL(G.ITE_DESMAX,0) AS "ITE_DESMAX", ';
        strSQL := strSQL + '  IFNULL(G.ITE_DESMGE,0) AS "ITE_DESMGE_NOV", '; //% Desc.Maximo Gerente Júnior
        strSQL := strSQL + '  IFNULL(G.ITE_DESMGE,0) AS "ITE_DESMGE", ';
        strSQL := strSQL + '  IFNULL(G.ITE_DESMSU,0) AS "ITE_DESMSU_NOV", '; //% Desc.Maximo Sub-Gerente Júnior
        strSQL := strSQL + '  IFNULL(G.ITE_DESMSU,0) AS "ITE_DESMSU", ';

        strSQL := strSQL + '  IFNULL(G.ITE_DESMVM,0) AS "ITE_DESMVM_NOV", '; //% Desc.Maximo Master
        strSQL := strSQL + '  IFNULL(G.ITE_DESMVM,0) AS "ITE_DESMVM", ';
        strSQL := strSQL + '  IFNULL(G.ITE_DESMGM,0) AS "ITE_DESMGM_NOV", '; //% Desc.Maximo Gerente Master
        strSQL := strSQL + '  IFNULL(G.ITE_DESMGM,0) AS "ITE_DESMGM", ';
        strSQL := strSQL + '  IFNULL(G.ITE_DESMSM,0) AS "ITE_DESMSM_NOV", '; //% Desc.Maximo Sub-Gerente Master
        strSQL := strSQL + '  IFNULL(G.ITE_DESMSM,0) AS "ITE_DESMGM", ';
      End
      Else
      Begin
      For intCorre := 1 To Length(VS_strTabPrc) Do
        strSQL := strSQL + fAddIteTbp(intCorre);

    End;

    If (fCfgSis('OPCCOM') <> 'PPT') Then
    begin
      strSQL := strSQL + '  G.ITE_COMVAR AS "ITE_COMVAR_NOV", '; //% Comis.Vendedor Interno
      strSQL := strSQL + '  G.ITE_COMVAR, ';
      strSQL := strSQL + '  G.ITE_COMATA AS "ITE_COMATA_NOV", '; //% Comis. Repres. Ext. Loja
      strSQL := strSQL + '  G.ITE_COMATA, ';
      strSQL := strSQL + '  G.ITE_COMDIS AS "ITE_COMDIS_NOV", '; //% Comis. Repres. Ext. Distribuidor
      strSQL := strSQL + '  G.ITE_COMDIS, ';
    end;
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

    if fCfgSis('NFEPEP', varBoolean) then
    begin
      strSQL := strSQL + '  G.ITE_OBRNFE AS "ITE_OBRNFE_NOV", '; //Venda c/ obrigat. NFe
      strSQL := strSQL + '  G.ITE_OBRNFE, ';
    end
    else
    begin
      strSQL := strSQL + '  I.ITE_OBRNFE AS "ITE_OBRNFE_NOV", '; //Venda c/ obrigat. NFe
      strSQL := strSQL + '  I.ITE_OBRNFE, ';
    end;

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
    strSQL := strSQL + '  ABF_DESABF AS "ABF_DESABF_NOV", '; //Abrev. Fiscal
    strSQL := strSQL + '  ABF_DESABF, ';


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

    strSQL := strSQL + '  PIS.APC_DESCRI AS "APC_DESPIS_NOV", '; //Abrev. PIS
    strSQL := strSQL + '  PIS.APC_DESCRI AS "APC_DESPIS", ';
    strSQL := strSQL + '  COF.APC_DESCRI AS "APC_DESCOF_NOV", '; //Abrev. COFINS
    strSQL := strSQL + '  COF.APC_DESCRI AS "APC_DESCOF", ';
    strSQL := strSQL + '  IPI.APC_DESCRI AS "APC_DESIPI_NOV", '; //Abrev. IPI
    strSQL := strSQL + '  IPI.APC_DESCRI AS "APC_DESIPI", ';


    strSQL := strSQL + '  I.ITE_INCPIS AS "ITE_INCPIS_NOV", '; //Incide PIS?
    strSQL := strSQL + '  I.ITE_INCPIS, ';
    strSQL := strSQL + '  I.ITE_COMLUB AS "ITE_COMLUB_NOV", '; //Combustível/Lubrificante?
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  G.ITE_IMPLIS AS "ITE_IMPLIS_NOV", '; //Imp. Lista?
    strSQL := strSQL + '  G.ITE_IMPLIS, ';
    strSQL := strSQL + '  I.ITE_ITEATI AS "ITE_ITEATI_NOV", '; //Ativo?
    strSQL := strSQL + '  I.ITE_ITEATI, ';

    strSQL := strSQL + '  I.ITE_GRAMAR AS "ITE_GRAMAR_NOV", '; //Ativo?
    strSQL := strSQL + '  I.ITE_GRAMAR, ';

    strSQL := strSQL + '  B.BAR_CODBAR AS "ITE_BARPRI", ';
    strSQL := strSQL + '  B.BAR_CODBAR AS "ITE_BARPRV", ';
    strSQL := strSQL + '  B.BAR_EMBALA AS "ITE_EMBPRV", ';
    strSQL := strSQL + '  B.BAR_EMBALA AS "ITE_EMBPRI", ';

    strSQL := strSQL + '  E.BAR_CODBAR AS "ITE_BARPRP", ';
    strSQL := strSQL + '  E.BAR_CODBAR AS "ITE_BARPRC", ';
    strSQL := strSQL + '  E.BAR_EMBALA AS "ITE_EMBPRC", ';
    strSQL := strSQL + '  E.BAR_EMBALA AS "ITE_EMBPRP", ';

    strSQL := strSQL + '  I.ITE_EXPPOK AS "ITE_EXPPOK_NOV", '; //Exporta Tablet?
    strSQL := strSQL + '  I.ITE_EXPPOK, ';

    If fCfgSIs('IMPDIG') = '1' Then
    Begin
      strSQL := strSQL + '  I.ITE_IMPDIR AS "ITE_IMPDIR_NOV", '; //Importação Direta
      strSQL := strSQL + '  I.ITE_IMPDIR, ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_IMPDIR AS "ITE_IMPDIR_NOV", '; //Abrev. Fiscal
      strSQL := strSQL + '  G.ITE_IMPDIR, ';
    End;

    If fCfgSIs('TIPABF') = '1' Then
    Begin
      strSQL := strSQL + '  I.ITE_USAPPF AS "ITE_USAPPF_NOV", ';
      strSQL := strSQL + '  I.ITE_USAPPF, ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_USAPPF AS "ITE_USAPPF_NOV", ';
      strSQL := strSQL + '  G.ITE_USAPPF, ';
    End;

    strSQL := strSQL + '  G.ITE_LOCFIS AS "ITE_LOCFIS_NOV", '; //Local. Fisica
    strSQL := strSQL + '  G.ITE_LOCFIS, ';
    strSQL := strSQL + '  G.ITE_ESTMAX AS "ITE_ESTMAX_NOV", '; //Estoque Máximo
    strSQL := strSQL + '  G.ITE_ESTMAX, ';
    strSQL := strSQL + '  G.ITE_ESTMIN AS "ITE_ESTMIN_NOV", '; //Estoque Mínimo
    strSQL := strSQL + '  G.ITE_ESTMIN, ';
    strSQL := strSQL + '  G.ITE_MAXDIG AS "ITE_MAXDIG_NOV",  ';
    strSQL := strSQL + '  G.ITE_MAXDIG,  ';
    strSQL := strSQL + '  G.ITE_MINDIG AS "ITE_MINDIG_NOV",  ';
    strSQL := strSQL + '  G.ITE_MINDIG,  ';
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
    strSQL := strSQL + '  0.0 AS "ITE_PRECUS_VAR", ';

    strSQL := strSQL + ' IF((1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100) <> 0, ';
    strSQL := strSQL + '     ((IFNULL(G.ITE_PRECUS, 0) + IFNULL(G.ITE_OUTVAL, 0)) / (1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100)), 0) AS ITE_CUSREA_NOV, ';

    strSQL := strSQL + ' IF((1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100) <> 0, ';
      strSQL := strSQL + '     ((IFNULL(G.ITE_PRECUS, 0) + IFNULL(G.ITE_OUTVAL, 0)) / (1 - (IFNULL(G.ITE_ICMSAI, 0) + IFNULL(G.ITE_IMPFED, 0) + IFNULL(G.ITE_DESOPE, 0))/100)), 0) AS ITE_CUSREA, ';

      strSQL := strSQL + '  G.ITE_CODEMP, ';
      strSQL := strSQL + '  IFNULL(G.ITE_MARMIN,0) AS "ITE_MARMIN_NOV", '; //Margem Mínima Vendedor Júnior
      strSQL := strSQL + '  IFNULL(G.ITE_MARMIN,0) AS "ITE_MARMIN", ';
      strSQL := strSQL + '  IFNULL(G.ITE_MARMSG,0) AS "ITE_MARMSG_NOV", '; //Margem Mínima Sub Gerente Júnior
      strSQL := strSQL + '  IFNULL(G.ITE_MARMSG,0) AS "ITE_MARMSG", ';
      strSQL := strSQL + '  IFNULL(G.ITE_MARMGE,0) AS "ITE_MARMGE_NOV", '; //Margem Mínima Gerente Júnior
      strSQL := strSQL + '  IFNULL(G.ITE_MARMGE,0) AS "ITE_MARMGE", ';

      strSQL := strSQL + '  IFNULL(G.ITE_MARMMV,0) AS "ITE_MARMMV_NOV", '; //Margem Mínima Vendedor Master
      strSQL := strSQL + '  IFNULL(G.ITE_MARMMV,0) AS "ITE_MARMMV", ';
      strSQL := strSQL + '  IFNULL(G.ITE_MARMMS,0) AS "ITE_MARMMS_NOV", '; //Margem Mínima Sub Gerente Master
      strSQL := strSQL + '  IFNULL(G.ITE_MARMMS,0) AS "ITE_MARMMS", ';
      strSQL := strSQL + '  IFNULL(G.ITE_MARMMG,0) AS "ITE_MARMMG_NOV", '; //Margem Mínima Gerente Master
      strSQL := strSQL + '  IFNULL(G.ITE_MARMMG,0) AS "ITE_MARMMG", ';

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
    strSQL := strSQL + '  I.ITE_RSPGAR AS "ITE_RSPGAR_NOV", '; //Responsável pela Garantia
    strSQL := strSQL + '  I.ITE_RSPGAR, ';
    strSQL := strSQL + '  I.ITE_EMBALA AS "ITE_EMBALA_NOV", '; //Embalagem
    strSQL := strSQL + '  I.ITE_EMBALA, ';
    strSQL := strSQL + '  I.ITE_BAREMB AS "ITE_BAREMB_NOV", '; //Código de barras Embalagem
    strSQL := strSQL + '  I.ITE_BAREMB, ';
    strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI_NOV", '; //Unidade
    strSQL := strSQL + '  I.ITE_CODUNI, ';
    strSQL := strSQL + '  UNI_DESUNI AS "UNI_DESUNI_NOV", '; //
    strSQL := strSQL + '  UNI_DESUNI, ';

    strSQL := strSQL + '  G.ITE_TIPPRO AS "ITE_TIPPRO_NOV", '; //Tipo do produto
    strSQL := strSQL + '  G.ITE_TIPPRO, ';
    strSQL := strSQL + '  I.ITE_UNICOM AS "ITE_UNICOM_NOV", '; //Unidade de Compra
    strSQL := strSQL + '  I.ITE_UNICOM, ';
    strSQL := strSQL + '  I.ITE_UNITRI AS "ITE_UNITRI_NOV", '; //Unidade de Compra
    strSQL := strSQL + '  I.ITE_UNITRI, ';
    strSQL := strSQL + '  I.ITE_FATUTR AS "ITE_FATUTR_NOV", '; //Unidade de Compra
    strSQL := strSQL + '  I.ITE_FATUTR, ';
    strSQL := strSQL + '  I.ITE_CODMAR AS "ITE_CODMAR_NOV", '; //Marca
    strSQL := strSQL + '  I.ITE_CODMAR, ';

    strSQL := strSQL + '  MAR_DESMAR AS "MAR_DESMAR_NOV", '; //Marca
    strSQL := strSQL + '  MAR_DESMAR, ';

    strSQL := strSQL + '  I.ITE_USAPFD, ';
    strSQL := strSQL + '  I.ITE_USAPFD AS "I.ITE_USAPFD_NOV", ';
    strSQL := strSQL + '  I.ITE_USAPCV, ';
    strSQL := strSQL + '  I.ITE_USAPCV AS "I.ITE_USAPCV_NOV", ';

    strSQL := strSQL + '  G.ITE_SITPRO AS "ITE_SITPRO_NOV", '; //Situação do Produto
    strSQL := strSQL + '  G.ITE_SITPRO, ';
    strSQL := strSQL + '  SIT_DESCRI AS "SIT_DESCRI_NOV", '; //Situação do Produto
    strSQL := strSQL + '  SIT_DESCRI, ';

      strSQL := strSQL + '  G.ITE_DTAVAL AS "ITE_DTAVAL_NOV", '; //Data de Validade de Preço
      strSQL := strSQL + '  G.ITE_DTAVAL, ';

    strSQL := strSQL + '  I.ITE_DTAEPI AS "ITE_DTAEPI_NOV", '; //Data de Validade de Certificado EPI
    strSQL := strSQL + '  I.ITE_DTAEPI, ';

      strSQL := strSQL + '  (SELECT GROUP_CONCAT(ITM_CODMON) FROM ITEMON WHERE ITM_CODITE = I.ITE_CODITE) AS ITE_CODMON, ';
      strSQL := strSQL + '  (SELECT GROUP_CONCAT(ITM_CODMON) FROM ITEMON WHERE ITM_CODITE = I.ITE_CODITE) AS "ITE_CODMON_NOV", '; //Montadora

  //    strSQL := strSQL + '  MON_DESCRI AS "MON_DESCRI_NOV", '; //Montadora
  //    strSQL := strSQL + '  MON_DESCRI, ';

      strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR_NOV", '; //Fornecedor
      strSQL := strSQL + '  I.ITE_CODFOR, ';
    strSQL := strSQL + '  FOR_NOMFOR AS "FOR_NOMFOR_NOV", '; //Fornecedor
    strSQL := strSQL + '  FOR_NOMFOR, ';

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

    strSQL := strSQL + '  DEP_DESCRI AS "DEP_DESCRI_NOV", '; //Departamento
    strSQL := strSQL + '  DEP_DESCRI, ';

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
    strSQL := strSQL + '  PRD_DESGRU,  ';                   // Grupo de Produto
    strSQL := strSQL + '  PRD_DESGRU AS PRD_DESGRU_NOV,  ';

    strSQL := strSQL + '  I.ITE_ATICOM,  ';                   // ATIVO COMPRAS
    strSQL := strSQL + '  I.ITE_ATICOM AS ITE_ATICOM_NOV,  ';

    strSQL := strSQL + '  I.ITE_CODDIC,  ';
    strSQL := strSQL + '  I.ITE_CODDIC AS ITE_CODDIC_NOV,  ';

    strSQL := strSQL + '  I.ITE_IMPETI,  ';
    strSQL := strSQL + '  I.ITE_IMPETI AS ITE_IMPETI_NOV,  ';

    strSQL := strSQL + ' I.ITE_PRAPEL AS ITE_PRAPEL_NOV,'; //Unidade
    strSQL := strSQL + ' I.ITE_PRAPEL,  ';


    strSQL := strSQL + '  CAST(G.ITE_PRECOM * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF01 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF02 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF03 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF04 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF05 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF06 / 100) ) AS DECIMAL(12,2)) AS ITE_PRELIQ_NOV, ';

    strSQL := strSQL + '  CAST(G.ITE_PRECOM * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF01 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF02 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF03 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF04 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF05 / 100) ) * ';
    strSQL := strSQL + '  ( 1 - (G.ITE_DESF06 / 100) ) AS DECIMAL(12,2)) AS ITE_PRELIQ, ';

    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '     MAX(ALT_DTAALT) ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + '     PREALT ';
    strSQL := strSQL + '   WHERE ';
    strSQL := strSQL + '     ALT_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '     ALT_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '  ) AS ITE_ALTPRE, ';

    strSQL := strSQL + ' I.ITE_DTAALT AS "ITE_DTAUAP", ';

    strSQL := strSQL + ' IF((SELECT COUNT(1) FROM ITEEMB ';
    strSQL := strSQL + '      WHERE ITB_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '        AND ITB_CODEMP = G.ITE_CODEMP) > 0,"Sim","Não") ';
    strSQL := strSQL + ' AS ITE_POSEMB, ';

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

    strSQL := strSQL + '  I.ITE_FATPM3,  ';
    strSQL := strSQL + '  I.ITE_FATPM3 AS ITE_FATPM3_NOV,  ';

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

    strSQL := strSQL + '  IF(I.ITE_CAREST = "I", "ITEM ESTRUTURA", "SUB-PRODUTOS") AS "ITE_PESOBR_NOV", ';
    strSQL := strSQL + '  IF(I.ITE_CAREST = "I", "ITEM ESTRUTURA", "SUB-PRODUTOS") AS ITE_CAREST, ';

    strSQL := strSQL + '  I.ITE_LOTEPD AS "ITE_LOTEPD_NOV",  ';
    strSQL := strSQL + '  I.ITE_LOTEPD,  ';

    strSQL := strSQL + '  I.ITE_ORDSER AS "ITE_ORDSER_NOV",  ';
    strSQL := strSQL + '  I.ITE_ORDSER,  ';

    strSQL := strSQL + '  I.ITE_CLACRM AS "ITE_CLACRM_NOV",  ';
    strSQL := strSQL + '  I.ITE_CLACRM,  ';

    if FPermVendaIgualTodasEmp then
    begin
      strSQL := strSQL + '  I.ITE_PERVDA AS "ITE_PERVDA_NOV",  ';
      strSQL := strSQL + '  I.ITE_PERVDA,  ';
    end
    else
    begin
      strSQL := strSQL + '  G.ITE_PEVNDA AS "ITE_PERVDA_NOV",  ';
      strSQL := strSQL + '  G.ITE_PEVNDA AS ITE_PERVDA,  ';
    end;

    strSQL := strSQL + '  G.ITE_CPESOB AS "ITE_CPESOB_NOV",  ';
    strSQL := strSQL + '  G.ITE_CPESOB,  ';

    strSQL := strSQL + '  I.ITE_DESCND AS "ITE_DESCND_NOV",  ';
    strSQL := strSQL + '  I.ITE_DESCND,  ';

    strSQL := strSQL + '  I.ITE_CODONU AS "ITE_CODONU_NOV", ';
    strSQL := strSQL + '  I.ITE_CODONU, ';

    strSQL := strSQL + '  DE.ITE_CRODOC , ';
    strSQL := strSQL + '  DE.ITE_CRODOC AS ITE_CRODOC_NOV , ';

    strSQL := strSQL + '  DE.ITE_DESTAQ,                    ';
    strSQL := strSQL + '  DE.ITE_DESTAQ AS ITE_DESTAQ_NOV,  ';

    strSQL := strSQL + '  G.ITE_DESCHK AS "ITE_DESCHK_NOV",  ';
    strSQL := strSQL + '  G.ITE_DESCHK,  ';

    If fCfgSis('MARPAD') = 'S' Then
    Begin
      strSQL := strSQL + '  G.ITE_MARPAD AS "ITE_MARPAD_NOV",  ';
      strSQL := strSQL + '  G.ITE_MARPAD,  ';
    End;

    strSQL := strSQL + '  I.ITE_ITEBAS AS "ITE_ITEBAS_NOV", '; //Base Produto
    strSQL := strSQL + '  I.ITE_ITEBAS, ';

    If blnTABPRD  then
    Begin

      For intContador := 1 To Length(VS_strTabPrc) Do
      Begin
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PREDOL, "")  AS ITE_PREDOL' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_CODABF, "")  AS ITE_CODABF' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_USAPPF, "")  AS ITE_USAPPF' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECOM, G.ITE_PRECOM)  AS ITE_PRECOM' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF01, G.ITE_DESF01)  AS ITE_DESF01' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF02, G.ITE_DESF02)  AS ITE_DESF02' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF03, G.ITE_DESF03)  AS ITE_DESF03' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF04, G.ITE_DESF04)  AS ITE_DESF04' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF05, G.ITE_DESF05)  AS ITE_DESF05' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF06, G.ITE_DESF06)  AS ITE_DESF06' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ICMENT, G.ITE_ICMENT)  AS ITE_ICMENT' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_SUBFED, G.ITE_SUBFED)  AS ITE_SUBFED' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IPIENT, G.ITE_IPIENT)  AS ITE_IPIENT' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FREENT, G.ITE_FREENT)  AS ITE_FREENT' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_VALFRE, G.ITE_VALFRE)  AS ITE_VALFRE' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ACRFIN, G.ITE_ACRFIN)  AS ITE_ACRFIN' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESADB, G.ITE_DESADB)  AS ITE_DESADB' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECUS, G.ITE_PRECUS)  AS ITE_PRECUS' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_OUTVAL, G.ITE_OUTVAL)  AS ITE_OUTVAL' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_ICMSAI, G.ITE_ICMSAI)  AS ITE_ICMSAI' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IMPFED, G.ITE_IMPFED)  AS ITE_IMPFED' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_DESOPE, G.ITE_DESOPE)  AS ITE_DESOPE' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TCIFCU, G.ITE_TCIFCU)  AS ITE_TCIFCU' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TSCUST, G.ITE_TSCUST)  AS ITE_TSCUST' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEPICO, G.ITE_DEPICO)  AS ITE_DEPICO' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEICMS, G.ITE_DEICMS)  AS ITE_DEICMS' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FATREG, G.ITE_FATREG)  AS ITE_FATREG' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.AUTOINCREM, "") AS AUTINC' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(IF' + IntToStr(intContador) + '.ITE_CNVCUS, 1)  AS ITE_CNVCUS' + IntToStr(intContador) + ',';
      End;
    End;

    strSQL := strSQL + '  G.ITE_CICMDE AS "ITE_CICMDE_NOV", ';
    strSQL := strSQL + '  G.ITE_CICMDE, ';
    strSQL := strSQL + '  G.ITE_CDPIOP AS "ITE_CDPIOP_NOV", ';
    strSQL := strSQL + '  G.ITE_CDPIOP, ';
    strSQL := strSQL + '  G.ITE_DIDIOP AS "ITE_DIDIOP_NOV", ';
    strSQL := strSQL + '  G.ITE_DIDIOP, ';

    strSQL := strSQL + '  I.ITE_CODGPC AS "ITE_CODGPC_NOV",  ';
    strSQL := strSQL + '  I.ITE_CODGPC,  ';
    strSQL := strSQL + '  GPC_DESGPC AS "ITE_DESGPC_NOV",  ';
    strSQL := strSQL + '  GPC_DESGPC,  ';

    strSQL := strSQL + '  G.ITE_APERET AS "ITE_APERET_NOV",  ';
    strSQL := strSQL + '  G.ITE_APERET,  ';

    strSQL := strSQL + '  G.ITE_APEENT AS "ITE_APEENT_NOV",  ';
    strSQL := strSQL + '  G.ITE_APEENT,  ';

    strSQL := strSQL + '  DE.ITE_NOMITE AS "ITE_NOMECO_NOV", ';
    strSQL := strSQL + '  DE.ITE_NOMITE AS "ITE_NOMECO", ';

    strSQL := strSQL + '  DE.ITE_APLITE AS "ITE_APLECO_NOV", ';
    strSQL := strSQL + '  DE.ITE_APLITE AS "ITE_APLECO", ';

    strSQL := strSQL + '  DE.ITE_DESITE AS "ITE_DESECO_NOV", ';
    strSQL := strSQL + '  DE.ITE_DESITE AS "ITE_DESECO", ';

    strSQL := strSQL + '  DE.ITE_EXPALT AS "ITE_EXPALT_NOV", ';
    strSQL := strSQL + '  DE.ITE_EXPALT AS "ITE_EXPALT", ';

    strSQL := strSQL + '  DE.ITE_EXPLAR AS "ITE_EXPLAR_NOV", ';
    strSQL := strSQL + '  DE.ITE_EXPLAR AS "ITE_EXPLAR", ';

    strSQL := strSQL + '  DE.ITE_EXPPRO AS "ITE_EXPPRO_NOV", ';
    strSQL := strSQL + '  DE.ITE_EXPPRO AS "ITE_EXPPRO", ';

    strSQL := strSQL + '  I.ITE_BAREXP AS "ITE_BAREXP_NOV", ';
    strSQL := strSQL + '  I.ITE_BAREXP AS "ITE_BAREXP", ';

    strSQL := strSQL + '  I.ITE_SEPBAR AS "ITE_SEPBAR_NOV", ';
    strSQL := strSQL + '  I.ITE_SEPBAR AS "ITE_SEPBAR", ';

    strSQL := strSQL + '  I.ITE_EXPSIT AS "ITE_EXPSIT_NOV", ';
    strSQL := strSQL + '  I.ITE_EXPSIT AS "ITE_EXPSIT", ';

    if blnUtilizaChecklistGarantia then
    begin
      strSQL := strSQL + ' G.ITE_CODATC AS "ITE_CODATC_NOV", ';
      strSQL := strSQL + ' G.ITE_CODATC AS "ITE_CODATC", ';

      strSQL := strSQL + ' CAST( "" AS CHAR(10000)) AS "TMP_CKLGAR_NOV", ';
      strSQL := strSQL + ' CAST( "" AS CHAR(10000)) AS "TMP_CKLGAR", ';

      strSQL := strSQL + ' CAST( "" AS CHAR(10000)) AS "TMP_CKLTRO_NOV", ';
      strSQL := strSQL + ' CAST( "" AS CHAR(10000)) AS "TMP_CKLTRO", ';
    end;

    If fCfgSis('SEPEXC', varBoolean) Then
    Begin
      strSQL := strSQL + ' I.ITE_SEPEXC, ';
      strSQL := strSQL + ' I.ITE_SEPEXC AS ITE_SEPEXC_NOV, ';
    End;

    strSQL := strSQL + '  G.ITE_SOBENC AS "ITE_SOBENC_NOV", ';
    strSQL := strSQL + '  G.ITE_SOBENC AS "ITE_SOBENC", ';

    If fCfgSis('UTPEST', varBoolean) Then
    Begin
      strSQL := strSQL + ' I.ITE_QTDPES, ';
      strSQL := strSQL + ' I.ITE_QTDPES AS ITE_QTDPES_NOV, ';

      strSQL := strSQL + ' I.ITE_PORPES, ';
      strSQL := strSQL + ' I.ITE_PORPES AS ITE_PORPES_NOV, ';
    End;

    If fCfgSis('UTIABA', varBoolean) Then
    Begin
      strSQL := strSQL + '  G.ITE_MLTRCA AS "ITE_MLTRCA_NOV", ';
      strSQL := strSQL + '  G.ITE_MLTRCA AS "ITE_MLTRCA", ';
    End;

    If fCfgSis('ETIDCE', varBoolean) Then
    Begin
      strSQL := strSQL + '  I.ITE_NECEXP as "ITE_NECEXP", ';
      strSQL := strSQL + '  I.ITE_NECEXP AS "ITE_NECEXP_NOV", ';
    End;

    If fCfgSis('LOCRET', varBoolean) Then
    Begin
      strSQL := strSQL + '  G.ITE_TIPRET AS "ITE_TIPRET", ';
      strSQL := strSQL + '  G.ITE_TIPRET AS "ITE_TIPRET_NOV", ';
    End;

    If fCfgSis('OPCCOM', varString) = 'VT' Then
    Begin
      For intCorre := 1 To Length(VS_strTabPrc) Do
      Begin
        If VS_strTabPrc[intCorre] = 'S' Then
        Begin
          strSQL := strSQL + ' IFNULL((SELECT COM_VENINT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ),0) AS COM_VENIN' + intToStr(intCorre) + ', ';
          strSQL := strSQL + ' IFNULL((SELECT COM_VENINT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ),0) AS COM_VENIN' + intToStr(intCorre) + '_NOV, ';

          strSQL := strSQL + ' IFNULL((SELECT COM_VENEXT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ),0) AS COM_VENEX' + intToStr(intCorre) + ', ';
          strSQL := strSQL + ' IFNULL((SELECT COM_VENEXT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ),0) AS COM_VENEX' + intToStr(intCorre) + '_NOV, ';

        End;

      End;

    End;

    If fCfgSis('EMPCAR', varBoolean) Then
    Begin
      strSQL := strSQL + '  I.ITE_EMPCAR AS "ITE_EMPCAR_NOV",   ';
      strSQL := strSQL + '  I.ITE_EMPCAR,   ';
      strSQL := strSQL + '  CAR.EMP_NOMEMP AS "EMP_NOMEMP_NOV", ';
      strSQL := strSQL + '  CAR.EMP_NOMEMP, ';
    End;

    if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
    Begin
      strSQL := strSQL + '  I.ITE_EMPSUG AS "ITE_EMPSUG_NOV",   ';
      strSQL := strSQL + '  I.ITE_EMPSUG,   ';
      strSQL := strSQL + '  SUG.EMP_NOMEMP AS "EMP_NOMEMPSUG_NOV", ';
      strSQL := strSQL + '  SUG.EMP_NOMEMP AS "EMP_NOMEMPSUG", ';
    End;

    strSQL := strSQL + 'G.ITE_DTAUVE, ';


    If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
    Begin
      strSQL := strSQL + '  I.ITE_NFEIDP as "ITE_NFEIDP", ';
      strSQL := strSQL + '  I.ITE_NFEIDP AS "ITE_NFEIDP_NOV", ';

      strSQL := strSQL + '  I.ITE_NFCIDP as "ITE_NFCIDP", ';
      strSQL := strSQL + '  I.ITE_NFCIDP AS "ITE_NFCIDP_NOV", ';
    End;

    If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
    Begin
      strSQL := strSQL + '  I.ITE_LOTRAP as "ITE_LOTRAP", ';
      strSQL := strSQL + '  I.ITE_LOTRAP AS "ITE_LOTRAP_NOV", ';
    End;

    If fCfgSis('TRITTE', varBoolean) Then
    Begin
      strSQL := strSQL + ' I.ITE_TRITTE, ';
      strSQL := strSQL + ' I.ITE_TRITTE AS ITE_TRITTE_NOV, ';
    End;

    If fCfgSis('CDPHAB', varBoolean) Then
    Begin
      strSQL := strSQL + ' I.ITE_CLBPIN, ';
      strSQL := strSQL + ' I.ITE_CLBPIN AS ITE_CLBPIN_NOV, ';
    End;

    If blnUsaBef Then
    Begin
      strSQL := strSQL + ' I.ITE_USABEF, ';
      strSQL := strSQL + ' I.ITE_USABEF AS ITE_USABEF_NOV, ';
    End;
  End
  Else
    strSQL := strSQL + Campos;

  strSQL := strSQL + '  NULL ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '                     AND G.ITE_CODEMP = :CODEMP ';
  If (Not fEmptyStr(edtDocumento.Text)) Then
  begin
    strSQL := strSQL + ' INNER JOIN MOVDET D ON D.DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '                    AND D.DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '                    AND D.DET_CODEMP = :DOCEMP ';
    strSQL := strSQL + '                    AND D.DET_TIP_FC = "F"     ';

  end;

  strSQL := strSQL + '  INNER JOIN ABFICM A ON ';
  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF '
  Else
    strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF ';
  strSQL := strSQL + '   AND A.ABF_ESTADO = :ESTADO  ';
  strSQL := strSQL + '  INNER JOIN CADUNI U  ON I.ITE_CODUNI = U.UNI_CODUNI  ';
  strSQL := strSQL + '  INNER JOIN CADFOR ON FOR_CODFOR = I.ITE_CODFOR  ';
  strSQL := strSQL + '  INNER JOIN CADMAR ON MAR_CODMAR = I.ITE_CODMAR  ';


  strSQL := strSQL + '  LEFT JOIN CADGRU ON I.ITE_CODGRU = GRU_CODGRU  ';
  strSQL := strSQL + '  LEFT JOIN CADGPR ON I.ITE_CODGRU = GPR_CODIGO  ';
    strSQL := strSQL + '  LEFT JOIN SITPRO ON G.ITE_SITPRO = SIT_CODIGO  ';
    strSQL := strSQL + '  LEFT JOIN CADDEP ON I.ITE_CODDEP = DEP_CODIGO  ';
//    strSQL := strSQL + '  LEFT JOIN ITEMON ON I.ITE_CODMON = MON_CODMON  ';
    strSQL := strSQL + '  LEFT JOIN GRPPRD ON I.ITE_PRDGRU = PRD_CODGRU  ';
    strSQL := strSQL + '  LEFT JOIN ITEBAR B ON I.ITE_CODITE = B.BAR_CODITE AND B.BAR_PRINCI = 1 ';
  strSQL := strSQL + '  LEFT JOIN ITEBAR E ON I.ITE_CODITE = E.BAR_CODITE AND E.BAR_COMPRA = 1 ';

  If fCfgSis('TPABPC') = '2' Then
  Begin
    strSQL := strSQL + '       LEFT JOIN IPISAI IPI ON G.ITE_ABFIPI = IPI.APC_CODAPC AND IPI.AUTOINCREM = (SELECT MAX(AUTOINCREM) FROM IPISAI WHERE IPISAI.APC_CODAPC = IPI.APC_CODAPC)  ';
    strSQL := strSQL + '       LEFT JOIN COFSAI COF ON G.ITE_ABFCOF = COF.APC_CODAPC AND COF.AUTOINCREM = (SELECT MAX(AUTOINCREM) FROM COFSAI WHERE COFSAI.APC_CODAPC = COF.APC_CODAPC)  ';
    strSQL := strSQL + '       LEFT JOIN PISSAI PIS ON G.ITE_ABFPIS = PIS.APC_CODAPC AND PIS.AUTOINCREM = (SELECT MAX(AUTOINCREM) FROM PISSAI WHERE PISSAI.APC_CODAPC = PIS.APC_CODAPC)  ';
  End
  Else
  begin
    strSQL := strSQL + '       LEFT JOIN IPISAI IPI ON I.ITE_ABFIPI = IPI.APC_CODAPC AND IPI.AUTOINCREM = (SELECT MAX(AUTOINCREM) FROM IPISAI WHERE IPISAI.APC_CODAPC= IPI.APC_CODAPC)  ';
    strSQL := strSQL + '       LEFT JOIN COFSAI COF ON I.ITE_ABFCOF = COF.APC_CODAPC AND COF.AUTOINCREM = (SELECT MAX(AUTOINCREM) FROM COFSAI WHERE COFSAI.APC_CODAPC= COF.APC_CODAPC)  ';
    strSQL := strSQL + '       LEFT JOIN PISSAI PIS ON I.ITE_ABFPIS = PIS.APC_CODAPC AND PIS.AUTOINCREM = (SELECT MAX(AUTOINCREM) FROM PISSAI WHERE PISSAI.APC_CODAPC= PIS.APC_CODAPC)  ';
  End;
  strSQL := strSQL + '  LEFT JOIN GRU_COMPRA ON I.ITE_GRUCMP = GRU_CODIGO   ';
  strSQL := strSQL + '  LEFT JOIN CDCEST CES ON I.ITE_CDCEST = CES.CES_CDCEST AND CES.AUTOINCREM = (SELECT MAX(CDCEST.AUTOINCREM) FROM CDCEST WHERE CDCEST.CES_CDCEST = CES.CES_CDCEST)  ';

  strSQL := strSQL + '  LEFT JOIN DESSIT DE ON DE.ITE_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + '  LEFT JOIN CADGPC ON I.ITE_CODGPC = GPC_CODGPC  ';

  If fCfgSis('EMPCAR', varBoolean) Then
    strSQL := strSQL + '  LEFT JOIN CADEMP CAR ON CAR.EMP_CODEMP = I.ITE_EMPCAR ';

  if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
    strSQL := strSQL + '  LEFT JOIN CADEMP SUG ON SUG.EMP_CODEMP = I.ITE_EMPSUG ';

  If blnTABPRD then
  Begin
    For intContador := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + ' LEFT JOIN TABDET D' + IntToStr(intContador) + ' ON D' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
      strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODEMP = G.ITE_CODEMP';
      strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE ';
      strSQL := strSQL + ' LEFT JOIN ITEFOR IF' + IntToStr(intContador) + ' ON IF' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
      strSQL := strSQL + '                                                AND IF' + IntToStr(intContador) + '.ITE_CODEMP = G.ITE_CODEMP';
      strSQL := strSQL + '                                                AND IF' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE ';
      strSQL := strSQL + ' LEFT  JOIN DETCUS DC'+ IntToStr(intContador) + ' ON DC' + IntToStr(intContador) + '.DET_SEQDET = D' + IntToStr(intContador) + '.AUTOINCREM  AND DC'+IntToStr(intContador)+'.DET_TABELA = ' + IntToStr(intContador) ;
    End;
  end;

  Result := strSQL;
End;

procedure TfrmAltPrecoIndividual.pGravaMontadoras(strCodIte,
  strListaMontadoras: String; qryComand: TUniQuery);

  var Lista: TStringList;
  i: integer;
begin
  qryComand.SQL.Clear;
  If strListaMontadoras <> '' Then
  Begin
    qryComand.SQL.Text := 'DELETE FROM ITEMON WHERE ITM_CODITE = "'+strCodIte+'";';
    If (strListaMontadoras <> 'Limpar') Then
    Begin
      Lista := TStringList.Create;
      Try
        Lista.Delimiter := ',';
        Lista.Commatext :=strListaMontadoras;
        for i := 0 To Lista.Count -1 do
        Begin
          qryComand.SQL.Add('INSERT INTO ITEMON(AUTOINCREM, ITM_CODMON, ITM_CODITE)VALUES(' +
                                                '"' + fRetAutoincrem('ITEMON', VS_StrCodemp) + '",' +
                                                '"' + Lista[i] + '",' +
                                                '"' + strCodIte + '");');
        End;
      Finally
        FreeAndNil(Lista);
      End;
    End;

    qryComand.ExecSQL;
    qryComand.SQL.Clear;
  End;
end;

function TfrmAltPrecoIndividual.fRemoveQuebra(strInput: String): String;
Begin
  strInput := StringReplace(strInput, #$D#$A, ' ', [rfReplaceAll]);
  strInput := StringReplace(strInput, #$D#$A, ' ', [rfReplaceAll]);
  strInput := StringReplace(strInput, #$A   , ' ', [rfReplaceAll]);
  strInput := StringReplace(strInput, #13#10, ' ', [rfReplaceAll]);
  strInput := StringReplace(strInput, #13   , ' ', [rfReplaceAll]);
  Result := strInput
End;

end.
