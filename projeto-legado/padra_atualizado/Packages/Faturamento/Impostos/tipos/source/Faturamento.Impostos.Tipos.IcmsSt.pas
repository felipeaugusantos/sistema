unit Faturamento.Impostos.Tipos.IcmsSt;

interface

uses
  Faturamento.Impostos.Interfaces.IcmsSt,
  Faturamento.Impostos.Interfaces.Icms,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Interfaces.St, Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Tributacao.DepoisDoCalculo,
  Faturamento.Impostos.Interfaces.IcmsOrgaoPublico,
  Faturamento.Impostos.Interfaces.STCustoAquisicao;

type
  TParametrosServicoIcmsSt = class(TInterfacedObject, IParametrosServicoIcmsSt)
  private
    FCodigoDoCliente                     : String;
    FCodigoDoProduto                     : String;
    FCodigoDaEmpresa                     : String;
    FTotalGeralDoItem                    : Double;
    FValorFreteDoItem                    : Double;
    FDespesaAcessoriaDoItem              : Double;
    FDescontoEspecial                    : Double;
    FMetodoArredondamentoICMSECF         : TMetodoArredondamentoICMSECF;
    FClienteIndustria                    : Boolean;
    FClienteComercializacao              : Boolean;
    FNotaComplementoFornecedor           : Boolean;
    FNotaEspecialFornecedor              : Boolean;
    FTaxaBombeamentoPedidoOrcamento      : Boolean;
    FCodigoDoFornecedor                  : String;
    FCodigoDoFornecedorDoItem            : String;
    FSequencialEnderecoEntrega           : String;
    FOpcaoDoDocumento                    : String;
    FEspecieDocumento                    : String;
    FClassificacaoFiscalDoItem           : String;
    FVendaPresencial                     : Boolean;
    FCodigoDaSituacaoTributaria          : String;
    FOpcaoDeItemNfEspiritoSanto          : TOpcItensNFespTinta;
    FEntregaFuturaDoItem                 : Boolean;
    FBaixaDeEntregaFutura                : Boolean;
    FCodigoDaEmpresaTE                   : String;
    FAliquotaDeIcmsDoItem                : Double;
    FTipoOperacaoPedidoVenda             : String;
    FUtilizaSat                          : Boolean;
    FCalcularSatEcf                      : Boolean;
    FValorUnitarioDoItem                 : Double;
    FQuantidadeDoItem                    : Double;
    FGerandoCasosTestes                  : Boolean;
    FEspecieDeDevolucao                  : string;
    FDesmembrarNotaProdutosServicos      : Boolean;
    FDesmembrarMeiaNotaComNotaNormal     : Boolean;
    FMeiaNotaFatorExpedicao              : Boolean;
    FClienteConsumidorFinal              : Boolean;
    FPrecoDeCustoDoItem                  : Double;
    FPrecoDeUltimaCompraDoItem           : Double;
    FPrecoEImpostosDeUltimaCompraDoItem  : Double;
    FPercentualDoFcpDoItem               : Double;
    FValorDoFcpDoItem                    : Double;
    FTipoDePedidoFaturamento             : String;
    FIdePro                              : String;
    FPrecoDeCompraDaTinta                : Double;
    FPrecoDeCustoDoItemSemImpostos       : Double;
    FOrigemF11                           : Boolean;
    FCodigoDaEmpresaOriginal             : String;
    FNumeroDoOrcamento                   : String;
    FParametrosClienteConsumidor         : IParametrosFaturamentoImpostosClienteConsumidor;
    FClassificacaoDeIpi                  : String;
    FTipoDeBaixaEntregaFutura            : String;
    FEhDevolucaoEspelho                  : Boolean;
    FRegimeEspecialPorEmpresa            : Boolean;
    FCodigoDaEmpresaAbf                  : String;
    FDescontoEspecialBaixaDeEntregaFutura: Double;
    FConsideraDescontoNaBaseDeCalculoOrgaoPublico : Boolean;
    FCodigoDaFazenda                     : String;
    FTributaZonaFrancaUsoConsumo         : Boolean;
  public
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

    function DescontoEspecial: Double; overload;
    function DescontoEspecial(AValue: Double): IParametrosServicoIcmsSt; overload;

    function MetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF; overload;
    function MetodoArredondamentoICMSECF(AValue: TMetodoArredondamentoICMSECF): IParametrosServicoIcmsSt; overload;
    function MetodoArredondamentoICMSECF(AValue: Double): Double; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function NotaComplementoFornecedor : Boolean; overload;
    function NotaComplementoFornecedor(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function NotaEspecialFornecedor : Boolean; overload;
    function NotaEspecialFornecedor(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue : Boolean): IParametrosServicoIcmsSt; overload;

    function CodigoDoFornecedor : String; overload;
    function CodigoDoFornecedor(AValue: String): IParametrosServicoIcmsSt; overload;

    function CodigoDoFornecedorDoItem : String; overload;
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

    class function New(): IParametrosServicoIcmsSt;
  end;

type
  TResultadoServicosClasseIcmsSt = class(TInterfacedObject, IResultadoServicosClasseIcmsSt)
  private
    FResultadoCalculoIcms: IResultadoCalculoIcms;
    FResultadoCalculoSt: IResultadoCalculoST;
    FResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico;
    FResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
    FParametrosCalculoIcms: IParametrosCalculoIcms;
    FParametrosCalculoSt: IParametrosCalculoSt;
    FParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico;
    FParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao;
    FCodigoDaSubstituicaoTributariaDoItem: String;
    FResultadoRegrasTributacaoDepoisDoCalculo: IResultadoRegrasTributacaoDepoisDoCalculo;
    FAtendeRegrasAtoDeclaratorioDF: Boolean;
    FSTAtribuidaPorRegimeEspecial: Boolean;
  public
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

    class function New(): IResultadoServicosClasseIcmsSt;
  end;

type
  TResultadoCalculoIcmsSt = class(TInterfacedObject, IResultadoCalculoIcmsSt)
  private
    FResultadoCalculoIcms: IResultadoCalculoIcms;
    FResultadoCalculoSt: IResultadoCalculoST;
    FResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico;
    FResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
  public
    function ResultadoCalculoIcms: IResultadoCalculoIcms; overload;
    function ResultadoCalculoIcms(AValue: IResultadoCalculoIcms): IResultadoCalculoIcmsSt; overload;

    function ResultadoCalculoSt: IResultadoCalculoST; overload;
    function ResultadoCalculoSt(AValue: IResultadoCalculoST): IResultadoCalculoIcmsSt; overload;

    function ResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico; overload;
    function ResultadoCalculoIcmsOrgaoPublico(AValue: IResultadoCalculoIcmsOrgaoPublico): IResultadoCalculoIcmsSt; overload;

    function ResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao; overload;
    function ResultadoCalculoStCustoAquisicao(AValue: IResultadoCalculoSTCustoAquisicao): IResultadoCalculoIcmsSt; overload;

    class function New(): IResultadoCalculoIcmsSt;
  end;

implementation

{ TParametrosServicoIcmsSt }

function TParametrosServicoIcmsSt.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosServicoIcmsSt.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;


function TParametrosServicoIcmsSt.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;


function TParametrosServicoIcmsSt.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosServicoIcmsSt.CalcularSatEcf: Boolean;
begin
  Result := FCalcularSatEcf;
end;

function TParametrosServicoIcmsSt.CalcularSatEcf(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCalcularSatEcf := AValue;
end;


function TParametrosServicoIcmsSt.ClassificacaoDeIpi: String;
begin
  Result := FClassificacaoDeIpi;
end;

function TParametrosServicoIcmsSt.ClassificacaoDeIpi(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FClassificacaoDeIpi := AValue;
end;

function TParametrosServicoIcmsSt.ClassificacaoFiscalDoItem(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosServicoIcmsSt.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosServicoIcmsSt.ClienteComercializacao: Boolean;
begin
  Result := FClienteComercializacao;
end;

function TParametrosServicoIcmsSt.ClienteComercializacao(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FClienteComercializacao := AValue;
end;

function TParametrosServicoIcmsSt.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosServicoIcmsSt.ClienteIndustria: Boolean;
begin
  Result := FClienteIndustria;
end;

function TParametrosServicoIcmsSt.ClienteIndustria(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FClienteIndustria:= AValue;
end;

function TParametrosServicoIcmsSt.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosServicoIcmsSt.CodigoDaEmpresa(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TParametrosServicoIcmsSt.CodigoDaEmpresaAbf: String;
begin
  Result := FCodigoDaEmpresaAbf;
end;

function TParametrosServicoIcmsSt.CodigoDaEmpresaAbf(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDaEmpresaAbf := AValue;
end;

function TParametrosServicoIcmsSt.CodigoDaEmpresaOriginal: String;
begin
  Result := FCodigoDaEmpresaOriginal;
end;

function TParametrosServicoIcmsSt.CodigoDaEmpresaOriginal(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDaEmpresaOriginal := AValue;
end;

function TParametrosServicoIcmsSt.CodigoDaEmpresaTE: String;
begin
  Result := FCodigoDaEmpresaTE;
end;

function TParametrosServicoIcmsSt.CodigoDaEmpresaTE(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDaEmpresaTE := AValue;
end;

function TParametrosServicoIcmsSt.CodigoDaFazenda: String;
begin
  Result := FCodigoDaFazenda;
end;

function TParametrosServicoIcmsSt.CodigoDaFazenda(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDaFazenda := AValue;
end;

function TParametrosServicoIcmsSt.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosServicoIcmsSt.CodigoDaSituacaoTributaria: String;
begin
  Result := FCodigoDaSituacaoTributaria;
end;

function TParametrosServicoIcmsSt.CodigoDaSituacaoTributaria(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TParametrosServicoIcmsSt.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TParametrosServicoIcmsSt.CodigoDoCliente(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TParametrosServicoIcmsSt.CodigoDoFornecedor(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TParametrosServicoIcmsSt.CodigoDoFornecedorDoItem: String;
begin
  Result := FCodigoDoFornecedorDoItem;
end;

function TParametrosServicoIcmsSt.CodigoDoFornecedorDoItem(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDoFornecedorDoItem := AValue;
end;

function TParametrosServicoIcmsSt.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

function TParametrosServicoIcmsSt.CodigoDoProduto: String;
begin
  Result := FCodigoDoProduto;
end;

function TParametrosServicoIcmsSt.CodigoDoProduto(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FCodigoDoProduto := AValue;
end;

function TParametrosServicoIcmsSt.ConsideraDescontoNaBaseDeCalculoOrgaoPublico: Boolean;
begin
  Result := FConsideraDescontoNaBaseDeCalculoOrgaoPublico;
end;

function TParametrosServicoIcmsSt.ConsideraDescontoNaBaseDeCalculoOrgaoPublico(
  const AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FConsideraDescontoNaBaseDeCalculoOrgaoPublico := AValue;
end;

function TParametrosServicoIcmsSt.DescontoEspecial(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FDescontoEspecial := AValue;
end;

function TParametrosServicoIcmsSt.DesmembrarMeiaNotaComNotaNormal(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FDesmembrarMeiaNotaComNotaNormal := AValue;
end;

function TParametrosServicoIcmsSt.DescontoEspecialBaixaDeEntregaFutura: Double;
begin
  Result := FDescontoEspecialBaixaDeEntregaFutura;
end;

function TParametrosServicoIcmsSt.DescontoEspecialBaixaDeEntregaFutura(
  const AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FDescontoEspecialBaixaDeEntregaFutura := AValue;
end;

function TParametrosServicoIcmsSt.DesmembrarMeiaNotaComNotaNormal: Boolean;
begin
  Result := FDesmembrarMeiaNotaComNotaNormal;
end;

function TParametrosServicoIcmsSt.DesmembrarNotaProdutosServicos(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FDesmembrarNotaProdutosServicos := AValue;
end;

function TParametrosServicoIcmsSt.DesmembrarNotaProdutosServicos: Boolean;
begin
  Result := FDesmembrarNotaProdutosServicos;
end;

function TParametrosServicoIcmsSt.DescontoEspecial: Double;
begin
  Result := FDescontoEspecial;
end;

function TParametrosServicoIcmsSt.DespesaAcessoriaDoItem: Double;
begin
  Result := FDespesaAcessoriaDoItem;
end;

function TParametrosServicoIcmsSt.DespesaAcessoriaDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FDespesaAcessoriaDoItem := AValue;
end;

function TParametrosServicoIcmsSt.EspecieDocumento: String;
begin
  Result := FEspecieDocumento;
end;

function TParametrosServicoIcmsSt.EntregaFuturaDoItem: Boolean;
begin
  Result := FEntregaFuturaDoItem;
end;

function TParametrosServicoIcmsSt.EhDevolucaoEspelho: Boolean;
begin
  Result := FEhDevolucaoEspelho;
end;

function TParametrosServicoIcmsSt.EhDevolucaoEspelho(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FEhDevolucaoEspelho := AValue;
end;

function TParametrosServicoIcmsSt.EntregaFuturaDoItem(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FEntregaFuturaDoItem := AValue;
end;

function TParametrosServicoIcmsSt.EspecieDeDevolucao(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FEspecieDeDevolucao := AValue;
end;

function TParametrosServicoIcmsSt.EspecieDeDevolucao: String;
begin
  Result := FEspecieDeDevolucao;
end;

function TParametrosServicoIcmsSt.EspecieDocumento(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FEspecieDocumento := AValue;
end;

function TParametrosServicoIcmsSt.GerandoCasosTestes: Boolean;
begin
  Result := FGerandoCasosTestes;
end;

function TParametrosServicoIcmsSt.GerandoCasosTestes(
  AValue: boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FGerandoCasosTestes := AValue;
end;

function TParametrosServicoIcmsSt.IdePro(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FIdePro := AValue;
end;

function TParametrosServicoIcmsSt.IdePro: String;
begin
  Result := FIdePro;
end;

function TParametrosServicoIcmsSt.MetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF;
begin
  Result := FMetodoArredondamentoICMSECF;
end;

function TParametrosServicoIcmsSt.MetodoArredondamentoICMSECF(
  AValue: TMetodoArredondamentoICMSECF): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FMetodoArredondamentoICMSECF := AValue;
end;

class function TParametrosServicoIcmsSt.New: IParametrosServicoIcmsSt;
begin
  Result := Self.Create;
end;

function TParametrosServicoIcmsSt.NotaComplementoFornecedor(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FNotaComplementoFornecedor := AValue;
end;

function TParametrosServicoIcmsSt.NotaComplementoFornecedor: Boolean;
begin
  Result := FNotaComplementoFornecedor;
end;

function TParametrosServicoIcmsSt.NotaEspecialFornecedor(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FNotaEspecialFornecedor := AValue;
end;

function TParametrosServicoIcmsSt.NumeroDoOrcamento(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FNumeroDoOrcamento := AValue;
end;

function TParametrosServicoIcmsSt.NumeroDoOrcamento: String;
begin
  Result := FNumeroDoOrcamento;
end;

function TParametrosServicoIcmsSt.OpcaoDeItemNfEspiritoSanto: TOpcItensNFespTinta;
begin
  Result := FOpcaoDeItemNfEspiritoSanto;
end;

function TParametrosServicoIcmsSt.OpcaoDeItemNfEspiritoSanto(
  AValue: TOpcItensNFespTinta): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FOpcaoDeItemNfEspiritoSanto := AValue;
end;

function TParametrosServicoIcmsSt.OpcaoDoDocumento(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FOpcaoDoDocumento := AValue;
end;

function TParametrosServicoIcmsSt.OrigemF11: Boolean;
begin
  Result := FOrigemF11;
end;

function TParametrosServicoIcmsSt.OrigemF11(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FOrigemF11 := AValue;
end;

function TParametrosServicoIcmsSt.PercentualDoFcpDoItem: Double;
begin
  Result := FPercentualDoFcpDoItem;
end;

function TParametrosServicoIcmsSt.ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := FParametrosClienteConsumidor;
end;

function TParametrosServicoIcmsSt.ParametrosClienteConsumidor(
  AValue: IParametrosFaturamentoImpostosClienteConsumidor): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FParametrosClienteConsumidor := AValue;
end;

function TParametrosServicoIcmsSt.PercentualDoFcpDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FPercentualDoFcpDoItem := AValue;
end;

function TParametrosServicoIcmsSt.PrecoDeCompraDaTinta(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FPrecoDeCompraDaTinta := AValue;
end;

function TParametrosServicoIcmsSt.PrecoDeCompraDaTinta: Double;
begin
  Result := FPrecoDeCompraDaTinta;
end;

function TParametrosServicoIcmsSt.PrecoDeCustoDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FPrecoDeCustoDoItem := AValue;
end;

function TParametrosServicoIcmsSt.PrecoDeCustoDoItemSemImpostos(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FPrecoDeCustoDoItemSemImpostos := AValue;
end;

function TParametrosServicoIcmsSt.PrecoDeCustoDoItemSemImpostos: Double;
begin
  Result := FPrecoDeCustoDoItemSemImpostos;
end;

function TParametrosServicoIcmsSt.PrecoDeCustoDoItem: Double;
begin
  Result := FPrecoDeCustoDoItem;
end;

function TParametrosServicoIcmsSt.PrecoDeUltimaCompraDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FPrecoDeUltimaCompraDoItem := AValue;
end;

function TParametrosServicoIcmsSt.PrecoDeUltimaCompraDoItem: Double;
begin
  Result := FPrecoDeUltimaCompraDoItem;
end;

function TParametrosServicoIcmsSt.PrecoEImpostosDeUltimaCompraDoItem: Double;
begin
  Result := FPrecoEImpostosDeUltimaCompraDoItem;
end;

function TParametrosServicoIcmsSt.PrecoEImpostosDeUltimaCompraDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FPrecoEImpostosDeUltimaCompraDoItem := AValue;
end;

function TParametrosServicoIcmsSt.QuantidadeDoItem: Double;
begin
  Result := FQuantidadeDoItem;
end;

function TParametrosServicoIcmsSt.QuantidadeDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FQuantidadeDoItem := AValue;
end;

function TParametrosServicoIcmsSt.RegimeEspecialPorEmpresa: Boolean;
begin
  Result := FRegimeEspecialPorEmpresa;
end;

function TParametrosServicoIcmsSt.RegimeEspecialPorEmpresa(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FRegimeEspecialPorEmpresa := AValue;
end;

function TParametrosServicoIcmsSt.OpcaoDoDocumento: String;
begin
  Result := FOpcaoDoDocumento;
end;

function TParametrosServicoIcmsSt.NotaEspecialFornecedor: Boolean;
begin
  Result := FNotaEspecialFornecedor;
end;

function TParametrosServicoIcmsSt.SequencialEnderecoEntrega(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FSequencialEnderecoEntrega := AValue;
end;

function TParametrosServicoIcmsSt.SequencialEnderecoEntrega: String;
begin
  Result := FSequencialEnderecoEntrega;
end;

function TParametrosServicoIcmsSt.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

function TParametrosServicoIcmsSt.TaxaBombeamentoPedidoOrcamento: Boolean;
begin
  Result := FTaxaBombeamentoPedidoOrcamento;
end;

function TParametrosServicoIcmsSt.TaxaBombeamentoPedidoOrcamento(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FTaxaBombeamentoPedidoOrcamento := AValue;
end;

function TParametrosServicoIcmsSt.TipoOperacaoPedidoVenda: String;
begin
  Result := FTipoOperacaoPedidoVenda;
end;

function TParametrosServicoIcmsSt.TipoDeBaixaEntregaFutura: String;
begin
  Result := FTipoDeBaixaEntregaFutura;
end;

function TParametrosServicoIcmsSt.TipoDeBaixaEntregaFutura(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FTipoDeBaixaEntregaFutura := AValue;
end;

function TParametrosServicoIcmsSt.TipoDePedidoFaturamento: String;
begin
  Result := FTipoDePedidoFaturamento;
end;

function TParametrosServicoIcmsSt.TipoDePedidoFaturamento(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FTipoDePedidoFaturamento := AValue;
end;

function TParametrosServicoIcmsSt.TipoOperacaoPedidoVenda(
  AValue: String): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FTipoOperacaoPedidoVenda := AValue;
end;

function TParametrosServicoIcmsSt.TotalGeralDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosServicoIcmsSt.TributaClienteZonaFranca: Boolean;
begin
  Result := FTributaZonaFrancaUsoConsumo;
end;

function TParametrosServicoIcmsSt.TributaClienteZonaFranca(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FTributaZonaFrancaUsoConsumo := AValue;
end;

function TParametrosServicoIcmsSt.UtilizaSat: Boolean;
begin
  Result := FUtilizaSat;
end;

function TParametrosServicoIcmsSt.UtilizaSat(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FUtilizaSat := AValue;
end;

function TParametrosServicoIcmsSt.ValorFreteDoItem: Double;
begin
  Result := FValorFreteDoItem;
end;

function TParametrosServicoIcmsSt.ValorDoFcpDoItem: Double;
begin
  Result := FValorDoFcpDoItem;
end;

function TParametrosServicoIcmsSt.ValorDoFcpDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FValorDoFcpDoItem := AValue;
end;

function TParametrosServicoIcmsSt.ValorFreteDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FValorFreteDoItem := AValue;
end;

function TParametrosServicoIcmsSt.ValorUnitarioDoItem: Double;
begin
  Result := FValorUnitarioDoItem;
end;

function TParametrosServicoIcmsSt.ValorUnitarioDoItem(
  AValue: Double): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FValorUnitarioDoItem := AValue;
end;

function TParametrosServicoIcmsSt.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

function TParametrosServicoIcmsSt.VendaPresencial(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

function TParametrosServicoIcmsSt.MeiaNotaFatorExpedicao(
  AValue: Boolean): IParametrosServicoIcmsSt;
begin
  Result := Self;
  FMeiaNotaFatorExpedicao := AValue;
end;

function TParametrosServicoIcmsSt.MeiaNotaFatorExpedicao: Boolean;
begin
  Result := FMeiaNotaFatorExpedicao;
end;

function TParametrosServicoIcmsSt.MetodoArredondamentoICMSECF(
  AValue: Double): Double;
begin
  Result := FMetodoArredondamentoICMSECF(AValue);
end;

{ TResultadoServicosClasseIcmsSt }

function TResultadoServicosClasseIcmsSt.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TResultadoServicosClasseIcmsSt.AtendeRegrasAtoDeclaratorioDF: Boolean;
begin
  Result := FAtendeRegrasAtoDeclaratorioDF;
end;

function TResultadoServicosClasseIcmsSt.AtendeRegrasAtoDeclaratorioDF(
  AValue: Boolean): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FAtendeRegrasAtoDeclaratorioDF := AValue;
end;

function TResultadoServicosClasseIcmsSt.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;
end;

class function TResultadoServicosClasseIcmsSt.New: IResultadoServicosClasseIcmsSt;
begin
  Result := Self.Create;
end;

function TResultadoServicosClasseIcmsSt.ParametrosCalculoIcms(
  AValue: IParametrosCalculoIcms): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FParametrosCalculoIcms := AValue;
end;

function TResultadoServicosClasseIcmsSt.ParametrosCalculoIcmsOrgaoPublico(
  AValue: IParametrosCalculoIcmsOrgaoPublico): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FParametrosCalculoIcmsOrgaoPublico := AValue;
end;

function TResultadoServicosClasseIcmsSt.ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico;
begin
  Result := FParametrosCalculoIcmsOrgaoPublico;
end;

function TResultadoServicosClasseIcmsSt.ParametrosCalculoSt: IParametrosCalculoST;
begin
  Result := FParametrosCalculoSt;
end;

function TResultadoServicosClasseIcmsSt.ParametrosCalculoSt(
  AValue: IParametrosCalculoST): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FParametrosCalculoSt := AValue;
end;

function TResultadoServicosClasseIcmsSt.ParametrosCalculoStCustoAquisicao(
  AValue: IParametrosCalculoSTCustoAquisicao): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FParametrosCalculoStCustoAquisicao := AValue;
end;

function TResultadoServicosClasseIcmsSt.ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao;
begin
  Result := FParametrosCalculoStCustoAquisicao;
end;

function TResultadoServicosClasseIcmsSt.ParametrosCalculoIcms: IParametrosCalculoIcms;
begin
  Result := FParametrosCalculoIcms;
end;

function TResultadoServicosClasseIcmsSt.ResultadoCalculoIcms(
  AValue: IResultadoCalculoIcms): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FResultadoCalculoIcms := AValue;
end;

function TResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico(
  AValue: IResultadoCalculoIcmsOrgaoPublico): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FResultadoCalculoIcmsOrgaoPublico := AValue;
end;

function TResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := FResultadoCalculoIcmsOrgaoPublico;
end;

function TResultadoServicosClasseIcmsSt.ResultadoCalculoSt: IResultadoCalculoST;
begin
  Result := FResultadoCalculoSt;
end;

function TResultadoServicosClasseIcmsSt.ResultadoCalculoSt(
  AValue: IResultadoCalculoST): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FResultadoCalculoSt := AValue;
end;

function TResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao(
  AValue: IResultadoCalculoSTCustoAquisicao): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FResultadoCalculoStCustoAquisicao := AValue;
end;

function TResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
begin
  Result := FResultadoCalculoStCustoAquisicao;
end;

function TResultadoServicosClasseIcmsSt.ResultadoRegrasTributacaoDepoisDoCalculo: IResultadoRegrasTributacaoDepoisDoCalculo;
begin
  Result := FResultadoRegrasTributacaoDepoisDoCalculo;
end;

function TResultadoServicosClasseIcmsSt.ResultadoRegrasTributacaoDepoisDoCalculo(
  AValue: IResultadoRegrasTributacaoDepoisDoCalculo): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FResultadoRegrasTributacaoDepoisDoCalculo := AValue;
end;

function TResultadoServicosClasseIcmsSt.STAtribuidaPorRegimeEspecial: Boolean;
begin
  Result := FSTAtribuidaPorRegimeEspecial;
end;

function TResultadoServicosClasseIcmsSt.STAtribuidaPorRegimeEspecial(
  AValue: Boolean): IResultadoServicosClasseIcmsSt;
begin
  Result := Self;
  FSTAtribuidaPorRegimeEspecial := AValue;
end;

function TResultadoServicosClasseIcmsSt.ResultadoCalculoIcms: IResultadoCalculoIcms;
begin
  Result := FResultadoCalculoIcms;
end;

{ TResultadoCalculoIcmsSt }

class function TResultadoCalculoIcmsSt.New: IResultadoCalculoIcmsSt;
begin
  Result := Self.Create;
end;

function TResultadoCalculoIcmsSt.ResultadoCalculoIcms(
  AValue: IResultadoCalculoIcms): IResultadoCalculoIcmsSt;
begin
  Result := Self;
  FResultadoCalculoIcms := AValue;
end;

function TResultadoCalculoIcmsSt.ResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico;
begin
  Result := FResultadoCalculoIcmsOrgaoPublico;
end;

function TResultadoCalculoIcmsSt.ResultadoCalculoIcmsOrgaoPublico(
  AValue: IResultadoCalculoIcmsOrgaoPublico): IResultadoCalculoIcmsSt;
begin
  Result := Self;
  FResultadoCalculoIcmsOrgaoPublico := AValue;
end;

function TResultadoCalculoIcmsSt.ResultadoCalculoIcms: IResultadoCalculoIcms;
begin
  Result := FResultadoCalculoIcms;
end;

function TResultadoCalculoIcmsSt.ResultadoCalculoSt: IResultadoCalculoST;
begin
  Result := FResultadoCalculoSt;
end;

function TResultadoCalculoIcmsSt.ResultadoCalculoSt(
  AValue: IResultadoCalculoST): IResultadoCalculoIcmsSt;
begin
  Result := Self;
  FResultadoCalculoSt := AValue;
end;

function TResultadoCalculoIcmsSt.ResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
begin
  Result := FResultadoCalculoStCustoAquisicao;
end;

function TResultadoCalculoIcmsSt.ResultadoCalculoStCustoAquisicao(
  AValue: IResultadoCalculoSTCustoAquisicao): IResultadoCalculoIcmsSt;
begin
  Result := Self;
  FResultadoCalculoStCustoAquisicao := AValue;
end;

end.
