unit TestCalculoClass;

interface

uses
  TestFramework, untCalculoClass;

type
  TestTCalculo = class(TTestCase)
  strict private
    FCalculo: TCalculo;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSomaValoresInteiros;
    procedure TestSomaValoresComCasasDecimais;
    procedure TestSomaValoresNegativos;
    procedure TestSomaValoresZero;
    procedure TestDivisaoNormal;
    procedure TestDivisaoZero;
  end;

implementation

procedure TestTCalculo.SetUp;
begin
  FCalculo := TCalculo.Create;
end;

procedure TestTCalculo.TearDown;
begin
  FCalculo.Free;
  FCalculo := nil;
end;

procedure TestTCalculo.TestDivisaoNormal;
var
  nValor1: Double;
  nValor2: Double;
  nResultado: Double;
begin
  nValor1 := 500;
  nValor2 := 10;
  nResultado := FCalculo.Divisao(nValor1, nValor2);
  CheckTrue(nResultado = 50);
end;

procedure TestTCalculo.TestDivisaoZero;
var
  nValor1: Double;
  nValor2: Double;
  nResultado: Double;
begin
  nValor1 := 500;
  nValor2 := 0;
  //nValor2 := 1;
  nResultado := FCalculo.Divisao(nValor1, nValor2);
  CheckTrue(nResultado = 0);
  //CheckTrue(nResultado = 500);
end;

procedure TestTCalculo.TestSomaValoresComCasasDecimais;
var
  nValor1: Double;
  nValor2: Double;
  nResultado: Double;
begin
  nValor1 := 10.5;
  nValor2 := 20.5;
  nResultado := FCalculo.Soma(nValor1, nValor2);
  CheckTrue(nResultado = 31);
end;

procedure TestTCalculo.TestSomaValoresInteiros;
var
  nValor1: Double;
  nValor2: Double;
  nResultado: Double;
begin
  nValor1 := 10;
  nValor2 := 20;
  nResultado := FCalculo.Soma(nValor1, nValor2);
  CheckTrue(nResultado = 30);
end;

procedure TestTCalculo.TestSomaValoresNegativos;
var
  nValor1: Double;
  nValor2: Double;
  nResultado: Double;
begin
  nValor1 := -10;
  nValor2 := -20;
  nResultado := FCalculo.Soma(nValor1, nValor2);
  CheckTrue(nResultado = -30);
end;

procedure TestTCalculo.TestSomaValoresZero;
var
  nValor1: Double;
  nValor2: Double;
  nResultado: Double;
begin
  nValor1 := 0;
  nValor2 := 0;
  nResultado := FCalculo.Soma(nValor1, nValor2);
  CheckTrue(nResultado = 0);
end;

initialization
  RegisterTest(TestTCalculo.Suite);
end.

