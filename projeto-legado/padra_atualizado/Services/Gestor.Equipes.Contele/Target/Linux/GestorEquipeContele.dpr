program GestorEquipeContele;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Services.Core.Cache in '..\..\..\Core\Services.Core.Cache.pas',
  Services.Core.Connection.Interfaces in '..\..\..\Core\Services.Core.Connection.Interfaces.pas',
  Services.Core.Connection.Manager in '..\..\..\Core\Services.Core.Connection.Manager.pas',
  Services.Core.Connection.UniDac in '..\..\..\Core\Services.Core.Connection.UniDac.pas',
  Services.Core.Settings in '..\..\..\Core\Services.Core.Settings.pas',
  Services.Core.Task.Lock in '..\..\..\Core\Services.Core.Task.Lock.pas',
  Services.Core.Task.Monitor in '..\..\..\Core\Services.Core.Task.Monitor.pas',
  Services.Core.Types in '..\..\..\Core\Services.Core.Types.pas',
  Services.Core.Utils in '..\..\..\Core\Services.Core.Utils.pas',
  Services.Core.Rest in '..\..\..\Core\Services.Core.Rest.pas',
  Services.Gestor.Equipe.Contele in '..\..\Source\Services.Gestor.Equipe.Contele.pas',
  untRestApi in '..\..\..\..\fontes\faturamento\untRestApi.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untContele.Pois in '..\..\Source\untContele.Pois.pas',
  untConteleRestApi in '..\..\..\..\fontes\cadastros\untConteleRestApi.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');
  pDefinirUsuarioConexao('erp_autcom', 'F12@Aranha43');
//  pDefinirUsuarioConexao('root', 'citel13347');

  While True do
  Begin
    try
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Iniciando Gestor de Equipes Contele ...');

      If Not fProcessarGestorEquipeContele Then
        Sleep(60000);

      Writeln(DateTimeToStr(fNow) + ' - ' + 'Finalizando Gestor de Equipes Contele ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
