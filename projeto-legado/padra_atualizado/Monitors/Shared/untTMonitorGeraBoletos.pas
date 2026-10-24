unit untTMonitorGeraBoletos;

interface

uses System.Classes,System.SysUtils,Forms,untTypesSistema,untFuncoesSimples,
     System.StrUtils,System.IOUtils,Winapi.Windows,Uni, untUtilMonitor;
Type
  TMonitorGeraBoletos = class
  strict private
    class function GetExeName: String; static;
    class function GetCaminhoExe: String; static;
  public
    const
      ID_MONITOR = 'MONITOR_GERA_BOLETOS_%s_%s';
      ID_INATIVIDADE_MONITOR = 'TESTE_INATIVIDADE_GERA_BOLETOS_%s_%s';
      TEMPO_LIMITE_MONITOR = 30;
      TENTATIVAS_LOCK_MONITOR = 30;
      PARAMETROS = '%s %s %s';

    class var DataUltimaExecucaoMonitor: TDateTime;
    class var Operador: String;

    class property ExeName: string read GetExeName;
    class property CaminhoExe: string read GetCaminhoExe;

    class procedure ExecutaMonitorGeraBoletos;
  end;

  function ExecutarRobo:Boolean;
  function fQuantidadeRobosDeMonitaramentoExecutando(ALike: String): Integer;
  function QuantidadeBoletosPendentes: Integer;


Var
  ProcessoGeraBoletosMonitor: TProcessInformation;

implementation


function fQuantidadeRobosDeMonitaramentoExecutando(ALike: String): Integer;
  Var
    qryLock: TUniQuery;
Begin
  qryLock := fCriaQuery(Nil);
  With qryLock Do
  Begin
    SQL.Add('SELECT COUNT(0) FROM LCKATC WHERE LCK_CHAACE LIKE "%' + ALike +'%" ');
    Open;
    Result := Fields[0].AsInteger;
  End;
  FreeAndNil(qryLock);
end;

function QuantidadeBoletosPendentes: Integer;
  Var
    LBolAut: TUniQuery;
Begin
  LBolAut := fCriaQuery(Nil);
  Try
    LBolAut.SQL.Add('SELECT COUNT(*) AS QTD FROM BOLAUT WHERE BOL_CODEMP = :CODEMP');
    LBolAut.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LBolAut.Open;
    Result := LBolAut.Fields[0].AsInteger;
  Finally
    FreeAndNil(LBolAut);
  End;
end;

function ExecutarRobo:Boolean;
  Var
    LMonitorGeraBoletos: TMonitorGeraBoletos;
    LIDMOnitor: String;
Begin
  Result := True;
  Try
    LMonitorGeraBoletos := TMonitorGeraBoletos.Create;
    LIDMonitor := LMonitorGeraBoletos.ID_MONITOR;
    LIDMonitor := Format(LIDMonitor, ['%', '%']);

    If (QuantidadeBoletosPendentes = 0) Then
      Exit(False);

    If Not (fQuantidadeRobosDeMonitaramentoExecutando(LIDMonitor) < fCfgSis('MAXRBL', VarInteger)) Then
      Exit(False);

  Finally
    FreeAndNil(LMonitorGeraBoletos);
  End;
End;

{ TMonitorGeraBoletos }

Class procedure TMonitorGeraBoletos.ExecutaMonitorGeraBoletos;
  Var
    LIDMonitor : String;
begin

  LIDMonitor := untTMonitorGeraBoletos.TMonitorGeraBoletos.ID_MONITOR;
  LIDMonitor := Format(LIDMonitor, [VS_strCodEmp, strLoginUsuarioLogado]);

  If Not fLock_Unlock(LIDMonitor,
                      True,
                      False,
                      False,
                      '',
                      False) Then
  Begin
    if fGetTempoDuracaoLock(LIDMonitor) > StrToTime('02:00:00') Then
    Begin
      fLock_Unlock(LIDMonitor,
                   False,
                   False,
                   False,
                   '',
                   False,
                   LIDMonitor);

      fLock_Unlock(LIDMonitor,
                   True,
                   False,
                   False,
                   '',
                   False);
    End
    Else
      Exit;
  End;

  TUtilMonitor.pTestInactivity(Format(untTMonitorGeraBoletos.TMonitorGeraBoletos.ID_INATIVIDADE_MONITOR, [VS_strCodEmp,strLoginUsuarioLogado]),
                               untTMonitorGeraBoletos.TMonitorGeraBoletos.TEMPO_LIMITE_MONITOR,
                               untTMonitorGeraBoletos.ProcessoGeraBoletosMonitor,
                               untTMonitorGeraBoletos.TMonitorGeraBoletos.DataUltimaExecucaoMonitor);

  TUtilMonitor.pRunMonitor('',
                           untTMonitorGeraBoletos.ProcessoGeraBoletosMonitor,
                           untTMonitorGeraBoletos.TMonitorGeraBoletos.DataUltimaExecucaoMonitor,
                           untTMonitorGeraBoletos.TMonitorGeraBoletos.ExeName,
                           Format(untTMonitorGeraBoletos.TMonitorGeraBoletos.PARAMETROS, [VS_strCodEmp,strLoginUsuarioLogado,'MONITOR_GERA_BOLETOS']),
                           untTMonitorGeraBoletos.TMonitorGeraBoletos.CaminhoExe);

end;

class function TMonitorGeraBoletos.GetCaminhoExe: String;
begin
  Result := ExtractFilePath(Application.ExeName);

  If (Pos('\autban', LowerCase(Result)) > 0) Then
    Result := ExtractFilePath(Application.ExeName) + '..\' + ExeName
  Else
    Result := ExtractFilePath(Application.ExeName) + '\' + ExeName;
end;

class function TMonitorGeraBoletos.GetExeName: String;
begin
  Result := 'EnviaEmailBoletoMonitor.exe';
end;

end.
