unit untTCadRcxx;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy,
  Classes;

type
  [Entity]
  [Table('CADRCXX')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadRcxx = Class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;
    
    [Column('RCX_CODCLI', [], 8)]
    FRCX_CODCLI: Nullable<string>;
    
    [Column('RCX_CODOPE', [], 3)]
    FRCX_CODOPE: Nullable<string>;
    
    [Column('RCX_NUMDOC', [], 12)]
    FRCX_NUMDOC: Nullable<string>;
    
    [Column('RCX_ESPDOC', [], 2)]
    FRCX_ESPDOC: Nullable<string>;
    
    [Column('RCX_CODEMP', [TColumnProp.Required], 3)]
    FRCX_CODEMP: string;
    
    [Column('RCX_DTACAD', [TColumnProp.Required])]
    FRCX_DTACAD: TDateTime;
    
    [Column('RCX_HORCAD', [TColumnProp.Required])]
    FRCX_HORCAD: TDateTime;
    
    [Column('RCX_NUMDUP', [], 12)]
    FRCX_NUMDUP: Nullable<string>;
    
    [Column('RCX_PARCEL', [], 3)]
    FRCX_PARCEL: Nullable<string>;
    
    [Column('RCX_DESCRI', [], 100)]
    FRCX_DESCRI: Nullable<string>;
    
    [Column('RCX_IDEFEC', [], 1)]
    FRCX_IDEFEC: Nullable<string>;
    
    [Column('RCX_VALDOC', [], 12, 2)]
    FRCX_VALDOC: Nullable<double>;

    [Column('RCX_VALDES', [], 12, 2)]
    FRCX_VALDES: Nullable<double>;
    
    [Column('RCX_VALJUR', [], 12, 2)]
    FRCX_VALJUR: Nullable<double>;
    
    [Column('RCX_DINREC', [], 12, 2)]
    FRCX_DINREC: Nullable<double>;
    
    [Column('RCX_CHQAVI', [], 12, 2)]
    FRCX_CHQAVI: Nullable<double>;
    
    [Column('RCX_CHQPRE', [], 12, 2)]
    FRCX_CHQPRE: Nullable<double>;
    
    [Column('RCX_CARREC', [], 12, 2)]
    FRCX_CARREC: Nullable<double>;
    
    [Column('RCX_VALCRE', [], 12, 2)]
    FRCX_VALCRE: Nullable<double>;
    
    [Column('RCX_OUTROS', [], 12, 2)]
    FRCX_OUTROS: Nullable<double>;
    
    [Column('RCX_VENPRZ', [], 12, 2)]
    FRCX_VENPRZ: Nullable<double>;
    
    [Column('RCX_JURDES', [], 1)]
    FRCX_JURDES: Nullable<string>;
    
    [Column('RCX_CODFPG', [], 3)]
    FRCX_CODFPG: Nullable<string>;
    
    [Column('RCX_NUMROM', [], 6)]
    FRCX_NUMROM: Nullable<string>;

    [Column('RCX_RCXTCC', [], 1)]
    FRCX_RCXTCC: Nullable<string>;

    [Column('RCX_SEQCON', [])]
    FRCX_SEQCON: Nullable<integer>;
    
    [Column('RCX_ORDREC', [], 12, 2)]
    FRCX_ORDREC: Nullable<double>;
    
    [Column('RCX_SEQBAI', [])]
    FRCX_SEQBAI: Nullable<integer>;
    
    [Column('RCX_SQFCRX', [])]
    FRCX_SQFCRX: Nullable<integer>;
    
    [Column('RCX_MOTDES', [TColumnProp.Lazy])]
    FRCX_MOTDES: TBlob;
    
    [Column('RCX_EMPDUP', [], 3)]
    FRCX_EMPDUP: Nullable<string>;
    
    [Column('RCX_IDECAI', [], 1)]
    FRCX_IDECAI: Nullable<string>;
    
    [Column('RCX_VALFIN', [], 12, 2)]
    FRCX_VALFIN: Nullable<double>;
    
    [Column('RCX_TOTPES', [], 12, 2)]
    FRCX_TOTPES: Nullable<double>;
    
    [Column('RCX_TOTDOL', [], 12, 2)]
    FRCX_TOTDOL: Nullable<double>;
    
    [Column('RCX_TOTEUR', [], 12, 2)]
    FRCX_TOTEUR: Nullable<double>;
    
    [Column('RCX_TOTGUA', [], 12, 2)]
    FRCX_TOTGUA: Nullable<double>;

    [Column('RCX_TOTREA', [], 12, 2)]
    FRCX_TOTREA: Nullable<double>;

    [Column('RCX_TFCANC', [], 1)]
    FRCX_TFCANC: Nullable<string>;

    [Column('RCX_ID_LOC', [], 20)]
    FRCX_ID_LOC: Nullable<string>;

    [Column('RCX_ID_DOC', [], 6)]
    FRCX_ID_DOC: Nullable<string>;

    [Column('RCX_MOTEST', [])]
    FRCX_MOTEST: Nullable<string>;

    [Column('RCX_CODCAX', [])]
    FRCX_CODCAX: Nullable<string>;

    [Column('RCX_DTAGRV', [])]
    FRCX_DTAGRV: Nullable<TDateTime>;

    [Column('RCX_LANFEC', [])]
    FRCX_LANFEC: Nullable<string>;

    [Column('RCX_NUMLAC', [])]
    FRCX_NUMLAC: Nullable<string>;

    [Column('RCX_FUNCAX', [], 12, 2)]
    FRCX_FUNCAX: Nullable<double>;

    [Column('RCX_FECDIV', [])]
    FRCX_FECDIV: Nullable<string>;

    [Column('RCX_OPEPER', [])]
    FRCX_OPEPER: Nullable<string>;

    [Column('RCX_OPELIB', [])]
    FRCX_OPELIB: Nullable<string>;

    [Column('RCX_DTAPER', [])]
    FRCX_DTAPER: Nullable<TDateTime>;

    [Column('RCX_DTALIB', [])]
    FRCX_DTALIB: Nullable<TDateTime>;

    [Column('RCX_VALDIV', [], 12, 2)]
    FRCX_VALDIV: Nullable<double>;

    [Column('RCX_RECPIX', [], 1)]
    FRCX_RECPIX: Nullable<string>;
  public
    Constructor Create;

    property strAutInc: string            read FAUTOINCREM write FAUTOINCREM;
    property strCodCli: Nullable<string>  read FRCX_CODCLI write FRCX_CODCLI;
    property strCodOpe: Nullable<string>  read FRCX_CODOPE write FRCX_CODOPE;
    property strNumDoc: Nullable<string>  read FRCX_NUMDOC write FRCX_NUMDOC;
    property strEspDoc: Nullable<string>  read FRCX_ESPDOC write FRCX_ESPDOC;
    property strCodEmp: string            read FRCX_CODEMP write FRCX_CODEMP;
    property dtaDtaCad: TDateTime         read FRCX_DTACAD write FRCX_DTACAD;
    property dtaHorCad: TDateTime         read FRCX_HORCAD write FRCX_HORCAD;
    property strNumDup: Nullable<string>  read FRCX_NUMDUP write FRCX_NUMDUP;
    property strParcel: Nullable<string>  read FRCX_PARCEL write FRCX_PARCEL;
    property strDescri: Nullable<string>  read FRCX_DESCRI write FRCX_DESCRI;
    property strIdeFec: Nullable<string>  read FRCX_IDEFEC write FRCX_IDEFEC;
    property fltValDoc: Nullable<double>  read FRCX_VALDOC write FRCX_VALDOC;
    property fltValDes: Nullable<double>  read FRCX_VALDES write FRCX_VALDES;
    property fltValJur: Nullable<double>  read FRCX_VALJUR write FRCX_VALJUR;
    property fltDinRec: Nullable<double>  read FRCX_DINREC write FRCX_DINREC;
    property fltChqAvi: Nullable<double>  read FRCX_CHQAVI write FRCX_CHQAVI;
    property fltChqPre: Nullable<double>  read FRCX_CHQPRE write FRCX_CHQPRE;
    property fltCarRec: Nullable<double>  read FRCX_CARREC write FRCX_CARREC;
    property fltValCre: Nullable<double>  read FRCX_VALCRE write FRCX_VALCRE;
    property fltOutros: Nullable<double>  read FRCX_OUTROS write FRCX_OUTROS;
    property fltVenPrz: Nullable<double>  read FRCX_VENPRZ write FRCX_VENPRZ;
    property strJurDes: Nullable<string>  read FRCX_JURDES write FRCX_JURDES;
    property strCodFpg: Nullable<string>  read FRCX_CODFPG write FRCX_CODFPG;
    property strNumRom: Nullable<string>  read FRCX_NUMROM write FRCX_NUMROM;
    property strRcxTcc: Nullable<string>  read FRCX_RCXTCC write FRCX_RCXTCC;
    property intSeqCon: Nullable<integer> read FRCX_SEQCON write FRCX_SEQCON;
    property fltOrdRec: Nullable<double>  read FRCX_ORDREC write FRCX_ORDREC;
    property intSeqBai: Nullable<integer> read FRCX_SEQBAI write FRCX_SEQBAI;
    property intSqFcRx: Nullable<integer> read FRCX_SQFCRX write FRCX_SQFCRX;
    property txtMotDes: TBlob             read FRCX_MOTDES write FRCX_MOTDES;
    property strEmpDup: Nullable<string>  read FRCX_EMPDUP write FRCX_EMPDUP;
    property strIdeCai: Nullable<string>  read FRCX_IDECAI write FRCX_IDECAI;
    property fltValFin: Nullable<double>  read FRCX_VALFIN write FRCX_VALFIN;
    property fltTotPes: Nullable<double>  read FRCX_TOTPES write FRCX_TOTPES;
    property fltTotDol: Nullable<double>  read FRCX_TOTDOL write FRCX_TOTDOL;
    property fltTotEur: Nullable<double>  read FRCX_TOTEUR write FRCX_TOTEUR;
    property fltTotGua: Nullable<double>  read FRCX_TOTGUA write FRCX_TOTGUA;
    property fltTotRea: Nullable<double>  read FRCX_TOTREA write FRCX_TOTREA;
    property strTFCanc: Nullable<string>  read FRCX_TFCANC write FRCX_TFCANC;
    property strID_LOC: Nullable<string>  read FRCX_ID_LOC write FRCX_ID_LOC;
    property strID_DOC: Nullable<string>  read FRCX_ID_DOC write FRCX_ID_DOC;
    property strMotEst: Nullable<string>  read FRCX_MOTEST write FRCX_MOTEST;
    property strCodCax: Nullable<string>  read FRCX_CODCAX write FRCX_CODCAX;
    property strLanFec: Nullable<string>  read FRCX_LANFEC write FRCX_LANFEC;
    property strNumLac: Nullable<string>  read FRCX_NUMLAC write FRCX_NUMLAC;
    property fltFunCax: Nullable<double>  read FRCX_FUNCAX write FRCX_FUNCAX;
    property strFecDiv: Nullable<string>  read FRCX_FECDIV write FRCX_FECDIV;
    property strOpePer: Nullable<string>  read FRCX_OPEPER write FRCX_OPEPER;
    property strOpeLib: Nullable<string>  read FRCX_OPELIB write FRCX_OPELIB;
    property fltValDiv: Nullable<double>  read FRCX_VALDIV write FRCX_VALDIV;
    property strRecPix: Nullable<string>  read FRCX_RECPIX write FRCX_RECPIX;

    property dtaDtaGrv: Nullable<TDateTime> read FRCX_DTAGRV write FRCX_DTAGRV;
    property dtaDtaPer: Nullable<TDateTime> read FRCX_DTAPER write FRCX_DTAPER;
    property dtaDtaLib: Nullable<TDateTime> read FRCX_DTALIB write FRCX_DTALIB;
  end;

implementation

{ TCadRcxx }

constructor TCadRcxx.Create;
begin
  FRCX_VALDOC := 0;
  FRCX_VALDES := 0;
  FRCX_VALJUR := 0;
  FRCX_DINREC := 0;
  FRCX_CHQAVI := 0;
  FRCX_CHQPRE := 0;
  FRCX_CARREC := 0;
  FRCX_VALCRE := 0;
  FRCX_OUTROS := 0;
  FRCX_VENPRZ := 0;
  FRCX_ORDREC := 0;
  FRCX_VALFIN := 0;
  FRCX_SEQBAI := 0;
  FRCX_TOTPES := 0;
  FRCX_TOTDOL := 0;
  FRCX_TOTEUR := 0;
  FRCX_TOTGUA := 0;
  FRCX_TOTREA := 0;
  FRCX_TFCANC := 'N';
  FRCX_FUNCAX := 0;
  FRCX_VALDIV := 0;
  FRCX_FECDIV := 'N';
  FRCX_RECPIX := 'N';
end;

end.
