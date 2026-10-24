unit untTDirGpoRepository;

interface

uses Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults, Aurelius.Criteria.Expression, untTDirGpo, untFuncoesSimples;

Type
  TFiltros = class sealed
  Public
    strNomFrm: TFieldFiltros<String>;
    intCodGpo: TFieldFiltros<Integer>;

    Constructor Create;
  End;

  TDirGpoRepository = class
  Private
    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TDirGpo>;
  Public
    function fRetTodos: TList<TDirGpo>;
    function fReTDirGrupoByFrm(strNomFrm: String): TList<TDirGpo>;
    function fReTDirGrupoByCod(intCodGpo: Integer): TList<TDirGpo>;
    function fReTDirGrupoByCodFrm(intCodGpo: Integer; strNomFrm: String): TDirGpo;

    procedure pGravar(ADirGpo: TDirGpo);
    procedure pAtualizar(ADirGpo: TDirGpo);
    procedure pExcluir(ADirGpo: TDirGpo);

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

{ TFiltros }

constructor TFiltros.Create;
begin
  strNomFrm := '';
  intCodGpo := 0;
end;

{ TDirGpoRepository }

constructor TDirGpoRepository.Create;
begin
  blnCriouObj := False;
  frwk        := fCriaObjManager(blnCriouObj);
end;

destructor TDirGpoRepository.Destroy;
begin
  if blnCriouObj then FreeAndNil(frwk);
  inherited;
end;

function TDirGpoRepository.fExecutaList(Filter: TFiltros): TList<TDirGpo>;
  var
    lstDirGpo: TList<TDirGpo>;
begin
  lstDirGpo := fFiltrar<TDirGpo>(Filter).List<TDirGpo>;

  if (not Assigned(lstDirGpo)) or (lstDirGpo.Count <= 0) then
    Result := nil
  else
    Result := lstDirGpo;
end;

function TDirGpoRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  var
    ACriteria  : TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  {**************************}
  {* NOME FORMULÁRIO        *}
  {***********************DF*}
  if (not fEmptyStr(Filter.strNomFrm)) then
    ACriteria.Add(TExpression.Eq('FDIR_NOMFRM', Filter.strNomFrm));

  {**************************}
  {* CÓDIGO OPERADOR        *}
  {***********************DF*}
  if (Filter.intCodGpo.Value > 0) then
    ACriteria.Add(TExpression.Eq('FGPO_CODGPO', Filter.intCodGpo.Value));

  ACriteria.SubCriteria('FOBJ_CADGPO').AddOrder(TOrder.Asc('FGPO_DESCRI'));

  Result := ACriteria;
end;

function TDirGpoRepository.fReTDirGrupoByCod(intCodGpo: Integer): TList<TDirGpo>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.intCodGpo := intCodGpo;

  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

function TDirGpoRepository.fReTDirGrupoByCodFrm(intCodGpo: Integer; strNomFrm: String): TDirGpo;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.intCodGpo := intCodGpo;
  Filter.strNomFrm := strNomFrm;

  Result := fExecutaList(Filter).First;

  FreeAndNil(Filter);
end;

function TDirGpoRepository.fReTDirGrupoByFrm(strNomFrm: String): TList<TDirGpo>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strNomFrm := strNomFrm;

  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

function TDirGpoRepository.fRetTodos: TList<TDirGpo>;
begin
  Result := fExecutaList(TFiltros.Create);
end;

procedure TDirGpoRepository.pAtualizar(ADirGpo: TDirGpo);
begin
  frwk.objDBManager.Update(ADirGpo);
end;

procedure TDirGpoRepository.pExcluir(ADirGpo: TDirGpo);
begin
  frwk.objDBManager.Remove(ADirGpo);
end;

procedure TDirGpoRepository.pGravar(ADirGpo: TDirGpo);
begin
  frwk.objDBManager.SaveOrUpdate(ADirGpo);
end;

end.
