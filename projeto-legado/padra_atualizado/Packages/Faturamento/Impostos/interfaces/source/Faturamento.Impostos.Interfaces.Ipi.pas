unit Faturamento.Impostos.Interfaces.Ipi;

interface

uses Shared.Functions.Types,
     Faturamento.Impostos.Interfaces.Model;

type
  IParametrosCalculoIPI = interface
    ['{0E29DCD2-0E7A-46B9-8834-04E62212BD0B}']

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosCalculoIPI; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosCalculoIPI; overload;

    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosCalculoIPI; overload;

    function ClienteDoExterior: Boolean; overload;
    function ClienteDoExterior(AValue: Boolean): IParametrosCalculoIPI; overload;

    function SituacaoTributariaIPI: string; overload;
    function SituacaoTributariaIPI(AValue: string): IParametrosCalculoIPI; overload;

    function BaseDoIpi: Double; overload;
    function BaseDoIpi(AValue: Double): IParametrosCalculoIPI; overload;

    function AliquotaDeCalculoIPI: Double; overload;
    function AliquotaDeCalculoIPI(AValue: Double): IParametrosCalculoIPI; overload;

  end;

  IResultadoCalculoIPI = interface
    ['{1A5FB75C-2B27-42FD-AA65-96CA22B4BC3C}']
    function ValorCalculadoIPI: Double; overload;
    function ValorCalculadoIPI(AValue: Double): IResultadoCalculoIPI; overload;

    function BaseDeCalculoIPI: Double; overload;
    function BaseDeCalculoIPI(AValue: Double): IResultadoCalculoIPI; overload;

    function AliquotaDeCalculoIPI: Double; overload;
    function AliquotaDeCalculoIPI(AValue: Double): IResultadoCalculoIPI; overload;

    function ValorCalculadoIPIConsignacao: Double; overload;
    function ValorCalculadoIPIConsignacao(AValue: Double): IResultadoCalculoIPI; overload;
  end;

  ICalculoImpostosIPI = interface
    ['{BB65AB87-2D9D-40F8-BB19-9010E3A9A08C}']
    function CalcularValorIPI(AParametros: IParametrosCalculoIPI): IResultadoCalculoIPI; overload;
  end;

  IParametrosServicoIPI = interface
    ['{CEED2657-C3A9-46C1-BD97-01CB9B5266D7}']

    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosServicoIPI; overload;

    function CodigoDoProduto: String; overload;
    function CodigoDoProduto(AValue: String): IParametrosServicoIPI; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IParametrosServicoIPI; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosServicoIPI; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosServicoIPI; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosServicoIPI; overload;

    function DesmembrarNotaProdutosServicos : Boolean;overload;
    function DesmembrarNotaProdutosServicos(AValue: Boolean): IParametrosServicoIPI; overload;

    function OpcaoDoDocumento: String; overload;
    function OpcaoDoDocumento(AValue: String): IParametrosServicoIPI; overload;

    function OpcaoDeItemNfEspiritoSanto : TOpcItensNFespTinta; overload;
    function OpcaoDeItemNfEspiritoSanto(AValue: TOpcItensNFespTinta): IParametrosServicoIPI; overload;

    function EspecieDeDevolucao: String; overload;
    function EspecieDeDevolucao(AValue: String): IParametrosServicoIPI; overload;

    function DesmembrarMeiaNotaComNotaNormal : Boolean;overload;
    function DesmembrarMeiaNotaComNotaNormal(AValue: Boolean): IParametrosServicoIPI; overload;

    function BaixaDeEntregaFutura : Boolean; overload;
    function BaixaDeEntregaFutura(AValue : Boolean): IParametrosServicoIPI; overload;

    function EntregaFutura : Boolean; overload;
    function EntregaFutura(AValue : Boolean): IParametrosServicoIPI; overload;

    function MeiaNotaFatorExpedicao : Boolean; overload;
    function MeiaNotaFatorExpedicao(AValue : Boolean): IParametrosServicoIPI; overload;

    function TotalGeralDoItem : Double;overload;
    function TotalGeralDoItem(AValue : Double): IParametrosServicoIPI; overload;

    function ValorFreteDoItem : Double;overload;
    function ValorFreteDoItem(AValue : Double): IParametrosServicoIPI; overload;

    function DespesaAcessoriaDoItem : Double;overload;
    function DespesaAcessoriaDoItem(AValue : Double): IParametrosServicoIPI; overload;

    function DescontoEspecial : Double;overload;
    function DescontoEspecial(AValue : Double): IParametrosServicoIPI; overload;

    function NotaComplementoFornecedor : Boolean; overload;
    function NotaComplementoFornecedor(AValue : Boolean): IParametrosServicoIPI; overload;

    function NotaEspecialFornecedor : Boolean; overload;
    function NotaEspecialFornecedor(AValue : Boolean): IParametrosServicoIPI; overload;

    function CodigoDoFornecedor : String; overload;
    function CodigoDoFornecedor(AValue: String): IParametrosServicoIPI; overload;

    function SequencialEnderecoEntrega: String; overload;
    function SequencialEnderecoEntrega(AValue: String): IParametrosServicoIPI; overload;

    function GerandoCasosTestes: Boolean; overload;
    function GerandoCasosTestes(AValue: boolean): IParametrosServicoIPI; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosServicoIPI; overload;

    function ParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue : IParametrosFaturamentoImpostosClienteConsumidor) : IParametrosServicoIPI; overload;

    function TotalGeralDoItemPreUlt : Double;overload;
    function TotalGeralDoItemPreUlt(AValue : Double): IParametrosServicoIPI; overload;

    function TipoDePedidoFaturamento : String;overload;
    function TipoDePedidoFaturamento(AValue : String): IParametrosServicoIPI; overload;

    function TipoDeBaixaEntregaFutura: String; overload;
    function TipoDeBaixaEntregaFutura(AValue: String): IParametrosServicoIPI; overload;

    function OpcaoDoDocumentoVerdadeira: String; overload;
    function OpcaoDoDocumentoVerdadeira(AValue: String): IParametrosServicoIPI; overload;

    function CodigoDaFazenda: String; overload;
    function CodigoDaFazenda(AValue: String): IParametrosServicoIPI; overload;

  end;

  IResultadoServicosClasseIpi = interface
    ['{F869EF88-3418-4501-B686-9E370712FA95}']

    function ResultadoCalculoIPI: IResultadoCalculoIPI; overload;
    function ResultadoCalculoIPI(AValue: IResultadoCalculoIPI): IResultadoServicosClasseIpi; overload;

    function ParametrosCalculoIPI: IParametrosCalculoIPI; overload;
    function ParametrosCalculoIPI(AValue: IParametrosCalculoIPI): IResultadoServicosClasseIpi; overload;
  end;

  IResultadoAbreviacaoIpi = interface
    ['{E3EE02A3-E122-4216-B60D-FFA8E119165E}']
    function BaseDeCalculoIPI: Double; overload;
    function BaseDeCalculoIPI(AValue: Double): IResultadoAbreviacaoIpi; overload;

    function AliquotaDeCalculoIPI: Double; overload;
    function AliquotaDeCalculoIPI(AValue: Double): IResultadoAbreviacaoIpi; overload;
  end;

implementation

end.
