unit TestController.Faturamento.Precos.PrecoCusto;

interface

Uses
  TestFramework,
  Shared.Functions.Types,
  Shared.Functions.Configuracoes,
  Controller.Faturamento.Precos.PrecoCusto,
  Shared.Functions.Core,
  Controller.Faturamento.Interfaces.Precos.PrecoCusto,
  Faturamento.Precos.Interfaces.PrecoCusto,
  Faturamento.Precos.Tipos.PrecoCusto,
  untFatCalcularPrecosService;

Type
 TTestControllerFatPrecosCusto = class(TTestCase)
 Published
    Procedure TestCalculaPrecoCusto;
    Procedure TestCalculaPrecoCustoConversorMoeda;
    Procedure TestCalculaPrecoCustoMkp;
    Procedure TestCalculaPrecoCustoRealVenda;
    Procedure TestCalculaCustoReal;

 Public
   procedure SetUp; override;
   procedure TearDown; override;
 Private


 end;

implementation

{ TTestControllerFatPrecosCusto }

procedure TTestControllerFatPrecosCusto.SetUp;
begin
 // inherited;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_QUANTIDADE_CASAS_DECIMAIS_VALOR_UNITARIO, '3');
end;

procedure TTestControllerFatPrecosCusto.TearDown;
begin
  inherited;

end;

procedure TTestControllerFatPrecosCusto.TestCalculaCustoReal;
Var
 ReturnValue : Double;
 LParametros: IParametrosCalculoCustoReal;
begin
  LParametros :=
    TParametrosCalculoCustoReal.New
      .PrecoDeCusto(49.46)
      .IcmsDeSaida(5.0)
      .ImpostosFederais(2.0)
      .DespesasOperacionais(1.5)
      .OutrosValores(7.35);

  ReturnValue :=
    TControllerFaturamentoPrecoCusto.New
      .CalculaCustoReal(LParametros);

  CheckTrue(objCore.fFormataFloat(ReturnValue,4)  = objCore.fStrToFloat('62,0874'));
end;

procedure TTestControllerFatPrecosCusto.TestCalculaPrecoCusto;
Var
  LParametros: IParametrosServicoPrecoCusto;
  ReturnValue: Double;
begin
  LParametros:=
    TParametrosServicoPrecoCusto.New
      .PrecoDeCompra(50)
      .Desconto01(0.5)
      .Desconto02(1)
      .Desconto03(1.5)
      .Desconto04(2)
      .Desconto05(2.5)
      .Desconto06(3)
      .Desconto07(0)
      .IcmsDeEntrada(7)
      .ImpostoFederal(1)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(4)
      .AcrescimoFinal(1)
      .SubstituicaoTributaria(2)
      .DescontosAdicionais(3)
      .TipoMoeda(moeDolar);

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_QUANTIDADE_CASAS_DECIMAIS_VALOR_UNITARIO, '3');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_FORMULA_PARA_CALCULO_PRECO_CUSTO, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_OPERACAO_COMPOSICAO_PRECO_PRODUTO, '+');

  ReturnValue :=
    TControllerFaturamentoPrecoCusto.New
      .CalculaPrecoCusto(LParametros);

  CheckTrue( objCore.fFormataFloat(ReturnValue,3) = objCore.fStrToFloat('50,377'));
end;

procedure TTestControllerFatPrecosCusto.TestCalculaPrecoCustoConversorMoeda;
Var
  LParametros : IParametrosServicoPrecoCusto;
  ReturnValue : Double;
begin
  LParametros :=
    TParametrosServicoPrecoCusto.New
      .PrecoDeCompra(50)
      .Desconto01(0.5)
      .Desconto02(1)
      .Desconto03(1.5)
      .Desconto04(2)
      .Desconto05(2.5)
      .Desconto06(3)
      .Desconto07(0)
      .IcmsDeEntrada(7)
      .ImpostoFederal(1)
      .IpiDeEntrada(2)
      .PercentualFreteDeEntrada(3)
      .ValorDoFrete(4)
      .AcrescimoFinal(1)
      .SubstituicaoTributaria(2)
      .DescontosAdicionais(3)
      .TipoMoeda(moeDolar)
      .Predol(True);

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_FORMULA_PARA_CALCULO_PRECO_CUSTO, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_OPERACAO_COMPOSICAO_PRECO_PRODUTO, '+');

  ReturnValue :=
    TControllerFaturamentoPrecoCusto.New
      .CalculaPrecoCustoConversorMoeda(LParametros);

  CheckTrue( objCore.fFormataFloat(ReturnValue,3) = objCore.fStrToFloat('55,002'));
end;

procedure TTestControllerFatPrecosCusto.TestCalculaPrecoCustoMkp;
Var
  LParametros: IParametrosServicoPrecoCustoMargemMarkup;
  ReturnValue: Double;
begin
  LParametros :=
    TParametrosServicoPrecoCustoMargemMarkup.New
      .PrecoDeVenda(49.53)
      .Margem(25)
      .DecUni(4);

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, '1');

  ReturnValue :=
    TControllerFaturamentoPrecoCusto.New
      .CalculaPrecoCusto(LParametros);

  CheckTrue(ReturnValue = objCore.fFormataFloat(37.1475, 4));
end;

procedure TTestControllerFatPrecosCusto.TestCalculaPrecoCustoRealVenda;
Var
  ReturnValue : Double;
  LParametros : IParametrosCalculoPrecoCustoRealVenda;
begin
  LParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New
      .PrecoDeVenda(54.37)
      .PrecoDeCusto(49.46)
      .OutrosValores(0)
      .IcmsDeSaida(5.0)
      .ImpostosFederais(2.0)
      .DespesasOperacionais(1.5)
      .AliquotaDoDifal(3.45)
      .AliquotaDoFcp(1.75)
      .TaxaDeJuros(10);

  ReturnValue :=
    TControllerFaturamentoPrecoCusto.New
      .CalculaPrecoCustoRealVenda(LParametros);

  CheckTrue(objCore.fFormataFloat(ReturnValue,2) = objCore.fStrToFloat('61,85'));

end;

Initialization
  RegisterTest(TTestControllerFatPrecosCusto.Suite);
end.
