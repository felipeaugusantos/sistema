unit untTCadCCaRepository;

interface

uses untTCadCCa, Aurelius.Criteria.Base, System.Generics.Collections,
  System.SysUtils, Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros,
  Classes, untUtilRepository, untTestabilidade;

Type
  TFiltros = class sealed
  Public
    CodigoBanco   : TFieldFiltros<String>;
    CodigoAgencia : TFieldFiltros<String>;
    CodigoConta   : TFieldFiltros<String>;
    ChaveOFX      : TFieldFiltros<String>;
    Constructor Create;
  End;

  TCadCCaRepository = class
  Private
    FCriouObjeto: Boolean;
    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(AFilter: TFiltros): TCadCCa;
  Public
    procedure pAtualizar;
    function GetContaBancaria(ACodigoBanco : String = '' ; ACodigoAgencia : String = ''; ACodigoConta : String = '';
      AChaveOFX : String = '') : TCadCCa;
    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoesSimples, untFuncoes, Data.DB;

{ TFiltros }

constructor TFiltros.Create;
begin
  CodigoConta := '';
  ChaveOFX    := '';
end;

{ TCadForRepository }

constructor TCadCCaRepository.Create;
begin
  FCriouObjeto := False;
  frwk         := fCriaObjManager(FCriouObjeto);
end;

destructor TCadCCaRepository.Destroy;
begin
  If FCriouObjeto Then
    FreeAndNil(frwk);
  inherited;
end;

function TCadCCaRepository.fExecuta(AFilter: TFiltros): TCadCCa;
Var lstCCa: TList<TCadCCa>;
begin
  lstCCa := fFiltrar<TCadCCa>(AFilter).List<TCadCCa>;

  If (Not Assigned(lstCCa)) Or (lstCCa.Count <= 0) Then
    Result := Nil
  Else
    begin
      frwk.objDBManager.Refresh(lstCCa[0]);
      Result := lstCCa[0];
    end;
end;

function TCadCCaRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.CodigoBanco) Then
    ACriteria.Add(TLinq.Eq('FCCA_CODBCO', Filter.CodigoBanco));

  If Not fEmptyStr(Filter.CodigoAgencia) Then
    ACriteria.Add(TLinq.Eq('FCCA_AGENCI', Filter.CodigoAgencia));

  If Not fEmptyStr(Filter.CodigoConta) Then
    ACriteria.Add(TLinq.Eq('FCCA_CODCTA', Filter.CodigoConta));

  If Not fEmptyStr(Filter.ChaveOFX) Then
    ACriteria.Add(TLinq.Eq('FCCA_CHVOFX', Filter.ChaveOFX));

  Result := ACriteria;
end;

procedure TCadCCaRepository.pAtualizar;
begin
  frwk.objDBManager.Flush;
end;

function TCadCCaRepository.GetContaBancaria(ACodigoBanco : String = '' ; ACodigoAgencia : String = ''; ACodigoConta : String = '';
      AChaveOFX : String = ''): TCadCCa;
Var SFilter: TFiltros;
Begin
  SFilter := TFiltros.Create;
  Try
    if not fEmptyStr(ACodigoBanco) then
      SFilter.CodigoBanco := ACodigoBanco;

    if not fEmptyStr(ACodigoAgencia) then
      SFilter.CodigoAgencia := ACodigoAgencia;

    if not fEmptyStr(ACodigoConta) then
      SFilter.CodigoConta := ACodigoConta;

    if not fEmptyStr(AChaveOFX) then
      SFilter.ChaveOFX := AChaveOFX;

    Result := fExecuta(SFilter);
  Finally
    FreeAndNil(SFilter);
  End;
End;

end.
