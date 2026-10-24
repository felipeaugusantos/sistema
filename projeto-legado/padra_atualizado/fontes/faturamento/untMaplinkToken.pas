unit untMaplinkToken;

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

  TMaplinkToken = class
  private
    FAccess_token: String;
    FApi_product_list: String;
    FApi_product_list_json: TArray<String>;
    FApplication_name: String;
    FClient_id: String;
    FDeveloper_email: String;
    FExpires_in: String;
    FIssued_at: String;
    FOrganization_name: String;
    FRefresh_count: String;
    FRefresh_token_expires_in: String;
    FScope: String;
    FStatus: String;
    FToken_type: String;
  public
    property access_token: String read FAccess_token write FAccess_token;
    property api_product_list: String read FApi_product_list write FApi_product_list;
    property api_product_list_json: TArray<String> read FApi_product_list_json write FApi_product_list_json;
    property application_name: String read FApplication_name write FApplication_name;
    property client_id: String read FClient_id write FClient_id;
    property developer_email: String read FDeveloper_email write FDeveloper_email;
    property expires_in: String read FExpires_in write FExpires_in;
    property issued_at: String read FIssued_at write FIssued_at;
    property organization_name: String read FOrganization_name write FOrganization_name;
    property refresh_count: String read FRefresh_count write FRefresh_count;
    property refresh_token_expires_in: String read FRefresh_token_expires_in write FRefresh_token_expires_in;
    property scope: String read FScope write FScope;
    property status: String read FStatus write FStatus;
    property token_type: String read FToken_type write FToken_type;
    class function FromJsonString(AJsonString: string): TMaplinkToken;
  end;

  TControllerMaplinkToken = class
  private
    class function fConfigurarMaplinkToken(RestClient: TRestClient;
      OAuth2Authenticator: TOAuth2Authenticator;
      RestResponse: TRestResponse): Boolean;
  public
    class function fGetToken(strBaseUrl, strClientId, strClientSecret: String): TMaplinkToken;
  end;

implementation

uses untRestApi;

{ TMaplinkToken }

class function TMaplinkToken.FromJsonString(AJsonString: string): TMaplinkToken;
begin
  Result := TJson.JsonToObject<TMaplinkToken>(AJsonString)
end;

{ TControllerMaplinkToken }

class function TControllerMaplinkToken.fConfigurarMaplinkToken(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
  RestClient.ContentType := 'application/x-www-form-urlencoded';
  Result := True;
end;

class function TControllerMaplinkToken.fGetToken(strBaseUrl, strClientId,
  strClientSecret: String): TMaplinkToken;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', fConfigurarMaplinkToken);
  ControllerRest.RestClient.BaseURL := strBaseUrl;

  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'oauth/client_credential/accesstoken?grant_type=client_credentials';
    RestRequest.Method   := rmPOST;

    RestRequest.Params.AddItem('client_id', strClientId, pkGETorPOST);
    RestRequest.Params.AddItem('client_secret', strClientSecret , pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TMaplinkToken.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
