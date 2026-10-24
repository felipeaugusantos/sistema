{********************************************}
{* CLASSE PARA RELATÓRIOS DE CONTAS A PAGAR *}
{*****************************************AF*}
unit untTCadPagRelRepository;

interface

uses untTCadPag, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults, untTypesSistema, Aurelius.Criteria.Expression;

Type
  TPagamentoAntecipado = (paUtilizado, paNaoUtilizado, paTodos);

  TFiltros = class sealed
  Public
    arrCodFor: TConsultasArray;
    arrCodAti: TConsultasArray;
    arrCodEve: TConsultasArray;
    arrCodEmp: TConsultasArray;
    arrCodCta: TConsultasArray;

    strPagAnt: TFieldFiltros<String>;
    dtaCadIni: TFieldFiltros<TDateTime>;
    dtaCadFin: TFieldFiltros<TDateTime>;
    dtaVenIni: TFieldFiltros<TDateTime>;
    dtaVenFin: TFieldFiltros<TDateTime>;
    dtaPagIni: TFieldFiltros<TDateTime>;
    dtaPagFin: TFieldFiltros<TDateTime>;

    filPagAnt: TPagamentoAntecipado;

    Constructor Create;
  End;

  TCadPagRelRepository = class
  Private
    blnCriouObj: Boolean;
    FOrderRelPagAntecipados: IComparer<TCadPag>;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TCadPag>;

    procedure pOrderRelPagAntecipados;
  Public

    function fRetPagamentosAntecipados(arrCodFor, arrCodAti, arrCodEve, arrCodEmp,
                                       arrCodCta: TConsultasArray;
                                       dtaCadIni, dtaCadFin,
                                       dtaVenIni, dtaVenFin,
                                       dtaPagIni, dtaPagFin: TDateTime;
                                       filPagAnt: TPagamentoAntecipado = paTodos): TList<TCadPag>;

    Constructor Create;
    Destructor Destroy; Override;

    property orderRelPagAntecipados: IComparer<TCadPag> Read FOrderRelPagAntecipados Write FOrderRelPagAntecipados;
  End;

implementation

uses untFuncoesSimples, StrUtils;

{ TCadPagRelRepository }

constructor TCadPagRelRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);

  pOrderRelPagAntecipados;
end;

destructor TCadPagRelRepository.Destroy;
begin
  If blnCriouObj Then FreeAndNil(frwk);
  inherited;
end;

function TCadPagRelRepository.fExecutaList(Filter: TFiltros): TList<TCadPag>;
begin
  Result := fFiltrar<TCadPag>(Filter).List<TCadPag>;
end;

function TCadPagRelRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria  : TCriteria;
    cusCriteria: TCustomCriterion;
    conVal     : TConsultas;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  {****************************}
  {* PAGAMENTO ANTECIPADO S/N *}
  {*************************AF*}
  If Not fEmptyStr(Filter.strPagAnt) Then ACriteria.Add(TLinq.Eq('FPagAnt',Filter.strPagAnt));
  
  {*********************************}
  {* FILTRA PAGAMENTOS ANTECIPADOS *}
  {* UTILIZADO OU NÃO UTILIZADOS   *}
  {******************************AF*}
  Case Filter.filPagAnt Of
    paUtilizado   : ACriteria.Add(TLinq.IsNotNull('FDtaPag'));
    paNaoUtilizado: ACriteria.Add(TLinq.IsNull('FDtaPag'));
  End;

  {****************}
  {* FORNECEDORES *}
  {*************AF*}
  If Length(Filter.arrCodFor) >= 1 Then
  Begin
    cusCriteria := Nil;
    For conVal In Filter.arrCodFor Do
    Begin
      If cusCriteria <> Nil Then cusCriteria := TExpression.Or_(cusCriteria, TExpression.Eq('FFOR_CODFOR', conVal.strCodigo))
      Else cusCriteria := TExpression.Eq('FFOR_CODFOR', conVal.strCodigo);
    End;
    ACriteria.SubCriteria('FCodFor').Add(cusCriteria);
  End;

  {**************************}
  {* ATIVIDADE FORNECEDORES *}
  {***********************AF*}
  If Length(Filter.arrCodAti) >= 1 Then
  Begin
    cusCriteria := Nil;
    For conVal In Filter.arrCodAti Do
    Begin
      If cusCriteria <> Nil Then cusCriteria := TExpression.Or_(cusCriteria, TExpression.Eq('FFOR_CODATI', conVal.strCodigo))
      Else cusCriteria := TExpression.Eq('FFOR_CODATI', conVal.strCodigo);
    End;
    ACriteria.SubCriteria('FCodFor').Add(cusCriteria);
  End;

  {***********}
  {* EVENTOS *}
  {********AF*}
  If Length(Filter.arrCodEve) >= 1 Then
  Begin
    cusCriteria := Nil;
    For conVal In Filter.arrCodEve Do
    Begin
      If cusCriteria <> Nil Then cusCriteria := TExpression.Or_(cusCriteria, TExpression.Eq('FCodEve', conVal.strCodigo))
      Else cusCriteria := TExpression.Eq('FCodEve', conVal.strCodigo);
    End;
    ACriteria.Add(cusCriteria);
  End;

  {************}
  {* EMPRESAS *}
  {*********AF*}
  If Length(Filter.arrCodEmp) >= 1 Then
  Begin
    cusCriteria := Nil;
    For conVal In Filter.arrCodEmp Do
    Begin
      If cusCriteria <> Nil Then cusCriteria := TExpression.Or_(cusCriteria, TExpression.Eq('FCodEmp', conVal.strCodigo))
      Else cusCriteria := TExpression.Eq('FCodEmp', conVal.strCodigo);
    End;
    ACriteria.Add(cusCriteria);
  End;

  {*******************}
  {* CENTRO DE CUSTO *}
  {****************AF*}
  If Length(Filter.arrCodCta) >= 1 Then
  Begin
    cusCriteria := Nil;
    For conVal In Filter.arrCodCta Do
    Begin
      //COMPARA SOMENTE O GRUPO
      If RightStr(conVal.strCodigo, 3) = '000'   Then
      Begin
        If cusCriteria <> Nil Then cusCriteria := TExpression.Or_(cusCriteria, TExpression.Like('FCodCta', LeftStr(conVal.strCodigo,4) + '%'))
        Else cusCriteria := TExpression.Like('FCodCta', LeftStr(conVal.strCodigo,4) + '%');
      End

      //COMPARA SOMENTE A LINHA
      Else If RightStr(conVal.strCodigo, 5) = '00000' Then
      Begin
        If cusCriteria <> Nil Then cusCriteria := TExpression.Or_(cusCriteria, TExpression.Like('FCodCta', LeftStr(conVal.strCodigo,2) + '%'))
        Else cusCriteria := TExpression.Like('FCodCta', LeftStr(conVal.strCodigo,2) + '%');
      End

      //COMPARA TODA A CONTA
      Else
      Begin
        If cusCriteria <> Nil Then cusCriteria := TExpression.Or_(cusCriteria, TExpression.Eq('FCodCta', conVal.strCodigo))
        Else cusCriteria := TExpression.Eq('FCodCta', conVal.strCodigo);
      End;

    End;
    ACriteria.Add(cusCriteria);
  End;

  {********************}
  {* DATA DE CADASTRO *}
  {*****************AF*}
  If (Filter.dtaCadIni.Value > 0) Or (Filter.dtaCadIni.Opcao In [opcIsNull, opcIsNotNull]) Then
  Begin
    Case Filter.dtaCadIni.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FDtaCad'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FDtaCad'));
      opcBetween  : ACriteria.Add(TLinq.Ge('FDtaCad', Filter.dtaCadIni) And
                                  TLinq.Le('FDtaCad', Filter.dtaCadFin));
      Else ACriteria.Add(TLinq.Eq('FDtaCad', Filter.dtaCadIni));
    End;
  End;

  {**********************}
  {* DATA DE VENCIMENTO *}
  {*******************AF*}
  If (Filter.dtaVenIni.Value > 0) Or (Filter.dtaVenIni.Opcao In [opcIsNull, opcIsNotNull]) Then
  Begin
    Case Filter.dtaCadIni.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FDtaVen'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FDtaVen'));
      opcBetween  : ACriteria.Add(TLinq.Ge('FDtaVen', Filter.dtaVenIni) And
                                  TLinq.Le('FDtaVen', Filter.dtaVenFin));
      Else ACriteria.Add(TLinq.Eq('FDtaVen', Filter.dtaVenIni));
    End;
  End;

  {*********************}
  {* DATA DE PAGAMENTO *}
  {******************AF*}
  If (Filter.dtaPagIni.Value > 0) Or (Filter.dtaPagIni.Opcao In [opcIsNull, opcIsNotNull]) Then
  Begin
    Case Filter.dtaCadIni.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FDtaPag'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FDtaPag'));
      opcBetween  : ACriteria.Add(TLinq.Ge('FDtaPag', Filter.dtaPagIni) And
                                  TLinq.Le('FDtaPag', Filter.dtaPagFin));
      Else ACriteria.Add(TLinq.Eq('FDtaPag', Filter.dtaPagIni));
    End;
  End;

  Result := ACriteria;
end;

function TCadPagRelRepository.fRetPagamentosAntecipados(arrCodFor, arrCodAti,
  arrCodEve, arrCodEmp, arrCodCta: TConsultasArray; dtaCadIni, dtaCadFin,
  dtaVenIni, dtaVenFin, dtaPagIni, dtaPagFin: TDateTime;
  filPagAnt: TPagamentoAntecipado = paTodos): TList<TCadPag>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strPagAnt := 'S';
  Filter.arrCodFor := arrCodFor;
  Filter.arrCodAti := arrCodAti;
  Filter.arrCodEve := arrCodEve;
  Filter.arrCodEmp := arrCodEmp;
  Filter.arrCodCta := arrCodCta;

  Filter.dtaCadIni := dtaCadIni;
  Filter.dtaCadFin := dtaCadFin;
  Filter.dtaCadIni.Opcao := opcBetween;

  Filter.dtaVenIni := dtaVenIni;
  Filter.dtaVenFin := dtaVenFin;
  Filter.dtaVenIni.Opcao := opcBetween;

  Filter.dtaPagIni := dtaPagIni;
  Filter.dtaPagFin := dtaPagFin;
  Filter.dtaPagIni.Opcao := opcBetween;

  Filter.filPagAnt := filPagAnt;

  Result := fExecutaList(Filter);
  Result.Sort(FOrderRelPagAntecipados);

  FreeAndNil(Filter);
end;

{**************************************************}
{* ORDENAÇÃO DE LIST POR:                         *}
{* CODFOR, DTACAD, CODEMP, NUMDUP, PARCEL, SEQBAI *}
{***********************************************AF*}
procedure TCadPagRelRepository.pOrderRelPagAntecipados;
begin
  FOrderRelPagAntecipados := TComparer<TCadPag>.Construct(TComparison<TCadPag>(
  function(const R, L: TCadPag): integer
  Begin
    Result := CompareText(R.objCodFor.FOR_NOMFOR, L.objCodFor.FOR_NOMFOR);
    If Result = 0 Then Result := Trunc(Int(R.dtaDtaCad) - Int(L.dtaDtaCad));
    If Result = 0 Then Result := CompareText(R.strCodEmp, L.strCodEmp);
    If Result = 0 Then Result := CompareText(R.strNumDup, L.strNumDup);
    If Result = 0 Then Result := CompareText(R.strParcel, L.strParcel);
    If Result = 0 Then Result := R.intSeqBai.Value - L.intSeqBai.Value;
  End));
end;

{ TFiltros }

constructor TFiltros.Create;
begin
  SetLength(arrCodFor, 0);
  SetLength(arrCodAti, 0);
  SetLength(arrCodEve, 0);
  SetLength(arrCodEmp, 0);
  SetLength(arrCodCta, 0);

  dtaCadIni := 0;
  dtaCadFin := 0;
  dtaVenIni := 0;
  dtaVenFin := 0;
  dtaPagIni := 0;
  dtaPagFin := 0;
  strPagAnt := '';

  filPagAnt := paTodos;
end;

end.
