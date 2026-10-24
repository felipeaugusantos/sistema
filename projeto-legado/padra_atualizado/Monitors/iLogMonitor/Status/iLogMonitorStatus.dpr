program iLogMonitorStatus;

uses
  ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.SysUtils,
  Winapi.Windows,
  Forms,
  untModulo in '..\..\..\fontes\genericos\untModulo.pas' {frmModulo: TDataModule},
  untModuloReplicacao in '..\..\..\fontes\genericos\untModuloReplicacao.pas' {frmModuloReplicacao: TDataModule},
  untTypesSistema in '..\..\..\fontes\genericos\untTypesSistema.pas',
  untListaLogErros in '..\..\..\fontes\genericos\untListaLogErros.pas',
  untMensagem in '..\..\..\fontes\genericos\untMensagem.pas' {frmMensagem},
  untMensagemSonora in '..\..\..\fontes\genericos\untMensagemSonora.pas' {frmMensagemSonora},
  untConstantes in '..\..\..\fontes\genericos\untConstantes.pas',
  untGravaINNODBStatus in '..\..\..\fontes\genericos\untGravaINNODBStatus.pas',
  untFuncoesSimples in '..\..\Shared\untFuncoesSimples.pas',
  untiLogMonitorStatus in 'untiLogMonitorStatus.pas',
  untUtilMonitor in '..\..\..\fontes\genericos\untUtilMonitor.pas',
  untWaitWindow in '..\..\..\fontes\genericos\untWaitWindow.pas' {frmWaitWindow},
  untGravando in '..\..\..\fontes\genericos\untGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\..\..\fontes\genericos\untGenericProcedureFormGravando.pas',
  untLogAut in '..\..\..\fontes\genericos\untLogAut.pas',
  untWorkStationInfo in '..\..\..\fontes\genericos\untWorkStationInfo.pas',
  untSeqTmp in '..\..\..\fontes\genericos\untSeqTmp.pas',
  untVersaoProg in '..\..\..\fontes\genericos\untVersaoProg.pas',
  untTestabilidade in '..\..\..\fontes\util\testabilidade\untTestabilidade.pas',
  untCfgRepositorio in '..\..\..\fontes\configuracoes\untCfgRepositorio.pas' {frmCfgRepositorio: TDataModule},
  untInterfacedObjectNoCount in '..\..\..\fontes\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untICamposUso in '..\..\..\fontes\genericos\untICamposUso.pas',
  untCFGBAN_Class in '..\..\..\fontes\genericos\untCFGBAN_Class.pas',
  untCFGBAN_Dao in '..\..\..\fontes\genericos\untCFGBAN_Dao.pas',
  untSubjectClass in '..\..\..\fontes\genericos\untSubjectClass.pas',
  untSubjectIntf in '..\..\..\fontes\genericos\untSubjectIntf.pas',
  untGravandoObs in '..\..\..\fontes\genericos\untGravandoObs.pas',
  Yapay.Api.Resources in '..\..\..\fontes\financeiro\gerais\api.yapay\api\Yapay.Api.Resources.pas',
  Promocao.Regra.Preco.Sugestao in '..\..\..\fontes\faturamento\Promocao\Promocao.Regra.Preco.Sugestao.pas',
  untFatRomaneioiLogMonitorStatus.Interfaces in '..\..\..\fontes\faturamento\iLog\Monitors\Status\untFatRomaneioiLogMonitorStatus.Interfaces.pas',
  untFatRomaneioiLogMonitorStatus in '..\..\..\fontes\faturamento\iLog\Monitors\Status\untFatRomaneioiLogMonitorStatus.pas',
  untModelEntrega in '..\..\..\fontes\faturamento\iLog\Monitors\Status\untModelEntrega.pas',
  untRomGer in '..\..\..\fontes\faturamento\iLog\Monitors\Status\untRomGer.pas',
  untRest in '..\..\..\fontes\faturamento\iLog\Monitors\untRest.pas',
  untHorarioSistema in '..\..\..\fontes\genericos\untHorarioSistema.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

procedure pOnLostConection(strErro: String);
begin
  If Not TerminateProcess(GetCurrentProcess, 0) Then
    Application.Terminate;
end;

begin
  Application.Initialize;
  untModulo.ProcReconectarModulo := pOnLostConection;
  iLogMonitorar;
end.
