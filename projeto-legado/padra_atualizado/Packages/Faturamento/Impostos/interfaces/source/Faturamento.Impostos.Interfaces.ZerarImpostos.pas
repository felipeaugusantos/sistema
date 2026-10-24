unit Faturamento.Impostos.Interfaces.ZerarImpostos;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos.Icms,
  Faturamento.Impostos.Interfaces.ZerarImpostos.Types, Shared.Functions.Types;

type
  IParametrosRegraZerarImpostos = interface
    ['{0954DA49-F10F-45D2-969B-9049ED6F6A55}']

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostos; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostos; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostos; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostos; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosRegraZerarImpostos; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function ClassificacaoFiscal: String; overload;
    function ClassificacaoFiscal(AValue: String): IParametrosRegraZerarImpostos; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostos; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosRegraZerarImpostos; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostos; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostos; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosRegraZerarImpostos; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function TipoZerarIcms: TTipoZerarIcms; overload;
    function TipoZerarIcms(AValue: TTipoZerarIcms): IParametrosRegraZerarImpostos; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosRegraZerarImpostos; overload;

    function ConfiguradoParaTrocarParaX41noParana: Boolean; overload;
    function ConfiguradoParaTrocarParaX41noParana(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function TributaClienteZonaFranca: Boolean; overload;
    function TributaClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

  end;

  IRegraImpostosZerarImpostos = interface
    ['{CFCA8947-362E-4620-8749-1E82BA7A5DED}']

    function SetarParametros(const AParametros: IParametrosRegraZerarImpostos): IRegraImpostosZerarImpostos; overload;
    function ZerarIcms: IRegraImpostosZerarImpostos; overload;
    function ZerarValorDoIcms: Boolean; overload;
    function ResultadoIcms: IResultadoRegraZerarImpostosIcms; overload;
  end;

implementation

end.
