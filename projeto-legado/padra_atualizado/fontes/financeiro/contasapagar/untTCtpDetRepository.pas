{**********************************************}
{* APROVEITAMOS O REQUISITO 36383 QUE PEDIA   *}
{* ALTERAÇÃO NO ESTORNO PARA CRIAR REPOSITÓRIO*}
{* CTPDET LOCAL DAS FUNCOES DO CADPAG QUE TEM *}
{* INTERAÇÃO COM A CAMADA DE PERSISTÊNCIA     *}
{*REQ.36383 17/06/2014**********************JU*}
unit untTCtpDetRepository;

interface

uses untTCtpDet, Aurelius.Criteria.Base, System.Generics.Collections,untTCadPag,
  System.SysUtils, Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes,
  untTMovBan, untUtilRepository;

Type
  TFiltros = class sealed
  Public
    strAutInc: TFieldFiltros<String>;
    strDup   : TFieldFiltros<String>;
    strPar   : TFieldFiltros<String>;
    strEmp   : TFieldFiltros<String>;
    strFor   : TFieldFiltros<String>;
    strSer   : TFieldFiltros<String>;
    strCta   : TFieldFiltros<String>;

    Constructor Create;
  End;

  TCtpDetRepository = class
  Private

    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TCtpDet;
    function fExecutaList(Filter: TFiltros): TList<TCtpDet>;

  Public

    function fRetDuplicatas(ADup: TCadPag): TList<TCtpDet>;
    function fRetDuplicata(strAutInc: String): TCtpDet; Overload;
    function fRetDuplicata(ADup: TCadPag; strCtaCtpDet: String): TCtpDet; Overload;
    function fRetObjMovBan(ACtp: TCtpDet): TMovBan;

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoesSimples;

{ TFiltros }

constructor TFiltros.Create;
begin
  strAutInc := '';
  strDup    := '';
  strPar    := '';
  strEmp    := '';
  strFor    := '';
  strSer    := '';
  strCta    := '';
end;

{ TCtpDetRepository }

constructor TCtpDetRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TCtpDetRepository.Destroy;
begin
  If blnCriouObj Then FreeAndNil(frwk);
  inherited;
end;

function TCtpDetRepository.fExecuta(Filter: TFiltros): TCtpDet;
  Var
    lstPag: TList<TCtpDet>;
begin
  lstPag := fFiltrar<TCtpDet>(Filter).List<TCtpDet>;

  If (Not Assigned(lstPag)) Or (lstPag.Count <= 0) Then Result := Nil
  Else Result := lstPag[0];
end;

function TCtpDetRepository.fExecutaList(Filter: TFiltros): TList<TCtpDet>;
begin
  Result := fFiltrar<TCtpDet>(Filter).List<TCtpDet>;
end;

{*************************************************************}
{* FUNÇÃO RESPONSÁVEL PELOS FILTROS.                         *}
{* TODOS OS CAMPOS QUE SÃO TFieldFiltros TEM INTERNAMENTE    *}
{* UM CAMPO OPCAO QUE PODE SER:                              *}
{* opcDiferente: ACriteria.Add(TLinq.Lt(?) And TLinq.Gt(?)); *}
{* opcIsNull   : ACriteria.Add(TLinq.IsNull(?);              *}
{* opcIsNotNull: ACriteria.Add(TLinq.IsNotNull(?);           *}
{* opcBeetween : ACriteria.Add(TLinq.Le(?) And TLinq.Ge(?)); *}
{*  Else ACriteria.Add(TLinq.Eq(?));                         *}
{*REQ. 36383 17/06/2015************************************JU*}

function TCtpDetRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.strDup.Value) Then
  Begin
    Case Filter.strDup.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTP_NUMDUP'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTP_NUMDUP'));
      Else ACriteria.Add(TLinq.Eq('FCTP_NUMDUP', Filter.strDup));
    End;
  End;

  If Not fEmptyStr(Filter.strPar) Then
  Begin
    Case Filter.strPar.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTP_PARCEL'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTP_PARCEL'));
      Else ACriteria.Add(TLinq.Eq('FCTP_PARCEL', Filter.strPar));
    End;
  End;

  If Not fEmptyStr(Filter.strEmp) Then
  Begin
    Case Filter.strEmp.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTP_EMPORI'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTP_EMPORI'));
      Else ACriteria.Add(TLinq.Eq('FCTP_EMPORI', Filter.strEmp));
    End;
  End;

  If Not fEmptyStr(Filter.strFor) Then
  Begin
    Case Filter.strFor.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTP_CODFOR'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTP_CODFOR'));
      Else ACriteria.Add(TLinq.Eq('FCTP_CODFOR', Filter.strFor));
    End;
  End;

  If Not fEmptyStr(Filter.strCta) Then
  Begin
    Case Filter.strCta.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTP_CODCTA'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTP_CODCTA'));
      Else ACriteria.Add(TLinq.Eq('FCTP_CODCTA', Filter.strCta));
    End;
  End;

  If Not fEmptyStr(Filter.strSer) Then
  Begin
    Case Filter.strSer.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCTP_SERIE_') Or TLinq.Eq('FCTP_SERIE_',''));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCTP_SERIE_'));
      Else ACriteria.Add(TLinq.Eq('FCTP_SERIE_', Filter.strSer));
    End;
  End;

  Result := ACriteria;
end;

function TCtpDetRepository.fRetDuplicata(strAutInc: String): TCtpDet;
begin
  Result := TCtpDet(frwk.objDBManager.Find(TCtpDet, strAutInc));
end;

function TCtpDetRepository.fRetDuplicata(ADup: TCadPag; strCtaCtpDet: String): TCtpDet;
Var
  Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strDup    := ADup.strNumDup;
  Filter.strPar    := ADup.strParcel;
  Filter.strEmp    := ADup.strCodEmp;
  Filter.strFor    := ADup.objCodFor.FOR_CODFOR;
  Filter.strSer    := ADup.strSerie;
  Filter.strCta    := strCtaCtpDet;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
end;

function TCtpDetRepository.fRetDuplicatas(ADup: TCadPag): TList<TCtpDet>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strDup  := ADup.strNumDup;
  Filter.strPar  := ADup.strParcel;
  Filter.strEmp  := ADup.strCodEmp;
  Filter.strFor  := ADup.objCodFor.FOR_CODFOR;
  Filter.strSer  := ADup.strSerie;

  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

function TCtpDetRepository.fRetObjMovBan(ACtp: TCtpDet): TMovBan;
begin
  Result := TMovBan.Create;
end;

end.
