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
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(const dtaValor: TDateTime);
  end;

implementation

{ TFieldDataSetFieldWrapper }

constructor TFieldDataSetFieldWrapper.Create(const field: TField);
begin
  inherited Create();
  Self.field := field;
end;

function TFieldDataSetFieldWrapper.GetAsDateTime: TDateTime;
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

procedure TFieldDataSetFieldWrapper.SetAsDateTime(const dtaValor: TDateTime);
begin
  field.AsDateTime := dtaValor;
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

end.
