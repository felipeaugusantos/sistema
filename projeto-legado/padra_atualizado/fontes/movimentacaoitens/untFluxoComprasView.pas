unit untFluxoComprasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untFluxoCompras,
  cxImageComboBox, untZClient, cxHyperLinkEdit, cxContainer, dxSparkline,
  cxButtonEdit, cxLabel, cxMemo, cxGridBandedTableView, cxGridDBBandedTableView,
  cxEditRepositoryItems, dxScreenTip, dxCustomHint, cxHint, untTNFEToPedidoCompra;

type
  TfrmFluxoComprasView = class(TfrmPai)
    cxgFluxoLVL: TcxGridLevel;
    cxgFluxo: TcxGridCitel;
    btnIncluirXml: TBitBtnLocked;
    btnAtualizar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgFluxoTBV: TcxGridDBBandedTableView;
    cxEditRepository: TcxEditRepository;
    cxEditRepositoryButtonVisibleCenter: TcxEditRepositoryButtonItem;
    cxEditRepositoryButtonInvisibleCenter: TcxEditRepositoryButtonItem;
    cxEditRepositoryTextItem: TcxEditRepositoryTextItem;
    HintControler: TcxHintStyleController;
    tmrHint: TTimer;
    btnPainelRequisicaoCompra: TBitBtnLocked;
    btnExportaExcel: TBitBtnLocked;
    btnGerarPedidoCompra: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnIncluirXmlClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgFluxoTBVMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cxgFluxoTBVKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure cxgFluxoTBVCanFocusRecord(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure tmrHintTimer(Sender: TObject);
    procedure btnPainelRequisicaoCompraClick(Sender: TObject);
    procedure btnExportaExcelClick(Sender: TObject);
    procedure btnGerarPedidoCompraClick(Sender: TObject);
  private
    objFluxo : TFluxoCompras;
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  untEntImportacaoNotaEletronica,
  untFuncoesSimples,
  untExportaGridExcel;

procedure TfrmFluxoComprasView.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmFluxoComprasView.btnPainelRequisicaoCompraClick(Sender: TObject);
begin
  inherited;
  objFluxo.pCarregaRequisicoes;
end;

procedure TfrmFluxoComprasView.btnAtualizarClick(Sender: TObject);
begin
  inherited;

  if not btnAtualizar.Enabled then
    exit;

  objFluxo.pAtualizaDados();
end;


procedure TfrmFluxoComprasView.btnCancelarClick(Sender: TObject);
begin
  inherited;

  if not btnCancelar.Enabled then
    exit;

  objFluxo.pCancelarProcesso;
end;

procedure TfrmFluxoComprasView.btnExportaExcelClick(Sender: TObject);
  Var
    objExportaExcel: TExportaGridExcel;
begin
  inherited;

  objExportaExcel := TExportaGridExcel.Create(Self, cxgFluxoTBV);

  objExportaExcel.fExporta;

  FreeAndNil(objExportaExcel);
end;

procedure TfrmFluxoComprasView.btnGerarPedidoCompraClick(Sender: TObject);

begin

 If TNFEToPedidoCompra.fGeraPedidoCompra(objFluxo.cdsFluxo.FieldByName('AUTOINCREM').AsString, tpeNfeToPedidoCompra(FluxoCompras)) Then
  objFluxo.pAtualizaDados();

end;

procedure TfrmFluxoComprasView.btnIncluirXmlClick(Sender: TObject);
begin
  inherited;
  if not btnIncluirXml.Enabled then
    exit;

  objFluxo.pImportaNota();
end;

procedure TfrmFluxoComprasView.cxgFluxoTBVCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmFluxoComprasView.cxgFluxoTBVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: btnSair.Click;
  End;

end;

procedure TfrmFluxoComprasView.cxgFluxoTBVMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  exit;
  inherited;

end;

procedure TfrmFluxoComprasView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not fPergunta('Deseja abandonar a tarefa?') Then
    Action := caNone;
end;

procedure TfrmFluxoComprasView.FormCreate(Sender: TObject);
begin
  inherited;

  cxgFluxoTBV.OptionsView.ShowEditButtons := gsebAlways;

  cxEditRepositoryButtonInvisibleCenter.Properties.Buttons[0].Free;

  objFluxo := TFluxoCompras.Create(cxEditRepositoryButtonVisibleCenter,
                                   cxEditRepositoryButtonInvisibleCenter,
                                   cxEditRepositoryTextItem);
  cxgFluxo.BeginUpdate;
  Try
    objFluxo.cxgFluxo := cxgFluxo;

    objFluxo.btnCancelar := btnCancelar;

    objFluxo.HintControler := HintControler;
    objFluxo.TimerHint := tmrHint;

    tmrHint.Interval := HintControler.HintHidePause;
  Finally
    cxgFluxo.EndUpdate;
  End;
end;

procedure TfrmFluxoComprasView.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objFluxo);
end;

procedure TfrmFluxoComprasView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F1 : btnIncluirXml.Click;
    VK_F4 : btnGerarPedidoCompra.Click;
    VK_F5 : btnAtualizar.Click;
    VK_F6 : btnCancelar.Click;
    VK_F7 : btnPainelRequisicaoCompra.Click;
    VK_F8 : btnExportaExcel.Click;
  end;
end;

procedure TfrmFluxoComprasView.FormShow(Sender: TObject);
begin
  inherited;
  objFluxo.pAtualizaDados();
end;


procedure TfrmFluxoComprasView.tmrHintTimer(Sender: TObject);
begin
  inherited;
  tmrHint.Enabled := false;
  HintControler.HideHint;
end;

end.
