unit untTPagSeguro;

interface

uses System.Generics.Collections, SysUtils;

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
  End;


implementation

end.
