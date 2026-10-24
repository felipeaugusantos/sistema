{ ****************************************************************************** }
{ TELA QUE EXIBE O LOG DO TRACE EM UMA TELA SEMPRE POR CIMA DAS OUTRAS. }
{ PARA ATIVAR, BASTA INICIAR O AUTCOM COM O PARÂMETRO logtrace }
{ AUTOR: RENAN SERRANO }
{ ****************************************************************************** }
unit Contabilidade.View.LogTrace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MemoFocus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, frxClass, Winapi.ShlObj,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, DB,
  Uni, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, dxBar, cxClasses, Vcl.ExtDlgs, cxCheckBox, DateUtils,
  System.Generics.Collections, cxBarEditItem, dxSparkline, cxLabel, cxSpinEdit, dxBarExtItems,
  Contabilidade.InterfaceTrace;

type
  TQueryInfo = record
    SQL: String;
    Start: TDatetime;
    Finished: TDatetime;
    TotalTime: TDatetime;
  end;

  TTraceViewerContabilidade = class(TInterfacedObject, ITraceViewerContabilidade)
  private
    class var FPrimeiraExecucao: Boolean;
    class var FCacheForm: TForm;
    class var FCacheMemo: TRichEdit;
    class var FLeft: Integer;
    class Var FTop: Integer;
    class Var FWidth: Integer;
    class var FHeight: Integer;
    class var FLogEnabled: Boolean;
    class var FCountSQL: Integer;
    class var FQueryList: TList<TQueryInfo>;
    class var FMinTimeSeconds: Extended;
    class var FSQLTrace: ISQLTraceContabilidade;
  private
    FQueryInfo: TQueryInfo;
    FTimerShow: TTimer;

    procedure OnTimerShow(Sender: TObject);

    class procedure EventLog(ALog: String; AColor: TColor; ANewLine: Boolean); overload;
    class procedure EventLog(AInfo: TQueryInfo); overload;

    procedure BeforePost(ADataSet: TDataSet);
    procedure AfterPost(ADataSet: TDataSet);

    procedure BeforeExecute(AObject: TObject);
    procedure AfterExecute(AObject: TObject; AResult: boolean);
  public
    procedure Show();
    procedure Stop();
    procedure LogSQL(ALog: String);
    procedure LogTimer(AInfo: String);
    procedure LogThread(AInfo: String);
    procedure SetQueryEvents(ADataSet: TUniQuery);
    procedure SetSQLTrace(AObj: ISQLTraceContabilidade);
    function Visible(): Boolean;
    function EnabledSQLLog(): Boolean;
  end;

  TfrmLogTraceContabilidade = class(TForm)
    pnlMemo: TPanel;
    mmoTrace: TRichEdit;
    tmrStatus: TTimer;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfoSQL: TPanel;
    pnlNroSQL: TPanel;
    cxImageList1: TcxImageList;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    btnIniciarParar: TdxBarButton;
    btnSalvar_: TdxBarButton;
    btnLimpar_: TdxBarButton;
    pnlInfoStatus: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tmrStatusTimer(Sender: TObject);
    procedure btnIniciarPararClick(Sender: TObject);
    procedure btnLimpar_Click(Sender: TObject);
    procedure btnSalvar_Click(Sender: TObject);
    procedure mmoTraceMouseEnter(Sender: TObject);
    procedure mmoTraceMouseLeave(Sender: TObject);
    procedure mmoTraceClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSentToBack: Boolean;
    FWindowHandle: Hwnd;
    FClicouMemoTrace: Boolean;
  private
    procedure pDefinirTransparencia;
//    procedure pFiltrarQueries(ALastNumber: Integer);
    procedure pRestaurarTexto;
    procedure pSalvarStatus;
    procedure pEscreverLog(AEdit: TRichEdit; ALog: String; AColor: TColor; ANewLine: Boolean);
    function fMouseEstaNoFormulario: Boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure pRegistrarLog(ALog: String; AColor: TColor; ANewLine: Boolean);
    procedure InfoSQLExecutando(AText: String);
    class function IsVisible(): Boolean;
  end;

var
  frmLogTrace: TfrmLogTraceContabilidade;

implementation

{$R *.dfm}

uses untFuncoesSimples;

const
  LOG_COLUNAS = 80;

function StartProcess(Exename: String; CmdLineArgs: String = ''; ShowWindow: Boolean = False;
    WaitForFinish: Boolean = False): integer;
var
    StartInfo: TStartupInfo;
    ProcInfo: TProcessInformation;
    CreateOK: boolean;
begin
    // Simple wrapper for the CreateProcess command
    // returns the process id of the started process.
    FillChar(StartInfo, SizeOf(TStartupInfo), #0);
    FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
    StartInfo.cb := SizeOf(TStartupInfo);

    If Not ShowWindow Then
    begin
      StartInfo.dwFlags := STARTF_USESHOWWINDOW;
      StartInfo.wShowWindow := SW_HIDE;
    end;
    pLog('StartProcess->'+Exename + ' ' + CmdLineArgs);
    CreateOK := CreateProcess(nil, PChar(Exename + ' ' + CmdLineArgs), nil, nil, False,
      CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

    Result := ProcInfo.dwProcessId;

    if CreateOK then
    begin
      // may or may not be needed. Usually wait for child processes
      if WaitForFinish then
        WaitForSingleObject(ProcInfo.hProcess, Infinite);
    end
    else
    begin
      // ShowMessage('Unable to run '+ProgramName);
      SysErrorMessage(GetLastError());
    end;

    // close process & thread handles
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
end;

function fTrimAll(strTexto: String): String;
  Var
    c: Char;
    l: Char;
begin
  l := #0;
  Result := '';

  for c in strTexto do
  begin
    if (c = ' ') and (l = ' ') then
      continue;
    l := c;
    Result := Result + c;
  end;

  Result := Trim(Result);
end;

function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;
Var
  c: Char;
begin
  Result := '';
  for c in strTexto do
    if (c <> chrFrom) then
      Result := Result + c
    Else If chrTo <> #0 Then
      Result := Result + chrTo;
end;

function fTiraEnter(strTexto: String): String;
begin
  Result := strTexto;
  Result := fTrocaCaracter(Result, #13, ' ');
  Result := fTrocaCaracter(Result, #10, ' ');
  Result := Trim(Result);
end;

procedure TfrmLogTraceContabilidade.btnIniciarPararClick(Sender: TObject);
begin
  If Not TTraceViewerContabilidade.FLogEnabled Then
  Begin
    btnIniciarParar.Caption := '&Parar Trace';
    pnlInfoStatus.Caption := 'Status: Ativo';
    btnIniciarParar.ImageIndex := 1;
    TTraceViewerContabilidade.FLogEnabled := True;
  End
  Else
  Begin
    btnIniciarParar.Caption := '&Iniciar Trace';
    pnlInfoStatus.Caption := 'Status: Pausado';
    btnIniciarParar.ImageIndex := 0;
    TTraceViewerContabilidade.FLogEnabled := False;
  End;
end;

procedure TfrmLogTraceContabilidade.btnLimpar_Click(Sender: TObject);
begin
  mmoTrace.Lines.Clear;
  TTraceViewerContabilidade.FCacheMemo.Clear;
  TTraceViewerContabilidade.FCountSQL := 0;
  TTraceViewerContabilidade.FQueryList.Clear;
end;

procedure TfrmLogTraceContabilidade.btnSalvar_Click(Sender: TObject);
Var
  LPasta: String;
  LArquivo: String;
  LSLArquivo: TStringList;
begin
  LPasta := ExtractFilePath(Application.ExeName) + '\SQLTrace\';

  If (Not DirectoryExists(LPasta)) Then
    MkDir(LPasta);

  LArquivo := LPasta + 'LOG_TRACE_' + Random(999999).ToString() + '.txt';

  LSLArquivo := TStringList.Create;
  Try
    LSLArquivo.Text := mmoTrace.Text;
    LSLArquivo.SaveToFile(LArquivo);
  Finally
    FreeAndNil(LSLArquivo);
  End;

  If FileExists(LArquivo) Then
    StartProcess('NOTEPAD', '"' + LArquivo + '"', True);
end;

procedure TfrmLogTraceContabilidade.FormActivate(Sender: TObject);
begin
  If TTraceViewerContabilidade.FPrimeiraExecucao Then
  Begin
    btnIniciarParar.Click;
    TTraceViewerContabilidade.FPrimeiraExecucao := False;
  End;

  If TTraceViewerContabilidade.FLogEnabled Then
  Begin
    btnIniciarParar.Caption := '&Parar Trace';
    pnlInfoStatus.Caption := 'Status: Ativo';
    btnIniciarParar.ImageIndex := 1;
  End
  Else
  Begin
    btnIniciarParar.Caption := '&Iniciar Trace';
    pnlInfoStatus.Caption := 'Status: Pausado';
    btnIniciarParar.ImageIndex := 0;
  End;

  mmoTrace.Perform(WM_VSCROLL, MakeWParam(SB_Bottom, 0),0);
end;

procedure TfrmLogTraceContabilidade.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := False;
  Self.Hide;
  frmLogTrace.btnLimpar_.Click;
  TTraceViewerContabilidade.FPrimeiraExecucao := True;
end;

procedure TfrmLogTraceContabilidade.FormCreate(Sender: TObject);
Var
  LWindowsBarHeight: Integer;
begin
  LWindowsBarHeight := Screen.Height - Screen.WorkAreaHeight;

  AlphaBlendValue := 180;

  If TTraceViewerContabilidade.FLeft >= 0 Then
    Self.Left := TTraceViewerContabilidade.FLeft;

  If TTraceViewerContabilidade.FTop >= 0 Then
    Self.Top := TTraceViewerContabilidade.FTop;

  If TTraceViewerContabilidade.FWidth >= 0 Then
    Self.Width := TTraceViewerContabilidade.FWidth;

  If TTraceViewerContabilidade.FHeight >= 0 Then
    Self.Height := TTraceViewerContabilidade.FHeight;

  If Not Assigned(TTraceViewerContabilidade.FCacheForm) Then
  Begin
    TTraceViewerContabilidade.FCacheForm := TForm.Create(Application);
    TTraceViewerContabilidade.FCacheMemo := TRichEdit.Create(TTraceViewerContabilidade.FCacheForm);
    TTraceViewerContabilidade.FCacheMemo.Parent := TTraceViewerContabilidade.FCacheForm;
  End;

  If TTraceViewerContabilidade.FPrimeiraExecucao Then
  Begin
    TTraceViewerContabilidade.FLogEnabled := False;
    Self.Left := Screen.Width - Self.Width - 5;
    Self.Top := Screen.Height - Self.Height - LWindowsBarHeight;
  End;

  FSentToBack := True;
  FWindowHandle := GetActiveWindow;

  pRestaurarTexto;
end;

procedure TfrmLogTraceContabilidade.FormShow(Sender: TObject);
begin
  If FSentToBack Then
  Begin
//    SetForegroundWindow(FWindowHandle);
    FSentToBack := False;
  End;
end;

procedure TfrmLogTraceContabilidade.InfoSQLExecutando(AText: String);
begin
  If Not TTraceViewerContabilidade.FLogEnabled Then
    Exit;

  AText := Copy(AText, 1, 255);

  While AText.Contains('  ') Do
    AText := AText.Replace('  ', ' ');

  pnlInfoSQL.Caption := Copy(AText, 1, 255) + ' ... ';

  pnlInfoSQL.Refresh;
end;

class function TfrmLogTraceContabilidade.IsVisible: Boolean;
begin
  Result := Assigned(frmLogTrace) And frmLogTrace.Visible;
end;

procedure TfrmLogTraceContabilidade.mmoTraceClick(Sender: TObject);
begin
  FClicouMemoTrace := True;
end;

procedure TfrmLogTraceContabilidade.mmoTraceMouseEnter(Sender: TObject);
begin
  pDefinirTransparencia;
end;

procedure TfrmLogTraceContabilidade.mmoTraceMouseLeave(Sender: TObject);
begin
  pDefinirTransparencia;
end;

procedure TfrmLogTraceContabilidade.pEscreverLog(AEdit: TRichEdit; ALog: String; AColor: TColor; ANewLine: Boolean);
begin
  If Assigned(Self.ActiveControl) Then
    Self.ActiveControl := nil;

  AEdit.Perform(WM_VSCROLL, MakeWParam(SB_Bottom, 0),0);
  AEdit.SelAttributes.Color := AColor;
  AEdit.SelAttributes.Size := 8;
  AEdit.SelAttributes.Name := 'Courier New';

  If ANewLine Then
    AEdit.Lines.Add(ALog)
  Else
  Begin
    AEdit.SelStart := AEdit.GetTextLen;
    AEdit.SelText  := ALog;
  End;

  SendMessage(AEdit.Handle, WM_VSCROLL, SB_PAGEDOWN, 0);

  AEdit.Refresh;
end;

//procedure TfrmLogTraceContabilidade.pFiltrarQueries(ALastNumber: Integer);
//Var
//  LInfo: TQueryInfo;
//  LList: TList<TQueryInfo>;
//begin
//  LList := TList<TQueryInfo>.Create;
//  Try
//    mmoTrace.Clear;
//    For LInfo In TTraceViewerContabilidade.FQueryList Do
//      If MilliSecondsBetween(LInfo.Finished, LInfo.Start) > (TTraceViewerContabilidade.FMinTimeSeconds * 1000) Then
//        LList.Add(LInfo);
//
//    If LList.Count > ALastNumber Then
//      LList.DeleteRange(0, LList.Count - ALastNumber);
//
//    TTraceViewerContabilidade.EventLog('Existem ' + (LList.Count - ALastNumber).ToString +
//      ' registros não exibidos ...', clBlue, True, False);
//
//    For LInfo In LList Do
//      TTraceViewerContabilidade.EventLog(LInfo);
//
//    SendMessage(mmoTrace.Handle, WM_VSCROLL, SB_PAGEDOWN, 0);
//
//    mmoTrace.Refresh;
//  Finally
//    FreeAndNil(LList);
//  End;
//end;

procedure TfrmLogTraceContabilidade.pRegistrarLog(ALog: String; AColor: TColor; ANewLine: Boolean);
begin
  If Not TTraceViewerContabilidade.FLogEnabled Then
    Exit;

  pnlNroSQL.Caption := 'Nº SQLs: ' + IntToStr(TTraceViewerContabilidade.FCountSQL);

  pEscreverLog(TTraceViewerContabilidade.FCacheMemo, ALog, AColor, ANewLine);

  If (Not FClicouMemoTrace) Or (Not mmoTrace.Focused) Then
    pEscreverLog(mmoTrace, ALog, AColor, ANewLine);

  pnlNroSQL.Refresh;
end;

procedure TfrmLogTraceContabilidade.pRestaurarTexto;
var
  LStream : TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  Try
    TTraceViewerContabilidade.FCacheMemo.Lines.SaveToStream(LStream);
    LStream.Position := 0;
    mmoTrace.Lines.LoadFromStream(LStream);
  Finally
    LStream.Free;
  End;
  mmoTrace.Perform(WM_VSCROLL, MakeWParam(SB_Bottom, 0),0);
end;

procedure TfrmLogTraceContabilidade.pSalvarStatus;
begin
  TTraceViewerContabilidade.FTop := Self.Top;
  TTraceViewerContabilidade.FWidth := Self.Width;
  TTraceViewerContabilidade.FLeft := Self.Left;
  TTraceViewerContabilidade.FHeight := Self.Height;
end;

procedure TfrmLogTraceContabilidade.pDefinirTransparencia;
Var
  LValue: Integer;
begin
  If fMouseEstaNoFormulario Then
    LValue := 255
  Else
    LValue := 180;

  If AlphaBlendValue <> LValue Then
    AlphaBlendValue := LValue;
end;

procedure TfrmLogTraceContabilidade.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST or WS_EX_OVERLAPPEDWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

function TfrmLogTraceContabilidade.fMouseEstaNoFormulario: Boolean;
begin
  Result := (( Self.Left ) <= Mouse.CursorPos.X ) And (( Self.Left + Self.Width  ) >= Mouse.CursorPos.X ) And
            (( Self.Top  ) <= Mouse.CursorPos.Y ) And (( Self.Top  + Self.Height ) >= Mouse.CursorPos.Y ) ;
End;

procedure TfrmLogTraceContabilidade.tmrStatusTimer(Sender: TObject);
begin
  inherited;
  pnlNroSQL.Caption := 'Nº SQLs: ' + IntToStr(TTraceViewerContabilidade.FCountSQL);
  pSalvarStatus;
  pDefinirTransparencia;
end;

{ TTraceViewerContabilidade }

procedure TTraceViewerContabilidade.AfterExecute(AObject: TObject; AResult: boolean);
begin
  If Not EnabledSQLLog Then
    Exit;

  If FQueryInfo.SQL.IsEmpty Then
    LogSQL(TUniQuery(AObject).SQL.Text);

  FQueryInfo.Finished := fNow();
  FQueryInfo.TotalTime := FQueryInfo.Finished - FQueryInfo.Start;

  If Self.Visible And Self.FLogEnabled Then
    FQueryList.Add(FQueryInfo);

  TTraceViewerContabilidade.EventLog(FQueryInfo);

  If Self.Visible And Self.FLogEnabled Then
    frmLogTrace.InfoSQLExecutando('');
end;

procedure TTraceViewerContabilidade.AfterPost(ADataSet: TDataSet);
begin
  If Not EnabledSQLLog Then
    Exit;

  If FQueryInfo.SQL.IsEmpty Then
    LogSQL(TUniQuery(ADataSet).SQL.Text);

  FQueryInfo.Finished := fNow();
  FQueryInfo.TotalTime := FQueryInfo.Finished - FQueryInfo.Start;

  If Self.Visible And Self.FLogEnabled Then
    FQueryList.Add(FQueryInfo);

  TTraceViewerContabilidade.EventLog(FQueryInfo);

  If Self.Visible And Self.FLogEnabled Then
    frmLogTrace.InfoSQLExecutando('');
end;

procedure TTraceViewerContabilidade.BeforeExecute(AObject: TObject);
begin
  If Not EnabledSQLLog Then
    Exit;

  FQueryInfo.Start := fNow();
  FQueryInfo.SQL := EmptyStr;
end;

procedure TTraceViewerContabilidade.BeforePost(ADataSet: TDataSet);
begin
  If Not EnabledSQLLog Then
    Exit;

  FQueryInfo.Start := fNow();
  FQueryInfo.SQL := EmptyStr;
end;

function TTraceViewerContabilidade.EnabledSQLLog: Boolean;
begin
  Result := False;

  If Self.Visible And Self.FLogEnabled Then
    Exit(True);

  If Assigned(FSQLTrace) And FSQLTrace.Autenticado And (FSQLTrace.Status = stIniciado) Then
    Exit(True);
end;

class procedure TTraceViewerContabilidade.EventLog(AInfo: TQueryInfo);
begin
  If TfrmLogTraceContabilidade.IsVisible And Self.FLogEnabled Then
  Begin
    TTraceViewerContabilidade.EventLog(FormatDateTime('[ dd/mm/yyyy hh:mm:ss.zzz ]', AInfo.Start), clHotLight, True);
    TTraceViewerContabilidade.EventLog(AInfo.SQL, clBlack, True);
    TTraceViewerContabilidade.EventLog(FormatDateTime('[ dd/mm/yyyy hh:mm:ss.zzz ]', AInfo.Finished), clHotLight, True);
    TTraceViewerContabilidade.EventLog('Tempo Total: ' + FormatDateTime('hh:mm:ss.zzz', AInfo.TotalTime), clRed, False);
    TTraceViewerContabilidade.EventLog(StringOfChar('-', LOG_COLUNAS), clGray, True);
  End;

  If Assigned(FSQLTrace) And FSQLTrace.Autenticado And (FSQLTrace.Status = stIniciado) Then
  Begin
    FSQLTrace.pWrite(FormatDateTime('[ dd/mm/yyyy hh:mm:ss.zzz ]', AInfo.Start) + sLineBreak +
                     AInfo.SQL + sLineBreak +
                     FormatDateTime('[ dd/mm/yyyy hh:mm:ss.zzz ]', AInfo.Finished) + ' Tempo Total: ' +
                     FormatDateTime('hh:mm:ss.zzz', AInfo.TotalTime) + sLineBreak +
                     StringOfChar('-', LOG_COLUNAS));
  End;
end;

function TTraceViewerContabilidade.Visible: Boolean;
begin
  Result := TfrmLogTraceContabilidade.IsVisible;
end;

procedure TTraceViewerContabilidade.LogSQL(ALog: String);
begin
  If Not EnabledSQLLog Then
    Exit;

  If Self.Visible And Self.FLogEnabled Then
  Begin
    frmLogTrace.InfoSQLExecutando(ALog);
    Inc(TTraceViewerContabilidade.FCountSQL);
  End;

  FQueryInfo.SQL := fTrimAll(fTiraEnter(ALog));
end;

procedure TTraceViewerContabilidade.LogThread(AInfo: String);
begin
  If Not (Self.Visible And Self.FLogEnabled) Then
    Exit;

  TTraceViewerContabilidade.EventLog(FormatDateTime('[ dd/mm/yyyy hh:mm:ss.zzz ]', fNow), clHotLight, True);
  TTraceViewerContabilidade.EventLog('Thread: ' + AInfo, clRed, True);
  TTraceViewerContabilidade.EventLog(StringOfChar('-', LOG_COLUNAS), clGray, True);
end;

procedure TTraceViewerContabilidade.LogTimer(AInfo: String);
begin
  If Not (Self.Visible And Self.FLogEnabled) Then
    Exit;

  TTraceViewerContabilidade.EventLog(FormatDateTime('[ dd/mm/yyyy hh:mm:ss.zzz ]', fNow), clHotLight, True);
  TTraceViewerContabilidade.EventLog('Timer: ' + AInfo, clBlue, True);
  TTraceViewerContabilidade.EventLog(StringOfChar('-', LOG_COLUNAS), clGray, True);
end;

procedure TTraceViewerContabilidade.OnTimerShow(Sender: TObject);
Var
  FHandle: Hwnd;
begin
  FTimerShow.Enabled := False;

  FHandle := GetActiveWindow;

  If Assigned(frmLogTrace) Then
    FreeAndNil(frmLogTrace);

  If Not Assigned(frmLogTrace) Then
    frmLogTrace := TfrmLogTraceContabilidade.Create(Application);

  frmLogTrace.Show;

  SetForegroundWindow(FHandle);
end;

class procedure TTraceViewerContabilidade.EventLog(ALog: String; AColor: TColor; ANewLine: Boolean);
begin
  If Not (TfrmLogTraceContabilidade.IsVisible And Self.FLogEnabled) Then
    Exit;

  frmLogTrace.pRegistrarLog(ALog, AColor, ANewLine);
end;

procedure TTraceViewerContabilidade.SetQueryEvents(ADataSet: TUniQuery);
begin
  /// se o tracer da contabilidade estiver ligado, o tracer do autcom será subescrito.
  If Not EnabledSQLLog Then
    Exit;

  ADataSet.BeforePost := Self.BeforePost;

  ADataSet.AfterPost := Self.AfterPost;

  ADataSet.BeforeExecute := Self.BeforeExecute;

  ADataSet.AfterExecute := Self.AfterExecute;
end;

procedure TTraceViewerContabilidade.SetSQLTrace(AObj: ISQLTraceContabilidade);
begin
  FSQLTrace := AObj;
end;

procedure TTraceViewerContabilidade.Show;
begin
  If Not Assigned(FTimerShow) Then
  Begin
    FTimerShow := TTimer.Create(Application);
    FTimerShow.Interval := 300;
    FTimerShow.Enabled := False;
    FTimerShow.OnTimer := Self.OnTimerShow;
  End;

  FTimerShow.Enabled := False;
  FTimerShow.Enabled := True;
end;

procedure TTraceViewerContabilidade.Stop;
begin
  If Self.Visible Then
    If TTraceViewerContabilidade.FLogEnabled Then
      frmLogTrace.btnIniciarParar.Click;
end;

initialization
  TTraceViewerContabilidade.FLeft := -1;
  TTraceViewerContabilidade.FTop := -1;
  TTraceViewerContabilidade.FWidth := -1;
  TTraceViewerContabilidade.FHeight := -1;
  TTraceViewerContabilidade.FCountSQL := 0;
  TTraceViewerContabilidade.FMinTimeSeconds := 0;
  TTraceViewerContabilidade.FPrimeiraExecucao := True;
  TTraceViewerContabilidade.FQueryList := TList<TQueryInfo>.Create;

finalization
  FreeAndNil(TTraceViewerContabilidade.FQueryList);

end.
