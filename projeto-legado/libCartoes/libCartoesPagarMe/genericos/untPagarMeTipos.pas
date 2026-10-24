unit untPagarMeTipos;

interface

Uses System.Generics.Collections, System.SysUtils;

Const
  NOME_CONCILIACAO = 'PAGAR.ME';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
  TTiposLancamentosMkt = (tlmVendas, tlmAjustes, tlmLiquido, tlmTransferencias);

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaPagarMePgto = Array Of TEstruturaPgto;

  TPagarMeRegistroTransferencia = Class
    FTransferencia_ID,
    FTipoRegistro,
    FDescricao,
    FStatus,
    FValorTransferencia,
    FTaxaTransferencia,
    FTipoTransferencia,
    FSource_ID,
    FTargetType,
    FDataCadastro,
    FDataCredito,
    FTitular,
    FCodigoBanco,
    FAgencia,
    FConta,
    FDigitoConta,
    FJsonRecebido,
    FKeyApi: String;
  end;

  TPagarMeRegistroRecebiveis = Class
    FRecebivel_ID,
    FGateWay_ID,
    FCobranca_ID,
    FTipoRecebimento,
    FStatus,
    FNumeroParcela,
    FValorParcela,
    FTaxaParcela,
    FTaxaAntecipacao,
    FTaxaAntiFraude,
    FValorPago,
    FDataCadastro,
    FDataVencimento,
    FDataPagamento,
    FJsonRecebido,
    FKeyApi,
    FAntecipacao_ID,
    FRecebedor,
    FMetodoPagamento: String;
  end;

  TPagarMeRegistroCobranca = Class
    FCobranca_ID,
    FGateway_ID,
    FTipoRegistro,
    FTotalParcelas,
    FNumeroNSU,
    FParcela,
    FAutorizacao,
    FDataVenda,
    FValorBruto,
    FValorLiquido,
    FCartao,
    FNumPok,
    FBandeira,
    FDataPagamento,
    FMeioPagamento,
    FJson,
    FDataImportacao,
    FKeyApi,
    FStatus,
    FOrigem,
    FOrderIntegrador,
    FOrderId,
    FCustomerId: String;
  End;


  TPagarMeRegistroPgto = class
    Aobject,
    Astatus,
    Arefuse_reason,
    Astatus_reason,
    Aacquirer_response_code,
    Aacquirer_response_message,
    Aacquirer_name,
    Aacquirer_id,
    Aauthorization_code,
    Asoft_descriptor,
    Atid,
    Ansu,
    Adate_created,
    Adate_updated,
    Aamount,
    Aauthorized_amount,
    Apaid_amount,
    Arefunded_amount,
    Ainstallments,
    Aid,
    Acost,
    Acard_holder_name,
    Acard_last_digits,
    Acard_first_digits,
    Acard_brand,
    Acard_pin_mode,
    Acard_magstripe_fallback,
    Acvm_pin,
    Apostback_url,
    Apayment_method,
    Acapture_method,
    Aantifraud_score,
    Aboleto_url,
    Aboleto_barcode,
    Aboleto_expiration_date,
    Aboleto,
    Areferer,
    Aip,
    Asubscription_id,
    AJson,
    AKeyApi : String;
  End;

  TPagarMeRegistroVendas = class
    Aobject,
    Aid,
    Astatus,
    Aamount,
    Afee,
    Aanticipation_fee,
    Afraud_coverage_fee,
    Ainstallment,
    Atransaction_id,
    Asplit_rule_id,
    Abulk_anticipation_id,
    Aanticipation_id,
    Arecipient_id,
    Aoriginator_model,
    Aoriginator_model_id,
    Apayment_date,
    Aoriginal_payment,
    Atype,
    Apayment_method,
    Aaccrual_date,
    Adate_created,
    Aliquidation_arrangement_id,
    aJson : String;
  End;

implementation

end.
