{************************************************************************************}
{* Classe responsável por converter um TParam em um IDataSetParam, assim é possivel *}
{* trabalhar com um dataset em outros projetos                                      *}
{*********************************************************************************PH*}
unit untParamDataSetWrapper;

interface

uses
  untIDataSet, DB;

type
  TParamDataSetWrapper = class(TInterfacedObject, IDataSetParam)
  private
    param: TParam;
  public
    constructor Create(const param: TParam);
    function GetAsString: String;
    function GetAsInteger: Integer;
    function GetAsFloat: Double;
    function GetAsVariant: Variant;
    function GetAsDateTime: TDateTime;

    procedure SetAsString(const strTexto: String);
    procedure SetAsFloat(const fltValor: Double);
    procedure SetAsInteger(const intValor: Integer);
    procedure SetAsVariant(const varValor: Variant);
    procedure SetAsDateTime(const dtaValor: TDateTime);

    property AsString: String read GetAsString write SetAsString;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property Value: Variant Read GetAsVariant Write SetAsVariant;
    property AsVariant: Variant Read GetAsVariant Write SetAsVariant;
    property AsDateTime: TDateTime Read GetAsDateTime Write SetAsDateTime;

  end;

implementation

{ TParamDataSetWrapper }

constructor TParamDataSetWrapper.Create(const param: TParam);
begin
  inherited Create();
  Self.param := param;
end;

function TParamDataSetWrapper.GetAsDateTime: TDateTime;
begin
  Result := param.AsDateTime;
end;

function TParamDataSetWrapper.GetAsFloat: Double;
begin
  Result := param.AsFloat;
end;

function TParamDataSetWrapper.GetAsInteger: Integer;
begin
  Result := param.AsInteger;
end;

function TParamDataSetWrapper.GetAsString: String;
begin
  Result := param.AsString;
end;

function TParamDataSetWrapper.GetAsVariant: Variant;
begin
  Result := param.Value;
end;


procedure TParamDataSetWrapper.SetAsDateTime(const dtaValor: TDateTime);
begin
  param.AsDateTime := dtaValor;
end;

procedure TParamDataSetWrapper.SetAsFloat(const fltValor: Double);
begin
  param.AsFloat := fltValor;
end;

procedure TParamDataSetWrapper.SetAsInteger(const intValor: Integer);
begin
  param.AsInteger := intValor;
end;

procedure TParamDataSetWrapper.SetAsString(const strTexto: String);
begin
  param.AsString := strTexto;
end;

procedure TParamDataSetWrapper.SetAsVariant(const varValor: Variant);
begin
  param.Value := varValor;
end;

end.
