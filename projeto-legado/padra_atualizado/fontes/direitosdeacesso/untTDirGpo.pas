unit untTDirGpo;

interface

uses Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Proxy, Aurelius.Types.Nullable, untTCadGpo, StrUtils;

Type
  [Entity]
  [Table('DIRGPO')]
  [UniqueKey('FDIR_NOMFRM, FGPO_CODGPO')]
  [Id('FDIR_NOMFRM', TIdGenerator.None)]
  [Id('FGPO_CODGPO', TIdGenerator.None)]
  TDirGpo = class
  private
    [Association([TAssociationProp.Lazy], [])]
    [JoinColumn('GPO_CODGPO', [], 'GPO_CODGPO')]
    FOBJ_CADGPO : Proxy<TCadGpo>;

    [Column('DIR_NOMFRM', [TColumnProp.Required], 50)]
    FDIR_NOMFRM: String;

    [Column('GPO_CODGPO', [TColumnProp.Required], 11)]
    FGPO_CODGPO: Integer;

    [Column('DIR_ACAOUS', [], 3)]
    FDIR_ACAOUS: Nullable<String>;

    function  fGetCadGpo: TCadGpo;
    procedure pSetCadGpo(const Value: TCadGpo);

    function fPermiteIncluir: Boolean;
    function fPermiteAlterar: Boolean;
    function fPermiteExcluir: Boolean;
    function fPermissaoTotal: Boolean;
  public
    Constructor Create; overload;
    Constructor Create(strNomeFrm:String; intCodGpo: Integer); overload;

    procedure pSetDirAcessoEspecificoGrupo(blnInserir, blnAlterar, blnExcluir: Boolean);

    property DIR_NOMFRM: String           Read FDIR_NOMFRM Write FDIR_NOMFRM;
    property GPO_CODGPO: Integer          Read FGPO_CODGPO Write FGPO_CODGPO;
    property DIR_ACAOUS: Nullable<String> Read FDIR_ACAOUS Write FDIR_ACAOUS;

    property objCadGpo     : TCadGpo Read fGetCadGpo      Write pSetCadGpo;
    property permiteIncluir: Boolean Read fPermiteIncluir;
    property permiteAlterar: Boolean Read fPermiteAlterar;
    property permiteExcluir: Boolean Read fPermiteExcluir;
    property permissaoTotal: Boolean Read fPermissaoTotal;
  end;

implementation

{ TCadGpo }

constructor TDirGpo.Create;
begin
  Self.FDIR_NOMFRM := '';
  Self.FGPO_CODGPO := 0;
  Self.FDIR_ACAOUS := 'IAE';
end;

constructor TDirGpo.Create(strNomeFrm:String; intCodGpo: Integer);
begin
  Self.FDIR_NOMFRM := strNomeFrm;
  Self.FGPO_CODGPO := intCodGpo;
  Self.FDIR_ACAOUS := 'IAE';
end;

procedure TDirGpo.pSetCadGpo(const Value: TCadGpo);
begin
  Self.FOBJ_CADGPO.Value := Value;
end;

procedure TDirGpo.pSetDirAcessoEspecificoGrupo(blnInserir, blnAlterar, blnExcluir: Boolean);
begin
  Self.FDIR_ACAOUS := ifThen(blnInserir, 'I', '') + ifThen(blnAlterar, 'A', '') + ifThen(blnExcluir, 'E', '');
end;

function TDirGpo.fGetCadGpo: TCadGpo;
begin
  Result := Self.FOBJ_CADGPO.Value;
end;

function TDirGpo.fPermissaoTotal: Boolean;
begin
   Result := ((Self.permiteIncluir) and (Self.permiteAlterar) and (Self.permiteExcluir))
end;

function TDirGpo.fPermiteAlterar: Boolean;
begin
  Result := (Pos('A', Self.FDIR_ACAOUS) > 0);
end;

function TDirGpo.fPermiteExcluir: Boolean;
begin
  Result := (Pos('E', Self.FDIR_ACAOUS) > 0);
end;

function TDirGpo.fPermiteIncluir: Boolean;
begin
  Result := (Pos('I', Self.FDIR_ACAOUS) > 0);
end;

end.
