unit TestFaturamento.Impostos.Tipos.Servicos.Classe.DifalFcp;


interface

uses
  TestFramework, Faturamento.Impostos.Interfaces.Servicos.Classe.DifalFcp,
  Faturamento.Impostos.Tipos.Servicos.Classe.DifalFcp,
  Faturamento.Impostos.Interfaces.Tributacao, Faturamento.Impostos.Tipos.Tributacao,
  Faturamento.Impostos.Interfaces.Fcp, Faturamento.Impostos.Tipos.Fcp;

type

  TestTParametrosClasseDifalFcp = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestParametrosCalculoDifalFcp;
//    procedure TestResultadoCalculoDifalFcp;
  end;

  TestTResuladoClasseDifalFcp = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestParametrosCalculoDifalFcp;
    procedure TestResultadoCalculoDifalFcp;
  end;


implementation

procedure TestTParametrosClasseDifalFcp.SetUp;
begin
end;

procedure TestTParametrosClasseDifalFcp.TearDown;
begin
end;

procedure TestTParametrosClasseDifalFcp.TestParametrosCalculoDifalFcp;
var
  ReturnValue                : IParametrosCalculoDifalFCP;
  LParametrosCalculoDifalFcp : IParametrosCalculoDifalFCP;
begin
  LParametrosCalculoDifalFcp :=
    TParametrosCalculoDifalFcp.New
      .AliquotaFCPDoItem(10)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(true)
      .EnviarIcmsDifalDoRemetenteNaPartilha(false)
      .EnviarIcmsDifalDoDestinoNaPartilha(false)
      .IcmsDeOrigem(10)
      .IcmsDeDestino(10)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(10)
      .BaseDestino(10);


  ReturnValue :=
    TParametrosClasseDifalFcp.New
      .ParametrosCalculoDifalFcp(LParametrosCalculoDifalFcp).ParametrosCalculoDifalFcp;

  // TODO: Validate method results
  CheckTrue((ReturnValue.AliquotaFCPDoItem = 10) And
            (ReturnValue.AliquotaDifalDoItem = 10)And
            (ReturnValue.SimplesNacional= true)And
            (ReturnValue.EnviarIcmsDifalDoRemetenteNaPartilha = false)And
            (ReturnValue.EnviarIcmsDifalDoDestinoNaPartilha = false)And
            (ReturnValue.IcmsDeOrigem = 10)And
            (ReturnValue.IcmsDeDestino = 10)And
            (ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem = 10)And
            (ReturnValue.BaseDestino = 10));


end;

procedure TestTResuladoClasseDifalFcp.SetUp;
begin
  inherited;




end;

procedure TestTResuladoClasseDifalFcp.TearDown;
begin
  inherited;

end;

procedure TestTResuladoClasseDifalFcp.TestParametrosCalculoDifalFcp;
var
  LParametro : IParametrosCalculoDifalFcp;
  ReturnValue: IResultadoClasseDifalFcp;
begin

  LParametro := TParametrosCalculoDifalFcp.New;
  LParametro.AliquotaFCPDoItem(10);
  LParametro.AliquotaDifalDoItem(10);
  LParametro.SimplesNacional(true);
  LParametro.EnviarIcmsDifalDoRemetenteNaPartilha(false);
  LParametro.EnviarIcmsDifalDoDestinoNaPartilha(false);
  LParametro.IcmsDeOrigem(10);
  LParametro.IcmsDeDestino(10);
  LParametro.BaseDeCalculoDaSubstituicaoTributariaDoItem(10);
  LParametro.BaseDestino(10);

  ReturnValue := TResultadoClasseDifalFcp.New.ParametrosCalculoDifalFcp(LParametro);

  // TODO: Validate method results
  CheckTrue((ReturnValue.ParametrosCalculoDifalFcp.AliquotaFCPDoItem = 10) And
            (ReturnValue.ParametrosCalculoDifalFcp.AliquotaDifalDoItem = 10)And
            (ReturnValue.ParametrosCalculoDifalFcp.SimplesNacional = true)And
            (ReturnValue.ParametrosCalculoDifalFcp.EnviarIcmsDifalDoRemetenteNaPartilha = false)And
            (ReturnValue.ParametrosCalculoDifalFcp.EnviarIcmsDifalDoDestinoNaPartilha = false) And
            (ReturnValue.ParametrosCalculoDifalFcp.IcmsDeOrigem = 10) And
            (ReturnValue.ParametrosCalculoDifalFcp.IcmsDeDestino = 10) And
            (ReturnValue.ParametrosCalculoDifalFcp.BaseDeCalculoDaSubstituicaoTributariaDoItem = 10) And
            (ReturnValue.ParametrosCalculoDifalFcp.BaseDestino = 10));

end;

procedure TestTResuladoClasseDifalFcp.TestResultadoCalculoDifalFcp;
var
  ReturnValue                : IResultadoCalculoDifalFcp;
  LResultadoCalculoDifalFcp : IResultadoCalculoDifalFcp;
begin
  LResultadoCalculoDifalFcp :=
    TResultadoCalculoDifalFcp.New
      .AliquotaDifalDoItem(10)
      .IcmsDeOrigem(10)
      .IcmsDeDestino(10)
      .BaseFCP(10)
      .ValorFCP(10);

  ReturnValue :=
    TResultadoClasseDifalFcp.New
      .ResultadoCalculoDifalFcp(LResultadoCalculoDifalFcp)
      .ResultadoCalculoDifalFcp;

  CheckTrue(
    (ReturnValue.AliquotaDifalDoItem = 10) And
    (ReturnValue.IcmsDeOrigem = 10)And
    (ReturnValue.IcmsDeDestino = 10)And
    (ReturnValue.BaseFCP = 10)And
    (ReturnValue.ValorFCP = 10));
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTParametrosClasseDifalFcp.Suite);
  RegisterTest(TestTResuladoClasseDifalFcp.Suite);
end.

