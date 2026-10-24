unit Controller.Faturamento.Interfaces.Precos.Generic;

interface

uses Controller.Faturamento.Interfaces.Precos.PrecoCusto;

type
  IControllerFaturamentoPrecosGeneric = interface
    ['{AAC87F80-1529-4798-9876-D9FC286E806E}']

    function PrecoCusto: IControllerFaturamentoPrecoCusto;
  end;

implementation

end.
