unit Yapay.Api.Core;

interface

uses
  StdCtrls,
  Windows,
  System.SysUtils,
  System.StrUtils;

type
 EYapayApiCore = Exception;
 TYapayApiCoreMetodo = (Post, Get, Patch);

{$M+}
 TYapayApiCore = class
 strict private
    type
      TApiRestExecute = function (pIntMetodo: integer;
                                  pBlnDebug: Boolean;
                                  pBlnLog: Boolean;
                                  pStrEndereco: string;
                                  pStrAccess_Token: string;
                                  pStrJSONEnvio: string): string; stdcall;
   var
     FAccess_Token: string;
     FDebug: Boolean;
     FLog: Boolean;
     FMetodo: TYapayApiCoreMetodo;
     FJSONRetorno: string;
     FBaseURL: string;
     FJSONEnvio: string;
 published
   property BaseURL: string read FBaseURL write FBaseURL;
   property Metodo: TYapayApiCoreMetodo read FMetodo write FMetodo;
   property Debug: Boolean read FDebug write FDebug default False;
   property Log: Boolean read FLog write FLog default False;
   property JSONEnvio: string read FJSONEnvio write FJSONEnvio;
   property JSONRetorno: string read FJSONRetorno;
   property Access_Token: string read FAccess_Token write FAccess_Token;
 public
   procedure Execute;
 end;
{$M-}

resourcestring
  sYAPAY_API_REST_DLL = 'Yapay.Api.Rest.dll';
  sYAPAY_API_REST_METODO_EXECUTE = 'Execute';
  sYAPAY_API_REST_MENSAGEM_ERRO_DLL_NAO_ENCONTRADA = 'Não encontrei a biblioteca %s !';
  sYAPAY_API_REST_MENSAGEM_ERRO_DLL_INVALIDA = 'Biblioteca %s inválida !';
  sYAPAY_API_REST_MENSAGEM_ERRO_FUNCAO_NAO_ENCONTRADA = 'Não encontrei função %s na biblioteca %s !';
  sYAPAY_API_REST_MENSAGEM_ERRO_FUNCAO_EXECUTE =
    'Não foi possível chamar a função %s na biblioteca %s!' + sLineBreak + sLineBreak + 'EYapayApiCore: %s';

implementation

procedure TYapayApiCore.Execute;
var
  oHandle: THandle;
  fApiRestExecute: TApiRestExecute;
begin
  if not FileExists(sYAPAY_API_REST_DLL) then
  begin
    raise EYapayApiCore.Create(Format(sYAPAY_API_REST_MENSAGEM_ERRO_DLL_NAO_ENCONTRADA,
                                      [sYAPAY_API_REST_DLL]))
  end;

  oHandle := LoadLibrary(PChar(sYAPAY_API_REST_DLL));
  try
    if oHandle = 0 then
    begin
      raise EYapayApiCore.Create(Format(sYAPAY_API_REST_MENSAGEM_ERRO_DLL_INVALIDA,
                                        [sYAPAY_API_REST_DLL]))
    end
    else
    begin
      @fApiRestExecute := GetProcAddress(oHandle, PChar(sYAPAY_API_REST_METODO_EXECUTE));

      if @fApiRestExecute <> nil then
      begin
        try
          FJSONRetorno := fApiRestExecute(ord(FMetodo),
                                          FDebug,
                                          FLog,
                                          FBaseURL,
                                          FAccess_token,
                                          JSONEnvio
                                         );
        except
          on E: Exception do
          begin
            raise EYapayApiCore.Create(Format(sYAPAY_API_REST_MENSAGEM_ERRO_FUNCAO_EXECUTE,
                                              [sYAPAY_API_REST_METODO_EXECUTE,
                                               sYAPAY_API_REST_DLL,
                                               E.Message]));
          end;
        end;
      end
      else
      begin
        raise EYapayApiCore.Create(Format(sYAPAY_API_REST_MENSAGEM_ERRO_FUNCAO_NAO_ENCONTRADA,
                                          [sYAPAY_API_REST_METODO_EXECUTE,
                                           sYAPAY_API_REST_DLL]));
      end;
    end;
  finally
    if oHandle <> 0 then
      FreeLibrary(oHandle);
  end;
end;

end.
