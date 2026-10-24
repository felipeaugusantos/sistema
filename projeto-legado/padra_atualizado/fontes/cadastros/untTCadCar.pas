unit untTCadCar;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy;

type
  [Entity]
  [Table('CADCAR')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadCar = Class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;

    [Column('CAR_CODCAR', [TColumnProp.Required], 5)]
    FCAR_CODCAR: string;

    [Column('CAR_DESCAR', [TColumnProp.Required], 40)]
    FCAR_DESCAR: string;

    [Column('CAR_NOMBAN', [], 30)]
    FCAR_NOMBAN: Nullable<string>;
  public
    property strAutInc: string            read FAUTOINCREM write FAUTOINCREM;
    property strCodCar: string            read FCAR_CODCAR write FCAR_CODCAR;
    property strDesCar: string            read FCAR_DESCAR write FCAR_DESCAR;
    property strNomBan: Nullable<string>  read FCAR_NOMBAN write FCAR_NOMBAN;
  End;

implementation

end.
