unit Controller.Faturamento.Interfaces.Margem.MargemBruta;

interface

uses Faturamento.Margem.Interfaces.MargemBruta;

type
  IControllerFaturamentoMargemBruta = interface
    ['{77A76C3B-D550-4038-B190-646A6AB355A7}']
    function CalculaMargemBruta(const AParametros: IParametrosServicoMargemBruta): Double;

    function CalculaMargemParaMarkup(const AParametros: IParametrosServicoMargemParaMarkup): Double;
  end;

implementation

end.
