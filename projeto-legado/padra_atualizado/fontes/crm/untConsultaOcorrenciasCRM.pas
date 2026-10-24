unit untConsultaOcorrenciasCRM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, MaskEditFocus, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, strUtils,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, UniClientDataSet, UniDataSetProvider,Uni,
  ComboBoxFocus, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters,
  cxNavigator, MemDS, DBAccess, Provider, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, untTypesSistema, cxGridCitel,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxScreenTip,
  cxSplitter, dxCustomHint, cxHint, System.ImageList, Vcl.ImgList, untZClient,
  cxButtonEdit, cxImage, Vcl.Samples.Spin, Vcl.DBCtrls, DBEditFocus, cxVGrid,
  cxDBVGrid, cxInplaceContainer, cxImageComboBox, dxBarBuiltInMenu, cxPC, dxColorEdit,
  untHelperCitel, QColorLabel, Vcl.Grids,
  Vcl.Samples.Calendar, untCRMCalendarioOcorrencias, untILeads, untLeads, untCadLeads,
  untAtualizaOcorrenciasCRM, cxCheckBox, untCfgTel, untCfgConsultaOcorrenciasCRM, untTypesCRM, untMostraDebCtrChq2,
  cxContainer;

type
  TcxPainterAccess = class(TcxGridTableDataCellPainter);
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);

  TTipoValidacao = (tpOcorrenciaNaoSelecionada, tpOcorrenciaNaoSelecionadaPainel,  tpNaoPermiteMultiplaSelecao);

  RecTipoOcorrencia = Record
    Codigo: String;
    Descricao: String;
  end;

  TListaOcorrencias = array of RecTipoOcorrencia;

  TfrmConsultaOcorrenciasCRM = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    pnlFiltros: TPanel;
    lblCliente: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtCodCli: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtProtoc: TEditFocus;
    edtDesCli: TEditFocus;
    edtCodGoc: TEditFocus;
    edtDesGoc: TEditFocus;
    edtDesToc: TEditFocus;
    edtCodToc: TEditFocus;
    dbgOcorrenciasDBTableView1: TcxGridDBTableViewCitel;
    dbgOcorrenciasLevel1: TcxGridLevel;
    dbgOcorrencias: TcxGridCitel;
    dtsOcorrencias: TDataSource;
    cdsOcorrencias: TUniClientDataSet;
    cdsOcorrenciasOCO_CODOCO: TStringField;
    cdsOcorrenciasOCO_CODTOC: TStringField;
    cdsOcorrenciasTOC_DESTOC: TStringField;
    cdsOcorrenciasOCO_CODCLI: TStringField;
    cdsOcorrenciasGOC_CODGOC: TStringField;
    cdsOcorrenciasGOC_DESGOC: TStringField;
    cdsOcorrenciasCLI_NOMCLI: TStringField;
    cdsOcorrenciasOCO_DTAINC: TDateField;
    cdsOcorrenciasOCO_HORINC: TTimeField;
    cdsOcorrenciasOCO_DTACON: TDateField;
    cdsOcorrenciasOCO_HORCON: TTimeField;
    cdsOcorrenciasOCO_CODOPE: TStringField;
    cdsOcorrenciasOPE_NOMOPE: TStringField;
    cdsOcorrenciasOCO_CODEMP: TStringField;
    cdsOcorrenciasOCO_OPEOCO: TStringField;
    cdsOcorrenciasNOPEOCO: TStringField;
    dbgOcorrenciasDBTableView1TOC_DESTOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1GOC_DESGOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1CLI_NOMCLI: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_DTAINC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_HORINC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_DTACON: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_HORCON: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OPE_NOMOPE: TcxGridDBColumn;
    OCO_CODEMP: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1NOPEOCO: TcxGridDBColumn;
    qryOcorrencias: TUniQuery;
    dspOcorrencias: TUniDataSetProvider;
    cdsOcorrenciasOCO_PROTOC: TStringField;
    dbgOcorrenciasDBTableView1OCO_PROTOC: TcxGridDBColumn;
    OCO_CODTOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1GOC_CODGOC: TcxGridDBColumn;
    edtOpeOco: TEditFocus;
    edtCodOpe: TEditFocus;
    edtDesOpeOco: TEditFocus;
    edtDesCodOpe: TEditFocus;
    Label1: TLabel;
    Label3: TLabel;
    cbStatus: TComboBoxFocus;
    Label2: TLabel;
    edtAutDev: TEditFocus;
    Label4: TLabel;
    cdsOcorrenciasGER_CODADE: TStringField;
    dbgOcorrenciasDBTableView1GER_CODADE: TcxGridDBColumn;
    btnCarrega: TBitBtnLocked;
    Label15: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    Label25: TLabel;
    edtCodGat: TEditFocus;
    edtDesGat: TEditFocus;
    dbgOcorrenciasDBTableView1DOCUMENTO: TcxGridDBColumn;
    cdsOcorrenciasDOCUMENTO: TStringField;
    dbgOcorrenciasDBTableView1FGO_VALORC: TcxGridDBColumn;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    lblCidade: TLabel;
    lblEstado: TLabel;
    edtCodCid: TEditFocus;
    dbgOcorrenciasDBTableView1CLI_FONE01: TcxGridDBColumn;
    cdsOcorrenciasCLI_FONE01: TStringField;
    cdsOcorrenciasFGO_VLRCON: TFloatField;
    dbgOcorrenciasDBTableView1FGO_VLRCON: TcxGridDBColumn;
    pnlHistorico: TPanel;
    imgButton: TImageList;
    cxHint: TcxHintStyleController;
    Label8: TLabel;
    splDivisor: TcxSplitter;
    cdsOcorrenciasOCO_CODCOC: TStringField;
    cdsOcorrenciasCOC_DESCOC: TStringField;
    cdsOcorrenciasOCO_DESCRI: TBlobField;
    cdsOcorrenciasOCO_CODSIT: TStringField;
    cdsOcorrenciasOCO_ESPDOC: TStringField;
    cdsOcorrenciasOCO_NUMDOC: TStringField;
    cdsOcorrenciasOCO_EMERGE: TStringField;
    cdsOcorrenciasCLI_EMAIL_: TStringField;
    cdsOcorrenciasOPE_E_MAIL: TStringField;
    cdsOcorrenciasOCO_DTAAGE: TDateField;
    cdsOcorrenciasOCO_HORAGE: TTimeField;
    OCO_DTAAGE: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_HORAGE: TcxGridDBColumn;
    Label5: TLabel;
    mskDtaIniAg: TMaskEditFocus;
    Label12: TLabel;
    mskDtaFinAg: TMaskEditFocus;
    Label13: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    popOcorrencias: TPopupMenu;
    mnuAbrirOcorrencia: TMenuItem;
    mnuEfetivarOrcamento: TMenuItem;
    mnuAlterarDocumento: TMenuItem;
    mnuEnviarEmail: TMenuItem;
    mnuGerarPDF: TMenuItem;
    mnuReimprimir: TMenuItem;
    mnuGerarVendaPerdida: TMenuItem;
    cdsOcorrenciasOCO_DTALIM: TDateTimeField;
    popPedido: TPopupMenu;
    mnuFatPedido: TMenuItem;
    popOrcamento: TPopupMenu;
    mnuFatOrcamento: TMenuItem;
    pnlBotoesAgregados: TFlowPanel;
    mnuDesmembrar: TMenuItem;
    pnlBotoesInferiores: TPanel;
    btnConfirma: TBitBtnLocked;
    btnAbrirOcorrencia: TBitBtnLocked;
    btnHistorico: TBitBtnLocked;
    btnFinalizar: TBitBtnLocked;
    btnAltSituacao: TBitBtnLocked;
    btnArquivos: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnCadCli: TBitBtnLocked;
    btnHisDeb: TBitBtnLocked;
    btnConsumiveis: TBitBtnLocked;
    btnResFin: TBitBtnLocked;
    btnImpBol: TBitBtnLocked;
    mnuBaixar: TMenuItem;
    cdsOcorrenciasFGO_STATUS: TLargeIntField;
    shpLiberadoOpeDest: TShape;
    shpLiberadoOpeOrig: TShape;
    Label14: TLabel;
    edtDesCoc: TEditFocus;
    edtCodCoc: TEditFocus;
    dbgOcorrenciasDBTableView1CLI_FANSOB: TcxGridDBColumn;
    cdsOcorrenciasCLI_FANSOB: TStringField;
    cxPageControl: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    tbsOcoPar: TcxTabSheet;
    cxGridCitel: TcxGridCitel;
    cxTableViewHisOco: TcxGridDBTableViewCitel;
    HisOcoColumnSTATUS: TcxGridDBColumn;
    HisOcoColumnDESCRI: TcxGridDBColumn;
    HisOcoColumnDTAINC: TcxGridDBColumn;
    HisOcoColumnHORINC: TcxGridDBColumn;
    HisOcoColumnOPEORI: TcxGridDBColumn;
    HisOcoColumnOPEDES: TcxGridDBColumn;
    HisOcoColumnNUMDOC: TcxGridDBColumn;
    HisOcoColumnTIPOCO: TcxGridDBColumn;
    HisOcoColumnCODSIT: TcxGridDBColumn;
    HisOcoColumnOBSERV: TcxGridDBColumn;
    cxGridCitelLevel1: TcxGridLevel;
    cxgOcoParDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgOcoParLevel1: TcxGridLevel;
    cxgOcoPar: TcxGridCitel;
    cxgOcoParDBTableViewCitelColumn1: TcxGridDBColumn;
    cxgOcoParDBTableViewCitelColumn2: TcxGridDBColumn;
    cxgOcoParDBTableViewCitelColumn3: TcxGridDBColumn;
    cxgOcoParDBTableViewCitelColumn4: TcxGridDBColumn;
    cdsOcorrenciasUSADEPS: TStringField;
    cdsOcorrenciasSTATUSDEPS: TStringField;
    cdsOcorrenciasAUTOINCREMFATGOR: TStringField;
    cdsOcorrenciasMOTBAI: TStringField;
    mnuAnaliseCreditoDEPS: TMenuItem;
    cdsOcorrenciasFGO_NUMFAT: TStringField;
    dbgOcorrenciasDBTableView1STATUSDEPS: TcxGridDBColumn;
    tmrSistemaDEPS: TTimer;
    lblCatego: TLabel;
    edtCodCat: TEditFocus;
    edtDesCat: TEditFocus;
    labelQua: TLabel;
    edtCodQua: TEditFocus;
    edtDesQua: TEditFocus;
    cdsOcorrenciasCAT_DESCRI: TStringField;
    cdsOcorrenciasCAT_CORCAT: TStringField;
    dbgOcorrenciasDBTableView1CAT_DESCRI: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1CAT_CORCAT: TcxGridDBColumn;
    cdsOcorrenciasOCO_SEQLAG: TStringField;
    Label16: TLabel;
    Label17: TLabel;
    mskDtaIniFlx: TMaskEditFocus;
    mskDtaFinFlx: TMaskEditFocus;
    dbgOcorrenciasDBTableView1CLI_CONTAT: TcxGridDBColumn;
    cdsOcorrenciasCLI_CONTAT: TStringField;
    lblEntrCD: TLabel;
    edtEntrCD: TEditFocus;
    clbEntrCD: TColorLabel;
    edtNumeroDocumento: TEditFocus;
    edtEspecieDocumento: TEditFocus;
    Label18: TLabel;
    Label19: TLabel;
    btnVisualizacaoFiltros: TBitBtnLocked;
    btnVisualizacaoHistorico: TBitBtnLocked;
    BtnExibirCalendario: TBitBtnLocked;
    pnlCalendarioGeral: TPanel;
    pnlMenuCalendario: TPanel;
    btnMesAnt: TBitBtnLocked;
    btnMesProx: TBitBtnLocked;
    btnSelecionarMes: TBitBtnLocked;
    btnSelecionarAno: TBitBtnLocked;
    btnAnoAnt: TBitBtnLocked;
    btnAnoProx: TBitBtnLocked;
    chkexibirFds: TCheckBox;
    pnlCalendario: TPanel;
    CheckBoxExibicaoCalendario: TCheckBox;
    pnlDetalhamento: TPanel;
    Splitter2: TSplitter;
    btnCarregaDadosCalendario: TBitBtnLocked;
    pnlTotalAgendamentos: TPanel;
    edtTamanhoDetalhamento: TEditFocus;
    chkFiltrosExpandido: TCheckBox;
    chkHistoricoExpandido: TCheckBox;
    pnlTitAgendamentos: TPanel;
    lblTitAgendamentos: TLabel;
    edtDiaCalendarioSelecionado: TEditFocus;
    ListViewCalendario: TListView;
    mnuAbrirLead: TMenuItem;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    cdsOcorrenciasQTDITEMSEL: TIntegerField;
    dbgOcorrenciasLevel2: TcxGridLevel;
    btnCadLead: TBitBtnLocked;
    dbgOcorrenciasDBTableView1NLEAD: TcxGridDBColumn;
    OCO_CODOCO: TcxGridDBColumn;
    OCO_CODCLI: TcxGridDBColumn;
    OCO_CODOPE: TcxGridDBColumn;
    OCO_CODCOC: TcxGridDBColumn;
    cdsOcorrenciasNLEAD: TStringField;
    dbgOcorrenciasDBTableView1FGO_PREVIS: TcxGridDBColumn;
    cdsOcorrenciasFGO_PREVIS: TDateField;
    dbgOcorrenciasDBTableViewCOMPLEMENTO: TcxGridDBColumn;
    cdsOcorrenciasCOMPLEMENTO: TStringField;
    HisOcoColumnCODCOC: TcxGridDBColumn;
    mnuModificarCategoria: TMenuItem;
    lblAssunto: TLabel;
    edtAssunto: TEditFocus;
    cdsOcorrenciasOCO_ASSUNT: TStringField;
    dbgOcorrenciasDBTableView1OCO_ASSUNT: TcxGridDBColumn;
    cdsOcorrenciasFGO_CODVEN: TStringField;
    dbgOcorrenciasDBTableView1FGO_CODVEN: TcxGridDBColumn;
    PopVendaNormal: TPopupMenu;
    mnuFatVendaNormal: TMenuItem;
    cdsOcorrenciasOCO_C_P_F_: TStringField;
    mnuLimparSeparacao: TMenuItem;
    mnuFaturarEmVendaNormal: TMenuItem;
    cdsOcorrenciasSIT_DESSIT: TStringField;
    dbgOcorrenciasDBTableView1OCO_CODSIT: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1SIT_DESSIT: TcxGridDBColumn;
    Label20: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    cdsOcorrenciasOCO_NOMFRM: TStringField;
    tmrAtualizarDados: TTimer;
    mnuEnviarBoletoPorEmail: TMenuItem;
    cdsOcorrenciasOCO_PARCEL: TStringField;
    btnCadFor: TBitBtnLocked;
    btnCadProspecto: TBitBtnLocked;
    btnAlterarAssunto: TBitBtnLocked;
    btnCfg: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    lblCorTemp: TLabel;
    edtCodTea: TEditFocus;
    edtDesTea: TEditFocus;
    cdsOcorrenciasOCO_CODTEA: TStringField;
    cdsOcorrenciasTEA_DESCRI: TStringField;
    dbgOcorrenciasDBTableViewTEA_DESCRI: TcxGridDBColumn;
    dbgOcorrenciasDBTableViewTEA_CORTEA: TcxGridDBColumn;
    cdsOcorrenciasTEA_CORTEA: TStringField;
    lblQtdOcoAbe: TLabel;
    lblDigitador: TLabel;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    cxIncluirHistoricoOpeOrig: TcxCheckBox;
    cxIncluirHistoricoOpeDest: TcxCheckBox;
    cdsOcorrenciasQTD_OCOABE: TFloatField;
    cdsOcorrenciasQTD_OCOFEC: TFloatField;
    cdsOcorrenciasFGOCLI: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodGocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtOpeOcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarregaClick(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGatExit(Sender: TObject);
    procedure edtCodGatKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure cdsOcorrenciasCLI_FONE01GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cxTableViewHisOcoCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxTableViewHisOcoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnArquivosClick(Sender: TObject);
    procedure btnAltSituacaoClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnAbrirOcorrenciaClick(Sender: TObject);
    procedure btnConsumiveisClick(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure dbgOcorrenciasDBTableView1DblClick(Sender: TObject);
    procedure dbgOcorrenciasDBTableView1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure mnuAbrirOcorrenciaClick(Sender: TObject);
    procedure mnuEfetivarOrcamentoClick(Sender: TObject);
    procedure mnuAlterarDocumentoClick(Sender: TObject);
    procedure mnuEnviarEmailClick(Sender: TObject);
    procedure mnuGerarPDFClick(Sender: TObject);
    procedure mnuReimprimirClick(Sender: TObject);
    procedure mnuGerarVendaPerdidaClick(Sender: TObject);
    procedure btnResFinClick(Sender: TObject);
    procedure btnImpBolClick(Sender: TObject);
    procedure btnCadCliClick(Sender: TObject);
    procedure btnHisDebClick(Sender: TObject);
    procedure mnuDesmembrarClick(Sender: TObject);
    procedure mnuBaixarClick(Sender: TObject);
    procedure edtCodCocKeyPress(Sender: TObject; var Key: Char);
    procedure mnuAnaliseCreditoDEPSClick(Sender: TObject);
    procedure tmrSistemaDEPSTimer(Sender: TObject);
    procedure edtCodCatKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodQuaKeyPress(Sender: TObject; var Key: Char);
    procedure popOcorrenciasPopup(Sender: TObject);
    procedure btnVisualizacaoFiltrosClick(Sender: TObject);
    procedure btnVisualizacaoHistoricoClick(Sender: TObject);
    procedure BtnExibirCalendarioClick(Sender: TObject);
    procedure chkexibirFdsClick(Sender: TObject);
    procedure ListViewCalendarioMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAnoAntClick(Sender: TObject);
    procedure btnAnoProxClick(Sender: TObject);
    procedure btnMesAntClick(Sender: TObject);
    procedure btnMesProxClick(Sender: TObject);
    procedure ExecutaOnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pnlCalendarioResize(Sender: TObject);
    procedure ListViewCalendarioClick(Sender: TObject);
    procedure btnCarregaDadosCalendarioClick(Sender: TObject);
    procedure pnlDetalhamentoResize(Sender: TObject);
    procedure ListViewCalendarioDblClick(Sender: TObject);
    procedure ListViewCalendarioExit(Sender: TObject);
    procedure ListViewCalendarioKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListViewCalendarioSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListViewCalendarioAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure mnuAbrirLeadClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure dbgOcorrenciasDBTableView1KeyUp (Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgOcorrenciasDBTableView1CanFocusRecord(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      var AAllow: Boolean);
    procedure dbgOcorrenciasDBTableView1CellClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnCadLeadClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtOpeOcoExit(Sender: TObject);
    procedure edtCodOpeExit(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodQuaExit(Sender: TObject);
    procedure edtCodGocExit(Sender: TObject);
    procedure edtCodTocExit(Sender: TObject);
    procedure edtCodCocExit(Sender: TObject);
    procedure edtCodCatExit(Sender: TObject);
    procedure dbgTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure mnuModificarCategoriaClick(Sender: TObject);
    procedure dbgOcorrenciasDBTableView1SelectionChanged(
      Sender: TcxCustomGridTableView);
    procedure mnuLimparSeparacaoClick(Sender: TObject);
    procedure mnuFaturarEmVendaNormalClick(Sender: TObject);
    procedure btnCfgClick(Sender: TObject);
    procedure tmrAtualizarDadosTimer(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure mnuEnviarBolEmail(Sender: TObject);
    procedure btnCadForClick(Sender: TObject);
    procedure btnCadProspectoClick(Sender: TObject);
    procedure btnAlterarAssuntoClick(Sender: TObject);
    procedure edtCodTeaExit(Sender: TObject);
    procedure edtCodTeaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtCodDigKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDigExit(Sender: TObject);
  private
    { Private declarations }
    qryCadGoc: TUniQuery;
    qryCadToc: TUniQuery;
    qryCadCoc: TUniQuery;
    qryCadOpe: TUniQuery;

    cdsHisOco: TZClient;
    cdsOcoPar: TZClient;

    arrGruAti: TConsultasArray;
    arrCodAti: TConsultasArray;
    arrCodCli: TConsultasArray;
    arrCodCid: TConsultasArray;
    arrOpeOco: TConsultasArray;
    arrCodOpe: TConsultasArray;
    arrCodDep: TConsultasArray;
    arrCodQua: TConsultasArray;
    arrCodGoc: TConsultasArray;
    arrCodToc: TConsultasArray;
    arrCodCoc: TConsultasArray;
    arrCodCat: TConsultasArray;
    arrCodEmp: TConsultasArray;
    arrCodTea: TConsultasArray;

    strCnsCodAti: String;
    strCnsGruAti: String;
    strCnsCodCli: String;
    strCnsCodCid: String;
    strCnsOpeOco: String;
    strCnsCodOpe: String;
    strCnsCodDep: String;
    strCnsCodGoc: String;
    strCnsCodToc: String;
    strCnsCodCoc: String;
    strCnsCodCat: String;
    strCnsCodEmp: String;
    strCnsCodTea: String;

    strValFil: String;
    strCamFil: String;

    FTip_Fc: String;
    FObjLeads: ILeads;

    intLastRec : Integer;

    //USADO NA GERAÇÃO DE FLUXO
    FOcoFin: Boolean;

    FCarregandoOcorrencias: Boolean;

    blnLiberadoOpeDest: Boolean;
    blnLiberadoOpeOrig: Boolean;

    blnUtilizaSistemaDEPS: Boolean;
    blnCtrGrdOco: Boolean;

    strCodOpeDest: String;
    strCodOpeOrig: String;

    FEstadoTela, FEstadoTelaFiltros: tTipoMovimentoTela;
    FTipoExibicaoDados: tTipoExibicaoOcorrenciasCRM;

    FTamanhoPanelHistoricoInicial,
    FTamanhoPanelHistoricoReduzido,
    FTamanhoPanelFiltrosReduzido,
    FTamanhoPanelFiltrosInicial: Integer;

    FCalendario: TCalendarioOcorrenciaCRM;
    FCalendarioCarregado: Boolean;
    FAlteraDataSelecionada: Boolean;
    FLiberarAjusteListView: Boolean;
    FOcorrenciaSelecionada: Integer;
    FOcorrenciaFocada: string;
    FAlteraPropFoco: Boolean;
    FPodeMarcarDesmarcarKey: Boolean;
    FLimitaUmaOcorrencia: Boolean;
    FTipoValidacao: TTipoValidacao;
    FAcessoFLUCRM,
    FAcessoBAICRM,
    FAcessoOPNCRM,
    FAcessoALTSIT,
    FAcessoCADCLI,
    FAcessoACEF7_,
    FAcessoBOLIND,
    FAcessoACEF6_,
    FAcessoCadFor,
    FAcessoCadPro : Boolean;

    FDesabilitaCdsScroll: Boolean;
    FIndiceCampoCodOco: Integer;

    FCfgTela: TCfgTelaConsultaOcorrenciaCRM;
    FblnValidarOpe : Boolean;
    FExibirAlertaCodCli: Boolean;
    FExibirAlertaCodCid: Boolean;

    procedure pCarregarCidade;
    procedure pCarregarCliente;
    procedure pCarregarGrupoOcorrencia;
    procedure pCarregarTipoOcorrencia;
    procedure pCarregarComplementoOcorrencia;
    procedure pCarregarQualificacao;
    procedure pConsultaOcorrencias;
    procedure pHabilitaBotoesPanelInferior;
    procedure pDesabilitaBotoesPanelInferior;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pCarregarUsuarioOrigem;
    procedure pCarregarUsuarioDestino;
    procedure pCarregarDepOpeDest;
    procedure pCarregarCategoria;
    procedure pCarregarCorTemperaturaAtend;

    function fRetornaSQLConsulta: String;

    procedure pCarregaHistoricoOcorrencia;
    procedure pTrataBotoesAgregados;
    procedure pAtualizaDadosGridOcorrencia(const blnCarregarOcorrencia: Boolean = True; blnExibirTrava: Boolean = True);
    procedure pEnviarSemPerguntar;

    procedure pExibirEfetivarOrcamento;
    procedure pExibirGerarVendaPerdida;
    procedure pExibirDesmembrar;
    procedure pExibirBaixar;
    procedure pExibirAlterar;
    procedure pTrataExibirMenus;
    procedure pExibirCadastroLeads;
    procedure pExibirAbrirOcorrencia;
    procedure pExibirEnviarOcoEmail;
    procedure pExibirGerarPDF;
    procedure pExibirReimprimir;
    procedure pExibirModificarCategoria;
    procedure pExibirLimparSeparacao;
    procedure pExibirFaturarEmVendaNormal;
    procedure pExibirEnviarBolEmail;

    function fSelecionarLead: string;

    procedure pConfiguraIcones(cxView: TcxGridDBTableViewCitel);
    function fGetSQLOcoPar: String;
    procedure pAtualizaOcoPar;

    procedure pExibirValidacaoSistemaDEPS();
    procedure pAtualizarStatusDEPSOrcamentos(cdsOcorrencias: TUniClientDataSet);

    procedure pSelecionarTipoExibicao(Tipo: tTipoExibicaoOcorrenciasCRM);
    procedure pAjustaLayoutCalendario(Area: tAreaAjuste);
    procedure pCarregarDados(const blnExibirMensagemTrava: Boolean = True);
    procedure OnDataOnChange(Sender: TObject);
    procedure OnDataOnClick(Sender: TObject);
    procedure OnDataOnExit(Sender: TObject);
    procedure pAtualizaDataAgendamentoFiltro;
    function fVerificaPodeExecutarAcao: Boolean;
    function fVerificaPodeExecutarAcaoCalendario: Boolean;
    function fVerificaPodeExecutarAcaoGrid: Boolean;
    function fObtemCodigoClienteSelecionado: string;
    procedure pFocaOcorrenciaAgendamento;
    procedure pCarregaOcorrenciaDataSelecionada;
    procedure pAtualizaDataSelecionada;
    procedure pSetarDataSelecionada(NovaData: TDateTime);
    procedure pCarregarOcorrenciasData;
    procedure pSetaItemFoco;
    procedure pMarcarDesmarcarItemLista;
    procedure pMarcarTodas;
    procedure pDesmarcarTodas;
    function fAlterarSituacaoOcorrenciasMarcadas: Boolean;
    function fObterTipoOcorrenciasSelecionadas: TListaOcorrencias;
    procedure pValidaCamposSemMensagem;
    function GetQtdItensMarcados: Integer;
    function fVerificarFiltrosPreenchidos: Boolean;
    function fValidarIndiceListView(intIndice: Integer): Boolean;
    function fVerificaPodeCarregarDados(const blnExibirAlerta: Boolean = True): Boolean;
    procedure pLimparCamposMultiConsulta;
    function  fMontaCondicaoQualificacao: string;
    procedure pConfigurarGridOcorrencias;
    procedure pGravarConfiguracoesTela;
    procedure pAbrirConfigGridOcorrencia;
    procedure pAbrirConfigCalendario;
    procedure pConfigurarAgendamentoCalendario;
    procedure pConfigurarTelaModoCalendario;
    procedure pConfigurarTelaModoGrid;
    procedure pCarregarCfgColunasGrid;
    procedure pCarregarEmpresa;
    function fValidaCamposParaCarregar(blnExibirMensagem: Boolean): Boolean;
    function fVerificaDataValida(strData: String): Boolean;
    procedure pSetarParametroOperadorDestino;
    procedure pSetarParametroOperadorOrigem;
    function fMultiSelecaoOperadorOrigem: Boolean;
    function fMultiSelecaoOperadorDestino: Boolean;
    procedure pGerarVendaPerdidaSelItens;
    procedure pCarregarDigitador;
  protected
    function getTip_Fc: String;
    procedure setTip_Fc(const Value: String);

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodGoc: String;
    strCodOco: String;
    strCodCli: String;
    pChamaOrcamento: TProcedureChamaOrcamento;

    property strTip_Fc: String Read getTip_Fc Write setTip_Fc;
  end;

const

  DescricaoValidacao: array[TTipoValidacao] of string = (
   'Selecione uma ocorrência!',
   'Selecione uma ocorrência no Painel de Agendamentos!',
   'Atenção! Selecione apenas um registro de ocorrência. Operação não permitida com multi-seleção.'
  );

var
  frmConsultaOcorrenciasCRM: TfrmConsultaOcorrenciasCRM;

implementation

uses untFuncoesSimples, untConsultas,  untPesqAux, untGravando,
  untFuncoesConsulta, untFuncoesGenerica, untFuncoesCRM, untObservacao,
  untCadMovOcorrencias, untImpulsionadorVendasCRM, untFuncoesOcorrenciasCRM,
  untMovGer, untResFinanceiro, untImpBoletoIndiv, untCadClientes,
  untFuncoesAuxiliares, untTSituacaoPedidoVenda,
  untValidacoesSistemaDEPS, untFatGor, untValorPorExtenso, System.DateUtils, untFuncoes,
  untCadProspectos, untCadFornecedores, untFatBaixarPedOrcNaoEntregue,
  untFatImpressao;

{$R *.dfm}

{ TfrmConsultaOcorrenciasCRM }

procedure TfrmConsultaOcorrenciasCRM.btnAbrirOcorrenciaClick(Sender: TObject);
var
  frmCadMovOcorrencias: TfrmCadMovOcorrencias;
begin
  inherited;

  If (Not btnAbrirOcorrencia.Visible) Or (Not btnAbrirOcorrencia.Enabled) Then
    Exit;

  if Not VerificarAcessoClienteOrdemDeProducaoIndustrial(edtCodCli.text) Then
    Exit;

  pCriarFormularios(TfrmCadMovOcorrencias, frmCadMovOcorrencias);
  Try
    Try
      frmCadMovOcorrencias.strTip_FC := FTip_Fc;
      If Not fEmptyStr(edtCodCli.Text) Then
        frmCadMovOcorrencias.strCodCli := edtCodCli.Text
      Else
      Begin
        If (Not cdsOcorrencias.IsEmpty) and (FTipoExibicaoDados <> tpCalendario)Then
          frmCadMovOcorrencias.strCodCli := cdsOcorrencias.FieldByName('OCO_CODCLI').AsString;
      End;
      frmCadMovOcorrencias.strCodEmp := VS_strCodEmp;
      frmCadMovOcorrencias.strOperac := 'Inserir';
      If FTipoExibicaoDados = tpCalendario Then
        frmCadMovOcorrencias.strDtaAge := DateTimeToStr( FCalendario.CalendarDate );
      frmCadMovOcorrencias.ShowModal;
      pAtualizaDadosGridOcorrencia;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.btnAbrirOcorrenciaClick]');
    End;
  Finally
    FreeAndNil(frmCadMovOcorrencias);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.btnAlterarAssuntoClick(Sender: TObject);
var
  strCodOcoTmp: String;
begin
  inherited;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  strCodOcoTmp := cdsOcorrencias.FieldByName('OCO_CODOCO').AsString;
  fAtualizarAssuntoOcorrencia(cdsOcorrencias.FieldByName('OCO_CODOCO').AsString,
                              FTip_Fc,
                              cdsOcorrencias.FieldByName('OCO_CODEMP').AsString);

  pAtualizaDadosGridOcorrencia(False);
  cdsOcorrencias.Locate('OCO_CODOCO', strCodOcoTmp, [ ] );
end;

procedure TfrmConsultaOcorrenciasCRM.btnAltSituacaoClick(Sender: TObject);
var
  blnAlterado: Boolean;
begin
  inherited;

  If (Not btnAltSituacao.Visible) Or (Not btnAltSituacao.Enabled) Then
    Exit;

  FLimitaUmaOcorrencia := False;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;

  try
    pSetaItemFoco;

    If (GetQtdItensMarcados > 1) Then
    Begin
      If fMensagem('ATENÇÃO', 'Deseja alterar a situação de todas as ocorrências selecionadas?', ['&Sim', '&Não'], 2) = 2 Then
        Exit
      Else
        blnAlterado := fAlterarSituacaoOcorrenciasMarcadas;
    End
    Else
      blnAlterado := fAlteraSituacaoOcorrencia(Self,
                                               cdsOcorrencias.FieldByName('OCO_CODTOC').AsString,
                                               cdsOcorrencias.FieldByName('OCO_CODOCO').AsString,
                                               cdsOcorrencias.FieldByName('OCO_CODCLI').AsString,
                                               cdsOcorrencias.FieldByName('OCO_CODOPE').AsString,
                                               cdsOcorrencias.FieldByName('OCO_CODEMP').AsString,
                                               cdsOcorrencias.FieldByName('OCO_CODCOC').AsString,
                                               cdsOcorrencias.FieldByName('OCO_DTAAGE').AsString,
                                               cdsOcorrencias.FieldByName('OCO_HORAGE').AsString);

    If blnAlterado  Then
    Begin
      pAtualizaDadosGridOcorrencia(False);

      If FTIpoExibicaoDados = tpCalendario Then
      Begin
        cdsOcorrencias.Locate('OCO_CODOCO', FOcorrenciaFocada, [ ] );
        FLiberarAjusteListView := True;
        pSetarDataSelecionada(cdsOcorrencias.FieldByName('OCO_DTAAGE').AsDateTime);
        pFocaOcorrenciaAgendamento;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.btnAltSituacaoClick]');
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.btnArquivosClick(Sender: TObject);
var
  strCli: string;
begin
  inherited;

  strCli := fObtemCodigoClienteSelecionado;
  If fEmptyStr(strCli) Then
  Begin
    fMensagem('ALERTA', 'Selecione um cliente no Painel de Agendamentos!', ['&OK']);
    Exit;
  End;

  FLimitaUmaOcorrencia := True;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;

  If (Not btnArquivos.Visible) Or (Not btnArquivos.Enabled) Then
    Exit;

  If not cdsOcorrencias.IsEmpty then
  Begin
    pVincularArquivos(cdsOcorrencias.FieldByName('OCO_CODOCO').AsString,
                      strTip_Fc,
                      cdsOcorrencias.FieldByName('OCO_CODCLI').AsString,
                      False);
  End;

  pFocaOcorrenciaAgendamento;
end;

procedure TfrmConsultaOcorrenciasCRM.btnCadCliClick(Sender: TObject);
var
  strCli: string;
begin
  If (Not btnCadCli.Visible) Or (cdsOcorrencias.IsEmpty) Then
    Exit;

  strCli := fObtemCodigoClienteSelecionado;
  If fEmptyStr(strCli) Then
  Begin
    fMensagem('ALERTA', 'Selecione um cliente no Painel de Agendamentos!', ['&OK']);
    Exit;
  End;

  FLimitaUmaOcorrencia := True;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;


  pCriarFormularios(TfrmCadClientes, frmCadClientes);
  Try
    Try
      frmCadClientes.strCodClienteIniciarCadastro := strCli;
      frmCadClientes.ShowModal;
      pFocaOcorrenciaAgendamento;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.btnCadCliClick]');
    End;
  Finally
    pFreeAndNil(frmCadClientes);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.btnCadForClick(Sender: TObject);
var
  strFor: string;
  frmCadFornecedores: TfrmCadFornecedores;
begin
  If (cdsOcorrencias.IsEmpty) Then
    Exit;

  strFor := fObtemCodigoClienteSelecionado;
  If fEmptyStr(strFor) Then
  Begin
    fMensagem('ALERTA', 'Selecione um fornecedor no Painel de Agendamentos!', ['&OK']);
    Exit;
  End;

  FLimitaUmaOcorrencia := True;
  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;

  pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);
  Try
    Try
      frmCadFornecedores.strCodFornecedorIniciarCadastro := strFor;
      frmCadFornecedores.ShowModal;
      pFocaOcorrenciaAgendamento;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.btnCadForClick]');
    End;
  Finally
    pFreeAndNil(frmCadFornecedores);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.btnCadLeadClick(Sender: TObject);
begin
  inherited;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  FLimitaUmaOcorrencia := True;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;

  If Not fEmptyStr(fSelecionarLead) Then
  Begin
    TfrmCadLeads.fCadLeads(pChamaOrcamento, FObjLeads);
      pAtualizaDadosGridOcorrencia();
  End
  Else
    fMensagem('ALERTA', 'Lead não localizado.', ['&OK']);
end;

procedure TfrmConsultaOcorrenciasCRM.btnCadProspectoClick(Sender: TObject);
var
  strProspe: string;
  frmCadProspectos: TfrmCadProspectos;
begin
  If (cdsOcorrencias.IsEmpty) Then
    Exit;

  strProspe := fObtemCodigoClienteSelecionado;
  If fEmptyStr(strProspe) Then
  Begin
    fMensagem('ALERTA', 'Selecione um prospecto no Painel de Agendamentos!', ['&OK']);
    Exit;
  End;

  FLimitaUmaOcorrencia := True;
  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;

  pCriarFormularios(TfrmCadProspectos, frmCadProspectos);
  Try
    Try
      frmCadProspectos.strCodIniciarCadastro := strProspe;
      frmCadProspectos.ShowModal;
      pFocaOcorrenciaAgendamento;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.btnCadProspectoClick]');
    End;
  Finally
    pFreeAndNil(frmCadProspectos);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.btnCarregaClick(Sender: TObject);
begin
  inherited;

  pCarregarDados;

end;

procedure TfrmConsultaOcorrenciasCRM.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  strCodGoc := cdsOcorrencias.FieldByName('GOC_CODGOC').AsString;
  strCodOco := cdsOcorrencias.FieldByName('OCO_CODOCO').AsString;
  strCodCli := cdsOcorrencias.FieldByName('OCO_CODCLI').AsString;


  blnConfirma := True;

  Close;
end;

procedure TfrmConsultaOcorrenciasCRM.btnConsumiveisClick(Sender: TObject);
  Var
    strCodCli: String;
begin
  inherited;

  If Not ( (FTip_Fc = 'C') And fVerificaAcessoSistema('CRMOCN') ) Then
    Exit;

  If Not (fEmptyStr(edtCodCli.Text)) Then
    strCodCli := edtCodCli.Text
  Else
    strCodCli := fObtemCodigoClienteSelecionado;

  If (fEmptyStr(strCodCli)) Then
  Begin
    fMensagem('ALERTA', 'Não há um cliente informado e/ou registro selecionado para acionar a rotina de Oferta de Consumíveis. Operação cancelada!', ['&OK']);
    pSetFocus(edtCodCli);
    Exit;
  End;

  FLimitaUmaOcorrencia := True;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;


  pCriarFormularios(TfrmImpulsionadorVendasCRM, frmImpulsionadorVendasCRM);
  Try
    Try
      frmImpulsionadorVendasCRM.strCodCli := strCodCli;
      frmImpulsionadorVendasCRM.ShowModal();
      pAtualizaDadosGridOcorrencia;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'btnConsumiveisClick');
    End;
  Finally
    pFreeAndNil(frmImpulsionadorVendasCRM);
  End;

end;

procedure TfrmConsultaOcorrenciasCRM.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;

  pDesmarcarTodas;
end;

procedure TfrmConsultaOcorrenciasCRM.btnFinalizarClick(Sender: TObject);
begin
  inherited;

  FLimitaUmaOcorrencia := True;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;

  If (Not btnFinalizar.Visible) Or (Not btnFinalizar.Enabled) Then
    Exit;

  If Not cdsOcorrencias.IsEmpty Then
  Begin
    cdsOcorrencias.Edit;
    cdsOcorrencias.FieldByName('OCO_NOMFRM').AsString := Self.Name;
    cdsOcorrencias.Post;
    If fFinalizaReabreOcorrencia(cdsOcorrencias, btnFinalizar.Tag = 0, FTip_Fc) Then
    Begin
      If fEnviarOcorrenciaPorEmail(cdsOcorrenciasOCO_CODTOC.AsString) Then
        pEnviarSemPerguntar();
      pAtualizaDadosGridOcorrencia();
    End;

  End;

end;

procedure TfrmConsultaOcorrenciasCRM.btnHisDebClick(Sender: TObject);
var
  strCli: string;
begin
  If (Not btnHisDeb.Visible) Or
    (cdsOcorrencias.IsEmpty) Then
    Exit;

  strCli := fObtemCodigoClienteSelecionado;
  If fEmptyStr(strCli) Then
  Begin
    fMensagem('ALERTA', 'Selecione um cliente no Painel de Agendamentos!', ['&OK']);
    Exit;
  End;

  FLimitaUmaOcorrencia := True;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;


  TfrmMostraDebCtrChq2.pMostraContaCorrente(strCli);
  pFocaOcorrenciaAgendamento;
end;

procedure TfrmConsultaOcorrenciasCRM.btnHistoricoClick(Sender: TObject);
Var
 strCodOcoTmp: String;
begin
  inherited;

  If (Not btnHistorico.Visible) Or (Not btnHistorico.Enabled) Then
    Exit;

  FLimitaUmaOcorrencia := True;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;

  Try

    If Not cdsOcorrencias.IsEmpty Then
    Begin
      pSetaItemFoco;

      If fChamaHistoricoOcorrencias(cdsOcorrencias.FieldByName('OCO_CODOCO').AsString,
                                    cdsOcorrencias.FieldByName('OCO_CODEMP').AsString,
                                    cdsOcorrencias.FieldByName('OCO_CODCLI').AsString,
                                    cdsOcorrencias.FieldByName('CLI_NOMCLI').AsString,
                                    cdsOcorrencias.FieldByName('CLI_EMAIL_').AsString,
                                    cdsOcorrencias.FieldByName('GOC_CODGOC').AsString,
                                    cdsOcorrencias.FieldByName('GOC_DESGOC').AsString,
                                    cdsOcorrencias.FieldByName('OCO_CODTOC').AsString,
                                    cdsOcorrencias.FieldByName('TOC_DESTOC').AsString,
                                    cdsOcorrencias.FieldByName('OCO_CODCOC').AsString,
                                    cdsOcorrencias.FieldByName('COC_DESCOC').AsString,
                                    FTip_Fc,
                                    cdsOcorrencias.FieldByName('OCO_PROTOC').AsString,
                                    cdsOcorrencias.FieldByName('OCO_NUMDOC').AsString,
                                    cdsOcorrencias.FieldByName('OCO_ESPDOC').AsString,
                                    cdsOcorrencias.FieldByName('OCO_CODSIT').AsString,
                                    FOcoFin,
                                    '',
                                    cdsOcorrencias.FieldByName('OCO_DTAAGE').AsString,
                                    cdsOcorrencias.FieldByName('OCO_HORAGE').AsString) Then
      Begin
        strCodOcoTmp := cdsOcorrencias.FieldByName('OCO_CODOCO').AsString;
        pAtualizaDadosGridOcorrencia(False);
        cdsOcorrencias.Locate('OCO_CODOCO', strCodOcoTmp, [ ] );
      End
      Else
        Exit;

      pAtualizaDadosGridOcorrencia(False);
      If FTIpoExibicaoDados = tpCalendario Then
      Begin
        cdsOcorrencias.Locate('OCO_CODOCO', FOcorrenciaFocada, [ ] );
        FLiberarAjusteListView := True;
        FCalendario.CalendarDate := cdsOcorrencias.FieldByName('OCO_DTAAGE').AsDateTime;

        Application.ProcessMessages;
        pFocaOcorrenciaAgendamento;
      End;

    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.btnHistoricoClick]');
  End;

end;

procedure TfrmConsultaOcorrenciasCRM.btnImpBolClick(Sender: TObject);
Var
  frmImpBoletoIndiv: TfrmImpBoletoIndiv;
  strCli: string;
begin
  If Not( (FTip_Fc = 'C') And fVerificaAcessoSistema('OCOBOL', strLoginUsuarioLogado) ) Then
    Exit;

  If (Not btnImpBol.Visible) Or
    (cdsOcorrencias.IsEmpty) Then
    Exit;

  strCli := fObtemCodigoClienteSelecionado;
  If fEmptyStr(strCli) Then
  Begin
    fMensagem('ALERTA', 'Selecione um cliente no Painel de Agendamentos!', ['&OK']);
    Exit;
  End;

  FLimitaUmaOcorrencia := True;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;


  pCriarFormularios(TfrmImpBoletoIndiv, frmImpBoletoIndiv);
  Try
    Try
      frmImpBoletoIndiv.strCodCli := strCli;
      frmImpBoletoIndiv.ShowModal;
      pFocaOcorrenciaAgendamento;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.btnImpBolClick]');
    End;
  Finally
    pFreeAndNil(frmImpBoletoIndiv);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.btnImprimirClick(Sender: TObject);
var
  intCnt, Indice: Integer;
  strCodOco, strCodEmp: String;
begin
  inherited;

  If (Not btnImprimir.Visible) Or (Not btnImprimir.Enabled) Then
    Exit;

  FLimitaUmaOcorrencia := False;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;

  If (GetQtdItensMarcados > 1 ) Then
  Begin
    If fMensagem('ATENÇÃO', 'Deseja imprimir todas as ocorrêcias selecionadas?', ['&Sim', '&Não'], 2) = 2 Then
      Exit;

    If FTipoExibicaoDados = tpGrid Then
    Begin
      dbgOcorrenciasDBTableView1.DataController.BeginLocate;
      dbgOcorrenciasDBTableView1.DataController.DataSet.DisableControls;

      For intCnt := 0 to dbgOcorrenciasDBTableView1.Controller.SelectedRowCount  -1 Do
      Begin
        Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_CODOCO').Index;
        strCodOco := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
        Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_CODEMP').Index;
        strCodEmp := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];

        pImprimirOcorrencias(strCodOco,
                             strCodEmp,
                             FTip_Fc);
      End;

      dbgOcorrenciasDBTableView1.DataController.EndLocate;
      dbgOcorrenciasDBTableView1.DataController.DataSet.EnableControls;
    End
    Else
    Begin
      For intCnt := 0 to ListViewCalendario.Items.Count -1 Do
      Begin
        If  ListViewCalendario.Items[intCnt].Selected Then
        Begin
          strCodOco := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceOcorrencia];
          strCodEmp := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceCodEmpresa];

          pImprimirOcorrencias(strCodOco,
                               strCodEmp,
                               FTip_Fc);
        End;
      End;
    End;

  End
  Else
    pImprimirOcorrencias(cdsOcorrencias.FieldByName('OCO_CODOCO').AsString,
                         cdsOcorrencias.FieldByName('OCO_CODEMP').AsString,
                         FTip_Fc);

  pFocaOcorrenciaAgendamento;

end;

procedure TfrmConsultaOcorrenciasCRM.btnResFinClick(Sender: TObject);
var
  strCli: string;
begin
  inherited;

  If (Not btnResFin.Visible) Or
    (cdsOcorrencias.IsEmpty) Then
    Exit;

  strCli := fObtemCodigoClienteSelecionado;
  If fEmptyStr(strCli) Then
  Begin
    fMensagem('ALERTA', 'Selecione um cliente no Painel de Agendamentos!', ['&OK']);
    Exit;
  End;

  FLimitaUmaOcorrencia := True;

  If Not(fVerificaPodeExecutarAcao) Then
  Begin
    fMensagem('ALERTA', DescricaoValidacao[FTipoValidacao], ['&OK']);
    Exit;
  End;


  pCriarFormularios(TfrmResFinanceiro, frmResFinanceiro);
  Try
    Try
      frmResFinanceiro.strCodCli := strCli;
      frmResFinanceiro.ShowModal;
      pFocaOcorrenciaAgendamento;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.btnResFinClick]');
      End;
    End;
  Finally
    pFreeAndNil(frmResFinanceiro);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmConsultaOcorrenciasCRM.cdsOcorrenciasCLI_FONE01GetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fFormataFone(Sender.AsString);
end;

procedure TfrmConsultaOcorrenciasCRM.cxTableViewHisOcoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    APainter: TcxPainterAccess;
begin
  inherited;
  If AViewInfo.Item.Index <> HisOcoColumnDESCRI.Index Then
    Exit;

  APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
  With APainter Do
  Begin
    Try
      DrawBorders;
      With AViewInfo.ClientBounds Do
      Begin
        imgButton.Draw(ACanvas.Canvas, Left + ((Width - 16) div 2), Top + ((Height - 16) div 2), 1 );
      End;
    Finally
      Free;
    End;

  End;

  ADone := True;
end;

procedure TfrmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1CanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;

  If Not blnCtrGrdOco Then
    Exit;

  Application.ProcessMessages;

  If Not Assigned(dbgOcorrenciasDBTableView1.Controller.FocusedRow) Then
    Exit;

  If AAllow Then
  Begin
    dbgOcorrenciasDBTableView1.Controller.FocusedRow.Selected := dbgOcorrenciasDBTableView1.Controller.FocusedRow.Focused;
  End
  Else
    dbgOcorrenciasDBTableView1.Controller.FocusedRow.Selected := False;

  Application.ProcessMessages;
end;

procedure TfrmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pTrataBotoesAgregados;
  pCarregaHistoricoOcorrencia;
end;

procedure TfrmConsultaOcorrenciasCRM.cxTableViewHisOcoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  Var
    Site: TcxGridSite;
    HitTest: TcxCustomGridHitTest;
begin
  inherited;
  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);

  if HitTest is TcxGridRecordCellHitTest then
  begin

    If (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex >= 0) And
       (HisOcoColumnDESCRI.Index = TcxGridRecordCellHitTest(HitTest).Item.Index) And
       (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex <> intLastRec) Then
    Begin
      intLastRec := TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex;
      cxHint.ShowHint(Mouse.CursorPos.X + 3, Mouse.CursorPos.Y + 3,'',
                      ReplaceStr(VarToStr(Site.GridView.DataController.Values[intLastRec, HisOcoColumnDESCRI.Index]), '<<csq>>', #13 ));
    End;

    If (HisOcoColumnDESCRI.Index <> TcxGridRecordCellHitTest(HitTest).Item.Index) Or
       (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex <> intLastRec) Then
    Begin
      cxHint.HideHint;
      intLastRec := -1;
    End;
  end
  Else
  Begin
    cxHint.HideHint;
    intLastRec := -1;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1DblClick(
  Sender: TObject);
begin
  inherited;

  btnConfirma.Click;
end;

procedure TfrmConsultaOcorrenciasCRM.ExecutaOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin
  If FCarregandoOcorrencias Then
    Exit;

  FDesabilitaCdsScroll := True;
  Try
    Try
      FAlteraPropFoco := False;
      FPodeMarcarDesmarcarKey := False;

      If (Shift = [ssShift]) then
      Begin
        If (FTipoExibicaoDados = tpCalendario) and (ListViewCalendario.MultiSelect = True) Then
          ListViewCalendario.MultiSelect := False;

        If (FTipoExibicaoDados = tpGrid) Then
          dbgOcorrenciasDBTableView1.OptionsSelection.MultiSelect := False;

        Application.ProcessMessages;

        Exit;
      End;

      If ((Shift = [ssAlt]) And (Pos(strTip_Fc, 'C_P_') > 0)) Then
      Begin
        Case Key Of
          VK_F2 : mnuEfetivarOrcamento.Click;
          VK_F3 : mnuAlterarDocumento.Click;
          VK_F4 : Begin
                    mnuEnviarEmail.Click;
                    Key := 0;
                  End;
          VK_F5 : mnuGerarPDF.Click;
          VK_F6 : mnuReimprimir.Click;
          VK_F7 : mnuGerarVendaPerdida.Click;
          VK_F8 : mnuDesmembrar.Click;
          VK_F9 : mnuBaixar.Click;
        End;
      End
      Else If (Key = VK_Return) Then
      Begin
        If ((TcxGridSiteCitel(Sender).Parent = dbgOcorrencias) or (TListView(Sender) = ListViewCalendario)) Then
        Begin
          btnConfirma.Click;
        End
        Else
        Begin
          Try
            if Not VerificarAcessoClienteOrdemDeProducaoIndustrial(cdsOcorrencias.FieldByName('OCO_CODCLI').AsString) Then
              exit;

            If Not cdsHisOco.IsEmpty Then
            Begin
              cxHint.HideHint;
              intLastRec := -1;
              pCriarFormularios(TfrmObservacao, frmObservacao);
              frmObservacao.Width := 1024;
              frmObservacao.Height:= 600;
              frmObservacao.BorderIcons := [biSystemMenu, biMinimize, biMaximize];
              frmObservacao.memObs.Font.Name := 'Courier New';
              frmObservacao.lblMensagem.caption := 'Histórico:';
              frmObservacao.memObs.Texto := cdsHisOco.FieldByName('DESCRI').AsString;
              frmObservacao.BorderIcons := [biSystemMenu, biMaximize];
              frmObservacao.ShowModal;
            End;
          Finally
            FreeAndNil(frmObservacao);
          End;
        End;
      End
      Else
      Begin

        Case Key Of
          VK_ESCAPE: Begin
                       btnSair.Click;
                     End;
          VK_F1: Begin
                   If (Shift = [ssCtrl]) Then
                     btnResFin.Click
                   Else
                     btnAbrirOcorrencia.Click;
                 End;
          VK_F2: Begin
                   If (Shift = [ssCtrl]) Then
                     btnImpBol.Click
                   Else
                     btnHistorico.Click;
                 End;
          VK_F3: btnFinalizar.Click;
          VK_F4: btnAltSituacao.Click;
          VK_F7: btnArquivos.Click;
          VK_F8: btnImprimir.Click;
          VK_F9: Begin
                   If FTip_Fc = 'C' Then
                     btnCadCli.Click;
                   If FTip_Fc = 'F' Then
                     btnCadFor.Click;
                   If FTip_Fc = 'P' Then
                     btnCadProspecto.Click;
                 End;
          VK_F10: Begin
                    If (Shift = [ssCtrl]) Then
                      btnAlterarAssunto.Click
                    Else
                      btnConfirma.Click;
                  End;
          VK_F11: btnHisDeb.Click;
          VK_F12: Begin
                    If (Shift = [ssCtrl]) Then
                      btnCadLead.Click
                    Else
                      btnConsumiveis.Click;
                  End;
        End;

        If (FTipoExibicaoDados = tpCalendario) Then
        Begin

          If (Shift = [ssCtrl]) Then
          Begin
            If (FTipoExibicaoDados = tpCalendario) and (ListViewCalendario.MultiSelect = False) Then
              ListViewCalendario.MultiSelect := True;
            Exit;
          End;

          If (Shift = [ssShift]) then
            Exit;

          If (TListView(Sender) = ListViewCalendario) Then
          Begin

            If Not fValidarIndiceListView(ListViewCalendario.ItemIndex) Then
              Exit;

            If Not fValidarIndiceListView(ListViewCalendario.ItemIndex+1) Then
                Exit;

            If Not fValidarIndiceListView(ListViewCalendario.ItemIndex-1) Then
                Exit;

            If Key = VK_DOWN Then
            Begin
              Application.ProcessMessages;

              If ListViewCalendario.SelCount > 0 Then
              Begin
                If (ListViewCalendario.ItemIndex >= 0)Then
                  ListViewCalendario.Items[ListViewCalendario.ItemIndex].Focused := True; // existe para contornar problema de foco de grupo do componente

                Application.ProcessMessages;
              End;
            End;

            If Key = VK_UP Then
            Begin
              FAlteraPropFoco := True;
              Application.ProcessMessages;

              If ListViewCalendario.SelCount > 0 Then
              Begin
                If Not Assigned(ListViewCalendario.ItemFocused) Then
                Begin
                  If ListViewCalendario.ItemIndex-1 >=0 Then
                  Begin
                    ListViewCalendario.Items[ListViewCalendario.ItemIndex].Focused := False;
                    ListViewCalendario.Items[ListViewCalendario.ItemIndex-1].Focused := True;
                    Application.ProcessMessages;
                  End
                  Else
                    ListViewCalendario.Items[ListViewCalendario.ItemIndex].Focused := True;  // existe para contornar problema de foco de grupo do componente
                End
                Else
                Begin
                  If ((ListViewCalendario.ItemIndex-1) >= 0) and ((ListViewCalendario.ItemIndex+1) <= (ListViewCalendario.Items.Count-1)) Then
                  Begin
                    FAlteraPropFoco := False;
                    ListViewCalendario.Items[ListViewCalendario.ItemIndex+1].Focused := False;
                    FAlteraPropFoco := True;
                    ListViewCalendario.Items[ListViewCalendario.ItemIndex-1].Focused := True;
                    ListViewCalendario.Items[ListViewCalendario.ItemIndex].Focused := True;
                  End
                  Else
                  If ((ListViewCalendario.ItemIndex-1) >= 0) Then
                  Begin
                    ListViewCalendario.Items[ListViewCalendario.ItemIndex-1].Focused := True;
                    ListViewCalendario.Items[ListViewCalendario.ItemIndex].Focused := True;
                  End;
                End;
                Application.ProcessMessages;
              End;
            End;
          End;

          If (TCalendarioOcorrenciaCRM(Sender) = FCalendario) Then
          Begin
            If (Shift = [ssCtrl]) then
              Exit;

            FCalendario.PularProximo := False;
            FCalendario.PularAnterior := False;

            If Not FCalendario.ExibirDiasSemanaFeriado Then
            Begin
              Case Key Of
                VK_DOWN, VK_RIGHT : Begin
                                      FCalendario.PularProximo := True;
                                    End;

                VK_UP, VK_LEFT    : Begin
                                      FCalendario.PularAnterior := True;
                                    End;
              End;
            End
            Else If FCalendario.DataSelecionadaAnteriormente = FCalendario.CalendarDate Then
            Begin
              Case Key Of
                VK_RIGHT : Begin
                             If DayOfWeek(FCalendario.CalendarDate) in [7] Then
                             Begin
                               FLiberarAjusteListView := True;
                               pSetarDataSelecionada(FCalendario.CalendarDate + 1);
                             End;
                           End;

                VK_LEFT  : Begin
                             If DayOfWeek(FCalendario.CalendarDate) in [1] Then
                             Begin
                               FLiberarAjusteListView := True;
                               pSetarDataSelecionada(FCalendario.CalendarDate -1);
                             End;
                           End;
              End;
            End;

            Application.ProcessMessages;
          End;
        End

        Else
        Begin
          If (TcxGridSiteCitel(Sender).Parent = dbgOcorrencias) Then
          Begin
            blnCtrGrdOco := (Shift = [ssCtrl]);

            If (Shift = [ssCtrl]) Then
            Begin
              If dbgOcorrenciasDBTableView1.OptionsSelection.MultiSelect = False Then
                dbgOcorrenciasDBTableView1.OptionsSelection.MultiSelect := True;

              Application.ProcessMessages;

              Case Key Of
                VK_DOWN,
                VK_UP   : Begin
                            If (TcxGridSiteCitel(Sender).Parent = dbgOcorrencias) Then
                            Begin
                              If dbgOcorrenciasDBTableView1.Controller.FocusedRow.Selected Then
                              Begin
                                dbgOcorrenciasDBTableView1.Controller.FocusedRow.Selected := False;
                              End
                              Else
                              Begin
                                dbgOcorrenciasDBTableView1.Controller.FocusedRow.Selected := True;
                              End;
                            End;
                          End;
              End;
            End;
          End;
        End;
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.ExecutaOnKeyDown]');
    End;
  Finally
    FDesabilitaCdsScroll := False;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1MouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
  Rec: TcxCustomGridRecord;
  strDoc: String;
begin
  inherited;

  If Button = mbRight Then
  Begin
    Site    := Sender as TcxGridSite;
    HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);

    If HitTest Is TcxGridRecordCellHitTest Then
    Begin
      Rec  := TcxGridRecordCellHitTest(HitTest).GridRecord;

      strDoc := VarToStr(rec.Values[dbgOcorrenciasDBTableView1DOCUMENTO.Index]);

      If (Pos('PD', strDoc) > 0) Or
         (Pos('OR', strDoc) > 0) Or
         (Not fEmptyStr(cdsOcorrenciasOCO_SEQLAG.AsString)) Or
         (cdsOcorrencias.FieldByName('OCO_CODTOC').AsString = fCfgSis('OCOFIN', varString)) Then
      Begin
        pTrataExibirMenus();
        popOcorrencias.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      End;
    End;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1SelectionChanged(
  Sender: TcxCustomGridTableView);
begin
  inherited;

  If Not FPodeMarcarDesmarcarKey Then
    Exit;

  If Not Assigned(dbgOcorrenciasDBTableView1.Controller.FocusedRow) Then
    Exit;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodAtiExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodAti.Text) Then
    edtDesAti.Text := 'TODAS'
  Else
    pEdtCodSelectExit(edtCodAti, edtDesAti, arrCodAti, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  SetLength(arrCodAti, 0);
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrCodAti, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;

end;

procedure TfrmConsultaOcorrenciasCRM.edtCodCatExit(Sender: TObject);
begin
  inherited;

  pCarregarCategoria;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodCatKeyPress(Sender: TObject; var Key: Char);
begin
  SetLength(arrCodCat, 0);
  if fPesqCategoriaOrPd(Self, edtCodCat, edtDesCat, qryTabela, Key, arrCodCat, False) then
  begin
    If fValidaCampos(edtCodCat, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodCidExit(Sender: TObject);
begin
  inherited;

  pCarregarCidade;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodCidKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  SetLength(arrCodCid, 0);
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCodCid, False) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConsultaOcorrenciasCRM.edtCodCliExit(Sender: TObject);
begin
  inherited;

  pCarregarCliente;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************AC*}
  SetLength(arrCodCli, 0);
  If FTip_Fc = 'P' Then
  Begin

    If fPesqProspecto(Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, False, True, True) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End

  Else
  If FTip_Fc = 'C' Then
  Begin
    If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, False) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    {*********************************}
    {* NOVA CONSULTA DE FORNECEDORES *}
    {******************************AC*}
    If fPesqFornecedor(conForSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCodCli, False) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodCocExit(Sender: TObject);
begin
  inherited;

  pCarregarComplementoOcorrencia;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodCocKeyPress(Sender: TObject;
  var Key: Char);
begin
  SetLength(arrCodCoc, 0);
  If fPesqComplementosOcorrencias(Self, edtCodCoc, edtDesCoc, nil, Key, arrCodCoc, False, edtCodToc.Text) Then
  Begin
    If fValidaCampos(edtCodCoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodTeaExit(Sender: TObject);
begin
  inherited;

  pCarregarCorTemperaturaAtend;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodTeaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  SetLength(arrCodTea, 0);
  If fPesqTempAtndCRM(Self, edtCodTea, edtDesTea, qryTabela, Key, arrCodTea, False) Then
  begin
    If fValidaCampos(edtCodTea, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodDepExit(Sender: TObject);
begin
  inherited;

  pCarregarDepOpeDest;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  SetLength(arrCodDep, 0);
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodDigExit(Sender: TObject);
begin
  inherited;
  pCarregarDigitador;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarDigitador;
begin
  If fEmptyStr(edtCodDig.Text) Then
  Begin
    edtNomDig.Text := 'TODOS';
    Exit;
  End;

  pPesquisaCadOpe(qryTabela, qryCadOpe, edtCodDig.Text);
  edtNomDig.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodDigKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCodDig : TConsultasArray;
begin
  inherited;

  SetLength(arrCodDig, 0);
  If (fPesqOperador(Self, edtCodDig, edtNomDig, nil, Key, arrCodDig, False)) then
  Begin
    If fValidaCampos(edtCodDig, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  If (Not SameText(edtCodEmp.Text, '000')) Then
    pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrCodEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  SetLength(arrCodEmp, 0);
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrCodEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodGatExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodGat.Text) Then
    edtDesGat.Text := 'TODOS'
  Else
    pEdtCodSelectExit(edtCodGat, edtDesGat, arrGruAti, fRetDescGrupoAtividade, Nil, 'do Grupo de Atividade');
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodGatKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  SetLength(arrGruAti, 0);
  If fPesqGrupoAtividade(Self, edtCodGat, edtDesGat, Nil, Key, arrGruAti, False) Then
  Begin
    fValidaCampos(edtCodGat, True);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodGocExit(Sender: TObject);
begin
  inherited;

  pCarregarGrupoOcorrencia;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodGocKeyPress(Sender: TObject;
  var Key: Char);
begin
  {***************************************}
  {* NOVA CONSULTA GRUPOS DE OCORRENCIAS *}
  {************************************AC*}
  SetLength(arrCodGoc, 0);
  If fPesqGruposOcorrencias(Self, edtCodGoc, edtDesGoc, nil, Key, arrCodGoc, False) Then
  Begin
    If fValidaCampos(edtCodGoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodOpeExit(Sender: TObject);
begin
  inherited;

  pCarregarUsuarioDestino;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  SetLength(arrCodOpe, 0);
  If (blnLiberadoOpeDest) And
     (fPesqOperador(Self, edtCodOpe, edtDesCodOpe, nil, Key, arrCodOpe, False)) then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodQuaExit(Sender: TObject);
begin
  inherited;

  pCarregarQualificacao;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodQuaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  SetLength(arrCodQua, 0);
  If fPesqQualificacao(Self, edtCodQua, edtDesQua, Nil, Key, arrCodQua, False) Then
  Begin
    If fValidaCampos(edtCodQua, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodTocExit(Sender: TObject);
begin
  inherited;

  pCarregarTipoOcorrencia;
end;

procedure TfrmConsultaOcorrenciasCRM.edtCodTocKeyPress(Sender: TObject;
  var Key: Char);
begin
  {**************************************}
  {* NOVA CONSULTA TIPOS DE OCORRENCIAS *}
  {***********************************AC*}
  SetLength(arrCodToc, 0);
  If fPesqTiposOcorrencias(Self, edtCodToc, edtDesToc, nil, Key, arrCodToc, False, IIF(Length(arrCodGoc)> 0, EmptyStr, edtCodGoc.Text), False) Then
  Begin
    If fValidaCampos(edtCodToc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.edtOpeOcoExit(Sender: TObject);
begin
  inherited;

  pCarregarUsuarioOrigem;
end;

procedure TfrmConsultaOcorrenciasCRM.edtOpeOcoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  SetLength(arrOpeOco, 0);
  if (blnLiberadoOpeOrig) And
     (fPesqOperador(Self, edtOpeOco, edtDesOpeOco, nil, Key, arrOpeOco, False)) then
  Begin
    If fValidaCampos(edtOpeOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pValidaCamposSemMensagem;
begin
  VS_ExibirMensagemAoUsuario := False;
  Try
    VS_ExibirMensagemAoUsuario := fVerificaCampos;
  Finally
    VS_ExibirMensagemAoUsuario := True;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pValidaCamposSemMensagem;

  pGravarConfiguracoesTela;

  tmrSistemaDEPS.Enabled := False;

  cdsOcorrencias.Close;
  FreeAndNil(qryCadGoc);
  FreeAndNil(qryCadToc);
  FreeAndNil(qryCadCoc);
  FreeAndNil(qryCadOpe);

  cdsHisOco.Close;
  FreeAndNil(cdsHisOco);

  If Assigned(FCalendario) Then
    FreeAndNil(FCalendario);
end;

procedure TfrmConsultaOcorrenciasCRM.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  CanClose := fVerificaPodeCarregarDados(True);
end;

procedure TfrmConsultaOcorrenciasCRM.FormCreate(Sender: TObject);
var
  fldValOrc: TDateField;
  intCorZeb: Integer;
begin
  inherited;
  //Sempre default Cliente.Quando for fornecedor será passado pelo frmCRMForn
  strTip_Fc := 'C';
  blnConfirma := False;
  FDesabilitaCdsScroll := True;

  tmrAtualizarDados.Enabled  := False;
  blnCtrGrdOco := False;

  pCriarModuloLegenda;

  If fCfgSis('IFVLOR', varBoolean) Then
  Begin
    fldValOrc := TDateField.Create(cdsOcorrencias);
    fldValOrc.Name := 'cdsOcorrenciasFGO_VALORC';
    fldValOrc.FieldName := 'FGO_VALORC';
    fldValOrc.DisplayLabel := 'Validade orç.';
    fldValOrc.DataSet := cdsOcorrencias;
  End;

  blnLiberadoOpeDest := True;
  If (Not fVerificaAcessoSistema('CONOPD')) Then
  Begin
    edtCodOpe.MaxLength := 10;
    edtCodOpe.TamCampo  := 0;
    edtCodOpe.PasswordChar := '*';
    shpLiberadoOpeDest.Brush.Color  := clRed;
    blnLiberadoOpeDest := False;
  End
  Else
    shpLiberadoOpeDest.Brush.Color  := clGreen;

  blnLiberadoOpeOrig := True;
  If (Not fVerificaAcessoSistema('CONOPO')) Then
  Begin
    edtOpeOco.MaxLength := 10;
    edtOpeOco.TamCampo  := 0;
    edtOpeOco.PasswordChar := '*';
    shpLiberadoOpeOrig.Brush.Color  := clRed;
    blnLiberadoOpeOrig := False;
  End
  Else
    shpLiberadoOpeOrig.Brush.Color  := clGreen;

  fCriaAggregateField(cdsOcorrencias, 'TOT_QTDABE', 'SUM(QTD_OCOABE)');
  fCriaAggregateField(cdsOcorrencias, 'TOT_QTDFEC', 'SUM(QTD_OCOFEC)');
  fCriaAggregateField(cdsOcorrencias, 'TOT_QTDOCO', 'COUNT(OCO_CODOCO)');

  cdsOcorrencias.CreateDataSet;
  cdsOcorrencias.OnFilterRecord := pFilterRecord;

  qryCadGoc := fCriarQuery('SELECT * FROM CADGOC WHERE FALSE', Self);
  qryCadToc := fCriarQuery('SELECT * FROM CADTOC WHERE FALSE', Self);
  qryCadCoc := fCriarQuery('SELECT * FROM CADCOC WHERE FALSE', Self);
  qryCadOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  cdsHisOco := TZClient.Create(Self, fRetornaSQLHistoricoOcorrencias);

  if fCfgSis('EXISTA', VarBoolean) then
  begin
    HisOcoColumnSTATUS.Visible := True;
    pConfiguraIcones(cxTableViewHisOco);
  end
  else
    HisOcoColumnSTATUS.Visible := False;

  FOcoFin   := False;
  FCarregandoOcorrencias := False;

  tbsOcoPar.TabVisible := fCfgSis('OCOPAR', varBoolean);
  cdsOcoPar := TZClient.Create(Self, fGetSQLOcoPar);
  cxgOcoParDBTableViewCitel.DataController.DataSource := cdsOcoPar.dtsSource;

  cxPageControl.ActivePageIndex := 0;

  lblCatego.Visible := fCfgSis('UTICAO', varBoolean) Or fCfgSis('UTICAP', varBoolean);
  edtCodCat.Visible := fCfgSis('UTICAO', varBoolean) Or fCfgSis('UTICAP', varBoolean);
  edtDesCat.Visible := fCfgSis('UTICAO', varBoolean) Or fCfgSis('UTICAP', varBoolean);

  FTamanhoPanelHistoricoReduzido := 0;
  FTamanhoPanelHistoricoInicial := pnlHistorico.Height;

  FTamanhoPanelFiltrosReduzido := 0;
  FTamanhoPanelFiltrosInicial := pnlFiltros.Height;

  intCorZeb := fCfgSis('CORZEB', varInteger);
  FCalendario := TCalendarioOcorrenciaCRM.Create(Self);
  FCalendario.OnKeyUp := ExecutaOnKeyDown;
  ListViewCalendario.OnKeyDown := ExecutaOnKeyDown;
  dbgOcorrenciasDBTableView1.OnKeyDown := ExecutaOnKeyDown;
  cxTableViewHisOco.OnKeyDOwn := ExecutaOnKeyDown;
  FCalendario.CorDestaqueCelula := intCorZeb;
  FAlteraDataSelecionada := False;
  FCalendarioCarregado := False;
  FObjLeads := TLeads.New;

  FAcessoFLUCRM := fVerificaAcessoSistema('FLUCRM');
  FAcessoBAICRM := fVerificaAcessoSistema('BAICRM');
  FAcessoOPNCRM := fVerificaAcessoSistema('OPNCRM');
  FAcessoALTSIT := fVerificaAcessoSistema('ALTSIT');
  FAcessoCADCLI := fVerificaAcessoSistema('frmCadClientes');
  FAcessoACEF7_ := fVerificaAcessoSistema('ACEF7_', strLoginUsuarioLogado);
  FAcessoBOLIND := fVerificaAcessoSistema('frmImpBoletosIndiv');
  FAcessoACEF6_ := fVerificaAcessoSistema('ACEF6_', strLoginUsuarioLogado);
  FAcessoCadFor := fVerificaAcessoSistema('frmCadFornecedores');
  FAcessoCadPro := fVerificaAcessoSistema('frmCadProspectos');

  dbgOcorrenciasDBTableView1.Zebra := False;
  dbgOcorrenciasDBTableView1.OnCustomDrawCell := dbgTableView1CustomDrawCell;
  cxTableViewHisOco.Zebra := False;
  cxTableViewHisOco.OnCustomDrawCell := dbgTableView1CustomDrawCell;

  If Not fCfgSis('CRMTEA', varBoolean) Then
  Begin
    edtCodTea.Visible := False;
    edtDesTea.Visible := False;
    lblCorTemp.Visible := False;
  End;

  FDesabilitaCdsScroll := False;

  lblQtdOcoAbe.Caption := EmptyStr;

end;

function TfrmConsultaOcorrenciasCRM.fGetSQLOcoPar : String;
Begin
  Result := '';
  Result := Result + ' SELECT * FROM OCOPAR       ';
  Result := Result + ' WHERE PAR_CODOCO = :CODOCO ';
  Result := Result + '   AND PAR_CODTOC = :CODTOC ';
  Result := Result + '   AND PAR_CODEMP = :CODEMP ';
  Result := Result + '   AND PAR_CODCLI = :CODCLI ';
End;

function TfrmConsultaOcorrenciasCRM.fMontaCondicaoQualificacao: string;
var
  strWhere: String;
  intCnt: Integer;
  intTam: Integer;
begin
  intTam := Length(arrCodQua);
  strWhere := EmptyStr;
  Try
    If Length(arrCodQua)>= 1 Then
    Begin
      For intCnt :=0 To intTam-1 Do
      Begin
        strWhere := strWhere + IIF(intCnt=0, '(', ' OR ');
        strWhere := '( '+ QuotedStr(arrCodQua[intCnt].strCodigo) +
                    ' IN (SELECT CADQUA.QUA_CODQUA  FROM QUACLI ' +
                    '      INNER JOIN CADQUA ON QUACLI.QUA_CODQUA = CADQUA.AUTOINCREM '  +
                    '     WHERE QUA_CODCLI = MOVOCO.OCO_CODCLI)  ';
        strWhere := strWhere + IIF(intCnt = intTam-1, ')', '');
      End;
    End
    Else
    Begin
      If Not fEmptyStr(edtCodQua.Text) Then
      Begin
         strWhere := QuotedStr(edtCodQua.Text) +
                      '   IN (SELECT CADQUA.QUA_CODQUA ' +
                      '		   FROM QUACLI               ' +
                      '      INNER JOIN CADQUA ON QUACLI.QUA_CODQUA = CADQUA.AUTOINCREM '  +
                      '    WHERE QUA_CODCLI = MOVOCO.OCO_CODCLI)  ';
      End;
    End;
  Finally
    Result := strWhere;
  End;
end;

function TfrmConsultaOcorrenciasCRM.fMultiSelecaoOperadorDestino: Boolean;
begin
  Result := (Not(fEmptyStr(edtCodOpe.text))) And (Length(arrCodOpe) > 1);
end;

function TfrmConsultaOcorrenciasCRM.fMultiSelecaoOperadorOrigem: Boolean;
begin
  Result := (Not(fEmptyStr(edtOpeOco.text))) And (Length(arrOpeOco) > 1);
end;

procedure TfrmConsultaOcorrenciasCRM.pAtualizaOcoPar;
Begin
  if not Assigned(cdsOcoPar) Then
    Exit;

  If cdsOcoPar.Active Then
    cdsOcoPar.EmptyDataSet;

  cdsOcoPar.qryQuery.ParamByName('CODOCO').AsString := cdsOcorrencias.FieldByName('OCO_CODOCO').AsString;
  cdsOcoPar.qryQuery.ParamByName('CODTOC').AsString := cdsOcorrencias.FieldByName('OCO_CODTOC').AsString;
  cdsOcoPar.qryQuery.ParamByName('CODEMP').AsString := cdsOcorrencias.FieldByName('OCO_CODEMP').AsString;
  cdsOcoPar.qryQuery.ParamByName('CODCLI').AsString := cdsOcorrencias.FieldByName('OCO_CODCLI').AsString;

  cdsOcoPar.fAbreClient(True, '');

End;

procedure TfrmConsultaOcorrenciasCRM.FormDestroy(Sender: TObject);
begin

  FreeAndNil(FCfgTela);

  inherited;
end;

procedure TfrmConsultaOcorrenciasCRM.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaCamposForm(Self, 'frmConsultaOcorrenciasCRM.' + FTip_Fc + '.Campos', False);
  If Not blnLiberadoOpeDest Then
  Begin
    edtCodOpe.Text := '';
    edtDesCodOpe.Text := '';
  End;
  If Not blnLiberadoOpeOrig Then
  Begin
    edtOpeOco.Text := '';
    edtDesOpeOco.Text := '';
  End;

  pLimparCamposMultiConsulta;
  pValidaCamposSemMensagem;

  If Not (FTip_Fc = 'C') Then
  Begin
    btnConfirma.Visible := False;
    btnArquivos.Visible := False;
    btnCadCli.Visible := False;
    btnHisDeb.Visible := False;
    btnResFin.Visible := False;
    btnMarcarTodas.Visible := False;
    btnDesmarcarTodas.Visible := False;
    btnCadLead.Visible := False;

    If  (FTip_Fc = 'F') Then
    Begin
      btnAbrirOcorrencia.Visible := False;
      btnHistorico.Visible := False;
      btnFinalizar.Visible := False;
      btnAltSituacao.Visible := False;
      btnImprimir.Visible := False;
    End;

    pnlBotoesAgregados.Height := pnlBotoesAgregados.Height div 2;
  End;

  btnCadFor.Visible := FAcessoCadFor And (FTip_Fc = 'F');
  btnCadProspecto.Visible := FAcessoCadPro And (FTip_Fc = 'P');
  btnAlterarAssunto.Visible := fCfgSis('OCOAST',varBoolean);

  btnConsumiveis.Visible := (FTip_Fc = 'C') And fVerificaAcessoSistema('CRMOCN');
  btnImpBol.Visible := (FTip_Fc = 'C') And fVerificaAcessoSistema('OCOBOL', strLoginUsuarioLogado);

  FCfgTela := TCfgTelaConsultaOcorrenciaCRM.Create(FTip_Fc);

  pnlDetalhamento.Width := StrToIntDef( FCfgTela.Sugestao.fCarregarInfObjeto(pnlDetalhamento.Name), pnlDetalhamento.Width);

  FDesabilitaCdsScroll := False;

  pSetFocus(edtCodCli);

  pnlInfo.Caption := 'Utilize o (Ctrl + Clique) ou (Ctrl + Seta) para selecionar várias ocorrências';

  If Not fCfgSis('CRMTEA', varBoolean) Then
    edtCodTea.Clear;

  If CheckBoxExibicaoCalendario.checked Then
    pSelecionarTipoExibicao(tpCalendario)
  Else
  Begin
    pSelecionarTipoExibicao(tpGrid);
    pSetFocus(edtCodCli);
  End;

end;

function TfrmConsultaOcorrenciasCRM.fRetornaSQLConsulta: String;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '       OCO_CODOCO, ';
  strSQL := strSQL + '       OCO_CODTOC, ';
  strSQL := strSQL + '       TOC_DESTOC, ';
  strSQL := strSQL + '       OCO_CODCOC, ';
  strSQL := strSQL + '       COC_DESCOC, ';
  strSQL := strSQL + '       OCO_CODCLI, ';
  strSQL := strSQL + '       GOC_CODGOC, ';
  strSQL := strSQL + '       GOC_DESGOC, ';

  If strTip_Fc = 'P' Then
  Begin
    strSQL := strSQL + '       PRO_NOMCLI AS CLI_NOMCLI, ';
    strSQL := strSQL + '       PRO_FONE01 AS CLI_FONE01, ';
    strSQL := strSQL + '       PRO_EMAIL_ AS CLI_EMAIL_, ';
    strSQL := strSQL + '       PRO_FANSOB AS CLI_FANSOB, ';
    strSQL := strSQL + '       PRO_CONTAT AS CLI_CONTAT, ';

  End
  Else
  If strTip_Fc = 'C' Then
  Begin
    strSQL := strSQL + '       IFNULL(FGO_NOMCON, IFNULL(IFNULL(M.GER_NOMCON,CON_NOMCON), CLI_NOMCLI)) AS CLI_NOMCLI, ';
    strSQL := strSQL + '       IFNULL(FGO_TELCON, IFNULL(IFNULL(M.GER_TELCON,CON_FONE01), CLI_FONE01)) AS CLI_FONE01, ';
    strSQL := strSQL + '       CLI_EMAIL_, ';
    strSQL := strSQL + '       CLI_FANSOB, ';
    strSQL := strSQL + '       CLI_CONTAT, ';
  End
  Else
  Begin
    strSQL := strSQL + '       FOR_NOMFOR AS CLI_NOMCLI, ';
    strSQL := strSQL + '       FOR_FONE01 AS CLI_FONE01, ';
    strSQL := strSQL + '       FOR_EMAIL_ AS CLI_EMAIL_, ';
    strSQL := strSQL + '       FOR_NOMFAN AS CLI_FANSOB, ';
    strSQL := strSQL + '       FOR_CONTAT AS CLI_CONTAT, ';
  End;

  strSQL := strSQL + '       OCO_DTAINC, ';
  strSQL := strSQL + '       OCO_HORINC, ';
  strSQL := strSQL + '       OCO_DTAAGE, ';
  strSQL := strSQL + '       OCO_HORAGE, ';
  strSQL := strSQL + '       OCO_DTACON, ';
  strSQL := strSQL + '       OCO_HORCON, ';
  strSQL := strSQL + '       OCO_CODOPE, ';
  strSQL := strSQL + '       CODOPE.OPE_NOMOPE, ';
  strSQL := strSQL + '       CODOPE.OPE_E_MAIL, ';
  strSQL := strSQL + '       OCO_CODEMP, ';
  strSQL := strSQL + '       OCO_OPEOCO, ';
  strSQL := strSQL + '       OPEOCO.OPE_NOMOPE AS NOPEOCO,';
  strSQL := strSQL + '       OCO_PROTOC, ';
  strSQL := strSQL + '       GER_CODADE, ';
  strSQL := strSQL + '       IF(IFNULL(OCO_NUMDOC, "") <> "",';
  strSQL := strSQL + '          CONCAT(      ';
  strSQL := strSQL + '            OCO_NUMDOC,';
  strSQL := strSQL + '            "-",       ';
  strSQL := strSQL + '            OCO_ESPDOC,';
  strSQL := strSQL + '            "-",       ';
  strSQL := strSQL + '            OCO_CODEMP),';
  strSQL := strSQL + '         ""';
  strSQL := strSQL + '       ) AS DOCUMENTO ';

  If fCfgSis('IFVLOR', varBoolean) Then
    strSQL := strSQL + '       ,FGO_VALORC ';

  strSQL := strSQL + '       , (CASE WHEN IFNULL(N.GER_VLRCON, 0) > 0 THEN IFNULL(N.GER_VLRCON, 0) ';
  strSQL := strSQL + '               WHEN IFNULL(M.GER_VLRCON, 0) > 0 THEN IFNULL(M.GER_VLRCON, 0) ';
  strSQL := strSQL + '               ELSE IFNULL(FGO_VLRCON, 0) ';
  strSQL := strSQL + '         END) AS FGO_VLRCON ';

  strSQL := strSQL + '       ,OCO_DESCRI ';
  strSQL := strSQL + '       ,OCO_NUMDOC ';
  strSQL := strSQL + '       ,OCO_ESPDOC ';
  strSQL := strSQL + '       ,OCO_CODSIT ';
  strSQL := strSQL + '       ,OCO_EMERGE ';
  strSQL := strSQL + '       ,TIMESTAMPADD(SECOND, IFNULL(TOC_TMPLIM,0), CAST( CONCAT(OCO_DTAINC," ",OCO_HORINC) AS DATETIME) ) AS OCO_DTALIM ';
  strSQL := strSQL + '       ,IFNULL(FGO_STATUS, 0) AS FGO_STATUS ';
  strSQL := strSQL + '       ,FGO_NUMFAT ';
  strSQL := strSQL + '       ,EXTGOR.FGO_USADEP AS USADEPS ';
  strSQL := strSQL + '       ,EXTGOR.FGO_STSDEP AS STATUSDEPS ';
  strSQL := strSQL + '       ,FATGOR.FGO_MOTBAI AS MOTBAI ';
  strSQL := strSQL + '       ,FATGOR.AUTOINCREM AS AUTOINCREMFATGOR ';
  strSQL := strSQL + '       ,CAT_DESCRI ';
  strSQL := strSQL + '       ,CAT_CORCAT ';
  strSQL := strSQL + '       ,OCO_SEQLAG ';
  strSQL := strSQL + '       ,COALESCE(LDG_NUMDOC, FGO_NLEADS) AS NLEAD ';
  strSQL := strSQL + '       ,FATGOR.FGO_PREVIS ';
  strSQL := strSQL + '       ,CONCAT(COC_CODCOC, " - ", COC_DESCOC) AS COMPLEMENTO ';
  strSQL := strSQL + '       ,OCO_ASSUNT ';
  strSQL := strSQL + '       ,FATGOR.FGO_CODVEN ';
  strSQL := strSQL + '       ,OCO_C_P_F_ ';
  strSQL := strSQL + '       ,SIT_DESSIT';
  strSQL := strSQL + '       ,OCO_NOMFRM';
  strSQL := strSQL + '       ,OCO_PARCEL';
  strSQL := strSQL + '       ,OCO_CODTEA';
  strSQL := strSQL + '       ,TEA_DESCRI';
  strSQL := strSQL + '       ,TEA_CORTEA';
  strSQL := strSQL + '       ,(CASE WHEN IFNULL(OCO_DTACON, 0.00)  > 0 THEN 0.00 ELSE 1.00 END ) AS QTD_OCOABE';
  strSQL := strSQL + '       ,(CASE WHEN IFNULL(OCO_DTACON, 0.00)  > 0 THEN 1.00 ELSE 0.00 END ) AS QTD_OCOFEC';
  strSQL := strSQL + '       ,FATGOR.FGO_CODCLI AS FGOCLI ';
  strSQL := strSQL + '  FROM MOVOCO      ';

  If FTip_Fc = 'P' Then
  Begin
    strSQL := strSQL + ' INNER JOIN PROSPE ON PRO_CODPRO = OCO_CODCLI ';
    strSQL := strSQL + ' LEFT  JOIN CADATI ON ATI_CODATI = PRO_CODATI ';
  End
  Else
  If FTip_Fc = 'C' Then
  Begin
    strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = OCO_CODCLI ';
    strSQL := strSQL + ' LEFT  JOIN CADATI ON ATI_CODATI = CLI_CODATI ';
    strSQL := strSQL + ' LEFT  JOIN CLICON ON OCO_C_P_F_ = CON_C_P_F_ ';
  End
  Else
  Begin
    strSQL := strSQL + ' INNER JOIN CADFOR ON FOR_CODFOR = OCO_CODCLI ';
    strSQL := strSQL + ' LEFT  JOIN CADATI ON ATI_CODATI = FOR_CODATI ';
  End;

  strSQL := strSQL + ' INNER JOIN CADTOC ON TOC_CODTOC = OCO_CODTOC ';
  strSQL := strSQL + ' INNER JOIN CADGOC ON GOC_CODGOC = TOC_CODGOC ';
  strSQL := strSQL + '  LEFT JOIN CADCOC ON COC_CODCOC = OCO_CODCOC  AND OCO_CODTOC = COC_CODTOC ';
  strSQL := strSQL + '  LEFT JOIN CADOPE CODOPE ON CODOPE.OPE_CODOPE = OCO_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN CADOPE OPEOCO ON OPEOCO.OPE_CODOPE = OCO_OPEOCO ';
  strSQL := strSQL + '  LEFT JOIN ADEGER ON GER_CODEMP = OCO_CODEMP AND GER_CODOCO = OCO_CODOCO ';

  strSQL := strSQL + '  LEFT JOIN FATGOR                    ';
  strSQL := strSQL + '    ON FGO_NUMDOC = OCO_NUMDOC        ';
  strSQL := strSQL + '   AND FGO_ESPDOC = OCO_ESPDOC       ';
  strSQL := strSQL + '   AND FGO_CODEMP = OCO_CODEMP       ';
  strSQL := strSQL + '  LEFT JOIN EXTGOR                    ';
  strSQL := strSQL + '    ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CATEGO ON FGO_CODCAT = CAT_CODIGO ';
  strSQL := strSQL + ' LEFT JOIN LADGER ON OCO_SEQLAG = LADGER.AUTOINCREM ';
  strSQL := strSQL + ' LEFT JOIN SITOCO ON SIT_CODTOC = OCO_CODTOC AND OCO_CODSIT = SIT_CODSIT ';
  strSQL := strSQL + ' LEFT JOIN MOVGER M                  ';
  strSQL := strSQL + '   ON  M.GER_NUMDOC = OCO_NUMDOC       ';
  strSQL := strSQL + '   AND M.GER_ESPDOC = OCO_ESPDOC       ';
  strSQL := strSQL + '   AND M.GER_CODEMP = OCO_CODEMP       ';
  If FTip_Fc = 'F' Then
    strSQL := strSQL + '   AND M.GER_CODFOR = OCO_CODCLI     '
  Else
    strSQL := strSQL + '   AND M.GER_CODCLI = OCO_CODCLI     ';
  strSQL := strSQL + '   AND M.GER_TIP_FC = OCO_TIP_FC       ';
  strSQL := strSQL + ' LEFT JOIN NOTGER N                    ';
  strSQL := strSQL + '   ON  N.GER_NUMDOC = OCO_NUMDOC       ';
  strSQL := strSQL + '   AND N.GER_ESPDOC = OCO_ESPDOC       ';
  strSQL := strSQL + '   AND N.GER_CODEMP = OCO_CODEMP       ';
  If FTip_Fc = 'F' Then
    strSQL := strSQL + '   AND N.GER_CODFOR = OCO_CODCLI     '
  Else
    strSQL := strSQL + '   AND N.GER_CODCLI = OCO_CODCLI     ';
  strSQL := strSQL + '   AND M.GER_TIP_FC = OCO_TIP_FC       ';
  strSQL := strSQL + ' LEFT  JOIN CADTEA ON TEA_CODIGO = OCO_CODTEA ';

  strSQL := strSQL + ' WHERE OCO_TIP_FC = ' + QuotedStr(FTip_Fc);

  strSQL := strSQL + fStrLocate(edtCodGat, arrGruAti, 'ATI_CODGAT', 'CODGAT');
  strSQL := strSQL + fStrLocate(edtCodAti, arrCodAti, 'ATI_CODATI', 'CODATI');
  strSQL := strSQL + fStrLocate(edtCodCli, arrCodCli, 'OCO_CODCLI', 'CODCLI');

  {Filtro Cidade}
  If (FTip_Fc = 'P') Then
    strSQL := strSQL + fStrLocate(edtCodCid, arrCodCid, 'PRO_CODCID', 'CODCID')
  Else
  If (FTip_Fc = 'C')  Then
    strSQL := strSQL + fStrLocate(edtCodCid, arrCodCid, 'CLI_CODCID', 'CODCID')
  Else
  If (Not fEmptyStr(edtCodCid.Text)) Then
    strSQL := strSQL + fStrLocate(edtCodCid, arrCodCid, 'FOR_CODCID', 'CODCID');

  //Operador Origem
  If Not fEmptyStr(edtOpeOco.Text) Then
  Begin
    strSQL := strSQL + 'AND ';

    strSQL := strSQL + IIF(cxIncluirHistoricoOpeOrig.checked, '(', '');

    strSQL := strSQL + fStrLocate(edtOpeOco, arrOpeOco, 'OCO_OPEOCO', 'OPEOCO', True);

    If cxIncluirHistoricoOpeOrig.checked Then
      strSQL := strSQL + ' OR (SELECT COUNT(HIS_CODOCO) FROM HISOCO WHERE HIS_CODEMP = OCO_CODEMP AND HIS_CODOCO = OCO_CODOCO '+fStrLocate(edtOpeOco, arrOpeOco, 'HIS_OPEHIS', 'OPEOCO')+') > 0 )';
  End;

  //Operador Destino
  If Not fEmptyStr(edtCodOpe.Text) Then
  Begin
    strSQL := strSQL + ' AND ';

    strSQL := strSQL + IIF(cxIncluirHistoricoOpeDest.checked, '(', '');

    strSQL := strSQL + fStrLocate(edtCodOpe, arrCodOpe, 'OCO_CODOPE', 'CODOPE', True) ;

    If cxIncluirHistoricoOpeDest.checked Then
      strSQL := strSQL + ' OR (SELECT COUNT(HIS_CODOCO) FROM HISOCO WHERE HIS_CODEMP = OCO_CODEMP AND HIS_CODOCO = OCO_CODOCO '+fStrLocate(edtCodOpe, arrCodOpe, 'HIS_CODOPE', 'CODOPE')+') > 0 )';
  End;

  If Not fEmptyStr(edtCodDep.Text) Then
    strSQL := strSQL + fStrLocate(edtCodDep, arrCodDep, 'CODOPE.OPE_CODDEP', 'CODDEP');

  If Not fEmptyStr(edtCodQua.Text) And (FTip_Fc = 'C') Then
  Begin
    strSQL := strSQL + ' AND ' + fMontaCondicaoQualificacao;
  End;

  If Not fEmptyStr(edtCodGoc.Text) Then
    strSQL := strSQL + fStrLocate(edtCodGoc, arrCodGoc, 'GOC_CODGOC', 'CODGOC');

  If fCfgSis('VGOCOP', varBoolean) Then
    strSQL := strSQL + fRetSQLVerificaDireitoAcessoGrupoOcorrencias;

  If Not fEmptyStr(edtCodToc.Text) Then
    strSQL := strSQL + fStrLocate(edtCodToc, arrCodToc, 'TOC_CODTOC', 'CODTOC');

  If Not fEmptyStr(edtCodCoc.Text) Then
    strSQL := strSQL + fStrLocate(edtCodCoc, arrCodCoc, 'COC_CODCOC', 'CODCOC');

  If (edtCodCat.Visible) And (Not fEmptyStr(edtCodCat.Text)) Then
    strSQL := strSQL + fStrLocate(edtCodCat, arrCodCat, 'CAT_CODIGO', 'CODCAT');

  if (not fEmptyStr(mskDtaIni.Text) And (mskDtaIni.Text <> '  /  /    ')) And
     (not fEmptyStr(mskDtaFin.Text) And (mskDtaFin.Text <> '  /  /    ')) then
    strSQL := strSQL + ' AND OCO_DTAINC BETWEEN :DTAINI AND :DTAFIN '
  else if not fEmptyStr(mskDtaIni.Text) And (mskDtaIni.Text <> '  /  /    ') then
    strSQL := strSQL + ' AND OCO_DTAINC = :DTAINI '
  else if not fEmptyStr(mskDtaFin.Text) And (mskDtaFin.Text <> '  /  /    ') then
    strSQL := strSQL + ' AND OCO_DTAINC = :DTAFIN ';

  If (Not fEmptyDate(mskDtaIniAg.Text)) And (Not fEmptyDate(mskDtaFinAg.Text)) Then
    strSQL := strSQL + ' AND OCO_DTAAGE BETWEEN :DTAIAG AND :DTAFAG '
  Else If (Not fEmptyDate(mskDtaIniAg.Text)) Then
    strSQL := strSQL + ' AND OCO_DTAAGE = :DTAIAG '
  Else If (Not fEmptyDate(mskDtaFinAg.Text)) Then
    strSQL := strSQL + ' AND OCO_DTAAGE = :DTAFAG ';

  If (Not fEmptyDate(mskDtaIniFlx.Text)) And (Not fEmptyDate(mskDtaFinFlx.Text)) Then
    strSQL := strSQL + ' AND (OCO_CODOCO, OCO_CODEMP) = ANY(SELECT HIS_CODOCO, HIS_CODEMP FROM HISOCO WHERE HIS_DTAINC BETWEEN :DTAIFX AND :DTAFFX) '
  Else If (Not fEmptyDate(mskDtaIniFlx.Text)) Then
    strSQL := strSQL + ' AND (OCO_CODOCO, OCO_CODEMP) = ANY(SELECT HIS_CODOCO, HIS_CODEMP FROM HISOCO WHERE HIS_DTAINC = :DTAIFX) '
  Else If (Not fEmptyDate(mskDtaFinFlx.Text)) Then
    strSQL := strSQL + ' AND (OCO_CODOCO, OCO_CODEMP) = ANY(SELECT HIS_CODOCO, HIS_CODEMP FROM HISOCO WHERE HIS_DTAINC = :DTAFFX) ';

  if cbStatus.ItemIndex = 1 then //Em aberto
    strSQL := strSQL + ' AND OCO_DTACON IS NULL AND OCO_HORCON IS NULL '
  else if cbStatus.ItemIndex = 2 then //Concluida
    strSQL := strSQL + ' AND OCO_DTACON IS NOT NULL AND OCO_HORCON IS NOT NULL ';

  if not fEmptyStr(edtAutDev.Text) then
    strSQL := strSQL + ' AND GER_CODADE = :AUTDEV ';

  if not fEmptyStr(edtProtoc.Text) then
    strSQL := strSQL + ' AND OCO_PROTOC = :PROTOC ';

  {*REQ*139463**********RP*}
  If edtEntrCD.Visible Then
  Begin
    If (edtEntrCD.Text = 'S') Then
      strSQL := strSQL + ' AND OCO_CODTOC = "'+ fCfgSis('VENPED') +'" AND FGO_ENT_CD = "S" ';
  End;

  If not fEmptyStr(edtEspecieDocumento.Text) Then
  Begin
    If Pos(edtEspecieDocumento.Text, 'OR_PD_') > 0 Then
      strSQL := strSQL + ' AND FGO_NUMDOC = :NUMDOC '+
                         ' AND FGO_ESPDOC = :ESPDOC '
    Else
      strSQL := strSQL + ' AND FGO_NUMFAT = :NUMDOC '+
                         ' AND FGO_TIPFAT = :ESPDOC ';
  End;

  If Not fEmptyStr(edtCodDig.Text) Then
    strSQL := strSQL + ' AND (FGO_CODDIG = :CODDIG OR M.GER_CODDIG = :CODDIG) ';

  If Not fEmptyStr(edtAssunto.Text) Then
  Begin
    strSQL := strSQL + ' AND UPPER(OCO_ASSUNT) LIKE CONCAT("%", UPPER(:ASSUNT), "%") ';
  End;

  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    strSQL := strSQL + fStrLocate(edtCodEmp, arrCodEmp, 'OCO_CODEMP', 'CODEMP');
  End;

  If Not fEmptyStr(edtCodTea.Text) Then
    strSQL := strSQL + fStrLocate(edtCodTea, arrCodTea, 'OCO_CODTEA', 'CODTEA');

  strSQL := strSQL +' AND OCO_CODEMP IN (' +  fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

  strSQL := strSQL + ' ORDER BY OCO_TIP_FC, OCO_DTAINC, OCO_HORCON, OCO_CODEMP, OCO_CODTOC ';

  Result := strSQL;
end;

function TfrmConsultaOcorrenciasCRM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
      pCarregarCliente;
      If fEmptyStr(edtDesCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Código de '+ IfThen(strTip_FC = 'F','Fornecedor', 'CLIENTE' + IfThen(strTip_FC = 'C','', ' prospecto') ) + ' não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtCodAti) Then
    Begin
      If fEmptyStr(edtCodAti.Text) Then
      Begin
        edtDesAti.Text := 'TODAS';
      End;
      pDesmarcaLista(edtCodAti, ArrCodAti);
    End

    Else
    If (Sender = edtCodGat) Then
    Begin
      If fEmptyStr(edtCodGat.Text) Then
      Begin
        edtDesGat.Text := 'TODAS';
      End;
      pDesmarcaLista(edtCodGat, arrGruAti);
    End

    Else If (Sender = edtCodCid) Then
    Begin

      pCarregarCidade;
      If Not fEmptyStr(edtCodCid.Text) Then
      Begin
        If (fEmptyStr(edtNomCid.Text) and (Length(arrCodCid) >=1)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        If (Length(edtCodCid.Text) > 0) And (Length(edtCodCid.Text) < edtCodCid.MaxLength) Then
        Begin
          fMensagem('ATENÇÃO!', 'O código da cidade deve ter ' + IntToStr(edtCodCid.MaxLength) + ' caracteres!', ['&Ok']);
          Result := False;
        End
      End;

    End

    Else
    If (Sender = edtOpeOco) Then
    Begin
      pCarregarUsuarioOrigem;
      If (Not fEmptyStr(edtOpeOco.Text)) Then
      Begin
        If fEmptyStr(edtDesOpeOco.Text) Then
        Begin
          If blnLiberadoOpeOrig Then
            fMensagem('ATENÇÃO!', 'Esse Operador não está cadastrado!', ['&Ok'])
          Else
            fMensagem('ATENÇÃO!', 'Operador não encontrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        If blnLiberadoOpeOrig Then
          edtDesOpeOco.Text := 'TODOS'
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Operador Origem não pode ficar em branco!', ['&Ok']);
          pSetFocus(edtDesOpeOco);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtCodOpe) Then
    Begin
      pCarregarUsuarioDestino;
      If (Not fEmptyStr(edtCodOpe.Text)) Then
      Begin
        If fEmptyStr(edtDesCodOpe.Text) Then
        Begin
          If blnLiberadoOpeDest Then
            fMensagem('ATENÇÃO!', 'Esse Operador não está cadastrado!', ['&Ok'])
          Else
            fMensagem('ATENÇÃO!', 'Operador Destino não encontrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        If blnLiberadoOpeDest Then
          edtDesCodOpe.Text := 'TODOS'
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Operador Destino não pode ficar em branco!', ['&Ok']);
          pSetFocus(edtDesCodOpe);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodDep) Then
    Begin
      pCarregarDepOpeDest;
      If Not (fEmptyStr(edtCodDep.Text)) Then
      Begin
        If fEmptyStr(edtDesDep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodDig) Then
    Begin
      pCarregarDigitador;
      If Not fEmptyStr(edtCodDig.Text) Then
      Begin
        If fEmptyStr(edtNomDig.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Digitador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtCodQua) Then
    Begin
      pCarregarQualificacao;
      If Not fEmptyStr(edtCodQua.Text) Then
      Begin
         If fEmptyStr(edtDesQua.Text) Then
         Begin
           fMensagem('ATENÇÃO!', 'Esse Código de Qualificação não está cadastrado!', ['&Ok']);
           Result := False;
           edtCodQua.Clear;
         End;
      End;
    End

    Else
    If (Sender = edtCodGoc) Then
    Begin
      pCarregarGrupoOcorrencia;
      If Not fEmptyStr(edtCodGoc.Text) Then
      Begin
        If fEmptyStr(edtDesGoc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Grupo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
        If (fCfgSis('VGOCOP', varBoolean)) And (Not fVerificaDireitoAcessoGrupoOcorrencia(edtCodGoc.Text)) Then
        Begin
          Result := False;
          fMensagem('', 'Usuário sem permissão para utilizar este grupo de ocorrência!', ['&Ok']);
        End;
      End;
    End

    Else
    If (Sender = edtCodToc) Then
    Begin
      pCarregarTipoOcorrencia;
      If Not fEmptyStr(edtCodToc.Text) Then
      Begin
        If fEmptyStr(edtDesToc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Tipo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtCodCoc) Then
    Begin
      pCarregarComplementoOcorrencia;
      If Not fEmptyStr(edtCodCoc.Text) Then
      Begin
        If fEmptyStr(edtDesCoc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Complemento de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = mskDtaIni) Then
    Begin

      If ((Not fEmptyDate(mskDtaIni.Text)) And (Not fVerificaDataValida(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe uma data válida!', ['&Ok']);
        Result := False;
      End;

      If Result And
         (Not fEmptyDate(mskDtaIni.Text)) And
         (Not fEmptyDate(mskDtaFin.Text)) And
         fVerificaDataValida(mskDtaFin.Text) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;

    End

    Else
    If (Sender = mskDtaFin) Then
    Begin
      If ((Not fEmptyDate(mskDtaFin.Text)) And (Not fVerificaDataValida(mskDtaFin.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe uma data válida!', ['&Ok']);
        Result := False;
      End;

      If Result And
         (Not fEmptyDate(mskDtaIni.Text)) And
         (Not fEmptyDate(mskDtaFin.Text)) And
         fVerificaDataValida(mskDtaIni.Text) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = mskDtaIniAg) Or (Sender = mskDtaFinAg)Then
    Begin
      If ((Not fEmptyDate(mskDtaIniAg.Text)) And (Not fVerificaDataValida(mskDtaIniAg.Text)) And (Sender = mskDtaIniAg)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe uma data válida!', ['&Ok']);
        Result := False;
      End;

      If ((Not fEmptyDate(mskDtaFinAg.Text)) And (Not fVerificaDataValida(mskDtaFinAg.Text)) And (Sender = mskDtaFinAg)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe uma data válida!', ['&Ok']);
        Result := False;
      End;

      If Result And
         (Not fEmptyDate(mskDtaIniAg.Text)) And (Not fEmptyDate(mskDtaFinAg.Text)) And
         fVerificaDataValida(mskDtaIniAg.Text) And
         fVerificaDataValida(mskDtaFinAg.Text) And
         (StrToDate(mskDtaIniAg.Text) > StrToDate(mskDtaFinAg.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial do Agendamento não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    If (Sender = mskDtaIniFlx) Or (Sender = mskDtaFinFlx)Then
    Begin
      If ((Not fEmptyDate(mskDtaIniFlx.Text)) And (Not fVerificaDataValida(mskDtaIniFlx.Text)) And (Sender = mskDtaIniFlx)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe uma data válida!', ['&Ok']);
        Result := False;
      End;

      If ((Not fEmptyDate(mskDtaFinFlx.Text)) And (Not fVerificaDataValida(mskDtaFinFlx.Text)) And (Sender = mskDtaFinFlx)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe uma data válida!', ['&Ok']);
        Result := False;
      End;

      If Result And
         (Not fEmptyDate(mskDtaIniFlx.Text)) And (Not fEmptyDate(mskDtaFinFlx.Text)) And
         fVerificaDataValida(mskDtaIniFlx.Text) And
         fVerificaDataValida(mskDtaFinFlx.Text) And
         (StrToDate(mskDtaIniFlx.Text) > StrToDate(mskDtaFinFlx.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial do Fluxo não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodCat) And edtCodCat.Visible Then
    Begin
      pCarregarCategoria;
      If Not fEmptyStr(edtCodCat.Text) Then
      Begin

        If fEmptyStr(edtDesCat.Text) Then
        Begin
          fMensagem('', 'Categoria não encontrada!', ['&Ok']);
          edtDesCat.Clear;
          Result := False;
        End;

      End;

    End

    Else if (Sender = edtEntrCD) Then
    Begin
      If Pos(edtEntrCD.Text, 'SN') = 0 Then
      Begin
        fMensagem('', 'Entrega pelo CD deve ser preenchido com S ou N!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      pCarregarEmpresa;
      If (Not SameText(edtCodEmp.Text, '000')) and (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodTea) And edtCodTea.Visible Then
    Begin
      pCarregarCorTemperaturaAtend;
      If Not fEmptyStr(edtCodTea.Text) Then
      Begin
        If fEmptyStr(edtDesTea.Text) Then
        Begin
          fMensagem('', 'Temperatura de atendimento não encontrada!', ['&Ok']);
          edtDesTea.Clear;
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmConsultaOcorrenciasCRM.fValidaCamposParaCarregar(blnExibirMensagem: Boolean): Boolean;
var
  blnExibirMensagemAoUsuario: Boolean;
begin
  blnExibirMensagemAoUsuario := VS_ExibirMensagemAoUsuario;
  VS_ExibirMensagemAoUsuario := blnExibirMensagem;
  Try
    Result := fVerificaCampos;
  Finally
    VS_ExibirMensagemAoUsuario := blnExibirMensagemAoUsuario;
  End;
end;

function TfrmConsultaOcorrenciasCRM.fValidarIndiceListView(
  intIndice: Integer): Boolean;
begin
  If ((intIndice > -1) and (intIndice <= ListViewCalendario.Items.Count-1)) Then
    Result := True
  Else
    Result := False;
end;

function TfrmConsultaOcorrenciasCRM.getTip_Fc: String;
begin
  Result := FTip_Fc;
end;

procedure TfrmConsultaOcorrenciasCRM.mnuAbrirLeadClick(Sender: TObject);
begin
  inherited;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  If Not fEmptyStr(FObjLeads.strAutInc) Then
  Begin
    TfrmCadLeads.fCadLeads(pChamaOrcamento, FObjLeads);
      pAtualizaDadosGridOcorrencia();
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.mnuAbrirOcorrenciaClick(Sender: TObject);
 Var
    LCodGoc: String;
begin
  inherited;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  try
    pTrataExibirMenus();
    pIncluirNovoHistoricoOcorrencia(cdsOcorrencias.FieldByName('OCO_CODOCO').AsString,
                                    cdsOcorrencias.FieldByName('OCO_PROTOC').AsString,
                                    strTip_Fc,
                                    cdsOcorrencias.FieldByName('OCO_CODCLI').AsString,
                                    cdsOcorrencias.FieldByName('OCO_CODEMP').AsString,
                                    cdsOcorrencias.FieldByName('OCO_CODSIT').AsString,
                                    cdsOcorrencias.FieldByName('OCO_DTALIM').AsDateTime,
                                    mnuEfetivarOrcamento.Visible,
                                    mnuGerarVendaPerdida.Visible,
                                    LCodGoc);
    pAtualizaDadosGridOcorrencia();
  except
     On E: Exception Do
      pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.mnuAbrirOcorrenciaClick]');
  end;
end;

procedure TfrmConsultaOcorrenciasCRM.mnuAlterarDocumentoClick(Sender: TObject);
  Var
    popMenu: TPopupMenu;
begin
  inherited;
  pExibirAlterar();

  If cdsOcorrencias.IsEmpty Or
    (Not mnuAlterarDocumento.Visible) Then
    Exit;


  popMenu := nil;

  If (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) > 0) Then
    popMenu := popPedido
  Else If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) > 0) Then
    popMenu := popOrcamento;

  If Assigned(popMenu) Then
  Begin
    pAlterarDocumento(cdsOcorrenciasDOCUMENTO.AsString,
                      cdsOcorrenciasOCO_CODCLI.AsString,
                      popMenu,
                      (strTipFil = 'P'));

    pAtualizaDadosGridOcorrencia();
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.mnuAnaliseCreditoDEPSClick(
  Sender: TObject);
begin
  inherited;
  If (Not mnuAnaliseCreditoDEPS.Visible) Or
     (Not mnuAnaliseCreditoDEPS.Enabled) Then
    Exit;

  If Not fEmptyStr(cdsOcorrenciasFGO_NUMFAT.AsString) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível realizar o envio da análise, pois o documento já foi transformado em Pedido de Venda.', ['&OK']);
    Exit;
  End;

  If Not fEmptyStr(cdsOcorrenciasMOTBAI.AsString) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível realizar o envio da análise, pois o documento foi baixado.', ['&OK']);
    Exit;
  End;

  If Pos(cdsOcorrenciasSTATUSDEPS.AsString, 'APROVADO_DISPENSA ANÁLISE_') > 0 Then
  Begin
    If cdsOcorrenciasSTATUSDEPS.AsString = 'APROVADO' Then
      fMensagem('ATENÇÃO', 'Orçamento já aprovado.', ['&OK'])
    Else
      fMensagem('ATENÇÃO', 'Não será necessário a aprovação de crédito. Orçamento já está liberado para faturamento.', ['&OK']);

    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Tem certeza que deseja enviar o documento para a análise de crédito do Sistema DEPS?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  Try
    fStartTransaction;
    If TValidacoesSistemaDEPS.fAtualizaStatusSistemaDEPS(cdsOcorrenciasAUTOINCREMFATGOR.AsString,
                                                         'AGUARDANDO ANÁLISE') Then
    Begin
      cdsOcorrencias.Refresh;
    End;

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.mnuAnaliseCreditoDEPSClick]');
    End;

  End;
end;

procedure TfrmConsultaOcorrenciasCRM.mnuBaixarClick(Sender: TObject);
  Var
    strNumDoc : String;
    strEspDoc : String;
    strCodEmp : String;
    strAutInc : String;
    LEmpExp   : String;
begin
  inherited;
  pExibirBaixar();

  strNumDoc := LeftStr(cdsOcorrenciasDOCUMENTO.AsString, 12);
  strEspDoc := Copy(cdsOcorrenciasDOCUMENTO.AsString, 14, 2);
  strCodEmp := RightStr(cdsOcorrenciasDOCUMENTO.AsString, 3);

  If Not mnuBaixar.Visible Then
    Exit;

  If (strEspDoc = 'PD') Then
  Begin
    strAutInc := fCampoTabela('AUTOINCREM', 'FATGOR', ['FGO_NUMDOC', 'FGO_CODEMP', 'FGO_ESPDOC'], [strNumDoc, strCodEmp, strEspDoc]);
    LEmpExp := fCampoTabela('FGO_EMPEXP', 'EXTGOR', ['FGO_SEQFGO'], [strAutInc]);

    If ((Not fVerificaAcessoSistema('CANPDA')) or fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO(LEmpExp)) And (fPedidoExpedido(strAutInc)) Then
    Begin
      fMensagem('Atenção!', 'Pedido expedido, para efetuar a baixa é necessário cancelar a expedição.', ['&Ok']);
      Exit;
    End
  End;

  If fBaixarPedOrcNaoEntregue(strNumDoc,
                              strEspDoc,
                              strCodEmp,
                              True) then
  Begin
    pAtualizaDadosGridOcorrencia();
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.mnuDesmembrarClick(Sender: TObject);
begin
  inherited;
  pExibirDesmembrar();

  If (Not mnuDesmembrar.Visible) Then
    Exit;

  If fDesmembrarPedOrc(cdsOcorrenciasDOCUMENTO.AsString) Then
    pAtualizaDadosGridOcorrencia();
end;

procedure TfrmConsultaOcorrenciasCRM.mnuEfetivarOrcamentoClick(Sender: TObject);
begin
  inherited;
  pExibirEfetivarOrcamento;

  If Not mnuEfetivarOrcamento.Visible Then
    Exit;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  If (blnUtilizaSistemaDEPS) And
   (Pos(cdsOcorrenciasSTATUSDEPS.AsString, 'APROVADO_DISPENSA ANÁLISE_') <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Necessária a aprovação de crédito do sistema DEPS para a efetivação.' + #13 +
                         'Status DEPS: ' + cdsOcorrenciasSTATUSDEPS.AsString, ['&OK']);
    Exit;
  End;

  If fEfetivarOrcamentoEmPedido(cdsOcorrenciasDOCUMENTO.AsString,
                                IIF(FAcessoCadPro And (FTip_Fc = 'P'), cdsOcorrenciasFGOCLI.AsString, cdsOcorrenciasOCO_CODCLI.AsString)) Then
    pAtualizaDadosGridOcorrencia();
end;

procedure TfrmConsultaOcorrenciasCRM.mnuEnviarBolEmail(Sender: TObject);
begin
  inherited;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  pImprimeBoleto(Self,
                 cdsOcorrencias.FieldByName('OCO_CODEMP').AsString,
                 cdsOcorrencias.FieldByName('OCO_ESPDOC').AsString,
                 cdsOcorrencias.FieldByName('OCO_CODCLI').AsString,
                 cdsOcorrencias.FieldByName('OCO_NUMDOC').AsString,
                 cdsOcorrencias.FieldByName('OCO_PARCEL').AsString);
end;

procedure TfrmConsultaOcorrenciasCRM.mnuEnviarEmailClick(Sender: TObject);
begin
  inherited;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  pEnviarEmail(Self,
               cdsOcorrenciasDOCUMENTO.AsString,
               cdsOcorrenciasOCO_CODCLI.AsString,
               cdsOcorrenciasCLI_NOMCLI.AsString,
               cdsOcorrenciasCLI_EMAIL_.AsString);
end;

procedure TfrmConsultaOcorrenciasCRM.mnuFaturarEmVendaNormalClick(
  Sender: TObject);
var
  strNumDoc,
  strEspDoc : String;
begin

  inherited;

  pExibirFaturarEmVendaNormal;

  If Not mnuFaturarEmVendaNormal.Visible Then
    Exit;

  strNumDoc := LeftStr(cdsOcorrenciasDOCUMENTO.AsString, 12);
  strEspDoc := Copy(cdsOcorrenciasDOCUMENTO.AsString, 14, 2);

  If fEmptyStr(strNumDoc) Then
    Exit;

  If fEmptyStr(strEspDoc) Then
    Exit;

  If fVerificaAcessoSistema('CRMVDN') Then
  Begin

    If (mnuFaturarEmVendaNormal.Enabled) And (not fEmptyStr(cdsOcorrenciasOCO_CODCLI.AsString)) then
    Begin
      pChamaFaturamento_PD_OR_Em_VendaNormal(PopVendaNormal,
                                             cdsOcorrenciasOCO_CODCLI.AsString,
                                             cdsOcorrenciasOCO_C_P_F_.AsString,
                                             strNumDoc,
                                             strEspDoc);
      pAtualizaDadosGridOcorrencia;
    End;

  End
  Else
    fMensagem('ATENÇÃO!','Usuário logado não tem direito de acesso a esse botão!', ['&OK']);

end;

procedure TfrmConsultaOcorrenciasCRM.mnuGerarPDFClick(Sender: TObject);
begin
  inherited;
  If cdsOcorrencias.IsEmpty Then
    Exit;

  pGerarPDF(cdsOcorrenciasDOCUMENTO.AsString);
end;

procedure TfrmConsultaOcorrenciasCRM.mnuGerarVendaPerdidaClick(Sender: TObject);
begin
  inherited;
  pExibirGerarVendaPerdida;

  If Not mnuGerarVendaPerdida.Visible Then
    Exit;

  If fCfgSis('VNPEIT', varBoolean) Then
    pGerarVendaPerdidaSelItens
  Else
    pGerarVendaPerdida(cdsOcorrenciasDOCUMENTO.AsString);


  pAtualizaDadosGridOcorrencia();
end;

procedure TfrmConsultaOcorrenciasCRM.mnuLimparSeparacaoClick(Sender: TObject);
begin
  inherited;

  Try
    If Not mnuLimparSeparacao.Visible Then
      Exit;

    If fLimpaExpedicaoPedido(cdsOcorrenciasAUTOINCREMFATGOR.AsString) Then
    Begin
      pAtualizaDadosGridOcorrencia;
      pMensagemOk('Operação realizada com sucesso.');
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.message, 'TfrmConsultaOcorrenciasCRM.mnuLimparSeparacaoClick');
    End;
  End;

end;

procedure TfrmConsultaOcorrenciasCRM.mnuModificarCategoriaClick(
  Sender: TObject);
var
  chrKey        : Char;
  arrCategorias : TConsultasArray;
  qryAtuCat     : TUniQuery;
begin
  pExibirModificarCategoria();

  If (Not mnuModificarCategoria.Visible) Then
    Exit;

  chrKey := '/';
  If fPesqCategoriaOrPd(Self, Nil, Nil, Nil, chrKey, arrCategorias, True, cdsOcorrencias.FieldByName('OCO_ESPDOC').asString) Then
  begin
    qryAtuCat := fCriaQuery;
    Try
      qryAtuCat.Close;
      qryAtuCat.SQL.Text := 'UPDATE EXTGOR SET FGO_CODCAT = ' + QuotedStr(fStrZero(arrCategorias[0].strCodigo,6)) + ' WHERE FGO_SEQFGO = '+ cdsOcorrencias.FieldByName('AUTOINCREMFATGOR').asString;
      qryAtuCat.ExecSQL;
      pCarregarDados;
    Finally
      FreeAndNil(qryAtuCat);
    End;
  end;
end;

procedure TfrmConsultaOcorrenciasCRM.mnuReimprimirClick(Sender: TObject);
  Var
    strNomeArquivo: String;
begin
  inherited;
  If (Not cdsOcorrencias.IsEmpty) And
     (Not fEmptyStr(cdsOcorrenciasDOCUMENTO.AsString)) Then
  Begin
    pImprimeFatImp('FATGOR',
                   LeftStr(cdsOcorrenciasDOCUMENTO.AsString, 12),
                   Copy(cdsOcorrenciasDOCUMENTO.AsString, 14, 02),
                   Copy(cdsOcorrenciasDOCUMENTO.AsString, 17, 03),
                   cdsOcorrenciasOCO_CODCLI.AsString,
                   'C',
                   '',
                   True,
                   strNomeArquivo,
                   False);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pAtualizaDadosGridOcorrencia(const blnCarregarOcorrencia: Boolean = True; blnExibirTrava: Boolean = True);
begin
  pCarregarDados(blnExibirTrava);

  If FTipoExibicaoDados = tpCalendario Then
  Begin
    If blnCarregarOcorrencia Then
    Begin
      Application.ProcessMessages;
      pCarregaOcorrenciaDataSelecionada;
      pFocaOcorrenciaAgendamento;
    End
    Else
    If FCalendario.CanFocus then
      pSetFocus(FCalendario);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarCategoria;
begin
  If fEmptyStr(edtCodCat.Text) Then
  Begin
    edtDesCat.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodCat) > 1 Then
  Begin
    edtDesCat.Text := '+1';
  End
  Else
  Begin
    edtDesCat.Text := fRetDescCatego(edtCodCat.Text);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarCidade;
begin

  If fEmptyStr(edtCodCid.Text) Then
  Begin
    edtNomCid.Text := 'TODOS';
    edtEstado.Clear;
    Exit;
  End;

  If Length(arrCodCid) > 1 Then
  Begin
    edtNomCid.Text := '+1';
    edtEstado.Text := '+1';
  End
  Else
  Begin
    pEdtCodSelectExit(edtCodCid, edtNomCid, arrCodCid, Nil, fRetCidade, 'da Cidade');
    edtEstado.Text := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [edtCodCid.Text], False);
  End;

end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarCliente;
begin
  If fEmptyStr(edtCodCli.Text) Then
  Begin
    edtDesCli.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodCli) > 1 Then
  Begin
    edtDesCli.Text := '+1';
  End
  Else
  Begin
    If strTip_FC = 'P' Then
      pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, fRetNomProspectoATIVO, Nil, 'do Prospecto')
    Else
    If strTip_Fc = 'C' Then
      pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, Nil, fRetNomCliente, 'do Cliente')
    Else
      pEdtCodSelectExit(edtCodCli, edtDesCli, arrCodCli, fRetNomFornecedor, Nil, 'do Fornecedor');
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarComplementoOcorrencia;
begin
  If fEmptyStr(edtCodCoc.Text) Then
  Begin
    edtDesCoc.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodCoc) > 1 Then
  Begin
    edtDesCoc.Text := '+1';
  End
  Else
  Begin
    pPesquisaCadCoc(qryTabela, qryCadCoc, edtCodCoc.Text, edtCodToc.Text);
    edtDesCoc.Text := qryCadCoc.FieldByName('COC_DESCOC').AsString;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarCorTemperaturaAtend;
begin
  If fEmptyStr(edtCodTea.Text) Then
  Begin
    edtDesTea.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodTea) > 1 Then
    edtDesTea.Text := '+1'
  Else
    edtDesTea.Text := fCampoTabela('TEA_DESCRI', 'CADTEA', ['TEA_CODIGO'], [edtCodTea.Text], False);
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarQualificacao;
begin
  If fEmptyStr(edtCodQua.Text) Then
  Begin
    edtDesQua.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodQua) > 1 Then
  Begin
    edtDesQua.Text := '+1';
  End
  Else
  Begin
    edtDesQua.Text := fCampoTabela('QUA_DESQUA', 'CADQUA', ['QUA_CODQUA'], [edtCodQua.Text], False);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarDados(const blnExibirMensagemTrava: Boolean = True);
begin
  FLiberarAjusteListView := False;

  FCarregandoOcorrencias := True;
  Try
    If Not fVerificaPodeCarregarDados(blnExibirMensagemTrava) Then
    Begin
      If FExibirAlertaCodCli Then
      Begin
        fValidaCampos(edtCodCli, True);
      End;

      If FExibirAlertaCodCid Then
      Begin
        fValidaCampos(edtCodCid, True);
      End;

      Exit;
    End;


    TfrmGravando.fExecutarModal(pConsultaOcorrencias, 'Aguarde carregando ocorrências....', 'ConsultaOcorrenciasCRM');

    If FTipoExibicaoDados = tpGrid Then
      pCarregaHistoricoOcorrencia;

    If FTipoExibicaoDados = tpCalendario Then
    Begin
      FCalendario.pAtualizarCalendario(cdsOcorrencias);
      FCalendario.UpdateCalendar;
      If FCalendario.CanFocus then
        pSetFocus(FCalendario);
    End
    Else Begin
      If not cdsOcorrencias.IsEmpty then
      Begin
        pHabilitaBotoesPanelInferior;
        pSetFocus(dbgOcorrencias);
        dbgOcorrenciasDBTableView1.DataController.FocusedRowIndex := 0;
        pTrataBotoesAgregados;
        pCarregaHistoricoOcorrencia;
      End
      Else
      Begin
        pDesabilitaBotoesPanelInferior;
        If cdsHisOco.Active Then
          cdsHisOco.Close;
      End;

    End;

  Finally
    FCarregandoOcorrencias := False;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarDepOpeDest;
begin
  If fEmptyStr(edtCodDep.Text) Then
  Begin
    edtDesDep.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodDep) > 1 Then
  Begin
    edtDesDep.Text := '+1';
  End
  Else
  Begin
    edtDesDep.Text := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[edtCodDep.Text]);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    If length(arrCodEmp) > 1 Then
    Begin
      edtNomEmp.Text := '+1';
    End
    Else
      edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text)
  End
  Else
    edtNomEmp.Text := 'TODOS';
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarGrupoOcorrencia;
begin
  If fEmptyStr(edtCodGoc.Text) Then
  Begin
    edtDesGoc.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodGoc) > 1 Then
  Begin
    edtDesGoc.Text := '+1';
  End
  Else
  Begin
    pPesquisaCadGOc(nil, qryCadGoc, edtCodGoc.Text);
    edtDesGoc.Text := qryCadGoc.FieldByName('GOC_DESGOC').AsString;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregaHistoricoOcorrencia;
begin
  cdsHisOco.qryQuery.SQL.Clear;
  cdsHisOco.qryQuery.SQL.Add(fRetornaSQLHistoricoOcorrencias);
  cdsHisOco.qryQuery.ParamByName('CODOCO').AsString := cdsOcorrencias.FieldByName('OCO_CODOCO').AsString;
  cdsHisOco.qryQuery.ParamByName('CODEMP').AsString := cdsOcorrencias.FieldByName('OCO_CODEMP').AsString;
  cdsHisOco.qryQuery.ParamByName('CODCLI').AsString := cdsOcorrencias.FieldByName('OCO_CODCLI').AsString;
  cdsHisOco.fAbreClient(True, 'TfrmConsultaOcorrenciasCRM.pCarregaHistoricoOcorrencia');
  cxTableViewHisOco.DataController.DataSource := cdsHisOco.dtsSource;

  If FTipoExibicaoDados = tpGrid Then
  Begin
    If Not cdsHisOco.IsEmpty Then
    Begin
      cxTableViewHisOco.BeginUpdate;
      HisOcoColumnDESCRI.Visible := False;
      Try
        cxTableViewHisOco.ApplyBestFit();
      Finally
        HisOcoColumnDESCRI.Width := 32;
        HisOcoColumnDESCRI.Visible := True;
        cxTableViewHisOco.EndUpdate;
      End;
    End
  End;

  HisOcoColumnDESCRI.Width := 32;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarTipoOcorrencia;
begin
  If fEmptyStr(edtCodToc.Text) Then
  Begin
    edtDesTOc.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodToc) > 1 Then
  Begin
    edtDesTOc.Text := '+1';
  End
  Else
  Begin
    pPesquisaCadToc(qryTabela, qryCadToc, edtCodToc.Text, edtCodGoc.Text, False);
    edtDesTOc.Text := qryCadToc.FieldByName('TOC_DESTOC').AsString;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarUsuarioDestino;
begin
  If fEmptyStr(edtCodOpe.Text) Then
  Begin
    edtDesCodOpe.Text := 'TODOS';
    Exit;
  End;

  If Length(arrCodOpe) > 1 Then
  Begin
    edtDesCodOpe.Text := '+1';
  End
  Else
  Begin
    pPesquisaCadOpe(qryTabela, qryCadOpe, edtCodOpe.Text, Not blnLiberadoOpeDest);
    edtDesCodOpe.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString;
    strCodOpeDest     := qryCadOpe.FieldByName('OPE_CODOPE').AsString;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarUsuarioOrigem;
begin
  If fEmptyStr(edtOpeOco.Text) Then
  Begin
    edtDesOpeOco.Text := 'TODOS';
    Exit;
  End;

  If Length(arrOpeOco) > 1 Then
  Begin
    edtDesOpeOco.Text := '+1';
  End
  Else
  Begin
    pPesquisaCadOpe(qryTabela, qryCadOpe, edtOpeOco.Text, Not blnLiberadoOpeOrig);
    edtDesOpeOco.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString;
    strCodOpeOrig     := qryCadOpe.FieldByName('OPE_CODOPE').AsString;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pConfiguraIcones(
  cxView: TcxGridDBTableViewCitel);
var
  item: TcxImageComboBoxItem;
  coluna: TcxGridDBColumn;
  strKey: String;
begin
  coluna := cxView.GetColumnByFieldName('STATUS');

  If Assigned(coluna) Then
  Begin
    With coluna Do
    begin
      Visible         := True;
      Width           := 25;
      Index           := 0;
      SortIndex       := -1;
      Options.Editing := False;

      If Not SameText(PropertiesClassName, 'TcxImageComboBoxProperties') Then
      Begin
        PropertiesClass := TcxImageComboBoxProperties;

        With TcxImageComboBoxProperties(Properties) Do
        Begin
          Images := frmModuloLegenda.imglLegenda;
          For strKey In TSituacaoPedidoVenda.fRetornaLegendaCompleta.Keys Do
          Begin
            item := Items.Add;
            item.ImageIndex := TSituacaoPedidoVenda.fRetornaLegendaCompleta.Items[strKey];
            item.Value      := strKey;
            item.Description:= item.Value;
          End;
        End;
      End;
    End;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pSetarParametroOperadorOrigem;
var
  strCodOpeAux: String;
Begin
  If blnLiberadoOpeOrig Then
    strCodOpeAux := edtOpeOco.text
  Else
    strCodOpeAux := strCodOpeOrig;

  If fEmptyStr(strCodOpeAux) Then
    Exit;

  If Not fMultiSelecaoOperadorOrigem Then
  Begin
    qryOcorrencias.ParamByName('OPEOCO').AsString := strCodOpeAux;
  End
  Else
    pSetaParam(strCodOpeAux, arrOpeOco, strCnsOpeOco, 'OPEOCO', qryOcorrencias);
End;

procedure TfrmConsultaOcorrenciasCRM.pSetarParametroOperadorDestino;
var
  strCodOpeAux: String;
Begin
  If blnLiberadoOpeDest Then
    strCodOpeAux := edtCodOpe.text
  Else
    strCodOpeAux := strCodOpeDest;

  If fEmptyStr(strCodOpeAux) Then
    Exit;

  If Not fMultiSelecaoOperadorDestino Then
  Begin
    qryOcorrencias.ParamByName('CODOPE').AsString := strCodOpeAux;
  End
  Else
    pSetaParam(strCodOpeAux, arrCodOpe, strCnsCodOpe, 'CODOPE', qryOcorrencias);
End;

procedure TfrmConsultaOcorrenciasCRM.pConsultaOcorrencias;
begin
  with qryOcorrencias do
  begin
    cdsOcorrencias.Close;
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLConsulta);

    if not fEmptyStr(edtCodCli.Text) then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

    pSetaParam(edtCodGat.Text, arrGruAti, strCnsGruAti, 'CODGAT', qryOcorrencias);
    pSetaParam(edtCodAti.Text, arrCodAti, strCnsCodAti, 'CODATI', qryOcorrencias);

    pSetaParam(edtCodCli.Text, arrCodCli, strCnsCodCli, 'CODCLI', qryOcorrencias);
    pSetaParam(edtCodGat.Text, arrGruAti, strCnsGruAti, 'CODGAT', qryOcorrencias);
    pSetaParam(edtCodAti.Text, arrCodAti, strCnsCodAti, 'CODATI', qryOcorrencias);
    pSetaParam(edtCodCid.Text, arrCodCid, strCnsCodCid, 'CODCID', qryOcorrencias);

    pSetarParametroOperadorOrigem;
    pSetarParametroOperadorDestino;

    pSetaParam(edtCodDep.Text, arrCodDep, strCnsCodDep, 'CODDEP', qryOcorrencias);
    pSetaParam(edtCodGoc.Text, arrCodGoc, strCnsCodGoc, 'CODGOC', qryOcorrencias);
    pSetaParam(edtCodToc.Text, arrCodToc, strCnsCodToc, 'CODTOC', qryOcorrencias);
    pSetaParam(edtCodCoc.Text, arrCodCoc, strCnsCodCoc, 'CODCOC', qryOcorrencias);
    {Categoria Orçamento / Pedido}
    If (edtCodCat.Visible) And (Not fEmptyStr(edtCodCat.Text)) And (FTip_Fc = 'C') Then
      pSetaParam(edtCodCat.Text, arrCodCat, strCnsCodCat, 'CODCAT', qryOcorrencias);

    If (not fEmptyStr(mskDtaIni.Text) And (mskDtaIni.Text <> '  /  /    ')) And
       (not fEmptyStr(mskDtaFin.Text) And (mskDtaFin.Text <> '  /  /    ')) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End
    Else if not fEmptyStr(mskDtaIni.Text) And (mskDtaIni.Text <> '  /  /    ') Then
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text)
    Else if not fEmptyStr(mskDtaFin.Text) And (mskDtaFin.Text <> '  /  /    ') Then
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);

    If (Not fEmptyDate(mskDtaIniAg.Text)) Then
      ParamByName('DTAIAG').AsDateTime := StrToDate(mskDtaIniAg.Text);

    If (Not fEmptyDate(mskDtaFinAg.Text)) Then
      ParamByName('DTAFAG').AsDateTime := StrToDate(mskDtaFinAg.Text);

    If (Not fEmptyDate(mskDtaIniFlx.Text)) Then
      ParamByName('DTAIFX').AsDateTime := StrToDate(mskDtaIniFlx.Text);

    If (Not fEmptyDate(mskDtaFinFlx.Text)) Then
      ParamByName('DTAFFX').AsDateTime := StrToDate(mskDtaFinFlx.Text);

    If Not fEmptyStr(edtAutDev.Text) Then
      ParamByName('AUTDEV').AsString := edtAutDev.Text;

    If Not fEmptyStr(edtProtoc.Text) Then
      ParamByName('PROTOC').AsString := edtProtoc.Text;

    If not fEmptyStr(edtEspecieDocumento.Text) Then
    Begin
      ParamByName('NUMDOC').AsString := edtNumeroDocumento.Text;
      ParamByName('ESPDOC').AsString := edtEspecieDocumento.Text;
    End;

    If Not fEmptyStr(edtCodDig.Text) Then
      ParamByName('CODDIG').AsString := edtCodDig.Text;

    If Not fEmptyStr(edtAssunto.Text) Then
    Begin
      ParamByName('ASSUNT').AsString := edtAssunto.Text;
    End;

    pSetaParam(edtCodEmp.Text, arrCodEmp, strCnsCodEmp, 'CODEMP', qryOcorrencias);
    pSetaParam(edtCodTea.Text, arrCodTea, strCnsCodTea, 'CODTEA', qryOcorrencias);

    If fCfgSis('VGOCOP', varBoolean) Then
    Begin
      ParamByName('OPEGOC').AsString := strLoginUsuarioLogado;
    End;

    Open;
    pSetaClient(qryOcorrencias);
    cdsOcorrencias.Open;

    if FTipoExibicaoDados = tpGrid then
    Begin
      dbgOcorrencias.BeginUpdate;
      Try
        dbgOcorrenciasDBTableView1.ApplyBestFit();
      Finally
        dbgOcorrencias.EndUpdate;
      End;
    End;


    lblQtdOcoAbe.Caption := 'Total Em Aberto: ' + IntToStr(fIntAggregate(cdsOcorrencias, 'TOT_QTDABE')) + '   ' +
                            'Total Concluída: ' + IntToStr(fIntAggregate(cdsOcorrencias, 'TOT_QTDFEC')) + '   ' +
                            'Total: ' + IntToStr(fIntAggregate(cdsOcorrencias, 'TOT_QTDOCO'));


    tmrSistemaDEPS.Enabled := (fCfgSis('USADEP') = 'S') And
                              (Not cdsOcorrencias.IsEmpty);
  end;
end;

procedure TfrmConsultaOcorrenciasCRM.pDesabilitaBotoesPanelInferior;
begin
  btnConfirma.Enabled := False;
end;

procedure TfrmConsultaOcorrenciasCRM.pEnviarSemPerguntar;
  Var
    strEmailCliente: String;
    LQuery: TUniQuery;
    LSql: String;
begin
  LQuery := fCriaQuery();

  Try
    LSql := fRetornaSQLConsulta();

    LQuery.SQL.Add(Copy(LSql, 0, Pos('WHERE', LSql) - 1));
    LQuery.SQL.Add('WHERE OCO_CODOCO = :CODOCO');
    LQuery.ParamByName('CODOCO').AsString := cdsOcorrencias.FieldByName('OCO_CODOCO').AsString;
    LQuery.Open();

    If fOcorrenciaDevolucao(LQuery.FieldByName('OCO_CODTOC').AsString, FTip_Fc) Then
      strEmailCliente := fCampoTabela('CLI_EMAIL3', 'CADCLI', ['CLI_CODCLI'], [LQuery.FieldByName('OCO_CODCLI').AsString])
    Else
      strEmailCliente := LQuery.FieldByName('CLI_EMAIL_').AsString;

    pEnviarEmailSemPerguntar(Self,
                             strEmailCliente,
                             LQuery.FieldByName('OPE_E_MAIL').AsString,
                             LQuery.FieldByName('OCO_CODCLI').AsString,
                             LQuery.FieldByName('CLI_NOMCLI').AsString,
                             LQuery.FieldByName('GOC_CODGOC').AsString,
                             LQuery.FieldByName('GOC_DESGOC').AsString,
                             LQuery.FieldByName('OCO_DTAINC').AsString,
                             LQuery.FieldByName('OCO_HORINC').AsString,
                             LQuery.FieldByName('OCO_CODTOC').AsString,
                             LQuery.FieldByName('TOC_DESTOC').AsString,
                             LQuery.FieldByName('OCO_CODOPE').AsString,
                             LQuery.FieldByName('OPE_NOMOPE').AsString,
                             LQuery.FieldByName('OCO_DESCRI').AsString,
                             LQuery.FieldByName('OCO_CODCOC').AsString,
                             LQuery.FieldByName('COC_DESCOC').AsString,
                             FTip_Fc,
                             LQuery.FieldByName('OCO_PROTOC').AsString,
                             []);
  Finally
    FreeAndNil(LQuery);
  End
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirAlterar;
begin
  mnuAlterarDocumento.Visible := False;

  If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) And (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  If (Pos('-' + VS_strCodEmp, cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuAlterarDocumento.Visible := True;
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirBaixar;
begin
  mnuBaixar.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit
  Else If (Pos('-' + VS_strCodEmp, cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit
  Else If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) And
    (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuBaixar.Visible := ((Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) > 0) And fVerificaAcessoSistema('BAIPDV')) Or
    ((Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) > 0) And fVerificaAcessoSistema('BXPNFT'));
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirCadastroLeads;
var
  NumLead: String;
begin
  mnuAbrirLead.Visible := False;
  FObjLeads.pLimpar;
  NumLead := EmptyStr;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  If Not fEmptyStr(cdsOcorrenciasOCO_SEQLAG.AsString) then
    NumLead := cdsOcorrenciasOCO_SEQLAG.AsString;

  If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) >= 1) Then
    NumLead := TLeads.fObterNumLead(RightStr(cdsOcorrenciasDOCUMENTO.AsString, 3), Copy(cdsOcorrenciasDOCUMENTO.AsString, 14, 2),  LeftStr(cdsOcorrenciasDOCUMENTO.AsString, 12));

  If fEmptyStr(NumLead) Then
    Exit;

  FObjLeads.strAutInc := NumLead;
  FObjLeads.strCodCLi := cdsOcorrencias.FieldByName('OCO_CODCLI').AsString;
  FObjLeads.Tip_Fc := FTip_Fc;

  mnuAbrirLead.Visible := Not fEmptyStr(NumLead);
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirDesmembrar;
begin
  mnuDesmembrar.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit
  Else If (Pos('-' + VS_strCodEmp, cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit
  Else If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) And
    (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit
  Else If (cdsOcorrenciasFGO_STATUS.AsInteger In [pvPedidoEmAberto.fGetId(),
                                                  pvSeparando.fGetId(),
                                                  pvAgFaturamento.fGetId()]) Then
    Exit;

  mnuDesmembrar.Visible := fVerificaAcessoSistema('frmFatDesmembrarPedido');
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirEfetivarOrcamento;
begin
  mnuEfetivarOrcamento.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit
  Else If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit
  Else If (Pos('-' + VS_strCodEmp, cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit
  Else If Not fCfgSis('USAFPG', varBoolean) Then
    Exit
  Else If Not fCfgSis('USAPDV', varBoolean) Then
    Exit;

  mnuEfetivarOrcamento.Visible := True;
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirGerarVendaPerdida;
begin
  mnuGerarVendaPerdida.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit
  Else If (Pos(cdsOcorrenciasDOCUMENTO.AsString, 'OR_PD_') > 0) Then
    Exit
  Else If (Pos('-' + VS_strCodEmp, cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuGerarVendaPerdida.Visible := True;
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirLimparSeparacao;
begin
  mnuLimparSeparacao.Visible := False;

  If (Pos('-' + VS_strCodEmp, cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit
  Else If (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuLimparSeparacao.Visible := fVerificaAcessoSistema('CRMLIMSEP');
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirModificarCategoria;
begin
  mnuModificarCategoria.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit
  Else If (cdsOcorrenciasOCO_CODEMP.AsString <> VS_strCodEmp) Then
    Exit
  Else If (cdsOcorrenciasOCO_ESPDOC.AsString = 'OR') And (Not fCfgSis('UTICAO', varBoolean)) Then
    Exit
  Else If (cdsOcorrenciasOCO_ESPDOC.AsString = 'PD') And (Not fCfgSis('UTICAP', varBoolean)) Then
    Exit
  Else If (cdsOcorrenciasFGO_STATUS.AsInteger In [pvPedidoEmAberto.fGetId(),
                                                  pvSeparando.fGetId(),
                                                  pvAgFaturamento.fGetId()]) Then
    Exit;

  If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) And (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuModificarCategoria.Visible := fVerificaAcessoSistema('MODCAT');
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirValidacaoSistemaDEPS;
begin
  mnuAnaliseCreditoDEPS.Visible := blnUtilizaSistemaDEPS;

  If (Not blnUtilizaSistemaDEPS) Then
    Exit;

  mnuAnaliseCreditoDEPS.Enabled := (Not cdsOcorrencias.IsEmpty) And
                                   (Pos('OR', cdsOcorrencias.FieldByName('OCO_ESPDOC').AsString) > 0);
end;

procedure TfrmConsultaOcorrenciasCRM.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
//  If Pos('_PROTOC', strCamFil) > 0 Then
//       Accept := FloatToStrF(fStrToFloat(strValFil),ffFixed,15,2) = FloatToStrF(DataSet.FieldByName(strCamFil).AsFloat,ffFixed,15,2)
//  Else
  Accept := (Pos(strValFil, DataSet.FieldByName(strCamFil).AsString) > 0);
end;

procedure TfrmConsultaOcorrenciasCRM.pHabilitaBotoesPanelInferior;
begin
  btnConfirma.Enabled := True;
end;

procedure TfrmConsultaOcorrenciasCRM.popOcorrenciasPopup(Sender: TObject);
begin
  if Not VerificarAcessoClienteOrdemDeProducaoIndustrial(cdsOcorrencias.FieldByName('OCO_CODCLI').AsString) Then
    Abort;

  inherited;
end;

procedure TfrmConsultaOcorrenciasCRM.pLimparCamposMultiConsulta;
begin
  If edtCodCli.Text = fStrZero('0',edtCodCli.MaxLength) Then
     edtCodCli.Clear;

  If edtCodAti.Text = fStrZero('0',edtCodAti.MaxLength) Then
     edtCodAti.Clear;

  If edtCodGat.Text = fStrZero('0',edtCodGat.MaxLength) Then
     edtCodGat.Clear;

  If edtCodCid.Text = fStrZero('0',edtCodCid.MaxLength) Then
     edtCodCid.Clear;

  If edtOpeOco.Text = fStrZero('0',edtOpeOco.MaxLength) Then
     edtOpeOco.Clear;

  If edtCodOpe.Text = fStrZero('0',edtCodOpe.MaxLength) Then
     edtCodOpe.Clear;

  If edtCodDep.Text = fStrZero('0',edtCodDep.MaxLength) Then
     edtCodDep.Clear;

  If edtCodQua.Text = fStrZero('0',edtCodQua.MaxLength) Then
     edtCodQua.Clear;

  If edtCodGoc.Text = fStrZero('0',edtCodGoc.MaxLength) Then
     edtCodGoc.Clear;

  If edtCodToc.Text = fStrZero('0',edtCodToc.MaxLength) Then
     edtCodToc.Clear;

  If edtCodCoc.Text = fStrZero('0',edtCodCoc.MaxLength) Then
     edtCodCoc.Clear;

  If edtCodCat.Text = fStrZero('0',edtCodCat.MaxLength) Then
     edtCodCat.Clear;

  If edtCodEmp.Text = fStrZero('0',edtCodEmp.MaxLength) Then
     edtCodEmp.Clear;
end;

procedure TfrmConsultaOcorrenciasCRM.pTrataBotoesAgregados;
begin

  If (cdsOcorrencias.FieldByName('OCO_DTACON').AsDateTime = 0) And
    (cdsOcorrencias.FieldByName('OCO_HORCON').AsDateTime = 0) Then
  Begin
    btnHistorico.Enabled  := FAcessoFLUCRM Or (cdsOcorrencias.FieldByName('OCO_CODOPE').AsString = strLoginUsuarioLogado);

    btnFinalizar.Glyph.Assign(nil);
    btnFinalizar.Enabled := FAcessoBAICRM Or (cdsOcorrencias.FieldByName('OCO_CODOPE').AsString = strLoginUsuarioLogado);
    btnFinalizar.Hint    := 'Finalizar essa ocorrência.';
    btnFinalizar.Tag     := 0;
    btnFinalizar.Caption := 'Finalizar [F3]';
    imgButton.GetBitmap(0, btnFinalizar.Glyph);
  End
  Else
  Begin
    btnHistorico.Enabled := False;
    btnFinalizar.Glyph.Assign(nil);
    btnFinalizar.Enabled := FAcessoOPNCRM;
    btnFinalizar.Hint := 'Reabrir essa ocorrência.';
    btnFinalizar.Tag := 1;
    btnFinalizar.Caption := 'Reabrir [F3]';
    imgButton.GetBitmap(1, btnFinalizar.Glyph);
  End;

  btnAltSituacao.Enabled := FAcessoALTSIT Or (cdsOcorrencias.FieldByName('OCO_CODOPE').AsString = strLoginUsuarioLogado);
  btnResFin.Enabled      := FAcessoACEF7_;
  btnCadCli.Visible      := FAcessoCADCLI And (FTip_Fc = 'C');
  btnImpBol.Visible      := FAcessoBOLIND And (FTip_Fc = 'C');
  btnHisDeb.Visible      := FAcessoACEF6_ And (FTip_Fc = 'C');
  btnCadLead.Enabled     := Not fEmptyStr(cdsOcorrencias.FieldByName('NLEAD').AsString);
  btnCadFor.Visible      := FAcessoCadFor And (FTip_Fc = 'F');
  btnCadProspecto.Visible := FAcessoCadPro And (FTip_Fc = 'P');
end;

procedure TfrmConsultaOcorrenciasCRM.pTrataExibirMenus;
begin
  pExibirAbrirOcorrencia;
  pExibirEnviarOcoEmail;
  pExibirGerarPDF;
  pExibirReimprimir;
  pExibirBaixar();
  pExibirAlterar();
  pExibirDesmembrar();
  pExibirEfetivarOrcamento();
  pExibirGerarVendaPerdida();
  pExibirValidacaoSistemaDEPS();
  pExibirCadastroLeads;
  pExibirModificarCategoria();
  pExibirLimparSeparacao;
  pExibirFaturarEmVendaNormal;
  pExibirEnviarBolEmail;
end;

procedure TfrmConsultaOcorrenciasCRM.setTip_Fc(const Value: String);
begin
  If (FTip_Fc <> Value) Then
    FTip_Fc := Value;
end;

procedure TfrmConsultaOcorrenciasCRM.tmrAtualizarDadosTimer(Sender: TObject);
begin
  inherited;

  tmrAtualizarDados.Enabled := False;

  If FCarregandoOcorrencias Then
    Exit;

  If FDesabilitaCdsScroll Then
    Exit;

  If GetQtdItensMarcados > 1 Then
    Exit;

  If FTipoExibicaoDados = tpGrid Then
  Begin
    if cdsOcorrencias.IsEmpty then
      pDesabilitaBotoesPanelInferior
    else
      pHabilitaBotoesPanelInferior;

    pTrataBotoesAgregados;
    pCarregaHistoricoOcorrencia;

    If tbsOcoPar.TabVisible Then
      pAtualizaOcoPar;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.tmrSistemaDEPSTimer(Sender: TObject);
begin
  inherited;
  tmrSistemaDEPS.Enabled := False;
  pAtualizarStatusDEPSOrcamentos(cdsOcorrencias);
  tmrSistemaDEPS.Enabled := True;
end;

procedure TfrmConsultaOcorrenciasCRM.pAtualizarStatusDEPSOrcamentos(cdsOcorrencias: TUniClientDataSet);
  Var
    cdsDEPS      : TUniCLientDataSet;
    strStatusDEPS: String;
    intRegistro  : Integer;
    blnAtualizar : Boolean;
    prcScroll    : TprcScroll;
Begin
  cdsDEPS := TUniCLientDataSet.Create(Nil);

  cdsDEPS.Data     := cdsOcorrencias.Data;
  cdsDEPS.Filter   := 'USADEPS=''S'' AND (FGO_NUMFAT IS NULL OR FGO_NUMFAT='''') ';
  cdsDEPS.Filtered := True;

  blnAtualizar := False;
  Application.ProcessMessages;
  While Not cdsDEPS.Eof Do
  Begin
    strStatusDEPS := TValidacoesSistemaDEPS.fRetornaStatusDoOrcamentoNoSistemaDEPS(cdsDEPS.FieldByName('AUTOINCREMFATGOR').AsString);

    If strStatusDEPS <> cdsDEPS.FieldByName('STATUSDEPS').AsString Then
      blnAtualizar := True;

    Application.ProcessMessages;
    cdsDEPS.Next;
  End;

  FreeAndNil(cdsDEPS);

  If (blnAtualizar) Then
  Begin
    pDisableControls(cdsOcorrencias, prcScroll);
    intRegistro := cdsOcorrencias.RecNo;
    cdsOcorrencias.Refresh;
    cdsOcorrencias.RecNo := intRegistro;
    pEnableControls(cdsOcorrencias, prcScroll);
  End;
End;

procedure TfrmConsultaOcorrenciasCRM.pConfigurarTelaModoCalendario;
Begin
  FOcorrenciaSelecionada := -1;
  FTipoExibicaoDados :=  tpCalendario;
  pnlCalendarioGeral.Align := alClient;
  dbgOcorrencias.Visible := False;
  pnlCalendarioGeral.Visible := True;
  FCalendario.Parent :=  pnlCalendario;
  FCalendario.Align := alClient;
  FCalendario.OnChange := OnDataOnChange;
  FCalendario.OnClick := OnDataOnClick;
  FCalendario.OnExit := OnDataOnExit;
  pnlCalendarioGeral.Align := alClient;
  btnVisualizacaoFiltros.Visible := True;
  btnVisualizacaoHistorico.Visible := True;
  BtnExibirCalendario.Caption := 'Exibir no formato grid';
  btnSelecionarMes.Caption := IntToStr(FCalendario.Month);
  btnSelecionarAno.Caption := IntToStr(FCalendario.Year);
  CheckBoxExibicaoCalendario.checked := True;
  pnlDetalhamento.Width := StrToIntDef( edtTamanhoDetalhamento.Text ,  pnlDetalhamento.Width);
  If chkHistoricoExpandido.Checked Then
    FEstadoTela := tExpand
  Else
    FEstadoTela := tColapse;

  If chkFiltrosExpandido.Checked Then
    FEstadoTelaFiltros := tExpand
  Else
    FEstadoTelaFiltros := tColapse;

  pAjustaLayoutCalendario(filtros);
  pAjustaLayoutCalendario(historico);

  FCalendario.strTip_Fc := strTip_Fc;
  FCalendario.ExibirDiasSemanaFeriado := chkexibirFds.Checked;
  FCalendario.pAjustaTamanhoColunas;

  FAlteraDataSelecionada := False;
  FCalendarioCarregado := True;

  pConfigurarAgendamentoCalendario;
End;

procedure TfrmConsultaOcorrenciasCRM.pConfigurarTelaModoGrid;
Begin
  pnlHistorico.Height := FTamanhoPanelHistoricoInicial;
  CheckBoxExibicaoCalendario.checked := False;
  FOcorrenciaSelecionada := -1;
  FTipoExibicaoDados := TpGrid;
  dbgOcorrencias.Align := alClient;
  dbgOcorrencias.Visible := True;
  pnlCalendarioGeral.Visible := False;
  btnVisualizacaoHistorico.Visible := False;
  btnVisualizacaoFiltros.Visible := False;
  btnVisualizacaoFiltros.Visible := False;
  btnVisualizacaoHistorico.Visible := False;
  BtnExibirCalendario.Caption := 'Exibir no formato calendário';
  FAlteraDataSelecionada := False;
  FCalendarioCarregado := False;
  pConfigurarGridOcorrencias;
End;

procedure TfrmConsultaOcorrenciasCRM.pSelecionarTipoExibicao(Tipo: tTipoExibicaoOcorrenciasCRM);
Begin
  FOcorrenciaFocada := '';
  FCarregandoOcorrencias := false;
  Case Tipo of
    tpGrid : Begin
               pConfigurarTelaModoGrid;
               If fCfgSis('OCOCAR', VarBoolean) Then
                 pCarregarDados(False);
             End;
    tpCalendario: Begin
                    pConfigurarTelaModoCalendario;
                    If fCfgSis('OCOCAR', VarBoolean) Then
                      pAtualizaDadosGridOcorrencia(True, False);
                    If FCalendario.CanFocus Then
                      pSetFocus(FCalendario);
                  End;
  End;

  Application.ProcessMessages;
End;

procedure TfrmConsultaOcorrenciasCRM.pSetaItemFoco;
begin
  cdsOcorrencias.Fields[FIndiceCampoCodOco].AsString;
end;

procedure TfrmConsultaOcorrenciasCRM.pSetarDataSelecionada(NovaData: TDateTime);
begin
  If FTipoExibicaoDados = tpCalendario Then
  Begin
    FCalendario.CalendarDate := NovaData;
    pAtualizaDataSelecionada;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.chkexibirFdsClick(Sender: TObject);
begin
  inherited;

  FCalendario.ExibirDiasSemanaFeriado := chkexibirFds.Checked;
  FCalendario.pAjustaTamanhoColunas;
  pSetFocus(FCalendario);

end;

procedure TfrmConsultaOcorrenciasCRM.OnDataOnChange(Sender: TObject);
begin
  inherited;

  Try
    pAtualizaDataSelecionada;

    btnSelecionarMes.Caption := fRetMesExtenso(FCalendario.Month);
    btnSelecionarAno.Caption := IntToStr(FCalendario.Year);
    Application.ProcessMessages;

    Application.ProcessMessages;
    FCalendario.UpdateCalendar;

    pDesmarcarTodas;

    If (FCalendario.Day = 1) Then   // ajusta o foco
    begin
      If FCalendario.CalendarDate <> FCalendario.DataFoco Then
      Begin
        FCalendario.UpdateCalendar;
        Exit;
      End;
    end;

    If Not FCalendario.ExibirDiasSemanaFeriado Then
    Begin
      If DayOfWeek(FCalendario.CalendarDate) in [1,7] Then
      Begin
        If FCalendario.PularProximo Then
          FCalendario.CalendarDate := FCalendario.CalendarDate + 1;
        If FCalendario.PularAnterior Then
          FCalendario.CalendarDate := FCalendario.CalendarDate - 1;
      End;
    End;

    If FCarregandoOcorrencias Then
      Exit;

    If Not FLiberarAjusteListView Then
      Exit;

    FLiberarAjusteListView := False;

    TfrmGravando.fExecutarModal(pCarregarOcorrenciasData, 'Aguarde carregando ocorrências do dia....', 'ConsultaOcorrenciasCRM');

    If fVerificaPodeExecutarAcao Then
      pCarregaHistoricoOcorrencia
    Else
      cdsHisOco.Close;

    pTrataBotoesAgregados;

  Finally
    Application.ProcessMessages;
    FCalendario.UpdateCalendar;
    FCalendario.DataSelecionadaAnteriormente := FCalendario.CalendarDate;
    FLiberarAjusteListView := False;
  End;

End;

procedure TfrmConsultaOcorrenciasCRM.OnDataOnClick(Sender: TObject);
Begin
  inherited;

  FLiberarAjusteListView := True;

End;

procedure TfrmConsultaOcorrenciasCRM.OnDataOnExit(Sender: TObject);
Begin
  pAtualizaDataSelecionada;
End;

procedure TfrmConsultaOcorrenciasCRM.btnAnoAntClick(Sender: TObject);
Begin
  inherited;

  FLiberarAjusteListView := True;
  FCalendario.PrevYear;
  pAtualizaDataAgendamentoFiltro;
End;

procedure TfrmConsultaOcorrenciasCRM.btnAnoProxClick(Sender: TObject);
Begin
  inherited;

  FLiberarAjusteListView := True;
  FCalendario.NextYear;
  pAtualizaDataAgendamentoFiltro;
End;

procedure TfrmConsultaOcorrenciasCRM.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;

  pMarcarTodas;
end;

procedure TfrmConsultaOcorrenciasCRM.btnMesAntClick(Sender: TObject);
Begin
  inherited;

  FLiberarAjusteListView := True;
  FCalendario.PrevMonth;
  pAtualizaDataAgendamentoFiltro;
End;

procedure TfrmConsultaOcorrenciasCRM.btnMesProxClick(Sender: TObject);
begin
  inherited;

  FLiberarAjusteListView := True;
  FCalendario.NextMonth;
  pAtualizaDataAgendamentoFiltro;
end;

procedure TfrmConsultaOcorrenciasCRM.ListViewCalendarioAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  inherited;

  Sender.Canvas.Font.Style := [];
end;

procedure TfrmConsultaOcorrenciasCRM.ListViewCalendarioClick(Sender: TObject);
begin
  inherited;

  If fVerificaPodeExecutarAcao Then
    pCarregaHistoricoOcorrencia;

  pTrataBotoesAgregados;
  Application.ProcessMessages;
end;

procedure TfrmConsultaOcorrenciasCRM.ListViewCalendarioDblClick(Sender: TObject);
begin
  inherited;

  If fVerificaPodeExecutarAcao Then
    btnConfirmaClick(Sender);

end;

procedure TfrmConsultaOcorrenciasCRM.ListViewCalendarioExit(Sender: TObject);
begin
  inherited;

  Application.ProcessMessages;

  FAlteraDataSelecionada := False;

  If ListViewCalendario.SelCount >= 1 Then
  Begin
    If Not fValidarIndiceListView(ListViewCalendario.Selected.Index) Then
      Exit;
    FOcorrenciaSelecionada := ListViewCalendario.Selected.Index;
  End;

end;

procedure TfrmConsultaOcorrenciasCRM.ListViewCalendarioKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If FCarregandoOcorrencias Then
    Exit;

  Application.ProcessMessages;

  If (Shift = [ssShift]) Then
    Exit;

  Case Key of
    VK_RETURN: Begin
                  If fVerificaPodeExecutarAcao Then
                    btnConfirmaClick(Sender);
               End;
    VK_UP, VK_DOWN : Begin
                       Application.ProcessMessages;

                       Try
                         If GetKeyState(VK_SHIFT) <> 0 Then
                           Exit;

                         If (Shift = [ssCtrl]) Then
                         Begin
                           If Assigned(ListViewCalendario.ItemFocused) Then
                           Begin
                             If Not fValidarIndiceListView(ListViewCalendario.ItemFocused.Index) Then
                               Exit;

                             ListViewCalendario.Items[ListViewCalendario.ItemFocused.Index].Selected := Not (ListViewCalendario.Items[ListViewCalendario.ItemFocused.Index].Selected);
                             pMarcarDesmarcarItemLista;
                           End;
                         End;

                       Finally
                         If fVerificaPodeExecutarAcao Then
                         Begin
                           pCarregaHistoricoOcorrencia;
                           Application.ProcessMessages;
                         End;
                       End;
                     End;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.ListViewCalendarioMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  strDoc: string;
  ItemFoco: TListItem;
begin
  inherited;

  If Button = mbRight Then
  Begin

    If fVerificaPodeExecutarAcao Then
    Begin
      strDoc := cdsOcorrencias.FieldByName('DOCUMENTO').AsString;

      If (Pos('PD', strDoc) > 0) Or (Pos('OR', strDoc) > 0) or (Not fEmptyStr(cdsOcorrenciasOCO_SEQLAG.AsString)) Then
      Begin
        pTrataExibirMenus();
        popOcorrencias.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      End;
    End;

  End;

  If Button = mbLeft Then
  Begin
    If (Shift = [ssCtrl, ssLeft]) Then
    Begin
      pMarcarDesmarcarItemLista;
    End
    Else
    Begin
      If (GetQtdItensMarcados > 1) Then
      Begin
        ItemFoco := ListViewCalendario.ItemFocused;
        If Assigned(ItemFoco) Then
        Begin
          ListViewCalendario.ItemFocused := ItemFoco;
          ListViewCalendario.ItemFocused.Selected := True;
        End;
      End;
    End;
  End;

End;

procedure TfrmConsultaOcorrenciasCRM.ListViewCalendarioSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  inherited;

  If GetKeyState(VK_SHIFT) <> 0 Then
    Exit;

  // Só força ao utilizar o keyup
  If FAlteraPropFoco Then
  Begin
    Item.Focused := Selected;

    FAlteraPropFoco := False;
  End;

  pMarcarDesmarcarItemLista;

end;

procedure TfrmConsultaOcorrenciasCRM.pAjustaLayoutCalendario(Area: tAreaAjuste);
  procedure pAlteraAreaExibicaoHistorico;
  begin

    case FEstadoTela of
      tColapse :Begin
                  pnlHistorico.Height := FTamanhoPanelHistoricoReduzido;
                  btnVisualizacaoHistorico.Caption := '<< Expandir Histórico >>';
                  FEstadoTela := tExpand;
                  chkHistoricoExpandido.Checked := False;
                End;
      tExpand : Begin
                  pnlHistorico.Height := FTamanhoPanelHistoricoInicial;
                  btnVisualizacaoHistorico.Caption:= '<< Recolher Histórico >>';
                  FEstadoTela := tColapse;
                  chkHistoricoExpandido.Checked := True;
                End;
    end;

  end;

  procedure pAlteraAreaExibicaoFiltros;
  begin

    Case FEstadoTelaFiltros of
      tColapse :Begin
                  pnlFiltros.Height := FTamanhoPanelFiltrosInicial;
                  btnVisualizacaoFiltros.Caption := '<< Recolher Filtros >>';
                  FEstadoTelaFiltros := tExpand;
                  btnCarregaDadosCalendario.Visible := False;
                  chkFiltrosExpandido.Checked := False;
                End;
      tExpand : Begin
                  pnlFiltros.Height := FTamanhoPanelFiltrosReduzido;
                  btnVisualizacaoFiltros.Caption:= '<< Expandir Filtros >>';
                  FEstadoTelaFiltros := tColapse;
                  chkFiltrosExpandido.Checked := True;
                  btnCarregaDadosCalendario.Visible := True;
                End;
    End;

  End;
begin

  Case Area of
    filtros : pAlteraAreaExibicaoFiltros;
    historico: pAlteraAreaExibicaoHistorico;
  End;

  Application.ProcessMessages;
  pFocaOcorrenciaAgendamento;
End;

procedure TfrmConsultaOcorrenciasCRM.BtnExibirCalendarioClick(Sender: TObject);
begin
  inherited;

  case FTipoExibicaoDados of
    tpGrid : pSelecionarTipoExibicao(tpCalendario);
    tpCalendario : pSelecionarTipoExibicao(tpGrid);
  end;

end;

procedure TfrmConsultaOcorrenciasCRM.btnVisualizacaoFiltrosClick(
  Sender: TObject);
begin
  inherited;

  pAjustaLayoutCalendario(filtros);
end;

procedure TfrmConsultaOcorrenciasCRM.btnVisualizacaoHistoricoClick(
  Sender: TObject);
begin
  inherited;

  pAjustaLayoutCalendario(historico);
end;

procedure TfrmConsultaOcorrenciasCRM.pnlCalendarioResize(Sender: TObject);
begin
  inherited;

  FCalendario.pAjustaTamanhoColunas;
  Application.ProcessMessages;
end;

procedure TfrmConsultaOcorrenciasCRM.pnlDetalhamentoResize(Sender: TObject);
begin
  inherited;

  if FCalendarioCarregado then
    edtTamanhoDetalhamento.Text := IntToStr(pnlDetalhamento.Width);
end;

procedure TfrmConsultaOcorrenciasCRM.pAtualizaDataAgendamentoFiltro;
var
  DataIniAux, DataFimAux: TDateTime;
  UltimoDiaMes: Word;
Begin
  UltimoDiaMes := 30;
  case FCalendario.Month of
    2 : Begin
          UltimoDiaMes := 28;
        End;
    1, 3, 5, 7, 8, 10, 12 : UltimoDiaMes := 31;
  end;

  DataIniAux := EncodeDateTime(FCalendario.Year, FCalendario.Month, 1, 0, 0, 0, 0);
  DataFimAux := EncodeDateTime(FCalendario.Year, FCalendario.Month, UltimoDiaMes, 0, 0, 0, 0);

  mskDtaIniAg.Text := DateTimeToStr(DataIniAux);
  mskDtaFinAg.Text := DateTimeToStr(DataFimAux);

  Application.ProcessMessages;

  pAtualizaDataSelecionada;
  FAlteraDataSelecionada := True;

  If FCalendario.CanFocus Then
    pSetFocus(FCalendario);
End;

procedure TfrmConsultaOcorrenciasCRM.btnCarregaDadosCalendarioClick(Sender: TObject);
begin
  inherited;

  pAtualizaDadosGridOcorrencia;

  If FTipoExibicaoDados = tpCalendario Then
    If FCalendario.CanFocus then
      pSetFocus(FCalendario);
end;

procedure TfrmConsultaOcorrenciasCRM.btnCfgClick(Sender: TObject);
begin
  inherited;

  If FTipoExibicaoDados = tpCalendario Then
    pAbrirConfigCalendario
  Else
    pAbrirConfigGridOcorrencia;
end;

function TfrmConsultaOcorrenciasCRM.fVerificaPodeExecutarAcaoCalendario: Boolean;
Begin
  Result := False;
  FTipoValidacao := tpOcorrenciaNaoSelecionadaPainel;
  If (ListViewCalendario.SelCount > 0) Then
  Begin
    If Not cdsOcorrencias.IsEmpty Then
    Begin

      If FLimitaUmaOcorrencia then
      Begin
        Result := GetQtdItensMarcados <= 1;
        FTipoValidacao := tpNaoPermiteMultiplaSelecao;

        If Not Result Then
          Exit;
      End;

      If Not fValidarIndiceListView(ListViewCalendario.Selected.Index) Then
        Exit;

      cdsOcorrencias.DisableControls;
      Try
        cdsOcorrencias.Locate('OCO_CODOCO', ListViewCalendario.Items[ListViewCalendario.Selected.Index].SubItems[FCalendario.IndiceOcorrencia], [ ] );
      Finally
        cdsOcorrencias.EnableControls;
      End;

      Result := True;
    End;
  End;
End;

function TfrmConsultaOcorrenciasCRM.fVerificaPodeExecutarAcaoGrid: Boolean;
Begin
  Result := False;
  FTipoValidacao := tpOcorrenciaNaoSelecionada;

  If Not cdsOcorrencias.IsEmpty Then
  Begin
    If FLimitaUmaOcorrencia then
    Begin
      Result := GetQtdItensMarcados <= 1;
      FTipoValidacao := tpNaoPermiteMultiplaSelecao;
      Exit;
    End;
    Result := True;
  End;
End;

function TfrmConsultaOcorrenciasCRM.fVerificarFiltrosPreenchidos: Boolean;
begin
  If fEmptyStr(edtCodCli.Text) And
     fEmptyStr(edtCodAti.Text) And
     fEmptyStr(edtCodGat.Text) And
     fEmptyStr(edtCodCid.Text) And
     fEmptyStr(edtOpeOco.Text) And
     fEmptyStr(edtCodOpe.Text) And
     fEmptyStr(edtCodDep.Text) And
     fEmptyStr(edtCodDig.Text) And
     fEmptyStr(edtCodQua.Text) And
     fEmptyStr(edtNumeroDocumento.Text) And
     fEmptyStr(edtEspecieDocumento.Text) And
     fEmptyStr(edtCodGoc.Text) And
     fEmptyStr(edtCodToc.Text) And
     fEmptyStr(edtCodCoc.Text) And
     fEmptyDate(mskDtaIni.Text) And
     fEmptyDate(mskDtaFin.Text) And
     fEmptyDate(mskDtaIniAg.Text) And
     fEmptyDate(mskDtaFinAg.Text) And
     fEmptyDate(mskDtaIniFlx.Text) And
     fEmptyDate(mskDtaFinFlx.Text) And
     fEmptyStr(edtCodCat.Text) And
     fEmptyStr(edtProtoc.Text) And
     fEmptyStr(edtAutDev.Text) And
     (cbStatus.ItemIndex = 0) And
     fEmptyStr(edtAssunto.Text) And
     fEmptyStr(edtCodEmp.Text) Then
    Result := False
  Else
    Result := True;

end;

function TfrmConsultaOcorrenciasCRM.fVerificaDataValida(
  strData: String): Boolean;
var
  datTmp: TDateTime;
begin
  datTmp := 0;
  Try
    datTmp := strToDateDef(strData, 0);
  Finally
    Result := datTmp > 0;
  End;
end;

function TfrmConsultaOcorrenciasCRM.fVerificaPodeCarregarDados(
  const blnExibirAlerta: Boolean): Boolean;
begin
  FblnValidarOpe := blnExibirAlerta;
  FExibirAlertaCodCli := False;
  FExibirAlertaCodCid := False;

  If (Not blnConfirma) And (Not FCarregandoOcorrencias) Then
    Exit(True);

  Result := fVerificarFiltrosPreenchidos;

  If (Not Result) and blnExibirAlerta Then
  Begin
    If fMensagem('ATENÇÃO!', 'Nenhum filtro foi aplicado para realizar a consulta, desta forma o processo pode demorar. Deseja prosseguir? ', ['&Sim', '&Não']) = 2  Then
    Begin
      pSetFocus(edtOpeOco);
    End
    Else
      Result:= True;
  End;

  If Not Result Then
    Exit;

  If (Not blnLiberadoOpeOrig) and  fEmptyStr(edtOpeOco.Text) Then
  Begin
    If blnExibirAlerta Then
    Begin
      fMensagem('ATENÇÃO!', 'Operador Origem não pode ficar em branco!', ['&Ok']);
      pSetFocus(edtOpeOco);
    End;
    Result := False;
    Exit;
  End;

  If (Not blnLiberadoOpeDest) and fEmptyStr(edtCodOpe.Text)  Then
  Begin
    If blnExibirAlerta Then
    Begin
      fMensagem('ATENÇÃO!', 'Operador Destino não pode ficar em branco!', ['&Ok']);
      pSetFocus(edtCodOpe);
    End;
    Result := False;
    Exit;
  End;

  If blnExibirAlerta and (not fEmptyStr(edtNumeroDocumento.Text) and (fEmptyStr(edtEspecieDocumento.Text))) or
     (fEmptyStr(edtNumeroDocumento.Text) and (not fEmptyStr(edtEspecieDocumento.Text))) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor preencher corretamente o número do documento e a espécie do mesmo!', ['&Ok']);
    pSetFocus(edtNumeroDocumento);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    pCarregarCliente;
    If fEmptyStr(edtDesCli.Text) Then
    Begin
      Result := False;
      FExibirAlertaCodCli := True;
      Exit;
    End;
  End;

  If ((Not fEmptyStr(edtCodCid.Text)) and  (fEmptyStr(fRetNomCidade(edtCodCid.Text))) and (Length(arrCodCid) <=1)) Then
  Begin
    Result := False;
    FExibirAlertaCodCid := True;
    Exit;
  End;

  Result := fValidaCamposParaCarregar(blnExibirAlerta);

end;

function TfrmConsultaOcorrenciasCRM.fVerificaPodeExecutarAcao: Boolean;
Begin
  Result := False;

  Case FTipoExibicaoDados Of
    tpCalendario : Result := fVerificaPodeExecutarAcaoCalendario;
    tpGrid       : Result := fVerificaPodeExecutarAcaoGrid;
  End;
End;

function TfrmConsultaOcorrenciasCRM.GetQtdItensMarcados: Integer;
begin
  Case FTipoExibicaoDados Of
    tpCalendario : Result := ListViewCalendario.SelCount;
    tpGrid       : Result := dbgOcorrenciasDBTableView1.Controller.SelectedRowCount;
    Else
      Result := 0;
  End;
end;

function TfrmConsultaOcorrenciasCRM.fObtemCodigoClienteSelecionado: string;
var
  Indice: Integer;
Begin
  Application.ProcessMessages;

  Result := EmptyStr;

  If FTipoExibicaoDados = tpCalendario Then
  Begin
    If(ListViewCalendario.SelCount > 0) Then
    Begin
      Indice := ListViewCalendario.Selected.Index;
    End
    Else
      Indice := FOcorrenciaSelecionada;

    If Indice >= 0 Then
      Result := ListViewCalendario.Items[Indice].SubItems[FCalendario.IndiceCliente];
  End
  Else
  Begin
    If Not cdsOcorrencias.IsEmpty Then
      Result := cdsOcorrencias.FieldByName('OCO_CODCLI').AsString;
  End;

End;

procedure TfrmConsultaOcorrenciasCRM.pFocaOcorrenciaAgendamento;
var
  NumOcor: string;
  Indice: Integer;
Begin
  If FCarregandoOcorrencias Then
    Exit;

  If FTipoExibicaoDados = tpCalendario Then
  Begin
    Application.ProcessMessages;
    If ListViewCalendario.Items.Count > 0 Then
    Begin
      If (FOcorrenciaSelecionada >= 0) and (FOcorrenciaSelecionada <= ListViewCalendario.Items.Count) Then
      Begin
        pSetFocus(ListViewCalendario);
        ListViewCalendario.Items.Item[FOcorrenciaSelecionada].Selected := True;
      End
      Else
      Begin
        For Indice := 0 to ListViewCalendario.Items.Count-1 Do
        Begin
          If ((FCalendario.IndiceOcorrencia) <= (ListViewCalendario.Items[Indice].SubItems.Count-1)) Then
          Begin
            NumOcor := ListViewCalendario.Items[Indice].SubItems[FCalendario.IndiceOcorrencia];
            If (NumOcor = FOcorrenciaFocada )Then
            Begin
              pSetFocus(ListViewCalendario);
              ListViewCalendario.Items[Indice].Selected := True;
              Application.ProcessMessages;
              Break;
            End;
          End;
        End;
      End;
      If fVerificaPodeExecutarAcao Then
        pCarregaHistoricoOcorrencia;
    End;
  End;
End;

procedure TfrmConsultaOcorrenciasCRM.pCarregaOcorrenciaDataSelecionada;
begin
  If FTipoExibicaoDados = tpCalendario Then
  Begin
    If Not (fEmptyDate(edtDiaCalendarioSelecionado.Text)) Then
    Begin
      FCalendario.DataSelecionada := StrToDate(edtDiaCalendarioSelecionado.Text);
      If FCalendario.DataSelecionada > 0 Then
      Begin
        FLiberarAjusteListView := True;
        FCalendario.CalendarDate := FCalendario.DataSelecionada;
      End
      Else
      Begin
        FCalendario.DataSelecionada := FCalendario.fObtemPrimeiroDiaMes;
        FLiberarAjusteListView := True;
        FCalendario.CalendarDate := FCalendario.fObtemPrimeiroDiaMes;
      End;
    End
    Else
    Begin
      edtDiaCalendarioSelecionado.Text := DateTimeToStr(FCalendario.fObtemPrimeiroDiaMes);
      FCalendario.DataSelecionada := FCalendario.fObtemPrimeiroDiaMes;
      FLiberarAjusteListView := True;
      FCalendario.CalendarDate := FCalendario.fObtemPrimeiroDiaMes;
    End;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pAtualizaDataSelecionada;
begin
  If FTipoExibicaoDados = tpCalendario Then
  Begin
    FCalendario.DataSelecionada := FCalendario.CalendarDate;
    edtDiaCalendarioSelecionado.Text := DateToStr(FCalendario.DataSelecionada);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarOcorrenciasData;
Begin
  If FTipoExibicaoDados = tpCalendario Then
  Begin
    If FCalendario.fObterDetalhamentoDia(ListViewCalendario) Then
    Begin
      FOcorrenciaSelecionada := -1;
      pnlTotalAgendamentos.Caption := 'Total de Agendamentos do dia ' + DateTimeToStr(FCalendario.CalendarDate) + ': ' + IntToStr( FCalendario.TotalAgendamentosDia );
      If ListViewCalendario.Items.Count = 1 Then
        ListViewCalendario.SelectAll;
    End;
  End;
End;

procedure TfrmConsultaOcorrenciasCRM.pMarcarDesmarcarItemLista;
begin

  If Not Assigned(ListViewCalendario.ItemFocused) Then
    Exit;

  If Not fValidarIndiceListView(ListViewCalendario.ItemFocused.Index) Then
    Exit;

  cdsOcorrencias.DisableControls;
  Try
    cdsOcorrencias.Locate('OCO_CODOCO', ListViewCalendario.Items[ListViewCalendario.ItemFocused.Index].SubItems[FCalendario.IndiceOcorrencia], [ ] );
    Application.ProcessMessages;
  Finally
    cdsOcorrencias.EnableControls;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pMarcarTodas;
begin
  case FTipoExibicaoDados of
    tpGrid : begin
               dbgOcorrenciasDBTableView1.OptionsSelection.MultiSelect := True;
               dbgOcorrenciasDBTableView1.Controller.SelectAll;
               pSetFocus(dbgOcorrencias);
             end;
    tpCalendario : Begin
                     ListViewCalendario.MultiSelect := True;
                     ListViewCalendario.SelectAll;
                     pSetFocus(ListViewCalendario);
                   End;
  end;
end;

procedure TfrmConsultaOcorrenciasCRM.pDesmarcarTodas;
begin
  case FTipoExibicaoDados of
    tpGrid : dbgOcorrenciasDBTableView1.Controller.ClearSelection;
    tpCalendario : ListViewCalendario.ClearSelection;
  end;
end;


function TfrmConsultaOcorrenciasCRM.fObterTipoOcorrenciasSelecionadas: TListaOcorrencias;
var
  arrTipoOco: TListaOcorrencias;
  intCnt: Integer;
  intCont: Integer;
  intAux : Integer;
  blnEncontrou: Boolean;
  Indice: Integer;
  strCodToc, strDesToc: String;
  strAux: Variant;
Begin
  FillChar(arrTipoOco, SizeOf(arrTipoOco), #0);
  SetLength(arrTipoOco, Length(arrTipoOco));

  Try
    Try
      If FTipoExibicaoDados = tpGrid Then
      Begin
        dbgOcorrenciasDBTableView1.DataController.BeginLocate;
        dbgOcorrenciasDBTableView1.DataController.DataSet.DisableControls;

        For intCnt := 0 to dbgOcorrenciasDBTableView1.Controller.SelectedRowCount  -1 Do
        Begin
          strCodToc := EmptyStr;
          strDesToc := EmptyStr;

          Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_CODTOC').Index;
          strAux := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
          If Not(VarIsNull (strAux)) then
            strCodToc := strAux;

          Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('TOC_DESTOC').Index;
          strAux := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
          If Not(VarIsNull(strAux)) then
            strDesToc := strAux;

          blnEncontrou := False;
          For intCont := 0 to Length(arrTipoOco)-1 do
          Begin
            If arrTipoOco[intCont].Codigo = strCodToc Then
            Begin
              blnEncontrou := True;
              Break;
            End;
          End;

          If Not blnEncontrou then
          Begin
            SetLength(arrTipoOco, Length(arrTipoOco) + 1);
            intAux := Length(arrTipoOco) -1;
            arrTipoOco[intAux].Codigo := strCodToc;
            arrTipoOco[intAux].Descricao := strDesToc;
          End;
        End;

        dbgOcorrenciasDBTableView1.DataController.EndLocate;
        dbgOcorrenciasDBTableView1.DataController.DataSet.EnableControls;
      End
      Else
      Begin
        For intCnt := 0 to ListViewCalendario.Items.Count -1 Do
        Begin
          If  ListViewCalendario.Items[intCnt].Selected Then
          Begin
            strCodToc := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceCodToc];
            strDesToc := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceDesToc];

            blnEncontrou := False;
            For intCont := 0 to Length(arrTipoOco)-1 do
            Begin
              If arrTipoOco[intCont].Codigo = strCodToc Then
              Begin
                blnEncontrou := True;
                Break;
              End;
            End;

            If Not blnEncontrou then
            Begin
              SetLength(arrTipoOco, Length(arrTipoOco) + 1);
              intAux := Length(arrTipoOco) -1;
              arrTipoOco[intAux].Codigo := strCodToc;
              arrTipoOco[intAux].Descricao := strDesToc;
            End;

          End;
        End;
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.fObterTipoOcorrenciasSelecionadas]');
    End;

  Finally
    Result := arrTipoOco;
  End;

End;

function TfrmConsultaOcorrenciasCRM.fAlterarSituacaoOcorrenciasMarcadas: Boolean;
var
  objAtuOcoCrm: TAtuOcoCrm;
  qrySitOco : TUniQuery;
  arrSel    : TConsultasArray;
  chrKey    : Char;
  arrTipOco : TListaOcorrencias;
  strTipOco : String;
  intCnt    : Integer;
  Indice    : Integer;
  strAux    : Variant;
Begin
  Result := False;
  objAtuOcoCrm := TAtuOcoCrm.Create(Self);
  objAtuOcoCrm.strNomFrm := Self.Name;
  qrySitOco := fCriaQuery;
  cdsOcorrencias.DisableControls;
  try
    FDesabilitaCdsScroll := True;
    try
      arrTipOco := fObterTipoOcorrenciasSelecionadas;

      If Length(arrTipOco) > 1 Then
      Begin
        For intCnt := 0 to Length(arrTipOco)-1 Do
        Begin
          strTipOco := strTipOco + arrTipOco[intCnt].Descricao + IfThen(intCnt < Length(arrTipOco)-1 , ', ', '.');
        End;

        fMensagem('ALERTA', 'Atenção! Existem ocorrências selecionadas que não são do mesmo tipo. ' +
                            'Operação não permitida. ' +
                            'Tipos de Ocorrências selecionadas: ' +
                            strTipOco, ['&OK']);
        Exit;
      End
      Else
        strTipOco := arrTipOco[0].Codigo;

      chrKey := '/';
      If fPesqSitOcorrencias(Self, nil, nil, qrySitOco, chrKey, arrSel, True, True, strTipOco) Then
      Begin

        fStartTransaction;
        If FTipoExibicaoDados = tpGrid Then
        Begin
          dbgOcorrenciasDBTableView1.DataController.BeginLocate;
          dbgOcorrenciasDBTableView1.DataController.DataSet.DisableControls;

          For intCnt := 0 to dbgOcorrenciasDBTableView1.Controller.SelectedRowCount -1 Do
          Begin            Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_CODOCO').Index;
            strAux := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
            If Not VarIsNull(strAux) Then
              objAtuOcoCrm.strCodOco := strAux;

            Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_CODCLI').Index;
            strAux := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
            If Not VarIsNull(strAux) Then
              objAtuOcoCrm.strCodCli := strAux;

            objAtuOcoCrm.strDtaInc := VS_Date;
            objAtuOcoCrm.strHorInc := fRetHoraServidor();

            Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_DTAAGE').Index;
            strAux := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
            If Not VarIsNull(strAux) Then
              objAtuOcoCrm.strDtaAge := strAux
            Else
              objAtuOcoCrm.strDtaAge := objAtuOcoCrm.strDtaInc;
            objAtuOcoCrm.strOpeHis := strLoginUsuarioLogado;

            Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_CODOPE').Index;
            strAux := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
            If Not VarIsNull(strAux) Then
              objAtuOcoCrm.strCodOpe := strAux;

            Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_CODEMP').Index;
            strAux := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
            If Not VarIsNull(strAux) Then
              objAtuOcoCrm.strCodEmp := strAux;

            Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_CODCOC').Index;
            strAux := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
            If Not VarIsNull(strAux) Then
              objAtuOcoCrm.strCodCoc := strAux;

            Indice := dbgOcorrenciasDBTableView1.GetColumnByFieldName('OCO_CODCOC').Index;
            strAux := dbgOcorrenciasDBTableView1.Controller.SelectedRows[intCnt].Values[Indice];
            If Not VarIsNull(strAux) Then
              objAtuOcoCrm.strCodToc := strAux;

            objAtuOcoCrm.strDtaInc := VS_Date;
            objAtuOcoCrm.strHorInc := fRetHoraServidor();
            objAtuOcoCrm.strHorAge := objAtuOcoCrm.strHorInc;
            objAtuOcoCrm.strDtaCon := 0;
            objAtuOcoCrm.strHorCon := 0;
            objAtuOcoCrm.strCodSit := qrySitOco.FieldByName('SIT_CODSIT').AsString;
            objAtuOcoCrm.strDescri := fGeraTextoHistorico(VS_Date, fNow,
                                                          fRetNomeOperador(objAtuOcoCrm.strCodOpe),
                                                          'ALTERAÇÃO DA SITUAÇÃO DA OCORRÊNCIA');
            objAtuOcoCrm.pInsereHistoricoOcorrencia;
            objAtuOcoCrm.pAtualizaOcorrencia;
          End;

          dbgOcorrenciasDBTableView1.DataController.EndLocate;
          dbgOcorrenciasDBTableView1.DataController.DataSet.EnableControls;
        End
        Else
        Begin
          For intCnt := 0 to ListViewCalendario.Items.Count -1 Do
          Begin
            If  ListViewCalendario.Items[intCnt].Selected Then
            Begin

              objAtuOcoCrm.strCodOco := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceOcorrencia];
              objAtuOcoCrm.strCodCli := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceCliente];
              objAtuOcoCrm.strDtaInc := VS_Date;
              objAtuOcoCrm.strHorInc := fRetHoraServidor();
              If Not(fEmptyDate(ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceDtaAgendamento])) Then
                objAtuOcoCrm.strDtaAge := StrToDateTime(ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceDtaAgendamento])
              Else
                objAtuOcoCrm.strDtaAge := objAtuOcoCrm.strDtaInc;
              objAtuOcoCrm.strOpeHis := strLoginUsuarioLogado;
              objAtuOcoCrm.strCodOpe := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceCodOpe];
              objAtuOcoCrm.strCodEmp := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceCodEmpresa];
              objAtuOcoCrm.strCodCoc := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceCodCoc];
              objAtuOcoCrm.strCodToc := ListViewCalendario.Items[intCnt].SubItems[FCalendario.IndiceCodToc];
              objAtuOcoCrm.strDtaInc := VS_Date;
              objAtuOcoCrm.strHorInc := fRetHoraServidor();
              objAtuOcoCrm.strHorAge := objAtuOcoCrm.strHorInc;
              objAtuOcoCrm.strDtaCon := 0;
              objAtuOcoCrm.strHorCon := 0;
              objAtuOcoCrm.strCodSit := qrySitOco.FieldByName('SIT_CODSIT').AsString;
              objAtuOcoCrm.strDescri := fGeraTextoHistorico(VS_Date, fNow,
                                                            fRetNomeOperador(objAtuOcoCrm.strCodOpe),
                                                            'ALTERAÇÃO DA SITUAÇÃO DA OCORRÊNCIA');
              objAtuOcoCrm.pInsereHistoricoOcorrencia;
              objAtuOcoCrm.pAtualizaOcorrencia;

            End;
          End;
        End;

        fCommit;
        Result := True;

      End;
    Except
      On E: Exception Do
      Begin
        fRollback;
        pMensagensErro(E.Message, '[TfrmConsultaOcorrenciasCRM.fAlterarSituacaoOcorrenciasMarcadas]');
      End;
    End;

  Finally
    cdsOcorrencias.EnableControls;
    FDesabilitaCdsScroll := False;
    FreeAndNil(objAtuOcoCrm);
    FreeAndNil(qrySitOco);
  End;
End;

procedure TfrmConsultaOcorrenciasCRM.dbgOcorrenciasDBTableView1KeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (TcxGridSiteCitel(Sender).Parent = dbgOcorrencias) Then
  Begin
    If (Shift = [ssCtrl]) Then
    Begin
      FPodeMarcarDesmarcarKey := True;
      Case Key Of
        VK_DOWN,
        VK_UP : Begin
                  Application.ProcessMessages;
                  If Not dbgOcorrenciasDBTableView1.Controller.FocusedRow.Selected Then
                  Begin
                    dbgOcorrenciasDBTableView1.Controller.FocusedRow.Selected := True;
                  End
                  Else
                  Begin
                    dbgOcorrenciasDBTableView1.Controller.FocusedRow.Selected := False;
                  End;
                End;
      End;
    End
    Else
    Begin
      Case Key Of
        VK_HOME,
        VK_END,
        VK_PRIOR,
        VK_NEXT,
        VK_UP,
        VK_DOWN: tmrAtualizarDados.Enabled := True;
      End;
    End;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirAbrirOcorrencia;
Begin
  mnuAbrirOcorrencia.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) And (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuAbrirOcorrencia.Visible := True;
End;

procedure TfrmConsultaOcorrenciasCRM.pExibirEnviarBolEmail;
begin

  mnuEnviarBoletoPorEmail.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  mnuEnviarBoletoPorEmail.Visible := True;

end;

procedure TfrmConsultaOcorrenciasCRM.pExibirEnviarOcoEmail;
begin
  mnuEnviarEmail.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) And (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuEnviarEmail.Visible := True;
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirFaturarEmVendaNormal;
begin
  mnuFaturarEmVendaNormal.Visible := False;

  If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) And (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  If (Pos('-' + VS_strCodEmp, cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuFaturarEmVendaNormal.Visible := fVerificaAcessoSistema('CRMVDN');
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirGerarPDF;
begin
  mnuGerarPDF.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) And (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuGerarPDF.Visible := True;
end;

procedure TfrmConsultaOcorrenciasCRM.pExibirReimprimir;
begin
  mnuReimprimir.Visible := False;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  If (Pos('OR', cdsOcorrenciasDOCUMENTO.AsString) <= 0) And (Pos('PD', cdsOcorrenciasDOCUMENTO.AsString) <= 0) Then
    Exit;

  mnuReimprimir.Visible := True;
end;

function TfrmConsultaOcorrenciasCRM.fSelecionarLead: string;
begin
  Result := EmptyStr;

  FObjLeads.pLimpar;

  If cdsOcorrencias.IsEmpty Then
    Exit;

  If Not fEmptyStr(cdsOcorrenciasOCO_SEQLAG.AsString) then
    Result := cdsOcorrenciasOCO_SEQLAG.AsString;

  If fEmptyStr(Result) Then
    If Not fEmptyStr(cdsOcorrenciasDOCUMENTO.AsString) Then
      Result := TLeads.fObterNumLead(RightStr(cdsOcorrenciasDOCUMENTO.AsString, 3), Copy(cdsOcorrenciasDOCUMENTO.AsString, 14, 2),  LeftStr(cdsOcorrenciasDOCUMENTO.AsString, 12));

  If fEmptyStr(Result) Then
    Exit;

  FObjLeads.strAutInc := Result;
  FObjLeads.strCodCLi := cdsOcorrencias.FieldByName('OCO_CODCLI').AsString;
  FObjLeads.Tip_Fc := FTip_Fc;
end;

procedure TfrmConsultaOcorrenciasCRM.dbgTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If Odd(AViewInfo.GridRecord.Index) Then
  Begin
    If (AViewInfo.GridRecord.Selected) Then
    Begin
      If AViewInfo.GridView.Site.Focused Then
      Begin
        ACanvas.Font.Color := clWhite;
      End
      Else
      Begin
        ACanvas.Brush.Color := TcxGridDBTableViewCitel(Sender).CorZebra;
      End;
    End
    Else
    Begin
      ACanvas.Brush.Color := TcxGridDBTableViewCitel(Sender).CorZebra;
    End;
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pGerarVendaPerdidaSelItens;
var
  objGerarVendaPerdida: TGerarVendaPerdida;
begin
  inherited;

  objGerarVendaPerdida := TGerarVendaPerdida.Create(cdsOcorrenciasOCO_ESPDOC.AsString);
  Try
    Try
      objGerarVendaPerdida.pGerarVendaPerdida(cdsOcorrenciasOCO_CODEMP.AsString,
                                              cdsOcorrenciasOCO_ESPDOC.AsString,
                                              cdsOcorrenciasOCO_NUMDOC.AsString);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.message, 'TfrmConsultaOcorrenciasCRM.pGerarVendaPerdidaSelItens');
      End;
    End;
  Finally
    FreeAndNil(objGerarVendaPerdida);
  End;
end;

procedure TfrmConsultaOcorrenciasCRM.pGravarConfiguracoesTela;
begin
  Case FTipoExibicaoDados Of
         tpGrid : Begin
                    FCfgTela.pGravarDadosNoBanco(dbgOcorrenciasDBTableView1, 'frmConsultaOcorrenciasCRM.' + FTip_Fc + '.dbgOcorrenciasDBTableView1', cdsOcorrencias);
                  End;
    tpCalendario: Begin
                    FCfgTela.pGravarDadosNoBanco(dbgOcorrenciasDBTableView1, 'frmConsultaOcorrenciasCRM.' + FTip_Fc + '.' + ListViewCalendario.Name, cdsOcorrencias);
                    FCfgTela.Sugestao.pGravarSugestoesNoBanco(pnlDetalhamento.name, IntToStr(pnlDetalhamento.Width));
                  End;
  End;


  pSalvaCamposForm(Self, 'frmConsultaOcorrenciasCRM.' + FTip_Fc + '.Campos', False);
end;

procedure TfrmConsultaOcorrenciasCRM.pConfigurarAgendamentoCalendario;
var
  intRecNo: Integer;
begin
  FCarregandoOcorrencias := True;
  FCalendario.strNomFormulario := FCfgTela.NomeFormulario;
  FCfgTela.pConfigurarGrid(dbgOcorrenciasDBTableView1, 'frmConsultaOcorrenciasCRM.' + FTip_Fc + '.'+ ListViewCalendario.name, cdsOcorrencias, intRecNo, False);
  pCarregarCfgColunasGrid;
  FCfgTela.Sugestao.pCarregarTamanhoFonteObj(ListViewCalendario.name);
  ListViewCalendario.Font.Size := FCfgTela.Sugestao.TamanhoFonte;
  FCalendario.TamFonteAge := FCfgTela.Sugestao.TamanhoFonte;
  FCarregandoOcorrencias := False;
end;

procedure TfrmConsultaOcorrenciasCRM.pConfigurarGridOcorrencias;
Var
  intRecNo: Integer;
begin
  // Atenção: ao incluir configuração para visibilidade de coluna, alterar a tela de configuração;
  FCarregandoOcorrencias := True;
  FCfgTela.pConfigurarGrid(dbgOcorrenciasDBTableView1, 'frmConsultaOcorrenciasCRM.' + FTip_Fc + '.dbgOcorrenciasDBTableView1', cdsOcorrencias, intRecNo, False);
  pCarregarCfgColunasGrid;
  FCfgTela.pOrdenaColunas(cdsOcorrencias, dbgOcorrenciasDBTableView1.Name);
  FCfgTela.Sugestao.pCarregarTamanhoFonteObj(dbgOcorrenciasDBTableView1.name);
  dbgOcorrencias.Font.Size := FCfgTela.Sugestao.TamanhoFonte;

  FCarregandoOcorrencias := False;
end;

procedure TfrmConsultaOcorrenciasCRM.pCarregarCfgColunasGrid;
begin
  If FTip_Fc = 'F' Then
  Begin
    lblCliente.Caption := 'Fornecedor';
    dbgOcorrenciasDBTableView1CLI_NOMCLI.Caption := 'Fornecedor';
  End
  Else If FTip_Fc = 'P' Then
  Begin
    lblCliente.Caption := 'Prospecto';
    dbgOcorrenciasDBTableView1CLI_NOMCLI.Caption := 'Prospecto';
  End;

  If Not(Pos(FTip_Fc, 'C_P_') > 0) Then
    dbgOcorrenciasDBTableView1DOCUMENTO.Visible  := False;

  If Not((Pos(FTip_Fc, 'C_P_') > 0) And fCfgSis('IFVLOR', varBoolean)) Then
    dbgOcorrenciasDBTableView1FGO_VALORC.Visible := False;

  If Not(Pos(FTip_Fc, 'C_P_') > 0) Then
    dbgOcorrenciasDBTableView1FGO_VLRCON.Visible := False;

  If Not(blnUtilizaSistemaDEPS) Then
    dbgOcorrenciasDBTableView1STATUSDEPS.Visible := False;

  If (Not fUtilizarCategoriaParaPedidoOrcamento) Then
    dbgOcorrenciasDBTableView1CAT_DESCRI.Visible := False;

  If (Not fUtilizarCategoriaParaPedidoOrcamento) Then
    dbgOcorrenciasDBTableView1CAT_CORCAT.Visible := False;

  If Not(fCfgSis('SEGCND', varBoolean)) Then
    dbgOcorrenciasDBTableView1FGO_PREVIS.Visible := False;

  If Not(fCfgSis('OCOAST', varBoolean)) Then
    dbgOcorrenciasDBTableView1OCO_ASSUNT.Visible := False;

  If Not(fCfgSis('CRMTEA', varBoolean)) Then
  Begin
    dbgOcorrenciasDBTableViewTEA_DESCRI.Visible := False;
    dbgOcorrenciasDBTableViewTEA_CORTEA.Visible := False;
  End;

  OCO_CODOCO.Visible := False;
  OCO_CODCLI.Visible := False;
  OCO_CODOPE.Visible := False;
  OCO_CODCOC.Visible := False;

  FIndiceCampoCodOco := cdsOcorrencias.FieldByName('OCO_CODOCO').Index;
end;

procedure TfrmConsultaOcorrenciasCRM.pAbrirConfigCalendario;
var
  frmCfgConsultaOcorrenciaCRM: TfrmCfgConsultaOcorrenciaCRM;
Begin
  FCarregandoOcorrencias := True;

  pSetaItemFoco;
  pCriarFormularios(TfrmCfgConsultaOcorrenciaCRM, frmCfgConsultaOcorrenciaCRM);
  Try
    frmCfgConsultaOcorrenciaCRM.strTip_FC := strTip_Fc;
    frmCfgConsultaOcorrenciaCRM.FTipoExibicaoDados := FTipoExibicaoDados;
    frmCfgConsultaOcorrenciaCRM.ShowModal;
    If frmCfgConsultaOcorrenciaCRM.ModalResult = mrOk Then
    Begin
      FCfgTela.pIniciar(dbgOcorrencias, dbgOcorrenciasDBTableView1, ListViewCalendario.Name);
      FCfgTela.pGravarDadosNoBanco(dbgOcorrenciasDBTableView1, FCfgTela.NomeFormulario + '.' + ListViewCalendario.Name, frmConsultaOcorrenciasCRM.cdsOcorrencias);
      TFrmGravando.fExecutarModal(pConfigurarAgendamentoCalendario, 'Aguarde... Carregando Configurações!', '');

      pAtualizaDadosGridOcorrencia(False);
      If FTIpoExibicaoDados = tpCalendario Then
      Begin
        cdsOcorrencias.Locate('OCO_CODOCO', FOcorrenciaFocada, [ ] );
        FLiberarAjusteListView := True;
        FCalendario.CalendarDate := cdsOcorrencias.FieldByName('OCO_DTAAGE').AsDateTime;

        Application.ProcessMessages;
        pFocaOcorrenciaAgendamento;
      End;

    End;
  Finally
    pFreeAndNil(frmCfgConsultaOcorrenciaCRM);
    FCarregandoOcorrencias := False;
  End;
End;

procedure TfrmConsultaOcorrenciasCRM.pAbrirConfigGridOcorrencia;
var
  frmCfgConsultaOcorrenciaCRM: TfrmCfgConsultaOcorrenciaCRM;
Begin
  FCarregandoOcorrencias := True;
  pCriarFormularios(TfrmCfgConsultaOcorrenciaCRM, frmCfgConsultaOcorrenciaCRM);
  Try
    frmCfgConsultaOcorrenciaCRM.strTip_FC := strTip_Fc;
    frmCfgConsultaOcorrenciaCRM.FTipoExibicaoDados := FTipoExibicaoDados;
    frmCfgConsultaOcorrenciaCRM.ShowModal;
    If frmCfgConsultaOcorrenciaCRM.ModalResult = mrOk Then
    Begin
      dbgOcorrencias.Font.Size := FCfgTela.Sugestao.TamanhoFonte;
      FCfgTela.pIniciar(dbgOcorrencias, dbgOcorrenciasDBTableView1, dbgOcorrenciasDBTableView1.Name);
      FCfgTela.pGravarDadosNoBanco(dbgOcorrenciasDBTableView1, FCfgTela.NomeFormulario + '.' + dbgOcorrenciasDBTableView1.Name, frmConsultaOcorrenciasCRM.cdsOcorrencias);
      TFrmGravando.fExecutarModal(pConfigurarGridOcorrencias, 'Aguarde... Carregando Configurações!', '');
    End;
  Finally
    pFreeAndNil(frmCfgConsultaOcorrenciaCRM);
    FCarregandoOcorrencias := False;
  End;
End;

End.


