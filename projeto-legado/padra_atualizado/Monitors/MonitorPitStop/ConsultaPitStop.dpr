program ConsultaPitStop;

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
  untModulo in '..\..\fontes\genericos\untModulo.pas' {frmModulo: TDataModule},
  untModuloReplicacao in '..\..\fontes\genericos\untModuloReplicacao.pas' {frmModuloReplicacao: TDataModule},
  untTypesSistema in '..\..\fontes\genericos\untTypesSistema.pas',
  untListaLogErros in '..\..\fontes\genericos\untListaLogErros.pas',
  untMensagem in '..\..\fontes\genericos\untMensagem.pas' {frmMensagem},
  untConstantes in '..\..\fontes\genericos\untConstantes.pas',
  untGravaINNODBStatus in '..\..\fontes\genericos\untGravaINNODBStatus.pas',
  untProcessaPitStop in 'untProcessaPitStop.pas',
  untUtilMonitor in '..\..\fontes\genericos\untUtilMonitor.pas',
  untWaitWindow in '..\..\fontes\genericos\untWaitWindow.pas' {frmWaitWindow},
  untGravando in '..\..\fontes\genericos\untGravando.pas' {frmGravando},
  untThreadUtils in '..\..\fontes\genericos\untThreadUtils.pas',
  untGenericProcedureFormGravando in '..\..\fontes\genericos\untGenericProcedureFormGravando.pas',
  untLogAut in '..\..\fontes\genericos\untLogAut.pas',
  untWorkStationInfo in '..\..\fontes\genericos\untWorkStationInfo.pas',
  untSeqTmp in '..\..\fontes\genericos\untSeqTmp.pas',
  untVersaoProg in '..\..\fontes\genericos\untVersaoProg.pas',
  untCfgRepositorio in '..\..\fontes\configuracoes\untCfgRepositorio.pas' {frmCfgRepositorio: TDataModule},
  untInterfacedObjectNoCount in '..\..\fontes\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untICamposUso in '..\..\fontes\genericos\untICamposUso.pas',
  untSubjectClass in '..\..\fontes\genericos\untSubjectClass.pas',
  untSubjectIntf in '..\..\fontes\genericos\untSubjectIntf.pas',
  untGravandoObs in '..\..\fontes\genericos\untGravandoObs.pas',
  untHorarioSistema in '..\..\fontes\genericos\untHorarioSistema.pas',
  untTestabilidade in '..\..\fontes\util\testabilidade\untTestabilidade.pas',
  Yapay.Api.Resources in '..\..\fontes\financeiro\gerais\api.yapay\api\Yapay.Api.Resources.pas',
  Promocao.Regra.Preco.Sugestao in '..\..\fontes\faturamento\Promocao\Promocao.Regra.Preco.Sugestao.pas',
  PitStop.Classes.Base in '..\..\fontes\movimentacaoitens\Cotacao\pitstop\PitStop.Classes.Base.pas',
  PitStop.Classes.EndPoint in '..\..\fontes\movimentacaoitens\Cotacao\pitstop\PitStop.Classes.EndPoint.pas',
  PitStop.Comunicacao in '..\..\fontes\movimentacaoitens\Cotacao\pitstop\PitStop.Comunicacao.pas',
  PitStop.classe.log in '..\..\fontes\movimentacaoitens\Cotacao\pitstop\PitStop.classe.log.pas',
  Cotacao.ApiPrecos.BaseParam in '..\..\fontes\movimentacaoitens\Cotacao\apiPrecos\Cotacao.ApiPrecos.BaseParam.pas',
  untBuscaCotacaoPitStop in 'untBuscaCotacaoPitStop.pas',
  untMsgInterna in '..\..\fontes\cadastros\untMsgInterna.pas',
  Cotacao.ApiPrecos.ConstAndTypes in '..\..\fontes\movimentacaoitens\Cotacao\apiPrecos\Cotacao.ApiPrecos.ConstAndTypes.pas',
  untFuncoesSimples in 'untFuncoesSimples.pas',
  TypesLayoutPedidoCompra in '..\..\fontes\genericos\TypesLayoutPedidoCompra.pas';

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
  pIniciaProcessoPitStop;
end.
