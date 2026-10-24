program AutcomTestesStCustoAqClientes;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  TestFrameWork,
  DUnitTestRunner,
  XMLTestRunner,
  untTestFloatUtils in '..\TestesUnitarios\padra_atualizado\fontes\genericos\untTestFloatUtils.pas',
  untFuncoes in '..\TestesUnitarios\padra_atualizado\fontes\untFuncoes.pas',
  untTestConfiguracoes in '..\TestesUnitarios\padra_atualizado\fontes\genericos\untTestConfiguracoes.pas',
  untTestConstantesUtils in '..\TestesUnitarios\padra_atualizado\fontes\genericos\untTestConstantesUtils.pas',
  Faturamento.Impostos.Calculos.STCustoAquisicao in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.STCustoAquisicao.pas',
  Faturamento.Impostos.IcmsEfetivo.SQL in '..\fontes\faturamento\Impostos\Faturamento.Impostos.IcmsEfetivo.SQL.pas',
  Faturamento.Impostos.Calculos.IcmsEfetivo in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.IcmsEfetivo.pas',
  untConstantes in '..\fontes\genericos\untConstantes.pas',
  untConstantesNFe in '..\fontes\libNfe\untConstantesNFe.pas',
  Shared.Functions.FloatUtils in '..\Packages\Shared\Functions\source\Shared.Functions.FloatUtils.pas',
  Shared.Functions.Configuracoes in '..\Packages\Shared\Functions\source\Shared.Functions.Configuracoes.pas',
  Faturamento.Impostos.Tipos.STCustoAquisicao in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.STCustoAquisicao.pas',
  Faturamento.Impostos.Interfaces.STCustoAquisicao in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.STCustoAquisicao.pas',
  Faturamento.Impostos.Interfaces.FCP in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.FCP.pas',
  Faturamento.Impostos.Tipos.IcmsEfetivo in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.IcmsEfetivo.pas',
  Faturamento.Impostos.Interfaces.IcmsEfetivo in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.IcmsEfetivo.pas',
  Faturamento.Impostos.Tipos.Model in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.Model.pas',
  Faturamento.Impostos.Interfaces.Model in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.Model.pas',
  Shared.Functions.Types in '..\Packages\Shared\Functions\source\Shared.Functions.Types.pas',
  Shared.Functions.Constantes in '..\Packages\Shared\Functions\source\Shared.Functions.Constantes.pas',
  Faturamento.Impostos.Interfaces.ZerarImpostos.Types in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ZerarImpostos.Types.pas',
  Shared.Functions.Funcoes.Faturamento in '..\Packages\Shared\Functions\source\Shared.Functions.Funcoes.Faturamento.pas',
  Shared.Functions.DataSet in '..\Packages\Shared\Functions\source\Shared.Functions.DataSet.pas',
  Core.Funcoes in '..\fontes\Core\Core.Funcoes.pas',
  Shared.Functions.Interfaces in '..\Packages\Shared\Functions\source\Shared.Functions.Interfaces.pas',
  Shared.Functions.Tipos in '..\Packages\Shared\Functions\source\Shared.Functions.Tipos.pas',
  TestFaturamento.Impostos.Calculos.STCustoAquisicao.RAUL_TINTAS_R3_Lj025_20191101 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.STCustoAquisicao.RAUL_TINTAS_R3_Lj025_20191101.pas',
  TestFaturamento.Impostos.Calculos.STCustoAquisicao.CHUVEIRAO_Lj001_20191101 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.STCustoAquisicao.CHUVEIRAO_Lj001_20191101.pas';

{$R *.RES}

var
  Resultado: TTestResult;

begin
  if ParamStr(1) = 'jenkins' then
  begin
    Resultado := Nil;

    try
      Resultado := XMLTestRunner.RunRegisteredTests;
      ExitCode := (Resultado.FailureCount + Resultado.ErrorCount);
      exit;
    finally
      Resultado.Free;
    end;
  end;

  DUnitTestRunner.RunRegisteredTests;
end.

