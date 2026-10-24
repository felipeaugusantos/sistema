unit Faturamento.Impostos.Interfaces.Servicos.Disponiveis;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Disponiveis.ipi,
  Faturamento.Impostos.Interfaces.Servicos.Disponiveis.IcmsSt,
  Faturamento.Impostos.Interfaces.Servicos.Disponiveis.IcmsEfetivo,
  Faturamento.Impostos.Interfaces.Servicos.Disponiveis.FcpDifal;

type
  IFaturamentoImpostosServicosDisponiveis = interface
    ['{DC409F55-C269-4DA9-9915-BA70E042F237}']

    function Ipi: IFaturamentoImpostosServicosDisponiveisIpi;
    function IcmsSt: IFaturamentoImpostosServicosDisponiveisIcmsSt;
    function IcmsEfetivo: IFaturamentoImpostosServicosDisponiveisIcmsEfetivo;
    function FcpDifal: IFaturamentoImpostosServicosDisponiveisFcpDifal;
  end;

implementation

end.
