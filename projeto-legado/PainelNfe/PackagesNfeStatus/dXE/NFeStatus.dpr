program NFeStatus;

uses
  ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Windows,
  Forms,
  SysUtils,
  Dialogs,
  Classes,
  VirtualUI_AutoRun in '..\..\VirtualUI\VirtualUI_AutoRun.pas',
  VirtualUI_SDK in '..\..\VirtualUI\VirtualUI_SDK.pas',
  untUtil in '..\..\untUtil.pas',
  untModulo in '..\..\untModulo.pas' {frmModulo: TDataModule},
  untLibNfe in '..\..\untLibNfe.pas',
  untConfigNFE in '..\..\libNfe\untConfigNFE.pas',
  untInterfaces in '..\..\libNfe\untInterfaces.pas',
  untConfiguracoes in '..\..\untConfiguracoes.pas' {frmConfiguracoes},
  untMensagemExplicativa in '..\..\untMensagemExplicativa.pas' {frmMensagemExplicativa},
  untPontosImpressao in '..\..\untPontosImpressao.pas' {frmPontosImpressao},
  untModuloReplicacao in '..\..\untModuloReplicacao.pas' {frmModuloReplicacao: TDataModule},
  untManifestoEletronico in '..\..\libNfe\untManifestoEletronico.pas',
  untInterfacesManifestoEletronico in '..\..\libNfe\untInterfacesManifestoEletronico.pas',
  untTestabilidade in '..\..\testabilidade\untTestabilidade.pas',
  untGravando in '..\..\genericos\untGravando.pas' {frmGravando},
  untCoordenadorStatusNFe in '..\..\consultastatus\untCoordenadorStatusNFe.pas',
  untEnviarXMLSat in '..\..\consultastatus\untEnviarXMLSat.pas',
  untPendenciasDPEC in '..\..\consultastatus\untPendenciasDPEC.pas',
  untLimparDanfes in '..\..\consultastatus\untLimparDanfes.pas',
  untVerificarStatus in '..\..\consultastatus\untVerificarStatus.pas',
  untRegistrarTarefa in '..\..\consultastatus\untRegistrarTarefa.pas',
  untProcessarTarefaNFe in '..\..\consultastatus\untProcessarTarefaNFe.pas',
  untConectando in '..\..\genericos\untConectando.pas' {frmConectando},
  untInterfacesConhecimentoEletronico in '..\..\libNfe\untInterfacesConhecimentoEletronico.pas',
  untIntegracaoCitel in '..\..\consultastatus\untIntegracaoCitel.pas',
  untConhecimentoEletronico in '..\..\libNfe\untConhecimentoEletronico.pas',
  untDicSis in '..\..\libNfe\untDicSis.pas',
  untLogDanfe in '..\..\libNfe\untLogDanfe.pas',
  untConfirmaXMLGravacao in '..\..\consultastatus\untConfirmaXMLGravacao.pas',
  untConsultaCadastro in '..\..\consultastatus\untConsultaCadastro.pas',
  untImportaXMLTerceiros in '..\..\consultastatus\untImportaXMLTerceiros.pas',
  untComplementarDocumento in '..\..\consultastatus\untComplementarDocumento.pas',
  untAuditarDocumento in '..\..\consultastatus\untAuditarDocumento.pas',
  Faturamento.Classes.CNPJ in '..\..\Faturamento.Classes.CNPJ.pas',
  untEventoConciliacaoFinanceira in '..\..\consultastatus\untEventoConciliacaoFinanceira.pas';

{$WEAKLINKRTTI ON}
{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

begin
  SetCurrentDir(ExtractFilePath(ParamStr(0)));//Req: 322163
  pConfiguraOpcoesRegionais;
  Application.Initialize;
  pExecutarTarefaNFe;
end.
