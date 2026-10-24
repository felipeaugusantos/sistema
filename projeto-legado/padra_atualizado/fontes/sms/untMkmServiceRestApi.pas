unit untMkmServiceRestApi;

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
  TControllerMkmService = class
  public
    class function fConfigurarMkmService(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TControllerMkmService }

class function TControllerMkmService.fConfigurarMkmService(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
  RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLSMS'], True, '');
  RestClient.ContentType   := 'application/json';
  RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestClient.AcceptCharset := 'UTF-8, *;q=0.8';

  RestResponse.ContentType := 'application/json';

  OAuth2Authenticator              := TOAuth2Authenticator.Create(RestClient);
  OAuth2Authenticator.TokenType    := TOAuth2TokenType.ttBEARER;
  OAuth2Authenticator.AccessToken  := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_TOKMKM'], True, '');

  RestClient.Authenticator := OAuth2Authenticator;

  Result := True;

end;

end.
