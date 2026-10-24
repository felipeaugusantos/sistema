unit TestFaturamento.Margem.Servicos.Classe.MargemBruta;

interface

uses
  TestFramework, Shared.Functions.Types,
  Shared.Functions.Core,
  Shared.Functions.Configuracoes,
  Faturamento.Margem.Servicos.Classe.MargemBruta,
  Faturamento.Margem.Interfaces.Servicos.Classe.MargemBruta,
  Faturamento.Margem.Interfaces.MargemBruta,
  untTestConfiguracoes, untFuncoes,
  Faturamento.Margem.Tipos.MargemBruta,
  untTestMyCampoTabela;

type

  TestTServicosClasseMargemBruta = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalcularMargemBruta;
    procedure TestCalcularMargemToMarkup;

  end;

implementation


procedure TestTServicosClasseMargemBruta.SetUp;
begin

end;

procedure TestTServicosClasseMargemBruta.TearDown;
begin

end;



procedure TestTServicosClasseMargemBruta.TestCalcularMargemBruta;
Var
  ReturnValue : Double;
  LParametros : IParametrosServicoMargemBruta;
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
    TFaturamentoMargemServicosClasseMargemBruta.New
      .CalculaMargemBruta(LParametros)
        .ResultadoCalculoMargemBruta
          .ValorMargemBruta;

  CheckTrue(CompararValores(returnValue , 39.42));
end;

procedure TestTServicosClasseMargemBruta.TestCalcularMargemToMarkup;
Var
  ReturnValue : Double;
  LParametros : IParametrosServicoMargemParaMarkup;
begin
  LParametros :=
    TParametrosServicoMargemParaMarkup.New
      .ValorDaMargem(16);

  ReturnValue :=
    TFaturamentoMargemServicosClasseMargemBruta.New
      .CalculaMargemParaMarkup(LParametros)
        .ResultadoCalculoMargemParaMarkup
          .ValorMarkup;

  CheckTrue(CompararValores(returnValue , 19.0476));
end;

initialization
  RegisterTest(TestTServicosClasseMargemBruta.Suite);
end.

