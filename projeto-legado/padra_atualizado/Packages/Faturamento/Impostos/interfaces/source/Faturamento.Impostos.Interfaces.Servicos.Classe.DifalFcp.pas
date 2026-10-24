unit Faturamento.Impostos.Interfaces.Servicos.Classe.DifalFcp;

interface

uses Faturamento.Impostos.Interfaces.FCP;

type
  IParametrosClasseDifalFcp = interface
    ['{6F022094-7094-4DC0-A48A-976A93752D4F}']

    function ParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp; overload;
    function ParametrosCalculoDifalFcp(AValue: IParametrosCalculoDifalFcp): IParametrosClasseDifalFcp; overload;
  end;

  IResultadoClasseDifalFcp = interface
    ['{8DF1EF4E-52B7-4A05-ACFF-A40E373DEA99}']

    function ResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp; overload;
    function ResultadoCalculoDifalFcp(AValue: IResultadoCalculoDifalFcp): IResultadoClasseDifalFcp; overload;

    function ParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp; overload;
    function ParametrosCalculoDifalFcp(AValue: IParametrosCalculoDifalFcp): IResultadoClasseDifalFcp; overload;

  end;

  IServicosClasseDifalFcp = Interface
    ['{CA8C448E-FBC7-453C-8D76-97E556C3849B}']

    function CalcularDifalFcp: IResultadoClasseDifalFcp;
  End;


implementation

end.
