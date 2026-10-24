unit untTMotorista;

interface

Uses Classes, StrUtils, SysUtils, Uni, Aurelius.Mapping.Attributes, Aurelius.Types.Nullable;

Type

  [Entity]
  [Table('CADMOT')]
  [Id('FAutoIncremento', TIdGenerator.None)]
  TMotorista = Class
  private
    [Column('AUTOINCREM', [TColumnProp.Required])]
    FAutoIncremento : string;
    [Column('MOT_CODMOT')]
    FCodigoMotorista : string;
    [Column('MOT_NOMMOT')]
    FNomeMotorista : string;

    function GetDescricao : String;

  public
    property AutoIncremento  : string Read FAutoIncremento  Write FAutoIncremento;
    property CodigoMotorista : string Read FCodigoMotorista Write FCodigoMotorista;
    property Descricao       : string read GetDescricao;
    property NomeMotorista   : string Read FNomeMotorista   Write FNomeMotorista;
  End;

implementation

{ TMotorista }

function TMotorista.GetDescricao: String;
begin
  Result := FCodigoMotorista + '-' + FNomeMotorista;
end;

end.
