unit Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos;

interface

uses System.StrUtils, Shared.Functions.Types,
  Shared.Functions.Faturamento.Impostos.Regras, Shared.Functions.Configuracoes,
  Shared.Functions.Constantes, Shared.Functions.Funcoes.Faturamento, SysUtils;

type
  TFunctionsZerarImpostosRegrasImpostosFaturamento = class
  private
    class function fClienteExteriorEClassificacaoDeExportacao(const AClassificacaoFiscal: String; const AClienteEstado: String): Boolean;
    class function fConfirmacaoDeCupomFiscalEZerarBaseIcmsEIpi(const AOpcaoDeDocumento: String): Boolean;
    class function fRemessaContaEOrdemOuRemessaMercadoriaFaltante(const AOpcaoDeDocumento: String): Boolean;
    class function fRemessaConcretoOuTaxaBombeamentoPedidoOrcamento(const AOpcaoDeDocumento: String; const ATaxaBombeamentoPedidoOrcamento: Boolean): Boolean;
    class function fClassificacaoDeVenda(const AClassificacaoFiscal: String; const AClassificacaoDeVenda: String; const AOpcaoDeDocumento: String): Boolean;
    class function fRemessaParaDeposito(const AClassificacaoFiscal: String; const AOpcaoDeDocumento: String): Boolean;
    class function fClassificacaoDeBrinde(const AClassificacaoFiscal: String): Boolean;
    class function fNFEspiritoSantoBasesColorantesDestaqueImpostosOuTributados(const AOpcINFesp: TOpcItensNFespTinta): Boolean;
    class function fClassificacaoDeDevolucaoImpostos(const AClassificacaoFiscal, AOpcaoDeDocumento: String): Boolean;
    class function fClassificacaoDeExportacao(const AClassificacaoFiscal: String): Boolean;
    class function fClassificacaoFiscalDeRetornoDeConsignacao(const AClassificacaoFiscal : String; const AVendaDentroDoEstado : Boolean) : Boolean;
  public
    class function fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(
      const AClassificacaoFiscalDoItem: String; const AOpcaoDeDocumento: String;
      const ATaxaBombeamentoPedidoOrcamento: Boolean; const AClassificacaoFiscal: String;
      const AOpcaoItensNFEspTinta: TOpcItensNFespTinta; const AClassificacaoDeVenda: String;
      const AClienteEstado: String; const AClienteZonaFranca: Boolean; const AVendaDentroDoEstado : Boolean): Boolean;

    //IPI E ST
    class function DesmembrarMeiaNotaComNotaNormalFatorExpedicao(
      const ADesmembrarMeiaNotaComNotaNormal: Boolean; const AEspecieDoDocumento: String;
      const AMeiaNotaFatorExpedicao: Boolean): Boolean;

    class function fZerarIpiFaturamentoConsignacao(const AClassificacaoFiscal: String): Boolean;
    class function fZerarSTFaturamentoConsignacao(const AClassificacaoFiscal: String): Boolean;
    class function fZerarIcmsFaturamentoConsignacao(const AClassificacaoFiscal: String; const ACodigoDaSituacaoTributaria: String): Boolean;

  end;

implementation

{ TFunctionsZerarImpostosRegrasImpostosFaturamento }

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.
  fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(const AClassificacaoFiscalDoItem: String;
    const AOpcaoDeDocumento: String; const ATaxaBombeamentoPedidoOrcamento: Boolean;
    const AClassificacaoFiscal: String; const AOpcaoItensNFEspTinta: TOpcItensNFespTinta;
    const AClassificacaoDeVenda: String; const AClienteEstado: String;
    const AClienteZonaFranca: Boolean; const AVendaDentroDoEstado : Boolean): Boolean;
begin
  Result :=
    AClienteZonaFranca Or
    Self.fClienteExteriorEClassificacaoDeExportacao(AClassificacaoFiscalDoItem, AClienteEstado) Or
    Self.fConfirmacaoDeCupomFiscalEZerarBaseIcmsEIpi(AOpcaoDeDocumento) Or
    Self.fRemessaContaEOrdemOuRemessaMercadoriaFaltante(AOpcaoDeDocumento) Or
    Self.fRemessaConcretoOuTaxaBombeamentoPedidoOrcamento(AOpcaoDeDocumento, ATaxaBombeamentoPedidoOrcamento) Or
    (
      (Not Self.fRemessaParaDeposito(AClassificacaoFiscal, AOpcaoDeDocumento)) And
      (Not Self.fClassificacaoDeVenda(AClassificacaoFiscal, AClassificacaoDeVenda, AOpcaoDeDocumento)) And
      (Not Self.fNFEspiritoSantoBasesColorantesDestaqueImpostosOuTributados(AOpcaoItensNFespTinta)) And
      (Not Self.fClassificacaoDeDevolucaoImpostos(AClassificacaoFiscal, AOpcaoDeDocumento)) And
      (Not Self.fClassificacaoFiscalDeRetornoDeConsignacao(AClassificacaoFiscal, AVendaDentroDoEstado)) And
      (Not Self.fClassificacaoDeBrinde(AClassificacaoFiscal))
    )
    Or
    Self.fClassificacaoDeExportacao(AClassificacaoFiscalDoItem);
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fClienteExteriorEClassificacaoDeExportacao(
  const AClassificacaoFiscal: String; const AClienteEstado: String): Boolean;
begin
  Result := ((AClienteEstado = EXTERIOR) And Self.fClassificacaoDeExportacao(AClassificacaoFiscal));
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fConfirmacaoDeCupomFiscalEZerarBaseIcmsEIpi(const AOpcaoDeDocumento: String): Boolean;
begin
  Result :=
    ((AOpcaoDeDocumento = CONFIRMACAO_CUPOM_FISCAL) And (objConfiguracoes.fGetValorConfiguracao(CFG_ZERAR_BASES_ICMS_E_IPI, varBoolean)));
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fRemessaContaEOrdemOuRemessaMercadoriaFaltante(
  const AOpcaoDeDocumento: String): Boolean;
begin
  Result := (Pos(AOpcaoDeDocumento, REMESSA_CONTA_E_ORDEM_MERCADORIA_FALTANTE) > 0);
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fZerarIcmsFaturamentoConsignacao(const AClassificacaoFiscal, ACodigoDaSituacaoTributaria: String): Boolean;
begin
  Result := (Pos(AClassificacaoFiscal, objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_FATURAMENTO_MERCADORIA_CONSIGNACAO, varString)) > 0) and
            (objConfiguracoes.fGetValorConfiguracao(CFG_FATURAMENTO_CONSIGNACAO_REGRA_TRIBUTARIA, varString) <> MANTER_CALCULO_ABREVIACAO_FISCAL) And
            (Pos(RightStr(ACodigoDaSituacaoTributaria, 2), CST_ISENTAR_TRIBUTADOS_ZERANDO_ICMS) > 0);
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fZerarIpiFaturamentoConsignacao(const AClassificacaoFiscal: String): Boolean;
begin
  Result := (Pos(AClassificacaoFiscal, objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_FATURAMENTO_MERCADORIA_CONSIGNACAO, varString)) > 0) and
            (objConfiguracoes.fGetValorConfiguracao(CFG_FATURAMENTO_CONSIGNACAO_REGRA_TRIBUTARIA, varString) <> MANTER_CALCULO_ABREVIACAO_FISCAL);
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fZerarSTFaturamentoConsignacao(const AClassificacaoFiscal: String): Boolean;
begin
  Result := (Pos(AClassificacaoFiscal, objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_FATURAMENTO_MERCADORIA_CONSIGNACAO, varString)) > 0) and
            (objConfiguracoes.fGetValorConfiguracao(CFG_FATURAMENTO_CONSIGNACAO_REGRA_TRIBUTARIA, varString) = ISENTAR_TRIBUTADOS_JOGANDO_ST_NAS_DESPESAS_ACESSORIAS);
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fRemessaConcretoOuTaxaBombeamentoPedidoOrcamento(
  const AOpcaoDeDocumento: String; const ATaxaBombeamentoPedidoOrcamento: Boolean): Boolean;
begin
  Result := ((AOpcaoDeDocumento = REMESSA_CONCRETO) Or ATaxaBombeamentoPedidoOrcamento)
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fClassificacaoDeVenda(
  const AClassificacaoFiscal: String; const AClassificacaoDeVenda: String;
  const AOpcaoDeDocumento: String): Boolean;
var
  LClassificacaoDeVenda : String;

const
  ENVIO_REMESSA = 'ER';
  RETORNO_REMESSA = 'ET';
  FATURAMENTO_REMESSA = 'EM';
begin
  LClassificacaoDeVenda := AClassificacaoDeVenda;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_MODELO_VENDA_FORA_ESTABELECIMENTO) = CFG_MODELO_VENDA_FORA_ESTABELECIMENTO_OPC_2) Then
  Begin
    If (AOpcaoDeDocumento = ENVIO_REMESSA) Or
       (AOpcaoDeDocumento = RETORNO_REMESSA) Or
       (AOpcaoDeDocumento = FATURAMENTO_REMESSA) Then
    Begin
      LClassificacaoDeVenda := LClassificacaoDeVenda
                             + AClassificacaoFiscal
                             + '_'
    End;
  End;

  Result := (Pos(AClassificacaoFiscal, LClassificacaoDeVenda) > 0);
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fRemessaParaDeposito(const AClassificacaoFiscal: String; const AOpcaoDeDocumento: String): Boolean;
var
  LClassificaDeRemessaParaDeposito: String;
  LZeraImpostosDaRemessaParaDeposito: Boolean;

const
  OUTRAS_SAIDAS = 'OU';

begin
  Result := False;

  LClassificaDeRemessaParaDeposito   := objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_REMESSA_PARA_DEPOSITO, varString);
  LZeraImpostosDaRemessaParaDeposito := objConfiguracoes.fGetValorConfiguracao(CFG_ZERA_IMPOSTOS_DA_REMESSA_PARA_DEPOSITO, varBoolean);

  If not (AOpcaoDeDocumento = OUTRAS_SAIDAS) Then
    Exit;

  If not (Pos(AClassificacaoFiscal, LClassificaDeRemessaParaDeposito) > 0) Then
    Exit;

  If LZeraImpostosDaRemessaParaDeposito Then
    Exit;

  Result := True;
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fClassificacaoDeBrinde(const AClassificacaoFiscal: String): Boolean;
begin
  Result := (RightStr(AClassificacaoFiscal, 3) = objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_BRINDE));
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fNFEspiritoSantoBasesColorantesDestaqueImpostosOuTributados(
  const AOpcINFesp: TOpcItensNFespTinta): Boolean;
begin
  Result := (AOpcINFesp in [opcBasesColorantesComDestaqueImpostos, opcColorantesTributados]);
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.DesmembrarMeiaNotaComNotaNormalFatorExpedicao(
  const ADesmembrarMeiaNotaComNotaNormal: Boolean;
  const AEspecieDoDocumento: String;
  const AMeiaNotaFatorExpedicao: Boolean): Boolean;
begin
  Result := False;

  If Not ADesmembrarMeiaNotaComNotaNormal Then
    Exit;

  If Not TFunctionFuncoesFaturamento.
    ValidarDocumentosMIFF(AEspecieDoDocumento) Then
  Begin
    Exit;
  End;

  If Not AMeiaNotaFatorExpedicao Then
    Exit;

  Result := True;
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fClassificacaoDeDevolucaoImpostos(const AClassificacaoFiscal, AOpcaoDeDocumento: String): Boolean;
begin
  Result := True;

  If (Pos(AClassificacaoFiscal, CFOP_DEVOLUCAO_IMPOSTOS) > 0) Then
    Exit;

  If (Pos(AOpcaoDeDocumento, OPCAO_DOCUMENTO_EXCECOES_ZERAR_IMPOSTOS) > 0) Then
    Exit;

  Result := False;
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fClassificacaoDeExportacao(
  const AClassificacaoFiscal: String): Boolean;
begin
  Result := (LeftStr(AClassificacaoFiscal, 1) = '7');
end;

class function TFunctionsZerarImpostosRegrasImpostosFaturamento.fClassificacaoFiscalDeRetornoDeConsignacao(const AClassificacaoFiscal : String; const AVendaDentroDoEstado : Boolean): Boolean;
  Var
    LstrPreClassificaoItem: String;
    LstrClassificacaoDeRetornoConsignacao : String;
begin
  Result := False;

  If (AVendaDentroDoEstado) Then
    LstrPreClassificaoItem := '1'
  Else
    LstrPreClassificaoItem := '2';

  LstrClassificacaoDeRetornoConsignacao := LstrPreClassificaoItem +
                                           Copy(Trim(objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_RETORNO_MERCADORIA_CONSIGNACAO, varString)), 2, 3);

  If (Pos(AClassificacaoFiscal, LstrClassificacaoDeRetornoConsignacao) > 0) Then
    Exit(True);
end;

end.
