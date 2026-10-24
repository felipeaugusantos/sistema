unit untEditorEtiquetasPrinc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, DB, frxDesgn, frxPreview, ExtCtrls, Grids, ValEdit, ComCtrls,
  ToolWin, ImgList, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, UniClientDataSet, cxButtonEdit, Buttons, Contnrs, StdCtrls, cxVGrid,
  cxInplaceContainer, cxTextEdit, Menus, cxSpinEdit, untReguaEditor, jpeg,
  frxDesgnCtrls, cxDropDownEdit, frxBarcode, frxBarcod, StrUtils, untComponentMovel,
  untEditorFast, cxDBLookupComboBox, cxCheckBox, fs_synmemo, fs_iinterpreter,
  cxContainer, cxLabel, cxColorComboBox, cxCurrencyEdit, cxTL, cxMaskEdit, cxDBTL,
  cxTLData, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, cxTLdxBarBuiltInMenu, Uni,
  untTypesSistema, untZClient, untFuncoesSimples, untConsultas, System.ImageList,
  cxDataControllerConditionalFormattingRulesManagerDialog;
type
  TfrmEditorEtiquetasPrinc = class(TForm)
    pnlCampos: TPanel;
    cxgTabCamView: TcxGridDBTableView;
    cxgTabCamLevel1: TcxGridLevel;
    cxgTabCam: TcxGrid;
    cxgTabCamDESCAM: TcxGridDBColumn;
    dtsTabCam: TDataSource;
    SpeedButton1: TSpeedButton;
    cxStyleRepositorio: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    ToolBar1: TToolBar;
    ImageList: TImageList;
    ToolButton7: TToolButton;
    btnDesmarca: TToolButton;
    btnExcluir: TToolButton;
    Splitter1: TSplitter;
    MainMenu: TMainMenu;
    mnuLayout: TMenuItem;
    Sair1: TMenuItem;
    mnuNovo: TMenuItem;
    mnuPreview: TMenuItem;
    mnuCarregar: TMenuItem;
    mnuSalvar: TMenuItem;
    mnuSalvarPadrao: TMenuItem;
    cxgTabCamCODCAM: TcxGridDBColumn;
    btnExpressao: TToolButton;
    pnlMainRegua: TPanel;
    pnlReguaSuperior: TPanel;
    pnlCentral: TPanel;
    scrPagina: TScrollBox;
    pnlReguaLateral: TPanel;
    frxRulerSuperior: TfrxRuler;
    pnlReguaLatAux: TPanel;
    frxRulerLateral: TfrxRuler;
    tmrRegua: TTimer;
    mnuCarregarPadrao: TMenuItem;
    ToolButton1: TToolButton;
    pnlPadrao: TPanel;
    pnlDescricao: TPanel;
    edtDescri: TEdit;
    ToolButton2: TToolButton;
    btnNovo: TToolButton;
    btnSalvar: TToolButton;
    btnPreview: TToolButton;
    btnSair: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    btnExcLay: TToolButton;
    btnImagem: TToolButton;
    pnlConfig: TPanel;
    Splitter3: TSplitter;
    pnlDadCam: TPanel;
    Panel2: TPanel;
    cxvDadCam: TcxVerticalGrid;
    cxvDadCamLeft: TcxEditorRow;
    cxvDadCamTop: TcxEditorRow;
    cxvDadCamWidth: TcxEditorRow;
    cxvDadCamHeight: TcxEditorRow;
    cxvDadCamFont: TcxEditorRow;
    cxvDadCamCorFundo: TcxEditorRow;
    cxvDadCamTipCam: TcxEditorRow;
    cxvDadCamDado: TcxEditorRow;
    cxvDadCamExpressao: TcxEditorRow;
    cxvDadCamAlign: TcxEditorRow;
    cxvDadCamWordWrap: TcxEditorRow;
    cxvDadCamHideZeros: TcxEditorRow;
    cxvDadCamRotacao: TcxEditorRow;
    cxvDadCamTipApr: TcxEditorRow;
    cxvDadCamBarCode: TcxEditorRow;
    cxvDadCamBarCodeText: TcxEditorRow;
    cxvDadCamCenter: TcxEditorRow;
    cxvDadCamStrech: TcxEditorRow;
    cxvDadCamImagem: TcxEditorRow;
    cxvDadCamDecimais: TcxEditorRow;
    cxvDadCamAutoWidth: TcxEditorRow;
    pnlDadEti: TPanel;
    pnlCabEti: TPanel;
    btnMosEti: TSpeedButton;
    cxvDadEti: TcxVerticalGrid;
    cxvDadEtiWidth: TcxEditorRow;
    cxvDadEtiHeigth: TcxEditorRow;
    cxvDadEtiColumns: TcxEditorRow;
    cxvDadEtiGapHor: TcxEditorRow;
    cxvDadEtiGapVer: TcxEditorRow;
    cxvDadCamBordas: TcxEditorRow;
    cxvDadCamBordaSuperior: TcxEditorRow;
    cxvDadCamBordaInferior: TcxEditorRow;
    cxvDadCamBordaEsquerda: TcxEditorRow;
    cxvDadCamBordaDireita: TcxEditorRow;
    cxStyle3: TcxStyle;
    cxgTabCamPOSDES: TcxGridDBColumn;
    cxgLegendasView: TcxGridDBTableView;
    cxgLegendasLevel1: TcxGridLevel;
    cxgLegendas: TcxGrid;
    cxgLegendasDESTIP: TcxGridDBColumn;
    cxgLegendasPOSCAM: TcxGridDBColumn;
    cxvDadEtiZebra: TcxEditorRow;
    cxvDadEtiMolDad: TcxEditorRow;
    cxvDadCamAutoHeight: TcxEditorRow;
    cxvDadEtiCorZebra: TcxEditorRow;
    cxvDadEtiOrdenacao: TcxEditorRow;
    cxvDadPagFooNewPage: TcxEditorRow;
    cxgTabCamPOSCAM: TcxGridDBColumn;
    Splitter2: TSplitter;
    cxtGrupos: TcxDBTreeList;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn3: TcxDBTreeListColumn;
    dtsGrupos: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle4: TcxStyle;
    pnlDadPag: TPanel;
    pnlCabPag: TPanel;
    btnMosPag: TSpeedButton;
    cxvDadPag: TcxVerticalGrid;
    cxvDadPagPapel: TcxEditorRow;
    cxvDadPagOrientacao: TcxEditorRow;
    cxvDadPagAltura: TcxEditorRow;
    cxvDadPagLargura: TcxEditorRow;
    cxvDadPagMargens: TcxEditorRow;
    cxvDadPagMargemSup: TcxEditorRow;
    cxvDadPagMargemInf: TcxEditorRow;
    cxvDadPagMargemEsq: TcxEditorRow;
    cxvDadPagMargemDir: TcxEditorRow;
    cxvDadPagMoldura: TcxEditorRow;
    cxvDadPagMolSup: TcxEditorRow;
    cxvDadPagMolInf: TcxEditorRow;
    cxvDadPagMolEsq: TcxEditorRow;
    cxvDadPagMolDir: TcxEditorRow;
    cxvDadPagHeader: TcxEditorRow;
    cxvDadPagHeaAlt: TcxEditorRow;
    cxvDadPagHeaderData: TcxEditorRow;
    cxvDadPagHeaderDataAlt: TcxEditorRow;
    cxvDadPagHeaderDataCorFundo: TcxEditorRow;
    cxvDadPagHeaderDataMoldura: TcxEditorRow;
    cxvDadPagFooterData: TcxEditorRow;
    cxvDadPagFooDataAlt: TcxEditorRow;
    cxvDadPagFooter: TcxEditorRow;
    cxvDadPagFooUltImp: TcxEditorRow;
    cxvDadPagFooAlt: TcxEditorRow;
    Splitter5: TSplitter;
    Splitter4: TSplitter;
    btnHeranca: TToolButton;
    cxvDadPagImpressora: TcxEditorRow;
    cxvDadPagMsgProx: TcxEditorRow;
    btnPDF: TToolButton;
    cxvDadPagSemFim: TcxEditorRow;
    cxvDadPagHeaderFonte: TcxEditorRow;
    cxvDadPagHeaderDataFonte: TcxEditorRow;
    cxvDadCamFontMat: TcxEditorRow;
    cxvDadPagInfAlt: TcxEditorRow;
    pnlAlinhamentos: TPanel;
    chkAlinhaGrade: TCheckBox;
    btnAliEsq: TSpeedButton;
    btnAliBot: TSpeedButton;
    btnAliDir: TSpeedButton;
    btnAliTop: TSpeedButton;
    cxvDadPagAvancar: TcxEditorRow;
    cxvDadPagEspacamento: TcxEditorRow;
    cxvDadPagFooterDataCorFundo: TcxEditorRow;
    cxvDadPagFooterDataMoldura: TcxEditorRow;
    cxvDadPagViaPag: TcxEditorRow;
    cxvDadPagPapelViaPag: TcxEditorRow;
    cxvDadPagLinCommand: TcxEditorRow;
    cxvDadPagFooBra: TcxEditorRow;
    cxvDadPagCabPri: TcxEditorRow;
    cxvDadCamCalculaCheckSum: TcxEditorRow;
    cxvDadPagMarcaDAgua: TcxEditorRow;
    cxvDadPagIMPPDF: TcxEditorRow;
    cxvDadCamQrCode: TcxEditorRow;
    cxvDadCamZoom: TcxEditorRow;
    cxvDadCamZooFix: TcxEditorRow;
    cxvDadEtiExpZebra: TcxEditorRow;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgTabCamViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure cxvDadCamLeftEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadCamTopEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadCamWidthEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadCamHeightEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadCamItemChanged(Sender: TObject; AOldRow: TcxCustomRow;
      AOldCellIndex: Integer);
    procedure btnExpressaoClick(Sender: TObject);
    procedure cxvDadPagPapelEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagOrientacaoEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagAlturaEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadPagLarguraEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadPagMargemSupEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadPagMargemInfEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadPagMargemEsqEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadPagMargemDirEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadEtiGapHorEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tmrReguaTimer(Sender: TObject);
    procedure cxvDadEtiWidthEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadEtiHeigthEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadEtiColumnsEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure mnuSalvarPadraoClick(Sender: TObject);
    procedure mnuNovoClick(Sender: TObject);
    procedure cxvDadCamTipCamEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamDadoEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamExpressaoEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure mnuSalvarClick(Sender: TObject);
    procedure mnuCarregarPadraoClick(Sender: TObject);
    procedure mnuCarregarClick(Sender: TObject);
    procedure cxvDadCamAlignEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamWordWrapEditPropertiesChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure mnuPreviewClick(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure btnMosEtiClick(Sender: TObject);
    procedure btnMosPagClick(Sender: TObject);
    procedure btnExcLayClick(Sender: TObject);
    procedure cxvDadCamRotacaoEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamTipAprEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamBarCodeEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamBarCodeTextEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamCorFundoEditPropertiesChange(Sender: TObject);
    procedure cxvDadEtiGapVerEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnImagemClick(Sender: TObject);
    procedure cxvDadCamCenterEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamStrechEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamImagemEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxvDadCamDecimaisEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamAutoWidthEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagMolSupEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagMolInfEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagMolEsqEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagMolDirEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagMolduraEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagHeaderEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagHeaAltEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadPagFooterEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagFooAltEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadCamBordaDireitaEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamBordaEsquerdaEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamBordaInferiorEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamBordaSuperiorEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamBordasEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagHeaderDataAltEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadPagHeaderDataEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagFooterDataEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagFooDataAltEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgTabCamViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgLegendasViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvDadEtiZebraEditPropertiesEditValueChanged(Sender: TObject);
    procedure cxvDadEtiMolDadEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagHeaderDataMolduraEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagHeaderDataCorFundoEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamAutoHeightEditPropertiesChange(Sender: TObject);
    procedure cxvDadEtiCorZebraEditPropertiesChange(Sender: TObject);
    procedure cxvDadEtiOrdenacaoEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxgTabCamDESCAMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgTabCamCODCAMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgTabCamPOSDESCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvDadPagFooUltImpEditPropertiesChange(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure chkAlinhaGradeClick(Sender: TObject);
    procedure cxvDadCamFontEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxvDadPagImpressoraEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagMsgProxEditPropertiesChange(Sender: TObject);
    procedure btnPDFClick(Sender: TObject);
    procedure cxvDadPagSemFimEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagHeaderFonteEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxvDadPagHeaderDataFonteEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxvDadCamFontMatEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagInfAltEditPropertiesChange(Sender: TObject);
    procedure btnAliBotClick(Sender: TObject);
    procedure btnAliEsqClick(Sender: TObject);
    procedure btnAliDirClick(Sender: TObject);
    procedure btnAliTopClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvDadPagAvancarEditPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxvDadPagEspacamentoEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagFooterDataCorFundoEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagFooterDataMolduraEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagViaPagEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagPapelViaPagEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagLinCommandEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadPagFooBraEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagCabPriEditPropertiesEditValueChanged(Sender: TObject);
    procedure cxvDadCamHideZerosEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamCalculaCheckSumEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagMarcaDAguaEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagIMPPDFEditPropertiesChange(Sender: TObject);
    procedure cxvDadPagFooNewPageEditPropertiesChange(Sender: TObject);
    procedure cxvDadCamZoomEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadCamZooFixEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvDadCamQrCodeEditPropertiesChange(Sender: TObject);
    procedure cxvDadEtiExpZebraEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);

  private
    { Private declarations }

    cdsLegendas: TZClient;

    intQtdMarcaDagua,
    intVerAnt,
    intHorAnt: Integer;

    blnArgox : Boolean;
    regEditor: TReguaEditor;
    objCmpMvl: TComponentMovel;
    objEdFast: TEditorFast;

    qryTabCam: TUniQuery;

    Function fValidaDouble(var DisplayValue: Variant; var ErrorText: TCaption;
                           var Error: Boolean; blnPodeZero: Boolean = False): Boolean;

    Function fValidaInteger(var DisplayValue: Variant; var ErrorText: TCaption;
                            var Error: Boolean): Boolean;

    Function fFiltraCampos: String;

    Procedure pMontaLegenda;
    procedure pCarregarLayout(blnPadrao: Boolean; blnChamadaPeloMenu: Boolean);
    procedure pEditorToDadPag;
    procedure pEditorToDadEti;
    procedure pSetaConPro;

    procedure pNomeEtiqueta;

    Procedure pCampoToEditor;

    procedure pSetaTipoImpressao(blnJato: Boolean);
    Procedure pPosicaoToEditor;
    procedure pFormataMatricial(cxeEditorRow: TcxEditorRow);

    Procedure pEditorToCampo;
    Procedure pNovoLayout;
    procedure pSetaTipoEtiqueta;
    procedure pSalvarLayout(blnPadrao: Boolean);
    procedure pAjustaTelaCampos(sttCampo: TLayStaticText);
    procedure pCamposfterScroll(dtsDados: TDataSet);

  public
    { Public declarations }
    tpeCodEti: TTipoEtiqueta;
    tplTipLay: TTipoLayout;
    strTipImp: String;

    strCodLayDoc: String;

  end;

var
  frmEditorEtiquetasPrinc: TfrmEditorEtiquetasPrinc;

implementation

{$R *.dfm}

uses System.UITypes, untConstantes, TypesRel, EditFocus, frxBarcode2D;

Const
  INT_NROETI  = 1;

procedure TfrmEditorEtiquetasPrinc.cxgLegendasViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

    Case StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                             cxgLegendasPOSCAM.Index]), 0) Of

      VAL_CABEC_PAGINA : ACanvas.Brush.Color := COR_CABEC_PAGINA;
      VAL_CABEC_DADOS  : ACanvas.Brush.Color := COR_CABEC_DADOS;
      VAL_DADOS        : ACanvas.Brush.Color := COR_DADOS;
      VAL_RODAPE_DADOS : ACanvas.Brush.Color := COR_RODAPE_DADOS;
      VAL_RODAPE_PAGINA: ACanvas.Brush.Color := COR_RODAPE_PAGINA;

    End;


end;

procedure TfrmEditorEtiquetasPrinc.cxgTabCamCODCAMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  If AViewInfo.Selected Then
  Begin

    Case StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                             cxgTabCamPOSCAM.Index]), 0) Of

      VAL_CABEC_PAGINA : ACanvas.Font.Color := COR_CABEC_PAGINA;
      VAL_DADOS        : ACanvas.Font.Color := COR_DADOS;
      VAL_RODAPE_DADOS : ACanvas.Font.Color := COR_RODAPE_DADOS;
      VAL_RODAPE_PAGINA: ACanvas.Font.Color := COR_RODAPE_PAGINA;

    End;

  End;

end;

procedure TfrmEditorEtiquetasPrinc.cxgTabCamDESCAMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  If AViewInfo.Selected Then
  Begin

    Case StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                             cxgTabCamPOSCAM.Index]), 0) Of

      VAL_CABEC_PAGINA : ACanvas.Font.Color := COR_CABEC_PAGINA;
      VAL_DADOS        : ACanvas.Font.Color := COR_DADOS;
      VAL_RODAPE_DADOS : ACanvas.Font.Color := COR_RODAPE_DADOS;
      VAL_RODAPE_PAGINA: ACanvas.Font.Color := COR_RODAPE_PAGINA;

    End;

  End;

end;

procedure TfrmEditorEtiquetasPrinc.cxgTabCamPOSDESCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  If AViewInfo.Selected Then
  Begin
    ACanvas.Font.Color := ACanvas.Brush.Color;
  End Else
  Begin

    Case StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                             cxgTabCamPOSCAM.Index]), 0) Of

      VAL_CABEC_PAGINA : ACanvas.Font.Color := COR_CABEC_PAGINA;
      VAL_DADOS        : ACanvas.Font.Color := COR_DADOS;
      VAL_RODAPE_DADOS : ACanvas.Font.Color := COR_RODAPE_DADOS;
      VAL_RODAPE_PAGINA: ACanvas.Font.Color := COR_RODAPE_PAGINA;

    End;
  End;

end;

procedure TfrmEditorEtiquetasPrinc.chkAlinhaGradeClick(Sender: TObject);
begin
  objCmpMvl.blnAlinhaGrade := chkAlinhaGrade.Checked;
end;

procedure TfrmEditorEtiquetasPrinc.cxgTabCamViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  objCmpMvl.pSetaInclusaoCampo;
end;

procedure TfrmEditorEtiquetasPrinc.cxgTabCamViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  If AViewInfo.Selected Then
  Begin


  End Else
  Begin

    Case StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                             cxgTabCamPOSCAM.Index]), 0) Of

      VAL_CABEC_PAGINA : ACanvas.Brush.Color := COR_CABEC_PAGINA;
      VAL_DADOS        : ACanvas.Brush.Color := COR_DADOS;
      VAL_RODAPE_DADOS : ACanvas.Brush.Color := COR_RODAPE_DADOS;
      VAL_RODAPE_PAGINA: ACanvas.Brush.Color := COR_RODAPE_PAGINA;

    End;

  End;

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamAlignEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    If SameText(cxvDadCamAlign.Properties.Value, 'Esquerda') Then
      aliHAlign  := TfrxHAlign.haLeft

    Else If SameText(cxvDadCamAlign.Properties.Value, 'Direita') Then
      aliHAlign  := TfrxHAlign.haRight

    Else If SameText(cxvDadCamAlign.Properties.Value, 'Centro') Then
      aliHAlign  := TfrxHAlign.haCenter
  End;

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamAutoHeightEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    blnAutHei := cxvDadCamAutoHeight.Properties.Value;
    cxvDadCamWordWrap.Properties.Value := blnWorWra;
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamAutoWidthEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  blnAutWid := cxvDadCamAutoWidth.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamBarCodeEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl), cxvDadCamBarCode.Properties Do
  bctBarCod := objCmpMvl.fTextToBarCode(Value);
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamBarCodeTextEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  blnBarTxt := cxvDadCamBarCodeText.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamBordaDireitaEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  blnBorRig := cxvDadCamBordaDireita.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamBordaEsquerdaEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  blnBorLef := cxvDadCamBordaEsquerda.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamBordaInferiorEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  blnBorBot := cxvDadCamBordaInferior.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamBordasEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  fltBorEsp := cxvDadCamBordas.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamBordaSuperiorEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  blnBorTop := cxvDadCamBordaSuperior.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamCalculaCheckSumEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  blnChkSum := cxvDadCamCalculaCheckSum.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamCenterEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
   blnCenImg := cxvDadCamCenter.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamCorFundoEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  colBColor := cxvDadCamCorFundo.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamDadoEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    strCodCam  := cxvDadCamDado.Properties.Value;
    If qryTabCam.Locate('CAM_CODCAM', cxvDadCamDado.Properties.Value, []) Then
    Begin
      strCapCam := qryTabCam.FieldByName('CAM_DESCAM').AsString;
      fdtTipDad := objCmpMvl.fRetTipoDado(qryTabCam.FieldByName('CAM_TIPCAM').AsString);
    End;
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamDecimaisEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    intCasDec := strToIntDef(cxvDadCamDecimais.Properties.Value, -1);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamExpressaoEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  objCmpMvl.pAlteraExpressao;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamFontEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  objCmpMvl.pAlteraFonte;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamFontMatEditPropertiesChange(
  Sender: TObject);
begin

  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Case TcxComboBoxProperties(cxvDadCamFontMat.Properties.EditProperties).Items.IndexOf(cxvDadCamFontMat.Properties.Value) Of
    0: colFonMat := col40;
    1: colFonMat := col80;
    2: colFonMat := col96;
    3: colFonMat := col137;
    4: colFonMat := col160;
  End;

  If strTipImp = 'M' Then
  Begin
    objCmpMvl.pAlteraFonteLinha(TLayStaticText(objCmpMvl.FCurrentNodeControl));
    regEditor.pSetaRegua;
    objCmpMvl.PositionNodes(objCmpMvl.FCurrentNodeControl);
  End;

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamHeightEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    error := (fStrToFloat(DisplayValue) < 0.01);
    ErrorText := '';

    DisplayValue := FormatFloat('#0.00', DisplayValue);

  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamHideZerosEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    blnHidZer := cxvDadCamHideZeros.Properties.Value;
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamImagemEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  objCmpMvl.pAlteraImagem;
  cxvDadCamDado.Properties.Value := '';
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamItemChanged(Sender: TObject;
  AOldRow: TcxCustomRow; AOldCellIndex: Integer);
begin
  pEditorToCampo;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamLeftEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error, True) Then
  Begin
    ErrorText := '';
    DisplayValue := FormatFloat('#0.00', DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamQrCodeEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl), cxvDadCamQrCode.Properties Do
  bcqBarCQR := objCmpMvl.fTextToQRCode(Value);
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamRotacaoEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Case TcxCustomComboBoxProperties(cxvDadCamRotacao.Properties.EditProperties).Items.IndexOf(cxvDadCamRotacao.Properties.Value) Of
    0: intfrxRot := 0;
    1: intfrxRot := 90;
    2: intfrxRot := 270;
    3: intfrxRot := 180;
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamStrechEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
   blnStretc := cxvDadCamStrech.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamTipAprEditPropertiesChange(
  Sender: TObject);
begin
  cxvDadCamBarCode.Visible     := SameText(cxvDadCamTipApr.Properties.Value, 'Código de Barras');

  cxvDadCamBarCodeText.Visible := SameText(cxvDadCamTipApr.Properties.Value, 'Código de Barras') Or
                                  SameText(cxvDadCamTipApr.Properties.Value, 'QRDCODE');

  cxvDadCamZoom.Visible   := SameText(cxvDadCamTipApr.Properties.Value, 'QRDCODE');
  cxvDadCamZooFix.Visible := SameText(cxvDadCamTipApr.Properties.Value, 'Código de Barras');
  cxvDadCamQrCode.Visible := SameText(cxvDadCamTipApr.Properties.Value, 'QRDCODE');

  cxvDadCamCalculaCheckSum.Visible := SameText(cxvDadCamTipApr.Properties.Value, 'Código de Barras');

  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    If SameText(cxvDadCamTipApr.Properties.Value, 'Código de Barras') Then
      tpaTipApr := aprCodeBar
    Else If SameText(cxvDadCamTipApr.Properties.Value, 'QRCODE') Then
      tpaTipApr := aprQRCODE
    Else
      tpaTipApr := aprTexto;

    pAjustaTelaCampos(TLayStaticText(objCmpMvl.FCurrentNodeControl));
  End;
end;

procedure TfrmEditorEtiquetasPrinc.pAjustaTelaCampos(sttCampo: TLayStaticText);
Begin
  With sttCampo Do
  Begin
    cxvDadCamBarCode.Visible         := tpaTipApr = aprCodeBar;
    cxvDadCamBarCodeText.Visible     := tpaTipApr IN [aprCodeBar, aprQRCODE];
    cxvDadCamZoom.Visible            := tpaTipApr IN [aprQRCODE];
    cxvDadCamZooFix.Visible          := tpaTipApr IN [aprCodeBar];
    cxvDadCamQrCode.Visible          := tpaTipApr IN [aprQRCODE];
    cxvDadCamCalculaCheckSum.Visible := tpaTipApr = aprCodeBar;

    cxvDadCamAlign.Visible       := tpaTipApr = aprTexto;
    cxvDadCamWordWrap.Visible    := tpaTipApr = aprTexto;
    cxvDadCamHideZeros.Visible   := tpaTipApr = aprTexto;
    cxvDadCamFont.Visible        := (tpaTipApr In [aprTexto, aprCodeBar, aprQRCODE]){ And (strTipImp = 'J')};

    cxvDadCamCenter.Visible      := tpaTipApr = aprImagem;
    cxvDadCamStrech.Visible      := tpaTipApr = aprImagem;
    cxvDadCamImagem.Visible      := tpaTipApr = aprImagem;

    cxvDadCamCorFundo.Visible    := (tpaTipApr In [aprTexto, aprCodeBar]) And (strTipImp = 'J');
    cxvDadCamRotacao.Visible     := (tpaTipApr In [aprTexto, aprCodeBar]) And (strTipImp = 'J');
    cxvDadCamTipApr.Visible      := (tpaTipApr In [aprTexto, aprCodeBar, aprQRCODE]) And (strTipImp = 'J');

    cxvDadCamDado.Visible        := ((tpaTipApr In [aprTexto, aprCodeBar, aprQRCODE]) And (tcpTipCam = camNormal) And (strTipImp = 'J')) Or (tcpTipCam = camImagem);

    cxvDadCamTipCam.Visible      := (tpaTipApr In [aprTexto, aprCodeBar, aprQRCODE]) And (strTipImp = 'J');

    cxvDadCamDecimais.Visible    := (fdtTipDad In [ftFloat]) Or (tcpTipCam = camExpressao);

    cxvDadCamAutoWidth.Visible   := tpaTipApr In [aprTexto];
    cxvDadCamAutoHeight.Visible  := tpaTipApr In [aprTexto];

    cxvDadCamBordas.Visible        := (tpaTipApr In [aprTexto]) And (strTipImp = 'J');
    cxvDadCamBordaDireita.Visible  := cxvDadCamBordas.Visible;
    cxvDadCamBordaEsquerda.Visible := cxvDadCamBordas.Visible;
    cxvDadCamBordaSuperior.Visible := cxvDadCamBordas.Visible;
    cxvDadCamBordaInferior.Visible := cxvDadCamBordas.Visible;

    cxvDadCamFont.Visible        := strTipImp = 'J';
    cxvDadCamFontMat.Visible     := strTipImp = 'M';
    cxvDadPagEspacamento.Visible := strTipImp = 'M';
    cxvDadPagLinCommand.Visible  := cxvDadPagEspacamento.Visible;
  End;
End;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamTipCamEditPropertiesChange(
  Sender: TObject);
begin

  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    If SameText(cxvDadCamTipCam.Properties.Value, 'Campo') Then
    Begin
      // MUDANDO DE EXPESSAO PARA CAMPO
      tcpTipCam  := camNormal;
      // PEGA QUALQUER UM PARA NAO FICAR VAZIO
      qryTabCam.Locate('CAM_CODCAM', strCodCam, []);
      strCodCam  := qryTabCam.FieldByName('CAM_CODCAM').AsString;
      strCapCam := qryTabCam.FieldByName('CAM_DESCAM').AsString;

      cxvDadCamDado.Visible      := True;
      cxvDadCamExpressao.Visible := False;
    End Else
    Begin
      // MUDANDO DE CAMPO PARA EXPRESSAO - O CODCAM CONTINUA O MESMO
      tcpTipCam  := camExpressao;
      strCapCam := strCodCam;

      cxvDadCamDado.Visible      := False;
      cxvDadCamExpressao.Visible := True;
    End;
  End;

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamTopEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    ErrorText := '';
    DisplayValue := FormatFloat('#0.00', DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamWidthEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    error := (fStrToFloat(DisplayValue) < 0.01);
    ErrorText := '';
    DisplayValue := FormatFloat('#0.00', DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamWordWrapEditPropertiesChange(
  Sender: TObject);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    blnWorWra := cxvDadCamWordWrap.Properties.Value;
    cxvDadCamAutoHeight.Properties.Value := blnAutHei
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamZoomEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    If DisplayValue <> Null Then
      fltBarZoo := fStrToFloat(DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadCamZooFixEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  With TLayStaticText(objCmpMvl.FCurrentNodeControl) Do
  Begin
    If DisplayValue <> Null Then
      regEditor.dblZooFix := fStrToFloat(DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiColumnsEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaInteger(DisplayValue, ErrorText, Error) Then
  Begin
    regEditor.intNrCoEt := StrToIntDef(DisplayValue, 2);

    If blnArgox Then
      regEditor.fltWidPag := (regEditor.fltLarEtq * regEditor.intNrCoEt) +
                             (regEditor.fltGpHrEt * Pred(regEditor.intNrCoEt));

  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiCorZebraEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.clrZebra := cxvDadEtiCorZebra.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiExpZebraEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  regEditor.expZebra := DisplayValue;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiGapHorEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    regEditor.fltGpHrEt := fStrToFloat(DisplayValue);

    If blnArgox Then
      regEditor.fltWidPag := (regEditor.fltLarEtq * regEditor.intNrCoEt) +
                             (regEditor.fltGpHrEt * Pred(regEditor.intNrCoEt));

    DisplayValue := FormatFloat('#0.00', DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiGapVerEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    If blnArgox And (regEditor.strInfHei <> 'S') Then
    Begin
      regEditor.fltHeiPag := regEditor.fltAltEtq + fStrToFloat(DisplayValue);
    End;

    regEditor.fltGpVrEt := fStrToFloat(DisplayValue);

    DisplayValue := FormatFloat('#0.00', DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiHeigthEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    If blnArgox And (regEditor.strInfHei <> 'S') Then
      regEditor.fltHeiPag := fStrToFloat(DisplayValue) +
                             regEditor.fltGpVrEt;

    regEditor.fltAltEtq := fStrToFloat(DisplayValue);

    DisplayValue := FormatFloat('#0.00', DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiMolDadEditPropertiesChange(
  Sender: TObject);
begin

  regEditor.intMolDad := cxvDadEtiMolDad.Properties.Value;

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiOrdenacaoEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  objEdFast.pPedeOrdenacao;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiWidthEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    If blnArgox Then
      regEditor.fltWidPag := (fStrToFloat(DisplayValue) * regEditor.intNrCoEt) +
                             (regEditor.fltGpHrEt * Pred(regEditor.intNrCoEt));

    regEditor.fltLarEtq := fStrToFloat(DisplayValue);

    DisplayValue := FormatFloat('#0.00', DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadEtiZebraEditPropertiesEditValueChanged(
  Sender: TObject);
begin

  regEditor.blnZebra := cxvDadEtiZebra.Properties.Value;

end;

Function TfrmEditorEtiquetasPrinc.fValidaDouble(var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean; blnPodeZero: Boolean = False): Boolean;
Var
  fltValue: Double;
Begin
  DisplayValue := AnsiReplaceStr(DisplayValue, '.', ',');
  fltValue := fStrToFloat(DisplayValue);

  If strTipImp = 'M' Then
  Begin
    If blnPodeZero Then
       Error := fltValue < 0
    Else
      Error := fltValue <= 0;

  End Else
    Error := fltValue < 0;

  ErrorText := '';
  Result := Not Error;
End;

Function TfrmEditorEtiquetasPrinc.fValidaInteger(var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean): Boolean;
Var
  intValue: Integer;
Begin
  intValue := StrToIntDef(DisplayValue, -1);

  If strTipImp = 'M' Then
    Error := intValue <= 0
  Else
    Error := intValue < 0;
    
  ErrorText := '';
  Result := Not Error;
End;

procedure TfrmEditorEtiquetasPrinc.pCarregarLayout(blnPadrao: Boolean; blnChamadaPeloMenu: Boolean);
begin
  pnlPadrao.Visible := objEdFast.fCarregarLayout(blnPadrao, strCodLayDoc, blnChamadaPeloMenu) And objEdFast.blnPadrao;
  edtDescri.Text    := objEdFast.strDescri;
  pEditorToDadPag;
  pEditorToDadEti;
end;

procedure TfrmEditorEtiquetasPrinc.mnuCarregarClick(Sender: TObject);
begin
  pCarregarLayout(False, True);
end;

procedure TfrmEditorEtiquetasPrinc.mnuCarregarPadraoClick(Sender: TObject);
begin
  pCarregarLayout(True, True);
end;

procedure TfrmEditorEtiquetasPrinc.mnuNovoClick(Sender: TObject);
begin
  pNovoLayout;
end;

procedure TfrmEditorEtiquetasPrinc.mnuPreviewClick(Sender: TObject);
begin
  objEdFast.pPreview;
end;

procedure TfrmEditorEtiquetasPrinc.pSalvarLayout(blnPadrao: Boolean);
begin
  objEdFast.strDescri := edtDescri.Text;
  pnlPadrao.Visible   := objEdFast.fSalvaArquivo(blnPadrao) And objEdFast.blnPadrao;
  Case objEdFast.intErrVal Of
    1: pSetFocus(edtDescri);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.mnuSalvarClick(Sender: TObject);
begin
  pSalvarLayout(False);
end;

procedure TfrmEditorEtiquetasPrinc.mnuSalvarPadraoClick(Sender: TObject);
begin
  pSalvarLayout(True);
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagAlturaEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    intIniFooAnt: Integer;
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    intIniFooAnt := regEditor.intIniFoD;

    If (regEditor.intPagina = fIndiceCustom(regEditor.strTipImp)) Then
      regEditor.fltHeiPag := fStrToFloat(DisplayValue);

    objCmpMvl.pReposicionaCamposRodape(intIniFooAnt);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagAvancarEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.strAvnPag := cxvDadPagAvancar.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagCabPriEditPropertiesEditValueChanged(
  Sender: TObject);
begin

  regEditor.strCabPri := cxvDadPagCabPri.Properties.Value;

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagEspacamentoEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.intEspaca := TcxCustomComboBoxProperties(cxvDadPagEspacamento.Properties.EditProperties).Items.IndexOf(cxvDadPagEspacamento.Properties.Value);
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagFooAltEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    intIniFooAnt: Integer;
    fltAltFooAnt: Double;
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    fltAltFooAnt := regEditor.fltFooDataAlt;
    intIniFooAnt := regEditor.intIniFoD;

    regEditor.fltFooAlt := fStrToFloat(DisplayValue);

    objCmpMvl.pReposicionaFooterData(intIniFooAnt, fltAltFooAnt, True);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagFooBraEditPropertiesChange(
  Sender: TObject);
begin

  regEditor.blnFooBra := cxvDadPagFooBra.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagFooDataAltEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    intIniFooAnt: Integer;
    fltAltFooAnt: Double;
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    fltAltFooAnt := regEditor.fltFooDataAlt;
    intIniFooAnt := regEditor.intIniFoD;

    regEditor.fltFooDataAlt := fStrToFloat(DisplayValue);

    objCmpMvl.pReposicionaFooterData(intIniFooAnt, fltAltFooAnt, False);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagFooNewPageEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnFooNewPage := cxvDadPagFooNewPage.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagFooterDataCorFundoEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.clrFooterDataCor := cxvDadPagFooterDataCorFundo.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagFooterDataEditPropertiesChange(
  Sender: TObject);
  Var
    intIniFooAnt: Integer;
    fltAltFooAnt: Double;
begin
  fltAltFooAnt := regEditor.fltFooDataAlt;
  intIniFooAnt := regEditor.intIniFoD;

  regEditor.blnFooterData := cxvDadPagFooterData.Properties.Value;
  cxvDadPagFooDataAlt.Properties.Options.Editing := regEditor.blnFooterData;

  cxvDadPagFooDataAlt.Properties.Value := regEditor.fltFooDataAlt;

  objCmpMvl.pReposicionaFooterData(intIniFooAnt, fltAltFooAnt, False);
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagFooterDataMolduraEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.intFooterDataMol := cxvDadPagFooterDataMoldura.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagFooterEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnFooter := cxvDadPagFooter.Properties.Value;

  cxvDadPagFooAlt.Properties.Value := regEditor.fltFooAlt;
  pSetaConPro;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagFooUltImpEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnImpUlt := cxvDadPagFooUltImp.Properties.Value;

  cxvDadPagFooUltImp.Visible := regEditor.blnImpUlt;

  pSetaConPro;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagHeaAltEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    fltHeaAltAnt: Double;
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin

    fltHeaAltAnt := regEditor.fltHeaAlt;

    regEditor.fltHeaAlt := fStrToFloat(DisplayValue);

    objCmpMvl.pReposicionaCamposHeader(fltHeaAltAnt, regEditor.fltHeaAlt, regEditor.intIniVer, regEditor.intIniFoD);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagHeaderDataAltEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    fltHeaDataAltAnt: Double;
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin

    fltHeaDataAltAnt := regEditor.fltHeaDataAlt;

    regEditor.fltHeaDataAlt := fStrToFloat(DisplayValue);

    objCmpMvl.pReposicionaCamposHeaderData(fltHeaDataAltAnt, regEditor.fltHeaDataAlt, regEditor.intIniVer, regEditor.intIniFoD);

  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagHeaderDataCorFundoEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.clrHeaderDataCor := cxvDadPagHeaderDataCorFundo.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagHeaderDataEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnHeaderData := cxvDadPagHeaderData.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagHeaderDataFonteEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  regEditor.pPedeFonteMatricialCabDados;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagHeaderDataMolduraEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.intHeaderDataMol := cxvDadPagHeaderDataMoldura.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagHeaderEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnHeader := cxvDadPagHeader.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagHeaderFonteEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  regEditor.pPedeFonteMatricialCabPag;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagIMPPDFEditPropertiesChange(
  Sender: TObject);
begin

  regEditor.blnImpPDF := cxvDadPagIMPPDF.Properties.Value;

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagImpressoraEditPropertiesChange(
  Sender: TObject);
begin

  regEditor.intEscMod := TcxCustomComboBoxProperties(cxvDadPagImpressora.Properties.EditProperties).Items.IndexOf(cxvDadPagImpressora.Properties.Value);

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagInfAltEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.strInfHei     := cxvDadPagInfAlt.Properties.Value;;
  cxvDadPagAltura.Visible := (regEditor.strInfHei = 'S');
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagLarguraEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error) Then
  Begin
    If (regEditor.intPagina = fIndiceCustom(regEditor.strTipImp)) Then
      regEditor.fltWidPag := fStrToFloat(DisplayValue);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagLinCommandEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin

  If fValidaDouble(DisplayValue, ErrorText, Error, True) Then
    regEditor.intLinCommand := DisplayValue;

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMarcaDAguaEditPropertiesChange(
  Sender: TObject);
begin
  //Esta essa cambiarra pq usando o properties.value nao atualiza na tela, e desse modo dispara o envento 2 vezes
  //tentei tirar o evento antes de mudar o valor e depois voltar o evento, porem o evento continua desparando 2 vezes
  //se vc resolver esse problema parabens, me conte como fez #GB#
  Inc(intQtdMarcaDagua);
  If intQtdMarcaDagua > 1 Then
  Begin
    Dec(intQtdMarcaDagua);
    Exit;
  End;
  TcxCheckBox(Sender).Checked := objEdFast.fCarregarMarcaDagua;
  Dec(intQtdMarcaDagua);

end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMargemDirEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error, True) Then
  Begin
    regEditor.fltMrgDir := DisplayValue;
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMargemEsqEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error, True) Then
  Begin
    intVerAnt := regEditor.intIniVer;
    intHorAnt := regEditor.intIniHor;

    regEditor.fltMrgEsq := DisplayValue;

    objCmpMvl.pReposicionaCamposMarLeft(intVerAnt, intHorAnt);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMargemInfEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    fltMarInfAnt: Double;
begin
  If fValidaDouble(DisplayValue, ErrorText, Error, True) Then
  Begin
    fltMarInfAnt := regEditor.fltMrgInf;

    regEditor.fltMrgInf := DisplayValue;

    objCmpMvl.pReposicionaCamposMarInf(fltMarInfAnt, regEditor.fltMrgInf);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMargemSupEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fValidaDouble(DisplayValue, ErrorText, Error, True) Then
  Begin
    intVerAnt := regEditor.intIniVer;
    intHorAnt := regEditor.intIniHor;

    regEditor.fltMrgSup := DisplayValue;

    objCmpMvl.pReposicionaCamposMarSup(intVerAnt, intHorAnt);
  End;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMolDirEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnMolDir := cxvDadPagMolDir.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMolduraEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.intMolLar := cxvDadPagMoldura.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMolEsqEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnMolEsq := cxvDadPagMolEsq.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMolInfEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnMolInf := cxvDadPagMolInf.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMolSupEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnMolSup := cxvDadPagMolSup.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagMsgProxEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnConPro := cxvDadPagMsgProx.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagOrientacaoEditPropertiesChange(
  Sender: TObject);
  Var
    intIniFooAnt: Integer;
begin
  intIniFooAnt := regEditor.intIniFoD;

  regEditor.intOrinta     := TcxCustomComboBoxProperties(cxvDadPagOrientacao.Properties.EditProperties).Items.IndexOf(cxvDadPagOrientacao.Properties.Value);

  cxvDadPagAltura.Properties.Value  := regEditor.ppzPapSiz.recPapCur.fltAltura;
  cxvDadPagLargura.Properties.Value := regEditor.ppzPapSiz.recPapCur.fltLargur;

  objCmpMvl.pReposicionaCamposRodape(intIniFooAnt);
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagPapelEditPropertiesChange(
  Sender: TObject);
  Var
    intIniFooAnt: Integer;
begin
  intIniFooAnt := regEditor.intIniFoD;

  regEditor.intPagina := TcxCustomComboBoxProperties(cxvDadPagPapel.Properties.EditProperties).Items.IndexOf(cxvDadPagPapel.Properties.Value);

  cxvDadPagEspacamento.Visible := SameText(cxvDadPagPapel.Properties.Value, 'Custom') And (regEditor.strTipImp = 'M');
  cxvDadPagLinCommand.Visible  := cxvDadPagEspacamento.Visible;

  If Not SameText(cxvDadPagPapel.Properties.Value, 'Custom') Then
  Begin
    cxvDadPagAltura.Properties.Value            := regEditor.ppzPapSiz.recPapCur.fltAltura;
    cxvDadPagLargura.Properties.Value           := regEditor.ppzPapSiz.recPapCur.fltLargur;
  End;

  cxvDadPagLargura.Properties.Options.Editing := SameText(cxvDadPagPapel.Properties.Value, 'Custom');
  cxvDadPagAltura.Properties.Options.Editing  := SameText(cxvDadPagPapel.Properties.Value, 'Custom');

  objCmpMvl.pReposicionaCamposRodape(intIniFooAnt);

  If regEditor.strTipImp = 'M' Then
    objEdFast.pMudaFontePaginaPrincipal;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagPapelViaPagEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.strNomPapVias := cxvDadPagPapel.Properties.Value;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagSemFimEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnSemFim := cxvDadPagSemFim.Properties.Value;

  If regEditor.blnSemFim  Then
  Begin
    regEditor.blnImpUlt := False;
    cxvDadPagFooBra.Visible := False;
    cxvDadPagFooNewPage.Visible := False;
    cxvDadPagFooUltImp.Properties.Value := False;
    pSetaConPro;
  End;

  cxvDadPagFooUltImp.Visible := Not regEditor.blnSemFim;
  cxvDadPagFooNewPage.Visible := regEditor.blnSemFim;
end;

procedure TfrmEditorEtiquetasPrinc.cxvDadPagViaPagEditPropertiesChange(
  Sender: TObject);
begin
  regEditor.blnViaPag          := cxvDadPagViaPag.Properties.Value;
  cxvDadPagPapelViaPag.Visible := regEditor.blnViaPag;
  cxvDadPagMsgProx.Visible     := Not regEditor.blnViaPag;

  If Not cxvDadPagMsgProx.Visible Then
    cxvDadPagMsgProx.Properties.Value := False;
end;

function TfrmEditorEtiquetasPrinc.fFiltraCampos: String;
begin
  Result := ' CAM_CODCAM NOT IN ("REFDSP", "LOTDSP", "QITDSP") ';
end;

procedure TfrmEditorEtiquetasPrinc.btnAliDirClick(Sender: TObject);
begin
  objCmpMvl.pAlinhamento(tpaDireita);
end;

procedure TfrmEditorEtiquetasPrinc.btnAliEsqClick(Sender: TObject);
begin
  objCmpMvl.pAlinhamento(tpaEsquerda);
end;

procedure TfrmEditorEtiquetasPrinc.btnAliTopClick(Sender: TObject);
begin
  objCmpMvl.pAlinhamento(tpaTopo);
end;

procedure TfrmEditorEtiquetasPrinc.btnAliBotClick(Sender: TObject);
begin
  objCmpMvl.pAlinhamento(tpaEmBaixo);
end;

procedure TfrmEditorEtiquetasPrinc.btnDesmarcaClick(Sender: TObject);
begin
  objCmpMvl.pCancelaInclusao;
end;

procedure TfrmEditorEtiquetasPrinc.btnExcLayClick(Sender: TObject);
begin
  objEdFast.fExcluiLayout;
end;

procedure TfrmEditorEtiquetasPrinc.btnExcluirClick(Sender: TObject);
begin
  objCmpMvl.pApagaCampo;
end;

procedure TfrmEditorEtiquetasPrinc.tmrReguaTimer(Sender: TObject);
begin
  tmrRegua.Enabled := False;
  regEditor.pPosicionaReguas;
end;

procedure TfrmEditorEtiquetasPrinc.btnExpressaoClick(Sender: TObject);
begin
  objCmpMvl.pSetaInclusaoExpressao;
end;

procedure TfrmEditorEtiquetasPrinc.btnHerancaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    qryTabela: TUniQuery;
begin
  chrKey := '?';

  qryTabela := fCriaQuery;

  If fPesqLayout(Self,
                 Nil,
                 Nil,
                 qryTabela,
                 strTipImp,
                 chrKey,
                 arrSel,
                 true,
                 '',
                 tplTipLay) And  objEdFast.fHerdaLayout(qryTabela) Then
   Begin
    pEditorToDadPag;
    pEditorToDadEti;
    // edtDescri.Text := objEdFast.strDescri;
   End;

  FreeAndNil(qryTabela)
end;

procedure TfrmEditorEtiquetasPrinc.btnImagemClick(Sender: TObject);
begin
  objCmpMvl.pSetaInclusaoImagem;
end;

procedure TfrmEditorEtiquetasPrinc.btnMosEtiClick(Sender: TObject);
begin
  If cxvDadEti.Visible Then
  Begin
    cxvDadEti.Visible      := False;
    pnlDadEti.ClientHeight := pnlCabEti.Height;
  End Else
  Begin
    cxvDadEti.Visible      := True;
    pnlDadEti.ClientHeight := pnlCabEti.Height + cxvDadEti.Height;
  End;
end;

procedure TfrmEditorEtiquetasPrinc.btnMosPagClick(Sender: TObject);
begin
  If cxvDadPag.Visible Then
  Begin
    cxvDadPag.Visible      := False;
    pnlDadPag.ClientHeight := pnlCabPag.Height;
  End Else
  Begin
    cxvDadPag.Visible      := True;
    pnlDadPag.ClientHeight := pnlCabPag.Height + cxvDadPag.Height;
  End;
end;

procedure TfrmEditorEtiquetasPrinc.btnNovoClick(Sender: TObject);
begin
  objEdFast.strDescri := edtDescri.Text;
  If objEdFast.fSalvaArquivo(False, True) Then
    pNovoLayout;
  btnHeranca.Visible := (tplTipLay = tplEtiquetas) Or ( (tplTipLay = tplDocumentos) And fEmptyStr(strCodLayDoc) );
  edtDescri.Text := EmptyStr;
end;

procedure TfrmEditorEtiquetasPrinc.btnPDFClick(Sender: TObject);
begin
  objEdFast.pGeraPDF;
end;

procedure TfrmEditorEtiquetasPrinc.btnPreviewClick(Sender: TObject);
begin
  btnPreview.Enabled := False;

  objEdFast.pPreview;

  btnPreview.Enabled := True;
end;

procedure TfrmEditorEtiquetasPrinc.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditorEtiquetasPrinc.btnSalvarClick(Sender: TObject);
begin
  btnSalvar.Enabled := False;

  pSalvarLayout(False);

  btnSalvar.Enabled := True;
end;

procedure TfrmEditorEtiquetasPrinc.pSetaConPro;
Begin
  With regEditor, ppzPapSiz, recPapCur, dadMargem Do
  Begin
    cxvDadPagMsgProx.Visible := (Not (blnFooter And (Not blnImpUlt))) And
                                (tplTipLay = tplDocumentos);

    If Not cxvDadPagMsgProx.Visible Then
    Begin
      cxvDadPagMsgProx.Properties.Value := False;
      regEditor.blnConPro               := False;
    End;
  End;

End;

procedure TfrmEditorEtiquetasPrinc.pEditorToDadPag;
Begin
  With regEditor, ppzPapSiz, recPapCur, dadMargem Do
  Begin
    TcxCustomComboBoxProperties(cxvDadPagPapel.Properties.EditProperties).Items.Text := strLisPap;
    cxvDadPagPapel.Properties.Value := strNomPap;
    TcxCustomComboBoxProperties(cxvDadPagOrientacao.Properties.EditProperties).Items.Text := stlOrient.Text;

    // VIA PAG
    cxvDadPagViaPag.Properties.Value := regEditor.blnViaPag;

    TcxCustomComboBoxProperties(cxvDadPagPapelViaPag.Properties.EditProperties).Items.Text := strLisPapVias;
    cxvDadPagPapelViaPag.Properties.Value := strNomPapVias;
    cxvDadPagPapelViaPag.Visible := regEditor.blnViaPag;

    If Not cxvDadPagMsgProx.Visible Then
      cxvDadPagMsgProx.Properties.Value := False;

    If (strTipImp = 'M') Then
    Begin
      cxvDadPagViaPag.Visible      := False;
      cxvDadPagPapelViaPag.Visible := False;
    End;
    // FIM - VIA PAG

    If intEspaca = 0 Then
      cxvDadPagEspacamento.Properties.Value := '1/6'
    Else
      cxvDadPagEspacamento.Properties.Value := '1/8';

    cxvDadPagOrientacao.Properties.Value := strNomOri;

    cxvDadPagAltura.Properties.Value     := fltAltura;
    cxvDadPagLargura.Properties.Value    := fltLargur;

    cxvDadPagLinCommand.Properties.Value := intLinCommand;

    cxvDadPagInfAlt.Properties.Value     :=  strInfHei;

    cxvDadPagAltura.Visible              := (Not blnArgox) Or (strInfHei = 'S');

    cxvDadPagAvancar.Properties.Value    :=  strAvnPag;
    cxvDadPagAvancar.Visible             :=  (strTipImp = 'M');


    cxvDadPagLargura.Properties.Options.Editing := False;
    cxvDadPagAltura.Properties.Options.Editing  := False;

    cxvDadPagMargemSup.Properties.Value := fltMarSup;
    cxvDadPagMargemInf.Properties.Value := fltMarInf;
    cxvDadPagMargemEsq.Properties.Value := fltMarEsq;
    cxvDadPagMargemDir.Properties.Value := fltMarDir;

    cxvDadPagMoldura.Properties.Value := intMolLar;
    cxvDadPagMolSup.Properties.Value  := blnMolSup;
    cxvDadPagMolInf.Properties.Value  := blnMolInf;
    cxvDadPagMolEsq.Properties.Value  := blnMolEsq;
    cxvDadPagMolDir.Properties.Value  := blnMolDir;

    cxvDadPagLargura.Properties.Options.Editing := SameText(cxvDadPagPapel.Properties.Value, 'Custom');
    cxvDadPagAltura.Properties.Options.Editing  := SameText(cxvDadPagPapel.Properties.Value, 'Custom');

    cxvDadPagHeader.Properties.Value := blnHeader;
    cxvDadPagHeaAlt.Properties.Value := fltHeaAlt;
    cxvDadPagCabPri.Properties.Value := strCabPri;

    cxvDadPagHeaderData.Properties.Value := blnHeaderData;
    cxvDadPagHeaderDataAlt.Properties.Value := fltHeaDataAlt;

    cxvDadPagFooter.Properties.Value    := blnFooter;
    cxvDadPagFooUltImp.Properties.Value := regEditor.blnImpUlt;
    cxvDadPagFooBra.Properties.Value    := regEditor.blnFooBra;
    cxvDadPagIMPPDF.Properties.Value    := regEditor.blnImpPDF;
    cxvDadPagFooNewPage.Properties.Value    := regEditor.blnFooNewPage;

    cxvDadPagFooAlt.Properties.Value    := fltFooAlt;

    cxvDadPagFooterData.Properties.Value := blnFooterData;
    cxvDadPagFooDataAlt.Properties.Value := fltFooDataAlt;

    cxvDadPagFooDataAlt.Properties.Options.Editing := regEditor.blnFooterData;

    cxvDadPagHeaderDataMoldura.Properties.Value  := regEditor.intHeaderDataMol;
    cxvDadPagHeaderDataCorFundo.Properties.Value := regEditor.clrHeaderDataCor;

    cxvDadPagFooterDataMoldura.Properties.Value  := regEditor.intFooterDataMol;
    cxvDadPagFooterDataCorFundo.Properties.Value := regEditor.clrFooterDataCor;

    cxvDadPagImpressora.Properties.Value := TcxCustomComboBoxProperties(cxvDadPagImpressora.Properties.EditProperties).Items[regEditor.intEscMod];

    cxvDadPagMsgProx.Properties.Value := regEditor.blnConPro;

    cxvDadPagSemFim.Properties.Value := regEditor.blnSemFim;

    cxvDadPagFooUltImp.Visible := Not regEditor.blnSemFim;
    cxvDadPagFooNewPage.Visible := regEditor.blnSemFim;
    If Not regEditor.blnSemFim Then
      cxvDadPagFooNewPage.Properties.Value := False;
    cxvDadPagEspacamento.Visible := SameText(cxvDadPagPapel.Properties.Value, 'Custom') And (regEditor.strTipImp = 'M');
    cxvDadPagLinCommand.Visible  := cxvDadPagEspacamento.Visible;

    cxvDadPagMarcaDagua.Properties.Value := objEdFast.fTemMarcaDAgua;

    pSetaConPro;
  End;
End;

procedure TfrmEditorEtiquetasPrinc.pEditorToDadEti;
Begin
  With regEditor, dadEtique Do
  Begin
    cxvDadEtiWidth.Properties.Value    := FormatFloat('#0.00', fltLarEti);
    cxvDadEtiHeigth.Properties.Value   := FormatFloat('#0.00', fltAltEti);
    cxvDadEtiColumns.Properties.Value  := intNumCol;
    cxvDadEtiGapHor.Properties.Value   := FormatFloat('#0.00', fltGapHor);
    cxvDadEtiGapVer.Properties.Value   := FormatFloat('#0.00', fltGapVer);
    cxvDadEtiZebra.Properties.Value    := blnZebra;
    cxvDadEtiMolDad.Properties.Value   := intMolDad;
    cxvDadEtiCorZebra.Properties.Value := regEditor.clrZebra;
    cxvDadEtiExpZebra.Properties.Value := regEditor.expZebra;
  End;
End;

procedure TfrmEditorEtiquetasPrinc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  objEdFast.strDescri := edtDescri.Text;

  If Not objEdFast.fSalvaArquivo(False, True) Then
    Action := canone;

  strCodLayDoc := objEdFast.strCodDoc;
end;

procedure TfrmEditorEtiquetasPrinc.FormCreate(Sender: TObject);
begin
  intQtdMarcaDagua := 0;
  blnArgox := False;
  Self.KeyPreview := True;
  scrPagina.DoubleBuffered := True;


  qryTabCam := fCriaQuery(Nil);
  dtsTabCam.DataSet := qryTabCam;

  regEditor := Nil;
  objCmpMvl := Nil;

  strCodLayDoc := '';

  strTipImp    := 'J';
end;

procedure TfrmEditorEtiquetasPrinc.FormDestroy(Sender: TObject);
begin
  qryTabCam.Close;
  FreeAndNil(qryTabCam);

  FreeAndNil(regEditor);
  FreeAndNil(objCmpMvl);
  FreeAndNil(objEdFast);
end;

procedure TfrmEditorEtiquetasPrinc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  If Key = VK_DELETE Then
//   objCmpMvl.pApagaCampo;
end;

procedure TfrmEditorEtiquetasPrinc.pCamposfterScroll(dtsDados: TDataSet);
Begin
  With qryTabCam Do
  Begin
    Filter := 'CAM_GRUETI = ' + objEdFast.qryCamTre.FieldByName('GRU_CODGRU').AsString +
              ' OR PAI1   = ' + objEdFast.qryCamTre.FieldByName('GRU_CODGRU').AsString +
              ' OR PAI2   = ' + objEdFast.qryCamTre.FieldByName('GRU_CODGRU').AsString;

    Filtered := True;
  End;
End;

procedure TfrmEditorEtiquetasPrinc.pFormataMatricial(cxeEditorRow: TcxEditorRow);
Begin
  TcxCustomCurrencyEditProperties(cxeEditorRow.Properties.EditProperties).DecimalPlaces := 0;
  TcxCustomCurrencyEditProperties(cxeEditorRow.Properties.EditProperties).DisplayFormat := '0;-0';
  TcxCustomCurrencyEditProperties(cxeEditorRow.Properties.EditProperties).MinValue := 1;
End;

procedure TfrmEditorEtiquetasPrinc.pSetaTipoImpressao(blnJato: Boolean);

  Procedure pSetaTipImpPagina;
  Begin
    btnImagem.Visible  := blnJato;

    cxvDadPagHeader.Properties.EditProperties.ReadOnly     := (Not blnJato);
    cxvDadPagHeaderData.Properties.EditProperties.ReadOnly := (Not blnJato);

    cxvDadPagOrientacao.Visible         := blnJato;
    cxvDadPagMoldura.Visible            := blnJato;

    cxvDadPagHeaderDataCorFundo.Visible := blnJato;
    cxvDadPagHeaderDataMoldura.Visible  := blnJato;

    cxvDadPagFooterDataCorFundo.Visible := blnJato And (tplTipLay = tplDocumentos);
    cxvDadPagFooterDataMoldura.Visible  := blnJato And (tplTipLay = tplDocumentos);

    cxvDadPagImpressora.Visible         := False;

    If Not blnJato Then
    Begin
      cxvDadPagHeader.Properties.Options.Editing     := False;
      cxvDadPagHeaderData.Properties.Options.Editing := False;

      frxRulerSuperior.Units := ruChars;
      frxRulerLateral.Units  := ruChars;


      pFormataMatricial(cxvDadPagAltura);
      pFormataMatricial(cxvDadPagLargura);
      pFormataMatricial(cxvDadPagMargemSup);
      pFormataMatricial(cxvDadPagMargemInf);
      pFormataMatricial(cxvDadPagMargemEsq);
      pFormataMatricial(cxvDadPagMargemDir);
      pFormataMatricial(cxvDadPagHeaAlt);
      pFormataMatricial(cxvDadPagHeaderDataAlt);
      pFormataMatricial(cxvDadPagFooAlt);
      pFormataMatricial(cxvDadPagFooDataAlt);
    End;

  End;

  Procedure pSetaTipEtiqueta;
  Begin
    cxvDadEtiZebra.Visible     := blnJato And (tplTipLay = tplDocumentos);
    cxvDadEtiCorZebra.Visible  := blnJato And (tplTipLay = tplDocumentos);
    cxvDadEtiOrdenacao.Visible := (tplTipLay = tplDocumentos);

    cxvDadEtiMolDad.Visible   := blnJato;

    If Not blnJato Then
    Begin
      pFormataMatricial(cxvDadEtiWidth);
      pFormataMatricial(cxvDadEtiHeigth);
      pFormataMatricial(cxvDadEtiGapHor);
      pFormataMatricial(cxvDadEtiGapVer);

      pnlDadEti.Height := 70;
    End Else
    Begin
      If tplTipLay = tplDocumentos Then
        pnlDadEti.Height := 120;
    End;
  End;

  Procedure pSetaTipCampo;
  Begin
    cxvDadCamCorFundo.Visible    := blnJato;
    cxvDadCamTipCam.Visible      := blnJato;
    cxvDadCamRotacao.Visible     := blnJato;
    cxvDadCamTipApr.Visible      := blnJato;
    cxvDadCamBarCode.Visible     := blnJato;
    cxvDadCamBarCodeText.Visible := blnJato;
    cxvDadCamBarCodeText.Visible := blnJato;
    cxvDadCamZoom.Visible        := blnJato;
    cxvDadCamZooFix.Visible      := blnJato;
    cxvDadCamQrCode.Visible      := blnJato;

    cxvDadCamImagem.Visible      := blnJato;
    cxvDadCamBordas.Visible      := blnJato;

    If Not blnJato Then
    Begin
      cxvDadCamLeft.Properties.Caption := 'Coluna';
      cxvDadCamTop.Properties.Caption  := 'Linha';

      pFormataMatricial(cxvDadCamLeft);
      pFormataMatricial(cxvDadCamTop);
      pFormataMatricial(cxvDadCamWidth);
      pFormataMatricial(cxvDadCamHeight);

      pnlDadCam.Height := 225;
    End;
  End;

Begin
  pSetaTipImpPagina;
  pSetaTipEtiqueta;
  pSetaTipCampo;
End;

procedure TfrmEditorEtiquetasPrinc.FormShow(Sender: TObject);
  var
    strFiltroCampos : String;
begin
  strFiltroCampos := EmptyStr;
  If tpeCodEti In CONJ_DOCUMENTOS Then
    tplTipLay := tplDocumentos
  Else
    tplTipLay := tplEtiquetas;

  pSetaTipoEtiqueta;

  pSetaTipoImpressao(strTipImp = 'J');

  pNomeEtiqueta;

  regEditor := TReguaEditor.Create(scrPagina,
                                   pnlReguaLateral, pnlReguaSuperior,
                                   pnlReguaLatAux, frxRulerSuperior,
                                   frxRulerLateral,
                                   blnArgox,
                                   scrPagina,
                                   tpeCodEti,
                                   tplTipLay,
                                   strTipImp);

  objCmpMvl := TComponentMovel.Create(Nil, //Alex
                                      pCampoToEditor,
                                      cxvDadCam,
                                      scrPagina,
                                      regEditor,
                                      qryTabCam,
                                      tpeCodEti,
                                      strTipImp);

  regEditor.pSetaComponentMovel(objCmpMvl);

  If (tpeCodEti In [tpeDespachoLaser, tpeDespachoLaserECommerce, tpeDespachoArgox,
                    tpeDespachoMatricial, tpeDespachoFaturarExpedidoLaser, tpeDespachoFaturarExpedidoArgox,
                    tpeEtiquetaDespachoVolumeGeralArgox, tpeEtiquetaDespachoVolumeIndividualArgox, tpeEtiquetaDespachoVolumeGeralLaser, tpeEtiquetaDespachoVolumeIndividualLaser]) Then
    strFiltroCampos := fFiltraCampos;

  objEdFast := TEditorFast.Create(Nil, regEditor, objCmpMvl, tpeCodEti, strTipImp);//Alex


  objEdFast.pAbreDefCampos(qryTabCam, strFiltroCampos);

  If tplTipLay = tplDocumentos Then
  Begin
    dtsGrupos.DataSet := objEdFast.qryCamTre;
    objEdFast.qryCamTre.AfterScroll := pCamposfterScroll;

    If cxtGrupos.Count > 0 Then
      cxtGrupos.Items[0].Expand(True);
  End;                        //Edmilson

  pCarregarLayout(tplTipLay = tplEtiquetas, False);

  tmrRegua.Enabled := True;

  pMontaLegenda;
end;

procedure TfrmEditorEtiquetasPrinc.pSetaTipoEtiqueta;
Begin
  If tpeCodEti In CONJ_ARGOX Then
  Begin
    blnArgox := True;
  End;

  If blnArgox Then
  Begin
    cxvDadPagPapel.Visible   := False;
    cxvDadPagAltura.Visible  := False;
    cxvDadPagLargura.Visible := False;
    cxvDadPagPapel.Properties.Value := 'Custom';
  End;

  cxvDadPagInfAlt.Visible := blnArgox;

  cxvDadPagHeader.Visible := (tpeCodEti = tpeFomulacaoTinta) Or (tplTipLay = tplDocumentos);
  cxvDadPagHeaAlt.Visible := (tpeCodEti = tpeFomulacaoTinta) Or (tplTipLay = tplDocumentos);
  cxvDadPagCabPri.Visible := (tpeCodEti = tpeFomulacaoTinta) Or (tplTipLay = tplDocumentos);

  cxvDadPagFooter.Visible := (tpeCodEti = tpeFomulacaoTinta) Or (tplTipLay = tplDocumentos);
  cxvDadPagFooAlt.Visible := (tpeCodEti = tpeFomulacaoTinta) Or (tplTipLay = tplDocumentos);

  mnuLayout.Visible   := tplTipLay = tplEtiquetas;
  btnNovo.Visible     := tplTipLay = tplEtiquetas;

  cxgLegendas.Visible := tplTipLay = tplDocumentos;
  cxtGrupos.Visible   := tplTipLay = tplDocumentos;
  btnHeranca.Visible  := (tplTipLay = tplEtiquetas) Or ( (tplTipLay = tplDocumentos) And fEmptyStr(strCodLayDoc) ); // INLCUSAO

  Case tplTipLay Of
    tplDocumentos: Begin
                     pnlCabEti.Caption := 'Linha do Item';
                     pnlCampos.Width   := pnlCampos.Width + 50;
                   End;
    tplEtiquetas : Begin
                     pnlCabEti.Caption := 'Dados da Etiqueta';
                   End;
  End;

  cxvDadEtiWidth.Visible      := (tplTipLay = tplEtiquetas) or ((tplTipLay = tplDocumentos) and (tpeCodEti = tpeCupomPromocao));
  cxvDadEtiColumns.Visible    := (tplTipLay = tplEtiquetas) or ((tplTipLay = tplDocumentos) and (tpeCodEti = tpeCupomPromocao));
  cxvDadEtiGapHor.Visible     := (tplTipLay = tplEtiquetas);
  cxvDadEtiGapVer.Visible     := (tplTipLay = tplEtiquetas);

  cxvDadEtiZebra.Visible      := (tplTipLay = tplDocumentos);
  cxvDadEtiMolDad.Visible     := (tplTipLay = tplDocumentos);

  cxvDadPagHeaderData.Visible := (tplTipLay = tplDocumentos);
  cxvDadPagFooterData.Visible := (tplTipLay = tplDocumentos);
End;

procedure TfrmEditorEtiquetasPrinc.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditorEtiquetasPrinc.pNomeEtiqueta;
Begin
  Caption := String(ARR_NOME_ETIQUETA[tpeCodEti]);
End;

(**************************************************)
(* COPIA OS DADOS DO COMPONENTE PARA A TELA (GRID)*)
(**************************************************)
Procedure TfrmEditorEtiquetasPrinc.pPosicaoToEditor;
  Var
    staCampo: TLayStaticText;
Begin
  staCampo := TLayStaticText(objCmpMvl.FCurrentNodeControl);
  With staCampo Do
  Begin
    cxvDadCamLeft.Properties.Value     := FormatFloat('#0.00', fltLeft);
    cxvDadCamTop.Properties.Value      := FormatFloat('#0.00', fltTop);
    cxvDadCamWidth.Properties.Value    := FormatFloat('#0.00', fltWidth);
    cxvDadCamHeight.Properties.Value   := FormatFloat('#0.00', fltHeight);
  End;
End;

Procedure TfrmEditorEtiquetasPrinc.pCampoToEditor;
  Var
    staCampo: TLayStaticText;
Begin
  cxvDadCam.CancelEdit;

  staCampo := TLayStaticText(objCmpMvl.FCurrentNodeControl);
  With staCampo Do
  Begin
    pPosicaoToEditor;

    cxvDadCamWordWrap.Properties.Value  := blnWorWra;
    cxvDadCamHideZeros.Properties.Value := blnHidZer;

    Case aliHAlign Of
      TfrxHAlign.haLeft  : cxvDadCamAlign.Properties.Value := 'Esquerda';
      TfrxHAlign.haRight : cxvDadCamAlign.Properties.Value := 'Direita';
      TfrxHAlign.haCenter: cxvDadCamAlign.Properties.Value := 'Centro';
    End;

    Case tprTipRot Of
      tpr0   : cxvDadCamRotacao.Properties.Value := '0';
      tpr90  : cxvDadCamRotacao.Properties.Value := '90';
      tpr270 : cxvDadCamRotacao.Properties.Value := '270';
      tpr180 : cxvDadCamRotacao.Properties.Value := '180';
    End;

    Case tcpTipCam Of
      camNormal,
      camImagem   : Begin
                      cxvDadCamTipCam.Properties.Value := 'Campo';
                      cxvDadCamDado.Properties.Value := strCodCam;

                      cxvDadCamDado.Visible      := True;
                      cxvDadCamExpressao.Visible := False;
                    End;
      camExpressao: Begin
                      cxvDadCamTipCam.Properties.Value := 'Expressão';

                      cxvDadCamDado.Visible      := False;
                      cxvDadCamExpressao.Visible := True;
                    End;
    End;

    Case tpaTipApr Of
      aprTexto  : Begin
                    cxvDadCamTipApr.Properties.Value := 'Texto';
                  End;

      aprQRCODE  : Begin
                    cxvDadCamTipApr.Properties.Value := 'QRCODE';

                    cxvDadCamBarCodeText.Properties.Value := blnBarTxt;
                    cxvDadCamZoom.Properties.Value  := FormatFloat('#0.000', fltBarZoo);

                    Case bcqBarCQR Of
                      bcCodePDF417     : cxvDadCamQrCode.Properties.Value := 'PDF417';
                      bcCodeDataMatrix : cxvDadCamQrCode.Properties.Value := 'DataMatrix';
                      Else               cxvDadCamQrCode.Properties.Value := 'CodeQR';
                    End;

                  End;

      aprCodeBar: Begin
                    cxvDadCamTipApr.Properties.Value := 'Código de Barras';
                    cxvDadCamZooFix.Properties.Value := FormatFloat('#0.000', regEditor.dblZooFix);

                    With cxvDadCamBarCode.Properties Do
                    Case bctBarCod Of
                      bcCode_2_5_interleaved: Value := '2_5_interleaved';
                      bcCode_2_5_industrial : Value := '2_5_industrial';
                      bcCode_2_5_matrix     : Value := '2_5_matrix';
                      bcCode39              : Value := '39';
                      bcCode39Extended      : Value := '39Extended';
                      bcCode128             : Value := '128';
                      bcCode128A            : Value := '128A';
                      bcCode128B            : Value := '128B';
                      bcCode128C            : Value := '128C';
                      bcCode93              : Value := '93';
                      bcCode93Extended      : Value := '93Extended';
                      bcCodeMSI             : Value := 'MSI';
                      bcCodePostNet         : Value := 'PostNet';
                      bcCodeCodabar         : Value := 'Codabar';
                      bcCodeEAN8            : Value := 'EAN8';
                      bcCodeEAN13           : Value := 'EAN13';
                      bcCodeUPC_A           : Value := 'UPC_A';
                      bcCodeUPC_E0          : Value := 'UPC_E0';
                      bcCodeUPC_E1          : Value := 'UPC_E1';
                      bcCodeUPC_Supp2       : Value := 'UPC_Supp2';
                      bcCodeUPC_Supp5       : Value := 'UPC_Supp5';
                      bcCodeEAN128A         : Value := 'EAN128A';
                      bcCodeEAN128B         : Value := 'EAN128B';
                      bcCodeEAN128C         : Value := 'EAN128C';
                    End;

                    cxvDadCamBarCodeText.Properties.Value := blnBarTxt;
                    cxvDadCamCalculaCheckSum.Properties.Value := blnChkSum;
                  End;
    End;

    cxvDadCamCorFundo.Properties.Value  := colBColor;

    If intCasDec = -1 Then
      cxvDadCamDecimais.Properties.Value := 'Não formatar'
    Else
      cxvDadCamDecimais.Properties.Value := IntToStr(intCasDec);

    cxvDadCamAutoWidth.Properties.Value  := blnAutWid;
    cxvDadCamAutoHeight.Properties.Value := blnAutHei;

    cxvDadCamBordas.Properties.Value        := fltBorEsp;
    cxvDadCamBordaSuperior.Properties.Value := blnBorTop;
    cxvDadCamBordaInferior.Properties.Value := blnBorBot;
    cxvDadCamBordaEsquerda.Properties.Value := blnBorLef;
    cxvDadCamBordaDireita.Properties.Value  := blnBorRig;

    //chkAlinhaGrade.Visible := strTipImp = 'J';
    pnlAlinhamentos.Visible := (strTipImp = 'J');

    pAjustaTelaCampos(staCampo);

    If strTipImp = 'M' Then
    Begin
      cxvDadCamFontMat.Properties.Options.Editing := Not regEditor.fCampoTemFonteDaPagina(staCampo.fltfrxTop);

      Case colFonMat Of
        col40 : cxvDadCamFontMat.Properties.Value := TcxComboBoxProperties(cxvDadCamFontMat.Properties.EditProperties).Items[0];
        col80 : cxvDadCamFontMat.Properties.Value := TcxComboBoxProperties(cxvDadCamFontMat.Properties.EditProperties).Items[1];
        col96 : cxvDadCamFontMat.Properties.Value := TcxComboBoxProperties(cxvDadCamFontMat.Properties.EditProperties).Items[2];
        col137: cxvDadCamFontMat.Properties.Value := TcxComboBoxProperties(cxvDadCamFontMat.Properties.EditProperties).Items[3];
        col160: cxvDadCamFontMat.Properties.Value := TcxComboBoxProperties(cxvDadCamFontMat.Properties.EditProperties).Items[4];
      End;
    End;  

  End;
End;

(***************************************************************)
(* COPIA OS DADOS DA TELA (GRID) PARA O COMPONENTE STATICTEXT  *)
(***************************************************************)
Procedure TfrmEditorEtiquetasPrinc.pEditorToCampo;
  Var
    staCampo: TLayStaticText;
Begin
  staCampo := TLayStaticText(objCmpMvl.FCurrentNodeControl);
  With objCmpMvl, staCampo Do
  Begin

    fltleft   := cxvDadCamLeft.Properties.Value;
    fltTop    := cxvDadCamTop.Properties.Value;
    fltWidth  := cxvDadCamWidth.Properties.Value;
    fltHeight := cxvDadCamHeight.Properties.Value;

    PositionNodes(FCurrentNodeControl);
  End;

End;

Procedure TfrmEditorEtiquetasPrinc.pNovoLayout;
Begin
  objEdFast.pNovoLayout;
  pnlPadrao.Visible := objEdFast.blnPadrao;
  edtDescri.Text    := objEdFast.strDescri;
  pEditorToDadPag;
  pEditorToDadEti;
End;

Procedure TfrmEditorEtiquetasPrinc.pMontaLegenda;

  Procedure pIncluiDado(strNomCam: String; intPosCam: Integer);
  Begin
    With cdsLegendas Do
    Begin
      Insert;
      FieldByName('DESTIP').AsString  := strNomCam;
      FieldByName('POSCAM').AsInteger := intPosCam;
      Post;
    End;
  End;


Begin
  cdsLegendas := TZClient.Create(Self, 'SELECT  "MMMMMMMMMMMMMMMMMMMMMMMMMMMM" AS DESTIP, 0 AS POSCAM');
  cdsLegendas.fAbreClient(True, 'TfrmEditorEtiquetasPrinc.pMontaLegenda');
  cdsLegendas.EmptyDataSet;

  pIncluiDado('CABEÇALHO DE PÁGINA', VAL_CABEC_PAGINA);
  pIncluiDado('CABEÇALHO DOS ITENS', VAL_CABEC_DADOS);
  pIncluiDado('DADOS DOS ITENS',     VAL_DADOS);
  pIncluiDado('RODAPÉ DOS ITENS',    VAL_RODAPE_DADOS);
  pIncluiDado('RODAPÉ DE PÁGINA',    VAL_RODAPE_PAGINA);

  cdsLegendas.IndexFieldNames := 'POSCAM';
  cdsLegendas.pAlinhaCampoCentro('DESTIP');

  cxgLegendasView.DataController.DataSource := cdsLegendas.dtsSource;
End;

end.


