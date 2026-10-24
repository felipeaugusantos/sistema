unit Impostos.Fat.Service.Interfaces;

interface

uses Faturamento.Impostos.Interfaces.Ipi, Impostos.Fat.Parametros.Interfaces.Ipi;

type
  IImpostosFatService = interface
    ['{017066D9-4E93-425F-81BE-4FB2385F15FA}']

    function CalcularValorIpi(AParametros: IImpostosFatParametrosIpi): IResultadoCalculoIPI;
    function CalcularValorIpiFinal(AParametros: IImpostosFatParametrosIpi): IResultadoCalculoIPI;
  end;

implementation

end.
