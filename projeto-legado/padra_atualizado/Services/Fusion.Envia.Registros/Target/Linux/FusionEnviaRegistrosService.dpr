program FusionEnviaRegistrosService;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  {$region}
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
  Services.Fusion.Enviar.Registros in '..\..\Source\Services.Fusion.Enviar.Registros.pas',
  Shared.Core in '..\..\..\..\fontes\Core\Shared.Core.pas',
  Core.Funcoes in '..\..\..\..\fontes\Core\Core.Funcoes.pas',
  Faturamento.Connections.Functions in '..\..\..\..\fontes\Core\Faturamento.Connections.Functions.pas',
  Faturamento.Interfaces.Conexao in '..\..\..\..\fontes\Core\Conexao\Faturamento.Interfaces.Conexao.pas',
  Shared.Functions.Conexao.UniDac in '..\..\..\..\fontes\genericos\Shared.Functions.Conexao.UniDac.pas',
  untGTinForTipos in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untConstantes in '..\..\..\..\fontes\genericos\untConstantes.pas',
  untMadeireira in '..\..\..\..\fontes\faturamento\untMadeireira.pas',
  untSaldoPedidoCompra in '..\..\..\..\fontes\movimentacaoitens\PedidoDeCompra\untSaldoPedidoCompra.pas',
  untIFatReservaSaldo in '..\..\..\..\fontes\faturamento\untIFatReservaSaldo.pas',
  untTFatReservaSaldo in '..\..\..\..\fontes\faturamento\untTFatReservaSaldo.pas',
  untIFatEntregaFutura in '..\..\..\..\fontes\faturamento\untIFatEntregaFutura.pas',
  untTFatEntregaFutura in '..\..\..\..\fontes\faturamento\untTFatEntregaFutura.pas',
  Controller.Faturamento.Precos.PrecoCusto in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Precos\PrecoCusto\Controller.Faturamento.Precos.PrecoCusto.pas',
  Controller.Faturamento.Interfaces.Precos.PrecoCusto in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Precos\Interfaces\Controller.Faturamento.Interfaces.Precos.PrecoCusto.pas',
  untFatCalcularPrecosService in '..\..\..\..\fontes\faturamento\untFatCalcularPrecosService.pas',
  untFatCalcularServicePath in '..\..\..\..\fontes\faturamento\untFatCalcularServicePath.pas',
  Controller.Faturamento.Interfaces.Cache in '..\..\..\..\fontes\Faturamento\Controller.Faturamento.Interfaces.Cache.pas',
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.Parametros.Comum.pas',
  untTConfiguracao in '..\..\..\..\fontes\configuracoes\untTConfiguracao.pas',
  untIConfiguracao in '..\..\..\..\fontes\configuracoes\untIConfiguracao.pas',
  untCalculoPrecoVenda in '..\..\..\..\fontes\genericos\untCalculoPrecoVenda.pas',
  untTMemoriaCalculoPrecoVendaMargem in '..\..\..\..\fontes\genericos\untTMemoriaCalculoPrecoVendaMargem.pas',
  OrdemProducaoIndustrial.Funcoes in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.Funcoes.pas',
  untParCalculaPrecoCusto in '..\..\..\..\fontes\genericos\untParCalculaPrecoCusto.pas',
  untFuncFatTypes in '..\..\..\..\fontes\faturamento\untFuncFatTypes.pas',
  untTMatrizSaldosColorantes in '..\..\..\..\fontes\genericos\untTMatrizSaldosColorantes.pas',
  untIIdentificadorTinta in '..\..\..\..\fontes\iTintas\untIIdentificadorTinta.pas',
  untAutcomDllTinta in '..\..\..\..\fontes\genericos\untAutcomDllTinta.pas',
  untIExecutaSQLReplicacaoTinta in '..\..\..\..\fontes\iTintas\untIExecutaSQLReplicacaoTinta.pas',
  untCadIte in '..\..\..\..\fontes\cadastros\untCadIte.pas',
  untCadLote in '..\..\..\..\fontes\cadastros\untCadLote.pas',
  untICadLote in '..\..\..\..\fontes\cadastros\untICadLote.pas',
  untConDet in '..\..\..\..\fontes\cadastros\untConDet.pas',
  Estoque.Lote.TSQLSaldoLote in '..\..\..\..\fontes\Estoque\Estoque.Lote.TSQLSaldoLote.pas',
  untHistoricoBalanco in '..\..\..\..\fontes\util\operacoesrefitens\untHistoricoBalanco.pas',
  untZClient in '..\..\..\..\fontes\genericos\untZClient.pas',
  untIZClient in '..\..\..\..\fontes\genericos\untIZClient.pas',
  untHelperCitel in '..\..\..\..\fontes\genericos\untHelperCitel.pas',
  untBalancoEstoqueAjuste in '..\..\..\..\fontes\util\operacoesrefitens\untBalancoEstoqueAjuste.pas',
  untControleContagemBalancoEstoque in '..\..\..\..\fontes\Util_DLL\OpeRefProd\untControleContagemBalancoEstoque.pas',
  untControlaNotSaldoMin in '..\..\..\..\fontes\genericos\untControlaNotSaldoMin.pas',
  untMsgInterna in '..\..\..\..\fontes\cadastros\untMsgInterna.pas',
  untTEstruturaPersonalizada in '..\..\..\..\fontes\faturamento\untTEstruturaPersonalizada.pas',
  untTipoFreteAtc in '..\..\..\..\fontes\genericos\untTipoFreteAtc.pas',
  untInterfaces in '..\..\..\..\fontes\libNfe\untInterfaces.pas',
  Promocao.Regra.Preco.Sugestao in '..\..\..\..\fontes\faturamento\Promocao\Promocao.Regra.Preco.Sugestao.pas',
  untFatCalcularImpostosService in '..\..\..\..\fontes\faturamento\untFatCalcularImpostosService.pas',
  Faturamento.Impostos.Calculos.TesteUnitarioLog in '..\..\..\..\fontes\faturamento\Faturamento.Impostos.Calculos.TesteUnitarioLog.pas',
  Controller.Faturamento.Interfaces.Margem.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\Interfaces\Controller.Faturamento.Interfaces.Margem.Generic.pas',
  Controller.Faturamento.Impostos.FcpDifal in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\FcpDifal\Controller.Faturamento.Impostos.FcpDifal.pas',
  Controller.Faturamento.Impostos.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Generic\Controller.Faturamento.Impostos.Generic.pas',
  Controller.Faturamento.Impostos.IcmsEfetivo in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\IcmsEfetivo\Controller.Faturamento.Impostos.IcmsEfetivo.pas',
  Controller.Faturamento.Impostos.IcmsSt in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\IcmsSt\Controller.Faturamento.Impostos.IcmsSt.pas',
  Controller.Faturamento.Impostos.Ipi in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Ipi\Controller.Faturamento.Impostos.Ipi.pas',
  Controller.Faturamento.Interfaces.Impostos.FcpDifal in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.FcpDifal.pas',
  Controller.Faturamento.Interfaces.Impostos.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Generic\Controller.Faturamento.Interfaces.Impostos.Generic.pas',
  Controller.Faturamento.Interfaces.Impostos.IcmsEfetivo in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.IcmsEfetivo.pas',
  Controller.Faturamento.Interfaces.Impostos.IcmsSt in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.IcmsSt.pas',
  Controller.Faturamento.Interfaces.Impostos.Ipi in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.Ipi.pas',
  Controller.Faturamento.Interfaces.Margem.MargemBruta in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\Interfaces\Controller.Faturamento.Interfaces.Margem.MargemBruta.pas',
  Controller.Faturamento.Interfaces.Margem.MargemVenda in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\Interfaces\Controller.Faturamento.Interfaces.Margem.MargemVenda.pas',
  Controller.Faturamento.Interfaces.Precos.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Precos\Interfaces\Controller.Faturamento.Interfaces.Precos.Generic.pas',
  Controller.Faturamento.Margem.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\Generic\Controller.Faturamento.Margem.Generic.pas',
  Controller.Faturamento.Margem.MargemBruta in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\MargemBruta\Controller.Faturamento.Margem.MargemBruta.pas',
  Controller.Faturamento.Margem.MargemVenda in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\MargemVenda\Controller.Faturamento.Margem.MargemVenda.pas',
  Controller.Faturamento.Precos.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Precos\Generic\Controller.Faturamento.Precos.Generic.pas',
  Controller.Faturamento.Tipos.Impostos.IcmsEfetivo in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Tipos\Controller.Faturamento.Tipos.Impostos.IcmsEfetivo.pas',
  Controller.Faturamento.Tipos.Impostos.IcmsSt in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Tipos\Controller.Faturamento.Tipos.Impostos.IcmsSt.pas',
  Controller.Faturamento.Tipos.Impostos.Ipi in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Tipos\Controller.Faturamento.Tipos.Impostos.Ipi.pas',
  Controller.Faturamento.Tipos.Impostos.Parametros.Comum in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Tipos\Controller.Faturamento.Tipos.Impostos.Parametros.Comum.pas',
  untFatCalcularMargemService in '..\..\..\..\fontes\faturamento\untFatCalcularMargemService.pas',
  untDicionarioResultadoQuerySimples in '..\..\..\..\fontes\genericos\untDicionarioResultadoQuerySimples.pas',
  untFuncoesGenerica in '..\..\..\..\fontes\genericos\untFuncoesGenerica.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untTEnviaRegistrosFusion in '..\..\..\..\fontes\faturamento\untTEnviaRegistrosFusion.pas',
  untFusionCarga in '..\..\..\..\fontes\faturamento\untFusionCarga.pas',
  untFusionCliente in '..\..\..\..\fontes\faturamento\untFusionCliente.pas',
  untFusionEntregaServico in '..\..\..\..\fontes\faturamento\untFusionEntregaServico.pas',
  untFusionEntregaServicoItens in '..\..\..\..\fontes\faturamento\untFusionEntregaServicoItens.pas',
  untFusionEnvio in '..\..\..\..\fontes\faturamento\untFusionEnvio.pas',
  untFusionIntegWS in '..\..\..\..\fontes\faturamento\untFusionIntegWS.pas',
  untFusionMotoristaAjudante in '..\..\..\..\fontes\faturamento\untFusionMotoristaAjudante.pas',
  untFusionRomaneio in '..\..\..\..\fontes\faturamento\untFusionRomaneio.pas',
  untFusionVeiculo in '..\..\..\..\fontes\faturamento\untFusionVeiculo.pas',
  untFusionWS in '..\..\..\..\fontes\faturamento\untFusionWS.pas',
  untTEnviaRegistrosFaturadosFusion in '..\..\..\..\fontes\faturamento\untTEnviaRegistrosFaturadosFusion.pas',
  untFusionAtualizaCarga in '..\..\..\..\fontes\faturamento\untFusionAtualizaCarga.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');

{$IFDEF DEBUG}
  pDefinirUsuarioConexao('root', 'citel13347');
{$ELSE}
  pDefinirUsuarioConexao('rb_fusionenvreg', 'serv!ce@citel#robo');
{$ENDIF DEBUG}

  While True do
  Begin
    try
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Iniciando Fusion - Envia Registros service ...');

      If Not EnviarRegistros Then
        Sleep(60000);

      Writeln(DateTimeToStr(fNow) + ' - ' + 'Finalizando Fusion - Envia Registros service ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
