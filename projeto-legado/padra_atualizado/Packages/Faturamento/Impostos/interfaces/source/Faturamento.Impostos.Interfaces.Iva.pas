unit Faturamento.Impostos.Interfaces.Iva;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  IParametrosCalculoIva = interface
    ['{5704118B-E46C-4F05-8B8E-9EDBB251D7F0}']

    function PercentualDoIvaAbreviacao: Double; overload;
    function PercentualDoIvaAbreviacao(AValue: Double): IParametrosCalculoIva; overload;

    function ModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ModelClienteFornecedor(AValue: IResultadoFaturamentoImpostosModelClienteFornecedor): IParametrosCalculoIva; overload;

    function ModelProduto: IResultadoFaturamentoImpostosModelProduto; overload;
    function ModelProduto(AValue: IResultadoFaturamentoImpostosModelProduto): IParametrosCalculoIva; overload;

    function ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; overload;
    function ModelEmpresa(AValue: IResultadoFaturamentoImpostosModelEmpresa): IParametrosCalculoIva; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosCalculoIva; overload;

    function CodigoDaSubstituicaoTributaria: String; overload;
    function CodigoDaSubstituicaoTributaria(AValue: String): IParametrosCalculoIva; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IParametrosCalculoIva; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosCalculoIva; overload;

//    function ClienteIVAEspMT: Double; overload;
//    function ClienteIVAEspMT(AValue: Double): IParametrosCalculoIva; overload;
//
//    function ClienteIVANacMT: Double; overload;
//    function ClienteIVANacMT(AValue: Double): IParametrosCalculoIva; overload;
//
//    function ClienteIVASimMT: Double; overload;
//    function ClienteIVASimMT(AValue: Double): IParametrosCalculoIva; overload;

	  function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoIva; overload;

    function ValorDeIpiDoItem: Double; overload;
    function ValorDeIpiDoItem(AValue: Double): IParametrosCalculoIva; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosCalculoIva; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoIva; overload;

    function DocumentoParaFornecedor: Boolean; overload;
    function DocumentoParaFornecedor(AValue: Boolean): IParametrosCalculoIva; overload;

    function ExisteNaTabelaCEDEM: Boolean; overload;
    function ExisteNaTabelaCEDEM(AValue: Boolean): IParametrosCalculoIva; overload;
  end;

  IResultadoCalculoIva = interface
    ['{3F2511F0-455F-4E62-91DF-A37AB3E816A0}']

    function ValorDoIva: Double; overload;
    function ValorDoIva(AValue: Double): IResultadoCalculoIva; overload;

    function ValorDoIvaMatriz: Double; overload;
    function ValorDoIvaMatriz(AValue: Double): IResultadoCalculoIva; overload;

    function ValorDoIvaStMatriz: Double; overload;
    function ValorDoIvaStMatriz(AValue: Double): IResultadoCalculoIva; overload;

    function ClienteIVAEspMT: Double; overload;
    function ClienteIVAEspMT(AValue: Double): IResultadoCalculoIva; overload;
  end;

  IRegraCalculoIva = interface
    ['{F801A167-8FD1-4C0D-9DD5-AB686FEA0A00}']

    function CalcularValorIva: IResultadoCalculoIva;
  end;



  //Abstracao

  IAbstractRegraTributacaoIva = interface
    ['{4E5439E9-E137-40BC-AB69-E36F5047552A}']

    procedure IniciarIvaCliente;
    procedure IniciarIvaAliquota;
    procedure CalcularValorDoIvaEspMTOuNacMT;
    procedure AdicionarValorDoIvaAosCamposParaMatriz;
    procedure CalcularValorDoIvaCNAESimplificado;
    function ResultadoDoCalculoDoIva: IResultadoCalculoIva;
  end;

implementation

end.
