unit Reforma.Calculo.CustoVenda;

// pCalculaCustoVenda da calculadora: usada pelos lados Atual, Novo e Futuro.

interface

uses
  Reforma.Contrato.Tipos;

function fCustoVenda(const Configuracao: TConfiguracaoReforma; const PrecoCusto, OutrosValores,
  PrecoVenda, IcmsSaida, ImpostoFederal, DespesaOperacional, Comissao: Double): Double;

implementation

function fCustoVenda(const Configuracao: TConfiguracaoReforma; const PrecoCusto, OutrosValores,
  PrecoVenda, IcmsSaida, ImpostoFederal, DespesaOperacional, Comissao: Double): Double;
var
  ImpostoAplicado: Double;
  ComissaoAplicada: Double;
begin
  if PrecoVenda <= 0 then
  begin
    Result := 0;
    Exit;
  end;

  ImpostoAplicado := ImpostoFederal;
  if Configuracao.ReduzImpostoFederal then
    ImpostoAplicado := ImpostoAplicado * (1 - IcmsSaida / 100);

  ComissaoAplicada := Comissao;
  if not Configuracao.ExibeComissao then
    ComissaoAplicada := 0;

  Result := (PrecoCusto + OutrosValores) +
    (PrecoVenda * (IcmsSaida + ImpostoAplicado + DespesaOperacional + ComissaoAplicada)) / 100;
end;

end.