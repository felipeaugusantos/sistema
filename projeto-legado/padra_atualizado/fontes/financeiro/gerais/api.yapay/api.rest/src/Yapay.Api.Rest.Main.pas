unit Yapay.Api.Rest.Main;

interface

uses
  System.SysUtils,
  System.Classes,
  Yapay.Api.Rest.Core;

function Execute(pIntMetodo: integer;
                 pBlnDebug: Boolean;
                 pBlnLog: Boolean;
                 pStrEndereco: string;
                 pStrAccess_Token: string;
                 pStrJSONEnvio: string): string; stdcall; export;

implementation

function Execute(pIntMetodo: integer;
                 pBlnDebug: Boolean;
                 pBlnLog: Boolean;
                 pStrEndereco: string;
                 pStrAccess_Token: string;
                 pStrJSONEnvio: string): string; stdcall; export;
var
  FCore: TApiRestCore;
begin
  FCore := TApiRestCore.Create;
  try
    FCore.Metodo := TApiRestCoreMetodo(pIntMetodo);
    FCore.Debug := pBlnDebug;
    FCore.Log := pBlnLog;
    FCore.BaseURL := pStrEndereco;
    FCore.Access_Token := pStrAccess_Token;

    if not pStrJSONEnvio.IsEmpty  then
      FCore.JSONEnvio := pStrJSONEnvio;

    FCore.Execute;
    Result := FCore.JSONRetorno;
  finally
    if Assigned(FCore) then
      FreeAndNil(FCore);
  end;
end;

end.
