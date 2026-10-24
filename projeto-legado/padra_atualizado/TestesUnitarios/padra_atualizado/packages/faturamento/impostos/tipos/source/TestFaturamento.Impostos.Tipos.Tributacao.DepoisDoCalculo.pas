unit TestFaturamento.Impostos.Tipos.Tributacao.DepoisDoCalculo;

interface

uses
  TestFramework, Shared.Functions.Types,
  Faturamento.Impostos.Tipos.Tributacao.DepoisDoCalculo,
  Faturamento.Impostos.Interfaces.Tributacao.DepoisDoCalculo;

type
  TestTParametrosRegrasTributacaoDepoisDoCalculo = class(TTestCase)
  strict private
    FParametrosRegrasTributacaoDepoisDoCalculo: TParametrosRegrasTributacaoDepoisDoCalculo;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestReducaoRICMPR;
    procedure TestPercentualDaBaseDaSubstituicaoTributariaDoItem;
    procedure TestAliquotaDaSubstituicaoTributariaDoItem;
  end;

  TestTResultadoRegraTributacaoDepoisDoCalculo = class(TTestCase)
  strict private
    FResultadoRegraTributacaoDepoisDoCalculo: TResultadoRegrasTributacaoDepoisDoCalculo;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPercentualDaBaseDaSubstituicaoTributariaDoItem;
    procedure TestAliquotaDaSubstituicaoTributariaDoItem;
  end;

implementation
{ TestTParametrosRegrasTributacaoDepoisDoCalculo }

procedure TestTParametrosRegrasTributacaoDepoisDoCalculo.SetUp;
begin
  inherited;
  FParametrosRegrasTributacaoDepoisDoCalculo := TParametrosRegrasTributacaoDepoisDoCalculo.Create;
end;

procedure TestTParametrosRegrasTributacaoDepoisDoCalculo.TearDown;
begin
  inherited;
  FParametrosRegrasTributacaoDepoisDoCalculo := nil;
end;

procedure TestTParametrosRegrasTributacaoDepoisDoCalculo.TestAliquotaDaSubstituicaoTributariaDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosRegrasTributacaoDepoisDoCalculo.AliquotaDaSubstituicaoTributariaDoItem(77).AliquotaDaSubstituicaoTributariaDoItem;
  CheckTrue(ReturnValue = 77);
end;

procedure TestTParametrosRegrasTributacaoDepoisDoCalculo.TestPercentualDaBaseDaSubstituicaoTributariaDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosRegrasTributacaoDepoisDoCalculo.PercentualDaBaseDaSubstituicaoTributariaDoItem(10).PercentualDaBaseDaSubstituicaoTributariaDoItem;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosRegrasTributacaoDepoisDoCalculo.TestReducaoRICMPR;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacaoDepoisDoCalculo.ReducaoRICMPR(true).ReducaoRICMPR;
  CheckTrue(ReturnValue);
end;

{ TestTResultadoRegraTributacaoDepoisDoCalculo }

procedure TestTResultadoRegraTributacaoDepoisDoCalculo.SetUp;
begin
  inherited;
  FResultadoRegraTributacaoDepoisDoCalculo := TResultadoRegrasTributacaoDepoisDoCalculo.Create;
end;

procedure TestTResultadoRegraTributacaoDepoisDoCalculo.TearDown;
begin
  inherited;
  FResultadoRegraTributacaoDepoisDoCalculo := nil;
end;

procedure TestTResultadoRegraTributacaoDepoisDoCalculo.TestAliquotaDaSubstituicaoTributariaDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FResultadoRegraTributacaoDepoisDoCalculo.AliquotaDaSubstituicaoTributariaDoItem(21).AliquotaDaSubstituicaoTributariaDoItem;
  CheckTrue(ReturnValue = 21);
end;

procedure TestTResultadoRegraTributacaoDepoisDoCalculo.TestPercentualDaBaseDaSubstituicaoTributariaDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FResultadoRegraTributacaoDepoisDoCalculo.PercentualDaBaseDaSubstituicaoTributariaDoItem(10).PercentualDaBaseDaSubstituicaoTributariaDoItem;
  CheckTrue(ReturnValue = 10);
end;

initialization
  RegisterTest(TestTParametrosRegrasTributacaoDepoisDoCalculo.Suite);
  RegisterTest(TestTResultadoRegraTributacaoDepoisDoCalculo.Suite);
end.

