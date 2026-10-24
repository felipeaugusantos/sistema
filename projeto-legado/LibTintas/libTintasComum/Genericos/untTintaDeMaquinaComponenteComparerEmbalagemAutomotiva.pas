unit untTintaDeMaquinaComponenteComparerEmbalagemAutomotiva;

interface

uses
  untITintaDeMaquinaComponenteComparer, untITintaDeMaquinaComponente, StrUtils, SysUtils;

type
  TTintaDeMaquinaComponenteComparerEmbalagemAutomotiva = class(TInterfacedObject, ITintaDeMaquinaComponenteComparer)
  private
    strCodEmb: string;
  public
    constructor Create(const strCodEmb: string);
    function Igual(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente): Boolean;
  end;

implementation
uses untTintaDeMaquinaComponenteTipo;
{ TTintaDeMaquinaComponenteComparerEmbalagemAutomotiva }

constructor TTintaDeMaquinaComponenteComparerEmbalagemAutomotiva.Create(const strCodEmb: string);
begin
  inherited Create();
  Self.strCodEmb := strCodEmb;
end;

function TTintaDeMaquinaComponenteComparerEmbalagemAutomotiva.Igual(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente): Boolean;
begin
  Result := (AnsiUpperCase(Trim(tintaDeMaquinaComponente.CodIte)) = AnsiUpperCase(Trim(strCodEmb)))
    and (tintaDeMaquinaComponente.Tipo = tmctEmbalagemAutomotiva);
end;

end.
