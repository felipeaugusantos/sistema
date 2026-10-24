unit untTAlteracaoIndividualChecklist;

interface

uses
  System.Classes;

Type
  TAlteracaoIndividualGrupo = class;

  TAlteracaoIndividualChecklist = class
  Private
    FAltIndGarantia,
    FAltIndTroca: TAlteracaoIndividualGrupo;
  public
    constructor Create;
    destructor Destroy;Override;
    property objAltIndTroca: TAlteracaoIndividualGrupo Read FAltIndTroca Write FAltIndTroca;
    property objAltIndGarantia: TAlteracaoIndividualGrupo Read FAltIndGarantia Write FAltIndGarantia;
  end;

  TAlteracaoIndividualGrupo = class
  Private
    FlstCkl,
    FlstCklNovo: TStringList;
    procedure pCriarLista(var pstlCkl: TStringList);
    function fGetParNomeValor(const strNome, strValor: String): String;

  Private
    const
      CHAR_SEPARADOR: Char  = '=';

  public
    Constructor Create;
    Destructor Destroy; Override;
    procedure pAdicionar(const strCodIte, strJsonCklNovo: String; const strJsonCkl: String = '');
    function fObterNovoValor(const strCodIte: String; Out strJsonCklAnterior: String): String;
    function fIndex(const strCodIte: String): Integer;
  end;

implementation

uses
  System.SysUtils;

{ TAlteracaoIndividualGrupo }

constructor TAlteracaoIndividualGrupo.Create;
begin
  pCriarLista(FlstCkl);
  pCriarLista(FlstCklNovo);
end;

destructor TAlteracaoIndividualGrupo.Destroy;
begin
  FlstCkl.Free;
  FlstCklNovo.Free;
  inherited;
end;

function TAlteracaoIndividualGrupo.fGetParNomeValor(const strNome, strValor: String): String;
begin
  Result := strNome +CHAR_SEPARADOR+strValor;
end;

function TAlteracaoIndividualGrupo.fIndex(const strCodIte: String): Integer;
begin
  Result := FlstCkl.IndexOfName(strCodIte);
end;

function TAlteracaoIndividualGrupo.fObterNovoValor(const strCodIte: String; out strJsonCklAnterior: String): String;
  Var
    intIdx: Integer;
begin
  intIdx := FlstCkl.IndexOfName(strCodIte);
  if intIdx >= 0 then
    strJsonCklAnterior := FlstCkl.ValueFromIndex[intIdx]
  else
    strJsonCklAnterior := EmptyStr;

  intIdx := FlstCklNovo.IndexOfName(strCodIte);
  if intIdx >= 0 then
    Result := FlstCklNovo.ValueFromIndex[intIdx]
  else
    Result := EmptyStr;

end;

procedure TAlteracaoIndividualGrupo.pAdicionar(const strCodIte, strJsonCklNovo: String; const strJsonCkl: String = '');
  Var
    intIdx: Integer;
begin
  intIdx := FlstCkl.IndexOfName(strCodIte);
  if intIdx = -1 then
  begin
    FlstCkl.Add(fGetParNomeValor(strCodIte, strJsonCkl));
    FlstCklNovo.Add(fGetParNomeValor(strCodIte,strJsonCklNovo));
  end
  else
  begin
    intIdx := FlstCklNovo.IndexOfName(strCodIte);
    if intIdx >= 0 then
      FlstCklNovo.ValueFromIndex[intIdx] := strJsonCklNovo
  end;
end;

procedure TAlteracaoIndividualGrupo.pCriarLista(var pstlCkl: TStringList);
begin
  if Assigned(pstlCkl) then
    FreeAndNil(pstlCkl);
  pstlCkl := TStringList.Create;
  pstlCkl.Clear;
  pstlCkl.NameValueSeparator := CHAR_SEPARADOR;
end;




{ TAlteracaoIndividualChecklist }

constructor TAlteracaoIndividualChecklist.Create;
begin
  FAltIndGarantia := TAlteracaoIndividualGrupo.Create;
  FAltIndTroca := TAlteracaoIndividualGrupo.Create;
end;

destructor TAlteracaoIndividualChecklist.Destroy;
begin
  FAltIndGarantia.Free;
  FAltIndTroca.Free;
  inherited;
end;

end.
