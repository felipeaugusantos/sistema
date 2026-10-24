program ProcessaCobrancaEletronica;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Services.Core.Connection.Interfaces in '..\..\..\Core\Services.Core.Connection.Interfaces.pas',
  Services.Core.Connection.Manager in '..\..\..\Core\Services.Core.Connection.Manager.pas',
  Services.Processa.Cobranca.Eletronica in '..\..\Source\Services.Processa.Cobranca.Eletronica.pas',
  Services.Core.Task.Monitor in '..\..\..\Core\Services.Core.Task.Monitor.pas',
  Services.Core.Task.Lock in '..\..\..\Core\Services.Core.Task.Lock.pas',
  Services.Core.Settings in '..\..\..\Core\Services.Core.Settings.pas',
  Services.Core.Utils in '..\..\..\Core\Services.Core.Utils.pas',
  Services.Core.Cache in '..\..\..\Core\Services.Core.Cache.pas',
  Services.Core.Connection.UniDac in '..\..\..\Core\Services.Core.Connection.UniDac.pas',
  Services.Core.Rest in '..\..\..\Core\Services.Core.Rest.pas',
  Services.Core.Types in '..\..\..\Core\Services.Core.Types.pas',
  untRestApi in '..\..\..\..\fontes\faturamento\untRestApi.pas',
  untArredondaParcelaImpl in '..\..\..\..\fontes\faturamento\untArredondaParcelaImpl.pas',
  untAdiantamentoClienteGenerico in '..\..\..\..\fontes\genericos\untAdiantamentoClienteGenerico.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untLogMca in '..\..\..\..\fontes\financeiro\cartoes\untLogMca.pas',
  untBaseIntegracaoJSON in '..\..\..\..\fontes\libFuncoes\untBaseIntegracaoJSON.pas',
  PagarMe.Base.JSON in '..\..\..\..\fontes\PagarMe\v4\bases\PagarMe.Base.JSON.pas',
  PagarMe.Classe.LinkPagamento in '..\..\..\..\fontes\PagarMe\v4\classes\PagarMe.Classe.LinkPagamento.pas',
  CobrancaEletronica.Lib.Types in '..\..\..\..\fontes\cobrancaEletronica\libs\CobrancaEletronica.Lib.Types.pas',
  PagarMe.Base.Service in '..\..\Source\Pagar.me\bases\PagarMe.Base.Service.pas',
  PagarMe.Lib.Connection in '..\..\Source\Pagar.me\libs\PagarMe.Lib.Connection.pas',
  CobrancaEletronica.Controller.PagarMe in '..\..\Source\CobrancaEletronica\controllers\CobrancaEletronica.Controller.PagarMe.pas',
  PagarMe.Service.LinkPagamento in '..\..\Source\Pagar.me\services\PagarMe.Service.LinkPagamento.pas',
  CobrancaEletronica.Base.Service in '..\..\Source\CobrancaEletronica\bases\CobrancaEletronica.Base.Service.pas',
  PagarMe.Lib.Validate in '..\..\Source\Pagar.me\libs\PagarMe.Lib.Validate.pas',
  PagarMe.Lib.Dicionario in '..\..\Source\Pagar.me\libs\PagarMe.Lib.Dicionario.pas',
  PagarMe.Service.Recebivel in '..\..\Source\Pagar.me\services\PagarMe.Service.Recebivel.pas',
  CobrancaEletronica.Classe in '..\..\Source\CobrancaEletronica\classes\CobrancaEletronica.Classe.pas',
  untGravaMovCar in '..\..\..\..\fontes\financeiro\cartoes\untGravaMovCar.pas',
  PagarMe.Classe.Transacao in '..\..\..\..\fontes\PagarMe\v4\classes\PagarMe.Classe.Transacao.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');
  pDefinirUsuarioConexao('autcom_citel', 'belamupe_citel');

  While True do
  Begin
    try
      Writeln(DateTimeToStr(nOw()) + ' - ' + 'Iniciando Processa Links de Pagamento de Cobranças Eletrônicas ...');

      If Not ProcessarCobrancaEletronica Then
        Sleep(60000);

      Writeln(DateTimeToStr(nOw()) + ' - ' + 'Finalizando Processa Links de Pagamento de Cobranças Eletrônicas ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(nOw()) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
