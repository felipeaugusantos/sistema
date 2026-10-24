unit Faturamento.Margem.Interfaces.Servicos.Disponiveis.MargemBruta;

interface

uses Faturamento.Margem.Interfaces.MargemBruta;

type
  IFaturamentoMargemServicosDisponiveisMargemBruta = interface
    ['{11A21E05-8322-469D-B1C8-0F4BEDDC5902}']
   	
    function CalculaMargemBruta(const AParametros: IParametrosServicoMargemBruta): IResultadoServicosClasseMargemBruta;

    function CalculaMargemParaMarkup(const AParametros: IParametrosServicoMargemParaMarkup): IResultadoServicosClasseMargemBruta;
  end;

implementation

end.
