unit Impostos.Fat.Controller.Tipos.Ipi;

interface

uses
  Impostos.Fat.Controller.Interfaces.Ipi;

type
  TParametrosCalculoValorIpi = class(TInterfacedObject, IParametrosCalculoValorIpi)
  private
    FCodigoDoCliente: String;
    FCodigoDoProduto: String;
    FCodigoDaEmpresa: String;
    FTotalGeralDoItem: Double;
    FBaixaDeEntregaFutura: Boolean;
    FClienteConsumidorFinal: Boolean;
  public
    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosCalculoValorIpi; overload;

    function CodigoDoProduto: String; overload;
    function CodigoDoProduto(AValue: String): IParametrosCalculoValorIpi; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IParametrosCalculoValorIpi; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoValorIpi; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosCalculoValorIpi; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoValorIpi; overload;

    class function New: IParametrosCalculoValorIpi;
  end;

implementation

{ TCalcularValorIpi }

function TParametrosCalculoValorIpi.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosCalculoValorIpi;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosCalculoValorIpi.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosCalculoValorIpi.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosCalculoValorIpi;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosCalculoValorIpi.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosCalculoValorIpi.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosCalculoValorIpi.CodigoDaEmpresa(AValue: String): IParametrosCalculoValorIpi;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TParametrosCalculoValorIpi.CodigoDoCliente(AValue: String): IParametrosCalculoValorIpi;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TParametrosCalculoValorIpi.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TParametrosCalculoValorIpi.CodigoDoProduto: String;
begin
  Result := FCodigoDoProduto;
end;

function TParametrosCalculoValorIpi.CodigoDoProduto(AValue: String): IParametrosCalculoValorIpi;
begin
  Result := Self;
  FCodigoDoProduto := AValue;
end;

class function TParametrosCalculoValorIpi.New: IParametrosCalculoValorIpi;
begin
  Result := Self.Create;
end;

function TParametrosCalculoValorIpi.TotalGeralDoItem(AValue: Double): IParametrosCalculoValorIpi;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosCalculoValorIpi.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

end.
