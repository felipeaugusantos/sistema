unit untSafrapayTipos;

interface

Const
  NOME_CONCILIACAO = 'SAFRAPAY';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

type
  TSafrapayRegistro = Record
    strTipReg: String;
    strCodEst: String;
    strDtaPag: String;
    strDtaTra: String;
    strNumNSU: String;
    strTipLan: String;
    strTipPro: String;
    strTipCap: String;
    fltValBru: Double;
    fltValDes: Double;
    fltValLiq: Double;
    strNumCar: String;
    strNumPar: String;
    strTotPar: String;
    fltBruPar: Double;
    fltDesPar: Double;
    fltLiqPar: Double;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strCodAut: String;
    strCodBan: String;
    strCodPro: String;
    strNumAnt: String;
    strNSUAju: String;
    strTipAju: String;
    strCodAju: String;
    strDesAju: String;
    strNomArq: String;
    strDtaArq: String;
    strVerArq: String;
    strID_Pix: String;
    TaxaAntecipacao: Double;

    DataPrevisaoPagamento,
    DiasAntecipados,
    NumeroEC,
    NumeroRO: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroSafrapayPgto = array of TSafrapayRegistro;

  TArrEstruturaSafrapayPgto = array of TEstruturaPgto;

implementation


end.





