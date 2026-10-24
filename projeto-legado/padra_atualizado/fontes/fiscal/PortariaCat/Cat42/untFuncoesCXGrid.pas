unit untFuncoesCXGrid;

interface

uses
  SysUtils, cxGridCustomView, cxGridCustomTableView, cxGridDBTableView,
  StrUtils, cxControls, cxCustomData, Classes, Windows, Math, Uni,
  DB, Variants, Forms, UniClientDataSet, dxCore, Shlobj,
  untInterfacedObjectNoCount, untIFuncoesCXGrid;

Type
  TFuncoesCXGrid = class(TInterfacedObjectNoCount, IFuncoesCXGrid)
  private
    class var objFuncoesCxGrid: IFuncoesCXGrid;

    function fCarregarConfiguracaoOperador(strCodOpe, strChave: String;
       qryConsulta: TDataSet; Var intRecNo: Integer): String;
    function fGravarConfiguracaoOperador(strCodOpe, strChave, strValor: String;
      qryConsulta: TDataSet): Boolean;
  public
    function fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
    function fArquivoParaString(strNomArq: String): String;
    function fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
    function fGetFiltros(coluna: TcxGridDBColumn): String;
    function fGetOrdem(view: TcxGridDBTableView): String;
    function fCarregarView(view: TcxGridDBTableView; strChave: String;
      qryConsulta: TDataSet; Var intRecNo: Integer): Boolean;
    procedure pSalvarView(view: TcxGridDBTableView; strChave: String; qryConsulta: TDataSet);
    procedure pSalvarEstado(view: TcxGridDBTableView; strChave: String);
    procedure pCarregarEstado(view: TcxGridDBTableView; strChave: String);
    procedure pFocoNoFiltro(view: TcxGridDBTableView; stlCamOrd: TStringList;
      const strNomeColuna: String = ''; blnExecutarEnd: Boolean=True);
    procedure pProximoFiltro(view: TcxGridDBTableView);
  End;

  function fGetFuncoesCxGrid: IFuncoesCXGrid; StdCall;

  function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;

Var
  intGravandoArquivo: Integer;

implementation

uses untFuncoesConsulta,
     untFuncoes;

function fGetFuncoesCxGrid: IFuncoesCXGrid;
begin
  If Not Assigned(TFuncoesCXGrid.objFuncoesCxGrid) Then
  Begin
    TFuncoesCXGrid.objFuncoesCxGrid := TFuncoesCxGrid.Create;
  End;

  Result := TFuncoesCXGrid.objFuncoesCxGrid;
end;

{ TFuncoesCXGrid }

function TFuncoesCXGrid.fArquivoParaString(strNomArq: String): String;
  Var
    stlArq: TStringList;
begin
  Try
    stlArq := TStringList.Create;
    stlArq.LoadFromFile(strNomArq);
    Result := stlArq.Text;
  Except
    Result := '';
  End;

  FreeAndNil(stlArq);
end;

function TFuncoesCXGrid.fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
  Var
    Arquivo: TextFile;
begin
  Result := True;

  Try

    If Not FileExists(strNomArq) Then
    Begin
      Result := False;
    End
    Else
    Begin
      AssignFile(Arquivo, strNomArq);
      Rewrite(Arquivo);
      Write(Arquivo, strTexto);
    End;

  Finally
    CloseFile(Arquivo);
  End;
end;

function TFuncoesCXGrid.fGetFiltros(coluna: TcxGridDBColumn): String;
  Var
    lista: TcxGridFilterValueList;
    itensAtivos: TcxGridIndexes;
    intCont: Integer;
begin
  Result := '';
  lista := TcxGridFilterValueList.Create(coluna.DataBinding.Filter);
  coluna.DataBinding.GetFilterValues(lista);
  coluna.DataBinding.GetFilterActiveValueIndexes(lista, itensAtivos);
  For intCont := 0 To Length(itensAtivos) - 1 Do
  Begin
    Result := Result + ' ' + lista.Items[itensAtivos[intCont]].DisplayText + ',';
  End;

  Result := Trim(Result);
  Result := Copy(Result, 0, Length(Result) - 1);
end;

function TFuncoesCXGrid.fGetOrdem(view: TcxGridDBTableView): String;
  Var
    intCont: Integer;
begin
  If view.SortedItemCount > 0 Then
  Begin
    Result := '';
    For intCont := 0 To view.SortedItemCount - 1 Do
    Begin
      Result := Result + ' ' +
        view.SortedItems[intCont].DataBinding.FilterFieldName +
        IfThen(view.SortedItems[intCont].SortOrder = soDescending, ' DESC');
    End;
  End;
end;

procedure TFuncoesCXGrid.pCarregarEstado(view: TcxGridDBTableView; strChave: String);
begin
  view.RestoreFromRegistry(strChave);
  view.ApplyBestFit;
end;

function TFuncoesCXGrid.fCarregarView(view: TcxGridDBTableView; strChave: String;
  qryConsulta: TDataSet; Var intRecNo: Integer): Boolean;
  Var
    strArqTemp: String;
    strConfig : String;
begin
  Result := False;
  try
    if InterlockedIncrement(intGravandoArquivo) = 1 then
    begin
      strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);
      strConfig  := fCarregarConfiguracaoOperador('998', strChave, qryConsulta, intRecNo);
      fEscreverNoArquivo(strArqTemp, strConfig);
      view.RestoreFromIniFile(strArqTemp);
      DeleteFile(PChar(strArqTemp));
      InterlockedDecrement(intGravandoArquivo);
      Result := Not fEmptyStr(strConfig);
    end;
  Except
    On E: Exception Do
    begin
      InterlockedDecrement(intGravandoArquivo);
    end;
  End;

end;

procedure TFuncoesCXGrid.pSalvarEstado(view: TcxGridDBTableView; strChave: String);
begin
  view.StoreToRegistry(strChave, True, [gsoUseFilter, gsoUseSummary]);
end;

procedure TFuncoesCXGrid.pSalvarView(view: TcxGridDBTableView; strChave: String; qryConsulta: TDataSet);
  Var
    strArqTemp: String;
begin
  strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);
  view.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);
  fGravarConfiguracaoOperador('998', strChave, fArquivoParaString(strArqTemp), qryConsulta);
  DeleteFile(PChar(strArqTemp));
end;

 function TFuncoesCXGrid.fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
  Var
    Caminho  : PChar;
    Arquivo  : file;
    strDirVal: String;
begin
  Result := '';

  Try
    If fEmptyStr(strPathTmp) Then
    Begin
      strDirVal := GetSpecialFolderPath(CSIDL_APPDATA, False) + '\Autcom\';

      If Not DirectoryExists(strDirVal) Then
        CreateDir(strDirVal);

      Caminho := PChar(strDirVal);
    End
    Else
      Caminho := PChar(strPathTmp);

    If fEmptyStr(strNomArq) Then
    Begin
      Result := Caminho + IntToStr(RandomRange(0, 9999));

      While FileExists(Result) Do
      Begin
        Result := Caminho + IntToStr(RandomRange(0, 9999));
      End;
    End
    Else
    Begin
      Result := Caminho + strNomArq;
    End;

    AssignFile(Arquivo, Result);
    Rewrite(Arquivo);

  Finally
    CloseFile(Arquivo);
  End;
end;

function TFuncoesCXGrid.fCarregarConfiguracaoOperador(strCodOpe, strChave: String;
  qryConsulta: TDataSet; Var intRecNo: Integer): String;
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
    strSQL := strSQL + '  CFG_CHAVE_ = :CHAVE  AND ';
    strSQL := strSQL + '  CFG_RECNO_ IS NOT NULL   ';

    qryGen := fCriaQuery(Nil);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodOpe;
      ParamByName('CHAVE').AsString := strChave;
      Open;

      If Not IsEmpty Then
      Begin
        Result := FieldByName('CFG_VALOR_').AsString;

        intRecNo := FieldByName('CFG_RECNO_').AsInteger;

        If (Not qryConsulta.IsEmpty) And (qryConsulta.RecordCount >= FieldByName('CFG_RECNO_').AsInteger) Then
          qryConsulta.RecNo := FieldByName('CFG_RECNO_').AsInteger;
      End
      Else Result := '';

    End;
  Except
    On E: Exception Do
    Begin
      Result := '';
      pErro(E.Message);
    End;
  End;
  FreeAndNil(qryGen);
end;

function TFuncoesCXGrid.fGravarConfiguracaoOperador(strCodOpe, strChave, strValor: String; qryConsulta: TDataSet): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + ' * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CFGCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CFG_LOGOPE = :CODOPE AND ';
  strSQL := strSQL + '  CFG_CHAVE_ = :CHAVE      ';

  Result := True;

  qryGen := fCriaQuery(Nil);
  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString := strCodOpe;
    ParamByName('CHAVE').AsString := strChave;
    Open;
    If IsEmpty Then
    Begin
      Insert;
      FieldByName('CFG_LOGOPE').AsString := strCodOpe;
      FieldByName('CFG_CHAVE_').AsString := strChave;
    End
    Else
      Edit;

    FieldByName('CFG_VALOR_').AsString := strValor;

    If Not qryConsulta.IsEmpty Then
      FieldByName('CFG_RECNO_').Value := qryConsulta.RecNo
    Else
      FieldByName('CFG_RECNO_').Value := null;
    Post;
    Close;
  End;
  FreeAndNil(qryGen);
end;

procedure TFuncoesCXGrid.pFocoNoFiltro(view: TcxGridDBTableView; stlCamOrd: TStringList;
  const strNomeColuna: String = ''; blnExecutarEnd: Boolean=True);
  Var
    intIndice: Integer;
    strNomeColunaFocus: String;
Begin
  Try
    // SE NAO TIVER ORDENACAO
    If view.SortedItemCount = 0 Then
      For intIndice := 0 To stlCamOrd.Count - 1 Do
        view.GetColumnByFieldName(stlCamOrd[intIndice]).SortOrder := soAscending;

    If fEmptyStr(strNomeColuna) Then
      strNomeColunaFocus := view.SortedItems[0].DataBinding.FilterFieldName
    Else
      strNomeColunaFocus := strNomeColuna;

    view.ViewData.FilterRow.Focused := True;
    view.Controller.FocusedColumn := view.GetColumnByFieldName(strNomeColunaFocus);

    Keybd_Event(VK_F2, 0, 0, 0);

    If blnExecutarEnd Then
      Keybd_Event(VK_END, 0, 0, 0);

  Except

  End;

End;

procedure TFuncoesCXGrid.pProximoFiltro(view: TcxGridDBTableView);
  Var
    intIndice,
    intContador: Integer;
    strNomeColunaFocus: String;
Begin
  intIndice := 0;

  If Not Assigned(view.Controller.FocusedColumn) Then
    Exit;

  strNomeColunaFocus := view.Controller.FocusedColumn.Name;

  For intContador := 0 To view.SortedItemCount - 1 Do
    If SameText(strNomeColunaFocus, view.SortedItems[intContador].name) Then
    Begin
      intIndice := intContador;
      Break;
    End;

  If view.SortedItemCount <= 0 Then
    Exit;

  If intIndice = view.SortedItemCount - 1 Then
    intIndice := 0
  Else
    intIndice := Succ(intIndice);

  strNomeColunaFocus := view.SortedItems[intIndice].DataBinding.FilterFieldName;
  view.Controller.FocusedColumn := view.GetColumnByFieldName(strNomeColunaFocus);
  Keybd_Event(VK_F2, 0, 0, 0);
  Keybd_Event(VK_END, 0, 0, 0);

End;

function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;
  Var
    FilePath: array [0..255] of Char;
Begin
  SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
  Result := FilePath;
End;

end.
