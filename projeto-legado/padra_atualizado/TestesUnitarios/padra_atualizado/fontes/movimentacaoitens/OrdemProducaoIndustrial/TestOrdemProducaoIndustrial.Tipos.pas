unit TestOrdemProducaoIndustrial.Tipos;

interface

uses
  TestFramework,
  SysUtils,

  untFuncoes,
  OrdemProducaoIndustrial.Tipos;

type
  TestTipos = class(TTestCase)
  published
    procedure TestfStrToTipoMedidaUnidade_Null;
    procedure TestfStrToTipoMedidaUnidade_Kilo;
    procedure TestfStrToTipoMedidaUnidade_Litro;
    procedure TestfTipoMedidaUnidadeToStr_Null;
    procedure TestfTipoMedidaUnidadeToStr_Kilo;
    procedure TestfTipoMedidaUnidadeToStr_Litro;
    procedure TestfStrToTipoArredondamentoComposicao_NaoArredonda;
    procedure TestfStrToTipoArredondamentoComposicao_ArredondaAbaixo;
    procedure TestfStrToTipoArredondamentoComposicao_ArredondaAcima;
    procedure TestfTipoArredondamentoComposicaoToStr_NaoArredonda;
    procedure TestfTipoArredondamentoComposicaoToStr_ArredondaAbaixo;
    procedure TestfTipoArredondamentoComposicaoToStr_ArredondaAcima;
  end;

implementation

{ TestTipos }

procedure TestTipos.TestfStrToTipoArredondamentoComposicao_NaoArredonda;
var
  enuResultado : TTipoArredondamentoComposicao;
begin
  enuResultado := fStrToTipoArredondamentoComposicao('?');
  CheckTrue(enuResultado = taNaoArredonda);
end;

procedure TestTipos.TestfStrToTipoArredondamentoComposicao_ArredondaAcima;
var
  enuResultado : TTipoArredondamentoComposicao;
begin
  enuResultado := fStrToTipoArredondamentoComposicao('+');
  CheckTrue(enuResultado = taAcima);
end;

procedure TestTipos.TestfStrToTipoArredondamentoComposicao_ArredondaAbaixo;
var
  enuResultado : TTipoArredondamentoComposicao;
begin
  enuResultado := fStrToTipoArredondamentoComposicao('-');
  CheckTrue(enuResultado = taAbaixo);
end;

procedure TestTipos.TestfStrToTipoMedidaUnidade_Null;
var
  enuResultado : TTipoMedidaUnidade;
begin
  enuResultado := fStrToTipoMedidaUnidade('');
  CheckTrue(enuResultado =  tmNull);
end;

procedure TestTipos.TestfStrToTipoMedidaUnidade_Kilo;
var
  enuResultado : TTipoMedidaUnidade;
begin
  enuResultado := fStrToTipoMedidaUnidade('K');
  CheckTrue(enuResultado =  tmKilo);
end;

procedure TestTipos.TestfStrToTipoMedidaUnidade_Litro;
var
  enuResultado : TTipoMedidaUnidade;
begin
  enuResultado := fStrToTipoMedidaUnidade('L');
  CheckTrue(enuResultado =  tmLitro);
end;

procedure TestTipos.TestfTipoArredondamentoComposicaoToStr_NaoArredonda;
var
  strResultado : String;
begin
  strResultado := fTipoArredondamentoComposicaoToStr(taNaoArredonda);
  CheckTrue(strResultado = '?');
end;

procedure TestTipos.TestfTipoArredondamentoComposicaoToStr_ArredondaAcima;
var
  strResultado : String;
begin
  strResultado := fTipoArredondamentoComposicaoToStr(taAcima);
  CheckTrue(strResultado = '+');
end;

procedure TestTipos.TestfTipoArredondamentoComposicaoToStr_ArredondaAbaixo;
var
  strResultado : String;
begin
  strResultado := fTipoArredondamentoComposicaoToStr(taAbaixo);
  CheckTrue(strResultado = '-');
end;

procedure TestTipos.TestfTipoMedidaUnidadeToStr_Null;
var
  strResultado : String;
begin
  strResultado := fTipoMedidaUnidadeToStr(tmNull);
  CheckTrue(strResultado = '');
end;

procedure TestTipos.TestfTipoMedidaUnidadeToStr_Kilo;
var
  strResultado : String;
begin
  strResultado := fTipoMedidaUnidadeToStr(tmKilo);
  CheckTrue(strResultado = 'K');
end;

procedure TestTipos.TestfTipoMedidaUnidadeToStr_Litro;
var
  strResultado : String;
begin
  strResultado := fTipoMedidaUnidadeToStr(tmLitro);
  CheckTrue(strResultado = 'L');
end;

initialization
  RegisterTest(TestTipos.Suite);

end.
