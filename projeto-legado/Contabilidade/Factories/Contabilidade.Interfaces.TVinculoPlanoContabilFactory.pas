unit Contabilidade.Interfaces.TVinculoPlanoContabilFactory;

interface

uses
  Contabilidade.Interfaces.TVinculoPlanoContabilService ;

Type
  IVinculoPlanoContabilFactory<T, T2: class> = interface
    ['{BB0788C1-2337-4339-869F-9C46A8964F41}']
    function fPlanoContabilVinculo: IVinculoPlanoContabilGenericService<T, T2>;
  end;

implementation

end.
