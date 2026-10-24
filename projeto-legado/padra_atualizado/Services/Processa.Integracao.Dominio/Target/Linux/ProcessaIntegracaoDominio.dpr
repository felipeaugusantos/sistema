program ProcessaIntegracaoDominio;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Services.Core.Connection.Interfaces in '..\..\..\Core\Services.Core.Connection.Interfaces.pas',
  Services.Core.Connection.Manager in '..\..\..\Core\Services.Core.Connection.Manager.pas',
  Services.Core.Task.Monitor in '..\..\..\Core\Services.Core.Task.Monitor.pas',
  Services.Core.Task.Lock in '..\..\..\Core\Services.Core.Task.Lock.pas',
  Services.Core.Settings in '..\..\..\Core\Services.Core.Settings.pas',
  Services.Core.Utils in '..\..\..\Core\Services.Core.Utils.pas',
  Services.Core.Cache in '..\..\..\Core\Services.Core.Cache.pas',
  Services.Core.Connection.UniDac in '..\..\..\Core\Services.Core.Connection.UniDac.pas',
  Services.Core.Connection.FireDac in '..\..\..\Core\Services.Core.Connection.FireDac.pas',
  Services.Core.Types in '..\..\..\Core\Services.Core.Types.pas',
  Services.Core.Rest in '..\..\..\Core\Services.Core.Rest.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untFuncoesDicionarios in '..\..\..\..\fontes\genericos\untFuncoesDicionarios.pas',
  untHorarioSistema in '..\..\..\..\fontes\genericos\untHorarioSistema.pas',
  untConstantes in '..\..\..\..\fontes\genericos\untConstantes.pas',
  untRestApi in '..\..\..\..\fontes\faturamento\untRestApi.pas',
  Faturamento.Interfaces.Conexao in '..\..\..\..\fontes\Core\Conexao\Faturamento.Interfaces.Conexao.pas',
  Faturamento.Connections.Functions in '..\..\..\..\fontes\Core\Faturamento.Connections.Functions.pas',
  Shared.Functions.Conexao.UniDac in '..\..\..\..\fontes\genericos\Shared.Functions.Conexao.UniDac.pas',
  Core.Funcoes in '..\..\..\..\fontes\Core\Core.Funcoes.pas',
  untDicionarioResultadoQuerySimples in '..\..\..\..\fontes\genericos\untDicionarioResultadoQuerySimples.pas',
  Shared.Core in '..\..\..\..\fontes\Core\Shared.Core.pas',
  Faturamento.Classes.CNPJ in '..\..\..\..\fontes\FuncoesCentralizadas\Faturamento.Classes.CNPJ.pas',
  untLogAut in '..\..\..\..\fontes\genericos\untLogAut.pas',
  untDominioSistemasFuncoesMultiPlataforma in '..\..\..\..\..\libDominioSistemas\fontes\Genericos\untDominioSistemasFuncoesMultiPlataforma.pas',
  DominioSistemas.Core.ApiClientInterface in '..\..\..\..\..\libDominioSistemas\fontes\Core\DominioSistemas.Core.ApiClientInterface.pas',
  DominioSistemas.Core.AutenticacaoInterface in '..\..\..\..\..\libDominioSistemas\fontes\Core\DominioSistemas.Core.AutenticacaoInterface.pas',
  DominioSistemas.Core.ConsultaInterface in '..\..\..\..\..\libDominioSistemas\fontes\Core\DominioSistemas.Core.ConsultaInterface.pas',
  DominioSistemas.Core.DadosDocumentosInterface in '..\..\..\..\..\libDominioSistemas\fontes\Core\DominioSistemas.Core.DadosDocumentosInterface.pas',
  DominioSistemas.Core.DocumentoFactoryRegistry in '..\..\..\..\..\libDominioSistemas\fontes\Core\DominioSistemas.Core.DocumentoFactoryRegistry.pas',
  DominioSistemas.Core.DocumentoInterface in '..\..\..\..\..\libDominioSistemas\fontes\Core\DominioSistemas.Core.DocumentoInterface.pas',
  DominioSistemas.Core.Exception in '..\..\..\..\..\libDominioSistemas\fontes\Core\DominioSistemas.Core.Exception.pas',
  DominioSistemas.Core.Utils in '..\..\..\..\..\libDominioSistemas\fontes\Core\DominioSistemas.Core.Utils.pas',
  DominioSistemas.DTO.DomPro in '..\..\..\..\..\libDominioSistemas\fontes\DTO\DominioSistemas.DTO.DomPro.pas',
  DominioSistemas.Factories.AutenticacaoFactory in '..\..\..\..\..\libDominioSistemas\fontes\Factories\DominioSistemas.Factories.AutenticacaoFactory.pas',
  DominioSistemas.Factories.ConsultaFactory in '..\..\..\..\..\libDominioSistemas\fontes\Factories\DominioSistemas.Factories.ConsultaFactory.pas',
  DominioSistemas.Factories.DadosDocumentosFactory in '..\..\..\..\..\libDominioSistemas\fontes\Factories\DominioSistemas.Factories.DadosDocumentosFactory.pas',
  DominioSistemas.Factories.NotaConhecimentoTransporteFactory in '..\..\..\..\..\libDominioSistemas\fontes\Factories\DominioSistemas.Factories.NotaConhecimentoTransporteFactory.pas',
  DominioSistemas.Factories.NotaEntradaMercadoriaFactory in '..\..\..\..\..\libDominioSistemas\fontes\Factories\DominioSistemas.Factories.NotaEntradaMercadoriaFactory.pas',
  DominioSistemas.Factories.NotaEntradaServicoFactory in '..\..\..\..\..\libDominioSistemas\fontes\Factories\DominioSistemas.Factories.NotaEntradaServicoFactory.pas',
  DominioSistemas.Factories.NotaSaidaMercadoriaFactory in '..\..\..\..\..\libDominioSistemas\fontes\Factories\DominioSistemas.Factories.NotaSaidaMercadoriaFactory.pas',
  DominioSistemas.Factories.NotaSaidaServicoFactory in '..\..\..\..\..\libDominioSistemas\fontes\Factories\DominioSistemas.Factories.NotaSaidaServicoFactory.pas',
  DominioSistemas.Infra.APIClient in '..\..\..\..\..\libDominioSistemas\fontes\Infra\DominioSistemas.Infra.APIClient.pas',
  DominioSistemas.Infra.Config in '..\..\..\..\..\libDominioSistemas\fontes\Infra\DominioSistemas.Infra.Config.pas',
  DominioSistemas.Infra.Repository in '..\..\..\..\..\libDominioSistemas\fontes\Infra\DominioSistemas.Infra.Repository.pas',
  DominioSistemas.Service.Autenticacao in '..\..\..\..\..\libDominioSistemas\fontes\Service\DominioSistemas.Service.Autenticacao.pas',
  DominioSistemas.Service.ConsultasEspecificas in '..\..\..\..\..\libDominioSistemas\fontes\Service\DominioSistemas.Service.ConsultasEspecificas.pas',
  DominioSistemas.Service.GerarXml in '..\..\..\..\..\libDominioSistemas\fontes\Service\DominioSistemas.Service.GerarXml.pas',
  DominioSistemas.Service.NotaConhecimentoTransporte in '..\..\..\..\..\libDominioSistemas\fontes\Service\DominioSistemas.Service.NotaConhecimentoTransporte.pas',
  DominioSistemas.Service.NotaEntradaMercadoria in '..\..\..\..\..\libDominioSistemas\fontes\Service\DominioSistemas.Service.NotaEntradaMercadoria.pas',
  DominioSistemas.Service.NotaEntradaServico in '..\..\..\..\..\libDominioSistemas\fontes\Service\DominioSistemas.Service.NotaEntradaServico.pas',
  DominioSistemas.Service.NotaSaidaMercadoria in '..\..\..\..\..\libDominioSistemas\fontes\Service\DominioSistemas.Service.NotaSaidaMercadoria.pas',
  DominioSistemas.Service.NotaSaidaServico in '..\..\..\..\..\libDominioSistemas\fontes\Service\DominioSistemas.Service.NotaSaidaServico.pas',
  Services.Processa.Integracao.Dominio in '..\..\Source\Services.Processa.Integracao.Dominio.pas',
  DominioSistemas.Controller.Robo.Exec in '..\..\..\..\..\libDominioSistemas\fontes\Controller\DominioSistemas.Controller.Robo.Exec.pas',
  DominioSistemas.DocumentoProcessor in '..\..\..\..\..\libDominioSistemas\fontes\DominioSistemas.DocumentoProcessor.pas',
  DominioSistemas.Infra.Util in '..\..\..\..\..\libDominioSistemas\fontes\Infra\DominioSistemas.Infra.Util.pas',
  untDominioSistemasRestApi in '..\..\..\..\..\libDominioSistemas\fontes\Genericos\untDominioSistemasRestApi.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');

  While True do
  Begin
    try
      Writeln(DateTimeToStr(nOw()) + ' - ' + 'Iniciando Processa Integração Domínio...');

      If Not ProcessarIntegracaoDominio Then
        Sleep(60000);

      Writeln(DateTimeToStr(nOw()) + ' - ' + 'Finalizando Processa Integração Domínio...');

      if VS_ExitProcessSignal then
        Break;
    except
      on E: Exception do
        Writeln(DateTimeToStr(nOw()) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
