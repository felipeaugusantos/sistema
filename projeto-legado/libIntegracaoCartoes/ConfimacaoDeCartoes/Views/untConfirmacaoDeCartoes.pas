unit untConfirmacaoDeCartoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts,Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxImageComboBox,
  cxTextEdit, cxDataControllerConditionalFormattingRulesManagerDialog, cxPC,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, Data.DB, cxDBData, cxCurrencyEdit, cxButtonEdit,
  dxScreenTip, frxExportPDF, frxDBSet, System.Actions, Vcl.ActnList, AdvMenus,
  dxDockControl, dxCustomHint, cxHint, cxClasses, System.ImageList, Vcl.ImgList,
  cxImageList, cxGridBandedTableView, cxGridDBBandedTableView, Vcl.Mask,
  MaskEditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, dxGDIPlusClasses, cxCheckBox,
  cxMaskEdit, cxDropDownEdit, cxCalendar, dxDockPanel, cxVGrid, cxDBVGrid,
  cxInplaceContainer, EditFocus, cxButtons, cxGroupBox,untIDataset,Uni,
  untTConfirmaCartoes,untConstantes,untFuncoesSimples, DBAccess, MemDS,
  frxDesgn,UniClientDataSet,cxProgressBar, Datasnap.DBClient, TipoConciliadora.Classes;

type
  TfrmConfirmacaoDeCartoes = class(TfrmPai)
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
    frxExtratoCartoes: TfrxReport;
    frxDBExtratoCartoes: TfrxDBDataset;
    frxDesigner1: TfrxDesigner;
    UniClientDataSetExtrato: TUniClientDataSet;
    UniClientDataSetExtratoEXT_NUM_PV: TStringField;
    UniClientDataSetExtratoEXT_CODAUT: TStringField;
    UniClientDataSetExtratoEXT_NUMNSU: TStringField;
    UniClientDataSetExtratoEXT_PARCEL: TStringField;
    UniClientDataSetExtratoEXT_DTACUP: TDateField;
    UniClientDataSetExtratoEXT_DTAVEN: TDateField;
    UniClientDataSetExtratoEXT_VALBRU: TFloatField;
    UniClientDataSetExtratoEXT_VALTAX: TFloatField;
    UniClientDataSetExtratoEXT_VALLIQ: TFloatField;
    UniClientDataSetExtratoEXT_NOMCON: TStringField;
    UniClientDataSetExtratoEXT_STATUS: TStringField;
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

uses untFuncoes,untTMenuImportaVendas,untTDockingManager,untLancPendentesConfirmacao;

{$R *.dfm}

procedure TfrmConfirmacaoDeCartoes.AbreConciliacao;
begin

  If FConfirmaCartoes.Conciliadora.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Selecione uma operadora!', ['&O k']);
    Exit;
  End;

  Try
    Self.Hide;
    Try
      if FConfirmaCartoes.Conciliadora <> 'REDECARD' then
        untFuncoes.ChamaConciliacaoCartoes(FConfirmaCartoes.Conciliadora)
      else
      Begin
        If Not Assigned(untConstantes.MenuConciliacaoCartoes) Then
          untFuncoes.ChamaConciliacaoCartoes('RedeCardApi')
        Else
          untConstantes.MenuConciliacaoCartoes.Find('Conciliação RedeCard API').Click;
      End;

      AguardeExecutarModalA(AtualizarRegistros,'Aguarde, Atualizando Registros...', '');
    Finally
      Self.Show;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.AbreConciliacao]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.AjustaColunasGridCartoesParaVincular;
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


procedure TfrmConfirmacaoDeCartoes.AjustaColunasGridCartoesConfirmados;
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

procedure TfrmConfirmacaoDeCartoes.AjustaColunasGridExtratoVendas;
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

procedure TfrmConfirmacaoDeCartoes.AjustaColunasGridResumoBandeira;
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

procedure TfrmConfirmacaoDeCartoes.AjustaLarguraColunaBanderia;
  Var
    LLarguraTotalColunas: Integer;
begin
  LLarguraTotalColunas := (cxGridDBTableViewResumoBandeiraQUANTIDADE.Width  +
                           cxGridDBTableViewResumoBandeiraTOTAL_BRUTO.Width +
                           cxGridDBTableViewResumoBandeiraTOTAL_TAXA.Width  +
                           cxGridDBTableViewResumoBandeiraTOTAL_LIQUIDO.Width);

  cxGridDBTableViewResumoBandeiraLOGO.Width := ((cxGridPontosDeVenda.Width - LLarguraTotalColunas) - 40);
end;

procedure TfrmConfirmacaoDeCartoes.AtualizarRegistros;
begin
  CarregadaExtratoVendas;
  CarregaResumoBandeiraExtrato;
  ExecutarConsultaCartao;
  AtualizarTotalizadorPorStatus;
end;

procedure TfrmConfirmacaoDeCartoes.AtualizarTotalizadorPorStatus;
begin

  Try
    FConfirmaCartoes.ConsultaTotalizadorPorStatus(FQueryTotalizadorStatus);
    FQueryTotalizadorStatus.First;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.AtualizarTotalizadorPorStatus]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.AtualizaStatusLancamento;
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

procedure TfrmConfirmacaoDeCartoes.btnAlterarCartaoClick(Sender: TObject);
begin
  inherited;
  If FQueryCartoesParaVincular.IsEmpty Then
  Begin
    fMensagem('Aviso', 'É necessário carregar ao menos um cartão!', ['&O k']);
    Exit;
  End;

  AguardeExecutarModalA(ChamaManutencaoCartaoParaAlteracao,'Aguarde, Atualizando Registros...', '');
end;

procedure TfrmConfirmacaoDeCartoes.btnAtualizarPendentesClick(Sender: TObject);
begin
  inherited;
  CarregaExtratosComVendasPendentes;
end;

procedure TfrmConfirmacaoDeCartoes.btnCarregarClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(dtaIniExt) Then
    Exit;

  If Not fValidaCampos(dtaFinExt) Then
    Exit;

  If FConfirmaCartoes.Conciliadora.IsEmpty Then
  Begin
    fMensagem('Aviso', 'Selecione a operadora!', ['&O k']);
    Exit;
  End;

  AguardeExecutarModalA(CarregaVendasParaConfimarPorPeriodo,'Aguarde, Carregando venda(s)...', '');
end;

procedure TfrmConfirmacaoDeCartoes.btnConciliacaoClick(Sender: TObject);
begin
  inherited;
  AguardeExecutarModalA(AbreConciliacao,'Aguarde, Conciliando Lançamentos.', '');
end;

procedure TfrmConfirmacaoDeCartoes.btnDesvincularClick(Sender: TObject);
begin
  inherited;
  AguardeExecutarModalA(DesvincularLancamentoManualmente,'Aguarde, Desvinculando Lançamento.', '');
end;

procedure TfrmConfirmacaoDeCartoes.btnExpandClick(Sender: TObject);
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

procedure TfrmConfirmacaoDeCartoes.btnIgnorarLancamentoClick(Sender: TObject);
begin
  inherited;

  If FQueryExtrato.FieldByName('EXT_STATUS').AsString.Equals('C') Then
  Begin
    fMensagem('Aviso', 'Lançamentos confirmados não podem ser ignorados!', ['&O k']);
    Exit;
  End;

  If Not PermitirIgnorarCartaoes(FQueryExtrato.FieldByName('EXT_NOMCON').AsString) Then
    Exit;

  AguardeExecutarModalA(IgnorarLancamentoManualmente,'Aguarde, Ignorando Lançamento.', '');
end;

procedure TfrmConfirmacaoDeCartoes.btnImportarVendasClick(Sender: TObject);
  Var
    Pt : TPoint;
begin
  inherited;
  GetCursorPos(Pt);
  AdvPopupMenuImpVendas.Popup(Pt.X+15, Pt.Y+10);
  LimparCampos;
end;

procedure TfrmConfirmacaoDeCartoes.btnPesqPendClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(mskDtaIniPen) Then
    Exit;

  If Not fValidaCampos(mskDtaFinPen) Then
    Exit;

  If FQueryExtrato.IsEmpty Then
  Begin
    fMensagem('Aviso', 'É necessário carregar um extrato de vendas para executar esse filtro!', ['&O k']);
    Exit;
  End;

  AguardeExecutarModalA(CarregaCartoesParaVincularPorPeriodo,'Aguarde, Carregando lançamento(s)...', '');
end;

procedure TfrmConfirmacaoDeCartoes.btnPrintExtBanClick(Sender: TObject);
begin
  inherited;
  ExecutaAguarde(ImprimirExtrato,'Aguarde, Imprimindo Lançamentos...');
end;

procedure TfrmConfirmacaoDeCartoes.btnRecomporLancamentoClick(Sender: TObject);
begin
  inherited;
  If Not FQueryExtrato.FieldByName('EXT_STATUS').AsString.Equals('I') Then
  Begin
    fMensagem('Aviso', 'O lançamento deve estar ignorado para recompor!', ['&O k']);
    Exit;
  End;

  If Not PermitirRecomporCartaoesIgnorados(FQueryExtrato.FieldByName('EXT_NOMCON').AsString) Then
    Exit;

  AguardeExecutarModalA(RecomporLancamentoManualmente,'Aguarde, Recompondo Lançamento.', '');
end;

procedure TfrmConfirmacaoDeCartoes.btnVincularClick(Sender: TObject);
begin
  inherited;
  AguardeExecutarModalA(VincularLancamentoManualmente,'Aguarde, Vinculando Lançamento.', '');
end;

procedure TfrmConfirmacaoDeCartoes.CarregaCartaoParaVincular;
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaCartaoParaVincular]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.CarregaCartaoConfirmado;
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaCartaoConfirmado]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.CarregaCartoesParaVincularPorPeriodo;
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaCartoesParaVincularPorPeriodo]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.CarregadaExtratoVendas;
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregadaExtratoVendas]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.CarregaExtratosComVendasPendentes;
begin

  Try
    FQueryExtratoPendentes.DisableControls;
    FConfirmaCartoes.ConsultaExtratosComVendasPendentes(FQueryExtratoPendentes);
    FQueryExtratoPendentes.First;
    FQueryExtratoPendentes.EnableControls;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaExtratosComVendasPendentes]');
    End;
  End;

end;

procedure TfrmConfirmacaoDeCartoes.CarregaLayoutPaineis;
  Var
    LDadosDockingManager : TDadosDockingManager;
begin
  Try
    LDadosDockingManager.DockingManager := dxDockingManager;
    LDadosDockingManager.NomeFormulario := Self.Name;
    LDadosDockingManager.Operador       := strLoginUsuarioLogado;
    LDadosDockingManager.Empresa        := VS_strCodEmp;

    untTDockingManager.CarregarLayout(LDadosDockingManager);
    dxVertContainerDockSite1.OnCanResize := dxVertContainerDockSite1CanResize;
    OnResizeGrupoPontoVendas(dxVertContainerDockSite1.Width);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaLayoutPaineis]');
    End;
  End;

end;

procedure TfrmConfirmacaoDeCartoes.CarregaLibCartoes;
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

  untConstantes.MenuImportacaoCartoes := TMenuItem.Create(Application);
  untConstantes.MenuImportacaoCartoes := RetornaItensMenuImportacaoCartoes;

  untConstantes.MenuConciliacaoCartoes := TMenuItem.Create(Application);
  untConstantes.MenuConciliacaoCartoes := RetornaItensMenuConciliacaoCartoes;
end;

procedure TfrmConfirmacaoDeCartoes.CarregaResumoBandeiraExtrato;
begin

  Try
    FConfirmaCartoes.ConsultaResumoBandeiraExtrato(FQueryResumoBandeiras);
    AjustaColunasGridResumoBandeira;
    FQueryResumoBandeiras.First;
    cxGridDBTableViewResumoBandeira.ViewData.Expand(True);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaResumoBandeiraExtrato]');
    End;
  End;

end;

procedure TfrmConfirmacaoDeCartoes.CarregaVendasParaConfimarPorPeriodo;
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CarregaVendasParaConfimarPorPeriodo]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.ChamaManutencaoCartaoParaAlteracao;
begin
  Try
    Self.Hide;
    Try

      If Not fVerificaAcessoSistema('frmCadMovCartoes') Then
      Begin
        If Not PedirLiberacao('frmCadMovCartoes',
                              'Manutenção de Cartões',
                              'Permissão para alteração de cartão no extrato de confirmação') Then
          Exit;
      End;


      untFuncoes.AlterarCartaoVenda(FQueryCartoesParaVincular.FieldByName('AUTOINCREM').AsString);
      AtualizaStatusLancamento;
      ExecutarConsultaCartao;
      AtualizarTotalizadorPorStatus;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ChamaManutencaoCartaoParaAlteracao]');
      End;
    End;
  Finally
    Self.Show;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.ChamaManutencaoCartaoParaInclusao;
begin
  Try
    Self.Hide;

    Try

      If Not fVerificaAcessoSistema('frmCadMovCartoes') Then
      Begin
        If Not PedirLiberacao('frmCadMovCartoes',
                              'Manutenção de Cartões',
                              'Permissão para inclusão de cartão do extrato de confirmação') Then
          Exit;
      End;

      untFuncoes.IncluirCartaoVenda(FQueryExtrato.FieldByName('AUTOINCREM').AsString);
      AtualizaStatusLancamento;
      ExecutarConsultaCartao;
      AtualizarTotalizadorPorStatus;
    Finally
      Self.Show;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ChamaManutencaoCartaoParaInclusao]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.CriarObjetosDeConsulta;
begin
  Try
    FQueryExtratoPendentes := untFuncoes.CriarQueryDLL;
    FQueryExtratoPendentes.CachedUpdates := True;
    FQueryExtratoPendentes.Options.SetFieldsReadOnly := False;
    FDataSourceExtratoPendentes := TDataSource.Create(Nil);
    FDataSourceExtratoPendentes.DataSet := FQueryExtratoPendentes;
    grdPendOperadora.DataController.DataSource := FDataSourceExtratoPendentes;

    FQueryExtrato := untFuncoes.CriarQueryDLL;
    FQueryExtrato.CachedUpdates := True;
    FQueryExtrato.Options.SetFieldsReadOnly := False;
    FDataSourceExtrato := TDataSource.Create(Nil);
    FDataSourceExtrato.DataSet := FQueryExtrato;
    grdExtratoVendasDBTableView.DataController.DataSource := FDataSourceExtrato;
    FDataSourceExtrato.OnDataChange := dsExtratoDataChange;

    FQueryResumoBandeiras := untFuncoes.CriarQueryDLL;
    FQueryResumoBandeiras.CachedUpdates := True;
    FQueryResumoBandeiras.Options.SetFieldsReadOnly := False;
    FDataSourceResumoBandeiras := TDataSource.Create(Nil);
    FDataSourceResumoBandeiras.DataSet := FQueryResumoBandeiras;
    cxGridDBTableViewResumoBandeira.DataController.DataSource := FDataSourceResumoBandeiras;

    FQueryTotalizadorStatus := untFuncoes.CriarQueryDLL;
    FQueryTotalizadorStatus.CachedUpdates := True;
    FQueryTotalizadorStatus.Options.SetFieldsReadOnly := False;
    FDataSourceTotalizadorStatus := TDataSource.Create(Nil);
    FDataSourceTotalizadorStatus.DataSet := FQueryTotalizadorStatus;
    grdTotaisDBBandedTableViewCitelTotalizadorStatus.DataController.DataSource := FDataSourceTotalizadorStatus;

    FQueryCartoesParaVincular := untFuncoes.CriarQueryDLL;
    FQueryCartoesParaVincular.CachedUpdates := True;
    FQueryCartoesParaVincular.Options.SetFieldsReadOnly := False;
    FDataSourceCartoesParaVincular := TDataSource.Create(Nil);
    FDataSourceCartoesParaVincular.DataSet := FQueryCartoesParaVincular;
    cxGridDBTableViewMOVCAR.DataController.DataSource := FDataSourceCartoesParaVincular;

    FQueryCartoesConfirmados := untFuncoes.CriarQueryDLL;
    FQueryCartoesConfirmados.CachedUpdates := True;
    FQueryCartoesConfirmados.Options.SetFieldsReadOnly := False;
    FDataSourceCartoesConfirmados := TDataSource.Create(Nil);
    FDataSourceCartoesConfirmados.DataSet := FQueryCartoesConfirmados;
    cxGridDBTableViewMOVCAR_Confirmado.DataController.DataSource := FDataSourceCartoesConfirmados;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.CriarObjetosDeConsulta]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.btnIncluirLancamentoClick(Sender: TObject);
begin
  inherited;
  If FQueryExtrato.IsEmpty Then
  Begin
    fMensagem('Aviso', 'É necessário carregar um extrato!', ['&O k']);
    Exit;
  End;

  If FQueryExtrato.FieldByName('EXT_STATUS').AsString.Equals('C') Then
  Begin
    fMensagem('Aviso', 'Lançamento já confirmado!', ['&O k']);
    Exit;
  End;

  If FQueryExtrato.FieldByName('EXT_STATUS').AsString.Equals('I') Then
  Begin
    fMensagem('ATENÇÃO', 'Lançamentos ignorado!', ['&O k']);
    Exit;
  End;

  AguardeExecutarModalA(ChamaManutencaoCartaoParaInclusao,'Aguarde, Atualizando registros...', '');
end;

procedure TfrmConfirmacaoDeCartoes.cxBtnSairClick(Sender: TObject);
begin
  inherited;
  btnSair.Click;
end;

procedure TfrmConfirmacaoDeCartoes.cxGridDBTableViewMOVCARCustomDrawCell(
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

procedure TfrmConfirmacaoDeCartoes.cxGridDBTableViewMOVCAR_ConfirmadoCustomDrawCell(
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

procedure TfrmConfirmacaoDeCartoes.cxGridDBTableViewResumoBandeiraCustomDrawCell(
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

procedure TfrmConfirmacaoDeCartoes.DesvincularLancamentoManualmente;
begin
  Try
    If FQueryCartoesConfirmados.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Carregue um registro para desvincular!', ['&O k']);
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.DesvincularLancamentoManualmente]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.dsExtratoDataChange(Sender: TObject;
  Field: TField);
begin
  ExecutarConsultaCartao;
end;

procedure TfrmConfirmacaoDeCartoes.dxVertContainerDockSite1CanResize(
  Sender: TdxCustomDockControl; NewWidth, NewHeight: Integer;
  var Resize: Boolean);
begin
  inherited;
  OnResizeGrupoPontoVendas(NewWidth);
end;

procedure TfrmConfirmacaoDeCartoes.mnuSalvarLayoutClick(Sender: TObject);
begin
  inherited;
  SalvaLayoutPaineis(True);
end;

procedure TfrmConfirmacaoDeCartoes.mnuExportarLayoutClick(Sender: TObject);
begin
  inherited;
  ExportarLayoutPaineis;
end;

procedure TfrmConfirmacaoDeCartoes.mnuImportarLayoutClick(Sender: TObject);
begin
  inherited;
  ImportarLayoutPaineis;
end;

procedure TfrmConfirmacaoDeCartoes.ExecutarConsultaCartao;
begin
  tmrCarregaCartaoParaVincular.Enabled := False;
  tmrCarregaCartaoParaVincular.Enabled := True;
end;

procedure TfrmConfirmacaoDeCartoes.ExecutarTeclasAtalho(Key: Word);
begin
  If (Key = VK_F7)          Then btnAlterarCartao.Click
  Else If (Key = VK_F6)     Then btnIncluirLancamento.Click
  Else If (Key = VK_F11)    Then btnIgnorarLancamento.Click
  Else If (Key = VK_F12)    Then btnRecomporLancamento.Click
  Else If (Key = VK_F9)     Then btnConciliacao.Click
  Else If (Key = VK_Escape) Then btnSair.Click;
end;

procedure TfrmConfirmacaoDeCartoes.ExportarLayoutPaineis;
  Var
    LDadosDockingManager : TDadosDockingManager;
begin
  Try
    LDadosDockingManager.DockingManager := dxDockingManager;
    LDadosDockingManager.NomeFormulario := Self.Name;

    If untTDockingManager.ExportarLayout(LDadosDockingManager) Then
      fMensagem('Aviso', 'Configuração do layout dos painéis exportada com sucessos!', ['O k']);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ExportarLayoutPaineis]');
    End;
  End;

end;

procedure TfrmConfirmacaoDeCartoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  SalvaLayoutPaineis(False);
end;

procedure TfrmConfirmacaoDeCartoes.FormCreate(Sender: TObject);
begin
  inherited;
  CriarObjetosDeConsulta;
  FConfirmaCartoes := TConfirmaCartoes.Create;
  FExecuteFormShow := True;
  UniClientDataSetExtrato.CreateDataSet;
end;

procedure TfrmConfirmacaoDeCartoes.FormDestroy(Sender: TObject);
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

procedure TfrmConfirmacaoDeCartoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ExecutarTeclasAtalho(Key);
end;

procedure TfrmConfirmacaoDeCartoes.FormShow(Sender: TObject);
begin
  inherited;

  If Not FExecuteFormShow Then
    Exit;

  CarregaLibCartoes;

  CarregaLayoutPaineis;
  CarregaExtratosComVendasPendentes;

  FExecuteFormShow := False;
end;

function TfrmConfirmacaoDeCartoes.fValidaCampos(Sender: TWinControl;
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

procedure TfrmConfirmacaoDeCartoes.grdExtratoVendasDBTableViewCustomDrawCell(
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

procedure TfrmConfirmacaoDeCartoes.grdPendOperadoraDblClick(Sender: TObject);
begin
  inherited;
  AguardeExecutarModalA(SelecionarLancamentosPendentes,'Aguarde, Selecionando lançamento(s)...', '');
  LimparCampos;
end;

procedure TfrmConfirmacaoDeCartoes.grdPendOperadoraStylesGetContentStyle(
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

procedure TfrmConfirmacaoDeCartoes.grdTotaisDBBandedTableViewCitelTotalizadorStatusCustomDrawCell(
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

procedure TfrmConfirmacaoDeCartoes.IgnorarLancamentoManualmente;
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.IgnorarLancamentoManualmente]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.ImportarVendas(Sender: TObject);
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
    pMensagensErro('O nome da conciliadora deve ser informado ' +
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ImportarVendas]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.ImportarLayoutPaineis;
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
      fMensagem('Aviso', 'Configuração do layout dos painéis importada com sucessos!', ['O k']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ImportarLayoutPaineis]');
    End;
  End;
end;

function TfrmConfirmacaoDeCartoes.ImprimirExtrato(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LRecNo : Integer;
begin
  LRecNo := 0;
  Result := True;

  Try
    If FQueryExtrato.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Sem lançamentos para impressão!', ['&O k']);
      Exit;
    End;

    Try
      LRecNo := FQueryExtrato.RecNo;
      FQueryExtrato.DisableControls;

      FQueryExtrato.Filtered := False;
      FQueryExtrato.Filter   := grdExtratoVendasDBTableView.DataController.Filter.FilterText;
      FQueryExtrato.Filtered := True;

      UniClientDataSetExtrato.Open;
      UniClientDataSetExtrato.EmptyDataSet;

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := FQueryExtrato.RecordCount;

      FQueryExtrato.First;
      While Not FQueryExtrato.Eof Do
      Begin
        UniClientDataSetExtrato.Insert;
        UniClientDataSetExtrato.FieldByName('EXT_NUM_PV').AsString := FQueryExtrato.FieldByName('EXT_NUM_PV').AsString;
        UniClientDataSetExtrato.FieldByName('EXT_CODAUT').AsString := FQueryExtrato.FieldByName('EXT_CODAUT').AsString;
        UniClientDataSetExtrato.FieldByName('EXT_NUMNSU').AsString := FQueryExtrato.FieldByName('EXT_NUMNSU').AsString;
        UniClientDataSetExtrato.FieldByName('EXT_PARCEL').AsString := FQueryExtrato.FieldByName('EXT_PARCEL').AsString;
        UniClientDataSetExtrato.FieldByName('EXT_NOMCON').AsString := FQueryExtrato.FieldByName('EXT_NOMCON').AsString;
        UniClientDataSetExtrato.FieldByName('EXT_STATUS').AsString := FQueryExtrato.FieldByName('EXT_STATUS').AsString;

        UniClientDataSetExtrato.FieldByName('EXT_DTACUP').AsDateTime := FQueryExtrato.FieldByName('EXT_DTACUP').AsDateTime;
        UniClientDataSetExtrato.FieldByName('EXT_DTAVEN').AsDateTime := FQueryExtrato.FieldByName('EXT_DTAVEN').AsDateTime;

        UniClientDataSetExtrato.FieldByName('EXT_VALBRU').AsFloat := FQueryExtrato.FieldByName('EXT_VALBRU').AsFloat;
        UniClientDataSetExtrato.FieldByName('EXT_VALTAX').AsFloat := FQueryExtrato.FieldByName('EXT_VALTAX').AsFloat;
        UniClientDataSetExtrato.FieldByName('EXT_VALLIQ').AsFloat := FQueryExtrato.FieldByName('EXT_VALLIQ').AsFloat;
        UniClientDataSetExtrato.Post;

        FQueryExtrato.Next;
        pStep(pgbProgresso);
      End;

      TfrxMemoView(frxExtratoCartoes.FindObject('rllZebra')).Highlight.Color := COR_ZEBRA;
      frxExtratoCartoes.DotMatrixReport             := False;
      frxExtratoCartoes.PrintOptions.PrintMode      := pmScale;
      frxExtratoCartoes.PrintOptions.PrintOnSheet   := 9;
      frxExtratoCartoes.Script.Variables['NOMEMP']  := VS_strCodEmp +'-'+ fRetNomeEmpresa(VS_strCodEmp);

      pExibirRelatorio('procedure TfrmConfirmacaoDeCartoes.ImprimirExtrato',
                       'Extrato de Cartões Para Confirmação',
                        TReport.New(frxExtratoCartoes));
    Finally
      UniClientDataSetExtrato.Close;
      FQueryExtrato.Filtered := False;
      FQueryExtrato.Filter   := '';
      FQueryExtrato.RecNo    := LRecNo;
      FQueryExtrato.EnableControls;
    End;


  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.ImprimirExtrato]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.LimparCampos;
begin
  dtaIniExt.Clear;
  dtaFinExt.Clear;
  mskDtaIniPen.Clear;
  mskDtaFinPen.Clear;
end;

procedure TfrmConfirmacaoDeCartoes.MarcaOperadoraSelecionada;
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.MarcaOperadoraSelecionada]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.mnuRedeCardOnlineClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.mnuRedeCardOnlineClick]');
    End;
  End;


end;

procedure TfrmConfirmacaoDeCartoes.OnResizeGrupoPontoVendas(ANewWidth: Integer);
begin
  gpbPontoVendas.Width := ANewWidth;
  btnAtualizarPendentes.Left := (gpbLanPendentes.Width - 10);
  AjustaLarguraColunaBanderia;
end;

function TfrmConfirmacaoDeCartoes.PermitirIgnorarCartaoes(
  AOperadora: String): Boolean;
begin
  Result := True;

  If Not fVerificaAcessoSistema('IGNORARCARTOESCONFIRMACAO') Then
  Begin
    Try
      Self.Hide;
      Result := PedirLiberacao('IGNORARCARTOESCONFIRMACAO',
                               'Ignorar cartão do extrato de confirmação',
                               'Permissão para ignorar cartão do extrato de confirmação - ' + AOperadora);
    Finally
      Self.Show;
    End;
  End;
end;

function TfrmConfirmacaoDeCartoes.PermitirImportarExtrato(
  AOperadora: String): Boolean;
begin

  Result := True;

  If Not fVerificaAcessoSistema('IMPORTAREXTRATOCARTOES') Then
  Begin
    Try
      Self.Hide;
      Result := PedirLiberacao('IMPORTAREXTRATOCARTOES',
                               'Importar extrato de confirmação de cartões',
                               'Permissão para importar extrato de confirmação de cartões - ' + AOperadora);
    Finally
      Self.Show;
    End;
  End;
end;

function TfrmConfirmacaoDeCartoes.PermitirRecomporCartaoesIgnorados(
  AOperadora: String): Boolean;
begin
  Result := True;

  If Not fVerificaAcessoSistema('IGNORARCARTOESCONFIRMACAO') Then
  Begin
    Try
      Self.Hide;
      Result := PedirLiberacao('IGNORARCARTOESCONFIRMACAO',
                               'Recompor cartão ignorado do extrato de confirmação',
                               'Permissão para recompor cartão ignorado do extrato de confirmação - ' + AOperadora);
    Finally
      Self.Show;
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.mnuRedefinirLayoutClick(Sender: TObject);
begin
  inherited;
  RedefinirLayoutPaineis;
end;

procedure TfrmConfirmacaoDeCartoes.RecomporLancamentoManualmente;
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.RecomporLancamentoManualmente]');
    End;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.RedefinirLayoutPaineis;
  Var
    LDadosDockingManager : TDadosDockingManager;
    LResult: Boolean;
begin

  Try
    If fMensagem('Aviso', 'As configurações de layout atuais '+
                          'serão perdidas! Deseja continuar?', ['Sim', 'Não']) = 2 Then
    Exit;

    LDadosDockingManager.DockingManager := dxDockingManager;
    LDadosDockingManager.NomeFormulario := Self.Name + '_Padrao';
    LDadosDockingManager.Operador       := 'AUT';

    LResult := untTDockingManager.RedefinirLayout(LDadosDockingManager);
    dxVertContainerDockSite1.OnCanResize := dxVertContainerDockSite1CanResize;
    OnResizeGrupoPontoVendas(dxVertContainerDockSite1.Width);

    If LResult Then
      fMensagem('Aviso', 'Configuração do layout dos painéis redefinidas com sucessos!', ['O k']);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.RedefinirLayoutPaineis]');
    End;
  End;

end;

procedure TfrmConfirmacaoDeCartoes.SalvaLayoutPaineis(AExibirMensagem: Boolean);
  Var
    LDadosDockingManager : TDadosDockingManager;
begin
  Try
    LDadosDockingManager.DockingManager := dxDockingManager;
    LDadosDockingManager.NomeFormulario := Self.Name;
    LDadosDockingManager.Operador       := strLoginUsuarioLogado;
    LDadosDockingManager.Empresa        := VS_strCodEmp;

    If untTDockingManager.SalvarLayout(LDadosDockingManager) And AExibirMensagem Then
      fMensagem('Aviso', 'Configuração do layout dos painéis salva com sucessos!', ['O k']);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.SalvaLayoutPaineis]');
    End;
  End;

end;

procedure TfrmConfirmacaoDeCartoes.SelecionarLancamentosPendentes;
  Var
    LLancPendentesConfirmacao: TfrmLancPendentesConfirmacao;
    LNomeConciliadora:         String;
begin

  If FQueryExtratoPendentes.IsEmpty Then
    Exit;

  Try
    Self.Hide;
    LNomeConciliadora := FQueryExtratoPendentes.FieldByName('NOMCON').AsString;
    pCriarFormularios(TfrmLancPendentesConfirmacao, LLancPendentesConfirmacao);
    LLancPendentesConfirmacao.Conciliadora := LNomeConciliadora;
    LLancPendentesConfirmacao.ShowModal;

    If  Not LLancPendentesConfirmacao.Confirma Then
      Exit;

    FConfirmaCartoes.Conciliadora := LLancPendentesConfirmacao.Conciliadora;
    FConfirmaCartoes.FLancamentosSelecionados  := LLancPendentesConfirmacao.LancamentosSelecionados;

    MarcaOperadoraSelecionada;
    AguardeExecutarModalA(AtualizarRegistros,'Aguarde, Atualizando Registros...', '');

  Finally
    If Assigned(LLancPendentesConfirmacao) Then
      FreeAndNil(LLancPendentesConfirmacao);

    Self.Show;
  End;
end;

procedure TfrmConfirmacaoDeCartoes.tmrCarregaCartaoParaVincularTimer(
  Sender: TObject);
begin
  inherited;

  If FQueryExtratoPendentes.IsEmpty Then
    CarregaExtratosComVendasPendentes;

  tmrCarregaCartaoParaVincular.Enabled := False;

  CarregaCartaoParaVincular;
end;

function TfrmConfirmacaoDeCartoes.ValidaDataFinalExtratoVendas: Boolean;
begin
  Result := True;

  If (Not fEmptyStr(fTiraCaracEspeciais(dtaFinExt.Text))) And (StrToDateDef(dtaFinExt.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'A Data Final do lançamento informada é inválida! Necessário correção.', ['&O k']);
    Result := False;
  End
  Else
  If fEmptyStr(fTiraCaracEspeciais(dtaFinExt.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(dtaIniExt.Text))) Then
  Begin
    fMensagem('', 'O campo Data Final do lançamento deve ser preenchido!', ['&Ok']);
    Result := False;
  End
  Else
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(dtaFinExt.Text))) And fEmptyStr(fTiraCaracEspeciais(dtaIniExt.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial do lançamento deve ser preenchido!', ['&Ok']);
      Result := False;
      pSetFocus(dtaIniExt);
    End
    Else
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(dtaFinExt.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(dtaIniExt.Text))) Then
      Begin
        If StrToDate(dtaIniExt.Text) > StrToDate(dtaFinExt.Text) Then
        Begin
          fMensagem('','A Data Inicial do lançamento deve ser menor que a data final do lançamento!',['&O K']);
          Result := False;
          pSetFocus(dtaIniExt);
        End;
      End;
    End;
  End;

end;

function TfrmConfirmacaoDeCartoes.ValidaDataFinalLacamentosPendentes: Boolean;
begin
  Result := True;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinPen.Text))) And (StrToDateDef(mskDtaFinPen.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'A Data Final do lançamento informada é inválida! Necessário correção.', ['&O k']);
    Result := False;
  End
  Else
  If fEmptyStr(fTiraCaracEspeciais(mskDtaFinPen.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniPen.Text))) Then
  Begin
    fMensagem('', 'O campo Data Final do lançamento deve ser preenchido!', ['&Ok']);
    Result := False;
  End
  Else
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinPen.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniPen.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial do lançamento deve ser preenchido!', ['&Ok']);
      Result := False;
      pSetFocus(mskDtaIniPen);
    End
    Else
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinPen.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniPen.Text))) Then
      Begin
        If StrToDate(mskDtaIniPen.Text) > StrToDate(mskDtaFinPen.Text) Then
        Begin
          fMensagem('','A Data Inicial do lançamento deve ser menor que a data final do lançamento!',['&O K']);
          Result := False;
          pSetFocus(mskDtaIniPen);
        End;
      End;
    End;
  End;

end;

function TfrmConfirmacaoDeCartoes.ValidaDataInicialExtratoVendas: Boolean;
begin
  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(dtaIniExt.Text)) Then
  Begin
    fMensagem('', 'A Data Inicial do lançamento deve ser informada.', ['&O k']);
    Result := False;
    pSetFocus(dtaIniExt);
  End
  Else If (Not fEmptyStr(fTiraCaracEspeciais(dtaIniExt.Text))) and (StrToDateDef(dtaIniExt.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'A Data Inicial do lançamento informada é inválida! Necessário correção.', ['&O k']);
    Result := False;
    pSetFocus(dtaIniExt);
  End;
end;

function TfrmConfirmacaoDeCartoes.ValidaDataInicialLancamentosPendentes: Boolean;
begin
  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(mskDtaIniPen.Text)) Then
  Begin
    fMensagem('', 'A Data Inicial do lançamento deve ser informada.', ['&O k']);
    Result := False;
    pSetFocus(mskDtaIniPen);
  End
  Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniPen.Text))) and (StrToDateDef(mskDtaIniPen.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'A Data Inicial do lançamento informada é inválida! Necessário correção.', ['&O k']);
    Result := False;
    pSetFocus(mskDtaIniPen);
  End;

end;

procedure TfrmConfirmacaoDeCartoes.VincularLancamentoManualmente;
begin
  Try
    If FQueryCartoesParaVincular.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Carregue um registro para vincular!', ['&O k']);
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
      pMensagensErro(E.Message, '[TfrmConfirmacaoDeCartoes.VincularLancamentoManualmente]');
    End;
  End;
end;

end.
