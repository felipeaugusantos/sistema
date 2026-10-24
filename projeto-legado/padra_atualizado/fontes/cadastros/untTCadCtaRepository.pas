unit untTCadCtaRepository;

interface

uses untTCadCta, Aurelius.Criteria.Base, System.Generics.Collections,
  System.SysUtils, Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros,
  Classes, untUtilRepository, untTestabilidade;

Type
  TFiltros = class sealed
  Public
    strCodCta: TFieldFiltros<String>;

    Constructor Create;
  End;

  TCadCtaRepository = class
  Private

    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TCadCta;

  Public
    procedure pAtualizar;
    function fRetCadCta(strCodCta: String): TCadCta;

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoesSimples, untFuncoes, Data.DB;

{ TFiltros }

constructor TFiltros.Create;
begin
  strCodCta := '';
end;

{ TCadForRepository }

constructor TCadCtaRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TCadCtaRepository.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

function TCadCtaRepository.fExecuta(Filter: TFiltros): TCadCta;
  Var
    lstCta: TList<TCadCta>;
begin
  lstCta := fFiltrar<TCadCta>(Filter).List<TCadCta>;

  If (Not Assigned(lstCta)) Or (lstCta.Count <= 0) Then
    Result := Nil
  Else
    Result := lstCta[0];
end;

function TCadCtaRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.strCodCta) Then
    ACriteria.Add(TLinq.Eq('FCTA_CODCTA', Filter.strCodCta));

  Result := ACriteria;
end;

procedure TCadCtaRepository.pAtualizar;
begin
  frwk.objDBManager.Flush;
end;

function TCadCtaRepository.fRetCadCta(strCodCta: String): TCadCta;
  Var
    Filter: TFiltros;
Begin
  Filter := TFiltros.Create;
  Filter.strCodCta := strCodCta;

  Result := fExecuta(Filter);
  FreeAndNil(Filter);
End;

end.
