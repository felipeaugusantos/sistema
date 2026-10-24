unit TestFaturamento.Margem.Calculos.MargemVenda;

interface

uses
  TestFramework, Shared.Functions.Types,
  Shared.Functions.Core,
  Shared.Functions.Configuracoes,
  Faturamento.Margem.Calculos.MargemVenda,
  Faturamento.Margem.Interfaces.MargemVenda,
  untFuncoes,
//  untTestConfiguracoes,
  Faturamento.Margem.Tipos.MargemVenda;
//  untTestMyCampoTabela,
//  untFuncoes;
type

  TestTClasseMargemVenda = class(TTestCase)
  strict private

  public
    procedure SetUp; override;

	procedure TearDown; override;
  published

    procedure CalcularValorMargemVendaLiquida;
    procedure CalcularValorMargemVenda;
    procedure CalcularValorMargemVendaCfgPrecoDaUltimaCompraMaisImpostos;
    procedure CalcularValorMargemVendaCalcularST_True;

  end;

implementation


procedure TestTClasseMargemVenda.CalcularValorMargemVenda;
Var
  LParametros : IParametrosCalculoMargemVenda;
  ReturnValue : IResultadoCalculoMargemVenda;

begin      // ITEM 40304

  objConfiguracoes.
      fAtualizaValorConfiguracao(
        CFG_CALCULO_MARGEM_PRECO_ULTIMA_COMPRA_MAIS_IMPOSTOS_CONSIDERAR, '1');

  LParametros :=
    TParametrosCalculoMargemVenda.New
      .PrecoMedio(84.3472)
      .ValorCalculoImpostosAliquota(0.95)
      .CalcularST(false)
      .ValorUnitarioOriginal(110)
      .ValorUnitario(110)
      .ImpostosFederais(2)
      .ValorDoIcms(0)
      .ValorDoDifal(0)
      .ValorDoFCP(0)
      .DespesasOperacionais(3)
      .DespesaOperacionalCliente(0)
      .ValorComissaoTabelaDeitens(0)
      .ValorDoCustoPraticado(54.898)
      .ValorCustoDoItem(54.898)
      .OutrosValores(1)
      .ValorUltimaCompraImpostos(80.78)
      .ConsiderarMargemDePrecoUltimaCompraNoCalculo(true)
      .ValorDoIcmsStParteDaVenda(0)
      .ConfiguracaoMargemMarkup('1')
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(0)
      .ValorUnitarioMargemMinima(0)
      .ValorUnitarioCustoRealComMargemZero(58.84)
      .ValorUnitarioMargemPraticadaCustoReal(44.18)
      .ValorUnitarioMargemPropostaCustoReal(44.18)
      .ValorUnitarioMargemPropostaCusto(50.09)
      .ValorUnitarioMargemPraticadaCusto(50.09)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(23.32)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(17.41)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(46)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(40.09)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(26.56)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(20.65)
      .ValorUnitarioItemMargemPrecoMedio(18.32)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(20.65)
      .ValorUnitarioItemMargemProposta(44.18)
      .ValorUnitarioItemMargemPraticadaLucro(44.18)
      .ValorMargemIdeal(0)
      .CalcularPrecoIdeal(true)
      .ValorPrecoIdeal(58.84)
      .AliquotaIcmsPrecoIdeal(0)
      .ValorMargemCat17(44.18);

  ReturnValue := TCalculoMargemMargemVenda.New.CalculaMargemVenda(LParametros);


  CheckTrue(
    (returnValue.ValorUnitarioMargemMinima = 0) And
    (CompararValores(returnValue.ValorUnitarioCustoRealComMargemZero, 58.84)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticadaCustoReal,44.18)) And
    (CompararValores(returnValue.ValorUnitarioMargemPropostaCustoReal,44.18)) And
    (CompararValores(returnValue.ValorUnitarioMargemPropostaCusto, 50.09)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticadaCusto,50.09)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoMedio,23.32)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoMedio, 17.41)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra, 46)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra,40.09)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos,26.56)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos,20.65)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticada, 48.60)) And
    (CompararValores(objCore.fFormataFloat(returnValue.ValorUnitarioMargemPraticadaSemDespesasOperacionais,2),51.90)) And
    (CompararValores(returnValue.ValorUnitarioMargemPrecoMedio,20.15)) And // ?
    (CompararValores(returnValue.ValorUnitarioMargemPrecoUltimaCompraComImpostos,22.72)) And
    (CompararValores(returnValue.ValorUnitarioMargemProposta, 48.60)) And
    (CompararValores(returnValue.ValorUnitarioMarkupProposto, 58.84)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPraticado, 58.84)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPraticadoSemDespesasOperacionais, 57.03)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPrecoMedio, 88.78)) And // ?
    (CompararValores(returnValue.ValorUnitarioItemMargemPrecoMedio, 18.32)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos, 20.65)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemProposta, 44.18)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemPraticadaLucro, 44.18)) And
    (returnValue.ValorMargemIdeal = 0) And
    (CompararValores(returnValue.ValorUnitarioMargemPrecoIdeal, 0)) And
    (CompararValores(returnValue.ValorMargemCat17, 44.18)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPrecoUltimaCompraComImpostos, 86.08))); // ?

end;

procedure TestTClasseMargemVenda.CalcularValorMargemVendaCalcularST_True;
Var
  LParametros : IParametrosCalculoMargemVenda;
  ReturnValue : IResultadoCalculoMargemVenda;
begin      // ITEM 40304
  objConfiguracoes.
      fAtualizaValorConfiguracao(
        CFG_CALCULO_MARGEM_PRECO_ULTIMA_COMPRA_MAIS_IMPOSTOS_CONSIDERAR, '2');

  LParametros :=
    TParametrosCalculoMargemVenda.New
      .PrecoMedio(84.3472)
      .ValorCalculoImpostosAliquota(0.95)
      .CalcularST(true)
      .ValorUnitarioOriginal(110)
      .ValorUnitario(110)
      .ImpostosFederais(2)
      .ValorDoIcms(0)
      .ValorDoDifal(0)
      .ValorDoFCP(0)
      .DespesasOperacionais(3)
      .DespesaOperacionalCliente(0)
      .ValorComissaoTabelaDeitens(0)
      .ValorDoCustoPraticado(54.898)
      .ValorCustoDoItem(54.898)
      .OutrosValores(1)
      .ValorUltimaCompraImpostos(80.78)
      .ConsiderarMargemDePrecoUltimaCompraNoCalculo(false)
      .ValorDoIcmsStParteDaVenda(0)
      .ConfiguracaoMargemMarkup('4')
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(0)
      .ValorUnitarioMargemMinima(0)
      .ValorUnitarioCustoRealComMargemZero(58.84)
      .ValorUnitarioMargemPraticadaCustoReal(44.18)
      .ValorUnitarioMargemPropostaCustoReal(44.18)
      .ValorUnitarioMargemPropostaCusto(50.09)
      .ValorUnitarioMargemPraticadaCusto(50.09)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(23.32)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(17.41)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(46)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(40.09)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(26.56)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(20.65)
      .ValorUnitarioItemMargemPrecoMedio(18.32)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(20.65)
      .ValorUnitarioItemMargemProposta(44.18)
      .ValorUnitarioItemMargemPraticadaLucro(44.18)
      .ValorMargemIdeal(0)
      .CalcularPrecoIdeal(true)
      .ValorPrecoIdeal(58.84)
      .AliquotaIcmsPrecoIdeal(0)
      .ValorMargemCat17(44.18);

  ReturnValue := TCalculoMargemMargemVenda.New.CalculaMargemVenda(LParametros);


  CheckTrue(
    (returnValue.ValorUnitarioMargemMinima = 0) And
    (CompararValores(returnValue.ValorUnitarioCustoRealComMargemZero, 58.84)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticadaCustoReal,44.18)) And
    (CompararValores(returnValue.ValorUnitarioMargemPropostaCustoReal,44.18)) And
    (CompararValores(returnValue.ValorUnitarioMargemPropostaCusto, 50.09)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticadaCusto,50.09)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoMedio,23.32)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoMedio, 17.41)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra, 46)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra,40.09)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos,26.56)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos,20.65)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticada, 48.60)) And
    (CompararValores(objCore.fFormataFloat(returnValue.ValorUnitarioMargemPraticadaSemDespesasOperacionais,2),51.90)) And
    (CompararValores(returnValue.ValorUnitarioMargemPrecoMedio,20.15)) And // ?
    (CompararValores(returnValue.ValorUnitarioMargemPrecoUltimaCompraComImpostos,29.22)) And
    (CompararValores(returnValue.ValorUnitarioMargemProposta, 48.60)) And
    (CompararValores(returnValue.ValorUnitarioMarkupProposto, 104.5)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPraticado, 104.5)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPraticadoSemDespesasOperacionais, 107.8)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPrecoMedio, 104.5)) And // ?
    (CompararValores(returnValue.ValorUnitarioItemMargemPrecoMedio, 18.32)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos, 20.65)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemProposta, 44.18)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemPraticadaLucro, 44.18)) And
    (returnValue.ValorMargemIdeal = 0) And
    (CompararValores(returnValue.ValorUnitarioMargemPrecoIdeal, 0)) And
    (CompararValores(returnValue.ValorMargemCat17, 44.18)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPrecoUltimaCompraComImpostos, 80.78))); // ?


end;

procedure TestTClasseMargemVenda.CalcularValorMargemVendaCfgPrecoDaUltimaCompraMaisImpostos;
Var
  LParametros : IParametrosCalculoMargemVenda;
  ReturnValue : IResultadoCalculoMargemVenda;

begin      // ITEM 40304
  objConfiguracoes.
      fAtualizaValorConfiguracao(
        CFG_CALCULO_MARGEM_PRECO_ULTIMA_COMPRA_MAIS_IMPOSTOS_CONSIDERAR, '2');

  LParametros :=
    TParametrosCalculoMargemVenda.New
      .PrecoMedio(84.3472)
      .ValorCalculoImpostosAliquota(0.95)
      .CalcularST(false)
      .ValorUnitarioOriginal(110)
      .ValorUnitario(110)
      .ImpostosFederais(2)
      .ValorDoIcms(0)
      .ValorDoDifal(0)
      .ValorDoFCP(0)
      .DespesasOperacionais(3)
      .DespesaOperacionalCliente(0)
      .ValorComissaoTabelaDeitens(0)
      .ValorDoCustoPraticado(54.898)
      .ValorCustoDoItem(54.898)
      .OutrosValores(1)
      .ValorUltimaCompraImpostos(80.78)
      .ConsiderarMargemDePrecoUltimaCompraNoCalculo(false)
      .ValorDoIcmsStParteDaVenda(0)
      .ConfiguracaoMargemMarkup('1')
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(0)
      .ValorUnitarioMargemMinima(0)
      .ValorUnitarioCustoRealComMargemZero(58.84)
      .ValorUnitarioMargemPraticadaCustoReal(44.18)
      .ValorUnitarioMargemPropostaCustoReal(44.18)
      .ValorUnitarioMargemPropostaCusto(50.09)
      .ValorUnitarioMargemPraticadaCusto(50.09)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(23.32)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(17.41)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(46)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(40.09)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(26.56)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(20.65)
      .ValorUnitarioItemMargemPrecoMedio(18.32)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(20.65)
      .ValorUnitarioItemMargemProposta(44.18)
      .ValorUnitarioItemMargemPraticadaLucro(44.18)
      .ValorMargemIdeal(0)
      .CalcularPrecoIdeal(true)
      .ValorPrecoIdeal(58.84)
      .AliquotaIcmsPrecoIdeal(0)
      .ValorMargemCat17(44.18);

  ReturnValue := TCalculoMargemMargemVenda.New.CalculaMargemVenda(LParametros);


  CheckTrue(
    (returnValue.ValorUnitarioMargemMinima = 0) And
    (CompararValores(returnValue.ValorUnitarioCustoRealComMargemZero, 58.84)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticadaCustoReal,44.18)) And
    (CompararValores(returnValue.ValorUnitarioMargemPropostaCustoReal,44.18)) And
    (CompararValores(returnValue.ValorUnitarioMargemPropostaCusto, 50.09)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticadaCusto,50.09)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoMedio,23.32)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoMedio, 17.41)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra, 46)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra,40.09)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos,26.56)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos,20.65)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticada, 48.60)) And
    (CompararValores(objCore.fFormataFloat(returnValue.ValorUnitarioMargemPraticadaSemDespesasOperacionais,2),51.90)) And
    (CompararValores(returnValue.ValorUnitarioMargemPrecoMedio,20.15)) And // ?
    (CompararValores(returnValue.ValorUnitarioMargemPrecoUltimaCompraComImpostos,29.22)) And
    (CompararValores(returnValue.ValorUnitarioMargemProposta, 48.60)) And
    (CompararValores(returnValue.ValorUnitarioMarkupProposto, 58.84)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPraticado, 58.84)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPraticadoSemDespesasOperacionais, 57.03)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPrecoMedio, 88.78)) And // ?
    (CompararValores(returnValue.ValorUnitarioItemMargemPrecoMedio, 18.32)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos, 20.65)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemProposta, 44.18)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemPraticadaLucro, 44.18)) And
    (returnValue.ValorMargemIdeal = 0) And
    (CompararValores(returnValue.ValorUnitarioMargemPrecoIdeal, 0)) And
    (CompararValores(returnValue.ValorMargemCat17, 44.18)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPrecoUltimaCompraComImpostos, 80.78))); // ?

end;

procedure TestTClasseMargemVenda.CalcularValorMargemVendaLiquida;
Var
  LParametros : IParametrosCalculoMargemVenda;
  ReturnValue : IResultadoCalculoMargemVenda;

begin

  objConfiguracoes.
      fAtualizaValorConfiguracao(
        CFG_CALCULO_MARGEM_PRECO_ULTIMA_COMPRA_MAIS_IMPOSTOS_CONSIDERAR, '1');

  LParametros :=
    TParametrosCalculoMargemVenda.New
      .PrecoMedio(41)
      .ValorCalculoImpostosAliquota(0.86)
      .CalcularST(false)
      .ValorUnitarioOriginal(83.648)
      .ValorUnitario(83.648)
      .ImpostosFederais(2)
      .ValorDoIcms(7)
      .ValorDoDifal(0)
      .ValorDoFCP(2)
      .DespesasOperacionais(3)
      .DespesaOperacionalCliente(0)
      .ValorComissaoTabelaDeitens(0)
      .ValorDoCustoPraticado(54.597)
      .ValorCustoDoItem(54.597)
      .OutrosValores(1)
      .ValorUltimaCompraImpostos(41)
      .ConsiderarMargemDePrecoUltimaCompraNoCalculo(true)
      .ValorDoIcmsStParteDaVenda(0)
      .ConfiguracaoMargemMarkup('4')
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(0)
      .ValorUnitarioMargemMinima(0)
      .ValorUnitarioCustoRealComMargemZero(64.64)
      .ValorUnitarioMargemPraticadaCustoReal(32.4)
      .ValorUnitarioMargemPropostaCustoReal(32.4)
      .ValorUnitarioMargemPropostaCusto(53.21)
      .ValorUnitarioMargemPraticadaCusto(53.21)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(104.02)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(75.26)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(67.3)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(44.33)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(104.02)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(75.26)
      .ValorUnitarioItemMargemPrecoMedio(79.54)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(75.26)
      .ValorUnitarioItemMargemProposta(32.4)
      .ValorUnitarioItemMargemPraticadaLucro(32.4)
      .ValorMargemIdeal(0)
      .CalcularPrecoIdeal(true)
      .ValorPrecoIdeal(63.178)
      .AliquotaIcmsPrecoIdeal(7)
      .ValorMargemCat17(0);

  ReturnValue := TCalculoMargemMargemVenda.New.CalculaMargemVenda(LParametros);


  CheckTrue(
    (returnValue.ValorUnitarioMargemMinima = 0) And
    (CompararValores(returnValue.ValorUnitarioCustoRealComMargemZero, 64.64)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticadaCustoReal,32.4)) And
    (CompararValores(returnValue.ValorUnitarioMargemPropostaCustoReal,32.4)) And
    (CompararValores(returnValue.ValorUnitarioMargemPropostaCusto, 53.21)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticadaCusto,53.21)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoMedio,104.02)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoMedio, 75.26)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra, 67.3)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra,44.33)) And
    (CompararValores(returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos,104.02)) And
    (CompararValores(returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos,75.26)) And
    (CompararValores(returnValue.ValorUnitarioMargemPraticada, 16.34)) And
    (CompararValores(objCore.fFormataFloat(returnValue.ValorUnitarioMargemPraticadaSemDespesasOperacionais,2),18.84)) And
    (CompararValores(returnValue.ValorUnitarioMargemPrecoMedio,30.93)) And
    (CompararValores(returnValue.ValorUnitarioMargemPrecoUltimaCompraComImpostos,29.93)) And
    (CompararValores(returnValue.ValorUnitarioMargemProposta, 16.34)) And
    (CompararValores(returnValue.ValorUnitarioMarkupProposto, 73.61)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPraticado, 73.61)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPraticadoSemDespesasOperacionais, 76.11)) And
    (CompararValores(returnValue.ValorUnitarioMarkupPrecoMedio, 73.61)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemPrecoMedio, 79.54)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos, 75.26)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemProposta, 32.4)) And
    (CompararValores(returnValue.ValorUnitarioItemMargemPraticadaLucro, 32.4)) And
    (returnValue.ValorMargemIdeal = 0) And
    (CompararValores(returnValue.ValorUnitarioMargemPrecoIdeal, -0.00)) And
    (returnValue.ValorMargemCat17 = 0) And
    (CompararValores(returnValue.ValorUnitarioMarkupPrecoUltimaCompraComImpostos, 48.83))); // ?


end;

procedure TestTClasseMargemVenda.SetUp;
begin

end;

procedure TestTClasseMargemVenda.TearDown;
begin
end;



initialization
  RegisterTest(TestTClasseMargemVenda.Suite);
end.

