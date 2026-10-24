{******************************************}
{* REPOSITORY DO CHQEMI.                  *}
{* LOCAL DAS FUNCOES DO CHQEMI QUE TEM    *}
{* INTERAÇÃO COM A CAMADA DE PERSISTÊNCIA *}
{*17/06/2015****************************AF*}
unit untTChqEmiRepository;

interface

uses untTChqEmi, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros;

Type
  {**********************************************}
  {* CLASSE RESPONSÁVEL PELOS FILTROS QUE SERÃO *}
  {* EXECUTADOS NA BUSCA DOS DADOS              *}
  {*17/06/2015********************************AF*}
  TFiltros = class sealed
  Public
    strAutInc: TFieldFiltros<String>;
    strCodFor: TFieldFiltros<String>;
    strNumDup: TFieldFiltros<String>;
    strParcel: TFieldFiltros<String>;
    strCodEmp: TFieldFiltros<String>;
    strSerie_: TFieldFiltros<String>;
    intSeqBai: TFieldFiltros<Integer>;

    Constructor Create;
  End;

  TChqEmiRepository = class
  Private
    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
//    function fExecuta(Filter: TFiltros): TChqEmi;
    function fExecutaList(Filter: TFiltros): TList<TChqEmi>;

  Public
    procedure pDeletaChqEmi(AChq: TChqEmi);

    function fRetCheques(strCodFor, strNumDup, strParcel, strCodEmp, strSerie_: String; intSeqBai: Integer): TList<TChqEmi>;

    Constructor Create;
    Destructor Destroy; Override;
  End;


implementation

{ TFiltros }

uses untFuncoesSimples;

constructor TFiltros.Create;
begin
  strAutInc := '';
  strCodFor := '';
  strNumDup := '';
  strParcel := '';
  strCodEmp := '';
  intSeqBai := -1;
end;

{ TChqEmiRepository }

constructor TChqEmiRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TChqEmiRepository.Destroy;
begin
  If blnCriouObj Then FreeAndNil(frwk);
  inherited;
end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA APENAS  *}
{* UM OBJETO(CASO RETORNE MAIS DE UM ELE     *}
{* PEGA O PRIMEIRO REGISTRO)                 *}
{* OBS: COMENTADO POIS NÃO USA POR ENQUANTO  *}
{*17/06/2015*******************************AF*}
//function TChqEmiRepository.fExecuta(Filter: TFiltros): TChqEmi;
//  Var
//    lstChq: TList<TChqEmi>;
//begin
//  lstChq := fFiltrar<TChqEmi>(Filter).List<TChqEmi>;
//  If (Not Assigned(lstChq)) Or (lstChq.Count <= 0) Then Result := Nil
//  Else Result := lstChq[0];
//end;

{*********************************************}
{* EXECUÇÃO DE UM SELECT QUE RETORNA UMA     *}
{* LISTA DE OBJETOS                          *}
{*17/06/2015*******************************AF*}
function TChqEmiRepository.fExecutaList(Filter: TFiltros): TList<TChqEmi>;
begin
  Result := fFiltrar<TChqEmi>(Filter).List<TChqEmi>;
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
function TChqEmiRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  Case Filter.strSerie_.Opcao Of
    opcIsNull   : ACriteria.Add(TLinq.IsNull('FEMI_SERIE_') Or TLinq.Eq('FEMI_SERIE_',''));
    opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FEMI_SERIE_'));
    Else ACriteria.Add(TLinq.Eq('FEMI_SERIE_', Filter.strSerie_));
  End;

  If Not fEmptyStr(Filter.strAutInc) Then ACriteria.Add(TLinq.Eq('FAUTOINCREM', Filter.strAutInc));
  If Not fEmptyStr(Filter.strCodFor) Then ACriteria.Add(TLinq.Eq('FEMI_CODFOR', Filter.strCodFor));
  If Not fEmptyStr(Filter.strNumDup) Then ACriteria.Add(TLinq.Eq('FEMI_NUMDUP', Filter.strNumDup));
  If Not fEmptyStr(Filter.strParcel) Then ACriteria.Add(TLinq.Eq('FEMI_PARCEL', Filter.strParcel));
  If Not fEmptyStr(Filter.strCodEmp) Then ACriteria.Add(TLinq.Eq('FEMI_CODEMP', Filter.strCodEmp));
  If (Filter.intSeqBai.Value >= 0) Then ACriteria.Add(TLinq.Eq('FEMI_SEQBAI', Filter.intSeqBai));

  Result := ACriteria;
end;

{*********************************************}
{* RETORNA UMA LISTA DE CHEQUES A PARTIR DA  *}
{* CHAVE                                     *}
{*17/06/2015*******************************AF*}
function TChqEmiRepository.fRetCheques(strCodFor, strNumDup, strParcel, strCodEmp, strSerie_: String; intSeqBai: Integer): TList<TChqEmi>;
  Var
    Filtro: TFiltros;
begin
  Filtro := TFiltros.Create;
  Filtro.strCodFor := strCodFor;
  Filtro.strNumDup := strNumDup;
  Filtro.strParcel := strParcel;
  Filtro.strCodEmp := strCodEmp;

  Filtro.strSerie_ := strSerie_;
  If fEmptyStr(strSerie_) Then Filtro.strSerie_.Opcao := opcIsNull;

  Filtro.intSeqBai := intSeqBai;

  Result := fExecutaList(Filtro);
  FreeAndNil(Filtro);
end;

{*********************************************}
{* DELETA UM CHEQUE                          *}
{*17/06/2015*******************************AF*}
procedure TChqEmiRepository.pDeletaChqEmi(AChq: TChqEmi);
begin
  frwk.objDBManager.Remove(AChq);
end;

end.
