unit Contabilidade.Interfaces.TVinculoPlanoContabilRepo;

interface
 uses
   System.Generics.Collections ;

 type
   IVinculoPlanoContabilRepo<T, T2: class> = interface
    ['{40B5E8E0-B92A-4BE9-85F2-523686938DD2}']
    function fListDadosT: TObjectList<T>;
    function fListDadosT2: TObjectList<T2>;
    function fSalvarVinculo(const AEntitys: TObjectList<T>): Boolean;
  end;


implementation

end.
