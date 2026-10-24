library libRelContasAPagar;

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
  untQckCtpAnalDebitos in '..\..\Relatorios\Financeiro\ContasaPagar\untQckCtpAnalDebitos.pas' {frmQckCtpAnalDebitos},
  untRelCtpAnaDebitos in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpAnaDebitos.pas' {frmRelCtpAnaDebitos},
  untConstantes in '..\..\genericos\untConstantes.pas',
  untModuloSPR in '..\..\Genericos\untModuloSPR.pas' {frmModuloSPR: TDataModule},
  untRelCtpTitAbertoMes in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpTitAbertoMes.pas' {frmRelCtpTitAbertoMes},
  untRelCtpContaCorrente in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpContaCorrente.pas' {frmRelCtpContaCorrente},
  untRelCtpIncDiarias in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpIncDiarias.pas' {frmRelCtpIncDiarias},
  untQckCtpTitContasSint in '..\..\Relatorios\Financeiro\ContasaPagar\untQckCtpTitContasSint.pas' {frmQckCtpTitContasSint},
  untRelCtpTitContas in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpTitContas.pas' {frmRelCtpTitContas},
  untQckCtpTitContas in '..\..\relatorios\financeiro\contasapagar\untQckCtpTitContas.pas' {frmQckCtpTitContas},
  untRelCtpPosContabil in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpPosContabil.pas' {frmRelCtpPosContabil},
  untPaiSimples in '..\..\Genericos\untPaiSimples.pas' {frmPaiSimples},
  untPai in '..\..\relatorios\genericos\untPai.pas' {frmPai},
  untQckCtpTitContasAno in '..\..\relatorios\financeiro\contasapagar\untQckCtpTitContasAno.pas' {frmQckCtpTitContasAno: TDataModule},
  untRelCtpTitContasAno in '..\..\relatorios\financeiro\contasapagar\untRelCtpTitContasAno.pas' {frmRelCtpTitContasAno},
  untPaiEdit in '..\..\genericos\untPaiEdit.pas' {frmPaiEdit},
  untExcel in '..\..\genericos\untExcel.pas',
  untClassPanelCx in '..\..\libFuncoes\untClassPanelCx.pas',
  untExcelOfc in '..\..\genericos\untExcelOfc.pas',
  untExcelBRO in '..\..\genericos\untExcelBRO.pas',
  untQckReimpCtaPagar in '..\..\relatorios\financeiro\contasapagar\untQckReimpCtaPagar.pas' {frmQckReimpCtaPagar: TDataModule},
  untRelCtpReimpressaoBusca in '..\..\relatorios\financeiro\contasapagar\untRelCtpReimpressaoBusca.pas' {frmRelCtpReimpressaoBusca},
  untRelCtpReimpressaoDocs in '..\..\relatorios\financeiro\contasapagar\untRelCtpReimpressaoDocs.pas' {frmRelCtpReimpressaoDoc},
  untRelCtpReimpressaoDocsList in '..\..\relatorios\financeiro\contasapagar\untRelCtpReimpressaoDocsList.pas' {frmRelCtpReimpressaoDocsList},
  untRelCtpTitDeletados in '..\..\relatorios\financeiro\contasapagar\untRelCtpTitDeletados.pas' {frmRelCtpTitDeletados},
  untMemo in '..\..\genericos\untMemo.pas' {frmMemo},
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
  untIFatOrdProTintaMaquina in '..\..\iTintas\untIFatOrdProTintaMaquina.pas',
  untIDadosTinta in '..\..\iTintas\untIDadosTinta.pas',
  untIDadosTintasComponentes in '..\..\iTintas\untIDadosTintasComponentes.pas',
  untICalculadorFatVendas in '..\..\Interfaces\untICalculadorFatVendas.pas',
  untITintaDeMaquina in '..\..\..\..\LibTintas\libTintasComum\Interfaces\untITintaDeMaquina.pas',
  untITintaDeMaquinaComponente in '..\..\..\..\LibTintas\libTintasComum\Interfaces\untITintaDeMaquinaComponente.pas',
  untTintaDeMaquinaComponenteTipo in '..\..\..\..\LibTintas\libTintasComum\Genericos\untTintaDeMaquinaComponenteTipo.pas',
  untInterfaces in '..\..\libNfe\untInterfaces.pas',
  untQckFatDemonstracaoCamp in '..\..\relatorios\faturamento\untQckFatDemonstracaoCamp.pas' {frmQckFatDemonstracaoCamp},
  untPaiQck in '..\..\relatorios\genericos\untPaiQck.pas' {frmPaiQck},
  untIIteBar in '..\..\cadastros\untIIteBar.pas',
  untIFuncoesEditorFast in '..\..\util\EditorEtiquetas\untIFuncoesEditorFast.pas',
  untIOrdenacao in '..\..\util\EditorEtiquetas\untIOrdenacao.pas',
  untIMadeireira in '..\..\faturamento\untIMadeireira.pas',
  untFuncoesFactory in '..\..\relatorios\funcoes\untFuncoesFactory.pas',
  untPaiRelatorio in '..\..\relatorios\genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  TypesRel in '..\geral\TypesRel.pas',
  untGeraExcel in '..\..\relatorios\genericos\untGeraExcel.pas',
  untIFinanceira in '..\..\faturamento\untIFinanceira.pas',
  untIFuncMacro in '..\..\genericos\untIFuncMacro.pas',
  untICamposUso in '..\..\genericos\untICamposUso.pas',
  untDllRelatorios in '..\geral\untDllRelatorios.pas',
  untIDocumentos in '..\..\util\EditorEtiquetas\untIDocumentos.pas',
  untIZClient in '..\..\genericos\untIZClient.pas',
  untRelContasAPagar in 'untRelContasAPagar.pas',
  untPaiCad in '..\..\relatorios\genericos\untPaiCad.pas' {frmPaiCad},
  untPaiOrdena in '..\..\relatorios\genericos\untPaiOrdena.pas' {frmPaiOrdena},
  untModulo in '..\geral\untModulo.pas' {frmModulo: TDataModule},
  untCadConfRelatorios in '..\..\cadastros\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untICadLote in '..\..\cadastros\untICadLote.pas',
  untIFiltrosRelatorio in '..\..\genericos\untIFiltrosRelatorio.pas',
  untCfgRel in '..\..\cadastros\untCfgRel.pas',
  untMenuFilas in '..\..\genericos\untMenuFilas.pas',
  untMenuTipImp in '..\..\genericos\untMenuTipImp.pas',
  untIConfiguracao in '..\..\configuracoes\untIConfiguracao.pas',
  untConfigNFE in '..\..\libNfe\untConfigNFE.pas',
  untRelCtpLogAcompDuplic in '..\..\relatorios\financeiro\contasapagar\untRelCtpLogAcompDuplic.pas' {frmRelCtpLogAcompDuplic},
  untGTinForTipos in '..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untTipoTinta in '..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untIMesesGiro in '..\..\movimentacaoitens\PedidoDeCompra\untIMesesGiro.pas',
  untSelFilImpressao in '..\..\cadastros\untSelFilImpressao.pas' {frmSelFilImpressao},
  untITSQLTrace in '..\..\genericos\untITSQLTrace.pas',
  untPaiSQLTrace in '..\..\genericos\untPaiSQLTrace.pas' {frmPaiSQLTrace},
  untGenericProcedureFormGravando in '..\..\genericos\untGenericProcedureFormGravando.pas',
  untGravando in '..\..\genericos\untGravando.pas' {frmGravando},
  untLogForm in '..\..\genericos\untLogForm.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

exports
  prelcontasapagar,
  fSVN_RevisionRelContasPagar;

begin
  RlConsts.SetVersion(3,71,'B');
end.
