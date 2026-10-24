program AutcomTestesIpiRegrasClientes;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  TestFrameWork,
  DUnitTestRunner,
  XMLTestRunner,
  untTestFloatUtils in '..\TestesUnitarios\padra_atualizado\fontes\genericos\untTestFloatUtils.pas',
  untFuncoes in '..\TestesUnitarios\padra_atualizado\fontes\untFuncoes.pas',
  untTestConfiguracoes in '..\TestesUnitarios\padra_atualizado\fontes\genericos\untTestConfiguracoes.pas',
  untTestConstantesUtils in '..\TestesUnitarios\padra_atualizado\fontes\genericos\untTestConstantesUtils.pas',
  Faturamento.Impostos.Calculos.Ipi in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.Ipi.pas',
  Contabilidade.SQL in '..\..\Contabilidade\Outros\Contabilidade.SQL.pas',
  Faturamento.Impostos.Calculos.FCP in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.FCP.pas',
  Faturamento.Impostos.Calculos.Difal in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.Difal.pas',
  Faturamento.Impostos.IcmsEfetivo.SQL in '..\fontes\faturamento\Impostos\Faturamento.Impostos.IcmsEfetivo.SQL.pas',
  Faturamento.Impostos.Calculos.IcmsEfetivo in '..\Packages\Faturamento\Impostos\calculos\source\Faturamento.Impostos.Calculos.IcmsEfetivo.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.AkzoNobel in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.AkzoNobel.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.AbstractClassificacaoItem in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.AbstractClassificacaoItem.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.AtivoImobilizado in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.AtivoImobilizado.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.BaixaEntregaFutura in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.BaixaEntregaFutura.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.Brinde in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.Brinde.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.ClienteFilial in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.ClienteFilial.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.ClienteZonaFrancaOuReducaoBaseIcmsST in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.ClienteZonaFrancaOuReducaoBaseIcmsST.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.ConfirmacaoDeCupom in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.ConfirmacaoDeCupom.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.ConsumidorForaDoEstadoOuAtendeDifal in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.ConsumidorForaDoEstadoOuAtendeDifal.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.DevolucaoDemonstracao in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.DevolucaoDemonstracao.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.DevolOuOutrasEntradas in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.DevolOuOutrasEntradas.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.RegrasDeTributacaoEstado in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.RegrasDeTributacaoEstado.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.ClienteExterior in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.ClienteExterior.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.Consignacao in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.Consignacao.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.EnvioGarantiaFornecedor in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.EnvioGarantiaFornecedor.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.UsoEConsumo in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.UsoEConsumo.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.SimplesRemessaDeConcreto in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.SimplesRemessaDeConcreto.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.TipoOperacaoPedidoVenda in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.TipoOperacaoPedidoVenda.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.RetornoConsignacao in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.RetornoConsignacao.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.RemessaPorContaEOrdem in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.RemessaPorContaEOrdem.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.RemessaDeMercadoriaFaltante in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.RemessaDeMercadoriaFaltante.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.PedidoDeRemessaParaGarantia in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.PedidoDeRemessaParaGarantia.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.OrdemDeProducaoAvulsaTintometrico in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.OrdemDeProducaoAvulsaTintometrico.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.ExcecoesServico in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.ExcecoesServico.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.EntregaFutura in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.EntregaFutura.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.Emprestimo in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.Emprestimo.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.NotaImportacao in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.NotaImportacao.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.OutrasEntradasOuEntregaFutura in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.OutrasEntradasOuEntregaFutura.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.OutrasSaidas in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.OutrasSaidas.pas',
  untConstantes in '..\fontes\genericos\untConstantes.pas',
  untConstantesNFe in '..\fontes\libNfe\untConstantesNFe.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.ConfirmacaoAjustes in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.ConfirmacaoAjustes.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.FaturamentoConsignacao in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.FaturamentoConsignacao.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.NotaFiscalTintometricoEspiritoSanto in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.NotaFiscalTintometricoEspiritoSanto.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.EnvioRemessa in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.EnvioRemessa.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.FaturamentoRemessa in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.FaturamentoRemessa.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.RetornoRemessa in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.RetornoRemessa.pas',
  Faturamento.Impostos.Interfaces.Ipi in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.Ipi.pas',
  Faturamento.Impostos.Tipos.Ipi in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.Ipi.pas',
  Shared.Functions.FloatUtils in '..\Packages\Shared\Functions\source\Shared.Functions.FloatUtils.pas',
  Shared.Functions.Configuracoes in '..\Packages\Shared\Functions\source\Shared.Functions.Configuracoes.pas',
  Faturamento.Impostos.Tipos.FCP in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.FCP.pas',
  Faturamento.Impostos.Interfaces.FCP in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.FCP.pas',
  Faturamento.Impostos.Tipos.Difal in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.Difal.pas',
  Faturamento.Impostos.Interfaces.Difal in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.Difal.pas',
  Faturamento.Impostos.Tipos.IcmsEfetivo in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.IcmsEfetivo.pas',
  Faturamento.Impostos.Interfaces.IcmsEfetivo in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.IcmsEfetivo.pas',
  Faturamento.Impostos.Tipos.Model in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.Model.pas',
  Faturamento.Impostos.Interfaces.Model in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.Model.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.pas',
  Shared.Functions.Types in '..\Packages\Shared\Functions\source\Shared.Functions.Types.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.BaixaEntregaFutura in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.BaixaEntregaFutura.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.BaixaEntregaFutura in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.BaixaEntregaFutura.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.ClienteFilial in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.ClienteFilial.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.ClienteFilial in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.ClienteFilial.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.ClienteZonaFrancaOuReducaoBaseIcmsST in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.ClienteZonaFrancaOuReducaoBaseIcmsST.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.ClienteZonaFrancaOuReducaoBaseIcmsST in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.ClienteZonaFrancaOuReducaoBaseIcmsST.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.ConsumidorForaDoEstadoOuAtendeDifal in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.ConsumidorForaDoEstadoOuAtendeDifal.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.ConsumidorForaDoEstadoOuAtendeDifal in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.ConsumidorForaDoEstadoOuAtendeDifal.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.DevolOuOutrasEntradas in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.DevolOuOutrasEntradas.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.DevolOuOutrasEntradas in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.DevolOuOutrasEntradas.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.RegrasDeTributacaoEstado in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.RegrasDeTributacaoEstado.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.RegrasDeTributacaoEstado in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.RegrasDeTributacaoEstado.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.ClienteExterior in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.ClienteExterior.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.ClienteExterior in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.ClienteExterior.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.EnvioGarantiaFornecedor in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.EnvioGarantiaFornecedor.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.EnvioGarantiaFornecedor in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.EnvioGarantiaFornecedor.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.TipoOperacaoPedidoVenda in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.TipoOperacaoPedidoVenda.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.TipoOperacaoPedidoVenda in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.TipoOperacaoPedidoVenda.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.NotaImportacao in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.NotaImportacao.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.OutrasEntradasOuEntregaFutura in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.OutrasEntradasOuEntregaFutura.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.OutrasEntradasOuEntregaFutura in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.OutrasEntradasOuEntregaFutura.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.OutrasSaidas in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.OutrasSaidas.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.OutrasSaidas in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.OutrasSaidas.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.TransferenciaEstoqueEmpresa in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.TransferenciaEstoqueEmpresa.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.TransferenciaEstoqueEmpresa in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.TransferenciaEstoqueEmpresa.pas',
  Shared.Functions.Constantes in '..\Packages\Shared\Functions\source\Shared.Functions.Constantes.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.ConfirmacaoAjustes in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.ConfirmacaoAjustes.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.ConfirmacaoAjustes in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.ConfirmacaoAjustes.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.NotaFiscalTintometricoEspiritoSanto in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.NotaFiscalTintometricoEspiritoSanto.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.NotaImportacao in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.NotaImportacao.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.NotaFiscalTintometricoEspiritoSanto in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.NotaFiscalTintometricoEspiritoSanto.pas',
  Shared.Functions.Faturamento.Impostos.Regras in '..\Packages\Shared\Functions\source\Shared.Functions.Faturamento.Impostos.Regras.pas',
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos in '..\Packages\Shared\Functions\source\Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos.pas',
  Faturamento.Impostos.Interfaces.ZerarImpostos.Types in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ZerarImpostos.Types.pas',
  Shared.Functions.Funcoes.Faturamento in '..\Packages\Shared\Functions\source\Shared.Functions.Funcoes.Faturamento.pas',
  Faturamento.Impostos.Regras.ClassificacoesTransferencias in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacoesTransferencias.pas',
  Faturamento.Impostos.Interfaces.ClassificacoesTransferencias in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacoesTransferencias.pas',
  Faturamento.Impostos.Tipos.ClassificacoesTransferencias in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacoesTransferencias.pas',
  untTestTransferenciaEstoqueEmpresaDadosDB in '..\TestesUnitarios\Faturamento\Impostos\untTestTransferenciaEstoqueEmpresaDadosDB.pas',
  Faturamento.Impostos.Tipos.NFComplementoFornecedorValor in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.NFComplementoFornecedorValor.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.NFComplementoFornecedorValor in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.NFComplementoFornecedorValor.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.NFComplementoFornecedorValor in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.NFComplementoFornecedorValor.pas',
  Shared.Functions.DataSet in '..\Packages\Shared\Functions\source\Shared.Functions.DataSet.pas',
  Core.Funcoes in '..\fontes\Core\Core.Funcoes.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.NFAmostraGratis in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.NFAmostraGratis.pas',
  Faturamento.Impostos.Tipos.NFAmostraGratis in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.NFAmostraGratis.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.NFAmostraGratis in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.NFAmostraGratis.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.ReposicaoClienteGarantia in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.ReposicaoClienteGarantia.pas' {/  TestFaturamento.Impostos.Calculos.Fcp.RezendeLoja12 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.Fcp.RezendeLoja12.pas',},
  Shared.Functions.Interfaces in '..\Packages\Shared\Functions\source\Shared.Functions.Interfaces.pas',
  Shared.Functions.Tipos in '..\Packages\Shared\Functions\source\Shared.Functions.Tipos.pas',
  TestFaturamento.Impostos.Calculos.IPI.REFRIGAS__SAO_20191017 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IPI.REFRIGAS__SAO_20191017.pas',
  TestFaturamento.Impostos.Calculos.IPI.TECHGEL_COMERCI_20191024 in 'padra_atualizado\packages\faturamento\impostos\calculos\source\TestFaturamento.Impostos.Calculos.IPI.TECHGEL_COMERCI_20191024.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.ExcecoesServico in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.ExcecoesServico.pas',
  Faturamento.Impostos.Interfaces.ClassificacaoItem.EntregaFutura in '..\Packages\Faturamento\Impostos\interfaces\source\Faturamento.Impostos.Interfaces.ClassificacaoItem.EntregaFutura.pas',
  Faturamento.Model.Cliente in '..\Packages\Faturamento\Model\source\Faturamento.Model.Cliente.pas',
  Shared.Functions.Core in '..\Packages\Shared\Functions\source\Shared.Functions.Core.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.EntregaFutura in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.EntregaFutura.pas',
  Faturamento.Impostos.Tipos.ClassificacaoItem.ExcecoesServico in '..\Packages\Faturamento\Impostos\tipos\source\Faturamento.Impostos.Tipos.ClassificacaoItem.ExcecoesServico.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.RemessaEstoqueExterno in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.RemessaEstoqueExterno.pas',
  Faturamento.Impostos.Regras.ClassificacaoItem.BaixaRefugo in '..\Packages\Faturamento\Impostos\regras\source\Faturamento.Impostos.Regras.ClassificacaoItem.BaixaRefugo.pas';

{$R *.RES}

var
  Resultado: TTestResult;

begin
  if ParamStr(1) = 'jenkins' then
  begin
    Resultado := Nil;

    try
      Resultado := XMLTestRunner.RunRegisteredTests;
      ExitCode := (Resultado.FailureCount + Resultado.ErrorCount);
      exit;
    finally
      Resultado.Free;
    end;
  end;

  DUnitTestRunner.RunRegisteredTests;
end.

