library libRelPedidosDeVenda;

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
  untModuloSPR in '..\..\Genericos\untModuloSPR.pas' {frmModuloSPR: TDataModule},
  untPaiSimples in '..\..\Relatorios\Genericos\untPaiSimples.pas' {frmPaiSimples},
  untRelPedidosDeVenda in 'untRelPedidosDeVenda.pas',
  untExcel in '..\..\genericos\untExcel.pas',
  untClassPanelCx in '..\..\libFuncoes\untClassPanelCx.pas',
  untExcelOfc in '..\..\genericos\untExcelOfc.pas',
  untExcelBRO in '..\..\genericos\untExcelBRO.pas',
  untModuloRelPedDocProd in '..\..\relatorios\pedidosvenda\untModuloRelPedDocProd.pas' {frmModuloRelPedDocProd: TDataModule},
  untModuloRelPedDocDoc in '..\..\relatorios\pedidosvenda\untModuloRelPedDocDoc.pas' {frmModuloRelPedDocDoc: TDataModule},
  untIFuncoes in '..\..\relatorios\interfaces\untIFuncoes.pas',
  untTypesSistema in '..\..\genericos\untTypesSistema.pas',
  untMenuFilas in '..\..\genericos\untMenuFilas.pas',
  untMenuTipImp in '..\..\genericos\untMenuTipImp.pas',
  untITintasDeMaquina in '..\..\iTintas\untITintasDeMaquina.pas',
  untICamGer in '..\..\cadastros\untICamGer.pas',
  untIControlePagtoFunc in '..\..\cadastros\untIControlePagtoFunc.pas',
  untIValorRecebido in '..\..\relatorios\faturamento\untIValorRecebido.pas',
  untIConfTinta in '..\..\iTintas\untIConfTinta.pas',
  untIFastPrint in '..\..\util\untIFastPrint.pas',
  untIMetAno in '..\..\genericos\untIMetAno.pas',
  untInterfacedObjectNoCount in '..\..\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  TypesRel in '..\geral\TypesRel.pas',
  untFuncoesFactory in '..\..\relatorios\funcoes\untFuncoesFactory.pas',
  untDllRelatorios in '..\geral\untDllRelatorios.pas',
  untModulo in '..\geral\untModulo.pas' {frmModulo: TDataModule},
  untPai in '..\..\relatorios\genericos\untPai.pas' {frmPai},
  untCadConfRelatorios in '..\..\relatorios\genericos\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untPaiCad in '..\..\relatorios\genericos\untPaiCad.pas' {frmPaiCad},
  untPaiRelatorio in '..\..\relatorios\genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  untGeraExcel in '..\..\relatorios\genericos\untGeraExcel.pas',
  untPaiQck in '..\..\relatorios\genericos\untPaiQck.pas' {frmPaiQck},
  untIIteBar in '..\..\cadastros\untIIteBar.pas',
  untIFuncoesEditorFast in '..\..\util\EditorEtiquetas\untIFuncoesEditorFast.pas',
  untIOrdenacao in '..\..\util\EditorEtiquetas\untIOrdenacao.pas',
  untIMadeireira in '..\..\faturamento\untIMadeireira.pas',
  untIFinanceira in '..\..\faturamento\untIFinanceira.pas',
  untIFuncMacro in '..\..\genericos\untIFuncMacro.pas',
  untICamposUso in '..\..\genericos\untICamposUso.pas',
  untIDocumentos in '..\..\util\EditorEtiquetas\untIDocumentos.pas',
  untIZClient in '..\..\genericos\untIZClient.pas',
  untICadLote in '..\..\cadastros\untICadLote.pas',
  untIFiltrosRelatorio in '..\..\genericos\untIFiltrosRelatorio.pas',
  untCfgRel in '..\..\relatorios\genericos\untCfgRel.pas',
  untIConfiguracao in '..\..\configuracoes\untIConfiguracao.pas',
  untGTinForTipos in '..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untTipoTinta in '..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untIMesesGiro in '..\..\movimentacaoitens\PedidoDeCompra\untIMesesGiro.pas',
  untSelFilImpressao in '..\..\cadastros\untSelFilImpressao.pas' {frmSelFilImpressao},
  untITSQLTrace in '..\..\genericos\untITSQLTrace.pas',
  untPaiSQLTrace in '..\..\genericos\untPaiSQLTrace.pas' {frmPaiSQLTrace},
  untLogForm in '..\..\genericos\untLogForm.pas',
  untIFatReservaSaldo in '..\..\faturamento\untIFatReservaSaldo.pas',
  untFrameDirectoryEditFocus in '..\..\genericos\untFrameDirectoryEditFocus.pas' {fraDirectoryEditFocus: TFrame};

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

exports
  prelpedidosdevenda,
  fSVN_RevisionRelPedVenda;

begin
  RlConsts.SetVersion(3,71,'B');
end.
