unit TestController.Faturamento.Margem.MargemBruta;

interface

Uses
  TestFramework,
  untFuncoes,
  Controller.Faturamento.Margem.MargemBruta,
  Faturamento.Margem.Interfaces.MargemBruta,
  Faturamento.Margem.Tipos.MargemBruta;

Type
  TControllerFatMargemBruta = class(TTestCase)
   private

   published
    procedure TestCalculaMargemBruta;
    procedure TestCalculaMargemParaMarkup;
  public
    procedure SetUp; override;
    procedure TearDown; override;

  end;

implementation


{ TControllerFatMargemBruta }

procedure TControllerFatMargemBruta.SetUp;
begin
  inherited;

end;

procedure TControllerFatMargemBruta.TearDown;
begin
  inherited;

end;

procedure TControllerFatMargemBruta.TestCalculaMargemBruta;
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
    TControllerFaturamentoMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue(CompararValores(ReturnValue, 39.42));
end;

procedure TControllerFatMargemBruta.TestCalculaMargemParaMarkup;
Var
  LParametros : IParametrosServicoMargemParaMarkup;
  returnValue : Double;
begin
  LParametros:=
    TParametrosServicoMargemParaMarkup.New
      .ValorDaMargem(16);


  returnValue :=
    TControllerFaturamentoMargemBruta.New
      .CalculaMargemParaMarkup(LParametros);

  CheckTrue(CompararValores(returnValue, 19.0476));
end;

initialization
  RegisterTest(TControllerFatMargemBruta.Suite);
end.
