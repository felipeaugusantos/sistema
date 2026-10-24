library libRelChequesPre;

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
  untRelChqInclDiarias in '..\..\Relatorios\Financeiro\ChequePre\untRelChqInclDiarias.pas' {frmRelChqInclDiarias},
  untConstantes in '..\..\genericos\untConstantes.pas',
  untModuloSPR in '..\..\Genericos\untModuloSPR.pas' {frmModuloSPR: TDataModule},
  untRelChequesPre in 'untRelChequesPre.pas',
  untRelChqRepassados in '..\..\Relatorios\Financeiro\ChequePre\untRelChqRepassados.pas' {frmRelChqRepassados},
  untRelChqPredatados in '..\..\Relatorios\Financeiro\ChequePre\untRelChqPredatados.pas' {frmRelChqPredatados},
  untRelChqDevolvidos in '..\..\Relatorios\Financeiro\ChequePre\untRelChqDevolvidos.pas' {frmRelChqDevolvidos},
  untRelChqEmCustodia in '..\..\Relatorios\Financeiro\ChequePre\untRelChqEmCustodia.pas' {frmRelChqEmCustodia},
  untPaiSimples in '..\..\Genericos\untPaiSimples.pas' {frmPaiSimples},
  untClassPanelCx in '..\..\libFuncoes\untClassPanelCx.pas',
  untExcelOfc in '..\..\genericos\untExcelOfc.pas',
  untExcelBRO in '..\..\genericos\untExcelBRO.pas',
  untExcel in '..\..\genericos\untExcel.pas',
  untIFuncoes in '..\..\relatorios\interfaces\untIFuncoes.pas',
  untTypesSistema in '..\..\genericos\untTypesSistema.pas',
  untITintasDeMaquina in '..\..\iTintas\untITintasDeMaquina.pas',
  untICamGer in '..\..\cadastros\untICamGer.pas',
  untIControlePagtoFunc in '..\..\cadastros\untIControlePagtoFunc.pas',
  untIValorRecebido in '..\..\relatorios\faturamento\untIValorRecebido.pas',
  untIConfTinta in '..\..\iTintas\untIConfTinta.pas',
  untIFastPrint in '..\..\util\untIFastPrint.pas',
  untIMetAno in '..\..\genericos\untIMetAno.pas',
  untInterfacedObjectNoCount in '..\..\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untPaiQck in '..\..\relatorios\genericos\untPaiQck.pas' {frmPaiQck},
  untFuncoesFactory in '..\..\relatorios\funcoes\untFuncoesFactory.pas',
  untModulo in '..\geral\untModulo.pas' {frmModulo: TDataModule},
  untPai in '..\..\relatorios\genericos\untPai.pas' {frmPai},
  untPaiCad in '..\..\relatorios\genericos\untPaiCad.pas' {frmPaiCad},
  untCadConfRelatorios in '..\..\cadastros\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untPaiRelatorio in '..\..\relatorios\genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  untGeraExcel in '..\..\relatorios\genericos\untGeraExcel.pas',
  TypesRel in '..\geral\TypesRel.pas',
  untDllRelatorios in '..\geral\untDllRelatorios.pas',
  untReimpressaoBorderoTelecheque in '..\..\relatorios\financeiro\chequepre\untReimpressaoBorderoTelecheque.pas' {frmReimpressaoBorderoTelecheque},
  untModuloBaixaChequesTelecheque in '..\..\financeiro\chequepre\untModuloBaixaChequesTelecheque.pas' {frmModuloBaixaChequesTelecheque: TDataModule},
  untIIteBar in '..\..\cadastros\untIIteBar.pas',
  untIFuncoesEditorFast in '..\..\util\EditorEtiquetas\untIFuncoesEditorFast.pas',
  untIOrdenacao in '..\..\util\EditorEtiquetas\untIOrdenacao.pas',
  untIMadeireira in '..\..\faturamento\untIMadeireira.pas',
  untIFinanceira in '..\..\faturamento\untIFinanceira.pas',
  untICamposUso in '..\..\genericos\untICamposUso.pas',
  untIFuncMacro in '..\..\genericos\untIFuncMacro.pas',
  untIDocumentos in '..\..\util\EditorEtiquetas\untIDocumentos.pas',
  untIZClient in '..\..\genericos\untIZClient.pas',
  untICadLote in '..\..\cadastros\untICadLote.pas',
  untIFiltrosRelatorio in '..\..\genericos\untIFiltrosRelatorio.pas',
  untCfgRel in '..\..\cadastros\untCfgRel.pas',
  untMenuFilas in '..\..\genericos\untMenuFilas.pas',
  untMenuTipImp in '..\..\genericos\untMenuTipImp.pas',
  untIConfiguracao in '..\..\configuracoes\untIConfiguracao.pas',
  untRelChqLogAcomp in '..\..\relatorios\financeiro\chequepre\untRelChqLogAcomp.pas' {frmRelChqLogAcomp},
  untGTinForTipos in '..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untTipoTinta in '..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untIMesesGiro in '..\..\movimentacaoitens\PedidoDeCompra\untIMesesGiro.pas',
  untSelFilImpressao in '..\..\cadastros\untSelFilImpressao.pas' {frmSelFilImpressao},
  untITSQLTrace in '..\..\genericos\untITSQLTrace.pas',
  untPaiSQLTrace in '..\..\genericos\untPaiSQLTrace.pas' {frmPaiSQLTrace},
  untLogForm in '..\..\genericos\untLogForm.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

exports
  prelchequespre,
  fSVN_RevisionRelCheques;

begin
  RlConsts.SetVersion(3,71,'B');
end.
