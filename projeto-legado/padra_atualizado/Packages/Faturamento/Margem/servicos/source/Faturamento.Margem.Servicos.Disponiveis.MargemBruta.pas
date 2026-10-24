unit Faturamento.Margem.Servicos.Disponiveis.MargemBruta;

interface

uses Faturamento.Margem.Interfaces.Servicos.Disponiveis.MargemBruta,
     Faturamento.Margem.Interfaces.MargemBruta, 
     Faturamento.Margem.Servicos.Classe.MargemBruta;

type
  TFaturamentoMargemServicosDisponiveisMargemBruta = class(TInterfacedObject, IFaturamentoMargemServicosDisponiveisMargemBruta)
  public
    function CalculaMargemBruta(const AParametros: IParametrosServicoMargemBruta): IResultadoServicosClasseMargemBruta;

    function CalculaMargemParaMarkup(const AParametros: IParametrosServicoMargemParaMarkup): IResultadoServicosClasseMargemBruta;

    class function New(): IFaturamentoMargemServicosDisponiveisMargemBruta;
  end;

implementation

{ TFaturamentoMargemServicosMargemBruta}

function TFaturamentoMargemServicosDisponiveisMargemBruta.CalculaMargemBruta(
  const AParametros: IParametrosServicoMargemBruta): IResultadoServicosClasseMargemBruta;
begin
  Result :=
    TFaturamentoMargemServicosClasseMargemBruta.New()
      .CalculaMargemBruta(AParametros);
end;

function TFaturamentoMargemServicosDisponiveisMargemBruta.CalculaMargemParaMarkup(
  const AParametros: IParametrosServicoMargemParaMarkup): IResultadoServicosClasseMargemBruta;
begin
  Result :=
    TFaturamentoMargemServicosClasseMargemBruta.New()
      .CalculaMargemParaMarkup(AParametros);
end;

class function TFaturamentoMargemServicosDisponiveisMargemBruta.New: IFaturamentoMargemServicosDisponiveisMargemBruta;
begin
  Result := Self.Create;
end;

end.
