unit untEnderecamentoMarmoreGranito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, MemDS, DBAccess, Uni,
  Datasnap.DBClient, UniClientDataSet,
  cxTextEdit, untTEnderecamentoMarmoreGranito, Vcl.ComCtrls, cxSpinEdit;

type
  TfrmEnderecamentoMarmoreGranito = class(TfrmPai)
    pnlHeader: TPanel;
    lblNotEle: TLabel;
    edtDocumento: TEditFocus;
    btnPesDoc: TBitBtnLocked;
    cxgDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxDados: TcxGridCitel;
    btnConfirma: TBitBtnLocked;
    btnImprimirEtiquetas: TBitBtnLocked;
    btnMedidasChapas: TBitBtnLocked;
    dtsDados: TDataSource;
    cxgDadosColumn2: TcxGridDBColumn;
    cxgDadosColumn3: TcxGridDBColumn;
    cxgDadosColumn4: TcxGridDBColumn;
    cxgDadosColumn5: TcxGridDBColumn;
    cxgDadosNUMLOT: TcxGridDBColumn;
    cxgDadosQTDCHAPAS: TcxGridDBColumn;
    cxgDadosCODITE: TcxGridDBColumn;
    cxgDadosSTATUS: TcxGridDBColumn;
    Panel1: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    cxgDadosESTPER: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesDocClick(Sender: TObject);
    procedure cxgDadosColumn7PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgDadosNUMLOTPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnImprimirEtiquetasClick(Sender: TObject);
    procedure btnMedidasChapasClick(Sender: TObject);
    procedure cxgDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    { Private declarations }
    objEnderecamentoMarmoreGranito: TEnderecamentoMarmoreGranito;
    procedure msgVaiParaAColunaLote(var Msg: TMessage); message WM_GO_TO_COLLUMN_LOTE;
    procedure pReinicia;
  public
    { Public declarations }
  end;

var
  frmEnderecamentoMarmoreGranito: TfrmEnderecamentoMarmoreGranito;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmEnderecamentoMarmoreGranito.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  objEnderecamentoMarmoreGranito.Progress := ProgressBar1;
  If objEnderecamentoMarmoreGranito.fConfirmaEnderecamento Then
  begin
    pMensagemOk('Endereçamento Concluído!');
    pReinicia;
  End
end;

procedure TfrmEnderecamentoMarmoreGranito.btnImprimirEtiquetasClick(
  Sender: TObject);
begin
  inherited;
  objEnderecamentoMarmoreGranito.pImprimirItem;
end;

procedure TfrmEnderecamentoMarmoreGranito.btnMedidasChapasClick(
  Sender: TObject);
begin
  inherited;
  If Not objEnderecamentoMarmoreGranito.fTemQtdChapasDefinidas then
  begin
    cxgDadosQTDCHAPAS.Focused := True;
    fMensagem('ATENÇÃO!', 'A Quantidade de chapas não foi definida!', ['&O k']);
  End

  Else
    objEnderecamentoMarmoreGranito.pAbrirDefinicoesDasChapas;
end;

procedure TfrmEnderecamentoMarmoreGranito.btnPesDocClick(Sender: TObject);
begin
  inherited;
  If objEnderecamentoMarmoreGranito.fCarregaEnderecamento Then
  Begin
    pnlHeader.Enabled := False;
    edtDocumento.Text := objEnderecamentoMarmoreGranito.strDocumentoSelecionado;
    dtsDados.DataSet := objEnderecamentoMarmoreGranito.cdsDados;
    pSetFocus(cxDados);
  End;

end;

procedure TfrmEnderecamentoMarmoreGranito.cxgDadosColumn7PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If DisplayValue = '' Then
    DisplayValue := '0';
  if StrToInt(DisplayValue) <= 0 Then
  Begin
    pMensagemOk('O valor deve ser maior que zero!');
    DisplayValue := '0';
  End;


end;

procedure TfrmEnderecamentoMarmoreGranito.cxgDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosSTATUS.Index]) = '1' Then
    ACAnvas.Brush.Color := clMoneyGreen;
end;

procedure TfrmEnderecamentoMarmoreGranito.cxgDadosNUMLOTPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
    strCodIte: String;
begin
  inherited;

  strCodIte := VarToStr(cxgDados.DataController.Values[cxgDados.DataController.FocusedRowIndex,  cxgDadosCODITE.Index]);
  If fExisteLote(DisplayValue, strCodIte, VS_strCodEmp) Then
  begin
    pMensagemOk('Este lote já esta cadastrado!');
    DisplayValue := '';
  End

end;

procedure TfrmEnderecamentoMarmoreGranito.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := fPergunta('Deseja abandonar a tarefa?');
end;

procedure TfrmEnderecamentoMarmoreGranito.FormCreate(Sender: TObject);
begin
  inherited;
  objEnderecamentoMarmoreGranito := TEnderecamentoMarmoreGranito.Create(Self);
  dtsDados.DataSet := objEnderecamentoMarmoreGranito.cdsDados;

end;

procedure TfrmEnderecamentoMarmoreGranito.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objEnderecamentoMarmoreGranito);
  inherited;
end;

procedure TfrmEnderecamentoMarmoreGranito.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirma.Click;
    VK_F9: btnMedidasChapas.Click;
    VK_F8: btnImprimirEtiquetas.Click;

    VK_RETURN:
      Begin
      If cxgDadosNUMLOT.Focused Then
        cxgDadosQTDCHAPAS.Focused := True;
      End;

    VK_ESCAPE: Close;
  End;
end;

procedure TfrmEnderecamentoMarmoreGranito.msgVaiParaAColunaLote(
  var Msg: TMessage);
begin
  pMensagemOk('Informe o lote do produto!');
  cxgDadosNUMLOT.Focused := True;
end;

procedure TfrmEnderecamentoMarmoreGranito.pReinicia;
begin
  objEnderecamentoMarmoreGranito.pReinicia;
  pnlHeader.Enabled := True;
  edtDocumento.Text := '';
  pSetFocus(btnPesDoc);

end;

end.
