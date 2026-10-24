program IntegradorSAT;

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
  untUtil in '..\untUtil.pas',
  untModulo in '..\untModulo.pas' {frmModulo: TDataModule},
  untLibNfe in '..\untLibNfe.pas',
  untConfigNFE in '..\libNfe\untConfigNFE.pas',
  untInterfaces in '..\libNfe\untInterfaces.pas',
  untPontosImpressao in '..\untPontosImpressao.pas' {frmPontosImpressao},
  untModuloReplicacao in '..\untModuloReplicacao.pas' {frmModuloReplicacao: TDataModule},
  untGravando in '..\genericos\untGravando.pas' {frmGravando},
  untConectando in '..\genericos\untConectando.pas' {frmConectando},
  untManifestoEletronico in '..\libNfe\untManifestoEletronico.pas',
  untInterfacesManifestoEletronico in '..\libNfe\untInterfacesManifestoEletronico.pas',
  untConhecimentoEletronico in '..\libNfe\untConhecimentoEletronico.pas',
  untInterfacesConhecimentoEletronico in '..\libNfe\untInterfacesConhecimentoEletronico.pas',
  untModuloSAT in 'untModuloSAT.pas',
  untMenu in 'untMenu.pas' {frmMenu},
  untTLock in 'untTLock.pas',
  untConfiguracoes in 'untConfiguracoes.pas' {frmConfiguracoes},
  untCfgSATCFe in 'untCfgSATCFe.pas' {frmCfgSATCFe},
  untImpressaoDiretaCitel in '..\libNfe\untImpressaoDiretaCitel.pas',
  untLogDanfe in '..\libNfe\untLogDanfe.pas',
  untDicSis in '..\libNfe\untDicSis.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}

begin
  Application.Initialize;

  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm:= False;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmConfiguracoes, frmConfiguracoes);
  Application.CreateForm(TfrmCfgSATCFe, frmCfgSATCFe);
  Application.Run;
end.
