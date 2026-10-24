unit TestOrdemProducaoIndustrial.TFormula;

interface

uses
  TestFramework,
  untFuncoes,

  OrdemProducaoIndustrial.TFormula,
  OrdemProducaoIndustrial.Tipos,
  OrdemProducaoIndustrial.TMateriaPrima,
  TestOrdemProducaoIndustrial.Dados.TMateriaPrima;

type
  TestTFormula = class(TTestCase)
  strict private
    FFormula: TFormula;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfRetornaCustoProducaoTotalKilo;
  end;

implementation

{ TestTFormula }

procedure TestTFormula.SetUp;
begin
  FFormula := TFormula.Create;

  FFormula.objProdutoGranel.strCodigo := '00001';
  FFormula.objProdutoGranel.strDescricao := 'TINTA PU';
end;

procedure TestTFormula.TearDown;
begin
  FFormula.Free;
  FFormula := nil;
end;

procedure TestTFormula.TestfRetornaCustoProducaoTotalKilo;
var
  fltPesoTotalProduzido : double;
  fltResultado : double;
begin
  FFormula.lstMateriasPrimas.Clear;
  pAlimentaListaMateriasPrimas(FFormula.lstMateriasPrimas);
  fltPesoTotalProduzido := 44.496;

  fltResultado := FFormula.fRetornaCustoProducaoTotalKilo(fltPesoTotalProduzido);

  CheckTrue(fComparaValoresDecimais(fltResultado, 377.7633));
end;

initialization
  RegisterTest(TestTFormula.Suite);

end.
