library libCartoesMercadoLivre;

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
  untMercadoLivreExports in 'genericos\untMercadoLivreExports.pas',
  untILibCartoesWrapper in '..\libCentralizado\interfaces\untILibCartoesWrapper.pas',
  untLibCartoesInterfacesTipos in '..\libCentralizado\interfaces\untLibCartoesInterfacesTipos.pas',
  untTLibCartoesFuncoes in '..\libCentralizado\genericos\untTLibCartoesFuncoes.pas',
  untTMercadoLivreFuncoes in 'genericos\untTMercadoLivreFuncoes.pas',
  untMercadoLivre in 'importacao\Arquivos\untMercadoLivre.pas',
  untMercadoLivrePgto in 'importacao\Arquivos\untMercadoLivrePgto.pas',
  untTMercadoLivreImportacaoCartao in 'genericos\untTMercadoLivreImportacaoCartao.pas',
  untIMercadoLivreIntegracaoLibCartoes in 'genericos\interfaces\untIMercadoLivreIntegracaoLibCartoes.pas',
  untLibCartoesDigData in '..\libCentralizado\views\untLibCartoesDigData.pas' {frmLibCartoesDigData},
  untLibCartoesHorarioSistema in '..\libCentralizado\genericos\untLibCartoesHorarioSistema.pas',
  untMercadoLivreTipos in 'genericos\untMercadoLivreTipos.pas',
  untLibCartoesGetMenu in '..\libCentralizado\views\untLibCartoesGetMenu.pas' {frmLibCartoesGetMenu},
  untConciliaRecebiveisMercadoLivre in 'recebiveis\untConciliaRecebiveisMercadoLivre.pas',
  untMercadoLivreConciliaRecebiveis in 'recebiveis\untMercadoLivreConciliaRecebiveis.pas',
  untTMercadoLivreBaixaCartoes in 'conciliacao\untTMercadoLivreBaixaCartoes.pas',
  untTLockLibCartoes in '..\libCentralizado\classes\untTLockLibCartoes.pas',
  untILibCartoesFactory in '..\libCentralizado\factorys\untILibCartoesFactory.pas',
  untLibCartoesGravando in '..\libCentralizado\views\untLibCartoesGravando.pas' {frmGravando},
  untLibCartoesGravandoOld in '..\libCentralizado\views\untLibCartoesGravandoOld.pas' {frmGravandoOld},
  untLibCartoesTelasAbertas in '..\libCentralizado\classes\untLibCartoesTelasAbertas.pas',
  untGenericProcedureFormGravando in '..\libCentralizado\views\untGenericProcedureFormGravando.pas',
  untLibCartoesPai in '..\libCentralizado\views\untLibCartoesPai.pas' {frmPai},
  untLibCartoesPaiSimples in '..\libCentralizado\views\untLibCartoesPaiSimples.pas' {frmPaiSimples},
  untTBanMca in '..\libCentralizado\classes\untTBanMca.pas',
  untLogBan in '..\libCentralizado\classes\untLogBan.pas',
  untLibCartoesConstantes in '..\libCentralizado\genericos\untLibCartoesConstantes.pas',
  untLibCartoesLogCtp in '..\libCentralizado\genericos\untLibCartoesLogCtp.pas',
  untLibCartoesLogMca in '..\libCentralizado\genericos\untLibCartoesLogMca.pas',
  untTLibCartoesCadPag in '..\libCentralizado\genericos\untTLibCartoesCadPag.pas',
  untTLibCartoesConfiguracaoGrids in '..\libCentralizado\genericos\untTLibCartoesConfiguracaoGrids.pas',
  untTLibCartoesMovBan in '..\libCentralizado\genericos\untTLibCartoesMovBan.pas',
  untTLibCartoesMovCar in '..\libCentralizado\genericos\untTLibCartoesMovCar.pas',
  untcxGridDBColumnHelper in '..\libCentralizado\genericos\untcxGridDBColumnHelper.pas',
  untLibCartoesConfiguracaoGrids in '..\libCentralizado\views\untLibCartoesConfiguracaoGrids.pas' {frmConfiguracaoGrids},
  untLibCartoesBaixaCtcValor in '..\libCentralizado\views\untLibCartoesBaixaCtcValor.pas' {frmLibCartoesBaixaCtcValor},
  untLibCartoesBaixaCtcAnaSin in '..\libCentralizado\views\untLibCartoesBaixaCtcAnaSin.pas' {frmLibCartoesBaixaCtcAnaSin},
  untLibCartoesFrameCentroCustoEditFocus in '..\libCentralizado\views\untLibCartoesFrameCentroCustoEditFocus.pas' {fraCentroCustoEditFocus: TFrame},
  untLibCartoesFramePlanoDeContasMaskEdit in '..\libCentralizado\views\untLibCartoesFramePlanoDeContasMaskEdit.pas' {fraPlanoDeContasMskEdit: TFrame},
  untLibCartoesDigValor in '..\libCentralizado\views\untLibCartoesDigValor.pas' {frmDigValor},
  untTMercadoLivreBaixaRecebiveis in 'recebiveis\untTMercadoLivreBaixaRecebiveis.pas',
  untMercadoLivreBaixaRecebiveisMkt in 'recebiveis\views\untMercadoLivreBaixaRecebiveisMkt.pas' {frmMercadoLivreBaixaRecebiveisMkt},
  untMercadoLivreItemBaixaMkt in 'recebiveis\views\untMercadoLivreItemBaixaMkt.pas' {fraMercadoLivreItemBaixaMkt: TFrame},
  untTMercadoLivreInclusaoVendas in 'recebiveis\untTMercadoLivreInclusaoVendas.pas',
  untMercadoLivreVendasNaoEncontradas in 'recebiveis\views\untMercadoLivreVendasNaoEncontradas.pas' {frmMercadoLivreVendasNaoEncontradas},
  untLibCartoesImageLists in '..\libCentralizado\views\untLibCartoesImageLists.pas' {frmLibCartoesImageLists},
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

  BaixarRecebiveisMktArquivo,
  ConciliacaoCartoesArquivo;

begin
end.
