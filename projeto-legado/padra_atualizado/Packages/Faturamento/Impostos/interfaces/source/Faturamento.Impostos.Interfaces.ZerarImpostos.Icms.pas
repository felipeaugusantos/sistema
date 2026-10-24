unit Faturamento.Impostos.Interfaces.ZerarImpostos.Icms;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos.Types,
  Shared.Functions.Types;

type
  IParametrosRegraZerarImpostosIcms = interface
    ['{AA75DF22-D391-4B00-A577-1D360C7DD23A}']

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcms; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcms; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcms; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostosIcms; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function TipoZerarIcms: TTipoZerarIcms; overload;
    function TipoZerarIcms(AValue: TTipoZerarIcms): IParametrosRegraZerarImpostosIcms; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function ConfiguradoParaTrocarParaX41noParana: Boolean; overload;
    function ConfiguradoParaTrocarParaX41noParana(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function TributaClienteZonaFranca: Boolean; overload;
    function TributaClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

  end;


  IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico = interface
    ['{4DA03B1E-D5B0-4B65-8829-3D8886EF577B}']

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;
  end;

  IParametrosRegraZerarImpostosIcmsGeral = interface
    ['{DB76594F-EE1A-4C3E-A9DD-507D770F4E7D}']

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ConfiguradoParaTrocarParaX41noParana: Boolean; overload;
    function ConfiguradoParaTrocarParaX41noParana(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

  end;

  IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero = interface
    ['{78646E28-E2CA-466D-A977-26EB0F07E395}']

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero; overload;
  end;


  IResultadoRegraZerarImpostosIcms = interface
    ['{AA75DF22-D391-4B00-A577-1D360C7DD23A}']

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IResultadoRegraZerarImpostosIcms; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IResultadoRegraZerarImpostosIcms; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IResultadoRegraZerarImpostosIcms; overload;
  end;

  IRegraImpostosZerarImpostosIcms = interface
    ['{9A665D53-21F7-4F40-A4AD-93D14FAE49AE}']

    function ZerarIcms(const AParametros: IParametrosRegraZerarImpostosIcms): IResultadoRegraZerarImpostosIcms;
    function ZerarValorDoIcms(const AParametros: IParametrosRegraZerarImpostosIcms): Boolean;
  end;

implementation

end.
