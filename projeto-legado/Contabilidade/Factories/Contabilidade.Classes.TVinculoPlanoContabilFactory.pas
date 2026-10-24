unit Contabilidade.Classes.TVinculoPlanoContabilFactory;

interface

uses
  Contabilidade.Interfaces.TVinculoPlanoContabilFactory,
  Contabilidade.Interfaces.TVinculoPlanoContabilService ;

type
  TVinculoPlanoContabilFactory<T, T2: class> = class(TInterfacedObject, IVinculoPlanoContabilFactory<T, T2>)
  public
    function fPlanoContabilVinculo: IVinculoPlanoContabilGenericService<T, T2>;
    class function New: IVinculoPlanoContabilFactory<T, T2> ;
  end ;

implementation

uses
  Contabilidade.Interfaces.TVinculoPlanoContabilRepo,
  Contabilidade.Classes.TVinculoPlanoContabilRepo,
  Contabilidade.Classes.TVinculoPlanoContabilService;

{ TVinculoPlanoContabilFactory<T, T2> }

function TVinculoPlanoContabilFactory<T, T2>.fPlanoContabilVinculo: IVinculoPlanoContabilGenericService<T, T2>;
var
  LPlanoRepository: IVinculoPlanoContabilRepo<T, T2>;
  LPlanoService: IVinculoPlanoContabilGenericService<T, T2>;
begin
  LPlanoRepository := TVinculoPlanoContabilGenericRepo<T, T2>.Create;
  LPlanoService := TVinculoPlanoContabilService<T, T2>.Create(LPlanoRepository);
  Result := LPlanoService ;
end;

class function TVinculoPlanoContabilFactory<T, T2>.New: IVinculoPlanoContabilFactory<T, T2>;
begin
  Result := Self.Create ;
end;

end.
