unit untTOpeGpo;

interface

uses Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Proxy, untTCadOpe, untTCadGpo;

Type
  [Entity]
  [Table('OPEGPO')]
  [Id('FOPE_CODOPE', TIdGenerator.None)]
  [Id('FGPO_CODGPO', TIdGenerator.None)]
  TOpeGpo = class
  private
    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('OPE_CODOPE', [], 'OPE_CODOPE')]
    FOBJ_CADOPE: Proxy<TCadOpe>;

    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('GPO_CODGPO', [], 'GPO_CODGPO')]
    FOBJ_CADGPO: Proxy<TCadGpo>;

    [Column('OPE_CODOPE', [TColumnProp.Required], 3)]
    FOPE_CODOPE: String;

    [Column('GPO_DESCRI', [TColumnProp.Required], 11)]
    FGPO_CODGPO: Integer;

    function fGetCadOpe: TCadOPe;
    function fGetCadGpo: TCadGpo;

    procedure pSetCadOpe(const Value: TCadOpe);
    procedure pSetCadGpo(const Value: TCadGpo);
  public
    Constructor Create;

    property OPE_CODOPE: String  Read FOPE_CODOPE Write FOPE_CODOPE;
    property GPO_CODGPO: Integer Read FGPO_CODGPO Write FGPO_CODGPO;

    property objCadOpe: TCadOpe Read fGetCadOpe  Write pSetCadOpe;
    property objCadGpo: TCadGpo Read fGetCadGpo  Write pSetCadGpo;
  end;

implementation

{ TOpeGpo }

constructor TOpeGpo.Create;
begin
  FOPE_CODOPE := '';
  FGPO_CODGPO := 0;
end;

function TOpeGpo.fGetCadGpo: TCadGpo;
begin
  Result := FOBJ_CADGPO.Value;
end;

function TOpeGpo.fGetCadOpe: TCadOPe;
begin
  Result := FOBJ_CADOPE.Value;
end;

procedure TOpeGpo.pSetCadGpo(const Value: TCadGpo);
begin
  FOBJ_CADGPO.Value := Value;
end;

procedure TOpeGpo.pSetCadOpe(const Value: TCadOpe);
begin
  FOBJ_CADOPE.Value := Value;
end;

end.
