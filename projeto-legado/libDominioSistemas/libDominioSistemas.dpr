library libDominioSistemas;

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
  SysUtils,
  Classes,
  MidasLib,
  RlConsts,
  Windows,
  untConstantes in '..\padra_atualizado\fontes\genericos\untConstantes.pas',
  TypesLayoutPedidoCompra in '..\padra_atualizado\fontes\genericos\TypesLayoutPedidoCompra.pas',
  untTypesSistema in '..\padra_atualizado\fontes\genericos\untTypesSistema.pas',
  DominioSistemas.Core.ApiClientInterface in 'fontes\Core\DominioSistemas.Core.ApiClientInterface.pas',
  DominioSistemas.Core.AutenticacaoInterface in 'fontes\Core\DominioSistemas.Core.AutenticacaoInterface.pas',
  DominioSistemas.Core.ConsultaInterface in 'fontes\Core\DominioSistemas.Core.ConsultaInterface.pas',
  DominioSistemas.Core.DadosDocumentosInterface in 'fontes\Core\DominioSistemas.Core.DadosDocumentosInterface.pas',
  DominioSistemas.Core.DocumentoFactoryRegistry in 'fontes\Core\DominioSistemas.Core.DocumentoFactoryRegistry.pas',
  DominioSistemas.Core.DocumentoInterface in 'fontes\Core\DominioSistemas.Core.DocumentoInterface.pas',
  DominioSistemas.Core.Exception in 'fontes\Core\DominioSistemas.Core.Exception.pas',
  DominioSistemas.Core.Utils in 'fontes\Core\DominioSistemas.Core.Utils.pas',
  DominioSistemas.DTO.DomPro in 'fontes\DTO\DominioSistemas.DTO.DomPro.pas',
  DominioSistemas.Factories.AutenticacaoFactory in 'fontes\Factories\DominioSistemas.Factories.AutenticacaoFactory.pas',
  DominioSistemas.Factories.ConsultaFactory in 'fontes\Factories\DominioSistemas.Factories.ConsultaFactory.pas',
  DominioSistemas.Factories.DadosDocumentosFactory in 'fontes\Factories\DominioSistemas.Factories.DadosDocumentosFactory.pas',
  DominioSistemas.Factories.NotaConhecimentoTransporteFactory in 'fontes\Factories\DominioSistemas.Factories.NotaConhecimentoTransporteFactory.pas',
  DominioSistemas.Factories.NotaEntradaMercadoriaFactory in 'fontes\Factories\DominioSistemas.Factories.NotaEntradaMercadoriaFactory.pas',
  DominioSistemas.Factories.NotaEntradaServicoFactory in 'fontes\Factories\DominioSistemas.Factories.NotaEntradaServicoFactory.pas',
  DominioSistemas.Factories.NotaSaidaMercadoriaFactory in 'fontes\Factories\DominioSistemas.Factories.NotaSaidaMercadoriaFactory.pas',
  DominioSistemas.Factories.NotaSaidaServicoFactory in 'fontes\Factories\DominioSistemas.Factories.NotaSaidaServicoFactory.pas',
  DominioSistemas.Infra.APIClient in 'fontes\Infra\DominioSistemas.Infra.APIClient.pas',
  DominioSistemas.Infra.Config in 'fontes\Infra\DominioSistemas.Infra.Config.pas',
  DominioSistemas.Infra.Repository in 'fontes\Infra\DominioSistemas.Infra.Repository.pas',
  DominioSistemas.Infra.Util in 'fontes\Infra\DominioSistemas.Infra.Util.pas',
  DominioSistemas.Service.Autenticacao in 'fontes\Service\DominioSistemas.Service.Autenticacao.pas',
  DominioSistemas.Service.ConsultasEspecificas in 'fontes\Service\DominioSistemas.Service.ConsultasEspecificas.pas',
  DominioSistemas.Service.GerarXml in 'fontes\Service\DominioSistemas.Service.GerarXml.pas',
  DominioSistemas.Service.NotaConhecimentoTransporte in 'fontes\Service\DominioSistemas.Service.NotaConhecimentoTransporte.pas',
  DominioSistemas.Service.NotaEntradaMercadoria in 'fontes\Service\DominioSistemas.Service.NotaEntradaMercadoria.pas',
  DominioSistemas.Service.NotaEntradaServico in 'fontes\Service\DominioSistemas.Service.NotaEntradaServico.pas',
  DominioSistemas.Service.NotaSaidaMercadoria in 'fontes\Service\DominioSistemas.Service.NotaSaidaMercadoria.pas',
  DominioSistemas.Service.NotaSaidaServico in 'fontes\Service\DominioSistemas.Service.NotaSaidaServico.pas',
  DominioSistemas.View.ConsultarDocumentos in 'fontes\View\DominioSistemas.View.ConsultarDocumentos.pas' {frmDominioSistemasConsultarDocumentos},
  DominioSistemas.View.ProcessarDocumentos in 'fontes\View\DominioSistemas.View.ProcessarDocumentos.pas' {frmDominioSistemasProcessarDocumentos},
  DominioSistemas.DocumentoProcessor in 'fontes\DominioSistemas.DocumentoProcessor.pas',
  untDominioSistemas in 'untDominioSistemas.pas',
  untDllDominioSistemas in 'untDllDominioSistemas.pas',
  untILibDominioSistemasWrapper in 'Interfaces\untILibDominioSistemasWrapper.pas',
  untDominioSistemasFuncoes in 'fontes\Genericos\untDominioSistemasFuncoes.pas',
  untDominioSistemasFuncoesMultiPlataforma in 'fontes\Genericos\untDominioSistemasFuncoesMultiPlataforma.pas',
  untDominioSistemasRestApi in 'fontes\Genericos\untDominioSistemasRestApi.pas',
  untLibDominioSistemasPai in 'fontes\View\untLibDominioSistemasPai.pas' {frmPaiDominioSistemas},
  untLibDominioSistemasPaiSimples in 'fontes\View\untLibDominioSistemasPaiSimples.pas' {frmPaiDominioSistemasSimples},
  untDominioSistemasConstantes in 'fontes\Genericos\untDominioSistemasConstantes.pas',
  untDominioSistemasTelasAbertas in 'fontes\Classes\untDominioSistemasTelasAbertas.pas',
  untLibDominioSistemasInterfacesTipos in 'Interfaces\untLibDominioSistemasInterfacesTipos.pas',
  untLibDominioSistemasPaiEdit in 'fontes\View\untLibDominioSistemasPaiEdit.pas' {frmPaiDominioSistemasEdit},
  untLibCartoesGravando in 'fontes\View\untLibCartoesGravando.pas' {frmGravando},
  untLibCartoesGravandoOld in 'fontes\View\untLibCartoesGravandoOld.pas' {frmGravandoOld},
  untGenericProcedureFormGravando in 'fontes\View\untGenericProcedureFormGravando.pas',
  untLibDominioSistemasFuncoes in 'fontes\Genericos\untLibDominioSistemasFuncoes.pas',
  untLibDominioSistemasPaiConfirma in 'fontes\View\untLibDominioSistemasPaiConfirma.pas' {frmPaiDominioSistemasConfirma},
  untLibDominioSistemasExportarArquivo in 'fontes\Genericos\untLibDominioSistemasExportarArquivo.pas',
  untTBatchSQL in '..\padra_atualizado\fontes\genericos\BatchSQL\untTBatchSQL.pas',
  untTBatchSQL.Helper in '..\padra_atualizado\fontes\genericos\BatchSQL\untTBatchSQL.Helper.pas';

{$R *.res}
{$R VCLStyles.res}

Exports
  pShowFormDominio,
  pInicializaObjetoLibDominioSistemas,
  dxInitialize,
  SetStyleAutcom ;

begin
  RlConsts.SetVersion(3,71,'B');
end.
