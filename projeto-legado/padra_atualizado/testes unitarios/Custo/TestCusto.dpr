program TestCusto;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options 
  to use the console test runner.  Otherwise the GUI test runner will be used by 
  default.

}

//{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
//{$ENDIF}

uses
  ShareMem,
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  untParCalculaPrecoCusto in '..\..\fontes\genericos\untParCalculaPrecoCusto.pas',
  untFuncoesLibFuncoes in '..\..\fontes\genericos\untFuncoesLibFuncoes.pas',
  untTestTParCalculaPrecoCusto in 'untTestTParCalculaPrecoCusto.pas',
  untIConfiguracao in '..\..\fontes\configuracoes\untIConfiguracao.pas',
  untConfiguracoesStub in '..\Configuracoes\untConfiguracoesStub.pas',
  untTestTCalculoPrecoMedio in 'untTestTCalculoPrecoMedio.pas',
  untCalculoPrecoMedio in '..\..\fontes\genericos\untCalculoPrecoMedio.pas',
  untConstantes in '..\..\fontes\genericos\untConstantes.pas',
  untTestTCalculoUltimaCompraImpostos in 'untTestTCalculoUltimaCompraImpostos.pas',
  untCalculoUltimaCompraImpostos in '..\..\fontes\genericos\untCalculoUltimaCompraImpostos.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;
end.

