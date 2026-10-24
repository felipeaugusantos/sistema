program PainelNFe;

uses
  ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  MidasLib,
  Windows,
  Forms,
  SysUtils,
  VirtualUI_AutoRun in '..\..\VirtualUI\VirtualUI_AutoRun.pas',
  VirtualUI_SDK in '..\..\VirtualUI\VirtualUI_SDK.pas',
  untPrincipal in '..\..\untPrincipal.pas' {frmPrincipal},
  untUtil in '..\..\untUtil.pas',
  untModulo in '..\..\untModulo.pas' {frmModulo: TDataModule},
  untLibNfe in '..\..\untLibNfe.pas',
  untConfigNFE in '..\..\libNfe\untConfigNFE.pas',
  untInterfaces in '..\..\libNfe\untInterfaces.pas',
  untDicSis in '..\..\libNfe\untDicSis.pas',
  untLogDanfe in '..\..\libNfe\untLogDanfe.pas',
  untConfiguracoes in '..\..\untConfiguracoes.pas' {frmConfiguracoes},
  untDigDadConsumidor in '..\..\untDigDadConsumidor.pas' {frmDigDadConsumidor},
  untPontosImpressao in '..\..\untPontosImpressao.pas' {frmPontosImpressao},
  untAlterarNCMTintas in '..\..\untAlterarNCMTintas.pas' {frmAlterarNCMTintas},
  untSefazParalisado in '..\..\untSefazParalisado.pas' {frmSefazParalisado},
  untModuloReplicacao in '..\..\untModuloReplicacao.pas' {frmModuloReplicacao: TDataModule},
  untManifestoEletronico in '..\..\libNfe\untManifestoEletronico.pas',
  untInterfacesManifestoEletronico in '..\..\libNfe\untInterfacesManifestoEletronico.pas',
  untTestabilidade in '..\..\testabilidade\untTestabilidade.pas',
  untGravando in '..\..\genericos\untGravando.pas' {frmGravando},
  untConectando in '..\..\genericos\untConectando.pas' {frmConectando},
  untFatDigChaveDev in '..\..\untFatDigChaveDev.pas' {frmFatDigChaveDev},
  untSelDocumentosReferenciar in '..\..\untSelDocumentosReferenciar.pas' {frmSelDocumentosReferenciar},
  untDadosExportacao in '..\..\untDadosExportacao.pas' {frmDadosExportacao},
  untConhecimentoEletronico in '..\..\libNfe\untConhecimentoEletronico.pas',
  untInterfacesConhecimentoEletronico in '..\..\libNfe\untInterfacesConhecimentoEletronico.pas',
  untDigNCMItemEspecial in '..\..\untDigNCMItemEspecial.pas' {frmDigNCMItemEspecial},
  untConsulta in '..\..\genericos\untConsulta.pas' {frmConsulta},
  untConsultaController in '..\..\genericos\untConsultaController.pas',
  untConsultaModel in '..\..\genericos\untConsultaModel.pas',
  untConsultaDao in '..\..\genericos\untConsultaDao.pas',
  untNCMController in '..\..\untNCMController.pas',
  untNCMDao in '..\..\untNCMDao.pas',
  untNCMModel in '..\..\untNCMModel.pas',
  untLogAut in '..\..\genericos\untLogAut.pas',
  untWorkStationInfo in '..\..\genericos\untWorkStationInfo.pas',
  untSelEmp in '..\..\untSelEmp.pas' {frmSelEmp},
  untMensagemExplicativa in '..\..\untMensagemExplicativa.pas',
  Faturamento.Classes.CNPJ in '..\..\Faturamento.Classes.CNPJ.pas';

{$WEAKLINKRTTI ON}
{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

begin
  pConfiguraOpcoesRegionais;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
