program ProcessaRecebiveisAlpe;

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
  Services.Processa.Recebiveis.Alpe in '..\..\Source\Services.Processa.Recebiveis.Alpe.pas',
  untAlpeBillReceivablesCessions in '..\..\..\..\fontes\faturamento\untAlpeBillReceivablesCessions.pas',
  untAlpeCancelReceivablesCessions in '..\..\..\..\fontes\faturamento\untAlpeCancelReceivablesCessions.pas',
  untAlpeCreateReceivablesCessions in '..\..\..\..\fontes\faturamento\untAlpeCreateReceivablesCessions.pas',
  untArredondaParcelaImpl in '..\..\..\..\fontes\faturamento\untArredondaParcelaImpl.pas',
  untAdiantamentoClienteGenerico in '..\..\..\..\fontes\genericos\untAdiantamentoClienteGenerico.pas',
  untGravaMovCar in '..\..\..\..\fontes\financeiro\cartoes\untGravaMovCar.pas',
  untLogMca in '..\..\..\..\fontes\financeiro\cartoes\untLogMca.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untRestApi in '..\..\..\..\fontes\faturamento\untRestApi.pas',
  untAlpeRestApi in '..\..\..\..\fontes\faturamento\untAlpeRestApi.pas',
  untAlpeToken in '..\..\..\..\fontes\faturamento\untAlpeToken.pas',
  untAlpeReceivablesSummaries in '..\..\..\..\fontes\faturamento\untAlpeReceivablesSummaries.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');
  pDefinirUsuarioConexao('autcom_citel', 'belamupe_citel');

  While True do
  Begin
    try
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Iniciando Processa Recebiveis Alpe ...');

      If Not ProcessarRecebiveisAlpe Then
        Sleep(60000);

      Writeln(DateTimeToStr(fNow) + ' - ' + 'Finalizando Processa Recebiveis Alpe ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
