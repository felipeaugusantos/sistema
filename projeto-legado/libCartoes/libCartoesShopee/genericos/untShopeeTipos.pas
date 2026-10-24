unit untShopeeTipos;

interface

Const
  NOME_CONCILIACAO = 'SHOPEE';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
  TTiposLancamentosMkt = (tlmVendas, tlmAjustes, tlmLiquido, tlmTransferencias);

  TRegistroRepassePgto = Record
    DataPagamento,
    Descricao,
    ValorPago,
    Autorizacao,
    NomeArquivo: String;
  End;

  TRegistroPedidoPgto = Record // Arquivo completo (detalhado)
    IDPedido,
    StatusPedido,
    CancelarMotivo,
    StatusDevolucao,
    NumeroRastreamento,
    OpcaoEnvio,
    MetodoEnvio,
    DataPrevistaEnvio,
    TempoEnvio,
    DataCriacaoPedido,
   	DataPagamentoPedido,
    HoraPagamentoPedido,
    NumeroSKUPrincipal,
    NomeProduto,
    NumeroSKU,
    NomeVariacao,
    PrecoOriginal,
    PrecoAcordado,
    Quantidade,
    SubtotalProduto,
    DescontoVendedor1,
    DescontoVendedor2,
    ReembolsoShopee,
    ReembolsoAjustavelDisputa,
    PesoTotalSKU,
    QuantidadePedidos,
    PesoTotalPedido,
    CodigoCupom,
    CupomVendedor,
    CoinCashback,
    CupomShopee,
    IndicadorLeveMaisPorMenos,
    DescontoShopeeLeveMaisPorMenos,
    DescontoLeveMaisPorMenosVendedor,
    CompensarMoedasShopee,
    TotalDescontadoCartaoCredito,
    DescontoOriginalShopee,
    DescontoShopee,
    DescontoPix,
    TaxaPublicidade,
    ValorTotal,
    ValorTotalRecebido,
    ValorDevolucao,
    TaxaEnvioPagaPeloComprador,
    DescontoFreteAproximado,
    TaxaEnvioReversa,
    TaxaTransacao,
    TaxaTransacaoComprador,
    TaxaComissao,
    TaxaServico,
    TaxaProtecaoEnvio,
    TotalGlobal,
    ValorEstimadoFrete,
    ValorFreteAtual,
    ValorFinalFrete,
    ValorComisaoAMS,
    ValorTotalAjustado,
    ImportadoPelaAPI,
    Empresa,
    NomeArquivo : String;
  End;

  TRegistroPgto = Record
    LDtaDec: String; // Data da Declaracão
    LHraDec: String; // Hora da Declaracão
    LBenefi: String; // Beneficiario
    LValPag: Double; // Pagamento
    LDescri: String; // Descrição
    LCodAut: String; // codigo da autorização
    LStatus: String; // Status
    LSalCar: Double; // Saldo da Carteira
    LAjuste: String; // Ajuste (S/N)
    LNomArq: String; // Nome do Arquivo
    LCodEmp: String; // Código da Empresa
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroShopeePayPgto  = Array Of TRegistroPgto;
  TArrRegistroShopeePayPedidoPgto  = Array Of TRegistroPedidoPgto;
  TArrRegistroShopeePayRepassePgto  = Array Of TRegistroRepassePgto;

  TArrEstruturaShopeePayPgto  = Array Of TEstruturaPgto;

implementation

end.
