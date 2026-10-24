unit Contabilidade.Interfaces.TVinculoPlanoContabilService;

interface

uses
  System.Generics.Collections ;

type
  IVinculoPlanoContabilGenericService<T, T2: class> = interface
    ['{E693EF94-5603-4C0D-A7BE-EE3D8E7A624F}']
    function fListDadosT: TObjectList<T>;
    function fListDadosT2: TObjectList<T2>;
    function fSalvarVinculo(const AEntitys: TObjectList<T>): Boolean;
  end;

implementation

end.
