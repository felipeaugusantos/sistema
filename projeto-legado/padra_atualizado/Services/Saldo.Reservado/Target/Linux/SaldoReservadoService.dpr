program SaldoReservadoService;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
{$region '  services.core,'}
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
{$endregion}
  Services.Saldo.Reservado.Atualizar in '..\..\Source\Services.Saldo.Reservado.Atualizar.pas',
  untHorarioSistema in '..\..\..\..\fontes\genericos\untHorarioSistema.pas',
  untLogAut in '..\..\..\..\fontes\genericos\untLogAut.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untTFatReservaSaldo in '..\..\..\..\fontes\faturamento\untTFatReservaSaldo.pas',
  untIFatReservaSaldo in '..\..\..\..\fontes\faturamento\untIFatReservaSaldo.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');
  pDefinirUsuarioConexao('rb_saldoreserv', 'serv!ce@citel#robo');

  While True do
  Begin
    try
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Iniciando saldo reservado service ...');

      If Not AtualizarSaldoReservado Then
        Sleep(60000);

      Writeln(DateTimeToStr(fNow) + ' - ' + 'Finalizando saldo reservado service ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
