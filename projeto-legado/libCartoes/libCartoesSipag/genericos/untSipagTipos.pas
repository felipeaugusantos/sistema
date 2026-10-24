unit untSipagTipos;

interface

Const
  NOME_CONCILIACAO = 'SIPAG';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strNum_RV: String;
    strDtaPag: String;
    strOC_Doc: String;
    fltRV_Bru: Double;
    fltRV_Liq: Double;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strStatus: String;
    strTipCre: String;
    strTipOpe: String;
    strNumCar: String;
    strDtaTra: String;
    strNumPar: String;
    strTotPar: String;
    strCodAut: String;
    strNumNSU: String;
    fltValBru: Double;
    fltValDes: Double;
    fltValLiq: Double;
    strBandei: String;
    strNumCli: String;
    strCodAju: String;
    strDesAju: String;
    strTipAju: String;
    strDtaArq: String;
    strNomArq: String;
  End;

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

  TArrRegistroSipagPgto  = Array Of TRegistroPgto;

  TArrEstruturaSipagPgto  = Array Of TEstruturaPgto;

  TArrRegistroSipagMovimentoFinanceiro = Array Of TRegistroMovimentoFinanceiro;


  TRegistroPgtoV2 = Record
    strTipReg: String;
    strCodEst: String;
    strNum_RV: String;
    strDtaPag: String;
    strOC_Doc: String;
    fltRV_Bru: Double;
    fltRV_Liq: Double;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strStatus: String;
    strTipCre: String;
    strTipOpe: String;
    strNumCar: String;
    strDtaTra: String;
    strNumPar: String;
    strTotPar: String;
    strCodAut: String;
    strNumNSU: String;
    fltValBru: Double;
    fltValDes: Double;
    fltValLiq: Double;
    strBandei: String;
    strNumCli: String;
    strCodAju: String;
    strDesAju: String;
    strTipAju: String;
    strDtaArq: String;
    strNomArq: String;
  End;

  TRegistroMovimentoFinanceiroV2 = Record
    TipoRegistro,
    BandeiraCartao,
    DataPagamento,
    Estabelecimento,
    LoteLiquidacao,
    QtdeComprovantes,
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
    ReferenciadeVenda,
    DescricaoTransacaoPagamento,
    ChargebackComprovanteReferencia,
    NumeroComprovanteVenda,
    TipoTransacaoVenda,
    DataTransacao,
    HorarioCriacao,
    DataProcessamentoTransacao,
    DataPrevistaPagamentoTransacao,
    NumeroParcela,
    TotalParcelas,
    DataDoAjuste,
    NumeroConta,
    DataGeracaoSOC,
    DataPagamentoSOC,
    NumeroControleCliente,
    NumeroCartao,
    CodigoAutorizacao,
    NumeroComprovanteNSU,
    TipoComprovante,
    ValorBruto,
    ValorAjustado,
    ValorBrutoAjuste,
    ValorBrutoVenda,
    ValorTaxaMDR,
    ValorLiquidoVenda,
    ValorTaxaAntecipacao,
    ValorLiquido,
    ValorLiquidoAntecipacao,
    ValorCompraComSaque,
    ReversaoIntercambio,
    AcquirerReferenceNumber,
    NumeroTerminal,
    CancelId,
    NumeroRegistroArquivo,
    NomeArquivo: String;
  End;

  TArrRegistroSipagPgtoV2  = Array Of TRegistroPgtoV2;

  TArrRegistroSipagMovimentoFinanceiroV2 = Array Of TRegistroMovimentoFinanceiroV2;

implementation

end.
