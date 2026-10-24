library libCartoesShopee;

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
  untShopeeTipos in 'genericos\untShopeeTipos.pas',
  untTShopeeFuncoes in 'genericos\untTShopeeFuncoes.pas',
  untShopeeConciliaRecebiveis in 'recebiveis\untShopeeConciliaRecebiveis.pas',
  untTShopeeBaixaRecebiveis in 'recebiveis\untTShopeeBaixaRecebiveis.pas',
  untShopeeBaixaRecebiveisMkt in 'recebiveis\views\untShopeeBaixaRecebiveisMkt.pas' {frMShopeeBaixaRecebiveisMkt: TFrame},
  untShopeeItemBaixaMkt in 'recebiveis\views\untShopeeItemBaixaMkt.pas' {fraShopeeItemBaixaMkt: TFrame},
  untShopeeExports in 'genericos\untShopeeExports.pas',
  untILibCartoesFactory in '..\libCentralizado\factorys\untILibCartoesFactory.pas',
  untILibCartoesWrapper in '..\libCentralizado\interfaces\untILibCartoesWrapper.pas',
  untLibCartoesInterfacesTipos in '..\libCentralizado\interfaces\untLibCartoesInterfacesTipos.pas',
  untTLibCartoesFuncoes in '..\libCentralizado\genericos\untTLibCartoesFuncoes.pas',
  untLibCartoesHorarioSistema in '..\libCentralizado\genericos\untLibCartoesHorarioSistema.pas',
  untLibCartoesLogCtp in '..\libCentralizado\genericos\untLibCartoesLogCtp.pas',
  untLibCartoesLogMca in '..\libCentralizado\genericos\untLibCartoesLogMca.pas',
  untTLibCartoesCadPag in '..\libCentralizado\genericos\untTLibCartoesCadPag.pas',
  untTLibCartoesMovBan in '..\libCentralizado\genericos\untTLibCartoesMovBan.pas',
  untTLibCartoesMovCar in '..\libCentralizado\genericos\untTLibCartoesMovCar.pas',
  untLibCartoesTelasAbertas in '..\libCentralizado\classes\untLibCartoesTelasAbertas.pas',
  untLogBan in '..\libCentralizado\classes\untLogBan.pas',
  untTBanMca in '..\libCentralizado\classes\untTBanMca.pas',
  untLibCartoesDigData in '..\libCentralizado\views\untLibCartoesDigData.pas' {frmLibCartoesDigData},
  untLibCartoesGetMenu in '..\libCentralizado\views\untLibCartoesGetMenu.pas' {frmLibCartoesGetMenu},
  untLibCartoesGravando in '..\libCentralizado\views\untLibCartoesGravando.pas' {frmGravando},
  untLibCartoesGravandoOld in '..\libCentralizado\views\untLibCartoesGravandoOld.pas' {frmGravandoOld},
  untLibCartoesPai in '..\libCentralizado\views\untLibCartoesPai.pas' {frmPai},
  untLibCartoesPaiSimples in '..\libCentralizado\views\untLibCartoesPaiSimples.pas' {frmPaiSimples},
  untGenericProcedureFormGravando in '..\libCentralizado\views\untGenericProcedureFormGravando.pas',
  untLibCartoesConstantes in '..\libCentralizado\genericos\untLibCartoesConstantes.pas',
  untTLockLibCartoes in '..\libCentralizado\classes\untTLockLibCartoes.pas',
  untTShopeeBaixaCartoes in 'genericos\untTShopeeBaixaCartoes.pas',
  untConciliaRecebiveisShopeePay in 'recebiveis\untConciliaRecebiveisShopeePay.pas',
  untLibCartoesImageLists in '..\libCentralizado\views\untLibCartoesImageLists.pas' {frmLibCartoesImageLists},
  blcksock in '..\libCentralizado\synalist\blcksock.pas',
  httpsend in '..\libCentralizado\synalist\httpsend.pas',
  ssl_openssl in '..\libCentralizado\synalist\ssl_openssl.pas',
  ssl_openssl_lib in '..\libCentralizado\synalist\ssl_openssl_lib.pas',
  synacode in '..\libCentralizado\synalist\synacode.pas',
  synafpc in '..\libCentralizado\synalist\synafpc.pas',
  synaip in '..\libCentralizado\synalist\synaip.pas',
  synautil in '..\libCentralizado\synalist\synautil.pas',
  synsock in '..\libCentralizado\synalist\synsock.pas',
  untIShopeeIntegracaoLibCartoes in 'genericos\interfaces\untIShopeeIntegracaoLibCartoes.pas',
  untShopeePay in 'importacao\Arquivos\untShopeePay.pas',
  untShopeePayPgto in 'importacao\Arquivos\untShopeePayPgto.pas',
  untTShopeeImportacaoCartao in 'importacao\Arquivos\untTShopeeImportacaoCartao.pas',
  untLibCartoesMensagem in '..\libCentralizado\views\untLibCartoesMensagem.pas' {frmMensagem},
  Faturamento.Classes.CNPJ in '..\libCentralizado\genericos\Faturamento.Classes.CNPJ.pas',
  untTBatchSQL.Helper in '..\libCentralizado\genericos\BatchSQL\untTBatchSQL.Helper.pas',
  untTBatchSQL in '..\libCentralizado\genericos\BatchSQL\untTBatchSQL.pas',
  untShopeeExcluirArquivosImportadosCartoes in 'views\untShopeeExcluirArquivosImportadosCartoes.pas' {frmShopeeExcluirArquivosImportadosCartoes};

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R ..\libCentralizado\VCLStyles.res}
{$R ..\libCentralizado\icones.res}

exports
  dxInitialize,
  dxFinalize,
  InicializaObjetoLibCartoes,
  VerificaEstruturaTabelas,
  pAtualizaObjetoTelasAbertas,
  SetStyleAutcom,
  ImportarCartoesArquivo,

  BaixarRecebiveisMktArquivo,

  ExcluirArquivosImportados;

begin
end.
