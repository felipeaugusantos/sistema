unit Faturamento.Margem.Interfaces.Servicos.Classe.MargemBruta;

interface

uses Faturamento.Margem.Interfaces.MargemBruta;

type
  IFaturamentoMargemServicosClasseMargemBruta = interface
    ['{93B3E040-0141-46AF-91B7-C61822F469E7}']

    function CalculaMargemBruta(const AParametros: IParametrosServicoMargemBruta): IResultadoServicosClasseMargemBruta;

    function CalculaMargemParaMarkup(const AParametros: IParametrosServicoMargemParaMarkup): IResultadoServicosClasseMargemBruta;
  end;

implementation

end.
