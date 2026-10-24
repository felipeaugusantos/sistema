library libRelFatComissao;

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
  untGravando in '..\..\..\genericos\untGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\..\..\genericos\untGenericProcedureFormGravando.pas',
  untPaiRelatorio in '..\..\..\relatorios\genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  untPai in '..\..\..\relatorios\genericos\untPai.pas' {frmPai},
  untConstantes in '..\..\..\Genericos\untConstantes.pas',
  untTypesSistema in '..\..\..\genericos\untTypesSistema.pas',
  untFuncoesFactory in '..\..\..\relatorios\funcoes\untFuncoesFactory.pas',
  untIFuncoes in '..\..\..\relatorios\interfaces\untIFuncoes.pas',
  untClassPanelCx in '..\..\..\libFuncoes\untClassPanelCx.pas',
  untITintasDeMaquina in '..\..\..\iTintas\untITintasDeMaquina.pas',
  untICamGer in '..\..\..\cadastros\untICamGer.pas',
  untIFastPrint in '..\..\..\util\untIFastPrint.pas',
  untIFuncoesEditorFast in '..\..\..\util\EditorEtiquetas\untIFuncoesEditorFast.pas',
  untIMadeireira in '..\..\..\faturamento\untIMadeireira.pas',
  untIConfiguracao in '..\..\..\configuracoes\untIConfiguracao.pas',
  untIValorRecebido in '..\..\..\relatorios\faturamento\untIValorRecebido.pas',
  untIConfTinta in '..\..\..\Interfaces\untIConfTinta.pas',
  untIControlePagtoFunc in '..\..\..\cadastros\untIControlePagtoFunc.pas',
  untIMetAno in '..\..\..\genericos\untIMetAno.pas',
  untIIteBar in '..\..\..\cadastros\untIIteBar.pas',
  untIOrdenacao in '..\..\..\util\EditorEtiquetas\untIOrdenacao.pas',
  untIFinanceira in '..\..\..\faturamento\untIFinanceira.pas',
  untICamposUso in '..\..\..\genericos\untICamposUso.pas',
  untIFuncMacro in '..\..\..\genericos\untIFuncMacro.pas',
  untIDocumentos in '..\..\..\util\EditorEtiquetas\untIDocumentos.pas',
  untIZClient in '..\..\..\genericos\untIZClient.pas',
  untICadLote in '..\..\..\cadastros\untICadLote.pas',
  untIFiltrosRelatorio in '..\..\..\genericos\untIFiltrosRelatorio.pas',
  untGeraExcel in '..\..\..\relatorios\genericos\untGeraExcel.pas',
  untExcel in '..\..\..\genericos\untExcel.pas',
  untExcelBRO in '..\..\..\genericos\untExcelBRO.pas',
  untExcelOfc in '..\..\..\genericos\untExcelOfc.pas',
  untModulo in '..\..\geral\untModulo.pas' {frmModulo: TDataModule},
  untCadConfRelatorios in '..\..\..\cadastros\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untPaiCad in '..\..\..\relatorios\genericos\untPaiCad.pas' {frmPaiCad},
  untCfgRel in '..\..\..\cadastros\untCfgRel.pas',
  untWorkStationInfo in '..\..\..\genericos\untWorkStationInfo.pas',
  untWord in '..\..\..\genericos\untWord.pas',
  untWordBRO in '..\..\..\genericos\untWordBRO.pas',
  untWordOfc in '..\..\..\genericos\untWordOfc.pas',
  untSpoolImpressao in '..\..\..\genericos\untSpoolImpressao.pas',
  untSpoolPrintDialog in '..\..\..\genericos\untSpoolPrintDialog.pas' {SpoolPrintDialog},
  untMenuFilas in '..\..\..\genericos\untMenuFilas.pas',
  untMenuTipImp in '..\..\..\genericos\untMenuTipImp.pas',
  untRelValorRecebidoPrevia in '..\..\..\relatorios\faturamento\untRelValorRecebidoPrevia.pas',
  untRelFatComissao in '..\untRelFatComissao.pas',
  TypesRel in '..\..\geral\TypesRel.pas',
  untDllRelatorios in '..\..\geral\untDllRelatorios.pas',
  untMemo in '..\..\..\genericos\untMemo.pas' {frmMemo},
  untRelFatComFaixaDescTabPrecoIntf in '..\..\..\relatorios\faturamento\untRelFatComFaixaDescTabPrecoIntf.pas',
  untBaseIntf in '..\..\..\genericos\untBaseIntf.pas',
  untFactoryClass in '..\..\..\genericos\untFactoryClass.pas',
  untBaseClass in '..\..\..\genericos\untBaseClass.pas',
  untBaseListClass in '..\..\..\genericos\untBaseListClass.pas',
  untBaseListIntf in '..\..\..\genericos\untBaseListIntf.pas',
  untBaseListTypes in '..\..\..\genericos\untBaseListTypes.pas',
  untRelFatComFaixaDescTabPrecoClass in '..\..\..\relatorios\faturamento\untRelFatComFaixaDescTabPrecoClass.pas',
  untGTinForTipos in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untTipoTinta in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untIMesesGiro in '..\..\..\movimentacaoitens\PedidoDeCompra\untIMesesGiro.pas',
  untSelFilImpressao in '..\..\..\cadastros\untSelFilImpressao.pas' {frmSelFilImpressao},
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
  prelfatcomissao,
  fSVN_RevisionRelFatComissao;

begin
  RlConsts.SetVersion(3,71,'B');
end.
