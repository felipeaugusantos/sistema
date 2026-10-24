unit Impostos.Fat.Controller.Interfaces.Generic;

interface

uses Impostos.Fat.Controller.Interfaces.Ipi,
  untFuncFatTypes,
  Impostos.Fat.Controller.Interfaces.IcmsSt,
  Impostos.Fat.Controller.Interfaces.IcmsEfetivo,
  Impostos.Fat.Controller.Interfaces.FcpDifal;

type
  IImpostosFatControllerGeneric = interface
    ['{7460E213-8CFD-450D-9497-F67E0DFA57CF}']

    function Ipi: IImpostosFatControllerIpi;
    function IcmsSt: IImpostosFatControllerIcmsSt;
    function IcmsEfetivo: IImpostosFatControllerIcmsEfetivo;
    function FcpDifal: IImpostosFatControllerFcpDifal;

    function SetarMatrizItens(var AMatItens: TMatrizFechamento): IImpostosFatControllerGeneric;
    function SetarPosicaoMatriz(const APosicao: Integer): IImpostosFatControllerGeneric;
    function SetarDadosFechamento(var ADadosFechamento: TDadosFechamento): IImpostosFatControllerGeneric;
  end;

implementation

end.
