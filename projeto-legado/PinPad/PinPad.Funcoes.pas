unit PinPad.Funcoes;

interface

uses PinPad.Interfaces, Classes, Windows ;

type
  TListaDllAcessoPinPad = class
  public
    class procedure pCarrega(var Alst: TStrings) ;
  end ;

type
  TNomeMaquinaLocal = class
  private
    type TWTSQuerySessionInformationFunction = function(hServer: THandle;
        SessionId: DWORD; WTSInofClass: Byte; var ppBuffer: LPSTR;
        var pBytesReturned: DWORD): BOOL; stdcall;

    type TWTSFreeMemoryProcedure = procedure(pMemory: Pointer); stdcall;

    class function fIsTSClient: boolean;
    class function fGetNomeTSClient: string;
    class function fGetNomeLongo: string;

    class var strNomeMaquina: string;

  public
    class function fGet: string;
  end;

procedure pCarregaConfiguracaoTerminalPinPad(var AstrPorta, AstrFabricante, AstrNumTer: String) ;
function fObtemDadosPinPadCitelDireto(const ATipoDoc: TPinPadCitelDocumentos): String;
function fObtemFabricantePinPad: TPinPadCitelFabricantes ;
function fAcessoDiretoPinPadCitel: Boolean ;
function fIfThen(const AblnCondicao: Boolean; const AOpcaoVerdade, AOpcaoFalso: TPinPadCitelDocumentos): TPinPadCitelDocumentos ;
function fInstanciaPinPad: IPinPadCitel ;
procedure pEnviaQrCode(const AstrTextoQrCode, AstrTituloInformativo: String; APinPad: IPinPadCitel) ;
procedure pLimpaQrCode(APinPad: IPinPadCitel) ;
function PathWithDelim(const APath : AnsiString) : AnsiString ;

implementation

uses PinPad.Classes.PinPadFactory, untFuncoesSimples, SysUtils, AnsiStrings,
     Uni, Data.DB , untTypesSistema;

function PathWithDelim(const APath : AnsiString) : AnsiString ;
begin
  Result := AnsiString(Trim(String(APath))) ;
  if Result <> '' then
  begin
     {$IfDef FPC}
      Result := IncludeTrailingPathDelimiter(Result);
     {$Else}
      if AnsiStrings.RightStr(Result,1) <> String(PathDelim) then
         Result := Result + PathDelim ;
     {$EndIf}
  end;
end ;

function fInstanciaPinPad: IPinPadCitel ;
var
  LstrPorta, LstrFabricante, LstrNumTer: String ;
  LppcfFabricante: TPinPadCitelFabricantes ;
  LstrPathDll: String ;
begin
  pCarregaConfiguracaoTerminalPinPad(LstrPorta, LstrFabricante, LstrNumTer) ;
  if fEmptyStr(LstrPorta) then
    LstrPorta := 'COM6' ; //Default

  LstrPathDll := fCfgSis('PTTFCT', varString) ;
  if Trim(LstrPathDll) <> '' then
  begin
    LstrPathDll := String(PathWithDelim(AnsiString(LstrPathDll)))+LstrNumTer ;
  end ;

  LppcfFabricante := fObtemFabricantePinPad ;
  Result := TPinPadFactory.New.fAcessa(LstrPorta, LppcfFabricante, LstrPathDll) ;
end ;

procedure pCarregaConfiguracaoTerminalPinPad(var AstrPorta, AstrFabricante, AstrNumTer: String) ;
var
  LqryTefTerminal: TUniQuery ;
begin
  if fCfgSis('TIPTER', varString) = '1' then
  begin
    AstrPorta := fCampoTabela('TFC_PINPOR', 'TEFCFG', ['TFC_NOMUSU', 'TFC_NOMMAQ', 'TFC_CODEMP'], [VS_UserFromWindows, VS_ComputerNetName, VS_strCodEmp], False) ;
    AstrFabricante := fCampoTabela('TFC_PINFAB', 'TEFCFG', ['TFC_NOMUSU', 'TFC_NOMMAQ', 'TFC_CODEMP'], [VS_UserFromWindows, VS_ComputerNetName, VS_strCodEmp], False) ;
    AstrNumTer := fCampoTabela('TFC_NUMTER', 'TEFCFG', ['TFC_NOMUSU', 'TFC_NOMMAQ', 'TFC_CODEMP'], [VS_UserFromWindows, VS_ComputerNetName, VS_strCodEmp], False) ;
  end
  else if fCfgSis('TIPTER', varString) = '2' then
  begin
    AstrPorta := fCampoTabela('TFC_PINPOR', 'TEFCFG', ['TFC_LOC_IP', 'TFC_NOMMAQ'], [VS_WorkStationIP, TNomeMaquinaLocal.fGet], False) ;
    AstrFabricante := fCampoTabela('TFC_PINFAB', 'TEFCFG', ['TFC_LOC_IP', 'TFC_NOMMAQ'], [VS_WorkStationIP, TNomeMaquinaLocal.fGet], False) ;
    AstrNumTer := fCampoTabela('TFC_NUMTER', 'TEFCFG', ['TFC_LOC_IP', 'TFC_NOMMAQ'], [VS_WorkStationIP, TNomeMaquinaLocal.fGet], False)
  end
  else // 3
  begin
    LqryTefTerminal := fCriaQuery() ;
    try
      LqryTefTerminal.Close ;
      LqryTefTerminal.SQL.Clear ;
      LqryTefTerminal.SQL.Add('SELECT');
      LqryTefTerminal.SQL.Add('  TFC_PINPOR, TFC_PINFAB, TFC_NUMTER ');
      LqryTefTerminal.SQL.Add('FROM');
      LqryTefTerminal.SQL.Add('  TEFCFG ');
      LqryTefTerminal.SQL.Add('WHERE TFC_EMPTIP = :EMPTIP');
      LqryTefTerminal.SQL.Add('  AND TFC_NOMMAQ = :NOMMAQ');
      if fCfgSis('TEFCIT', varString) = 'T' then
        LqryTefTerminal.SQL.Add(' AND LENGTH(TRIM(TFC_NUMTER)) = 3 ')
      else if (fCfgSis('TEFCIT', varString) = 'S') or (fCfgSis('TEFCIT', varString) = 'N') then
        LqryTefTerminal.SQL.Add(' AND LENGTH(TRIM(TFC_NUMTER)) > 3 ') ;

      LqryTefTerminal.ParamByName('EMPTIP').AsString := VS_strCodEmp;
      LqryTefTerminal.ParamByName('NOMMAQ').AsString := TNomeMaquinaLocal.fGet;
      LqryTefTerminal.Open ;

      AstrPorta := '' ;
      AstrFabricante := '' ;
      AstrNumTer := '' ;

      if not LqryTefTerminal.IsEmpty then
      begin
        AstrPorta := LqryTefTerminal.FieldByName('TFC_PINPOR').AsString ;
        AstrFabricante := LqryTefTerminal.FieldByName('TFC_PINFAB').AsString ;
        AstrNumTer := LqryTefTerminal.FieldByName('TFC_NUMTER').AsString ;
      end ;
    finally
      FreeAndNil(LqryTefTerminal) ;
    end ;
  end ;
end ;

function fObtemDadosPinPadCitelDireto(const ATipoDoc: TPinPadCitelDocumentos): String;
var
  LPinPad: IPinPadCitel ;
begin
  result := '' ;
  LPinPad := fInstanciaPinPad ;
  if not Assigned(LPinPad) then
    exit ;

  Result := LPinPad.fObtemDadoPinPadDireto(ATipoDoc) ;
end ;

procedure pEnviaQrCode(const AstrTextoQrCode, AstrTituloInformativo: String; APinPad: IPinPadCitel) ;
begin
  if not Assigned(APinPad) then
    exit ;

  APinPad.pEnviarQrCode(AstrTextoQrCode, AstrTituloInformativo);
end ;

procedure pLimpaQrCode(APinPad: IPinPadCitel) ;
begin
  if not Assigned(APinPad) then
    exit ;

  APinPad.pLimpaQrCode ;
end ;

function fObtemFabricantePinPad: TPinPadCitelFabricantes ;
var
  LstrPorta, LstrFabricante, LstrNumTer: String ;
begin
  pCarregaConfiguracaoTerminalPinPad(LstrPorta, LstrFabricante, LstrNumTer) ;
  result := ppcfGertec ; //Default
  LstrFabricante := LstrFabricante ;
  if LstrFabricante = 'Gertec' then
    result := ppcfGertec
  else if LstrFabricante = 'Scope' then
    result := ppcfScope ;
end ;

function fAcessoDiretoPinPadCitel: Boolean ;
var
  LstrPorta, LstrFabricante, LstrNumTer: String ;
begin
  Result := False ;
  if fCfgSis('TEFCIT', varBoolean) then
    Exit ;

  pCarregaConfiguracaoTerminalPinPad(LstrPorta, LstrFabricante, LstrNumTer) ;

  if fEmptyStr(LstrFabricante) then
    Exit ;

  if fEmptyStr(LstrPorta) then
    Exit ;

  Result := True ;
end ;

function fIfThen(const AblnCondicao: Boolean; const AOpcaoVerdade, AOpcaoFalso: TPinPadCitelDocumentos): TPinPadCitelDocumentos ;
begin
  if AblnCondicao then
    Result := AOpcaoVerdade
  else
    Result := AOpcaoFalso ;
end ;

{ TListaDllAcessoPinPad }

class procedure TListaDllAcessoPinPad.pCarrega(var Alst: TStrings);
begin
  Alst.Clear ;
  Alst.Add('') ;
  Alst.Add(ArrayDllAcessoPinPad[ppcfGertec]) ;
  Alst.Add(ArrayDllAcessoPinPad[ppcfScope]) ;
end;

{ TNomeMaquinaLocal }

class function TNomeMaquinaLocal.fGet: string;
begin
  if fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_TEFLNG', VS_strCodEmp], False) = 'S' then
    Result := Self.fGetNomeLongo
  else
    Result := VS_WorkstationID;
end;

class function TNomeMaquinaLocal.fGetNomeLongo: string;
  var
    szComputerName: packed array[0..255] of Char;
    iSize: Cardinal;
begin
  try

    if strNomeMaquina = '' then
    begin
      if Self.fIsTSClient then
      begin
        strNomeMaquina := UpperCase(Self.fGetNomeTSClient);
      end
      else
      begin
        iSize := 256;
        GetComputerName(szComputerName, iSize);
        strNomeMaquina := UpperCase(szComputerName);
      end;
    end;

    Result := strNomeMaquina;

  except
    Result := '';
  end;
end;

class function TNomeMaquinaLocal.fGetNomeTSClient: string;
  var
    LibHandle: HMODULE;
    WTSQuerySessionInformation: TWTSQuerySessionInformationFunction;
    WTSFreeMemory: TWTSFreeMemoryProcedure;
    ClientName: LPSTR;
    cByteseturned: Cardinal;
begin
  Result := '';
  LibHandle := LoadLibrary('wtsapi32.dll');
  if LibHandle <> 0 then
  begin
    try
      @WTSQuerySessionInformation := GetProcAddress(LibHandle,
      'WTSQuerySessionInformationA');
      @WTSFreeMemory := GetProcAddress(LibHandle, 'WTSFreeMemory');
      WTSQuerySessionInformation(0, DWORD(-1), 10,
      ClientName, cByteseturned);
      try
        Result := String(ClientName);
      finally
        WTSFreeMemory(Pointer(ClientName));
      end;
    finally
      FreeLibrary(LibHandle);
    end;
  end;
end;

class function TNomeMaquinaLocal.fIsTSClient: boolean;
begin
  Result := GetSystemMetrics(SM_REMOTESESSION) <> 0;
end;

end.
