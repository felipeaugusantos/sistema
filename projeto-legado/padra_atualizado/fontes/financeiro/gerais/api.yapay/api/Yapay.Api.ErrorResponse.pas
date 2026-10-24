unit Yapay.Api.ErrorResponse;

interface

uses
  SysUtils,
  TypInfo,
  System.Generics.Collections;

type
{$M+}
  TGeneralError = class
  strict protected
    FCode: string;
    FMessage: string;
  published
    property Code: string read FCode;
    property Message: string read FMessage;
  end;

  TGeneralErrors = TObjectList<TGeneralError>;

  TErrorResponse = class
  strict private
    FGeneral_errors: TGeneralErrors;
  published
    property General_errors: TGeneralErrors read FGeneral_errors;
  public
   procedure Clear;
   constructor Create; reintroduce;
   destructor Destroy; override;
  end;
{$M-}

implementation

{ TErrorResponse }

procedure TErrorResponse.Clear;
begin
  if Assigned(FGeneral_errors) then
    FreeAndNil(FGeneral_errors);
  FGeneral_errors := TGeneralErrors.Create;
end;

constructor TErrorResponse.Create;
begin
  inherited;
  FGeneral_errors := TGeneralErrors.Create;
end;

destructor TErrorResponse.Destroy;
begin
  if Assigned(FGeneral_errors) then
    FreeAndNil(FGeneral_errors);
  inherited;
end;


end.
