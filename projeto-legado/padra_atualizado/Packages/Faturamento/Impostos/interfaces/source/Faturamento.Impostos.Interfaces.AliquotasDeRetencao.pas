unit Faturamento.Impostos.Interfaces.AliquotasDeRetencao;

interface

Uses Faturamento.Impostos.Interfaces.Model;


type
  IParametrosAliquotasDeRetencao = interface
    ['{5704118B-E46C-4F05-8B8E-9EDBB251D7F0}']
    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosAliquotasDeRetencao ; overload;

    function ParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue : IParametrosFaturamentoImpostosClienteConsumidor) : IParametrosAliquotasDeRetencao; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosAliquotasDeRetencao ; overload;
  end;

  IResultadoAliquotasDeRetencao = interface
    ['{3F2511F0-455F-4E62-91DF-A37AB3E816A0}']
    function AliquotaIRPJ: Double; overload;
    function AliquotaIRPJ(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaPIS : Double; overload;
    function AliquotaPIS(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaCOFINS: Double; overload;
    function AliquotaCOFINS(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaCSLL: Double; overload;
    function AliquotaCSLL(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaProdutoIRPJ: Double; overload;
    function AliquotaProdutoIRPJ(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaProdutoPIS : Double; overload;
    function AliquotaProdutoPIS(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaProdutoCOFINS: Double; overload;
    function AliquotaProdutoCOFINS(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaProdutoCSLL: Double; overload;
    function AliquotaProdutoCSLL(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function ValorMinimoRetencaoPisCofinsCsll : Double; overload;
    function ValorMinimoRetencaoPisCofinsCsll(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function ValorMinimoRetencaoIRPJ : Double; overload;
    function ValorMinimoRetencaoIRPJ(AValue: Double): IResultadoAliquotasDeRetencao; overload;

  end;

  IRegrasAliquotasRetencao = interface
  ['{A766C431-BC25-476A-BF50-F08660FF592A}']

    function CarregarAliquotasRetencao(AParametros: IParametrosAliquotasDeRetencao = Nil): IResultadoAliquotasDeRetencao; overload;

    function CarregarModelCliente : IRegrasAliquotasRetencao;

    function UtilizarModelCliente(
      Const AParametros : IResultadoFaturamentoImpostosModelClienteFornecedor;
      Const AParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor = Nil) : IRegrasAliquotasRetencao;


  end;

implementation

end.
