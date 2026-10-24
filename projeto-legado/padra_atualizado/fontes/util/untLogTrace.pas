{ ****************************************************************************** }
{ TELA QUE EXIBE O LOG DO TRACE EM UMA TELA SEMPRE POR CIMA DAS OUTRAS. }
{ PARA ATIVAR, BASTA INICIAR O AUTCOM COM O PARÂMETRO logtrace }
{ AUTOR: RENAN SERRANO }
{ ****************************************************************************** }
unit untLogTrace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MemoFocus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, frxClass, Winapi.ShlObj, SyncObjs,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, untTypesSistema, DB, untThreadUtils,
  Uni, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, dxBar, cxClasses, Vcl.ExtDlgs, cxCheckBox, DateUtils,
  System.Generics.Collections, cxBarEditItem, dxSparkline, cxLabel, cxSpinEdit, dxBarExtItems;

type
  TQueryInfo = record
    SQL: String;
    Start: TDatetime;
    Finished: TDatetime;
    TotalTime: TDatetime;
  end;

  TTraceLog = record
    Log: String;
    Color: TColor;
    NewLine: Boolean;
  end;

  TTraceViewer = class(TInterfacedObject, ITraceViewer)
  private
    class var FPrimeiraExecucao: Boolean;
    class var FCacheForm: TForm;
    class var FCacheMemo: TRichEdit;
    class var FStream: TMemoryStream;
    class var FLeft: Integer;
    class Var FTop: Integer;
    class Var FWidth: Integer;
    class var FHeight: Integer;
    class var FLogEnabled: Boolean;
    class var FCountSQL: Integer;
    class var FQueryList: TList<TQueryInfo>;
    class var FMinTimeSeconds: Extended;
    class var FSQLTrace: ISQLTrace;
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
    procedure SetQueryEvents(ADataSet: TUniQuery);
    procedure SetSQLTrace(AObj: ISQLTrace);
    function Visible(): Boolean;
    function EnabledSQLLog(): Boolean;
  end;

  TThreadUpdateViewLog = class(TSafeThread)
  private
    FMemoTrace: TRichEdit;
    FPnlNroSQL: TPanel;
    FTraceLogs: TList<TTraceLog>;
    FSemaphore: TCriticalSection;
    FCurrentLog: TTraceLog;
  private
    function GetCount: Integer;
    function GetFirst: TTraceLog;
    procedure RemoveFirst;
    procedure WriteLog;
  protected
    procedure Execute; override;
  public
    constructor Create(AMemoTrace: TRichEdit; APnlNroSQL: TPanel); reintroduce;
    procedure AddLog(ALog: String; AColor: TColor; ANewLine: Boolean);
    destructor Destroy; override;
  end;

  TfrmLogTrace = class(TForm)
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
    procedure FormDestroy(Sender: TObject);
  private
    FSentToBack: Boolean;
    FWindowHandle: Hwnd;
    FUpdateViewLog: TThreadUpdateViewLog;
    FClicouMemoTrace: Boolean;
  private
    procedure pDefinirTransparencia;
    procedure pRestaurarTexto;
    procedure pSalvarTexto;
    procedure pSalvarStatus;
    function fMouseEstaNoFormulario: Boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure pRegistrarLog(ALog: String; AColor: TColor; ANewLine: Boolean);
    procedure InfoSQLExecutando(AText: String);
    class function IsVisible(): Boolean;
  end;

var
  frmLogTrace: TfrmLogTrace;

implementation

{$R *.dfm}

uses untFuncoesSimples;

const
  LOG_COLUNAS = 80;
  LOG_VIEW_MAX_LINES = 50;

Var
  FLastLogs: TList<TTraceLog>;

procedure pWriteLog(AEdit: TRichEdit; ALog: String; AColor: TColor; ANewLine: Boolean; ACache: Boolean);
Var
  LLastLog: TTraceLog;
begin
  If (Not ACache) And (AEdit.Lines.Count > LOG_VIEW_MAX_LINES) Then
  Begin
    AEdit.Clear;
    pWriteLog(AEdit, '...', clGray, True, False);
    For LLastLog In FLastLogs Do
      pWriteLog(AEdit, LLastLog.Log, LLastLog.Color, LLastLog.NewLine, False);
  End;

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

  If (Not ACache) Then
    SendMessage(AEdit.Handle, WM_VSCROLL, SB_PAGEDOWN, 0);

  If (Not ACache) Then
    If AEdit.Lines.Count > 10 Then
      AEdit.Refresh;
end;

procedure TfrmLogTrace.btnIniciarPararClick(Sender: TObject);
begin
  If Not TTraceViewer.FLogEnabled Then
  Begin
    btnIniciarParar.Caption := '&Parar Trace';
    pnlInfoStatus.Caption := 'Status: Ativo';
    btnIniciarParar.ImageIndex := 1;
    TTraceViewer.FLogEnabled := True;
  End
  Else
  Begin
    btnIniciarParar.Caption := '&Iniciar Trace';
    pnlInfoStatus.Caption := 'Status: Pausado';
    btnIniciarParar.ImageIndex := 0;
    TTraceViewer.FLogEnabled := False;
  End;
end;

procedure TfrmLogTrace.btnLimpar_Click(Sender: TObject);
begin
  mmoTrace.Lines.Clear;
  TTraceViewer.FCacheMemo.Clear;
  TTraceViewer.FCountSQL := 0;
  TTraceViewer.FQueryList.Clear;
end;

procedure TfrmLogTrace.btnSalvar_Click(Sender: TObject);
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
    LSLArquivo.Text := TTraceViewer.FCacheMemo.Text;
    LSLArquivo.SaveToFile(LArquivo);
  Finally
    FreeAndNil(LSLArquivo);
  End;

  If FileExists(LArquivo) Then
    StartProcess('NOTEPAD', '"' + LArquivo + '"', True);
end;

procedure TfrmLogTrace.FormActivate(Sender: TObject);
begin
  If TTraceViewer.FPrimeiraExecucao Then
  Begin
    btnIniciarParar.Click;
    TTraceViewer.FPrimeiraExecucao := False;
  End;

  If TTraceViewer.FLogEnabled Then
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

procedure TfrmLogTrace.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := False;
  Self.Hide;
  frmLogTrace.btnLimpar_.Click;
  TTraceViewer.FPrimeiraExecucao := True;
end;

procedure TfrmLogTrace.FormCreate(Sender: TObject);
Var
  LWindowsBarHeight: Integer;
begin
  FUpdateViewLog := TThreadUpdateViewLog.Create(Self.mmoTrace, Self.pnlNroSQL);

  LWindowsBarHeight := Screen.Height - Screen.WorkAreaHeight;

  AlphaBlendValue := 180;

  If TTraceViewer.FLeft >= 0 Then
    Self.Left := TTraceViewer.FLeft;

  If TTraceViewer.FTop >= 0 Then
    Self.Top := TTraceViewer.FTop;

  If TTraceViewer.FWidth >= 0 Then
    Self.Width := TTraceViewer.FWidth;

  If TTraceViewer.FHeight >= 0 Then
    Self.Height := TTraceViewer.FHeight;

  If Not Assigned(TTraceViewer.FCacheForm) Then
  Begin
    TTraceViewer.FCacheForm := TForm.Create(Application);
    TTraceViewer.FCacheMemo := TRichEdit.Create(TTraceViewer.FCacheForm);
    TTraceViewer.FCacheMemo.Parent := TTraceViewer.FCacheForm;
  End;

  If TTraceViewer.FPrimeiraExecucao Then
  Begin
    TTraceViewer.FLogEnabled := False;
    Self.Left := Screen.Width - Self.Width - 5;
    Self.Top := Screen.Height - Self.Height - LWindowsBarHeight;
  End;

  FSentToBack := True;
  FWindowHandle := GetActiveWindow;

  pRestaurarTexto;
end;

procedure TfrmLogTrace.FormDestroy(Sender: TObject);
begin
  pSalvarTexto;
  FUpdateViewLog.Terminate;
end;

procedure TfrmLogTrace.FormShow(Sender: TObject);
begin
  If FSentToBack Then
  Begin
//    SetForegroundWindow(FWindowHandle);
    FSentToBack := False;
  End;
end;

procedure TfrmLogTrace.InfoSQLExecutando(AText: String);
begin
  If Not TTraceViewer.FLogEnabled Then
    Exit;

  AText := Copy(AText, 1, 255);

  While AText.Contains('  ') Do
    AText := AText.Replace('  ', ' ');

  pnlInfoSQL.Caption := Copy(AText, 1, 255) + ' ... ';
  pnlInfoSQL.Refresh;

  pnlInfoStatus.Caption := 'Status: Ativo';
  pnlInfoStatus.Refresh;
end;

class function TfrmLogTrace.IsVisible: Boolean;
begin
  Result := Assigned(frmLogTrace) And frmLogTrace.Visible;
end;

procedure TfrmLogTrace.mmoTraceClick(Sender: TObject);
begin
  FClicouMemoTrace := True;
end;

procedure TfrmLogTrace.mmoTraceMouseEnter(Sender: TObject);
begin
  pDefinirTransparencia;
end;

procedure TfrmLogTrace.mmoTraceMouseLeave(Sender: TObject);
begin
  pDefinirTransparencia;
end;

procedure TfrmLogTrace.pRegistrarLog(ALog: String; AColor: TColor; ANewLine: Boolean);
begin
  If Not TTraceViewer.FLogEnabled Then
    Exit;
  pWriteLog(TTraceViewer.FCacheMemo, ALog, AColor, ANewLine, True);
  If (Not FClicouMemoTrace) Or (Not mmoTrace.Focused) Then
  Begin
    Self.ActiveControl
      := nil;
    FUpdateViewLog.AddLog(ALog, AColor, ANewLine);
  End;
end;

procedure TfrmLogTrace.pRestaurarTexto;
begin
  If Assigned(TTraceViewer.FStream) Then
  Begin
    TTraceViewer.FStream.Position := 0;
    mmoTrace.Lines.LoadFromStream(TTraceViewer.FStream);
    mmoTrace.Perform(WM_VSCROLL, MakeWParam(SB_Bottom, 0),0);
  End;
end;

procedure TfrmLogTrace.pSalvarStatus;
begin
  TTraceViewer.FTop := Self.Top;
  TTraceViewer.FWidth := Self.Width;
  TTraceViewer.FLeft := Self.Left;
  TTraceViewer.FHeight := Self.Height;
end;

procedure TfrmLogTrace.pSalvarTexto;
begin
  If Assigned(TTraceViewer.FStream) Then
    FreeAndNil(TTraceViewer.FStream);
  TTraceViewer.FStream := TMemoryStream.Create;
  Self.mmoTrace.Lines.SaveToStream(TTraceViewer.FStream);
end;

procedure TfrmLogTrace.pDefinirTransparencia;
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

procedure TfrmLogTrace.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST or WS_EX_OVERLAPPEDWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

function TfrmLogTrace.fMouseEstaNoFormulario: Boolean;
begin
  Result := (( Self.Left ) <= Mouse.CursorPos.X ) And (( Self.Left + Self.Width  ) >= Mouse.CursorPos.X ) And
            (( Self.Top  ) <= Mouse.CursorPos.Y ) And (( Self.Top  + Self.Height ) >= Mouse.CursorPos.Y ) ;
End;

procedure TfrmLogTrace.tmrStatusTimer(Sender: TObject);
begin
  inherited;
  pnlNroSQL.Caption := 'Nº SQLs: ' + IntToStr(TTraceViewer.FCountSQL);
  pSalvarStatus;
  pDefinirTransparencia;
end;

{ TTraceViewer }

procedure TTraceViewer.AfterExecute(AObject: TObject; AResult: boolean);
begin
  If Not EnabledSQLLog Then
    Exit;

  If FQueryInfo.SQL.IsEmpty Then
    LogSQL(TUniQuery(AObject).SQL.Text);

  FQueryInfo.Finished := fNow();
  FQueryInfo.TotalTime := FQueryInfo.Finished - FQueryInfo.Start;

  If Self.Visible And Self.FLogEnabled Then
    FQueryList.Add(FQueryInfo);

  TTraceViewer.EventLog(FQueryInfo);

  If Self.Visible And Self.FLogEnabled Then
    frmLogTrace.InfoSQLExecutando('');
end;

procedure TTraceViewer.AfterPost(ADataSet: TDataSet);
begin
  If Not EnabledSQLLog Then
    Exit;

  If FQueryInfo.SQL.IsEmpty Then
    LogSQL(TUniQuery(ADataSet).SQL.Text);

  FQueryInfo.Finished := fNow();
  FQueryInfo.TotalTime := FQueryInfo.Finished - FQueryInfo.Start;

  If Self.Visible And Self.FLogEnabled Then
    FQueryList.Add(FQueryInfo);

  TTraceViewer.EventLog(FQueryInfo);

  If Self.Visible And Self.FLogEnabled Then
    frmLogTrace.InfoSQLExecutando('');
end;

procedure TTraceViewer.BeforeExecute(AObject: TObject);
begin
  If Not EnabledSQLLog Then
    Exit;

  FQueryInfo.Start := fNow();
  FQueryInfo.SQL := EmptyStr;
end;

procedure TTraceViewer.BeforePost(ADataSet: TDataSet);
begin
  If Not EnabledSQLLog Then
    Exit;

  FQueryInfo.Start := fNow();
  FQueryInfo.SQL := EmptyStr;
end;

function TTraceViewer.EnabledSQLLog: Boolean;
begin
  Result := False;

  If Self.Visible And Self.FLogEnabled Then
    Exit(True);

  If Assigned(FSQLTrace) And FSQLTrace.Autenticado And (FSQLTrace.Status = stIniciado) Then
    Exit(True);
end;

class procedure TTraceViewer.EventLog(AInfo: TQueryInfo);
begin
  If TfrmLogTrace.IsVisible And Self.FLogEnabled Then
  Begin
    TTraceViewer.EventLog(FormatDateTime('[ dd/mm/yyyy hh:mm:ss.zzz ]', AInfo.Start), clHotLight, True);
    TTraceViewer.EventLog(AInfo.SQL, clBlack, True);
    TTraceViewer.EventLog(FormatDateTime('[ dd/mm/yyyy hh:mm:ss.zzz ]', AInfo.Finished), clHotLight, True);
    TTraceViewer.EventLog('Tempo Total: ' + FormatDateTime('hh:mm:ss.zzz', AInfo.TotalTime), clRed, False);
    TTraceViewer.EventLog(StringOfChar('-', LOG_COLUNAS), clGray, True);
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

function TTraceViewer.Visible: Boolean;
begin
  Result := TfrmLogTrace.IsVisible;
end;

procedure TTraceViewer.LogSQL(ALog: String);
begin
  If Not EnabledSQLLog Then
    Exit;

  If Self.Visible And Self.FLogEnabled Then
  Begin
    frmLogTrace.InfoSQLExecutando(ALog);
    InterlockedIncrement(TTraceViewer.FCountSQL);
  End;

  FQueryInfo.SQL := fTrimAll(fTiraEnter(ALog));
end;

procedure TTraceViewer.LogTimer(AInfo: String);
begin
  If Not (Self.Visible And Self.FLogEnabled) Then
    Exit;

  TTraceViewer.EventLog(FormatDateTime('[ dd/mm/yyyy hh:mm:ss.zzz ]', fNow), clHotLight, True);
  TTraceViewer.EventLog('Timer: ' + AInfo, clBlue, True);
  TTraceViewer.EventLog(StringOfChar('-', LOG_COLUNAS), clGray, True);
end;

procedure TTraceViewer.OnTimerShow(Sender: TObject);
Var
  FHandle: Hwnd;
begin
  FTimerShow.Enabled := False;

  FHandle := GetActiveWindow;

  If Assigned(frmLogTrace) Then
    FreeAndNil(frmLogTrace);

  If Not Assigned(frmLogTrace) Then
    frmLogTrace := TfrmLogTrace.Create(Application);

  frmLogTrace.Show;

  SetForegroundWindow(FHandle);
end;

class procedure TTraceViewer.EventLog(ALog: String; AColor: TColor; ANewLine: Boolean);
Var
  LLastLog: TTraceLog;
begin
  If Not (TfrmLogTrace.IsVisible And Self.FLogEnabled) Then
    Exit;

  If Not Assigned(FLastLogs) Then
    FLastLogs := TList<TTraceLog>.Create;

  If FLastLogs.Count > 10 Then
    FLastLogs.Delete(0);

  LLastLog.Log := ALog;
  LLastLog.Color := AColor;
  LLastLog.NewLine := ANewLine;

  FLastLogs.Add(LLastLog);

  frmLogTrace.pRegistrarLog(ALog, AColor, ANewLine);
end;

procedure TTraceViewer.SetQueryEvents(ADataSet: TUniQuery);
begin
  If Not Assigned(ADataSet.BeforePost) Then
    ADataSet.BeforePost := Self.BeforePost;

  If Not Assigned(ADataSet.AfterPost) Then
    ADataSet.AfterPost := Self.AfterPost;

  If Not Assigned(ADataSet.BeforeExecute) Then
    ADataSet.BeforeExecute := Self.BeforeExecute;

  If Not Assigned(ADataSet.AfterExecute) Then
    ADataSet.AfterExecute := Self.AfterExecute;
end;

procedure TTraceViewer.SetSQLTrace(AObj: ISQLTrace);
begin
  FSQLTrace := AObj;
end;

procedure TTraceViewer.Show;
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

procedure TTraceViewer.Stop;
begin
  If Self.Visible Then
    If TTraceViewer.FLogEnabled Then
      frmLogTrace.btnIniciarParar.Click;
end;

{ TThreadUpdateViewLog }

procedure TThreadUpdateViewLog.WriteLog;
begin
  FPnlNroSQL.Caption := 'Nº SQLs: ' + IntToStr(TTraceViewer.FCountSQL);
  pWriteLog(FMemoTrace, FCurrentLog.Log, FCurrentLog.Color, FCurrentLog.NewLine, False);
  FPnlNroSQL.Refresh;
end;

constructor TThreadUpdateViewLog.Create(AMemoTrace: TRichEdit;
  APnlNroSQL: TPanel);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FMemoTrace := AMemoTrace;
  FPnlNroSQL := APnlNroSQL;
  FTraceLogs := TList<TTraceLog>.Create;
  FSemaphore := TCriticalSection.Create;
end;

destructor TThreadUpdateViewLog.Destroy;
begin
  FTraceLogs.Free;
  FSemaphore.Free;
  inherited;
end;

procedure TThreadUpdateViewLog.Execute;
begin
  inherited;
  pLog('TThreadUpdateViewLog.Execute');
  while not Terminated do
  begin
    if Self.GetCount > 0 then
    begin
      FCurrentLog := Self.GetFirst;
      Synchronize(WriteLog);
      Self.RemoveFirst;
    end;
  end;
end;

function TThreadUpdateViewLog.GetCount: Integer;
begin
  FSemaphore.Enter;
  try
    Result := FTraceLogs.Count;
  finally
    FSemaphore.Leave;
  end;
end;

function TThreadUpdateViewLog.GetFirst: TTraceLog;
begin
  FSemaphore.Enter;
  try
    Result := FTraceLogs[0];
  finally
    FSemaphore.Leave;
  end;
end;

procedure TThreadUpdateViewLog.AddLog(ALog: String; AColor: TColor;
  ANewLine: Boolean);
Var
  LTraceLog: TTraceLog;
begin
  LTraceLog.Log := ALog;
  LTraceLog.Color := AColor;
  LTraceLog.NewLine := ANewLine;
  while Self.GetCount > LOG_VIEW_MAX_LINES do
    Self.RemoveFirst;
  FSemaphore.Enter;
  try
    FTraceLogs.Add(LTraceLog);
  finally
    FSemaphore.Leave;
  end;
end;

procedure TThreadUpdateViewLog.RemoveFirst;
begin
  FSemaphore.Enter;
  try
    FTraceLogs.Delete(0);
  finally
    FSemaphore.Leave;
  end;
end;

initialization
  TTraceViewer.FLeft := -1;
  TTraceViewer.FTop := -1;
  TTraceViewer.FWidth := -1;
  TTraceViewer.FHeight := -1;
  TTraceViewer.FCountSQL := 0;
  TTraceViewer.FMinTimeSeconds := 0;
  TTraceViewer.FPrimeiraExecucao := True;
  TTraceViewer.FQueryList := TList<TQueryInfo>.Create;

finalization
  FreeAndNil(TTraceViewer.FQueryList);

end.
