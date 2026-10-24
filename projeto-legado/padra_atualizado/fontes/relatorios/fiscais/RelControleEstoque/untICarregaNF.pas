unit untICarregaNF;

interface

uses Generics.Collections,
     untTItemNotaFiscal,
     untTDadosAbertura,
     Classes;

type
  ICarregaNF = interface
    function fCarregar(strItemSubstituido: string): TObjectList<TItemNotaFiscal>;
  end;

implementation

end.
