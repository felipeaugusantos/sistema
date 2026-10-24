program PlaySound;

uses
  Vcl.Forms,
  System.SysUtils,
  Winapi.Windows,
  Winapi.MMSystem,
  untPlaySound in 'untPlaySound.pas';

{$R *.res}

procedure pPlaySound;
begin
  Try
    If FileExists(ParamStr(1)) Then
      TPlaySound.Execute(ParamStr(1));
    Application.ProcessMessages;
  Finally
    If Not TerminateProcess(GetCurrentProcess, 0) Then
      Application.Terminate;
  End;
end;

begin
  Application.Initialize;
  pPlaySound;
end.
