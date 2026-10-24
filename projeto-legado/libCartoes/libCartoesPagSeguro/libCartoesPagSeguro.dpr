library libCartoesPagSeguro;

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
  WinAPi.Windows,
  dxCore,
  Vcl.Themes,
  Vcl.Styles,
  MidasLib,
  untPagSeguroExports in 'genericos\untPagSeguroExports.pas',
  untTLibCartoesFuncoes in '..\libCentralizado\genericos\untTLibCartoesFuncoes.pas',
  untTPagSeguroFuncoes in 'genericos\untTPagSeguroFuncoes.pas',
  untIPagSeguroIntegracaoLibCartoes in 'genericos\interfaces\untIPagSeguroIntegracaoLibCartoes.pas',
  untPagSeguroInterfacesTipos in 'genericos\interfaces\untPagSeguroInterfacesTipos.pas',
  untILibCartoesFactory in '..\libCentralizado\factorys\untILibCartoesFactory.pas',
  untILibCartoesWrapper in '..\libCentralizado\interfaces\untILibCartoesWrapper.pas',
  untLibCartoesInterfacesTipos in '..\libCentralizado\interfaces\untLibCartoesInterfacesTipos.pas',
  untLibCartoesConstantes in '..\libCentralizado\genericos\untLibCartoesConstantes.pas',
  untLibCartoesHorarioSistema in '..\libCentralizado\genericos\untLibCartoesHorarioSistema.pas',
  untGenericProcedureFormGravando in '..\libCentralizado\views\untGenericProcedureFormGravando.pas',
  untLibCartoesGravando in '..\libCentralizado\views\untLibCartoesGravando.pas' {frmGravando},
  untLibCartoesGravandoOld in '..\libCentralizado\views\untLibCartoesGravandoOld.pas' {frmGravandoOld},
  untLibCartoesTelasAbertas in '..\libCentralizado\classes\untLibCartoesTelasAbertas.pas',
  untLibCartoesDigData in '..\libCentralizado\views\untLibCartoesDigData.pas' {frmLibCartoesDigData},
  untTPagSeguroImportacaoCartao in 'genericos\untTPagSeguroImportacaoCartao.pas',
  untPagSeguro in 'importacao\Arquivos\untPagSeguro.pas',
  untPagSeguroPgto in 'importacao\Arquivos\untPagSeguroPgto.pas',
  untPagSeguroAPI in 'importacao\API\untPagSeguroAPI.pas',
  untPagSeguroAPIPgto in 'importacao\API\untPagSeguroAPIPgto.pas',
  untPagSeguroTipos in 'genericos\untPagSeguroTipos.pas',
  blcksock in '..\libCentralizado\synalist\blcksock.pas',
  httpsend in '..\libCentralizado\synalist\httpsend.pas',
  ssl_openssl in '..\libCentralizado\synalist\ssl_openssl.pas',
  ssl_openssl_lib in '..\libCentralizado\synalist\ssl_openssl_lib.pas',
  synacode in '..\libCentralizado\synalist\synacode.pas',
  synafpc in '..\libCentralizado\synalist\synafpc.pas',
  synaip in '..\libCentralizado\synalist\synaip.pas',
  synautil in '..\libCentralizado\synalist\synautil.pas',
  synsock in '..\libCentralizado\synalist\synsock.pas',
  untConciliacaoPagSeguro in 'conciliacao\untConciliacaoPagSeguro.pas',
  untConciliacaoPagSeguroApi in 'conciliacao\untConciliacaoPagSeguroApi.pas',
  untPagSeguroConciliacaoCartoes in 'conciliacao\untPagSeguroConciliacaoCartoes.pas',
  untTPagSeguroBaixaCartoes in 'conciliacao\untTPagSeguroBaixaCartoes.pas',
  untTLockLibCartoes in '..\libCentralizado\classes\untTLockLibCartoes.pas',
  untPagSeguroDigPeriodo in 'conciliacao\views\untPagSeguroDigPeriodo.pas' {frmPagSeguroDigPeriodo},
  untPagSeguroFiltroInconsistencias in 'conciliacao\views\untPagSeguroFiltroInconsistencias.pas' {frmPagSeguroFiltroInconsistencias},
  untLibCartoesPai in '..\libCentralizado\views\untLibCartoesPai.pas' {frmPai},
  untLibCartoesPaiSimples in '..\libCentralizado\views\untLibCartoesPaiSimples.pas' {frmPaiSimples},
  untLogBan in '..\libCentralizado\classes\untLogBan.pas',
  untTBanMca in '..\libCentralizado\classes\untTBanMca.pas',
  untLibCartoesLogCtp in '..\libCentralizado\genericos\untLibCartoesLogCtp.pas',
  untLibCartoesLogMca in '..\libCentralizado\genericos\untLibCartoesLogMca.pas',
  untTLibCartoesCadPag in '..\libCentralizado\genericos\untTLibCartoesCadPag.pas',
  untTLibCartoesMovBan in '..\libCentralizado\genericos\untTLibCartoesMovBan.pas',
  untTLibCartoesMovCar in '..\libCentralizado\genericos\untTLibCartoesMovCar.pas',
  untPagSeguroBaixaCartoes in 'conciliacao\views\untPagSeguroBaixaCartoes.pas' {frmPagSeguroBaixaCartoes},
  untLibCartoesConfiguracaoGrids in '..\libCentralizado\views\untLibCartoesConfiguracaoGrids.pas' {frmConfiguracaoGrids},
  untTLibCartoesConfiguracaoGrids in '..\libCentralizado\genericos\untTLibCartoesConfiguracaoGrids.pas',
  untcxGridDBColumnHelper in '..\libCentralizado\genericos\untcxGridDBColumnHelper.pas',
  untLibCartoesBaixaCtcAnaSin in '..\libCentralizado\views\untLibCartoesBaixaCtcAnaSin.pas' {frmLibCartoesBaixaCtcAnaSin},
  untLibCartoesDigValor in '..\libCentralizado\views\untLibCartoesDigValor.pas' {frmDigValor},
  untLibCartoesFrameCentroCustoEditFocus in '..\libCentralizado\views\untLibCartoesFrameCentroCustoEditFocus.pas' {fraCentroCustoEditFocus: TFrame},
  untLibCartoesFramePlanoDeContasMaskEdit in '..\libCentralizado\views\untLibCartoesFramePlanoDeContasMaskEdit.pas' {fraPlanoDeContasMskEdit: TFrame},
  untLibCartoesMensagem in '..\libCentralizado\views\untLibCartoesMensagem.pas' {frmMensagem},
  Faturamento.Classes.CNPJ in '..\libCentralizado\genericos\Faturamento.Classes.CNPJ.pas',
  untTBatchSQL.Helper in '..\libCentralizado\genericos\BatchSQL\untTBatchSQL.Helper.pas',
  untTBatchSQL in '..\libCentralizado\genericos\BatchSQL\untTBatchSQL.pas',
  untTIndiceBuscaCartao in '..\libCentralizado\classes\untTIndiceBuscaCartao.pas';

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
  ImportarCartoesAPI,

  ConciliacaoCartoesArquivo,
  ConciliacaoCartoesApi;

begin
end.
