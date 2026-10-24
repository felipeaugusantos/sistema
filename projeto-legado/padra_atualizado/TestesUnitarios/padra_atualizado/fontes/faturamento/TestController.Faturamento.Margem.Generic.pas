unit TestController.Faturamento.Margem.Generic;

interface

Uses
  TestFramework,
  System.Generics.Collections,
  System.SysUtils,
  untFuncoes,
  Shared.Functions.Core,
  Faturamento.Margem.Interfaces.MargemVenda,
  Faturamento.Margem.Interfaces.MargemBruta,
  Faturamento.Margem.Tipos.MargemBruta,
  Faturamento.Margem.Tipos.MargemVenda,
  Controller.Faturamento.Margem.Generic;


Type
  TTestControllerFatMargemGeneric = class(TTestCase)
  Public
    procedure SetUp; override;
    procedure TearDown; override;
  Private

  Published
    procedure TestMargemBruta;
    procedure TestMargemVenda;

end;

implementation


{ TTestControllerFatMargemGeneric }

procedure TTestControllerFatMargemGeneric.SetUp;
begin
  inherited;

end;

procedure TTestControllerFatMargemGeneric.TearDown;
begin
  inherited;

end;

procedure TTestControllerFatMargemGeneric.TestMargemBruta;
Var
  LParametros : IParametrosServicoMargemBruta;
  ReturnValue : Double;
begin
  LParametros :=
    TParametrosServicoMargemBruta.New
      .ConfiguracaoMargemMarkup('4')
      .PrecoDeCusto(40)
      .PrecoDeVenda(100)
      .ValorDaMargem(0)
      .IcmsDeSaida(5)
      .ImpostosFederais(2)
      .DespesasOperacionais(3)
      .PrecoDeCompra(30)
      .ValorIcmsSt(5.23)
      .CalcularST(true)
      .ValorDifal(2)
      .ValorFCP(2);

  ReturnValue :=
    TControllerFaturamentoMargemGeneric.New
      .MargemBruta
      .CalculaMargemBruta(LParametros);

  CheckTrue(CompararValores(ReturnValue, 39.42));
end;

procedure TTestControllerFatMargemGeneric.TestMargemVenda;
Var
  LParametros: TList<IParametrosServicoMargemVenda>;
  ReturnValue : TList<IResultadoCalculoMargemVenda>;
  LResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
begin
  LParametros := TList<IParametrosServicoMargemVenda>.Create;

  LParametros.Add(
    TParametrosServicoMargemVenda.New
      .ClassificacaoFiscal('6403')
      .CarregarPedidoOrcamentoEntradaFutura(False)
      .ImpostosFederais(1)
      .PrecoMedio(0)
      .CalcularST(False)
      .ValorUnitarioOriginal(692.908)
      .ValorUnitario(692.908)
      .ValorDoIcms(18)
      .ValorBaseDoIcms(18)
      .ValorDoDifal(0)
      .ValorDoFCP(0)
      .DespesasOperacionais(2)
      .DespesaOperacionalCliente(0)
      .ValorComissaoTabelaDeitens(0)
      .ValorDoCustoPraticado(375.218)
      .ValorCustoDoItem(375.218)
      .OutrosValores(1)
      .ValorUltimaCompraImpostos(0)
      .ValorDaSubstituicao(124.73)
      .ValorDoIcmsStParteDaVenda(0)
      .ValorCat17(0)
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(0)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargem(0)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida(0)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia(0)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos(0)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemItem(0)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro(0)
      .ValorUnitarioMargemMinima(40)
      .CalcularPrecoIdeal(True)
      .ValorPrecoIdeal(476.225)
      .AliquotaIcmsPrecoIdeal(18));

  ReturnValue :=
    TControllerFaturamentoMargemGeneric.New
      .MargemVenda
      .CalculaMargemVenda(LParametros);


  LResultadoCalculoMargemVenda := ReturnValue[0];

  CheckTrue(
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoIdeal, objCore.fStrToFloat('-0,00024999999999975')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPraticada, objCore.fStrToFloat('171,179')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaSemDespesasOperacionais, objCore.fStrToFloat('185,03')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoMedio, objCore.fStrToFloat('547,39')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoUltimaCompraComImpostos, objCore.fStrToFloat('546,39')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemProposta, objCore.fStrToFloat('171,17')) And

    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemMinima, 40) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioCustoRealComMargemZero, objCore.fStrToFloat('476,22')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoReal, objCore.fStrToFloat('24,7')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCustoReal, objCore.fStrToFloat('24,7')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCusto, objCore.fStrToFloat('45,85')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCusto, objCore.fStrToFloat('45,85')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio, 100) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio, objCore.fStrToFloat('78,86')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra, 100) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra, objCore.fStrToFloat('78,86')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos, 100) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos, objCore.fStrToFloat('78,86')) And

    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticado, objCore.fStrToFloat('476,22')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticadoSemDespesasOperacionais, objCore.fStrToFloat('464,46')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupProposto, objCore.fStrToFloat('476,22')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoMedio, objCore.fStrToFloat('0')) And

    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoUltimaCompraComImpostos, objCore.fStrToFloat('1,26')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoMedio, 79) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos, objCore.fStrToFloat('78,86')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioItemMargemProposta, objCore.fStrToFloat('24,7')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioItemMargemPraticadaLucro, objCore.fStrToFloat('24,7')) And

    CompararValores(LResultadoCalculoMargemVenda.ValorMargemCat17, 0)
  );

  LParametros.Free;
end;

Initialization
  RegisterTest(TTestControllerFatMargemGeneric.Suite);
end.
