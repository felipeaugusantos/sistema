unit Shared.Functions.Faturamento.Impostos.Regras;

interface

uses System.StrUtils, Shared.Functions.Types,
  Shared.Functions.Configuracoes, Shared.Functions.Constantes, System.SysUtils,
  Shared.Functions.Funcoes.Faturamento, Shared.Functions.Core,
  System.TypInfo;

type
  TFunctionsRegrasImpostosFaturamento = class
  private

  public
    //Metodos principais que serão compartilhados para zerar os impostos(icms, ipi e basret) e cst do produto
    class function fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(const AClassificacaoFiscal: String): Boolean;
    class function fEhEntregaFuturaNaoControleDeEntrega(const ABaixaDeEntregaFutura: Boolean; const AEntregaFuturaDoItem: Boolean): Boolean;
    class function fAlterarTributacaoIcmsPara41eZerarValores(const AEstadoDaEmpresa: String;
      const AEmpresaOptanteSimples: Boolean; const AOpcaoDeDocumento: String; const AEspecieDoDocumento: String;
      const ItemTributado: Boolean; const ConfiguradoParaTrocarParaX41: Boolean;
      const ConfiguradoParaTrocarParaX41noParana: Boolean): Boolean;
    class function fValorDoIcmsMenorIgualAZero(const AValor: Double): Boolean;

    class function RetornarTipoOperacaoPedidoVenda(const ATipoOperacao: String): String;

    //Metodos auxiliares
    class function fEhCupomFiscal(const AEspecieDoDocumento: String): Boolean;

    //Metodo Isenta Impostos strEspeciesZerar
    class function IsentaImpostosEspeciesZerarBaixaEntregaFuturaVendaItemConcreto(
      const AEspecieDoDocumento: String; const AEspeciesZerar: String; const AOpcaoDeDocumento: String; const AClienteOrgaoPublico: Boolean; const AClienteZonaFranca: Boolean;
      const ABaixaEntregaFutura: Boolean; const AEntregaFutura: Boolean; const AEhVendaItemConcreto: Boolean; const ADesmembrarNotaProdutosServicos: Boolean): Boolean;

    class function EspeciesZerarPedidoOrcamentoTrocaOrgaoPublicoZonaFranca(
      const AEspecieDoDocumento, AOpcaoDeDocumento, AEspeciesZerar: String; const AClienteOrgaoPublico,
      AClienteZonaFranca: Boolean): Boolean;
    class function RetornarEspecieDocumento(const AEspecieDoDocumento, AOpcaoDeDocumento: String): String;
    class function EspeciesZerarPedidoOrcamentoTroca(const AEspecieDoDocumento, AOpcaoDeDocumento, AEspeciesZerar: String): Boolean;
    class function OrcamentoZonaFrancaOuOrgaoPublico(const AEspecieDoDocumento: String;
      const AClienteOrgaoPublico, AClienteZonaFranca: Boolean): Boolean;
    class function ZonaFrancaOuOrgaoPublico(const AClienteOrgaoPublico, AClienteZonaFranca: Boolean): Boolean;
    class function BaixaEntregaFuturaNaoControleDeEntrega(const ABaixaEntregaFutura, AEntregaFutura: Boolean): Boolean;
    class function VendaItemConcretoDesmembrarNotaProdutosServicos(const AEhVendaItemConcreto, ADesmembrarNotaProdutosServicos: Boolean): Boolean;
    class function EspecieVaziaOpcaoDeDocumentoTroca(const AEspecieDoDocumento, AOpcaoDeDocumento: String): Boolean;

    class function CupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCe(const AEspecieDoDocumento: String; const APercentualDaBaseDeIcms: Double): Boolean;
    class function ClientePossuiReducaoBaseIcmsParaProdutosTributados(const AReducaoBaseIcmsCliente: Double; const ACodigoDaSubstituicaoTributaria: String): Boolean;
    class function EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST(const ADiferimentoST: Boolean; const AIndustrializacao: Boolean): Boolean;
    class function EmissaoDeCupomFiscalSimplesNacionalNaoTributado(const AEspecieDoDocumento: String; const ASimplesNacional: Boolean; const ACodigoDaSubstituicaoTributaria: String): Boolean;
    class function STAtribuidaPorRegimeEspecial(const ASujeitoPassivoSTRegimeEspecial: Boolean; const ACodigoDaSubstituicaoTributaria: String): Boolean;
//    class function TipoOperacaoPedidoVendaAmostra(const ATipoOperacao: String): Boolean;
    class function CupomFiscalPossuiAliquotaEcf(const AEspecieDoDocumento: String; const ATemAliquotaEcf: Boolean): Boolean;
    class function STAtribuidaPorAtoDeclaratorioDF(const ACodigoDaSubstituicaoTributaria, AUfEmitente, AUfDestinatario, ATipoAbreviacaoFiscal: String;
                                                   const AItemRevenda, AAtoDeclaratorioDFcliente, AAtoDeclaratorioDFproduto: Boolean): Boolean;
  end;

implementation

class function TFunctionsRegrasImpostosFaturamento.fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(const AClassificacaoFiscal: String): Boolean;
begin
  Result := (Pos(RightStr(AClassificacaoFiscal, 3), ENVIO_RETORNO_MERCADORIA_CONSERTO_GARANTIA) > 0);
end;

class function TFunctionsRegrasImpostosFaturamento.fEhCupomFiscal(
  const AEspecieDoDocumento: String): Boolean;
begin
  Result := (Pos(AEspecieDoDocumento, CUPOM_FISCAL) > 0);
end;

class function TFunctionsRegrasImpostosFaturamento.fEhEntregaFuturaNaoControleDeEntrega(const ABaixaDeEntregaFutura: Boolean; const AEntregaFuturaDoItem: Boolean): Boolean;
begin
  Result :=
    (
      (Not ABaixaDeEntregaFutura) And
       AEntregaFuturaDoItem And
      (Not objConfiguracoes.fGetValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, varBoolean))
    );
end;

class function TFunctionsRegrasImpostosFaturamento.fValorDoIcmsMenorIgualAZero(
  const AValor: Double): Boolean;
begin
  Result := (AValor <= 0.0);
end;

class function TFunctionsRegrasImpostosFaturamento.IsentaImpostosEspeciesZerarBaixaEntregaFuturaVendaItemConcreto(
  const AEspecieDoDocumento, AEspeciesZerar, AOpcaoDeDocumento: String;
  const AClienteOrgaoPublico, AClienteZonaFranca, ABaixaEntregaFutura,
  AEntregaFutura, AEhVendaItemConcreto,
  ADesmembrarNotaProdutosServicos: Boolean): Boolean;
begin
  Result := True;

  If EspeciesZerarPedidoOrcamentoTrocaOrgaoPublicoZonaFranca(AEspecieDoDocumento,
    AOpcaoDeDocumento, AEspeciesZerar, AClienteOrgaoPublico, AClienteZonaFranca) Then
    Exit;

  If BaixaEntregaFuturaNaoControleDeEntrega(ABaixaEntregaFutura, AEntregaFutura) Then
    Exit;

  If VendaItemConcretoDesmembrarNotaProdutosServicos(AEhVendaItemConcreto, ADesmembrarNotaProdutosServicos) Then
    Exit;

  Result := False;
end;

class function TFunctionsRegrasImpostosFaturamento.OrcamentoZonaFrancaOuOrgaoPublico(
  const AEspecieDoDocumento: String; const AClienteOrgaoPublico,
  AClienteZonaFranca: Boolean): Boolean;
begin
  Result := False;

  If (Not SameText(AEspecieDoDocumento, ORCAMENTO)) then
    Exit;

  If (Not ZonaFrancaOuOrgaoPublico(AClienteOrgaoPublico, AClienteZonaFranca)) then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.BaixaEntregaFuturaNaoControleDeEntrega(
  const ABaixaEntregaFutura, AEntregaFutura: Boolean): Boolean;
begin
  Result := False;

  If Not ABaixaEntregaFutura Then
    Exit;

  If AEntregaFutura Then
    Exit;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, varBoolean)) Then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.ClientePossuiReducaoBaseIcmsParaProdutosTributados(
  const AReducaoBaseIcmsCliente: Double;
  const ACodigoDaSubstituicaoTributaria: String): Boolean;
begin
  Result := False;

  If (Not (AReducaoBaseIcmsCliente > 0)) Then
    Exit;

  If TFunctionFuncoesFaturamento.SubstituicaoTributaria(ACodigoDaSubstituicaoTributaria) Then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.CupomFiscalPercentualDaBaseDeIcmsMaiorQueZeroNaoUtilizaNFCe(
  const AEspecieDoDocumento: String;
  const APercentualDaBaseDeIcms: Double): Boolean;
begin
  Result := False;
//(Pos(strEspDoc, 'IF_IV_D1_') > 0) And (fFormataFloat(arrMatItens[intContador].fltPerBas,2) > 0.00) And (Not fCfgSis('USNFCE', varBoolean))
  If (Not Self.fEhCupomFiscal(AEspecieDoDocumento)) Then
    Exit;

  If (Not (objCore.fFormataFloat(APercentualDaBaseDeIcms, 2) > 0.00)) Then
    Exit;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_NFCE, varBoolean)) then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.CupomFiscalPossuiAliquotaEcf(
  const AEspecieDoDocumento: String; const ATemAliquotaEcf: Boolean): Boolean;
begin
  Result := False;

  If (Not Self.fEhCupomFiscal(AEspecieDoDocumento)) Then
    Exit;

  If Not ATemAliquotaEcf Then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.EmissaoDeCupomFiscalSimplesNacionalNaoTributado(
  const AEspecieDoDocumento: String; const ASimplesNacional: Boolean;
  const ACodigoDaSubstituicaoTributaria: String): Boolean;
begin
  Result := False;

  If (Not Self.fEhCupomFiscal(AEspecieDoDocumento)) Then
    Exit;

  If (Not ASimplesNacional) Then
    Exit;

  If (Not (ACodigoDaSubstituicaoTributaria = CST_NAO_TRIBUTADO)) Then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.EmpresaDistribuidoraVendaIndustrializacaoDiferimentoST(
  const ADiferimentoST, AIndustrializacao: Boolean): Boolean;
begin
  Result := False;

  If (Not objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_DISTRIBUIDORA, varBoolean)) then
    Exit;

  If (Not ADiferimentoST) then
    Exit;

  If (Not AIndustrializacao) then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.EspeciesZerarPedidoOrcamentoTroca(
  const AEspecieDoDocumento, AOpcaoDeDocumento,
  AEspeciesZerar: String): Boolean;
begin
  Result := True;

  If (Pos(AEspecieDoDocumento, AEspeciesZerar) > 0) Then
    Exit;

  If (Pos(RetornarEspecieDocumento(AEspecieDoDocumento, AOpcaoDeDocumento), PEDIDO_ORCAMENTO) > 0) Then
    Exit;

  If EspecieVaziaOpcaoDeDocumentoTroca(AEspecieDoDocumento, AOpcaoDeDocumento) Then
    Exit;

  Result := False;
end;

class function TFunctionsRegrasImpostosFaturamento.EspeciesZerarPedidoOrcamentoTrocaOrgaoPublicoZonaFranca(
  const AEspecieDoDocumento, AOpcaoDeDocumento, AEspeciesZerar: String; const AClienteOrgaoPublico,
  AClienteZonaFranca: Boolean): Boolean;
begin
  Result := False;

  If Not EspeciesZerarPedidoOrcamentoTroca(AEspecieDoDocumento, AOpcaoDeDocumento, AEspeciesZerar) Then
    Exit;

  If OrcamentoZonaFrancaOuOrgaoPublico(AEspecieDoDocumento, AClienteOrgaoPublico, AClienteZonaFranca) Then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.EspecieVaziaOpcaoDeDocumentoTroca(
  const AEspecieDoDocumento, AOpcaoDeDocumento: String): Boolean;
begin
  Result := False;

  If (Not objCore.fEmptyStr(AEspecieDoDocumento)) Then
    Exit;

  If (Not (AOpcaoDeDocumento = TROCA)) Then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.RetornarEspecieDocumento(
  const AEspecieDoDocumento, AOpcaoDeDocumento: String): String;
begin
  Result := AEspecieDoDocumento;

  If objCore.fEmptyStr(AEspecieDoDocumento) Then
    Result := AOpcaoDeDocumento;
end;

class function TFunctionsRegrasImpostosFaturamento.STAtribuidaPorAtoDeclaratorioDF(
  const ACodigoDaSubstituicaoTributaria, AUfEmitente, AUfDestinatario, ATipoAbreviacaoFiscal: String;
  const AItemRevenda, AAtoDeclaratorioDFcliente, AAtoDeclaratorioDFproduto: Boolean): Boolean;
begin
  Result := False;

  If Not TFunctionFuncoesFaturamento.SubstituicaoTributaria(ACodigoDaSubstituicaoTributaria) Then
    Exit;

  If Not TFunctionFuncoesFaturamento.PerfilAbreviacaoNaoConsumidorOuIndustria(ATipoAbreviacaoFiscal) Then
    Exit;

  If AUfEmitente <> 'DF' Then
    Exit;

  If AUfDestinatario <> 'DF' Then
    Exit;

  If Not AItemRevenda Then
    Exit;

  If Not AAtoDeclaratorioDFcliente Then
    Exit;

  If Not AAtoDeclaratorioDFproduto Then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.STAtribuidaPorRegimeEspecial(
  const ASujeitoPassivoSTRegimeEspecial: Boolean;
  const ACodigoDaSubstituicaoTributaria: String): Boolean;
begin
  Result := False;

  If Not ASujeitoPassivoSTRegimeEspecial Then
    Exit;

  If Not TFunctionFuncoesFaturamento.SubstituicaoTributaria(ACodigoDaSubstituicaoTributaria) Then
    Exit;

  Result := True;
end;

Class function TFunctionsRegrasImpostosFaturamento.RetornarTipoOperacaoPedidoVenda(Const ATipoOperacao : String) : String;
begin
  Result := '';

  Case AnsiIndexStr(UpperCase(ATipoOperacao), ['V', 'B','C', 'A']) of
    0 : Result := 'Venda';
    1 : Result := 'Bonificacao';
    2 : Result := 'ContaOrdem';
    3 : Result := 'Amostra';
  end;

end;

//class function TFunctionsRegrasImpostosFaturamento.TipoOperacaoPedidoVendaAmostra(
//  const ATipoOperacao: String): Boolean;
//begin
//  Result := TOpcTipoOperacaoPedidoVenda(GetEnumValue(TypeInfo(TOpcTipoOperacaoPedidoVenda),  RetornarTipoOperacaoPedidoVenda(ATipoOperacao))) = Amostra;
//end;

class function TFunctionsRegrasImpostosFaturamento.VendaItemConcretoDesmembrarNotaProdutosServicos(
  const AEhVendaItemConcreto, ADesmembrarNotaProdutosServicos: Boolean): Boolean;
begin
  Result := False;

  If Not AEhVendaItemConcreto Then
    Exit;

  If Not ADesmembrarNotaProdutosServicos Then
    Exit;

  If Not (MatchStr(objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL),[CONCREMASSA,PRESTCON,SECOL])) Then
    Exit;

  Result := True;
end;

class function TFunctionsRegrasImpostosFaturamento.ZonaFrancaOuOrgaoPublico(
  const AClienteOrgaoPublico, AClienteZonaFranca: Boolean): Boolean;
begin
  Result := True;

  If AClienteOrgaoPublico Then
    Exit;

  If AClienteZonaFranca Then
    Exit;

  Result := False;
end;

class function TFunctionsRegrasImpostosFaturamento.fAlterarTributacaoIcmsPara41eZerarValores(
  const AEstadoDaEmpresa: String; const AEmpresaOptanteSimples: Boolean; const AOpcaoDeDocumento: String;
  const AEspecieDoDocumento: String; const ItemTributado: Boolean; const ConfiguradoParaTrocarParaX41: Boolean;
  const ConfiguradoParaTrocarParaX41noParana: Boolean): Boolean;
begin
  Result := False;

  If (AOpcaoDeDocumento = USO_CONSUMO) Then
    Result := objConfiguracoes.fGetValorConfiguracao(CFG_ZERAR_ICMS_ITENS_SAIDA_POR_USO_CONSUMO, varBoolean)
  Else If (ItemTributado) Then
  Begin
    If AEmpresaOptanteSimples Then
    Begin
      If Self.fEhCupomFiscal(AEspecieDoDocumento) Then
        Result := ConfiguradoParaTrocarParaX41noParana Or ConfiguradoParaTrocarParaX41
      Else
        Result := ConfiguradoParaTrocarParaX41;
    End;
  End;
end;

end.
