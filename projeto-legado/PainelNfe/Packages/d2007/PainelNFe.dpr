program PainelNFe;

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
  untPrincipal in '..\..\untPrincipal.pas' {frmPrincipal},
  untUtil in '..\..\untUtil.pas',
  untModulo in '..\..\untModulo.pas' {frmModulo: TDataModule},
  untLibNfe in '..\..\untLibNfe.pas',
  untConfigNFE in '..\..\libNfe\untConfigNFE.pas',
  untInterfaces in '..\..\libNfe\untInterfaces.pas',
  untConfiguracoes in '..\..\untConfiguracoes.pas' {frmConfiguracoes},
  untDigDadConsumidor in '..\..\untDigDadConsumidor.pas' {frmDigDadConsumidor},
  untPontosImpressao in '..\..\untPontosImpressao.pas' {frmPontosImpressao},
  untAlterarNCMTintas in '..\..\untAlterarNCMTintas.pas' {frmAlterarNCMTintas},
  untSefazParalisado in '..\..\untSefazParalisado.pas' {frmSefazParalisado},
  untModuloReplicacao in '..\..\untModuloReplicacao.pas' {frmModuloReplicacao: TDataModule},
  untThreadLimparDanfes in '..\..\untThreadLimparDanfes.pas',
  untManifestoEletronico in '..\..\libNfe\untManifestoEletronico.pas',
  untInterfacesManifestoEletronico in '..\..\libNfe\untInterfacesManifestoEletronico.pas',
  untTestabilidade in '..\..\testabilidade\untTestabilidade.pas',
  untGravando in '..\..\genericos\untGravando.pas' {frmGravando},
  untConsulta in '..\..\genericos\untConsulta.pas' {frmConsulta},
  untConsultaController in '..\..\genericos\untConsultaController.pas',
  untConsultaDao in '..\..\genericos\untConsultaDao.pas',
  untConsultaModel in '..\..\genericos\untConsultaModel.pas',
  untDigNCMItemEspecial in '..\..\untDigNCMItemEspecial.pas' {frmDigNCMItemEspecial},
  untNCMController in '..\..\untNCMController.pas',
  untNCMDao in '..\..\untNCMDao.pas',
  untNCMModel in '..\..\untNCMModel.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
