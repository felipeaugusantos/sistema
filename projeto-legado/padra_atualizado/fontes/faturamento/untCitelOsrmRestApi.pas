unit untCitelOsrmRestApi;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils, System.DateUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest,
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  TControllerCitelOsrmRestApi = class
  public
    class function fConfigurarCitelOsrm(ARestClient: TRestClient; AOAuth2Authenticator: TOAuth2Authenticator; ARestResponse: TRestResponse): Boolean;
  end;

implementation

{ TControllerCitelOsrmRestApi }

class function TControllerCitelOsrmRestApi.fConfigurarCitelOsrm(ARestClient: TRestClient;
  AOAuth2Authenticator: TOAuth2Authenticator; ARestResponse: TRestResponse): Boolean;
begin
  Result := True;

  try
    ARestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_RCIURL']);
    ARestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    ARestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    ARestClient.ContentType   := 'application/json';

    ARestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;

end;

end.
