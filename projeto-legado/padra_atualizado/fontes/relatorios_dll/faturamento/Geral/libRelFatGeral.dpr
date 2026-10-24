library libRelFatGeral;

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
  VirtualUI_AutoRun in '..\..\..\..\VirtualUI\VirtualUI_AutoRun.pas',
  VirtualUI_SDK in '..\..\..\..\VirtualUI\VirtualUI_SDK.pas',
  untPaiQck in '..\..\..\relatorios\genericos\untPaiQck.pas' {frmPaiQck},
  untConstantes in '..\..\..\genericos\untConstantes.pas',
  untCadConfRelatorios in '..\..\..\cadastros\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untPaiRelatorio in '..\..\..\relatorios\genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  untPaiSimples in '..\..\..\relatorios\genericos\untPaiSimples.pas' {frmPaiSimples},
  untRelFatGeral in '..\untRelFatGeral.pas',
  untQckFatListVenRep in '..\..\..\relatorios\faturamento\untQckFatListVenRep.pas' {frmQckFatListVenRep},
  untPaiCad in '..\..\..\relatorios\genericos\untPaiCad.pas' {frmPaiCad},
  untPai in '..\..\..\relatorios\genericos\untPai.pas' {frmPai},
  untRelCtrDebitosCliente in '..\..\..\relatorios\financeiro\contasareceber\untRelCtrDebitosCliente.pas' {frmRelCtrDebitosCliente},
  untExcel in '..\..\..\genericos\untExcel.pas',
  untIConfTinta in '..\..\..\iTintas\untIConfTinta.pas',
  untMostraGraficoEvolucao in '..\..\..\genericos\untMostraGraficoEvolucao.pas' {frmMostraGraficoEvolucao},
  untClassPanelCx in '..\..\..\libFuncoes\untClassPanelCx.pas',
  untExcelOfc in '..\..\..\genericos\untExcelOfc.pas',
  untExcelBRO in '..\..\..\genericos\untExcelBRO.pas',
  untInterfaces in '..\..\..\libNfe\untInterfaces.pas',
  untMemo in '..\..\..\genericos\untMemo.pas' {frmMemo},
  untITintasDeMaquina in '..\..\..\iTintas\untITintasDeMaquina.pas',
  untQckCtpCompPgtoMod in '..\..\..\relatorios\financeiro\contasapagar\untQckCtpCompPgtoMod.pas' {frmQckCtpCompPgtoMod: TDataModule},
  untGravando in '..\..\..\genericos\untGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\..\..\genericos\untGenericProcedureFormGravando.pas',
  untBaseListIntf in '..\..\..\genericos\untBaseListIntf.pas',
  untBaseIntf in '..\..\..\genericos\untBaseIntf.pas',
  untBaseListTypes in '..\..\..\genericos\untBaseListTypes.pas',
  untFactoryClass in '..\..\..\genericos\untFactoryClass.pas',
  untBaseClass in '..\..\..\genericos\untBaseClass.pas',
  untBaseListClass in '..\..\..\genericos\untBaseListClass.pas',
  untCadComissaoFaixaDescTabPrecoIntf in '..\..\..\cadastros\untCadComissaoFaixaDescTabPrecoIntf.pas',
  untListaLogErros in '..\..\..\genericos\untListaLogErros.pas',
  untIFuncoes in '..\..\..\relatorios\interfaces\untIFuncoes.pas',
  untTypesSistema in '..\..\..\genericos\untTypesSistema.pas',
  untInterfacedObjectNoCount in '..\..\..\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  TypesRel in '..\..\geral\TypesRel.pas',
  untDllRelatorios in '..\..\geral\untDllRelatorios.pas',
  untModulo in '..\..\geral\untModulo.pas' {frmModulo: TDataModule},
  untGeraExcel in '..\..\..\relatorios\genericos\untGeraExcel.pas',
  untICamGer in '..\..\..\cadastros\untICamGer.pas',
  untRelBocaCaixa in '..\..\..\relatorios\faturamento\untRelBocaCaixa.pas',
  untIValorRecebido in '..\..\..\relatorios\faturamento\untIValorRecebido.pas',
  untIControlePagtoFunc in '..\..\..\cadastros\untIControlePagtoFunc.pas',
  untIFastPrint in '..\..\..\util\untIFastPrint.pas',
  untIMetAno in '..\..\..\genericos\untIMetAno.pas',
  untFuncoesFactory in '..\..\..\relatorios\funcoes\untFuncoesFactory.pas',
  untIIteBar in '..\..\..\cadastros\untIIteBar.pas',
  untICamposUso in '..\..\..\genericos\untICamposUso.pas',
  untIFuncoesEditorFast in '..\..\..\util\EditorEtiquetas\untIFuncoesEditorFast.pas',
  untIOrdenacao in '..\..\..\util\EditorEtiquetas\untIOrdenacao.pas',
  untIMadeireira in '..\..\..\faturamento\untIMadeireira.pas',
  untIFinanceira in '..\..\..\faturamento\untIFinanceira.pas',
  untIFuncMacro in '..\..\..\genericos\untIFuncMacro.pas',
  untIDocumentos in '..\..\..\util\EditorEtiquetas\untIDocumentos.pas',
  untIZClient in '..\..\..\genericos\untIZClient.pas',
  untICadLote in '..\..\..\cadastros\untICadLote.pas',
  untIFiltrosRelatorio in '..\..\..\genericos\untIFiltrosRelatorio.pas',
  untIConfiguracao in '..\..\..\configuracoes\untIConfiguracao.pas',
  untCfgRel in '..\..\..\cadastros\untCfgRel.pas',
  untWorkStationInfo in '..\..\..\genericos\untWorkStationInfo.pas',
  untWord in '..\..\..\genericos\untWord.pas',
  untWordBRO in '..\..\..\genericos\untWordBRO.pas',
  untWordOfc in '..\..\..\genericos\untWordOfc.pas',
  untSpoolImpressao in '..\..\..\genericos\untSpoolImpressao.pas',
  untSpoolPrintDialog in '..\..\..\genericos\untSpoolPrintDialog.pas' {SpoolPrintDialog},
  untMenuFilas in '..\..\..\genericos\untMenuFilas.pas',
  untMenuTipImp in '..\..\..\genericos\untMenuTipImp.pas',
  untGTinForTipos in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untTipoTinta in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untIMesesGiro in '..\..\..\movimentacaoitens\PedidoDeCompra\untIMesesGiro.pas',
  untSelFilImpressao in '..\..\..\cadastros\untSelFilImpressao.pas' {frmSelFilImpressao},
  untITSQLTrace in '..\..\..\genericos\untITSQLTrace.pas',
  untPaiSQLTrace in '..\..\..\genericos\untPaiSQLTrace.pas' {frmPaiSQLTrace},
  untLogForm in '..\..\..\genericos\untLogForm.pas',
  untIFatReservaSaldo in '..\..\..\faturamento\untIFatReservaSaldo.pas',
  untIFatEntregaFutura in '..\..\..\faturamento\untIFatEntregaFutura.pas',
  untFrameDirectoryEditFocus in '..\..\..\genericos\untFrameDirectoryEditFocus.pas' {fraDirectoryEditFocus: TFrame},
  untFuncoesRel in '..\..\geral\untFuncoesRel.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R VCLStyles.res}

exports
  prelfatgeral,
  fSVN_RevisionRelFatGeral;

begin
  RlConsts.SetVersion(3,71,'B');
end.
