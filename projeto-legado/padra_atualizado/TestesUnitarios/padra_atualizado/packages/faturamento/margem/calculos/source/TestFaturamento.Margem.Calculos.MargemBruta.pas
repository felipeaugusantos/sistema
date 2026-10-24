unit TestFaturamento.Margem.Calculos.MargemBruta;

interface

uses
  TestFramework, Shared.Functions.Types,
  Shared.Functions.Core,
  Shared.Functions.Configuracoes,
  Faturamento.Margem.Servicos.Classe.MargemBruta,
  Faturamento.Margem.Calculos.MargemBruta,
  Faturamento.Margem.Interfaces.MargemBruta,
  untTestConfiguracoes,
  Faturamento.Margem.Tipos.MargemBruta,
  untTestMyCampoTabela,
  untFuncoes;
type

  TestTClasseMargemBruta = class(TTestCase)
  strict private

  public
    procedure SetUp; override;

	procedure TearDown; override;
  published
    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoPreVenZero_Opc1;
    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc1;
    procedure
    TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc2;
    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoMargemToMarkup_Opc2;

    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoPreVenZero_Opc3;
    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc3;

    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoPreVenZero_Opc4;
    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoST_Opc4;
    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc4;
    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoIcmsSt_Opc4;

    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoPreVenZero_Opc5;
    procedure TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc5;
  end;

implementation


procedure TestTClasseMargemBruta.SetUp;
begin

end;

procedure TestTClasseMargemBruta.TearDown;
begin
end;


procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoIcmsSt_Opc4;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
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


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue(CompararValores(returnValue.ValorMargemBruta, 39.42));
end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoMargemToMarkup_Opc2;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('2')
      .PrecoDeCusto(40)
      .PrecoDeVenda(100)
      .ValorDaMargem(0)
      .IcmsDeSaida(5)
      .ImpostosFederais(2)
      .DespesasOperacionais(3)
      .PrecoDeCompra(30)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(2)
      .ValorFCP(2);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue(ReturnValue.ValorMargemBruta = objCore.fStrToFloat('19,05'));
end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoPreVenZero_Opc1;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('1')
      .PrecoDeCusto(0)
      .PrecoDeVenda(0)
      .ValorDaMargem(0)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .PrecoDeCompra(0)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(0)
      .ValorFCP(0);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue( returnValue.ValorMargemBruta = 0 );
end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoPreVenZero_Opc3;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('3')
      .PrecoDeCusto(0)
      .PrecoDeVenda(0)
      .ValorDaMargem(0)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .PrecoDeCompra(0)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(0)
      .ValorFCP(0);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue( returnValue.ValorMargemBruta = 0 );

end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoPreVenZero_Opc4;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('4')
      .PrecoDeCusto(0)
      .PrecoDeVenda(0)
      .ValorDaMargem(0)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .PrecoDeCompra(0)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(0)
      .ValorFCP(0);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue( returnValue.ValorMargemBruta = 0 );


end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoPreVenZero_Opc5;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('5')
      .PrecoDeCusto(0)
      .PrecoDeVenda(0)
      .ValorDaMargem(0)
      .IcmsDeSaida(0)
      .ImpostosFederais(0)
      .DespesasOperacionais(0)
      .PrecoDeCompra(0)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(0)
      .ValorFCP(0);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue( returnValue.ValorMargemBruta = 0 );


end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovoST_Opc4;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('4')
      .PrecoDeCusto(40)
      .PrecoDeVenda(100)
      .ValorDaMargem(0)
      .IcmsDeSaida(5)
      .ImpostosFederais(2)
      .DespesasOperacionais(3)
      .PrecoDeCompra(30)
      .ValorIcmsSt(0)
      .CalcularST(true)
      .ValorDifal(2)
      .ValorFCP(2);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue( returnValue.ValorMargemBruta = objCore.fStrToFloat('52,5'));

end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc1;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('1')
      .PrecoDeCusto(40)
      .PrecoDeVenda(100)
      .ValorDaMargem(0)
      .IcmsDeSaida(5)
      .ImpostosFederais(2)
      .DespesasOperacionais(3)
      .PrecoDeCompra(30)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(2)
      .ValorFCP(2);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue( returnValue.ValorMargemBruta = 16);

end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc2;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('1')
      .PrecoDeCusto(40)
      .PrecoDeVenda(100)
      .ValorDaMargem(0)
      .IcmsDeSaida(5)
      .ImpostosFederais(2)
      .DespesasOperacionais(3)
      .PrecoDeCompra(30)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(2)
      .ValorFCP(2);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue( returnValue.ValorMargemBruta = 16);
end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc3;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('3')
      .PrecoDeCusto(40)
      .PrecoDeVenda(100)
      .ValorDaMargem(0)
      .IcmsDeSaida(5)
      .ImpostosFederais(2)
      .DespesasOperacionais(3)
      .PrecoDeCompra(30)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(2)
      .ValorFCP(2);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue(CompararValores(returnValue.ValorMargemBruta, 40));

end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc4;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('4')
      .PrecoDeCusto(40)
      .PrecoDeVenda(100)
      .ValorDaMargem(0)
      .IcmsDeSaida(5)
      .ImpostosFederais(2)
      .DespesasOperacionais(3)
      .PrecoDeCompra(30)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(2)
      .ValorFCP(2);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue( returnValue.ValorMargemBruta = 40);

end;

procedure TestTClasseMargemBruta.TesteCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo_Opc5;
Var
  returnValue : IResultadoCalculoMargemBruta;
  LParametros : IParametrosCalculoMargemBruta;
begin
  LParametros :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('5')
      .PrecoDeCusto(40)
      .PrecoDeVenda(100)
      .ValorDaMargem(0)
      .IcmsDeSaida(5)
      .ImpostosFederais(2)
      .DespesasOperacionais(3)
      .PrecoDeCompra(30)
      .ValorIcmsSt(0)
      .CalcularST(false)
      .ValorDifal(2)
      .ValorFCP(2);


  returnValue :=
    TCalculoMargemMargemBruta.New
      .CalculaMargemBruta(LParametros);

  CheckTrue(CompararValores(returnValue.ValorMargemBruta, 28.57));
end;

initialization
  RegisterTest(TestTClasseMargemBruta.Suite);
end.

