{******************************************}
{* REPOSITORY DO CADRCXX.                 *}
{* LOCAL DAS FUNCOES DO CADRCXX QUE TEM   *}
{* INTERAÇÃO COM A CAMADA DE PERSISTÊNCIA *}
{*17/06/2015****************************AF*}
unit untTCadRcxxRepository;

interface

uses untTCadRcxx, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Aurelius.Criteria.Projections;

Type
  {**********************************************}
  {* CLASSE RESPONSÁVEL PELOS FILTROS QUE SERÃO *}
  {* EXECUTADOS NA BUSCA DOS DADOS              *}
  {*17/06/2015********************************AF*}
  TFiltros = class sealed
  Public
    intSeqCon: TFieldFiltros<Integer>;
    strAutInc: TFieldFiltros<String>;
    strCodEmp: TFieldFiltros<String>;

    Constructor Create;
  End;

  TCadRcxxRepository = class
  Private
    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function Executa(Filter: TFiltros): TCadRcxx;
    function fExecutaList(Filter: TFiltros): TList<TCadRcxx>;

  Public
    procedure pSomaModalidades(intSeqCon: Integer; Var fltDinRec, fltCarRec, fltChqAvi, fltChqPre, fltOrdRec: Double; strCodEmp: String = '');

    function fRetRegistros(intSeqCon: Integer; strCodEmp: String): TList<TCadRcxx>;
    function RetornaRegistros(ASeqCon: Integer; ACodEmpresa: String): TCadRcxx;

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

{ TFiltros }

uses untFuncoesSimples;

constructor TFiltros.Create;
begin
  intSeqCon := 0;
  strAutInc := '';
  strCodEmp := '';
end;

{ TCadRcxxRepository }

constructor TCadRcxxRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TCadRcxxRepository.Destroy;
begin
  If blnCriouObj Then FreeAndNil(frwk);
  inherited;
end;

function TCadRcxxRepository.Executa(Filter: TFiltros): TCadRcxx;
Var
  lstCadRcxx: TList<TCadRcxx>;
begin
  lstCadRcxx := fFiltrar<TCadRcxx>(Filter).List<TCadRcxx>;
  If (Not Assigned(lstCadRcxx)) Or (lstCadRcxx.Count <= 0) Then
    Result := Nil
  Else
  Begin
    Result := lstCadRcxx[0];
    frwk.objDBManager.Refresh(Result);
  End;
end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA UMA     *}
{* LISTA DE OBJETOS                          *}
{*17/06/2015*******************************AF*}
function TCadRcxxRepository.fExecutaList(Filter: TFiltros): TList<TCadRcxx>;
begin
  Result := fFiltrar<TCadRcxx>(Filter).List<TCadRcxx>;
end;

{**************************************************************}
{* FUNÇÃO RESPONSÁVEL PELOS FILTROS.                          *}
{* TODOS OS CAMPOS QUE SÃO TFieldFiltros TEM INTERNAMENTE     *}
{* UM CAMPO OPCAO QUE PODE SER:                               *}
{*  opcDiferente: ACriteria.Add(TLinq.Lt(?) And TLinq.Gt(?)); *}
{*  opcIsNull   : ACriteria.Add(TLinq.IsNull(?);              *}
{*  opcIsNotNull: ACriteria.Add(TLinq.IsNotNull(?);           *}
{*  opcBeetween : ACriteria.Add(TLinq.Le(?) And TLinq.Ge(?)); *}
{*  Else ACriteria.Add(TLinq.Eq(?));                          *}
{*                                                            *}
{* obs: PODE SER CRIADO OUTROS NO FUTURO                      *}
{*17/06/2015************************************************AF*}
function TCadRcxxRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If (Filter.intSeqCon.Value > 0) Then ACriteria.Add(TLinq.Eq('FRCX_SEQCON', Filter.intSeqCon));
  If Not fEmptyStr(Filter.strAutInc) Then ACriteria.Add(TLinq.Eq('FAUTOINCREM', Filter.strAutInc));
  If Not fEmptyStr(Filter.strCodEmp) Then ACriteria.Add(TLinq.Eq('FRCX_CODEMP', Filter.strCodEmp));

  Result := ACriteria;
end;

function TCadRcxxRepository.fRetRegistros(intSeqCon: Integer;
  strCodEmp: String): TList<TCadRcxx>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Try
    Filter.intSeqCon := intSeqCon;
    Filter.strCodEmp := strCodEmp;

    Result := fExecutaList(Filter);
  Finally
    FreeAndNil(Filter);
  End;
end;

{*********************************************}
{* RETORNA A SOMATÓRIA DAS MODALIDADES DE UM *}
{* RECEB. DO CAIXA A PARTIR DE UM SEQCON     *}
{*17/06/2015*******************************AF*}
procedure TCadRcxxRepository.pSomaModalidades(intSeqCon: Integer; var fltDinRec,
  fltCarRec, fltChqAvi, fltChqPre, fltOrdRec: Double; strCodEmp: String = '');
  Var
    Filter: TFiltros;
    rstRcx: TCriteriaResult;
begin
  Filter := TFiltros.Create;
  Filter.intSeqCon  := intSeqCon;
  If fEmptyStr(strCodEmp) Then
    Filter.strCodEmp := VS_strCodEmp
  Else
    Filter.strCodEmp := strCodEmp;

  fltDinRec := 0;
  fltCarRec := 0;
  fltChqAvi := 0;
  fltChqPre := 0;
  fltOrdRec := 0;

  rstRcx := fFiltrar<TCadRcxx>(Filter).SetProjections(TProjections.ProjectionList
                            .Add(TProjections.Sum('FRCX_DINREC').As_('DINREC'))
                            .Add(TProjections.Sum('FRCX_CARREC').As_('CARREC'))
                            .Add(TProjections.Sum('FRCX_CHQAVI').As_('CHQAVI'))
                            .Add(TProjections.Sum('FRCX_CHQPRE').As_('CHQPRE'))
                            .Add(TProjections.Sum('FRCX_ORDREC').As_('ORDREC'))
            ).UniqueValue;

  If Not Assigned(rstRcx) Then
    Exit;

  fltDinRec := IfNull(rstRcx.Values['DINREC'],0);
  fltCarRec := IfNull(rstRcx.Values['CARREC'],0);
  fltChqAvi := IfNull(rstRcx.Values['CHQAVI'],0);
  fltChqPre := IfNull(rstRcx.Values['CHQPRE'],0);
  fltOrdRec := IfNull(rstRcx.Values['ORDREC'],0);
end;

function TCadRcxxRepository.RetornaRegistros(ASeqCon: Integer;
  ACodEmpresa: String): TCadRcxx;
Var
  Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Try
    Filter.intSeqCon := ASeqCon;
    Filter.strCodEmp := ACodEmpresa;

    Result := Executa(Filter);
  Finally
    FreeAndNil(Filter);
  End;
end;

end.
