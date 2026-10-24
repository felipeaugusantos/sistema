unit Faturamento.Impostos.Interfaces.Servicos.Disponiveis.FcpDifal;

interface

uses Faturamento.Impostos.Interfaces.FcpDifal;

type
  IFaturamentoImpostosServicosDisponiveisFcpDifal = interface
    ['{E017F36A-D359-48F9-8135-A702EAC5C872}']

//    function CalcularValorIcmsSt(AParametros: IParametrosServicoIcmsSt): IResultadoServicosClasseIcmsSt;
    function CalcularValorFcpDifalFinal(AParametros: IParametrosServicoFcpDifal): IResultadoServicosClasseFcpDifal;
  end;

implementation

end.
