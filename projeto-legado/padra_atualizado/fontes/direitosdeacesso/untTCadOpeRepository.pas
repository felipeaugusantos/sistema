unit untTCadOpeRepository;

interface

uses Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults, Aurelius.Criteria.Expression, untTCadOpe, untFuncoesSimples;

Type
  TFiltros = class sealed
  Public
    strCodOpe: TFieldFiltros<String>;
    intCodPrv: TFieldFiltros<Integer>;

    Const
      strOpeStatus = 'OPE_STATUS <> ''I''';

    Constructor Create;
  End;

  TOpeRepository = class
  Private
    blnCriouObj: Boolean;
  Public
    Constructor Create;
    Destructor Destroy; Override;
  End;

  TOpeAssRepository = class(TOpeRepository)
  Private
    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TOpeAss>;
  Public
    procedure pInsert(AOpeAss: TOpeAss);
    procedure pUpdate(AOpeAss: TOpeAss);
    procedure pDelete(AOpeAss: TOpeAss);
    procedure pReload(AOpeAss: TOpeAss);

    function fRetAssinaturaOperador(strCodOpe: String): TOpeAss;
  End;

  TCadOpeRepository = class(TOpeRepository)
  Private
    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TCadOpe>;
  Public
    function fRetTodos: TList<TCadOpe>;
    function fRetOperadorByCodOpe(strCodOpe: String): TCadOpe;
    function fPossuiVinculoProvedorEmail(intCodPrv: Integer): Boolean;

    procedure pReload(ACadOpe: TCadOpe);
  End;

implementation

{ TFiltros }

constructor TFiltros.Create;
begin
  strCodOpe := '';
  intCodPrv := 0;
end;

{ TOpeRepository }

constructor TOpeRepository.Create;
begin
  blnCriouObj := False;
  frwk        := fCriaObjManager(blnCriouObj);
end;

destructor TOpeRepository.Destroy;
begin
  if blnCriouObj then FreeAndNil(frwk);
  inherited;
end;

{ TCadOpeRepository }

function TCadOpeRepository.fExecutaList(Filter: TFiltros): TList<TCadOpe>;
  var
    lstCadOpe: TList<TCadOpe>;
begin
  lstCadOpe := fFiltrar<TCadOpe>(Filter).List<TCadOpe>;

  if (not Assigned(lstCadOpe)) or (lstCadOpe.Count <= 0) then
    Result := nil
  else
    Result := lstCadOpe;
end;

function TCadOpeRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  var
    ACriteria  : TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  {**************************}
  {* CÓDIGO DO OPERADOR     *}
  {***********************DF*}
  if (not fEmptyStr(Filter.strCodOpe)) then
    ACriteria.Add(TExpression.Eq('FOPE_CODOPE', Filter.strCodOpe));

  if (Filter.intCodPrv.Value > 0) then
    ACriteria.Add(TExpression.Eq('FOPE_CODPRV', Filter.intCodPrv));

  ACriteria.Add(TExpression.Sql(Filter.strOpeStatus));

  ACriteria.AddOrder(TOrder.Asc('FOPE_NOMOPE'));

  Result := ACriteria;
end;

function TCadOpeRepository.fPossuiVinculoProvedorEmail(intCodPrv: Integer): Boolean;
  var
    Filter: TFiltros;
    objCadOpe: TList<TCadOpe>;
begin
  Filter           := TFiltros.Create;
  Filter.intCodPrv := intCodPrv;

  objCadOpe := fExecutaList(Filter);

  if (Assigned(objCadOpe)) then
  begin
    Result := (objCadOpe.Count > 0);
    FreeAndNil(objCadOpe);
  end
  else
    Result := False;

  FreeAndNil(Filter);
end;

function TCadOpeRepository.fRetOperadorByCodOpe(strCodOpe: String): TCadOpe;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodOpe := strCodOpe;

  Result := fExecutaList(Filter).First;

  FreeAndNil(Filter);
end;

function TCadOpeRepository.fRetTodos: TList<TCadOpe>;
begin
  Result := fExecutaList(TFiltros.Create);
end;

procedure TCadOpeRepository.pReload(ACadOpe: TCadOpe);
begin
  frwk.objDBManager.Refresh(ACadOpe);
end;

{ TOpeAssRepository }

function TOpeAssRepository.fExecutaList(Filter: TFiltros): TList<TOpeAss>;
  var
    lstOpeAss: TList<TOpeAss>;
begin
  lstOpeAss := fFiltrar<TOpeAss>(Filter).List<TOpeAss>;

  if (not Assigned(lstOpeAss)) or (lstOpeAss.Count <= 0) then
    Result := nil
  else
    Result := lstOpeAss;
end;

function TOpeAssRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  var
    ACriteria  : TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  {**************************}
  {* CÓDIGO DO OPERADOR     *}
  {***********************DF*}
  if (not fEmptyStr(Filter.strCodOpe)) then
    ACriteria.Add(TExpression.Eq('FASS_CODOPE', Filter.strCodOpe));

  Result := ACriteria;
end;

function TOpeAssRepository.fRetAssinaturaOperador(strCodOpe: String): TOpeAss;
  var
    Filter     : TFiltros;
    objListTemp: TList<TOpeAss>;
begin
  Filter           := TFiltros.Create;
  Filter.strCodOpe := strCodOpe;

  objListTemp := fExecutaList(Filter);

  if (Assigned(objListTemp)) then
    Result := objListTemp.First
  else
    Result := nil;

  FreeAndNil(Filter);
end;

procedure TOpeAssRepository.pDelete(AOpeAss: TOpeAss);
begin
  frwk.objDBManager.Remove(AOpeAss);
end;

procedure TOpeAssRepository.pInsert(AOpeAss: TOpeAss);
begin
  frwk.objDBManager.Save(AOpeAss);
end;

procedure TOpeAssRepository.pReload(AOpeAss: TOpeAss);
begin
  frwk.objDBManager.Refresh(AOpeAss);
end;

procedure TOpeAssRepository.pUpdate(AOpeAss: TOpeAss);
begin
  frwk.objDBManager.Flush();
end;

end.
