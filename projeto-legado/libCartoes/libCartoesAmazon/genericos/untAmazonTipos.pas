unit untAmazonTipos;

interface

Const
  NOME_CONCILIACAO  = 'AMAZON';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
  TTiposLancamentosMkt = (tlmVendas, tlmAjustes, tlmLiquido, tlmTransferencias);

  TTipoTransacaoAmazon = (
    ttaOrder,
    ttaRefund,
    ttaServiceFee,
    ttaAdjustment,
    ttaTransfer,
    ttaFBAInventoryFee,
    ttaFBAFulfillmentFee,
    ttaCouponRedemptionFee,
    ttaLiquidations,
    ttaOtherTransaction
  );

  TTipoValorAmazon = (
    tvaItemPrice,
    tvaItemFees,
    tvaPromotion,
    tvaOtherTransaction
  );

  TRegistroCabecalhoAmazon = Record
    SettlementID       : String;
    SettlementStartDate: String;
    SettlementEndDate  : String;
    DepositDate        : String;
    TotalAmount        : Double;
    Currency           : String;
  End;


  TRegistroPgto = Record
    strIdentificacaoArquivo           : String;
    TransactionType         : String;
    OrderID                 : String;
    MerchantOrderID         : String;
    AdjustmentID            : String;
    ShipmentID              : String;
    AmountType              : String;
    AmountDescription       : String;
    Amount                  : Double;
    FulfillmentID           : String;
    PostedDate              : String;
    PostedDateTime          : String;
    OrderItemCode           : String;
    MerchantOrderItemID     : String;
    MerchantAdjustmentItemID: String;
    SKU                     : String;
    QuantityPurchased       : Integer;
    PromotionID             : String;
    strNomArq: String;
    strDtaArq: String;
    strDtaini: String;
    strDtaPag: String;
    strDtafim: String;
    strMoeda: String;
    strTotArq: String;

    CodigoEmpresa           : String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroAmazonPgto   = Array Of TRegistroPgto;
  TArrEstruturaAmazonPgto  = Array Of TEstruturaPgto;

implementation

end.
