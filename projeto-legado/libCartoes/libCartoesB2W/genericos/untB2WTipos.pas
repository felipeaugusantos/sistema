unit untB2WTipos;

interface

Uses System.Generics.Collections, System.SysUtils;

Const
  NOME_CONCILIACAO = 'B2W';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
 TTiposLancamentosMkt = (tlmVendas, tlmAjustes, tlmLiquido, tlmTransferencias);

  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strCodAut: String;
    strDtaTra: String;
    strDtaPag: String;
    strNumPed: String;
    strStatus: String;
    strMarca_: String;
    strTipPag: String;
    strNumPar: String;
    strTotPar: String;
    fltValBru: Double;
    fltValCom: Double;
    fltValLiq: Double;
    strNomArq: String;
    strDtaArq: String;
    strNumEnt: String;
    strImpNov: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroB2WPgto  = Array Of TRegistroPgto;

  TArrEstruturaB2WPgto = Array Of TEstruturaPgto;

implementation


end.
