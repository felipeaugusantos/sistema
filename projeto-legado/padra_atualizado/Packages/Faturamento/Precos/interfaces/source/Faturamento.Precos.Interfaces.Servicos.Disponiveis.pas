unit Faturamento.Precos.Interfaces.Servicos.Disponiveis;

interface

uses Faturamento.Precos.Interfaces.Servicos.Disponiveis.PrecoCusto;

type
  IFaturamentoPrecosServicosDisponiveis = interface
    ['{01FBDDB6-46A7-4C73-A08A-EE6777D7264B}']

    function PrecoCusto: IFaturamentoPrecosServicosDisponiveisPrecoCusto;
  end;

implementation

end.
