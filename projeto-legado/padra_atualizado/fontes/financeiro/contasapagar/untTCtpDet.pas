unit untTCtpDet;

interface

uses SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy;

Type
  [Entity]
  [Table('CTPDET')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCtpDet = class
  private
    [Column('CTP_CODFOR', [TColumnProp.Required], 8)]
    FCTP_CODFOR: string;

    [Column('CTP_NUMDUP', [TColumnProp.Required], 12)]
    FCTP_NUMDUP: string;

    [Column('CTP_PARCEL', [TColumnProp.Required], 1)]
    FCTP_PARCEL: string;

    [Column('CTP_CODCTA', [], 7)]
    FCTP_CODCTA: Nullable<string>;

    [Column('CTP_CODEMP', [TColumnProp.Required], 3)]
    FCTP_CODEMP: string;

    [Column('CTP_EMPORI', [TColumnProp.Required], 3)]
    FCTP_EMPORI: string;

    [Column('CTP_FATCAL', [TColumnProp.Required], 14, 6)]
    FCTP_FATCAL: double;

    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;

    [Column('CTP_SERIE_', [], 3)]
    FCTP_SERIE_: Nullable<string>;

    [Column('CTP_CODEVE', [], 5)]
    FCTP_CODEVE: Nullable<string>;
  public
    property CTP_CODFOR: string read FCTP_CODFOR write FCTP_CODFOR;
    property CTP_NUMDUP: string read FCTP_NUMDUP write FCTP_NUMDUP;
    property CTP_PARCEL: string read FCTP_PARCEL write FCTP_PARCEL;
    property CTP_CODCTA: Nullable<string> read FCTP_CODCTA write FCTP_CODCTA;
    property CTP_CODEMP: string read FCTP_CODEMP write FCTP_CODEMP;
    property CTP_EMPORI: string read FCTP_EMPORI write FCTP_EMPORI;
    property CTP_FATCAL: double read FCTP_FATCAL write FCTP_FATCAL;
    property AUTOINCREM: string read FAUTOINCREM write FAUTOINCREM;
    property CTP_SERIE_: Nullable<string> read FCTP_SERIE_ write FCTP_SERIE_;
    property CTP_CODEVE: Nullable<string> read FCTP_CODEVE write FCTP_CODEVE;
  end;


  [Entity]
  [Table('LOGCTPDET')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TLogCtpDet = Class(TCtpDet)
  private
    [Column('CTP_DESCRI')]
    FDescri: string;
    [Column('CTP_DTALOG')]
    FDtaLog: TDate;
    [Column('CTP_HORLOG')]
    FHorLog: TTime;
    [Column('CTP_OPELOG')]
    FOpeLog: String;
    [Column('CTP_NOMFRM')]
    FNomFrm: String;
    [Column('CTP_AUTCTP')]
    FAutCtp: String;
  public
    property strDescri: string Read FDescri Write FDescri;
    property dtaDtaLog: TDate  Read FDtaLog Write FDtaLog;
    property dtaHorLog: TTime  Read FHorLog Write FHorLog;
    property strOpeLog: String Read FOpeLog Write FOpeLog;
    property strNomFrm: String Read FNomFrm Write FNomFrm;
    property strAutCtp: String Read FAutCtp Write FAutCtp;
  End;

implementation

end.
