unit untAlpeRestApi;

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
  TControllerAlpe = class
  public
    class function fConfigurarAlpe(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
    class function fConfigurarAlpeKonekt(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

uses untAlpeToken;

{ TControllerAlpe }

{*********************************************}
{***** CONFIGURA A API NA VERSÃO ANTIGA ******}
{******************************************BL*}
class function TControllerAlpe.fConfigurarAlpe(RestClient: TRestClient;
  OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
var
  AlpeToken: TAlpeToken;

  strClientId,
  strClientSecret: String;
begin
  Result := False;

  RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLALP'], True, '');
  RestClient.ContentType   := 'application/json';
  RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestClient.AcceptCharset := 'UTF-8, *;q=0.8';

  RestResponse.ContentType := 'application/json';

  strClientId := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_CLIEID'], True, '');
  strClientSecret := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_CLISEC'], True, '');

  AlpeToken := TControllerAlpeToken.fGetToken(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLTOK'], True, ''),
                                              strClientId,
                                              strClientSecret,
                                              'client_credentials');
  try
    if (Assigned(AlpeToken)) and
       (not fEmptyStr(AlpeToken.access_token)) then
    begin
      OAuth2Authenticator              := TOAuth2Authenticator.Create(RestClient);
      OAuth2Authenticator.ClientID     := strClientId;
      OAuth2Authenticator.ClientSecret := strClientSecret;
      OAuth2Authenticator.TokenType    := TOAuth2TokenType.ttBEARER;
      OAuth2Authenticator.AccessToken  := AlpeToken.access_token;

      RestClient.Authenticator := OAuth2Authenticator;

      Result := True;
    end;
  finally
    FreeAndNil(AlpeToken)
  end;
end;

{*********************************************}
{****** CONFIGURA A API NA NOVA VERSÃO *******}
{******************************************BL*}
class function TControllerAlpe.fConfigurarAlpeKonekt(RestClient: TRestClient;
  OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
var
  AlpeToken: TAlpeToken;

  strClientId,
  strClientSecret: String;
begin
  Result := False;

  RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLKNK'], True, '');
  RestClient.ContentType   := 'application/json';
  RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestClient.AcceptCharset := 'UTF-8, *;q=0.8';

  RestResponse.ContentType := 'application/json';

  strClientId := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_IDKNKT'], True, '');
  strClientSecret := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_SECKNK'], True, '');

  AlpeToken := TControllerAlpeToken.fGetToken(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_TOKKNK'], True, ''),
                                              strClientId,
                                              strClientSecret,
                                              'client_credentials');
  try
    if (Assigned(AlpeToken)) and
       (not fEmptyStr(AlpeToken.access_token)) then
    begin
      OAuth2Authenticator              := TOAuth2Authenticator.Create(RestClient);
      OAuth2Authenticator.ClientID     := strClientId;
      OAuth2Authenticator.ClientSecret := strClientSecret;
      OAuth2Authenticator.TokenType    := TOAuth2TokenType.ttBEARER;
      OAuth2Authenticator.AccessToken  := AlpeToken.access_token;

      RestClient.Authenticator := OAuth2Authenticator;

      Result := True;
    end;
  finally
    FreeAndNil(AlpeToken)
  end;

end;

end.
