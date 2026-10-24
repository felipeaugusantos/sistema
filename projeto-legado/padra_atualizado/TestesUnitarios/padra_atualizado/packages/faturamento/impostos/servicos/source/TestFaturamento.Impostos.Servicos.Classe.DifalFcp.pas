unit TestFaturamento.Impostos.Servicos.Classe.DifalFcp;

interface

uses
  TestFramework, Faturamento.Impostos.Interfaces.Servicos.Classe.DifalFcp,
  Faturamento.Impostos.Servicos.Classe.DifalFcp,
  Faturamento.Impostos.Tipos.Servicos.Classe.DifalFcp,
  Faturamento.Impostos.Interfaces.Fcp, Faturamento.Impostos.Calculos.Fcp,
  Shared.Functions.Types, Faturamento.Impostos.Tipos.Fcp;

type

  TestTServicosClasseDifalFcp = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalcularDifalFcp;
  end;

implementation

procedure TestTServicosClasseDifalFcp.SetUp;
begin
end;

procedure TestTServicosClasseDifalFcp.TearDown;
begin
end;

procedure TestTServicosClasseDifalFcp.TestCalcularDifalFcp;
var
  ReturnValue              : IResultadoClasseDifalFcp;
  AParametrosDifalFCP      : IParametrosCalculoDifalFCP;
  AParametrosClasseDifalFcp: IParametrosClasseDifalFcp;
begin
   AParametrosDifalFCP :=
    TParametrosCalculoDifalFcp.New
      .AliquotaFCPDoItem(10)
      .AliquotaDifalDoItem(10)
      .SimplesNacional(false)
      .EnviarIcmsDifalDoRemetenteNaPartilha(true)
      .EnviarIcmsDifalDoDestinoNaPartilha(true)
      .IcmsDeOrigem(10)
      .IcmsDeDestino(10)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(10)
      .BaseDestino(10);

  AParametrosClasseDifalFcp := TParametrosClasseDifalFcp.New.ParametrosCalculoDifalFcp(AParametrosDifalFCP);

  ReturnValue :=
    TServicosClasseDifalFcp.New(AParametrosClasseDifalFcp).CalcularDifalFcp;

  CheckTrue((ReturnValue.ResultadoCalculoDifalFcp.AliquotaDifalDoItem = 10) And
            (ReturnValue.ResultadoCalculoDifalFcp.IcmsDeOrigem = 10) And
            (ReturnValue.ResultadoCalculoDifalFcp.IcmsDeDestino = 10)And
            (ReturnValue.ResultadoCalculoDifalFcp.BaseFCP = 10)And
            (ReturnValue.ResultadoCalculoDifalFcp.ValorFCP = 1));
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTServicosClasseDifalFcp.Suite);
end.

