unit Faturamento.Margem.Interfaces.Servicos.Disponiveis;

interface

uses Faturamento.Margem.Interfaces.Servicos.Disponiveis.MargemBruta,
  Faturamento.Margem.Interfaces.Servicos.Disponiveis.MargemVenda;

type
  IFaturamentoMargemServicosDisponiveis = interface
    ['{01FBDDB6-46A7-4C73-A08A-EE6777D7264B}']

    function MargemBruta: IFaturamentoMargemServicosDisponiveisMargemBruta;
    function MargemVenda: IFaturamentoMargemServicosDisponiveisMargemVenda;
  end;

implementation

end.
