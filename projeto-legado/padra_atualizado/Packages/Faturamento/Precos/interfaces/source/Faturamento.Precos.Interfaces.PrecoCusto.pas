unit Faturamento.Precos.Interfaces.PrecoCusto;

interface

Uses
  Shared.Functions.Types;

type
  IParametrosServicoPrecoCusto = interface
    ['{F8437793-0AEB-44F7-999B-4014DBB09CD4}']

    function PrecoDeCompra: Double; overload;
    function PrecoDeCompra(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto01: Double; overload;
    function Desconto01(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto02: Double; overload;
    function Desconto02(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto03: Double; overload;
    function Desconto03(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto04: Double; overload;
    function Desconto04(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto05: Double; overload;
    function Desconto05(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto06: Double; overload;
    function Desconto06(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto07: Double; overload;
    function Desconto07(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function IcmsDeEntrada: Double; overload;
    function IcmsDeEntrada(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function ImpostoFederal: Double; overload;
    function ImpostoFederal(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function IpiDeEntrada: Double; overload;
    function IpiDeEntrada(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function PercentualFreteDeEntrada: Double; overload;
    function PercentualFreteDeEntrada(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function ValorDoFrete: Double; overload;
    function ValorDoFrete(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function AcrescimoFinal: Double; overload;
    function AcrescimoFinal(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function SubstituicaoTributaria: Double; overload;
    function SubstituicaoTributaria(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function DescontosAdicionais: Double; overload;
    function DescontosAdicionais(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function TipoMoeda : TTipoMoeda; overload;
    function TipoMoeda(AValue: TTipoMoeda): IParametrosServicoPrecoCusto; overload;

    function Predol : Boolean; overload;
    function Predol(AValue: Boolean): IParametrosServicoPrecoCusto; overload;

    function TaxaDeControleDeIncentivosFiscaisSuframa: Double; overload;
    function TaxaDeControleDeIncentivosFiscaisSuframa(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function TaxaDeServicoSuframa: Double; overload;
    function TaxaDeServicoSuframa(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function DescontoPISCOFINS: Double; overload;
    function DescontoPISCOFINS(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function DescontoDeIcms: Double; overload;
    function DescontoDeIcms(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function FatorRegional: Double; overload;
    function FatorRegional(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function CalculandoTintaDeMaquina: Boolean; overload;
    function CalculandoTintaDeMaquina(AValue: Boolean): IParametrosServicoPrecoCusto; overload;
  end;

  IParametrosCalculoPrecoCusto = interface
    ['{CA03C395-6080-42C9-9E41-F6DA3D077823}']

    function PrecoDeCompra: Double; overload;
    function PrecoDeCompra(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto01: Double; overload;
    function Desconto01(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto02: Double; overload;
    function Desconto02(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto03: Double; overload;
    function Desconto03(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto04: Double; overload;
    function Desconto04(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto05: Double; overload;
    function Desconto05(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto06: Double; overload;
    function Desconto06(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto07: Double; overload;
    function Desconto07(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function IcmsDeEntrada: Double; overload;
    function IcmsDeEntrada(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function ImpostoFederal: Double; overload;
    function ImpostoFederal(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function IpiDeEntrada: Double; overload;
    function IpiDeEntrada(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function PercentualFreteDeEntrada: Double; overload;
    function PercentualFreteDeEntrada(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function ValorDoFrete: Double; overload;
    function ValorDoFrete(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function AcrescimoFinal: Double; overload;
    function AcrescimoFinal(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function SubstituicaoTributaria: Double; overload;
    function SubstituicaoTributaria(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function DescontosAdicionais: Double; overload;
    function DescontosAdicionais(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function FormulaParaCalculo: String; overload;
    function FormulaParaCalculo(AValue: String): IParametrosCalculoPrecoCusto; overload;

    function OperadorAdicaoDescontosAdicionais: Boolean; overload;
    function OperadorAdicaoDescontosAdicionais(AValue: Boolean): IParametrosCalculoPrecoCusto; overload;

    function QuantidadeCasasDecimais: Integer; overload;
    function QuantidadeCasasDecimais(AValue : Integer) :IParametrosCalculoPrecoCusto; overload;

    function TaxaDeControleDeIncentivosFiscaisSuframa: Double; overload;
    function TaxaDeControleDeIncentivosFiscaisSuframa(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function TaxaDeServicoSuframa: Double; overload;
    function TaxaDeServicoSuframa(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function DescontoPISCOFINS: Double; overload;
    function DescontoPISCOFINS(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function DescontoDeIcms: Double; overload;
    function DescontoDeIcms(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function FatorRegional: Double; overload;
    function FatorRegional(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function CalculandoTintaDeMaquina: Boolean; overload;
    function CalculandoTintaDeMaquina(AValue: Boolean): IParametrosCalculoPrecoCusto; overload;
  end;

  IParametrosServicoPrecoCustoMargemMarkup = interface
    ['{BDD379DD-2291-434F-B190-1FCBB20031A8}']

    function PrecoDeVenda: Double; overload;
    function PrecoDeVenda(AValue: Double): IParametrosServicoPrecoCustoMargemMarkup; overload;

    function Margem: Double; overload;
    function Margem(AValue: Double): IParametrosServicoPrecoCustoMargemMarkup; overload;

    function DecUni: Integer; overload;
    function DecUni(AValue: Integer): IParametrosServicoPrecoCustoMargemMarkup; overload;
  end;

  IParametrosCalculoPrecoCustoMargemMarkup = interface
    ['{BDD379DD-2291-434F-B190-1FCBB20031A8}']

    function PrecoDeVenda: Double; overload;
    function PrecoDeVenda(AValue: Double): IParametrosCalculoPrecoCustoMargemMarkup; overload;

    function Margem: Double; overload;
    function Margem(AValue: Double): IParametrosCalculoPrecoCustoMargemMarkup; overload;

    function MargemMarkup: String; overload;
    function MargemMarkup(AValue: String): IParametrosCalculoPrecoCustoMargemMarkup; overload;

    function DecUni: Integer; overload ;
    function DecUni(AValue: Integer): IParametrosCalculoPrecoCustoMargemMarkup; overload;
  end;

  IParametrosCalculoPrecoCustoRealVenda = interface
    ['{FE6FB3BE-D403-491F-B856-481D56372D8A}']

    function PrecoDeVenda: Double; overload;
    function PrecoDeVenda(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function PrecoDeCusto: Double; overload;
    function PrecoDeCusto(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function OutrosValores: Double; overload;
    function OutrosValores(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function IcmsDeSaida: Double; overload;
    function IcmsDeSaida(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function ImpostosFederais: Double; overload;
    function ImpostosFederais(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function DespesasOperacionais: Double; overload;
    function DespesasOperacionais(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function AliquotaDoDifal: Double; overload;
    function AliquotaDoDifal(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function AliquotaDoFcp: Double; overload;
    function AliquotaDoFcp(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function TaxaDeJuros: Double; overload;
    function TaxaDeJuros(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function ValorFrete: Double; overload;
    function ValorFrete(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;
  end;

  IParametrosCalculoCustoReal = interface
    ['{13381560-F303-45BD-B234-32F875A49FA5}']

    function PrecoDeCusto: Double; overload;
    function PrecoDeCusto(AValue: Double): IParametrosCalculoCustoReal; overload;

    function IcmsDeSaida: Double; overload;
    function IcmsDeSaida(AValue: Double): IParametrosCalculoCustoReal; overload;

    function ImpostosFederais: Double; overload;
    function ImpostosFederais(AValue: Double): IParametrosCalculoCustoReal; overload;

    function DespesasOperacionais: Double; overload;
    function DespesasOperacionais(AValue: Double): IParametrosCalculoCustoReal; overload;

    function OutrosValores: Double; overload;
    function OutrosValores(AValue: Double): IParametrosCalculoCustoReal; overload;
  end;

  IResultadoCalculoPrecoCusto = interface
    ['{AD6758BC-368B-4236-A95E-228A94BC1367}']

    function ValorCalculadoPrecoCusto: Double; overload;
    function ValorCalculadoPrecoCusto(AValue: Double): IResultadoCalculoPrecoCusto; overload;
  end;

  ICalculoPrecosPrecoCusto = interface
    ['{255E30DF-302C-4235-91E8-164C9E25365F}']

    function CalculaPrecoCusto(const AParametros: IParametrosCalculoPrecoCusto): IResultadoCalculoPrecoCusto; overload;
    function CalculaPrecoCusto(const AParametros: IParametrosCalculoPrecoCustoMargemMarkup): IResultadoCalculoPrecoCusto; overload;
    function CalculaPrecoCustoRealVenda(const AParametros: IParametrosCalculoPrecoCustoRealVenda): IResultadoCalculoPrecoCusto;
    function CalculaCustoReal(const AParametros: IParametrosCalculoCustoReal): IResultadoCalculoPrecoCusto;
  end;

  IResultadoServicosClassePrecoCusto = interface
    ['{D39072BC-78D8-4044-BF0A-1585B5310AF1}']

    function ResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto; overload;
    function ResultadoCalculoPrecoCusto(AValue: IResultadoCalculoPrecoCusto): IResultadoServicosClassePrecoCusto; overload;

    function ParametrosCalculoPrecoCusto: IParametrosCalculoPrecoCusto; overload;
    function ParametrosCalculoPrecoCusto(AValue: IParametrosCalculoPrecoCusto): IResultadoServicosClassePrecoCusto; overload;

    function ParametrosCalculoPrecoCustoMargemMarkup: IParametrosCalculoPrecoCustoMargemMarkup; overload;
    function ParametrosCalculoPrecoCustoMargemMarkup(AValue: IParametrosCalculoPrecoCustoMargemMarkup): IResultadoServicosClassePrecoCusto; overload;

    function ParametrosCalculoPrecoCustoRealVenda: IParametrosCalculoPrecoCustoRealVenda; overload;
    function ParametrosCalculoPrecoCustoRealVenda(AValue: IParametrosCalculoPrecoCustoRealVenda): IResultadoServicosClassePrecoCusto; overload;

    function ParametrosCalculoCustoReal: IParametrosCalculoCustoReal; overload;
    function ParametrosCalculoCustoReal(AValue: IParametrosCalculoCustoReal): IResultadoServicosClassePrecoCusto; overload;
  end;

implementation

end.
