unit untQualiZapRestApi;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils, untFuncoesSimples, REST.Client, Data.DB, MemDS, DBAccess,
  Uni;

type
  TControllerQualiZap = class
  private
  public
    class function fConfigurarQualiZap(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TControllerQualiZap }

class function TControllerQualiZap.fConfigurarQualiZap(RestClient: TRestClient;
  OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
begin
  Result := True;

  try
    RestClient.BaseURL := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLWPP'], True, '');
    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/json';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;

end;

end.
