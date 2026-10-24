unit untTDupAgr;

interface

Uses Classes, Uni, Aurelius.Mapping.Attributes, Aurelius.Types.Nullable;

type
  [Entity]
  [Table('DUPAGR')]
  [Id('FAutInc', TIdGenerator.None)]
  TDupAgr = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required])]
    FAutInc : string;
    [Column('CTR_NUMAGR')]
    FNumeroAgrupamento : string;
    [Column('CTR_CODCLI')]
    FCodigoCliente : string;
    [Column('CTR_NUMDUP')]
    FDuplicata : string;
    [Column('CTR_PARCEL')]
    FParcela : string;
    [Column('CTR_CODEMP')]
    FCodigoEmpresa : string;
    [Column('CTR_ESPDOC')]
    FEspecieDocumento  : string;
  public
    property AutoIncrem       : String  Read FAutInc            Write FAutInc;
    property NumeroAgrupamento: String  Read FNumeroAgrupamento Write FNumeroAgrupamento;
    property CodigoCliente    : string  Read FCodigoCliente     Write FCodigoCliente;
    property Duplicata        : string  Read FDuplicata         Write FDuplicata;
    property Parcela          : string  Read FParcela           Write FParcela;
    property CodigoEmpresa    : string  Read FCodigoEmpresa     Write FCodigoEmpresa;
    property EspecieDocumento : string  Read FEspecieDocumento  Write FEspecieDocumento;
  end;

implementation

end.
