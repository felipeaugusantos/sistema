unit untTCadCCa;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy;

type
  [Entity]
  [Table('CADCCA')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadCCa = Class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;

    [Column('CCA_CODBCO', [], 3)]
    FCCA_CODBCO: Nullable<string>;

    [Column('CCA_AGENCI', [], 50)]
    FCCA_AGENCI: Nullable<string>;

    [Column('CCA_CODCTA', [], 50)]
    FCCA_CODCTA: Nullable<string>;

    [Column('CCA_CHVOFX', [], 30)]
    FCCA_CHVOFX: Nullable<string>;

    [Column('CCA_DIGCTA', [], 4)]
    FCCA_DIGCTA: Nullable<string>;
  public
    property AutoIncremento : string            read FAUTOINCREM write FAUTOINCREM;
    property CodigoBanco    : Nullable<string>  read FCCA_CODBCO write FCCA_CODBCO;
    property CodigoAgencia  : Nullable<string>  read FCCA_AGENCI write FCCA_AGENCI;
    property CodigoConta    : Nullable<string>  read FCCA_CODCTA write FCCA_CODCTA;
    property DigitoConta    : Nullable<string>  read FCCA_DIGCTA write FCCA_DIGCTA;
    property ChaveOFX       : Nullable<string>  read FCCA_CHVOFX write FCCA_CHVOFX;
  End;

implementation

end.
