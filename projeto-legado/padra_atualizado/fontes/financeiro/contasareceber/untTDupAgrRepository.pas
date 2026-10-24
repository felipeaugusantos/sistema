unit untTDupAgrRepository;

interface

uses untTDupAgr, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
  Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
  System.Generics.Defaults;

Type

  TFiltros = class sealed
  Public
    CodigoCliente   : TFieldFiltros<String>;
    Duplicata       : TFieldFiltros<String>;
    Parcela         : TFieldFiltros<String>;
    CodigoEmpresa   : TFieldFiltros<String>;
    EspecieDocumento: TFieldFiltros<String>;
    Constructor Create;
  End;

  TDupAgrRepository = class
  Private
    FCriouObj: Boolean;
    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(Filter: TFiltros): TList<TDupAgr>;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    function fGetDuplicatasAgrupadasReceber(ADuplicata, ACodigoCliente, AParcela, ACodigoEmpresa, AEspecieDocumento : String) : TList<TDupAgr>;
  End;

implementation

uses untFuncoesSimples, untUtilRepository;

{ TFiltros }

constructor TFiltros.Create;
begin
  CodigoCliente    := '';
  Duplicata        := '';
  Parcela          := '';
  CodigoEmpresa    := '';
  EspecieDocumento := '';
end;

{ TDupAgrRepository }

constructor TDupAgrRepository.Create;
begin
  FCriouObj := False;
  frwk := fCriaObjManager(FCriouObj);
end;

destructor TDupAgrRepository.Destroy;
begin
  If FCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

function TDupAgrRepository.fExecutaList(Filter: TFiltros): TList<TDupAgr>;
begin
  Result := fFiltrar<TDupAgr>(Filter).List<TDupAgr>;
end;

function TDupAgrRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
Var SCriteria: TCriteria;
begin
  SCriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.CodigoCliente.Value) Then
  Begin
    Case Filter.CodigoCliente.Opcao Of
      opcIsNull   : SCriteria.Add(TLinq.IsNull('FCodigoCliente'));
      opcIsNotNull: SCriteria.Add(TLinq.IsNotNull('FCodigoCliente'));
      Else SCriteria.Add(TLinq.Eq('FCodigoCliente', Filter.CodigoCliente));
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

  If Not fEmptyStr(Filter.EspecieDocumento.Value) Then
  Begin
    Case Filter.EspecieDocumento.Opcao Of
      opcIsNull   : SCriteria.Add(TLinq.IsNull('FEspecieDocumento'));
      opcIsNotNull: SCriteria.Add(TLinq.IsNotNull('FEspecieDocumento'));
      Else SCriteria.Add(TLinq.Eq('FEspecieDocumento', Filter.EspecieDocumento));
    End;
  End;

  Result := SCriteria;

end;

function TDupAgrRepository.fGetDuplicatasAgrupadasReceber(ADuplicata, ACodigoCliente, AParcela,
  ACodigoEmpresa, AEspecieDocumento : string): TList<TDupAgr>;
var SFilter : TFiltros;
begin
  SFilter := TFiltros.Create;
  try
    SFilter.Duplicata        := ADuplicata;
    SFilter.CodigoCliente    := ACodigoCliente;
    SFilter.Parcela          := AParcela;
    SFilter.CodigoEmpresa    := ACodigoEmpresa;
    SFilter.EspecieDocumento := AEspecieDocumento;

    Result := fExecutaList(SFilter);

  finally
    FreeAndNil(SFilter);
  end;
end;

end.
