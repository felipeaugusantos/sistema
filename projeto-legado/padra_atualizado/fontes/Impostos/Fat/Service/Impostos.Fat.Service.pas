unit Impostos.Fat.Service;

//classe servico

interface

uses Impostos.Fat.Service.Interfaces, Faturamento.Impostos.Interfaces.Ipi,
  Impostos.Fat.Parametros.Interfaces.Ipi, Impostos.Fat.Classe.Ipi;

type
  TImpostosFatService = class sealed(TInterfacedObject, IImpostosFatService)
  public
    function CalcularValorIpi(AParametros: IImpostosFatParametrosIpi): IResultadoCalculoIPI;
    function CalcularValorIpiFinal(AParametros: IImpostosFatParametrosIpi): IResultadoCalculoIPI;

    class function New(): IImpostosFatService;
  end;

implementation

{ TImpostosFatService }

function TImpostosFatService.CalcularValorIpi(AParametros: IImpostosFatParametrosIpi): IResultadoCalculoIPI;
begin
  Result := TImpostosFatClasseIpi.New(AParametros).CalcularValorDoIpi;
end;

function TImpostosFatService.CalcularValorIpiFinal(AParametros: IImpostosFatParametrosIpi): IResultadoCalculoIPI;
begin
  Result := TImpostosFatClasseIpi.New(AParametros).CalcularValorDoIpiFinal;
end;

class function TImpostosFatService.New: IImpostosFatService;
begin
  Result := Self.Create;
end;

end.
