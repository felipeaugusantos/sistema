program StatusPedidoService;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
{$region '  services.core,'}
  Services.Core.Cache in '..\..\..\Core\Services.Core.Cache.pas',
  Services.Core.Connection.Interfaces in '..\..\..\Core\Services.Core.Connection.Interfaces.pas',
  Services.Core.Connection.Manager in '..\..\..\Core\Services.Core.Connection.Manager.pas',
  Services.Core.Connection.UniDac in '..\..\..\Core\Services.Core.Connection.UniDac.pas',
  Services.Core.Settings in '..\..\..\Core\Services.Core.Settings.pas',
  Services.Core.Task.Lock in '..\..\..\Core\Services.Core.Task.Lock.pas',
  Services.Core.Task.Monitor in '..\..\..\Core\Services.Core.Task.Monitor.pas',
  Services.Core.Types in '..\..\..\Core\Services.Core.Types.pas',
  Services.Core.Utils in '..\..\..\Core\Services.Core.Utils.pas',
  Services.Core.Rest in '..\..\..\Core\Services.Core.Rest.pas',
{$endregion}
  Services.Status.Pedido.Atualizar in '..\..\Source\Services.Status.Pedido.Atualizar.pas',
  untTSituacaoPedidoVenda in '..\..\..\..\fontes\faturamento\untTSituacaoPedidoVenda.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untTypesCRM in '..\..\..\..\fontes\crm\untTypesCRM.pas',
  untLogAut in '..\..\..\..\fontes\genericos\untLogAut.pas',
  untValidaSituacaoFinanceiraPedido in '..\..\..\..\fontes\faturamento\untValidaSituacaoFinanceiraPedido.pas',
  untAtualizaOcorrenciasCRM in '..\..\..\..\fontes\crm\untAtualizaOcorrenciasCRM.pas',
  untIFuncoesCRM in '..\..\..\..\fontes\crm\untIFuncoesCRM.pas',
  untMsgInterna in '..\..\..\..\fontes\cadastros\untMsgInterna.pas',
  untHorarioSistema in '..\..\..\..\fontes\genericos\untHorarioSistema.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');
  pDefinirUsuarioConexao('rb_statpedvenda', 'serv!ce@citel#robo');

  While True do
  Begin
    try
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Iniciando status pedido reservado service ...');

      If Not AtualizarStatusPedido Then
        Sleep(60000);

      Writeln(DateTimeToStr(fNow) + ' - ' + 'Finalizando status pedido reservado service ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
