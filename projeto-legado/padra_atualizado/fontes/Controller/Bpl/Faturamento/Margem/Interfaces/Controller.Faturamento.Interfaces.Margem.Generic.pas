unit Controller.Faturamento.Interfaces.Margem.Generic;

interface

uses Controller.Faturamento.Interfaces.Margem.MargemBruta,
  Controller.Faturamento.Interfaces.Margem.MargemVenda;

type
  IControllerFaturamentoMargemGeneric = interface
    ['{AAC87F80-1529-4798-9876-D9FC286E806E}']

    function MargemBruta: IControllerFaturamentoMargemBruta;
    function MargemVenda: IControllerFaturamentoMargemVenda;
  end;

implementation

end.
