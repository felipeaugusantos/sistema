unit untLogAut;

interface

uses SysUtils, Classes, {$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280)}Data.DB{$ELSE}DB{$IFEND},
  {$IF Defined(UNIDAC)}
    DBAccess, Uni, UniProvider, MySQLUniProvider,
  {$ELSE}
    ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  StrUtils;

type
  TLogAut = class
  private
    const
      SVN_REPOSITORY = 'svn://srvprg1.citelsoftware.com.br';
      OPERADOR_ADMIN = '999';
  private
    FAutInc : String;
    FConId : String;
    FProcId : String;
    FCodEmp : String;
    FAchouOperador : Boolean;
    FWorkstationID : String;
    FWorkStationIP : String;
    FCampoProcIdExiste : Boolean;
    FConnection : {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection{$IFEND};
    function SQLInsertLogin(const ACampoSvnRevExiste, ACampoUrlSvnExiste : Boolean): String;
    function SQLUpdateLogout(const AAtualizaOperador : Boolean): String;
    function GetOperadorLogado : String;
    function GetParams : String;
    function LogAceValida : Boolean;
    {$IF Defined(UNIDAC)}
    function GetVersionSvn(const ASvnUrl : String): String;
    {$IFEND}
  public
    procedure pLogin;
    procedure pLogout;
    procedure pAtualizarEmpresa(const ACodEmp : String);
    constructor Create(const AConnection : {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection{$IFEND}; const ACodEmp : String);
  End;

implementation

uses untUtil, Forms, untWorkStationInfo, Windows;

{ TLogAut }

procedure TLogAut.pAtualizarEmpresa(const ACodEmp: String);
  Var
    LQry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fEmptyStr(FAutInc) Then
    Exit;
  LQry := fCriaQuery();
  Try
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(' UPDATE LOGACE ');
    LQry.SQL.Add('    SET LOG_CODEMP = :CODEMP ');
    LQry.SQL.Add('  WHERE AUTOINCREM = :AUTINC ');
    LQry.ParamByName('CODEMP').AsString := ACodEmp;
    LQry.ParamByName('AUTINC').AsString := FAutInc;
    LQry.ExecSQL;
  Finally
    FreeAndNil(LQry);
  End;
end;

procedure TLogAut.pLogin;
  {$IF Defined(UNIDAC)}
    {$I rev.inc}
  {$IFEND}
  Var
    LQry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LDtaExe : TDateTime;
    LCampoSvnRevExiste : Boolean;
    LCampoUrlSvnExiste : Boolean;
begin
  If Not fConexaoAtiva(FConnection) Then
    Exit;
  If (Not LogAceValida) Then
    Exit;
  FConId := fConnectionID;
  FProcId := IntToStr(GetCurrentProcessId);
  FWorkstationID := TWorkStationInfo.fGetWorkstationID;
  FWorkStationIP := TWorkStationInfo.fGetWorkStationIP;
  FileAge(Application.ExeName, LDtaExe);
  FCampoProcIdExiste := fCampoExiste('LOGACE', 'LOG_PROCID');
  LCampoSvnRevExiste := fCampoExiste('LOGACE', 'LOG_SVNREV');
  LCampoUrlSvnExiste := fCampoExiste('LOGACE', 'LOG_URLSVN');
  LQry := fCriaQuery();
  Try
    FAutInc := fRetAutoIncrem('LOGACE', FCodEmp);
    LQry.SQL.Add(SQLInsertLogin(LCampoSvnRevExiste, LCampoUrlSvnExiste));
    LQry.ParamByName('AUTINC').AsString := FAutInc;
    LQry.ParamByName('CON_ID').AsString := FConId;
    LQry.ParamByName('CODOPE').AsString := GetOperadorLogado;
    LQry.ParamByName('CODEMP').AsString := FCodEmp;
    LQry.ParamByName('NUM_IP').AsString := VS_IPAddressAsString;
    LQry.ParamByName('MACADD').AsString := VS_MacAddress;
    LQry.ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
    LQry.ParamByName('NOMUSU').AsString := VS_UserFromWindows;
    LQry.ParamByName('DTAEXE').AsDateTime := LDtaExe;
    LQry.ParamByName('WTSMAQ').AsString := FWorkstationID;
    LQry.ParamByName('WTS_IP').AsString := FWorkStationIP;
    LQry.ParamByName('PATEXE').AsString := ExtractFilePath(Application.ExeName);
    LQry.ParamByName('NOMEXE').AsString := ExtractFileName(Application.ExeName);
    LQry.ParamByName('DTAENT').AsDate := Date;
    LQry.ParamByName('HRAENT').AsTime := Time();
    LQry.ParamByName('PARAMS').AsString := GetParams;
    If FCampoProcIdExiste Then
      LQry.ParamByName('PROCID').AsString := FProcId;
    {$IF Defined(UNIDAC) And (RTLVersion >= 28)}
    If LCampoUrlSvnExiste Then
    Begin
      LQry.ParamByName('URLSVN').AsString := SVN_URL;
      LQry.ParamByName('VERSVN').AsString := GetVersionSvn(SVN_URL);
    End;
    If LCampoSvnRevExiste Then
      LQry.ParamByName('SVNREV').AsInteger := StrToIntDef(SVN_REVISION, 0);
    {$ELSE}
    If LCampoUrlSvnExiste Then
    Begin
      LQry.ParamByName('URLSVN').AsString := '';
      LQry.ParamByName('VERSVN').AsString := '';
    End;
    If LCampoSvnRevExiste Then
      LQry.ParamByName('SVNREV').AsInteger := 0;
    {$IFEND}
    LQry.ParamByName('VEREXE').AsString := fRetornaVersao(Application.ExeName);
    LQry.ParamByName('VERPRO').AsString := fRetornaVersao(Application.ExeName, True);
    LQry.ExecSQL();
  Finally
    FreeAndNil(LQry);
  End;
end;

procedure TLogAut.pLogout;
  Var
    LQry : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LAtualizaOperador : Boolean;
    LCodigoOperador : String;
begin
  If fEmptyStr(FAutInc) Then
    Exit;
  LQry := fCriaQuery();
  Try
    LCodigoOperador := '';
    If (Not FAchouOperador) Then
      LCodigoOperador := GetOperadorLogado;
    LAtualizaOperador := (Not fEmptyStr(LCodigoOperador)) And (LCodigoOperador <> OPERADOR_ADMIN);
    LQry.SQL.Add(SQLUpdateLogout(LAtualizaOperador));
    LQry.ParamByName('DTASAI').AsDate := Date;
    LQry.ParamByName('HRASAI').AsTime := Time();
    LQry.ParamByName('AUTINC').AsString := FAutInc;
    If (LAtualizaOperador) Then
      LQry.ParamByName('CODOPE').AsString := LCodigoOperador;
    LQry.ExecSQL();
  Finally
    FreeAndNil(LQry);
  End;
end;

constructor TLogAut.Create(const AConnection : {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection{$IFEND}; const ACodEmp : String);
begin
  FAchouOperador := False;
  FAutInc := '';
  FConId := '';
  FProcId := '';
  FWorkStationIP := '';
  FWorkstationID := '';
  FConnection := AConnection;
  FCodEmp := ACodEmp;
end;

function TLogAut.SQLInsertLogin(const ACampoSvnRevExiste, ACampoUrlSvnExiste : Boolean): String;
begin
  Result := '';
  Result := Result + 'INSERT INTO LOGACE (                                    ';
  Result := Result + '  AUTOINCREM,                                           ';
  Result := Result + '  LOG_CODEMP,                                           ';
  Result := Result + '  LOG_CODOPE,                                           ';
  Result := Result + '  LOG_CON_ID,                                           ';
  Result := Result + '  LOG_NUM_IP,                                           ';
  Result := Result + '  LOG_MACADD,                                           ';
  Result := Result + '  LOG_NOMMAQ,                                           ';
  Result := Result + '  LOG_NOMUSU,                                           ';
  Result := Result + '  LOG_DTAEXE,                                           ';
  Result := Result + '  LOG_VEREXE,                                           ';
  Result := Result + '  LOG_PATEXE,                                           ';
  Result := Result + '  LOG_NOMEXE,                                           ';
  Result := Result + '  LOG_DTAENT,                                           ';
  Result := Result + '  LOG_HRAENT,                                           ';
  Result := Result + '  LOG_VERPRO,                                           ';
  Result := Result + '  LOG_WTSMAQ,                                           ';
  Result := Result + '  LOG_WTS_IP,                                           ';
  if FCampoProcIdExiste then
    Result := Result + '  LOG_PROCID,                                         ';
  if ACampoSvnRevExiste then
    Result := Result + '  LOG_SVNREV,                                         ';
  if ACampoUrlSvnExiste then
  begin
    Result := Result + '  LOG_URLSVN,                                         ';
    Result := Result + '  LOG_VERSVN,                                         ';
  end;
  Result := Result + '  LOG_PARAMS                                            ';
  Result := Result + ') VALUES (                                              ';
  Result := Result + '  :AUTINC,                                              ';
  Result := Result + '  :CODEMP,                                              ';
  Result := Result + '  :CODOPE,                                              ';
  Result := Result + '  :CON_ID,                                              ';
  Result := Result + '  :NUM_IP,                                              ';
  Result := Result + '  :MACADD,                                              ';
  Result := Result + '  :NOMMAQ,                                              ';
  Result := Result + '  :NOMUSU,                                              ';
  Result := Result + '  :DTAEXE,                                              ';
  Result := Result + '  :VEREXE,                                              ';
  Result := Result + '  :PATEXE,                                              ';
  Result := Result + '  :NOMEXE,                                              ';
  Result := Result + '  :DTAENT,                                              ';
  Result := Result + '  :HRAENT,                                              ';
  Result := Result + '  :VERPRO,                                              ';
  Result := Result + '  :WTSMAQ,                                              ';
  Result := Result + '  :WTS_IP,                                              ';
  if FCampoProcIdExiste then
    Result := Result + '  :PROCID,                                            ';
  if ACampoSvnRevExiste then
    Result := Result + '  :SVNREV,                                            ';
  if ACampoUrlSvnExiste then
  begin
    Result := Result + '  :URLSVN,                                            ';
    Result := Result + '  :VERSVN,                                            ';
  end;
  Result := Result + '  IF(:PARAMS="",NULL,:PARAMS))                          ';
end;

function TLogAut.SQLUpdateLogout(const AAtualizaOperador : Boolean): String;
begin
  Result := '';
  Result := Result + ' UPDATE LOGACE ';
  Result := Result + '    SET LOG_DTASAI = :DTASAI ';
  Result := Result + '       ,LOG_HRASAI = :HRASAI ';
  If (AAtualizaOperador) Then
    Result := Result + '     ,LOG_CODOPE = :CODOPE ';
  Result := Result + '  WHERE AUTOINCREM = :AUTINC ';
end;

function TLogAut.GetOperadorLogado: String;
  Var
    LQry : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := OPERADOR_ADMIN;
  If (Not FCampoProcIdExiste) Then
    Exit;
  LQry := fCriaQuery();
  Try
    FAchouOperador := False;
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(' SELECT LOG_CODOPE ');
    LQry.SQL.Add('   FROM LOGACE ');
    LQry.SQL.Add('  INNER JOIN information_schema.PROCESSLIST PL ON PL.ID = LOG_CON_ID ');
    LQry.SQL.Add('  WHERE LOG_WTSMAQ = :WTSMAQ ');
    LQry.SQL.Add('    AND LOG_NOMEXE = :NOMEXE ');
    LQry.SQL.Add('    AND LOG_MACADD = :MACADD ');
    LQry.SQL.Add('    AND LOG_NUM_IP = :NUM_IP ');
    LQry.SQL.Add('    AND LOG_NOMMAQ = :NOMMAQ ');
    LQry.SQL.Add('    AND LOG_CODEMP = :CODEMP ');
    LQry.SQL.Add('    AND LOG_NOMUSU = :NOMUSU ');
    LQry.SQL.Add('    AND LOG_WTS_IP = :WTS_IP ');
    LQry.SQL.Add('    AND LOG_DTAENT >= DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) ');
    LQry.SQL.Add('  ORDER BY LOG_DTAENT DESC, LOG_HRAENT DESC ');
    LQry.SQL.Add('  LIMIT 1 ');
    LQry.ParamByName('WTSMAQ').AsString := FWorkstationID;
    LQry.ParamByName('NOMEXE').AsString := 'autcom.exe';
    LQry.ParamByName('MACADD').AsString := VS_MacAddress;
    LQry.ParamByName('NUM_IP').AsString := VS_IPAddressAsString;
    LQry.ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
    LQry.ParamByName('CODEMP').AsString := FCodEmp;
    LQry.ParamByName('NOMUSU').AsString := VS_UserFromWindows;
    LQry.ParamByName('WTS_IP').AsString := FWorkStationIP;
    LQry.Open;
    If LQry.IsEmpty Then
      Exit;
    FAchouOperador := True;
    Result := LQry.FieldByName('LOG_CODOPE').AsString;
  Finally
    FreeAndNil(LQry);
  End;
end;

function TLogAut.GetParams: String;
  Var
    LCount : Integer;
begin
  Result := '';
  If (ParamCount <= 0) Then
    Exit;
  For LCount := 1 To ParamCount Do
  Begin
    If fEmptyStr(Result) Then
      Result := Result + ParamStr(LCount)
    Else
      Result := Result + ' ' + ParamStr(LCount);
  End;
end;

{$IF Defined(UNIDAC)}
function TLogAut.GetVersionSvn(const ASvnUrl : String): String;
  Const
    STR_PAINEL_HOME = '/PainelNFe/';
    STR_PAINEL_PCK = '/Packages/';
  Var
    LPosFin : Integer;
    LPosIni : Integer;
begin
  Result := '';
  If fEmptyStr(ASvnUrl) Then
    Exit;
  LPosIni := Pos(STR_PAINEL_HOME, ASvnUrl);
  If LPosIni <= 0 Then
    Exit;
  LPosFin := Pos(STR_PAINEL_PCK, ASvnUrl);
  If LPosFin <= 0 Then
    Exit;
  Result := Copy(ASvnUrl, LPosIni + Length(STR_PAINEL_HOME), LPosFin - (LPosIni + Length(STR_PAINEL_HOME)));
end;
{$IFEND}

function TLogAut.LogAceValida: Boolean;
  Var
    LQry : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  LQry := fCriaQuery();
  Try
    Try
      Result := False;
      LQry.SQL.Text := 'SELECT * FROM LOGACE WHERE FALSE';
      LQry.Open;
      If (Not Assigned(LQry.FindField('AUTOINCREM'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_CODEMP'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_CODOPE'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_CON_ID'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_NUM_IP'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_MACADD'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_NOMMAQ'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_NOMUSU'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_DTAEXE'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_VEREXE'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_PATEXE'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_NOMEXE'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_DTAENT'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_HRAENT'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_VERPRO'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_WTSMAQ'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_WTS_IP'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_PARAMS'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_DTASAI'))) Then
        Exit;
      If (Not Assigned(LQry.FindField('LOG_HRASAI'))) Then
        Exit;
      Result := True;
    Finally
      FreeAndNil(LQry);
    End;
  Except
    Result := False;
  End;
end;

end.
