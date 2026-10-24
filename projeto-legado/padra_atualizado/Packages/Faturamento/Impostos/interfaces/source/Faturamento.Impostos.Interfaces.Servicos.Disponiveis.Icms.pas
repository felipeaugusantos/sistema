unit Faturamento.Impostos.Interfaces.Servicos.Disponiveis.Icms;

interface

uses Faturamento.Impostos.Interfaces.Icms;

type
  IFaturamentoImpostosServicosDisponiveisIcms = interface
    ['{D5A6AE6F-A09E-4673-8B76-260C69F3D17C}']

    function CalcularValorIcms(AParametros: IParametrosServicoIcms): IResultadoServicosClasseIcms;
    function CalcularValorIcmsFinal(AParametros: IParametrosServicoIcms): IResultadoServicosClasseIcms;
  end;

implementation

end.
