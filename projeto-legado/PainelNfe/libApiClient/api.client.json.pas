unit api.client.json;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Generics.Collections;

type
  TApiClientJson = class
  private
    FJsonObj: TJSONObject;
  public
    constructor Create(const AJsonString: String);
    destructor Destroy; override;
    function GetJsonValue(const AChave: String): String;
    function GetJsonArrayCount(const AChaveArr: String): Integer;
    function GetJsonArrayValue(const AChaveArr, AChave: String; const AIndex: Integer): String;
  end;

implementation

{ TApiClientJson }

constructor TApiClientJson.Create(const AJsonString: String);
begin
  FJsonObj := TJSonObject.ParseJSONValue(AJsonString) As TJSONObject;
end;

destructor TApiClientJson.Destroy;
begin
  FreeAndNil(FJsonObj);
  inherited;
end;

function TApiClientJson.GetJsonArrayCount(const AChaveArr: String): Integer;
Var
  LJsonArr: TJSONArray;
begin
  Result := 0;
  If Not Assigned(FJsonObj) Then
    Exit;

  LJsonArr := FJsonObj.GetValue(AChaveArr) As TJSONArray;
  If Assigned(LJsonArr) Then
    Result := LJsonArr.Count;
end;

function TApiClientJson.GetJsonArrayValue(const AChaveArr, AChave: String;
  const AIndex: Integer): String;
Var
  LJsonArr: TJSONArray;
  LJsonSub: TJSONObject;
  LJsonVal: TJSONValue;
begin
  Result := '';
  If Not Assigned(FJsonObj) Then
    Exit;

  LJsonArr := FJsonObj.GetValue(AChaveArr) As TJSONArray;
  if Not Assigned(LJsonArr) then
    Exit;

  LJsonSub := LJsonArr.Items[AIndex] As TJSONObject;
  If Not Assigned(LJsonSub) Then
    Exit;

  LJsonVal := LJsonSub.GetValue(AChave);
  If Assigned(LJsonVal) Then
    Result := LJsonVal.Value;
end;

function TApiClientJson.GetJsonValue(const AChave: String): String;
Var
  LJsonVal: TJSONValue;
begin
  Result := '';
  If Not Assigned(FJsonObj) Then
    Exit;

  LJsonVal := FJsonObj.GetValue(AChave);
  If Assigned(LJsonVal) Then
    Result := LJsonVal.Value;
end;

end.

