unit Faturamento.Impostos.Interfaces.Servicos.Classe.Difal;

interface

uses Faturamento.Impostos.Interfaces.Difal;

type
  IParametrosClasseDifal = interface
    ['{6F022094-7094-4DC0-A48A-976A93752D4F}']

    function ParametrosCalculoDifal: IParametrosCalculoDifal; overload;
    function ParametrosCalculoDifal(AValue: IParametrosCalculoDifal): IParametrosClasseDifal; overload;
  end;

  IResultadoClasseDifal = interface
    ['{8DF1EF4E-52B7-4A05-ACFF-A40E373DEA99}']

    function ResultadoCalculoDifal: IResultadoCalculoDifal; overload;
    function ResultadoCalculoDifal(AValue: IResultadoCalculoDifal): IResultadoClasseDifal; overload;

    function ParametrosCalculoDifal: IParametrosCalculoDifal; overload;
    function ParametrosCalculoDifal(AValue: IParametrosCalculoDifal): IResultadoClasseDifal; overload;
  end;

  IServicosClasseDifal = Interface
    ['{CA8C448E-FBC7-453C-8D76-97E556C3849B}']

//    function CalcularDifal: IResultadoClasseDifal;
    function CalcularDifalFinal: IResultadoClasseDifal;
  End;


implementation

end.
