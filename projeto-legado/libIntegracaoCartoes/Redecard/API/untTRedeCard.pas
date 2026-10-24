unit untTRedeCard;

interface

uses System.Generics.Collections, SysUtils;

Type
  TRedeCardRegistroPgto = class
    private
    public
      CodigoEstabelecimento,
      TipoRegistro,
      DataPagamento,
      NumeroRV,
      NumeroOrdem,
      CodigoBandeira,
      DescricaoTipo,
      DataImportacao,
      PagamentoID: String;

      ValorBruto,
      ValorDesconto,
      ValorLiquido: Double;
  end;

  TRedeCardAPIRegistroVenda = class
    private
    public
      CodigoEstabelecimento,
      TipoRegistro,
      DataRV,
      NumeroRV,
      NumeroOrdem,
      NumeroDocumento,
      CodigoBandeira,
      DataImportacao,
      RazaoSocial,
      NomeFantasia,
      Autorizacao,
      NSU,
      TID,
      NomeProduto,
      CodigoProduto,
      TotalParcelas,
      DataVenda,
      Status,
      ChargeBackStatus,
      TipoMaquina,
      CodigoTerminal,
      TipoCaptura,
      CodigoCaptura,
      Ard,
      Flex,
      NumeroCartao: String;

      ValorBruto,
      ValorDesconto,
      ValorLiquido,
      TaxaMDR,
      ValorMDR,
      TaxaFlex,
      ValorFlex,
      PercentualTaxa,
      ValorEmbarque: Double;
  end;

  TRedeCardAPIRegistroVendaParcelada = class
    private
    public
      CodigoEstabelecimento,
      DataRV,
      DataVenda,
      DataVencimento,
      NumeroRV,
      DataImportacao,
      NSU,
      TID,
      Parcela,
      TotalParcelas: String;

      ValorParcela,
      ValorDesconto,
      ValorLiquido,
      TaxaMDR,
      ValorMDR,
      PercentualTaxa,
      ValorVenda: Double;
  end;

  TRedeCardAPIRegistroAjuste = class
    private
    public
      CodigoAjuste,
      DescricaoAjuste,
      CodigoEstabelecimento,
      NumeroRV,
      DataPagamento,
      DataRV,
      NumeroDebito,
      NumeroDocumento,
      NomeFantasia,
      NumeroAviso,
      RazaoSocial,
      DataExpiracao,
      NumeroPedido,
      TipoRegistro,
      DataImportacao: String;

      ValorAjuste,
      ValorAjusteFuturo,
      ValorPago: Double;
  end;


implementation

end.
