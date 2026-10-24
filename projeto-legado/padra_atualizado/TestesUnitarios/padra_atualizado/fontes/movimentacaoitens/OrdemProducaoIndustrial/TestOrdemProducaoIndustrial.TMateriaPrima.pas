unit TestOrdemProducaoIndustrial.TMateriaPrima;

interface

uses
  TestFramework,
  untFuncoes,

  OrdemProducaoIndustrial.TMateriaPrima;

type
  TestTMateriaPrima = class(TTestCase)
  strict private
    FMateriaPrima: TMateriaPrima;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfRetornaQuantidadeUtilizadaKilo;
    procedure TestfRetornaCustoProduzidoKilo;
  end;

implementation

{ TestTMateriaPrima }

procedure TestTMateriaPrima.SetUp;
begin
  FMateriaPrima := TMateriaPrima.Create;
end;

procedure TestTMateriaPrima.TearDown;
begin
  FMateriaPrima.Free;
  FMateriaPrima := nil;
end;


procedure TestTMateriaPrima.TestfRetornaQuantidadeUtilizadaKilo;
var
  fltPesoTotalProduzido : double;
  fltResultado : double;
begin
  FMateriaPrima.fltPercentualFormula := 63.5591;
  fltPesoTotalProduzido := 10.5164;

  fltResultado := FMateriaPrima.fRetornaQuantidadeUtilizadaKilo(fltPesoTotalProduzido);

  CheckTrue(fComparaValoresDecimais(fltResultado, 6.6841));
end;

procedure TestTMateriaPrima.TestfRetornaCustoProduzidoKilo;
var
  fltPesoTotalProduzido : double;
  fltResultado : double;
begin
  FMateriaPrima.fltPercentualFormula := 13.6312;
  FMateriaPrima.fltCusto := 0.9199;
  fltPesoTotalProduzido := 50.7046;

  fltResultado := FMateriaPrima.fRetornaCustoProduzidoKilo(fltPesoTotalProduzido);

  CheckTrue(fComparaValoresDecimais(fltResultado, 6.358));
end;

initialization
  RegisterTest(TestTMateriaPrima.Suite);

end.
