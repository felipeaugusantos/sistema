unit untTGetNet;

interface

Uses System.SysUtils;

Type
  TRegistroGetNetPgto10_1 = record
    TipoRegistro,
    CodigoEstabelecimento,

    CodigoProduto,
    FormaCaptura,

    NumeroRV,
    DataRV,
    DataPagamento,

    NumeroNSU,
    CodigoAutorizacao,
    DataTransacao,
    NumeroCartao,
    StatusTransacao,

    CodigoTerminal,
    CarteiraDigital,

    CodigoBanco,
    CodigoAgencia,
    CodigoContaCorrente,

    TipoPagamentoOperacao,
    NumeroParcela,
    TotalParcelas,
    CentralizadorPagamento,

    DataVencimentoOriginal,
    NumeroControle,
    ChaveUR,

    Metadados,

    IdentificadorAjuste,
    MotivoAjuste,
    DataCartaCancelamento,
    NumeroRVOriginal,
    NSUOriginal,
    DataPagamentoOriginal,

    NumeroOperacao,
    TipoConta,
    CanalOperacao,
    TipoMovimento: String;

    ValorBrutoRV,
    ValorLiquidoRV,
    ValorTaxaRV,
    ValorRejeitadoRV,
    ValorCreditadoRV,
    ValorLiquidoCI,
    ValorParcela,
    ValorComissaoMDR,
    TaxaMensalOperacao,
    ValorTransacao,
    ValorTarifaRV: Double;

    DataArquivo,
    NomeArquivo,
    TipoArquivo: String;

    VersaoArquivo: String;
  End;

Type
  TArrRegistroGetNetPgto10_1 = Array Of TRegistroGetNetPgto10_1;

implementation

end.
