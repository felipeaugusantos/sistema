unit untIDadosTintasComponentes;

interface

type
  IDadosTintasComponentes = interface(IInterface)
    ['{41656CC8-1300-48C6-9C37-D87F8C391B79}']
    function GetComponente: string;
    function GetQuantidade: Double;
    property Componente: string read GetComponente;
    property Quantidade: Double read GetQuantidade;
  end;

implementation

end.
