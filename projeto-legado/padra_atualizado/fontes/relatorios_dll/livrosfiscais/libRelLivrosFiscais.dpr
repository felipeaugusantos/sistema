library libRelLivrosFiscais;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  SysUtils,
  Classes,
  MidasLib,
  RlConsts,
  Windows,
  VirtualUI_AutoRun in '..\..\..\VirtualUI\VirtualUI_AutoRun.pas',
  VirtualUI_SDK in '..\..\..\VirtualUI\VirtualUI_SDK.pas',
  untPaiQck in '..\..\relatorios\genericos\untPaiQck.pas' {frmPaiQck},
  untModulo in '..\geral\untModulo.pas' {frmModulo: TDataModule},
  untConstantes in '..\..\genericos\untConstantes.pas',
  untModuloSPR in '..\..\genericos\untModuloSPR.pas' {frmModuloSPR: TDataModule},
  untModuloCfgAtb in '..\..\genericos\untModuloCfgAtb.pas' {frmModuloCfgAtb: TDataModule},
  untCadConfRelatorios in '..\..\cadastros\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untPaiRelatorio in '..\..\relatorios\genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  untGravando in '..\..\genericos\untGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\..\genericos\untGenericProcedureFormGravando.pas',
  untPaiSimples in '..\..\relatorios\genericos\untPaiSimples.pas' {frmPaiSimples},
  untFrameSheet in '..\..\relatorios\fiscais\untFrameSheet.pas',
  untFrameICMSIPI in '..\..\relatorios\fiscais\untFrameICMSIPI.pas' {frmFrameICMSIPI: TFrame},
  untRelFiscOpeInterSaidas in '..\..\Relatorios\Fiscais\untRelFiscOpeInterSaidas.pas' {frmRelFiscOpeInterSaidas},
  untWaitWindow in '..\..\genericos\untWaitWindow.pas' {frmWaitWindow},
  untPaiCad in '..\..\relatorios\genericos\untPaiCad.pas' {frmPaiCad},
  untPai in '..\..\relatorios\genericos\untPai.pas' {frmPai},
  untQckHTMLCliente in '..\..\relatorios\cadastros\untQckHTMLCliente.pas' {frmQckHTMLCliente},
  untRelCtrDebitosCliente in '..\..\relatorios\financeiro\contasareceber\untRelCtrDebitosCliente.pas' {frmRelCtrDebitosCliente},
  untGetMenu in '..\..\genericos\untGetMenu.pas' {frmGetMenu},
  untClassPanelCx in '..\..\libFuncoes\untClassPanelCx.pas',
  untGeraExcel in '..\..\relatorios\genericos\untGeraExcel.pas',
  untExcel in '..\..\genericos\untExcel.pas',
  untExcelOfc in '..\..\genericos\untExcelOfc.pas',
  untExcelBRO in '..\..\genericos\untExcelBRO.pas',
  untMemo in '..\..\genericos\untMemo.pas' {frmMemo},
  untIConfiguracao in '..\..\configuracoes\untIConfiguracao.pas',
  untListaLogErros in '..\..\genericos\untListaLogErros.pas',
  untTypesSistema in '..\..\genericos\untTypesSistema.pas',
  untITintasDeMaquina in '..\..\iTintas\untITintasDeMaquina.pas',
  untICamGer in '..\..\cadastros\untICamGer.pas',
  untIControlePagtoFunc in '..\..\cadastros\untIControlePagtoFunc.pas',
  untIValorRecebido in '..\..\relatorios\faturamento\untIValorRecebido.pas',
  untIConfTinta in '..\..\iTintas\untIConfTinta.pas',
  untIFastPrint in '..\..\util\untIFastPrint.pas',
  untIMetAno in '..\..\genericos\untIMetAno.pas',
  untInterfacedObjectNoCount in '..\..\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untIIteBar in '..\..\cadastros\untIIteBar.pas',
  untICamposUso in '..\..\genericos\untICamposUso.pas',
  TypesRel in '..\geral\TypesRel.pas',
  untFuncoesFactory in '..\..\relatorios\funcoes\untFuncoesFactory.pas',
  untIFuncoes in '..\..\relatorios\interfaces\untIFuncoes.pas',
  untRelFiscOpeInterEntradas in '..\..\Relatorios\Fiscais\untRelFiscOpeInterEntradas.pas' {frmRelFiscOpeInterEntradas},
  untRelLIvrosFiscais in 'untRelLIvrosFiscais.pas',
  untIFuncoesEditorFast in '..\..\util\EditorEtiquetas\untIFuncoesEditorFast.pas',
  untIOrdenacao in '..\..\util\EditorEtiquetas\untIOrdenacao.pas',
  untIMadeireira in '..\..\faturamento\untIMadeireira.pas',
  untIFinanceira in '..\..\faturamento\untIFinanceira.pas',
  untIFuncMacro in '..\..\genericos\untIFuncMacro.pas',
  untIDocumentos in '..\..\util\EditorEtiquetas\untIDocumentos.pas',
  untIZClient in '..\..\genericos\untIZClient.pas',
  untDllRelatorios in '..\geral\untDllRelatorios.pas',
  untICadLote in '..\..\cadastros\untICadLote.pas',
  untCfgRel in '..\..\cadastros\untCfgRel.pas',
  untWord in '..\..\genericos\untWord.pas',
  untWordBRO in '..\..\genericos\untWordBRO.pas',
  untWordOfc in '..\..\genericos\untWordOfc.pas',
  untWorkStationInfo in '..\..\genericos\untWorkStationInfo.pas',
  untSpoolImpressao in '..\..\genericos\untSpoolImpressao.pas',
  untSpoolPrintDialog in '..\..\genericos\untSpoolPrintDialog.pas' {SpoolPrintDialog},
  untMenuFilas in '..\..\genericos\untMenuFilas.pas',
  untMenuTipImp in '..\..\genericos\untMenuTipImp.pas',
  untIFiltrosRelatorio in '..\..\genericos\untIFiltrosRelatorio.pas',
  untAjusteICMST in '..\..\relatorios\fiscais\untAjusteICMST.pas' {frmAjusteICMST},
  untGTinForTipos in '..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untTipoTinta in '..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untIMesesGiro in '..\..\movimentacaoitens\PedidoDeCompra\untIMesesGiro.pas',
  untIConsulta in '..\..\Interfaces\untIConsulta.pas',
  untSelFilImpressao in '..\..\cadastros\untSelFilImpressao.pas' {frmSelFilImpressao},
  untITSQLTrace in '..\..\genericos\untITSQLTrace.pas',
  untPaiSQLTrace in '..\..\genericos\untPaiSQLTrace.pas' {frmPaiSQLTrace},
  untLogForm in '..\..\genericos\untLogForm.pas',
  untTNotaFiscal in '..\..\relatorios\fiscais\Classes Genericas\untTNotaFiscal.pas',
  untIRepositorioAjusteIcms in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untIRepositorioAjusteIcms.pas',
  untTAjusteIcms in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untTAjusteIcms.pas',
  untTApuradorAjustesIcms in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untTApuradorAjustesIcms.pas',
  untTDadosDifal in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untTDadosDifal.pas',
  untTRepositorioAjusteIcms in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untTRepositorioAjusteIcms.pas',
  untTRepositorioAjusteIcmsAbstract in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untTRepositorioAjusteIcmsAbstract.pas',
  untTRepositorioAjusteIcmsDocumento in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untTRepositorioAjusteIcmsDocumento.pas',
  untTRepositorioAjusteIcmsFactory in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untTRepositorioAjusteIcmsFactory.pas',
  untTRepositorioAjusteIcmsProduto in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untTRepositorioAjusteIcmsProduto.pas',
  untTDadosCreditoCat158 in '..\..\relatorios\fiscais\Classes Ajustes Impostos\untTDadosCreditoCat158.pas',
  untIFatReservaSaldo in '..\..\faturamento\untIFatReservaSaldo.pas',
  untIFatEntregaFutura in '..\..\faturamento\untIFatEntregaFutura.pas',
  untFrameDirectoryEditFocus in '..\..\genericos\untFrameDirectoryEditFocus.pas' {fraDirectoryEditFocus: TFrame},
  untFuncoesRel in '..\geral\untFuncoesRel.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R VCLStyles.res}

exports
  prellivrosfiscais,
  fSVN_RevisionRelFiscais;

begin
  RlConsts.SetVersion(3,71,'B');
end.
