unit untMaplinkRestApi;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  TControllerMaplink = class
  public
    class function fConfigurarMaplink(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TControllerMaplink }

uses untMaplinkToken;

class function TControllerMaplink.fConfigurarMaplink(RestClient: TRestClient;
  OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
var
  MaplinkToken: TMaplinkToken;

  strClientId,
  strClientSecret: String;
begin
  Result := False;

  RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_MPLURL'], True, '');
  RestClient.ContentType   := 'application/json';
  RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestClient.AcceptCharset := 'UTF-8, *;q=0.8';

  RestResponse.ContentType := 'application/json';

  //Deixei fixo no fonte pois são chaves de uso exclusivo da Citel e não podem ser compartilhadas
  strClientId := 'bFQF71M7JABUG4F9lJLpSSwJfVfdh3CT';
  strClientSecret := 'gmAzcF4Nnaxro1QH';

  MaplinkToken := TControllerMaplinkToken.fGetToken(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_MPLTOK'], True, ''),
                                                    strClientId,
                                                    strClientSecret);
  try
    if (Assigned(MaplinkToken)) and
       (not fEmptyStr(MaplinkToken.access_token)) then
    begin
      OAuth2Authenticator              := TOAuth2Authenticator.Create(RestClient);
      OAuth2Authenticator.ClientID     := strClientId;
      OAuth2Authenticator.ClientSecret := strClientSecret;
      OAuth2Authenticator.TokenType    := TOAuth2TokenType.ttBEARER;
      OAuth2Authenticator.AccessToken  := MaplinkToken.access_token;

      RestClient.Authenticator := OAuth2Authenticator;

      Result := True;
    end;
  finally
    FreeAndNil(MaplinkToken)
  end;
end;

end.
