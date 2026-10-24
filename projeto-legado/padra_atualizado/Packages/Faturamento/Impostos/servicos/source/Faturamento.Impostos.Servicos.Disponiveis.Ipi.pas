unit Faturamento.Impostos.Servicos.Disponiveis.Ipi;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Disponiveis.ipi,
  Faturamento.Impostos.Interfaces.Ipi, Faturamento.Impostos.Servicos.Classe.Ipi;

type
  TFaturamentoImpostosServicosDisponiveisIpi = class(TInterfacedObject, IFaturamentoImpostosServicosDisponiveisIpi)
  public
    function CalcularValorIpi(AParametros: IParametrosServicoIPI): IResultadoServicosClasseIpi;
    function CalcularValorIpiProduto(AParametros: IParametrosServicoIPI): IResultadoServicosClasseIpi;
    function CalcularValorIpiFinal(AParametros: IParametrosServicoIPI): IResultadoServicosClasseIpi;
    function CalcularValorIpiEntrada(AParametros: IParametrosServicoIPI): Double;

    class function New(): IFaturamentoImpostosServicosDisponiveisIpi;
  end;

implementation

{ TFaturamentoImpostosServicosDisponiveisIpi }

function TFaturamentoImpostosServicosDisponiveisIpi.CalcularValorIpi(
  AParametros: IParametrosServicoIPI): IResultadoServicosClasseIpi;
begin
  Result :=
    TFaturamentoImpostosServicosClasseIpi.New(AParametros).CalcularValorIpi;
end;

function TFaturamentoImpostosServicosDisponiveisIpi.CalcularValorIpiFinal(
  AParametros: IParametrosServicoIPI): IResultadoServicosClasseIpi;
begin
  Result :=
    TFaturamentoImpostosServicosClasseIpi.New(AParametros).CalcularValorIpiFinal;
end;

function TFaturamentoImpostosServicosDisponiveisIpi.CalcularValorIpiProduto(
  AParametros: IParametrosServicoIPI): IResultadoServicosClasseIpi;
begin
  Result :=
    TFaturamentoImpostosServicosClasseIpi.New(AParametros).CalcularValorIpiProduto;
end;

function TFaturamentoImpostosServicosDisponiveisIpi.CalcularValorIpiEntrada(
  AParametros: IParametrosServicoIPI): Double;
begin
  Result :=
    TFaturamentoImpostosServicosClasseIpi.New(AParametros).CalcularValorIpiEntrada;
end;

class function TFaturamentoImpostosServicosDisponiveisIpi.New: IFaturamentoImpostosServicosDisponiveisIpi;
begin
  Result := Self.Create;
end;

end.
