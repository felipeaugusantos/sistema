unit Faturamento.Impostos.Interfaces.Servicos.Disponiveis.ipi;

interface

uses Faturamento.Impostos.Interfaces.Ipi;

type
  IFaturamentoImpostosServicosDisponiveisIpi = interface
    ['{77F8F956-A5F4-46F3-A261-CB5CDF73FE52}']

    function CalcularValorIpi(AParametros: IParametrosServicoIPI): IResultadoServicosClasseIpi;
    function CalcularValorIpiProduto(AParametros: IParametrosServicoIPI): IResultadoServicosClasseIpi;
    function CalcularValorIpiFinal(AParametros: IParametrosServicoIPI): IResultadoServicosClasseIpi;
    function CalcularValorIpiEntrada(AParametros: IParametrosServicoIPI): Double;
  end;

implementation

end.
