unit untConteleRestApi;

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
  TControllerContele = class
  public
    class function fConfigurarContele(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TControllerContele }

class function TControllerContele.fConfigurarContele(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
begin
  Result := True;
  try
    RestClient.BaseURL       := fCampoTabela('CON_URLCON', 'APICON', ['CON_CODEMP'], [VS_strCodEmp]);

    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/json';

    RestResponse.ContentType := 'application/json';

    OAuth2Authenticator              := TOAuth2Authenticator.Create(RestClient);
    OAuth2Authenticator.TokenType    := TOAuth2TokenType.ttBEARER;
    OAuth2Authenticator.AccessToken  := AnsiReplaceStr(fCampoTabela('CON_AUTCON', 'APICON', ['CON_CODEMP'], [VS_strCodEmp]), 'Bearer ', '');

    RestClient.Authenticator := OAuth2Authenticator;
  except
    Result := False;
  end;
end;

end.
