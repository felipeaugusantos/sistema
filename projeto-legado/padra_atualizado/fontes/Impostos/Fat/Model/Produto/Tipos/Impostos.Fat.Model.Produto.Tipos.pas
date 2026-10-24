unit Impostos.Fat.Model.Produto.Tipos;

interface

uses Impostos.Fat.Model.Produto.Interfaces;

type
  TResultadoImpostosFatModelProduto = class(TInterfacedObject, IResultadoImpostosFatModelProduto)
  private
    FIpiDeSaida: Double;
  public
    function IpiDeSaida: Double; overload;
    function IpiDeSaida(AValue: Double): IResultadoImpostosFatModelProduto; overload;

    class function New(): IResultadoImpostosFatModelProduto;
  end;

implementation

{ TResultadoImpostosFatModelProduto }

function TResultadoImpostosFatModelProduto.IpiDeSaida: Double;
begin
  Result := FIpiDeSaida;
end;

function TResultadoImpostosFatModelProduto.IpiDeSaida(
  AValue: Double): IResultadoImpostosFatModelProduto;
begin
  Result := Self;
  FIpiDeSaida := AValue;
end;

class function TResultadoImpostosFatModelProduto.New: IResultadoImpostosFatModelProduto;
begin
  Result := Self.Create;
end;

end.
