unit untAlpeToken;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess;

type
  TAlpeToken = class
  private
    FAccess_token: String;
    FExpires_in: Extended;
    FNot_before_policy: Extended;
    FRefresh_expires_in: Extended;
    FRefresh_token: String;
    FScope: String;
    FSession_state: String;
    FToken_type: String;

    class function FromJsonString(AJsonString: string): TAlpeToken;
  public
    property access_token: String read FAccess_token write FAccess_token;
    property expires_in: Extended read FExpires_in write FExpires_in;
    property not_before_policy: Extended read FNot_before_policy write FNot_before_policy;
    property refresh_expires_in: Extended read FRefresh_expires_in write FRefresh_expires_in;
    property refresh_token: String read FRefresh_token write FRefresh_token;
    property scope: String read FScope write FScope;
    property session_state: String read FSession_state write FSession_state;
    property token_type: String read FToken_type write FToken_type;
  end;

  TControllerAlpeToken = class
  private
    class function fConfigurarAlpeToken(RestClient: TRestClient;
      OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  public
    class function fGetToken(strBaseUrl, strClientId, strClientSecret, strGrantType: String): TAlpeToken;
  end;

implementation

{ TAlpeToken }

uses untRestApi;

class function TAlpeToken.FromJsonString(AJsonString: string): TAlpeToken;
begin
  Result := TJson.JsonToObject<TAlpeToken>(AJsonString);
end;

class function TControllerAlpeToken.fConfigurarAlpeToken(RestClient: TRestClient;
  OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
  RestClient.ContentType := 'application/x-www-form-urlencoded';
  Result := True;
end;

class function TControllerAlpeToken.fGetToken(strBaseUrl, strClientId, strClientSecret, strGrantType: String): TAlpeToken;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('ALPE', fConfigurarAlpeToken);
  ControllerRest.RestClient.BaseURL := strBaseUrl;

  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := EmptyStr;
    RestRequest.Method   := rmPOST;

    RestRequest.Params.AddItem('client_id', strClientId, pkGETorPOST);
    RestRequest.Params.AddItem('client_secret', strClientSecret , pkGETorPOST);
    RestRequest.Params.AddItem('grant_type', strGrantType , pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200', '201'], '') then
      Result := TAlpeToken.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
