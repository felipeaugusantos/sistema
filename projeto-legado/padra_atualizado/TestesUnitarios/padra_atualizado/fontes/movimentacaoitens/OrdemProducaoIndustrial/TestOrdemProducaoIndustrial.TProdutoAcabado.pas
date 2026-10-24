unit TestOrdemProducaoIndustrial.TProdutoAcabado;

interface

uses
  TestFramework,

  untFuncoes,
  TestOrdemProducaoIndustrial.Dados.TEmbalagem,
  OrdemProducaoIndustrial.TProdutoAcabado,
  OrdemProducaoIndustrial.Tipos,
  OrdemProducaoIndustrial.TComposicao;

type
  TestTProdutoAcabado = class(TTestCase)
  strict private
    FProdutoAcabado: TProdutoAcabado;

    const
      CUSTO_KILO = 7.9427;
      CUSTO_TOTAL_PRODUCAO = 3500.9427;
      PESO_TOTAL_PRODUCAO = 1000;
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfRetornaPesoUnitario_MedidaUnidadeNull;
    procedure TestfRetornaPesoUnitario_MedidaUnidadeKilo;
    procedure TestfRetornaPesoUnitario_MedidaUnidadeLitro;
    procedure TestfRetornaVolumeUnitario_MedidaUnidadeKilo;
    procedure TestfRetornaVolumeUnitario_MedidaUnidadeLitro;
    procedure TestfRetornaVolumeUnitario_MedidaUnidadeNull;
    procedure TestfRetornaPesoEnvasado;
    procedure TestfRetornaVolumeEnvasado;
    procedure TestfRetornaPesoProduzido;
    procedure TestfRetornaVolumeProduzido;
    procedure TestfRetornaCustoUnitario;
    procedure TestfRetornaCustoUnitarioFormula;
    procedure TestfRetornaCustoEnvasado;
    procedure TestfRetornaCustoEnvasadoFormula;
    procedure TestfRetornaCustoRelativoProducao;
    procedure TestfRetornaCustoComposicaoEnvasado;
    procedure TestfRetornaCustoUnitarioComposicao;
  end;

implementation

{ TestTProdutoAcabado }

procedure TestTProdutoAcabado.SetUp;
begin
  FProdutoAcabado := TProdutoAcabado.Create;
  FProdutoAcabado.strCodigo := '00001';
  FProdutoAcabado.strDescricao := 'TINTA CINZA 2,7';
  FProdutoAcabado.fltPesoReal := 1.34;
  FProdutoAcabado.fltPesoLitro := 34.678;
  FProdutoAcabado.fltQuantidadeProduzida := 25.561;
  FProdutoAcabado.fltQuantidadeEnvasada := 12.346;

  pAlimentaListaEmbalagens3600MiliLitros(taNaoArredonda, FProdutoAcabado.objComposicao.lstEmbalagens);
end;

procedure TestTProdutoAcabado.TearDown;
begin
  FProdutoAcabado.Free;
  FProdutoAcabado := nil;
end;

procedure TestTProdutoAcabado.TestfRetornaCustoUnitario;
var
  fltResultado : double;
begin

  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaCustoUnitario(CUSTO_KILO);
  CheckTrue(fComparaValoresDecimais(fltResultado, 282.1566));

end;

procedure TestTProdutoAcabado.TestfRetornaCustoComposicaoEnvasado;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaCustoComposicaoEnvasado;
  CheckTrue(fComparaValoresDecimais(fltResultado, 82.9607));
end;

procedure TestTProdutoAcabado.TestfRetornaCustoUnitarioComposicao;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaCustoUnitarioComposicao;
  CheckTrue(fComparaValoresDecimais(fltResultado, 6.7196));
end;

procedure TestTProdutoAcabado.TestfRetornaCustoEnvasado;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaCustoEnvasado(CUSTO_KILO);
  CheckTrue(fComparaValoresDecimais(fltResultado, 3483.5054));
end;

procedure TestTProdutoAcabado.TestfRetornaCustoEnvasadoFormula;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaCustoEnvasadoFormula(CUSTO_KILO);
  CheckTrue(fComparaValoresDecimais(fltResultado, 3400.5452));
end;

procedure TestTProdutoAcabado.TestfRetornaCustoRelativoProducao;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaCustoRelativoProducao(CUSTO_TOTAL_PRODUCAO, PESO_TOTAL_PRODUCAO);
  CheckTrue(fComparaValoresDecimais(fltResultado, 3103.2510));
end;

procedure TestTProdutoAcabado.TestfRetornaCustoUnitarioFormula;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaCustoUnitario(CUSTO_KILO);
  CheckTrue(fComparaValoresDecimais(fltResultado, 282.1566));
end;

procedure TestTProdutoAcabado.TestfRetornaPesoEnvasado;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaPesoEnvasado;
  CheckTrue(fComparaValoresDecimais(fltResultado, 428.1346));
end;

procedure TestTProdutoAcabado.TestfRetornaVolumeEnvasado;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaVolumeEnvasado;
  CheckTrue(fComparaValoresDecimais(fltResultado, 319.5034));
end;

procedure TestTProdutoAcabado.TestfRetornaPesoProduzido;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaPesoProduzido;
  CheckTrue(fComparaValoresDecimais(fltResultado, 886.4044));
end;

procedure TestTProdutoAcabado.TestfRetornaVolumeProduzido;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaVolumeProduzido;
  CheckTrue(fComparaValoresDecimais(fltResultado, 661.4957));
end;

procedure TestTProdutoAcabado.TestfRetornaPesoUnitario_MedidaUnidadeNull;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmNull;
  fltResultado := FProdutoAcabado.fRetornaPesoUnitario;
  CheckTrue(fComparaValoresDecimais(fltResultado, 34.678));
end;

procedure TestTProdutoAcabado.TestfRetornaPesoUnitario_MedidaUnidadeKilo;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaPesoUnitario;
  CheckTrue(fComparaValoresDecimais(fltResultado, 34.678));
end;

procedure TestTProdutoAcabado.TestfRetornaPesoUnitario_MedidaUnidadeLitro;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmLitro;
  fltResultado := FProdutoAcabado.fRetornaPesoUnitario;
  CheckTrue(fComparaValoresDecimais(fltResultado, 46.4685));
end;


procedure TestTProdutoAcabado.TestfRetornaVolumeUnitario_MedidaUnidadeNull;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmNull;
  fltResultado := FProdutoAcabado.fRetornaVolumeUnitario;
  CheckTrue(fComparaValoresDecimais(fltResultado, 25.8791));
end;

procedure TestTProdutoAcabado.TestfRetornaVolumeUnitario_MedidaUnidadeKilo;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmKilo;
  fltResultado := FProdutoAcabado.fRetornaVolumeUnitario;
  CheckTrue(fComparaValoresDecimais(fltResultado, 25.8791));
end;

procedure TestTProdutoAcabado.TestfRetornaVolumeUnitario_MedidaUnidadeLitro;
var
  fltResultado : double;
begin
  FProdutoAcabado.enuMedidaUnidade := tmLitro;
  fltResultado := FProdutoAcabado.fRetornaVolumeUnitario;
  CheckTrue(fComparaValoresDecimais(fltResultado, 34.678));
end;

initialization
  RegisterTest(TestTProdutoAcabado.Suite);

end.
