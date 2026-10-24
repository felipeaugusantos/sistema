unit Contabilidade.Classes.TVinculoPlanoContabilService;

interface

uses
  Contabilidade.Interfaces.TVinculoPlanoContabilService, System.Generics.Collections,
  Contabilidade.Interfaces.TVinculoPlanoContabilRepo ;

type
  TVinculoPlanoContabilService<T, T2: class> = class(TInterfacedObject, IVinculoPlanoContabilGenericService<T, T2>)
  private
    FPlanoRepository: IVinculoPlanoContabilRepo<T, T2> ;
    function fListDadosNcoComPlanco: TObjectList<T> ;
  public
    function fListDadosT: TObjectList<T>;
    function fListDadosT2: TObjectList<T2>;
    function fSalvarVinculo(const AEntities: TObjectList<T>): Boolean;
    constructor Create(ARepository: IVinculoPlanoContabilRepo<T, T2>);
  end;

implementation

uses
  Contabilidade.Classes.TVinculoPlanoContabil, untFuncoesSimples, System.SysUtils ;

{ TVinculoPlanoContabilService<T, T2> }

constructor TVinculoPlanoContabilService<T, T2>.Create(
  ARepository: IVinculoPlanoContabilRepo<T, T2>);
begin
  FPlanoRepository := ARepository ;
end;

function TVinculoPlanoContabilService<T, T2>.fListDadosNcoComPlanco: TObjectList<T>;
var
  LItemGeneric: T ;
  LItem: TCadBaseComPlanoContabil ;
begin
  Result := FPlanoRepository.fListDadosT ;
  for LItemGeneric in Result do
  begin
    LItem := LItemGeneric as TCadBaseComPlanoContabil ;
    if LItem.empresas.Count > 0 then
      LItem.por_empresa := '1' ;
  end ;
end;

function TVinculoPlanoContabilService<T, T2>.fListDadosT: TObjectList<T>;
begin
  if TClass(T).InheritsFrom(TCadCtaComPlanoContabil) then
    Result := Self.fListDadosNcoComPlanco
  else if TClass(T).InheritsFrom(TCadPorComPlanoContabil) then
    Result := Self.fListDadosNcoComPlanco
  else
    Result := FPlanoRepository.fListDadosT ;
end;

function TVinculoPlanoContabilService<T, T2>.fListDadosT2: TObjectList<T2>;
begin
  Result := FPlanoRepository.fListDadosT2 ;
end;

function TVinculoPlanoContabilService<T, T2>.fSalvarVinculo(
  const AEntities: TObjectList<T>): Boolean;
begin
  fStartTransaction() ;
  try
    Result := FPlanoRepository.fSalvarVinculo(AEntities) ;
    fCommit() ;
  except
    on E: Exception do
    begin
      fRollBack() ;
      raise ;
    end ;
  end ;
end;

end.
