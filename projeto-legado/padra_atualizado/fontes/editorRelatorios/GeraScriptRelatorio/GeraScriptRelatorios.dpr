program GeraScriptRelatorios;

uses
  ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Midas,
  Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  TConverte in 'TConverte.pas',
  untGridRelatorios in 'untGridRelatorios.pas' {frmGridRelatorios};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
