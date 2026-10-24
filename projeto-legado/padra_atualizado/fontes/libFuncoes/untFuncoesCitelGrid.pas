unit untFuncoesCitelGrid;

interface

uses
  SysUtils, DBGridCitel,   StrUtils, cxControls, cxCustomData, Classes,
   Windows, Math, Uni, IOUtils, DateUtils, DB, Variants, Forms, UniClientDataSet,
   Shlobj, Vcl.ExtCtrls, untInterfacedObjectNoCount, untIFuncoesCitelGrid,
   System.Generics.Collections;

Type

  TFuncoesCitelGrid = class(TInterfacedObjectNoCount, IFuncoesCitelGrid)
  private
    class var objFuncoesCitelGrid: TFuncoesCitelGrid;

    function fCarregarConfiguracao(strCodOpe, strCodEmp, strChave: String): String;
    function fGravarConfiguracao(const strCodOpe, strCodEmp, strChave, strValor: String;
      grdGrid: TDbGridCitel): Boolean;
    procedure pLoadGridLayout(grdGrid: TDBGridCitel; strConfig: String);
    function fSaveGridLayout(grdGrid: TDBGridCitel) : String;
    procedure pStringExplode(strTexto: string; strDelimiter: string; Var stlTexto: TStringList);
  public
    function fCarregarView(grdGrid: TDBGridCitel; strChave: String): Boolean; overload;
    procedure pSalvarView(grdGrid: TDBGridCitel; strChave: String); overload;
    procedure pDeletarView(strChave: String);
  End;

  function fGetFuncoesCitelGrid: IFuncoesCitelGrid; StdCall;

Var
  intGravandoCarregandoArquivoCfg: Integer;

implementation

uses untFuncoesGen;

var
  VS_ProcessId: string;

function fGetFuncoesCitelGrid: IFuncoesCitelGrid;
begin
  Result := TFuncoesCitelGrid.objFuncoesCitelGrid;
end;

{ TFuncoesCitelGrid }

procedure TFuncoesCitelGrid.pDeletarView(strChave: String);
var
  strSQL: String;
  qryCfgCol: TUniQuery;
begin
  qryCfgCol := fCriaQuery(nil);
  try
    strSQL := ' UPDATE '+
              '   CFGCOL '+
              ' SET '+
              '   CFG_VALOR_ = "" '+
              ' WHERE CFG_CHAVE_ = :CHAVE_ ' +
              ' AND CFG_CODEMP = :CODEMP '+
              ' AND CFG_LOGOPE = :CODOPE';

    qryCfgCol.Close;
    qryCfgCol.SQL.Text := strSQL;

    qryCfgCol.ParamByName('CHAVE_').AsString := strChave;

    qryCfgCol.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfgCol.ParamByName('CODOPE').AsString := strUsuarioLogado;


    qryCfgCol.ExecSql;
  finally
    FreeAndNil(qryCfgCol);
  end;
end;

function TFuncoesCitelGrid.fCarregarView(grdGrid: TDBGridCitel; strChave: String): Boolean;
  Var
    strConfig : String;
begin
  Result := False;
  try
    if InterlockedIncrement(intGravandoCarregandoArquivoCfg) = 1 then
    begin

      strConfig  := fCarregarConfiguracao(strUsuarioLogado, VS_strCodEmp, strChave);

      pLoadGridLayout(grdGrid, strConfig);

      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
      Result := Not fEmptyStr(strConfig);
    end;
  Except
    On E: Exception Do
    begin
      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
    end;
  End;

end;

procedure TFuncoesCitelGrid.pLoadGridLayout(grdGrid: TDBGridCitel; strConfig: String);
  Var
    stlLines: TStringList;
    stlColumnInfo: TStringList;
    intLineCtr: integer;
    intColIdx: integer;
    intCont: integer;
begin
  Try
    stlLines := TStringList.Create;
    stlColumnInfo := TStringList.Create;
    stlLines.Text := strConfig;

    For intLineCtr := 0 To stlLines.Count-1 Do
    begin
      If (Trim(stlLines[intLineCtr]) <> '') Then
      begin
        pStringExplode(stlLines[intLineCtr], '~ ', stlColumnInfo);
        intCont := grdGrid.Columns.count;
        For intColIdx := 0 To intCont - 1 Do
        Begin
          If grdGrid.Columns[intColIdx].FieldName = stlColumnInfo[1] Then
          Begin
            grdGrid.Columns[intColIdx].Width := StrToInt(stlColumnInfo[3]);
            grdGrid.Columns[intColIdx].Title.Caption := stlColumnInfo[2];
            grdGrid.Columns[intColIdx].Index := intLineCtr;
          End;
        End;
      End;
    End;
  Finally
    FreeAndNil(stlLines);
    If assigned(stlColumnInfo) Then
      FreeAndNil(stlColumnInfo);
  End;
End;

procedure TFuncoesCitelGrid.pStringExplode(strTexto: string; strDelimiter: string; Var stlTexto: TStringList);
Begin
	stlTexto.Clear;
	stlTexto.Text := StringReplace(strTexto, strDelimiter, #13#10, [rfIgnoreCase, rfReplaceAll]);
End;

procedure TFuncoesCitelGrid.pSalvarView(grdGrid: TDBGridCitel; strChave: String);
  Var
    LCodOpe,
    LCodEmp,
    LChave_: String;
begin
  Try
    If InterlockedIncrement(intGravandoCarregandoArquivoCfg) = 1 Then
    begin

      LChave_:= strChave;
      LCodOpe := strUsuarioLogado;
      LCodEmp := VS_strCodEmp;

      fGravarConfiguracao(LCodOpe, LCodEmp, LChave_, '', grdGrid);

      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
    End;
  Except
    On E: Exception Do
    Begin
      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
    End;
  End;
end;

function TFuncoesCitelGrid.fSaveGridLayout(grdGrid: TDBGridCitel): String;
  Var
    stlArq: TStringList;
    intCont: integer;
begin

  stlArq := TStringList.Create;
  Try
    For intCont := 0 To grdGrid.Columns.count-1 Do
    Begin
      stlArq.Add(  IntToStr(grdGrid.Columns[intCont].Index)
                   + '~ ' + grdGrid.Columns[intCont].DisplayName
                   + '~ ' + grdGrid.Columns[intCont].Title.Caption
                   + '~ ' + grdGrid.Columns[intCont].Width.ToString);
    End;

		Result := stlArq.Text;
	Finally
    FreeAndNil(stlArq);
	End;
end;

function TFuncoesCitelGrid.fCarregarConfiguracao(strCodOpe, strCodEmp, strChave: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CFG_VALOR_, ';
    strSQL := strSQL + '  IFNULL(CFG_RECNO_, 1) AS CFG_RECNO_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CFGCOL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CFG_LOGOPE = :CODOPE AND ';
    strSQL := strSQL + '  CFG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CFG_CHAVE_ = :CHAVE      ';

    qryGen := fCriaQuery(Nil);
    try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('CODOPE').AsString := strCodOpe;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('CHAVE').AsString  := strChave;
      qryGen.Open;

      If Not qryGen.IsEmpty Then
        Result := qryGen.FieldByName('CFG_VALOR_').AsString
      Else Result := '';
    finally
      FreeAndNil(qryGen);
    end;
  Except
    On E: Exception Do
    Begin
      Result := '';
      pErro(E.Message);
    End;
  End;
end;

function TFuncoesCitelGrid.fGravarConfiguracao(const strCodOpe, strCodEmp,
  strChave, strValor: String; grdGrid: TDbGridCitel): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' CFG_LOGOPE, ';
    strSQL := strSQL + ' CFG_CHAVE_, ';
    strSQL := strSQL + ' CFG_VALOR_, ';
    strSQL := strSQL + ' CFG_RECNO_, ';
    strSQL := strSQL + ' CFG_CODEMP  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CFGCOL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CFG_LOGOPE = :CODOPE AND ';
    strSQL := strSQL + '  CFG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CFG_CHAVE_ = :CHAVE      ';

    Result := True;

    qryGen := fCriaQuery(Nil);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODOPE').AsString := strCodOpe;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CHAVE').AsString  := '<ABRIR_QUERY_VAZIA>';
      Open;

      Close;
      ParamByName('CODOPE').AsString := strCodOpe;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CHAVE').AsString  := strChave;
      Open;
      If IsEmpty Then
      Begin
        Insert;

        FieldByName('CFG_LOGOPE').AsString := strCodOpe;
        FieldByName('CFG_CODEMP').AsString := strCodEmp;
        FieldByName('CFG_CHAVE_').AsString := strChave;
      End
      Else
        Edit;

      If Not fEmptyStr(strValor) Then
        FieldByName('CFG_VALOR_').AsString := strValor
      Else
        FieldByName('CFG_VALOR_').AsString := fSaveGridLayout(grdGrid);

      FieldByName('CFG_RECNO_').Value := null;

      Post;
      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

initialization
  VS_ProcessId := GetCurrentProcessId.ToString;
  TFuncoesCitelGrid.objFuncoesCitelGrid := TFuncoesCitelGrid.Create;

finalization
  FreeAndNil(TFuncoesCitelGrid.objFuncoesCitelGrid);

end.

