unit TestOrdemProducaoIndustrial.TCorrecao;

interface

uses
  TestFramework,
  untFuncoes,

  OrdemProducaoIndustrial.TCorrecao;

type
  TestTCorrecao = class(TTestCase)
  strict private
    FCorrecao: TCorrecao;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfRetornaCustoTotal;
  end;

implementation

{ TestTCorrecao }

procedure TestTCorrecao.SetUp;
begin
  FCorrecao := TCorrecao.Create;
end;

procedure TestTCorrecao.TearDown;
begin
  FCorrecao.Free;
  FCorrecao := nil;
end;

procedure TestTCorrecao.TestfRetornaCustoTotal;
var
  fltResultado : double;
begin
  FCorrecao.fltQuantidade := 21.8591;
  FCorrecao.fltCusto := 4.0092;

  fltResultado := FCorrecao.fRetornaCustoTotal;

  CheckTrue(fComparaValoresDecimais(fltResultado, 87.6375));
end;

initialization
  RegisterTest(TestTCorrecao.Suite);

end.
