unit Faturamento.Impostos.Interfaces.Servicos.Disponiveis.IcmsSt;

interface

uses Faturamento.Impostos.Interfaces.IcmsSt;

type
  IFaturamentoImpostosServicosDisponiveisIcmsSt = interface
    ['{D5A6AE6F-A09E-4673-8B76-260C69F3D17C}']

    function CalcularValorIcmsSt(AParametros: IParametrosServicoIcmsSt): IResultadoServicosClasseIcmsSt;
    function CalcularValorIcmsStFinal(AParametros: IParametrosServicoIcmsSt): IResultadoServicosClasseIcmsSt;
  end;

implementation

end.
