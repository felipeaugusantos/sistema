library libNfe;

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
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Windows,
  SysUtils,
  Classes,
  untInterfaces in '..\..\untInterfaces.pas',
  untUtilBD in '..\..\untUtilBD.pas',
  untNFEServiceImpl in '..\..\untNFEServiceImpl.pas',
  untNFEOphos in '..\..\untNFEOphos.pas',
  untUtil in '..\..\untUtil.pas',
  untFonteDados in '..\..\untFonteDados.pas',
  untValidadorNFE in '..\..\untValidadorNFE.pas',
  untFuncoesDll in '..\..\untFuncoesDll.pas',
  untConfigNFE in '..\..\untConfigNFE.pas',
  untNFEOphos200 in '..\..\untNFEOphos200.pas',
  untDadosIcms in '..\..\untDadosIcms.pas',
  untNFEMegalosIdeas in '..\..\untNFEMegalosIdeas.pas',
  untNFESPainelFiscal in '..\..\untNFESPainelFiscal.pas',
  untInterfacesOphos in '..\..\untOphos\untInterfacesOphos.pas',
  untOphos200 in '..\..\untOphos\untOphos200.pas',
  untOphos201 in '..\..\untOphos\untOphos201.pas',
  untOphos202 in '..\..\untOphos\untOphos202.pas',
  untOphos203 in '..\..\untOphos\untOphos203.pas',
  untTipoFreteAtc in '..\..\..\genericos\untTipoFreteAtc.pas',
  untNFEFit200 in '..\..\untNFEFit200.pas',
  NfeApiWSBean in '..\..\fit\NfeApiWSBean.pas',
  Dialogs,
  untNFESFit in '..\..\untNFESFit.pas',
  untUtilNFSe in '..\..\untUtilNFSe.pas',
  untOphos205 in '..\..\untOphos\untOphos205.pas',
  untManifestoEletronicoServiceImpl in '..\..\untManifestoEletronicoServiceImpl.pas',
  untInterfacesManifestoEletronico in '..\..\untInterfacesManifestoEletronico.pas',
  untManifestoEletronico in '..\..\untManifestoEletronico.pas',
  untNFCEFit200 in '..\..\untNFCEFit200.pas',
  untConstantesNFe in '..\..\untConstantesNFe.pas',
  untUtilFIT in '..\..\untUtilFIT.pas',
  untFuncoesLibNfe in '..\..\untFuncoesLibNfe.pas',
  untDisparadorEventos in '..\..\untDisparadorEventos.pas',
  untNFEFit310 in '..\..\untNFEFit310.pas',
  untValorPorExtenso in '..\..\untValorPorExtenso.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

exports

{$IF Defined(VER250) Or Defined(UNIDAC)}
  dxInitializeLibNfe,
  dxFinalizeLibNfe,
{$IFEND}

  pSetaConfiguracoes,
  pSetaConfiguracoesPainel,
  fCriarFonteDadosBD,
  fCriarFonteDadosEmitenteBD,
  fCriarNFEService,
  fCriarNFEAdministrativoService,
  fNumeroSerial,
  fCriarManifestoEletronicoService,
  fCriarFonteDadosManifesto,
  pSetVirtualUIPrintPDF;

begin

end.
