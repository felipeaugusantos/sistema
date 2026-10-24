unit Controller.Faturamento.Interfaces.Impostos.Generic;

interface

uses Controller.Faturamento.Interfaces.Impostos.Ipi,
  untFuncFatTypes,
  Controller.Faturamento.Interfaces.Impostos.IcmsSt,
  Controller.Faturamento.Interfaces.Impostos.IcmsEfetivo,
  Controller.Faturamento.Interfaces.Impostos.FcpDifal;

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
