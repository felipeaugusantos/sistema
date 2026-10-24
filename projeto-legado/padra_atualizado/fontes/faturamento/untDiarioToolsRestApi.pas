unit untDiarioToolsRestApi;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils, REST.Authenticator.OAuth,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni;
  {$ENDIF LINUX}

type
  TConfigurarDiarioTools = class
  public
    class function fConfigurarDiarioTools(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TConfigurarDiarioTools }

class function TConfigurarDiarioTools.fConfigurarDiarioTools(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
   Result := True;
  try
    RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS',  ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_URLDTO', VS_strCodEmp]);

    RestClient.Accept        := '*/*';
    RestClient.ContentType   := 'multipart/form-data; boundary=<calculated when request is sent>';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

end.
