library libCartoesAutcom;

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
  untLibCartoesCfgRepositorio in 'genericos\untLibCartoesCfgRepositorio.pas',
  untILibCartoesFactory in 'factorys\untILibCartoesFactory.pas',
  untILibCartoesWrapper in 'interfaces\untILibCartoesWrapper.pas',
  untLibCartoesInterfacesTipos in 'interfaces\untLibCartoesInterfacesTipos.pas',
  untLibCartoesAutcomExports in 'genericos\untLibCartoesAutcomExports.pas',
  untLibCartoesTelasAbertas in 'classes\untLibCartoesTelasAbertas.pas',
  untTLibCartoesFuncoes in 'genericos\untTLibCartoesFuncoes.pas',
  untWorkStationInfo in 'genericos\untWorkStationInfo.pas',
  untLibCartoesHorarioSistema in 'genericos\untLibCartoesHorarioSistema.pas',
  untLibCartoesDigData in 'views\untLibCartoesDigData.pas' {frmLibCartoesDigData},
  untLibCartoesPai in 'views\untLibCartoesPai.pas' {frmPai},
  untLibCartoesConstantes in 'genericos\untLibCartoesConstantes.pas',
  untLibCartoesTiposCompartilhados in 'classes\untLibCartoesTiposCompartilhados.pas',
  untRepositorioConfiguracoesLibCartoes in 'genericos\untRepositorioConfiguracoesLibCartoes.pas' {dtmRepositorioConfiguracoesLibCartoes: TDataModule},
  untLibCartoesCadEstabelecimentos in 'views\untLibCartoesCadEstabelecimentos.pas' {frmCfgCadEstabelecimentosOperadorasCartoes},
  untLibCartoesGravando in 'views\untLibCartoesGravando.pas' {frmGravando},
  untLibCartoesGravandoOld in 'views\untLibCartoesGravandoOld.pas' {frmGravandoOld},
  untGenericProcedureFormGravando in 'views\untGenericProcedureFormGravando.pas',
  untTMenuLibCartoes in 'genericos\untTMenuLibCartoes.pas',
  untLibCartoesMensagem in 'views\untLibCartoesMensagem.pas' {frmMensagem},
  Faturamento.Classes.CNPJ in 'genericos\Faturamento.Classes.CNPJ.pas',
  untLibCartoesConfirmacaoDeCartoes in 'ConfimacaoDeCartoes\views\untLibCartoesConfirmacaoDeCartoes.pas' {frmLibCartoesConfirmacaoDeCartoes},
  untLibCartoesLancPendentesConfirmacao in 'ConfimacaoDeCartoes\views\untLibCartoesLancPendentesConfirmacao.pas' {frmLibCartoesLancPendentesConfirmacao},
  untTConfirmaCartoes in 'ConfimacaoDeCartoes\fontes\untTConfirmaCartoes.pas',
  TipoConciliadora.Classes in 'ConfimacaoDeCartoes\fontes\TipoConciliadora.Classes.pas',
  untTMenuImportaVendas in 'ConfimacaoDeCartoes\fontes\untTMenuImportaVendas.pas',
  untTConfirmaCartoesRedeCard in 'ConfimacaoDeCartoes\fontes\untTConfirmaCartoesRedeCard.pas',
  untTExtratoConfirmaCartoes in 'ConfimacaoDeCartoes\fontes\untTExtratoConfirmaCartoes.pas',
  untTImportaVendasConfirmacaoRedeCard in 'ConfimacaoDeCartoes\fontes\untTImportaVendasConfirmacaoRedeCard.pas',
  ImportaVendasCartaoFactory.Classes in 'ConfimacaoDeCartoes\factory\ImportaVendasCartaoFactory.Classes.pas',
  ImportaVendasCartaoFactory.Interfaces in 'ConfimacaoDeCartoes\factory\ImportaVendasCartaoFactory.Interfaces.pas',
  ImportaVendasCartao.Interfaces in 'ConfimacaoDeCartoes\models\ImportaVendasCartao.Interfaces.pas',
  ImportaVendasPagarMe.Classes in 'ConfimacaoDeCartoes\models\ImportaVendasPagarMe.Classes.pas',
  untTDockingManager in 'ConfimacaoDeCartoes\fontes\untTDockingManager.pas',
  untTBatchSQL.Helper in 'genericos\BatchSQL\untTBatchSQL.Helper.pas',
  untTBatchSQL in 'genericos\BatchSQL\untTBatchSQL.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R VCLStyles.res}

Exports
  dxInitialize,
  dxFinalize,
  InicializaObjetoLibCartoes,
  RetornaItensMenuImportacaoCartoes,
  RetornaItensMenuConciliacaoCartoes,
  RetornaItensMenuAntecipacaoCartoes,
  RetornaItensMenuImportacaoRecebiveisMkt,
  RetornaItensMenuBaixaRecebiveisMkt,
  RetornaCfgRepositorioCartoes,
  AdicionarConfiguracoesCartoes,
  AdicionarConfiguracoesAntecipacaoRedeCard,
  CarregaPropriedadesConfiguracoesCartoes,
  CarregaPropriedadesConfiguracoesAntecipacaoRedeCard,
  ValidaConfiguracoesCartoes,
  CarregarCadEstabelecimentosCartoes,
  RetornaItensMenuExclusaoCartoes,
  RetornaItensMenuExportacaoCartoes,
  CarregarCadEstabelecimentosCartoesEstilo,
  OnClickConfirmacaoCartoes;

begin
end.
