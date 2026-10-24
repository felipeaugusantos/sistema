unit untLibContaBancariaHorarioSistema;

interface

uses
 {$IFDEF LINUX}
  Services.Core.Connection.Interfaces;
 {$ELSE}
  Uni;
 {$ENDIF}

function GetTime(): TDateTime; overload;
function GetTime(const ACodigoEmpresa : String; AConnection : {$IFDEF LINUX} IConnection {$ELSE} TUniConnection {$ENDIF}): TDateTime; overload;

procedure DefinirTimeZoneEmSessaoMySql(const AConnection : {$IFDEF LINUX} IConnection {$ELSE} TUniConnection {$ENDIF}; const ACodigoEmpresa : String; const AChecarConfiguracao : Boolean = True);
procedure LimparDicionarioConfiguracoesHorario;

implementation

uses
 {$IFDEF LINUX}
  Services.Core.Utils,
 {$ELSE}
  Winapi.Windows,
 {$ENDIF}
  System.SysUtils,
  System.DateUtils,
  System.Generics.Collections;

{$IFDEF LINUX}
type
  TTimeZoneInformation = record
    Bias: Longint;
  end;
{$ENDIF}

Var
  TimeZoneInCache: Boolean;
  DicConfigHorario: TDictionary<String, String>;
  TimeZoneInfoCache: TTimeZoneInformation;

{$IFDEF LINUX}
function TimeZoneLocal : Integer;
Var
  LTimeZone: string;
begin
  If (Not TimeZoneInCache) Then
  Begin
    LTimeZone := ShellExecute('date +"%Z"').Trim;
    TimeZoneInfoCache.Bias := LTimeZone.ToInteger() * 60;
    TimeZoneInCache := True;
  End;
  Result := TimeZoneInfoCache.Bias div 60;
end;
{$ELSE}
function TimeZoneLocal : Integer;
begin
  If (Not TimeZoneInCache) Then
  Begin
    GetTimeZoneInformation(TimeZoneInfoCache);
    TimeZoneInCache := True;
  End;
  Result := TimeZoneInfoCache.Bias div -60;
end;
{$ENDIF}

function GetValorConfiguracao(const ACodigoConfiguracao, ACodigoEmpresa : String; const AConnection : {$IFDEF LINUX} IConnection {$ELSE} TUniConnection {$ENDIF}) : String;
  Var
    LQryCfgSis : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF};
    LKey : String;
begin
  Result := EmptyStr;
  If ACodigoConfiguracao.IsEmpty Then
    Exit;
  If ACodigoEmpresa.IsEmpty Then
    Exit;
  If (Not Assigned(AConnection)) Then
    Exit;
  If (Not AConnection.Connected) Then
    Exit;

  LKey := 'CFG_' + ACodigoConfiguracao + ACodigoEmpresa;

  If (Assigned(DicConfigHorario)) Then
  Begin
    If DicConfigHorario.ContainsKey(LKey) Then
      Exit(DicConfigHorario[LKey]);
  End;

  LQryCfgSis := {$IFDEF LINUX} AConnection.CreateQuery {$ELSE} TUniQuery.Create(Nil) {$ENDIF};
  Try
   {$IFNDEF LINUX}
    LQryCfgSis.Connection := AConnection;
    LQryCfgSis.Tag := AConnection.Tag;
    LQryCfgSis.Options.RequiredFields := False;
   {$ENDIF}
    LQryCfgSis.SQL.Text := 'SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP';
    LQryCfgSis.ParamByName('CODCFG').AsString := 'CFG_' + ACodigoConfiguracao;
    LQryCfgSis.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LQryCfgSis.Open;
    Result := LQryCfgSis.FieldByName('SIS_VALCFG').AsString;
    If (Assigned(DicConfigHorario)) Then
      DicConfigHorario.AddOrSetValue(LKey, Result);
  Finally
   {$IFNDEF LINUX}
    FreeAndNil(LQryCfgSis);
   {$ENDIF}
  End;
end;

function TimeZoneConfigurado(const ACodigoEmpresa : String; AConnection : {$IFDEF LINUX} IConnection {$ELSE} TUniConnection {$ENDIF}) : Integer;
  Var
    LTimeZone : String;
begin
  Result := 0;

  LTimeZone := GetValorConfiguracao('TMZONE', ACodigoEmpresa, AConnection);

  If (LTimeZone.IsEmpty) Then
    Exit;

  Result := StrToIntDef(LTimeZone, 0);
end;

{$IFDEF LINUX}
function LocalTimeToUTC(const AValue: TDateTime): TDateTime;
var
  LTimeZone: string;
begin
  If (Not TimeZoneInCache) Then
  Begin
    LTimeZone := ShellExecute('date +"%Z"').Trim;
    TimeZoneInfoCache.Bias := LTimeZone.ToInteger() * 60;
    TimeZoneInCache := True;
  End;
  Result := IncMinute(AValue, -TimeZoneInfoCache.Bias);
end;
{$ELSE}
function LocalTimeToUTC(const AValue: TDateTime): TDateTime;
  Var
    LSysTime1, LSysTime2 : TSystemTime;
    LTimeZoneInfo : TTimeZoneInformation;
begin
  If (Not TimeZoneInCache) Then
  Begin
    GetTimeZoneInformation(TimeZoneInfoCache);
    TimeZoneInCache := True;
  End;
  LTimeZoneInfo := TimeZoneInfoCache;
  LTimeZoneInfo.Bias := -LTimeZoneInfo.Bias;
  LTimeZoneInfo.StandardBias := -LTimeZoneInfo.StandardBias;
  LTimeZoneInfo.DaylightBias := -LTimeZoneInfo.DaylightBias;
  DateTimeToSystemTime(AValue, LSysTime1);
  SystemTimeToTzSpecificLocalTime(@LTimeZoneInfo, LSysTime1, LSysTime2);
  Result := SystemTimeToDateTime(LSysTime2);
end;
{$ENDIF}

function GetTime(): TDateTime;
begin
  Result := Time();
end;

function GetTime(const ACodigoEmpresa : String; AConnection : {$IFDEF LINUX} IConnection {$ELSE} TUniConnection {$ENDIF}): TDateTime;
  Var
    LTimeZoneLocal : Integer;
    LUsaTimeZone : String;
    LTimeZoneConfigurado : Integer;
begin
  If (ACodigoEmpresa.IsEmpty) Then
    Exit(Time());

  LUsaTimeZone := GetValorConfiguracao('USATMZ', ACodigoEmpresa, AConnection);

  If (LUsaTimeZone.IsEmpty) Then
    Exit(Time());

  If (LUsaTimeZone = 'N') Then
    Exit(Time());

  LTimeZoneLocal := TimeZoneLocal();
  LTimeZoneConfigurado := TimeZoneConfigurado(ACodigoEmpresa, AConnection);
  If (LTimeZoneConfigurado <> 0) And (LTimeZoneLocal <> LTimeZoneConfigurado) Then
    Result := IncHour(LocalTimeToUTC(Time()), LTimeZoneConfigurado)
  Else
    Exit(Time());
end;

function CfgTmZoneToMySqlFormatTimeZone(const ACodigoEmpresa : String; AConnection : {$IFDEF LINUX} IConnection {$ELSE} TUniConnection {$ENDIF}): String;
  Const
    arrTimeZonesPemrmitidos : Array [1..4] Of Integer = (-2, -3, -4, -5);
  Var
    LTimeZoneConfigurado : Integer;
    LContador : Integer;
begin
  Result := '-3:00';
  If ACodigoEmpresa.IsEmpty Then
    Exit;
  LTimeZoneConfigurado := TimeZoneConfigurado(ACodigoEmpresa, AConnection);
  If LTimeZoneConfigurado = 0 Then
    Exit;
  For LContador := Low(arrTimeZonesPemrmitidos) To High(arrTimeZonesPemrmitidos) Do
  Begin
    If (arrTimeZonesPemrmitidos[LContador] = LTimeZoneConfigurado) Then
    Begin
      Result := Format('%d:00', [LTimeZoneConfigurado]);
      Exit;
    End;
  End;
end;

procedure DefinirTimeZoneEmSessaoMySql(const AConnection : {$IFDEF LINUX} IConnection {$ELSE} TUniConnection {$ENDIF}; const ACodigoEmpresa : String; const AChecarConfiguracao : Boolean = True);
  Var
   {$IFNDEF LINUX}
    LQryConexao : TUniQuery;
   {$ENDIF}
    LUsaTimeZone : String;
    LSQL: string;
begin
  If ACodigoEmpresa.IsEmpty Then
    Exit;
  If (AChecarConfiguracao) Then
  Begin
    LUsaTimeZone := GetValorConfiguracao('USATMZ', ACodigoEmpresa, AConnection);
    If (LUsaTimeZone.IsEmpty) Or (LUsaTimeZone = 'N') Then
      Exit;
  End;
  LSQL := Format('SET time_zone = %s;', [QuotedStr(CfgTmZoneToMySqlFormatTimeZone(ACodigoEmpresa, AConnection))]);
 {$IFDEF LINUX}
  AConnection.CreateQuery(LSQL).ExecSQL;
 {$ELSE}
  LQryConexao := TUniQuery.Create(Nil);
  Try
    LQryConexao.Connection := AConnection;
    LQryConexao.Tag := AConnection.Tag;
    LQryConexao.Options.RequiredFields := False;
    LQryConexao.SQL.Text := LSQL;
    LQryConexao.ExecSQL;
  Finally
    FreeAndNil(LQryConexao);
  End;
 {$ENDIF}
end;

procedure LimparDicionarioConfiguracoesHorario;
begin
  DicConfigHorario.Clear;
end;

initialization
  DicConfigHorario := TDictionary<String, String>.Create;
  TimeZoneInCache := False;

finalization
  FreeAndNil(DicConfigHorario);


end.
