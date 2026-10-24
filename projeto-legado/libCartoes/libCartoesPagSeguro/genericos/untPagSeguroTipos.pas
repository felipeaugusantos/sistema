unit untPagSeguroTipos;

interface

Const
  NOME_CONCILIACAO = 'PAGSEGURO';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

//API
Type
  TPagSeguroRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strCod_CV: String;
    strDtaTra: String;
    strDtaPag: String;
    strTipEve: String;
    strDtaAju: String;
    strTipTra: String;
    strCodAut: String;
    strCodTra: String;
    strCodVen: String;
    fltValBru: Double;
    fltValLiq: Double;
    fltValPar: Double;
    fltTaxAnt: Double;
    fltLiqAnt: Double;
    strTotPar: String;
    strNumPar: String;
    strStaPag: String;
    strMeiPag: String;
    strNumNSU: String;
    strNumCar: String;
    strNomArq: String;
    strDtaArq: String;

    PagamentoAPrazo,
    CanalDeEntrada,
    MeioDeCaptura,
    Plano: String;

    TaxaIntermediacao,
    TaxaParcelamento: Double;

    strTxId,
    strCodUr,
    strArrUr: String;
  End;

  TChavesPagSeguro = class
  private
  public
    Empresa,
    Estabelecimento,
    Authorization : String;
  end;

//Arquivos
Type
  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strCod_CV: String;
    strDtaTra: String;
    strDtaPag: String;
    strTipEve: String;
    strDtaAju: String;
    strTipTra: String;
    strCodAut: String;
    strCodTra: String;
    strCodVen: String;
    fltValBru: Double;
    fltValLiq: Double;
    fltValPar: Double;
    fltTaxAnt: Double;
    fltLiqAnt: Double;
    strTotPar: String;
    strNumPar: String;
    strStaPag: String;
    strMeiPag: String;
    strNumNSU: String;
    strNumCar: String;
    strNomArq: String;
    strDtaArq: String;

    PagamentoAPrazo,
    CanalDeEntrada,
    MeioDeCaptura,
    Plano: String;

    TaxaIntermediacao,
    TaxaParcelamento: Double;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroPagSeguroPgto  = Array Of TRegistroPgto;

  TArrEstruturaPagSeguroPgto  = Array Of TEstruturaPgto;

implementation

end.
