unit untSQLBind_QueryDLL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  Uni, StdCtrls, Grids, DBGridCitel, DBGrids, ComCtrls, DB, cxDataStorage, cxEdit, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  ExtCtrls, Buttons, ValEdit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxGrid, StrUtils, UniClientDataSet, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmSQLBind_QueryDLL = class(TForm)
    memError: TMemo;
    Panel1: TPanel;
    Splitter1: TSplitter;
    memSQL: TMemo;
    GridBind: TcxGrid;
    GridBindDBTableView: TcxGridDBTableView;
    GridBindLevel1: TcxGridLevel;
    pnlSlider: TPanel;
    GridParams: TcxGrid;
    GridParamsView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    GridParamsViewParam: TcxGridDBColumn;
    GridParamsViewValue: TcxGridDBColumn;
    dtsParams: TDataSource;
    cdsParams: TUniClientDataSet;
    cdsParamsParam: TStringField;
    cdsParamsValue: TStringField;
    cdsParamsType: TIntegerField;
    pnlButtons: TPanel;
    btnRestaurar: TBitBtn;
    btnShowHideParam: TBitBtn;
    btnSQLBound: TBitBtn;
    btnExecutar: TBitBtn;
    Panel2: TPanel;
    btnRestaurarParam: TBitBtn;
    btnIdentar: TBitBtn;
    stb: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure memSQLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExecutarClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSQLBoundClick(Sender: TObject);
    procedure btnShowHideParamClick(Sender: TObject);
    procedure btnRestaurarParamClick(Sender: TObject);
    procedure btnIdentarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure pAtualizaParam(qry: TUniQuery);
    procedure pExecSQL(strSQL: String);
    function Locate(Args: Array Of String; strLocate: String): Boolean;

    procedure pShowHideParam;

    function fIdentar(strSQL: String): String;
  public
    dtsSQL: TDataSource;
    qryOriginal: TUniQuery;
    qryBind: TUniQuery;

    class procedure pBind(qry: TUniQuery);
    class function fBoundSQL(qry: TUniQuery): String;
  end;

var
  frmSQLBind_QueryDLL: TfrmSQLBind_QueryDLL;

implementation

{$R *.dfm}

uses untILibCartoesFactory, untILibCartoesWrapper, untTLibCartoesFuncoes;

class function TfrmSQLBind_QueryDLL.fBoundSQL(qry: TUniQuery): String;
  Var
    intParam: Integer;
begin
  Result := qry.SQL.Text;

  For intParam := 0 To qry.Params.Count -1 Do
  Begin
    Case qry.Params[intParam].DataType Of
      ftDateTime,
      ftDate:    Result := ReplaceStr(Result, ':'+ qry.Params[intParam].Name, QuotedStr( FormatDateTime('YYYY-MM-DD', qry.Params[intParam].AsDateTime) ));
      ftFloat:   Result := ReplaceStr(Result, ':'+ qry.Params[intParam].Name, ReplaceStr(qry.Params[intParam].AsString, ',', '.'));
      ftInteger: Result := ReplaceStr(Result, ':'+ qry.Params[intParam].Name, qry.Params[intParam].AsString);
    Else         Result := ReplaceStr(Result, ':'+ qry.Params[intParam].Name, QuotedStr(qry.Params[intParam].AsString) );
    End;
  End;
end;

procedure TfrmSQLBind_QueryDLL.btnExecutarClick(Sender: TObject);
begin
  pExecSQL(memSQL.Text);
end;

procedure TfrmSQLBind_QueryDLL.btnIdentarClick(Sender: TObject);
begin
  memSQL.Text := fIdentar(memSQL.Text);
end;

procedure TfrmSQLBind_QueryDLL.btnRestaurarClick(Sender: TObject);
begin
  memSQL.Text := qryOriginal.SQL.Text;
end;

procedure TfrmSQLBind_QueryDLL.btnRestaurarParamClick(Sender: TObject);
begin
  cdsParams.First;
  While Not cdsParams.Eof Do
  Begin
    cdsParams.Edit;
    Case TFieldType(cdsParamsType.AsInteger) Of
      ftDateTime,
      ftDate:  cdsParamsValue.AsString := FormatDateTime('dd/mm/yyyy', qryOriginal.ParamByName(cdsParamsParam.AsString).AsDateTime);
      ftFloat: cdsParamsValue.AsString := FormatFloat('#,##0.0000', qryOriginal.ParamByName(cdsParamsParam.AsString).AsFloat);
    Else
      cdsParamsValue.AsString := qryOriginal.ParamByName(cdsParamsParam.AsString).AsString;
    End;
    
    cdsParams.Post;
    
    cdsParams.Next;
  End;
end;

procedure TfrmSQLBind_QueryDLL.btnShowHideParamClick(Sender: TObject);
begin
  pShowHideParam;
end;

procedure TfrmSQLBind_QueryDLL.btnSQLBoundClick(Sender: TObject);
begin
  pAtualizaParam(qryBind);
  memSQL.Text := fBoundSQL(qryBind);
end;

function TfrmSQLBind_QueryDLL.fIdentar(strSQL: String): String;
  Var
    stlToken: TStringList;
    intChar: Integer;
    blnGravando: Boolean;
    strToken: String;
    cChar: Char;
begin
  blnGravando := False;
  Result := AnsiReplaceStr(strSQL, #13#10, ' ');

  stlToken := TStringList.Create;
  Try
    Result := AnsiReplaceStr(Result, #13, ' ');

    While Pos('  ', Result) > 0 Do
      Result := AnsiReplaceStr(Result, '  ', ' ');

    //Salva todos os textos antes dos replaces
    For intChar := 1 To Length(Result) Do
    Begin
      cChar := Result[intChar];
      If (cChar = '''') Or (cChar = '"') Then
        blnGravando := Not blnGravando;

      If blnGravando Then
        strToken := strToken + cChar
      Else If strToken <> '' Then
      Begin
        strToken := strToken + cChar;
        stlToken.Add(strToken);
        strToken := '';
      End;
    End;

    //Substitui todos token
    For intChar := 0 To stlToken.Count -1 Do
      Result := AnsiReplaceStr(Result, stlToken[intChar], '$TOKEN'+ IntToStr(intChar)+'$');

    Result := AnsiReplaceStr(Result, 'FROM ',      #13#10 + '  FROM ');
    Result := AnsiReplaceStr(Result, 'WHERE ',     #13#10 + ' WHERE ');
    Result := AnsiReplaceStr(Result, 'LEFT JOIN ', #13#10 + '  LEFT JOIN ');
    Result := AnsiReplaceStr(Result, 'GROUP BY ',  #13#10 + ' GROUP BY ');
    Result := AnsiReplaceStr(Result, 'ORDER BY ',  #13#10 + ' ORDER BY ');
    Result := AnsiReplaceStr(Result, 'UNION ALL ', #13#10#13#10 + 'UNION ALL'+ #13#10#13#10);
    Result := AnsiReplaceStr(Result, ', ', ',' + #13#10 + '       ');
    Result := AnsiReplaceStr(Result, ' AND ', #13#10 +  '   AND ');

    //Volta os valores dos token
    For intChar := 0 To stlToken.Count -1 Do
      Result := AnsiReplaceStr(Result, '$TOKEN'+ IntToStr(intChar)+'$', stlToken[intChar]);
  Finally
    stlToken.Free;
  End;

end;

procedure TfrmSQLBind_QueryDLL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryBind.Free;
  dtsSQL.Free;
end;

procedure TfrmSQLBind_QueryDLL.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_F11: btnIdentar.Click;
    VK_F10: btnShowHideParam.Click;
    VK_F8: btnExecutar.Click;
    VK_F5: btnRestaurar.Click;
    VK_F6: btnSQLBound.Click;
    VK_ESCAPE: Close;
  End;
end;

procedure TfrmSQLBind_QueryDLL.FormShow(Sender: TObject);
  Var
    intParam: Integer;
begin
  dtsSQL := TDataSource.Create(Nil);

  qryBind.SQL.Text := fBoundSQL(qryOriginal);
  memSQL.Text := qryBind.SQL.Text;

  // Popula CDS de Parametros
  cdsParams.CreateDataSet;
  For intParam := 0 To qryOriginal.Params.Count -1 Do
  Begin
    cdsParams.Append;
    cdsParamsParam.AsString := qryOriginal.Params[intParam].Name;
    cdsParamsType.AsInteger := Integer(qryOriginal.Params[intParam].DataType);
    Case qryOriginal.Params[intParam].DataType Of
      ftDateTime,
      ftDate:  cdsParamsValue.AsString := FormatDateTime('dd/mm/yyyy', qryOriginal.Params[intParam].AsDateTime);
      ftFloat: cdsParamsValue.AsString := FormatFloat('#,##0.0000', qryOriginal.Params[intParam].AsFloat);
    Else       cdsParamsValue.AsString := qryOriginal.Params[intParam].AsString;
    End;
    cdsParams.Post;
  End;

  dtsSQL.DataSet := qryBind;
  GridBindDBTableView.DataController.DataSource := dtsSQL;

  stb.Caption := 'Host: ' + qryOriginal.Connection.Server + ':'+ IntToStr(qryOriginal.Connection.Port) + '    Database: '+ qryOriginal.Connection.Database;
end;

function TfrmSQLBind_QueryDLL.Locate(Args: Array Of String; strLocate: String): Boolean;
  Var
    i: Integer;
begin
  Result := False;

  For i := 0 To Length(Args) -1 Do
  Begin
    If Pos(Args[i], strLocate) > 0 Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

procedure TfrmSQLBind_QueryDLL.memSQLKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Chr(Key) = 'A') And (ssCtrl In Shift) Then
    memSQL.SelectAll;
end;

procedure TfrmSQLBind_QueryDLL.pAtualizaParam(qry: TUniQuery);
Begin
  qry.Close;
  
  qry.SQL.Text := qryOriginal.SQL.Text;

  cdsParams.First;
  While Not cdsParams.Eof Do
  Begin
    Case TFieldType(cdsParamsType.AsInteger) Of
      ftDateTime,
      ftDate: qry.ParamByName(cdsParamsParam.AsString).AsDateTime := StrToDate(cdsParamsValue.AsString);
      ftFloat: qry.ParamByName(cdsParamsParam.AsString).AsFloat := StrToFloat(ReplaceStr(ReplaceStr(cdsParamsValue.AsString, '.', ''), ',', '.'));
    Else
      qry.ParamByName(cdsParamsParam.AsString).AsString := cdsParamsValue.AsString;
    End;
    cdsParams.Next;
  End;

end;

class procedure TfrmSQLBind_QueryDLL.pBind(qry: TUniQuery);
begin
  TLibCartoesFuncoes.pCriarFormularios(TfrmSQLBind_QueryDLL, frmSQLBind_QueryDLL);
  Try
    frmSQLBind_QueryDLL.qryBind := TLibCartoesFactory.Get.fICriaQuery;
    frmSQLBind_QueryDLL.qryOriginal := qry;

    frmSQLBind_QueryDLL.ShowModal;
  Finally
    frmSQLBind_QueryDLL.Free;
  End;
end;

procedure TfrmSQLBind_QueryDLL.pExecSQL(strSQL: String);
begin
  memError.Visible := False;

  qryBind.SQL.Text := strSQL;
  Try
    GridBindDBTableView.ClearItems;
    If Locate(['UPDATE','INSERT','DELETE'], strSQL) Then
    Begin
      qryBind.Connection.ExecSQL(strSQL, []);
      memError.Visible := True;
    End
    Else
    Begin
      qryBind.Open;
      GridBindDBTableView.DataController.CreateAllItems;
    End;
  Except
    On E: Exception Do
    Begin
      memError.Text := E.Message;
      memError.Visible := True;
    End;
  End;
end;

procedure TfrmSQLBind_QueryDLL.pShowHideParam;
Const intWidth = 250;
  Var
    intNewWidth: Integer;
begin
  If pnlSlider.Width > 0 Then
    intNewWidth := 0
  Else
    intNewWidth := intWidth;

  While pnlSlider.Width <> intNewWidth Do
    pnlSlider.Width := pnlSlider.Width + StrToInt(IfThen(intNewWidth = 0, '-10', '10'));

  If pnlSlider.Width = 0 Then
    btnShowHideParam.Caption := '[F10] Mostrar Parametros'
  Else
    btnShowHideParam.Caption := '[F10] Esconder Parametros';
end;

end.
