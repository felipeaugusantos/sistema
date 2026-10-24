unit Faturamento.Margem.Interfaces.Servicos.Classe.MargemVenda;

interface

uses Faturamento.Margem.Interfaces.MargemVenda, System.Generics.Collections;

type
  IFaturamentoMargemServicosClasseMargemVenda = interface
    ['{93B3E040-0141-46AF-91B7-C61822F469E7}']

    function CalculaMargemVenda(const AParametros: TList<IParametrosServicoMargemVenda>; AstrConfiguracaoMargemMarkup: String=''): TList<IResultadoServicosClasseMargemVenda>;
  end;

implementation

end.
