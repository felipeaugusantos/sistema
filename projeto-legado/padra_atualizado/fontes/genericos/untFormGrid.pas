unit untFormGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, DB,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmGrid = class(TfrmPai)
    grdInfoDBTableView: TcxGridDBTableView;
    grdInfoLevel1: TcxGridLevel;
    grdInfo: TcxGrid;
    dsrInfo: TDataSource;
    procedure grdInfoDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetDataSet(const Value: TDataSet);
    procedure CriaColunas();
  public
    property DataSet: TDataSet write SetDataSet;
  end;

var
  frmGrid: TfrmGrid;

implementation

{$R *.dfm}

{ TfrmGrid }

procedure TfrmGrid.CriaColunas;
var
  objField: TField;
  objColumn: TcxGridDBColumn;
begin
  For objField in dsrInfo.DataSet.Fields Do
  Begin
    objColumn := grdInfoDBTableView.CreateColumn;
    objColumn.DataBinding.FieldName := objField.FieldName;
    objColumn.MinWidth := objField.DisplayWidth;
    If objColumn.MinWidth < (grdInfo.Canvas.TextWidth(objColumn.Caption) + 10) Then
      objColumn.MinWidth := grdInfo.Canvas.TextWidth(objColumn.Caption) + 10;

    objColumn.Visible := objField.Visible;
    if (Trim(objField.DisplayName) <> '') then
      objColumn.Caption := Trim(objField.DisplayName);
  End;
end;

procedure TfrmGrid.FormCreate(Sender: TObject);
begin
  inherited;
  grdInfoDBTableView.OnKeyDown := pOnKeyDown;
end;

procedure TfrmGrid.grdInfoDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord.Selected then
  begin
    ACanvas.Brush.Color := clHighlight;
    ACanvas.Font.Color := clHighlightText;
  end
  else
  begin
    if Odd(AViewInfo.GridRecord.Index) then
      ACanvas.Brush.Color := clMoneyGreen
    else
      ACanvas.Brush.Color := clWindow;
    ACanvas.Font.Color := clWindowText;
  end;

  ADone := False;
end;

procedure TfrmGrid.SetDataSet(const Value: TDataSet);
begin
  dsrInfo.DataSet := Value;
  CriaColunas;
end;

end.
