unit untFormulaAutomotivaBrazilianColor;

interface

uses
  untIFormulaAutomotiva , untAbstractFormulaAutomotiva;

type
  TFormulaAutomotivaBrazilianColor = class(TAbstractFormulaAutomotiva, IFormulaAutomotiva)
  public
    function GetNomeTabelaBase: string; override;
    function GetTipBas(const strCodBas: string): string; override;
  end;


implementation

{ TFormulaAutomotivaBrazilianColor }

function TFormulaAutomotivaBrazilianColor.GetNomeTabelaBase: string;
begin
  Result := 'BZC_CADBAS';
end;

function TFormulaAutomotivaBrazilianColor.GetTipBas(const strCodBas: string): string;
begin
  if strCodBas = 'BP 8007' then
    Result := 'D'
  else
    Result := 'B';
end;

end.
