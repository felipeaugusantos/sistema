unit untSalvaConfiguracaoGrid;

interface

Uses
  cxGrid, cxGridCustomView, cxGridDBTableView, Uni, UniClientDataSet, IniFiles,
  cxGridBandedTableView,
  untFuncoesSimples, Shlobj, Math, System.SysUtils,
  System.Classes, Winapi.Windows, Data.DB, cxDBVGrid, DBGridCitel, System.Json, Vcl.DBGrids;

Type

  TSalvaConfiguracaoGrid = Class

  public

    Class Procedure pSalvaConfiguracoesGrid(cxvViewGrid: TcxGridDBTableView; strNomFrm: String); Overload;
    Class Procedure pSalvaConfiguracoesGrid(cxvViewGrid: TcxGridBandedTableView; strNomFrm: String); Overload;
    Class Procedure pSalvaConfiguracoesGrid(cxvViewGrid: TcxDBVerticalGrid; strNomFrm: String); Overload;
    Class Procedure pSalvaConfiguracoesDbGrid(dbGrid: TDBGridCitel; strNomFrm: String);

    Class Procedure pCarregaConfiguracoesGrid(cxvViewGrid: TcxGridDBTableView; strNomFrm: String) Overload;
    Class Procedure pCarregaConfiguracoesGrid(cxvViewGrid: TcxGridBandedTableView; strNomFrm: String) Overload;
    Class Procedure pCarregaConfiguracoesGrid(cxvViewGrid: TcxDBVerticalGrid; strNomFrm: String) Overload;
    Class Procedure pCarregaConfiguracoesDbGrid(dbGrid: TDBGridCitel; strNomFrm: String; blnDefaultVisibleIntensNovos: Boolean = False);


    Class Function fExisteRegistro(strNomFrm: String): Boolean;
    Class Function fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
    Class function fGetPathTempOpcoesLocais: String;
    Class function fArquivoParaString(strNomArq: String): String;
    Class function fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;

    Class Procedure pApagaConfiguracoes(strNomFrm: String);

  End;

implementation

{ TSalvaConfiguracaoGrid }

class function TSalvaConfiguracaoGrid.fArquivoParaString(strNomArq: String): String;
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

class function TSalvaConfiguracaoGrid.fCriarArquivoTemporario(strNomArq, strPathTmp: String): String;
Var
  Caminho  : PChar;
  Arquivo  : file;
  strDirVal: String;

  function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;
    Var
      FilePath: array [0..255] of Char;
  Begin
    SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
    Result := FilePath;
  End;

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
      Result := Caminho + IntToStr(RandomRange(0, 99999));

      While FileExists(Result) Do
      Begin
        Result := Caminho + IntToStr(RandomRange(0, 99999));
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

class function TSalvaConfiguracaoGrid.fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
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

class function TSalvaConfiguracaoGrid.fExisteRegistro(strNomFrm: String): Boolean;
var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    With qryGen, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM CFGGRD');
      Add('WHERE ');
      Add('  GRD_NOMFRM = :NOMFRM');
      Add('  AND GRD_CODOPE = :CODOPE');

      ParamByName('NOMFRM').AsString := strNomFrm;
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      Open;
      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryGen)
  End;
End;

class function TSalvaConfiguracaoGrid.fGetPathTempOpcoesLocais: String;
  Var
    Buffer: Array[0..254] Of Char;
    strPatIni: String;
    iniArqIni : TIniFile;
begin
  Result := '';
  GetWindowsDirectory(Buffer, 255);
  strPatIni := StrPas(Buffer) + '\OPCOES_LOCAIS.INI';
  If FileExists(strPatIni) Then
  Begin
    iniArqIni := TIniFile.Create(strPatIni);
    Try
      Result := iniArqIni.ReadString('ARQUIVOS_TEMPORARIOS', 'PATH' , Result)
    Finally
      iniArqIni.Free;
    End;
  End;
end;

Class Procedure TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvViewGrid: TcxGridBandedTableView; strNomFrm: String) Overload;
  Var
    qryGen: TUniQuery;
    strArqTemp: String;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM CFGGRD');
    Add('WHERE ');
    Add('  GRD_NOMFRM = :NOMFRM');
    Add('  AND GRD_CODOPE = :CODOPE');

    ParamByName('NOMFRM').AsString := strNomFrm;
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Open;

    If Not IsEmpty Then
    Begin
      strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);
      If fEscreverNoArquivo(strArqTemp, FieldByName('GRD_CFGGRD').AsString) Then
      Begin
        cxvViewGrid.RestoreFromIniFile(strArqTemp);
        DeleteFile(PChar(strArqTemp));
      End;
    End;
  End;
  FreeAndNil(qryGen);
end;

class procedure TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvViewGrid: TcxGridDBTableView; strNomFrm: String) overload;
  Var
    qryGen: TUniQuery;
    strArqTemp: String;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM CFGGRD');
    Add('WHERE ');
    Add('  GRD_NOMFRM = :NOMFRM');
    Add('  AND GRD_CODOPE = :CODOPE');

    ParamByName('NOMFRM').AsString := strNomFrm;
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Open;

    If Not IsEmpty Then
    Begin
      strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);
      If fEscreverNoArquivo(strArqTemp, FieldByName('GRD_CFGGRD').AsString) Then
      Begin
        cxvViewGrid.RestoreFromIniFile(strArqTemp);
        DeleteFile(PChar(strArqTemp));
      End;
    End;
  End;
  FreeAndNil(qryGen);
end;

Class Procedure TSalvaConfiguracaoGrid.pCarregaConfiguracoesDbGrid(dbGrid: TDBGridCitel; strNomFrm: String; blnDefaultVisibleIntensNovos: Boolean = False);
var
  qryGen: TUniQuery;
  idxCol, i,x , intColQtd: Integer;
  IniFile : TIniFile;
  strArqTemp : String;
  lDBGridColumns: TDBGridColumns;

  function fFindIndexByFieldName(AName: string): integer;
   var indexCol: integer;
  begin
    Result := -1;
    For indexCol := 0 To dbGrid.Columns.Count - 1 do
    begin
      If dbGrid.Columns[indexCol].FieldName =  AName then
        Exit(indexCol);
    End;

  End;
Begin

  qryGen := fCriaQuery;

  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT * FROM CFGGRD');
  qryGen.SQL.Add('WHERE ');
  qryGen.SQL.Add('  GRD_NOMFRM = :NOMFRM');
  qryGen.SQL.Add('  AND GRD_CODOPE = :CODOPE');

  qryGen.ParamByName('NOMFRM').AsString := strNomFrm;
  qryGen.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

  Try

    qryGen.Open;

    If Not qryGen.IsEmpty Then
    Begin

      strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);

      If fEscreverNoArquivo(strArqTemp, qryGen.FieldByName('GRD_CFGGRD').AsString) Then
      Begin

        Try
          IniFile := TIniFile.Create(strArqTemp);

          intColQtd := dbGrid.Columns.Count;

          If intColQtd > 0 then
          Begin
            lDBGridColumns := TDBGridColumns.Create(nil, TColumn);
            lDBGridColumns.Assign(dbGrid.Columns);

            dbGrid.Columns.Clear;
            for i := 0 to intColQtd - 1 do
            Begin
              dbGrid.Columns.Add.FieldName := IniFile.ReadString(dbGrid.Name, 'Col' + IntToStr(i), '');
              dbGrid.Columns[i].Width := IniFile.ReadInteger(dbGrid.Name, 'Width' + IntToStr(i), 0);
              dbGrid.Columns[i].Title.Caption := IniFile.ReadString(dbGrid.Name, 'Title' + IntToStr(i), '');
              dbGrid.Columns[i].ReadOnly := IniFile.ReadBool(dbGrid.Name, 'ReadOnly' + IntToStr(i), True);
              dbGrid.Columns[i].Visible := IniFile.ReadBool(dbGrid.Name, 'Visible' + IntToStr(i), True)
            End;

            For i := 0 To lDBGridColumns.Count -1 do
            begin
              x := fFindIndexByFieldName(lDBGridColumns[i].FieldName);
              If x = -1 then
              begin
                dbGrid.Columns.Add.FieldName := lDBGridColumns[i].FieldName;
                idxCol := dbGrid.Columns.Count -1;
                dbGrid.Columns[idxCol].Width := lDBGridColumns[i].Width;
                dbGrid.Columns[idxCol].Title.Caption := lDBGridColumns[i].Title.Caption;
                dbGrid.Columns[idxCol].ReadOnly := lDBGridColumns[i].ReadOnly;
                dbGrid.Columns[idxCol].Visible := blnDefaultVisibleIntensNovos;
              End;
            End;

            FreeAndNil(lDBGridColumns);
          End;

        Finally
          DeleteFile(PChar(strArqTemp));
          FreeAndNil(IniFile);
        End;

      End;

    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

Class Procedure TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvViewGrid: TcxGridBandedTableView; strNomFrm: String);
  Var
    qryGen: TUniQuery;
    strArqTemp: String;
Begin
  strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);
  cxvViewGrid.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM CFGGRD');
    Add('WHERE ');
    Add('  GRD_NOMFRM = :NOMFRM');
    Add('  AND GRD_CODOPE = :CODOPE');

    ParamByName('NOMFRM').AsString := strNomFrm;
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Open;

    If IsEmpty Then
    Begin
      qryGen.Insert;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGGRD', VS_strCodEmp);
    End Else
    Begin
      Edit;
    End;

    FieldByName('GRD_CFGGRD').AsString := fArquivoParaString(strArqTemp);
    FieldByName('GRD_NOMFRM').AsString := strNomFrm;
    FieldByName('GRD_CODOPE').AsString := strLoginUsuarioLogado;

    Post;

    DeleteFile(PChar(strArqTemp));
  End;
  FreeAndNil(qryGen);
end;

class procedure TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvViewGrid: TcxGridDBTableView; strNomFrm: String) overload;
  Var
    qryGen: TUniQuery;
    strArqTemp: String;
Begin
  strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);
  cxvViewGrid.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM CFGGRD');
    Add('WHERE ');
    Add('  GRD_NOMFRM = :NOMFRM');
    Add('  AND GRD_CODOPE = :CODOPE');

    ParamByName('NOMFRM').AsString := strNomFrm;
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Open;

    If IsEmpty Then
    Begin
      qryGen.Insert;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGGRD', VS_strCodEmp);
    End Else
    Begin
      Edit;
    End;

    FieldByName('GRD_CFGGRD').AsString := fArquivoParaString(strArqTemp);
    FieldByName('GRD_NOMFRM').AsString := strNomFrm;
    FieldByName('GRD_CODOPE').AsString := strLoginUsuarioLogado;
    Post;

    DeleteFile(PChar(strArqTemp));
  End;
  FreeAndNil(qryGen);
end;

Class Procedure TSalvaConfiguracaoGrid.pSalvaConfiguracoesDbGrid(dbGrid: TDBGridCitel; strNomFrm: String);
var
  qryGen: TUniQuery;
  i: Integer;
  IniFile : TIniFile;
  strCaminhoArq : String;
  strArqTemp : TStringList;
Begin
  Try
    strCaminhoArq := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);
    IniFile := TIniFile.Create(strCaminhoArq);

    IniFile.WriteInteger(dbGrid.Name, 'Columns', dbGrid.Columns.Count);

    for i := 0 to dbGrid.Columns.Count - 1 do
    Begin
      IniFile.WriteString(dbGrid.Name, 'Col' + IntToStr(i), dbGrid.Columns[i].FieldName);
      IniFile.WriteInteger(dbGrid.Name, 'Width' + IntToStr(i), dbGrid.Columns[i].Width);
      IniFile.WriteString(dbGrid.Name, 'Title' + IntToStr(i), dbGrid.Columns[i].Title.Caption);
      IniFile.WriteBool(dbGrid.Name, 'ReadOnly' + IntToStr(i), dbGrid.Columns[i].ReadOnly);
      IniFile.WriteBool(dbGrid.Name, 'Visible' + IntToStr(i), dbGrid.Columns[i].Visible);
    End;

    Try
      strArqTemp := TStringList.Create();
      strArqTemp.LoadFromFile(strCaminhoArq);

      qryGen := fCriaQuery;

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT * FROM CFGGRD');
      qryGen.SQL.Add('WHERE ');
      qryGen.SQL.Add('  GRD_NOMFRM = :NOMFRM');
      qryGen.SQL.Add('  AND GRD_CODOPE = :CODOPE');

      qryGen.ParamByName('NOMFRM').AsString := strNomFrm;
      qryGen.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.Insert;
        qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGGRD', VS_strCodEmp);
      End Else
      Begin
        qryGen.Edit;
      End;

      qryGen.FieldByName('GRD_CFGGRD').AsString := strArqTemp.Text;
      qryGen.FieldByName('GRD_NOMFRM').AsString := strNomFrm;
      qryGen.FieldByName('GRD_CODOPE').AsString := strLoginUsuarioLogado;

      qryGen.Post;

    Finally
      FreeAndNil(qryGen);
      FreeAndNil(strArqTemp);
    End;

  Finally
    DeleteFile(PChar(strCaminhoArq));
    FreeAndNil(IniFile);
  End;
end;

Class Procedure TSalvaConfiguracaoGrid.pApagaConfiguracoes(strNomFrm: String);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add('DELETE FROM CFGGRD');
    Add('WHERE ');
    Add('  GRD_NOMFRM = :NOMFRM');
    Add('  AND GRD_CODOPE = :CODOPE');

    ParamByName('NOMFRM').AsString := strNomFrm;
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    ExecSQL;
  End;

  FreeAndNil(qryGen);
End;


class procedure TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(
  cxvViewGrid: TcxDBVerticalGrid; strNomFrm: String);
  Var
    qryGen: TUniQuery;
    strArqTemp: String;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM CFGGRD');
    Add('WHERE ');
    Add('  GRD_NOMFRM = :NOMFRM');
    Add('  AND GRD_CODOPE = :CODOPE');

    ParamByName('NOMFRM').AsString := strNomFrm;
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Open;

    If Not IsEmpty Then
    Begin
      strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);
      If fEscreverNoArquivo(strArqTemp, FieldByName('GRD_CFGGRD').AsString) Then
      Begin
        cxvViewGrid.RestoreFromIniFile(strArqTemp);
        DeleteFile(PChar(strArqTemp));
      End;
    End;
  End;
  FreeAndNil(qryGen);
end;

class procedure TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(
  cxvViewGrid: TcxDBVerticalGrid; strNomFrm: String);
  Var
    qryGen: TUniQuery;
    strArqTemp: String;
Begin
  strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);
  cxvViewGrid.StoreToIniFile(strArqTemp, True);

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM CFGGRD');
    Add('WHERE ');
    Add('  GRD_NOMFRM = :NOMFRM');
    Add('  AND GRD_CODOPE = :CODOPE');

    ParamByName('NOMFRM').AsString := strNomFrm;
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Open;

    If IsEmpty Then
    Begin
      qryGen.Insert;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGGRD', VS_strCodEmp);
    End Else
    Begin
      Edit;
    End;

    FieldByName('GRD_CFGGRD').AsString := fArquivoParaString(strArqTemp);
    FieldByName('GRD_NOMFRM').AsString := strNomFrm;
    FieldByName('GRD_CODOPE').AsString := strLoginUsuarioLogado;
    Post;

    DeleteFile(PChar(strArqTemp));
  End;
  FreeAndNil(qryGen);
end;


end.
