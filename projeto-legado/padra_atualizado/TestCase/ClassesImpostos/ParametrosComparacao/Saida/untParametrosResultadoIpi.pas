unit untParametrosResultadoIpi;

interface

Uses
 Shared.Functions.Types;


type
  IParametrosResultadoIpi = interface
    ['{45B30447-1F13-453A-B58D-2FE108ACF9AB}']
    function ValorCalculadoIPI: Double; overload;
    function ValorCalculadoIPI(AValue: Double): IParametrosResultadoIPI; overload;

    function BaseDeCalculoIPI: Double; overload;
    function BaseDeCalculoIPI(AValue: Double): IParametrosResultadoIPI; overload;
  end;

type
  TParametrosResultadoIpi = class(TInterfacedObject, IParametrosResultadoIpi)
  private
    FValorCalculadoIPI : Double;
    FBaseDeCalculoIPI  : Double;
  public
    function ValorCalculadoIPI: Double; overload;
    function ValorCalculadoIPI(AValue: Double): IParametrosResultadoIPI; overload;

    function BaseDeCalculoIPI: Double; overload;
    function BaseDeCalculoIPI(AValue: Double): IParametrosResultadoIPI; overload;

    class function New(): IParametrosResultadoIpi;
  end;

implementation

{ TParametrosResultadoFcp }

function TParametrosResultadoIpi.BaseDeCalculoIPI: Double;
begin
  Result := FBaseDeCalculoIPI;
end;

function TParametrosResultadoIpi.BaseDeCalculoIPI(
  AValue: Double): IParametrosResultadoIPI;
begin
  Result := Self;
  FBaseDeCalculoIPI := AValue;
end;

class function TParametrosResultadoIPI.New: IParametrosResultadoIPI;
begin
  Result := Self.Create;
end;

function TParametrosResultadoIpi.ValorCalculadoIPI: Double;
begin
  Result := FValorCalculadoIPI;
end;

function TParametrosResultadoIpi.ValorCalculadoIPI(
  AValue: Double): IParametrosResultadoIPI;
begin
  Result := Self;
  FValorCalculadoIPI := AValue;
end;

end.
