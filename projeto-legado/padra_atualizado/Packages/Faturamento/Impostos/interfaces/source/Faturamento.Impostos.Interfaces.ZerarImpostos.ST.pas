unit Faturamento.Impostos.Interfaces.ZerarImpostos.ST;

interface

uses Shared.Functions.Types;

type
  IParametrosRegraZerarImpostosST = interface
    ['{CC5E052E-4474-48CC-BC1B-8DA128B11624}']

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostosST; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function ClienteTARE: String; overload;
    function ClienteTARE(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function ClienteDEFIT: String; overload;
    function ClienteDEFIT(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function DesmembrarMeiaNotaComNotaNormal: Boolean; overload;
    function DesmembrarMeiaNotaComNotaNormal(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function MeiaNotaFatorExpedicao : Boolean; overload;
    function MeiaNotaFatorExpedicao(AValue : Boolean): IParametrosRegraZerarImpostosST; overload;

    function TipoDePedidoFaturamento: String; overload;
    function TipoDePedidoFaturamento(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function DesmembrarNotaProdutosServicos : Boolean; overload;
    function DesmembrarNotaProdutosServicos(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function EhItemConcreto: Boolean; overload;
    function EhItemConcreto(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ConfiguradoParaTrocarParaX41noParana: Boolean; overload;
    function ConfiguradoParaTrocarParaX41noParana(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function TipoDeBaixaEntregaFutura: String; overload;
    function TipoDeBaixaEntregaFutura(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function TemMIFFEntreOsDevolvidos: Boolean; overload;
    function TemMIFFEntreOsDevolvidos(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function TributaClienteZonaFranca: Boolean; overload;
    function TributaClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

  end;

  IRegraImpostosZerarImpostosST = interface
    ['{187D9E87-2319-48D0-8B54-E4C73E4296EF}']

    function ZerarValorDoST(const AParametros: IParametrosRegraZerarImpostosST): Boolean;
  end;

implementation

end.
