unit untTintaDeMaquinaComponenteComparerColorante;

interface

uses
  untITintaDeMaquinaComponenteComparer,  StrUtils, SysUtils,
  untITintaDeMaquinaComponente;

type
  TTintaDeMaquinaComponenteComparerColorante = class(TInterfacedObject, ITintaDeMaquinaComponenteComparer)
  private
    strCodCol: string;
    ACount: Integer;
  public
    constructor Create(const strCodCol: string);
    function Igual(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente): Boolean;
  end;

implementation
uses untTintaDeMaquinaComponenteTipo;
{ TTintaDeMaquinaComponenteComparerColorante }

constructor TTintaDeMaquinaComponenteComparerColorante.Create(const strCodCol: string);
begin
  inherited Create();
  Self.strCodCol := strCodCol;
  ACount := 15;
end;

function TTintaDeMaquinaComponenteComparerColorante.Igual(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente): Boolean;
begin
  Result := (Trim(AnsiUpperCase(LeftStr(tintaDeMaquinaComponente.Descricao, ACount))) = Trim(AnsiUpperCase(strCodCol)))
    and (tintaDeMaquinaComponente.Tipo = tmctColoranteImobiliario);
end;

end.
