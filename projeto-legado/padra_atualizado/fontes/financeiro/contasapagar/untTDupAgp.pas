unit untTDupAgp;

interface

Uses Classes, Uni, Aurelius.Mapping.Attributes, Aurelius.Types.Nullable;

type
  [Entity]
  [Table('DUPAGP')]
  [Id('FAutInc', TIdGenerator.None)]
  TDupAgp = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required])]
    FAutInc : string;
    [Column('CTP_NUMAGR')]
    FNumeroAgrupamento : string;
    [Column('CTP_CODFOR')]
    FCodigoFornecedor : string;
    [Column('CTP_NUMDUP')]
    FDuplicata : string;
    [Column('CTP_PARCEL')]
    FParcela : string;
    [Column('CTP_CODEMP')]
    FCodigoEmpresa : string;
    [Column('CTP_SERIE_')]
    FSerie_  : string;
  public
    property AutoIncrem       : String  Read FAutInc            Write FAutInc;
    property NumeroAgrupamento: String  Read FNumeroAgrupamento Write FNumeroAgrupamento;
    property CodigoFornecedor : string  Read FCodigoFornecedor  Write FCodigoFornecedor;
    property Duplicata        : string  Read FDuplicata         Write FDuplicata;
    property Parcela          : string  Read FParcela           Write FParcela;
    property CodigoEmpresa    : string  Read FCodigoEmpresa     Write FCodigoEmpresa;
    property Serie_           : string  Read FSerie_            Write FSerie_;
  end;

implementation

end.
