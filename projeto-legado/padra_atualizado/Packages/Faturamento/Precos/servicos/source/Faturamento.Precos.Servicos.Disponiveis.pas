unit Faturamento.Precos.Servicos.Disponiveis;

interface

uses Faturamento.Precos.Interfaces.Servicos.Disponiveis,
  Faturamento.Precos.Interfaces.Servicos.Disponiveis.PrecoCusto,
  Faturamento.Precos.Servicos.Disponiveis.PrecoCusto;


type
  TFaturamentoPrecosServicosDisponiveis = class(TInterfacedObject, IFaturamentoPrecosServicosDisponiveis)
  public
    function PrecoCusto: IFaturamentoPrecosServicosDisponiveisPrecoCusto;
  end;

  function GetFaturamentoPrecosService(): IFaturamentoPrecosServicosDisponiveis; stdcall;

implementation

{ TFaturamentoPrecosServicos }

function TFaturamentoPrecosServicosDisponiveis.PrecoCusto: IFaturamentoPrecosServicosDisponiveisPrecoCusto;
begin
  Result := TFaturamentoPrecosServicosDisponiveisPrecoCusto.New();
end;

function GetFaturamentoPrecosService(): IFaturamentoPrecosServicosDisponiveis; stdcall;
begin
  Result := TFaturamentoPrecosServicosDisponiveis.Create;
end;

exports GetFaturamentoPrecosService;

end.
