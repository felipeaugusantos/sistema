unit untTEmaEnv;

interface

Uses Classes, DateUtils, StrUtils, SysUtils, Uni, Aurelius.Mapping.Attributes, Aurelius.Types.Nullable;

type
  [Entity]
  [Table('EMAENV')]
  [UniqueKey('ENV_EMACOD')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TEmaEnv = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: String;

    [Column('ENV_EMACOD', [TColumnProp.Required])]
    FENV_CODEMA: Int64;

    [Column('ENV_EMADTA', [TColumnProp.Required])]
    FENV_EMADTA: TDateTime;

    [Column('ENV_EMAHOR', [TColumnProp.Required])]
    FENV_EMAHOR: TDateTime;

    [Column('ENV_EMAIMP', [TColumnProp.Required])]
    FENV_EMAIMP: Integer;

    [Column('ENV_ANEXOS', [TColumnProp.Required])]
    FENV_ANEXOS: Integer;

    [Column('ENV_EMAREM', [TColumnProp.Required], 150)]
    FENV_EMAREM: String;

    [Column('ENV_EMADES', [TColumnProp.Required], 150)]
    FENV_EMADES: String;

    [Column('ENV_EMASTO', [TColumnProp.Required], 250)]
    FENV_EMASTO: String;

    [Column('ENV_CODOPE', [TColumnProp.Required], 3)]
    FENV_CODOPE: String;

    [Column('ENV_ZIPNOM', [TColumnProp.Required], 250)]
    FENV_ZIPNOM: String;

    [Column('ENV_CODEMP', [TColumnProp.Required], 3)]
    FENV_CODEMP: String;

    [Column('ENV_CODPRV', [])]
    FENV_CODPRV: Nullable<Integer>;

    [Column('ENV_PATEXE', [], 255)]
    FENV_PATEXE: Nullable<String>;

    [Column('ENV_VEREXE', [], 30)]
    FENV_VEREXE: Nullable<String>;

    [Column('ENV_DTAEXE', [])]
    FENV_DTAEXE: Nullable<TDateTime>;
  public
    constructor Create;

    property AUTOINCREM: String    read FAUTOINCREM write FAUTOINCREM;
    property ENV_CODEMA: Int64     read FENV_CODEMA write FENV_CODEMA;
    property ENV_EMADTA: TDateTime read FENV_EMADTA write FENV_EMADTA;
    property ENV_EMAHOR: TDateTime read FENV_EMAHOR write FENV_EMAHOR;
    property ENV_EMAIMP: Integer   read FENV_EMAIMP write FENV_EMAIMP;
    property ENV_ANEXOS: Integer   read FENV_ANEXOS write FENV_ANEXOS;
    property ENV_EMAREM: String    read FENV_EMAREM write FENV_EMAREM;
    property ENV_EMADES: String    read FENV_EMADES write FENV_EMADES;
    property ENV_EMASTO: String    read FENV_EMASTO write FENV_EMASTO;
    property ENV_CODOPE: String    read FENV_CODOPE write FENV_CODOPE;
    property ENV_ZIPNOM: String    read FENV_ZIPNOM write FENV_ZIPNOM;
    property ENV_CODEMP: String    read FENV_CODEMP write FENV_CODEMP;
    property ENV_CODPRV: Nullable<Integer> Read FENV_CODPRV Write FENV_CODPRV;
    property ENV_PATEXE: Nullable<String>  read FENV_PATEXE write FENV_PATEXE;
    property ENV_VEREXE: Nullable<String>  read FENV_VEREXE write FENV_VEREXE;
    property ENV_DTAEXE: Nullable<TDateTime> read FENV_DTAEXE write FENV_DTAEXE;
  end;

implementation

{ TEmaEnv }

constructor TEmaEnv.Create;
begin
  FAUTOINCREM := '';
  FENV_CODEMA := 0;
  FENV_EMADTA := 0;
  FENV_EMAHOR := 0;
  FENV_EMAIMP := 0;
  FENV_ANEXOS := 0;
  FENV_EMAREM := '';
  FENV_EMADES := '';
  FENV_EMASTO := '';
  FENV_CODOPE := '';
  FENV_ZIPNOM := '';
  FENV_CODEMP := '';
end;

end.
