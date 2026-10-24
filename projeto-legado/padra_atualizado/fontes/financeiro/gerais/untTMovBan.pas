unit untTMovBan;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy,
  Classes;

type
  [Entity]
  [Table('MOVBAN')]
  [UniqueKey('CTB_SEQLAN')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TMovBan = Class
  private
    [Column('CTB_SEQLAN', [TColumnProp.Required], 13)]
    FCTB_SEQLAN: string;

    [Column('CTB_CODCTA', [], 7)]
    FCTB_CODCTA: Nullable<string>;

    [Column('CTB_CODPOR', [TColumnProp.Required], 5)]
    FCTB_CODPOR: string;
    
    [Column('CTB_CODOPE', [], 3)]
    FCTB_CODOPE: Nullable<string>;
    
    [Column('CTB_DTALAN', [])]
    FCTB_DTALAN: Nullable<TDateTime>;
    
    [Column('CTB_HORLAN', [])]
    FCTB_HORLAN: Nullable<TDateTime>;
    
    [Column('CTB_NUMDOC', [], 12)]
    FCTB_NUMDOC: Nullable<string>;
    
    [Column('CTB_CREDEB', [], 1)]
    FCTB_CREDEB: Nullable<string>;
    
    [Column('CTB_VALLAN', [], 12, 2)]
    FCTB_VALLAN: Nullable<double>;
    
    [Column('CTB_HIST01', [], 40)]
    FCTB_HIST01: Nullable<string>;
    
    [Column('CTB_HIST02', [], 40)]
    FCTB_HIST02: Nullable<string>;
    
    [Column('CTB_CODEMP', [], 3)]
    FCTB_CODEMP: Nullable<string>;
    
    [Column('AUTOINCREM', [], 20)]
    FAUTOINCREM: Nullable<string>;
    
    [Column('CTB_CODCLI', [], 8)]
    FCTB_CODCLI: Nullable<string>;

    [Column('CTB_CODFOR', [], 8)]
    FCTB_CODFOR: Nullable<string>;
    
    [Column('CTB_SEQBAI', [])]
    FCTB_SEQBAI: Nullable<integer>;
    
    [Column('CTB_PARCEL', [], 3)]
    FCTB_PARCEL: Nullable<string>;
    
    [Column('CTB_EMPDUP', [], 3)]
    FCTB_EMPDUP: Nullable<string>;
    
    [Column('CTB_NUMDUP', [], 12)]
    FCTB_NUMDUP: Nullable<string>;
    
    [Column('CTB_SERIE_', [], 3)]
    FCTB_SERIE_: Nullable<string>;
    
    [Column('CTB_CODEVE', [], 5)]
    FCTB_CODEVE: Nullable<string>;
    
    [Column('CTB_DTACON', [])]
    FCTB_DTACON: Nullable<TDateTime>;
    
    [Column('CTB_HORCON', [])]
    FCTB_HORCON: Nullable<TDateTime>;
    
    [Column('CTB_OPECON', [], 3)]
    FCTB_OPECON: Nullable<string>;
    
    [Column('CTB_SEQCTP', [], 6)]
    FCTB_SEQCTP: Nullable<string>;

    [Column('CTB_DOCBAI', [], 11)]
    FCTB_DOCBAI: Nullable<string>;

    [Column('CTB_SEQTRF', [])]
    FCTB_SEQTRF: Nullable<integer>;

    [Column('CTB_CODVEL', [], 20)]
    FCTB_CODVEL: Nullable<string>;

    [Column('CTB_PAGCON', [])]
    FCTB_PAGCON: Nullable<integer>;

    [Column('CTB_COMPET', [], 7)]
    FCTB_COMPET: Nullable<string>;

    [Column('CTB_ORIGEM', [], 3)]
    FCTB_ORIGEM: Nullable<string>;

    [Column('CTB_IGNORA', [], 1)]
    FCTB_IGNORA: Nullable<string>;

    [Column('CTB_OCOIGN', [], 1)]
    FCTB_OCOIGN: Nullable<string>;

    [Column('CTB_GERCON', [])]
    FCTB_GERCON: Nullable<integer>;

    [Column('CTB_EMPTRA', [], 1)]
    FCTB_EMPTRA: Nullable<string>;

    [Column('CTB_TRFLIB', [], 1)]
    FCTB_TRFLIB: Nullable<string>;
  public
    property strSeqLan: string              read FCTB_SEQLAN write FCTB_SEQLAN;
    property strCodCta: Nullable<string>    read FCTB_CODCTA write FCTB_CODCTA;
    property strCodPor: string              read FCTB_CODPOR write FCTB_CODPOR;
    property strCodOpe: Nullable<string>    read FCTB_CODOPE write FCTB_CODOPE;
    property dtaDtaLan: Nullable<TDateTime> read FCTB_DTALAN write FCTB_DTALAN;
    property dtaHorLan: Nullable<TDateTime> read FCTB_HORLAN write FCTB_HORLAN;
    property strNumDoc: Nullable<string>    read FCTB_NUMDOC write FCTB_NUMDOC;
    property strCreDeb: Nullable<string>    read FCTB_CREDEB write FCTB_CREDEB;
    property fltValLan: Nullable<double>    read FCTB_VALLAN write FCTB_VALLAN;
    property strHist01: Nullable<string>    read FCTB_HIST01 write FCTB_HIST01;
    property strHist02: Nullable<string>    read FCTB_HIST02 write FCTB_HIST02;
    property strCodEmp: Nullable<string>    read FCTB_CODEMP write FCTB_CODEMP;
    property strAutInc: Nullable<string>    read FAUTOINCREM write FAUTOINCREM;
    property strCodCli: Nullable<string>    read FCTB_CODCLI write FCTB_CODCLI;
    property strCodFor: Nullable<string>    read FCTB_CODFOR write FCTB_CODFOR;
    property intSeqBai: Nullable<integer>   read FCTB_SEQBAI write FCTB_SEQBAI;
    property strParcel: Nullable<string>    read FCTB_PARCEL write FCTB_PARCEL;
    property strEmpDup: Nullable<string>    read FCTB_EMPDUP write FCTB_EMPDUP;
    property strNumDup: Nullable<string>    read FCTB_NUMDUP write FCTB_NUMDUP;
    property strSerie_: Nullable<string>    read FCTB_SERIE_ write FCTB_SERIE_;
    property strCodEve: Nullable<string>    read FCTB_CODEVE write FCTB_CODEVE;
    property dtaDtaCon: Nullable<TDateTime> read FCTB_DTACON write FCTB_DTACON;
    property dtaHorCon: Nullable<TDateTime> read FCTB_HORCON write FCTB_HORCON;
    property strOpeCon: Nullable<string>    read FCTB_OPECON write FCTB_OPECON;
    property strSeqCtp: Nullable<string>    read FCTB_SEQCTP write FCTB_SEQCTP;
    property strDocBai: Nullable<string>    read FCTB_DOCBAI write FCTB_DOCBAI;
    property intSeqTrf: Nullable<integer>   read FCTB_SEQTRF write FCTB_SEQTRF;
    property strCodVel: Nullable<string>    read FCTB_CODVEL write FCTB_CODVEL;
    property intPagCon: Nullable<integer>   read FCTB_PAGCON write FCTB_PAGCON;
    property strCompet: Nullable<string>    read FCTB_COMPET write FCTB_COMPET;
    property strOrigem: Nullable<string>    read FCTB_ORIGEM write FCTB_ORIGEM;
    property strIgnora: Nullable<string>    read FCTB_IGNORA write FCTB_IGNORA;
    property strOcoIgn: Nullable<string>    read FCTB_OCOIGN write FCTB_OCOIGN;
    property intGerCon: Nullable<integer>   read FCTB_GERCON write FCTB_GERCON;
    property strEmpTra: Nullable<string>    read FCTB_EMPTRA write FCTB_EMPTRA;
    property strTrfLib: Nullable<string>    read FCTB_TRFLIB write FCTB_TRFLIB;
  end;

  [Entity]
  [Table('LOGCBA')]
  [UniqueKey('CTB_SEQLAN')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TLogCba = Class(TMovBan)
  private
    [Column('CTB_DESCRI')]
    FDescri: string;
    [Column('CTB_DTALOG')]
    FDtaLog: TDate;
    [Column('CTB_HORLOG')]
    FHorLog: TTime;
    [Column('CTB_OPELOG')]
    FOpeLog: String;
    [Column('CTB_NOMFRM')]
    FNomFrm: String;
    [Column('CTB_NOMEXE')]
    FNomeExecutavel : String;
    [Column('CTB_DTAEXE')]
    FDataExecutavel : TDate;
    [Column('CTB_HOREXE')]
    FHoraExecutavel: TTime;
    [Column('CTB_VEREXE')]
    FVersaoExecutavel : String;
    [Column('CTB_ARQIMP')]
    FArquivoImportacao: String;
  public
    property strDescri        : string Read FDescri            Write FDescri;
    property dtaDtaLog        : TDate  Read FDtaLog            Write FDtaLog;
    property dtaHorLog        : TTime  Read FHorLog            Write FHorLog;
    property strOpeLog        : String Read FOpeLog            Write FOpeLog;
    property strNomFrm        : String Read FNomFrm            Write FNomFrm;
    property NomeExecutavel   : String Read FNomeExecutavel    Write FNomeExecutavel;
    property DataExecutavel   : TDate  Read FDataExecutavel    Write FDataExecutavel;
    property HoraExecutavel   : TTime  Read FHoraExecutavel    Write FHoraExecutavel;
    property VersaoExecutavel : String Read FVersaoExecutavel  Write FVersaoExecutavel;
    property ArquivoImportacao: String Read FArquivoImportacao Write FArquivoImportacao;
  End;

implementation

end.
