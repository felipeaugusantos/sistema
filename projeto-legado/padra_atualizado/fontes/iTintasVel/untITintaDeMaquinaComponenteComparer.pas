unit untITintaDeMaquinaComponenteComparer;

interface

uses
  untITintaDeMaquinaComponente;

type
  ITintaDeMaquinaComponenteComparer = interface
    ['{FA873B47-DF61-4CDD-901F-C0259C109CCC}']
    function Igual(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente): Boolean;
  end;

implementation

end.
