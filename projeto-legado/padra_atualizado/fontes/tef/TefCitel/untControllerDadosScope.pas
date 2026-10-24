unit untControllerDadosScope;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest,
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess;

type

  TControllerDadosScope = class
  public
    destructor Destroy; Override;
    class function fConfigurarApiScope(RestClient: TRestClient;
                                       OAuth2Authenticator: TOAuth2Authenticator;
                                       RestResponse: TRestResponse): Boolean;
  end;

implementation

uses untRepositorioDadosScope ;

{ TControllerDadosScope }

destructor TControllerDadosScope.Destroy;
begin

end;

class function TControllerDadosScope.fConfigurarApiScope(RestClient: TRestClient;
                                                         OAuth2Authenticator: TOAuth2Authenticator;
                                                         RestResponse: TRestResponse): Boolean;
begin
  Result := True;

  try
    RestClient.BaseURL       := TRepositorioDadosScope.fGetURL;

    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/json';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

end.
