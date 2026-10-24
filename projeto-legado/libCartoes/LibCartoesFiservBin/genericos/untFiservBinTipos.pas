unit untFiservBinTipos;

interface

Const
  NOME_CONCILIACAO = 'FISERVBIN';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';


Type
  TRegistroMovimentoFinanceiro = Record
    TipoRegistro,
    BandeiraCartao,
    DataPagamento,
    Estabelecimento,
    EstabelecimentoCentralizador,
    InstrucaoPagamento,
    NumeroResumoVenda,
    QuantidadeROC,
    TipoPagamento,
    TipoTransacao,
    CodigoDescricaoTransacao,
    Descricaotransacao,
    ResumoPagamento,
    CNPJBeneficiarioLockin,
    TipoLockin,
    TipoContaPagamento,
    StatusPagamento,
    DescricaoTransacaoPagamento,
    ChargebackComprovanteReferencia,
    NumeroComprovanteVenda,
    TipoTransacaoVenda,
    DataTransacao,
    HorarioCriacao,
    NumeroParcela,
    TotalParcelas,
    NumeroContaEC,
    DataGeracaoSOC,
    DataPagamentoSOC,
    NumeroControleCliente,
    NumeroCartao,
    CodigoAutorizacao,
    NumeroComprovanteNSU,
    TipoComprovante,
    ValorBrutoROC,
    ValorTaxaImpostosROC,
    ValorLiquidoROC,
    ValorTaxaAntecipacaoROC,
    ValorLiquidoAntecipacaoROC,
    ValorCompraComSaque,
    ReversaoIntercambio,
    ValorBrutoVenda,
    NumeroRegistroArquivo,
    NomeArquivo: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaFiservBinPgto  = Array Of TEstruturaPgto;

  TArrRegistroFiservBinMovimentoFinanceiro = Array Of TRegistroMovimentoFinanceiro;


implementation

end.
