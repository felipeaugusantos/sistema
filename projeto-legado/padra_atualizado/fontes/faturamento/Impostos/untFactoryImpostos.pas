unit untFactoryImpostos;

interface

uses untCalculoImpostoIPI, untCalculoImpostoBeneficioREIDI;

type
  TFactoryImpostos = class
  public
    class function Ipi: TCalculoImpostoIPI;
    class function BeneficioREIDI: TCalculoImpostoBeneficioREIDI;
  end;

implementation

uses Shared.Core, untConfiguracoes, untConsultaModelFaturamentoDatabase, Shared.Functions.DataSet;

{ TFactoryImpostos }

class function TFactoryImpostos.BeneficioREIDI: TCalculoImpostoBeneficioREIDI;
begin
  Result := TCalculoImpostoBeneficioREIDI.Create(TFunctionsCore.New());
end;

class function TFactoryImpostos.Ipi: TCalculoImpostoIPI;
begin
  Result := TCalculoImpostoIPI.Create(TFunctionsCore.New(),
                                      TConfiguracoes.New(),
                                      TConsultaModelFaturamentoDatabase.Create(TFunctionsCore.New(), TConfiguracoes.New(), objDataSet)
                                     );
end;

end.
