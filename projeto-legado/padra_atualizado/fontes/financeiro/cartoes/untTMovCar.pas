unit untTMovCar;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy;

type
  [Entity]
  [Table('MOVCAR')]
  [UniqueKey('MCA_NUMDUP, MCA_CODCLI, MCA_PARCEL, MCA_CODEMP')]
  [Id('FstrAutoIncrem', TIdGenerator.None)]
  TMovCar = class
  private

    [Column('MCA_NUMDUP', [TColumnProp.Required], 12)]
    FstrNumDup: String;

    [Column('MCA_CODCLI', [TColumnProp.Required], 8)]
    FstrCodCli: String;

    [Column('MCA_PARCEL', [TColumnProp.Required], 3)]
    FstrParcel: String;

    [Column('MCA_CODEMP', [TColumnProp.Required], 3)]
    FstrCodEmp: String;

    [Column('MCA_CODCAR', [TColumnProp.Required], 5)]
    FstrCodCar: String;

    [Column('MCA_DTACAD')]
    FdteDtaCad: Nullable<TDateTime>;

    [Column('MCA_DTAVEN')]
    FdteDtaVen: Nullable<TDateTime>;

    [Column('MCA_VALORI', [], 12, 2)]
    FfltValOri: Nullable<Double>;

    [Column('MCA_VALDUP', [], 12, 2)]
    FfltValDup: Nullable<Double>;

    [Column('MCA_HIST01', [], 250)]
    FstrHist01: Nullable<String>;

    [Column('MCA_HIST02', [], 250)]
    FstrHist02: Nullable<String>;

    [Column('MCA_CONPAG', [], 110)]
    FstrConPag: Nullable<String>;

    [Column('MCA_DTAREC')]
    FdteDtaRec: Nullable<TDateTime>;

    [Column('MCA_VALREC', [], 12, 2)]
    FfltValRec: Nullable<Double>;

    [Column('MCA_OPEBAI', [], 3)]
    FstrOpeBai: Nullable<String>;

    [Column('MCA_HISBAI', [], 50)]
    FstrHisBai: Nullable<String>;

    [Column('MCA_PORBAI', [], 5)]
    FstrPorBai: Nullable<String>;

    [Column('MCA_CTABAI', [], 7)]
    FstrCtaBai: Nullable<String>;

    [Column('MCA_DOCBAN', [], 13)]
    FstrDocBan: Nullable<String>;

    [Column('MCA_PORBTX', [], 5)]
    FstrPorBtx: Nullable<String>;

    [Column('MCA_CTABTX', [], 7)]
    FstrCtaBtx: Nullable<String>;

    [Column('MCA_DOCBTX', [], 13)]
    FstrDocBtx: Nullable<String>;

    [Column('MCA_PERCAR', [], 12, 6)]
    FfltPerCar: Nullable<Double>;

    [Column('MCA_VALSTA', [], 12, 2)]
    FfltValSta: Nullable<Double>;

    [Column('MCA_VALTAX', [], 12, 2)]
    FfltValTax: Nullable<Double>;

    [Column('MCA_NUMCCD', [], 20)]
    FstrNumCcd: Nullable<String>;

    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FstrAutoIncrem: String;

    [Column('MCA_DOCUME', [], 50)]
    FstrDocume: Nullable<String>;

    [Column('MCA_FORBTX', [], 8)]
    FstrForBtx: Nullable<String>;

    [Column('MCA_PORDEB', [], 5)]
    FstrPorDeb: Nullable<String>;

    [Column('MCA_SEQCOM', [], 20)]
    FstrSeqCom: Nullable<String>;

    [Column('MCA_CTADEB', [], 7)]
    FstrCtaDeb: Nullable<String>;

    [Column('MCA_RESCAI', [], 11)]
    FintResCai: Nullable<Integer>;

    [Column('MCA_DTATRA')]
    FdteDtaTra: Nullable<TDateTime>;

    [Column('MCA_SEQCON', [], 11)]
    FintSeqCon: Nullable<Integer>;

    [Column('MCA_EMPRCX', [], 3)]
    FstrEmpRcx: Nullable<String>;

    [Column('MCA_CODVEN', [], 3)]
    FstrCodVen: Nullable<String>;

    [Column('MCA_EMP_PD', [], 3)]
    FstrEmp_Pd: Nullable<String>;

    [Column('MCA_SEQTRF', [], 11)]
    FintSeqTrf: Nullable<Integer>;

    [Column('MCA_TIPBAI', [], 1)]
    FstrTipBai: Nullable<String>;

    [Column('MCA_CODFIN', [], 5)]
    FstrCodFin: Nullable<String>;

    [Column('MCA_TIPCAR', [], 3)]
    FstrTipCar: Nullable<String>;

    [Column('MCA_VALACE', [], 12, 2)]
    FfltValAce: Nullable<Double>;

    [Column('MCA_VALFRE', [], 12, 2)]
    FfltValFre: Nullable<Double>;

    [Column('MCA_VALIPI', [], 12, 2)]
    FfltValIPI: Nullable<Double>;

    [Column('MCA_VALRET', [], 12, 2)]
    FfltValRet: Nullable<Double>;

    [Column('MCA_VALCBS', [], 12, 2)]
    FfltValCbs: Nullable<Double>;

    [Column('MCA_VALIBS', [], 12, 2)]
    FfltValIbs: Nullable<Double>;

    [Column('MCA_VAL_IS', [], 12, 2)]
    FfltVal_Is: Nullable<Double>;

    [Column('MCA_NUMNSU', [], 20)]
    FstrNumNSU: Nullable<String>;

    [Column('MCA_CODOPE', [], 3)]
    FstrCodOpe: Nullable<String>;

    [Column('MCA_CTPCOM', [], 9)]
    FstrCtpCom: Nullable<String>;

    [Column('MCA_EXPEQU', [], 13)]
    FstrExpEqu: Nullable<String>;

    [Column('MCA_TAXANT', [], 12, 2)]
    FfltTaxAnt: Nullable<Double>;

    [Column('MCA_VALANT', [], 12, 2)]
    FfltValAnt: Nullable<Double>;

    [Column('MCA_NUMPOK', [], 30)]
    FstrNumPOK: Nullable<String>;

    [Column('MCA_CHACON', [], 70)]
    FstrChaCon: Nullable<String>;

    [Column('MCA_DTABAI')]
    FdtaDtaBai: Nullable<TDateTime>;

    [Column('MCA_DOCDEB', [], 13)]
    FstrDocDeb: Nullable<String>;

    [Column('MCA_DTACUP')]
    FdtaDtaCup: Nullable<TDateTime>;

    [Column('MCA_VLTXGE', [], 12, 2)]
    FfltVlTxGe: Nullable<Double>;

    [Column('MCA_VLTXPC', [], 12, 2)]
    FfltVlTxPc: Nullable<Double>;

    [Column('MCA_EVEDEB', [], 5)]
    FstrEveDeb: Nullable<String>;

    [Column('MCA_CTAANT', [], 7)]
    FstrCtaAnt: Nullable<String>;

    [Column('MCA_DOCANT', [], 13)]
    FstrDocAnt: Nullable<String>;

    [Column('MCA_ANTTAX', [], 12, 2)]
    FfltAntTax: Nullable<Double>;

    [Column('MCA_EVECRE', [], 5)]
    FstrEventoCredito: Nullable<String>;

    [Column('MCA_EVETAX', [], 5)]
    FstrEventoTaxa: Nullable<String>;

    [Column('MCA_CODCAX', [], 5)]
    FstrCodCax: Nullable<String>;

    [Column('MCA_TPPARC', [], 1)]
    FstrTpParc: Nullable<String>;

    [Column('MCA_SEQANT', [], 20)]
    FstrSeqAnt: Nullable<String>;

    [Column('MCA_FREMKT', [], 12, 2)]
    FfltFreMkt: Nullable<Double>;

    [Column('MCA_FREANT', [], 12, 2)]
    FfltFreAnt: Nullable<Double>;

    [Column('MCA_VALAJU', [], 12, 2)]
    FfltValAju: Nullable<Double>;

    [Column('MCA_TRFLIB', [], 1)]
    FstrTrfLib: Nullable<String>;

    [Column('MCA_PORCAR', [], 5)]
    FstrPorCar: Nullable<String>;

    [Column('MCA_CTACAR', [], 7)]
    FstrCtaCar: Nullable<String>;

    [Column('MCA_CUPMKT', [], 12, 2)]
    FfltCupMkt: Nullable<Double>;

    [Column('MCA_CUPANT', [], 12, 2)]
    FfltCupAnt: Nullable<Double>;

    [Column('MCA_BRUANT', [], 12, 2)]
     FfltBruAnt: Nullable<Double>;

    [Column('MCA_DOCFRE', [], 13)]
    FstrDocFre: Nullable<String>;

    [Column('MCA_DOCAJU', [], 13)]
    FstrDocAju: Nullable<String>;

    [Column('MCA_DOCCUP', [], 13)]
    FstrDocCup: Nullable<String>;

  public
    property strNumDup        : String              read FstrNumDup        write FstrNumDup;
    property strCodCli        : String              read FstrCodCli        write FstrCodCli;
    property strParcel        : String              read FstrParcel        write FstrParcel;
    property strCodEmp        : String              read FstrCodEmp        write FstrCodEmp;
    property strCodCar        : String              read FstrCodCar        write FstrCodCar;
    property dteDtaCad        : Nullable<TDateTime> read FdteDtaCad        write FdteDtaCad;
    property dteDtaVen        : Nullable<TDateTime> read FdteDtaVen        write FdteDtaVen;
    property fltValOri        : Nullable<Double>    read FfltValOri        write FfltValOri;
    property fltValDup        : Nullable<Double>    read FfltValDup        write FfltValDup;
    property strHist01        : Nullable<String>    read FstrHist01        write FstrHist01;
    property strHist02        : Nullable<String>    read FstrHist02        write FstrHist02;
    property strConPag        : Nullable<String>    read FstrConPag        write FstrConPag;
    property dteDtaRec        : Nullable<TDateTime> read FdteDtaRec        write FdteDtaRec;
    property fltValRec        : Nullable<Double>    read FfltValRec        write FfltValRec;
    property strOpeBai        : Nullable<String>    read FstrOpeBai        write FstrOpeBai;
    property strHisBai        : Nullable<String>    read FstrHisBai        write FstrHisBai;
    property strPorBai        : Nullable<String>    read FstrPorBai        write FstrPorBai;
    property strCtaBai        : Nullable<String>    read FstrCtaBai        write FstrCtaBai;
    property strDocBan        : Nullable<String>    read FstrDocBan        write FstrDocBan;
    property strPorBtx        : Nullable<String>    read FstrPorBtx        write FstrPorBtx;
    property strCtaBtx        : Nullable<String>    read FstrCtaBtx        write FstrCtaBtx;
    property strDocBtx        : Nullable<String>    read FstrDocBtx        write FstrDocBtx;
    property fltPerCar        : Nullable<Double>    read FfltPerCar        write FfltPerCar;
    property fltValSta        : Nullable<Double>    read FfltValSta        write FfltValSta;
    property fltValTax        : Nullable<Double>    read FfltValTax        write FfltValTax;
    property strNumCcd        : Nullable<String>    read FstrNumCcd        write FstrNumCcd;
    property strAutoIncrem    : String              read FstrAutoIncrem    write FstrAutoIncrem;
    property strDocume        : Nullable<String>    read FstrDocume        write FstrDocume;
    property strForBtx        : Nullable<String>    read FstrForBtx        write FstrForBtx;
    property strPorDeb        : Nullable<String>    read FstrPorDeb        write FstrPorDeb;
    property strSeqCom        : Nullable<String>    read FstrSeqCom        write FstrSeqCom;
    property strCtaDeb        : Nullable<String>    read FstrCtaDeb        write FstrCtaDeb;
    property intResCai        : Nullable<Integer>   read FintResCai        write FintResCai;
    property dteDtaTra        : Nullable<TDateTime> read FdteDtaTra        write FdteDtaTra;
    property intSeqCon        : Nullable<Integer>   read FintSeqCon        write FintSeqCon;
    property strEmpRcx        : Nullable<String>    read FstrEmpRcx        write FstrEmpRcx;
    property strCodVen        : Nullable<String>    read FstrCodVen        write FstrCodVen;
    property strEmp_Pd        : Nullable<String>    read FstrEmp_Pd        write FstrEmp_Pd;
    property intSeqTrf        : Nullable<Integer>   read FintSeqTrf        write FintSeqTrf;
    property strTipBai        : Nullable<String>    read FstrTipBai        write FstrTipBai;
    property strCodFin        : Nullable<String>    read FstrCodFin        write FstrCodFin;
    property strTipCar        : Nullable<String>    read FstrTipCar        write FstrTipCar;
    property fltValAce        : Nullable<Double>    read FfltValAce        write FfltValAce;
    property fltValFre        : Nullable<Double>    read FfltValFre        write FfltValFre;
    property fltValIPI        : Nullable<Double>    read FfltValIPI        write FfltValIPI;
    property fltValRet        : Nullable<Double>    read FfltValRet        write FfltValRet;
    property fltValCbs        : Nullable<Double>    read FfltValCbs        write FfltValCbs;
    property fltValIbs        : Nullable<Double>    read FfltValIbs        write FfltValIbs;
    property fltVal_Is        : Nullable<Double>    read FfltVal_Is        write FfltVal_Is;
    property strNumNSU        : Nullable<String>    read FstrNumNSU        write FstrNumNSU;
    property strCodOpe        : Nullable<String>    read FstrCodOpe        write FstrCodOpe;
    property strCtpCom        : Nullable<String>    read FstrCtpCom        write FstrCtpCom;
    property strExpEqu        : Nullable<String>    read FstrExpEqu        write FstrExpEqu;
    property fltTaxAnt        : Nullable<Double>    read FfltTaxAnt        write FfltTaxAnt;
    property fltValAnt        : Nullable<Double>    read FfltValAnt        write FfltValAnt;
    property strNumPOK        : Nullable<String>    read FstrNumPOK        write FstrNumPOK;
    property strChaCon        : Nullable<String>    read FstrChaCon        write FstrChaCon;
    property dtaDtaBai        : Nullable<TDateTime> read FdtaDtaBai        write FdtaDtaBai;
    property strDocDeb        : Nullable<String>    read FstrDocDeb        write FstrDocDeb;
    property dtaDtaCup        : Nullable<TDateTime> read FdtaDtaCup        write FdtaDtaCup;
    property fltVlTxGe        : Nullable<Double>    read FfltVlTxGe        write FfltVlTxGe;
    property fltVlTxPc        : Nullable<Double>    read FfltVlTxPc        write FfltVlTxPc;
    property strEveDeb        : Nullable<String>    read FstrEveDeb        write FstrEveDeb;
    property strCtaAnt        : Nullable<String>    read FstrCtaAnt        write FstrCtaAnt;
    property strDocAnt        : Nullable<String>    read FstrDocAnt        write FstrDocAnt;
    property fltAntTax        : Nullable<Double>    read FfltAntTax        write FfltAntTax;
    property strEventoCredito : Nullable<String>    read FstrEventoCredito write FstrEventoCredito;
    property strEventoTaxa    : Nullable<String>    read FstrEventoTaxa    write FstrEventoTaxa;
    property strCodCax        : Nullable<String>    read FstrCodCax        write FstrCodCax;
    property strTpParc        : Nullable<String>    read FstrTpParc        write FstrTpParc;
    property strSeqAnt        : Nullable<String>    read FstrSeqAnt        write FstrSeqAnt;
    property fltFreMkt        : Nullable<Double>    read FfltFreMkt        write FfltFreMkt;
    property fltFreAnt        : Nullable<Double>    read FfltFreAnt        write FfltFreAnt;
    property fltValAju        : Nullable<Double>    read FfltValAju        write FfltValAju;
    property strTrfLib        : Nullable<String>    read FstrTrfLib        write FstrTrfLib;
    property strPorCar        : Nullable<String>    read FstrPorCar        write FstrPorCar;
    property strCtaCar        : Nullable<String>    read FstrCtaCar        write FstrCtaCar;
    property fltCupMkt        : Nullable<Double>    read FfltCupMkt        write FfltCupMkt;
    property fltCupAnt        : Nullable<Double>    read FfltCupAnt        write FfltCupAnt;
    property fltBruAnt        : Nullable<Double>    read FfltBruAnt        write FfltBruAnt;
    property strDocFre        : Nullable<String>    read FstrDocFre        write FstrDocFre;
    property strDocAju        : Nullable<String>    read FstrDocAju        write FstrDocAju;
    property strDocCup        : Nullable<String>    read FstrDocCup        write FstrDocCup;
  end;

  [Entity]
  [Table('LOGMCA')]
  [Id('FstrAutoIncrem', TIdGenerator.None)]
  TLogMca = Class(TMovCar)
  private
    [Column('MCA_NOMFRM')]
    FNomFrm : string;
    [Column('MCA_DESCRI')]
    FDescri: string;
    [Column('MCA_DTALOG')]
    FDtaLog: TDate;
    [Column('MCA_HORLOG')]
    FHorLog: TTime;
    [Column('MCA_OPELOG')]
    FOpeLog: String;
    [Column('MCA_NOMTAB')]
    FNomTab: String;
    [Column('MCA_NOMEXE')]
    FNomeExecutavel : String;
    [Column('MCA_DTAEXE')]
    FDataExecutavel : TDate;
    [Column('MCA_HOREXE')]
    FHoraExecutavel: TTime;
    [Column('MCA_VEREXE')]
    FVersaoExecutavel : String;
  public
    property strNomFrm       : string Read FNomFrm           Write FNomFrm;
    property strDescri       : string Read FDescri           Write FDescri;
    property dtaDtaLog       : TDate  Read FDtaLog           Write FDtaLog;
    property dtaHorLog       : TTime  Read FHorLog           Write FHorLog;
    property strOpeLog       : String Read FOpeLog           Write FOpeLog;
    property strNomTab       : String Read FNomTab           Write FNomTab;
    property NomeExecutavel  : String Read FNomeExecutavel   Write FNomeExecutavel;
    property DataExecutavel  : TDate  Read FDataExecutavel   Write FDataExecutavel;
    property HoraExecutavel  : TTime  Read FHoraExecutavel   Write FHoraExecutavel;
    property VersaoExecutavel: String Read FVersaoExecutavel Write FVersaoExecutavel;
  End;

  [Entity]
  [Table('DEL_MOVCAR')]
  [UniqueKey('MCA_NUMDUP, MCA_CODCLI, MCA_PARCEL, MCA_CODEMP')]
  [Id('FstrAutoIncrem', TIdGenerator.None)]
  TDelMovCar = Class(TMovCar)
  private
    [Column('OPEDEL')]
    FOpeDel: String;
    [Column('DTADEL')]
    FDtaDel: TDate;
    [Column('HORDEL')]
    FHorDel: TTime;
  public
    property strOpeDel: String Read FOpeDel Write FOpeDel;
    property dtaDtaDel: TDate  Read FDtaDel Write FDtaDel;
    property hraHorDel: TTime  Read FHorDel Write FHorDel;
  End;

implementation

end.
