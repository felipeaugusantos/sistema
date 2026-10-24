unit untTEmaEnvRepository;

interface

uses Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults, Aurelius.Criteria.Expression, untTEmaEnv, untFuncoesSimples;

Type
  TFiltros = class sealed
  Public
    strCodOpe: TFieldFiltros<String>;
    intCodEma: TFieldFiltros<Int64>;
    dteDtaIni: TFieldFiltros<TDateTime>;
    dteDtaFin: TFieldFiltros<TDateTime>;

    ExibirEmailAutomatico: TFieldFiltros<Boolean>;

    Constructor Create;
  End;

  TEmaEnvRepository = class
  Private
    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TEmaEnv>;

    function RetornaFiltroDeOperador(AFiltros: TFiltros): TCustomCriterion;
  Public
    function fRetTodos: TList<TEmaEnv>;
    function fRetEmailByCodEmail(intCodEma: Int64): TEmaEnv;
    function fRetEmailByCodOpe(strCodOpe: String;
                               AExibirEmailAutomatico: Boolean): TList<TEmaEnv>;
    function fRetEmailByPeriodo(dteDataInicial, dteDataFinal: TDateTime; strCodOpe: String;
                                AExibirEmailAutomatico: Boolean): TList<TEmaEnv>;

    procedure pInsert(AEmaEnv: TEmaEnv; Var AAutoInc : String);
    procedure pUpdate(AEmaEnv: TEmaEnv);
    procedure pDelete(AEmaEnv: TEmaEnv); overload;
    procedure pDelete(ACodEma: Int64); overload;

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

{ TFiltros }

constructor TFiltros.Create;
begin
  strCodOpe := '';
  dteDtaIni := 0;
  dteDtaFin := 0;
  intCodEma := 0;
end;

{ TEmaEnvRepository }

constructor TEmaEnvRepository.Create;
begin
  blnCriouObj := False;
  frwk        := fCriaObjManager(blnCriouObj);
end;

destructor TEmaEnvRepository.Destroy;
begin
  if blnCriouObj then FreeAndNil(frwk);
  inherited;
end;

function TEmaEnvRepository.fExecutaList(Filter: TFiltros): TList<TEmaEnv>;
  var
    lstEmaEnv: TList<TEmaEnv>;
begin
  lstEmaEnv := fFiltrar<TEmaEnv>(Filter).List<TEmaEnv>;

  if (not Assigned(lstEmaEnv)) or (lstEmaEnv.Count <= 0) then
    Result := nil
  else
    Result := lstEmaEnv;
end;

function TEmaEnvRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  var
    ACriteria: TCriteria;

    LCustomCriteria: TCustomCriterion;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  LCustomCriteria := RetornaFiltroDeOperador(Filter);

  If LCustomCriteria <> Nil Then
    ACriteria.Add(LCustomCriteria);

  {**************************}
  {* CÓDIGO DO EMAIL        *}
  {***********************DF*}
  if (Filter.intCodEma.Value > 0) then
    ACriteria.Add(TExpression.Eq('FENV_CODEMA', Filter.intCodEma.Value));

  {**************************}
  {* PERIODO DE ENVIO       *}
  {***********************DF*}
  if (Filter.dteDtaIni.Value > 0) then
    ACriteria.Add(TLinq.Ge('FENV_EMADTA', Filter.dteDtaIni));

  if (Filter.dteDtaFin.Value > 0) then
    ACriteria.Add(TLinq.Le('FENV_EMADTA', Filter.dteDtaFin));

  ACriteria.AddOrder(TOrder.Desc('FENV_EMADTA'));

  Result := ACriteria;
end;

function TEmaEnvRepository.fRetEmailByCodEmail(intCodEma: Int64): TEmaEnv;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.intCodEma := intCodEma;

  Result := fExecutaList(Filter).First;

  FreeAndNil(Filter);
end;

function TEmaEnvRepository.fRetEmailByCodOpe(strCodOpe: String;
                                             AExibirEmailAutomatico: Boolean): TList<TEmaEnv>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodOpe := strCodOpe;

  Filter.ExibirEmailAutomatico := AExibirEmailAutomatico;

  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

function TEmaEnvRepository.fRetEmailByPeriodo(dteDataInicial, dteDataFinal: TDateTime; strCodOpe: String;
 AExibirEmailAutomatico: Boolean): TList<TEmaEnv>;
  var
    Filter: TFiltros;
begin
  Filter           := TFiltros.Create;
  Filter.strCodOpe := strCodOpe;
  Filter.dteDtaIni := dteDataInicial;
  Filter.dteDtaFin := dteDataFinal;

  Filter.ExibirEmailAutomatico := AExibirEmailAutomatico;

  Result := fExecutaList(Filter);

  FreeAndNil(Filter);
end;

function TEmaEnvRepository.fRetTodos: TList<TEmaEnv>;
begin
  Result := fExecutaList(TFiltros.Create);
end;

procedure TEmaEnvRepository.pDelete(AEmaEnv: TEmaEnv);
begin
  frwk.objDBManager.Remove(AEmaEnv);
end;

procedure TEmaEnvRepository.pDelete(ACodEma: Int64);
  var
    objEmaEnv: TEmaEnv;
begin
  If (ACodEma > 0) Then Begin
    objEmaEnv := fRetEmailByCodEmail(ACodEma);

    If (Assigned(objEmaEnv)) Then
      pDelete(objEmaEnv);
  End;
end;

procedure TEmaEnvRepository.pInsert(AEmaEnv: TEmaEnv; Var AAutoInc : String);
begin
  AAutoInc := fRetAutoIncrem('EMAENV', VS_strCodEmp);
  AEmaEnv.AUTOINCREM := AAutoInc;
  AEmaEnv.ENV_CODEMA := StrToInt64(fAtualizaProCod('EMAENV', ''));
  AEmaEnv.ENV_CODEMP := VS_strCodEmp;
  frwk.objDBManager.Save(AEmaEnv);
end;

procedure TEmaEnvRepository.pUpdate(AEmaEnv: TEmaEnv);
begin
  frwk.objDBManager.Update(AEmaEnv);
  frwk.objDBManager.Flush();
end;

function TEmaEnvRepository.RetornaFiltroDeOperador(
  AFiltros: TFiltros): TCustomCriterion;
begin
  Result := Nil;

  {**************************}
  {* CÓDIGO DO OPERADOR     *}
  {***********************DF*}
  if (not fEmptyStr(AFiltros.strCodOpe)) then
  Begin
    Result := TExpression.Eq('FENV_CODOPE', AFiltros.strCodOpe);

    If AFiltros.ExibirEmailAutomatico Then
    Begin
      Result := TExpression.Or_(Result, TExpression.Eq('FENV_CODOPE', fCfgSis('OPEAUT')))
    End;

  End
  Else If Not AFiltros.ExibirEmailAutomatico.Value Then
    Result := TExpression.Not_(TExpression.Eq('FENV_CODOPE', fCfgSis('OPEAUT')));
end;

end.
