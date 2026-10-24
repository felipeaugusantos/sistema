unit untDllGatIme;

interface
{$WARN SYMBOL_PLATFORM OFF}

uses
{$IFDEF LINUX}
    {$I '..\..\Services\core\services.core.uses.inc'},
{$ELSE}
  Winapi.Windows,
  untFuncoesSimples,
  untModulo,
  untUtilMonitor,
{$ENDIF LINUX}
  Classes,
  SysUtils,
  Uni,
  untDLLGatImeParametros,
  GatilhosImediatos.Interfaces,
  untTypesSistema;

{$REGION 'Funcoes de Inicialização da DLL/SO'}
{$IFNDEF LINUX}
  function fCarregarDll(prmDll: Pointer): IGatIme; stdcall;
    external 'libGatIme.dll' delayed;
  function fSVN_RevisionGatIme: PAnsiChar; stdcall;
    external 'libGatIme.dll' delayed;
{$ELSE}
  procedure pCarregaFuncoesDllGatilhoImediatos;

  var
    fCarregarDllGatIme: function(prmDll: Pointer): IGatIme; cdecl;
{$ENDIF LINUX}
{$ENDREGION}

Var
  VS_strLockMonitorGatilhosImediatosOperacional: String;
  VS_strLockMonitorGatilhosImediatosComplementar: String;
  VS_dtaUltimaExecucaoMonitorGatilhosImediatosOperacional: TDateTime;
  VS_dtaUltimaExecucaoMonitorGatilhosImediatosComplementar: TDateTime;
{$IFNDEF LINUX}
  VS_objProcessoMonitorGatilhosImediatosOperacional: TProcessInformation;
  VS_objProcessoMonitorGatilhosImediatosComplementar: TProcessInformation;
{$ENDIF LINUX}

Const
  IdMonitorGatilhosImediatos_OLD = 'MONITOR_GATILHOS_IMEDIATOS_%s';
  IdMonitorGatilhosImediatosOperacional = 'MONITOR_GATILHOS_IMEDIATOS_OPERACIONAL_%s';
  IdMonitorGatilhosImediatosComplementar = 'MONITOR_GATILHOS_IMEDIATOS_COMPLEMENTAR_%s';
  IdInactivityMonitorGatilhosImediatos = 'TESTE_INATIVIDADE_%s';
  GatilhosImediatosMonitorExeName = 'autcom.exe';
  GatilhosImediatosMonitorExeParam = 'GATILHOS_IMEDIATOS';
  TimeLimitMonitorGatilhosImediatos = 30;
  AttemptsLockMonitorGatilhosImediatos = 30;
  MinutosNovaTentativaGatilhosImediatos = 10;

type
  IDllGatime = interface
  ['{584AB3C1-454A-4C8C-9848-7F49A3F5DA52}']
    function fMonitorarGatilhosImediatos(AstrFluxo: String = ''): {$IFDEF LINUX}ITaskMonitorProcedure{$ELSE}IMonitorProcedure{$ENDIF LINUX};
    function fGravarGatilhoImediato(const RecGatilhoImediato: TRecGatilhoImediato): Boolean;
  end;

  TDllGatime = class(TInterfacedObject, IDllGatime)
  private
    FDllGatIme: IGatIme;
  public
    property DllGatIme: IGatIme Read FDllGatIme Write FDllGatIme;

    {$IFNDEF LINUX}
    class procedure ExecutarRoboOperacional;
    class procedure ExecutarRoboComplementar;
    {$ENDIF}

    constructor Create;
    class function fNew: IDllGatime;

    function fMonitorarGatilhosImediatos(AstrFluxo: String = ''): {$IFDEF LINUX}ITaskMonitorProcedure{$ELSE}IMonitorProcedure{$ENDIF LINUX};
    function fGravarGatilhoImediato(const RecGatilhoImediato: TRecGatilhoImediato): Boolean;
  end;

implementation

{ TDllGatime }

{$IFNDEF LINUX}
class procedure TDllGatime.ExecutarRoboOperacional;
Var
  LId: String;
begin
  LId := Format(IdMonitorGatilhosImediatosOperacional, [VS_strCodEmp]);

  TUtilMonitor.pTestInactivity(IdInactivityMonitorGatilhosImediatos,
    TimeLimitMonitorGatilhosImediatos, VS_objProcessoMonitorGatilhosImediatosOperacional,
    VS_dtaUltimaExecucaoMonitorGatilhosImediatosOperacional);

  TUtilMonitor.pRunMonitor(LId, VS_objProcessoMonitorGatilhosImediatosOperacional,
    VS_dtaUltimaExecucaoMonitorGatilhosImediatosOperacional, ExtractFileName(ParamStr(0)),
      Concat(GatilhosImediatosMonitorExeParam, ' ', VS_strCodEmp, ' ', 'OPERACIONAL' ));

  TUtilMonitor.pClearAttemptsLock(LId, AttemptsLockMonitorGatilhosImediatos);
end;

class procedure TDllGatime.ExecutarRoboComplementar;
Var
  LId: String;
begin
  LId := Format(IdMonitorGatilhosImediatosComplementar, [VS_strCodEmp]);

  TUtilMonitor.pTestInactivity(IdInactivityMonitorGatilhosImediatos,
    TimeLimitMonitorGatilhosImediatos, VS_objProcessoMonitorGatilhosImediatosComplementar,
    VS_dtaUltimaExecucaoMonitorGatilhosImediatosComplementar);

  TUtilMonitor.pRunMonitor(LId, VS_objProcessoMonitorGatilhosImediatosComplementar,
    VS_dtaUltimaExecucaoMonitorGatilhosImediatosComplementar, ExtractFileName(ParamStr(0)),
      Concat(GatilhosImediatosMonitorExeParam, ' ', VS_strCodEmp, ' ', 'COMPLEMENTAR'));

  TUtilMonitor.pClearAttemptsLock(LId, AttemptsLockMonitorGatilhosImediatos);
end;
{$ENDIF}

class function TDllGatime.fNew: IDllGatime ;
begin
  Result := TDllGatime.Create;
end;

function TDllGatime.fGravarGatilhoImediato(const RecGatilhoImediato: TRecGatilhoImediato): Boolean;
begin
  Result := DllGatIme.fGravarGatilhoImediato(RecGatilhoImediato);
end;

function TDllGatime.fMonitorarGatilhosImediatos(AstrFluxo: String = ''): {$IFDEF LINUX}ITaskMonitorProcedure {$ELSE}IMonitorProcedure{$ENDIF LINUX};
begin
  Result := DllGatIme.fMonitorar(AstrFluxo);
end;

{$REGION 'Carregamento da DLL/SO'}
{$IFDEF LINUX}
function RetornarDllGatilhosImediatos : THandle;
begin
  if not FileExists(ExtractFilePath(Application.ExeName) + 'libGatIme.so') then
    Exit;

  Result := LoadLibrary(PChar(ExtractFilePath(Application.ExeName) + 'libGatIme.so'));
end;

procedure pCarregaFuncoesDllGatilhoImediatos;
begin
  if HandleDllGatilhosImediatos = 0 then
    HandleDllGatilhosImediatos := RetornarDllGatilhosImediatos;

  If (HandleDllGatilhosImediatos = 0) Then
    Exit;

  fCarregarDllGatIme := GetProcAddress(HandleDllGatilhosImediatos, PChar('fCarregarDll'));
end;

{$ENDIF LINUX}

{$REGION 'Inicializa parâmetros - Windows'}
{$IFNDEF LINUX}
procedure pInicializaParametrosWindows(objGatImeParametros: TparamGatIme);
begin
  {$WARN SYMBOL_PLATFORM OFF}
  objGatImeParametros.intDebugH := DebugHook;
  {$WARN SYMBOL_PLATFORM ON}

  objGatImeParametros.modRecMod.Banco := frmModulo.GetCurrentConnection;

  objGatImeParametros.varRecVar.dtaVSDate := VS_Date;
  objGatImeParametros.varRecVar.strLogUsu := ShortString(strLoginUsuarioLogado);
  objGatImeParametros.varRecVar.strDesUsu := ShortString(strDescriUsuarioLogado);
  objGatImeParametros.varRecVar.strEmpUsu := String(strEmpAcessoUsuarioLogado);
  objGatImeParametros.varRecVar.strEmpEst := String(strEmpEstUsuarioLogado);
  objGatImeParametros.varRecVar.strEmpCod := ShortString(String(VS_strCodEmp));
end;
{$ENDIF LINUX}
{$ENDREGION}

{$REGION 'Inicializa parâmetros - Linux'}
{$IFDEF LINUX}
procedure pInicializaParametrosLinux(objGatImeParametros: TparamGatIme);
begin
  objGatImeParametros.modRecMod.ConnectionManager := objConnectionsManager;
  objGatImeParametros.Application := Application;

  objGatImeParametros.varRecVar.strLogUsu := strLoginUsuarioLogado;
  objGatImeParametros.varRecVar.strEmpCod := ShortString(String(VS_strCodEmp));
end;
{$ENDIF LINUX}
{$ENDREGION}

constructor TDllGatime.Create;
var
  objGatImeParametros : TparamGatIme;
begin
  try
    objGatImeParametros := TparamGatIme.Create;
    {$IFNDEF LINUX}
    pInicializaParametrosWindows(objGatImeParametros);
    DllGatIme := fCarregarDll(objGatImeParametros);
    {$ELSE }
    pInicializaParametrosLinux(objGatImeParametros);
    DllGatIme := fCarregarDllGatIme(objGatImeParametros);
    {$ENDIF LINUX}
  except
    on E: Exception do
    begin
      {$IFNDEF LINUX}
      pMensagensErro(E.Message, 'DLL libGatIme');
      {$ENDIF LINUX}
    end;
  end;
end;
{$ENDREGION}

end.
