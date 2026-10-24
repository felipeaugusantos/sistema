unit Controller.Faturamento.Interfaces.Margem.MargemVenda;

interface

uses Faturamento.Margem.Interfaces.MargemVenda, System.Generics.Collections;

type
  IControllerFaturamentoMargemVenda = interface
    ['{77A76C3B-D550-4038-B190-646A6AB355A7}']

    function CalculaMargemVenda(const AParametros: TList<IParametrosServicoMargemVenda>; AstrConfiguracaoMargemMarkup: String=''): TList<IResultadoCalculoMargemVenda>;

//    function CalculaMargemParaMarkup(const AParametros: IParametrosServicoMargemParaMarkup): Double;
  end;

implementation

end.
