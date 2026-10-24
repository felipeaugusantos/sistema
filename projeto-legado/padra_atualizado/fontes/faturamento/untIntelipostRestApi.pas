unit untIntelipostRestApi;

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
  TControllerConfigurarIntelipost = class
  public
    class function fConfigurarIntelipost(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TControllerConfigurarIntelipost }

class function TControllerConfigurarIntelipost.fConfigurarIntelipost(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
   Result := True;
  try
    RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_ITPURL', VS_strCodEmp], True, EmptyStr);

    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/json';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

end.
