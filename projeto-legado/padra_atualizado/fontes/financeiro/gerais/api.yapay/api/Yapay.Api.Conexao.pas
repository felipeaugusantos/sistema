unit Yapay.Api.Conexao;

interface

uses
  System.JSON,
  System.Variants,
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  Yapay.Api.Helpers,
  Yapay.Api.Resources,
  Yapay.Api.Base,
  Yapay.Api.MessageResponse,
  Yapay.Api.ErrorResponse,
  Yapay.Api.Ambiente,
  Yapay.Api.TypeResponse,
  Yapay.Api.Core,
  Yapay.Api.Authorization,
  Yapay.Api.Token;

type
{$M+}
  TYapayApiConexao = class
  strict private
    type
      TMessageResponseHelper = class helper for TMessageResponse
      strict private
        function GetMessage: TTipoMessageResponse;
        procedure SetMessage(const Value: TTipoMessageResponse);
      published
        property Message: TTipoMessageResponse read GetMessage write SetMessage;
      end;

      TGeneralErrorHelper = class helper for TGeneralError
      strict private
        function GetCode: string;
        function GetMessage: string;
        procedure SetCode(const Value: string);
        procedure SetMessage(const Value: string);
      published
        property Code: string read GetCode write SetCode;
        property Message: string read GetMessage write SetMessage;
      end;

      TYapayApiAuthorizationTAuthorizationHelper = class helper for TYapayApiAuthorization.TAuthorization
      strict private
        function GetCode: string;
        function GetStatus: Boolean;
        procedure SetCode(const Value: string);
        procedure SetStatus(const Value: Boolean);
      published
        property Code: string read GetCode write SetCode;
        property Status: Boolean read GetStatus write SetStatus;
      end;

      TYapayApiTokenTAuthorizationHelper = class helper for TYapayApiToken.TAuthorization
      strict private
        function GetAccess_Token: string;
        function GetAccess_Token_Expiration: TDateTime;
        function GetRefresh_Token: string;
        function GetRefresh_Token_Expiration: TDateTime;
        procedure SetAccess_Token(const Value: string);
        procedure SetAccess_Token_Expiration(const Value: TDateTime);
        procedure SetRefresh_Token(const Value: string);
        procedure SetRefresh_Token_Expiration(const Value: TDateTime);
      published
        property Access_Token: string read GetAccess_Token write SetAccess_Token;
        property Access_Token_Expiration: TDateTime read GetAccess_Token_Expiration write SetAccess_Token_Expiration;
        property Refresh_Token: string read GetRefresh_Token write SetRefresh_Token;
        property Refresh_Token_Expiration: TDateTime read GetRefresh_Token_Expiration write SetRefresh_Token_Expiration;
      end;

      TAbstractClassGerar<T: TYapayApiBase> = class abstract
      strict private
        procedure ProcessaRetorno;
        procedure ProcessaError;
      strict protected
        FCore: TYapayApiCore;
        FOwner: TYapayApiConexao;
        FJSONRequest: TJSONObject;

        procedure ProcessaSuccess; virtual; abstract;
        function GetEndereco: string; virtual; abstract;
      public
        function Gerar: Boolean; virtual;
        constructor Create(AOwner: TYapayApiConexao); reintroduce;
      end;

      TAutorizarAplicacaoRevendedor = class(TAbstractClassGerar<TYapayApiAuthorization>)
      strict protected
        procedure ProcessaSuccess; override;
        function GetEndereco: string; override;
      public
        function Gerar: Boolean; override;
      end;

      TTokenDeAcesso = class(TAbstractClassGerar<TYapayApiToken>)
      strict protected
        procedure ProcessaSuccess; override;
        function GetEndereco: string; override;
      public
        function Gerar: Boolean; override;
      end;

    var
      FAmbiente: TYapayApiAmbiente;
      FActive: Boolean;
      FReseller_token: string;
      FToken_account: string;
      FConsumer_key: string;
      FConsumer_secret: string;
      FType_response: TTypeResponse;
      FDebug: Boolean;
      FLog: Boolean;
      FAuthorization: TYapayApiAuthorization;
      FToken: TYapayApiToken;
    function GetActive: Boolean;
    procedure SetGetActive(const Value: Boolean);
    function RequisitaPermissoes: Boolean;
  published
    property Active: Boolean read GetActive write SetGetActive default False;
    property Ambiente: TYapayApiAmbiente read FAmbiente write FAmbiente default Sandbox;
    property Consumer_key: string read FConsumer_key write FConsumer_key;
    property Consumer_secret: string read FConsumer_secret write FConsumer_secret;
    property Reseller_token: string read FReseller_token write FReseller_token;
    property Token_account: string read FToken_account write FToken_account;
    property Type_response: TTypeResponse read FType_response write FType_response default JSON;
    property Debug: Boolean read FDebug write FDebug default False;
    property Log: Boolean read FLog write FLog default False;
    property Authorization: TYapayApiAuthorization read FAuthorization;
    property Token: TYapayApiToken read FToken;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;
{$M-}

implementation

{ TYapayApiConexao }

constructor TYapayApiConexao.Create;
begin
  inherited;
  FAmbiente := Sandbox;
  FReseller_token := NullAsStringValue;
  FToken_account := NullAsStringValue;
  FConsumer_key := NullAsStringValue;
  FConsumer_secret := NullAsStringValue;
  FType_response := TTypeResponse.JSON;
  FAuthorization := TYapayApiAuthorization.Create;
  FToken := TYapayApiToken.Create;
  FActive := False;
end;

function TYapayApiConexao.GetActive: Boolean;
begin
  Result := FActive;
end;

procedure TYapayApiConexao.SetGetActive(const Value: Boolean);
begin
  FAuthorization.Clear;
  FToken.Clear;
  FActive := False;
  if Value then
    FActive := RequisitaPermissoes and Value;
end;

function TYapayApiConexao.RequisitaPermissoes: Boolean;
var
  oAPIAutorizarAplicacaoRevendedor: TAutorizarAplicacaoRevendedor;
  oTokenDeAcesso: TTokenDeAcesso;
begin
  oAPIAutorizarAplicacaoRevendedor := TAutorizarAplicacaoRevendedor.Create(Self);
  oTokenDeAcesso := TTokenDeAcesso.Create(Self);
  try
    result := oAPIAutorizarAplicacaoRevendedor.Gerar and
              oTokenDeAcesso.Gerar;
  finally
    if Assigned(oAPIAutorizarAplicacaoRevendedor) then
      FreeAndNil(oAPIAutorizarAplicacaoRevendedor);

    if Assigned(oTokenDeAcesso) then
      FreeAndNil(oTokenDeAcesso);
  end;
end;

destructor TYapayApiConexao.Destroy;
begin
  if Assigned(FAuthorization) then
    FreeAndNil(FAuthorization);

  if Assigned(FToken) then
    FreeAndNil(FToken);

  inherited;
end;

{ TYapayApiConexao.TMessageResponseHelper }

function TYapayApiConexao.TMessageResponseHelper.GetMessage: TTipoMessageResponse;
begin
  result := FMessage;
end;

procedure TYapayApiConexao.TMessageResponseHelper.SetMessage(
  const Value: TTipoMessageResponse);
begin
  FMessage := Value;
end;

{ TYapayApiConexao.TGeneralErrorHelper }

function TYapayApiConexao.TGeneralErrorHelper.GetCode: string;
begin
  result := FCode;
end;

function TYapayApiConexao.TGeneralErrorHelper.GetMessage: string;
begin
  result := FMessage;
end;

procedure TYapayApiConexao.TGeneralErrorHelper.SetCode(const Value: string);
begin
  FCode := Value;
end;

procedure TYapayApiConexao.TGeneralErrorHelper.SetMessage(const Value: string);
begin
  FMessage := Value;
end;

{ TYapayApiConexao.TAutorizarAplicacaoRevendedor }

function TYapayApiConexao.TAutorizarAplicacaoRevendedor.GetEndereco: string;
begin
  inherited;
  case FOwner.Ambiente of
    Sandbox: result := rsYAPAY_API_AUTORIZAR_APLICACAO_REVENDEDOR_ENDERECO_SANDBOX;
    Producao: result := rsYAPAY_API_AUTORIZAR_APLICACAO_REVENDEDOR_ENDERECO_PRODUCAO;
    else
    begin
      result := NullAsStringValue;
    end;
  end;
end;

function TYapayApiConexao.TAutorizarAplicacaoRevendedor.Gerar: Boolean;
begin
  FJSONRequest := TJSONObject.Create;
  try
    FJSONRequest.AddPair('consumer_key', FOwner.Consumer_key);
    FJSONRequest.AddPair('consumer_secret', FOwner.Consumer_secret);
    FJSONRequest.AddPair('reseller_token', FOwner.Reseller_token);
    FJSONRequest.AddPair('token_account', FOwner.Token_account);
    FJSONRequest.AddPair('type_response', FOwner.Type_response.ToFlag);
    Result := inherited Gerar;
  finally
    if Assigned(FJSONRequest) then
      FreeAndNil(FJSONRequest);
  end;
end;

procedure TYapayApiConexao.TAutorizarAplicacaoRevendedor.ProcessaSuccess;
var
  oJSONObj, oJSONSubObj: TJSONObject;
  oJSONValue: TJSONValue;
begin
  inherited;
  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;
    oJSONValue := oJSONObj.Get('data_response').JsonValue;

    oJSONSubObj := oJSONValue as TJSONObject;
    oJSONValue := oJSONSubObj.Get('authorization').JsonValue;

    oJSONSubObj := oJSONValue as TJSONObject;
    oJSONValue := oJSONSubObj.Get('code').JsonValue;
    FOwner.Authorization.Data_Response.Authorization.Code := oJSONValue.Value;

    oJSONValue := oJSONSubObj.Get('status').JsonValue;
    FOwner.Authorization.Data_Response.Authorization.Status := CompareText(oJSONValue.Value, 'true') = 0;
  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

{ TYapayApiConexao.TYapayApiAuthorizationTAuthorizationHelper }

function TYapayApiConexao.TYapayApiAuthorizationTAuthorizationHelper.GetCode: string;
begin
  result := FCode;
end;

function TYapayApiConexao.TYapayApiAuthorizationTAuthorizationHelper.GetStatus: Boolean;
begin
  result := FStatus;
end;

procedure TYapayApiConexao.TYapayApiAuthorizationTAuthorizationHelper.SetCode(const Value: string);
begin
  FCode := Value;
end;

procedure TYapayApiConexao.TYapayApiAuthorizationTAuthorizationHelper.SetStatus(const Value: Boolean);
begin
  FStatus := Value;
end;

{ TYapayApiConexao.TTokenDeAcesso }

function TYapayApiConexao.TTokenDeAcesso.GetEndereco: string;
begin
  inherited;
  case FOwner.Ambiente of
    Sandbox: result := rsYAPAY_API_TOKEN_DE_ACESSO_ENDERECO_SANDBOX;
    Producao: result := rsYAPAY_API_TOKEN_DE_ACESSO_ENDERECO_PRODUCAO;
    else
    begin
      result := NullAsStringValue;
    end;
  end;
end;

procedure TYapayApiConexao.TTokenDeAcesso.ProcessaSuccess;
var
  oJSONObj, oJSONSubObj: TJSONObject;
  oJSONValue: TJSONValue;
begin
  inherited;
  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;
    oJSONValue := oJSONObj.Get('data_response').JsonValue;

    oJSONSubObj := oJSONValue as TJSONObject;
    oJSONValue := oJSONSubObj.Get('authorization').JsonValue;

    oJSONSubObj := oJSONValue as TJSONObject;
    oJSONValue := oJSONSubObj.Get('access_token').JsonValue;
    FOwner.Token.Data_Response.Authorization.Access_Token := oJSONValue.Value;

    oJSONValue := oJSONSubObj.Get('access_token_expiration').JsonValue;
    FOwner.Token.Data_Response.Authorization.Access_Token_Expiration := oJSONValue.ToDatetime;

    oJSONValue := oJSONSubObj.Get('refresh_token').JsonValue;
    FOwner.Token.Data_Response.Authorization.Refresh_Token := oJSONValue.Value;

    oJSONValue := oJSONSubObj.Get('refresh_token_expiration').JsonValue;
    FOwner.Token.Data_Response.Authorization.Refresh_Token_Expiration := oJSONValue.ToDatetime;

  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

function TYapayApiConexao.TTokenDeAcesso.Gerar: Boolean;
begin
  FJSONRequest := TJSONObject.Create;
  try
    FJSONRequest.AddPair('consumer_key', FOwner.Consumer_key);
    FJSONRequest.AddPair('consumer_secret', FOwner.Consumer_secret);
    FJSONRequest.AddPair('code', FOwner.Authorization.Data_Response.Authorization.Code);
    FJSONRequest.AddPair('type_response', FOwner.Type_response.ToFlag);
    Result := inherited Gerar;
  finally
    if Assigned(FJSONRequest) then
      FreeAndNil(FJSONRequest);
  end;
end;

{ TYapayApiConexao.TYapayApiTokenTAuthorizationHelper }

function TYapayApiConexao.TYapayApiTokenTAuthorizationHelper.GetAccess_Token: string;
begin
  result := FAccess_Token;
end;

function TYapayApiConexao.TYapayApiTokenTAuthorizationHelper.GetAccess_Token_Expiration: TDateTime;
begin
  result := FAccess_Token_Expiration;
end;

function TYapayApiConexao.TYapayApiTokenTAuthorizationHelper.GetRefresh_Token: string;
begin
  result := FRefresh_Token;
end;

function TYapayApiConexao.TYapayApiTokenTAuthorizationHelper.GetRefresh_Token_Expiration: TDateTime;
begin
  result := Refresh_Token_Expiration
end;

procedure TYapayApiConexao.TYapayApiTokenTAuthorizationHelper.SetAccess_Token(
  const Value: string);
begin
  FAccess_Token := value;
end;

procedure TYapayApiConexao.TYapayApiTokenTAuthorizationHelper.SetAccess_Token_Expiration(
  const Value: TDateTime);
begin
  FAccess_Token_Expiration := value;
end;

procedure TYapayApiConexao.TYapayApiTokenTAuthorizationHelper.SetRefresh_Token(
  const Value: string);
begin
  FRefresh_Token := value;
end;

procedure TYapayApiConexao.TYapayApiTokenTAuthorizationHelper.SetRefresh_Token_Expiration(
  const Value: TDateTime);
begin
  FRefresh_Token_Expiration := Value;
end;

{ TYapayApiConexao.TAbstractClassGerar }

constructor TYapayApiConexao.TAbstractClassGerar<T>.Create(AOwner: TYapayApiConexao);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TYapayApiConexao.TAbstractClassGerar<T>.Gerar: Boolean;
begin
  FCore := TYapayApiCore.Create;
  try
    FCore.Metodo := Post;
    FCore.Debug := FOwner.Debug;
    FCore.Log := FOwner.Log;
    FCore.BaseURL := GetEndereco;
    FCore.JSONEnvio := FJSONRequest.ToJSON;
    FCore.Execute;
    ProcessaRetorno;
    FCore.Access_Token := FOwner.Token.Data_Response.Authorization.Access_Token;
    Result :=
      (FOwner.Authorization.Message_Response.Message = TTipoMessageResponse.Success) and
      (FOwner.Token.Message_Response.Message = TTipoMessageResponse.Success);
  finally
    if Assigned(FCore) then
      FreeAndNil(FCore);
  end;
end;

procedure TYapayApiConexao.TAbstractClassGerar<T>.ProcessaError;
var
  oJSONObj, oJSONSubObj: TJSONObject;
  oJSONValue: TJSONValue;
  oJSONArray: TJSONArray;
  I: integer;
  oGeneralError: TGeneralError;
begin
  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;
    oJSONValue := oJSONObj.Get('error_response').JsonValue;
    oJSONSubObj := oJSONValue as TJSONObject;
    oJSONValue := oJSONSubObj.Get('general_errors').JsonValue;
    oJSONArray := oJSONValue as TJSONArray;

    for I := 0 to oJSONArray.Count - 1 do
    begin
      oGeneralError := TGeneralError.Create;

      oJSONValue := oJSONArray.Items[i];
      oJSONSubObj := oJSONValue as TJSONObject;

      oJSONValue := oJSONSubObj.Get('code').JsonValue;
      oGeneralError.Code := oJSONValue.Value;

      oJSONValue := oJSONSubObj.Get('message').JsonValue;
      oGeneralError.Message := oJSONValue.Value;

      if TClass(T) = TYapayApiAuthorization then
        FOwner.Authorization.Error_Response.General_errors.add(oGeneralError)
      else if TClass(T) = TYapayApiToken then
        FOwner.Token.Error_Response.General_errors.add(oGeneralError);
    end;
  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

procedure TYapayApiConexao.TAbstractClassGerar<T>.ProcessaRetorno;
var
  oJSONObj, oJSONSubObj: TJSONObject;
  oJSONValue: TJSONValue;
begin
  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;
    oJSONValue := oJSONObj.Get('message_response').JsonValue;

    oJSONSubObj := oJSONValue as TJSONObject;
    oJSONValue := oJSONSubObj.Get('message').JsonValue;

    if TClass(T) = TYapayApiAuthorization then
    begin
      FOwner.Authorization.Message_Response.Message := TTipoMessageResponse.GetByName(oJSONValue.Value);
      FOwner.Authorization.Data_Response.Clear;
      FOwner.Authorization.Error_Response.Clear;

      case FOwner.Authorization.Message_Response.Message of
        Error: ProcessaError;
        Success: ProcessaSuccess;
      end;
    end
    else if TClass(T) = TYapayApiToken then
    begin
      FOwner.Token.Message_Response.Message := TTipoMessageResponse.GetByName(oJSONValue.Value);
      FOwner.Token.Data_Response.Clear;
      FOwner.Token.Error_Response.Clear;

      case FOwner.Token.Message_Response.Message of
        Error: ProcessaError;
        Success: ProcessaSuccess;
      end;
    end;
  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

end.
