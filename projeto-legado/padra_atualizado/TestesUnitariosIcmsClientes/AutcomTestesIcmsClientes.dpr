program AutcomTestesIcmsClientes;
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
  Faturamento.Impostos.Calculos.Icms in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.Icms.pas',
  Faturamento.Impostos.IcmsEfetivo.SQL in '..\fontes\faturamento\Impostos\Faturamento.Impostos.IcmsEfetivo.SQL.pas',
  Faturamento.Impostos.Calculos.IcmsEfetivo in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.IcmsEfetivo.pas',
  Faturamento.Impostos.Calculos.IcmsOrgaoPublico in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.IcmsOrgaoPublico.pas',
  untConstantes in '..\fontes\genericos\untConstantes.pas',
  untConstantesNFe in '..\fontes\libNfe\untConstantesNFe.pas',
  Shared.Functions.FloatUtils in '..\Packages\Shared\Functions\source\Shared.Functions.FloatUtils.pas',
  Shared.Functions.Configuracoes in '..\Packages\Shared\Functions\source\Shared.Functions.Configuracoes.pas',
  Faturamento.Impostos.Interfaces.Icms in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.Icms.pas',
  Faturamento.Impostos.Tipos.Icms in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.Icms.pas',
  Faturamento.Impostos.Interfaces.FCP in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.FCP.pas',
  Faturamento.Impostos.Tipos.IcmsEfetivo in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.IcmsEfetivo.pas',
  Faturamento.Impostos.Interfaces.IcmsEfetivo in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.IcmsEfetivo.pas',
  Faturamento.Impostos.Tipos.Model in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.Model.pas',
  Faturamento.Impostos.Interfaces.Model in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.Model.pas',
  Faturamento.Impostos.Tipos.IcmsOrgaoPublico in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.IcmsOrgaoPublico.pas',
  Faturamento.Impostos.Interfaces.IcmsOrgaoPublico in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.IcmsOrgaoPublico.pas',
  Shared.Functions.Types in '..\Packages\Shared\Functions\source\Shared.Functions.Types.pas',
  Shared.Functions.Constantes in '..\Packages\Shared\Functions\source\Shared.Functions.Constantes.pas',
  Faturamento.Impostos.Interfaces.ZerarImpostos.Icms in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ZerarImpostos.Icms.pas',
  Faturamento.Impostos.Tipos.ZerarImpostos.Icms in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ZerarImpostos.Icms.pas',
  Faturamento.Impostos.Interfaces.ZerarImpostos.Types in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ZerarImpostos.Types.pas',
  Shared.Functions.Funcoes.Faturamento in '..\Packages\Shared\Functions\source\Shared.Functions.Funcoes.Faturamento.pas',
  Shared.Functions.DataSet in '..\Packages\Shared\Functions\source\Shared.Functions.DataSet.pas',
  Core.Funcoes in '..\fontes\Core\Core.Funcoes.pas',
  Shared.Functions.Interfaces in '..\Packages\Shared\Functions\source\Shared.Functions.Interfaces.pas',
  Shared.Functions.Tipos in '..\Packages\Shared\Functions\source\Shared.Functions.Tipos.pas',
  TestFaturamento.Impostos.Calculos.Icms.DarkaLoja1_03 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Icms.DarkaLoja1_03.pas',
  TestFaturamento.Impostos.Calculos.Icms.FeniorLoja1_03 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Icms.FeniorLoja1_03.pas',
  TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.TECHGEL_COMERCI_Lj002_20191101 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.TECHGEL_COMERCI_Lj002_20191101.pas',
  TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.JABU_ENGENHARIA_Lj001_20191106 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.JABU_ENGENHARIA_Lj001_20191106.pas',
  TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.TECHGEL_COMERCI_Lj002_20191118 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.TECHGEL_COMERCI_Lj002_20191118.pas',
  TestFaturamento.Impostos.Calculos.Icms.MAGIC_CAR_OURIN_Lj002_20191212 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Icms.MAGIC_CAR_OURIN_Lj002_20191212.pas',
  TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.VINIMAQ_AUTOMAÇ_Lj001_20191205 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.VINIMAQ_AUTOMAÇ_Lj001_20191205.pas',
  TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.VINIMAQ_AUTOMAÇ_Lj001_20190917 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.VINIMAQ_AUTOMAÇ_Lj001_20190917.pas',
  TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.FRANCA_CORES_Lj001_20191205 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.FRANCA_CORES_Lj001_20191205.pas',
  TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.TELCABOS_PR_Lj002_20191216 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.TELCABOS_PR_Lj002_20191216.pas',
  TestFaturamento.Impostos.Calculos.IcmsEfetivo.PALACIO_DAS_FER_Lj001_20191224 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IcmsEfetivo.PALACIO_DAS_FER_Lj001_20191224.pas';

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


