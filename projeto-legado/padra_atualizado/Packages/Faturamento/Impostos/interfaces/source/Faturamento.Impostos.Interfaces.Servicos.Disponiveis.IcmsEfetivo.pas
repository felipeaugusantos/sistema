unit Faturamento.Impostos.Interfaces.Servicos.Disponiveis.IcmsEfetivo;

interface

uses Faturamento.Impostos.Interfaces.IcmsEfetivo;

type
  IFaturamentoImpostosServicosDisponiveisIcmsEfetivo = interface
    ['{D5A6AE6F-A09E-4673-8B76-260C69F3D17C}']

    function CalcularValorIcmsEfetivo(AParametros: IParametrosServicoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo;
  end;

implementation

end.
