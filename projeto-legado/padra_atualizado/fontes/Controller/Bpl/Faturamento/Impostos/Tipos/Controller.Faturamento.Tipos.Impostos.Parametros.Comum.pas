unit Controller.Faturamento.Tipos.Impostos.Parametros.Comum;

interface

uses
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum,
  Faturamento.Impostos.Interfaces.Model,
  Shared.Functions.Types;

type
  TImpostosFatParametrosComum = class(TInterfacedObject, IImpostosFatParametrosComum)
  private
    FCodigoDoCliente                  : String;
    FCodigoDaEmpresa                  : String;
    FSequencialEnderecoEntrega        : String;
    FVendaPresencial                  : Boolean;
    FClassificacaoFiscal              : String;
    FEspecieDoDocumento               : String;
    FOpcaoDoDocumento                 : String;
    FDesmembrarNotaProdutosServicos   : Boolean;
    FDesmembrarMeiaNotaComNotaNormal  : Boolean;
    FTaxaBombeamentoPedidoOrcamento   : Boolean;
    FBaixaDeEntregaFutura             : Boolean;
    FEntregaFutura                    : Boolean;
    FCodigoDoFornecedor               : String;
    FNotaComplementoFornecedor        : Boolean;
    FNotaEspecialFornecedor           : Boolean;
    FMetodoArredondamentoICMSECF      : TMetodoArredondamentoICMSECF;
    FCodigoDaEmpresaTE                : String;
    FTipoOperacaoPedidoVenda          : String;
    FUtilizaSat                       : Boolean;
    FCalcularSatEcf                   : Boolean;
    FClienteConsumidorFinal         : Boolean;
    FTipoDePedidoFaturamento          : String;
    FClienteIndustria                 : Boolean;
    FClienteComercializacao           : Boolean;
    FOrigemF11                        : Boolean;
    FCodigoDaEmpresaOriginal          : String;
    FNumeroDoOrcamento                : String;
    FParametrosClienteConsumidor      : IParametrosFaturamentoImpostosClienteConsumidor;
    FTipoDeBaixaEntregaFutura         : String;
    FOpcaoDoDocumentoVerdadeira       : String;
    FEhDevolucaoEspelho               : Boolean;
    FRegimeEspecialPorEmpresa         : Boolean;
    FCodigoDaEmpresaAbf               : String;
    FConsideraDescontoNaBaseDeCalculoOrgaoPublico : Boolean;
    FCodigoDaFazenda                  : String;
    FTributaZonaFrancaManausUsoConsumo : Boolean;
  public
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

    function DesmembrarNotaProdutosServicos : Boolean; overload;
    function DesmembrarNotaProdutosServicos(AValue: Boolean): IImpostosFatParametrosComum; overload;

    function ClienteIndustria : Boolean; overload;
    function ClienteIndustria(AValue: Boolean): IImpostosFatParametrosComum; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue : Boolean) : IImpostosFatParametrosComum; overload;

    function TaxaBombeamentoPedidoOrcamento : Boolean; overload;
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

    function UtilizaSat: Boolean; overload;
    function UtilizaSat(AValue: Boolean): IImpostosFatParametrosComum; overload;

    function CalcularSatEcf: Boolean; overload;
    function CalcularSatEcf(AValue: Boolean): IImpostosFatParametrosComum; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IImpostosFatParametrosComum; overload;

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

    function TipoDeBaixaEntregaFutura: String; overload;
    function TipoDeBaixaEntregaFutura(AValue: String): IImpostosFatParametrosComum; overload;

    function OpcaoDoDocumentoVerdadeira: String; overload;
    function OpcaoDoDocumentoVerdadeira(AValue: String): IImpostosFatParametrosComum; overload;

    function EhDevolucaoEspelho: Boolean; overload;
    function EhDevolucaoEspelho(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function RegimeEspecialPorEmpresa: Boolean; overload;
    function RegimeEspecialPorEmpresa(AValue : Boolean): IImpostosFatParametrosComum; overload;

    function CodigoDaEmpresaAbf: String; overload;
    function CodigoDaEmpresaAbf(AValue: String): IImpostosFatParametrosComum; overload;

    function ConsideraDescontoNaBaseDeCalculoOrgaoPublico : Boolean; overload;
    function ConsideraDescontoNaBaseDeCalculoOrgaoPublico(const AValue : Boolean) : IImpostosFatParametrosComum; overload;

    function CodigoDaFazenda: String; overload;
    function CodigoDaFazenda(AValue: String): IImpostosFatParametrosComum; overload;

    function TributaClienteZonaFranca: Boolean; overload;
    function TributaClienteZonaFranca(AValue: Boolean): IImpostosFatParametrosComum; overload;

    class function New(): IImpostosFatParametrosComum;
  end;

type
  TImpostosFatParametrosComumFcpDifal = class(TInterfacedObject, IImpostosFatParametrosComumFcpDifal)
  private
    FCodigoDoCliente: String;
    FSequencialEnderecoEntrega: String;
    FVendaPresencial: Boolean;
    FOpcaoDoDocumento: String;
    FCodigoDoFornecedor: String;
    FNotaComplementoFornecedor: Boolean;
    FNotaEspecialFornecedor: Boolean;
    FClienteConsumidorFinal: Boolean;
    FParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
    FTipoDaAbreviacaoFiscal: String;
    FClienteFilial: Boolean;
    FDiferencaFCPST: Boolean;
    FCodigoDaEmpresa: String;
    FCodigoDaEmpresaTE: String;
    FDataDoSistema: TDateTime;
    FClienteIndustria: Boolean;
    FClassificacaoFiscalRecebimentoGarantia: String;
    FAliquotaFCPST: Double;
    FBaixaDeEntregaFutura: Boolean;
    FEspecieDoDocumento: String;
    FOpcaoDeDocumentoVerdadeira: String;
    FEntraIPInaBaseIcms: Boolean;
    FClassificacaoFiscal: String;
    FHabilitarNovoCalculoDifalComPercentualBase: Boolean;
    FCodigoDaEmpresaAbf: String;
    FCalculandoPrecoDeVendaComDifal: Boolean;
    FCodigoDaFazenda: String;
  public
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

    function OpcaoDeDocumentoVerdadeira: String; overload;
    function OpcaoDeDocumentoVerdadeira(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function EntraIPInaBaseIcms: Boolean; overload;
    function EntraIPInaBaseIcms(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function ClassificacaoFiscal: String; overload;
    function ClassificacaoFiscal(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function HabilitarNovoCalculoDifalComPercentualBase: Boolean; overload;
    function HabilitarNovoCalculoDifalComPercentualBase(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function CodigoDaEmpresaAbf: String; overload;
    function CodigoDaEmpresaAbf(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    function CalculandoPrecoDeVendaComDifal: Boolean; overload;
    function CalculandoPrecoDeVendaComDifal(AValue: Boolean): IImpostosFatParametrosComumFcpDifal; overload;

    function CodigoDaFazenda: String; overload;
    function CodigoDaFazenda(AValue: String): IImpostosFatParametrosComumFcpDifal; overload;

    class function New(): IImpostosFatParametrosComumFcpDifal;
  end;

implementation

{ TImpostosFatParametrosComum }

function TImpostosFatParametrosComum.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;


function TImpostosFatParametrosComum.BaixaDeEntregaFutura(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TImpostosFatParametrosComum.ClassificacaoFiscal: String;
begin
  Result := FClassificacaoFiscal;
end;

function TImpostosFatParametrosComum.CalcularSatEcf: Boolean;
begin
  Result := FCalcularSatEcf;
end;


function TImpostosFatParametrosComum.CalcularSatEcf(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FCalcularSatEcf := AValue;
end;

function TImpostosFatParametrosComum.ClassificacaoFiscal(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FClassificacaoFiscal := AValue;
end;

function TImpostosFatParametrosComum.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TImpostosFatParametrosComum.ClienteConsumidorFinal(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;


function TImpostosFatParametrosComum.ClienteIndustria: Boolean;
begin
  Result := FClienteIndustria;
end;

function TImpostosFatParametrosComum.ClienteIndustria(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FClienteIndustria:= AValue;
end;


function TImpostosFatParametrosComum.CodigoDaEmpresa(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TImpostosFatParametrosComum.CodigoDaEmpresaAbf: String;
begin
  Result := FCodigoDaEmpresaAbf;
end;

function TImpostosFatParametrosComum.CodigoDaEmpresaAbf(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FCodigoDaEmpresaAbf := AValue;
end;

function TImpostosFatParametrosComum.CodigoDaEmpresaOriginal(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FCodigoDaEmpresaOriginal := AValue;
end;

function TImpostosFatParametrosComum.CodigoDaEmpresaOriginal: String;
begin
  Result := FCodigoDaEmpresaOriginal;
end;

function TImpostosFatParametrosComum.CodigoDaEmpresaTE: String;
begin
  Result := FCodigoDaEmpresaTE;
end;

function TImpostosFatParametrosComum.CodigoDaEmpresaTE(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FCodigoDaEmpresaTE := AValue;
end;

function TImpostosFatParametrosComum.CodigoDaFazenda: String;
begin
  Result := FCodigoDaFazenda;
end;

function TImpostosFatParametrosComum.CodigoDaFazenda(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FCodigoDaFazenda := AValue;
end;

function TImpostosFatParametrosComum.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TImpostosFatParametrosComum.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TImpostosFatParametrosComum.CodigoDoCliente(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TImpostosFatParametrosComum.CodigoDoFornecedor(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TImpostosFatParametrosComum.ConsideraDescontoNaBaseDeCalculoOrgaoPublico: Boolean;
begin
  Result := FConsideraDescontoNaBaseDeCalculoOrgaoPublico;
end;

function TImpostosFatParametrosComum.ConsideraDescontoNaBaseDeCalculoOrgaoPublico(
  const AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FConsideraDescontoNaBaseDeCalculoOrgaoPublico := AValue;
end;

function TImpostosFatParametrosComum.ClienteComercializacao: Boolean;
begin
  Result := FClienteComercializacao;
end;

function TImpostosFatParametrosComum.ClienteComercializacao(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FClienteComercializacao := AValue;
end;

function TImpostosFatParametrosComum.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

function TImpostosFatParametrosComum.DesmembrarNotaProdutosServicos: Boolean;
begin
  Result := FDesmembrarNotaProdutosServicos;
end;

function TImpostosFatParametrosComum.DesmembrarMeiaNotaComNotaNormal: Boolean;
begin
  Result := FDesmembrarMeiaNotaComNotaNormal;
end;

function TImpostosFatParametrosComum.DesmembrarMeiaNotaComNotaNormal(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FDesmembrarMeiaNotaComNotaNormal := AValue;
end;

function TImpostosFatParametrosComum.DesmembrarNotaProdutosServicos(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FDesmembrarNotaProdutosServicos := AValue;
end;

function TImpostosFatParametrosComum.SequencialEnderecoEntrega: String;
begin
  Result := FSequencialEnderecoEntrega;
end;

function TImpostosFatParametrosComum.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TImpostosFatParametrosComum.EntregaFutura: Boolean;
begin
  Result := FEntregaFutura;
end;

function TImpostosFatParametrosComum.EhDevolucaoEspelho: Boolean;
begin
  Result := FEhDevolucaoEspelho;
end;

function TImpostosFatParametrosComum.EhDevolucaoEspelho(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FEhDevolucaoEspelho := AValue;
end;

function TImpostosFatParametrosComum.EntregaFutura(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FEntregaFutura := AValue;
end;

function TImpostosFatParametrosComum.EspecieDoDocumento(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TImpostosFatParametrosComum.MetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF;
begin
  Result := FMetodoArredondamentoICMSECF;
end;

function TImpostosFatParametrosComum.MetodoArredondamentoICMSECF(
  AValue: TMetodoArredondamentoICMSECF): IImpostosFatParametrosComum;
begin
  Result := Self;
  FMetodoArredondamentoICMSECF := AValue;
end;

function TImpostosFatParametrosComum.SequencialEnderecoEntrega(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FSequencialEnderecoEntrega:= AValue;
end;

function TImpostosFatParametrosComum.TaxaBombeamentoPedidoOrcamento: Boolean;
begin
  Result := FTaxaBombeamentoPedidoOrcamento;
end;

function TImpostosFatParametrosComum.TaxaBombeamentoPedidoOrcamento(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FTaxaBombeamentoPedidoOrcamento := AValue;
end;

function TImpostosFatParametrosComum.TipoOperacaoPedidoVenda: String;
begin
  Result := FTipoOperacaoPedidoVenda;
end;

function TImpostosFatParametrosComum.TipoDePedidoFaturamento: String;
begin
  Result := FTipoDePedidoFaturamento;
end;

function TImpostosFatParametrosComum.TipoDePedidoFaturamento(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FTipoDePedidoFaturamento := AValue;
end;

function TImpostosFatParametrosComum.TipoDeBaixaEntregaFutura: String;
begin
  Result := FTipoDeBaixaEntregaFutura;
end;

function TImpostosFatParametrosComum.TipoDeBaixaEntregaFutura(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FTipoDeBaixaEntregaFutura := AValue;
end;

function TImpostosFatParametrosComum.OpcaoDoDocumentoVerdadeira: String;
begin
  Result := FOpcaoDoDocumentoVerdadeira;
end;

function TImpostosFatParametrosComum.OpcaoDoDocumentoVerdadeira(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FOpcaoDoDocumentoVerdadeira := AValue;
end;

function TImpostosFatParametrosComum.TipoOperacaoPedidoVenda(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FTipoOperacaoPedidoVenda := AValue;
end;

function TImpostosFatParametrosComum.TributaClienteZonaFranca: Boolean;
begin
  Result := FTributaZonaFrancaManausUsoConsumo;
end;

function TImpostosFatParametrosComum.TributaClienteZonaFranca(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FTributaZonaFrancaManausUsoConsumo := AValue;
end;

function TImpostosFatParametrosComum.UtilizaSat: Boolean;
begin
  Result := FUtilizaSat;
end;

function TImpostosFatParametrosComum.UtilizaSat(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FUtilizaSat := AValue;
end;

class function TImpostosFatParametrosComum.New: IImpostosFatParametrosComum;
begin
  Result := Self.Create;
end;

function TImpostosFatParametrosComum.NotaComplementoFornecedor: Boolean;
begin
  Result := FNotaComplementoFornecedor;
end;

function TImpostosFatParametrosComum.NotaComplementoFornecedor(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FNotaComplementoFornecedor := AValue;
end;

function TImpostosFatParametrosComum.NotaEspecialFornecedor(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FNotaEspecialFornecedor := AValue;
end;

function TImpostosFatParametrosComum.NumeroDoOrcamento(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FNumeroDoOrcamento := AValue;
end;

function TImpostosFatParametrosComum.NumeroDoOrcamento: String;
begin
  Result := FNumeroDoOrcamento;
end;

function TImpostosFatParametrosComum.NotaEspecialFornecedor: Boolean;
begin
  Result := FNotaEspecialFornecedor;
end;

function TImpostosFatParametrosComum.OpcaoDoDocumento: String;
begin
  Result := FOpcaoDoDocumento;
end;


function TImpostosFatParametrosComum.OpcaoDoDocumento(
  AValue: String): IImpostosFatParametrosComum;
begin
  Result := Self;
  FOpcaoDoDocumento := AValue;
end;

function TImpostosFatParametrosComum.OrigemF11: Boolean;
begin
  Result := FOrigemF11;
end;

function TImpostosFatParametrosComum.OrigemF11(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FOrigemF11 := AValue;
end;

function TImpostosFatParametrosComum.ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := FParametrosClienteConsumidor;
end;

function TImpostosFatParametrosComum.ParametrosClienteConsumidor(
  AValue: IParametrosFaturamentoImpostosClienteConsumidor): IImpostosFatParametrosComum;
begin
  Result := Self;
  FParametrosClienteConsumidor := AValue;
end;

function TImpostosFatParametrosComum.RegimeEspecialPorEmpresa: Boolean;
begin
  Result := FRegimeEspecialPorEmpresa;
end;

function TImpostosFatParametrosComum.RegimeEspecialPorEmpresa(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FRegimeEspecialPorEmpresa := AValue;
end;

function TImpostosFatParametrosComum.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

function TImpostosFatParametrosComum.VendaPresencial(
  AValue: Boolean): IImpostosFatParametrosComum;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

function TImpostosFatParametrosComum.MetodoArredondamentoICMSECF(
  AValue: Double): Double;
begin
  Result := FMetodoArredondamentoICMSECF(AValue);
end;

{ TImpostosFatParametrosComumFcpDifal }

function TImpostosFatParametrosComumFcpDifal.ClassificacaoFiscalRecebimentoGarantia: String;
begin
  Result := FClassificacaoFiscalRecebimentoGarantia;
end;

function TImpostosFatParametrosComumFcpDifal.AliquotaFCPST: Double;
begin
  Result := FAliquotaFCPST;
end;

function TImpostosFatParametrosComumFcpDifal.AliquotaFCPST(
  AValue: Double): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FAliquotaFCPST := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.BaixaDeEntregaFutura(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TImpostosFatParametrosComumFcpDifal.ClassificacaoFiscal: String;
begin
  Result := FClassificacaoFiscal;
end;

function TImpostosFatParametrosComumFcpDifal.CalculandoPrecoDeVendaComDifal: Boolean;
begin
  Result := FCalculandoPrecoDeVendaComDifal;
end;

function TImpostosFatParametrosComumFcpDifal.CalculandoPrecoDeVendaComDifal(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FCalculandoPrecoDeVendaComDifal := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.ClassificacaoFiscal(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FClassificacaoFiscal := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.ClassificacaoFiscalRecebimentoGarantia(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FClassificacaoFiscalRecebimentoGarantia := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.ClienteConsumidorFinal(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.ClienteFilial: Boolean;
begin
  Result := FClienteFilial;
end;

function TImpostosFatParametrosComumFcpDifal.ClienteFilial(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FClienteFilial := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.ClienteIndustria: Boolean;
begin
  Result := FClienteIndustria;
end;

function TImpostosFatParametrosComumFcpDifal.ClienteIndustria(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FClienteIndustria := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDaEmpresa(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDaEmpresaAbf: String;
begin
  Result := FCodigoDaEmpresaAbf;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDaEmpresaAbf(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FCodigoDaEmpresaAbf := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDaEmpresaTE: String;
begin
  Result := FCodigoDaEmpresaTE;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDaEmpresaTE(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FCodigoDaEmpresaTE := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDaFazenda: String;
begin
  Result := FCodigoDaFazenda;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDaFazenda(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FCodigoDaFazenda := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDoCliente(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDoFornecedor(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.DiferencaFCPST: Boolean;
begin
  Result := FDiferencaFCPST;
end;

function TImpostosFatParametrosComumFcpDifal.DataDoSistema: TDateTime;
begin
  Result := FDataDoSistema;
end;

function TImpostosFatParametrosComumFcpDifal.DataDoSistema(
  AValue: TDateTime): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FDataDoSistema := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.DiferencaFCPST(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FDiferencaFCPST := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.EspecieDoDocumento(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TImpostosFatParametrosComumFcpDifal.OpcaoDeDocumentoVerdadeira(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FOpcaoDeDocumentoVerdadeira := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.OpcaoDeDocumentoVerdadeira: String;
begin
  Result := FOpcaoDeDocumentoVerdadeira;
end;

function TImpostosFatParametrosComumFcpDifal.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

class function TImpostosFatParametrosComumFcpDifal.New: IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self.Create;
end;

function TImpostosFatParametrosComumFcpDifal.NotaComplementoFornecedor: Boolean;
begin
  Result := FNotaComplementoFornecedor;
end;

function TImpostosFatParametrosComumFcpDifal.NotaComplementoFornecedor(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FNotaComplementoFornecedor := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.NotaEspecialFornecedor(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FNotaEspecialFornecedor := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.NotaEspecialFornecedor: Boolean;
begin
  Result := FNotaEspecialFornecedor;
end;

function TImpostosFatParametrosComumFcpDifal.OpcaoDoDocumento(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FOpcaoDoDocumento := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.OpcaoDoDocumento: String;
begin
  Result := FOpcaoDoDocumento;
end;

function TImpostosFatParametrosComumFcpDifal.ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := FParametrosClienteConsumidor;
end;

function TImpostosFatParametrosComumFcpDifal.ParametrosClienteConsumidor(
  AValue: IParametrosFaturamentoImpostosClienteConsumidor): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FParametrosClienteConsumidor := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.SequencialEnderecoEntrega(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FSequencialEnderecoEntrega := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.TipoDaAbreviacaoFiscal: String;
begin
  Result := FTipoDaAbreviacaoFiscal;
end;

function TImpostosFatParametrosComumFcpDifal.TipoDaAbreviacaoFiscal(
  AValue: String): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.SequencialEnderecoEntrega: String;
begin
  Result := FSequencialEnderecoEntrega;
end;

function TImpostosFatParametrosComumFcpDifal.VendaPresencial(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

function TImpostosFatParametrosComumFcpDifal.EntraIPInaBaseIcms(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FEntraIPInaBaseIcms := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.EntraIPInaBaseIcms: Boolean;
begin
  Result := FEntraIPInaBaseIcms;
end;

function TImpostosFatParametrosComumFcpDifal.HabilitarNovoCalculoDifalComPercentualBase(
  AValue: Boolean): IImpostosFatParametrosComumFcpDifal;
begin
  Result := Self;
  FHabilitarNovoCalculoDifalComPercentualBase := AValue;
end;

function TImpostosFatParametrosComumFcpDifal.HabilitarNovoCalculoDifalComPercentualBase: Boolean;
begin
  Result := FHabilitarNovoCalculoDifalComPercentualBase;
end;

end.
