unit Faturamento.Impostos.Interfaces.Servicos.Classe.Ipi;

interface

uses Faturamento.Impostos.Interfaces.Ipi;

type
  IFaturamentoImpostosServicosClasseIpi = interface
    ['{E947571C-C334-4079-A5A2-BEEB3A6605FA}']

    function CalcularValorIpi: IResultadoServicosClasseIpi;
    function CalcularValorIpiFinal: IResultadoServicosClasseIpi;
    function CalcularValorIpiProduto: IResultadoServicosClasseIpi;
    function CalcularValorIpiEntrada: Double;
  end;

implementation

end.
