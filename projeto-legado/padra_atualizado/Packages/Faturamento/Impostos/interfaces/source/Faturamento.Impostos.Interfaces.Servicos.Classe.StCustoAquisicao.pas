unit Faturamento.Impostos.Interfaces.Servicos.Classe.StCustoAquisicao;

interface

uses Faturamento.Impostos.Interfaces.STCustoAquisicao, Faturamento.Impostos.Interfaces.Tributacao,
  Faturamento.Impostos.Interfaces.IcmsSt;

type
  IParametrosClasseStCustoAquisicao = interface
    ['{D2E00D61-AD2F-4A27-B6D0-0853C4AA5685}']

    function ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao; overload;
    function ParametrosCalculoStCustoAquisicao(AValue: IParametrosCalculoSTCustoAquisicao): IParametrosClasseStCustoAquisicao; overload;
  end;

  IResultadoClasseStCustoAquisicao = interface
    ['{125A5B8A-C55B-49BE-B423-D72F7074EFD4}']

    function ResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao; overload;
    function ResultadoCalculoStCustoAquisicao(AValue: IResultadoCalculoSTCustoAquisicao): IResultadoClasseStCustoAquisicao; overload;

    function ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao; overload;
    function ParametrosCalculoStCustoAquisicao(AValue: IParametrosCalculoSTCustoAquisicao): IResultadoClasseStCustoAquisicao; overload;
  end;

  IServicosClasseStCustoAquisicao = Interface
    ['{EBD5BF91-0DED-43BB-A91C-1F02CA380164}']

    function CalcularStCustoAquisicao: IResultadoClasseStCustoAquisicao;
  End;

implementation

end.
