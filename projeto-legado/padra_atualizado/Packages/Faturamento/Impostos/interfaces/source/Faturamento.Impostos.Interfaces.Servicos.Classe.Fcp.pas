unit Faturamento.Impostos.Interfaces.Servicos.Classe.Fcp;

interface

uses Faturamento.Impostos.Interfaces.Fcp;

type
  IParametrosClasseFcp = interface
    ['{6F022094-7094-4DC0-A48A-976A93752D4F}']

    function ParametrosCalculoFcp: IParametrosCalculoFcp; overload;
    function ParametrosCalculoFcp(AValue: IParametrosCalculoFcp): IParametrosClasseFcp; overload;
  end;

  IResultadoClasseFcp = interface
    ['{8DF1EF4E-52B7-4A05-ACFF-A40E373DEA99}']

    function ResultadoCalculoFcp: IResultadoCalculoFcp; overload;
    function ResultadoCalculoFcp(AValue: IResultadoCalculoFcp): IResultadoClasseFcp; overload;

    function ParametrosCalculoFcp: IParametrosCalculoFcp; overload;
    function ParametrosCalculoFcp(AValue: IParametrosCalculoFcp): IResultadoClasseFcp; overload;

    function CalculouOValorDoFcp: Boolean; overload;
    function CalculouOValorDoFcp(AValue: Boolean): IResultadoClasseFcp; overload;
  end;

  IServicosClasseFcp = Interface
    ['{CA8C448E-FBC7-453C-8D76-97E556C3849B}']

//    function CalcularFcp: IResultadoClasseFcp;
    function CalcularFcpFinal: IResultadoClasseFcp;
  End;


implementation

end.
