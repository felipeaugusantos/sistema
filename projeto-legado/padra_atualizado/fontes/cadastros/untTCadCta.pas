unit untTCadCta;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy;

type
  [Entity]
  [Table('CADCTA')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadCta = Class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;

    [Column('CTA_CODCTA', [], 7)]
    FCTA_CODCTA: Nullable<string>;

    [Column('CTA_DESCTA', [], 40)]
    FCTA_DESCTA: Nullable<string>;
  public
    property strAutInc: string            read FAUTOINCREM write FAUTOINCREM;
    property strCodCta: Nullable<string>  read FCTA_CODCTA write FCTA_CODCTA;
    property strDesCta: Nullable<string>  read FCTA_DESCTA write FCTA_DESCTA;
  End;

implementation

end.
