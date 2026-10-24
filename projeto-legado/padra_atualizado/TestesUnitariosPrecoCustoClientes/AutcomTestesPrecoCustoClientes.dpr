program AutcomTestesPrecoCustoClientes;
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
  Shared.Functions.FloatUtils in '..\Packages\Shared\Functions\source\Shared.Functions.FloatUtils.pas',
  Shared.Functions.Configuracoes in '..\Packages\Shared\Functions\source\Shared.Functions.Configuracoes.pas',
  Core.Funcoes in '..\fontes\Core\Core.Funcoes.pas',
  Shared.Functions.Funcoes.Faturamento in '..\Packages\Shared\Functions\source\Shared.Functions.Funcoes.Faturamento.pas',
  Shared.Functions.Constantes in '..\Packages\Shared\Functions\source\Shared.Functions.Constantes.pas',
  Shared.Functions.Types in '..\Packages\Shared\Functions\source\Shared.Functions.Types.pas',
  Shared.Functions.Tipos in '..\Packages\Shared\Functions\source\Shared.Functions.Tipos.pas',
  Shared.Functions.Interfaces in '..\Packages\Shared\Functions\source\Shared.Functions.Interfaces.pas',
  TestFaturamento.Impostos.Calculos.PrecoCusto.RITEC_MAQUINAS_Lj001_20191218 in 'padra_atualizado\packages\faturamento\precos\calculos\source\TestFaturamento.Impostos.Calculos.PrecoCusto.RITEC_MAQUINAS_Lj001_20191218.pas',
  Faturamento.Precos.Calculos.PrecoCusto in '..\Packages\Faturamento\Precos\calculos\source\Faturamento.Precos.Calculos.PrecoCusto.pas',
  Faturamento.Precos.Interfaces.PrecoCusto in '..\Packages\Faturamento\Precos\interfaces\source\Faturamento.Precos.Interfaces.PrecoCusto.pas',
  Faturamento.Precos.Tipos.PrecoCusto in '..\Packages\Faturamento\Precos\tipos\source\Faturamento.Precos.Tipos.PrecoCusto.pas',
  Shared.Functions.DataSet in '..\Packages\Shared\Functions\source\Shared.Functions.DataSet.pas',
  TestFaturamento.Impostos.Calculos.PrecoCusto.SECOL_MATERIAIS_Lj001_20191218 in 'padra_atualizado\packages\faturamento\precos\calculos\source\TestFaturamento.Impostos.Calculos.PrecoCusto.SECOL_MATERIAIS_Lj001_20191218.pas',
  TestFaturamento.Impostos.Calculos.PrecoCusto.ANDRESA_EMP_01_Lj012_20191220 in 'padra_atualizado\packages\faturamento\precos\calculos\source\TestFaturamento.Impostos.Calculos.PrecoCusto.ANDRESA_EMP_01_Lj012_20191220.pas',
  TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.SANTEC_Lj001_20191219 in 'padra_atualizado\packages\faturamento\precos\calculos\source\TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.SANTEC_Lj001_20191219.pas',
  TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.SECOL_Lj001_20191219 in 'padra_atualizado\packages\faturamento\precos\calculos\source\TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.SECOL_Lj001_20191219.pas',
  Shared.Core in '..\fontes\Core\Shared.Core.pas',
  Shared.Functions.Core in '..\Packages\Shared\Functions\source\Shared.Functions.Core.pas',
  Impostos.Fat.Connections.Functions in '..\fontes\Impostos\Fat\Connections\Impostos.Fat.Connections.Functions.pas',
  Shared.Functions.Conexao.UniDac in '..\fontes\genericos\Shared.Functions.Conexao.UniDac.pas',
  Impostos.Fat.Conexao.Interfaces in '..\fontes\Impostos\Fat\Interfaces\Conexao\Impostos.Fat.Conexao.Interfaces.pas',
  untDicionarioResultadoQuerySimples in '..\fontes\genericos\untDicionarioResultadoQuerySimples.pas',
  untFuncoesDicionarios in '..\fontes\genericos\untFuncoesDicionarios.pas',
  untFuncoesGenCompartilhada in '..\fontes\genericos\untFuncoesGenCompartilhada.pas',
  TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.SULCORESLj005_20191219 in 'padra_atualizado\packages\faturamento\precos\calculos\source\TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.SULCORESLj005_20191219.pas',
  TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.ANDRESA_Lj012_20191220 in 'padra_atualizado\packages\faturamento\precos\calculos\source\TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.ANDRESA_Lj012_20191220.pas',
  TestFaturamento.Precos.Calculos.PrecoCustoRealVenda.TINTAS_MC_Lj002_20191223 in 'padra_atualizado\packages\faturamento\precos\calculos\source\TestFaturamento.Precos.Calculos.PrecoCustoRealVenda.TINTAS_MC_Lj002_20191223.pas',
  TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.TINTAS_MC_Lj002_20191223 in 'padra_atualizado\packages\faturamento\precos\calculos\source\TestFaturamento.Precos.Calculos.PrecoCustoMargemMarkup.TINTAS_MC_Lj002_20191223.pas',
  Shared.Functions.FormulaPrecoCusto in '..\Packages\Shared\Functions\source\Shared.Functions.FormulaPrecoCusto.pas',
  Faturamento.Connections.Functions in '..\fontes\Core\Faturamento.Connections.Functions.pas',
  Faturamento.Interfaces.Conexao in '..\fontes\Core\Conexao\Faturamento.Interfaces.Conexao.pas';

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

