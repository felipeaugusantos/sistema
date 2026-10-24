unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, DateUtils, Math,
  DBAccess, Uni, UniProvider, MySQLUniProvider, Vcl.ComCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Samples.Spin, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, Vcl.DBCtrls, DBMemoFocus,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, MemDS, Datasnap.DBClient,
  UniClientDataSet, Datasnap.Provider, UniDataSetProvider, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.AppEvnts;

const
   CM_AVISOS = WM_USER + 1;
   CHAVE_LCKATC = 'AutcomService';

type
  TStrMsgObject = class(TObject)
    fMsg: string;
  public
    constructor Create(aMsg: string);
    property Msg: string read fMsg;
  end;

  TfrmAutcomSvc = class(TForm)
    TrayIcon1: TTrayIcon;
    tmrInicia: TTimer;
    Database: TUniConnection;
    StatusBar: TStatusBar;
    Panel1: TPanel;
    btmExecTarefas: TBitBtnLocked;
    btnMinimiza: TBitBtnLocked;
    spNumReg: TSpinEdit;
    lblNumReg1: TLabel;
    lblNumReg2: TLabel;
    cxgUltimosProcessosLevel1: TcxGridLevel;
    cxgUltimosProcessosTableView1: TcxGridDBTableViewCitel;
    cxgUltimosProcessos: TcxGridCitel;
    dbeLogCmd: TDBMemoFocus;
    Splitter1: TSplitter;
    cxgUltimosProcessosTableView1Column1: TcxGridDBColumn;
    cxgUltimosProcessosTableView1Column2: TcxGridDBColumn;
    cxgUltimosProcessosTableView1Column3: TcxGridDBColumn;
    cxgUltimosProcessosTableView1Column4: TcxGridDBColumn;
    qryUltimos: TUniQuery;
    dtsUltimos: TDataSource;
    qryProcessar: TUniQuery;
    dspProcessar: TUniDataSetProvider;
    cdsProcessar: TUniClientDataSet;
    cdsProcessarSVC_COMAND: TStringField;
    cdsProcessarSVC_DTTINC: TDateTimeField;
    cdsProcessarSVC_DTTEXC: TDateTimeField;
    cdsProcessarSVC_DTTFIN: TDateTimeField;
    cdsProcessarSVC_LOGCMD: TBlobField;
    cdsProcessarSVC_COMAUX: TStringField;
    tmrTarefas: TTimer;
    btnUpdate: TBitBtnLocked;
    ApplicationEvents1: TApplicationEvents;
    chkOcultarTarefasRealizadas: TCheckBox;
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure tmrIniciaTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMinimizaClick(Sender: TObject);
    procedure DatabaseAfterConnect(Sender: TObject);
    procedure DatabaseAfterDisconnect(Sender: TObject);
    procedure btmExecTarefasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrTarefasTimer(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure chkOcultarTarefasRealizadasClick(Sender: TObject);
    procedure spNumRegChange(Sender: TObject);
  private
    FLockMonitor: string;
    procedure pAtualizaUltimosExecutados;
    procedure pExecutarTarefas;
    procedure CMavisos(var Msg: TMessage); message CM_AVISOS;
  public
    { Public declarations }
  end;

var
  frmAutcomSvc: TfrmAutcomSvc;

implementation

{$R *.dfm}

uses untFuncoes, untLogAut;

function SVC_COMAND_LIKE: string;
begin
  if HasParam('SVC_COMAND_LIKE=') then
    Result := GetParamValue('SVC_COMAND_LIKE=')
  else
    Result := '%';
end;

procedure TfrmAutcomSvc.ApplicationEvents1Minimize(Sender: TObject);
begin
  Self.Hide;
end;

procedure TfrmAutcomSvc.btmExecTarefasClick(Sender: TObject);
begin
  pExecutarTarefas;
end;

procedure TfrmAutcomSvc.btnMinimizaClick(Sender: TObject);
begin
  Self.Hide;
end;

procedure TfrmAutcomSvc.btnUpdateClick(Sender: TObject);
begin
  pAtualizaUltimosExecutados;
end;

procedure TfrmAutcomSvc.chkOcultarTarefasRealizadasClick(Sender: TObject);
begin
  lblNumReg1.Visible := not chkOcultarTarefasRealizadas.Checked;
  lblNumReg2.Visible := not chkOcultarTarefasRealizadas.Checked;
  spNumReg.Visible   := not chkOcultarTarefasRealizadas.Checked;
  pAtualizaUltimosExecutados;
end;

procedure TfrmAutcomSvc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('Confirma encerrar a aplicação e as tarefas sendo executadas?',
    mtConfirmation, [mbNo, mbYes], 0) <> mrYes then
  begin
    Action := caNone;
    Exit;
  end;
  Application.Terminate;
  fLock_Unlock(CHAVE_LCKATC, False);
  TLogAut.New.pLogout;
  Database.Connected := False;
end;

procedure TfrmAutcomSvc.FormCreate(Sender: TObject);
begin
  tmrInicia.Enabled := True;
end;

procedure TfrmAutcomSvc.pAtualizaUltimosExecutados;
begin
  if Not Database.Connected Then
  Begin
    If not fAbrirBanco(Database) Then
      Exit;
  End;

  With qryUltimos, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT ');
    Add('  T1.* ');
    Add('FROM ');
    Add('  (SELECT ');
    Add('    * ');
    Add('  FROM ');
    Add('    AUTSVC ');
    Add('  WHERE SVC_COMAND LIKE "' + SVC_COMAND_LIKE + '" ');
    Add('    AND SVC_DTTFIN IS NULL) AS T1 ');

    if not chkOcultarTarefasRealizadas.Checked then
    begin
      Add('UNION ');
      Add('SELECT ');
      Add('  T2.* ');
      Add('FROM ');
      Add('  (SELECT ');
      Add('    * ');
      Add('  FROM ');
      Add('    AUTSVC ');
      Add('  WHERE SVC_COMAND LIKE "' + SVC_COMAND_LIKE + '" ');
      Add('    AND SVC_DTTFIN IS NOT NULL ');
      Add('ORDER BY SVC_DTTINC DESC ');
      Add('  LIMIT ' + IntToStr(Max(spNumReg.Value, 0)) + ') AS T2 ');
    end;

    Add('ORDER BY SVC_DTTINC DESC ');
    Open;
  End;

  pZerarTentativasLock(CHAVE_LCKATC);

  cxgUltimosProcessosTableView1.ApplyBestFit();
end;

procedure TfrmAutcomSvc.pExecutarTarefas;
  Var
    strDir : String;
    intInterval : Integer;
begin
  intInterval := StrToIntDef(fArqIni(0, 'AUTCOMSVC', 'INTERVAL', '15000'), 15000);
  Try
    btmExecTarefas.Enabled := False;
    tmrTarefas.Enabled := False;

    If cdsProcessar.Active Then
    Begin
      cdsProcessar.EmptyDataSet;
      cdsProcessar.Close;
    End;

    if Not Database.Connected Then
    Begin
      If not fAbrirBanco(Database) Then
        Exit;
    End;

    If FLockMonitor <> fGetIdConnectionLock(CHAVE_LCKATC) Then
    Begin
      Application.Terminate;
      Exit;
    End;

    cdsProcessar.Open;
    cdsProcessar.First;

    strDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

    While Not cdsProcessar.Eof Do
    Begin
      if Application.Terminated then
        Break;

      if (cdsProcessar.RecordCount > 5) and (cdsProcessar.RecNo mod 5 = 0) then
        Break;

      StatusBar.Panels[1].Text := 'Status: Processando ' + IntToStr(cdsProcessar.RecNo) + ' de ' + IntToStr(cdsProcessar.RecordCount);

      cdsProcessar.Edit;
      cdsProcessarSVC_DTTEXC.Value := Now;
      cdsProcessar.Post;

      if not cdsProcessarSVC_COMAUX.AsString.IsEmpty then
        fCriarProcesso(strDir + string(cdsProcessarSVC_COMAUX.Value), strDir, True, False, True)
      else
        fCriarProcesso(strDir + 'Autcom.exe ' + string(cdsProcessarSVC_COMAND.Value), strDir, True, False, True);

      cdsProcessar.Edit;
      cdsProcessarSVC_DTTFIN.Value := Now;
      cdsProcessar.Post;

      cdsProcessar.Next;

      pZerarTentativasLock(CHAVE_LCKATC);
    End;

    cdsProcessar.ApplyUpdates(0);
    pAtualizaUltimosExecutados;
    StatusBar.Panels[1].Text := 'Status: Aguardando ' + FormatDateTime('dd/MM/yyyy hh:nn:ss', IncMilliSecond(now, intInterval) );
  Except
    On E: Exception Do
    Begin
      StatusBar.Panels[1].Text := 'Status: ' + E.Message;
      pLog(StatusBar.Panels[1].Text);
    End;
  End;

  tmrTarefas.Interval := intInterval;
  tmrTarefas.Enabled  := True;
  btmExecTarefas.Enabled := True;
end;

procedure TfrmAutcomSvc.spNumRegChange(Sender: TObject);
begin
  pAtualizaUltimosExecutados;
end;

procedure TfrmAutcomSvc.tmrIniciaTimer(Sender: TObject);
begin
  tmrInicia.Enabled := False;

  If not fAbrirBanco(Database) Then
  Begin
    Application.Terminate;
    Exit;
  End;

  TLogAut.New.pLogin;

  if not fLock_Unlock(CHAVE_LCKATC, True, False, False, '', True) Then
  Begin
    MessageDlg('Monitor de Tarefas do Autcom já está sendo executado na estação: ' + fGetHostLock(CHAVE_LCKATC, True) + ' !', mtError, [mbOK], 0);
    Application.Terminate;
    Exit;
  End;

  FLockMonitor := fGetIdConnectionLock(CHAVE_LCKATC);

  pAtualizaUltimosExecutados;
  pExecutarTarefas;
end;

procedure TfrmAutcomSvc.tmrTarefasTimer(Sender: TObject);
begin
  pExecutarTarefas;
end;

procedure TfrmAutcomSvc.TrayIcon1DblClick(Sender: TObject);
begin
  Self.Show;
end;

procedure TfrmAutcomSvc.CMavisos(var Msg: TMessage);
  Var
    strTexto : String;
begin
  if cdsProcessar.IsEmpty then
    Exit;

  SetLength(strTexto,255);
  SetLength(strTexto,GlobalGetAtomName(Msg.lParam,Pchar(strTexto),255));

  strTexto := strTexto + #13;

  Try
    cdsProcessar.Edit;
    cdsProcessarSVC_LOGCMD.AsString := cdsProcessarSVC_LOGCMD.AsString + strTexto;
    cdsProcessar.Post;
  Except
    On E: Exception Do
    Begin
      StatusBar.Panels[1].Text := 'Status: ' + E.Message;
      pLog(StatusBar.Panels[1].Text);
    End;
  End;

  GlobalDeleteAtom(Msg.lParam);
end;

procedure TfrmAutcomSvc.DatabaseAfterConnect(Sender: TObject);
begin
  StatusBar.Panels[0].Text := 'Conectado';
end;

procedure TfrmAutcomSvc.DatabaseAfterDisconnect(Sender: TObject);
begin
  If Assigned(StatusBar) Then
    StatusBar.Panels[0].Text := 'Desconectado';

end;

{ TStrMsgObject }

constructor TStrMsgObject.Create(aMsg: string);
begin
  Inherited Create;
  fMsg := aMsg;
end;

Initialization
  RegisterClass(TfrmAutcomSvc);

Finalization
  UnRegisterClass(TfrmAutcomSvc);

end.
