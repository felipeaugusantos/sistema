library TefCitelDvcPlugin;

{ DLL do plugin cliente de Dynamic Virtual Channel do RDP (Req. 456190),
  carregada pelo cliente RDP (mstsc.exe/TSPlus) na estacao, canal
  "TefCitelCh". Adaptada de DVC\src\client\TefDvcClient.dpr (prototipo
  escolhido como base tecnica oficial - ver IA\456190\plans.md).

  A bitness desta DLL PRECISA ser igual a do processo do cliente RDP que a
  carrega (Win64 por padrao - mstsc.exe de System32 em Windows moderno; ver
  IA\456190\tasks.md, secao "Plugin cliente DVC", para instalar tambem em
  Win32 caso a estacao use um cliente RDP de 32 bits).

  Registro somente em HKCU (nao exige administrador) - ver
  Estacao\install\register-plugin.ps1/unregister-plugin.ps1. }

uses
  Winapi.Windows,
  System.SysUtils,
  System.Win.Registry,
  untTefCitelDvcPluginApi in 'untTefCitelDvcPluginApi.pas',
  untTefCitelDvcPluginImpl in 'untTefCitelDvcPluginImpl.pas';

const
  TEF_PLUGIN_CHAVE_ADDIN = 'Software\Microsoft\Terminal Server Client\Default\AddIns\TefCitelCh';

function fNomeArquivoModulo: String;
var
  LarrBuffer: array[0..MAX_PATH - 1] of Char;
begin
  SetString(Result, LarrBuffer, GetModuleFileName(HInstance, LarrBuffer, Length(LarrBuffer)));
end;

function VirtualChannelGetInstance(const RefIID: TGUID; NumObjs: PULONG;
  ObjArray: Pointer): HRESULT; stdcall;
var
  LobjPlugin: IWTSPlugin;
begin
  if NumObjs = nil then
    Exit(E_POINTER);
  if not IsEqualGUID(RefIID, IID_IWTSPlugin) then
    Exit(E_NOINTERFACE);

  if ObjArray = nil then
  begin
    NumObjs^ := 1;
    Exit(S_OK);
  end;

  if NumObjs^ < 1 then
  begin
    NumObjs^ := 1;
    Exit(HRESULT($8007007A)); { HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER) }
  end;

  PPointer(ObjArray)^ := nil;
  LobjPlugin := TTefCitelDvcPlugin.Create;
  PPointer(ObjArray)^ := Pointer(LobjPlugin);
  LobjPlugin._AddRef; { a referencia devolvida passa a pertencer ao cliente RDP }
  NumObjs^ := 1;
  Result := S_OK;
end;

function DllRegisterServer: HRESULT; stdcall;
var
  LobjRegistro: TRegistry;
begin
  Result := E_FAIL;
  LobjRegistro := TRegistry.Create(KEY_WRITE);
  try
    LobjRegistro.RootKey := HKEY_CURRENT_USER;
    if LobjRegistro.OpenKey(TEF_PLUGIN_CHAVE_ADDIN, True) then
    begin
      LobjRegistro.WriteString('Name', fNomeArquivoModulo);
      Result := S_OK;
    end;
  finally
    LobjRegistro.Free;
  end;
end;

function DllUnregisterServer: HRESULT; stdcall;
var
  LobjRegistro: TRegistry;
begin
  LobjRegistro := TRegistry.Create(KEY_WRITE);
  try
    LobjRegistro.RootKey := HKEY_CURRENT_USER;
    LobjRegistro.DeleteKey(TEF_PLUGIN_CHAVE_ADDIN);
    Result := S_OK;
  finally
    LobjRegistro.Free;
  end;
end;

exports
  VirtualChannelGetInstance name 'VirtualChannelGetInstance',
  DllRegisterServer name 'DllRegisterServer',
  DllUnregisterServer name 'DllUnregisterServer';

begin
end.
