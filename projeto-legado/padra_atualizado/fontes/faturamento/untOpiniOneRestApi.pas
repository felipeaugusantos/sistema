unit untOpiniOneRestApi;

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
  TControllerOpiniOne = class
  public
    class function fConfigurarOpiniOne(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TControllerOpiniOne }

class function TControllerOpiniOne.fConfigurarOpiniOne(RestClient: TRestClient;
  OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
begin
  Result := True;
  try
    RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLOPI'], True, '');
    //homologação
    //RestClient.BaseURL := 'https://api-hml.opini.one/v2/integracoes';
    RestClient.ContentType   := 'application/json';
    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

end.
