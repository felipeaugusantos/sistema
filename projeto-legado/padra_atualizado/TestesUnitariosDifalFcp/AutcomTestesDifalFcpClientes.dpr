program AutcomTestesDifalFcpClientes;
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
  Core.Funcoes in '..\fontes\Core\Core.Funcoes.pas',
  Faturamento.Impostos.Calculos.FCP in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.FCP.pas',
  Faturamento.Impostos.Calculos.Difal in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.Difal.pas',
  Faturamento.Impostos.Interfaces.Difal in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.Difal.pas',
  Faturamento.Impostos.Interfaces.FCP in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.FCP.pas',
  Faturamento.Impostos.Tipos.Difal in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.Difal.pas',
  Faturamento.Impostos.Tipos.FCP in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.FCP.pas',
  Shared.Functions.FloatUtils in '..\Packages\Shared\Functions\source\Shared.Functions.FloatUtils.pas',
  Shared.Functions.Constantes in '..\Packages\Shared\Functions\source\Shared.Functions.Constantes.pas',
  Shared.Functions.Funcoes.Faturamento in '..\Packages\Shared\Functions\source\Shared.Functions.Funcoes.Faturamento.pas',
  Shared.Functions.Configuracoes in '..\Packages\Shared\Functions\source\Shared.Functions.Configuracoes.pas',
  Shared.Functions.Tipos in '..\Packages\Shared\Functions\source\Shared.Functions.Tipos.pas',
  Shared.Functions.Types in '..\Packages\Shared\Functions\source\Shared.Functions.Types.pas',
  Shared.Functions.Interfaces in '..\Packages\Shared\Functions\source\Shared.Functions.Interfaces.pas',
  untFuncoes in '..\TestesUnitarios\padra_atualizado\fontes\untFuncoes.pas',
  TestFaturamento.Impostos.Calculos.Difal.CS_FERRAMENTAS_Lj001_20191209 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Difal.CS_FERRAMENTAS_Lj001_20191209.pas',
  TestFaturamento.Impostos.Calculos.Fcp.CS_FERRAMENTAS_Lj001_20191209 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Fcp.CS_FERRAMENTAS_Lj001_20191209.pas',
  TestFaturamento.Impostos.Calculos.Difal.CS_FERRAMENTAS_Lj001_20191206 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Difal.CS_FERRAMENTAS_Lj001_20191206.pas',
  TestFaturamento.Impostos.Calculos.Fcp.CS_FERRAMENTAS_Lj001_20191206 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Fcp.CS_FERRAMENTAS_Lj001_20191206.pas',
  TestFaturamento.Impostos.Calculos.Difal.DUPLOR_MAQUINAS_Lj002_20191209 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Difal.DUPLOR_MAQUINAS_Lj002_20191209.pas',
  TestFaturamento.Impostos.Calculos.Fcp.DUPLOR_MAQUINAS_Lj002_20191209 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Fcp.DUPLOR_MAQUINAS_Lj002_20191209.pas',
  TestFaturamento.Impostos.Calculos.Difal.GLOBALCOLOR_Lj001_20191210 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Difal.GLOBALCOLOR_Lj001_20191210.pas',
  TestFaturamento.Impostos.Calculos.Fcp.DUPLOR_MAQUINAS_Lj002_20191210 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Fcp.DUPLOR_MAQUINAS_Lj002_20191210.pas',
  TestFaturamento.Impostos.Calculos.Fcp.AQUARELA_FLORIA_Lj003_20191210 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Fcp.AQUARELA_FLORIA_Lj003_20191210.pas',
  TestFaturamento.Impostos.Calculos.Difal.DUPLOR_MAQUINAS_Lj002_20191211 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Difal.DUPLOR_MAQUINAS_Lj002_20191211.pas',
  TestFaturamento.Impostos.Calculos.Difal.MAGIC_CAR_OURIN_Lj002_20190910 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Difal.MAGIC_CAR_OURIN_Lj002_20190910.pas',
  TestFaturamento.Impostos.Calculos.Fcp.MAGIC_CAR_OURIN_Lj002_20190910 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Fcp.MAGIC_CAR_OURIN_Lj002_20190910.pas',
  TestFaturamento.Impostos.Calculos.FCPDifal.DUPLOR_MAQUINAS_Lj002_20191220 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.FCPDifal.DUPLOR_MAQUINAS_Lj002_20191220.pas',
  TestFaturamento.Impostos.Calculos.Fcp.DUPLOR_MAQUINAS_Lj002_20191220 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Fcp.DUPLOR_MAQUINAS_Lj002_20191220.pas';

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
