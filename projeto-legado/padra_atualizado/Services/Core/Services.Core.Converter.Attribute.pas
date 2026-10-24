unit Services.Core.Converter.Attribute;

interface

uses System.SysUtils, System.Variants, System.Rtti, System.Generics.Collections;

type
  TExec = procedure of object;

  TAttributeConverter = class abstract(TCustomAttribute)
  public
    function ConvertToDatabaseColumn(AValue: TValue): TValue; virtual; abstract;
    function ConvertToEntityAttribute(AValue: TValue): TValue; virtual;
      abstract;
  end;

  TBooleanSNConverter = class(TAttributeConverter)
  public
    function ConvertToDatabaseColumn(AValue: TValue): TValue; override;
    function ConvertToEntityAttribute(AValue: TValue): TValue; override;
  end;

  TJsonListConverter = class abstract(TCustomAttribute)
  public
    function ToJson(AInstance: TObject): String; virtual; abstract;
    procedure FromJson(AInstance: TObject; AJson: String); virtual; abstract;
  end;

  TJsonIgnore = class abstract(TCustomAttribute);

implementation

uses
  System.TypInfo, Services.Core.JsonCitel.Serializer;

{ TBooleanSNConverter }

function TBooleanSNConverter.ConvertToDatabaseColumn(AValue: TValue): TValue;
begin
  if not AValue.IsEmpty and AValue.AsBoolean then
    Result := 'S'
  else
    Result := 'N';
end;

function TBooleanSNConverter.ConvertToEntityAttribute(AValue: TValue): TValue;
begin
  Result := TValue.From(UpperCase(AValue.AsString).Equals('S'));
end;

end.

