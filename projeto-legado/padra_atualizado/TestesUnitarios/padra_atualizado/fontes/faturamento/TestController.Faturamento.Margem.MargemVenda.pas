unit TestController.Faturamento.Margem.MargemVenda;

interface

uses
  TestFramework,
  untFuncoes,
  Shared.Functions.Core,
  Controller.Faturamento.Interfaces.Margem.MargemVenda,
  Controller.Faturamento.Margem.MargemVenda,
  Faturamento.Margem.Interfaces.MargemVenda,
  Faturamento.Margem.Tipos.MargemVenda,
  System.Generics.Collections, System.SysUtils;

type
  TestTControllerFatMargemVenda = class(TTestCase)
  public
   procedure SetUp; override;
   procedure TearDown; override;
  private

  published
    procedure TestCalculaMargemVenda;
  end;

implementation

procedure TestTControllerFatMargemVenda.SetUp;
begin
  inherited;

end;

procedure TestTControllerFatMargemVenda.TearDown;
begin
  inherited;

end;

procedure TestTControllerFatMargemVenda.TestCalculaMargemVenda;
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

  ReturnValue := TControllerFaturamentoMargemVenda.New.CalculaMargemVenda(LParametros);


  LResultadoCalculoMargemVenda := ReturnValue[0];

  CheckTrue(
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoIdeal, objCore.fStrToFloat('-0,00024999999999975')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPraticada, objCore.fStrToFloat('171,17932')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaSemDespesasOperacionais, objCore.fStrToFloat('185,03748')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoMedio, objCore.fStrToFloat('547,39732')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoUltimaCompraComImpostos, objCore.fStrToFloat('546,39732')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemProposta, objCore.fStrToFloat('171,17932')) And

    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemMinima, 40) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioCustoRealComMargemZero, objCore.fStrToFloat('476,225316455696')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoReal, objCore.fStrToFloat('45,5')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCustoReal, objCore.fStrToFloat('45,5')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCusto, objCore.fStrToFloat('84,67')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCusto, objCore.fStrToFloat('84,67')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio, 0) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio, objCore.fStrToFloat('54639,73')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra, 0) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra, objCore.fStrToFloat('54639,73')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos, 0) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos, objCore.fStrToFloat('54639,73')) And

    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticado, objCore.fStrToFloat('547,39732')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticadoSemDespesasOperacionais, objCore.fStrToFloat('561,25548')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupProposto, objCore.fStrToFloat('547,39732')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoMedio, objCore.fStrToFloat('547,39732')) And

    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoUltimaCompraComImpostos, objCore.fStrToFloat('1,26582278481013')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoMedio, 0) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos, objCore.fStrToFloat('54639,73')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioItemMargemProposta, objCore.fStrToFloat('45,5')) And
    CompararValores(LResultadoCalculoMargemVenda.ValorUnitarioItemMargemPraticadaLucro, objCore.fStrToFloat('45,5')) And

    CompararValores(LResultadoCalculoMargemVenda.ValorMargemCat17, 0)
  );

  LParametros.Free;

end;

initialization
  RegisterTest(TestTControllerFatMargemVenda.Suite);
end.
