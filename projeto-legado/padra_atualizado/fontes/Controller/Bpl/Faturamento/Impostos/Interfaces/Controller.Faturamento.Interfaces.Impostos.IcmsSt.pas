unit Controller.Faturamento.Interfaces.Impostos.IcmsSt;

interface

uses Faturamento.Impostos.Interfaces.IcmsSt;

type
  IResultadoImpostosFatControllerIcmsSt = interface;

  IParametrosCalculoValorIcmsSt = interface
    ['{F24ABF48-F889-4776-858B-0432FD534F36}']
    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosCalculoValorIcmsSt; overload;

    function CodigoDoProduto: String; overload;
    function CodigoDoProduto(AValue: String): IParametrosCalculoValorIcmsSt; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IParametrosCalculoValorIcmsSt; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoValorIcmsSt; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoValorIcmsSt; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue: Boolean): IParametrosCalculoValorIcmsSt; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue: Boolean): IParametrosCalculoValorIcmsSt; overload;
  end;

  IImpostosFatControllerIcmsSt = interface
    ['{44AD97D8-E25E-4E1E-AE3B-9A1A81786C05}']

    function CalcularValorIcmsSt: IResultadoCalculoIcmsSt; Overload;

    function CalcularValorIcmsSt(const AParametrosCalculoValorIcmsSt: IParametrosCalculoValorIcmsSt): IResultadoCalculoIcmsSt; Overload;

    function CalcularValorIcmsStFinal: IResultadoImpostosFatControllerIcmsSt;

    procedure ZerarValorIcms;
    procedure ZerarDadosIcms(const AZerarPerBas: boolean);
    procedure ZerarDadosSt;
    procedure ZerarDadosDoOrgaoPublicoDeTodosOsItens;

    function ItemReducaoRICMPR(const ARICMPR: String) : String;
  end;

  IResultadoImpostosFatControllerIcmsSt = interface
    ['{2E3C7700-02F4-4BFA-BEF3-1219ED78C4BD}']

    function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function AliquotaDaSubstituicaoTributariaSimulada: Double; overload;
    function AliquotaDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorDaSubstituicaoTributariaSimulada: Double; overload;
    function ValorDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function BaseDeIcmsDeOrgaoPublicoDoItem: Double; overload;
    function BaseDeIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function BaseDaSTCustoAquisicao: Double; overload;
    function BaseDaSTCustoAquisicao(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorDaSTCustoAquisicao: Double; overload;
    function ValorDaSTCustoAquisicao(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function FatorPositivo: Double; overload;
    function FatorPositivo(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function FatorNegativo: Double; overload;
    function FatorNegativo(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function EntraIPInaBaseIcms: Boolean; overload;
    function EntraIPInaBaseIcms(AValue: Boolean): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorSeparadoDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorSeparadoDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorSeparadoDoPisDeOrgaoPublicoDoItem: Double; overload;
    function ValorSeparadoDoPisDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function ValorSeparadoDoCofinsDeOrgaoPublicoDoItem: Double; overload;
    function ValorSeparadoDoCofinsDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function AliquotaDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function AliquotaDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function AliquotaDoPisDeOrgaoPublicoDoItem: Double; overload;
    function AliquotaDoPisDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;

    function AliquotaDoCofinsDeOrgaoPublicoDoItem: Double; overload;
    function AliquotaDoCofinsDeOrgaoPublicoDoItem(AValue: Double): IResultadoImpostosFatControllerIcmsSt; overload;
  end;

implementation

end.
