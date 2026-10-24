unit TestOrdemProducaoIndustrial.TComposicao;

interface

uses
  TestFramework,
  untFuncoes,

  OrdemProducaoIndustrial.TComposicao,
  OrdemProducaoIndustrial.Tipos,
  OrdemProducaoIndustrial.TEmbalagem,
  TestOrdemProducaoIndustrial.Dados.TEmbalagem;

type
  TestTComposicao = class(TTestCase)
  strict private
    FComposicao: TComposicao;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfRetornaCustoTotal;
    procedure TestfRetornaCusto;
    procedure TestfRetornaPeso;
  end;

implementation

{ TestTComposicao }

procedure TestTComposicao.SetUp;
begin
  FComposicao := TComposicao.Create;
  FComposicao.strCodigo := '00001';
  FComposicao.strDescricao := 'EMBALAGEM 3,6 TINTAS BRANCO';
end;

procedure TestTComposicao.TearDown;
begin
  FComposicao.Free;
  FComposicao := nil;
end;

procedure TestTComposicao.TestfRetornaCusto;
var
  fltQuantidadeEnvasada : double;
  fltResultado : double;
begin
  FComposicao.lstEmbalagens.Clear;
  pAlimentaListaEmbalagens3600MiliLitros(taNaoArredonda, FComposicao.lstEmbalagens);
  fltQuantidadeEnvasada := 17;

  fltResultado := FComposicao.fRetornaCusto(fltQuantidadeEnvasada);

  CheckTrue(fComparaValoresDecimais(fltResultado, 6.7197));
end;

procedure TestTComposicao.TestfRetornaCustoTotal;
var
  fltQuantidadeEnvasada : double;
  fltResultado : double;
begin
  FComposicao.lstEmbalagens.Clear;
  pAlimentaListaEmbalagens3600MiliLitros(taNaoArredonda, FComposicao.lstEmbalagens);
  fltQuantidadeEnvasada := 17;

  fltResultado := FComposicao.fRetornaCustoTotal(fltQuantidadeEnvasada);

  CheckTrue(fComparaValoresDecimais(fltResultado, 114.2346));
end;

procedure TestTComposicao.TestfRetornaPeso;
var
  fltResultado : double;
begin
  FComposicao.lstEmbalagens.Clear;
  pAlimentaListaEmbalagens3600MiliLitros(taNaoArredonda, FComposicao.lstEmbalagens);

  fltResultado := FComposicao.fRetornaPeso;

  CheckTrue(fComparaValoresDecimais(fltResultado, 7.773));
end;

initialization
  RegisterTest(TestTComposicao.Suite);

end.
