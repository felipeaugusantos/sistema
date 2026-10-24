unit untTCadChq;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy;

type
  [Entity]
  [Table('CADCHQ')]
  [UniqueKey('CHQ_CODBCO, CHQ_CODEMP')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadChq = class
  private
    [Column('CHQ_CODBCO', [TColumnProp.Required], 3)]
    FCHQ_CODBCO: string;

    [Column('CHQ_NUMAGE', [TColumnProp.Required], 5)]
    FCHQ_NUMAGE: string;

    [Column('CHQ_CONCOR', [TColumnProp.Required], 12)]
    FCHQ_CONCOR: string;

    [Column('CHQ_NUMCHQ', [TColumnProp.Required], 10)]
    FCHQ_NUMCHQ: string;

    [Column('CHQ_CODCLI', [TColumnProp.Required], 8)]
    FCHQ_CODCLI: string;

    [Column('CHQ_NOMEMI', [TColumnProp.Required], 40)]
    FCHQ_NOMEMI: string;

    [Column('CHQ_ENDERE', [], 40)]
    FCHQ_ENDERE: Nullable<string>;

    [Column('CHQ_TELEMI', [], 15)]
    FCHQ_TELEMI: Nullable<string>;

    [Column('CHQ_CGCCPF', [], 1)]
    FCHQ_CGCCPF: Nullable<string>;

    [Column('CHQ_C_G_C_', [], 18)]
    FCHQ_C_G_C_: Nullable<string>;

    [Column('CHQ_DTACAD', [TColumnProp.Required])]
    FCHQ_DTACAD: TDateTime;

    [Column('CHQ_DTAVEN', [TColumnProp.Required])]
    FCHQ_DTAVEN: TDateTime;

    [Column('CHQ_VALCHQ', [TColumnProp.Required], 12, 2)]
    FCHQ_VALCHQ: double;

    [Column('CHQ_HIST01', [], 50)]
    FCHQ_HIST01: Nullable<string>;

    [Column('CHQ_HIST02', [], 50)]
    FCHQ_HIST02: Nullable<string>;

    [Column('CHQ_CTADEP', [], 10)]
    FCHQ_CTADEP: Nullable<string>;

    [Column('CHQ_DTADEP', [])]
    FCHQ_DTADEP: Nullable<TDateTime>;

    [Column('CHQ_DOCDEP', [], 13)]
    FCHQ_DOCDEP: Nullable<string>;

    [Column('CHQ_CODPOR', [], 5)]
    FCHQ_CODPOR: Nullable<string>;

    [Column('CHQ_CODCTA', [], 7)]
    FCHQ_CODCTA: Nullable<string>;

    [Column('CHQ_DTADEV', [])]
    FCHQ_DTADEV: Nullable<TDateTime>;

    [Column('CHQ_MOTDEV', [], 30)]
    FCHQ_MOTDEV: Nullable<string>;

    [Column('CHQ_DTARDP', [])]
    FCHQ_DTARDP: Nullable<TDateTime>;

    [Column('CHQ_FORREP', [], 8)]
    FCHQ_FORREP: Nullable<string>;
    
    [Column('CHQ_OBSREP', [], 50)]
    FCHQ_OBSREP: Nullable<string>;

    [Column('CHQ_DTAREP', [])]
    FCHQ_DTAREP: Nullable<TDateTime>;

    [Column('CHQ_RESCAI', [])]
    FCHQ_RESCAI: Nullable<integer>;

    [Column('CHQ_CODEMP', [TColumnProp.Required], 3)]
    FCHQ_CODEMP: string;

    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;

    [Column('CHQ_NUMNOT', [], 12)]
    FCHQ_NUMNOT: Nullable<string>;

    [Column('CHQ_DTACUS', [])]
    FCHQ_DTACUS: Nullable<TDateTime>;

    [Column('CHQ_PORCUS', [], 5)]
    FCHQ_PORCUS: Nullable<string>;

    [Column('CHQ_DOCUME', [], 150)]
    FCHQ_DOCUME: Nullable<string>;

    [Column('CHQ_INCCTR', [], 1)]
    FCHQ_INCCTR: Nullable<string>;

    [Column('CHQ_HISTOR', [])]
    FCHQ_HISTOR: WideString;

    [Column('CHQ_DOCCUS', [], 20)]
    FCHQ_DOCCUS: Nullable<string>;

    [Column('CHQ_LOTCUS', [], 12)]
    FCHQ_LOTCUS: Nullable<string>;

    [Column('CHQ_PORDEB', [], 5)]
    FCHQ_PORDEB: Nullable<string>;

    [Column('CHQ_CTADEB', [], 7)]
    FCHQ_CTADEB: Nullable<string>;

    [Column('CHQ_MOTDV2', [], 50)]
    FCHQ_MOTDV2: Nullable<string>;

    [Column('CHQ_DTADP2', [])]
    FCHQ_DTADP2: Nullable<TDateTime>;

    [Column('CHQ_DTADV2', [])]
    FCHQ_DTADV2: Nullable<TDateTime>;

    [Column('CHQ_SEQCOM', [], 20)]
    FCHQ_SEQCOM: Nullable<string>;

    [Column('CHQ_DTATRA', [])]
    FCHQ_DTATRA: Nullable<TDateTime>;

    [Column('CHQ_SEQCON', [])]
    FCHQ_SEQCON: Nullable<integer>;

    [Column('CHQ_EMPRCX', [], 3)]
    FCHQ_EMPRCX: Nullable<string>;

    [Column('CHQ_DEVDEF', [])]
    FCHQ_DEVDEF: Nullable<integer>;

    [Column('CHQ_CODVEN', [], 3)]
    FCHQ_CODVEN: Nullable<string>;

    [Column('CHQ_SEQTRF', [])]
    FCHQ_SEQTRF: Nullable<integer>;

    [Column('CHQ_DUPDEV', [], 32)]
    FCHQ_DUPDEV: Nullable<string>;

    [Column('CHQ_DUPDEP', [], 32)]
    FCHQ_DUPDEP: Nullable<string>;

    [Column('CHQ_CTDPSV', [], 10)]
    FCHQ_CTDPSV: Nullable<string>;

    [Column('CHQ_CTDBSV', [], 7)]
    FCHQ_CTDBSV: Nullable<string>;

    [Column('CHQ_PRDBSV', [], 5)]
    FCHQ_PRDBSV: Nullable<string>;

    [Column('CHQ_CDCTSV', [], 7)]
    FCHQ_CDCTSV: Nullable<string>;

    [Column('CHQ_CDPRSV', [], 5)]
    FCHQ_CDPRSV: Nullable<string>;

    [Column('CHQ_TELCHE', [], 1)]
    FCHQ_TELCHE: Nullable<string>;

    [Column('CHQ_TELNUM', [], 4)]
    FCHQ_TELNUM: Nullable<string>;

    [Column('CHQ_SEQDEP', [], 6)]
    FCHQ_SEQDEP: Nullable<string>;

    [Column('CHQ_CODOPE', [], 3)]
    FCHQ_CODOPE: Nullable<string>;

    [Column('CHQ_CODCMC', [], 34)]
    FCHQ_CODCMC: Nullable<string>;

    [Column('CHQ_CTPCOM', [], 9)]
    FCHQ_CTPCOM: Nullable<string>;

    [Column('CHQ_VALIPI', [], 12, 2)]
    FCHQ_VALIPI: Nullable<double>;

    [Column('CHQ_VALRET', [], 12, 2)]
    FCHQ_VALRET: Nullable<double>;

    [Column('CHQ_VALACE', [], 12, 2)]
    FCHQ_VALACE: Nullable<double>;

    [Column('CHQ_VALFRE', [], 12, 2)]
    FCHQ_VALFRE: Nullable<double>;

    [Column('CHQ_VALCBS', [], 12, 2)]
    FCHQ_VALCBS: Nullable<double>;

    [Column('CHQ_VALIBS', [], 12, 2)]
    FCHQ_VALIBS: Nullable<double>;

    [Column('CHQ_VAL_IS', [], 12, 2)]
    FCHQ_VAL_IS: Nullable<double>;

    [Column('CHQ_PORCHQ', [], 5)]
    FCHQ_PORCHQ: Nullable<string>;

    [Column('CHQ_DUPDV2', [], 32)]
    FCHQ_DUPDV2: Nullable<string>;

    [Column('CHQ_DUPDP2', [], 32)]
    FCHQ_DUPDP2: Nullable<string>;

    [Column('CHQ_CTDPS2', [], 10)]
    FCHQ_CTDPS2: Nullable<string>;

    [Column('CHQ_CDCTS2', [], 7)]
    FCHQ_CDCTS2: Nullable<string>;

    [Column('CHQ_CDPRS2', [], 5)]
    FCHQ_CDPRS2: Nullable<string>;

    [Column('CHQ_NOMFRM', [], 70)]
    FCHQ_NOMFRM: Nullable<string>;

    [Column('CHQ_PRCORI', [], 5)]
    FCHQ_PRCORI: Nullable<string>;

    [Column('CHQ_CTCORI', [], 7)]
    FCHQ_CTCORI: Nullable<string>;

    [Column('CHQ_PRDORI', [], 5)]
    FCHQ_PRDORI: Nullable<string>;

    [Column('CHQ_CTDORI', [], 7)]
    FCHQ_CTDORI: Nullable<string>;

    [Column('CHQ_DEPORI', [], 10)]
    FCHQ_DEPORI: Nullable<string>;

    [Column('CHQ_NAODEP', [], 1)]
    FCHQ_NAODEP: Nullable<string>;

    [Column('CHQ_CODCID', [], 5)]
    FCHQ_CODCID: Nullable<string>;

    [Column('CHQ_SEQRCH', [])]
    FCHQ_SEQRCH: Nullable<integer>;

    [Column('CHQ_EMPRCH', [], 3)]
    FCHQ_EMPRCH: Nullable<string>;

    [Column('CHQ_CTACRE', [], 7)]
    FCHQ_CTACRE: Nullable<string>;

    [Column('CHQ_PORCRE', [], 5)]
    FCHQ_PORCRE: Nullable<string>;

    [Column('CHQ_CTACHQ', [], 7)]
    FCHQ_CTACHQ: Nullable<string>;

    [Column('CHQ_CODCAX', [], 5)]
    FCHQ_CODCAX: Nullable<string>;

    [Column('CHQ_SEQANT', [], 20)]
    FCHQ_SEQANT: Nullable<string>;

    [Column('CHQ_TRFLIB', [], 1)]
    FCHQ_TRFLIB: Nullable<string>;

  public
    property CHQ_CODBCO: string              read FCHQ_CODBCO write FCHQ_CODBCO;
    property CHQ_NUMAGE: string              read FCHQ_NUMAGE write FCHQ_NUMAGE;
    property CHQ_CONCOR: string              read FCHQ_CONCOR write FCHQ_CONCOR;
    property CHQ_NUMCHQ: string              read FCHQ_NUMCHQ write FCHQ_NUMCHQ;
    property CHQ_CODCLI: string              read FCHQ_CODCLI write FCHQ_CODCLI;
    property CHQ_NOMEMI: string              read FCHQ_NOMEMI write FCHQ_NOMEMI;
    property CHQ_ENDERE: Nullable<string>    read FCHQ_ENDERE write FCHQ_ENDERE;
    property CHQ_TELEMI: Nullable<string>    read FCHQ_TELEMI write FCHQ_TELEMI;
    property CHQ_CGCCPF: Nullable<string>    read FCHQ_CGCCPF write FCHQ_CGCCPF;
    property CHQ_C_G_C_: Nullable<string>    read FCHQ_C_G_C_ write FCHQ_C_G_C_;
    property CHQ_DTACAD: TDateTime           read FCHQ_DTACAD write FCHQ_DTACAD;
    property CHQ_DTAVEN: TDateTime           read FCHQ_DTAVEN write FCHQ_DTAVEN;
    property CHQ_VALCHQ: double              read FCHQ_VALCHQ write FCHQ_VALCHQ;
    property CHQ_HIST01: Nullable<string>    read FCHQ_HIST01 write FCHQ_HIST01;
    property CHQ_HIST02: Nullable<string>    read FCHQ_HIST02 write FCHQ_HIST02;
    property CHQ_CTADEP: Nullable<string>    read FCHQ_CTADEP write FCHQ_CTADEP;
    property CHQ_DTADEP: Nullable<TDateTime> read FCHQ_DTADEP write FCHQ_DTADEP;
    property CHQ_DOCDEP: Nullable<string>    read FCHQ_DOCDEP write FCHQ_DOCDEP;
    property CHQ_CODPOR: Nullable<string>    read FCHQ_CODPOR write FCHQ_CODPOR;
    property CHQ_CODCTA: Nullable<string>    read FCHQ_CODCTA write FCHQ_CODCTA;
    property CHQ_DTADEV: Nullable<TDateTime> read FCHQ_DTADEV write FCHQ_DTADEV;
    property CHQ_MOTDEV: Nullable<string>    read FCHQ_MOTDEV write FCHQ_MOTDEV;
    property CHQ_DTARDP: Nullable<TDateTime> read FCHQ_DTARDP write FCHQ_DTARDP;
    property CHQ_FORREP: Nullable<string>    read FCHQ_FORREP write FCHQ_FORREP;
    property CHQ_OBSREP: Nullable<string>    read FCHQ_OBSREP write FCHQ_OBSREP;
    property CHQ_DTAREP: Nullable<TDateTime> read FCHQ_DTAREP write FCHQ_DTAREP;
    property CHQ_RESCAI: Nullable<integer>   read FCHQ_RESCAI write FCHQ_RESCAI;
    property CHQ_CODEMP: string              read FCHQ_CODEMP write FCHQ_CODEMP;
    property AUTOINCREM: string              read FAUTOINCREM write FAUTOINCREM;
    property CHQ_NUMNOT: Nullable<string>    read FCHQ_NUMNOT write FCHQ_NUMNOT;
    property CHQ_DTACUS: Nullable<TDateTime> read FCHQ_DTACUS write FCHQ_DTACUS;
    property CHQ_PORCUS: Nullable<string>    read FCHQ_PORCUS write FCHQ_PORCUS;
    property CHQ_DOCUME: Nullable<string>    read FCHQ_DOCUME write FCHQ_DOCUME;
    property CHQ_INCCTR: Nullable<string>    read FCHQ_INCCTR write FCHQ_INCCTR;
    property CHQ_HISTOR: WideString          read FCHQ_HISTOR write FCHQ_HISTOR;
    property CHQ_DOCCUS: Nullable<string>    read FCHQ_DOCCUS write FCHQ_DOCCUS;
    property CHQ_LOTCUS: Nullable<string>    read FCHQ_LOTCUS write FCHQ_LOTCUS;
    property CHQ_PORDEB: Nullable<string>    read FCHQ_PORDEB write FCHQ_PORDEB;
    property CHQ_CTADEB: Nullable<string>    read FCHQ_CTADEB write FCHQ_CTADEB;
    property CHQ_MOTDV2: Nullable<string>    read FCHQ_MOTDV2 write FCHQ_MOTDV2;
    property CHQ_DTADP2: Nullable<TDateTime> read FCHQ_DTADP2 write FCHQ_DTADP2;
    property CHQ_DTADV2: Nullable<TDateTime> read FCHQ_DTADV2 write FCHQ_DTADV2;
    property CHQ_SEQCOM: Nullable<string>    read FCHQ_SEQCOM write FCHQ_SEQCOM;
    property CHQ_DTATRA: Nullable<TDateTime> read FCHQ_DTATRA write FCHQ_DTATRA;
    property CHQ_SEQCON: Nullable<integer>   read FCHQ_SEQCON write FCHQ_SEQCON;
    property CHQ_EMPRCX: Nullable<string>    read FCHQ_EMPRCX write FCHQ_EMPRCX;
    property CHQ_DEVDEF: Nullable<integer>   read FCHQ_DEVDEF write FCHQ_DEVDEF;
    property CHQ_CODVEN: Nullable<string>    read FCHQ_CODVEN write FCHQ_CODVEN;
    property CHQ_SEQTRF: Nullable<integer>   read FCHQ_SEQTRF write FCHQ_SEQTRF;
    property CHQ_DUPDEV: Nullable<string>    read FCHQ_DUPDEV write FCHQ_DUPDEV;
    property CHQ_DUPDEP: Nullable<string>    read FCHQ_DUPDEP write FCHQ_DUPDEP;
    property CHQ_CTDPSV: Nullable<string>    read FCHQ_CTDPSV write FCHQ_CTDPSV;
    property CHQ_CTDBSV: Nullable<string>    read FCHQ_CTDBSV write FCHQ_CTDBSV;
    property CHQ_PRDBSV: Nullable<string>    read FCHQ_PRDBSV write FCHQ_PRDBSV;
    property CHQ_CDCTSV: Nullable<string>    read FCHQ_CDCTSV write FCHQ_CDCTSV;
    property CHQ_CDPRSV: Nullable<string>    read FCHQ_CDPRSV write FCHQ_CDPRSV;
    property CHQ_TELCHE: Nullable<string>    read FCHQ_TELCHE write FCHQ_TELCHE;
    property CHQ_TELNUM: Nullable<string>    read FCHQ_TELNUM write FCHQ_TELNUM;
    property CHQ_SEQDEP: Nullable<string>    read FCHQ_SEQDEP write FCHQ_SEQDEP;
    property CHQ_CODOPE: Nullable<string>    read FCHQ_CODOPE write FCHQ_CODOPE;
    property CHQ_CODCMC: Nullable<string>    read FCHQ_CODCMC write FCHQ_CODCMC;
    property CHQ_CTPCOM: Nullable<string>    read FCHQ_CTPCOM write FCHQ_CTPCOM;
    property CHQ_VALIPI: Nullable<double>    read FCHQ_VALIPI write FCHQ_VALIPI;
    property CHQ_VALRET: Nullable<double>    read FCHQ_VALRET write FCHQ_VALRET;
    property CHQ_VALACE: Nullable<double>    read FCHQ_VALACE write FCHQ_VALACE;
    property CHQ_VALFRE: Nullable<double>    read FCHQ_VALFRE write FCHQ_VALFRE;
    property CHQ_VALCBS: Nullable<double>    read FCHQ_VALCBS write FCHQ_VALCBS;
    property CHQ_VALIBS: Nullable<double>    read FCHQ_VALIBS write FCHQ_VALIBS;
    property CHQ_VAL_IS: Nullable<double>    read FCHQ_VAL_IS write FCHQ_VAL_IS;
    property CHQ_PORCHQ: Nullable<string>    read FCHQ_PORCHQ write FCHQ_PORCHQ;
    property CHQ_DUPDV2: Nullable<string>    read FCHQ_DUPDV2 write FCHQ_DUPDV2;
    property CHQ_DUPDP2: Nullable<string>    read FCHQ_DUPDP2 write FCHQ_DUPDP2;
    property CHQ_CTDPS2: Nullable<string>    read FCHQ_CTDPS2 write FCHQ_CTDPS2;
    property CHQ_CDCTS2: Nullable<string>    read FCHQ_CDCTS2 write FCHQ_CDCTS2;
    property CHQ_CDPRS2: Nullable<string>    read FCHQ_CDPRS2 write FCHQ_CDPRS2;
    property CHQ_NOMFRM: Nullable<string>    read FCHQ_NOMFRM write FCHQ_NOMFRM;
    property CHQ_PRCORI: Nullable<string>    read FCHQ_PRCORI write FCHQ_PRCORI;
    property CHQ_CTCORI: Nullable<string>    read FCHQ_CTCORI write FCHQ_CTCORI;
    property CHQ_PRDORI: Nullable<string>    read FCHQ_PRDORI write FCHQ_PRDORI;
    property CHQ_CTDORI: Nullable<string>    read FCHQ_CTDORI write FCHQ_CTDORI;
    property CHQ_DEPORI: Nullable<string>    read FCHQ_DEPORI write FCHQ_DEPORI;
    property CHQ_NAODEP: Nullable<string>    read FCHQ_NAODEP write FCHQ_NAODEP;
    property CHQ_CODCID: Nullable<string>    read FCHQ_CODCID write FCHQ_CODCID;
    property CHQ_SEQRCH: Nullable<integer>   read FCHQ_SEQRCH write FCHQ_SEQRCH;
    property CHQ_EMPRCH: Nullable<string>    read FCHQ_EMPRCH write FCHQ_EMPRCH;
    property CHQ_CTACRE: Nullable<string>    read FCHQ_CTACRE write FCHQ_CTACRE;
    property CHQ_PORCRE: Nullable<string>    read FCHQ_PORCRE write FCHQ_PORCRE;
    property CHQ_CTACHQ: Nullable<string>    read FCHQ_CTACHQ write FCHQ_CTACHQ;
    property CHQ_CODCAX: Nullable<string>    read FCHQ_CODCAX write FCHQ_CODCAX;
    property CHQ_SEQANT: Nullable<string>    read FCHQ_SEQANT write FCHQ_SEQANT;
    property CHQ_TRFLIB: Nullable<string>    read FCHQ_TRFLIB write FCHQ_TRFLIB;
  end;

  [Entity]
  [Table('LOGCHQ')]
  [UniqueKey('CHQ_CODBCO, CHQ_CODEMP')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TLogChq = Class(TCadChq)
  private
    [Column('CHQ_HISLOG')]
    FCHQ_HISLOG: string;
    [Column('CHQ_DTALOG')]
    FCHQ_DTALOG: TDate;
    [Column('CHQ_HORLOG')]
    FCHQ_HORLOG: TTime;
    [Column('CHQ_OPELOG')]
    FCHQ_OPELOG: String;
    [Column('CHQ_NOMTAB')]
    FCHQ_NOMTAB: String;
    [Column('CHQ_NOMEXE')]
    FNomeExecutavel : String;
    [Column('CHQ_DTAEXE')]
    FDataExecutavel : TDate;
    [Column('CHQ_HOREXE')]
    FHoraExecutavel: TTime;
    [Column('CHQ_VEREXE')]
    FVersaoExecutavel : String;
  public
    property CHQ_HISLOG      : string Read FCHQ_HISLOG       Write FCHQ_HISLOG;
    property CHQ_DTALOG      : TDate  Read FCHQ_DTALOG       Write FCHQ_DTALOG;
    property CHQ_HORLOG      : TTime  Read FCHQ_HORLOG       Write FCHQ_HORLOG;
    property CHQ_OPELOG      : String Read FCHQ_OPELOG       Write FCHQ_OPELOG;
    property CHQ_NOMTAB      : String Read FCHQ_NOMTAB       Write FCHQ_NOMTAB;
    property NomeExecutavel  : String Read FNomeExecutavel   Write FNomeExecutavel;
    property DataExecutavel  : TDate  Read FDataExecutavel   Write FDataExecutavel;
    property HoraExecutavel  : TTime  Read FHoraExecutavel   Write FHoraExecutavel;
    property VersaoExecutavel: String Read FVersaoExecutavel Write FVersaoExecutavel;
  End;

  [Entity]
  [Table('DEL_CADCHQ')]
  [UniqueKey('CHQ_CODBCO, CHQ_CODEMP')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TDelCadChq = Class(TCadChq)
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
