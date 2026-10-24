program AutcomSvc;

uses
  MidasLib,
  ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  System.SysUtils,
  untPrincipal in 'untPrincipal.pas' {frmAutcomSvc},
  untFuncoes in 'untFuncoes.pas',
  untLogAut in 'untLogAut.pas';

{$R *.res}

begin
  pLog('Iniciando ' + GetModuleName(HInstance));
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmAutcomSvc, frmAutcomSvc);
  Application.Run;
end.
