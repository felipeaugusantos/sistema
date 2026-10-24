unit untThreadMonitorAutcom;

interface

uses
  SysUtils, Classes, Uni, DateUtils, Dialogs, untThreadUtils;

type
  TMonitorRep = class(TSafeThread)
  private
    { Private declarations }
    FCodEmp: String;
    FNumIp: String;
    FTmpPar: Integer;
    FPorta: Integer;

    FStaExe: Integer;
    horVerExe: TDateTime;
    strSeqExe: String;

    FStaGer: Integer;
    horVerGer: TDateTime;
    strSeqGer: String;

    FStaEnv: Integer;
    horVerEnv: TDateTime;
    strArqEnv: String;
    dtaDtaEnv: TDateTime;

    FStaCon: Integer;
    FMotCon: String;

    FQtdRep: Integer;
    horVerContRep: TDateTime;

    FQtdExe: Integer;
    horVerContExe: TDateTime;

    Conexao: TUniConnection;
    horVerConexao: TDateTime;

    function fConectaLoja: Boolean;
    procedure pVerificaExecuta;
    procedure pVerificaGera;
    procedure pVerificaEnvia;
    procedure pContaLogRep;
    procedure pContaLogExe;
    function fCriarConexao: TUniConnection;
    function fCriarQueryRep: TUniQuery;
    procedure pGravaLog(strMsg: String);
  protected
    procedure Execute; override;
  public
    constructor Create(strCodEmp, strNumIp: String; intTmpPar, intPorta: Integer); Reintroduce;

    property strCodEmp: String Read FCodEmp;
    property intStaExe: Integer Read FStaExe;
    property intStaGer: Integer Read FStaGer;
    property intStaEnv: Integer Read FStaEnv;
    property intStaCon: Integer Read FStaCon;
    property intQtdRep: integer Read FQtdRep;
    property intQtdExe: Integer Read FQtdExe;
    property intTmpPar: Integer Read FTmpPar Write FTmpPar;

    property strMotCon: String Read FMotCon;

  end;

implementation

uses untModulo, untFuncoesSimples, untTypesSistema;

{ TMonitorReplicacao }

constructor TMonitorRep.Create(strCodEmp, strNumIp: String; intTmpPar, intPorta: Integer);
begin
  inherited Create(True);

  FCodEmp := strCodEmp;
  FNumIp  := strNumIp;
  FTmpPar := intTmpPar;
  FPorta  := intPorta;

  horVerExe := IncSecond(fNow(), intTmpPar+1);
  horVerGer := horVerExe;

  strSeqExe := '';
  strSeqGer := '';

  strArqEnv := '';
  dtaDtaEnv := 0;

  FQtdRep := 0;
  horVerContRep := horVerExe;
  FQtdExe := 0;
  horVerContExe := horVerExe;

  FStaExe := 1;
  FStaGer := 1;
  FStaEnv := 1;
  FStaCon := -1;
  FMotCon := 'AINDA NÃO TENTOU CONECTAR';

  horVerConexao := 0;
end;

procedure TMonitorRep.Execute;
begin
  pLog('TThreadDirectoryExists.Execute');
  While (Not Terminated) Do
  Begin
    Try
      If SecondsBetween(fNow(), horVerConexao) > FTmpPar Then
      Begin
        horVerConexao := fNow();
        If fConectaLoja Then
        Begin
          FStaCon := 1;
          pVerificaExecuta;
          pVerificaGera;
          pVerificaEnvia;
          pContaLogRep;
          pContaLogExe;
        End
        Else
        Begin
          FStaCon := 0;
          FStaExe := 0;
          FStaGer := 0;
          FStaEnv := 0;
        End;
      End;
      Sleep(FTmpPar * 1000);
    Except
      On E: Exception Do
      Begin
        //ShowMessage(E.Message);
        //pMensagensErro(E.Message, '[Execute]');
        pGravaLog(E.Message);
      End;
    End;
  End;

  If Assigned(Conexao) Then
  Begin
    Conexao.Disconnect;
    Conexao.AfterConnect := Nil;
    FreeAndNil(Conexao);
  End;
end;

procedure TMonitorRep.pGravaLog(strMsg: String);
//  Var
//    stlLog: TStringList;
begin
//  stlLog := TStringList.Create;
//  If FileExists('logmonitor.txt') Then
//    stlLog.LoadFromFile('logmonitor.txt');
//
//  stlLog.Add(strMsg);
//  stlLog.SaveToFile('logmonitor.txt');
//  FreeAndNil(stlLog);
end;

function TMonitorRep.fConectaLoja: Boolean;
begin
//  If Assigned(Conexao) Then
//  Begin
//    Conexao.Disconnect;
//    FreeAndNil(Conexao);
//  End;

  If Not Assigned(Conexao) Then
    Conexao := fCriarConexao;

  Try
    FMotCon := '';
    Result  := True;
    If Not Conexao.Connected Then
    Begin
      Conexao.Connect;
      Result := Conexao.Connected;
    End;
  Except
    On E: Exception Do
    Begin
      FMotCon := E.Message;
      pGravaLog('Erro na conexão: ' + E.Message);
      Result := False;
    End;
  End;

end;

function TMonitorRep.fCriarConexao: TUniConnection;
begin
  Result := TUniConnection.Create(Nil);
  Result.Server   := FNumIp;
  Result.Port     := FPorta;
  Result.ProviderName := 'MySQL';
  Result.Database := frmModulo.GetCurrentConnection.Database;
  Result.Username := frmModulo.GetCurrentConnection.Username;
  Result.Password := frmModulo.GetCurrentConnection.Password;
  Result.PoolingOptions.MaxPoolSize := TDefaultPoolingOptions.MaxPoolSize;
  Result.PoolingOptions.MinPoolSize := TDefaultPoolingOptions.MinPoolSize;
  Result.PoolingOptions.Validate := TDefaultPoolingOptions.Validate;
  Result.PoolingOptions.ConnectionLifetime := TDefaultPoolingOptions.ConnectionLifetime;
  Result.Pooling := TDefaultPoolingOptions.Pooling;
  Result.AfterConnect := TModuloEvents.AfterConnect;
end;

procedure TMonitorRep.pContaLogExe;
  Var
    qryExe: TUniQuery;
begin
  qryExe := fCriarQueryRep;
  qryExe.SQL.Add('SELECT COUNT(*) AS QTD FROM LOGEXE WHERE LOG_EXECUT = 0');
  qryExe.Open;

  FQtdExe := qryExe.FieldByName('QTD').AsInteger;

  FreeAndNil(qryExe);
end;

procedure TMonitorRep.pContaLogRep;
  Var
    qryRep: TUniQuery;
begin
  qryRep := fCriarQueryRep;
  qryRep.SQL.Add('SELECT COUNT(*) AS QTD FROM LOGREP WHERE LOG_CARREG = "N"');
  qryRep.Open;

  FQtdRep := qryRep.FieldByName('QTD').AsInteger;

  FreeAndNil(qryRep);
end;

procedure TMonitorRep.pVerificaEnvia;
  Var
    qryEnv: TUniQuery;
begin
  horVerEnv := fNow;

  qryEnv := fCriarQueryRep;
  qryEnv.SQL.Add('SELECT REP_ARQENV, REP_DTAENV FROM REPSTA');
  qryEnv.Open;

  If (Not SameText(strArqEnv, qryEnv.FieldByName('REP_ARQENV').AsString)) Or
     (FormatDateTime('dd/mm/yyyy hh:nn:ss', dtaDtaEnv) <>
      FormatDateTime('dd/mm/yyyy hh:nn:ss', qryEnv.FieldByName('REP_DTAENV').AsDateTime)) Then
  Begin
    FStaEnv := 1;
    strArqEnv := qryEnv.FieldByName('REP_ARQENV').AsString;
    dtaDtaEnv := qryEnv.FieldByName('REP_DTAENV').AsDateTime;
  End
  Else
  Begin
    FStaEnv := 0;
  End;

  FreeAndNil(qryEnv);
end;

procedure TMonitorRep.pVerificaExecuta;
  Var
    qryExe: TUniQuery;
begin
  horVerExe := fNow;

  qryExe := fCriarQueryRep;
  qryExe.SQL.Add('SELECT MIN(LOG_CODIGO) AS CODIGO FROM LOGEXE');
  qryExe.SQL.Add('WHERE LOG_EXECUT = 0');
  qryExe.Open;

  If (qryExe.FieldByName('CODIGO').IsNull)                Or
     (qryExe.FieldByName('CODIGO').AsString <> strSeqExe) Then
  Begin
    FStaExe := 1;
    strSeqExe := qryExe.FieldByName('CODIGO').AsString;
  End
  Else
  Begin
    FStaExe := 0;
  End;

  FreeAndNil(qryExe);
end;

procedure TMonitorRep.pVerificaGera;
  Var
    qryGer: TUniQuery;
begin
  horVerGer := fNow;

  qryGer := fCriarQueryRep;
  qryGer.SQL.Add('SELECT MIN(LOG_CODIGO) AS CODIGO FROM LOGREP');
  qryGer.SQL.Add('WHERE LOG_CARREG = "N"');
  qryGer.Open;

  If (qryGer.FieldByName('CODIGO').IsNull)                Or
     (qryGer.FieldByName('CODIGO').AsString <> strSeqGer) Then
  Begin
    FStaGer := 1;
    strSeqGer := qryGer.FieldByName('CODIGO').AsString;
  End
  Else
  Begin
    FStaGer := 0;
  End;

  FreeAndNil(qryGer);
end;

function TMonitorRep.fCriarQueryRep: TUniQuery;
begin
  Result := TUniQuery.Create(Nil);
  Result.Connection := Conexao;
end;

end.
