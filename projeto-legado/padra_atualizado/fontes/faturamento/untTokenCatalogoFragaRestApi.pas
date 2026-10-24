unit untTokenCatalogoFragaRestApi;

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
  TTokenCatalogoFragaRestApi = class
  public
    class function fConfigurarTokenCatalogoFraga(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TCatalogoFragaRestApi }

class function TTokenCatalogoFragaRestApi.fConfigurarTokenCatalogoFraga(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
   Result := True;
  try
    RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_URLTFR', VS_strCodEmp], True, EmptyStr); //'https://accounts.fraga.com.br/realms/cat_teste/protocol/openid-connect/token';

    RestClient.Accept        := '*/*';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/x-www-form-urlencoded';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

end.
