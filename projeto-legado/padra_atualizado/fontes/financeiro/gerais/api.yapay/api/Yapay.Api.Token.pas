unit Yapay.Api.Token;

interface

uses
  SysUtils,
  Yapay.Api.Base,
  Yapay.Api.MessageResponse,
  Yapay.Api.ErrorResponse;

type
{$M+}
  TYapayApiToken = class(TYapayApiBase)
  public
    type
      TAuthorization = class
      strict protected
        FAccess_Token: string;
        FAccess_Token_Expiration: TDateTime;
        FRefresh_Token: string;
        FRefresh_Token_Expiration: TDateTime;
      published
        property Access_Token: string read FAccess_Token;
        property Access_Token_Expiration: TDateTime read FAccess_Token_Expiration;
        property Refresh_Token: string read FRefresh_Token;
        property Refresh_Token_Expiration: TDateTime read FRefresh_Token_Expiration;
      end;

      TDataResponse = class
      strict private
        FAuthorization: TAuthorization;
      published
        property Authorization: TAuthorization read FAuthorization;
      public
       procedure Clear;
       constructor Create; reintroduce;
       destructor Destroy; override;
      end;
  strict private
      FMessageResponse: TMessageResponse;
      FDataResponse: TDataResponse;
      FErrorResponse: TErrorResponse;
  published
    property Message_Response: TMessageResponse read FMessageResponse;
    property Data_Response: TDataResponse read FDataResponse;
    property Error_Response: TErrorResponse read FErrorResponse;
  public
    procedure Clear;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;
{$M-}

implementation

{ TYapayApiToken.TDataResponse }

procedure TYapayApiToken.TDataResponse.Clear;
begin
  if Assigned(FAuthorization) then  
    FreeAndNil(FAuthorization);
  FAuthorization := TAuthorization.Create;
end;

constructor TYapayApiToken.TDataResponse.Create;
begin
  inherited;
  FAuthorization := TAuthorization.Create;
end;

destructor TYapayApiToken.TDataResponse.Destroy;
begin
  if Assigned(FAuthorization) then
    FreeAndNil(FAuthorization);
  inherited;
end;

{ TYapayApiToken }

procedure TYapayApiToken.Clear;
begin
  if Assigned(FMessageResponse) then
    FreeAndNil(FMessageResponse);
  FMessageResponse := TMessageResponse.Create;

  if Assigned(FDataResponse) then
    FreeAndNil(FDataResponse);
  FDataResponse := TDataResponse.Create;

  if Assigned(FErrorResponse) then
    FreeAndNil(FErrorResponse);
  FErrorResponse := TErrorResponse.Create;
end;

constructor TYapayApiToken.Create;
begin
  inherited;
  FMessageResponse := TMessageResponse.Create;
  FDataResponse := TDataResponse.Create;
  FErrorResponse := TErrorResponse.Create;
end;

destructor TYapayApiToken.Destroy;
begin
  if Assigned(FMessageResponse) then
    FreeAndNil(FMessageResponse);

  if Assigned(FDataResponse) then
    FreeAndNil(FDataResponse);

  if Assigned(FErrorResponse) then
    FreeAndNil(FErrorResponse);

  inherited;
end;

end.
