unit Impostos.Fat.Classe.Interfaces.Ipi;


interface

Uses
  Impostos.Fat.Parametros.Interfaces.Ipi,
  Faturamento.Impostos.Interfaces.Ipi;

type
  IImpostosFatClasseIpi = interface
    ['{59ADEF3E-ADC1-462C-B808-8598824EE2E7}']
    function CalcularValorDoIpi: IResultadoCalculoIPI;

    function CalcularValorDoIpiFinal: IResultadoCalculoIPI;

  end;

implementation

end.
