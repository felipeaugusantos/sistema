library libRequisicoesPix;

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
  MidasLib,
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Windows,
  untFuncoesLibRequisicoesPix in 'genericos\untFuncoesLibRequisicoesPix.pas',
  untTRequisicoesPixTls13 in 'genericos\untTRequisicoesPixTls13.pas',
  blcksock in 'genericos\synalist\blcksock.pas',
  httpsend in 'genericos\synalist\httpsend.pas',
  ssl_openssl in 'genericos\synalist\ssl_openssl.pas',
  ssl_openssl_lib in 'genericos\synalist\ssl_openssl_lib.pas',
  synacode in 'genericos\synalist\synacode.pas',
  synafpc in 'genericos\synalist\synafpc.pas',
  synaip in 'genericos\synalist\synaip.pas',
  synautil in 'genericos\synalist\synautil.pas',
  synsock in 'genericos\synalist\synsock.pas';

{$R *.res}

exports
  GetToken,
  GetTokenSicoob,
  CriarCobranca,
  AlterarCobranca,
  ConsultarCobrancaPorIxId,
  SolicitarDevolucao,
  GetTokenShipay,
  CriarCobrancaShipay,
  ConsultarCobrancaPorOrderIdShipay,
  CancelarCobrancaShipay,
  SolicitarDevolucaoShipay,
  CriarCobrancaSynalist,
  ConsultarCobrancaPorIxIdSynalist,
  AlterarCobrancaSynalist,
  SolicitarDevolucaoSynalist,
  GetTokenSynalist;

begin
end.
