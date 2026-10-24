unit TestOrdemProducaoIndustrial.TEmbalagem;

interface

uses
  TestFramework,
  untFuncoes,
  SysUtils,

  OrdemProducaoIndustrial.TEmbalagem,
  OrdemProducaoIndustrial.Tipos;

type
  TestTEmbalagem = class(TTestCase)
  private
  published
    procedure TestfRetornaCusto;
    procedure TestfRetornaPeso;
    procedure TestfRetornaQuantidadeUtilizada_NaoArredonda_Fracionado;
    procedure TestfRetornaQuantidadeUtilizada_ArredondaAcima_NaoFracionado;
    procedure TestfRetornaQuantidadeUtilizada_ArredondaAbaixo_NaoFracionado;
  end;

implementation

{ TestTEmbalagem }

procedure TestTEmbalagem.TestfRetornaCusto;
var
  fltQuantidadeEnvasada : double;
  fltResultado : double;
  FEmbalagem: TEmbalagem;
begin
  FEmbalagem := TEmbalagem.Create(taNaoArredonda, True);

  FEmbalagem.fltQuantidade := 1.3345;
  FEmbalagem.fltCusto      := 2.3554;
  fltQuantidadeEnvasada := 1.1329;

  fltResultado := FEmbalagem.fRetornaCusto(fltQuantidadeEnvasada);

  CheckTrue(fComparaValoresDecimais(fltResultado, 3.5611));
  FreeAndNil(FEmbalagem);
end;

procedure TestTEmbalagem.TestfRetornaQuantidadeUtilizada_ArredondaAcima_NaoFracionado;
var
  fltQuantidadeEnvasada : double;
  fltResultado : double;
  FEmbalagem: TEmbalagem;
begin
  FEmbalagem := TEmbalagem.Create(taAcima, False);

  FEmbalagem.fltQuantidade := 1.3345;
  fltQuantidadeEnvasada := 1.1329;

  fltResultado := FEmbalagem.fRetornaQuantidadeUtilizada(fltQuantidadeEnvasada);

  CheckTrue(fComparaValoresDecimais(fltResultado, 2));
  FreeAndNil(FEmbalagem);
end;

procedure TestTEmbalagem.TestfRetornaPeso;
var
  fltResultado : double;
  FEmbalagem: TEmbalagem;
begin
  FEmbalagem := TEmbalagem.Create(taNaoArredonda, True);

  FEmbalagem.fltQuantidade := 1.3345;
  FEmbalagem.fltPeso       := 5.1246;

  fltResultado := FEmbalagem.fRetornaPeso;

  CheckTrue(fComparaValoresDecimais(fltResultado, 6.8388));
  FreeAndNil(FEmbalagem);
end;

procedure TestTEmbalagem.TestfRetornaQuantidadeUtilizada_ArredondaAbaixo_NaoFracionado;
var
  fltQuantidadeEnvasada : double;
  fltResultado : double;
  FEmbalagem: TEmbalagem;
begin
  FEmbalagem := TEmbalagem.Create(taAbaixo, False);

  FEmbalagem.fltQuantidade := 1.3345;
  fltQuantidadeEnvasada := 1.1329;

  fltResultado := FEmbalagem.fRetornaQuantidadeUtilizada(fltQuantidadeEnvasada);

  CheckTrue(fComparaValoresDecimais(fltResultado, 1));
  FreeAndNil(FEmbalagem);
end;


procedure TestTEmbalagem.TestfRetornaQuantidadeUtilizada_NaoArredonda_Fracionado;
var
  fltQuantidadeEnvasada : double;
  fltResultado : double;
  FEmbalagem: TEmbalagem;
begin
  FEmbalagem := TEmbalagem.Create(taNaoArredonda, True);

  FEmbalagem.fltQuantidade := 1.3345;
  fltQuantidadeEnvasada := 1.1329;

  fltResultado := FEmbalagem.fRetornaQuantidadeUtilizada(fltQuantidadeEnvasada);

  CheckTrue(fComparaValoresDecimais(fltResultado, 1.5119));
  FreeAndNil(FEmbalagem);

end;

initialization
  RegisterTest(TestTEmbalagem.Suite);

end.
