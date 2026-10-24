program RecalculoEntregaFuturaMonitor;

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
  untTypesSistema in '..\..\fontes\genericos\untTypesSistema.pas',
  untListaLogErros in '..\..\fontes\genericos\untListaLogErros.pas',
  untMensagem in '..\..\fontes\genericos\untMensagem.pas' {frmMensagem},
  untMensagemSonora in '..\..\fontes\genericos\untMensagemSonora.pas' {frmMensagemSonora},
  untConstantes in '..\..\fontes\genericos\untConstantes.pas',
  untGravaINNODBStatus in '..\..\fontes\genericos\untGravaINNODBStatus.pas',
  untFuncoesSimples in '..\Shared\untFuncoesSimples.pas',
  untRecalcularEntregaFutura in 'untRecalcularEntregaFutura.pas',
  untUtilMonitor in '..\..\fontes\genericos\untUtilMonitor.pas',
  untWaitWindow in '..\..\fontes\genericos\untWaitWindow.pas' {frmWaitWindow},
  untGravando in '..\..\fontes\genericos\untGravando.pas' {frmGravando},
  untThreadUtils in '..\..\fontes\genericos\untThreadUtils.pas',
  untGenericProcedureFormGravando in '..\..\fontes\genericos\untGenericProcedureFormGravando.pas',
  untLogAut in '..\..\fontes\genericos\untLogAut.pas',
  untWorkStationInfo in '..\..\fontes\genericos\untWorkStationInfo.pas',
  untSeqTmp in '..\..\fontes\genericos\untSeqTmp.pas',
  untVersaoProg in '..\..\fontes\genericos\untVersaoProg.pas',
  untTFatEntregaFutura in '..\..\fontes\faturamento\untTFatEntregaFutura.pas',
  untIFatEntregaFutura in '..\..\fontes\faturamento\untIFatEntregaFutura.pas',
  untTestabilidade in '..\..\fontes\util\testabilidade\untTestabilidade.pas',
  untCfgRepositorio in '..\..\fontes\configuracoes\untCfgRepositorio.pas' {frmCfgRepositorio: TDataModule},
  untInterfacedObjectNoCount in '..\..\fontes\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untICamposUso in '..\..\fontes\genericos\untICamposUso.pas',
  untCFGBAN_Class in '..\..\fontes\genericos\untCFGBAN_Class.pas',
  untCFGBAN_Dao in '..\..\fontes\genericos\untCFGBAN_Dao.pas',
  untSubjectClass in '..\..\fontes\genericos\untSubjectClass.pas',
  untSubjectIntf in '..\..\fontes\genericos\untSubjectIntf.pas',
  untGravandoObs in '..\..\fontes\genericos\untGravandoObs.pas',
  Yapay.Api.Resources in '..\..\fontes\financeiro\gerais\api.yapay\api\Yapay.Api.Resources.pas',
  Promocao.Regra.Preco.Sugestao in '..\..\fontes\faturamento\Promocao\Promocao.Regra.Preco.Sugestao.pas',
  untModuloLegenda in '..\..\fontes\genericos\untModuloLegenda.pas' {frmModuloLegenda: TDataModule},
  untHorarioSistema in '..\..\fontes\genericos\untHorarioSistema.pas',
  TypesLayoutPedidoCompra in '..\..\fontes\genericos\TypesLayoutPedidoCompra.pas',
  untConnection in '..\..\fontes\Core\Conexao\untConnection.pas',
  untQuery in '..\..\fontes\Core\Conexao\untQuery.pas',
  untQueryParam in '..\..\fontes\Core\Conexao\untQueryParam.pas',
  Shared.Functions.Monitores in '..\..\Packages\Shared\Functions\source\Shared.Functions.Monitores.pas';

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
  pRecalcularEntregaFutura;
end.
