{**********************************************************************************************}
{* Classe responsável por converter um TField em um IDataSetField, assim é possivel trabalhar *}
{* com um dataset em outros projetos                                                          *}
{*******************************************************************************************PH*}
unit untFieldDataSetFieldWrapper;

interface

uses
  untIDataSet, DB;

type
  TFieldDataSetFieldWrapper = class(TInterfacedObject, IDataSetField)
  private
    field: TField;
  public
    constructor Create(const field: TField);
    function GetAsString: String;
    procedure SetAsString(const strTexto: String);
    function GetAsFloat: Double;
    procedure SetAsFloat(const fltValor: Double);
    function GetAsInteger: Integer;
    procedure SetAsInteger(const intValor: Integer);
    function GetAsDate: TDate;
    procedure SetAsDate(const dtaData: TDate);
    function GetAsValue: Variant;
    procedure SetAsValue(const vValor: Variant);
  end;

implementation

{ TFieldDataSetFieldWrapper }

constructor TFieldDataSetFieldWrapper.Create(const field: TField);
begin
  inherited Create();
  Self.field := field;
end;

function TFieldDataSetFieldWrapper.GetAsDate: TDate;
begin
  Result := field.AsDateTime;
end;

function TFieldDataSetFieldWrapper.GetAsFloat: Double;
begin
  Result := field.AsFloat;
end;

function TFieldDataSetFieldWrapper.GetAsInteger: Integer;
begin
  Result := field.AsInteger;
end;

function TFieldDataSetFieldWrapper.GetAsString: String;
begin
  Result := field.AsString;
end;

function TFieldDataSetFieldWrapper.GetAsValue: Variant;
begin
  Result := field.AsVariant;
end;

procedure TFieldDataSetFieldWrapper.SetAsDate(const dtaData: TDate);
begin
  field.AsDateTime := dtaData;
end;

procedure TFieldDataSetFieldWrapper.SetAsFloat(const fltValor: Double);
begin
  field.AsFloat := fltValor;
end;

procedure TFieldDataSetFieldWrapper.SetAsInteger(const intValor: Integer);
begin
  field.AsInteger := intValor;
end;

procedure TFieldDataSetFieldWrapper.SetAsString(const strTexto: String);
begin
  field.AsString := strTexto;
end;

procedure TFieldDataSetFieldWrapper.SetAsValue(const vValor: Variant);
begin
  field.AsVariant := vValor;
end;

end.
