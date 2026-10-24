unit Faturamento.Impostos.Servicos.Disponiveis.IcmsSt;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Disponiveis.IcmsSt,
  Faturamento.Impostos.Interfaces.IcmsSt, Faturamento.Impostos.Servicos.Classe.IcmsSt;

type
  TFaturamentoImpostosServicosDisponiveisIcmsSt = class(TInterfacedObject, IFaturamentoImpostosServicosDisponiveisIcmsSt)
  public
    function CalcularValorIcmsSt(AParametros: IParametrosServicoIcmsSt): IResultadoServicosClasseIcmsSt;
    function CalcularValorIcmsStFinal(AParametros: IParametrosServicoIcmsSt): IResultadoServicosClasseIcmsSt;

    class function New(): IFaturamentoImpostosServicosDisponiveisIcmsSt;
  end;

implementation

{ TFaturamentoImpostosServicosDisponiveisIcmsSt }

function TFaturamentoImpostosServicosDisponiveisIcmsSt.CalcularValorIcmsSt(
  AParametros: IParametrosServicoIcmsSt): IResultadoServicosClasseIcmsSt;
begin
  Result :=
    TFaturamentoImpostosServicosClasseIcmsSt.New(AParametros).CalcularValorIcmsSt;
end;

function TFaturamentoImpostosServicosDisponiveisIcmsSt.CalcularValorIcmsStFinal(
  AParametros: IParametrosServicoIcmsSt): IResultadoServicosClasseIcmsSt;
begin
  Result :=
    TFaturamentoImpostosServicosClasseIcmsSt.New(AParametros).CalcularValorIcmsStFinal;
end;

class function TFaturamentoImpostosServicosDisponiveisIcmsSt.New: IFaturamentoImpostosServicosDisponiveisIcmsSt;
begin
  Result := Self.Create;
end;

end.
