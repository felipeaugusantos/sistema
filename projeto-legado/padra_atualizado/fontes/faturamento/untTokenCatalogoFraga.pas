unit untTokenCatalogoFraga;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, System.Classes,
  System.JSON, strUtils, Math, System.DateUtils, REST.Authenticator.OAuth,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types, Services.Core.Task.Monitor, Posix.Unistd;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni, untUtilMonitor, untFuncFatTypes;
  {$ENDIF LINUX}

type
  TRetornoTokenCatalogoFraga = class
  private
    FAccess_token: String;
    FExpires_in: Integer;
    FRefresh_expires_in: Extended;
    FScope: String;
    FToken_type: String;
  public
    property access_token: String read FAccess_token write FAccess_token;
    property expires_in: Integer read FExpires_in write FExpires_in;
    property refresh_expires_in: Extended read FRefresh_expires_in write FRefresh_expires_in;
    property scope: String read FScope write FScope;
    property token_type: String read FToken_type write FToken_type;
    class function FromJsonString(AJsonString: string): TRetornoTokenCatalogoFraga;
  end;

  TTokenCatalogoFraga = class
    private
      class function fRetToken: TRetornoTokenCatalogoFraga;
    public
      class procedure pRefreshTokenFraga;
  end;

var
  VS_strToken: String;
  VS_dtaExpire: TDateTime;

implementation

{ TTokenCatalogoFraga }

uses untRestApi, untTokenCatalogoFragaRestApi;

class procedure TTokenCatalogoFraga.pRefreshTokenFraga;
var
  RetornoTokenCatalogoFraga: TRetornoTokenCatalogoFraga;
begin
  if (Now < IncMinute(untTokenCatalogoFraga.VS_dtaExpire, -1)) then
    Exit;

  RetornoTokenCatalogoFraga := TTokenCatalogoFraga.fRetToken;
  try
    if not Assigned(RetornoTokenCatalogoFraga) then
      Exit;

    untTokenCatalogoFraga.VS_strToken := RetornoTokenCatalogoFraga.access_token;
    untTokenCatalogoFraga.VS_dtaExpire := IncSecond(Now, RetornoTokenCatalogoFraga.expires_in);
  finally
    if Assigned(RetornoTokenCatalogoFraga) then
      FreeAndNil(RetornoTokenCatalogoFraga);
  end;
end;

class function TTokenCatalogoFraga.fRetToken: TRetornoTokenCatalogoFraga;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('FRAGA_CATALOGO', TTokenCatalogoFragaRestApi.fConfigurarTokenCatalogoFraga);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Method := rmPOST;

    RestRequest.Params.AddItem('grant_type', 'client_credentials', pkGETorPOST);
    RestRequest.Params.AddItem('client_id', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_CIDFRA', VS_strCodEmp], True, EmptyStr), pkGETorPOST); //criar cfg
    RestRequest.Params.AddItem('client_secret', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_CSCFRA', VS_strCodEmp], True, EmptyStr), pkGETorPOST); //criar cfg

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr) then
      Result := TRetornoTokenCatalogoFraga.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

{ TRetornoTokenCatalogoFraga }

class function TRetornoTokenCatalogoFraga.FromJsonString(
  AJsonString: string): TRetornoTokenCatalogoFraga;
begin
  Result := TJson.JsonToObject<TRetornoTokenCatalogoFraga>(AJsonString);
end;

initialization
  untTokenCatalogoFraga.VS_dtaExpire := Now;

end.
