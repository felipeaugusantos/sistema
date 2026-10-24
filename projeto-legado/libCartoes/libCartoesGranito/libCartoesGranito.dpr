library libCartoesGranito;

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
  System.ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  dxCore,
  Vcl.Themes,
  Vcl.Styles,
  MidasLib,
  untGranito in 'importacao\Arquivos\untGranito.pas',
  untGranitoPgto in 'importacao\Arquivos\untGranitoPgto.pas',
  untIGranitoIntegracaoLibCartoes in 'genericos\interfaces\untIGranitoIntegracaoLibCartoes.pas',
  untGranitoExports in 'genericos\untGranitoExports.pas',
  untGranitoTipos in 'genericos\untGranitoTipos.pas',
  untTGranitoFuncoes in 'genericos\untTGranitoFuncoes.pas',
  untTGranitoImportacaoCartao in 'genericos\untTGranitoImportacaoCartao.pas',
  untConciliacaoGranito in 'conciliacao\untConciliacaoGranito.pas',
  untGranitoConciliacaoCartoes in 'conciliacao\untGranitoConciliacaoCartoes.pas',
  untTGranitoBaixaCartoes in 'conciliacao\untTGranitoBaixaCartoes.pas',
  untGranitoBaixaCartoes in 'conciliacao\views\untGranitoBaixaCartoes.pas' {frmGranitoBaixaCartoes},
  untGranitoDigPeriodo in 'conciliacao\views\untGranitoDigPeriodo.pas' {frmGranitoDigPeriodo},
  untGranitoFiltroInconsistencias in 'conciliacao\views\untGranitoFiltroInconsistencias.pas' {frmGranitoFiltroInconsistencias},
  untTLibCartoesFuncoes in '..\libCentralizado\genericos\untTLibCartoesFuncoes.pas',
  untILibCartoesFactory in '..\libCentralizado\factorys\untILibCartoesFactory.pas',
  untILibCartoesWrapper in '..\libCentralizado\interfaces\untILibCartoesWrapper.pas',
  untLibCartoesTelasAbertas in '..\libCentralizado\classes\untLibCartoesTelasAbertas.pas',
  untLibCartoesInterfacesTipos in '..\libCentralizado\interfaces\untLibCartoesInterfacesTipos.pas',
  untLibCartoesHorarioSistema in '..\libCentralizado\genericos\untLibCartoesHorarioSistema.pas',
  untLibCartoesDigData in '..\libCentralizado\views\untLibCartoesDigData.pas',
  untLibCartoesPai in '..\libCentralizado\views\untLibCartoesPai.pas' {frmPai},
  untTLockLibCartoes in '..\libCentralizado\classes\untTLockLibCartoes.pas',
  untTLibCartoesMovCar in '..\libCentralizado\genericos\untTLibCartoesMovCar.pas',
  untLibCartoesLogMca in '..\libCentralizado\genericos\untLibCartoesLogMca.pas',
  untLibCartoesPaiSimples in '..\libCentralizado\views\untLibCartoesPaiSimples.pas' {frmPaiSimples},
  untLogBan in '..\libCentralizado\classes\untLogBan.pas',
  untTBanMca in '..\libCentralizado\classes\untTBanMca.pas',
  untTLibCartoesConfiguracaoGrids in '..\libCentralizado\genericos\untTLibCartoesConfiguracaoGrids.pas',
  untcxGridDBColumnHelper in '..\libCentralizado\genericos\untcxGridDBColumnHelper.pas',
  untLibCartoesConfiguracaoGrids in '..\libCentralizado\views\untLibCartoesConfiguracaoGrids.pas' {frmConfiguracaoGrids},
  untLibCartoesConstantes in '..\libCentralizado\genericos\untLibCartoesConstantes.pas',
  untLibCartoesGravando in '..\libCentralizado\views\untLibCartoesGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\libCentralizado\views\untGenericProcedureFormGravando.pas',
  untLibCartoesGravandoOld in '..\libCentralizado\views\untLibCartoesGravandoOld.pas' {frmGravandoOld},
  untLibCartoesDigValor in '..\libCentralizado\views\untLibCartoesDigValor.pas' {frmDigValor},
  untLibCartoesBaixaCtcAnaSin in '..\libCentralizado\views\untLibCartoesBaixaCtcAnaSin.pas' {frmLibCartoesBaixaCtcAnaSin},
  untTLibCartoesMovBan in '..\libCentralizado\genericos\untTLibCartoesMovBan.pas',
  untTLibCartoesCadPag in '..\libCentralizado\genericos\untTLibCartoesCadPag.pas',
  untLibCartoesFrameCentroCustoEditFocus in '..\libCentralizado\views\untLibCartoesFrameCentroCustoEditFocus.pas' {fraCentroCustoEditFocus: TFrame},
  untLibCartoesFramePlanoDeContasMaskEdit in '..\libCentralizado\views\untLibCartoesFramePlanoDeContasMaskEdit.pas' {fraPlanoDeContasMskEdit: TFrame},
  untLibCartoesLogCtp in '..\libCentralizado\genericos\untLibCartoesLogCtp.pas',
  untLibCartoesMensagem in '..\libCentralizado\views\untLibCartoesMensagem.pas' {frmMensagem},
  Faturamento.Classes.CNPJ in '..\libCentralizado\genericos\Faturamento.Classes.CNPJ.pas',
  untTBatchSQL.Helper in '..\libCentralizado\genericos\BatchSQL\untTBatchSQL.Helper.pas',
  untTBatchSQL in '..\libCentralizado\genericos\BatchSQL\untTBatchSQL.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R ..\libCentralizado\VCLStyles.res}
{$R ..\libCentralizado\icones.res}

Exports
  dxInitialize,
  dxFinalize,
  InicializaObjetoLibCartoes,
  VerificaEstruturaTabelas,
  pAtualizaObjetoTelasAbertas,
  SetStyleAutcom,
  ImportarCartoesArquivo,
  ConciliacaoCartoesArquivo;

begin
end.
