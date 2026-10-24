library libRelContasAReceber;

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
  untConstantes in '..\..\genericos\untConstantes.pas',
  untRelPosContabil in '..\..\Relatorios\Financeiro\ContasaReceber\untRelPosContabil.pas' {frmRelPosContabil},
  untRelTitDeletados in '..\..\relatorios\financeiro\contasareceber\untRelTitDeletados.pas' {frmRelTitDeletados},
  untPaiSimples in '..\..\Genericos\untPaiSimples.pas' {frmPaiSimples},
  untRelCtrCartoes in '..\..\Relatorios\Financeiro\ContasaReceber\untRelCtrCartoes.pas' {frmRelCtrCartoes},
  untCartaAnuencia in '..\..\Relatorios\Financeiro\ContasaReceber\untCartaAnuencia.pas' {frmCartaAnuencia},
  untDtaEmissao in '..\..\relatorios\financeiro\contasareceber\untDtaEmissao.pas' {frmDtaEmi},
  untRelDupAgr in '..\..\Relatorios\Financeiro\ContasaReceber\untRelDupAgr.pas' {frmRelDupAgr},
  untRelCtrComVendedor in '..\..\Relatorios\Financeiro\ContasaReceber\untRelCtrComVendedor.pas' {frmRelCtrComVendedor},
  untRelContasAReceber in 'untRelContasAReceber.pas',
  untPai in '..\..\relatorios\genericos\untPai.pas' {frmPai},
  untQckHTMLCliente in '..\..\relatorios\cadastros\untQckHTMLCliente.pas' {frmQckHTMLCliente},
  untRelCtrDebitosCliente in '..\..\relatorios\financeiro\contasareceber\untRelCtrDebitosCliente.pas' {frmRelCtrDebitosCliente},
  untRelCtrBordero in '..\..\relatorios\financeiro\contasareceber\untRelCtrBordero.pas' {frmRelCtrBordero},
  untPaiEdit in '..\..\genericos\untPaiEdit.pas' {frmPaiEdit},
  untRelCtrCartaProtesto in '..\..\relatorios\financeiro\contasareceber\untRelCtrCartaProtesto.pas' {frmRelCtrCartaProtesto},
  untModuloRelCtrCartaProtesto in '..\..\relatorios\financeiro\contasareceber\untModuloRelCtrCartaProtesto.pas' {frmModuloRelCtrCartaProtesto: TDataModule},
  untExcel in '..\..\genericos\untExcel.pas',
  untClassPanelCx in '..\..\libFuncoes\untClassPanelCx.pas',
  untExcelOfc in '..\..\genericos\untExcelOfc.pas',
  untExcelBRO in '..\..\genericos\untExcelBRO.pas',
  untWordOfc in '..\..\genericos\untWordOfc.pas',
  untWord in '..\..\genericos\untWord.pas',
  untWordBRO in '..\..\genericos\untWordBRO.pas',
  untRelCtrCartaDes in '..\..\relatorios\financeiro\contasareceber\untRelCtrCartaDes.pas' {frmRelCtrCartaDes},
  untIFuncoes in '..\..\relatorios\interfaces\untIFuncoes.pas',
  untTypesSistema in '..\..\genericos\untTypesSistema.pas',
  untITintasDeMaquina in '..\..\iTintas\untITintasDeMaquina.pas',
  untICamGer in '..\..\cadastros\untICamGer.pas',
  untIControlePagtoFunc in '..\..\cadastros\untIControlePagtoFunc.pas',
  untIValorRecebido in '..\..\relatorios\faturamento\untIValorRecebido.pas',
  untIConfTinta in '..\..\iTintas\untIConfTinta.pas',
  untIFastPrint in '..\..\util\untIFastPrint.pas',
  untIMetAno in '..\..\genericos\untIMetAno.pas',
  untInterfacedObjectNoCount in '..\..\FuncoesCentralizadas\untInterfacedObjectNoCount.pas' {/untFuncoesRel2 in '..\..\relatorios_dll\geral\untFuncoesRel2.pas',},
  TypesRel in '..\geral\TypesRel.pas' {/untFuncoesRelatorios in'..\..\relatorios_dll\contasAReceber\untFuncoesRelatorios.pas';},
  untPaiQck in '..\..\relatorios\genericos\untPaiQck.pas' {frmPaiQck},
  untModulo in '..\geral\untModulo.pas' {frmModulo: TDataModule},
  untFuncoesFactory in '..\..\relatorios\funcoes\untFuncoesFactory.pas',
  untPaiCad in '..\..\relatorios\genericos\untPaiCad.pas' {frmPaiCad},
  untCadConfRelatorios in '..\..\cadastros\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untPaiRelatorio in '..\..\relatorios\genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  untGeraExcel in '..\..\relatorios\genericos\untGeraExcel.pas',
  untIIteBar in '..\..\cadastros\untIIteBar.pas',
  untDllRelatorios in '..\geral\untDllRelatorios.pas',
  untIFuncoesEditorFast in '..\..\util\EditorEtiquetas\untIFuncoesEditorFast.pas',
  untIOrdenacao in '..\..\util\EditorEtiquetas\untIOrdenacao.pas',
  untIMadeireira in '..\..\faturamento\untIMadeireira.pas',
  untIFinanceira in '..\..\faturamento\untIFinanceira.pas',
  untIFuncMacro in '..\..\genericos\untIFuncMacro.pas',
  untIDocumentos in '..\..\util\EditorEtiquetas\untIDocumentos.pas',
  untIZClient in '..\..\genericos\untIZClient.pas',
  untICamposUso in '..\..\genericos\untICamposUso.pas',
  untPaiOrdena in '..\..\relatorios\genericos\untPaiOrdena.pas' {frmPaiOrdena},
  untICadLote in '..\..\cadastros\untICadLote.pas',
  untIFiltrosRelatorio in '..\..\genericos\untIFiltrosRelatorio.pas',
  untCfgRel in '..\..\cadastros\untCfgRel.pas',
  untMenuFilas in '..\..\genericos\untMenuFilas.pas',
  untMenuTipImp in '..\..\genericos\untMenuTipImp.pas',
  untIConfiguracao in '..\..\configuracoes\untIConfiguracao.pas',
  untGTinForTipos in '..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untTipoTinta in '..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untMemo in '..\..\genericos\untMemo.pas' {frmMemo},
  untIMesesGiro in '..\..\movimentacaoitens\PedidoDeCompra\untIMesesGiro.pas',
  untSelFilImpressao in '..\..\cadastros\untSelFilImpressao.pas' {frmSelFilImpressao},
  untGravando in '..\..\genericos\untGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\..\genericos\untGenericProcedureFormGravando.pas',
  untITSQLTrace in '..\..\genericos\untITSQLTrace.pas',
  untPaiSQLTrace in '..\..\genericos\untPaiSQLTrace.pas' {frmPaiSQLTrace},
  untLogForm in '..\..\genericos\untLogForm.pas',
  untRelCtrExportaCobranca in '..\..\relatorios\financeiro\contasareceber\untRelCtrExportaCobranca.pas' {frmRelCtrExportaCobranca},
  untSelCtrExportaCobranca in '..\..\relatorios\financeiro\contasareceber\untSelCtrExportaCobranca.pas' {frmSelCtrExportaCobranca},
  untIDigSenVar in '..\..\genericos\untIDigSenVar.pas',
  untDigSenVarFactory in '..\..\genericos\untDigSenVarFactory.pas',
  untFuncoesDLLContasAReceber in 'untFuncoesDLLContasAReceber.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

exports
  prelcontasareceber,
  pSetDigSenVarRelContasAReceber,
  fSVN_RevisionRelContasReceber;

begin
  RlConsts.SetVersion(3,71,'B');
End.

