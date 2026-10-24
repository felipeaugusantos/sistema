program ConsultaPagamentosPixMonitor;

uses
  ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.SysUtils,
  Winapi.Windows,
  MidasLib,
  Vcl.Forms,
  untLogAut in 'untLogAut.pas',
  untFuncoesSimples in 'untFuncoesSimples.pas',
  untConsultaPagamentosPix in 'untConsultaPagamentosPix.pas',
  untConstantes in '..\..\fontes\genericos\untConstantes.pas',
  untCfgRepositorio in '..\..\fontes\configuracoes\untCfgRepositorio.pas' {frmCfgRepositorio: TDataModule},
  untInterfacedObjectNoCount in '..\..\fontes\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untModulo in 'fontes\gerais\untModulo.pas' {frmModulo: TDataModule},
  untModuloReplicacao in '..\..\fontes\genericos\untModuloReplicacao.pas' {frmModuloReplicacao: TDataModule},
  untTestabilidade in '..\..\fontes\util\testabilidade\untTestabilidade.pas',
  untListaLogErros in '..\..\fontes\genericos\untListaLogErros.pas',
  untGravaINNODBStatus in '..\..\fontes\genericos\untGravaINNODBStatus.pas',
  untWaitWindow in '..\..\fontes\genericos\untWaitWindow.pas' {frmWaitWindow},
  untGravandoObs in '..\..\fontes\genericos\untGravandoObs.pas',
  untSubjectClass in '..\..\fontes\genericos\untSubjectClass.pas',
  untSubjectIntf in '..\..\fontes\genericos\untSubjectIntf.pas',
  untGenericProcedureFormGravando in '..\..\fontes\genericos\untGenericProcedureFormGravando.pas',
  Yapay.Api.Resources in '..\..\fontes\financeiro\gerais\api.yapay\api\Yapay.Api.Resources.pas',
  Promocao.Regra.Preco.Sugestao in '..\..\fontes\faturamento\Promocao\Promocao.Regra.Preco.Sugestao.pas',
  untTLogMpx in '..\..\fontes\financeiro\pix\untTLogMpx.pas',
  untVersaoProg in '..\..\fontes\genericos\untVersaoProg.pas',
  untAdiantamentoClienteGenerico in 'fontes\adiantamento\untAdiantamentoClienteGenerico.pas',
  untAdiantamentoCliente in 'fontes\adiantamento\untAdiantamentoCliente.pas',
  untTBanCtr in '..\..\fontes\financeiro\gerais\untTBanCtr.pas',
  untTBanCtrRepository in '..\..\fontes\financeiro\gerais\untTBanCtrRepository.pas',
  untTCadCli in '..\..\fontes\cadastros\untTCadCli.pas',
  untTCadCliRepository in '..\..\fontes\cadastros\untTCadCliRepository.pas',
  untMovBan in '..\..\fontes\financeiro\gerais\untMovBan.pas',
  untLogBan in '..\..\fontes\financeiro\gerais\untLogBan.pas',
  untFieldFiltros in '..\..\fontes\CamadaPersistencia\untFieldFiltros.pas',
  untObjectManager in '..\..\fontes\CamadaPersistencia\untObjectManager.pas',
  untUtilRepository in '..\..\fontes\CamadaPersistencia\untUtilRepository.pas',
  untTBanTrf in '..\..\fontes\financeiro\gerais\untTBanTrf.pas',
  untLogCba in '..\..\fontes\financeiro\gerais\untLogCba.pas',
  untTMovBan in '..\..\fontes\financeiro\gerais\untTMovBan.pas',
  untTMovBanRepository in '..\..\fontes\financeiro\gerais\untTMovBanRepository.pas',
  untTCadPag in '..\..\fontes\financeiro\contasapagar\untTCadPag.pas',
  untTCadFor in '..\..\fontes\cadastros\untTCadFor.pas',
  untWorkStationInfo in '..\..\fontes\genericos\untWorkStationInfo.pas',
  untTFuncoesPixMonitor in 'fontes\gerais\untTFuncoesPixMonitor.pas',
  untTIntegracaoPixCitel in '..\..\fontes\financeiro\pix\untTIntegracaoPixCitel.pas',
  untMsgInterna in '..\..\fontes\cadastros\untMsgInterna.pas',
  untDataSetIDataSetWrapper in '..\..\fontes\Dataset\untDataSetIDataSetWrapper.pas',
  untFieldDataSetFieldWrapper in '..\..\fontes\Dataset\untFieldDataSetFieldWrapper.pas',
  untIDataSet in '..\..\fontes\Dataset\untIDataSet.pas',
  untParamDataSetWrapper in '..\..\fontes\Dataset\untParamDataSetWrapper.pas',
  untUniQueryDataSetWrapper in '..\..\fontes\Dataset\untUniQueryDataSetWrapper.pas',
  untFuncoes in 'fontes\gerais\untFuncoes.pas',
  untTFuncoesAuxiliaresPix in '..\..\..\libIntegracaoPixCitel\fontes\requisicoes\untTFuncoesAuxiliaresPix.pas',
  untCFGBAN_Class in 'fontes\dependencias\untCFGBAN_Class.pas',
  untCFGBAN_Dao in 'fontes\dependencias\untCFGBAN_Dao.pas',
  untTiposPix in '..\..\..\libIntegracaoPixCitel\fontes\genericos\untTiposPix.pas',
  untTContasAReceberPix in 'fontes\financeiro\untTContasAReceberPix.pas',
  untLogCtr in 'fontes\financeiro\untLogCtr.pas',
  untIIntegracaoPixCitel in 'fontes\gerais\untIIntegracaoPixCitel.pas',
  untTBanMca in '..\..\fontes\financeiro\gerais\untTBanMca.pas',
  untTCadCar in '..\..\fontes\cadastros\untTCadCar.pas',
  untTPixDao in 'fontes\financeiro\untTPixDao.pas',
  untHorarioSistema in '..\..\fontes\genericos\untHorarioSistema.pas',
  untMensagem in 'fontes\gerais\untMensagem.pas' {frmMensagem},
  untGravando in '..\..\fontes\genericos\untGravando.pas' {frmGravando},
  untTelasAbertas in 'fontes\gerais\untTelasAbertas.pas',
  untTypesSistema in 'fontes\gerais\untTypesSistema.pas',
  untImagemBase64 in 'fontes\gerais\untImagemBase64.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

Var
  FMonitorPix: TMonitorPix;

begin
  Application.Initialize;
  Try
    FMonitorPix := TMonitorPix.Create;
    FMonitorPix.ConsultaPagamentosPix;
  Finally
    FreeAndNil(FMonitorPix);
  End;
end.
