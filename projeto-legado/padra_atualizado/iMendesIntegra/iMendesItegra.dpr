program iMendesItegra;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  ShareMem,
  SysUtils,
  Classes,
  MidasLib,
  RlConsts,
  Windows,
  madStackTrace,
  iMendes.TProcessamentoExterno in 'iMendes.TProcessamentoExterno.pas',
  iMendes.Comunicador in '..\fontes\util\operacoesrefitens\Saneamento\iMendes.Comunicador.pas',
  iMendes.Constantes in '..\fontes\util\operacoesrefitens\Saneamento\iMendes.Constantes.pas',
  iMendes.GerenciaEstado in '..\fontes\util\operacoesrefitens\Saneamento\iMendes.GerenciaEstado.pas',
  iMendes.Threads in '..\fontes\util\operacoesrefitens\Saneamento\iMendes.Threads.pas',
  iMendes.Functions in '..\fontes\util\operacoesrefitens\Saneamento\iMendes.Functions.pas',
  iMendes.Types in '..\fontes\util\operacoesrefitens\Saneamento\iMendes.Types.pas',
  iMendes.ProcessaAlterados in '..\fontes\util\operacoesrefitens\Saneamento\iMendes.ProcessaAlterados.pas';

function GetConsoleWindow: HWND; stdcall; external kernel32;
  var ProcessamentoExterno: TProcessamentoExterno;

begin
  try
    ShowWindow(GetConsoleWindow, SW_HIDE);
    iMendes.Types.IDUnicoExeImendesIntegra := GetNewID('IMENDES');
    iMendes.Types.intQtdThreadAtivas :=fRetQtdThreadAtivas;
    while true do
    begin
      ProcessamentoExterno := TProcessamentoExterno.Create(nil);
      Try
        If not ProcessamentoExterno.fLocalizaPendencias Then
          Sleep(1000)
        Else
          ProcessamentoExterno.ProcessaPendencias;
      Finally
        FreeAndNil(ProcessamentoExterno);
        If Assigned(ProcessamentoExterno.FConnection) Then
          If Not ProcessamentoExterno.FConnection.Connected Then
            FreeAndNil(TProcessamentoExterno.FConnection);

      End
    End;
  except
    on E: Exception do
    Begin
      If Assigned(TProcessamentoExterno.FConnection) Then
        FreeAndNil(TProcessamentoExterno.FConnection);

      Writeln(E.ClassName, ': ', E.Message);
    end;
  End;
end.

