unit Interfaces.Processar.Dados.Icms;

interface

uses Shared.Functions.Types, untParametrosResultadoIcms;

type
  IParametrosProcessarDadosIcms = interface
    ['{CC6EC84B-50EB-497F-BB05-6432A96B3808}']

    //Calculo icms
    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function SubstituicaoTributariaDoItem: Boolean; overload;
    function SubstituicaoTributariaDoItem(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function UtilizaImportacaoDireta: Boolean; overload;
    function UtilizaImportacaoDireta(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ItemImportacaoDireta: Boolean; overload;
    function ItemImportacaoDireta(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function CalculaBeneficioReducaoBaseIcmsST: Boolean; overload;
    function CalculaBeneficioReducaoBaseIcmsST(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function EntraIPINaBaseIcms: Boolean; overload;
    function EntraIPINaBaseIcms(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function ValorDoIpiDoItem: Double; overload;
    function ValorDoIpiDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function PercentualDaBaseDeIcmsDoItem: Double; overload;
    function PercentualDaBaseDeIcmsDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function UtilizarReducaoRICMPR: Boolean; overload;
    function UtilizarReducaoRICMPR(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    //Zerar impostos
    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosProcessarDadosIcms; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosProcessarDadosIcms; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ClassificacaoFiscal: String; overload;
    function ClassificacaoFiscal(AValue: String): IParametrosProcessarDadosIcms; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosProcessarDadosIcms; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosProcessarDadosIcms; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosProcessarDadosIcms; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosProcessarDadosIcms; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosProcessarDadosIcms; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ParametrosResultadoIcms: IParametrosResultadoIcms; overload;
    function ParametrosResultadoIcms(AValue: IParametrosResultadoIcms): IParametrosProcessarDadosIcms; overload;
  end;

  IResultadoProcessarDadosIcms = interface
    ['{B9CECBFC-6F43-4490-BC63-B696BB98DDB3}']

    function AliquotaDoIcms: Double; overload;
    function AliquotaDoIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;

    function BaseDeCalculoDoIcms: Double; overload;
    function BaseDeCalculoDoIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;

    function ValorCalculadoDoIcms: Double; overload;
    function ValorCalculadoDoIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;

    function ValorDaDiferencaDeIcms: Double; overload;
    function ValorDaDiferencaDeIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;
  end;

  IProcessarDadosIcms = interface
    ['{B7AEB235-C6D5-4026-AB6D-50A7419D53A0}']

    function ZerarIcms: IProcessarDadosIcms;
    function CalcularIcms: IResultadoProcessarDadosIcms;
  end;


implementation

end.
