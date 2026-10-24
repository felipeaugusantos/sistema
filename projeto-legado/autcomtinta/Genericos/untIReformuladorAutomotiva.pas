unit untIReformuladorAutomotiva;

interface

uses
  untFuncEspecificas;

type
  IReformuladorAutomotiva = interface
    ['{90744923-0145-4A0D-98BA-69B9B27BCBC0}']
    procedure Reformular(const formula: TFormulaAutomotiva; const strChave: string);
  end;

implementation

end.
