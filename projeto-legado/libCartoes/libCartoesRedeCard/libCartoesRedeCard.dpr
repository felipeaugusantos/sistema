library libCartoesRedeCard;

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
  untRedeCard in 'Importacao\Arquivos\untRedeCard.pas',
  untRedeCredito in 'Importacao\Arquivos\untRedeCredito.pas',
  untRedeDebito in 'Importacao\Arquivos\untRedeDebito.pas',
  untTRedeCardFuncoes in 'genericos\untTRedeCardFuncoes.pas',
  untTRedeCardImportacaoCartao in 'genericos\untTRedeCardImportacaoCartao.pas',
  untIRedeCardIntegracaoLibCartoes in 'genericos\interfaces\untIRedeCardIntegracaoLibCartoes.pas',
  untStyleHookFix in 'genericos\untStyleHookFix.pas',
  untRedeCardTipos in 'genericos\untRedeCardTipos.pas',
  untTRedeCardReport in 'genericos\untTRedeCardReport.pas',
  untRedeCardExports in 'genericos\untRedeCardExports.pas',
  untRedeCardAPI in 'importacao\API\untRedeCardAPI.pas',
  untRedeCardAPIPgto in 'importacao\API\untRedeCardAPIPgto.pas',
  untTConsultaPagamentoDiarioRedeCardOnline in 'importacao\API\untTConsultaPagamentoDiarioRedeCardOnline.pas',
  untGenericProcedureFormGravando in '..\libCentralizado\views\untGenericProcedureFormGravando.pas',
  untLibCartoesGravando in '..\libCentralizado\views\untLibCartoesGravando.pas' {frmGravando},
  untLibCartoesTelasAbertas in '..\libCentralizado\classes\untLibCartoesTelasAbertas.pas',
  untLibCartoesInterfacesTipos in '..\libCentralizado\interfaces\untLibCartoesInterfacesTipos.pas',
  untAntecipacaoRedeCard in 'importacao\API\views\untAntecipacaoRedeCard.pas' {frmAntecipacaoRedeCard},
  untConfirmaAntecipacaoRedeCard in 'importacao\API\views\untConfirmaAntecipacaoRedeCard.pas' {frmConfirmaAntecipacaoRedeCard},
  untLibCartoesPai in '..\libCentralizado\views\untLibCartoesPai.pas' {frmPai},
  untLibCartoesConstantes in '..\libCentralizado\genericos\untLibCartoesConstantes.pas',
  untILibCartoesFactory in '..\libCentralizado\factorys\untILibCartoesFactory.pas',
  untILibCartoesWrapper in '..\libCentralizado\interfaces\untILibCartoesWrapper.pas',
  untTIntegracaoAntecipacaoRedeCard in 'importacao\API\untTIntegracaoAntecipacaoRedeCard.pas',
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
  untConciliacaoRedeCardAPI in 'conciliacao\untConciliacaoRedeCardAPI.pas',
  untRedeCardConciliacaoCartoes in 'conciliacao\untRedeCardConciliacaoCartoes.pas',
  untTLockLibCartoes in '..\libCentralizado\classes\untTLockLibCartoes.pas',
  untTLibCartoesFuncoes in '..\libCentralizado\genericos\untTLibCartoesFuncoes.pas',
  untLibCartoesPaiSimples in '..\libCentralizado\views\untLibCartoesPaiSimples.pas' {frmPaiSimples},
  untLibCartoesFiltroInconsistencias in '..\libCentralizado\views\untLibCartoesFiltroInconsistencias.pas' {frmLibCartoesFiltroInconsistencias},
  untTLibCartoesMovCar in '..\libCentralizado\genericos\untTLibCartoesMovCar.pas',
  untTImportaVendasRedeCardOnline in 'importacao\API\untTImportaVendasRedeCardOnline.pas',
  untLibCartoesHorarioSistema in '..\libCentralizado\genericos\untLibCartoesHorarioSistema.pas',
  untConciliacaoRedeCard in 'conciliacao\untConciliacaoRedeCard.pas',
  untRedeCardBaixaCartoes in 'conciliacao\views\untRedeCardBaixaCartoes.pas' {frmRedeCardBaixaCartoes},
  untTRedeCardBaixaCartoes in 'conciliacao\untTRedeCardBaixaCartoes.pas',
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
  untDigPeriodoData in 'views\untDigPeriodoData.pas' {frmRedeCardDigPeriodoData},
  untLibCartoesDigData in '..\libCentralizado\views\untLibCartoesDigData.pas' {frmLibCartoesDigData},
  untWorkStationInfo in '..\libCentralizado\genericos\untWorkStationInfo.pas',
  untRedeCardDigPeriodo in 'views\untRedeCardDigPeriodo.pas' {frmRedeCardDigPeriodo},
  untRedeCardMemoInfoImportacao in 'views\untRedeCardMemoInfoImportacao.pas' {frmRedeCardMemoInfoImportacao},
  untLibCartoesGravandoOld in '..\libCentralizado\views\untLibCartoesGravandoOld.pas' {frmGravandoOld},
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
  ConciliacaoCartoesApi,

  AntecipacaoCartoes,

  GetDadosFiltroImportacaoAPI;

begin
end.
