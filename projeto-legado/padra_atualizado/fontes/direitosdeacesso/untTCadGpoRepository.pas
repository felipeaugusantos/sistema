unit untTCadGpoRepository;

interface

uses Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults, Aurelius.Criteria.Expression, untTCadGpo, untFuncoesSimples;

Type
  TFiltros = class sealed
  Public
    strCodGpo: TFieldFiltros<String>;
    strCodEmp: TFieldFiltros<String>;

    Constructor Create;
  End;

  TCadGpoRepository = class
  Private
    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TCadGpo>;
  Public
    Constructor Create;
    Destructor Destroy; Override;

    function fRetTodos: TList<TCadGpo>; overload;
    function fRetTodos(strCodEmp: String): TList<TCadGpo>; overload;
    function fRetGrupoByCodGpo(strCodGpo: String): TCadGpo;
    function fRetGrupoByCodEmp(strCodEmp: String): TList<TCadGpo>;
  End;

implementation

{ TFiltros }

constructor TFiltros.Create;
begin
  strCodGpo := '';
  strCodEmp := '';
end;

{ TCadGpoRepository }

constructor TCadGpoRepository.Create;
begin
  blnCriouObj := False;
  frwk        := fCriaObjManager(blnCriouObj);
end;

destructor TCadGpoRepository.Destroy;
begin
  if blnCriouObj then FreeAndNil(frwk);
  inherited;
end;

function TCadGpoRepository.fExecutaList(Filter: TFiltros): TList<TCadGpo>;
  var
    lstCadGpo: TList<TCadGpo>;
begin
  lstCadGpo := fFiltrar<TCadGpo>(Filter).List<TCadGpo>;

  if (not Assigned(lstCadGpo)) or (lstCadGpo.Count <= 0) then
    Result := nil
  else
    Result := lstCadGpo;
end;

function TCadGpoRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  var
    ACriteria  : TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  {**************************}
  {* CÓDIGO DO GRUPO        *}
  {***********************DF*}
  if (not fEmptyStr(Filter.strCodGpo)) then
    ACriteria.Add(TExpression.Eq('FGPO_CODGPO', Filter.strCodGpo))
  else
    {**************************}
    {* CÓDIGO DA EMPRESA      *}
    {***********************DF*}
    if (not fEmptyStr(Filter.strCodEmp)) then
      ACriteria.Add(TExpression.Eq('FGPO_CODEMP', Filter.strCodGpo))
    else
      raise Exception.Create('Empresa deve ser informada para o filtro de grupos de operadores. [TCadGpoRepository.fFiltrar]');

  ACriteria.AddOrder(TOrder.Asc('FGPO_DESCRI'));

  Result := ACriteria;
end;

function TCadGpoRepository.fRetGrupoByCodEmp(strCodEmp: String): TList<TCadGpo>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodEmp := strCodEmp;

  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

function TCadGpoRepository.fRetGrupoByCodGpo(strCodGpo: String): TCadGpo;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodGpo := strCodGpo;

  Result := fExecutaList(Filter).First;

  FreeAndNil(Filter);
end;

function TCadGpoRepository.fRetTodos: TList<TCadGpo>;
begin
  Result := fExecutaList(TFiltros.Create);
end;

function TCadGpoRepository.fRetTodos(strCodEmp: String): TList<TCadGpo>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodEmp := strCodEmp;

  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

end.
