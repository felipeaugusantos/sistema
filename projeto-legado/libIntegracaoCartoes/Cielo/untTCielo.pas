unit untTCielo;

interface

Uses System.SysUtils;

Type
  TRegistroCieloPgto015 = record
    TipoRegistro,
    CodigoEstabelecimento,
    EstabelecimentoVenda,
    CodigoBandeira,
    TipoLiquidacao,
    TipoTransacao,
    StatusPgto,
    TipoLancamento,
    TipoLancamentoOriginal,
    DataPagamento,
    DataEnvioBanco,
    DataVencimentoOriginal,
    NumeroNF,

    URsPendentes,
    URsReenviadas,
    URsNegociadas,

    TipoAntecipacao,
    NumeroAntecipacao,

    ChaveUR,

    CodigoBanco,
    CodigoAgencia,
    CodigoConta,
    DigitoConta,

    IndicativoGravame: String;

    ValorBrutoUR,
    ValorTaxaUR,
    ValorLiquidoUR,

    TaxaAntecipacao: Double;

    NumeroParcela,
    TotalParcelas,
    CodigoAutorizacao,
    CodigoAjuste,
    FormaPagameto,
    NumeroCartao,
    NumeroNSU,
    NumeroTID,
    CodigoPedido,
    CodigoVenda,
    CodigoOriginalVenda,
    NumeroOperacao,
    TipoCartao,
    TipoCaptura,

    DataTransacao,
    DataCaptura,
    DataMovimento,
    DataMovimentoOriginal,

    GrupoCartoes,

    MeioCaptura,
    NumeroTerminal :String;

    ValorBrutoVenda,
    ValorBrutoParcela,
    ValorTaxaRecebaRapido,
    ValorTaxaMDR,

    ValorComissao,
    ValorComissaoMinima,
    ValorTarifaAdministrativa,
    ValorLiquidoVenda,

    ValorAjuste: Double;

    QuantidadeLancamentosUR,
    IndicativoRecebaRapido,
    IndicativoTaxaZero,
    IndicativoTransacaoRejeitada,
    IndicativoTardia,

    CodigoTransacaoContrato,
    NumeroLote,
    NumeroTransacaoProcessada,
    MotivoRejeicao,

    OrigemAjuste,
    TipoNegociacao,
    VencimentoOriginal,

    DataArquivo,
    NomeArquivo,
    TipoArquivo: String;

    CalculaLiqDeb: Boolean;

    VersaoArquivo: String;
  End;

Type
  TArrRegistroCieloPgto015  = Array Of TRegistroCieloPgto015;

implementation

end.
