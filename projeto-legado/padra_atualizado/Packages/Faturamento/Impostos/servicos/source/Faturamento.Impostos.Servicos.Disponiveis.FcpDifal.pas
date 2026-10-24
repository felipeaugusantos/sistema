unit Faturamento.Impostos.Servicos.Disponiveis.FcpDifal;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Disponiveis.FcpDifal,
  Faturamento.Impostos.Interfaces.FcpDifal, Faturamento.Impostos.Servicos.Classe.FcpDifal;

type
  TFaturamentoImpostosServicosDisponiveisFcpDifal = class(TInterfacedObject, IFaturamentoImpostosServicosDisponiveisFcpDifal)
  public
    function CalcularValorFcpDifalFinal(AParametros: IParametrosServicoFcpDifal): IResultadoServicosClasseFcpDifal;

    class function New(): IFaturamentoImpostosServicosDisponiveisFcpDifal;
  end;

implementation

{ TFaturamentoImpostosServicosDisponiveisFcpDifal }

function TFaturamentoImpostosServicosDisponiveisFcpDifal.CalcularValorFcpDifalFinal(
  AParametros: IParametrosServicoFcpDifal): IResultadoServicosClasseFcpDifal;
begin
  Result := TFaturamentoImpostosServicosClasseFcpDifal.New(AParametros).CalcularValorFcpDifalFinal;
end;

class function TFaturamentoImpostosServicosDisponiveisFcpDifal.New: IFaturamentoImpostosServicosDisponiveisFcpDifal;
begin
  Result := Self.Create;
end;

end.
