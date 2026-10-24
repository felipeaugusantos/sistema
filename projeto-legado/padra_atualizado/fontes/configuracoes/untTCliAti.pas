unit untTCliAti;

interface

uses
  SysUtils, Generics.Collections, Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable, Aurelius.Types.Proxy, untTCadAti;

type
  [Entity]
  [Table('CLIATI')]
  [UniqueKey('ATI_CODATI, ATI_CODEMP')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCliAti = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: string;

    [Column('ATI_CODATI', [TColumnProp.Required], 3)]
    FATI_CODATI: string;

    [Column('ATI_CODEMP', [TColumnProp.Required], 3)]
    FATI_CODEMP: string;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('ATI_CODATI', [], 'ATI_CODATI')]
    FCadAti : Proxy<TCadAti>;
    function getCadAti: TCadAti;
    procedure setCadAti(const Value: TCadAti);
  public
    property AUTOINCREM: string  read FAUTOINCREM write FAUTOINCREM;
    property ATI_CODATI: string  read FATI_CODATI write FATI_CODATI;
    property ATI_CODEMP: string  read FATI_CODEMP write FATI_CODEMP;
    property objCadAti : TCadAti read getCadAti   write setCadAti;
  end;

implementation

uses untFuncoesSimples;

{ TCliAti }

function TCliAti.getCadAti: TCadAti;
begin
  Result := FCadAti.Value;
end;

procedure TCliAti.setCadAti(const Value: TCadAti);
begin
  FCadAti.Value := Value;
end;

end.
