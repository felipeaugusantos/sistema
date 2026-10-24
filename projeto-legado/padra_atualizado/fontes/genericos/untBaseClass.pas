unit untBaseClass;

interface

uses
  untBaseIntf;

type
  {$M+}
  TBaseClass = class(TInterfacedObject,IBaseIntf)
  private
  protected
    //Object fields, etc
    FIsPersistent: Boolean;
    function GetIsPersistent: Boolean; virtual;
    procedure SetIsPersistent(const Value: Boolean); virtual;
  public
    constructor Create;virtual;
    constructor CreateProps(PropNames: array of string;
      PropValues: array of const); virtual;
    function Implements(const IID: TGUID): Boolean;
    function GetClass:TClass;
    procedure Validate; virtual; abstract;
    function HasPrimaryKey: Boolean; virtual; abstract;
  published
    //Object Properties
    property IsPersistent: Boolean read GetIsPersistent;
  end;
  {$M-}
  TBaseClassRef = class of TBaseClass;

implementation

uses SysUtils, TypInfo;

function TBaseClass.GetIsPersistent: Boolean;
begin
  Result := FIsPersistent;
end;

procedure TBaseClass.SetIsPersistent(const Value: Boolean);
begin
  FIsPersistent := Value;
end;

function TBaseClass.Implements(const IID: TGUID): Boolean;
begin
  Result := Supports(Self,IID);
end;

function TBaseClass.GetClass: TClass;
begin
  Result := Self.ClassType;
end;

constructor TBaseClass.Create;
begin
  inherited;
end;

constructor TBaseClass.CreateProps(PropNames: array of string;
  PropValues: array of const);
var
  I: Integer;
  VarRec: TVarRec;
begin
  for I := Low(PropNames) to High(PropNames) do
  begin
    VarRec := PropValues[I];
    case VarRec.VType of
      vtInteger:    SetOrdProp(Self, PropNames[I], PropValues[I].VInteger);
      vtBoolean:    SetOrdProp(Self, PropNames[I], Integer(PropValues[I].VBoolean));
      vtChar:       SetOrdProp(Self, PropNames[I], Integer(PropValues[I].VChar));
      vtExtended:   SetFloatProp(Self, PropNames[I], PropValues[I].VExtended^);
      vtString:     SetStrProp(Self, PropNames[I], String(PropValues[I].VString^));
      vtObject:     SetObjectProp(Self, PropNames[I], PropValues[I].VObject);
      vtAnsiString: SetStrProp(Self, PropNames[I], string(PropValues[I].VAnsiString));
      vtCurrency:   SetFloatProp(Self, PropNames[I], PropValues[I].VCurrency^);
      vtVariant:    SetVariantProp(Self, PropNames[I], PropValues[I].VVariant^);
      vtInterface:  SetInterfaceProp(Self, PropNames[I], IInterface(PropValues[I].VInterface));
      vtWideString: SetStrProp(Self, PropNames[I], WideString(PropValues[I].VWideString));
      vtInt64:      SetInt64Prop(Self, PropNames[I], PropValues[I].VInt64^);
    else
      // Tipos não tratados
      // vtPointer, vtPChar, vtClass, vtWideChar, vtPWideChar
      raise Exception.Create('Não foi possível configurar a propriedade "' +
        PropNames[I] + '"');
    end;
  end;
end;

end.
