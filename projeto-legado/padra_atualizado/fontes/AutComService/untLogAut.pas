unit untLogAut;

interface

type
  ILogAut = interface
  ['{89D44045-6980-4D65-BB25-B91DFD0F5F21}']
    procedure pLogin;
    procedure pLogout;
    procedure pUpdate;
  end;

  TLogAut = class sealed(TInterfacedObject, ILogAut)
  const
    sqlLogout      = 'UPDATE LOGACE SET                                       '+
                     '  LOG_DTASAI = :DTASAI,                                 '+
                     '  LOG_HRASAI = :HRASAI                                  '+
                     ' WHERE AUTOINCREM = :AUTINC                             ';

    sqlUpdate      = 'UPDATE LOGACE SET                                       '+
                     '  LOG_CON_ID = :CON_ID,                                 '+
                     '  LOG_CODOPE = :CODOPE,                                 '+
                     '  LOG_CODEMP = :CODEMP                                  '+
                     ' WHERE AUTOINCREM = :AUTINC                             ';

  private
    class var FAutInc: String;

    FCodOpe: String;
    FCodEmp: String;
    FCon_ID: String;
    FNum_Ip: String;
    FMacAdd: String;
    FNomMaq: String;
    FNomUsu: String;
    FDtaExe: TDateTime;
    FVerExe: String;
    FPatExe: String;
    FNomExe: String;
    FVerPro: String;
    FWtsMaq: String;
    FWts_Ip: String;
    FParams: String;
    FProcId: String;

    function fInsert : String;
  protected
    constructor Create;

  public
    procedure pLogin;
    procedure pLogout;
    procedure pUpdate;

    class function New: ILogAut;
  end;

implementation

uses
  Uni,
  Vcl.Forms,
  System.SysUtils,
  strUtils,
  untFuncoes;

{ TLogAut }

constructor TLogAut.Create;
  Var
    intIdx: Integer;
begin
  If fGetConnectionID.IsEmpty Then
    Exit;

  FCodEmp := fRetEmpresaFisica;

  FCodOpe := '999';
  FCon_ID := fGetConnectionID();
  FNum_Ip := GetIPAddressAsString;
  FMacAdd := GetMacAddress;
  FNomMaq := GetComputerNetName;
  FNomUsu := GetUserFromWindows;

  FProcId := GetProcessID;

  FileAge(Application.ExeName, FDtaExe);
  FVerExe := '';
  FVerPro := '';
  FWtsMaq := '';
  FWts_Ip := '';
  FPatExe := ExtractFilePath(Application.ExeName);
  FNomExe := ExtractFileName(Application.ExeName);

  FParams := '';
  If (ParamCount > 0) Then
  Begin
    For intIdx := 1 To ParamCount Do
    Begin
      FParams := FParams + IfThen(FParams.IsEmpty, '', ' ') + ParamStr(intIdx);
    End;
  End;
end;

function TLogAut.fInsert: String;
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
  Result := Result + '  LOG_PROCID,                                           ';
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
  Result := Result + '  :PROCID,                                              ';
  Result := Result + '  IF(:PARAMS="",NULL,:PARAMS))                          ';
end;

class function TLogAut.New: ILogAut;
begin
  Result := TLogAut.Create();
end;

procedure TLogAut.pLogin;
{$I rev.inc}
var
  LQry: TUniQuery;
begin
  If fGetConnectionID.IsEmpty Then
    Exit;

  If (Not fEmptyStr(FAutInc)) Then
  Begin
    Self.pUpdate;
    Exit;
  End;

  LQry := fCriaQuery();

  Try
    FAutInc := fRetAutoIncrem('LOGACE', FCodEmp);

    LQry.SQL.Add(fInsert);
    LQry.ParamByName('AUTINC').AsString   := FAutInc;
    LQry.ParamByName('CON_ID').AsString   := FCon_ID;
    LQry.ParamByName('CODOPE').AsString   := FCodOpe;
    LQry.ParamByName('CODEMP').AsString   := FCodEmp;
    LQry.ParamByName('NUM_IP').AsString   := FNum_Ip;
    LQry.ParamByName('MACADD').AsString   := FMacAdd;
    LQry.ParamByName('NOMMAQ').AsString   := FNomMaq;
    LQry.ParamByName('NOMUSU').AsString   := FNomUsu;
    LQry.ParamByName('DTAEXE').AsDateTime := FDtaExe;
    LQry.ParamByName('VEREXE').AsString   := FVerExe;
    LQry.ParamByName('VERPRO').AsString   := FVerPro;
    LQry.ParamByName('WTSMAQ').AsString   := FWtsMaq;
    LQry.ParamByName('WTS_IP').AsString   := FWts_IP;
    LQry.ParamByName('PATEXE').AsString   := FPatExe;
    LQry.ParamByName('NOMEXE').AsString   := FNomExe;
    LQry.ParamByName('DTAENT').AsDate     := Date;
    LQry.ParamByName('HRAENT').AsTime     := Time;
    LQry.ParamByName('PARAMS').AsString   := FParams;
    LQry.ParamByName('PROCID').AsString   := FProcId;
    LQry.ExecSQL();
  Finally
    FreeAndNil(LQry);
  End;
end;

procedure TLogAut.pLogout;
var
  LQry: TUniQuery;
begin
  If fGetConnectionID.IsEmpty Then
    Exit;

  If fEmptyStr(FAutInc) Then
    Exit;

  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlLogout);
    LQry.ParamByName('DTASAI').AsDate   := Date;
    LQry.ParamByName('HRASAI').AsTime   := Time;
    LQry.ParamByName('AUTINC').AsString := FAutInc;

    LQry.ExecSQL();
  Finally
    FAutInc := '';
    FreeAndNil(LQry);
  End;
end;

procedure TLogAut.pUpdate;
var
  LQry: TUniQuery;
begin
  If fGetConnectionID.IsEmpty Then
    Exit;

  If fEmptyStr(FAutInc) Then
    Exit;

  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlUpdate);
    LQry.ParamByName('CON_ID').AsString := fGetConnectionID();
    LQry.ParamByName('CODEMP').AsString := FCodEmp;
    LQry.ParamByName('CODOPE').AsString := FCodOpe;
    LQry.ParamByName('AUTINC').AsString := FAutInc;
    LQry.ExecSQL();
  Finally
    FreeAndNil(LQry);
  End;
end;

initialization
  TLogAut.FAutInc := '';

end.
