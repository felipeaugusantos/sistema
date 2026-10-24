unit untTDirOpeRepository;

interface

uses Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults, Aurelius.Criteria.Expression, untTDirOpe, untFuncoesSimples;

Type
  TFiltros = class sealed
  Public
    strNomFrm: TFieldFiltros<String>;
    strCodOpe: TFieldFiltros<String>;

    Constructor Create;
  End;

  TDirOpeRepository = class
  Private
    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TDirOpe>;
  Public
    function fRetTodos: TList<TDirOpe>;
    function fRetDirOperadorByFrm(strNomFrm: String): TList<TDirOpe>;
    function fRetDirOperadorByCod(strCodOpe: String): TList<TDirOpe>;
    function fRetDirOperadorByCodFrm(strCodOpe, strNomFrm: String): TDirOpe;

    procedure pGravar(ADirOpe: TDirOpe);
    procedure pAtualizar(ADirOpe: TDirOpe);
    procedure pExcluir(ADirOpe: TDirOpe);

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

{ TFiltros }

constructor TFiltros.Create;
begin
  strNomFrm := '';
  strCodOpe := '';
end;

{ TDirOpeRepository }

constructor TDirOpeRepository.Create;
begin
  blnCriouObj := False;
  frwk        := fCriaObjManager(blnCriouObj);
end;

destructor TDirOpeRepository.Destroy;
begin
  if blnCriouObj then FreeAndNil(frwk);
  inherited;
end;

function TDirOpeRepository.fExecutaList(Filter: TFiltros): TList<TDirOpe>;
  var
    lstDirOpe: TList<TDirOpe>;
begin
  lstDirOpe := fFiltrar<TDirOpe>(Filter).List<TDirOpe>;

  if (not Assigned(lstDirOpe)) or (lstDirOpe.Count <= 0) then
    Result := nil
  else
    Result := lstDirOpe;
end;

function TDirOpeRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  {**************************}
  {* NOME FORMULÁRIO DIROPE *}
  {***********************DF*}
  if (not fEmptyStr(Filter.strNomFrm)) then
    ACriteria.Add(TExpression.Eq('FDIR_NOMFRM', Filter.strNomFrm));

  {**************************}
  {* CÓDIGO OPERADOR DIROPE *}
  {***********************DF*}
  if (not fEmptyStr(Filter.strCodOpe)) then
    ACriteria.Add(TExpression.Eq('FOPE_CODOPE', Filter.strCodOpe));

  ACriteria.SubCriteria('FOBJ_CADOPE').AddOrder(TOrder.Asc('FOPE_NOMOPE'));

  Result := ACriteria;
end;

function TDirOpeRepository.fRetDirOperadorByCod(strCodOpe: String): TList<TDirOpe>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodOpe := strCodOpe;
  
  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

function TDirOpeRepository.fRetDirOperadorByCodFrm(strCodOpe, strNomFrm: String): TDirOpe;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodOpe := strCodOpe;
  Filter.strNomFrm := strNomFrm;

  Result := fExecutaList(Filter).First;

  FreeAndNil(Filter);
end;

function TDirOpeRepository.fRetDirOperadorByFrm(strNomFrm: String): TList<TDirOpe>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strNomFrm := strNomFrm;

  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

function TDirOpeRepository.fRetTodos: TList<TDirOpe>;
begin
  Result := fExecutaList(TFiltros.Create);
end;

procedure TDirOpeRepository.pAtualizar(ADirOpe: TDirOpe);
begin
  frwk.objDBManager.Update(ADirOpe);
end;

procedure TDirOpeRepository.pExcluir(ADirOpe: TDirOpe);
begin
  frwk.objDBManager.Remove(ADirOpe);
end;

procedure TDirOpeRepository.pGravar(ADirOpe: TDirOpe);
begin
  frwk.objDBManager.Save(ADirOpe);
end;

end.
