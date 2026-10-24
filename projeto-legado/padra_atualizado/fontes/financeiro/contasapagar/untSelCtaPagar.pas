unit untSelCtaPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, UniClientDataSet;

type
  TfrmSelCtaPag = class(TfrmPaiConfirma)
    grdCtaPagTv: TcxGridDBTableViewCitel;
    grdCtaPagLevel1: TcxGridLevel;
    grdCtaPag: TcxGridCitel;
    grdCtaPagTvCTP_DTACAD: TcxGridDBColumn;
    grdCtaPagTvCTP_DTAVEN: TcxGridDBColumn;
    grdCtaPagTvDOCUMENTO: TcxGridDBColumn;
    grdCtaPagTvCTP_SERIE_: TcxGridDBColumn;
    grdCtaPagTvCTA_DESCTA: TcxGridDBColumn;
    grdCtaPagTvCTP_HIST01: TcxGridDBColumn;
    grdCtaPagTvCTP_VALDUP: TcxGridDBColumn;
    dsCtaPag: TDataSource;
    grdCtaPagTvMARDES: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure grdCtaPagTvDblClick(Sender: TObject);
    procedure grdCtaPagTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdCtaPagTvCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FQryCtaPag: TUniClientDataSet;
    FQtdeMarcado: Integer;
    procedure MarcaDesmarca;
  public
    { Public declarations }
    procedure SetData(DataSet: TDataSet);
    function Selecionado: String;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmSelCtaPag }

procedure TfrmSelCtaPag.btnConfirmaClick(Sender: TObject);
begin
  If FQtdeMarcado = 0 Then
  Begin
    fMensagem('', 'Selecione com [ENTER] ou [Duplo Click]' , ['&O k']);
    Exit;
  End;

  inherited;
end;

procedure TfrmSelCtaPag.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FQryCtaPag) then
    FreeAndNil(FQryCtaPag);
end;

procedure TfrmSelCtaPag.FormShow(Sender: TObject);
begin
  inherited;
  TFloatField(FQryCtaPag.FieldByName('CTP_VALDUP')).DisplayFormat := '#,##0.00';
  btnConfirma.ModalResult := MrNone;
end;

procedure TfrmSelCtaPag.grdCtaPagTvCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  MarDes : String;
begin
  inherited;
  MarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdCtaPagTvMARDES.Index]);

  If fEmptyStr(MarDes) Then
    Exit;

  If (MarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmSelCtaPag.grdCtaPagTvDblClick(Sender: TObject);
begin
  inherited;
  MarcaDesmarca;
end;

procedure TfrmSelCtaPag.grdCtaPagTvKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) then
    MarcaDesmarca;
end;

function TfrmSelCtaPag.Selecionado: String;
begin
  Result := '';
  if FQryCtaPag.Locate('MARDES', 'M', []) then
    Result := FQryCtaPag.FieldByName('AUTOINCREM').AsString;
end;

procedure TfrmSelCtaPag.SetData(DataSet: TDataSet);
begin
  FQryCtaPag := fCriaClientDatset(DataSet);
  dsCtaPag.DataSet := FQryCtaPag;
end;

procedure TfrmSelCtaPag.MarcaDesmarca;
begin
  if FQryCtaPag.IsEmpty then
   Exit;

  if FQryCtaPag.FieldByName('MARDES').AsString = 'M' then
  begin
    FQryCtaPag.Edit;
    FQryCtaPag.FieldByName('MARDES').AsString := '';
    FQryCtaPag.Post;
    Dec(FQtdeMarcado);
  end
  else
  begin
    if (FQtdeMarcado > 0) then
    begin
      fMensagem('', 'Somente é possível selecionar 1 registro!', ['&O k']);
      Exit;
    end;

    FQryCtaPag.Edit;
    FQryCtaPag.FieldByName('MARDES').AsString := 'M';
    FQryCtaPag.Post;
    Inc(FQtdeMarcado)
  end;
end;

end.
