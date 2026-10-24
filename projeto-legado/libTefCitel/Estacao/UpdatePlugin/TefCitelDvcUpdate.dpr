library TefCitelDvcUpdate;

{ DLL do plugin cliente do canal DVC de ATUALIZACAO (Req. 456190, Fase 6.1),
  carregada pelo cliente RDP (mstsc.exe/TSPlus) na estacao, canal
  "TefCitelUpd".

  E uma SEGUNDA DLL, e nao um listener a mais dentro do
  TefCitelDvcPlugin.dll, por decisao do Rafael (2026-09-16): assim o plugin
  da transacao - validado em campo - nao e recompilado nem substituido. Se o
  antivirus barrar esta DLL, so a transferencia rapida para; a estacao segue
  atualizando pelo caminho lento (RF45) e o TEF nem fica sabendo. E o mesmo
  raciocinio de isolamento que fez o TefEstacaoAtualizador.exe virar
  executavel a parte.

  A bitness desta DLL PRECISA ser igual a do processo do cliente RDP que a
  carrega - mesma regra do plugin da transacao, por isso Win32 e Win64.

  Registro somente em HKCU (nao exige administrador) - ver
  Estacao\install\register-plugin.ps1/unregister-plugin.ps1. }

uses
  Winapi.Windows,
  System.SysUtils,
  System.Win.Registry,
  untTefCitelDvcUpdateApi in 'untTefCitelDvcUpdateApi.pas',
  untTefCitelDvcUpdateImpl in 'untTefCitelDvcUpdateImpl.pas';

const
  TEF_UPD_CHAVE_ADDIN = 'Software\Microsoft\Terminal Server Client\Default\AddIns\TefCitelUpd';

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
  LobjPlugin := TTefCitelDvcUpdatePlugin.Create;
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
    if LobjRegistro.OpenKey(TEF_UPD_CHAVE_ADDIN, True) then
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
    LobjRegistro.DeleteKey(TEF_UPD_CHAVE_ADDIN);
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
