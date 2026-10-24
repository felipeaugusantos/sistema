unit TestFaturamento.Margem.Tipos.MargemBruta;

interface

uses
  TestFramework, Faturamento.Margem.Tipos.MargemBruta, Shared.Functions.Types,
  Faturamento.Margem.Interfaces.MargemBruta;

type

  TestTParametrosServicoMargemBruta = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestConfiguracaoMargemMarkup;
    procedure TestPrecoDeCusto;
    procedure TestPrecoDeVenda;
    procedure TestValorDaMargem;
    procedure TestIcmsDeSaida;
    procedure TestImpostosFederais;
    procedure TestDespesasOperacionais;
    procedure TestPrecoDeCompra;
    procedure TestValorIcmsSt;
    procedure TestCalcularST;
    procedure TestValorDifal;
    procedure TestValorFCP;
  end;

  TestTParametrosServicoMargemParaMarkup = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValorDaMargem;
  end;

  TestTParametrosCalculoMargemBruta = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestConfiguracaoMargemMarkup;
    procedure TestPrecoDeCusto;
    procedure TestPrecoDeVenda;
    procedure TestValorDaMargem;
    procedure TestIcmsDeSaida;
    procedure TestImpostosFederais;
    procedure TestDespesasOperacionais;
    procedure TestPrecoDeCompra;
    procedure TestValorIcmsSt;
    procedure TestCalcularST;
    procedure TestValorDifal;
    procedure TestValorFCP;
  end;

  TestTParametrosCalculoMargemParaMarkup = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValorDaMargem;
  end;

  TestTResultadoCalculoMargemBruta = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValorMargemBruta;
  end;

  TestTResultadoCalculoMargemParaMarkup  = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValorMarkup;
  end;

  TestTResultadoServicosClasseMargemBruta = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestParametrosCalculoMargemBruta;
    procedure TestParametrosCalculoMargemParaMarkup;
    procedure TestResultadoCalculoMargemBruta;
    procedure TestResultadoCalculoMargemParaMarkup;
  end;


implementation

procedure TestTParametrosServicoMargemBruta.SetUp;
begin
end;

procedure TestTParametrosServicoMargemBruta.TearDown;
begin
end;

procedure TestTParametrosServicoMargemBruta.TestCalcularST;
var
  ReturnValue: boolean;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.CalcularST(true).CalcularST;

  CheckTrue(ReturnValue);
end;

procedure TestTParametrosServicoMargemBruta.TestConfiguracaoMargemMarkup;
var
  ReturnValue: string;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.ConfiguracaoMargemMarkup('1').ConfiguracaoMargemMarkup;

  CheckTrue(ReturnValue = '1');
end;

procedure TestTParametrosServicoMargemBruta.TestDespesasOperacionais;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.DespesasOperacionais(10).DespesasOperacionais;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemBruta.TestIcmsDeSaida;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.IcmsDeSaida(10).IcmsDeSaida;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemBruta.TestImpostosFederais;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.ImpostosFederais(10).ImpostosFederais;

  CheckTrue(ReturnValue = 10);
end;


procedure TestTParametrosServicoMargemBruta.TestPrecoDeCompra;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.PrecoDeCompra(10).PrecoDeCompra;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemBruta.TestPrecoDeCusto;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.PrecoDeCusto(10).PrecoDeCusto;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemBruta.TestPrecoDeVenda;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.PrecoDeVenda(10).PrecoDeVenda;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemBruta.TestValorDaMargem;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.ValorDaMargem(10).ValorDaMargem;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemBruta.TestValorDifal;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.ValorDifal(10).ValorDifal;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemBruta.TestValorFCP;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.ValorFCP(10).ValorFCP;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosServicoMargemBruta.TestValorIcmsSt;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosServicoMargemBruta.New.ValorIcmsSt(10).ValorIcmsSt;

  CheckTrue(ReturnValue = 10);
end;

{ TestTParametrosServicoMargemParaMarkup }

procedure TestTParametrosServicoMargemParaMarkup.SetUp;
begin
  inherited;

end;

procedure TestTParametrosServicoMargemParaMarkup.TearDown;
begin
  inherited;

end;

procedure TestTParametrosServicoMargemParaMarkup.TestValorDaMargem;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosServicoMargemParaMarkup.New.ValorDaMargem(10).ValorDaMargem;

  CheckTrue(ReturnValue = 10);
end;

{ TestTParametrosCalculoMargemBruta }

procedure TestTParametrosCalculoMargemBruta.SetUp;
begin
  inherited;

end;

procedure TestTParametrosCalculoMargemBruta.TearDown;
begin
  inherited;

end;

procedure TestTParametrosCalculoMargemBruta.TestCalcularST;
var
  ReturnValue: boolean;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.CalcularST(true).CalcularST;

  CheckTrue(ReturnValue);
end;

procedure TestTParametrosCalculoMargemBruta.TestConfiguracaoMargemMarkup;
var
  ReturnValue: string;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.ConfiguracaoMargemMarkup('1').ConfiguracaoMargemMarkup;

  CheckTrue(ReturnValue = '1');

end;

procedure TestTParametrosCalculoMargemBruta.TestDespesasOperacionais;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.DespesasOperacionais(10).DespesasOperacionais;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemBruta.TestIcmsDeSaida;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.IcmsDeSaida(10).IcmsDeSaida;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemBruta.TestImpostosFederais;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.ImpostosFederais(10).ImpostosFederais;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemBruta.TestPrecoDeCompra;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.PrecoDeCompra(10).PrecoDeCompra;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemBruta.TestPrecoDeCusto;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.PrecoDeCusto(10).PrecoDeCusto;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemBruta.TestPrecoDeVenda;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.PrecoDeVenda(10).PrecoDeVenda;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemBruta.TestValorDaMargem;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.ValorDaMargem(10).ValorDaMargem;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemBruta.TestValorDifal;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.ValorDifal(10).ValorDifal;

  CheckTrue(ReturnValue = 10);

end;

procedure TestTParametrosCalculoMargemBruta.TestValorFCP;
var
  ReturnValue: Double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.ValorFCP(10).ValorFCP;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosCalculoMargemBruta.TestValorIcmsSt;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemBruta.New.ValorIcmsSt(10).ValorIcmsSt;

  CheckTrue(ReturnValue = 10);

end;

{ TestTParametrosCalculoMargemParaMarkup }

procedure TestTParametrosCalculoMargemParaMarkup.SetUp;
begin
  inherited;

end;

procedure TestTParametrosCalculoMargemParaMarkup.TearDown;
begin
  inherited;

end;

procedure TestTParametrosCalculoMargemParaMarkup.TestValorDaMargem;
var
  ReturnValue: double;
begin
  ReturnValue := TParametrosCalculoMargemParaMarkup.New.ValorDaMargem(10).ValorDaMargem;

  CheckTrue(ReturnValue = 10);

end;

{ TestTResultadoCalculoMargemBruta }

procedure TestTResultadoCalculoMargemBruta.SetUp;
begin
  inherited;

end;

procedure TestTResultadoCalculoMargemBruta.TearDown;
begin
  inherited;

end;

procedure TestTResultadoCalculoMargemBruta.TestValorMargemBruta;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoCalculoMargemBruta.New.ValorMargemBruta(10).ValorMargemBruta;

  CheckTrue(ReturnValue = 10);
end;

{ TestTResultadoCalculoMargemParaMarkup }

procedure TestTResultadoCalculoMargemParaMarkup.SetUp;
begin
  inherited;

end;

procedure TestTResultadoCalculoMargemParaMarkup.TearDown;
begin
  inherited;

end;

procedure TestTResultadoCalculoMargemParaMarkup.TestValorMarkup;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoCalculoMargemParaMarkup.New.ValorMarkup(10).ValorMarkup;

  CheckTrue(ReturnValue = 10);
end;

{ TestTResultadoServicosClasseMargemBruta }

procedure TestTResultadoServicosClasseMargemBruta.SetUp;
begin
  inherited;

end;

procedure TestTResultadoServicosClasseMargemBruta.TearDown;
begin
  inherited;

end;

procedure TestTResultadoServicosClasseMargemBruta.TestParametrosCalculoMargemBruta;
Var
  LParametrosCalculoMargemBruta : IParametrosCalculoMargemBruta;
  ReturnValue : IParametrosCalculoMargemBruta;
begin
  LParametrosCalculoMargemBruta :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup('1')
      .PrecoDeCusto(10)
      .PrecoDeVenda(10)
      .ValorDaMargem(10)
      .IcmsDeSaida(10)
      .ImpostosFederais(10)
      .DespesasOperacionais(10)
      .PrecoDeCompra(10)
      .ValorIcmsSt(10)
      .CalcularST(false)
      .ValorDifal(10)
      .ValorFCP(10);

  ReturnValue :=
    TResultadoServicosClasseMargemBruta.New
      .ParametrosCalculoMargemBruta(LParametrosCalculoMargemBruta).ParametrosCalculoMargemBruta;

  CheckTrue(
     (ReturnValue.ConfiguracaoMargemMarkup = '1') And
     (ReturnValue.PrecoDeCusto = 10)              And
     (ReturnValue.PrecoDeVenda = 10)              And
     (ReturnValue.ValorDaMargem = 10)             And
     (ReturnValue.IcmsDeSaida = 10)               And
     (ReturnValue.ImpostosFederais = 10)          And
     (ReturnValue.DespesasOperacionais = 10)      And
     (ReturnValue.PrecoDeCompra = 10)             And
     (ReturnValue.ValorIcmsSt = 10)               And
     (ReturnValue.CalcularST = false)             And
     (ReturnValue.ValorDifal = 10)                And
     (ReturnValue.ValorFCP = 10));
end;

procedure TestTResultadoServicosClasseMargemBruta.TestParametrosCalculoMargemParaMarkup;
Var
  LParametrosCalculoMargemParaMarkup : IParametrosCalculoMargemParaMarkup;
  ReturnValue : IParametrosCalculoMargemParaMarkup;
begin
  LParametrosCalculoMargemParaMarkup :=
    TParametrosCalculoMargemParaMarkup.New
      .ValorDaMargem(120);

  ReturnValue :=
    TResultadoServicosClasseMargemBruta.New
      .ParametrosCalculoMargemParaMarkup(LParametrosCalculoMargemParaMarkup).ParametrosCalculoMargemParaMarkup;

  CheckTrue(ReturnValue.ValorDaMargem = 120);

end;

procedure TestTResultadoServicosClasseMargemBruta.TestResultadoCalculoMargemBruta;
Var
  LResultadoCalculoMargemBruta : IResultadoCalculoMargemBruta;
  ReturnValue : IResultadoCalculoMargemBruta;
begin
  LResultadoCalculoMargemBruta :=
    TResultadoCalculoMargemBruta.New
      .ValorMargemBruta(10);

  ReturnValue :=
    TResultadoServicosClasseMargemBruta.New
      .ResultadoCalculoMargemBruta(LResultadoCalculoMargemBruta).ResultadoCalculoMargemBruta;

  CheckTrue(ReturnValue.ValorMargemBruta = 10);
end;

procedure TestTResultadoServicosClasseMargemBruta.TestResultadoCalculoMargemParaMarkup;
Var
  LResultadoCalculoMargemParaMarkup: IResultadoCalculoMargemParaMarkup;
  ReturnValue : IResultadoCalculoMargemParaMarkup;
begin
  LResultadoCalculoMargemParaMarkup:=
    TResultadoCalculoMargemParaMarkup.New
      .ValorMarkup(10);

  ReturnValue :=
    TResultadoServicosClasseMargemBruta.New
      .ResultadoCalculoMargemParaMarkup(LResultadoCalculoMargemParaMarkup).ResultadoCalculoMargemParaMarkup;

  CheckTrue(ReturnValue.ValorMarkup = 10);

end;

initialization
  RegisterTest(TestTParametrosServicoMargemBruta.Suite);
  RegisterTest(TestTParametrosCalculoMargemBruta.Suite);
  RegisterTest(TestTResultadoCalculoMargemBruta.Suite);
  RegisterTest(TestTParametrosServicoMargemParaMarkup.Suite);
  RegisterTest(TestTParametrosCalculoMargemParaMarkup.Suite);
  RegisterTest(TestTResultadoCalculoMargemParaMarkup.Suite);
  RegisterTest(TestTResultadoServicosClasseMargemBruta.Suite);
end.

