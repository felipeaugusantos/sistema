unit Yapay.Api.Authorization;

interface

uses
  SysUtils,
  Yapay.Api.Base,
  Yapay.Api.MessageResponse,
  Yapay.Api.ErrorResponse;

type
{$M+}
  TYapayApiAuthorization = class(TYapayApiBase)
  public
    type
      TAuthorization = class
      strict protected
        FCode: string;
        FStatus: Boolean;
      published
        property Code: string read FCode;
        property Status: Boolean read FStatus;
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

{ TYapayApiAuthorization }

procedure TYapayApiAuthorization.Clear;
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

constructor TYapayApiAuthorization.Create;
begin
  inherited;
  FMessageResponse := TMessageResponse.Create;
  FDataResponse := TDataResponse.Create;
  FErrorResponse := TErrorResponse.Create;
end;

destructor TYapayApiAuthorization.Destroy;
begin
  if Assigned(FMessageResponse) then
    FreeAndNil(FMessageResponse);

  if Assigned(FDataResponse) then
    FreeAndNil(FDataResponse);

  if Assigned(FErrorResponse) then
    FreeAndNil(FErrorResponse);

  inherited;
end;

{ TYapayApiAuthorization.TDataResponse }

procedure TYapayApiAuthorization.TDataResponse.Clear;
begin
  if Assigned(FAuthorization) then
    FreeAndNil(FAuthorization);
  FAuthorization := TAuthorization.Create;
end;

constructor TYapayApiAuthorization.TDataResponse.Create;
begin
  inherited;
  FAuthorization := TAuthorization.Create;
end;

destructor TYapayApiAuthorization.TDataResponse.Destroy;
begin
  if Assigned(FAuthorization) then
    FreeAndNil(FAuthorization);
  inherited;
end;

end.
