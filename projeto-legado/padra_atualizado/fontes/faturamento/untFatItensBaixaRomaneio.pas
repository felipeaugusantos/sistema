unit untFatItensBaixaRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem, Data.DB, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, UniClientDataSet, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxCalc, cxTextEdit,
  cxCurrencyEdit;

type
  TfrmFatItensBaixaRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    edtNomCli: TEditFocus;
    btnRestaurarItem: TBitBtnLocked;
    btnItemNaoEntregue: TBitBtnLocked;
    btnRestaurarTudo: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    cxgItensDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGridCitel;
    DET_CODITE: TcxGridDBColumn;
    DET_DESCRI: TcxGridDBColumn;
    DET_NUMLOT: TcxGridDBColumn;
    DET_QTDITE: TcxGridDBColumn;
    DET_QTDBAI: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnRestaurarTudoClick(Sender: TObject);
    procedure btnRestaurarItemClick(Sender: TObject);
    procedure btnItemNaoEntregueClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cxgItensDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DET_QTDBAIPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strSeqGer: String;
  end;

implementation

uses untFuncoesSimples, System.UITypes;

{$R *.dfm}

procedure TfrmFatItensBaixaRomaneio.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmFatItensBaixaRomaneio.btnRestaurarItemClick(Sender: TObject);
begin
  inherited;
  With cdsItens Do
  Begin
    If Not IsEmpty Then
    Begin
      Edit;
      FieldByName('DET_QTDBAI').AsFloat := FieldByName('DET_QTDITE').AsFloat;
      Post;
    End;
  End;
end;

procedure TfrmFatItensBaixaRomaneio.btnRestaurarTudoClick(Sender: TObject);
begin
  inherited;
  With cdsItens Do
  Begin
    If Not IsEmpty Then
    Begin
      DisableControls;
      First;
      While (Not Eof) Do
      Begin
        btnRestaurarItem.Click;
        Next;
      End;
      EnableControls;
    End;
  End;
end;

procedure TfrmFatItensBaixaRomaneio.btnItemNaoEntregueClick(Sender: TObject);
begin
  inherited;
  With cdsItens Do
  Begin
    If Not IsEmpty Then
    Begin
      Edit;
      FieldByName('DET_QTDBAI').AsFloat := 0;
      Post;
    End;
  End;
end;

procedure TfrmFatItensBaixaRomaneio.btnSairClick(Sender: TObject);
begin
  If (fMensagem('', 'Abandona Itens?', ['&Sim', '&Não']) = 2) Then
    Exit;
  inherited;
end;

procedure TfrmFatItensBaixaRomaneio.cxgItensDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Not cdsItens.Active) Then
    Exit;

  If (cdsItens.IsEmpty) Then
    Exit;

  if Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, DET_QTDITE.Index] =
    Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, DET_QTDBAI.Index] then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
      ACanvas.Font.Color := clBlue;
  end
  else
  if Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, DET_QTDBAI.Index] = 0.00 then
  begin
    ACanvas.Font.Color := clRed;
  end
  else
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
      ACanvas.Font.Color := clHighLight;
  end;

end;

procedure TfrmFatItensBaixaRomaneio.cxgItensDBTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10   : btnConfirma.Click;
    VK_F9    : btnRestaurarTudo.Click;
    VK_F8    : btnRestaurarItem.Click;
    VK_DELETE: btnItemNaoEntregue.Click;
    VK_ESCAPE: btnSair.Click;
  end;
end;

procedure TfrmFatItensBaixaRomaneio.DET_QTDBAIPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if not cdsItens.Active then
    Exit;

  if cdsItens.State = dsEdit then
  begin
    if (TcxCurrencyEdit(Sender).Value < 0 ) or
       (TcxCurrencyEdit(Sender).Value > cdsItens.FieldByName('DET_QTDITE').AsFloat) then
    cdsItens.Cancel;
  end;
end;

procedure TfrmFatItensBaixaRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgItens);
  DET_QTDBAI.Options.Editing := fCfgSis('ROMPAR', varBoolean);

  cdsItens.Filtered := False;
  cdsItens.Filter := 'DET_SEQGER = ' + QuotedStr(strSeqGer);
  cdsItens.Filtered := True;
end;

end.
