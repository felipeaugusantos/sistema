unit untLogAut;

interface

type
  ILogAut = interface
  ['{89D44045-6980-4D65-BB25-B91DFD0F5F21}']
  procedure pLogin;
  procedure pLogout;
  end;

  TLogAut = class sealed(TInterfacedObject, ILogAut)
  const
    sqlLogin       = 'INSERT INTO LOGACE (                                    '+
                     '  AUTOINCREM,                                           '+
                     '  LOG_CODEMP,                                           '+
                     '  LOG_CODOPE,                                           '+
                     '  LOG_CON_ID,                                           '+
                     '  LOG_NUM_IP,                                           '+
                     '  LOG_MACADD,                                           '+
                     '  LOG_NOMMAQ,                                           '+
                     '  LOG_NOMUSU,                                           '+
                     '  LOG_DTAEXE,                                           '+
                     '  LOG_VEREXE,                                           '+
                     '  LOG_PATEXE,                                           '+
                     '  LOG_NOMEXE,                                           '+
                     '  LOG_DTAENT,                                           '+
                     '  LOG_HRAENT                                            '+
                     ') VALUES (                                              '+
                     '  :AUTINC,                                              '+
                     '  :CODEMP,                                              '+
                     '  :CODOPE,                                              '+
                     '  :CON_ID,                                              '+
                     '  :NUM_IP,                                              '+
                     '  :MACADD,                                              '+
                     '  :NOMMAQ,                                              '+
                     '  :NOMUSU,                                              '+
                     '  :DTAEXE,                                              '+
                     '  :VEREXE,                                              '+
                     '  :PATEXE,                                              '+
                     '  :NOMEXE,                                              '+
                     '  :DTAENT,                                              '+
                     '  :HRAENT)                                              ';

    sqlLogout      = 'UPDATE LOGACE SET                                       '+
                     '  LOG_DTASAI = :DTASAI,                                 '+
                     '  LOG_HRASAI = :HRASAI                                  '+
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
  protected
    constructor Create;

  public
    procedure pLogin;
    procedure pLogout;

    class function New: ILogAut;
  end;

implementation

uses
  Uni,
  Vcl.Forms,
  System.SysUtils,
  untFuncoes;

{ TLogAut }

constructor TLogAut.Create;
begin
  FCodOpe := strLoginUsuarioLogado;
  FCodEmp := VS_strCodEmp;
  FCon_ID := fGetConnectionID();
  FNum_Ip := VS_IPAddressAsString;
  FMacAdd := VS_MacAddress;
  FNomMaq := VS_ComputerNetName;
  FNomUsu := VS_UserFromWindows;

  strAuxGerTmp := FCon_ID;

  FileAge(Application.ExeName, FDtaExe);
  FVerExe := fRetornaVersao();
  FPatExe := ExtractFilePath(Application.ExeName);
  FNomExe := ExtractFileName(Application.ExeName);
end;

class function TLogAut.New: ILogAut;
begin
  Result := TLogAut.Create();
end;

procedure TLogAut.pLogin;
var
  LQry: TUniQuery;
begin
  If (Not fEmptyStr(FAutInc)) Then
    Exit;
  If (Not fTabelaExiste('LOGACE')) Then
    Exit;

  LQry := fCriaQuery();

  Try
    FAutInc := fRetAutoIncrem('LOGACE', FCodEmp);

    LQry.SQL.Add(sqlLogin);
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
    LQry.ParamByName('PATEXE').AsString   := FPatExe;
    LQry.ParamByName('NOMEXE').AsString   := FNomExe;
    LQry.ParamByName('DTAENT').AsDate     := VS_Date;
    LQry.ParamByName('HRAENT').AsTime     := fTime();

    LQry.ExecSQL();
  Finally
    FreeAndNil(LQry);
  End;
end;

procedure TLogAut.pLogout;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlLogout);
    LQry.ParamByName('DTASAI').AsDate   := VS_Date;
    LQry.ParamByName('HRASAI').AsTime   := fTime();
    LQry.ParamByName('AUTINC').AsString := FAutInc;

    LQry.ExecSQL();
  Finally
    FAutInc := '';
    FreeAndNil(LQry);
  End;
end;

initialization
  TLogAut.FAutInc := '';

end.

