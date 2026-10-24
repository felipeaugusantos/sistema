unit TestOrdemProducaoIndustrial.TOrdemProducao;

interface

uses
  TestFramework,
  SysUtils,

  untFuncoes,
  OrdemProducaoIndustrial.TOrdemProducao,
  OrdemProducaoIndustrial.TProdutoAcabado,
  OrdemProducaoIndustrial.Tipos,
  TestOrdemProducaoIndustrial.Dados.TMateriaPrima,
  TestOrdemProducaoIndustrial.Dados.TCorrecao,
  TestOrdemProducaoIndustrial.Dados.TEmbalagem;

type
  TestTOrdemProducao = class(TTestCase)
  strict private
    function fGetTOrdemProducao(enuTipoArredondamentoComposicao : TTipoArredondamentoComposicao) : TOrdemProducao;
  private
  published
    procedure TestfRetornaPesoEnvasadoTotal;
    procedure TestfRetornaVolumeEnvasadoTotal;
    procedure TestfRetornaPesoProduzidoTotal;
    procedure TestfRetornaVolumeProduzidoTotal;
    procedure TestfRetornaCustoKilo;
    procedure TestfRetornaCustoKilo_EnvasadoZero;
    procedure TestfRetornaCustoLitro;
    procedure TestfRetornaCustoCorrecoesTotal;
    procedure TestfRetornaCustoTotalProducao;
    procedure TestpSetaBaixaPerfeitaProdutosAcabados;
  end;

implementation

{ TestTOrdemProducao }

function TestTOrdemProducao.fGetTOrdemProducao(enuTipoArredondamentoComposicao : TTipoArredondamentoComposicao): TOrdemProducao;
var
  objProdutoAcabado : TProdutoAcabado;
begin

  Result := TOrdemProducao.Create;
  Result.objFormula.objProdutoGranel.strCodigo := '001';
  Result.objFormula.objProdutoGranel.strDescricao := 'TINTA PU';
  Result.objFormula.fltPesoReal := 1.0300;
  pAlimentaListaMateriasPrimas(Result.objFormula.lstMateriasPrimas);
  pAlimentaListaCorrecoes(Result.lstCorrecoes);

  objProdutoAcabado := TProdutoAcabado.Create;
  objProdutoAcabado.strCodigo := '00001';
  objProdutoAcabado.strDescricao := 'TINTA PU CINZA 2,7 LT';
  objProdutoAcabado.enuMedidaUnidade := tmLitro;
  objProdutoAcabado.fltPesoLitro := 2.7;
  objProdutoAcabado.fltPesoReal := Result.objFormula.fltPesoReal;
  objProdutoAcabado.fltQuantidadeProduzida := 16;
  objProdutoAcabado.fltQuantidadeEnvasada := 17;
  pAlimentaListaEmbalagens3600MiliLitros(enuTipoArredondamentoComposicao, objProdutoAcabado.objComposicao.lstEmbalagens);
  Result.lstProdutosAcabados.Add(objProdutoAcabado);

  objProdutoAcabado := TProdutoAcabado.Create;
  objProdutoAcabado.strCodigo := '00001';
  objProdutoAcabado.strDescricao := 'TINTA PU CINZA 600 ML';
  objProdutoAcabado.enuMedidaUnidade := tmLitro;
  objProdutoAcabado.fltPesoLitro := 0.6;
  objProdutoAcabado.fltPesoReal := Result.objFormula.fltPesoReal;
  objProdutoAcabado.fltQuantidadeProduzida := 0;
  objProdutoAcabado.fltQuantidadeEnvasada := 4;
  pAlimentaListaEmbalagens900MiliLitros(enuTipoArredondamentoComposicao, objProdutoAcabado.objComposicao.lstEmbalagens);
  Result.lstProdutosAcabados.Add(objProdutoAcabado);

end;

procedure TestTOrdemProducao.TestfRetornaCustoTotalProducao;
var
  fltResultado : double;
  objOrdemProducao: TOrdemProducao;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  fltResultado := objOrdemProducao.fRetornaCustoTotalProducao;
  FreeAndNil(objOrdemProducao);
  CheckTrue(fComparaValoresDecimais(fltResultado,395.1429));
end;

procedure TestTOrdemProducao.TestfRetornaCustoCorrecoesTotal;
var
  fltResultado : double;
  objOrdemProducao: TOrdemProducao;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  fltResultado := objOrdemProducao.fRetornaCustoCorrecoesTotal;
  FreeAndNil(objOrdemProducao);
  CheckTrue(fComparaValoresDecimais(fltResultado,17.3796));
end;

procedure TestTOrdemProducao.TestfRetornaCustoKilo;
var
  fltResultado : double;
  objOrdemProducao: TOrdemProducao;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  fltResultado := objOrdemProducao.fRetornaCustoKilo;
  FreeAndNil(objOrdemProducao);
  CheckTrue(fComparaValoresDecimais(fltResultado,7.9427));
end;

procedure TestTOrdemProducao.TestfRetornaCustoLitro;
var
  fltResultado : double;
  objOrdemProducao: TOrdemProducao;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  fltResultado := objOrdemProducao.fRetornaCustoLitro;
  FreeAndNil(objOrdemProducao);
  CheckTrue(fComparaValoresDecimais(fltResultado,8.1810));
end;

procedure TestTOrdemProducao.TestfRetornaCustoKilo_EnvasadoZero;
var
  objProdutoAcabado : TProdutoAcabado;
  fltResultado : double;
  objOrdemProducao: TOrdemProducao;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  for objProdutoAcabado in objOrdemProducao.lstProdutosAcabados do
    objProdutoAcabado.fltQuantidadeEnvasada := 0;

  fltResultado := objOrdemProducao.fRetornaCustoKilo;
  FreeAndNil(objOrdemProducao);
  CheckTrue(fComparaValoresDecimais(fltResultado,0));
end;

procedure TestTOrdemProducao.TestfRetornaPesoEnvasadoTotal;
var
  fltResultado : double;
  objOrdemProducao: TOrdemProducao;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  fltResultado := objOrdemProducao.fRetornaPesoEnvasadoTotal;
  FreeAndNil(objOrdemProducao);
  CheckTrue(fComparaValoresDecimais(fltResultado,49.749));
end;

procedure TestTOrdemProducao.TestfRetornaVolumeEnvasadoTotal;
var
  fltResultado : double;
  objOrdemProducao: TOrdemProducao;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  fltResultado := objOrdemProducao.fRetornaVolumeEnvasadoTotal;
  FreeAndNil(objOrdemProducao);
  CheckTrue(fComparaValoresDecimais(fltResultado,48.3));
end;

procedure TestTOrdemProducao.TestfRetornaVolumeProduzidoTotal;
var
  fltResultado : double;
  objOrdemProducao: TOrdemProducao;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  fltResultado := objOrdemProducao.fRetornaVolumeProduzidoTotal;
  FreeAndNil(objOrdemProducao);
  CheckTrue(fComparaValoresDecimais(fltResultado,43.2));
end;

procedure TestTOrdemProducao.TestfRetornaPesoProduzidoTotal;
var
  fltResultado : double;
  objOrdemProducao: TOrdemProducao;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  fltResultado := objOrdemProducao.fRetornaPesoProduzidoTotal;
  FreeAndNil(objOrdemProducao);
  CheckTrue(fComparaValoresDecimais(fltResultado,44.496));
end;

procedure TestTOrdemProducao.TestpSetaBaixaPerfeitaProdutosAcabados;
var
  objProdutoAcabado : TProdutoAcabado;
  objOrdemProducao: TOrdemProducao;
  blnResultado : boolean;
begin
  objOrdemProducao := fGetTOrdemProducao(taAcima);
  objOrdemProducao.pSetaBaixaPerfeitaProdutosAcabados;

  blnResultado := True;

  for objProdutoAcabado in objOrdemProducao.lstProdutosAcabados do
    blnResultado := blnResultado and (objProdutoAcabado.fltQuantidadeProduzida = 1)  and (objProdutoAcabado.fltQuantidadeEnvasada = 1);

  FreeAndNil(objOrdemProducao);

  CheckTrue(blnResultado);
end;

initialization
  RegisterTest(TestTOrdemProducao.Suite);

end.
