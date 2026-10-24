program FaturamentoServicesAPI;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.StrUtils,
  System.IOUtils,
  MVCFramework.Logger,
  MVCFramework.Commons,
  MVCFramework.REPLCommandsHandlerU,
  Web.ReqMulti,
  Web.WebReq,
  Web.WebBroker,
  IdContext,
  IdHTTPWebBrokerBridge,
  api.core.connection in '..\..\Source\api\core\api.core.connection.pas',
  api.controller.redirect in '..\..\Source\api\controller\api.controller.redirect.pas',
  api.core.authentication in '..\..\Source\api\core\api.core.authentication.pas',
  api.core.common in '..\..\Source\api\core\api.core.common.pas',
  api.core.documentation in '..\..\Source\api\core\api.core.documentation.pas',
  api.core.utils in '..\..\Source\api\core\api.core.utils.pas',
  api.core.webmodule in '..\..\Source\api\core\api.core.webmodule.pas' {ApiWebModule: TWebModule},
  api.controller.pedidos in '..\..\Source\api\controller\api.controller.pedidos.pas',
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
  Services.Core.Converter.Attribute in '..\..\..\Core\Services.Core.Converter.Attribute.pas',
  Services.Core.JsonCitel.Helpers in '..\..\..\Core\Services.Core.JsonCitel.Helpers.pas',
  Services.Core.JsonCitel.Serializer in '..\..\..\Core\Services.Core.JsonCitel.Serializer.pas',
  Services.ConsultarPreco.Tinta in '..\..\..\Consulta.Preco.Tinta\Source\Services.ConsultarPreco.Tinta.pas',
  Controller.Faturamento.Impostos.FcpDifal in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\FcpDifal\Controller.Faturamento.Impostos.FcpDifal.pas',
  Controller.Faturamento.Impostos.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Generic\Controller.Faturamento.Impostos.Generic.pas',
  Controller.Faturamento.Impostos.IcmsEfetivo in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\IcmsEfetivo\Controller.Faturamento.Impostos.IcmsEfetivo.pas',
  Controller.Faturamento.Impostos.IcmsSt in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\IcmsSt\Controller.Faturamento.Impostos.IcmsSt.pas',
  Controller.Faturamento.Impostos.Ipi in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Ipi\Controller.Faturamento.Impostos.Ipi.pas',
  Controller.Faturamento.Interfaces.Cache in '..\..\..\..\fontes\Faturamento\Controller.Faturamento.Interfaces.Cache.pas',
  Controller.Faturamento.Interfaces.Impostos.FcpDifal in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.FcpDifal.pas',
  Controller.Faturamento.Interfaces.Impostos.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Generic\Controller.Faturamento.Interfaces.Impostos.Generic.pas',
  Controller.Faturamento.Interfaces.Impostos.IcmsEfetivo in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.IcmsEfetivo.pas',
  Controller.Faturamento.Interfaces.Impostos.IcmsSt in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.IcmsSt.pas',
  Controller.Faturamento.Interfaces.Impostos.Ipi in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.Ipi.pas',
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Interfaces\Controller.Faturamento.Interfaces.Impostos.Parametros.Comum.pas',
  Controller.Faturamento.Interfaces.Margem.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\Interfaces\Controller.Faturamento.Interfaces.Margem.Generic.pas',
  Controller.Faturamento.Interfaces.Margem.MargemBruta in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\Interfaces\Controller.Faturamento.Interfaces.Margem.MargemBruta.pas',
  Controller.Faturamento.Interfaces.Margem.MargemVenda in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\Interfaces\Controller.Faturamento.Interfaces.Margem.MargemVenda.pas',
  Controller.Faturamento.Interfaces.Precos.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Precos\Interfaces\Controller.Faturamento.Interfaces.Precos.Generic.pas',
  Controller.Faturamento.Interfaces.Precos.PrecoCusto in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Precos\Interfaces\Controller.Faturamento.Interfaces.Precos.PrecoCusto.pas',
  Controller.Faturamento.Margem.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\Generic\Controller.Faturamento.Margem.Generic.pas',
  Controller.Faturamento.Margem.MargemBruta in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\MargemBruta\Controller.Faturamento.Margem.MargemBruta.pas',
  Controller.Faturamento.Margem.MargemVenda in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Margem\MargemVenda\Controller.Faturamento.Margem.MargemVenda.pas',
  Controller.Faturamento.Precos.Generic in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Precos\Generic\Controller.Faturamento.Precos.Generic.pas',
  Controller.Faturamento.Precos.PrecoCusto in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Precos\PrecoCusto\Controller.Faturamento.Precos.PrecoCusto.pas',
  Controller.Faturamento.Tipos.Impostos.IcmsEfetivo in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Tipos\Controller.Faturamento.Tipos.Impostos.IcmsEfetivo.pas',
  Controller.Faturamento.Tipos.Impostos.IcmsSt in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Tipos\Controller.Faturamento.Tipos.Impostos.IcmsSt.pas',
  Controller.Faturamento.Tipos.Impostos.Ipi in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Tipos\Controller.Faturamento.Tipos.Impostos.Ipi.pas',
  Controller.Faturamento.Tipos.Impostos.Parametros.Comum in '..\..\..\..\fontes\Controller\Bpl\Faturamento\Impostos\Tipos\Controller.Faturamento.Tipos.Impostos.Parametros.Comum.pas',
  Core.Funcoes in '..\..\..\..\fontes\Core\Core.Funcoes.pas',
  Estoque.Lote.TSQLSaldoLote in '..\..\..\..\fontes\Estoque\Estoque.Lote.TSQLSaldoLote.pas',
  Faturamento.Auditoria.Cat17 in '..\..\..\..\fontes\faturamento\Auditoria\Faturamento.Auditoria.Cat17.pas',
  Faturamento.Auditoria.EmbalagemFechada in '..\..\..\..\fontes\faturamento\Auditoria\Faturamento.Auditoria.EmbalagemFechada.pas',
  Faturamento.Auditoria.Interfaces.Cat17 in '..\..\..\..\fontes\faturamento\Auditoria\Faturamento.Auditoria.Interfaces.Cat17.pas',
  Faturamento.Auditoria.Interfaces.EmbalagemFechada in '..\..\..\..\fontes\faturamento\Auditoria\Faturamento.Auditoria.Interfaces.EmbalagemFechada.pas',
  Faturamento.Classes.TDadosCTe in '..\..\..\..\fontes\faturamento\Faturamento.Classes.TDadosCTe.pas',
  Faturamento.Services.Pedido in '..\..\Source\api\services\Faturamento.Services.Pedido.pas',
  Faturamento.Services.Pedido.Types in '..\..\Source\api\services\types\Faturamento.Services.Pedido.Types.pas',
  Faturamento.Classes.TFatVendaBase in '..\..\..\..\fontes\faturamento\Faturamento.Classes.TFatVendaBase.pas',
  Faturamento.Connections.Functions in '..\..\..\..\fontes\Core\Faturamento.Connections.Functions.pas',
  Faturamento.Consignacao.Classes in '..\..\..\..\fontes\faturamento\Faturamento.Consignacao.Classes.pas',
  untReformaTributariaTipos in '..\..\..\..\fontes\fiscal\untReformaTributariaTipos.pas',
  untReformaTributariaCalculo in '..\..\..\..\fontes\fiscal\untReformaTributariaCalculo.pas',
  Faturamento.Impostos.Calculos.TesteUnitarioLog in '..\..\..\..\fontes\faturamento\Faturamento.Impostos.Calculos.TesteUnitarioLog.pas',
  Faturamento.Impostos.IcmsEfetivo.SQL in '..\..\..\..\fontes\faturamento\Impostos\Faturamento.Impostos.IcmsEfetivo.SQL.pas',
  Faturamento.Interfaces.Conexao in '..\..\..\..\fontes\Core\Conexao\Faturamento.Interfaces.Conexao.pas',
  Faturamento.Origem.TOrigemFaturamento in '..\..\..\..\fontes\faturamento\Origem\Faturamento.Origem.TOrigemFaturamento.pas',
  OrdemProducaoIndustrial.Funcoes in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.Funcoes.pas',
  Promocao.Regra.Preco.Sugestao in '..\..\..\..\fontes\faturamento\Promocao\Promocao.Regra.Preco.Sugestao.pas',
  Shared.Core in '..\..\..\..\fontes\Core\Shared.Core.pas',
  Shared.Functions.Conexao.UniDac in '..\..\..\..\fontes\genericos\Shared.Functions.Conexao.UniDac.pas',
  untAuditoriaGravacaoFaturamento in '..\..\..\..\fontes\faturamento\untAuditoriaGravacaoFaturamento.pas',
  untAutcomDllTinta in '..\..\..\..\fontes\genericos\untAutcomDllTinta.pas',
  untAtualizaOcorrenciasCRM in '..\..\..\..\fontes\crm\untAtualizaOcorrenciasCRM.pas',
  untBalancoEstoqueAjuste in '..\..\..\..\fontes\util\operacoesrefitens\untBalancoEstoqueAjuste.pas',
  untBonGer in '..\..\..\..\fontes\cadastros\untBonGer.pas',
  untCadIBPT in '..\..\..\..\fontes\cadastros\untCadIBPT.pas',
  untCadIte in '..\..\..\..\fontes\cadastros\untCadIte.pas',
  untCadLote in '..\..\..\..\fontes\cadastros\untCadLote.pas',
  untCadNegBussiness in '..\..\..\..\fontes\faturamento\untCadNegBussiness.pas',
  untCadPro in '..\..\..\..\fontes\cadastros\untCadPro.pas',
  untCadRec in '..\..\..\..\fontes\financeiro\contasareceber\untCadRec.pas',
  untCalcularMargemLucro in '..\..\..\..\fontes\faturamento\untCalcularMargemLucro.pas',
  untCalculoIpi in '..\..\..\..\fontes\fiscal\untCalculoIpi.pas',
  untCalculoPisCofins in '..\..\..\..\fontes\genericos\untCalculoPisCofins.pas',
  untCalculoPrecoVenda in '..\..\..\..\fontes\genericos\untCalculoPrecoVenda.pas',
  untCamGer in '..\..\..\..\fontes\Cadastros\untCamGer.pas',
  untConDet in '..\..\..\..\fontes\cadastros\untConDet.pas',
  untCfgRepositorio in '..\..\..\..\fontes\configuracoes\untCfgRepositorio.pas',
  untConfiguracoes in '..\..\..\..\fontes\genericos\untConfiguracoes.pas',
  untConstantes in '..\..\..\..\fontes\genericos\untConstantes.pas',
  untConstantesNFe in '..\..\..\..\fontes\libNfe\untConstantesNFe.pas',
  untConstantesUtils in '..\..\..\..\fontes\genericos\untConstantesUtils.pas',
  untControlaNotSaldoMin in '..\..\..\..\fontes\genericos\untControlaNotSaldoMin.pas',
  untControleContagemBalancoEstoque in '..\..\..\..\fontes\Util_DLL\OpeRefProd\untControleContagemBalancoEstoque.pas',
  untCustoItemFaturamento in '..\..\..\..\fontes\faturamento\untCustoItemFaturamento.pas',
  untDespesasFaturamento in '..\..\..\..\fontes\faturamento\untDespesasFaturamento.pas',
  untDicionarioResultadoQuerySimples in '..\..\..\..\fontes\genericos\untDicionarioResultadoQuerySimples.pas',
  untDivergenciasDevAD in '..\..\..\..\fontes\crm\untDivergenciasDevAD.pas',
  untEnderecoEntrega in '..\..\..\..\fontes\cadastros\untEnderecoEntrega.pas',
  untEstruturaMargemLucro in '..\..\..\..\fontes\faturamento\untEstruturaMargemLucro.pas',
  untExecutaSQLReplicacaoTinta in '..\..\..\..\fontes\genericos\untExecutaSQLReplicacaoTinta.pas',
  untFatVendasCalculadorWrapper in '..\..\..\..\fontes\faturamento\untFatVendasCalculadorWrapper.pas',
  untFatVendasCalculadorWrapperTAB in '..\..\..\..\fontes\faturamento\untFatVendasCalculadorWrapperTAB.pas',
  untFatCalcComissaoVendedor in '..\..\..\..\fontes\faturamento\untFatCalcComissaoVendedor.pas',
  untFatCalcularImpostosService in '..\..\..\..\fontes\faturamento\untFatCalcularImpostosService.pas',
  untFatCalcularMargemService in '..\..\..\..\fontes\faturamento\untFatCalcularMargemService.pas',
  untFatCalcularPrecosService in '..\..\..\..\fontes\faturamento\untFatCalcularPrecosService.pas',
  untFatCalcularServicePath in '..\..\..\..\fontes\faturamento\untFatCalcularServicePath.pas',
  untFatComboVenda in '..\..\..\..\fontes\faturamento\untFatComboVenda.pas',
  untFatDefineLotesPedidoWMSWrapper in '..\..\..\..\fontes\faturamento\untFatDefineLotesPedidoWMSWrapper.pas',
  untFatEstruturaVidro in '..\..\..\..\fontes\faturamento\untFatEstruturaVidro.pas',
  untFatMostraTravaMinimaHelper in '..\..\..\..\fontes\faturamento\untFatMostraTravaMinimaHelper.pas',
  untFatOrdSer in '..\..\..\..\fontes\faturamento\untFatOrdSer.pas',
  untFatOrdProTintaMaquina in '..\..\..\..\fontes\faturamento\untFatOrdProTintaMaquina.pas',
  untFatRegrasImpostos in '..\..\..\..\fontes\faturamento\untFatRegrasImpostos.pas',
  untFatSeriesItem in '..\..\..\..\fontes\faturamento\untFatSeriesItem.pas',
  untFinanceira in '..\..\..\..\fontes\faturamento\untFinanceira.pas',
  untFuncFatTypes in '..\..\..\..\fontes\faturamento\untFuncFatTypes.pas',
  untFuncTinta in '..\..\..\..\fontes\Genericos\untFuncTinta.pas',
  untFuncoesAutocenter in '..\..\..\..\fontes\genericos\untFuncoesAutocenter.pas',
  untFuncoesDicionarios in '..\..\..\..\fontes\genericos\untFuncoesDicionarios.pas',
  untFuncoesGenCompartilhada in '..\..\..\..\fontes\genericos\untFuncoesGenCompartilhada.pas',
  untFuncoesGenerica in '..\..\..\..\fontes\genericos\untFuncoesGenerica.pas',
  untFuncoesCRM in '..\..\..\..\fontes\crm\untFuncoesCRM.pas',
  untFuncoesTintaDeMaquinaBpl in '..\..\..\..\fontes\genericos\untFuncoesTintaDeMaquinaBpl.pas',
  untFuncoesSaldos in '..\..\..\..\fontes\faturamento\untFuncoesSaldos.pas',
  untGTinForTipos in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untHelperCitel in '..\..\..\..\fontes\genericos\untHelperCitel.pas',
  untHistoricoBalanco in '..\..\..\..\fontes\util\operacoesrefitens\untHistoricoBalanco.pas',
  untICadLote in '..\..\..\..\fontes\cadastros\untICadLote.pas',
  untICalculadorFatVendas in '..\..\..\..\fontes\Interfaces\untICalculadorFatVendas.pas',
  untICalculadorFatVendasLibTintas in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untICalculadorFatVendasLibTintas.pas',
  untICalculadorFatVendasTAB in '..\..\..\..\fontes\Interfaces\untICalculadorFatVendasTAB.pas',
  untICamGer in '..\..\..\..\fontes\cadastros\untICamGer.pas',
  untIConfTinta in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIConfTinta.pas',
  untIConfiguracao in '..\..\..\..\fontes\configuracoes\untIConfiguracao.pas',
  untIDadosTinta in '..\..\..\..\fontes\iTintas\untIDadosTinta.pas',
  untIDadosTintasComponentes in '..\..\..\..\fontes\iTintas\untIDadosTintasComponentes.pas',
  untIDataSet in '..\..\..\..\fontes\Dataset\untIDataSet.pas',
  untIExecutaSQLReplicacaoTinta in '..\..\..\..\fontes\iTintas\untIExecutaSQLReplicacaoTinta.pas',
  untIFatDefineLotesPedidoWMS in '..\..\..\..\fontes\Interfaces\untIFatDefineLotesPedidoWMS.pas',
  untIFatEntregaFutura in '..\..\..\..\fontes\faturamento\untIFatEntregaFutura.pas',
  untIFatOrdProTintaMaquina in '..\..\..\..\fontes\iTintas\untIFatOrdProTintaMaquina.pas',
  untIFatReservaSaldo in '..\..\..\..\fontes\faturamento\untIFatReservaSaldo.pas',
  untIFinanceira in '..\..\..\..\fontes\faturamento\untIFinanceira.pas',
  untIFuncoesCRM in '..\..\..\..\fontes\crm\untIFuncoesCRM.pas',
  untIFuncoesSaldos in '..\..\..\..\fontes\Interfaces\untIFuncoesSaldos.pas',
  untIIdentificadorTinta in '..\..\..\..\fontes\iTintas\untIIdentificadorTinta.pas',
  untILibTintaDllRelacao in '..\..\..\..\fontes\iTintas\untILibTintaDllRelacao.pas',
  untITintaDeMaquina in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untITintaDeMaquina.pas',
  untITintaDeMaquinaComponente in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untITintaDeMaquinaComponente.pas',
  untITintasDeMaquina in '..\..\..\..\fontes\iTintas\untITintasDeMaquina.pas',
  untITransferencias in '..\..\..\..\fontes\iTintas\untITransferencias.pas',
  untIZClient in '..\..\..\..\fontes\genericos\untIZClient.pas',
  untIcmsSTParteVenda in '..\..\..\..\fontes\faturamento\untIcmsSTParteVenda.pas',
  untIliberacao in '..\..\..\..\fontes\genericos\untIliberacao.pas',
  untImpostosFatConexao in '..\..\..\..\fontes\genericos\untImpostosFatConexao.pas',
  untImportaTintometricosTerceirosTabelas in '..\..\..\..\fontes\genericos\untImportaTintometricosTerceirosTabelas.pas',
  untInterfacedObjectNoCount in '..\..\..\..\fontes\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untInterfaces in '..\..\..\..\fontes\libNfe\untInterfaces.pas',
  untLiberacao in '..\..\..\..\fontes\genericos\untLiberacao.pas',
  untLogCtr in '..\..\..\..\fontes\financeiro\contasareceber\untLogCtr.pas',
  untMadeireira in '..\..\..\..\fontes\faturamento\untMadeireira.pas',
  untMargemLucro in '..\..\..\..\fontes\faturamento\untMargemLucro.pas',
  untMsgInterna in '..\..\..\..\fontes\cadastros\untMsgInterna.pas',
  untMsgLiberacao in '..\..\..\..\fontes\genericos\untMsgLiberacao.pas',
  untMovGer in '..\..\..\..\fontes\faturamento\untMovGer.pas',
  untNotCom in '..\..\..\..\fontes\cadastros\untNotCom.pas',
  untLogAbt in '..\..\..\..\fontes\faturamento\untLogAbt.pas',
  untParCalculaPrecoCusto in '..\..\..\..\fontes\genericos\untParCalculaPrecoCusto.pas',
  untPreAlt in '..\..\..\..\fontes\util\operacoesrefitens\untPreAlt.pas',
  untPreAlt_Trigger in '..\..\..\..\fontes\cadastros\untPreAlt_Trigger.pas',
  untSaldoPedidoCompra in '..\..\..\..\fontes\movimentacaoitens\PedidoDeCompra\untSaldoPedidoCompra.pas',
  untSeqTmp in '..\..\..\..\fontes\genericos\untSeqTmp.pas',
  untSQLFaturamento in '..\..\..\..\fontes\faturamento\untSQLFaturamento.pas',
  untSQLRepositorio in '..\..\..\..\fontes\faturamento\untSQLRepositorio.pas',
  untSQLServicos in '..\..\..\..\fontes\faturamento\untSQLServicos.pas',
  untTConfiguracao in '..\..\..\..\fontes\configuracoes\untTConfiguracao.pas',
  untTEstruturaPersonalizada in '..\..\..\..\fontes\faturamento\untTEstruturaPersonalizada.pas',
  untTFaixaDescTabPrecoLinhaGrupo.Classes in '..\..\..\..\fontes\cadastros\untTFaixaDescTabPrecoLinhaGrupo.Classes.pas',
  untTFatEntregaFutura in '..\..\..\..\fontes\faturamento\untTFatEntregaFutura.pas',
  untTFatReprocessarSaldoItem in '..\..\..\..\fontes\faturamento\untTFatReprocessarSaldoItem.pas',
  untTFatReservaSaldo in '..\..\..\..\fontes\faturamento\untTFatReservaSaldo.pas',
  untTFuncoesAuxiliaresPix in '..\..\..\..\..\libIntegracaoPixCitel\fontes\requisicoes\untTFuncoesAuxiliaresPix.pas',
  untTMatrizSaldosColorantes in '..\..\..\..\fontes\genericos\untTMatrizSaldosColorantes.pas',
  untTMemoriaCalculoPrecoVendaMargem in '..\..\..\..\fontes\genericos\untTMemoriaCalculoPrecoVendaMargem.pas',
  untTintaDeMaquinaComponenteTipo in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untTintaDeMaquinaComponenteTipo.pas',
  untTipoFreteAtc in '..\..\..\..\fontes\genericos\untTipoFreteAtc.pas',
  untTipoTinta in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untTiposPix in '..\..\..\..\..\libIntegracaoPixCitel\fontes\genericos\untTiposPix.pas',
  untTransferencias in '..\..\..\..\fontes\faturamento\untTransferencias.pas',
  untTypesCRM in '..\..\..\..\fontes\crm\untTypesCRM.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untTypesIPI in '..\..\..\..\fontes\faturamento\Impostos\IPI\untTypesIPI.pas',
  untTypesGenericosImpostos in '..\..\..\..\fontes\faturamento\Impostos\untTypesGenericosImpostos.pas',
  untCalculoImpostoIPI in '..\..\..\..\fontes\faturamento\Impostos\IPI\untCalculoImpostoIPI.pas',
  untFaturamentoImpostosFuncoes in '..\..\..\..\fontes\faturamento\Impostos\untFaturamentoImpostosFuncoes.pas',
  untFactoryImpostos in '..\..\..\..\fontes\faturamento\Impostos\untFactoryImpostos.pas',
  untConsultaModelFaturamento in '..\..\..\..\fontes\faturamento\Model\untConsultaModelFaturamento.pas',
  untConsultaModelFaturamentoDatabase in '..\..\..\..\fontes\faturamento\Model\untConsultaModelFaturamentoDatabase.pas',
  untValidacoesSistemaDEPS in '..\..\..\..\fontes\faturamento\untValidacoesSistemaDEPS.pas',
  untValorPorExtenso in '..\..\..\..\fontes\genericos\untValorPorExtenso.pas',
  untZClient in '..\..\..\..\fontes\genericos\untZClient.pas',
  Yapay.Api.Resources in '..\..\..\..\fontes\financeiro\gerais\api.yapay\api\Yapay.Api.Resources.pas',
  untAuditoriaGravacaoResumoCaixa in '..\..\..\..\fontes\resumodecaixa\untAuditoriaGravacaoResumoCaixa.pas';

function GetPort: Integer;
const
  DEFAULT_SERVER_API_PORT = 8080;
var
  strValDef: Integer;
begin
  strValDef := StrToIntDef(fCfgSis('PORFSA'), DEFAULT_SERVER_API_PORT);
  Result := StrToIntDef(ParamStr(2), strValDef);
  fAtuCfgSis('PORFSA', Result.ToString);
end;

procedure RunServer(pPort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
  LCustomHandler: TMVCCustomREPLCommandsHandler;
  LCmd: string;
begin
  Writeln('**********************************************************************************');
  Writeln(' FaturamentoServicesAPI - version 1.0.0 - 64bits');
  Writeln(' ');
  Writeln(' DMVCFramework - version ' + DMVCFRAMEWORK_VERSION);
  Writeln(' ');
  Writeln(' Database settings in the file:');
  Writeln(' ' + ExtractFilePath(ParamStr(0)) + 'opcoes.ini');
  Writeln(' ');
  Writeln(' SwagDoc - version 1.0.0');
  Writeln(' Swagger REST API Documentation - version 2.0');
  Writeln(' Swagger UI deploy folder:');
  Writeln(' ' + ExtractFilePath(ParamStr(0)) + 'www/api/help');
  Writeln(' ');
  Writeln(' Command to starts in other server API port:');
  Writeln(' ' + ExtractFileName(ParamStr(0)) + ' start ' + GetPort.ToString);
  Writeln('**********************************************************************************');

  LCmd := 'start';
  if ParamCount >= 1 then
    LCmd := ParamStr(1);

  LCustomHandler :=
      function(const Value: String; const Server: TIdHTTPWebBrokerBridge;
      out Handled: Boolean): THandleCommandResult
    begin
      Handled := False;
      Result := THandleCommandResult.Unknown;
    end;

  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.DefaultPort := pPort;
    LServer.MaxConnections := 0;
    LServer.ListenQueue := 200;
    { required if you use JWT middleware }
    LServer.OnParseAuthentication :=
      TMVCParseAuthentication.OnParseAuthentication;
    Writeln('Write "quit" or "exit" to shutdown the server');
    repeat
      if LCmd.IsEmpty then
      begin
        if HasParam('--nohup') then
        begin
          Writeln('server is running ...');
          Sleep(60000);
          Continue;
        end;
        Writeln('-> ');
        ReadLn(LCmd);
      end;
      try
        case HandleCommand(LowerCase(LCmd), LServer, LCustomHandler) of
          THandleCommandResult.Continue:
            begin
              Continue;
            end;
          THandleCommandResult.Break:
            begin
              Break;
            end;
          THandleCommandResult.Unknown:
            begin
              REPLEmit('Unknown command: ' + LCmd);
            end;
        end;
      finally
        LCmd := '';
      end;
    until False;

  finally
    LServer.Free;
  end;
end;

procedure pFreeLibTintaMaquina;
begin
  if HandleDllTinta <> 0 then
    FreeLibrary(HandleDllTinta);
end;

procedure pLoadLibTintaMaquina;
begin
  pCarregaFuncoesDll(fGravaMovGer,
                     fGravaMovDet,
                     TTransferencias.Create,
                     TFatOrdProTintaMaquina.Create,
                     TLiberacao.Create,
                     nil,
                     TExecutaSQLReplicacaoTinta.Create,
                     TFatDefineLotesPedidoWMSWrapper.Create,
                     TFuncoesCRM.Create,
                     TFuncoesSaldos.Create,
                     nil);
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  FormatSettings_ptBR;
  pDefinirEmpresa;
  objConnectionsManager := TConnectionsManager.Create;
  objConnectionsManager.BeginConnection;
  try
    pDefinirUsuario;
    pIniciarVariaveis;
    pLoadLibTintaMaquina;
    try
      IsMultiThread := True;
      try
        if WebRequestHandler <> nil then
          WebRequestHandler.WebModuleClass := WebModuleClass;
        WebRequestHandlerProc.MaxConnections := 1024;
        RunServer(GetPort);
      except
        on E: Exception do
          WriteError(E.ClassName + ': ' + E.Message);
      end;
    finally
      pFreeLibTintaMaquina;
    end;
  finally
    objConnectionsManager.EndConnection;
  end;
end.
