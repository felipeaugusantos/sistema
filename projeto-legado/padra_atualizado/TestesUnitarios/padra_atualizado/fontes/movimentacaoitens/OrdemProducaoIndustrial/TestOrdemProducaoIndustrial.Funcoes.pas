unit TestOrdemProducaoIndustrial.Funcoes;

interface

uses
  TestFramework,
  SysUtils,

  untFuncoes,
  OrdemProducaoIndustrial.Funcoes;

type
  TestFuncoes = class(TTestCase)
  published
    procedure TestfRetornaValorArredondado;
    procedure TestfConverteKiloParaLitro;
    procedure TestfConverteKiloParaLitro_PesoRealZero;
    procedure TestfConverteLitroParaKilo;
    procedure TestfConverteLitroParaKilo_PesoRealZero;
    procedure TestfRetornaSugestaoMaximaProducao;
    procedure TestfRetornaSugestaoMaximaProducao_RetornaZero;
  end;

implementation

{ TestFuncoes }

procedure TestFuncoes.TestfConverteKiloParaLitro;
var
  fltPesoReal  : double;
  fltKilo      : double;
  fltResultado : double;
begin
  fltPesoReal := 1.35;
  fltKilo     := 7.44;

  fltResultado := fConverteKiloParaLitro(fltPesoReal, fltKilo);

  CheckTrue(fComparaValoresDecimais(fltResultado, 5.5111));
end;

procedure TestFuncoes.TestfConverteKiloParaLitro_PesoRealZero;
var
  fltPesoReal  : double;
  fltKilo      : double;
  strMensagem  : String;
begin
  fltPesoReal := 0;
  fltKilo     := 7.44;

  try
    fConverteKiloParaLitro(fltPesoReal, fltKilo);
  except
    On E: Exception do
      strMensagem := E.Message;
  end;

  CheckTrue(strMensagem = 'O peso real deve ser maior que zero!');
end;

procedure TestFuncoes.TestfConverteLitroParaKilo;
var
  fltPesoReal  : double;
  fltLitro     : double;
  fltResultado : double;
begin
  fltPesoReal := 1.35;
  fltLitro    := 7.44;

  fltResultado := fConverteLitroParaKilo(fltPesoReal, fltLitro);

  CheckTrue(fComparaValoresDecimais(fltResultado, 10.044));
end;

procedure TestFuncoes.TestfConverteLitroParaKilo_PesoRealZero;
var
  fltPesoReal  : double;
  fltLitro     : double;
  strMensagem  : String;
begin
  fltPesoReal := 0;
  fltLitro    := 7.44;

  try
    fConverteLitroParaKilo(fltPesoReal, fltLitro);
  except
    On E: Exception do
      strMensagem := E.Message;
  end;

  CheckTrue(strMensagem = 'O peso real deve ser maior que zero!');
end;

procedure TestFuncoes.TestfRetornaSugestaoMaximaProducao;
var
  fltPesoTotalDisponivel,
  fltPesoUnitario,
  fltResultado: real;
begin
  fltPesoTotalDisponivel:= 200.00;
  fltPesoUnitario       := 1.00;
  fltResultado:= fRetornaSugestaoMaximaProducao(fltPesoTotalDisponivel, fltPesoUnitario);
  CheckEquals(fltResultado, 200.00);
end;

procedure TestFuncoes.TestfRetornaSugestaoMaximaProducao_RetornaZero;
var
  fltPesoTotalDisponivel,
  fltPesoUnitario,
  fltResultado: real;
begin
  fltPesoTotalDisponivel:= 0;
  fltPesoUnitario       := 1.00;
  fltResultado:= fRetornaSugestaoMaximaProducao(fltPesoTotalDisponivel, fltPesoUnitario);
  CheckEquals(fltResultado, 0);
end;

procedure TestFuncoes.TestfRetornaValorArredondado;
var
  fltValor     : double;
  fltResultado : double;
begin
  fltValor := 3.512354;
  fltResultado := fRetornaValorArredondado(fltValor);
  CheckTrue(fComparaValoresDecimais(fltResultado, 3.5124));
end;

initialization
  RegisterTest(TestFuncoes.Suite);

end.
