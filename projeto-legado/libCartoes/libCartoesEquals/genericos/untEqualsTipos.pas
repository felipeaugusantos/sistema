unit untEqualsTipos;

interface

Const
  NOME_CONCILIACAO = 'EQUALS';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';


Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Tipo do registro               | “31” = Registro de Transações                 |
// +---------------------------------------------------------------------------------+
// |  Lote Único                     | Número do lote único na adquirinte            |
// +---------------------------------------------------------------------------------+
// |  Cod Estabelecimento            | Código do Estabelecimento junto a EQUALS      |
// +---------------------------------------------------------------------------------+
// |  Data da Venda                  | Data da Venda                                 |
// +---------------------------------------------------------------------------------+
// |  Código da Autorização          | Código da autorização informado pelo emissor  |
// |                                 | para identificar a transação (Ajustes não tem)|
// +---------------------------------------------------------------------------------+
// |  NSU                            | NSU da transação. Para cancelamentos e        |
// |                                 | chargebacks é usada a NSU original            |
// +---------------------------------------------------------------------------------+
// |  Número da TID                  | Número da TID                                 |
// +---------------------------------------------------------------------------------+
// |  Número da Terminal             | Número da Terminal                            |
// +---------------------------------------------------------------------------------+
// |  Tipo do Terminal               | Tipo do terminal usado                        |
// +---------------------------------------------------------------------------------+
// |  Número do Cartão               | Número do Cartão                              |
// +---------------------------------------------------------------------------------+
// |  Valor Bruto                    | Valor Bruto da Parcela                        |
// +---------------------------------------------------------------------------------+
// |  Valor da Taxa                  | Valor da Taxa da Parcela                      |
// +---------------------------------------------------------------------------------+
// |  Valor da Comissão              | Valor da Comissão da parcela                  |
// +---------------------------------------------------------------------------------+
// |  Valor Líquido                  | Valor Líquido da Parcela                      |
// +---------------------------------------------------------------------------------+
// |  Data do Pagamento              | Data do Pagamento                             |
// +---------------------------------------------------------------------------------+
// |  Núm. da Parcela                | Número da parcela a ser paga.                 |
// +---------------------------------------------------------------------------------+

  TRegistroPgto = Record
    strTipReg: String;
    strLotUni: String;
    strCodEst: String;
    strDtaVen: String;
    strCodAut: String;
    strNumNSU: String;
    strNumTid: String;
    strNumTer: String;
    strTipTer: String;
    strNumCar: String;
    fltValBru: Double;
    fltValTax: Double;
    fltValCom: Double;
    fltValLiq: Double;
    strDtaPag: String;
    strCodPar: String;
    strTotPar: String;
    strNomArq: String;
    strMotAju: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroEquPgto  = Array Of TRegistroPgto;

  TArrEstruturaEquPgto  = Array Of TEstruturaPgto;

implementation

end.
