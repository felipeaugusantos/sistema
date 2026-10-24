unit Faturamento.Impostos.Servicos.Disponiveis.IcmsEfetivo;

interface

uses
  Faturamento.Impostos.Interfaces.Servicos.Disponiveis.IcmsEfetivo,
  Faturamento.Impostos.Interfaces.IcmsEfetivo,
  Faturamento.Impostos.Servicos.Classe.IcmsEfetivo;

type
  TFaturamentoImpostosServicosDisponiveisIcmsEfetivo = class(TInterfacedObject, IFaturamentoImpostosServicosDisponiveisIcmsEfetivo)
  public
    function CalcularValorIcmsEfetivo(AParametros: IParametrosServicoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo;

    class function New(): IFaturamentoImpostosServicosDisponiveisIcmsEfetivo;
  end;

implementation

{ TFaturamentoImpostosServicosDisponiveisIcmsEfetivo }

function TFaturamentoImpostosServicosDisponiveisIcmsEfetivo.CalcularValorIcmsEfetivo(
  AParametros: IParametrosServicoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo;
begin
  Result :=
    TFaturamentoImpostosServicosClasseIcmsEfetivo.New(AParametros).CalcularValorIcmsEfetivo;
end;

class function TFaturamentoImpostosServicosDisponiveisIcmsEfetivo.New: IFaturamentoImpostosServicosDisponiveisIcmsEfetivo;
begin
  Result := Self.Create;
end;

end.
