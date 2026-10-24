library libIntegracaoPixCitel;

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
  System.SysUtils,
  System.Classes,
  Windows,
  MidasLib,
  Vcl.Styles,
  Vcl.Themes,
  untFuncoesLibIntegracaoPix in 'fontes\genericos\untFuncoesLibIntegracaoPix.pas',
  untTiposPix in 'fontes\genericos\untTiposPix.pas',
  untTFuncoesAuxiliaresPix in 'fontes\requisicoes\untTFuncoesAuxiliaresPix.pas',
  untInterfacesIntegracaoPixCitel in 'fontes\genericos\untInterfacesIntegracaoPixCitel.pas',
  untTRequisicoesPix in 'fontes\requisicoes\untTRequisicoesPix.pas',
  untDataSetIDataSetWrapper in 'fontes\Dataset\untDataSetIDataSetWrapper.pas',
  untFieldDataSetFieldWrapper in 'fontes\Dataset\untFieldDataSetFieldWrapper.pas',
  untIDataSet in 'fontes\Dataset\untIDataSet.pas',
  untParamDataSetWrapper in 'fontes\Dataset\untParamDataSetWrapper.pas',
  untExibicaoQRCodePix in 'fontes\views\untExibicaoQRCodePix.pas' {frmExibicaoQRCodePix},
  untFuncoesSimples in 'fontes\genericos\untFuncoesSimples.pas',
  untSpoolImpressao in 'fontes\genericos\untSpoolImpressao.pas',
  untSpoolPrintDialog in 'fontes\genericos\untSpoolPrintDialog.pas',
  untWorkStationInfo in 'fontes\genericos\untWorkStationInfo.pas',
  untStepsBarPixFrame in 'fontes\views\untStepsBarPixFrame.pas' {frmStepsBarPixFrame: TFrame},
  untRelatoriosQRCodeDM in 'fontes\views\untRelatoriosQRCodeDM.pas' {frmRelatoriosQRCodeDM: TDataModule},
  untSelFilImpressao in 'fontes\views\untSelFilImpressao.pas' {frmSelFilImpressao},
  untTRequisicoesPixLib in 'fontes\requisicoes\untTRequisicoesPixLib.pas',
  PinPad.Classes.Gertec in '..\PinPad\PinPad.Classes.Gertec.pas',
  PinPad.Classes.PinPadFactory in '..\PinPad\PinPad.Classes.PinPadFactory.pas',
  PinPad.Interfaces in '..\PinPad\PinPad.Interfaces.pas',
  PinPad.Classes.Scope in '..\PinPad\PinPad.Classes.Scope.pas',
  untTMonitoramentoNovasCobrancasPix in 'fontes\requisicoes\untTMonitoramentoNovasCobrancasPix.pas',
  untTRequisicoesCitelPix in 'fontes\requisicoes\untTRequisicoesCitelPix.pas',
  blcksock in 'fontes\genericos\synalist\blcksock.pas',
  httpsend in 'fontes\genericos\synalist\httpsend.pas',
  ssl_openssl in 'fontes\genericos\synalist\ssl_openssl.pas',
  ssl_openssl_lib in 'fontes\genericos\synalist\ssl_openssl_lib.pas',
  synacode in 'fontes\genericos\synalist\synacode.pas',
  synafpc in 'fontes\genericos\synalist\synafpc.pas',
  synaip in 'fontes\genericos\synalist\synaip.pas',
  synautil in 'fontes\genericos\synalist\synautil.pas',
  synsock in 'fontes\genericos\synalist\synsock.pas',
  untMensagemRemoverPix in 'fontes\views\untMensagemRemoverPix.pas' {frmMensagemRemoverPix},
  untTelasAbertas in 'fontes\genericos\untTelasAbertas.pas',
  untConversorCertificadosCitel in 'fontes\views\untConversorCertificadosCitel.pas' {frmConversorCertificadosCitel},
  untInterfacePixTefBridge in 'fontes\genericos\untInterfacePixTefBridge.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}
{$SetPEOptFlags IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE}
{$R *.res}

exports
  InicializaIntegracaoPixCitel,
  InicializaIntegracaoPixCitelV2,
  RetornaBancosAtivosPIX,
  CriaObjetoRequisicoesPix,
  CriaObjetoRequisicoesPixEmpresa,
  CriaTelaLeituraQRCode,
  CriaTelaLeituraQRCodeNovoPix,
  dxInitializePix,
  dxFinalizePix,
  RetornaDadosAutorizacaoWebhookItau,
  RetornaCertificadosWebhookItau,
  CriaTelaLeituraQRCodeNovoPixCliente,
  AtualizaObjetoTelasAbertas,
  CriaTelaLeituraQRCodePagueFacil,
  CriaTelaLeituraQRCodeNovoPixPagueFacil,
  CriaTelaLeituraQRCodeNovoPixClienteV2,
  ImportarCertificadoCitelWebhookSantander,
  ConverterCertificadoPfxCitelWebhookItau,
  ConverterCertificadoPfxCitelWebhookItauSemTela,

  RetornaDadosChavePixTela,
  EnviaDadosDocumentoPixTela,
  EnviaDadosDocumentoPixTelaV2,

  RegistraBridgeTefPix,
  LibSuportaPixViaTef;

begin
end.
