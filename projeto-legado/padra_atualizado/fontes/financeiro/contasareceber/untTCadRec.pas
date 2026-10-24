unit untTCadRec;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy,
  untTCadCli;

type
  [Entity]
  [Table('CADREC')]
  [UniqueKey('CTR_NUMDUP, CTR_ESPDOC, CTR_CODCLI, CTR_CODEMP')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadRec = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('CTR_CODCLI', [], 'CLI_CODCLI')]
    FCodCli : Proxy<TCadCli>;

    [Column('CTR_NUMDUP', [TColumnProp.Required], 12)]
    FCTR_NUMDUP: string;

    [Column('CTR_PARCEL', [TColumnProp.Required], 3)]
    FCTR_PARCEL: string;

    [Column('CTR_SEQBAI', [TColumnProp.Required])]
    FCTR_SEQBAI: integer;

    [Column('CTR_ESPDOC', [TColumnProp.Required], 2)]
    FCTR_ESPDOC: string;

    [Column('CTR_CODEMP', [TColumnProp.Required], 3)]
    FCTR_CODEMP: string;
    
    [Column('CTR_CODVEN', [], 3)]
    FCTR_CODVEN: Nullable<string>;
    
    [Column('CTR_CODDIG', [], 3)]
    FCTR_CODDIG: Nullable<string>;
    
    [Column('CTR_CODPOR', [], 5)]
    FCTR_CODPOR: Nullable<string>;
    
    [Column('CTR_DTACAD', [TColumnProp.Required])]
    FCTR_DTACAD: TDateTime;

    [Column('CTR_DTAVEN', [TColumnProp.Required])]
    FCTR_DTAVEN: TDateTime;
    
    [Column('CTR_VALDUP', [], 12, 2)]
    FCTR_VALDUP: Nullable<double>;
    
    [Column('CTR_VALORI', [], 12, 2)]
    FCTR_VALORI: Nullable<double>;
    
    [Column('CTR_DESCOB', [], 12, 2)]
    FCTR_DESCOB: Nullable<double>;
    
    [Column('CTR_DESCON', [], 1)]
    FCTR_DESCON: Nullable<string>;
    
    [Column('CTR_HIST01')]
    FCTR_HIST01: Nullable<String>;

    [Column('CTR_HIST02', [], 50)]
    FCTR_HIST02: Nullable<string>;
    
    [Column('CTR_PORBAI', [], 5)]
    FCTR_PORBAI: Nullable<string>;
    
    [Column('CTR_HISBAI', [], 50)]
    FCTR_HISBAI: Nullable<string>;
    
    [Column('CTR_CTABAI', [], 7)]
    FCTR_CTABAI: Nullable<string>;
    
    [Column('CTR_DOCBAI', [], 13)]
    FCTR_DOCBAI: Nullable<string>;
    
    [Column('CTR_OPEBAI', [], 3)]
    FCTR_OPEBAI: Nullable<string>;
    
    [Column('CTR_DTAREC', [])]
    FCTR_DTAREC: Nullable<TDateTime>;
    
    [Column('CTR_VALREC', [], 12, 2)]
    FCTR_VALREC: Nullable<double>;
    
    [Column('CTR_VALJUR', [], 12, 2)]
    FCTR_VALJUR: Nullable<double>;
    
    [Column('CTR_VALCOB', [], 12, 2)]
    FCTR_VALCOB: Nullable<double>;

    [Column('CTR_VALDES', [], 12, 2)]
    FCTR_VALDES: Nullable<double>;
    
    [Column('CTR_RESCAI', [])]
    FCTR_RESCAI: Nullable<integer>;
    
    [Column('CTR_NOSNUM', [], 12)]
    FCTR_NOSNUM: Nullable<string>;
    
    [Column('CTR_DTABOL', [])]
    FCTR_DTABOL: Nullable<TDateTime>;
    
    [Column('CTR_BCOBOL', [], 3)]
    FCTR_BCOBOL: Nullable<string>;
    
    [Column('CTR_BCOENV', [], 3)]
    FCTR_BCOENV: Nullable<string>;
    
    [Column('CTR_DTAENV', [])]
    FCTR_DTAENV: Nullable<TDateTime>;
    
    [Column('CTR_OBSAG1', [], 120)]
    FCTR_OBSAG1: Nullable<string>;

    [Column('CTR_OBSAG2', [], 120)]
    FCTR_OBSAG2: Nullable<string>;

    [Column('CTR_OBSAG3', [], 120)]
    FCTR_OBSAG3: Nullable<string>;
    
    [Column('CTR_DTABAI', [])]
    FCTR_DTABAI: Nullable<TDateTime>;
    
    [Column('CTR_CODEVE', [], 5)]
    FCTR_CODEVE: Nullable<string>;
    
    [Column('CTR_CODVEL', [], 20)]
    FCTR_CODVEL: Nullable<string>;
    
    [Column('CTR_DINHEI', [], 12, 2)]
    FCTR_DINHEI: Nullable<double>;
    
    [Column('CTR_CHQAVI', [], 12, 2)]
    FCTR_CHQAVI: Nullable<double>;
    
    [Column('CTR_CHQPRE', [], 12, 2)]
    FCTR_CHQPRE: Nullable<double>;
    
    [Column('CTR_CARTAO', [], 12, 2)]
    FCTR_CARTAO: Nullable<double>;
    
    [Column('CTR_SEQMOD', [])]
    FCTR_SEQMOD: Nullable<integer>;
    
    [Column('CTR_TIPFOR', [], 10)]
    FCTR_TIPFOR: Nullable<string>;
    
    [Column('CTR_CODCND', [], 3)]
    FCTR_CODCND: Nullable<string>;
    
    [Column('CTR_CONAPR', [])]
    FCTR_CONAPR: Nullable<integer>;
    
    [Column('CTR_RECDIN', [], 1)]
    FCTR_RECDIN: Nullable<string>;
    
    [Column('CTR_RECCHE', [], 1)]
    FCTR_RECCHE: Nullable<string>;
    
    [Column('CTR_RECPRE', [], 1)]
    FCTR_RECPRE: Nullable<string>;
    
    [Column('CTR_RECCAR', [], 1)]
    FCTR_RECCAR: Nullable<string>;
    
    [Column('CTR_CODCTA', [], 7)]
    FCTR_CODCTA: Nullable<string>;
    
    [Column('CTR_CTASER', [], 7)]
    FCTR_CTASER: Nullable<string>;
    
    [Column('CTR_SERVAL', [], 12, 2)]
    FCTR_SERVAL: Nullable<double>;
    
    [Column('CTR_ORDPAG', [], 12, 2)]
    FCTR_ORDPAG: Nullable<double>;
    
    [Column('CTR_RECORD', [], 1)]
    FCTR_RECORD: Nullable<string>;
    
    [Column('CTR_VALCOM', [], 12, 2)]
    FCTR_VALCOM: Nullable<double>;
    
    [Column('CTR_FATCOM', [], 12, 8)]
    FCTR_FATCOM: Nullable<double>;
    
    [Column('CTR_EMPBAI', [], 3)]
    FCTR_EMPBAI: Nullable<string>;

    [Column('CTR_DTASER', [])]
    FCTR_DTASER: Nullable<TDateTime>;
    
    [Column('CTR_VALIPI', [], 12, 2)]
    FCTR_VALIPI: Nullable<double>;
    
    [Column('CTR_VALRET', [], 12, 2)]
    FCTR_VALRET: Nullable<double>;

    [Column('CTR_VALCBS', [], 12, 2)]
    FCTR_VALCBS: Nullable<double>;

    [Column('CTR_VALIBS', [], 12, 2)]
    FCTR_VALIBS: Nullable<double>;

    [Column('CTR_VAL_IS', [], 12, 2)]
    FCTR_VAL_IS: Nullable<double>;
    
    [Column('CTR_DOCDIV', [], 12)]
    FCTR_DOCDIV: Nullable<string>;
    
    [Column('CTR_ESPDIV', [], 2)]
    FCTR_ESPDIV: Nullable<string>;
    
    [Column('CTR_EMPDIV', [], 3)]
    FCTR_EMPDIV: Nullable<string>;
    
    [Column('CTR_CLIDIV', [], 8)]
    FCTR_CLIDIV: Nullable<string>;
    
    [Column('CTR_JURSUJ', [], 12, 2)]
    FCTR_JURSUJ: Nullable<double>;
    
    [Column('CTR_JURANT', [], 12, 2)]
    FCTR_JURANT: Nullable<double>;
    
    [Column('CTR_DESSUJ', [], 12, 2)]
    FCTR_DESSUJ: Nullable<double>;
    
    [Column('CTR_DESANT', [], 12, 2)]
    FCTR_DESANT: Nullable<double>;
    
    [Column('CTR_SEQCON', [])]
    FCTR_SEQCON: Nullable<integer>;
    
    [Column('CTR_QTDDAV', [])]
    FCTR_QTDDAV: Nullable<integer>;
    
    [Column('CTR_PERDPO', [], 12, 2)]
    FCTR_PERDPO: Nullable<double>;
    
    [Column('CTR_CODREP', [], 3)]
    FCTR_CODREP: Nullable<string>;
    
    [Column('CTR_COMREP', [], 5, 2)]
    FCTR_COMREP: Nullable<double>;
    
    [Column('CTR_FATREP', [], 12, 8)]
    FCTR_FATREP: Nullable<double>;
    
    [Column('CTR_VALANT', [], 12, 2)]
    FCTR_VALANT: Nullable<double>;
    
    [Column('CTR_ORIF11', [], 1)]
    FCTR_ORIF11: Nullable<string>;
    
    [Column('CTR_VALFIN', [], 12, 2)]
    FCTR_VALFIN: Nullable<double>;
    
    [Column('CTR_RECFIN', [], 1)]
    FCTR_RECFIN: Nullable<string>;
    
    [Column('CTR_EMP_PD', [], 3)]
    FCTR_EMP_PD: Nullable<string>;
    
    [Column('CTR_NOMFRM', [], 70)]
    FCTR_NOMFRM: Nullable<string>;
    
    [Column('CTR_VRTRDV', [], 12, 2)]
    FCTR_VRTRDV: Nullable<double>;
    
    [Column('CTR_BARCON', [], 13)]
    FCTR_BARCON: Nullable<string>;
    
    [Column('CTR_COMDIV', [], 12, 2)]
    FCTR_COMDIV: Nullable<double>;
    
    [Column('CTR_FATDIV', [], 12, 2)]
    FCTR_FATDIV: Nullable<double>;
    
    [Column('CTR_CODDIV', [], 8)]
    FCTR_CODDIV: Nullable<string>;
    
    [Column('CTR_PROTES', [], 20)]
    FCTR_PROTES: Nullable<string>;
    
    [Column('CTR_CTREME', [], 10)]
    FCTR_CTREME: Nullable<string>;
    
    [Column('CTR_DTAPFI', [])]
    FCTR_DTAPFI: Nullable<TDateTime>;
    
    [Column('CTR_MOTBAI', [], 2)]
    FCTR_MOTBAI: Nullable<string>;
    
    [Column('CTR_VALFRE', [], 12, 2)]
    FCTR_VALFRE: Nullable<double>;
    
    [Column('CTR_CTPCOM', [], 9)]
    FCTR_CTPCOM: Nullable<string>;
    
    [Column('CTR_VALACE', [], 12, 2)]
    FCTR_VALACE: Nullable<double>;
    
    [Column('CTR_DIFORI', [], 12, 2)]
    FCTR_DIFORI: Nullable<double>;
    
    [Column('CTR_ID_LOC', [], 20)]
    FCTR_ID_LOC: Nullable<string>;
    
    [Column('CTR_ID_DOC', [], 6)]
    FCTR_ID_DOC: Nullable<string>;
    
    [Column('CTR_CODPA1', [], 3)]
    FCTR_CODPA1: Nullable<string>;
    
    [Column('CTR_CODPA2', [], 3)]
    FCTR_CODPA2: Nullable<string>;
    
    [Column('CTR_CODPJ1', [], 3)]
    FCTR_CODPJ1: Nullable<string>;
    
    [Column('CTR_CODPJ2', [], 3)]
    FCTR_CODPJ2: Nullable<string>;
    
    [Column('CTR_FATPA1', [], 12, 8)]
    FCTR_FATPA1: Nullable<double>;
    
    [Column('CTR_FATPA2', [], 12, 8)]
    FCTR_FATPA2: Nullable<double>;
    
    [Column('CTR_FATPJ1', [], 12, 8)]
    FCTR_FATPJ1: Nullable<double>;
    
    [Column('CTR_FATPJ2', [], 12, 8)]
    FCTR_FATPJ2: Nullable<double>;
    
    [Column('CTR_CARTEI', [], 30)]
    FCTR_CARTEI: Nullable<string>;
    
    [Column('CTR_JUSDES', [], 50)]
    FCTR_JUSDES: Nullable<string>;
    
    [Column('CTR_RECAUT', [], 1)]
    FCTR_RECAUT: Nullable<string>;

    [Column('CTR_PERMOR', [], 12, 2)]
    FCTR_PERMOR: Nullable<double>;

    [Column('CTR_PERMUL', [], 12, 2)]
    FCTR_PERMUL: Nullable<double>;

    [Column('CTR_BCOCRR', [], 3)]
    FCTR_BCOCRR: Nullable<string>;

    [Column('CTR_NN_CRR', [], 13)]
    FCTR_NN_CRR: Nullable<string>;

    [Column('CTR_GRVORI', [], 12, 2)]
    FCTR_GRVORI: Nullable<double>;

    [Column('CTR_ADTCLI', [], 1)]
    FCTR_ADTCLI: Nullable<string>;

    [Column('CTR_AUTCTP', [], 20)]
    FCTR_AUTCTP: Nullable<string>;

    [Column('CTR_LINDIG', [], 100)]
    FCTR_LINDIG: Nullable<string>;

    [Column('CTR_COBANT', [], 12, 2)]
    FCTR_COBANT: Nullable<double>;

    [Column('CTR_CODCED', [], 60)]
    FCTR_CODCED: Nullable<string>;

    [Column('CTR_DTABOA', [])]
    FCTR_DTABOA: Nullable<TDateTime>;

    [Column('CTR_DTABO2', [])]
    FCTR_DTABO2: Nullable<TDateTime>;

    [Column('CTR_BOAEXC', [])]
    FCTR_BOAEXC: Nullable<TDateTime>;

    [Column('CTR_MOVDES', [], 13)]
    FCTR_MOVDES: Nullable<string>;

    [Column('CTR_DTAEMA', [])]
    FCTR_DTAEMA: Nullable<TDateTime>;

    [Column('CTR_CTPTXE', [], 20)]
    FCTR_CTPTXE: Nullable<string>;

    [Column('CTR_EMPORI', [], 3)]
    FCTR_EMPORI: Nullable<string>;

    [Column('CTR_JURBAI', [], 12, 2)]
    FCTR_JURBAI: Nullable<double>;

    [Column('CTR_DESBAI', [], 12, 2)]
    FCTR_DESBAI: Nullable<double>;

    [Column('CTR_AMORTI', [], 12, 2)]
    FCTR_AMORTI: Nullable<double>;

    [Column('CTR_VALCOR', [], 12, 2)]
    FCTR_VALCOR: Nullable<double>;

    [Column('CTR_DTASPC', [])]
    FCTR_DTASPC: Nullable<TDateTime>;

    [Column('CTR_STSSPC', [], 1)]
    FCTR_STSSPC: Nullable<string>;

    [Column('CTR_DTABAN', [])]
    FCTR_DTABAN: Nullable<TDateTime>;

    [Column('CTR_DTASMS', [])]
    FCTR_DTASMS: Nullable<TDateTime>;

    [Column('CTR_RECPIX', [], 1)]
    FCTR_RECPIX: Nullable<string>;

    [Column('CTR_EMPPIX', [], 3)]
    FCTR_EMPPIX: Nullable<string>;

    [Column('CTR_TX_PIX', [], 50)]
    FCTR_TX_PIX: Nullable<string>;

    [Column('CTR_PIXTIP', [], 1)]
    FCTR_PIXTIP: Nullable<string>;

    [Column('CTR_PIXREC', [], 12, 2)]
    FCTR_PIXREC: Nullable<double>;

    [Column('CTR_PIXJUR', [], 12, 2)]
    FCTR_PIXJUR: Nullable<double>;

    [Column('CTR_PIXDES', [], 12, 2)]
    FCTR_PIXDES: Nullable<double>;

    [Column('CTR_PIXCOB', [], 12, 2)]
    FCTR_PIXCOB: Nullable<double>;

    [Column('CTR_PIXCOR', [], 12, 2)]
    FCTR_PIXCOR: Nullable<double>;

    [Column('CTR_DTAWPP', [])]
    FCTR_DTAWPP: Nullable<TDateTime>;

    [Column('CTR_VALCAL', [], 12, 2)]
    FCTR_VALCAL: Nullable<double>;

    [Column('CTR_JURCAL', [], 15, 2)]
    FCTR_JURCAL: Nullable<double>;

    [Column('CTR_FATDUP', [], 8, 7)]
    FCTR_FATDUP: Nullable<double>;

    [Column('CTR_FATJUR', [], 8, 7)]
    FCTR_FATJUR: Nullable<double>;

    [Column('CTR_NOVBAI', [], 1)]
    FCTR_NOVBAI: Nullable<string>;

    [Column('CTR_DESCAL', [], 15, 2)]
    FCTR_DESCAL: Nullable<double>;

    [Column('CTR_SEQMPX', [], 20)]
    FCTR_SEQMPX: Nullable<string>;

    [Column('CTR_PERALP', [], 12, 2)]
    FCTR_PERALP: Nullable<double>;

    [Column('CTR_TARTED', [], 12, 2)]
    FCTR_TARTED: Nullable<double>;

    [Column('CTR_DTAALP', [])]
    FCTR_DTAALP: Nullable<TDateTime>;

    [Column('CTR_QRCODE', [])]
    FCTR_QRCODE: Nullable<string>;

    [Column('CTR_TX_BOL', [], 50)]
    FCTR_TX_BOL: Nullable<string>;

    [Column('CTR_END_ID', [], 50)]
    FCTR_END_ID: Nullable<string>;

    [Column('CTR_LNKCIT', [], 60)]
    FCTR_LNKCIT: Nullable<string>;

    function getCodCli : TCadCli;

    procedure setCodCli(const Value: TCadCli);
  public
    property CTR_NUMDUP: string              read FCTR_NUMDUP write FCTR_NUMDUP;
    property CTR_PARCEL: string              read FCTR_PARCEL write FCTR_PARCEL;
    property CTR_SEQBAI: integer             read FCTR_SEQBAI write FCTR_SEQBAI;
    property CTR_ESPDOC: string              read FCTR_ESPDOC write FCTR_ESPDOC;
    property CTR_CODEMP: string              read FCTR_CODEMP write FCTR_CODEMP;
    property CTR_CODVEN: Nullable<string>    read FCTR_CODVEN write FCTR_CODVEN;
    property CTR_CODDIG: Nullable<string>    read FCTR_CODDIG write FCTR_CODDIG;
    property CTR_CODPOR: Nullable<string>    read FCTR_CODPOR write FCTR_CODPOR;
    property CTR_DTACAD: TDateTime           read FCTR_DTACAD write FCTR_DTACAD;
    property CTR_DTAVEN: TDateTime           read FCTR_DTAVEN write FCTR_DTAVEN;
    property CTR_VALDUP: Nullable<double>    read FCTR_VALDUP write FCTR_VALDUP;
    property CTR_VALORI: Nullable<double>    read FCTR_VALORI write FCTR_VALORI;
    property CTR_DESCOB: Nullable<double>    read FCTR_DESCOB write FCTR_DESCOB;
    property CTR_DESCON: Nullable<string>    read FCTR_DESCON write FCTR_DESCON;
    property CTR_HIST01: Nullable<string>    read FCTR_HIST01 write FCTR_HIST01;
    property CTR_HIST02: Nullable<string>    read FCTR_HIST02 write FCTR_HIST02;
    property CTR_PORBAI: Nullable<string>    read FCTR_PORBAI write FCTR_PORBAI;
    property CTR_HISBAI: Nullable<string>    read FCTR_HISBAI write FCTR_HISBAI;
    property CTR_CTABAI: Nullable<string>    read FCTR_CTABAI write FCTR_CTABAI;
    property CTR_DOCBAI: Nullable<string>    read FCTR_DOCBAI write FCTR_DOCBAI;
    property CTR_OPEBAI: Nullable<string>    read FCTR_OPEBAI write FCTR_OPEBAI;
    property CTR_DTAREC: Nullable<TDateTime> read FCTR_DTAREC write FCTR_DTAREC;
    property CTR_VALREC: Nullable<double>    read FCTR_VALREC write FCTR_VALREC;
    property CTR_VALJUR: Nullable<double>    read FCTR_VALJUR write FCTR_VALJUR;
    property CTR_VALCOB: Nullable<double>    read FCTR_VALCOB write FCTR_VALCOB;
    property CTR_VALDES: Nullable<double>    read FCTR_VALDES write FCTR_VALDES;
    property CTR_RESCAI: Nullable<integer>   read FCTR_RESCAI write FCTR_RESCAI;
    property CTR_NOSNUM: Nullable<string>    read FCTR_NOSNUM write FCTR_NOSNUM;
    property CTR_DTABOL: Nullable<TDateTime> read FCTR_DTABOL write FCTR_DTABOL;
    property CTR_BCOBOL: Nullable<string>    read FCTR_BCOBOL write FCTR_BCOBOL;
    property CTR_BCOENV: Nullable<string>    read FCTR_BCOENV write FCTR_BCOENV;
    property CTR_DTAENV: Nullable<TDateTime> read FCTR_DTAENV write FCTR_DTAENV;
    property AUTOINCREM: string              read FAUTOINCREM write FAUTOINCREM;
    property CTR_OBSAG1: Nullable<string>    read FCTR_OBSAG1 write FCTR_OBSAG1;
    property CTR_OBSAG2: Nullable<string>    read FCTR_OBSAG2 write FCTR_OBSAG2;
    property CTR_OBSAG3: Nullable<string>    read FCTR_OBSAG3 write FCTR_OBSAG3;
    property CTR_DTABAI: Nullable<TDateTime> read FCTR_DTABAI write FCTR_DTABAI;
    property CTR_CODEVE: Nullable<string>    read FCTR_CODEVE write FCTR_CODEVE;
    property CTR_CODVEL: Nullable<string>    read FCTR_CODVEL write FCTR_CODVEL;
    property CTR_DINHEI: Nullable<double>    read FCTR_DINHEI write FCTR_DINHEI;
    property CTR_CHQAVI: Nullable<double>    read FCTR_CHQAVI write FCTR_CHQAVI;
    property CTR_CHQPRE: Nullable<double>    read FCTR_CHQPRE write FCTR_CHQPRE;
    property CTR_CARTAO: Nullable<double>    read FCTR_CARTAO write FCTR_CARTAO;
    property CTR_SEQMOD: Nullable<integer>   read FCTR_SEQMOD write FCTR_SEQMOD;
    property CTR_TIPFOR: Nullable<string>    read FCTR_TIPFOR write FCTR_TIPFOR;
    property CTR_CODCND: Nullable<string>    read FCTR_CODCND write FCTR_CODCND;
    property CTR_CONAPR: Nullable<integer>   read FCTR_CONAPR write FCTR_CONAPR;
    property CTR_RECDIN: Nullable<string>    read FCTR_RECDIN write FCTR_RECDIN;
    property CTR_RECCHE: Nullable<string>    read FCTR_RECCHE write FCTR_RECCHE;
    property CTR_RECPRE: Nullable<string>    read FCTR_RECPRE write FCTR_RECPRE;
    property CTR_RECCAR: Nullable<string>    read FCTR_RECCAR write FCTR_RECCAR;
    property CTR_CODCTA: Nullable<string>    read FCTR_CODCTA write FCTR_CODCTA;
    property CTR_CTASER: Nullable<string>    read FCTR_CTASER write FCTR_CTASER;
    property CTR_SERVAL: Nullable<double>    read FCTR_SERVAL write FCTR_SERVAL;
    property CTR_ORDPAG: Nullable<double>    read FCTR_ORDPAG write FCTR_ORDPAG;
    property CTR_RECORD: Nullable<string>    read FCTR_RECORD write FCTR_RECORD;
    property CTR_VALCOM: Nullable<double>    read FCTR_VALCOM write FCTR_VALCOM;
    property CTR_FATCOM: Nullable<double>    read FCTR_FATCOM write FCTR_FATCOM;
    property CTR_EMPBAI: Nullable<string>    read FCTR_EMPBAI write FCTR_EMPBAI;
    property CTR_DTASER: Nullable<TDateTime> read FCTR_DTASER write FCTR_DTASER;
    property CTR_VALIPI: Nullable<double>    read FCTR_VALIPI write FCTR_VALIPI;
    property CTR_VALRET: Nullable<double>    read FCTR_VALRET write FCTR_VALRET;
    property CTR_VALCBS: Nullable<double>    read FCTR_VALCBS write FCTR_VALCBS;
    property CTR_VALIBS: Nullable<double>    read FCTR_VALIBS write FCTR_VALIBS;
    property CTR_VAL_IS: Nullable<double>    read FCTR_VAL_IS write FCTR_VAL_IS;
    property CTR_DOCDIV: Nullable<string>    read FCTR_DOCDIV write FCTR_DOCDIV;
    property CTR_ESPDIV: Nullable<string>    read FCTR_ESPDIV write FCTR_ESPDIV;
    property CTR_EMPDIV: Nullable<string>    read FCTR_EMPDIV write FCTR_EMPDIV;
    property CTR_CLIDIV: Nullable<string>    read FCTR_CLIDIV write FCTR_CLIDIV;
    property CTR_JURSUJ: Nullable<double>    read FCTR_JURSUJ write FCTR_JURSUJ;
    property CTR_JURANT: Nullable<double>    read FCTR_JURANT write FCTR_JURANT;
    property CTR_DESSUJ: Nullable<double>    read FCTR_DESSUJ write FCTR_DESSUJ;
    property CTR_DESANT: Nullable<double>    read FCTR_DESANT write FCTR_DESANT;
    property CTR_SEQCON: Nullable<integer>   read FCTR_SEQCON write FCTR_SEQCON;
    property CTR_QTDDAV: Nullable<integer>   read FCTR_QTDDAV write FCTR_QTDDAV;
    property CTR_PERDPO: Nullable<double>    read FCTR_PERDPO write FCTR_PERDPO;
    property CTR_CODREP: Nullable<string>    read FCTR_CODREP write FCTR_CODREP;
    property CTR_COMREP: Nullable<double>    read FCTR_COMREP write FCTR_COMREP;
    property CTR_FATREP: Nullable<double>    read FCTR_FATREP write FCTR_FATREP;
    property CTR_VALANT: Nullable<double>    read FCTR_VALANT write FCTR_VALANT;
    property CTR_ORIF11: Nullable<string>    read FCTR_ORIF11 write FCTR_ORIF11;
    property CTR_VALFIN: Nullable<double>    read FCTR_VALFIN write FCTR_VALFIN;
    property CTR_RECFIN: Nullable<string>    read FCTR_RECFIN write FCTR_RECFIN;
    property CTR_EMP_PD: Nullable<string>    read FCTR_EMP_PD write FCTR_EMP_PD;
    property CTR_NOMFRM: Nullable<string>    read FCTR_NOMFRM write FCTR_NOMFRM;
    property CTR_VRTRDV: Nullable<double>    read FCTR_VRTRDV write FCTR_VRTRDV;
    property CTR_BARCON: Nullable<string>    read FCTR_BARCON write FCTR_BARCON;
    property CTR_COMDIV: Nullable<double>    read FCTR_COMDIV write FCTR_COMDIV;
    property CTR_FATDIV: Nullable<double>    read FCTR_FATDIV write FCTR_FATDIV;
    property CTR_CODDIV: Nullable<string>    read FCTR_CODDIV write FCTR_CODDIV;
    property CTR_PROTES: Nullable<string>    read FCTR_PROTES write FCTR_PROTES;
    property CTR_CTREME: Nullable<string>    read FCTR_CTREME write FCTR_CTREME;
    property CTR_DTAPFI: Nullable<TDateTime> read FCTR_DTAPFI write FCTR_DTAPFI;
    property CTR_MOTBAI: Nullable<string>    read FCTR_MOTBAI write FCTR_MOTBAI;
    property CTR_VALFRE: Nullable<double>    read FCTR_VALFRE write FCTR_VALFRE;
    property CTR_CTPCOM: Nullable<string>    read FCTR_CTPCOM write FCTR_CTPCOM;
    property CTR_VALACE: Nullable<double>    read FCTR_VALACE write FCTR_VALACE;
    property CTR_DIFORI: Nullable<double>    read FCTR_DIFORI write FCTR_DIFORI;
    property CTR_ID_LOC: Nullable<string>    read FCTR_ID_LOC write FCTR_ID_LOC;
    property CTR_ID_DOC: Nullable<string>    read FCTR_ID_DOC write FCTR_ID_DOC;
    property CTR_CODPA1: Nullable<string>    read FCTR_CODPA1 write FCTR_CODPA1;
    property CTR_CODPA2: Nullable<string>    read FCTR_CODPA2 write FCTR_CODPA2;
    property CTR_CODPJ1: Nullable<string>    read FCTR_CODPJ1 write FCTR_CODPJ1;
    property CTR_CODPJ2: Nullable<string>    read FCTR_CODPJ2 write FCTR_CODPJ2;
    property CTR_FATPA1: Nullable<double>    read FCTR_FATPA1 write FCTR_FATPA1;
    property CTR_FATPA2: Nullable<double>    read FCTR_FATPA2 write FCTR_FATPA2;
    property CTR_FATPJ1: Nullable<double>    read FCTR_FATPJ1 write FCTR_FATPJ1;
    property CTR_FATPJ2: Nullable<double>    read FCTR_FATPJ2 write FCTR_FATPJ2;
    property CTR_CARTEI: Nullable<string>    read FCTR_CARTEI write FCTR_CARTEI;
    property CTR_JUSDES: Nullable<string>    read FCTR_JUSDES write FCTR_JUSDES;
    property CTR_RECAUT: Nullable<string>    read FCTR_RECAUT write FCTR_RECAUT;
    property CTR_PERMOR: Nullable<double>    read FCTR_PERMOR write FCTR_PERMOR;
    property CTR_PERMUL: Nullable<double>    read FCTR_PERMUL write FCTR_PERMUL;
    property CTR_BCOCRR: Nullable<string>    read FCTR_BCOCRR write FCTR_BCOCRR;
    property CTR_NN_CRR: Nullable<string>    read FCTR_NN_CRR write FCTR_NN_CRR;
    property CTR_GRVORI: Nullable<double>    read FCTR_GRVORI write FCTR_GRVORI;
    property CTR_ADTCLI: Nullable<string>    read FCTR_ADTCLI write FCTR_ADTCLI;
    property CTR_AUTCTP: Nullable<string>    read FCTR_AUTCTP write FCTR_AUTCTP;
    property CTR_LINDIG: Nullable<string>    read FCTR_LINDIG write FCTR_LINDIG;
    property CTR_COBANT: Nullable<double>    read FCTR_COBANT write FCTR_COBANT;
    property CTR_CODCED: Nullable<string>    read FCTR_CODCED write FCTR_CODCED;
    property CTR_DTABOA: Nullable<TDateTime> read FCTR_DTABOA write FCTR_DTABOA;
    property CTR_DTABO2: Nullable<TDateTime> read FCTR_DTABO2 write FCTR_DTABO2;
    property CTR_BOAEXC: Nullable<TDateTime> read FCTR_BOAEXC write FCTR_BOAEXC;
    property CTR_MOVDES: Nullable<string>    read FCTR_MOVDES write FCTR_MOVDES;
    property CTR_DTAEMA: Nullable<TDateTime> read FCTR_DTAEMA write FCTR_DTAEMA;
    property CTR_CTPTXE: Nullable<string>    read FCTR_CTPTXE write FCTR_CTPTXE;
    property CTR_EMPORI: Nullable<string>    read FCTR_EMPORI  write FCTR_EMPORI;
    property CTR_JURBAI: Nullable<double>    read FCTR_JURBAI write FCTR_JURBAI;
    property CTR_DESBAI: Nullable<double>    read FCTR_DESBAI write FCTR_DESBAI;
    property CTR_AMORTI: Nullable<double>    read FCTR_AMORTI write FCTR_AMORTI;
    property CTR_VALCOR: Nullable<double>    read FCTR_VALCOR write FCTR_VALCOR;
    property CTR_DTASPC: Nullable<TDateTime> read FCTR_DTASPC write FCTR_DTASPC;
    property CTR_STSSPC: Nullable<string>    read FCTR_STSSPC write FCTR_STSSPC;
    property CTR_DTABAN: Nullable<TDateTime> read FCTR_DTABAN write FCTR_DTABAN;
    property CTR_DTASMS: Nullable<TDateTime> read FCTR_DTASMS write FCTR_DTASMS;
    property CTR_RECPIX: Nullable<string>    read FCTR_RECPIX write FCTR_RECPIX;
    property CTR_EMPPIX: Nullable<string>    read FCTR_EMPPIX write FCTR_EMPPIX;
    property CTR_TX_PIX: Nullable<string>    read FCTR_TX_PIX write FCTR_TX_PIX;
    property CTR_PIXTIP: Nullable<string>    read FCTR_PIXTIP write FCTR_PIXTIP;
    property CTR_PIXREC: Nullable<double>    read FCTR_PIXREC write FCTR_PIXREC;
    property CTR_PIXJUR: Nullable<double>    read FCTR_PIXJUR write FCTR_PIXJUR;
    property CTR_PIXDES: Nullable<double>    read FCTR_PIXDES write FCTR_PIXDES;
    property CTR_PIXCOB: Nullable<double>    read FCTR_PIXCOB write FCTR_PIXCOB;
    property CTR_PIXCOR: Nullable<double>    read FCTR_PIXCOR write FCTR_PIXCOR;
    property CTR_DTAWPP: Nullable<TDateTime> read FCTR_DTAWPP write FCTR_DTAWPP;

    property CTR_VALCAL: Nullable<double>    read FCTR_VALCAL write FCTR_VALCAL;
    property CTR_JURCAL: Nullable<double>    read FCTR_JURCAL write FCTR_JURCAL;
    property CTR_FATDUP: Nullable<double>    read FCTR_FATDUP write FCTR_FATDUP;
    property CTR_FATJUR: Nullable<double>    read FCTR_FATJUR write FCTR_FATJUR;
    property CTR_NOVBAI: Nullable<string>    read FCTR_NOVBAI write FCTR_NOVBAI;
    property CTR_DESCAL: Nullable<double>    read FCTR_DESCAL write FCTR_DESCAL;
    property CTR_SEQMPX: Nullable<string>    read FCTR_SEQMPX write FCTR_SEQMPX;

    property CTR_PERALP: Nullable<double>    read FCTR_PERALP write FCTR_PERALP;
    property CTR_TARTED: Nullable<double>    read FCTR_TARTED write FCTR_TARTED;
    property CTR_DTAALP: Nullable<TDateTime> read FCTR_DTAALP write FCTR_DTAALP;

    property CTR_QRCODE: Nullable<string>    read FCTR_QRCODE write FCTR_QRCODE;
    property CTR_TX_BOL: Nullable<string>    read FCTR_TX_BOL write FCTR_TX_BOL;
    property CTR_END_ID: Nullable<string>    read FCTR_END_ID write FCTR_END_ID;
    property CTR_LNKCIT: Nullable<string>    read FCTR_LNKCIT write FCTR_LNKCIT;

    property objCodCli : TCadCli             read getCodCli  write setCodCli;
  end;

  [Entity]
  [Table('LOGCTR')]
  [UniqueKey('CTR_NUMDUP, CTR_ESPDOC, CTR_CODCLI, CTR_CODEMP')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TLogCtr = Class(TCadRec)
  private
    [Column('CTR_DESCRI')]
    FDescri: string;
    [Column('CTR_DTALOG')]
    FDtaLog: TDate;
    [Column('CTR_HORLOG')]
    FHorLog: TTime;
    [Column('CTR_OPELOG')]
    FOpeLog: String;
    [Column('CTR_NOMEXE')]
    FNomeExecutavel : String;
    [Column('CTR_DTAEXE')]
    FDataExecutavel : TDate;
    [Column('CTR_HOREXE')]
    FHoraExecutavel: TTime;
    [Column('CTR_VEREXE')]
    FVersaoExecutavel : String;
  public
    property strDescri       : string Read FDescri           Write FDescri;
    property dtaDtaLog       : TDate  Read FDtaLog           Write FDtaLog;
    property dtaHorLog       : TTime  Read FHorLog           Write FHorLog;
    property strOpeLog       : String Read FOpeLog           Write FOpeLog;
    property NomeExecutavel  : String Read FNomeExecutavel   Write FNomeExecutavel;
    property DataExecutavel  : TDate  Read FDataExecutavel   Write FDataExecutavel;
    property HoraExecutavel  : TTime  Read FHoraExecutavel   Write FHoraExecutavel;
    property VersaoExecutavel: String Read FVersaoExecutavel Write FVersaoExecutavel;
  End;

  [Entity]
  [Table('DEL_CADREC')]
  [UniqueKey('CTR_NUMDUP, CTR_ESPDOC, CTR_CODCLI, CTR_CODEMP')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TDelCadRec = Class(TCadRec)
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

function TCadRec.getCodCli: TCadCli;
begin
  result := FCodCli.Value;
end;

procedure TCadRec.setCodCli(const Value: TCadCli);
begin
  FCodCli.Value := Value;
end;

end.
