unit Faturamento.Impostos.Interfaces.ST_Simulada;

interface

uses Faturamento.Impostos.Interfaces.Tributacao, Faturamento.Impostos.Interfaces.Model;

type
  IParametrosRegrasSTSimulada = interface
    ['{83F1E24A-EF23-4934-9EF7-A876C47C3D1A}']

    function ModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ModelClienteFornecedor(AValue: IResultadoFaturamentoImpostosModelClienteFornecedor): IParametrosRegrasSTSimulada; overload;

    function ModelProduto: IResultadoFaturamentoImpostosModelProduto; overload;
    function ModelProduto(AValue: IResultadoFaturamentoImpostosModelProduto): IParametrosRegrasSTSimulada; overload;

    function ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; overload;
    function ModelEmpresa(AValue: IResultadoFaturamentoImpostosModelEmpresa): IParametrosRegrasSTSimulada; overload;

	  function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosRegrasSTSimulada; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosRegrasSTSimulada; overload;

    function CodigoDaSubstituicaoTributaria: String; overload;
    function CodigoDaSubstituicaoTributaria(AValue : String): IParametrosRegrasSTSimulada; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IParametrosRegrasSTSimulada; overload;

	  function ValorDoIva: Double; overload;
    function ValorDoIva(AValue: Double): IParametrosRegrasSTSimulada; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue : Double): IParametrosRegrasSTSimulada; overload;

    function PercentualDaBaseDaSubstituicaoTributariaDoItem: Double; overload;
    function PercentualDaBaseDaSubstituicaoTributariaDoItem(AValue : Double): IParametrosRegrasSTSimulada; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegrasSTSimulada; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegrasSTSimulada; overload;

    function DentroDoEstadoCFOP: Boolean; overload;
    function DentroDoEstadoCFOP(AValue: Boolean): IParametrosRegrasSTSimulada; overload;

    function AtividadeConstrutora: Boolean; overload;
    function AtividadeConstrutora(AValue: Boolean): IParametrosRegrasSTSimulada; overload;
  end;

  IResultadoRegrasSTSimulada = interface
    ['{59A3DF74-40EC-4ADF-A351-C53D2B8B3FFB}']

	  function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasSTSimulada; overload;

	  function AliquotaDaSubstituicaoTributariaSimulada: Double; overload;
    function AliquotaDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasSTSimulada; overload;

	  function ValorDaSubstituicaoTributariaSimulada: Double; overload;
    function ValorDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasSTSimulada; overload;
  end;

  ICalculoSTSimulada = interface
    ['{A766C431-BC25-476A-BF50-F08660FF592A}']

    function Calcular(const AParametros: IParametrosRegrasSTSimulada): IResultadoRegrasSTSimulada;
  end;

implementation

end.
