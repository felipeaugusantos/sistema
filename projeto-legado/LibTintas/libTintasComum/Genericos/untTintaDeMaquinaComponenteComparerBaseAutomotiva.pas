unit untTintaDeMaquinaComponenteComparerBaseAutomotiva;

interface

uses
  untITintaDeMaquinaComponenteComparer, StrUtils, SysUtils,
  untITintaDeMaquinaComponente;

type
  TTintaDeMaquinaComponenteComparerBaseAutomotiva = class(TInterfacedObject, ITintaDeMaquinaComponenteComparer)
  private
    strCodBas: string;
  public
    constructor Create(const strCodBas: string);
    function Igual(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente): Boolean;
  end;

implementation
uses untTintaDeMaquinaComponenteTipo;
{ TTintaDeMaquinaComponenteComparerBaseAutomotiva }

constructor TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(const strCodBas: string);
begin
  inherited Create();
  Self.strCodBas := strCodBas;
end;

function TTintaDeMaquinaComponenteComparerBaseAutomotiva.Igual(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente): Boolean;
begin
  Result := (Trim(AnsiUpperCase(tintaDeMaquinaComponente.Descricao)) = Trim(AnsiUpperCase(strCodBas)))
    and (tintaDeMaquinaComponente.Tipo = tmctBaseAutomotiva);
end;

end.
