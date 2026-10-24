unit untFuncoesCXGrid;

interface

uses
  SysUtils, cxGridCustomView, cxGridCustomTableView, cxGridDBTableView,
  StrUtils, cxControls, cxCustomData, Classes, Windows, Math, Uni,
  cxGridDBBandedTableView, IOUtils, DateUtils,
  DB, Variants, Forms, UniClientDataSet, dxCore, Shlobj, Vcl.ExtCtrls,
  untInterfacedObjectNoCount, untIFuncoesCXGrid, System.Generics.Collections;

Type
  {$M+}
  TNewTimer = class sealed
  private
    const TimeoutNever = 0;
  private
    class var FList: TDictionary<String, TNewTimer>;
    class procedure Clear();
  private
    FId: string;
    FTimer: TTimer;
    FInterval: Cardinal;
    FTimeout: Cardinal;
    FTimeoutBegin: TDateTime;
    FEnabled: Boolean;
    FEnabling: Boolean;
    FOnTimer: TNotifyEvent;
  private
    procedure OnTimerEvent(ASender: TObject);
    procedure SetTimeout(Value: Cardinal);
    procedure SetInterval(Value: Cardinal);
    procedure SetEnabled(Value: Boolean);
  published
    property Timeout: Cardinal read FTimeout write SetTimeout;
    property Interval: Cardinal read FInterval write SetInterval;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
  protected
    constructor Create(AId: String);
  public
    class function Get(AId: String): TNewTimer;
    class function Has(AId: String): Boolean;
    class function Del(AId: string): Boolean;
    destructor Destroy(); override;
  end;

  TFuncoesCXGrid = class(TInterfacedObjectNoCount, IFuncoesCXGrid)
  private
    class var objFuncoesCxGrid: TFuncoesCXGrid;

    function fCarregarConfiguracao(strCodOpe, strCodEmp, strChave: String;
       qryConsulta: TDataSet; Var intRecNo: Integer): String;
    function fGravarConfiguracao(const strCodOpe, strCodEmp, strChave, strValor: String;
      qryConsulta: TDataSet; strNomArq: String=''): Boolean;
  public
    function fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
    function fArquivoParaString(strNomArq: String): String;
    function fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
    function fGetFiltros(coluna: TcxGridDBColumn): String;
    function fGetOrdem(view: TcxGridDBTableView): String;
    function fCarregarView(view: TcxGridDBTableView; strChave: String;
      qryConsulta: TDataSet; Var intRecNo: Integer; blnPorEmpresa: Boolean = False; strPorEmpresaEUsuario: String = 'N'): Boolean; overload;
    procedure pSalvarView(view: TcxGridDBTableView; strChave: String;
      qryConsulta: TDataSet; blnPorEmpresa: Boolean = False; strPorEmpresaEUsuario: String = 'N'); overload;
    procedure pSalvarEstado(view: TcxGridDBTableView; strChave: String);
    procedure pCarregarEstado(view: TcxGridDBTableView; strChave: String);
    procedure pFocoNoFiltro(view: TcxGridDBTableView; stlCamOrd: TStringList;
      const strNomeColuna: String = ''; blnExecutarEnd: Boolean=True);
    procedure pProximoFiltro(view: TcxGridDBTableView);
    procedure pDeletarView(strChave: String; blnPorEmpresa: Boolean = False; strPorEmpresaEUsuario: String = 'N');
    procedure pSalvarView(view: TcxGridDBBandedTableView; strChave: String;
      qryConsulta: TDataSet; blnPorEmpresa: Boolean = False; strPorEmpresaEUsuario: String = 'N'); overload;
    function fCarregarView(view: TcxGridDBBandedTableView; strChave: String;
      qryConsulta: TDataSet; Var intRecNo: Integer; blnPorEmpresa: Boolean = False; strPorEmpresaEUsuario: String = 'N'): Boolean; overload;
  End;

  function fGetFuncoesCxGrid: IFuncoesCXGrid; StdCall;

  function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;

Var
  intGravandoCarregandoArquivoCfg: Integer;

implementation

uses untFuncoesGen;

var
  VS_ProcessId: string;

function fGetFuncoesCxGrid: IFuncoesCXGrid;
begin
  Result := TFuncoesCXGrid.objFuncoesCxGrid;
end;

{ TNewTimer }

class procedure TNewTimer.Clear;
Var
  LObj: TNewTimer;
begin
  For LObj In FList.Values Do
    LObj.Destroy;
  FList.Clear;
end;

constructor TNewTimer.Create(AId: String);
begin
  FId := AId;
  FTimeout := TimeoutNever;
  FTimeoutBegin := fTime(True);
  FInterval := 1000;
  FEnabled := False;
  FEnabling := False;
  FOnTimer := nil;
  FTimer := TTimer.Create(nil);
  FTimer.OnTimer := Self.OnTimerEvent;
  FTimer.Enabled := True;
end;

destructor TNewTimer.Destroy;
begin
  FTimer.Enabled := False;
  FreeAndNil(FTimer);
  inherited;
end;

class function TNewTimer.Get(AId: String): TNewTimer;
begin
  If Not FList.ContainsKey(AId) Then
    FList.Add(AId, TNewTimer.Create(AId));
  Result := FList.Items[AId];
end;

class function TNewTimer.Has(AId: String): Boolean;
begin
  Result := FList.ContainsKey(AId);
end;

procedure TNewTimer.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  FEnabling := Value;
  FTimeoutBegin := fTime(True);
end;

procedure TNewTimer.SetInterval(Value: Cardinal);
begin
  FInterval := Value;
  If FInterval <> FTimer.Interval Then
    FTimer.Interval := FInterval;
  FTimeoutBegin := fTime(True);
end;

procedure TNewTimer.SetTimeout(Value: Cardinal);
begin
  FTimeout := Value;
  FTimeoutBegin := fTime(True);
end;

procedure TNewTimer.OnTimerEvent(ASender: TObject);
begin
{$IFDEF TIMERLOG}
  try
    if FileExists(VS_ProcessId + '.tmr') then
      TFile.AppendAllText(VS_ProcessId + '.tmr', DateTimeToStr(Now()) + ' - ' + Self.FId + sLineBreak);
  except
  end;
{$ENDIF}

  If FTimeout <> TimeoutNever Then
    If MilliSecondsBetween(fTime(True), FTimeoutBegin) > FTimeout Then
    Begin
      TNewTimer.Del(FId);
      Exit;
    End;

  If Not Self.Enabled Then
    Exit;

  If Not Assigned(Self.OnTimer) Then
    Exit;

  If fConexaoAtivaGen And fInTransactionGen Then
    Exit;

  If Self.FEnabling Then
  Begin
    Self.FEnabling := False;
    Exit;
  End;

  Try
    Self.OnTimer(nil);
  Except
    On E: Exception Do
    Begin
      Self.Enabled := False;
      Raise;
    End;
  End;
end;

class function TNewTimer.Del(AId: string): Boolean;
begin
  If Not FList.ContainsKey(AId) Then
    Exit(False);
  FList[AId].Free;
  FList.Remove(AId);
  Result := True;
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

procedure TFuncoesCXGrid.pDeletarView(strChave: String; blnPorEmpresa: Boolean = False; strPorEmpresaEUsuario: String = 'N');
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
              ' WHERE '+
              '   CFG_CHAVE_ = :CHAVE_ AND ';

    if strPorEmpresaEUsuario = 'S' then
      strSQL := strSQL + 'CFG_CODEMP = :CODEMP AND CFG_LOGOPE = :CODOPE'
    else if blnPorEmpresa then
      strSQL := strSQL + 'CFG_CODEMP = :CODEMP'
    else
      strSQL := strSQL + 'CFG_LOGOPE = :CODOPE';

    qryCfgCol.Close;
    qryCfgCol.SQL.Text := strSQL;

    qryCfgCol.ParamByName('CHAVE_').AsString := strChave;
    if strPorEmpresaEUsuario = 'S' then
    begin
      qryCfgCol.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCfgCol.ParamByName('CODOPE').AsString := strUsuarioLogado;
    end
    else if blnPorEmpresa then
      qryCfgCol.ParamByName('CODEMP').AsString := VS_strCodEmp
    else
      qryCfgCol.ParamByName('CODOPE').AsString := strUsuarioLogado;

    qryCfgCol.ExecSql;
  finally
    FreeAndNil(qryCfgCol);
  end;
end;

function TFuncoesCXGrid.fCarregarView(view: TcxGridDBTableView; strChave: String;
  qryConsulta: TDataSet; Var intRecNo: Integer; blnPorEmpresa: Boolean = False;
  strPorEmpresaEUsuario: String = 'N'): Boolean;
  Var
    strArqTemp: String;
    strConfig : String;
begin
  Result := False;
  try
    if InterlockedIncrement(intGravandoCarregandoArquivoCfg) = 1 then
    begin
      strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);

      If strPorEmpresaEUsuario = 'S' Then
        strConfig  := fCarregarConfiguracao(strUsuarioLogado, VS_strCodEmp, strChave, qryConsulta, intRecNo)
      Else If blnPorEmpresa Then
        strConfig  := fCarregarConfiguracao('', VS_strCodEmp, strChave, qryConsulta, intRecNo)
      Else
        strConfig  := fCarregarConfiguracao(strUsuarioLogado, '', strChave, qryConsulta, intRecNo);

      fEscreverNoArquivo(strArqTemp, strConfig);
      view.RestoreFromIniFile(strArqTemp);
      DeleteFile(PChar(strArqTemp));
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

function TFuncoesCXGrid.fCarregarView(view: TcxGridDBBandedTableView; strChave: String;
  qryConsulta: TDataSet; Var intRecNo: Integer; blnPorEmpresa: Boolean = False;
  strPorEmpresaEUsuario: String = 'N'): Boolean;
  Var
    strArqTemp: String;
    strConfig : String;
begin
  Result := False;
  try
    if InterlockedIncrement(intGravandoCarregandoArquivoCfg) = 1 then
    begin
      strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);

      If strPorEmpresaEUsuario = 'S' Then
        strConfig  := fCarregarConfiguracao(strUsuarioLogado, VS_strCodEmp, strChave, qryConsulta, intRecNo)
      Else If blnPorEmpresa Then
        strConfig  := fCarregarConfiguracao('', VS_strCodEmp, strChave, qryConsulta, intRecNo)
      Else
        strConfig  := fCarregarConfiguracao(strUsuarioLogado, '', strChave, qryConsulta, intRecNo);

      fEscreverNoArquivo(strArqTemp, strConfig);
      view.RestoreFromIniFile(strArqTemp);
      DeleteFile(PChar(strArqTemp));
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

procedure TFuncoesCXGrid.pSalvarEstado(view: TcxGridDBTableView; strChave: String);
begin
  view.StoreToRegistry(strChave, True, [gsoUseFilter, gsoUseSummary]);
end;

procedure TFuncoesCXGrid.pSalvarView(view: TcxGridDBTableView; strChave: String; qryConsulta: TDataSet;
  blnPorEmpresa: Boolean = False; strPorEmpresaEUsuario: String = 'N');
  Var
    LCodOpe,
    LCodEmp,
    LChave_,
    strArqTemp: String;
begin
  Try
    If InterlockedIncrement(intGravandoCarregandoArquivoCfg) = 1 Then
    begin
      strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);
      view.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

      LChave_:= strChave;
      iF strPorEmpresaEUsuario = 'S' Then
      Begin
        LCodOpe := strUsuarioLogado;
        LCodEmp := VS_strCodEmp;
      End
      Else If blnPorEmpresa Then
      Begin
        LCodOpe := '';
        LCodEmp := VS_strCodEmp;
      End
      Else
      Begin
        LCodOpe := strUsuarioLogado;
        LCodEmp := '';
      End;

      fGravarConfiguracao(LCodOpe, LCodEmp, LChave_, '', qryConsulta, strArqTemp);

      DeleteFile(PChar(strArqTemp));

      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
    End;
  Except
    On E: Exception Do
    Begin
      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
    End;
  End;
end;

procedure TFuncoesCXGrid.pSalvarView(view: TcxGridDBBandedTableView; strChave: String; qryConsulta: TDataSet;
  blnPorEmpresa: Boolean = False; strPorEmpresaEUsuario: String = 'N');
  Var
    LCodOpe,
    LCodEmp,
    LChave_,
    strArqTemp: String;
begin
  Try
    If InterlockedIncrement(intGravandoCarregandoArquivoCfg) = 1 Then
    begin
      strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);
      view.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

      LChave_:= strChave;
      iF strPorEmpresaEUsuario = 'S' Then
      Begin
        LCodOpe := strUsuarioLogado;
        LCodEmp := VS_strCodEmp;
      End
      Else If blnPorEmpresa Then
      Begin
        LCodOpe := '';
        LCodEmp := VS_strCodEmp;
      End
      Else
      Begin
        LCodOpe := strUsuarioLogado;
        LCodEmp := '';
      End;

      fGravarConfiguracao(LCodOpe, LCodEmp, LChave_, '', qryConsulta, strArqTemp);

      DeleteFile(PChar(strArqTemp));

      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
    End;
  Except
    On E: Exception Do
    Begin
      InterlockedDecrement(intGravandoCarregandoArquivoCfg);
    End;
  End;
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

function TFuncoesCXGrid.fCarregarConfiguracao(strCodOpe, strCodEmp, strChave: String;
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
      Begin
        Result := qryGen.FieldByName('CFG_VALOR_').AsString;

        If Not qryGen.FieldByName('CFG_RECNO_').IsNull Then
        Begin
          intRecNo := qryGen.FieldByName('CFG_RECNO_').AsInteger;

          If (Not qryConsulta.IsEmpty) And (qryConsulta.RecordCount >= qryGen.FieldByName('CFG_RECNO_').AsInteger) Then
            qryConsulta.RecNo := qryGen.FieldByName('CFG_RECNO_').AsInteger;
        End;
      End
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

function TFuncoesCXGrid.fGravarConfiguracao(const strCodOpe, strCodEmp,
  strChave, strValor: String; qryConsulta: TDataSet; strNomArq: String=''): Boolean;
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

      If fEmptyStr(strNomArq) Then
        FieldByName('CFG_VALOR_').AsString := strValor
      Else
        FieldByName('CFG_VALOR_').AsString := fArquivoParaString(strNomArq); 

      If qryConsulta.Active And Not qryConsulta.IsEmpty Then
        FieldByName('CFG_RECNO_').Value := qryConsulta.RecNo
      Else
        FieldByName('CFG_RECNO_').Value := null;

      Post;
      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
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

initialization
  VS_ProcessId := GetCurrentProcessId.ToString;
  TFuncoesCXGrid.objFuncoesCxGrid := TFuncoesCxGrid.Create;
  TNewTimer.FList := TDictionary<String, TNewTimer>.Create;

finalization
  FreeAndNil(TFuncoesCXGrid.objFuncoesCxGrid);
  TNewTimer.Clear;
  FreeAndNil(TNewTimer.FList);

end.

