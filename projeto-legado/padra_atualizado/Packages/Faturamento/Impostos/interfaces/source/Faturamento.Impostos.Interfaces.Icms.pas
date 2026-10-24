unit Faturamento.Impostos.Interfaces.Icms;


interface

Uses
  Shared.Functions.Types;

type

  IParametrosCalculoIcms = interface
    ['{02120538-182C-45CC-A5CE-FBCFBB1AC80D}']

    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosCalculoIcms; overload;

    function SubstituicaoTributariaDoItem: Boolean; overload;
    function SubstituicaoTributariaDoItem(AValue: Boolean): IParametrosCalculoIcms; overload;

    function UtilizaImportacaoDireta: Boolean; overload;
    function UtilizaImportacaoDireta(AValue: Boolean): IParametrosCalculoIcms; overload;

    function ItemImportacaoDireta: Boolean; overload;
    function ItemImportacaoDireta(AValue: Boolean): IParametrosCalculoIcms; overload;

    function CalculaBeneficioReducaoBaseIcmsST: Boolean; overload;
    function CalculaBeneficioReducaoBaseIcmsST(AValue: Boolean): IParametrosCalculoIcms; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosCalculoIcms; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoIcms; overload;

    function EntraIPINaBaseIcms: Boolean; overload;
    function EntraIPINaBaseIcms(AValue: Boolean): IParametrosCalculoIcms; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosCalculoIcms; overload;

    function ValorDoIpiDoItem: Double; overload;
    function ValorDoIpiDoItem(AValue: Double): IParametrosCalculoIcms; overload;

    function PercentualDaBaseDeIcmsDoItem: Double; overload;
    function PercentualDaBaseDeIcmsDoItem(AValue: Double): IParametrosCalculoIcms; overload;

    function MetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF; overload;
    function MetodoArredondamentoICMSECF(AValue: TMetodoArredondamentoICMSECF): IParametrosCalculoIcms; overload;
    function MetodoArredondamentoICMSECF(AValue: Double): Double; overload;

    function UtilizarReducaoRICMPR: Boolean; overload;
    function UtilizarReducaoRICMPR(AValue: Boolean): IParametrosCalculoIcms; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosCalculoIcms; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosCalculoIcms; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosCalculoIcms; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoIcms; overload;

    function PercentualDeReducaoDaBaseDeIcms: Double; overload;
    function PercentualDeReducaoDaBaseDeIcms(AValue: Double): IParametrosCalculoIcms; overload;

    function TipoDaAbreviacaoFiscal : String; Overload;
    function TipoDaAbreviacaoFiscal(AValue : String) : IParametrosCalculoIcms; Overload;

  end;

  IResultadoCalculoIcms = interface
    ['{A936E4B6-1626-4457-BC5D-FE4B2BB1DA05}']

    function AliquotaDoIcms: Double; overload;
    function AliquotaDoIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function BaseDeCalculoDoIcms: Double; overload;
    function BaseDeCalculoDoIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function ValorCalculadoDoIcms: Double; overload;
    function ValorCalculadoDoIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function ValorDaDiferencaDeIcms: Double; overload;
    function ValorDaDiferencaDeIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function AliquotaDeIcmsAnterior: Double; overload;
    function AliquotaDeIcmsAnterior(AValue : Double): IResultadoCalculoIcms; overload;

    function BaseDeCalculoDoIcmsAnterior: Double; overload;
    function BaseDeCalculoDoIcmsAnterior(AValue : Double): IResultadoCalculoIcms; overload;

    function ValorDoIcmsAnterior: Double; overload;
    function ValorDoIcmsAnterior(AValue : Double): IResultadoCalculoIcms; overload;

    function PercentualDeReducaoDaBaseDeIcms: Double; overload;
    function PercentualDeReducaoDaBaseDeIcms(AValue : Double): IResultadoCalculoIcms; overload;

    function ReducaoRICMPR : String; Overload;
    function ReducaoRICMPR(AValue : String) : IResultadoCalculoIcms; Overload;

    function TipoDaAbreviacaoFiscal : String; Overload;
    function TipoDaAbreviacaoFiscal(AValue : String) : IResultadoCalculoIcms; Overload;

    function EntraIPINaBaseIcms : Boolean; Overload;
    function EntraIPINaBaseIcms(AValue : Boolean) : IResultadoCalculoIcms; Overload;

    function BaseDeCalculoDoIcmsDoItemBenST: Double; overload;
    function BaseDeCalculoDoIcmsDoItemBenST(AValue : Double): IResultadoCalculoIcms; overload;

  end;

  ICalculoImpostosIcms = interface
    ['{D5381D43-1038-4C5B-8E97-6BDB0488A6A6}']
    function CalcularValorIcms(AParametros: IParametrosCalculoIcms): IResultadoCalculoIcms; overload;
  end;

implementation

end.
