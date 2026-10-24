unit Faturamento.Impostos.Servicos.Disponiveis.Icms;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Disponiveis.Icms,
  Faturamento.Impostos.Interfaces.Icms, Faturamento.Impostos.Servicos.Classe.Icms;

type
  TFaturamentoImpostosServicosDisponiveisIcms = class(TInterfacedObject, IFaturamentoImpostosServicosDisponiveisIcms)
  public
    function CalcularValorIcms(AParametros: IParametrosServicoIcms): IResultadoServicosClasseIcms;
    function CalcularValorIcmsFinal(AParametros: IParametrosServicoIcms): IResultadoServicosClasseIcms;

    class function New(): IFaturamentoImpostosServicosDisponiveisIcms;
  end;

implementation

{ TFaturamentoImpostosServicosDisponiveisIcms }

function TFaturamentoImpostosServicosDisponiveisIcms.CalcularValorIcms(
  AParametros: IParametrosServicoIcms): IResultadoServicosClasseIcms;
begin
  Result :=
    TFaturamentoImpostosServicosClasseIcms.New(AParametros).CalcularValorIcms;
end;

function TFaturamentoImpostosServicosDisponiveisIcms.CalcularValorIcmsFinal(
  AParametros: IParametrosServicoIcms): IResultadoServicosClasseIcms;
begin
  Result :=
    TFaturamentoImpostosServicosClasseIcms.New(AParametros).CalcularValorIcmsFinal;
end;

class function TFaturamentoImpostosServicosDisponiveisIcms.New: IFaturamentoImpostosServicosDisponiveisIcms;
begin
  Result := Self.Create;
end;

end.
