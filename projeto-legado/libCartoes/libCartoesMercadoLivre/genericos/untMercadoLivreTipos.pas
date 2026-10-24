unit untMercadoLivreTipos;

interface

Const
  NOME_CONCILIACAO = 'MERCADO LIVRE';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
  TRegistroPgto = Record
    strTipReg: String;
    strStatus: String;
    strCodAut: String;
    strDtaTra: String;
    strDtaPag: String;
    fltValPro: Double;
    fltValEnv: Double;
    fltValLiq: Double;
    fltValMPG: Double;
    fltValPla: Double;
    fltValDev: Double;
    strTipPag: String;
    strApelid: String;
    strNumOpe: String;
    strNumVen: String;
    strLinPro: String;
    strNomArq: String;
    strDtaArq: String;
    strCodEst: String;
    strShp_ID: String;
    LCodEmp  : String;

    CupomDesconto,
    BalanceAmount,
    CustoDescontoOferecido: Double;

    GMTRegistro,
    PosicaoArquivoData: Integer;

    OrderId,
    ShipmentMode,
    NumeroParcela,
    TotalParcelas,
    DataCompletaString,
    PosId,
    NumeroNSU,
    NumeroCartao: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TIndicesCampos = Record
    strNomCam: String;
    intIndice: Integer;
  End;

  TArrRegistroMLPgto  = Array Of TRegistroPgto;

  TArrEstruturaMLPgto = Array Of TEstruturaPgto;

  TArrIndicePgto      = Array Of TIndicesCampos;

  TTiposLancamentosMkt = (tlmVendas, tlmAjustes, tlmLiquido, tlmTransferencias);

  TEmpresasDatasImportacao = class
    DataImportacao: TDate;

    Empresa,
    NomeArquivos: String;

    QuantidadeRegistros: Integer;
  End;

implementation

end.
