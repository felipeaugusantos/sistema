program RomaneioIntegFusion;

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
  untModuloReplicacao in '..\Shared\untModuloReplicacao.pas' {frmModuloReplicacao: TDataModule},
  untUtilMonitor in '..\..\fontes\genericos\untUtilMonitor.pas',
  untFuncoesSimples in '..\Shared\untFuncoesSimples.pas',
  untTypesSistema in '..\..\fontes\genericos\untTypesSistema.pas',
  untListaLogErros in '..\..\fontes\genericos\untListaLogErros.pas',
  untConstantes in '..\..\fontes\genericos\untConstantes.pas',
  untCfgRepositorio in '..\..\fontes\configuracoes\untCfgRepositorio.pas' {frmCfgRepositorio: TDataModule},
  untCFGBAN_Class in '..\..\fontes\genericos\untCFGBAN_Class.pas',
  untCFGBAN_Dao in '..\..\fontes\genericos\untCFGBAN_Dao.pas',
  untInterfacedObjectNoCount in '..\..\fontes\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untICamposUso in '..\..\fontes\genericos\untICamposUso.pas',
  untMensagem in '..\..\fontes\genericos\untMensagem.pas' {frmMensagem},
  untMensagemSonora in '..\..\fontes\genericos\untMensagemSonora.pas' {frmMensagemSonora},
  untGravaINNODBStatus in '..\..\fontes\genericos\untGravaINNODBStatus.pas',
  untWaitWindow in '..\..\fontes\genericos\untWaitWindow.pas' {frmWaitWindow},
  untTestabilidade in '..\..\fontes\util\testabilidade\untTestabilidade.pas',
  untSubjectClass in '..\..\fontes\genericos\untSubjectClass.pas',
  untSubjectIntf in '..\..\fontes\genericos\untSubjectIntf.pas',
  untGravandoObs in '..\..\fontes\genericos\untGravandoObs.pas',
  untGravando in '..\..\fontes\genericos\untGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\..\fontes\genericos\untGenericProcedureFormGravando.pas',
  Yapay.Api.Resources in '..\..\fontes\financeiro\gerais\api.yapay\api\Yapay.Api.Resources.pas',
  Promocao.Regra.Preco.Sugestao in '..\..\fontes\faturamento\Promocao\Promocao.Regra.Preco.Sugestao.pas',
  untLogAut in '..\..\fontes\genericos\untLogAut.pas',
  untWorkStationInfo in '..\..\fontes\genericos\untWorkStationInfo.pas',
  untVersaoProg in '..\..\fontes\genericos\untVersaoProg.pas',
  untFusionEntregaServico in '..\..\fontes\faturamento\untFusionEntregaServico.pas',
  untFusionEntregaServicoItens in '..\..\fontes\faturamento\untFusionEntregaServicoItens.pas',
  untFusionEnvio in '..\..\fontes\faturamento\untFusionEnvio.pas',
  untFusionMotoristaAjudante in '..\..\fontes\faturamento\untFusionMotoristaAjudante.pas',
  untFusionVeiculo in '..\..\fontes\faturamento\untFusionVeiculo.pas',
  untFusionCliente in '..\..\fontes\faturamento\untFusionCliente.pas',
  untFusionWS in '..\..\fontes\faturamento\untFusionWS.pas',
  untFusionIntegWS in '..\..\fontes\faturamento\untFusionIntegWS.pas',
  untRomaneioIntegFusion in 'untRomaneioIntegFusion.pas',
  Romaneio.TemporariaDocumentos in '..\..\fontes\faturamento\Romaneio.TemporariaDocumentos.pas',
  untTObtemRomaneioIntegFusion in '..\..\fontes\faturamento\untTObtemRomaneioIntegFusion.pas',
  untFusionRomaneio in '..\..\fontes\faturamento\untFusionRomaneio.pas',
  untGravaRomaneio in '..\..\fontes\faturamento\untGravaRomaneio.pas',
  untTSituacaoPedidoVenda in '..\..\fontes\faturamento\untTSituacaoPedidoVenda.pas',
  untAtualizaOcorrenciasCRM in '..\..\fontes\crm\untAtualizaOcorrenciasCRM.pas',
  untTypesCRM in '..\..\fontes\crm\untTypesCRM.pas',
  untLegenda in '..\..\fontes\genericos\untLegenda.pas' {frmLegenda},
  untModuloLegenda in '..\..\fontes\genericos\untModuloLegenda.pas' {frmModuloLegenda: TDataModule},
  untIFuncoesCRM in '..\..\fontes\crm\untIFuncoesCRM.pas',
  untMsgInterna in '..\..\fontes\cadastros\untMsgInterna.pas',
  untValidaSituacaoFinanceiraPedido in '..\..\fontes\faturamento\untValidaSituacaoFinanceiraPedido.pas',
  untFusionCarga in '..\..\fontes\faturamento\untFusionCarga.pas',
  untThreadUtils in '..\..\fontes\genericos\untThreadUtils.pas',
  untHorarioSistema in '..\..\fontes\genericos\untHorarioSistema.pas',
  untProximoCodigo in '..\..\fontes\genericos\untProximoCodigo.pas',
  untFiredac in '..\..\fontes\Core\Conexao\untFiredac.pas',
  untUnidac in '..\..\fontes\Core\Conexao\untUnidac.pas',
  untConnection in '..\..\fontes\Core\Conexao\untConnection.pas',
  untQuery in '..\..\fontes\Core\Conexao\untQuery.pas',
  untQueryParam in '..\..\fontes\Core\Conexao\untQueryParam.pas',
  Romaneio.Types in '..\..\fontes\faturamento\Romaneio.Types.pas',
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
  pRomaneioIntegFusion;
end.
