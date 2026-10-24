unit Faturamento.Margem.Servicos.Disponiveis;

interface

uses
  Faturamento.Margem.Interfaces.Servicos.Disponiveis,
  Faturamento.Margem.Interfaces.Servicos.Disponiveis.MargemBruta,
  Faturamento.Margem.Servicos.Disponiveis.MargemBruta,
  Faturamento.Margem.Interfaces.Servicos.Disponiveis.MargemVenda,
  Faturamento.Margem.Servicos.Disponiveis.MargemVenda;

type
  TFaturamentoMargemServicosDisponiveis = class(TInterfacedObject, IFaturamentoMargemServicosDisponiveis)
  public
    function MargemBruta : IFaturamentoMargemServicosDisponiveisMargemBruta;
    function MargemVenda : IFaturamentoMargemServicosDisponiveisMargemVenda;
  end;

  function GetFaturamentoMargemService(): IFaturamentoMargemServicosDisponiveis; stdcall;

implementation

{ TFaturamentoPrecosServicos }
function TFaturamentoMargemServicosDisponiveis.MargemBruta: IFaturamentoMargemServicosDisponiveisMargemBruta;
begin
  Result := TFaturamentoMargemServicosDisponiveisMargemBruta.New();
end;

function GetFaturamentoMargemService(): IFaturamentoMargemServicosDisponiveis; stdcall;
begin
  Result := TFaturamentoMargemServicosDisponiveis.Create;
end;

function TFaturamentoMargemServicosDisponiveis.MargemVenda: IFaturamentoMargemServicosDisponiveisMargemVenda;
begin
  Result := TFaturamentoMargemServicosDisponiveisMargemVenda.New();
end;

exports GetFaturamentoMargemService;

end.
