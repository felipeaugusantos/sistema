unit Faturamento.Impostos.Interfaces.ST;

interface

type
  IParametrosCalculoST = interface
    ['{B5433986-26D2-4690-B152-D6D6054D7A48}']

    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosCalculoST; overload;

    function SubstituicaoTributariaDoItem: Boolean; overload;
    function SubstituicaoTributariaDoItem(AValue: Boolean): IParametrosCalculoST; overload;

    function CalculaSubstituicaoTributariaSimples: Boolean; overload;
    function CalculaSubstituicaoTributariaSimples(AValue: Boolean): IParametrosCalculoST; overload;

    function CalcularSTSomenteParaNaoConsumidorFinal: Boolean; overload;
    function CalcularSTSomenteParaNaoConsumidorFinal(AValue: Boolean): IParametrosCalculoST; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoST; overload;

    function CalculaSTClienteConsumidorFinalNCOEspiritoSanto: Boolean; overload;
    function CalculaSTClienteConsumidorFinalNCOEspiritoSanto(AValue: Boolean): IParametrosCalculoST; overload;

    function UtilizaImportacaoDireta: Boolean; overload;
    function UtilizaImportacaoDireta(AValue: Boolean): IParametrosCalculoST; overload;

    function ItemImportacaoDireta: Boolean; overload;
    function ItemImportacaoDireta(AValue: Boolean): IParametrosCalculoST; overload;

    function CalculaBeneficioReducaoBaseIcmsST: Boolean; overload;
    function CalculaBeneficioReducaoBaseIcmsST(AValue: Boolean): IParametrosCalculoST; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosCalculoST; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoIcmsDoEstado: Double; overload;
    function ValorDoIcmsDoEstado(AValue: Double): IParametrosCalculoST; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoST; overload;

//    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
//    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoST; overload;
//
//    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
//    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoST; overload;

    function TotalGeralDoItemPreUlt: Double; overload;
    function TotalGeralDoItemPreUlt(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoIpiDoItem: Double; overload;
    function ValorDoIpiDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoIva: Double; overload;
    function ValorDoIva(AValue: Double): IParametrosCalculoST; overload;

    function UtilizarReducaoDeBaseDeCalculoDeSTNaVenda: Boolean; overload;
    function UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(AValue: Boolean): IParametrosCalculoST; overload;

    function PercentualDaBaseDeCalculoDaSTDoItem: Double; overload;
    function PercentualDaBaseDeCalculoDaSTDoItem(AValue: Double): IParametrosCalculoST; overload;

    function PercentualMinimoReducaoDeBaseDeCalculoDosImpostos: Double; overload;
    function PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(AValue: Double): IParametrosCalculoST; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoST; overload;

    function UtilizaAmpara: Boolean; overload; //ampara
    function UtilizaAmpara(AValue: Boolean): IParametrosCalculoST; overload;

    function EncontrouAbreviacaoDeIcms: Boolean; overload; //ampara
    function EncontrouAbreviacaoDeIcms(AValue: Boolean): IParametrosCalculoST; overload;

    function AmparaAliquotaFCP: Double; overload; //ampara
    function AmparaAliquotaFCP(AValue: Double): IParametrosCalculoST; overload;

    function TipoDeAbreviacaoFiscal: String; overload;
    function TipoDeAbreviacaoFiscal(AValue: String): IParametrosCalculoST; overload;

    function PercentualDoFCPDoItem: Double; overload;
    function PercentualDoFCPDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoFCPDoItem: Double; overload;
    function ValorDoFCPDoItem(AValue: Double): IParametrosCalculoST; overload;

    function CalculaSubstituicaoTributariaPorDentro: Boolean; overload;
    function CalculaSubstituicaoTributariaPorDentro(AValue: Boolean): IParametrosCalculoST; overload;

    function ContribuinteDeIpi: Boolean; overload;
    function ContribuinteDeIpi(AValue: Boolean): IParametrosCalculoST; overload;

    function ClienteIVAEspecialMT: Boolean; overload;
    function ClienteIVAEspecialMT(AValue: Boolean): IParametrosCalculoST; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosCalculoST; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosCalculoST; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosCalculoST; overload;

    function AliquotaOriginalDeIcmsDoItem: Double; overload;
    function AliquotaOriginalDeIcmsDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoIpiDeEntrada: Double; overload;
    function ValorDoIpiDeEntrada(AValue: Double): IParametrosCalculoST; overload;

    function ModeloBeneficioReducaoBaseIcmsST: Integer; overload;
    function ModeloBeneficioReducaoBaseIcmsST(AValue: Integer): IParametrosCalculoST; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosCalculoST; overload;

    function AliquotaCalculoDesoneracaoDeSubstituicaoTributaria: Double; overload;
    function AliquotaCalculoDesoneracaoDeSubstituicaoTributaria(AValue: Double): IParametrosCalculoST; overload;

    function CalculaDesoneracaoDeSubstituicaoTributaria: Boolean; overload;
    function CalculaDesoneracaoDeSubstituicaoTributaria(AValue: Boolean): IParametrosCalculoST; overload;

    function AliquotaReducaoDeSt: Double; overload;
    function AliquotaReducaoDeSt(AValue: Double): IParametrosCalculoST; overload;

    function AplicaCargaLiquidaCE: Boolean; overload;
    function AplicaCargaLiquidaCE(AValue: Boolean): IParametrosCalculoST; overload;
  end;

  IResultadoCalculoST = interface
    ['{34EB55A8-78C6-4551-8F3A-0ECFED393A9F}']

    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoCalculoST; overload;

    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoCalculoST; overload;

    function PercentualDaSubstituicaoDaBase : Double; overload;
    function PercentualDaSubstituicaoDaBase(AValue : Double) : IResultadoCalculoST; overload;

    function PercentualDoFCPDoItem: Double; overload;
    function PercentualDoFCPDoItem(AValue: Double): IResultadoCalculoST; overload;

    function ValorDoFCPDoItem: Double; overload;
    function ValorDoFCPDoItem(AValue: Double): IResultadoCalculoST; overload;

    function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoCalculoST; overload;

    function AliquotaDaSubstituicaoTributariaSimulada: Double; overload;
    function AliquotaDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoCalculoST; overload;

    function ValorDaSubstituicaoTributariaSimulada: Double; overload;
    function ValorDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoCalculoST; overload;

    function ValorDoIvaMatriz: Double; overload;
    function ValorDoIvaMatriz(AValue: Double): IResultadoCalculoST; overload;

    function ValorDoIvaStMatriz: Double; overload;
    function ValorDoIvaStMatriz(AValue: Double): IResultadoCalculoST; overload;

    function ValorCalculadoSTConsignacao: Double; overload;
    function ValorCalculadoSTConsignacao(AValue: Double): IResultadoCalculoST; overload;

    function ValorDesoneradoDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDesoneradoDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoCalculoST; overload;
  end;

  ICalculoImpostosST = interface
    ['{AF10A25C-3BF3-4DE4-8387-369C01B88376}']

    function CalcularValorST(AParametros: IParametrosCalculoST): IResultadoCalculoST; overload;
  end;

implementation

end.
