library libRelEstoque;

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
  untConstantes in '..\..\genericos\untConstantes.pas',
  untPaiSimples in '..\..\relatorios\genericos\untPaiSimples.pas' {frmPaiSimples},
  untRelEstoque in 'untRelEstoque.pas',
  untPaiEdit in '..\..\genericos\untPaiEdit.pas' {frmPaiEdit},
  untExcel in '..\..\genericos\untExcel.pas',
  untClassPanelCx in '..\..\libFuncoes\untClassPanelCx.pas',
  untITintasDeMaquina in '..\..\iTintas\untITintasDeMaquina.pas',
  untIConfTinta in '..\..\iTintas\untIConfTinta.pas',
  untExcelOfc in '..\..\genericos\untExcelOfc.pas',
  untExcelBRO in '..\..\genericos\untExcelBRO.pas',
  untIConfiguracao in '..\..\configuracoes\untIConfiguracao.pas',
  untGravando in '..\..\genericos\untGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\..\genericos\untGenericProcedureFormGravando.pas',
  untModuloSPR in '..\..\Genericos\untModuloSPR.pas' {frmModuloSPR: TDataModule},
  untAnaliticoEmbSep in '..\..\relatorios\estoque\untAnaliticoEmbSep.pas' {frmAnaliticoEmbSep: TDataModule},
  untIFuncoes in '..\..\relatorios\interfaces\untIFuncoes.pas',
  untTypesSistema in '..\..\genericos\untTypesSistema.pas',
  untICamGer in '..\..\cadastros\untICamGer.pas',
  untIControlePagtoFunc in '..\..\cadastros\untIControlePagtoFunc.pas',
  untIValorRecebido in '..\..\relatorios\faturamento\untIValorRecebido.pas',
  untIFastPrint in '..\..\util\untIFastPrint.pas',
  untIMetAno in '..\..\genericos\untIMetAno.pas',
  untInterfacedObjectNoCount in '..\..\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  TypesRel in '..\geral\TypesRel.pas',
  untPaiQck in '..\..\relatorios\genericos\untPaiQck.pas' {frmPaiQck},
  untModulo in '..\geral\untModulo.pas' {frmModulo: TDataModule},
  untPai in '..\..\relatorios\genericos\untPai.pas' {frmPai},
  untFuncoesFactory in '..\..\relatorios\funcoes\untFuncoesFactory.pas',
  untStyleHookFix in '..\..\genericos\untStyleHookFix.pas',
  untIIteBar in '..\..\cadastros\untIIteBar.pas',
  untIFuncoesEditorFast in '..\..\util\EditorEtiquetas\untIFuncoesEditorFast.pas',
  untIOrdenacao in '..\..\util\EditorEtiquetas\untIOrdenacao.pas',
  untIMadeireira in '..\..\faturamento\untIMadeireira.pas',
  untIFinanceira in '..\..\faturamento\untIFinanceira.pas',
  untIDocumentos in '..\..\util\EditorEtiquetas\untIDocumentos.pas',
  untICamposUso in '..\..\genericos\untICamposUso.pas',
  untIFuncMacro in '..\..\genericos\untIFuncMacro.pas',
  untIZClient in '..\..\genericos\untIZClient.pas',
  untPaiCad in '..\..\relatorios\genericos\untPaiCad.pas' {frmPaiCad},
  untCadConfRelatorios in '..\..\cadastros\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untPaiRelatorio in '..\..\relatorios\genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  untGeraExcel in '..\..\relatorios\genericos\untGeraExcel.pas',
  untICadLote in '..\..\cadastros\untICadLote.pas',
  untIFiltrosRelatorio in '..\..\genericos\untIFiltrosRelatorio.pas',
  untPaiOrdena in '..\..\relatorios\genericos\untPaiOrdena.pas' {frmPaiOrdena},
  untDllRelatorios in '..\geral\untDllRelatorios.pas',
  untCfgRel in '..\..\cadastros\untCfgRel.pas',
  untWorkStationInfo in '..\..\genericos\untWorkStationInfo.pas',
  untWord in '..\..\genericos\untWord.pas',
  untWordBRO in '..\..\genericos\untWordBRO.pas',
  untWordOfc in '..\..\genericos\untWordOfc.pas',
  untSpoolImpressao in '..\..\genericos\untSpoolImpressao.pas',
  untSpoolPrintDialog in '..\..\genericos\untSpoolPrintDialog.pas' {SpoolPrintDialog},
  untMenuFilas in '..\..\genericos\untMenuFilas.pas',
  untMenuTipImp in '..\..\genericos\untMenuTipImp.pas',
  untGTinForTipos in '..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untTipoTinta in '..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untIMesesGiro in '..\..\movimentacaoitens\PedidoDeCompra\untIMesesGiro.pas',
  untSelFilImpressao in '..\..\cadastros\untSelFilImpressao.pas' {frmSelFilImpressao},
  untITSQLTrace in '..\..\genericos\untITSQLTrace.pas',
  untPaiSQLTrace in '..\..\genericos\untPaiSQLTrace.pas' {frmPaiSQLTrace},
  untLogForm in '..\..\genericos\untLogForm.pas',
  untConsultaCadAcaLojas in '..\..\..\..\AutcomTinta\untConsultaCadAcaLojas.pas' {frmConsultaCadAcaLojas},
  untIFatReservaSaldo in '..\..\faturamento\untIFatReservaSaldo.pas',
  untIFatEntregaFutura in '..\..\faturamento\untIFatEntregaFutura.pas',
  untFrameDirectoryEditFocus in '..\..\genericos\untFrameDirectoryEditFocus.pas' {fraDirectoryEditFocus: TFrame},
  untFuncoesRel in '..\geral\untFuncoesRel.pas';


{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R VCLStyles.res}

exports
  prelestoque,
  fSVN_RevisionRelEstoque;

begin
  RlConsts.SetVersion(3,71,'B');
end.

