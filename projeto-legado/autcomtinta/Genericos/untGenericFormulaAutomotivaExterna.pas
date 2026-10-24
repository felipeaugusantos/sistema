unit untGenericFormulaAutomotivaExterna;

interface

uses
  untGenericFormulaAutomotiva;

type
  TGenericFormulaAutomotivaExterna = class(TGenericFormulaAutomotiva)
  public
    procedure pCalcularPrecos; override;
  end;

implementation

{ TGenericFormulaAutomotivaExterna }

procedure TGenericFormulaAutomotivaExterna.pCalcularPrecos;
begin
  inherited;
end;

end.
