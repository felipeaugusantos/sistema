unit untMain;

interface

uses
  MidasLib, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBClient, cxClasses,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmMain = class(TForm)
    GridCDS: TcxGrid;
    GridCDSDBTableView: TcxGridDBTableView;
    GridCDSLevel1: TcxGridLevel;
    dtsCDS: TDataSource;
    pnlCab: TPanel;
    edtBus: TEdit;
    lblBus: TLabel;
    lblRes: TLabel;
    ckbFil: TCheckBox;
    mmoFil: TMemo;
    mmoCol: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GridCDSDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtBusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBusChange(Sender: TObject);
    procedure ckbFilClick(Sender: TObject);
  private
    cds: TClientDataSet;
    prp: TClientDataSet;
    intCol: Integer;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
  if lTest then
    Result := vExpr1
  else
    Result := vExpr2
end;

procedure TfrmMain.ckbFilClick(Sender: TObject);
begin
  cds.Filtered := ckbFil.Checked;
  If (prp.Active) And (Not prp.IsEmpty) Then
  Begin
    Try
      If prp.Locate('CDS_PROPRE', 'RecNo', []) Then
        cds.RecNo := prp.FieldByName('CDS_VALOR_').AsInteger;
    Except

    End;
  End;
end;

procedure TfrmMain.edtBusChange(Sender: TObject);
begin
  intCol := -1;
  GridCDS.ActiveView.Invalidate;
end;

procedure TfrmMain.edtBusKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    intIdx: Integer;
    strNam: String;
    blnZer: Boolean;
begin
  If Key = VK_RETURN Then
  Begin
    blnZer := True;
    For intIdx:= intCol+1 To GridCDSDBTableView.ColumnCount-1 Do
    Begin
      strNam := GridCDSDBTableView.Columns[intIdx].DataBinding.FieldName;

      If (Pos(AnsiUpperCase(edtBus.Text), AnsiUpperCase(strNam)) > 0) then
      Begin
        blnZer := False;
        Break;
      End;
    End;
    If blnZer Then
     intCol := -1;

    For intIdx:= 0 To GridCDSDBTableView.ColumnCount-1 Do
    Begin
      strNam := GridCDSDBTableView.Columns[intIdx].DataBinding.FieldName;

      If (Pos(AnsiUpperCase(edtBus.Text), AnsiUpperCase(strNam)) > 0) then
      Begin
        If intIdx > intCol Then
        Begin
          intCol := intIdx;
          GridCDSDBTableView.Columns[intIdx].Focused := True;
          Break;
        End;
      End;

      If (intIdx = GridCDSDBTableView.ColumnCount-1) Then
        intCol := -1;
    End;
    GridCDS.ActiveView.Invalidate;
  End;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cds.Free;
  prp.Free;
end;

procedure pMostraCampoMaior225(varDataSet: TDataSet; mmoCol: TMemo=Nil);
  Var
    intIdx: Integer;
    strMsg: String;
begin
  For intIdx:=0 To varDataSet.FieldCount-1 Do
  Begin
    If varDataSet.Fields[intIdx].Size > 255 Then
      strMsg := strMsg + varDataSet.Fields[intIdx].FieldName + ' - ' + IntToStr(varDataSet.Fields[intIdx].Size) + #10#13;
  End;

  If Assigned(mmoCol) And (strMsg <> '') Then
  Begin
    mmoCol.Visible := True;
    mmoCol.Text := 'Atenção! Colunas com tamanho maior que 255: ' + #10#13 +
                   '------------------------------------------- ' + #10#13 + strMsg;
  End;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  intCol := -1;

  RegisterClasses([TClientDataSet, TADTField, TDateField, TReferenceField, TAggregateField,
                                   TDateTimeField, TSmallIntField, TArrayField, TFloatField,
                                   TSQLTimeStampField, TAutoIncField, TFMTBCDField, TStringField,
                                   TBCDField, TGraphicField, TTimeField, TBinaryField,
                                   TGuidField, TVarBytesField, TBlobField, TIDispatchField,
                                   TVariantField, TBooleanField, TIntegerField, TWideStringField,
                                   TBytesField, TInterfaceField, TWordField, TCurrencyField,
                                   TLargeintField, TDataSetField, TMemoField, TShortIntField,
                                   TLongWordField]);

  cds := TClientDataSet.Create(Nil);
  prp := TClientDataSet.Create(Nil);

  ReadComponentResFile(ExtractFilePath(Application.ExeName) + 'cds.res', cds);
  Try
    If FileExists(ExtractFilePath(Application.ExeName) + 'prp.res') Then
    Begin
      ReadComponentResFile(ExtractFilePath(Application.ExeName) + 'prp.res', prp);
      prp.Open;
    End;
  Except

  End;

  dtsCDS.DataSet := cds;
  cds.Open;

  If (prp.Active) And (Not prp.IsEmpty) Then
  Begin
    Try
      If prp.Locate('CDS_PROPRE', 'IndexFieldNames', []) Then
        cds.IndexFieldNames := prp.FieldByName('CDS_VALOR_').AsString;

      If prp.Locate('CDS_PROPRE', 'Filter', []) Then
        cds.Filter := prp.FieldByName('CDS_VALOR_').AsString;

      If prp.Locate('CDS_PROPRE', 'Filtered', []) Then
        cds.Filtered := IIF(prp.FieldByName('CDS_VALOR_').AsString='True', True, False);

      ckbFil.Visible := ((cds.Filtered) Or (cds.Filter <> ''));
      mmoFil.Visible := ckbFil.Visible;
      ckbFil.Checked := cds.Filtered;
      If mmoFil.Visible Then
        mmoFil.Lines.Text := cds.Filter;

      If prp.Locate('CDS_PROPRE', 'RecNo', []) Then
        cds.RecNo := prp.FieldByName('CDS_VALOR_').AsInteger;
    Except

    End;
  End;

  lblRes.Caption := IntToStr(cds.FieldCount-1) + ' Coluna(s) ' + IntToStr(cds.RecordCount) + ' Registo(s)';
  GridCDSDBTableView.DataController.CreateAllItems;
  pMostraCampoMaior225(TDataSet(cds), mmoCol);
  GridCDS.BeginUpdate;
  Try
    GridCDSDBTableView.ApplyBestFit;
  Finally
    GridCDS.EndUpdate;
  End;
  edtBus.SetFocus;
end;

procedure TfrmMain.GridCDSDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    str: String;
begin
  If (Trim(edtBus.Text) <> '') Then
  Begin
    If (Assigned(cds)) And (cds.Active) Then
    Begin
      str := (AViewInfo.Item As TcxGridDBColumn).DataBinding.FieldName;

      If (AViewInfo.Item As TcxGridDBColumn).Index = intCol Then
      Begin
        ACanvas.Brush.Color := $008080FF;
      End
      Else If (Pos(AnsiUpperCase(edtBus.Text), AnsiUpperCase(str)) > 0) then
      Begin
        ACanvas.Brush.Color := clInfoBk;
      End;

      ACanvas.Font.Color := clBlack;
    End;
  End;
end;

end.
