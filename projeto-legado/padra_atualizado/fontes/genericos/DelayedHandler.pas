unit DelayedHandler;

interface

uses Winapi.Windows, System.SysUtils;

Type
  ELoadLibrary = class(Exception);
  EGetProcAddress = class(Exception);

implementation

function DelayedHandlerHook(dliNotify: dliNotification; pdli: PDelayLoadInfo): Pointer; stdcall;
begin
  Result := nil;

  If dliNotify = dliFailLoadLibrary Then
    Raise ELoadLibrary.Create('Não foi possível carregar a biblioteca ' +  pdli.szDll + '.' + #13#10 +
                              'Verifique se a Dll existe no diretório do Autcom e tente novamente.' + #13#10 +
                              'Caso o problema persista, entre em contato com o responsável do Sistema AUTCOM.')

  Else If dliNotify = dliFailGetProcAddress Then
    If pdli.dlp.fImportByName Then
      Raise EGetProcAddress.Create('Não foi possível carregar o método ' + pdli.dlp.szProcName + ' da biblioteca ' + String(pdli.szDll) + '.' + #13#10 +
                                   'Tente novamente. Caso o problema persista, entre em contato com o responsável do Sistema AUTCOM.')
    Else
      Raise EGetProcAddress.Create('Não foi possível carregar o index ' + IntToStr(pdli.dlp.dwOrdinal) + ' da biblioteca ' + String(pdli.szDll) + '.' + #13#10 +
                                   'Tente novamente. Caso o problema persista, entre em contato com o responsável do Sistema AUTCOM.');

end;

initialization
  SetDliFailureHook2(DelayedHandlerHook);
finalization
  SetDliFailureHook2(nil);

end.
