unit untTCadForRepository;

interface

uses untTCadFor, Aurelius.Criteria.Base, System.Generics.Collections,
  System.SysUtils, Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros,
  Classes, untUtilRepository, untTestabilidade;

Type
  TFiltros = class sealed
  Public
    strCodFor: TFieldFiltros<String>;

    Constructor Create;
  End;

  TCadForRepository = class
  Private

    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TCadFor;

  Public
    procedure pAtualizar;
    function fRetCadFor(strCodFor: String): TCadFor;

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoesSimples, untFuncoes, Data.DB;

{ TFiltros }

constructor TFiltros.Create;
begin
  strCodFor := '';
end;

{ TCadForRepository }

constructor TCadForRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TCadForRepository.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

function TCadForRepository.fExecuta(Filter: TFiltros): TCadFor;
  Var
    lstFor: TList<TCadFor>;
begin
  lstFor := fFiltrar<TCadFor>(Filter).List<TCadFor>;

  If (Not Assigned(lstFor)) Or (lstFor.Count <= 0) Then
    Result := Nil
  Else
    Result := lstFor[0];
end;

function TCadForRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.strCodFor) Then
    ACriteria.Add(TLinq.Eq('FFOR_CODFOR', Filter.strCodFor));

  Result := ACriteria;
end;

procedure TCadForRepository.pAtualizar;
begin
  frwk.objDBManager.Flush;
end;

function TCadForRepository.fRetCadFor(strCodFor: String): TCadFor;
  Var
    Filter: TFiltros;
Begin
  Filter := TFiltros.Create;
  Filter.strCodFor := strCodFor;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
End;

end.
