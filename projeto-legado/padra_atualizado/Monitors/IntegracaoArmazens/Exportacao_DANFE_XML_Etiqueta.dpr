program Exportacao_DANFE_XML_Etiqueta;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Winapi.Windows,
  MidasLib,
  Vcl.Forms,
  untPrincipal in 'fontes\untPrincipal.pas' {frmPrincipal_IntegracaoArmazens},
  untMensagem in 'fontes\untMensagem.pas' {frmMensagem},
  untAcesso in 'fontes\untAcesso.pas' {frmAcesso},
  untConfiguracoes in 'fontes\untConfiguracoes.pas' {frmConfiguracoes},
  untSIGEPWebClasses in '..\..\fontes\SigepWeb\untSIGEPWebClasses.pas',
  untSIGEPWebFuncoes in '..\..\fontes\SigepWeb\untSIGEPWebFuncoes.pas',
  untFuncoesSimples in '..\Shared\untFuncoesSimples.pas',
  untModuloLegenda in '..\..\fontes\genericos\untModuloLegenda.pas',
  untConstantes in '..\..\fontes\genericos\untConstantes.pas',
  untTypesSistema in '..\..\fontes\genericos\untTypesSistema.pas',
  untThreadUtils in '..\..\fontes\genericos\untThreadUtils.pas',
  untCfgRepositorio in '..\..\fontes\configuracoes\untCfgRepositorio.pas' {frmCfgRepositorio: TDataModule},
  untInterfacedObjectNoCount in '..\..\fontes\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untICamposUso in '..\..\fontes\genericos\untICamposUso.pas',
  untModulo in '..\..\fontes\genericos\untModulo.pas' {frmModulo: TDataModule},
  untListaLogErros in '..\..\fontes\genericos\untListaLogErros.pas',
  untGravaINNODBStatus in '..\..\fontes\genericos\untGravaINNODBStatus.pas',
  untWaitWindow in '..\..\fontes\genericos\untWaitWindow.pas' {frmWaitWindow},
  untModuloReplicacao in '..\..\fontes\genericos\untModuloReplicacao.pas' {frmModuloReplicacao: TDataModule},
  untTestabilidade in '..\..\fontes\util\testabilidade\untTestabilidade.pas',
  untSubjectClass in '..\..\fontes\genericos\untSubjectClass.pas',
  untSubjectIntf in '..\..\fontes\genericos\untSubjectIntf.pas',
  untGravando in '..\..\fontes\genericos\untGravando.pas' {frmGravando},
  untGravandoObs in '..\..\fontes\genericos\untGravandoObs.pas',
  untGenericProcedureFormGravando in '..\..\fontes\genericos\untGenericProcedureFormGravando.pas',
  untMensagemSonora in '..\..\fontes\genericos\untMensagemSonora.pas' {frmMensagemSonora},
  Yapay.Api.Resources in '..\..\fontes\financeiro\gerais\api.yapay\api\Yapay.Api.Resources.pas',
  Promocao.Regra.Preco.Sugestao in '..\..\fontes\faturamento\Promocao\Promocao.Regra.Preco.Sugestao.pas',
  untDespacho in '..\..\fontes\util\EditorEtiquetas\untDespacho.pas',
  untObservacao in 'fontes\untObservacao.pas' {frmObservacao},
  untCFGBAN_Class in '..\..\fontes\genericos\untCFGBAN_Class.pas',
  untCFGBAN_Dao in '..\..\fontes\genericos\untCFGBAN_Dao.pas',
  Mandae.Classes in '..\..\fontes\Mandae\Mandae.Classes.pas',
  untJadlog in '..\..\fontes\Jadlog\untJadlog.pas',
  untMarketPlace in '..\..\fontes\MarketPlace\untMarketPlace.pas',
  untPLP_Consulta_Direct in '..\..\fontes\faturamento\B2W\untPLP_Consulta_Direct.pas',
  untPLP_EtiquetaFrete_Direct in '..\..\fontes\faturamento\B2W\untPLP_EtiquetaFrete_Direct.pas',
  untWS_SkyHub in '..\..\fontes\faturamento\B2W\untWS_SkyHub.pas',
  untHubCitel in 'fontes\Marketplace\untHubCitel.pas',
  untMarketPlace.Classes in '..\..\fontes\MarketPlace\untMarketPlace.Classes.pas',
  httpsend in '..\..\fontes\genericos\synalist\httpsend.pas',
  blcksock in '..\..\fontes\genericos\synalist\blcksock.pas',
  synautil in '..\..\fontes\genericos\synalist\synautil.pas',
  synafpc in '..\..\fontes\genericos\synalist\synafpc.pas',
  synsock in '..\..\fontes\genericos\synalist\synsock.pas',
  synacode in '..\..\fontes\genericos\synalist\synacode.pas',
  synaip in '..\..\fontes\genericos\synalist\synaip.pas',
  ssl_openssl_lib in '..\..\fontes\genericos\synalist\ssl_openssl_lib.pas',
  ssl_openssl in '..\..\fontes\genericos\synalist\ssl_openssl.pas',
  untHorarioSistema in '..\..\fontes\genericos\untHorarioSistema.pas',
  TypesLayoutPedidoCompra in '..\..\fontes\genericos\TypesLayoutPedidoCompra.pas',
  untCorreiosLib in '..\..\fontes\Correios\untCorreiosLib.pas',
  untCorreiosMain in '..\..\fontes\Correios\untCorreiosMain.pas',
  Correios.Types in '..\..\fontes\FuncoesCentralizadas\Correios.Types.pas',
  Correios.Interfaces in '..\..\fontes\FuncoesCentralizadas\Correios.Interfaces.pas',
  untConnection in '..\..\fontes\Core\Conexao\untConnection.pas',
  untQuery in '..\..\fontes\Core\Conexao\untQuery.pas',
  untQueryParam in '..\..\fontes\Core\Conexao\untQueryParam.pas';

var
  frmPrincipal_IntegracaoArmazens : TfrmPrincipal_IntegracaoArmazens;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Exportação DANFE, XML e Etiqueta';
  Application.CreateForm(TfrmPrincipal_IntegracaoArmazens, frmPrincipal_IntegracaoArmazens);
  frmPrincipal_IntegracaoArmazens.Show;

  If Not VS_TSPlus Then
    Application.Minimize;

  frmPrincipal_IntegracaoArmazens.btnMonitorarClick(Application);

  Application.Run;
end.
