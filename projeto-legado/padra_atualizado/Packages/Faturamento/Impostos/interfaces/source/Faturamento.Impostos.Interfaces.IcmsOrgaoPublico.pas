unit Faturamento.Impostos.Interfaces.IcmsOrgaoPublico;

interface

type
  IParametrosCalculoIcmsOrgaoPublico = interface
    ['{B7D8327B-E3BE-4880-A472-12820889BB37}']

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function SubstituicaoTributariaDoItem: Boolean; overload;
    function SubstituicaoTributariaDoItem(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ValorTotalDoItem: Double; overload;
    function ValorTotalDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoPis: Double; overload;
    function AliquotaDoPis(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoCofins: Double; overload;
    function AliquotaDoCofins(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosCalculoIcmsOrgaoPublico; overload;

    function IsencaoDeIcmsVendasZonaFrancaProdutosNacionais: Boolean; overload;
    function IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function PercentualDaBaseDeCalculoDoItem: Double; overload;
    function PercentualDaBaseDeCalculoDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ValorFreteDespesasAcessoriasItem: Double; overload;
    function ValorFreteDespesasAcessoriasItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function DescontoEspecialDoItem: Double; overload;
    function DescontoEspecialDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function AplicarDescontoPisCofinsOrgaoPublico: Boolean; overload;
    function AplicarDescontoPisCofinsOrgaoPublico(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ValorDoIpiDoItem: Double; overload;
    function ValorDoIpiDoItem(AValue: Double): IParametrosCalculoIcmsOrgaoPublico; overload;

    function EntraIPINaBaseIcms: Boolean; overload;
    function EntraIPINaBaseIcms(AValue: Boolean): IParametrosCalculoIcmsOrgaoPublico; overload;

    function ConsideraDescontoNaBaseDeCalculo : Boolean; overload;
    function ConsideraDescontoNaBaseDeCalculo(AValue : Boolean) : IParametrosCalculoIcmsOrgaoPublico; overload;

    function OrgaoPublicoForaDoEstado : Boolean; overload;
    function OrgaoPublicoForaDoEstado(AValue : Boolean) : IParametrosCalculoIcmsOrgaoPublico; overload;
  end;

  IResultadoCalculoIcmsOrgaoPublico = interface
    ['{46FE1F58-63D7-4531-861B-597E19CE033C}']

    function ValorDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function BaseDeIcmsDeOrgaoPublicoDoItem: Double; overload;
    function BaseDeIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao: Double; overload;
    function TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function ValorSeparadoDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function ValorSeparadoDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function ValorSeparadoDoPisDeOrgaoPublicoDoItem: Double; overload;
    function ValorSeparadoDoPisDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function ValorSeparadoDoCofinsDeOrgaoPublicoDoItem: Double; overload;
    function ValorSeparadoDoCofinsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoIcmsDeOrgaoPublicoDoItem: Double; overload;
    function AliquotaDoIcmsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoPisDeOrgaoPublicoDoItem: Double; overload;
    function AliquotaDoPisDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;

    function AliquotaDoCofinsDeOrgaoPublicoDoItem: Double; overload;
    function AliquotaDoCofinsDeOrgaoPublicoDoItem(AValue: Double): IResultadoCalculoIcmsOrgaoPublico; overload;
  end;

  ICalculoImpostosIcmsOrgaoPublico = interface
    ['{9C2DEB77-5011-437B-A30B-9E418461825E}']

    function CalcularValorIcmsOrgaoPublico(AParametros: IParametrosCalculoIcmsOrgaoPublico): IResultadoCalculoIcmsOrgaoPublico; overload;
  end;

implementation

end.
