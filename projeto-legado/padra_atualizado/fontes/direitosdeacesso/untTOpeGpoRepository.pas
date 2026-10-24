unit untTOpeGpoRepository;

interface

uses Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults, Aurelius.Criteria.Expression, untTOpeGpo, untFuncoesSimples;

Type
  TFiltros = class sealed
  Public
    strCodOpe: TFieldFiltros<String>;
    intCodGpo: TFieldFiltros<Integer>;

    Constructor Create;
  End;

  TOpeGpoRepository = class
  Private
    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TOpeGpo>;
  Public
    function fRetTodos: TList<TOpeGpo>;
    function fRetOpeGpoByCodOpe(strCodOpe: String): TList<TOpeGpo>;
    function fRetOpeGpoByCodGpo(intCodGpo: Integer): TList<TOpeGpo>;
    function fRetDirOperadorByCodFrm(intCodGpo: Integer; strCodOpe: String): TOpeGpo;

    procedure pAtualiza(AOpeGpo: TOpeGpo);
    procedure pGrava(AOpeGpo: TOpeGpo);
    procedure pDeleta(AOpeGpo: TOpeGpo);

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

{ TFiltros }

constructor TFiltros.Create;
begin
  strCodOpe := '';
  intCodGpo := 0;
end;

{ TOpeGpoRepository }

constructor TOpeGpoRepository.Create;
begin
  blnCriouObj := False;
  frwk        := fCriaObjManager(blnCriouObj);
end;

destructor TOpeGpoRepository.Destroy;
begin
  if blnCriouObj then FreeAndNil(frwk);
  inherited;
end;

function TOpeGpoRepository.fExecutaList(Filter: TFiltros): TList<TOpeGpo>;
  var
    lstOpeGpo: TList<TOpeGpo>;
begin
  lstOpeGpo := fFiltrar<TOpeGpo>(Filter).List<TOpeGpo>;

  if (not Assigned(lstOpeGpo)) or (lstOpeGpo.Count <= 0) then
    Result := nil
  else
    Result := lstOpeGpo;
end;

function TOpeGpoRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
var
    ACriteria  : TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  {**************************}
  {* CÓDIGO OPERADOR        *}
  {***********************DF*}
  if (not fEmptyStr(Filter.strCodOpe)) then
    ACriteria.Add(TExpression.Eq('OPE_CODOPE', Filter.strCodOpe));

  {**************************}
  {* CÓDIGO GRUPO           *}
  {***********************DF*}
  if (Filter.intCodGpo.Value > 0) then
    ACriteria.Add(TExpression.Eq('GPO_CODGPO', Filter.intCodGpo.Value));

  Result := ACriteria;
end;

function TOpeGpoRepository.fRetDirOperadorByCodFrm(intCodGpo: Integer; strCodOpe: String): TOpeGpo;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodOpe := strCodOpe;
  Filter.intCodGpo := intCodGpo;

  Result := fExecutaList(Filter).First;

  FreeAndNil(Filter);
end;

function TOpeGpoRepository.fRetOpeGpoByCodGpo(intCodGpo: Integer): TList<TOpeGpo>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.intCodGpo := intCodGpo;

  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

function TOpeGpoRepository.fRetOpeGpoByCodOpe(strCodOpe: String): TList<TOpeGpo>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodOpe := strCodOpe;

  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

function TOpeGpoRepository.fRetTodos: TList<TOpeGpo>;
begin
  Result := fExecutaList(TFiltros.Create);
end;

procedure TOpeGpoRepository.pAtualiza(AOpeGpo: TOpeGpo);
begin
  frwk.objDBManager.Update(AOpeGpo);
end;

procedure TOpeGpoRepository.pDeleta(AOpeGpo: TOpeGpo);
begin
  frwk.objDBManager.Remove(AOpeGpo);
end;

procedure TOpeGpoRepository.pGrava(AOpeGpo: TOpeGpo);
begin
  frwk.objDBManager.Save(AOpeGpo);
end;

end.
