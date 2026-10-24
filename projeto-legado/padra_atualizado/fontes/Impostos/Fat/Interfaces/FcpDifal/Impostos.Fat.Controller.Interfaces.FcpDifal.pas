unit Impostos.Fat.Controller.Interfaces.FcpDifal;

interface

uses Faturamento.Impostos.Interfaces.FcpDifal;

type
  IImpostosFatControllerFcpDifal = interface
    ['{D13D9988-F3BD-4B0D-88EB-FCCBE82E3158}']

    function CalcularValorFcpDifalFinal: IResultadoCalculoFcpDifalFinal;
  end;

implementation

end.
