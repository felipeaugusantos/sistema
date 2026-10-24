unit TestFaturamento.Margem.Tipos.MargemVenda;

interface

uses
  TestFramework,
  Faturamento.Margem.Tipos.MargemVenda,
  Shared.Functions.Types,
  Faturamento.Margem.Interfaces.MargemVenda;

type
  TestTParametrosServicoMargemVenda = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TesteClassificacaoFiscal;
    procedure TesteCarregarPedidoOrcamentoEntradaFutura;
    procedure TesteImpostosFederais;
    procedure TestePrecoMedio;
    procedure TesteCalcularST;
    procedure TestePrecoUltimaCompra;
    procedure TesteValorUnitarioOriginal;
    procedure TesteValorUnitario;
    procedure TesteValorDoIcms;
    procedure TesteValorBaseDoIcms;
    procedure TesteValorDoDifal;
    procedure TesteValorDoFCP;
    procedure TesteDespesasOperacionais;
    procedure TesteDespesaOperacionalCliente;
    procedure TesteValorComissaoTabelaDeitens;
    procedure TesteValorDoCustoPraticado;
    procedure TesteValorCustoDoItem;
    procedure TesteOutrosValores;
    procedure TesteConsiderarMargemDePrecoUltimaCompraNoCalculo;
    procedure TesteValorUltimaCompraImpostos;
    procedure TesteValorDaSubstituicao;
    procedure TesteValorDoIcmsStParteDaVenda;
    procedure TesteValorCalculoImpostosAliquota;
    procedure TesteValorCat17;
    procedure TesteValorMargemCat17;
    procedure TesteConfiguracaoMargemMarkup;
    procedure TesteValorDaAliquotaDiferencaPrecoDinamicoIcms;
    procedure TesteValorDaAliquotaDiferencaPrecoDinamicoMargem;
    procedure TesteValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida;
    procedure TesteValorDaAliquotaDiferencaPrecoDinamicoMargemMedia;
    procedure TesteValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos;
    procedure TesteValorDaAliquotaDiferencaPrecoDinamicoMargemItem;
    procedure TesteValorDaAliquotaDiferencaPrecoDinamicoMargemLucro;
    procedure TesteValorUnitarioMargemMinima;
    procedure TesteValorUnitarioMargemPraticadaCustoReal;
    procedure TesteValorUnitarioMargemPropostaCustoReal;
    procedure TesteValorUnitarioMargemPropostaCusto;
    procedure TesteValorUnitarioMargemPraticadaCusto;
    procedure TesteValorUnitarioMargemBrutaPraticadaPrecoMedio;
    procedure TesteValorUnitarioMargemLiquidaPraticadaPrecoMedio;
    procedure TesteValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
    procedure TesteValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
    procedure TesteValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
    procedure TesteValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
    procedure TesteValorUnitarioItemMargemPrecoMedio;
    procedure TesteValorUnitarioItemMargemPrecoUltimaCompraComImpostos;
    procedure TesteValorUnitarioItemMargemProposta;
    procedure TesteValorUnitarioItemMargemPraticadaLucro;
    procedure TesteValorMargemIdeal;
    procedure TesteCalcularPrecoIdeal;
    procedure TesteValorPrecoIdeal;
    procedure TesteAliquotaIcmsPrecoIdeal;
  end;


  TestTParametrosCalculoMargemVenda = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TesteImpostosFederais;
    procedure TestePrecoMedio;
    procedure TesteValorCalculoImpostosAliquota;
    procedure TesteCalcularST;
    procedure TesteValorUnitarioOriginal ;
    procedure TesteValorUnitario;
    procedure TesteValorDoIcms;
    procedure TesteValorDoDifal ;
    procedure TesteValorDoFCP;
    procedure TesteDespesasOperacionais ;
    procedure TesteDespesaOperacionalCliente;
    procedure TesteValorComissaoTabelaDeitens ;
    procedure TesteValorDoCustoPraticado;
    procedure TesteValorCustoDoItem;
    procedure TesteOutrosValores ;
    procedure TesteValorUltimaCompraImpostos ;
    procedure TesteConsiderarMargemDePrecoUltimaCompraNoCalculo;
    procedure TesteValorDoIcmsStParteDaVenda ;
    procedure TesteConfiguracaoMargemMarkup ;
    procedure TesteValorDaAliquotaDiferencaPrecoDinamicoIcms ;
    procedure TesteValorUnitarioMargemMinima ;
    procedure TesteValorUnitarioCustoRealComMargemZero ;
    procedure TesteValorUnitarioMargemPraticadaCustoReal ;
    procedure TesteValorUnitarioMargemPropostaCustoReal;
    procedure TesteValorUnitarioMargemPropostaCusto ;
    procedure TesteValorUnitarioMargemPraticadaCusto ;
    procedure TesteValorUnitarioMargemBrutaPraticadaPrecoMedio ;
    procedure TesteValorUnitarioMargemLiquidaPraticadaPrecoMedio ;
    procedure TesteValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
    procedure TesteValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra ;
    procedure TesteValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos ;
    procedure TesteValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
    procedure TesteValorUnitarioItemMargemPrecoMedio ;
    procedure TesteValorUnitarioItemMargemPrecoUltimaCompraComImpostos ;
    procedure TesteValorUnitarioItemMargemProposta ;
    procedure TesteValorUnitarioItemMargemPraticadaLucro;
    procedure TesteValorMargemIdeal ;
    procedure TesteCalcularPrecoIdeal ;
    procedure TesteValorPrecoIdeal ;
    procedure TesteAliquotaIcmsPrecoIdeal ;
    procedure TesteValorMargemCat17;

  end;

  TestTResultadoCalculoMargemVenda= class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValorUnitarioMargemMinima;
    procedure TestValorUnitarioCustoRealComMargemZero;
    procedure TestValorUnitarioMargemPraticadaCustoReal;
    procedure TestValorUnitarioMargemPropostaCustoReal;
    procedure TestValorUnitarioMargemPropostaCusto;
    procedure TestValorUnitarioMargemPraticadaCusto;
    procedure TestValorUnitarioMargemBrutaPraticadaPrecoMedio;
    procedure TestValorUnitarioMargemLiquidaPraticadaPrecoMedio;
    procedure TestValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
    procedure TestValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
    procedure TestValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
    procedure TestValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
    procedure TestValorUnitarioMargemPraticada;
    procedure TestValorUnitarioMargemPraticadaSemDespesasOperacionais;
    procedure TestValorMargemCat17;
    procedure TestValorUnitarioMargemPrecoMedio;
    procedure TestValorUnitarioMargemPrecoUltimaCompraComImpostos;
    procedure TestValorUnitarioMargemProposta;
    procedure TestValorUnitarioMarkupProposto;
    procedure TestValorUnitarioMarkupPraticado;
    procedure TestValorUnitarioMarkupPraticadoSemDespesasOperacionais;
    procedure TestValorUnitarioMarkupPrecoMedio;
    procedure TestValorUnitarioItemMargemPrecoMedio;
    procedure TestValorUnitarioItemMargemPrecoUltimaCompraComImpostos;
    procedure TestValorUnitarioItemMargemProposta;
    procedure TestValorUnitarioItemMargemPraticadaLucro;
    procedure TestValorMargemIdeal;
    procedure TestValorUnitarioMargemPrecoIdeal;
    procedure TestValorUnitarioMarkupPrecoUltimaCompraComImpostos;
  end;


  TestTResultadoServicosClasseMargemVenda = class(TTestCase)
  strict private
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestParametrosCalculoMargemVenda;
    procedure TestResultadoCalculoMargemVenda;

  end;


implementation

procedure TestTParametrosServicoMargemVenda.SetUp;
begin

end;

procedure TestTParametrosServicoMargemVenda.TearDown;
begin

end;


procedure TestTParametrosServicoMargemVenda.TesteAliquotaIcmsPrecoIdeal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.AliquotaIcmsPrecoIdeal(560).AliquotaIcmsPrecoIdeal;

  CheckTrue(ReturnValue = 560);
end;

procedure TestTParametrosServicoMargemVenda.TesteCalcularPrecoIdeal;
var
  ReturnValue: boolean;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.CalcularPrecoIdeal(true).CalcularPrecoIdeal;

  CheckTrue(ReturnValue = true);
end;

procedure TestTParametrosServicoMargemVenda.TesteCalcularST;
var
  ReturnValue: boolean;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.CalcularST(true).CalcularST;

  CheckTrue(ReturnValue = true);
end;

procedure TestTParametrosServicoMargemVenda.TesteCarregarPedidoOrcamentoEntradaFutura;
var
  ReturnValue: boolean;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.CarregarPedidoOrcamentoEntradaFutura(true).CarregarPedidoOrcamentoEntradaFutura;

  CheckTrue(ReturnValue = true);

end;

procedure TestTParametrosServicoMargemVenda.TesteClassificacaoFiscal;
var
  ReturnValue: string;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ClassificacaoFiscal('000').ClassificacaoFiscal;

  CheckTrue(ReturnValue = '000');
end;

procedure TestTParametrosServicoMargemVenda.TesteConfiguracaoMargemMarkup;
var
  ReturnValue: string;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ConfiguracaoMargemMarkup('1').ConfiguracaoMargemMarkup;

  CheckTrue(ReturnValue = '1');

end;

procedure TestTParametrosServicoMargemVenda.TesteConsiderarMargemDePrecoUltimaCompraNoCalculo;
var
  ReturnValue: boolean;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ConsiderarMargemDePrecoUltimaCompraNoCalculo(true).ConsiderarMargemDePrecoUltimaCompraNoCalculo;

  CheckTrue(ReturnValue = true);

end;

procedure TestTParametrosServicoMargemVenda.TesteDespesaOperacionalCliente;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.DespesaOperacionalCliente(50).DespesaOperacionalCliente;

  CheckTrue(ReturnValue = 50);

end;

procedure TestTParametrosServicoMargemVenda.TesteDespesasOperacionais;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.DespesasOperacionais(55).DespesasOperacionais;

  CheckTrue(ReturnValue = 55);

end;

procedure TestTParametrosServicoMargemVenda.TesteImpostosFederais;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ImpostosFederais(10).ImpostosFederais;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemVenda.TesteOutrosValores;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.OutrosValores(90).OutrosValores;

  CheckTrue(ReturnValue = 90);
end;

procedure TestTParametrosServicoMargemVenda.TestePrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.PrecoMedio(100).PrecoMedio;

  CheckTrue(ReturnValue = 100);

end;

procedure TestTParametrosServicoMargemVenda.TestePrecoUltimaCompra;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.PrecoUltimaCompra(120).PrecoUltimaCompra;

  CheckTrue(ReturnValue = 120);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorBaseDoIcms;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorBaseDoIcms(15).ValorBaseDoIcms;

  CheckTrue(ReturnValue = 15);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorCalculoImpostosAliquota;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorCalculoImpostosAliquota(10).ValorCalculoImpostosAliquota;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorCat17;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorCat17(666).ValorCat17;

  CheckTrue(ReturnValue = 666);


end;

procedure TestTParametrosServicoMargemVenda.TesteValorComissaoTabelaDeitens;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorComissaoTabelaDeitens(10).ValorComissaoTabelaDeitens;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorCustoDoItem;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorCustoDoItem(190).ValorCustoDoItem;

  CheckTrue(ReturnValue = 190);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorDaAliquotaDiferencaPrecoDinamicoIcms;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDaAliquotaDiferencaPrecoDinamicoIcms(330).ValorDaAliquotaDiferencaPrecoDinamicoIcms;

  CheckTrue(ReturnValue = 330);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorDaAliquotaDiferencaPrecoDinamicoMargem;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDaAliquotaDiferencaPrecoDinamicoMargem(10).ValorDaAliquotaDiferencaPrecoDinamicoMargem;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos(10).ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorDaAliquotaDiferencaPrecoDinamicoMargemItem;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDaAliquotaDiferencaPrecoDinamicoMargemItem(40).ValorDaAliquotaDiferencaPrecoDinamicoMargemItem;

  CheckTrue(ReturnValue = 40);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida(80).ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida;

  CheckTrue(ReturnValue = 80);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorDaAliquotaDiferencaPrecoDinamicoMargemLucro;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro(40).ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro;

  CheckTrue(ReturnValue = 40);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorDaAliquotaDiferencaPrecoDinamicoMargemMedia;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia(810).ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia;

  CheckTrue(ReturnValue = 810);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorDaSubstituicao;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDaSubstituicao(10).ValorDaSubstituicao;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorDoCustoPraticado;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDoCustoPraticado(610).ValorDoCustoPraticado;

  CheckTrue(ReturnValue = 610);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorDoDifal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDoDifal(15).ValorDoDifal;

  CheckTrue(ReturnValue = 15);
end;


procedure TestTParametrosServicoMargemVenda.TesteValorDoFCP;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDoFCP(30).ValorDoFCP;

  CheckTrue(ReturnValue = 30);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorDoIcms;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDoIcms(15).ValorDoIcms;

  CheckTrue(ReturnValue = 15);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorDoIcmsStParteDaVenda;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorDoIcmsStParteDaVenda(50).ValorDoIcmsStParteDaVenda;

  CheckTrue(ReturnValue = 50);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(150).ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;

  CheckTrue(ReturnValue = 150);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(10).ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemBrutaPraticadaPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemBrutaPraticadaPrecoMedio(10).ValorUnitarioMargemBrutaPraticadaPrecoMedio;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorMargemCat17;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorMargemCat17(50).ValorMargemCat17;

  CheckTrue(ReturnValue = 50);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioItemMargemProposta;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioItemMargemProposta(60).ValorUnitarioItemMargemProposta;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorMargemIdeal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorMargemIdeal(1060).ValorMargemIdeal;

  CheckTrue(ReturnValue = 1060);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioItemMargemPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(60).ValorUnitarioItemMargemPrecoUltimaCompraComImpostos;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(150).ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;

  CheckTrue(ReturnValue = 150);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(10).ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemLiquidaPraticadaPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemLiquidaPraticadaPrecoMedio(50).ValorUnitarioMargemLiquidaPraticadaPrecoMedio;

  CheckTrue(ReturnValue = 50);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioItemMargemPraticadaLucro;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioItemMargemPraticadaLucro(160).ValorUnitarioItemMargemPraticadaLucro;

  CheckTrue(ReturnValue = 160);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioItemMargemPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioItemMargemPrecoMedio(50).ValorUnitarioItemMargemPrecoMedio;

  CheckTrue(ReturnValue = 50);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemMinima;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemMinima(10).ValorUnitarioMargemMinima;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemPraticadaCusto;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemPraticadaCusto(10).ValorUnitarioMargemPraticadaCusto;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemPraticadaCustoReal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemPraticadaCustoReal(10).ValorUnitarioMargemPraticadaCustoReal;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemPropostaCusto;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemPropostaCusto(100).ValorUnitarioMargemPropostaCusto;

  CheckTrue(ReturnValue = 100);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioMargemPropostaCustoReal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioMargemPropostaCustoReal(10).ValorUnitarioMargemPropostaCustoReal;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorPrecoIdeal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorPrecoIdeal(555).ValorPrecoIdeal;

  CheckTrue(ReturnValue = 555);
end;

procedure TestTParametrosServicoMargemVenda.TesteValorUltimaCompraImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUltimaCompraImpostos(180).ValorUltimaCompraImpostos;

  CheckTrue(ReturnValue = 180);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitario;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitario(200).ValorUnitario;

  CheckTrue(ReturnValue = 200);

end;

procedure TestTParametrosServicoMargemVenda.TesteValorUnitarioOriginal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemVenda.New.ValorUnitarioOriginal(1200).ValorUnitarioOriginal;

  CheckTrue(ReturnValue = 1200);

end;

{ TestTParametrosCalculoMargemVenda }

procedure TestTParametrosCalculoMargemVenda.SetUp;
begin
  inherited;

end;

procedure TestTParametrosCalculoMargemVenda.TearDown;
begin
  inherited;

end;



procedure TestTParametrosCalculoMargemVenda.TesteAliquotaIcmsPrecoIdeal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.AliquotaIcmsPrecoIdeal(10).AliquotaIcmsPrecoIdeal;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteCalcularPrecoIdeal;
var
  ReturnValue: boolean;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.CalcularPrecoIdeal(true).CalcularPrecoIdeal;

  CheckTrue(ReturnValue = true);

end;

procedure TestTParametrosCalculoMargemVenda.TesteCalcularST;
var
  ReturnValue: Boolean;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.CalcularST(false).CalcularST;

  CheckTrue(ReturnValue = false);
end;



procedure TestTParametrosCalculoMargemVenda.TesteConfiguracaoMargemMarkup;
var
  ReturnValue: string;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ConfiguracaoMargemMarkup('5').ConfiguracaoMargemMarkup;

  CheckTrue(ReturnValue = '5');

end;

procedure TestTParametrosCalculoMargemVenda.TesteConsiderarMargemDePrecoUltimaCompraNoCalculo;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUltimaCompraImpostos(10).ValorUltimaCompraImpostos;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteDespesaOperacionalCliente;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.DespesaOperacionalCliente(170).DespesaOperacionalCliente;

  CheckTrue(ReturnValue = 170);
end;

procedure TestTParametrosCalculoMargemVenda.TesteDespesasOperacionais;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.DespesasOperacionais(10).DespesasOperacionais;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteImpostosFederais;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ImpostosFederais(10).ImpostosFederais;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteOutrosValores;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.OutrosValores(10).OutrosValores;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TestePrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.PrecoMedio(10).PrecoMedio;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorCalculoImpostosAliquota;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorCalculoImpostosAliquota(10).ValorCalculoImpostosAliquota;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorComissaoTabelaDeitens;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorComissaoTabelaDeitens(10).ValorComissaoTabelaDeitens;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorCustoDoItem;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorCustoDoItem(10).ValorCustoDoItem;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioCustoRealComMargemZero;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioCustoRealComMargemZero(10).ValorUnitarioCustoRealComMargemZero;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorDaAliquotaDiferencaPrecoDinamicoIcms;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorDaAliquotaDiferencaPrecoDinamicoIcms(10).ValorDaAliquotaDiferencaPrecoDinamicoIcms;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorDoCustoPraticado;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorDoCustoPraticado(10).ValorDoCustoPraticado;

  CheckTrue(ReturnValue = 10);


end;

procedure TestTParametrosCalculoMargemVenda.TesteValorDoDifal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorDoDifal(10).ValorDoDifal;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorDoFCP;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorDoFCP(10).ValorDoFCP;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorDoIcms;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorDoIcms(10).ValorDoIcms;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorDoIcmsStParteDaVenda;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorDoIcmsStParteDaVenda(10).ValorDoIcmsStParteDaVenda;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(10).ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(10).ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;

  CheckTrue(ReturnValue = 10);


end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemBrutaPraticadaPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemBrutaPraticadaPrecoMedio(10).ValorUnitarioMargemBrutaPraticadaPrecoMedio;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorMargemCat17;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorMargemCat17(10).ValorMargemCat17;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioItemMargemProposta;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioItemMargemProposta(10).ValorUnitarioItemMargemProposta;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorMargemIdeal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorMargemIdeal(10).ValorMargemIdeal;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioItemMargemPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioItemMargemProposta(10).ValorUnitarioItemMargemProposta;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(10).ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(10).ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;

  CheckTrue(ReturnValue = 10);


end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemLiquidaPraticadaPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemLiquidaPraticadaPrecoMedio(10).ValorUnitarioMargemLiquidaPraticadaPrecoMedio;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioItemMargemPraticadaLucro;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioItemMargemPraticadaLucro(10).ValorUnitarioItemMargemPraticadaLucro;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioItemMargemPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioItemMargemPrecoMedio(10).ValorUnitarioItemMargemPrecoMedio;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemMinima;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemMinima(10).ValorUnitarioMargemMinima;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemPraticadaCusto;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemPraticadaCusto(10).ValorUnitarioMargemPraticadaCusto;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemPraticadaCustoReal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemPraticadaCustoReal(10).ValorUnitarioMargemPraticadaCustoReal;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemPropostaCusto;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemPropostaCusto(10).ValorUnitarioMargemPropostaCusto;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioMargemPropostaCustoReal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioMargemPropostaCustoReal(10).ValorUnitarioMargemPropostaCustoReal;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorPrecoIdeal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorPrecoIdeal(10).ValorPrecoIdeal;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUltimaCompraImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUltimaCompraImpostos(10).ValorUltimaCompraImpostos;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitario;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitario(10).ValorUnitario;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemVenda.TesteValorUnitarioOriginal;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemVenda.New.ValorUnitarioOriginal(10).ValorUnitarioOriginal;

  CheckTrue(ReturnValue = 10);
end;

{ TestTResultadoCalculoMargemVenda }

procedure TestTResultadoCalculoMargemVenda.SetUp;
begin
  inherited;

end;

procedure TestTResultadoCalculoMargemVenda.TearDown;
begin
  inherited;

end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioCustoRealComMargemZero;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioCustoRealComMargemZero(1000).ValorUnitarioCustoRealComMargemZero;

  CheckTrue(ReturnValue = 1000);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemPrecoIdeal;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorMargemIdeal(35).ValorMargemIdeal;

  CheckTrue(ReturnValue = 35);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMarkupPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorMargemIdeal(90).ValorMargemIdeal;

  CheckTrue(ReturnValue = 90);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemProposta;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPrecoMedio(500).ValorUnitarioMargemPrecoMedio;

  CheckTrue(ReturnValue = 500);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(10).ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(10).ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemBrutaPraticadaPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemBrutaPraticadaPrecoMedio(160).ValorUnitarioMargemBrutaPraticadaPrecoMedio;

  CheckTrue(ReturnValue = 160);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorMargemCat17;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorMargemCat17(180).ValorMargemCat17;

  CheckTrue(ReturnValue = 180);

end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioItemMargemProposta;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioItemMargemProposta(50).ValorUnitarioItemMargemProposta;

  CheckTrue(ReturnValue = 50);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorMargemIdeal;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorMargemIdeal(35).ValorMargemIdeal;

  CheckTrue(ReturnValue = 35);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioItemMargemPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(50).ValorUnitarioItemMargemPrecoUltimaCompraComImpostos;

  CheckTrue(ReturnValue = 50);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(10).ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(50).ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;

  CheckTrue(ReturnValue = 50);

end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemLiquidaPraticadaPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemLiquidaPraticadaPrecoMedio(60).ValorUnitarioMargemLiquidaPraticadaPrecoMedio;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioItemMargemPraticadaLucro;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioItemMargemPraticadaLucro(150).ValorUnitarioItemMargemPraticadaLucro;

  CheckTrue(ReturnValue = 150);

end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPrecoMedio(150).ValorUnitarioMargemPrecoMedio;

  CheckTrue(ReturnValue = 150);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioItemMargemPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPrecoMedio(750).ValorUnitarioMargemPrecoMedio;

  CheckTrue(ReturnValue = 750);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemMinima;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemMinima(150).ValorUnitarioMargemMinima;

  CheckTrue(ReturnValue = 150);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemPraticada;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPraticada(10).ValorUnitarioMargemPraticada;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemPraticadaCusto;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPraticadaCusto(100).ValorUnitarioMargemPraticadaCusto;

  CheckTrue(ReturnValue = 100);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemPraticadaCustoReal;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPraticadaCustoReal(1500).ValorUnitarioMargemPraticadaCustoReal;

  CheckTrue(ReturnValue = 1500);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemPrecoUltimaCompraComImpostos;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPrecoMedio(1500).ValorUnitarioMargemPrecoMedio;

  CheckTrue(ReturnValue = 1500);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemPropostaCusto;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPropostaCusto(60).ValorUnitarioMargemPropostaCusto;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemPropostaCustoReal;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPropostaCustoReal(10).ValorUnitarioMargemPropostaCustoReal;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMargemPraticadaSemDespesasOperacionais;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPraticadaSemDespesasOperacionais(80).ValorUnitarioMargemPraticadaSemDespesasOperacionais;

  CheckTrue(ReturnValue = 80);

end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMarkupPrecoMedio;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPrecoMedio(50).ValorUnitarioMargemPrecoMedio;

  CheckTrue(ReturnValue = 50);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMarkupPraticado;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPrecoMedio(700).ValorUnitarioMargemPrecoMedio;

  CheckTrue(ReturnValue = 700);
end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMarkupPraticadoSemDespesasOperacionais;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPrecoMedio(71).ValorUnitarioMargemPrecoMedio;

  CheckTrue(ReturnValue = 71);

end;

procedure TestTResultadoCalculoMargemVenda.TestValorUnitarioMarkupProposto;
var
  ReturnValue: double;
begin
  ReturnValue := TResultadoCalculoMargemVenda.New.ValorUnitarioMargemPrecoMedio(800).ValorUnitarioMargemPrecoMedio;

  CheckTrue(ReturnValue = 800);
end;

{ TestTResultadoServicosClasseMargemVenda }

procedure TestTResultadoServicosClasseMargemVenda.TestResultadoCalculoMargemVenda;
Var
  returnValue : IResultadoCalculoMargemVenda;
begin

  returnValue :=
    TResultadoCalculoMargemVenda.New
      .ValorUnitarioMargemMinima(10)
      .ValorUnitarioCustoRealComMargemZero(40)
      .ValorUnitarioMargemPraticadaCustoReal(100)
      .ValorUnitarioMargemPropostaCustoReal(110)
      .ValorUnitarioMargemPropostaCusto(150)
      .ValorUnitarioMargemPraticadaCusto(160)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(10)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(80)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(10)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(90)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(10)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(10)
      .ValorUnitarioMargemPraticada(0)
      .ValorUnitarioMargemPraticadaSemDespesasOperacionais(0)
      .ValorUnitarioMargemPrecoMedio(80)
      .ValorUnitarioMargemPrecoUltimaCompraComImpostos(10)
      .ValorUnitarioMargemProposta(60)
      .ValorUnitarioMarkupProposto(8)
      .ValorUnitarioMarkupPraticado(9)
      .ValorUnitarioMarkupPraticadoSemDespesasOperacionais(10)
      .ValorUnitarioMarkupPrecoMedio(188)
      .ValorUnitarioItemMargemPrecoMedio(190)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(160)
      .ValorUnitarioItemMargemProposta(17)
      .ValorUnitarioItemMargemPraticadaLucro(80)
      .ValorMargemIdeal(20)
      .ValorUnitarioMargemPrecoIdeal(10)
      .ValorMargemCat17(10)
      .ValorUnitarioMarkupPrecoUltimaCompraComImpostos(0);

  CheckTrue(
    (returnValue.ValorUnitarioMargemMinima = 10) And
    (returnValue.ValorUnitarioCustoRealComMargemZero = 40) And
    (returnValue.ValorUnitarioMargemPraticadaCustoReal = 100) And
    (returnValue.ValorUnitarioMargemPropostaCustoReal = 110) And
    (returnValue.ValorUnitarioMargemPropostaCusto = 150) And
    (returnValue.ValorUnitarioMargemPraticadaCusto = 160) And
    (returnValue.ValorUnitarioMargemBrutaPraticadaPrecoMedio = 10) And
    (returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoMedio = 80) And
    (returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra = 10) And
    (returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra = 90) And
    (returnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos = 10) And
    (returnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos = 10) And
    (returnValue.ValorUnitarioMargemPraticada = 0) And
    (returnValue.ValorUnitarioMargemPraticadaSemDespesasOperacionais = 0) And
    (returnValue.ValorUnitarioMargemPrecoMedio = 80) And
    (returnValue.ValorUnitarioMargemPrecoUltimaCompraComImpostos = 10) And
    (returnValue.ValorUnitarioMargemProposta = 60) And
    (returnValue.ValorUnitarioMarkupProposto = 8) And
    (returnValue.ValorUnitarioMarkupPraticado = 9) And
    (returnValue.ValorUnitarioMarkupPraticadoSemDespesasOperacionais = 10) And
    (returnValue.ValorUnitarioMarkupPrecoMedio = 188) And
    (returnValue.ValorUnitarioItemMargemPrecoMedio = 190) And
    (returnValue.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos = 160) And
    (returnValue.ValorUnitarioItemMargemProposta = 17) And
    (returnValue.ValorUnitarioItemMargemPraticadaLucro = 80) And
    (returnValue.ValorMargemIdeal = 20) And
    (returnValue.ValorUnitarioMargemPrecoIdeal = 10) And
    (returnValue.ValorMargemCat17 = 10) And
    (returnValue.ValorUnitarioMarkupPrecoUltimaCompraComImpostos = 0));

end;


procedure TestTResultadoServicosClasseMargemVenda.SetUp;
begin
end;

procedure TestTResultadoServicosClasseMargemVenda.TearDown;
begin
  inherited;

end;

procedure TestTResultadoServicosClasseMargemVenda.TestParametrosCalculoMargemVenda;
Var
  returnValue : IParametrosCalculoMargemVenda;
  LParametros : IParametrosCalculoMargemVenda;
begin
  inherited;

  LParametros :=
    TParametrosCalculoMargemVenda.New
      .PrecoMedio(80)
      .ValorCalculoImpostosAliquota(5)
      .CalcularST(false)
      .ValorUnitarioOriginal(53)
      .ValorUnitario(60)
      .ValorDoIcms(5)
      .ValorDoDifal(0)
      .ValorDoFCP(0)
      .DespesasOperacionais(6)
      .DespesaOperacionalCliente(0)
      .ValorComissaoTabelaDeitens(10)
      .ValorDoCustoPraticado(65)
      .ValorCustoDoItem(60)
      .OutrosValores(60)
      .ValorUltimaCompraImpostos(70)
      .ConsiderarMargemDePrecoUltimaCompraNoCalculo(true)
      .ValorDoIcmsStParteDaVenda(10)
      .ConfiguracaoMargemMarkup('5')
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(10)
      .ValorUnitarioMargemMinima(10)
      .ValorUnitarioCustoRealComMargemZero(10)
      .ValorUnitarioMargemPraticadaCustoReal(60)
      .ValorUnitarioMargemPropostaCustoReal(66)
      .ValorUnitarioMargemPropostaCusto(60)
      .ValorUnitarioMargemPraticadaCusto(40)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(80)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(90)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(90)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(100)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(80)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(56)
      .ValorUnitarioItemMargemPrecoMedio(10)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(10)
      .ValorUnitarioItemMargemProposta(60)
      .ValorUnitarioItemMargemPraticadaLucro(60)
      .ValorMargemIdeal(60)
      .CalcularPrecoIdeal(true)
      .ValorPrecoIdeal(60)
      .AliquotaIcmsPrecoIdeal(5)
      .ValorMargemCat17(888);

  ReturnValue := TResultadoServicosClasseMargemVenda.New.ParametrosCalculoMargemVenda(LParametros).ParametrosCalculoMargemVenda;

  CheckTrue(
    (ReturnValue.PrecoMedio = 80) And
    (ReturnValue.ValorCalculoImpostosAliquota = 5)And
    (ReturnValue.CalcularST = false)And
    (ReturnValue.ValorUnitarioOriginal = 53)And
    (ReturnValue.ValorUnitario = 60)And
    (ReturnValue.ValorDoIcms = 5)And
    (ReturnValue.ValorDoDifal = 0)And
    (ReturnValue.ValorDoFCP = 0)And
    (ReturnValue.DespesasOperacionais = 6)And
    (ReturnValue.DespesaOperacionalCliente = 0)And
    (ReturnValue.ValorComissaoTabelaDeitens = 10)And
    (ReturnValue.ValorDoCustoPraticado = 65)And
    (ReturnValue.ValorCustoDoItem = 60)And
    (ReturnValue.OutrosValores = 60)And
    (ReturnValue.ValorUltimaCompraImpostos = 70)And
    (ReturnValue.ConsiderarMargemDePrecoUltimaCompraNoCalculo = true)And
    (ReturnValue.ValorDoIcmsStParteDaVenda = 10)And
    (ReturnValue.ConfiguracaoMargemMarkup = '5')And
    (ReturnValue.ValorDaAliquotaDiferencaPrecoDinamicoIcms = 10)And
    (ReturnValue.ValorUnitarioMargemMinima = 10)And
    (ReturnValue.ValorUnitarioCustoRealComMargemZero = 10)And
    (ReturnValue.ValorUnitarioMargemPraticadaCustoReal = 60)And
    (ReturnValue.ValorUnitarioMargemPropostaCustoReal = 66)And
    (ReturnValue.ValorUnitarioMargemPropostaCusto = 60)And
    (ReturnValue.ValorUnitarioMargemPraticadaCusto = 40)And
    (ReturnValue.ValorUnitarioMargemBrutaPraticadaPrecoMedio = 80)And
    (ReturnValue.ValorUnitarioMargemLiquidaPraticadaPrecoMedio = 90)And
    (ReturnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra = 90)And
    (ReturnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra = 100)And
    (ReturnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos = 80)And
    (ReturnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos = 56)And
    (ReturnValue.ValorUnitarioItemMargemPrecoMedio = 10)And
    (ReturnValue.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos = 10)And
    (ReturnValue.ValorUnitarioItemMargemProposta = 60)And
    (ReturnValue.ValorUnitarioItemMargemPraticadaLucro = 60)And
    (ReturnValue.ValorMargemIdeal = 60)And
    (ReturnValue.CalcularPrecoIdeal = true)And
    (ReturnValue.ValorPrecoIdeal = 60)And
    (ReturnValue.AliquotaIcmsPrecoIdeal = 5)And
    (ReturnValue.ValorMargemCat17 = 888));
end;


initialization
  RegisterTest(TestTParametrosServicoMargemVenda.Suite);
  RegisterTest(TestTParametrosCalculoMargemVenda.Suite);
  RegisterTest(TestTResultadoCalculoMargemVenda.Suite);
  RegisterTest(TestTResultadoServicosClasseMargemVenda.Suite);
end.

