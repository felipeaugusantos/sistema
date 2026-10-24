unit Faturamento.Margem.Servicos.Disponiveis.MargemVenda;

interface

uses Faturamento.Margem.Interfaces.Servicos.Disponiveis.MargemVenda,
     Faturamento.Margem.Interfaces.MargemVenda,
     Faturamento.Margem.Servicos.Classe.MargemVenda,
     System.Generics.Collections;

type
  TFaturamentoMargemServicosDisponiveisMargemVenda = class(TInterfacedObject, IFaturamentoMargemServicosDisponiveisMargemVenda)
  public
    function CalculaMargemVenda(const AParametros: TList<IParametrosServicoMargemVenda>; AstrConfiguracaoMargemMarkup: String=''): TList<IResultadoServicosClasseMargemVenda>;


    class function New(): IFaturamentoMargemServicosDisponiveisMargemVenda;
  end;

implementation

{ TFaturamentoMargemServicosMargemBruta}

function TFaturamentoMargemServicosDisponiveisMargemVenda.CalculaMargemVenda(
  const AParametros: TList<IParametrosServicoMargemVenda>; AstrConfiguracaoMargemMarkup: String=''): TList<IResultadoServicosClasseMargemVenda>;
begin
  Result :=
    TFaturamentoMargemServicosClasseMargemVenda.New
      .CalculaMargemVenda(AParametros, AstrConfiguracaoMargemMarkup);
end;

class function TFaturamentoMargemServicosDisponiveisMargemVenda.New: IFaturamentoMargemServicosDisponiveisMargemVenda;
begin
  Result := Self.Create;
end;

end.
