unit untAncoraResultError;

interface

uses
  System.Generics.Collections, untAncoraBase;

type
  TAncoraResultError = class
  private
    FMessage: string;
  public
    property Message: string read FMessage write FMessage;
  end;

  TListAncoraResultError = class(TAncoraJson)
  private
    FMessages: TObjectList<TAncoraResultError>;
  public
    constructor Create;
    destructor Destroy; override;

    class function FromJsonString<T: class, constructor>(AJsonString: string): T; reintroduce;
    property Messages: TObjectList<TAncoraResultError> read FMessages;
  end;

implementation

uses
  REST.Json, System.Json, System.SysUtils;

{ TListAncoraResultError }

constructor TListAncoraResultError.Create;
begin
  FMessages := TObjectList<TAncoraResultError>.Create;
end;

destructor TListAncoraResultError.Destroy;
begin
  FMessages.Free;
  inherited;
end;

class function TListAncoraResultError.FromJsonString<T>(AJsonString: string): T;
var
  LJsonValue: TJsonValue;
  LJsonArray: TJsonArray absolute LJsonValue;
  I: Integer;
  LJsonItem: TJsonValue;
  ListAncoraResultError: TListAncoraResultError;
begin
  Result := T.Create;
  ListAncoraResultError := TListAncoraResultError(Result);

  LJsonValue := TJSOnObject.ParseJSONValue(AJsonString);
  try
    if not (LJsonValue is TJsonArray) then
      raise Exception.Create('JSON não é um array!');

    for I := 0 to Pred(LJsonArray.Count) do
    begin
      LJsonItem := LJsonArray.Items[I];
      if (LJsonItem is TJsonObject) then
        ListAncoraResultError.Messages.Add(TJson.JsonToObject<TAncoraResultError>(TJsonObject(LJsonItem)));
    end;
  finally
    LJsonValue.Free;
  end;
end;

end.
