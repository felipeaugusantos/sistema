unit untTCadCli;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy;

type
  [Entity]
  [Table('CADCLI')]
  [UniqueKey('CLI_CODCLI')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadCli = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;

    [Column('CLI_CODCLI', [TColumnProp.Required], 8)]
    FCLI_CODCLI: string;

    [Column('CLI_NOMCLI', [], 60)]
    FCLI_NOMCLI: Nullable<string>;

    [Column('CLI_CELULA', [], 15)]
    FCLI_CELULA: Nullable<string>;
  public
    property strAutInc: string            read FAUTOINCREM write FAUTOINCREM;
    property strCodCli: string            read FCLI_CODCLI write FCLI_CODCLI;
    property strNomCli: Nullable<string>  read FCLI_NOMCLI write FCLI_NOMCLI;
    property strCelula: Nullable<string>  read FCLI_CELULA write FCLI_CELULA;
  End;

implementation

end.
