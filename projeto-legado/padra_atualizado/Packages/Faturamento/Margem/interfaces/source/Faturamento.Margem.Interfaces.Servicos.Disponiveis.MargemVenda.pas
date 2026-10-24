unit Faturamento.Margem.Interfaces.Servicos.Disponiveis.MargemVenda;

interface

uses Faturamento.Margem.Interfaces.MargemVenda, System.Generics.Collections;

type
  IFaturamentoMargemServicosDisponiveisMargemVenda = interface
    ['{11A21E05-8322-469D-B1C8-0F4BEDDC5902}']
   	
    function CalculaMargemVenda(const AParametros: TList<IParametrosServicoMargemVenda>; AstrConfiguracaoMargemMarkup: String=''): TList<IResultadoServicosClasseMargemVenda>;
  end;

implementation

end.
