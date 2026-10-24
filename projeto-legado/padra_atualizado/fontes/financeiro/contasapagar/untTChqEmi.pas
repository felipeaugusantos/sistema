unit untTChqEmi;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy,
  Classes;

type
  [Entity]
  [Table('CHQEMI')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TChqEmi = Class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;
    
    [Column('EMI_CODBCO', [TColumnProp.Required], 3)]
    FEMI_CODBCO: string;
    
    [Column('EMI_NUMAGE', [TColumnProp.Required], 5)]
    FEMI_NUMAGE: string;
    
    [Column('EMI_NUMCHQ', [TColumnProp.Required], 10)]
    FEMI_NUMCHQ: string;
    
    [Column('EMI_CODFOR', [], 8)]
    FEMI_CODFOR: Nullable<string>;
    
    [Column('EMI_NUMDUP', [], 12)]
    FEMI_NUMDUP: Nullable<string>;
    
    [Column('EMI_PARCEL', [], 3)]
    FEMI_PARCEL: Nullable<string>;
    
    [Column('EMI_CODEMP', [TColumnProp.Required], 3)]
    FEMI_CODEMP: string;
    
    [Column('EMI_SEQBAI', [TColumnProp.Required])]
    FEMI_SEQBAI: integer;
    
    [Column('EMI_SERIE_', [], 3)]
    FEMI_SERIE_: Nullable<string>;
    
    [Column('EMI_OPEBAI', [TColumnProp.Required], 3)]
    FEMI_OPEBAI: string;
    
    [Column('EMI_DTABAI', [TColumnProp.Required])]
    FEMI_DTABAI: TDateTime;
    
    [Column('EMI_VALBAI', [TColumnProp.Required], 12, 2)]
    FEMI_VALBAI: double;
    
    [Column('EMI_ANASIN', [TColumnProp.Required], 1)]
    FEMI_ANASIN: string;
    
    [Column('EMI_NUMDOC', [], 11)]
    FEMI_NUMDOC: Nullable<string>;
    
    [Column('EMI_HISTOR', [], 255)]
    FEMI_HISTOR: Nullable<string>;

    [Column('EMI_CONCOR', [TColumnProp.Required], 12)]
    FEMI_CONCOR: string;

    [Column('EMI_BOMPAR', [])]
    FEMI_BOMPAR: Nullable<TDateTime>;

    [Column('EMI_FAVORE', [], 60)]
    FEMI_FAVORE: Nullable<string>;

    [Column('EMI_DTAEMI', [])]
    FEMI_DTAEMI: Nullable<TDateTime>;

    [Column('EMI_CODPOR', [], 5)]
    FEMI_CODPOR: Nullable<string>;
  public
    property strAutInc: string              read FAUTOINCREM write FAUTOINCREM;
    property strCodBco: string              read FEMI_CODBCO write FEMI_CODBCO;
    property strNumAge: string              read FEMI_NUMAGE write FEMI_NUMAGE;
    property strNumChq: string              read FEMI_NUMCHQ write FEMI_NUMCHQ;
    property strCodFor: Nullable<string>    read FEMI_CODFOR write FEMI_CODFOR;
    property strNumDup: Nullable<string>    read FEMI_NUMDUP write FEMI_NUMDUP;
    property strParcel: Nullable<string>    read FEMI_PARCEL write FEMI_PARCEL;
    property strCodEmp: string              read FEMI_CODEMP write FEMI_CODEMP;
    property intSeqBai: integer             read FEMI_SEQBAI write FEMI_SEQBAI;
    property strSerie_: Nullable<string>    read FEMI_SERIE_ write FEMI_SERIE_;
    property strOpeBai: string              read FEMI_OPEBAI write FEMI_OPEBAI;
    property dtaDtaBai: TDateTime           read FEMI_DTABAI write FEMI_DTABAI;
    property fltValBai: double              read FEMI_VALBAI write FEMI_VALBAI;
    property strAnaSin: string              read FEMI_ANASIN write FEMI_ANASIN;
    property strNumDoc: Nullable<string>    read FEMI_NUMDOC write FEMI_NUMDOC;
    property strHistor: Nullable<string>    read FEMI_HISTOR write FEMI_HISTOR;
    property strConCor: string              read FEMI_CONCOR write FEMI_CONCOR;
    property dtaBomPar: Nullable<TDateTime> read FEMI_BOMPAR write FEMI_BOMPAR;
    property strFavore: Nullable<string>    read FEMI_FAVORE write FEMI_FAVORE;
    property dtaDtaEmi: Nullable<TDateTime> read FEMI_DTAEMI write FEMI_DTAEMI;
    property strCodPor: Nullable<string>    read FEMI_CODPOR write FEMI_CODPOR;
  end;

implementation

end.
