unit untTintaDeMaquinaComponenteComparerBaseImobiliaria;

interface

uses
  untITintaDeMaquinaComponenteComparer,  StrUtils, SysUtils,
  untITintaDeMaquinaComponente;

type
  TTintaDeMaquinaComponenteComparerBaseImobiliaria = class(TInterfacedObject, ITintaDeMaquinaComponenteComparer)
  private
    strCodIte: string;
  public
    constructor Create(const strCodIte: string);
    function Igual(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente): Boolean;
  end;

implementation
uses untTintaDeMaquinaComponenteTipo;
{ TTintaDeMaquinaComponenteComparerBaseImobiliaria }

constructor TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(const strCodIte: string);
begin
  inherited Create();
  Self.strCodIte := strCodIte;
end;

function TTintaDeMaquinaComponenteComparerBaseImobiliaria.Igual(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente): Boolean;
begin
  Result := ((AnsiUpperCase(Trim(tintaDeMaquinaComponente.CodIte))) = AnsiUpperCase(Trim(strCodIte)))
    and (tintaDeMaquinaComponente.Tipo = tmctBaseImobiliaria);
end;

end.
