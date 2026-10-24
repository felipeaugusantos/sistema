unit Faturamento.Impostos.Interfaces.IcmsSt;

interface

uses
  Faturamento.Impostos.Interfaces.Icms, Faturamento.Impostos.Interfaces.St,
  Shared.Functions.Types, Faturamento.Impostos.Interfaces.Tributacao.DepoisDoCalculo,
  Faturamento.Impostos.Interfaces.IcmsOrgaoPublico,
  Faturamento.Impostos.Interfaces.STCustoAquisicao, Faturamento.Impostos.Interfaces.Model;

type
  IParametrosServicoIcmsSt = interface
    ['{028CD8CB-401C-402B-A0A6-11E5921BEE71}']

    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosServicoIcmsSt; overload;

    function CodigoDoProduto: String; overload;
    function CodigoDoProduto(AValue: String): IParametrosServicoIcmsSt; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IParametrosServicoIcmsSt; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function ValorFreteDoItem: Double; overload;
    function ValorFreteDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function DespesaAcessoriaDoItem: Double; overload;
    function DespesaAcessoriaDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function DescontoEspecial: Double;overload;
    function DescontoEspecial(AValue: Double): IParametrosServicoIcmsSt; overload;

    function MetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF; overload;
    function MetodoArredondamentoICMSECF(AValue: TMetodoArredondamentoICMSECF): IParametrosServicoIcmsSt; overload;
    function MetodoArredondamentoICMSECF(AValue: Double ): Double ; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue : Boolean): IParametrosServicoIcmsSt; overload;


    function NotaComplementoFornecedor : Boolean; overload;
    function NotaComplementoFornecedor(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function NotaEspecialFornecedor : Boolean; overload;
    function NotaEspecialFornecedor(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function CodigoDoFornecedor : String; overload;
    function CodigoDoFornecedor(AValue: String): IParametrosServicoIcmsSt; overload;

    function CodigoDoFornecedorDoItem: String; overload;
    function CodigoDoFornecedorDoItem(AValue: String): IParametrosServicoIcmsSt; overload;    

    function SequencialEnderecoEntrega: String; overload;
    function SequencialEnderecoEntrega(AValue: String): IParametrosServicoIcmsSt; overload;

    function OpcaoDoDocumento: String; overload;
    function OpcaoDoDocumento(AValue: String): IParametrosServicoIcmsSt; overload;

    function EspecieDocumento: String; overload;
    function EspecieDocumento(AValue: String): IParametrosServicoIcmsSt; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosServicoIcmsSt; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosServicoIcmsSt; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosServicoIcmsSt; overload;

    function OpcaoDeItemNfEspiritoSanto : TOpcItensNFespTinta; overload;
    function OpcaoDeItemNfEspiritoSanto(AValue: TOpcItensNFespTinta): IParametrosServicoIcmsSt; overload;

    Function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    Function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function CodigoDaEmpresaTE: String; overload;
    function CodigoDaEmpresaTE(AValue: String): IParametrosServicoIcmsSt; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function TipoOperacaoPedidoVenda: String; overload;
    function TipoOperacaoPedidoVenda(AValue: String): IParametrosServicoIcmsSt; overload;

    function UtilizaSat: Boolean; overload;
    function UtilizaSat(AValue: Boolean): IParametrosServicoIcmsSt; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function CalcularSatEcf: Boolean; overload;
    function CalcularSatEcf(AValue: Boolean): IParametrosServicoIcmsSt; overload;

    function ValorUnitarioDoItem: Double; overload;
    function ValorUnitarioDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function QuantidadeDoItem: Double; overload;
    function QuantidadeDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function GerandoCasosTestes: Boolean; overload;
    function GerandoCasosTestes(AValue: boolean): IParametrosServicoIcmsSt; overload;

    function EspecieDeDevolucao: String; overload;
    function EspecieDeDevolucao(AValue: String): IParametrosServicoIcmsSt; overload;

    function DesmembrarNotaProdutosServicos : Boolean; overload;
    function DesmembrarNotaProdutosServicos(AValue: Boolean): IParametrosServicoIcmsSt; overload;

    function DesmembrarMeiaNotaComNotaNormal: Boolean; overload;
    function DesmembrarMeiaNotaComNotaNormal(AValue: Boolean): IParametrosServicoIcmsSt; overload;

    function MeiaNotaFatorExpedicao : Boolean; overload;
    function MeiaNotaFatorExpedicao(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function PrecoDeCustoDoItem: Double; overload;
    function PrecoDeCustoDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function PrecoDeUltimaCompraDoItem: Double; overload;
    function PrecoDeUltimaCompraDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function PrecoEImpostosDeUltimaCompraDoItem: Double; overload;
    function PrecoEImpostosDeUltimaCompraDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function PercentualDoFcpDoItem: Double; overload;
    function PercentualDoFcpDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function ValorDoFcpDoItem: Double; overload;
    function ValorDoFcpDoItem(AValue: Double): IParametrosServicoIcmsSt; overload;

    function TipoDePedidoFaturamento: String; overload;
    function TipoDePedidoFaturamento(AValue: String): IParametrosServicoIcmsSt; overload;

    function IdePro: String; overload;
    function IdePro(AValue: String): IParametrosServicoIcmsSt; overload;

    function PrecoDeCompraDaTinta: Double; overload;
    function PrecoDeCompraDaTinta(AValue: Double): IParametrosServicoIcmsSt; overload;

    function PrecoDeCustoDoItemSemImpostos: Double; overload;
    function PrecoDeCustoDoItemSemImpostos(AValue: Double): IParametrosServicoIcmsSt; overload;

    function OrigemF11: Boolean; overload;
    function OrigemF11(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function CodigoDaEmpresaOriginal: String; overload;
    function CodigoDaEmpresaOriginal(AValue: String): IParametrosServicoIcmsSt; overload;

    function NumeroDoOrcamento: String; overload;
    function NumeroDoOrcamento(AValue: String): IParametrosServicoIcmsSt; overload;

    function ParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue : IParametrosFaturamentoImpostosClienteConsumidor) : IParametrosServicoIcmsSt; overload;

    function ClassificacaoDeIpi: String; overload;
    function ClassificacaoDeIpi(AValue: String): IParametrosServicoIcmsSt; overload;

    function TipoDeBaixaEntregaFutura: String; overload;
    function TipoDeBaixaEntregaFutura(AValue: String): IParametrosServicoIcmsSt; overload;

    function EhDevolucaoEspelho: Boolean; overload;
    function EhDevolucaoEspelho(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function RegimeEspecialPorEmpresa: Boolean; overload;
    function RegimeEspecialPorEmpresa(AValue: Boolean): IParametrosServicoIcmsSt; overload;

    function CodigoDaEmpresaAbf: String; overload;
    function CodigoDaEmpresaAbf(AValue: String): IParametrosServicoIcmsSt; overload;

    function DescontoEspecialBaixaDeEntregaFutura: Double; overload;
    function DescontoEspecialBaixaDeEntregaFutura(const AValue: Double): IParametrosServicoIcmsSt; overload;

    function ConsideraDescontoNaBaseDeCalculoOrgaoPublico : Boolean; overload;
    function ConsideraDescontoNaBaseDeCalculoOrgaoPublico(const AValue : Boolean) : IParametrosServicoIcmsSt; overload;

    function CodigoDaFazenda: String; overload;
    function CodigoDaFazenda(AValue: String): IParametrosServicoIcmsSt; overload;

    function TributaClienteZonaFranca: Boolean; overload;
    function TributaClienteZonaFranca(AValue: Boolean): IParametrosServicoIcmsSt; overload;
  end;

  IResultadoServicosClasseIcmsSt = interface
    ['{22A0EC68-D62D-476D-B6B1-2DB442C24B50}']

    function ResultadoCalculoIcms: IResultadoCalculoIcms; overload;
    function ResultadoCalculoIcms(AValue: IResultadoCalculoIcms): IResultadoServicosClasseIcmsSt; overload;

    function ResultadoCalculoSt: IResultadoCalculoST; overload;
    function ResultadoCalculoSt(AValue: IResultadoCalculoST): IResultadoServicosClasseIcmsSt; overload;

    function ResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico; overload;
    function ResultadoCalculoIcmsOrgaoPublico(AValue: IResultadoCalculoIcmsOrgaoPublico): IResultadoServicosClasseIcmsSt; overload;

    function ResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao; overload;
    function ResultadoCalculoStCustoAquisicao(AValue: IResultadoCalculoSTCustoAquisicao): IResultadoServicosClasseIcmsSt; overload;

    function ParametrosCalculoIcms: IParametrosCalculoIcms; overload;
    function ParametrosCalculoIcms(AValue: IParametrosCalculoIcms): IResultadoServicosClasseIcmsSt; overload;

    function ParametrosCalculoSt: IParametrosCalculoST; overload;
    function ParametrosCalculoSt(AValue: IParametrosCalculoST): IResultadoServicosClasseIcmsSt; overload;

    function ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico; overload;
    function ParametrosCalculoIcmsOrgaoPublico(AValue: IParametrosCalculoIcmsOrgaoPublico): IResultadoServicosClasseIcmsSt; overload;

    function ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao; overload;
    function ParametrosCalculoStCustoAquisicao(AValue: IParametrosCalculoSTCustoAquisicao): IResultadoServicosClasseIcmsSt; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IResultadoServicosClasseIcmsSt; overload;

    function ResultadoRegrasTributacaoDepoisDoCalculo: IResultadoRegrasTributacaoDepoisDoCalculo; overload;
    function ResultadoRegrasTributacaoDepoisDoCalculo(AValue: IResultadoRegrasTributacaoDepoisDoCalculo): IResultadoServicosClasseIcmsSt; overload;

    function AtendeRegrasAtoDeclaratorioDF: Boolean; overload;
    function AtendeRegrasAtoDeclaratorioDF(AValue: Boolean): IResultadoServicosClasseIcmsSt; overload;

    function STAtribuidaPorRegimeEspecial: Boolean; overload;
    function STAtribuidaPorRegimeEspecial(AValue: Boolean): IResultadoServicosClasseIcmsSt; overload;
  end;

  IResultadoCalculoIcmsSt = interface
    ['{850928BA-5978-481F-B920-DDB913680877}']

    function ResultadoCalculoIcms: IResultadoCalculoIcms; overload;
    function ResultadoCalculoIcms(AValue: IResultadoCalculoIcms): IResultadoCalculoIcmsSt; overload;

    function ResultadoCalculoSt: IResultadoCalculoSt; overload;
    function ResultadoCalculoSt(AValue: IResultadoCalculoSt): IResultadoCalculoIcmsSt; overload;

    function ResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico; overload;
    function ResultadoCalculoIcmsOrgaoPublico(AValue: IResultadoCalculoIcmsOrgaoPublico): IResultadoCalculoIcmsSt; overload;

    function ResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao; overload;
    function ResultadoCalculoStCustoAquisicao(AValue: IResultadoCalculoSTCustoAquisicao): IResultadoCalculoIcmsSt; overload;
  end;

implementation

end.
