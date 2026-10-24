unit untUtilMonitor;

interface

uses
  Winapi.Windows;

type
  TResultExecute = record
    Modified : Boolean;
  End;

  IMonitorProcedure = interface
  ['{33A9A1B2-8EFB-4FF6-AE80-455173B50571}']
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute : TResultExecute;
  end;

  IMonitor = interface
  ['{00228875-0959-4C67-A893-D1D526BB722A}']
    function IdMonitor(const AValue: String): IMonitor;
    function TimeLimit(const AValue: Integer): IMonitor;
    function LockMonitor(const AValue: String): IMonitor;
    function ProcedureExec(const AProc: IMonitorProcedure): IMonitor;
    function WaitInterval(const AValue: Integer): IMonitor;
    procedure pStart;
  end;

  TTipoMonitor = (tmMonitor_Fat_Automatico,
                  tmMonitor_MonitorNotificacoes,
                  tmMonitor_MonitorGatilhosImediatos,
                  tmMonitor_MonitorGatilhosInformacao,
                  tmMonitor_Desmembramento_Pedido_PIX,
                  tmMonitor_Lotes_WMS,
                  tmMonitor_Contabil,
                  tmMonitor_Envia_Registros_Fusion,
                  tmMonitor_Romaneio_Integ_Fusion,
                  tmMonitor_Envio_Extrato_Cobranca,
                  tmMonitor_Gera_Boletos,
                  tmMonitor_PrecoTinta,
                  tmMonitor_Auditoria,
                  tmMonitor_Entrega_Futura,
                  tmMonitor_Status,
                  tmMonitor_Reserva_Item,
                  tmMonitor_Cancelador_Automatico);

  TTipoMonitorHelper = record helper for TTipoMonitor
    class function Max: integer; static;
  end;

  TMonitor = class sealed(TInterfacedObject, IMonitor)
  private
    FIdMonitor: String;
    FTimeLimit: Integer;
    FLockMonitor: String;
    FProcedureExec: IMonitorProcedure;
    FWaitInterval: Integer;
    function fStopLoopMonitor(LStart: TDateTime; strIdMonitor: string):boolean;
  protected
    constructor Create();
  public
    function IdMonitor(const AValue: String): IMonitor;
    function TimeLimit(const AValue: Integer): IMonitor;
    function LockMonitor(const AValue: String): IMonitor;
    function ProcedureExec(const AProc: IMonitorProcedure): IMonitor;
    function WaitInterval(const AValue: Integer): IMonitor;

    procedure pStart;

    class function New: IMonitor;
  end;

  TUtilMonitor = class sealed
  public
    class function fLockMonitor(const AId: String; var ALockMonitor: String; const AMonitorSuspenso: Boolean = False): Boolean;
    class function fRemoveLockMonitor(const AId: String; const AMonitorSuspenso: Boolean = False; const ARecuperarIDConexaoDoLock: Boolean = False): Boolean;
    class function fMonitorIsRunning(const AId: String): Boolean;
    class function fMonitorSuspenso(const AId: String): Boolean;

    class procedure pRunMonitor(const AId: String; var AProccess: TProcessInformation;
      var AUltimaExecucao: TDateTime; const AMonitorExeName: String; const AParams: String;
      ACaminhoMonitor: String = '');

    class procedure pTestInactivity(const AId: String; const ATimeLimit: Integer; const AProccess: TProcessInformation; var AUltimaExecucao: TDateTime);
    class procedure pClearAttemptsLock(const AId: String; const AAttempts: Integer);
    class function fGetTempoDuracaoLock(const AId: String; blnSemEmpresa: boolean=False): Double;
    class procedure pDestravaLockForcado(strNomeTabela: String; intTentat: Integer=10);
  end;

implementation

uses
  Vcl.Forms,
  System.SysUtils,
  System.DateUtils,
  untFuncoesSimples;

{ TUtilMonitor }

class function TUtilMonitor.fLockMonitor(const AId: String; var ALockMonitor: String; const AMonitorSuspenso: Boolean = False): Boolean;
var
  strId : String ;
  blnSemEmpresa : boolean ;
begin
  blnSemEmpresa := pos('%s',AId) = 0 ;
  if blnSemEmpresa then
    strId := AId
  else
    strid := Format(AId, [VS_strCodEmp]) ;

  if AMonitorSuspenso then
    strId := strId + '_SUSPENSO';

  Result := fLock_Unlock(strId, True, False, False, '', False);
  If Result Then
    ALockMonitor := fGetIdConnectionLock(strId);
end;

class function TUtilMonitor.fGetTempoDuracaoLock(const AId: String; blnSemEmpresa:boolean=False): Double;
var
  strId: String;
begin
  if blnSemEmpresa then
    strId := AId
  else
    strId := Format(AId, [VS_strCodEmp]);
  result := untFuncoesSimples.fGetTempoDuracaoLock(strId) ;
end;

class procedure TUtilMonitor.pDestravaLockForcado(strNomeTabela: String;
  intTentat: Integer=10);
begin
  untFuncoesSimples.pDestravaLockForcado(strNomeTabela, intTentat);
end;

class function TUtilMonitor.fMonitorIsRunning(const AId: String): Boolean;
var
  strId: String;
  blnSemEmpresa: boolean;
begin
  blnSemEmpresa := pos('%s',AId) = 0;
  if blnSemEmpresa then
    strId := AId
  else
    strId := Format(AId, [VS_strCodEmp]);
  Result := Not fEmptyStr(fGetHostLock(strid, True));
  If Result Then
    fLock_Unlock(strid, True, False, False, '', False);
end;

class function TUtilMonitor.fMonitorSuspenso(const AId: String): Boolean;
var
  strId: String;
  blnSemEmpresa: boolean;
begin
  blnSemEmpresa := pos('%s',AId) = 0;
  if blnSemEmpresa then
    strId := AId
  else
    strId := Format(AId, [VS_strCodEmp]);

  strId := strId + '_SUSPENSO';

  Result := Not fEmptyStr(fGetHostLock(strid, True));
end;

class function TUtilMonitor.fRemoveLockMonitor(const AId: String; const AMonitorSuspenso: Boolean = False; const ARecuperarIDConexaoDoLock: Boolean = False): Boolean;
var
  strId: String;
  blnSemEmpresa: boolean;
  LConId: String;
begin
  blnSemEmpresa := pos('%s',AId) = 0;
  if blnSemEmpresa then
    strId := AId
  else
    strId := Format(AId, [VS_strCodEmp]);

  if AMonitorSuspenso then
    strId := strId + '_SUSPENSO';

  LConId := IIF(ARecuperarIDConexaoDoLock, untFuncoesSimples.fRetornaCon_Id_Trava(strId), '');

  fLock_Unlock(strId, False, False, False, LConId, False);
  Result := True;
end;

class procedure TUtilMonitor.pClearAttemptsLock(const AId: String; const AAttempts: Integer);
var
  strId: String;
  blnSemEmpresa: boolean;
begin
  blnSemEmpresa := pos('%s',AId) = 0;
  if blnSemEmpresa then
    strId := AId
  else
    strId := Format(AId, [VS_strCodEmp]);
  If (fGetTentativasLock(strid) > AAttempts) Then
    pDestravaLockForcado(strid, AAttempts);
end;

class procedure TUtilMonitor.pRunMonitor(const AId: String; var AProccess: TProcessInformation;
  var AUltimaExecucao: TDateTime; const AMonitorExeName: String; const AParams: String;
  ACaminhoMonitor: String = '');
Var
  LMonitorExeName: String;
  LParams: String;
begin
  If (Not fMonitorIsRunning(AId)) And (Not fEmptyStr(VS_strCodEmp)) Then
  Begin
    LMonitorExeName := ACaminhoMonitor;

    If fEmptyStr(LMonitorExeName) Then
      LMonitorExeName := ExtractFilePath(Application.ExeName) + '\' + AMonitorExeName;


    LParams := AParams;

    If LParams <> '' Then
      LParams := ' ' + LParams;

    If Pos(Concat(' ', VS_strCodEmp), LParams) = 0 Then
      LParams := Concat(LParams, ' ', VS_strCodEmp);

    If FileExists(LMonitorExeName) Then
      fCriarProcessoSimples(Concat(LMonitorExeName, LParams),
        False, False, AProccess, True);

    AUltimaExecucao := fNow();
  End;
end;

class procedure TUtilMonitor.pTestInactivity(const AId: String; const ATimeLimit: Integer; const AProccess: TProcessInformation; var AUltimaExecucao: TDateTime);
var
  strId: String;
  blnSemEmpresa: boolean;
begin
  blnSemEmpresa := pos('%s',AId) = 0;
  if blnSemEmpresa then
    strId := AId
  else
    strId := Format(AId, [VS_strCodEmp]);
  pDestravaLockForcado(strid, 0);
  If fLock_Unlock(strid, True, False, False, '', False) Then  Begin
    Try
      If (MinutesBetween(fNow(), AUltimaExecucao) >= ATimeLimit + 5) Then
      Begin
        Try
          TerminateProcess(AProccess.hProcess, 0);
          AUltimaExecucao := fNow();
        Except
        End;
      End;
    Finally
      fLock_Unlock(strid, False, False, False, '', False);
    End;
  End;
end;

{ TMonitor }

constructor TMonitor.Create;
begin
  FIdMonitor := '';
  FTimeLimit := 0;
  FLockMonitor := '';
  FProcedureExec := nil;
  FWaitInterval := 3000;
end;

function TMonitor.fStopLoopMonitor(LStart: TDateTime;
  strIdMonitor: string): boolean;
begin
  If (MinutesBetween(fNow(), LStart) >= FTimeLimit) Then
  Begin
    Result := True;
    Exit;
  End;

  If (FLockMonitor <> fGetIdConnectionLock(strIdMonitor)) Then
  Begin
    Result := True;
    Exit;
  End;

  If (VS_blnExitMonitor) Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
end;

function TMonitor.IdMonitor(const AValue: String): IMonitor;
begin
  FIdMonitor := AValue;
  Result := Self;
end;

function TMonitor.LockMonitor(const AValue: String): IMonitor;
begin
  FLockMonitor := AValue;
  Result := Self;
end;

class function TMonitor.New: IMonitor;
begin
  Result := TMonitor.Create();
end;

function TMonitor.ProcedureExec(const AProc: IMonitorProcedure): IMonitor;
begin
  FProcedureExec := AProc;
  Result := Self;
end;

procedure TMonitor.pStart;
var
  LStart: TDateTime;
  strIdMonitor: string ;
  blnSemEmpresa: Boolean ;
  blnGravaLog: Boolean ;
begin
  LStart := fNow();
  blnGravaLog := VS_blnGravaLogTransacao;
  VS_blnGravaLogTransacao := False;
  blnSemEmpresa := pos('%s',FIdMonitor) = 0;

  if blnSemEmpresa then
    strIdMonitor := FIdMonitor
  else
    strIdMonitor := Format(FIdMonitor, [VS_strCodEmp]);

  Try
    While True Do
    Begin
      If Assigned(FProcedureExec) Then
        FProcedureExec.pExecuteAll();

      if Application.Terminated then
        Break;

      if fStopLoopMonitor(LStart, strIdMonitor) then
        break;

      pZerarTentativasLock(strIdMonitor);
      Sleep(FWaitInterval);
      pTrimAppMemorySize();
    End;
  Finally
    pDestravaLockForcado(strIdMonitor, 0);
    VS_blnGravaLogTransacao := blnGravaLog;
  End;
end;

function TMonitor.TimeLimit(const AValue: Integer): IMonitor;
begin
  FTimeLimit := AValue;
  Result := Self;
end;

{ TTipoMonitorHelper }

class function TTipoMonitorHelper.Max: integer;
begin
  result := ord(High(TTipoMonitor))
end;

function TMonitor.WaitInterval(const AValue: Integer): IMonitor;
begin
  Result := Self;
  FWaitInterval := AValue;
end;

end.
