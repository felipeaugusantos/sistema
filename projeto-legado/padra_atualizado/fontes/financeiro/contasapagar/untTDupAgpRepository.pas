unit untTDupAgpRepository;

interface

uses untTDupAgp, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults;

Type

  TFiltros = class sealed
  Public
    CodigoFornecedor: TFieldFiltros<String>;
    Duplicata       : TFieldFiltros<String>;
    Parcela         : TFieldFiltros<String>;
    CodigoEmpresa   : TFieldFiltros<String>;
    Serie_          : TFieldFiltros<String>;
    Constructor Create;
  End;

  TDupAgpRepository = class
  Private
    FCriouObj: Boolean;
    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TDupAgp>;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    function fGetDuplicatasAgrupadasPagar(ADuplicata, ACodigoFornecedor, AParcela, ACodigoEmpresa, ASerie : String) : TList<TDupAgp>;
  End;

implementation

uses untFuncoesSimples, untUtilRepository;

{ TFiltros }

constructor TFiltros.Create;
begin
  CodigoFornecedor := '';
  Duplicata        := '';
  Parcela          := '';
  CodigoEmpresa    := '';
  Serie_           := '';
end;

{ TDupAgpRepository }

constructor TDupAgpRepository.Create;
begin
  FCriouObj := False;
  frwk := fCriaObjManager(FCriouObj);
end;

destructor TDupAgpRepository.Destroy;
begin
  If FCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

function TDupAgpRepository.fExecutaList(Filter: TFiltros): TList<TDupAgp>;
begin
  Result := fFiltrar<TDupAgp>(Filter).List<TDupAgp>;
end;

function TDupAgpRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
Var SCriteria: TCriteria;
begin
  SCriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.CodigoFornecedor.Value) Then
  Begin
    Case Filter.CodigoFornecedor.Opcao Of
      opcIsNull   : SCriteria.Add(TLinq.IsNull('FCodigoFornecedor'));
      opcIsNotNull: SCriteria.Add(TLinq.IsNotNull('FCodigoFornecedor'));
      Else SCriteria.Add(TLinq.Eq('FCodigoFornecedor', Filter.CodigoFornecedor));
    End;
  End;

  If Not fEmptyStr(Filter.Duplicata.Value) Then
  Begin
    Case Filter.Duplicata.Opcao Of
      opcIsNull   : SCriteria.Add(TLinq.IsNull('FDuplicata'));
      opcIsNotNull: SCriteria.Add(TLinq.IsNotNull('FDuplicata'));
      Else SCriteria.Add(TLinq.Eq('FDuplicata', Filter.Duplicata));
    End;
  End;

  If Not fEmptyStr(Filter.Parcela.Value) Then
  Begin
    Case Filter.Parcela.Opcao Of
      opcIsNull   : SCriteria.Add(TLinq.IsNull('FParcela'));
      opcIsNotNull: SCriteria.Add(TLinq.IsNotNull('FParcela'));
      Else SCriteria.Add(TLinq.Eq('FParcela', Filter.Parcela));
    End;
  End;

  If Not fEmptyStr(Filter.CodigoEmpresa.Value) Then
  Begin
    Case Filter.CodigoEmpresa.Opcao Of
      opcIsNull   : SCriteria.Add(TLinq.IsNull('FCodigoEmpresa'));
      opcIsNotNull: SCriteria.Add(TLinq.IsNotNull('FCodigoEmpresa'));
      Else SCriteria.Add(TLinq.Eq('FCodigoEmpresa', Filter.CodigoEmpresa));
    End;
  End;

  If Not fEmptyStr(Filter.Serie_.Value) Then
  Begin
    Case Filter.Serie_.Opcao Of
      opcIsNull   : SCriteria.Add(TLinq.IsNull('FSerie_'));
      opcIsNotNull: SCriteria.Add(TLinq.IsNotNull('FSerie_'));
      Else SCriteria.Add(TLinq.Eq('FSerie_', Filter.Serie_));
    End;
  End;

  Result := SCriteria;

end;

function TDupAgpRepository.fGetDuplicatasAgrupadasPagar(ADuplicata, ACodigoFornecedor, AParcela,
  ACodigoEmpresa, ASerie: String): TList<TDupAgp>;
var SFilter : TFiltros;
begin
  SFilter := TFiltros.Create;
  try
    SFilter.Duplicata        := ADuplicata;
    SFilter.CodigoFornecedor := ACodigoFornecedor;
    SFilter.Parcela          := AParcela;
    SFilter.CodigoEmpresa    := ACodigoEmpresa;
    SFilter.Serie_           := ASerie;

    Result := fExecutaList(SFilter);

  finally
    FreeAndNil(SFilter);
  end;
end;

end.
