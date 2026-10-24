program ProcessaCalculoRota;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  {$region}
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
  Services.Processa.Calculo.Rota in '..\..\Source\Services.Processa.Calculo.Rota.pas',
  untRestApi in '..\..\..\..\fontes\faturamento\untRestApi.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untMapsDistanceMatrix in '..\..\..\..\fontes\faturamento\untMapsDistanceMatrix.pas',
  untMapsRestApi in '..\..\..\..\fontes\faturamento\untMapsRestApi.pas',
  untProcessaCalculoRotaMapsDistanceMatrix in '..\..\..\..\fontes\faturamento\untProcessaCalculoRotaMapsDistanceMatrix.pas',
  untMaplinkMultiGeocode in '..\..\..\..\fontes\faturamento\untMaplinkMultiGeocode.pas',
  untMaplinkPlanning in '..\..\..\..\fontes\faturamento\untMaplinkPlanning.pas',
  untMaplinkRestApi in '..\..\..\..\fontes\faturamento\untMaplinkRestApi.pas',
  untMaplinkToken in '..\..\..\..\fontes\faturamento\untMaplinkToken.pas',
  untMaplinkMatrixDistance in '..\..\..\..\fontes\faturamento\untMaplinkMatrixDistance.pas',
  untMaplinkJobs in '..\..\..\..\fontes\faturamento\untMaplinkJobs.pas',
  untMaplinkIDRetorno in '..\..\..\..\fontes\faturamento\untMaplinkIDRetorno.pas',
  untCitelOsrmRestApi in '..\..\..\..\fontes\faturamento\untCitelOsrmRestApi.pas',
  untCitelOsrmTableApi in '..\..\..\..\fontes\faturamento\untCitelOsrmTableApi.pas',
  untCitelOsrmTripApi in '..\..\..\..\fontes\faturamento\untCitelOsrmTripApi.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');
  pDefinirUsuarioConexao('autcom_citel', 'belamupe_citel');
//  pDefinirUsuarioConexao('root', 'citel13347');

  While True do
  Begin
    try
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Iniciando Processa Calculo Rota ...');

      If Not ProcessarCalculoRota Then
        Sleep(60000);

      Writeln(DateTimeToStr(fNow) + ' - ' + 'Finalizando Processa Calculo Rota ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
