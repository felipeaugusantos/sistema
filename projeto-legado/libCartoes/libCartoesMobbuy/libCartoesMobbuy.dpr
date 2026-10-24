library libCartoesMobbuy;

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
  untTMobbuyFuncoes in 'genericos\untTMobbuyFuncoes.pas',
  untIMobbuyIntegracaoLibCartoes in 'genericos\interfaces\untIMobbuyIntegracaoLibCartoes.pas',
  untMobbuyTipos in 'genericos\untMobbuyTipos.pas',
  untMobbuyExports in 'genericos\untMobbuyExports.pas',
  untMobbuyAPI in 'importacao\API\untMobbuyAPI.pas',
  untMobbuyAPIPgto in 'importacao\API\untMobbuyAPIPgto.pas',
  untTConsultaPagamentoDiarioMobbuyOnline in 'importacao\API\untTConsultaPagamentoDiarioMobbuyOnline.pas',
  untGenericProcedureFormGravando in '..\libCentralizado\views\untGenericProcedureFormGravando.pas',
  untLibCartoesGravando in '..\libCentralizado\views\untLibCartoesGravando.pas' {frmGravando},
  untLibCartoesTelasAbertas in '..\libCentralizado\classes\untLibCartoesTelasAbertas.pas',
  untLibCartoesInterfacesTipos in '..\libCentralizado\interfaces\untLibCartoesInterfacesTipos.pas',
  untLibCartoesPai in '..\libCentralizado\views\untLibCartoesPai.pas' {frmPai},
  untLibCartoesConstantes in '..\libCentralizado\genericos\untLibCartoesConstantes.pas',
  untILibCartoesFactory in '..\libCentralizado\factorys\untILibCartoesFactory.pas',
  untILibCartoesWrapper in '..\libCentralizado\interfaces\untILibCartoesWrapper.pas',
  blcksock in '..\libCentralizado\synalist\blcksock.pas',
  httpsend in '..\libCentralizado\synalist\httpsend.pas',
  ssl_openssl in '..\libCentralizado\synalist\ssl_openssl.pas',
  ssl_openssl_lib in '..\libCentralizado\synalist\ssl_openssl_lib.pas',
  synacode in '..\libCentralizado\synalist\synacode.pas',
  synafpc in '..\libCentralizado\synalist\synafpc.pas',
  synaip in '..\libCentralizado\synalist\synaip.pas',
  synautil in '..\libCentralizado\synalist\synautil.pas',
  synsock in '..\libCentralizado\synalist\synsock.pas',
  untLibCartoesGetMenu in '..\libCentralizado\views\untLibCartoesGetMenu.pas' {frmLibCartoesGetMenu},
  untConciliacaoMobbuyAPI in 'conciliacao\untConciliacaoMobbuyAPI.pas',
  untMobbuyConciliacaoCartoes in 'conciliacao\untMobbuyConciliacaoCartoes.pas',
  untTLockLibCartoes in '..\libCentralizado\classes\untTLockLibCartoes.pas',
  untTLibCartoesFuncoes in '..\libCentralizado\genericos\untTLibCartoesFuncoes.pas',
  untLibCartoesPaiSimples in '..\libCentralizado\views\untLibCartoesPaiSimples.pas' {frmPaiSimples},
  untLibCartoesFiltroInconsistencias in '..\libCentralizado\views\untLibCartoesFiltroInconsistencias.pas' {frmLibCartoesFiltroInconsistencias},
  untTLibCartoesMovCar in '..\libCentralizado\genericos\untTLibCartoesMovCar.pas',
  untTImportaVendasMobbuyOnline in 'importacao\API\untTImportaVendasMobbuyOnline.pas',
  untLibCartoesHorarioSistema in '..\libCentralizado\genericos\untLibCartoesHorarioSistema.pas',
  untMobbuyBaixaCartoes in 'conciliacao\views\untMobbuyBaixaCartoes.pas' {frmMobbuyBaixaCartoes},
  untTMobbuyBaixaCartoes in 'conciliacao\untTMobbuyBaixaCartoes.pas',
  untLogBan in '..\libCentralizado\classes\untLogBan.pas',
  untTBanMca in '..\libCentralizado\classes\untTBanMca.pas',
  untTLibCartoesMovBan in '..\libCentralizado\genericos\untTLibCartoesMovBan.pas',
  untTLibCartoesCadPag in '..\libCentralizado\genericos\untTLibCartoesCadPag.pas',
  untLibCartoesLogCtp in '..\libCentralizado\genericos\untLibCartoesLogCtp.pas',
  untcxGridDBColumnHelper in '..\libCentralizado\genericos\untcxGridDBColumnHelper.pas',
  untLibCartoesBaixaCtcAnaSin in '..\libCentralizado\views\untLibCartoesBaixaCtcAnaSin.pas' {frmLibCartoesBaixaCtcAnaSin},
  untLibCartoesBaixaCtcValor in '..\libCentralizado\views\untLibCartoesBaixaCtcValor.pas' {frmLibCartoesBaixaCtcValor},
  untLibCartoesFrameCentroCustoEditFocus in '..\libCentralizado\views\untLibCartoesFrameCentroCustoEditFocus.pas' {fraCentroCustoEditFocus: TFrame},
  untLibCartoesFramePlanoDeContasMaskEdit in '..\libCentralizado\views\untLibCartoesFramePlanoDeContasMaskEdit.pas' {fraPlanoDeContasMskEdit: TFrame},
  untLibCartoesDigValor in '..\libCentralizado\views\untLibCartoesDigValor.pas' {frmDigValor},
  untLibCartoesConfiguracaoGrids in '..\libCentralizado\views\untLibCartoesConfiguracaoGrids.pas' {frmConfiguracaoGrids},
  untTLibCartoesConfiguracaoGrids in '..\libCentralizado\genericos\untTLibCartoesConfiguracaoGrids.pas',
  untLibCartoesLogMca in '..\libCentralizado\genericos\untLibCartoesLogMca.pas',
  untDigPeriodoData in 'views\untDigPeriodoData.pas' {frmMobbuyDigPeriodoData},
  untLibCartoesDigData in '..\libCentralizado\views\untLibCartoesDigData.pas' {frmLibCartoesDigData},
  untWorkStationInfo in '..\libCentralizado\genericos\untWorkStationInfo.pas',
  untLibCartoesGravandoOld in '..\libCentralizado\views\untLibCartoesGravandoOld.pas' {frmGravandoOld},
  untMobbuyDigPeriodo in 'views\untMobbuyDigPeriodo.pas' {frmMobbuyDigPeriodo},
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
  ImportarCartoesAPI,
  ConciliacaoCartoesApi;

begin
end.
