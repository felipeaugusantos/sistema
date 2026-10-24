library libCartoesMagazineLuiza;

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
  untMagazineLuizaExports in 'genericos\untMagazineLuizaExports.pas',
  untILibCartoesFactory in '..\libCentralizado\factorys\untILibCartoesFactory.pas',
  untLibCartoesTelasAbertas in '..\libCentralizado\classes\untLibCartoesTelasAbertas.pas',
  untLibCartoesTiposCompartilhados in '..\libCentralizado\classes\untLibCartoesTiposCompartilhados.pas',
  untLogBan in '..\libCentralizado\classes\untLogBan.pas',
  untTBanMca in '..\libCentralizado\classes\untTBanMca.pas',
  untTLockLibCartoes in '..\libCentralizado\classes\untTLockLibCartoes.pas',
  untILibCartoesWrapper in '..\libCentralizado\interfaces\untILibCartoesWrapper.pas',
  untLibCartoesInterfacesTipos in '..\libCentralizado\interfaces\untLibCartoesInterfacesTipos.pas',
  untLibCartoesConstantes in '..\libCentralizado\genericos\untLibCartoesConstantes.pas',
  untGenericProcedureFormGravando in '..\libCentralizado\views\untGenericProcedureFormGravando.pas',
  untLibCartoesGravando in '..\libCentralizado\views\untLibCartoesGravando.pas' {frmGravando},
  untLibCartoesGravandoOld in '..\libCentralizado\views\untLibCartoesGravandoOld.pas' {frmGravandoOld},
  untLibCartoesImageLists in '..\libCentralizado\views\untLibCartoesImageLists.pas' {frmLibCartoesImageLists},
  untLibCartoesMensagem in '..\libCentralizado\views\untLibCartoesMensagem.pas' {frmMensagem},
  untTMagazineLuizaFuncoes in 'genericos\untTMagazineLuizaFuncoes.pas',
  untTLibCartoesFuncoes in '..\libCentralizado\genericos\untTLibCartoesFuncoes.pas',
  untLibCartoesHorarioSistema in '..\libCentralizado\genericos\untLibCartoesHorarioSistema.pas',
  untLibCartoesDigData in '..\libCentralizado\views\untLibCartoesDigData.pas' {frmLibCartoesDigData},
  untLibCartoesPai in '..\libCentralizado\views\untLibCartoesPai.pas' {frmPai},
  untMagazineLuiza in 'importacao\Arquivos\untMagazineLuiza.pas',
  untMagazineLuizaPgto in 'importacao\Arquivos\untMagazineLuizaPgto.pas',
  untMagazineLuizaTipos in 'genericos\untMagazineLuizaTipos.pas',
  untTMagazineLuizaImportacaoCartao in 'genericos\untTMagazineLuizaImportacaoCartao.pas',
  untIMagazineLuizaIntegracaoLibCartoes in 'genericos\interfaces\untIMagazineLuizaIntegracaoLibCartoes.pas',
  untMagazineLuizaBaixaRecebiveisMkt in 'recebiveis\views\untMagazineLuizaBaixaRecebiveisMkt.pas' {frmMagazineLuizaBaixaRecebiveisMkt: TFrame},
  untMagazineLuizaItemBaixaMkt in 'recebiveis\views\untMagazineLuizaItemBaixaMkt.pas' {fraMagazineLuizaItemBaixaMkt: TFrame},
  untConciliaRecebiveisMagazineLuiza in 'recebiveis\untConciliaRecebiveisMagazineLuiza.pas',
  untMagazineLuizaConciliaRecebiveis in 'recebiveis\untMagazineLuizaConciliaRecebiveis.pas',
  untTLibCartoesMovCar in '..\libCentralizado\genericos\untTLibCartoesMovCar.pas',
  untLibCartoesLogCtp in '..\libCentralizado\genericos\untLibCartoesLogCtp.pas',
  untLibCartoesLogMca in '..\libCentralizado\genericos\untLibCartoesLogMca.pas',
  untTLibCartoesCadPag in '..\libCentralizado\genericos\untTLibCartoesCadPag.pas',
  untTMagazineLuizaBaixaRecebiveis in 'recebiveis\untTMagazineLuizaBaixaRecebiveis.pas',
  untTMagazineLuizaBaixaCartoes in 'recebiveis\untTMagazineLuizaBaixaCartoes.pas',
  untTLibCartoesMovBan in '..\libCentralizado\genericos\untTLibCartoesMovBan.pas',
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
  ImportarCartoesArquivo,

  BaixarRecebiveisMktArquivo;

begin
end.
