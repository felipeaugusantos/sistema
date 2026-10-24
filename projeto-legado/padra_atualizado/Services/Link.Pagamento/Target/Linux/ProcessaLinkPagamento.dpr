program ProcessaLinkPagamento;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Services.Core.Connection.Interfaces in '..\..\..\Core\Services.Core.Connection.Interfaces.pas',
  Services.Core.Connection.Manager in '..\..\..\Core\Services.Core.Connection.Manager.pas',
  Services.Processa.Link.Pagamento in '..\..\Source\Services.Processa.Link.Pagamento.pas',
  Services.Core.Task.Monitor in '..\..\..\Core\Services.Core.Task.Monitor.pas',
  Services.Core.Task.Lock in '..\..\..\Core\Services.Core.Task.Lock.pas',
  Services.Core.Settings in '..\..\..\Core\Services.Core.Settings.pas',
  Services.Core.Utils in '..\..\..\Core\Services.Core.Utils.pas',
  Services.Core.Cache in '..\..\..\Core\Services.Core.Cache.pas',
  Services.Core.Connection.UniDac in '..\..\..\Core\Services.Core.Connection.UniDac.pas',
  untRestApi in '..\..\..\..\fontes\faturamento\untRestApi.pas',
  Services.Core.Types in '..\..\..\Core\Services.Core.Types.pas',
  untArredondaParcelaImpl in '..\..\..\..\fontes\faturamento\untArredondaParcelaImpl.pas',
  untAdiantamentoClienteGenerico in '..\..\..\..\fontes\genericos\untAdiantamentoClienteGenerico.pas',
  untGravaMovCar in '..\..\..\..\fontes\financeiro\cartoes\untGravaMovCar.pas',
  untLogMca in '..\..\..\..\fontes\financeiro\cartoes\untLogMca.pas',
  Services.Core.Rest in '..\..\..\Core\Services.Core.Rest.pas',
  untHorarioSistema in '..\..\..\..\fontes\genericos\untHorarioSistema.pas',
  untConstantes in '..\..\..\..\fontes\genericos\untConstantes.pas',
  untDuplicatas in '..\..\..\..\fontes\genericos\untDuplicatas.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untLinkPagamentoCitelRetorno in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\api.esitef\untLinkPagamentoCitelRetorno.pas',
  untLinkPagamentoCitelStatus in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\api.esitef\untLinkPagamentoCitelStatus.pas',
  untLinkPagamentoCitelRepositorio in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\api.esitef\untLinkPagamentoCitelRepositorio.pas',
  untLinkPagamentoCitelRestApi in '..\..\..\..\fontes\faturamento\untLinkPagamentoCitelRestApi.pas',
  untClassesComumLinkPagamentoCitel in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\untClassesComumLinkPagamentoCitel.pas',
  untFactoryLinkPagamentoCitel in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\untFactoryLinkPagamentoCitel.pas',
  untImplementationLinkPagamentoCitelSiTef in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\untImplementationLinkPagamentoCitelSiTef.pas',
  untInterfaceLinkPagamentoCitel in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\untInterfaceLinkPagamentoCitel.pas',
  untImplementationLinkPagamentoCitelCielo in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\untImplementationLinkPagamentoCitelCielo.pas',
  untImplementationLinkPagamentoCitelCredPay in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\untImplementationLinkPagamentoCitelCredPay.pas',
  TypesLayoutPedidoCompra in '..\..\..\..\fontes\genericos\TypesLayoutPedidoCompra.pas',
  untTContasAReceberLinkPagamento in '..\..\Source\fontes\untTContasAReceberLinkPagamento.pas',
  untFuncoesComumLinkPagamentoCitel in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\untFuncoesComumLinkPagamentoCitel.pas',
  untClassesFinanceiro in '..\..\Source\fontes\financeiro\untClassesFinanceiro.pas',
  untMovBan in '..\..\Source\fontes\financeiro\untMovBan.pas',
  untImplementationLinkPagamentoCitelIpag in '..\..\..\..\fontes\financeiro\gerais\pagamento.online\untImplementationLinkPagamentoCitelIpag.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');
  TApplicationContext.strVersionNumber:= '74.111_1.0.0.3';
  pDefinirUsuarioConexao(LowerCase(fDecrypt('‰ÊõÎÏë¿ÁÈù')), fAjustaNovaSenhaComLetraMaiuscula(fDecrypt('¸Ùë≠ÂëÈëª˜Úû')));

  While True do
  Begin
    try
      Writeln(DateTimeToStr(nOw()) + ' - ' + 'Iniciando Processa Links de Pagamento ...');

      If Not ProcessarLinkPagamento Then
        Sleep(60000);

      Writeln(DateTimeToStr(nOw()) + ' - ' + 'Finalizando Processa Links de Pagamento ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(nOw()) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
