unit untWorkStationInfo;

interface

uses
  SysUtils, Classes, Windows, IdBaseComponent, IdComponent, IdIPWatch;

const
  WTS_CURRENT_SERVER_HANDLE: THandle = 0;
  WTS_CURRENT_SESSION: DWORD = DWORD(-1);

type
  _WTS_CLIENT_ADDRESS = record
    AddressFamily: DWORD;
    Address: array[0..19] of Byte;
  end;

  WTS_CLIENT_ADDRESS = _WTS_CLIENT_ADDRESS;
  PWTS_CLIENT_ADDRESS = ^_WTS_CLIENT_ADDRESS;

type
  TWorkStationInfo = class
  private
    class function fGetTSClientName: string;
    class function fGetTSClientIP : String;
    class function GetIPLocal : string;
  public
    class function fGetWorkstationID: string;
    class function fGetWorkStationIP: String;
    class function fIsTSRemoteSession: Boolean;
  end;

type
  WTS_INFO_CLASS = (
     WTSInitialProgram,
     WTSApplicationName,
     WTSWorkingDirectory,
     WTSOEMId,
     WTSSessionId,
     WTSUserName,
     WTSWinStationName,
     WTSDomainName,
     WTSConnectState,
     WTSClientBuildNumber,
     WTSClientName,
     WTSClientDirectory,
     WTSClientProductId,
     WTSClientHardwareId,
     WTSClientAddress,
     WTSClientDisplay,
     WTSClientProtocolType,
     WTSIdleTime,
     WTSLogonTime,
     WTSIncomingBytes,
     WTSOutgoingBytes,
     WTSIncomingFrames,
     WTSOutgoingFrames,
     WTSClientInfo,
     WTSSessionInfo,
     WTSSessionInfoEx,
     WTSConfigInfo,
     WTSValidationInfo,
     WTSSessionAddressV4,
     WTSIsRemoteSession
   );

  TWTSQuerySessionInformationFunction = function(hServer: THandle;
    SessionId: DWORD; WTSInofClass: Byte; var ppBuffer: LPSTR;
    var pBytesReturned: DWORD): BOOL; stdcall;

  TWTSQuerySessionInformationFunctionDif = function(hServer: THandle; SessionId:
     DWORD; WTSInfoClass: WTS_INFO_CLASS; var ppBuffer: LPTSTR; var pBytesReturned:
     DWORD): BOOL; stdcall;

  TWTSFreeMemoryProcedure = procedure(pMemory: Pointer); stdcall;

implementation

const
  SM_REMOTESESSION = $1000;
var
  strWorkStationID: string;
  strWorkStationIP: string;

{ TWorkStationInfo }
class function TWorkStationInfo.fGetTSClientIP : String;
var
  LibHandle: HMODULE;
  WTSQuerySessionInformation: TWTSQuerySessionInformationFunctionDif;
  WTSFreeMemory: TWTSFreeMemoryProcedure;
  ClientAddress: PWTS_CLIENT_ADDRESS;
  cBytesReturned: DWORD;
  Buffer: LPTSTR;
begin
  ClientAddress := nil;
  Result := '';
  LibHandle := LoadLibrary('wtsapi32.dll');
  if LibHandle > 0 then
  begin
    try
      @WTSQuerySessionInformation := GetProcAddress(LibHandle, {$IFDEF UNICODE}'WTSQuerySessionInformationW'{$ELSE}'WTSQuerySessionInformationA'{$ENDIF});
      @WTSFreeMemory := GetProcAddress(LibHandle, 'WTSFreeMemory');
      if Assigned(WTSQuerySessionInformation) and Assigned(WTSFreeMemory) then
      begin
        if WTSQuerySessionInformation(WTS_CURRENT_SERVER_HANDLE, WTS_CURRENT_SESSION,
          WTSClientAddress, Buffer, cBytesReturned) then
        try
          ClientAddress := PWTS_CLIENT_ADDRESS(Buffer);
          Result := ClientAddress.Address[2].ToString +'.'+
                    ClientAddress.Address[3].ToString +'.'+
                    ClientAddress.Address[4].ToString +'.'+
                    ClientAddress.Address[5].ToString;
        finally
          WTSFreeMemory(ClientAddress);
        end;
      end;
    finally
      FreeLibrary(LibHandle);
    end;
  end;
end;

class function TWorkStationInfo.fGetTSClientName: string;
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
      WTSQuerySessionInformation(0, DWORD(-1), Ord(WTSClientName),
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

class function TWorkStationInfo.fGetWorkstationID: string;
  var
    szComputerName: packed array[0..MAX_COMPUTERNAME_LENGTH] of Char;
    iSize: Cardinal;
begin
  try

    if strWorkStationID = '' then
    begin
      if fIsTSRemoteSession then
      begin
        strWorkStationID := UpperCase(fGetTSClientName);
      end
      else
      begin
        iSize := MAX_COMPUTERNAME_LENGTH + 1;
        GetComputerName(szComputerName, iSize);
        strWorkStationID := UpperCase(szComputerName);
      end;
    end;

    Result := strWorkStationID;

  except
    Result := '';
  end;
end;

class function TWorkStationInfo.fGetWorkStationIP: String;
begin
  try

    if strWorkStationIP = '' then
    begin
      if fIsTSRemoteSession then
      begin
        strWorkStationIP := UpperCase(fGetTSClientIP);
      end
      else
      begin
        strWorkStationIP := GetIPLocal;
      end;
    end;

    Result := strWorkStationIP;

  except
    Result := '';
  end;
end;

class function TWorkStationInfo.fIsTSRemoteSession: Boolean;
begin
  // are we running as a TS client?
  Result := GetSystemMetrics(SM_REMOTESESSION) <> 0;
end;

class function TWorkStationInfo.GetIPLocal : string;
var
  objIpWatch : TIdIPWatch;
begin
  try
    objIpWatch := TIdIPWatch.Create(nil);
    try
      objIpWatch.HistoryEnabled := False;
      Result := objIpWatch.LocalIP;
    finally
      objIpWatch.free;
    end;
  except
    Result := '';
  end;
end;

end.
