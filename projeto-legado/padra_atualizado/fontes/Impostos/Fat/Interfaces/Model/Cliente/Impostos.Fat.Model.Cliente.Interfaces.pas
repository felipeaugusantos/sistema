unit Impostos.Fat.Model.Cliente.Interfaces;

interface

type
  IResultadoImpostosFatModelCliente = interface
    ['{26CCBB8C-7A72-4E72-8A3A-6E3C9E75C78F}']

    function SituacaoDoIpi: String; overload;
    function SituacaoDoIpi(AValue: String): IResultadoImpostosFatModelCliente; overload;

    function ZonaFranca: Boolean; overload;
    function ZonaFranca(AValue: Boolean): IResultadoImpostosFatModelCliente; overload;

    function OrgaoPublico: Boolean; overload;
    function OrgaoPublico(AValue: Boolean): IResultadoImpostosFatModelCliente; overload;

    function ClienteExterior: Boolean; overload;
    function ClienteExterior(AValue: Boolean): IResultadoImpostosFatModelCliente; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IResultadoImpostosFatModelCliente; overload;

    function ClienteConsumidor: Boolean; overload;
    function ClienteConsumidor(AValue: Boolean): IResultadoImpostosFatModelCliente; overload;
  end;

  IImpostosFatModelCliente = interface
    ['{81DB7FE1-A50D-491F-99DA-D7DF185095C8}']

    function Consultar(const ACodigoDoCliente: String): IResultadoImpostosFatModelCliente;
  end;

implementation

end.

