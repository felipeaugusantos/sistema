unit untTConcil;

interface

uses System.Generics.Collections, SysUtils;

Type
  TConcilRegistroPgto = Record
    ID,
    PFJ,
    Branch,
    Estabelecimento,
    Parcela,
    TotalParcelas,
    IDAdquirente,
    BrandId,
    ProductId,
    Nsu,
    Autorizacao,
    DataPagamento,
    Status,
    StatusReconciliacaoVenda,
    Fatura,
    CodigoAntencipacao,
    Banco,
    AgenciaBancaria,
    ContaBancaria,
    Tid,
    Terminal,
    CanalCaptura,
    DataDaVenda,
    NumeroCartao,
    Classificacao,
    TipoTransacao,
    Resumo,
    IdUnico,
    DataCriacao: String;

    ValorBrutoParcela,
    ValorLiquidoPacrela,
    ValorBruto,
    ValorLiquido,
    TaxaAdministrativa,
    TaxaAntecipacao,
  	ValorDesconto,
    ValorMarcacao,
    TaxaEsquema,
    ValorIntercambio,
    ValorCarga: Double;

  End;

  TConcilRegistroAjuste = Record
    PFJ,
    Branch,
    Estabelecimento,
    Parcela,
    TotalParcelas,
    IDAdquirente,
    BrandId,
    ProductId,
    Nsu,
    Autorizacao,
    DataAjuste,
    Fatura,
    CodigoAntencipacao,
    Banco,
    AgenciaBancaria,
    ContaBancaria,
    Tid,
    Terminal,
    CanalCaptura,
    DataDaVenda,
    NumeroCartao,
    TipoTransacao,
    Resumo,
    IdUnico,
    DataCriacao: String;

    ValorAjuste :Double;

  End;


implementation

end.
