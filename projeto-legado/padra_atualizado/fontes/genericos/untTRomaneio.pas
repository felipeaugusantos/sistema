unit untTRomaneio;

interface

Uses Classes, StrUtils, SysUtils, Uni, Aurelius.Mapping.Attributes,
     Aurelius.Types.Nullable, untTMotorista, Aurelius.Types.Proxy;

Type

  [Entity]
  [Table('ROMGERX')]
  [Id('FAutoIncremento', TIdGenerator.None)]
  TRomaneio = Class
  private
    [Column('AUTOINCREM', [TColumnProp.Required])]
    FAutoIncremento : string;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('GER_CODMOT', [], 'MOT_CODMOT')]
    FMotorista : Proxy<TMotorista>;

    [Column('GER_PLAVEI')]
    FPlacaVeiculo : string;
    [Column('GER_EMPROM')]
    FEmpresaRomaneio : String;
    [Column('GER_NUMROM')]
    FNumeroRomaneio : String;
    [Column('GER_NUMDOC')]
    FNumeroDocumento : String;

    function getMotorista : TMotorista;
    procedure setMotorista(const Value: TMotorista);

  public
    property AutoIncremento  : string     Read FAutoIncremento  Write FAutoIncremento;
    property Motorista       : TMotorista Read getMotorista     Write setMotorista;
    property EmpresaRomaneio : string     Read FEmpresaRomaneio Write FEmpresaRomaneio;
    property NumeroRomaneio  : string     Read FNumeroRomaneio  Write FNumeroRomaneio;
    property NumeroDocumento : string     Read FNumeroDocumento Write FNumeroDocumento;
    property PlacaVeiculo    : String     Read FPlacaVeiculo    Write FPlacaVeiculo;
  End;

implementation

{ TRomaneio }

function TRomaneio.getMotorista: TMotorista;
begin
  Result := FMotorista.Value;
end;

procedure TRomaneio.setMotorista(const Value: TMotorista);
begin
  FMotorista.Value := Value;
end;

end.
