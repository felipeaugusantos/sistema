unit untlibSFTP;

interface

type
  TlibSFTP = Class
  public
    class function fPutFile(strHost, strUser, strPass, strStartPath, strFile: String; intPort: Integer; blnSubstituir: Boolean): Boolean;
    class function fGetFiles(strHost, strUser, strPass, strPathSFTP, strPathSav: String; intPort: Integer; strExt: String): Boolean;
    class function fRename(strHost, strUser, strPass: String; intPort: Integer; strOldFile, strNewFile: String): Boolean;
    class procedure pInit;
    class var strPathDLL: String;
  End;

implementation

uses Windows, SysUtils, Forms;

{ TlibSFTP }

class function TlibSFTP.fGetFiles(strHost, strUser, strPass, strPathSFTP,
  strPathSav: String; intPort: Integer; strExt: String): Boolean;
  Var
    fGetFilesInterna: function(strHost, strUser, strPass, strPathSFTP, strPathSav: String; intPort: Integer; strExt: String): Boolean; StdCall;
    HandleDll : THandle;
begin
  Result := False;
  If FileExists(strPathDll) Then
  Begin
    HandleDll := 0;
    Try
      HandleDll := LoadLibrary(PChar(strPathDll));

      fGetFilesInterna := GetProcAddress(HandleDll, 'fGetFiles');

      If Assigned(fGetFilesInterna) Then
        Result := fGetFilesInterna(strHost, strUser, strPass, strPathSFTP, strPathSav, intPort, strExt);
    Finally
      FreeLibrary(HandleDll);
    End;
  End;
end;

class function TlibSFTP.fPutFile(strHost, strUser, strPass, strStartPath,
  strFile: String; intPort: Integer; blnSubstituir: Boolean): Boolean;
  Var
    fPutFileInterna: function(strHost, strUser, strPass, strStartPath, strFile: String; intPort: Integer; blnSubstituir: Boolean): Boolean; StdCall;
    HandleDll : THandle;
begin
  Result := False;
  If FileExists(strPathDll) Then
  Begin
    HandleDll := 0;
    Try
      HandleDll := LoadLibrary(PChar(strPathDll));

      fPutFileInterna := GetProcAddress(HandleDll, 'fPutFile');

      If Assigned(fPutFileInterna) Then
        Result := fPutFileInterna(strHost, strUser, strPass, strStartPath, strFile, intPort, blnSubstituir);
    Finally
      FreeLibrary(HandleDll);
    End;
  End;
end;

class function TlibSFTP.fRename(strHost, strUser, strPass: String;
  intPort: Integer; strOldFile, strNewFile: String): Boolean;
  Var
    fRenameInterna: function(strHost, strUser, strPass: String; intPort: Integer; strOldFile, strNewFile: String): Boolean; StdCall;
    HandleDll : THandle;
begin
  Result := False;
  If FileExists(strPathDll) Then
  Begin
    HandleDll := 0;
    Try
      HandleDll := LoadLibrary(PChar(strPathDll));

      fRenameInterna := GetProcAddress(HandleDll, 'fRename');

      If Assigned(fRenameInterna) Then
        Result := fRenameInterna(strHost, strUser, strPass, intPort, strOldFile, strNewFile);
    Finally
      FreeLibrary(HandleDll);
    End;
  End;
end;

class procedure TlibSFTP.pInit;
begin
  strPathDll := ExtractFilePath(Application.ExeName) + 'libSFTP.dll';
end;

initialization
  TlibSFTP.pInit;

end.

