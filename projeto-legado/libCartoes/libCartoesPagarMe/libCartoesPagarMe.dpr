library libCartoesPagarMe;

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
  untTLibCartoesFuncoes in '..\libCentralizado\genericos\untTLibCartoesFuncoes.pas',
  untILibCartoesFactory in '..\libCentralizado\factorys\untILibCartoesFactory.pas',
  untILibCartoesWrapper in '..\libCentralizado\interfaces\untILibCartoesWrapper.pas',
  untLibCartoesInterfacesTipos in '..\libCentralizado\interfaces\untLibCartoesInterfacesTipos.pas',
  untLibCartoesConstantes in '..\libCentralizado\genericos\untLibCartoesConstantes.pas',
  untLibCartoesHorarioSistema in '..\libCentralizado\genericos\untLibCartoesHorarioSistema.pas',
  untWorkStationInfo in '..\libCentralizado\genericos\untWorkStationInfo.pas',
  untGenericProcedureFormGravando in '..\libCentralizado\views\untGenericProcedureFormGravando.pas',
  untLibCartoesGravando in '..\libCentralizado\views\untLibCartoesGravando.pas' {frmGravando},
  untLibCartoesGravandoOld in '..\libCentralizado\views\untLibCartoesGravandoOld.pas' {frmGravandoOld},
  untLibCartoesDigData in '..\libCentralizado\views\untLibCartoesDigData.pas' {frmLibCartoesDigData},
  untLibCartoesMensagem in '..\libCentralizado\views\untLibCartoesMensagem.pas' {frmMensagem},
  untLibCartoesPai in '..\libCentralizado\views\untLibCartoesPai.pas' {frmPai},
  untLibCartoesTelasAbertas in '..\libCentralizado\classes\untLibCartoesTelasAbertas.pas',
  untPagarMeExports in 'genericos\untPagarMeExports.pas',
  untTPagarMeFuncoes in 'genericos\untTPagarMeFuncoes.pas',
  untPagarMeTipos in 'genericos\untPagarMeTipos.pas',
  untPagarMePgto in 'importacao\API\untPagarMePgto.pas',
  untTImportaPagamentosPagarMe in 'importacao\API\untTImportaPagamentosPagarMe.pas',
  untIPagarMeIntegracaoLibCartoes in 'genericos\interfaces\untIPagarMeIntegracaoLibCartoes.pas',
  untConciliaRecebiveisPagarMe in 'recebiveis\untConciliaRecebiveisPagarMe.pas',
  untPagarMeConciliaRecebiveis in 'recebiveis\untPagarMeConciliaRecebiveis.pas',
  untTLibCartoesMovCar in '..\libCentralizado\genericos\untTLibCartoesMovCar.pas',
  untLibCartoesLogMca in '..\libCentralizado\genericos\untLibCartoesLogMca.pas',
  untTLockLibCartoes in '..\libCentralizado\classes\untTLockLibCartoes.pas',
  untPagarMeItemBaixaMkt in 'recebiveis\views\untPagarMeItemBaixaMkt.pas' {fraPagarMeItemBaixaMkt: TFrame},
  untPagarMeBaixaRecebiveisMkt in 'recebiveis\views\untPagarMeBaixaRecebiveisMkt.pas' {frmPagarMeBaixaRecebiveisMkt},
  untLibCartoesImageLists in '..\libCentralizado\views\untLibCartoesImageLists.pas' {frmLibCartoesImageLists},
  untTPagarMeBaixaRecebiveis in 'recebiveis\untTPagarMeBaixaRecebiveis.pas',
  untTPagarMeBaixaCartoes in 'recebiveis\untTPagarMeBaixaCartoes.pas',
  untLogBan in '..\libCentralizado\classes\untLogBan.pas',
  untTBanMca in '..\libCentralizado\classes\untTBanMca.pas',
  untTLibCartoesCadPag in '..\libCentralizado\genericos\untTLibCartoesCadPag.pas',
  untTLibCartoesMovBan in '..\libCentralizado\genericos\untTLibCartoesMovBan.pas',
  untLibCartoesLogCtp in '..\libCentralizado\genericos\untLibCartoesLogCtp.pas',
  Faturamento.Classes.CNPJ in '..\libCentralizado\genericos\Faturamento.Classes.CNPJ.pas',
  untTBatchSQL.Helper in '..\libCentralizado\genericos\BatchSQL\untTBatchSQL.Helper.pas',
  untTBatchSQL in '..\libCentralizado\genericos\BatchSQL\untTBatchSQL.pas';

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
  ImportarCartoesAPI,

  ConciliacaoCartoesApi,

  GetDadosFiltroImportacaoAPI;

begin
end.
