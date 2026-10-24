unit Impostos.Fat.Parametros.Comum.Interfaces;

interface

Uses
  Shared.Functions.Types, Faturamento.Impostos.Interfaces.Model;

type
  IImpostosFatParametrosComum = interface
    ['{2FDE190D-E3C5-4C77-B6DD-FF58E520FF4D}']

    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IImpostosFatParametrosComum; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IImpostosFatParametrosComum; overload;

    function SequencialEnderecoEntrega: String; overload;
    function SequencialEnderecoEntrega(AValue: String): IImpostosFatParametrosComum; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IImpostosFatParametrosComum; overload;

    function ClassificacaoFiscal: String; overload;
    function ClassificacaoFiscal(AValue: String): IImpostosFatParametrosComum; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IImpostosFatParametrosComum; overload;

    function DesmembrarNotaProdutosServicos : Boolean;overload;
    function DesmembrarNotaProdutosServicos(AValue: Boolean): IImpostosFatParametrosComum; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue: Boolean): IImpostosFatParametrosComum; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue : Boolean) : IImpostosFatParametrosComum; overload;

    function TaxaBombeamentoPedidoOrcamento : Boolean;overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IImpostosFatParametrosComum; overload;

    function OpcaoDoDocumento: String; overload;
    function OpcaoDoDocumento(AValue: String): IImpostosFatParametrosComum; overload;

    function DesmembrarMeiaNotaComNotaNormal : Boolean; overload;
    function DesmembrarMeiaNotaComNotaNormal(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function BaixaDeEntregaFutura : Boolean; overload;
    function BaixaDeEntregaFutura(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function EntregaFutura : Boolean; overload;
    function EntregaFutura(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function NotaComplementoFornecedor : Boolean; overload;
    function NotaComplementoFornecedor(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function NotaEspecialFornecedor : Boolean; overload;
    function NotaEspecialFornecedor(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function CodigoDoFornecedor: String; overload;
    function CodigoDoFornecedor(AValue: String): IImpostosFatParametrosComum; overload;

    function MetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF; overload;
    function MetodoArredondamentoICMSECF(AValue: TMetodoArredondamentoICMSECF): IImpostosFatParametrosComum; overload;
    function MetodoArredondamentoICMSECF(AValue: Double): Double; overload;

    function CodigoDaEmpresaTE: String; overload;
    function CodigoDaEmpresaTE(AValue: String): IImpostosFatParametrosComum; overload;

    function TipoOperacaoPedidoVenda: String; overload;
    function TipoOperacaoPedidoVenda(AValue: String): IImpostosFatParametrosComum; overload;

    function UtilizaSat : Boolean; overload;
    function UtilizaSat(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function CalcularSatEcf : Boolean; overload;
    function CalcularSatEcf(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function TipoDePedidoFaturamento: String; overload;
    function TipoDePedidoFaturamento(AValue: String): IImpostosFatParametrosComum; overload;

    function OrigemF11: Boolean; overload;
    function OrigemF11(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function CodigoDaEmpresaOriginal: String; overload;
    function CodigoDaEmpresaOriginal(AValue: String): IImpostosFatParametrosComum; overload;

    function NumeroDoOrcamento: String; overload;
    function NumeroDoOrcamento(AValue: String): IImpostosFatParametrosComum; overload;

    function ParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue : IParametrosFaturamentoImpostosClienteConsumidor) : IImpostosFatParametrosComum; overload;
  end;

  IImpostosFatParametrosComumFcpDifal = interface
    ['{083DD411-5203-420F-904C-FB75FE56B6E1}']

    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function SequencialEnderecoEntrega: String; overload;
    function SequencialEnderecoEntrega(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function OpcaoDoDocumento: String; overload;
    function OpcaoDoDocumento(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function CodigoDoFornecedor: String; overload;
    function CodigoDoFornecedor(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function NotaComplementoFornecedor: Boolean; overload;
    function NotaComplementoFornecedor(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function NotaEspecialFornecedor: Boolean; overload;
    function NotaEspecialFornecedor(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue: IParametrosFaturamentoImpostosClienteConsumidor) : IImpostosFatParametrosComumFcpDifal; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function ClienteFilial: Boolean; overload;
    function ClienteFilial(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function DiferencaFCPST: Boolean; overload;
    function DiferencaFCPST(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function CodigoDaEmpresaTE: String; overload;
    function CodigoDaEmpresaTE(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function DataDoSistema: TDateTime; overload;
    function DataDoSistema(AValue: TDateTime): IImpostosFatParametrosComumFcpDifal; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function ClassificacaoFiscalRecebimentoGarantia: String; overload;
    function ClassificacaoFiscalRecebimentoGarantia(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function AliquotaFCPST: Double; overload;
    function AliquotaFCPST(AValue: Double): IImpostosFatParametrosComumFcpDifal; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;
  end;

  procedure SetarImpostosFatParametrosComum(AValue: IImpostosFatParametrosComum);
  procedure SetarImpostosFatParametrosComumFcpDifal(AValue: IImpostosFatParametrosComumFcpDifal);

Var
  objImpostosFatParametrosComum: IImpostosFatParametrosComum;
  objImpostosFatParametrosComumFcpDifal: IImpostosFatParametrosComumFcpDifal;

implementation

procedure SetarImpostosFatParametrosComum(AValue: IImpostosFatParametrosComum);
begin
  If Assigned(objImpostosFatParametrosComum) Then
    objImpostosFatParametrosComum := Nil;

  objImpostosFatParametrosComum := AValue;
end;

procedure SetarImpostosFatParametrosComumFcpDifal(AValue: IImpostosFatParametrosComumFcpDifal);
begin
  If Assigned(objImpostosFatParametrosComumFcpDifal) Then
    objImpostosFatParametrosComumFcpDifal := Nil;

  objImpostosFatParametrosComumFcpDifal := AValue;
end;

end.
