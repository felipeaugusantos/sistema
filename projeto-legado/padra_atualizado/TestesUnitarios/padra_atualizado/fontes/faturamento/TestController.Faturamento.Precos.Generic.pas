unit TestController.Faturamento.Precos.Generic;

interface

Uses
  TestFramework,
  Shared.Functions.Core,
  Shared.Functions.Configuracoes,
  Controller.Faturamento.Precos.Generic,
  Controller.Faturamento.Interfaces.Precos.PrecoCusto,
  Faturamento.Precos.Interfaces.PrecoCusto,
  Faturamento.Precos.Tipos.PrecoCusto,
  Controller.Faturamento.Precos.PrecoCusto;

Type
  TTestControllerFatPrecosGeneric = class(TTestCase)
  Public
   procedure SetUp; override;
   procedure TearDown; override;

  Private

  Published
    procedure TestPrecoCusto;

  end;

implementation

{ TTestControllerFatPrecosGeneric }

procedure TTestControllerFatPrecosGeneric.SetUp;
begin
  inherited;

end;

procedure TTestControllerFatPrecosGeneric.TearDown;
begin
  inherited;

end;

procedure TTestControllerFatPrecosGeneric.TestPrecoCusto;

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
    TControllerFaturamentoPrecosGeneric.New.PrecoCusto.CalculaPrecoCusto(LParametros);

  CheckTrue(ReturnValue = objCore.fFormataFloat(37.1475, 4));

end;

Initialization
  RegisterTest(TTEstControllerFatPrecosGeneric.Suite);
end.
