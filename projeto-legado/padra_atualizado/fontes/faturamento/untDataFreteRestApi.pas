unit untDataFreteRestApi;

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
  TControllerDataFrete = class
  public
    class function fConfigurarDataFreteCotacao(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;

    class function fConfigurarDataFreteServico(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TControllerDataFrete }

class function TControllerDataFrete.fConfigurarDataFreteCotacao(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
begin
  Result := True;
  try
    RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_DTFCOT', VS_strCodEmp], True, EmptyStr);

    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/json';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

class function TControllerDataFrete.fConfigurarDataFreteServico(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
  Result := True;
  try
    RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_DTFSER', VS_strCodEmp], True, EmptyStr);

    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/json';

    RestResponse.ContentType := 'application/json';

    {OAuth2Authenticator              := TOAuth2Authenticator.Create(RestClient);
    OAuth2Authenticator.TokenType    := TOAuth2TokenType.ttNONE;
    OAuth2Authenticator.AccessToken  := '2cbd5a24-35d7-4ddc-8b97-dfff2b05724f';

    RestClient.Authenticator := OAuth2Authenticator;}
  except
    Result := False;
  end;
end;

end.
