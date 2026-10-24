unit untLibCartoesConfirmacaoDeCartoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Dialogs,
  System.Classes, Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.AppEvnts,Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.Mask, Datasnap.DBClient,

  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxStyles, cxImageComboBox, cxTextEdit, AdvMenus, dxDockControl, dxCustomHint,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxPC, dxCore,
  cxDateUtils, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDBData, cxCurrencyEdit, cxButtonEdit, dxScreenTip, cxHint, cxClasses,
  cxImageList, cxGridBandedTableView, cxGridDBBandedTableView, MaskEditFocus,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, dxGDIPlusClasses, cxCheckBox, cxMaskEdit,
  cxDropDownEdit, cxCalendar, dxDockPanel, cxVGrid, cxDBVGrid,
  cxInplaceContainer, EditFocus, cxButtons, cxGroupBox, Uni,  DBAccess, MemDS,
  UniClientDataSet,cxProgressBar,

  untLibCartoesPai, untTLibCartoesFuncoes, untTConfirmaCartoes,
  TipoConciliadora.Classes, untLibCartoesConstantes, untLibCartoesInterfacesTipos;

type
  TfrmLibCartoesConfirmacaoDeCartoes = class(TfrmPai)
    Panel1: TPanel;
    cxBtnSair: TBitBtnLocked;
    FlowPanel1: TFlowPanel;
    BitBtnLocked1: TBitBtnLocked;
    Panel4: TPanel;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    pnlFundo: TPanel;
    grpOpcoes: TcxGroupBox;
    btnAtualizarPendentes: TcxButton;
    grpExtrato: TcxGroupBox;
    dxDockSite1: TdxDockSite;
    dxLayoutDockSite3: TdxLayoutDockSite;
    dxLayoutDockSite1: TdxLayoutDockSite;
    dckpnlExtrato: TdxDockPanel;
    cxGroupBox4: TcxGroupBox;
    Panel7: TPanel;
    Label16: TLabel;
    btnConfigPainel: TcxButton;
    btnPrintExtBan: TcxButton;
    gbPeriodoExtrato: TcxGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    dtaIniExt: TcxDateEdit;
    dtaFinExt: TcxDateEdit;
    grdExtratoVendas: TcxGrid;
    grdExtratoVendasDBTableView: TcxGridDBTableView;
    grdExtratoVendasDBTableViewEXT_STATUS: TcxGridDBColumn;
    grdExtratoVendasDBTableViewEXT_DTACUP: TcxGridDBColumn;
    grdExtratoVendasDBTableViewEXT_VALBRU: TcxGridDBColumn;
    grdExtratoVendasDBTableViewAUTOINCREM: TcxGridDBColumn;
    grdExtratoVendasDBTableViewEXT_ARQIMP: TcxGridDBColumn;
    grdExtratoVendasLevel1: TcxGridLevel;
    dxVertContainerDockSite1: TdxVertContainerDockSite;
    dckpnlPendentes: TdxDockPanel;
    gbPeriodoLanPen: TcxGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    mskDtaIniPen: TcxDateEdit;
    mskDtaFinPen: TcxDateEdit;
    gbLancPendenteRodape: TcxGroupBox;
    btnVincular: TcxButton;
    dckpnlConcil: TdxDockPanel;
    gbLanVinculados: TcxGroupBox;
    btnDesvincular: TcxButton;
    grpTotais: TcxGroupBox;
    Panel9: TPanel;
    Label7: TLabel;
    btnExpand: TcxButton;
    grdTotais: TcxGrid;
    grdTotaisDBBandedTableViewCitelTotalizadorStatus: TcxGridDBBandedTableView;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn1: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn2: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn3: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn4: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn5: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn6: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn7: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn8: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn9: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn10: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn11: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn12: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn13: TcxGridDBBandedColumn;
    grdTotaisLevel1: TcxGridLevel;
    imglDiversas16: TcxImageList;
    imglPendentes: TcxImageList;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    HintControler: TcxHintStyleController;
    dxDockingManager: TdxDockingManager;
    AdvMenuStyler1: TAdvMenuStyler;
    svdConfigPanel: TSaveDialog;
    mmnConfigPaineis: TAdvPopupMenu;
    ConfiguraesdosPainis1: TMenuItem;
    mnuSalvarLayout: TMenuItem;
    mnuExportarLayout: TMenuItem;
    mnuImportarLayout: TMenuItem;
    mnuRedefinirLayout: TMenuItem;
    btnImportarVendas: TcxButton;
    AdvPopupMenuImpVendas: TAdvPopupMenu;
    mnuRedeCardOnline: TMenuItem;
    gpbLanPendentes: TcxGroupBox;
    grdPendOperadora: TcxDBVerticalGrid;
    grdPendOperadoraIMGCON: TcxDBEditorRow;
    grdPendOperadoraNOMCON: TcxDBEditorRow;
    grdPendOperadoraQtdPendentes: TcxDBEditorRow;
    grdPendOperadoraMarcado: TcxDBEditorRow;
    grdExtratoVendasDBTableViewEXT_CODAUT: TcxGridDBColumn;
    grdExtratoVendasDBTableViewEXT_NUMNSU: TcxGridDBColumn;
    grdExtratoVendasDBTableViewEXT_DTAVEN: TcxGridDBColumn;
    grdExtratoVendasDBTableViewEXT_PARCEL: TcxGridDBColumn;
    grdExtratoVendasDBTableViewEXT_VALTAX: TcxGridDBColumn;
    grdExtratoVendasDBTableViewEXT_VALLIQ: TcxGridDBColumn;
    cxGrid1: TcxGrid;
    cxGridDBTableViewMOVCAR: TcxGridDBTableView;
    cxGridDBTableViewMOVCAR_MCA_NUMCCD: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_MCA_NUMNSU: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_MCA_PARCEL: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_MCA_NUMCUP: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_MCA_VALSTA: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_MCA_VALTAX: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_MCA_VALDUP: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGridDBTableViewMOVCAR_Confirmado: TcxGridDBTableView;
    cxGridDBTableViewMOVCAR_Confirmado_MCA_NUMCCD: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_Confirmado_MCA_NUMNSU: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_Confirmado_MCA_PARCEL: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_Confirmado_MCA_DTACUP: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_Confirmado_MCA_VALSTA: TcxGridDBColumn;
    cxGridDBColumn19: TcxGridDBColumn;
    cxGridDBColumn20: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_Confirmado_MCA_VALTAX: TcxGridDBColumn;
    cxGridDBTableViewMOVCAR_Confirmado_MCA_VALDUP: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    Panel3: TPanel;
    Image2: TImage;
    Label9: TLabel;
    Image3: TImage;
    Label10: TLabel;
    cxGroupBox5: TcxGroupBox;
    pnlCaption: TPanel;
    Label1: TLabel;
    gpbPontoVendas: TcxGroupBox;
    cxGridPontosDeVenda: TcxGrid;
    cxGridDBTableViewResumoBandeira: TcxGridDBTableView;
    cxGridDBTableViewResumoBandeiraTOTAL_TAXA: TcxGridDBColumn;
    cxGridLevel4: TcxGridLevel;
    cxGridDBTableViewResumoBandeiraESTABELECIMENTO: TcxGridDBColumn;
    cxGridDBTableViewResumoBandeiraTOTAL_BRUTO: TcxGridDBColumn;
    cxGridDBTableViewResumoBandeiraTOTAL_LIQUIDO: TcxGridDBColumn;
    cxGridDBTableViewResumoBandeiraQUANTIDADE: TcxGridDBColumn;
    cxGridDBTableViewResumoBandeiraLOGO: TcxGridDBColumn;
    imgLogoBandeiras: TcxImageList;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyleRepository3: TcxStyleRepository;
    cxStyle13: TcxStyle;
    cxStyle14: TcxStyle;
    cxStyle15: TcxStyle;
    cxStyle16: TcxStyle;
    grdPendOperadoraDBEditorRow1: TcxDBEditorRow;
    chkLancSimilares: TcxCheckBox;
    tmrCarregaCartaoParaVincular: TTimer;
    Label2: TLabel;
    Image4: TImage;
    btnIncluirLancamento: TcxButton;
    btnAlterarCartao: TcxButton;
    cxStyle17: TcxStyle;
    Image5: TImage;
    Label3: TLabel;
    btnRecomporLancamento: TcxButton;
    btnIgnorarLancamento: TcxButton;
    btnCarregar: TcxButton;
    btnPesqPend: TcxButton;
    grdExtratoVendasDBTableViewEXT_NUM_PV: TcxGridDBColumn;
    Label4: TLabel;
    Image6: TImage;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn14: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn15: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn16: TcxGridDBBandedColumn;
    grdTotaisDBBandedTableViewCitelTotalizadorStatusColumn17: TcxGridDBBandedColumn;
    btnConciliacao: TBitBtnLocked;
    mnuPagarMe: TMenuItem;
    procedure btnImportarVendasClick(Sender: TObject);
    procedure mnuRedeCardOnlineClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAtualizarPendentesClick(Sender: TObject);
    procedure dxVertContainerDockSite1CanResize(Sender: TdxCustomDockControl;
      NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure btnExpandClick(Sender: TObject);
    procedure cxGridDBTableViewMOVCARCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBTableViewResumoBandeiraCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grdExtratoVendasDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure mnuSalvarLayoutClick(Sender: TObject);
    procedure mnuRedefinirLayoutClick(Sender: TObject);
    procedure mnuExportarLayoutClick(Sender: TObject);
    procedure mnuImportarLayoutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdPendOperadoraDblClick(Sender: TObject);
    procedure grdPendOperadoraStylesGetContentStyle(Sender: TObject;
      AEditProp: TcxCustomEditorRowProperties; AFocused: Boolean;
      ARecordIndex: Integer; var AStyle: TcxStyle);
    procedure btnPesqPendClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure tmrCarregaCartaoParaVincularTimer(Sender: TObject);
    procedure dsExtratoDataChange(Sender: TObject; Field: TField);
    procedure btnIncluirLancamentoClick(Sender: TObject);
    procedure btnAlterarCartaoClick(Sender: TObject);
    procedure cxGridDBTableViewMOVCAR_ConfirmadoCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnVincularClick(Sender: TObject);
    procedure btnDesvincularClick(Sender: TObject);
    procedure btnIgnorarLancamentoClick(Sender: TObject);
    procedure btnRecomporLancamentoClick(Sender: TObject);
    procedure grdTotaisDBBandedTableViewCitelTotalizadorStatusCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConciliacaoClick(Sender: TObject);
    procedure btnPrintExtBanClick(Sender: TObject);
    procedure cxBtnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ImportarVendas(Sender: TObject);
  private
    { Private declarations }
    FQueryExtrato: TUniQuery;
    FQueryExtratoPendentes: TUniQuery;
    FQueryResumoBandeiras: TUniQuery;
    FQueryTotalizadorStatus: TUniQuery;
    FQueryCartoesParaVincular: TUniQuery;
    FQueryCartoesConfirmados: TUniQuery;

    FDataSourceResumoBandeiras: TDataSource;
    FDataSourceTotalizadorStatus: TDataSource;
    FDataSourceExtratoPendentes: TDataSource;
    FDataSourceExtrato: TDataSource;
    FDataSourceCartoesParaVincular: TDataSource;
    FDataSourceCartoesConfirmados: TDataSource;

    FConfirmaCartoes: TConfirmaCartoes;
    FExecuteFormShow: Boolean;

    dxInitialize: procedure; StdCall;

    LibCartoesHandle: THandle;

    procedure ExecutarTeclasAtalho(Key: Word);

    procedure AtualizarRegistros;
    procedure AtualizarTotalizadorPorStatus;

    procedure CriarObjetosDeConsulta;
    procedure AjustaColunasGridExtratoVendas;
    procedure AjustaColunasGridCartoesParaVincular;
    procedure AjustaColunasGridCartoesConfirmados;
    procedure AjustaColunasGridResumoBandeira;
    procedure AjustaLarguraColunaBanderia;
    procedure OnResizeGrupoPontoVendas(ANewWidth: Integer);

    procedure CarregadaExtratoVendas;
    procedure CarregaExtratosComVendasPendentes;
    procedure CarregaResumoBandeiraExtrato;
    procedure CarregaCartoesParaVincularPorPeriodo;
    procedure CarregaCartaoParaVincular;
    procedure CarregaCartaoConfirmado;
    procedure CarregaVendasParaConfimarPorPeriodo;

    procedure ExecutarConsultaCartao;

    procedure SalvaLayoutPaineis(AExibirMensagem: Boolean);
    procedure CarregaLayoutPaineis;
    procedure RedefinirLayoutPaineis;
    procedure ExportarLayoutPaineis;
    procedure ImportarLayoutPaineis;

    procedure ChamaManutencaoCartaoParaAlteracao;
    procedure ChamaManutencaoCartaoParaInclusao;

    procedure SelecionarLancamentosPendentes;
    procedure MarcaOperadoraSelecionada;
    procedure AtualizaStatusLancamento;

    procedure VincularLancamentoManualmente;
    procedure DesvincularLancamentoManualmente;
    procedure IgnorarLancamentoManualmente;
    procedure RecomporLancamentoManualmente;

    function ValidaDataFinalLacamentosPendentes: Boolean;
    function ValidaDataFinalExtratoVendas: Boolean;
    function ValidaDataInicialLancamentosPendentes: Boolean;
    function ValidaDataInicialExtratoVendas: Boolean;

    procedure LimparCampos;

    procedure AbreConciliacao;

    function ImprimirExtrato(pgbProgresso: TcxProgressBar): Boolean;
    function PermitirImportarExtrato(AOperadora: String): Boolean;

    function PermitirIgnorarCartaoes(AOperadora: String): Boolean;
    function PermitirRecomporCartaoesIgnorados(AOperadora: String): Boolean;

    procedure CarregaLibCartoes;
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untTMenuImportaVendas, untLibCartoesLancPendentesConfirmacao,
     untTDockingManager;

const
  IMP_EXT_DLL = '.\libLayoutsFR3.dll';

{$WARN SYMBOL_PLATFORM OFF}
procedure pExtratoConfirmacaoCartao(AEmpresa:String; ACorZebra: Integer; ADataset: TDataset); stdcall; External IMP_EXT_DLL delayed;
{$WARN SYMBOL_PLATFORM ON}

{$R *.dfm}

procedure TfrmLibCartoesConfirmacaoDeCartoes.AbreConciliacao;
begin

  If FConfirmaCartoes.Conciliadora.IsEmpty Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Selecione uma operadora!', ['&Ok']);
    Exit;
  End;

  Try
    Self.Hide;
    Try
      if FConfirmaCartoes.Conciliadora.Equals('REDECARD') then
        untLibCartoesConstantes.MenuConciliacaoCartoes.Find('Conciliação RedeCard Online').Click
      else
        untLibCartoesConstantes.MenuConciliacaoCartoes.Find('Conciliação Pagar.Me').Click;

      TLibCartoesFuncoes.AguardeExecutarModalA(AtualizarRegistros,'Aguarde, Atualizando Registros...', '');
    Finally
      Self.Show;
    End;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.AbreConciliacao]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.AjustaColunasGridCartoesParaVincular;
begin
  Application.ProcessMessages;
  cxGridDBTableViewMOVCAR.BeginUpdate;
  Try
    If Not FDataSourceCartoesParaVincular.DataSet.IsEmpty Then
    Begin
      cxGridDBTableViewMOVCAR.ApplyBestFit;
    End;
  Finally
    cxGridDBTableViewMOVCAR.EndUpdate;
    Application.ProcessMessages;
  End;
end;


procedure TfrmLibCartoesConfirmacaoDeCartoes.AjustaColunasGridCartoesConfirmados;
begin
  Application.ProcessMessages;
  cxGridDBTableViewMOVCAR_Confirmado.BeginUpdate;
  Try
    If Not FDataSourceCartoesConfirmados.DataSet.IsEmpty Then
    Begin
      cxGridDBTableViewMOVCAR_Confirmado.ApplyBestFit;
    End;
  Finally
    cxGridDBTableViewMOVCAR_Confirmado.EndUpdate;
    Application.ProcessMessages;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.AjustaColunasGridExtratoVendas;
begin
  Application.ProcessMessages;
  grdExtratoVendas.BeginUpdate;
  Try

    If Not FDataSourceExtrato.DataSet.IsEmpty Then
    Begin
      grdExtratoVendasDBTableView.ApplyBestFit;
      grdExtratoVendasDBTableViewEXT_STATUS.Width := 25;
    End;
  Finally
    grdExtratoVendas.EndUpdate;
  End;
  Application.ProcessMessages;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.AjustaColunasGridResumoBandeira;
begin
  Application.ProcessMessages;
  cxGridDBTableViewResumoBandeira.BeginUpdate;
  Try

    If Not FDataSourceResumoBandeiras.DataSet.IsEmpty Then
    Begin
      cxGridDBTableViewResumoBandeiraESTABELECIMENTO.GroupIndex := -1;
      cxGridDBTableViewResumoBandeira.ApplyBestFit;
      cxGridDBTableViewResumoBandeiraESTABELECIMENTO.GroupIndex := 0;
      AjustaLarguraColunaBanderia;
    End;

  Finally
    cxGridDBTableViewResumoBandeira.EndUpdate;
  End;
  Application.ProcessMessages;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.AjustaLarguraColunaBanderia;
  Var
    LLarguraTotalColunas: Integer;
begin
  LLarguraTotalColunas := (cxGridDBTableViewResumoBandeiraQUANTIDADE.Width  +
                           cxGridDBTableViewResumoBandeiraTOTAL_BRUTO.Width +
                           cxGridDBTableViewResumoBandeiraTOTAL_TAXA.Width  +
                           cxGridDBTableViewResumoBandeiraTOTAL_LIQUIDO.Width);

  cxGridDBTableViewResumoBandeiraLOGO.Width := ((cxGridPontosDeVenda.Width - LLarguraTotalColunas) - 40);
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.AtualizarRegistros;
begin
  CarregadaExtratoVendas;
  CarregaResumoBandeiraExtrato;
  ExecutarConsultaCartao;
  AtualizarTotalizadorPorStatus;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.AtualizarTotalizadorPorStatus;
begin

  Try
    FConfirmaCartoes.ConsultaTotalizadorPorStatus(FQueryTotalizadorStatus);
    FQueryTotalizadorStatus.First;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.AtualizarTotalizadorPorStatus]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.AtualizaStatusLancamento;
  Var
    LRecNo: Integer;
begin
  LRecNo := 0;

  Try
    FQueryExtrato.DisableControls;
    LRecNo := FQueryExtrato.RecNo;
    FQueryExtrato.Filtered := False;
    FQueryExtrato.Filter := ' AUTOINCREM  = ' + QuotedStr(FQueryExtrato.FieldByName('AUTOINCREM').AsString);
    FQueryExtrato.Filtered := True;

    FConfirmaCartoes.Extrato := FQueryExtrato;
    FConfirmaCartoes.ProcessaExtratoParaVincular;
    FQueryExtrato.Refresh;
  Finally
    FQueryExtrato.Filtered := False;
    FQueryExtrato.Filter   := '';
    FQueryExtrato.EnableControls;
    FQueryExtrato.RecNo := LRecNo;
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnAlterarCartaoClick(Sender: TObject);
begin
  inherited;
  If FQueryCartoesParaVincular.IsEmpty Then
  Begin
    TLibCartoesFuncoes.fMensagem('Aviso', 'É necessário carregar ao menos um cartão!', ['&O k']);
    Exit;
  End;

  TLibCartoesFuncoes.AguardeExecutarModalA(ChamaManutencaoCartaoParaAlteracao,'Aguarde, Atualizando Registros...', '');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnAtualizarPendentesClick(Sender: TObject);
begin
  inherited;
  CarregaExtratosComVendasPendentes;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnCarregarClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(dtaIniExt) Then
    Exit;

  If Not fValidaCampos(dtaFinExt) Then
    Exit;

  If FConfirmaCartoes.Conciliadora.IsEmpty Then
  Begin
    TLibCartoesFuncoes.fMensagem('Aviso', 'Selecione a operadora!', ['&O k']);
    Exit;
  End;

  TLibCartoesFuncoes.AguardeExecutarModalA(CarregaVendasParaConfimarPorPeriodo,'Aguarde, Carregando venda(s)...', '');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnConciliacaoClick(Sender: TObject);
begin
  inherited;
  TLibCartoesFuncoes.AguardeExecutarModalA(AbreConciliacao,'Aguarde, Conciliando Lançamentos.', '');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnDesvincularClick(Sender: TObject);
begin
  inherited;
  TLibCartoesFuncoes.AguardeExecutarModalA(DesvincularLancamentoManualmente,'Aguarde, Desvinculando Lançamento.', '');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnExpandClick(Sender: TObject);
begin
  inherited;
  If grpTotais.Height = 34 Then
  Begin
    grpTotais.Height := 120;
    btnExpand.OptionsImage.ImageIndex := 24;
    btnExpand.Caption := '&Ocultar';
  End
  Else
  Begin
    grpTotais.Height := 34;
    btnExpand.OptionsImage.ImageIndex := 25;
    btnExpand.Caption := '&Exibir';
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnIgnorarLancamentoClick(Sender: TObject);
begin
  inherited;

  If FQueryExtrato.FieldByName('EXT_STATUS').AsString.Equals('C') Then
  Begin
    TLibCartoesFuncoes.fMensagem('Aviso', 'Lançamentos confirmados não podem ser ignorados!', ['&O k']);
    Exit;
  End;

  If Not PermitirIgnorarCartaoes(FQueryExtrato.FieldByName('EXT_NOMCON').AsString) Then
    Exit;

  TLibCartoesFuncoes.AguardeExecutarModalA(IgnorarLancamentoManualmente,'Aguarde, Ignorando Lançamento.', '');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnImportarVendasClick(Sender: TObject);
  Var
    Pt : TPoint;
begin
  inherited;
  GetCursorPos(Pt);
  AdvPopupMenuImpVendas.Popup(Pt.X+15, Pt.Y+10);
  LimparCampos;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnPesqPendClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(mskDtaIniPen) Then
    Exit;

  If Not fValidaCampos(mskDtaFinPen) Then
    Exit;

  If FQueryExtrato.IsEmpty Then
  Begin
    TLibCartoesFuncoes.fMensagem('Aviso', 'É necessário carregar um extrato de vendas para executar esse filtro!', ['&O k']);
    Exit;
  End;

  TLibCartoesFuncoes.AguardeExecutarModalA(CarregaCartoesParaVincularPorPeriodo,'Aguarde, Carregando lançamento(s)...', '');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnPrintExtBanClick(Sender: TObject);
begin
  inherited;
  TLibCartoesFuncoes.ExecutaAguarde(ImprimirExtrato,'Aguarde, Imprimindo Lançamentos...');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnRecomporLancamentoClick(Sender: TObject);
begin
  inherited;
  If Not FQueryExtrato.FieldByName('EXT_STATUS').AsString.Equals('I') Then
  Begin
    TLibCartoesFuncoes.fMensagem('Aviso', 'O lançamento deve estar ignorado para recompor!', ['&O k']);
    Exit;
  End;

  If Not PermitirRecomporCartaoesIgnorados(FQueryExtrato.FieldByName('EXT_NOMCON').AsString) Then
    Exit;

  TLibCartoesFuncoes.AguardeExecutarModalA(RecomporLancamentoManualmente,'Aguarde, Recompondo Lançamento.', '');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnVincularClick(Sender: TObject);
begin
  inherited;
  TLibCartoesFuncoes.AguardeExecutarModalA(VincularLancamentoManualmente,'Aguarde, Vinculando Lançamento.', '');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CarregaCartaoParaVincular;
begin
  Try

    If FQueryExtrato.IsEmpty Then
      Exit;

    FQueryCartoesConfirmados.Close;
    FQueryCartoesParaVincular.Close;

    If FQueryExtrato.FieldByName('EXT_STATUS').AsString.Equals('I') Then
      Exit;

    If Not FQueryExtrato.FieldByName('EXT_SEQMCA').IsNull Then
    Begin
      CarregaCartaoConfirmado;
      Exit;
    End;


    If Not FQueryCartoesParaVincular.ControlsDisabled Then
      FQueryCartoesParaVincular.DisableControls;

    FConfirmaCartoes.DataInicial := FQueryExtrato.FieldByName('EXT_DTACUP').AsDateTime;
    FConfirmaCartoes.DataFinal   := FQueryExtrato.FieldByName('EXT_DTACUP').AsDateTime;
    FConfirmaCartoes.Nsu         := FQueryExtrato.FieldByName('EXT_NUMNSU').AsString;
    FConfirmaCartoes.Autorizacao := FQueryExtrato.FieldByName('EXT_CODAUT').AsString;
    FConfirmaCartoes.Parcela     := FQueryExtrato.FieldByName('EXT_PARCEL').AsString;
    FConfirmaCartoes.Similares   := False;

    FConfirmaCartoes.ConsultaCartaoParaVincular(FQueryCartoesParaVincular);

    If Not FQueryCartoesParaVincular.IsEmpty Then
    Begin
      FQueryCartoesParaVincular.First;
      FQueryCartoesParaVincular.EnableControls;
      AjustaColunasGridCartoesParaVincular;
    End;


  Except
    On E:Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaCartaoParaVincular]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CarregaCartaoConfirmado;
begin
  Try
    If FQueryExtrato.IsEmpty Then
      Exit;

    If FQueryExtrato.FieldByName('EXT_SEQMCA').IsNull Then
      Exit;

    If Not FQueryCartoesConfirmados.ControlsDisabled Then
      FQueryCartoesConfirmados.DisableControls;

    FConfirmaCartoes.AutoIncremCartao := FQueryExtrato.FieldByName('EXT_SEQMCA').AsString;
    FConfirmaCartoes.ConsultaCartoesConfirmados(FQueryCartoesConfirmados);

    If Not FQueryCartoesConfirmados.IsEmpty Then
    Begin
      FQueryCartoesConfirmados.First;
      FQueryCartoesConfirmados.EnableControls;
      AjustaColunasGridCartoesConfirmados;
    End;

  Except
    On E:Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaCartaoConfirmado]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CarregaCartoesParaVincularPorPeriodo;
begin
  Try
    If Not FQueryCartoesParaVincular.ControlsDisabled Then
      FQueryCartoesParaVincular.DisableControls;

    FConfirmaCartoes.DataInicial := mskDtaIniPen.Date;
    FConfirmaCartoes.DataFinal   := mskDtaFinPen.Date;
    FConfirmaCartoes.Nsu         := FQueryExtrato.FieldByName('EXT_NUMNSU').AsString;
    FConfirmaCartoes.Autorizacao := FQueryExtrato.FieldByName('EXT_CODAUT').AsString;
    FConfirmaCartoes.Parcela     := FQueryExtrato.FieldByName('EXT_PARCEL').AsString;
    FConfirmaCartoes.ValorBruto  := FQueryExtrato.FieldByName('EXT_VALBRU').AsFloat;
    FConfirmaCartoes.Similares   := chkLancSimilares.Checked;

    If FConfirmaCartoes.Similares Then FConfirmaCartoes.ConsultaCartoesSimilaresParaVincular(FQueryCartoesParaVincular)
    Else FConfirmaCartoes.ConsultaCartaoParaVincular(FQueryCartoesParaVincular);

    If Not FQueryCartoesParaVincular.IsEmpty Then
    Begin
      FQueryCartoesParaVincular.First;
      FQueryCartoesParaVincular.EnableControls;
      AjustaColunasGridCartoesParaVincular;
    End;

  Except
    On E:Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaCartoesParaVincularPorPeriodo]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CarregadaExtratoVendas;
begin
  Try
    FConfirmaCartoes.ConsultaExtratoVenda(FQueryExtrato);
    AjustaColunasGridExtratoVendas;
    FConfirmaCartoes.Extrato := FQueryExtrato;
    FConfirmaCartoes.ProcessaExtratoParaVincular;
    FQueryExtrato.Refresh;
    FQueryExtrato.First;
  Except
    On E:Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregadaExtratoVendas]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CarregaExtratosComVendasPendentes;
begin

  Try
    FQueryExtratoPendentes.DisableControls;
    FConfirmaCartoes.ConsultaExtratosComVendasPendentes(FQueryExtratoPendentes);
    FQueryExtratoPendentes.First;
    FQueryExtratoPendentes.EnableControls;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaExtratosComVendasPendentes]');
    End;
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CarregaLayoutPaineis;
  Var
    LDadosDockingManager : TDadosDockingManager;
begin
  Try
    LDadosDockingManager.DockingManager := dxDockingManager;
    LDadosDockingManager.NomeFormulario := Self.Name;
    LDadosDockingManager.Operador       := VS_FuncoesExternas.fIRetOperadorLogado;
    LDadosDockingManager.Empresa        := VS_FuncoesExternas.fIRetEmpresaLogada;

    untTDockingManager.CarregarLayout(LDadosDockingManager);
    dxVertContainerDockSite1.OnCanResize := dxVertContainerDockSite1CanResize;
    OnResizeGrupoPontoVendas(dxVertContainerDockSite1.Width);
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaLayoutPaineis]');
    End;
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CarregaLibCartoes;
  Var
    LCaminho: String;

    RetornaItensMenuImportacaoCartoes: function: TMenuItem;
    RetornaItensMenuConciliacaoCartoes: function: TMenuItem;
begin
  If LibCartoesHandle > 0 Then
    Exit;

  LCaminho := ExtractFilePath(Application.ExeName) + 'libCartoes\libCartoesAutcom.dll';

  LibCartoesHandle := 0;
  If Not FileExists(LCaminho) Then
    Exit;

  LibCartoesHandle := LoadLibrary(PChar(LCaminho));

  dxInitialize := GetProcAddress(LibCartoesHandle, 'dxInitialize');
  dxInitialize;

  RetornaItensMenuImportacaoCartoes := GetProcAddress(LibCartoesHandle, PChar('RetornaItensMenuImportacaoCartoes'));
  RetornaItensMenuConciliacaoCartoes := GetProcAddress(LibCartoesHandle, PChar('RetornaItensMenuConciliacaoCartoes'));

  untLibCartoesConstantes.MenuImportacaoCartoes := TMenuItem.Create(Application);
  untLibCartoesConstantes.MenuImportacaoCartoes := RetornaItensMenuImportacaoCartoes;

  untLibCartoesConstantes.MenuConciliacaoCartoes := TMenuItem.Create(Application);
  untLibCartoesConstantes.MenuConciliacaoCartoes := RetornaItensMenuConciliacaoCartoes;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CarregaResumoBandeiraExtrato;
begin

  Try
    FConfirmaCartoes.ConsultaResumoBandeiraExtrato(FQueryResumoBandeiras);
    AjustaColunasGridResumoBandeira;
    FQueryResumoBandeiras.First;
    cxGridDBTableViewResumoBandeira.ViewData.Expand(True);
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaResumoBandeiraExtrato]');
    End;
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CarregaVendasParaConfimarPorPeriodo;
begin
  Try
    FConfirmaCartoes.DataInicial := dtaIniExt.Date;
    FConfirmaCartoes.DataFinal   := dtaFinExt.Date;
    FConfirmaCartoes.FLancamentosSelecionados.DataTransacao := '';

    FConfirmaCartoes.ConsultaVendasParaConfirmarPorPeriodo(FQueryExtrato);
    AjustaColunasGridExtratoVendas;
    FQueryExtrato.First;

    FConfirmaCartoes.Extrato := FQueryExtrato;
    FConfirmaCartoes.ProcessaExtratoParaVincular;
    CarregaResumoBandeiraExtrato;
    AtualizarTotalizadorPorStatus;
  Except
    On E:Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaVendasParaConfimarPorPeriodo]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.ChamaManutencaoCartaoParaAlteracao;
begin
  Try
    Self.Hide;
    Try

      If Not VS_FuncoesExternas.fIVerificaAcessoSistema('frmCadMovCartoes') Then
      Begin
        If Not VS_FuncoesExternas.fIPedirLiberacao('frmCadMovCartoes',
                                                   'Manutenção de Cartões',
                                                   'Permissão para alteração de cartão no extrato de confirmação') Then
          Exit;
      End;


      VS_FuncoesExternas.fIAlterarCartaoVenda(FQueryCartoesParaVincular.FieldByName('AUTOINCREM').AsString);
      AtualizaStatusLancamento;
      ExecutarConsultaCartao;
      AtualizarTotalizadorPorStatus;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ChamaManutencaoCartaoParaAlteracao]');
      End;
    End;
  Finally
    Self.Show;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.ChamaManutencaoCartaoParaInclusao;
begin
  Try
    Self.Hide;

    Try

      If Not VS_FuncoesExternas.fIVerificaAcessoSistema('frmCadMovCartoes') Then
      Begin
        If Not VS_FuncoesExternas.fIPedirLiberacao('frmCadMovCartoes',
                                                   'Manutenção de Cartões',
                                                   'Permissão para inclusão de cartão do extrato de confirmação') Then
          Exit;
      End;

      VS_FuncoesExternas.fIIncluirCartaoVenda(FQueryExtrato.FieldByName('AUTOINCREM').AsString);
      AtualizaStatusLancamento;
      ExecutarConsultaCartao;
      AtualizarTotalizadorPorStatus;
    Finally
      Self.Show;
    End;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ChamaManutencaoCartaoParaInclusao]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.CriarObjetosDeConsulta;
begin
  Try
    FQueryExtratoPendentes := VS_FuncoesExternas.fICriaQuery;
    FQueryExtratoPendentes.CachedUpdates := True;
    FQueryExtratoPendentes.Options.SetFieldsReadOnly := False;
    FDataSourceExtratoPendentes := TDataSource.Create(Nil);
    FDataSourceExtratoPendentes.DataSet := FQueryExtratoPendentes;
    grdPendOperadora.DataController.DataSource := FDataSourceExtratoPendentes;

    FQueryExtrato := VS_FuncoesExternas.fICriaQuery;
    FQueryExtrato.CachedUpdates := True;
    FQueryExtrato.Options.SetFieldsReadOnly := False;
    FDataSourceExtrato := TDataSource.Create(Nil);
    FDataSourceExtrato.DataSet := FQueryExtrato;
    grdExtratoVendasDBTableView.DataController.DataSource := FDataSourceExtrato;
    FDataSourceExtrato.OnDataChange := dsExtratoDataChange;

    FQueryResumoBandeiras := VS_FuncoesExternas.fICriaQuery;
    FQueryResumoBandeiras.CachedUpdates := True;
    FQueryResumoBandeiras.Options.SetFieldsReadOnly := False;
    FDataSourceResumoBandeiras := TDataSource.Create(Nil);
    FDataSourceResumoBandeiras.DataSet := FQueryResumoBandeiras;
    cxGridDBTableViewResumoBandeira.DataController.DataSource := FDataSourceResumoBandeiras;

    FQueryTotalizadorStatus := VS_FuncoesExternas.fICriaQuery;
    FQueryTotalizadorStatus.CachedUpdates := True;
    FQueryTotalizadorStatus.Options.SetFieldsReadOnly := False;
    FDataSourceTotalizadorStatus := TDataSource.Create(Nil);
    FDataSourceTotalizadorStatus.DataSet := FQueryTotalizadorStatus;
    grdTotaisDBBandedTableViewCitelTotalizadorStatus.DataController.DataSource := FDataSourceTotalizadorStatus;

    FQueryCartoesParaVincular := VS_FuncoesExternas.fICriaQuery;
    FQueryCartoesParaVincular.CachedUpdates := True;
    FQueryCartoesParaVincular.Options.SetFieldsReadOnly := False;
    FDataSourceCartoesParaVincular := TDataSource.Create(Nil);
    FDataSourceCartoesParaVincular.DataSet := FQueryCartoesParaVincular;
    cxGridDBTableViewMOVCAR.DataController.DataSource := FDataSourceCartoesParaVincular;

    FQueryCartoesConfirmados := VS_FuncoesExternas.fICriaQuery;
    FQueryCartoesConfirmados.CachedUpdates := True;
    FQueryCartoesConfirmados.Options.SetFieldsReadOnly := False;
    FDataSourceCartoesConfirmados := TDataSource.Create(Nil);
    FDataSourceCartoesConfirmados.DataSet := FQueryCartoesConfirmados;
    cxGridDBTableViewMOVCAR_Confirmado.DataController.DataSource := FDataSourceCartoesConfirmados;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CriarObjetosDeConsulta]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.btnIncluirLancamentoClick(Sender: TObject);
begin
  inherited;
  If FQueryExtrato.IsEmpty Then
  Begin
    TLibCartoesFuncoes.fMensagem('Aviso', 'É necessário carregar um extrato!', ['&O k']);
    Exit;
  End;

  If FQueryExtrato.FieldByName('EXT_STATUS').AsString.Equals('C') Then
  Begin
    TLibCartoesFuncoes.fMensagem('Aviso', 'Lançamento já confirmado!', ['&O k']);
    Exit;
  End;

  If FQueryExtrato.FieldByName('EXT_STATUS').AsString.Equals('I') Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Lançamentos ignorado!', ['&O k']);
    Exit;
  End;

  TLibCartoesFuncoes.AguardeExecutarModalA(ChamaManutencaoCartaoParaInclusao,'Aguarde, Atualizando registros...', '');
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.cxBtnSairClick(Sender: TObject);
begin
  inherited;
  btnSair.Click;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.cxGridDBTableViewMOVCARCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := COR_ZEBRA;
  End;

  If AViewInfo.GridRecord.Focused Then
  Begin
    ACanvas.Brush.Color := clNavy;
    ACanvas.Font.Color  := clWhite;
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.cxGridDBTableViewMOVCAR_ConfirmadoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := COR_ZEBRA;
  End;

  If AViewInfo.GridRecord.Focused Then
  Begin
   ACanvas.Brush.Color := clNavy;
   ACanvas.Font.Color  := clWhite;
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.cxGridDBTableViewResumoBandeiraCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := COR_ZEBRA;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.DesvincularLancamentoManualmente;
begin
  Try
    If FQueryCartoesConfirmados.IsEmpty Then
    Begin
      TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Carregue um registro para desvincular!', ['&O k']);
      Exit;
    End;

    FConfirmaCartoes.Extrato := FQueryExtrato;
    FConfirmaCartoes.DesvincularLancamentoExtrato;
    ExecutarConsultaCartao;
    FQueryExtrato.Refresh;
    AtualizarTotalizadorPorStatus;
  Except
    On E:Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.DesvincularLancamentoManualmente]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.dsExtratoDataChange(Sender: TObject;
  Field: TField);
begin
  ExecutarConsultaCartao;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.dxVertContainerDockSite1CanResize(
  Sender: TdxCustomDockControl; NewWidth, NewHeight: Integer;
  var Resize: Boolean);
begin
  inherited;
  OnResizeGrupoPontoVendas(NewWidth);
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.mnuSalvarLayoutClick(Sender: TObject);
begin
  inherited;
  SalvaLayoutPaineis(True);
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.mnuExportarLayoutClick(Sender: TObject);
begin
  inherited;
  ExportarLayoutPaineis;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.mnuImportarLayoutClick(Sender: TObject);
begin
  inherited;
  ImportarLayoutPaineis;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.ExecutarConsultaCartao;
begin
  tmrCarregaCartaoParaVincular.Enabled := False;
  tmrCarregaCartaoParaVincular.Enabled := True;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.ExecutarTeclasAtalho(Key: Word);
begin
  If (Key = VK_F7)          Then btnAlterarCartao.Click
  Else If (Key = VK_F6)     Then btnIncluirLancamento.Click
  Else If (Key = VK_F11)    Then btnIgnorarLancamento.Click
  Else If (Key = VK_F12)    Then btnRecomporLancamento.Click
  Else If (Key = VK_F9)     Then btnConciliacao.Click
  Else If (Key = VK_Escape) Then btnSair.Click;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.ExportarLayoutPaineis;
  Var
    LDadosDockingManager : TDadosDockingManager;
begin
  Try
    LDadosDockingManager.DockingManager := dxDockingManager;
    LDadosDockingManager.NomeFormulario := Self.Name;

    If untTDockingManager.ExportarLayout(LDadosDockingManager) Then
      TLibCartoesFuncoes.fMensagem('Aviso', 'Configuração do layout dos painéis exportada com sucessos!', ['O k']);

  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ExportarLayoutPaineis]');
    End;
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  SalvaLayoutPaineis(False);
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.FormCreate(Sender: TObject);
begin
  inherited;
  CriarObjetosDeConsulta;
  FConfirmaCartoes := TConfirmaCartoes.Create;
  FExecuteFormShow := True;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQueryExtratoPendentes);
  FreeAndNil(FDataSourceExtratoPendentes);

  FreeAndNil(FQueryResumoBandeiras);
  FreeAndNil(FDataSourceResumoBandeiras);

  FreeAndNil(FQueryExtrato);
  FreeAndNil(FDataSourceExtrato);

  FreeAndNil(FQueryCartoesParaVincular);
  FreeAndNil(FDataSourceCartoesParaVincular);

  FreeAndNil(FQueryCartoesConfirmados);
  FreeAndNil(FDataSourceCartoesConfirmados);

  If LibCartoesHandle > 0 Then
  Begin
    LibCartoesHandle := 0;
    FreeLibrary(LibCartoesHandle);
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ExecutarTeclasAtalho(Key);
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.FormShow(Sender: TObject);
begin
  inherited;

  If Not FExecuteFormShow Then
    Exit;

  CarregaLibCartoes;

  CarregaLayoutPaineis;
  CarregaExtratosComVendasPendentes;

  FExecuteFormShow := False;
end;

function TfrmLibCartoesConfirmacaoDeCartoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = mskDtaFinPen) Then
    Result := ValidaDataFinalLacamentosPendentes
   Else If (Sender = mskDtaIniPen) Then
    Result := ValidaDataInicialLancamentosPendentes
  Else If (Sender = dtaIniExt) Then
    Result := ValidaDataInicialExtratoVendas
  Else If (Sender = dtaFinExt) Then
    Result := ValidaDataFinalExtratoVendas;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.grdExtratoVendasDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    LValor : String;
begin
  inherited;

  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := COR_ZEBRA;
  End;


  If AViewInfo.GridRecord.Focused Then
  Begin
   ACanvas.Brush.Color := clNavy;
   ACanvas.Font.Color  := clWhite;
  End;

  LValor := VarAsType(grdExtratoVendasDBTableView.
                                         ViewData.
                                         Records[AViewInfo.GridRecord.Index].
                                         Values[grdExtratoVendasDBTableViewEXT_STATUS.Index], varString);

  If (LValor = 'I')  Then
  Begin
    ACanvas.Font.Color   := clMedGray;
    ACanvas.Font.Style   := [fsStrikeOut, fsBold];
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.grdPendOperadoraDblClick(Sender: TObject);
begin
  inherited;
  TLibCartoesFuncoes.AguardeExecutarModalA(SelecionarLancamentosPendentes,'Aguarde, Selecionando lançamento(s)...', '');
  LimparCampos;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.grdPendOperadoraStylesGetContentStyle(
  Sender: TObject; AEditProp: TcxCustomEditorRowProperties; AFocused: Boolean;
  ARecordIndex: Integer; var AStyle: TcxStyle);
begin
  inherited;

  If FQueryExtratoPendentes.IsEmpty Then
    Exit;

  AStyle := cxStyle8;

  If grdPendOperadora.DataController.Values[ARecordIndex, grdPendOperadoraMarcado.Index] = 'S' Then
    AStyle := cxStyle11
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.grdTotaisDBBandedTableViewCitelTotalizadorStatusCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.GridRecord.Selected Then
  Begin
     ACanvas.Brush.Color := clWhite;
     ACanvas.Font.Color  := clNavy;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.IgnorarLancamentoManualmente;
begin
  Try
    FConfirmaCartoes.Extrato := FQueryExtrato;
    FConfirmaCartoes.IgnorarLancamento;
    FQueryExtrato.Refresh;
    ExecutarConsultaCartao;
    CarregaExtratosComVendasPendentes;
    AtualizarTotalizadorPorStatus;
  Except
    On E:Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.IgnorarLancamentoManualmente]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.ImportarVendas(Sender: TObject);
Var
  LMenuImportaVendas: TMenuImportaVendas;
  LConciliadora: String;
begin
  inherited;
  {A Hint do MenuItem deve ser preenchida com o nome da conciliadora,
   seguindo o padrão da untMovCar.fSetConcil}
  LConciliadora := Trim(TMenuItem(Sender).Hint);
  if LConciliadora.IsEmpty then
  begin
    VS_FuncoesExternas.pIMensagensErro('O nome da conciliadora deve ser informado ' +
                                       'na propriedade Hint do MenuItem no AdvPopupMenuImpVendas',
                                       '[TfrmConfirmacaoDeCartoes.ImportarVendas]');
    Exit;
  end;

  If Not PermitirImportarExtrato(LConciliadora) Then
    Exit;

  Try
    try
      Self.Hide;
      LMenuImportaVendas := TMenuImportaVendas.Create;
      LMenuImportaVendas.Conciliadora := LConciliadora;
      LMenuImportaVendas.ImportarVendasCartao;

      If LMenuImportaVendas.PeriodoImportacao.ImportouVendas Then
      Begin
        FConfirmaCartoes.Conciliadora := LConciliadora;

        dtaIniExt.Date := LMenuImportaVendas.PeriodoImportacao.DataInicial;
        dtaFinExt.Date := LMenuImportaVendas.PeriodoImportacao.DataFinal;
        CarregaExtratosComVendasPendentes;

        FConfirmaCartoes.fLancamentosSelecionados.Estabelecimento := '';

        If FQueryExtratoPendentes.Locate('NOMCON', FConfirmaCartoes.Conciliadora,[]) Then
          MarcaOperadoraSelecionada;

        CarregaVendasParaConfimarPorPeriodo;
      End;
    Finally
      FreeAndNil(LMenuImportaVendas);
      Self.Show;
    End;

  except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ImportarVendas]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.ImportarLayoutPaineis;
  Var
    LDadosDockingManager : TDadosDockingManager;
    LResult: Boolean;
begin
  Try
    LDadosDockingManager.DockingManager := dxDockingManager;

    LResult := untTDockingManager.ImportarLayout(LDadosDockingManager);
    dxVertContainerDockSite1.OnCanResize := dxVertContainerDockSite1CanResize;
    OnResizeGrupoPontoVendas(dxVertContainerDockSite1.Width);

    If LResult Then
      TLibCartoesFuncoes.fMensagem('Aviso', 'Configuração do layout dos painéis importada com sucessos!', ['O k']);
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ImportarLayoutPaineis]');
    End;
  End;
end;

function TfrmLibCartoesConfirmacaoDeCartoes.ImprimirExtrato(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LRecNo : Integer;

    LDatasetRelatorio: TUniClientDataset;
begin
  LRecNo := 0;
  Result := True;

  Try
    If FQueryExtrato.IsEmpty Then
    Begin
      TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Sem lançamentos para impressão!', ['&O k']);
      Exit;
    End;

    Try
      LRecNo := FQueryExtrato.RecNo;
      FQueryExtrato.DisableControls;

      FQueryExtrato.Filtered := False;
      FQueryExtrato.Filter   := grdExtratoVendasDBTableView.DataController.Filter.FilterText;
      FQueryExtrato.Filtered := True;

      LDatasetRelatorio := TLibCartoesFuncoes.CriarClientDataSet(FQueryExtrato, True);
      LDatasetRelatorio.Open;
      LDatasetRelatorio.EmptyDataSet;

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := FQueryExtrato.RecordCount;

      FQueryExtrato.First;
      While Not FQueryExtrato.Eof Do
      Begin
        LDatasetRelatorio.Insert;
        LDatasetRelatorio.FieldByName('EXT_NUM_PV').AsString := FQueryExtrato.FieldByName('EXT_NUM_PV').AsString;
        LDatasetRelatorio.FieldByName('EXT_CODAUT').AsString := FQueryExtrato.FieldByName('EXT_CODAUT').AsString;
        LDatasetRelatorio.FieldByName('EXT_NUMNSU').AsString := FQueryExtrato.FieldByName('EXT_NUMNSU').AsString;
        LDatasetRelatorio.FieldByName('EXT_PARCEL').AsString := FQueryExtrato.FieldByName('EXT_PARCEL').AsString;
        LDatasetRelatorio.FieldByName('EXT_NOMCON').AsString := FQueryExtrato.FieldByName('EXT_NOMCON').AsString;
        LDatasetRelatorio.FieldByName('EXT_STATUS').AsString := FQueryExtrato.FieldByName('EXT_STATUS').AsString;

        LDatasetRelatorio.FieldByName('EXT_DTACUP').AsDateTime := FQueryExtrato.FieldByName('EXT_DTACUP').AsDateTime;
        LDatasetRelatorio.FieldByName('EXT_DTAVEN').AsDateTime := FQueryExtrato.FieldByName('EXT_DTAVEN').AsDateTime;

        LDatasetRelatorio.FieldByName('EXT_VALBRU').AsFloat := FQueryExtrato.FieldByName('EXT_VALBRU').AsFloat;
        LDatasetRelatorio.FieldByName('EXT_VALTAX').AsFloat := FQueryExtrato.FieldByName('EXT_VALTAX').AsFloat;
        LDatasetRelatorio.FieldByName('EXT_VALLIQ').AsFloat := FQueryExtrato.FieldByName('EXT_VALLIQ').AsFloat;
        LDatasetRelatorio.Post;

        FQueryExtrato.Next;
        TLibCartoesFuncoes.pStepStatusGravacao(pgbProgresso);
      End;

      Try
        If Not FileExists(PChar(IMP_EXT_DLL)) Then
        Begin
          TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'O arquivo ' + IMP_EXT_DLL.Replace('..\', EmptyStr) + ' não está na pasta do Autcom.' + #13 +
                                                   'Entre em contato com a Citel.', ['&Ok']);

          Exit;
        End;

        pExtratoConfirmacaoCartao(VS_FuncoesExternas.fIRetEmpresaLogada +'-'+ TLibCartoesFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada),
                                  COR_ZEBRA,
                                  LDatasetRelatorio);
      Except
        TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Opção de ajuda não está disponível.', ['&Ok']);
      End;

     { TfrxMemoView(frxExtratoCartoes.FindObject('rllZebra')).Highlight.Color := COR_ZEBRA;
      frxExtratoCartoes.DotMatrixReport             := False;
      frxExtratoCartoes.PrintOptions.PrintMode      := pmScale;
      frxExtratoCartoes.PrintOptions.PrintOnSheet   := 9;
      frxExtratoCartoes.Script.Variables['NOMEMP']  := VS_FuncoesExternas.fIRetEmpresaLogada +'-'+ TLibCartoesFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada);}

//      VS_FuncoesExternas.pIExibirRelatorio('procedure TfrmConfirmacaoDeCartoes.ImprimirExtrato',
  //                                         'Extrato de Cartões Para Confirmação',
    //                                        frxExtratoCartoes As IReport);
    Finally
      FQueryExtrato.Filtered := False;
      FQueryExtrato.Filter   := '';
      FQueryExtrato.RecNo    := LRecNo;
      FQueryExtrato.EnableControls;

      FreeAndNil(LDatasetRelatorio);
    End;


  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ImprimirExtrato]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.LimparCampos;
begin
  dtaIniExt.Clear;
  dtaFinExt.Clear;
  mskDtaIniPen.Clear;
  mskDtaFinPen.Clear;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.MarcaOperadoraSelecionada;
  Var
    LRecNo : Integer;
begin
  Try
    LRecNo := FQueryExtratoPendentes.RecNo;

    If FQueryExtratoPendentes.Locate('MARCADO', 'S',[]) Then
    Begin
      FQueryExtratoPendentes.Edit;
      FQueryExtratoPendentes.FieldByName('MARCADO').AsString := 'N';
      FQueryExtratoPendentes.Post;
    End;

    FQueryExtratoPendentes.RecNo := LRecNo;
    FQueryExtratoPendentes.Edit;
    FQueryExtratoPendentes.FieldByName('MARCADO').AsString := 'S';
    FQueryExtratoPendentes.Post;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.MarcaOperadoraSelecionada]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.mnuRedeCardOnlineClick(Sender: TObject);
  Var
    FMenuImportaVendas: TMenuImportaVendas;
begin
  inherited;

  If Not PermitirImportarExtrato('REDECARD') Then
    Exit;

 Try

    Try
      Self.Hide;
      FMenuImportaVendas := TMenuImportaVendas.Create;
      FMenuImportaVendas.ImportarVendasRedeCardOnline;

      If FMenuImportaVendas.PeriodoImportacao.ImportouVendas Then
      Begin
        FConfirmaCartoes.Conciliadora := 'REDECARD';
        dtaIniExt.Date := FMenuImportaVendas.PeriodoImportacao.DataInicial;
        dtaFinExt.Date := FMenuImportaVendas.PeriodoImportacao.DataFinal;
        CarregaExtratosComVendasPendentes;

        FConfirmaCartoes.fLancamentosSelecionados.Estabelecimento := '';

        If FQueryExtratoPendentes.Locate('NOMCON', FConfirmaCartoes.Conciliadora,[]) Then
          MarcaOperadoraSelecionada;

        CarregaVendasParaConfimarPorPeriodo;
      End;


    Finally
      FreeAndNil(FMenuImportaVendas);
      Self.Show;
    End;

  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.mnuRedeCardOnlineClick]');
    End;
  End;


end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.OnResizeGrupoPontoVendas(ANewWidth: Integer);
begin
  gpbPontoVendas.Width := ANewWidth;
  btnAtualizarPendentes.Left := (gpbLanPendentes.Width - 10);
  AjustaLarguraColunaBanderia;
end;

function TfrmLibCartoesConfirmacaoDeCartoes.PermitirIgnorarCartaoes(
  AOperadora: String): Boolean;
begin
  Result := True;

  If Not VS_FuncoesExternas.fIVerificaAcessoSistema('IGNORARCARTOESCONFIRMACAO') Then
  Begin
    Try
      Self.Hide;
      Result := VS_FuncoesExternas.fIPedirLiberacao('IGNORARCARTOESCONFIRMACAO',
                                                    'Ignorar cartão do extrato de confirmação',
                                                    'Permissão para ignorar cartão do extrato de confirmação - ' + AOperadora);
    Finally
      Self.Show;
    End;
  End;
end;

function TfrmLibCartoesConfirmacaoDeCartoes.PermitirImportarExtrato(
  AOperadora: String): Boolean;
begin

  Result := True;

  If Not VS_FuncoesExternas.fIVerificaAcessoSistema('IMPORTAREXTRATOCARTOES') Then
  Begin
    Try
      Self.Hide;
      Result := VS_FuncoesExternas.fIPedirLiberacao('IMPORTAREXTRATOCARTOES',
                                                    'Importar extrato de confirmação de cartões',
                                                    'Permissão para importar extrato de confirmação de cartões - ' + AOperadora);
    Finally
      Self.Show;
    End;
  End;
end;

function TfrmLibCartoesConfirmacaoDeCartoes.PermitirRecomporCartaoesIgnorados(
  AOperadora: String): Boolean;
begin
  Result := True;

  If Not VS_FuncoesExternas.fIVerificaAcessoSistema('IGNORARCARTOESCONFIRMACAO') Then
  Begin
    Try
      Self.Hide;
      Result := VS_FuncoesExternas.fIPedirLiberacao('IGNORARCARTOESCONFIRMACAO',
                                                    'Recompor cartão ignorado do extrato de confirmação',
                                                    'Permissão para recompor cartão ignorado do extrato de confirmação - ' + AOperadora);
    Finally
      Self.Show;
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.mnuRedefinirLayoutClick(Sender: TObject);
begin
  inherited;
  RedefinirLayoutPaineis;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.RecomporLancamentoManualmente;
begin
  Try
    FConfirmaCartoes.Extrato := FQueryExtrato;
    FConfirmaCartoes.RecomporLancamento;
    FQueryExtrato.Refresh;
    ExecutarConsultaCartao;
    CarregaExtratosComVendasPendentes;
    AtualizarTotalizadorPorStatus;
  Except
    On E:Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.RecomporLancamentoManualmente]');
    End;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.RedefinirLayoutPaineis;
  Var
    LDadosDockingManager : TDadosDockingManager;
    LResult: Boolean;
begin

  Try
    If TLibCartoesFuncoes.fMensagem('Aviso', 'As configurações de layout atuais '+
                                             'serão perdidas! Deseja continuar?', ['Sim', 'Não']) = 2 Then
    Exit;

    LDadosDockingManager.DockingManager := dxDockingManager;
    LDadosDockingManager.NomeFormulario := Self.Name + '_Padrao';
    LDadosDockingManager.Operador       := 'AUT';

    LResult := untTDockingManager.RedefinirLayout(LDadosDockingManager);
    dxVertContainerDockSite1.OnCanResize := dxVertContainerDockSite1CanResize;
    OnResizeGrupoPontoVendas(dxVertContainerDockSite1.Width);

    If LResult Then
      TLibCartoesFuncoes.fMensagem('Aviso', 'Configuração do layout dos painéis redefinidas com sucessos!', ['O k']);

  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.RedefinirLayoutPaineis]');
    End;
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.SalvaLayoutPaineis(AExibirMensagem: Boolean);
  Var
    LDadosDockingManager : TDadosDockingManager;
begin
  Try
    LDadosDockingManager.DockingManager := dxDockingManager;
    LDadosDockingManager.NomeFormulario := Self.Name;
    LDadosDockingManager.Operador       := VS_FuncoesExternas.fIRetOperadorLogado;
    LDadosDockingManager.Empresa        := VS_FuncoesExternas.fIRetEmpresaLogada;

    If untTDockingManager.SalvarLayout(LDadosDockingManager) And AExibirMensagem Then
      TLibCartoesFuncoes.fMensagem('Aviso', 'Configuração do layout dos painéis salva com sucessos!', ['O k']);

  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.SalvaLayoutPaineis]');
    End;
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.SelecionarLancamentosPendentes;
  Var
    LLancPendentesConfirmacao: TfrmLibCartoesLancPendentesConfirmacao;
    LNomeConciliadora:         String;
begin

  If FQueryExtratoPendentes.IsEmpty Then
    Exit;

  Try
    Self.Hide;
    LNomeConciliadora := FQueryExtratoPendentes.FieldByName('NOMCON').AsString;
    TLibCartoesFuncoes.pCriarFormularios(TfrmLibCartoesLancPendentesConfirmacao, LLancPendentesConfirmacao);
    LLancPendentesConfirmacao.Conciliadora := LNomeConciliadora;
    LLancPendentesConfirmacao.ShowModal;

    If  Not LLancPendentesConfirmacao.Confirma Then
      Exit;

    FConfirmaCartoes.Conciliadora := LLancPendentesConfirmacao.Conciliadora;
    FConfirmaCartoes.FLancamentosSelecionados  := LLancPendentesConfirmacao.LancamentosSelecionados;

    MarcaOperadoraSelecionada;
    TLibCartoesFuncoes.AguardeExecutarModalA(AtualizarRegistros,'Aguarde, Atualizando Registros...', '');

  Finally
    If Assigned(LLancPendentesConfirmacao) Then
      FreeAndNil(LLancPendentesConfirmacao);

    Self.Show;
  End;
end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.tmrCarregaCartaoParaVincularTimer(
  Sender: TObject);
begin
  inherited;

  If FQueryExtratoPendentes.IsEmpty Then
    CarregaExtratosComVendasPendentes;

  tmrCarregaCartaoParaVincular.Enabled := False;

  CarregaCartaoParaVincular;
end;

function TfrmLibCartoesConfirmacaoDeCartoes.ValidaDataFinalExtratoVendas: Boolean;
begin
  Result := True;

  If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(dtaFinExt.Text))) And (StrToDateDef(dtaFinExt.Text, 0) <= 0) Then
  Begin
    TLibCartoesFuncoes.fMensagem('', 'A Data Final do lançamento informada é inválida! Necessário correção.', ['&O k']);
    Result := False;
  End
  Else
  If TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(dtaFinExt.Text)) And (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(dtaIniExt.Text))) Then
  Begin
    TLibCartoesFuncoes.fMensagem('', 'O campo Data Final do lançamento deve ser preenchido!', ['&Ok']);
    Result := False;
  End
  Else
  Begin
    If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(dtaFinExt.Text))) And TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(dtaIniExt.Text)) Then
    Begin
      TLibCartoesFuncoes.fMensagem('', 'O campo Data Inicial do lançamento deve ser preenchido!', ['&Ok']);
      Result := False;
      pSetFocus(dtaIniExt);
    End
    Else
    Begin
      If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(dtaFinExt.Text))) And (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(dtaIniExt.Text))) Then
      Begin
        If StrToDate(dtaIniExt.Text) > StrToDate(dtaFinExt.Text) Then
        Begin
          TLibCartoesFuncoes.fMensagem('','A Data Inicial do lançamento deve ser menor que a data final do lançamento!',['&O K']);
          Result := False;
          pSetFocus(dtaIniExt);
        End;
      End;
    End;
  End;

end;

function TfrmLibCartoesConfirmacaoDeCartoes.ValidaDataFinalLacamentosPendentes: Boolean;
begin
  Result := True;

  If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaFinPen.Text))) And (StrToDateDef(mskDtaFinPen.Text, 0) <= 0) Then
  Begin
    TLibCartoesFuncoes.fMensagem('', 'A Data Final do lançamento informada é inválida! Necessário correção.', ['&O k']);
    Result := False;
  End
  Else
  If TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaFinPen.Text)) And (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaIniPen.Text))) Then
  Begin
    TLibCartoesFuncoes.fMensagem('', 'O campo Data Final do lançamento deve ser preenchido!', ['&Ok']);
    Result := False;
  End
  Else
  Begin
    If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaFinPen.Text))) And TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaIniPen.Text)) Then
    Begin
      TLibCartoesFuncoes.fMensagem('', 'O campo Data Inicial do lançamento deve ser preenchido!', ['&Ok']);
      Result := False;
      TLibCartoesFuncoes.pSetFocus(mskDtaIniPen);
    End
    Else
    Begin
      If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaFinPen.Text))) And (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaIniPen.Text))) Then
      Begin
        If StrToDate(mskDtaIniPen.Text) > StrToDate(mskDtaFinPen.Text) Then
        Begin
          TLibCartoesFuncoes.fMensagem('','A Data Inicial do lançamento deve ser menor que a data final do lançamento!',['&O K']);
          Result := False;
          TLibCartoesFuncoes.pSetFocus(mskDtaIniPen);
        End;
      End;
    End;
  End;

end;

function TfrmLibCartoesConfirmacaoDeCartoes.ValidaDataInicialExtratoVendas: Boolean;
begin
  Result := True;

  If TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(dtaIniExt.Text)) Then
  Begin
    TLibCartoesFuncoes.fMensagem('', 'A Data Inicial do lançamento deve ser informada.', ['&O k']);
    Result := False;
    TLibCartoesFuncoes.pSetFocus(dtaIniExt);
  End
  Else If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(dtaIniExt.Text))) and (StrToDateDef(dtaIniExt.Text, 0) <= 0) Then
  Begin
    TLibCartoesFuncoes.fMensagem('', 'A Data Inicial do lançamento informada é inválida! Necessário correção.', ['&O k']);
    Result := False;
    TLibCartoesFuncoes.pSetFocus(dtaIniExt);
  End;
end;

function TfrmLibCartoesConfirmacaoDeCartoes.ValidaDataInicialLancamentosPendentes: Boolean;
begin
  Result := True;

  If TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaIniPen.Text)) Then
  Begin
    TLibCartoesFuncoes.fMensagem('', 'A Data Inicial do lançamento deve ser informada.', ['&O k']);
    Result := False;
    TLibCartoesFuncoes.pSetFocus(mskDtaIniPen);
  End
  Else If (Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFuncoes.fTiraCaracEspeciais(mskDtaIniPen.Text))) and (StrToDateDef(mskDtaIniPen.Text, 0) <= 0) Then
  Begin
    TLibCartoesFuncoes.fMensagem('', 'A Data Inicial do lançamento informada é inválida! Necessário correção.', ['&O k']);
    Result := False;
    TLibCartoesFuncoes.pSetFocus(mskDtaIniPen);
  End;

end;

procedure TfrmLibCartoesConfirmacaoDeCartoes.VincularLancamentoManualmente;
begin
  Try
    If FQueryCartoesParaVincular.IsEmpty Then
    Begin
      TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Carregue um registro para vincular!', ['&O k']);
      Exit;
    End;

    FConfirmaCartoes.Extrato := FQueryExtrato;
    FConfirmaCartoes.AutoIncremCartao := FQueryCartoesParaVincular.FieldByName('AUTOINCREM').AsString;

    If FConfirmaCartoes.RelacionarLancamentoExtrato Then
    Begin
      ExecutarConsultaCartao;
      FQueryExtrato.Refresh;
      AtualizarTotalizadorPorStatus;
    End;
  Except
    On E:Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.VincularLancamentoManualmente]');
    End;
  End;
end;

end.
