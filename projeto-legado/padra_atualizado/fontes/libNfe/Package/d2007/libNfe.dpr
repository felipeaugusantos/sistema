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
  untUtil in '..\..\untUtil.pas',
  untFonteDados in '..\..\untFonteDados.pas',
  untValidadorNFE in '..\..\untValidadorNFE.pas',
  untFuncoesDll in '..\..\untFuncoesDll.pas',
  untConfigNFE in '..\..\untConfigNFE.pas',
  untDadosIcms in '..\..\untDadosIcms.pas',
  untNFESPainelFiscal in '..\..\untNFESPainelFiscal.pas',
  untTipoFreteAtc in '..\..\..\genericos\untTipoFreteAtc.pas',
  NfeApiWSBean in '..\..\fit\NfeApiWSBean.pas',
  NfeApiEnotas in '..\..\Enotas\NfeApiEnotas.pas',
  Dialogs,
  untNFESFit in '..\..\untNFESFit.pas',
  untNFSEnotas in '..\..\untNFSEnotas.pas',
  untUtilNFSe in '..\..\untUtilNFSe.pas',
  untManifestoEletronico in '..\..\untManifestoEletronico.pas',
  untManifestoEletronicoServiceImpl in '..\..\untManifestoEletronicoServiceImpl.pas',
  untInterfacesManifestoEletronico in '..\..\untInterfacesManifestoEletronico.pas',
  untConstantesNFe in '..\..\untConstantesNFe.pas',
  untUtilFIT in '..\..\untUtilFIT.pas',
  untFuncoesLibNfe in '..\..\untFuncoesLibNfe.pas',
  untDisparadorEventos in '..\..\untDisparadorEventos.pas',
  untVerificaIntegradorNFe in '..\..\untVerificaIntegradorNFe.pas',
  untSATCFE in '..\..\untSATCFE.pas',
  untEnviarArquivosServiceFIT in '..\..\untEnviarArquivosServiceFIT.pas',
  untValorPorExtenso in '..\..\untValorPorExtenso.pas',
  untManifestoFit in '..\..\untManifestoFit.pas',
  untIntegradorSATXML in '..\..\untIntegradorSATXML.pas',
  untIntegradorSAT in '..\..\untIntegradorSAT.pas',
  untIntegradorSATLOG in '..\..\untIntegradorSATLOG.pas',
  untInterfacesIntegradorSAT in '..\..\untInterfacesIntegradorSAT.pas',
  untNFEFit400 in '..\..\untNFEFit400.pas',
  untNFEFit400Ent in '..\..\untNFEFit400Ent.pas',
  untUtilBDEnt in '..\..\untUtilBDEnt.pas',
  untNFCEFit400 in '..\..\untNFCEFit400.pas',
  untImpressaoDiretaCitel in '..\..\untImpressaoDiretaCitel.pas',
  untConhecimentoEletronico in '..\..\untConhecimentoEletronico.pas',
  untInterfacesConhecimentoEletronico in '..\..\untInterfacesConhecimentoEletronico.pas',
  untCTEFit400 in '..\..\untCTEFit400.pas',
  untConhecimentoEletronicoServiceImpl in '..\..\untConhecimentoEletronicoServiceImpl.pas',
  untWorkStationInfo in '..\..\untWorkStationInfo.pas',
  untDicSis in '..\..\untDicSis.pas',
  untLogDanfe in '..\..\untLogDanfe.pas',
  untLibApiRest in '..\..\untLibApiRest.pas',
  untExecuteSoapWithMode in '..\..\untExecuteSoapWithMode.pas',
  untHttpTypes in '..\..\untHttpTypes.pas',
  untImportaXMLTerceirosServiceFIT in '..\..\untImportaXMLTerceirosServiceFIT.pas',
  untAuditarDocumentoServiceFIT in '..\..\untAuditarDocumentoServiceFIT.pas',
  untReformaTributaria in '..\..\untReformaTributaria.pas',
  Faturamento.Classes.CNPJ in '..\..\Faturamento.Classes.CNPJ.pas',
  untEventoConciliacaoFinanceiraServiceFIT in '..\..\untEventoConciliacaoFinanceiraServiceFIT.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

exports
  pSetaConfiguracoes,
  pSetaConfiguracoesPainel,
  fCriarFonteDadosBD,
  fCriarFonteDadosEmitenteBD,
  fCriarNFEService,
  fCriarNFEAdministrativoService,
  fNumeroSerial,
  fCriarManifestoEletronicoService,
  fCriarFonteDadosManifesto,
  fGetDisparadorEventos,
  pCarregaConfiguracoesLib,
  fCriarEnviarArquivosService,
  pSetVirtualUIPrintPDF,
  fCriarConhecimentoEletronicoService,
  fCriarEnviarArquivosServiceConfigurado,
  fCriarVerificarStatusServicoPelaUFServiceConfigurado,
  fCriarImportaXMLTerceirosServiceFITConfigurado,
  fCriarEventoConciliacaoFinanceiraServiceFITConfigurado,
  fCriarAuditarDocumentoServiceFIT,
  fCriarAmbienteEmpresaServiceFIT,
  fCriarFonteDadosConhecimento;

begin

end.
