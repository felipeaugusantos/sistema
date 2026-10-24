program Multiplus;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {Form1},
  untInterfacesMultiplus in '..\Interfaces\Multiplus\untInterfacesMultiplus.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;//DebugHook <> 0;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
