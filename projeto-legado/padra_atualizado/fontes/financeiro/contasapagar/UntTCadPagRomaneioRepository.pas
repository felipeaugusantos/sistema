unit UntTCadPagRomaneioRepository;

interface

uses untTCadPagRomaneio, Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
     Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes, Aurelius.Types.Nullable,
     System.Generics.Defaults;

Type

  TFiltros = class sealed
  Public
    Duplicata  : TFieldFiltros<String>;
    Empresa    : TFieldFiltros<String>;
    Fornecedor : TFieldFiltros<String>;
    Serie      : TFieldFiltros<String>;
    Constructor Create;
  End;

  TCadPagRomaneioRepository = class
  Private

    blnCriouObj: Boolean;

    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecutaList(AFilter: TFiltros): TList<TCadPagRomaneio>;
  Public
    procedure pDeletar(AList : TList<TCadPagRomaneio>);
    procedure pGravar(AList : TList<TCadPagRomaneio>);

    function fGetContasPagarVinculadasComRomaneio(ADuplicata, ASerie, AFornecedor, AEmpresa : String): TList<TCadPagRomaneio>;

    Constructor Create;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoesSimples, untUtilRepository, untDelRepository, Uni;

{ TFiltros }

constructor TFiltros.Create;
begin
  Duplicata  := '';
  Empresa    := '';
  Fornecedor := '';
  Serie      := '';
end;

{ TCadPagRomaneioRepository }

constructor TCadPagRomaneioRepository.Create;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
end;

destructor TCadPagRomaneioRepository.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);
  inherited;
end;

function TCadPagRomaneioRepository.fExecutaList(AFilter: TFiltros): TList<TCadPagRomaneio>;
begin
  Result := fFiltrar<TCadPagRomaneio>(AFilter).List<TCadPagRomaneio>;
end;

function TCadPagRomaneioRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.Duplicata.Value) Then
  Begin
    Case Filter.Duplicata.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FNumeroDuplicata'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FNumeroDuplicata'));
      Else ACriteria.Add(TLinq.Eq('FNumeroDuplicata', Filter.Duplicata));
    End;
  End;

  If Not fEmptyStr(Filter.Empresa) Then
  Begin
    Case Filter.Empresa.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCodigoEmpresa'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCodigoEmpresa'));
      Else ACriteria.Add(TLinq.Eq('FCodigoEmpresa', Filter.Empresa));
    End;
  End;

  If Not fEmptyStr(Filter.Fornecedor) Then
  Begin
    Case Filter.Fornecedor.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FCodigoFornecedor'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FCodigoFornecedor'));
      Else ACriteria.Add(TLinq.Eq('FCodigoFornecedor', Filter.Fornecedor));
    End;
  End;

  If Not fEmptyStr(Filter.Serie) Then
  Begin
    Case Filter.Serie.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FSerie') Or TLinq.Eq('FSerie',''));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FSerie'));
      Else ACriteria.Add(TLinq.Eq('FSerie', Filter.Serie));
    End;
  End;

  Result := ACriteria;
end;

function TCadPagRomaneioRepository.fGetContasPagarVinculadasComRomaneio(ADuplicata, ASerie, AFornecedor, AEmpresa: String): TList<TCadPagRomaneio>;
Var SFilter: TFiltros;
begin
  SFilter := TFiltros.Create;
  try
    SFilter.Duplicata  := ADuplicata;
    SFilter.Serie      := ASerie;
    SFilter.Fornecedor := AFornecedor;
    SFilter.Empresa    := AEmpresa;

    Result := fExecutaList(SFilter);
  finally
    FreeAndNil(SFilter);
  end;
end;

procedure TCadPagRomaneioRepository.pDeletar(AList : TList<TCadPagRomaneio>);
var SObjeto : TCadPagRomaneio;
begin
  For SObjeto In AList Do
    frwk.objDBManager.Remove(SObjeto);
end;

procedure TCadPagRomaneioRepository.pGravar(AList : TList<TCadPagRomaneio>);
var SObjeto : TCadPagRomaneio;
begin
  For SObjeto In AList Do
  begin
    If fEmptyStr(SObjeto.AutoIncremento) Then
    begin
      SObjeto.AutoIncremento := fRetAutoIncrem(TUtil.fRetTableName(SObjeto),
                                               SObjeto.CodigoEmpresa);
      frwk.objDBManager.Save(SObjeto);
    end
    else
      frwk.objDBManager.Update(SObjeto);
  end;

end;

end.
