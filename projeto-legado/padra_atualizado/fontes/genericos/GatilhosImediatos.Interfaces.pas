unit GatilhosImediatos.Interfaces;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\Services\Core\services.core.uses.inc'},
{$ELSE}
  untUtilMonitor,
{$ENDIF LINUX}
  untTypesSistema;

type
  IGatIme = interface
    ['{EA66E39A-13F2-414D-875A-0EF86F97A1C8}']
    function fMonitorar(AstrFluxo: String = ''): {$IFDEF LINUX}ITaskMonitorProcedure {$ELSE}IMonitorProcedure{$ENDIF LINUX};
    function fGravarGatilhoImediato(RecGatilhoImediato: TRecGatilhoImediato): Boolean;
  end;

implementation

end.
