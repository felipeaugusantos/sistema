unit UntTCadPagRomaneio;

interface

Uses Classes, StrUtils, SysUtils, Uni, Aurelius.Mapping.Attributes, Aurelius.Types.Nullable,
     untTRomaneio, Aurelius.Types.Proxy;

Type

  [Entity]
  [Table('PAGROM')]
  [Id('FAutoIncremento', TIdGenerator.None)]
  TCadPagRomaneio = Class
  private
    [Column('AUTOINCREM', [TColumnProp.Required])]
    FAutoIncremento : string;
    [Column('PGR_CODFOR')]
    FCodigoFornecedor: string;
    [Column('PGR_NUMDUP')]
    FNumeroDuplicata : string;
    [Column('PGR_SERIE_')]
    FSerie : String;
    [Column('PGR_CODEMP')]
    FCodigoEmpresa: String;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('PGR_AUTROM', [], 'AUTOINCREM')]
    FRomaneio : Proxy<TRomaneio>;

    function getRomaneio : TRomaneio;
    procedure setRomaneio(const Value: TRomaneio);

  public
    property AutoIncremento   : string    Read FAutoIncremento   Write FAutoIncremento;
    property CodigoFornecedor : string    Read FCodigoFornecedor Write FCodigoFornecedor;
    property CodigoEmpresa    : String    Read FCodigoEmpresa    Write FCodigoEmpresa;
    property NumeroDuplicata  : string    Read FNumeroDuplicata  Write FNumeroDuplicata;
    property Romaneio         : TRomaneio Read getRomaneio       Write setRomaneio;
    property Serie            : string    Read FSerie            Write FSerie;
  End;

implementation

{ TCadPagRomaneio }

function TCadPagRomaneio.getRomaneio: TRomaneio;
begin
  result := FRomaneio.Value;
end;

procedure TCadPagRomaneio.setRomaneio(const Value: TRomaneio);
begin
  FRomaneio.Value := Value;
end;

end.
