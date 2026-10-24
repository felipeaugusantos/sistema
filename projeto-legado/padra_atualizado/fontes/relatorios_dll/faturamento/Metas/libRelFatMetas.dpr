library libRelFatMetas;

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
  System.SysUtils,
  System.Classes,
  RlConsts,
  MidasLib,
  Windows,
  VirtualUI_AutoRun in '..\..\..\..\VirtualUI\VirtualUI_AutoRun.pas',
  VirtualUI_SDK in '..\..\..\..\VirtualUI\VirtualUI_SDK.pas',
  untPaiRelatorio in '..\..\..\relatorios\genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  untPai in '..\..\..\relatorios\genericos\untPai.pas' {frmPai},
  untConstantes in '..\..\..\Genericos\untConstantes.pas',
  untTypesSistema in '..\..\..\genericos\untTypesSistema.pas',
  untFuncoesFactory in '..\..\..\relatorios\funcoes\untFuncoesFactory.pas',
  untIFuncoes in '..\..\..\relatorios\interfaces\untIFuncoes.pas',
  untClassPanelCx in '..\..\..\libFuncoes\untClassPanelCx.pas',
  untITintasDeMaquina in '..\..\..\iTintas\untITintasDeMaquina.pas',
  untICamGer in '..\..\..\cadastros\untICamGer.pas',
  untIValorRecebido in '..\..\..\relatorios\faturamento\untIValorRecebido.pas',
  untIConfTinta in '..\..\..\Interfaces\untIConfTinta.pas',
  untIControlePagtoFunc in '..\..\..\cadastros\untIControlePagtoFunc.pas',
  untIFastPrint in '..\..\..\util\untIFastPrint.pas',
  untIMetAno in '..\..\..\genericos\untIMetAno.pas',
  untIFuncoesEditorFast in '..\..\..\util\EditorEtiquetas\untIFuncoesEditorFast.pas',
  untIIteBar in '..\..\..\cadastros\untIIteBar.pas',
  untIOrdenacao in '..\..\..\util\EditorEtiquetas\untIOrdenacao.pas',
  untIMadeireira in '..\..\..\faturamento\untIMadeireira.pas',
  untIFinanceira in '..\..\..\faturamento\untIFinanceira.pas',
  untIFuncMacro in '..\..\..\genericos\untIFuncMacro.pas',
  untIDocumentos in '..\..\..\util\EditorEtiquetas\untIDocumentos.pas',
  untICamposUso in '..\..\..\genericos\untICamposUso.pas',
  untIZClient in '..\..\..\genericos\untIZClient.pas',
  untICadLote in '..\..\..\cadastros\untICadLote.pas',
  untIConfiguracao in '..\..\..\configuracoes\untIConfiguracao.pas',
  untIFiltrosRelatorio in '..\..\..\genericos\untIFiltrosRelatorio.pas',
  untGeraExcel in '..\..\..\relatorios\genericos\untGeraExcel.pas',
  untExcel in '..\..\..\genericos\untExcel.pas',
  untExcelBRO in '..\..\..\genericos\untExcelBRO.pas',
  untExcelOfc in '..\..\..\genericos\untExcelOfc.pas',
  untModulo in '..\..\geral\untModulo.pas' {frmModulo: TDataModule},
  TypesRel in '..\..\geral\TypesRel.pas',
  untCadConfRelatorios in '..\..\..\cadastros\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untPaiCad in '..\..\..\relatorios\genericos\untPaiCad.pas' {frmPaiCad},
  untPaiQck in '..\..\..\relatorios\genericos\untPaiQck.pas' {frmPaiQck},
  untGravando in '..\..\..\genericos\untGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\..\..\genericos\untGenericProcedureFormGravando.pas',
  untRelFatMetas in '..\untRelFatMetas.pas',
  untDllRelatorios in '..\..\geral\untDllRelatorios.pas',
  untCfgRel in '..\..\..\cadastros\untCfgRel.pas',
  untWorkStationInfo in '..\..\..\genericos\untWorkStationInfo.pas',
  untSpoolImpressao in '..\..\..\genericos\untSpoolImpressao.pas',
  untWord in '..\..\..\genericos\untWord.pas',
  untWordBRO in '..\..\..\genericos\untWordBRO.pas',
  untWordOfc in '..\..\..\genericos\untWordOfc.pas',
  untSpoolPrintDialog in '..\..\..\genericos\untSpoolPrintDialog.pas' {SpoolPrintDialog},
  untMenuFilas in '..\..\..\genericos\untMenuFilas.pas',
  untMenuTipImp in '..\..\..\genericos\untMenuTipImp.pas',
  untGTinForTipos in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untTipoTinta in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untIMesesGiro in '..\..\..\movimentacaoitens\PedidoDeCompra\untIMesesGiro.pas',
  untSelFilImpressao in '..\..\..\cadastros\untSelFilImpressao.pas' {frmSelFilImpressao},
  untLogForm in '..\..\..\genericos\untLogForm.pas',
  untRelFatMetasVendedorFreteIntf in '..\..\..\relatorios\faturamento\untRelFatMetasVendedorFreteIntf.pas',
  untRelFatMetasVendedorFreteTypes in '..\..\..\relatorios\faturamento\untRelFatMetasVendedorFreteTypes.pas',
  untMetasVendedorFreteBussines in '..\..\..\relatorios\faturamento\untMetasVendedorFreteBussines.pas',
  untMetasVendedorFreteDao in '..\..\..\relatorios\faturamento\untMetasVendedorFreteDao.pas',
  untBaseIntf in '..\..\..\genericos\untBaseIntf.pas',
  untFactoryClass in '..\..\..\genericos\untFactoryClass.pas',
  untBaseClass in '..\..\..\genericos\untBaseClass.pas',
  untBaseListTypes in '..\..\..\genericos\untBaseListTypes.pas',
  untBaseListIntf in '..\..\..\genericos\untBaseListIntf.pas',
  untBaseListClass in '..\..\..\genericos\untBaseListClass.pas',
  untIFatReservaSaldo in '..\..\..\faturamento\untIFatReservaSaldo.pas',
  untIFatEntregaFutura in '..\..\..\faturamento\untIFatEntregaFutura.pas',
  untFrameDirectoryEditFocus in '..\..\..\genericos\untFrameDirectoryEditFocus.pas' {fraDirectoryEditFocus: TFrame},
  untFuncoesRel in '..\..\geral\untFuncoesRel.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R VCLStyles.res}

exports
  prelfatmetas,
  fSVN_RevisionRelFatMetas;

begin
  RlConsts.SetVersion(3,71,'B');
end.

