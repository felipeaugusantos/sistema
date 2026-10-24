unit untTDirOpe;

interface

uses Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Proxy, Aurelius.Types.Nullable, untTCadOpe, StrUtils;

Type
  [Entity]
  [Table('DIROPE')]
  [UniqueKey('FDIR_NOMFRM, FOPE_CODOPE')]
  [Id('FDIR_NOMFRM', TIdGenerator.None)]
  [Id('FOPE_CODOPE', TIdGenerator.None)]
  TDirOpe = class
  private
    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('OPE_CODOPE', [], 'OPE_CODOPE')]
    FOBJ_CADOPE : Proxy<TCadOpe>;

    [Column('DIR_NOMFRM', [TColumnProp.Required], 50)]
    FDIR_NOMFRM: String;

    [Column('OPE_CODOPE', [TColumnProp.Required], 3)]
    FOPE_CODOPE: String;

    [Column('DIR_ACAOUS', [], 3)]
    FDIR_ACAOUS: Nullable<String>;

    function  fGetCadOpe: TCadOpe;
    procedure pSetCadOpe(const Value: TCadOpe);

    function fPermiteIncluir: Boolean;
    function fPermiteAlterar: Boolean;
    function fPermiteExcluir: Boolean;
    function fPermissaoTotal: Boolean;
  public
    Constructor Create; overload;
    Constructor Create(strNomeFrm, strCodOpe: String); overload;

    procedure pSetDirAcessoEspecificoGrupo(blnInserir, blnAlterar, blnExcluir: Boolean);

    property DIR_NOMFRM: String           Read FDIR_NOMFRM Write FDIR_NOMFRM;
    property OPE_CODOPE: String           Read FOPE_CODOPE Write FOPE_CODOPE;
    property DIR_ACAOUS: Nullable<String> Read FDIR_ACAOUS Write FDIR_ACAOUS;

    property objCadOpe     : TCadOpe Read fGetCadOpe   Write pSetCadOpe;
    property permiteIncluir: Boolean Read fPermiteIncluir;
    property permiteAlterar: Boolean Read fPermiteAlterar;
    property permiteExcluir: Boolean Read fPermiteExcluir;
    property permissaoTotal: Boolean Read fPermissaoTotal;
  end;

implementation

{ TDirOpe }

constructor TDirOpe.Create;
begin
  Self.FDIR_NOMFRM := '';
  Self.FOPE_CODOPE := '';
  Self.FDIR_ACAOUS := 'IAE';
end;

constructor TDirOpe.Create(strNomeFrm, strCodOpe: String);
begin
  Self.FDIR_NOMFRM := strNomeFrm;
  Self.FOPE_CODOPE := strCodOpe;
  Self.FDIR_ACAOUS := 'IAE';
end;

procedure TDirOpe.pSetCadOpe(const Value: TCadOpe);
begin
  Self.FOBJ_CADOPE.Value := Value;
end;

procedure TDirOpe.pSetDirAcessoEspecificoGrupo(blnInserir, blnAlterar, blnExcluir: Boolean);
begin
  Self.FDIR_ACAOUS := ifThen(blnInserir, 'I', '') + ifThen(blnAlterar, 'A', '') + ifThen(blnExcluir, 'E', '');
end;

function TDirOpe.fGetCadOpe: TCadOpe;
begin
  Result := Self.FOBJ_CADOPE.Value;
end;

function TDirOpe.fPermissaoTotal: Boolean;
begin
   Result := ((Self.permiteIncluir) and (Self.permiteAlterar) and (Self.permiteExcluir))
end;

function TDirOpe.fPermiteAlterar: Boolean;
begin
  Result := (Pos('A', Self.FDIR_ACAOUS) > 0);
end;

function TDirOpe.fPermiteExcluir: Boolean;
begin
  Result := (Pos('E', Self.FDIR_ACAOUS) > 0);
end;

function TDirOpe.fPermiteIncluir: Boolean;
begin
  Result := (Pos('I', Self.FDIR_ACAOUS) > 0);
end;

end.
