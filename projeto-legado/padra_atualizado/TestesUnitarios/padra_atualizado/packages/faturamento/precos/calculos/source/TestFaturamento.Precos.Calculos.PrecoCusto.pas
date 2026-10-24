unit TestFaturamento.Precos.Calculos.PrecoCusto;

interface

uses
  TestFramework, Shared.Functions.Types,
  Shared.Functions.Core,
  Shared.Functions.Configuracoes,
  Faturamento.Precos.Servicos.Classe.PrecoCusto,
  Faturamento.Precos.Calculos.PrecoCusto,
  Faturamento.Precos.Interfaces.PrecoCusto,
  untTestConfiguracoes,
  Faturamento.Precos.Tipos.PrecoCusto,
  untTestMyCampoTabela;

type

  TestTClassePrecoCusto = class(TTestCase)
  strict private
    FOperadorSomaAdicionais : Boolean;
    FFormulaParaCalculo     : String;

    Function ParametrosPrecoCusto(const ACalculandoTintaMaquina: boolean = false): IParametrosCalculoPrecoCusto;
    Function ParametrosPrecoCustoMarkup(Const AMarkup : String) : IParametrosCalculoPrecoCustoMargemMarkup;

    function ParametrosCalculoPrecoCustoRealVenda : IParametrosCalculoPrecoCustoRealVenda;
    function ParametrosCalculoCustoReal           : IParametrosCalculoCustoReal;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalculaPrecoCusto_01_DescontosAdicionais;
    procedure TestCalculaPrecoCusto_02_DescontosAdicionais;
    procedure TestCalculaPrecoCusto_03_DescontosAdicionais;
    procedure TestCalculaPrecoCusto_04_DescontosAdicionais;

    procedure TestCalculaPrecoCusto_01_AcrescimosAdicionais;
    procedure TestCalculaPrecoCusto_02_AcrescimosAdicionais;
    procedure TestCalculaPrecoCusto_03_AcrescimosAdicionais;

    procedure TestCalculaPrecoCusto_04_TintaDeMaquina;

    procedure TestCalculaPrecoCustoMarkup_1;
    procedure TestCalculaPrecoCustoMarkup_5;
    procedure TestCalculaPrecoCustoMarkup_3;

    procedure TestCalculoPrecoCustoRealVenda;

    procedure TestCalculaCustoReal;

  end;

implementation

function TestTClassePrecoCusto.ParametrosCalculoCustoReal: IParametrosCalculoCustoReal;
begin
  Result :=
    TParametrosCalculoCustoReal.New
      .PrecoDeCusto(49.46)
      .IcmsDeSaida(5.0)
      .ImpostosFederais(2.0)
      .DespesasOperacionais(1.5)
      .OutrosValores(7.35);
end;

function TestTClassePrecoCusto.ParametrosCalculoPrecoCustoRealVenda: IParametrosCalculoPrecoCustoRealVenda;
begin
  Result :=
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
end;

function TestTClassePrecoCusto.ParametrosPrecoCusto(const ACalculandoTintaMaquina: boolean = false): IParametrosCalculoPrecoCusto;
begin
  Result :=
    TParametrosCalculoPrecoCusto.New
      .OperadorAdicaoDescontosAdicionais(FOperadorSomaAdicionais)
      .FormulaParaCalculo(FFormulaParaCalculo)
      .QuantidadeCasasDecimais(3)
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
      .CalculandoTintaDeMaquina(ACalculandoTintaMaquina);
end;

function TestTClassePrecoCusto.ParametrosPrecoCustoMarkup(Const AMarkup : String): IParametrosCalculoPrecoCustoMargemMarkup;
begin
  Result :=
    TParametrosCalculoPrecoCustoMargemMarkup.New
      .MargemMarkup(AMarkup)
      .PrecoDeVenda(49.53)
      .Margem(25)
      .DecUni(4);
end;

procedure TestTClassePrecoCusto.SetUp;
begin
  TMyCampoTabelaDefault.IniciarCamposDefault;

end;

procedure TestTClassePrecoCusto.TearDown;
begin
end;


procedure TestTClassePrecoCusto.TestCalculaCustoReal;
Var
  ReturnValue : Double;
begin
  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaCustoReal(ParametrosCalculoCustoReal)
        .ValorCalculadoPrecoCusto;

  CheckTrue(objCore.fFormataFloat(ReturnValue,4)  = objCore.fStrToFloat('62,0874'));
end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCusto_01_AcrescimosAdicionais;
Var
  ReturnValue : Double;
begin
  FFormulaParaCalculo     := '1';
  FOperadorSomaAdicionais := true;

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCusto)
        .ValorCalculadoPrecoCusto;


  CheckTrue(ReturnValue = objCore.fStrToFloat('50,377'));

end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCusto_01_DescontosAdicionais;
Var
  ReturnValue : Double;
begin

  FFormulaParaCalculo     := '1';
  FOperadorSomaAdicionais := false;

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCusto)
          .ValorCalculadoPrecoCusto;

  CheckTrue(ReturnValue = objCore.fStrToFloat('47,442'));
end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCusto_02_AcrescimosAdicionais;
Var
  ReturnValue : Double;
begin
  FFormulaParaCalculo     := '2';
  FOperadorSomaAdicionais := true;

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCusto)
          .ValorCalculadoPrecoCusto;


  CheckTrue(ReturnValue = objCore.fStrToFloat('50,507'));
end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCusto_02_DescontosAdicionais;
Var
  ReturnValue : Double;
begin
  FFormulaParaCalculo     := '2';
  FOperadorSomaAdicionais := false;

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCusto)
          .ValorCalculadoPrecoCusto;


  CheckTrue(ReturnValue = objCore.fStrToFloat('47,565'));


end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCusto_03_AcrescimosAdicionais;
Var
  ReturnValue : Double;
begin
  FFormulaParaCalculo     := '3';
  FOperadorSomaAdicionais := true;

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCusto)
          .ValorCalculadoPrecoCusto;


  CheckTrue(ReturnValue = objCore.fStrToFloat('50,479'));
end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCusto_03_DescontosAdicionais;
Var
  ReturnValue : Double;
begin
  FFormulaParaCalculo     := '3';
  FOperadorSomaAdicionais := false;

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCusto)
          .ValorCalculadoPrecoCusto;


  CheckTrue(ReturnValue = objCore.fStrToFloat('47,539'));
end;



procedure TestTClassePrecoCusto.TestCalculaPrecoCusto_04_DescontosAdicionais;
Var
  ReturnValue : Double;
begin
  FFormulaParaCalculo     := '4';
  FOperadorSomaAdicionais := false;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DESCONTOS_ADICIONAIS_DESCRICAO_COMPOSICAO_PRECO_DO_PRODUTO, '-');

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCusto)
          .ValorCalculadoPrecoCusto;


  CheckTrue(objCore.fFormataFloat(ReturnValue,3) = objCore.fFormataFloat(48.964,3));
end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCusto_04_TintaDeMaquina;
Var
  ReturnValue : Double;
begin
  FFormulaParaCalculo     := '4';
  FOperadorSomaAdicionais := false;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DESCONTOS_ADICIONAIS_DESCRICAO_COMPOSICAO_PRECO_DO_PRODUTO, '-');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VALOR_FRETE_DESCRICAO_COMPOSICAO_PRECO_DO_PRODUTO, '-');

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCusto(True))
          .ValorCalculadoPrecoCusto;


  CheckTrue(objCore.fFormataFloat(ReturnValue,3) = objCore.fFormataFloat(44.964,3));
end;

procedure TestTClassePrecoCusto.TestCalculoPrecoCustoRealVenda;
Var
  ReturnValue : Double;
begin
  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCustoRealVenda(ParametrosCalculoPrecoCustoRealVenda)
        .ValorCalculadoPrecoCusto;

  CheckTrue(objCore.fFormataFloat(ReturnValue,2) = objCore.fStrToFloat('61,85'));
end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCustoMarkup_1;
Var
  ReturnValue : Double;
begin

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCustoMarkup('1')).ValorCalculadoPrecoCusto;

  CheckTrue(ReturnValue = objCore.fFormataFloat(37.1475, 4));
end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCustoMarkup_3;
Var
  ReturnValue : Double;
begin

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCustoMarkup('3')).ValorCalculadoPrecoCusto;

  CheckTrue(ReturnValue = objCore.fFormataFloat(39.6240, 4));

end;

procedure TestTClassePrecoCusto.TestCalculaPrecoCustoMarkup_5;
Var
  ReturnValue : Double;
begin

  ReturnValue :=
    TCalculoPrecosPrecoCusto.New
      .CalculaPrecoCusto(ParametrosPrecoCustoMarkup('5')).ValorCalculadoPrecoCusto;

  CheckTrue(ReturnValue = objCore.fFormataFloat(37.1475, 4));

end;

initialization
  RegisterTest(TestTClassePrecoCusto.Suite);
end.

