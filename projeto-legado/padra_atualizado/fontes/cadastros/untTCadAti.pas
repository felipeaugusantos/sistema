unit untTCadAti;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable, Aurelius.Types.Proxy;

type
  [Entity]
  [Table('CADATI')]
  [Id('FATI_CODATI', TIdGenerator.None)]
  TCadAti = class
  private
    [Column('ATI_CODATI', [TColumnProp.Required], 3)]
    FATI_CODATI: string;

    [Column('ATI_DESATI', [], 70)]
    FATI_DESATI: Nullable<string>;

    [Column('ATI_CODEMP', [TColumnProp.Required], 3)]
    FATI_CODEMP: string;

    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;

    [Column('ATI_TABPRE', [], 1)]
    FATI_TABPRE: Nullable<string>;

    [Column('ATI_PERCOM', [], 5, 2)]
    FATI_PERCOM: Nullable<double>;

    [Column('ATI_CODVEL', [], 20)]
    FATI_CODVEL: Nullable<string>;

    [Column('ATI_RENPRE', [], 12, 2)]
    FATI_RENPRE: Nullable<double>;

    [Column('ATI_CODGAT', [], 3)]
    FATI_CODGAT: Nullable<string>;
  public
    property ATI_CODATI: string           read FATI_CODATI write FATI_CODATI;
    property ATI_DESATI: Nullable<string> read FATI_DESATI write FATI_DESATI;
    property ATI_CODEMP: string           read FATI_CODEMP write FATI_CODEMP;
    property AUTOINCREM: string           read FAUTOINCREM write FAUTOINCREM;
    property ATI_TABPRE: Nullable<string> read FATI_TABPRE write FATI_TABPRE;
    property ATI_PERCOM: Nullable<double> read FATI_PERCOM write FATI_PERCOM;
    property ATI_CODVEL: Nullable<string> read FATI_CODVEL write FATI_CODVEL;
    property ATI_RENPRE: Nullable<double> read FATI_RENPRE write FATI_RENPRE;
    property ATI_CODGAT: Nullable<string> read FATI_CODGAT write FATI_CODGAT;
  end;

implementation

end.
