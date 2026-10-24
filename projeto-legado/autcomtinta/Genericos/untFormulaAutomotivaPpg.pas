unit untFormulaAutomotivaPpg;

interface

uses
  untIFormulaAutomotiva , untAbstractFormulaAutomotiva;

type
  TFormulaAutomotivaPpg = class(TAbstractFormulaAutomotiva, IFormulaAutomotiva)
  public
    function GetNomeTabelaBase: string; override;
    function GetTipBas(const strCodBas: string): string; override;
    function GetVolumeOri: Double; override; 
  end;

implementation

{ TFormulaAutomotivaPpg }

function TFormulaAutomotivaPpg.GetNomeTabelaBase: string;
begin
  Result := 'PPG_CADBAS';
end;

function TFormulaAutomotivaPpg.GetTipBas(const strCodBas: string): string;
begin
  Result := 'B';
end;

function TFormulaAutomotivaPpg.GetVolumeOri: Double;
begin
  Result := 1;
end;

end.
