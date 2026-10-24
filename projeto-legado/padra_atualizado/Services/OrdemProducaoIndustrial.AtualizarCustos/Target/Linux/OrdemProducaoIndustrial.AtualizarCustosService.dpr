program OrdemProducaoIndustrial.AtualizarCustosService;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$region '  Services.Core,'}
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
  System.SysUtils,
  Controller.Faturamento.Interfaces.Cache in '..\..\..\..\fontes\Faturamento\Controller.Faturamento.Interfaces.Cache.pas',
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
  Core.Funcoes in '..\..\..\..\fontes\Core\Core.Funcoes.pas',
  Faturamento.Connections.Functions in '..\..\..\..\fontes\Core\Faturamento.Connections.Functions.pas',
  Faturamento.Interfaces.Conexao in '..\..\..\..\fontes\Core\Conexao\Faturamento.Interfaces.Conexao.pas',
  OrdemProducaoIndustrial.Dados.TCarregaEmbalagem in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.Dados.TCarregaEmbalagem.pas',
  OrdemProducaoIndustrial.Dados.TCarregaMateriaPrima in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.Dados.TCarregaMateriaPrima.pas',
  OrdemProducaoIndustrial.Dados.TCarregaProdutoAcabado in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.Dados.TCarregaProdutoAcabado.pas',
  OrdemProducaoIndustrial.Funcoes in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.Funcoes.pas',
  OrdemProducaoIndustrial.TAtualizacaoCustosProdutosAcabadosGeral in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TAtualizacaoCustosProdutosAcabadosGeral.pas',
  OrdemProducaoIndustrial.TComposicao in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TComposicao.pas',
  OrdemProducaoIndustrial.TCor in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TCor.pas',
  OrdemProducaoIndustrial.TCorrecao in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TCorrecao.pas',
  OrdemProducaoIndustrial.TEmbalagem in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TEmbalagem.pas',
  OrdemProducaoIndustrial.TFiltroProduto in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TFiltroProduto.pas',
  OrdemProducaoIndustrial.TFormula in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TFormula.pas',
  OrdemProducaoIndustrial.TMateriaPrima in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TMateriaPrima.pas',
  OrdemProducaoIndustrial.TOrdemProducao in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TOrdemProducao.pas',
  OrdemProducaoIndustrial.TProdutoAcabado in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TProdutoAcabado.pas',
  OrdemProducaoIndustrial.TProdutoGranel in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.TProdutoGranel.pas',
  OrdemProducaoIndustrial.Tipos in '..\..\..\..\fontes\movimentacaoitens\OrdemProducaoIndustrial\OrdemProducaoIndustrial.Tipos.pas',
  Services.OrdemProducaoIndustrial.AtualizacaoCustosProdutosAcabados in '..\..\Source\Services.OrdemProducaoIndustrial.AtualizacaoCustosProdutosAcabados.pas',
  Shared.Core in '..\..\..\..\fontes\Core\Shared.Core.pas',
  Shared.Functions.Conexao.UniDac in '..\..\..\..\fontes\genericos\Shared.Functions.Conexao.UniDac.pas',
  untCalculoPrecoVenda in '..\..\..\..\fontes\genericos\untCalculoPrecoVenda.pas',
  untConfiguracoes in '..\..\..\..\fontes\genericos\untConfiguracoes.pas',
  untConstantes in '..\..\..\..\fontes\genericos\untConstantes.pas',
  untConstantesNFe in '..\..\..\..\fontes\libNfe\untConstantesNFe.pas',
  untConstantesUtils in '..\..\..\..\fontes\genericos\untConstantesUtils.pas',
  untDicionarioResultadoQuerySimples in '..\..\..\..\fontes\genericos\untDicionarioResultadoQuerySimples.pas',
  untFatCalcularMargemService in '..\..\..\..\fontes\faturamento\untFatCalcularMargemService.pas',
  untFatCalcularPrecosService in '..\..\..\..\fontes\faturamento\untFatCalcularPrecosService.pas',
  untFatCalcularServicePath in '..\..\..\..\fontes\faturamento\untFatCalcularServicePath.pas',
  untFuncoesDicionarios in '..\..\..\..\fontes\genericos\untFuncoesDicionarios.pas',
  untFuncoesGenCompartilhada in '..\..\..\..\fontes\genericos\untFuncoesGenCompartilhada.pas',
  untHelperCitel in '..\..\..\..\fontes\genericos\untHelperCitel.pas',
  untIConfiguracao in '..\..\..\..\fontes\configuracoes\untIConfiguracao.pas',
  untIZClient in '..\..\..\..\fontes\genericos\untIZClient.pas',
  untImpostosFatConexao in '..\..\..\..\fontes\genericos\untImpostosFatConexao.pas',
  untParCalculaPrecoCusto in '..\..\..\..\fontes\genericos\untParCalculaPrecoCusto.pas',
  untPreAlt in '..\..\..\..\fontes\util\operacoesrefitens\untPreAlt.pas',
  untPreAlt_Trigger in '..\..\..\..\fontes\cadastros\untPreAlt_Trigger.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untTConfiguracao in '..\..\..\..\fontes\configuracoes\untTConfiguracao.pas',
  untTMemoriaCalculoPrecoVendaMargem in '..\..\..\..\fontes\genericos\untTMemoriaCalculoPrecoVendaMargem.pas',
  untZClient in '..\..\..\..\fontes\genericos\untZClient.pas';

begin
  FormatSettings := TFormatSettings.Create('pt-BR');

  {$IFDEF DEBUG}
  pDefinirUsuarioConexao('autcom_citel', 'belamupe_citel');
  {$ELSE}
  pDefinirUsuarioConexao('rb_prodindust', 'ord_prod!@citel#');
  {$ENDIF}

  While True do
  Begin
    try
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Iniciando OrdemProducaoIndustrial AtualizacaoCustosProdutosAcabados Service ...');

      If Not AtualizacaoCustosProdutosAcabados Then
        Sleep(60000);

      Writeln(DateTimeToStr(fNow) + ' - ' + 'Finalizando OrdemProducaoIndustrial AtualizacaoCustosProdutosAcabados Service ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
