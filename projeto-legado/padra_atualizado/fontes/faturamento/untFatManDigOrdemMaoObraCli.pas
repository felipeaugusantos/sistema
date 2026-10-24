unit untFatManDigOrdemMaoObraCli;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UniClientDataSet, untPaiSimples,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmFatManDigOrdemMaoObraCli = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    dbgServicos: TcxGrid;
    dbgServicosDBTableView1: TcxGridDBTableView;
    dbgServicosDBTableViewCODSER: TcxGridDBColumn;
    dbgServicosDBTableViewDESSER: TcxGridDBColumn;
    dbgServicosDBTableViewQTDSER: TcxGridDBColumn;
    dbgServicosDBTableViewUNITAR: TcxGridDBColumn;
    dbgServicosDBTableViewTOTSER: TcxGridDBColumn;
    dbgServicosDBTableViewMAOCLI: TcxGridDBColumn;
    dbgServicosLevel1: TcxGridLevel;
    dtsDados: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgServicosDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgServicosDBTableView1EditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure dbgServicosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pCopiarNumeroPedido;
    procedure pBeforePost(DataSet: TDataSet);
  public
    { Public declarations }
    cdsDados : TUniClientDataSet;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

procedure TfrmFatManDigOrdemMaoObraCli.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrOk;
end;

procedure TfrmFatManDigOrdemMaoObraCli.dbgServicosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if (not Assigned(cdsDados)) then
    Exit;

  if (not cdsDados.Active) then
    Exit;

  if cdsDados.IsEmpty then
    Exit;

  if AViewInfo.Item.Index in [dbgServicosDBTableViewMAOCLI.Index] then
    ACanvas.Brush.Color := $009FFDF5;

  if AViewInfo.Selected then
    ACanvas.Brush.Color := clHighlight;
end;

procedure TfrmFatManDigOrdemMaoObraCli.dbgServicosDBTableView1EditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;

  if (CharInSet(Key, ['-', '+', ',', '.']) and
     (dbgServicosDBTableView1.Controller.FocusedColumn = dbgServicosDBTableViewMAOCLI)) then
    Key := #0;
end;

procedure TfrmFatManDigOrdemMaoObraCli.dbgServicosDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_F5 then
    pCopiarNumeroPedido;

  if Key = VK_F10 then
  Begin
    Key := 0;
    btnConfirma.Click;
  End;

  if Key = VK_Escape then
    btnFechar.Click;

  if (Key = VK_DELETE) and (cdsDados.State <> dsEdit) then
    Key := 0;
end;

procedure TfrmFatManDigOrdemMaoObraCli.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados  := TUniClientDataSet.Create(Self);
  dbgServicosDBTableViewQTDSER.Visible := fCfgSis('QTDSER', varBoolean);

  if (not dbgServicosDBTableViewQTDSER.Visible) then
    Self.Width := Self.Width - dbgServicosDBTableViewQTDSER.Width;
end;

procedure TfrmFatManDigOrdemMaoObraCli.FormShow(Sender: TObject);
begin
  inherited;
  TFloatField(cdsDados.FieldByName('QTDSER')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsDados.FieldByName('VALUNI')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsDados.FieldByName('VALSER')).DisplayFormat := '#,##0.00';

  dtsDados.DataSet := cdsDados;
  cdsDados.BeforePost  := pBeforePost;

  pSetFocus(dbgServicos);
end;

procedure TfrmFatManDigOrdemMaoObraCli.pBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('MAOCLI').AsString := Trim(DataSet.FieldByName('MAOCLI').AsString);
end;

procedure TfrmFatManDigOrdemMaoObraCli.pCopiarNumeroPedido;
var
  strMaoCli: String;
begin
  if fPergunta('Deseja alterar todos os itens para o número ' +
               'de ordem de mão de obra "' + cdsDados.FieldByName('MAOCLI').AsString + '"?') then
  begin
    strMaoCli := cdsDados.FieldByName('MAOCLI').AsString;

    cdsDados.First;

    while not cdsDados.Eof do
    begin
      cdsDados.Edit;
      cdsDados.FieldByName('MAOCLI').AsString := strMaoCli;
      cdsDados.Post;
      cdsDados.Next;
    end;
  end;
end;

end.
