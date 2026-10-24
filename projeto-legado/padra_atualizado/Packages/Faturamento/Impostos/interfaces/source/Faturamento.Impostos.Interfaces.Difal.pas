unit Faturamento.Impostos.Interfaces.Difal;

interface

uses Shared.Functions.Types;

type
  IParametrosCalculoDifal = interface
    ['{0E29DCD2-0E7A-46B9-8834-04E62212BD0B}']

    function ValorIpiDoItem :Double; overload;
    function ValorIpiDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function ValorFreteDoItem :Double; overload;
    function ValorFreteDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function AliquotaInterestadualCalc :Double; overload;
    function AliquotaInterestadualCalc(AValue: Double): IParametrosCalculoDifal; overload;

    function ValorIcmsBase:Double; overload;
    function ValorIcmsBase(AValue: Double): IParametrosCalculoDifal; overload;

    function TotalDoItem :Double; overload;
    function TotalDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function DescontoEspecialDoItem :Double; overload;
    function DescontoEspecialDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function DespesaAcessoriaDoItem :Double; overload;
    function DespesaAcessoriaDoItem(AValue: Double): IParametrosCalculoDifal; overload;

    function PercentualBaseOrigem :Double; overload;
    function PercentualBaseOrigem(AValue: Double): IParametrosCalculoDifal; overload;

    function PercentualBaseDestino :Double; overload;
    function PercentualBaseDestino(AValue: Double): IParametrosCalculoDifal; overload;

    function PercentualBaseDifalOrigem :Double; overload;
    function PercentualBaseDifalOrigem(AValue: Double): IParametrosCalculoDifal; overload;

    function PercentualBaseDifalDestino :Double; overload;
    function PercentualBaseDifalDestino(AValue: Double): IParametrosCalculoDifal; overload;

    function CalculaAliquotaInterestadual :Double; overload;
    function CalculaAliquotaInterestadual(AValue: Double): IParametrosCalculoDifal; overload;

    function CalculaAliquotaEfetivaOrigem :Double; overload;
    function CalculaAliquotaEfetivaOrigem(AValue: Double): IParametrosCalculoDifal; overload;

    function AliquotaInternaEstadoDestino :Double; overload;
    function AliquotaInternaEstadoDestino(AValue: Double): IParametrosCalculoDifal; overload;

    function ProdutoSt : Boolean; overload;
    function ProdutoSt(AValue: Boolean): IParametrosCalculoDifal; overload;

    function SimplesNacional : Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosCalculoDifal; overload;

    function AbreviacaoIcmsProduto : Boolean; overload;
    function AbreviacaoIcmsProduto(AValue: Boolean): IParametrosCalculoDifal; overload;

    function AbreviacaoIcmsProdutoUfEmpresa : Boolean; overload;
    function AbreviacaoIcmsProdutoUfEmpresa(AValue: Boolean): IParametrosCalculoDifal; overload;

    function HabilitarPercentualBase : Boolean; overload;
    function HabilitarPercentualBase(AValue: Boolean): IParametrosCalculoDifal; overload;

    function SituacaoReducaoBaseCalculo : Boolean; overload;
    function SituacaoReducaoBaseCalculo(AValue: Boolean): IParametrosCalculoDifal; overload;


    function CalculaBaseReduzidaAliquotaEfetiva : Boolean; overload;
    function CalculaBaseReduzidaAliquotaEfetiva(AValue: Boolean): IParametrosCalculoDifal; overload;

    function CalculaDiferencialAliquotaProdutosSt : Boolean; overload;
    function CalculaDiferencialAliquotaProdutosSt(AValue: Boolean): IParametrosCalculoDifal; overload;

    function CalculaTipoDeAbreviacaoFiscal:Boolean; overload;
    function CalculaTipoDeAbreviacaoFiscal(AValue: Boolean): IParametrosCalculoDifal; overload;

    function PercentualProvisorioPartilha :Double; overload;
    function PercentualProvisorioPartilha(AValue: Double): IParametrosCalculoDifal; overload;

    function CodigoSituacaoTributaria : String; overload;
    function CodigoSituacaoTributaria(AValue: String): IParametrosCalculoDifal; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosCalculoDifal; overload;

    function ProdutoDeOrigemEstrangeira: Boolean; overload;
    function ProdutoDeOrigemEstrangeira(AValue: Boolean): IParametrosCalculoDifal; overload;

    function ConsiderarAliquotaEfetivaProdutosImportados: Boolean; overload;
    function ConsiderarAliquotaEfetivaProdutosImportados(AValue: Boolean): IParametrosCalculoDifal; overload;

    function EntraIPInaBaseIcms: Boolean; overload;
    function EntraIPInaBaseIcms(AValue: Boolean): IParametrosCalculoDifal; overload;

    function ClassificacaoFiscalDoItem : String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosCalculoDifal; overload;

    function HabilitarNovoCalculoDifalComPercentualBase : Boolean; overload;
    function HabilitarNovoCalculoDifalComPercentualBase(AValue: Boolean): IParametrosCalculoDifal; overload;

    function CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados : Boolean; overload;
    function CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados(AValue: Boolean): IParametrosCalculoDifal; overload;
  end;

  IResultadoCalculoDifal = interface
    ['{1A5FB75C-2B27-42FD-AA65-96CA22B4BC3C}']

    function ValorBaseDestino: Double; overload;
    function ValorBaseDestino(AValue: Double): IResultadoCalculoDifal; overload;

    function ValorIcmsDestino: Double; overload;
    function ValorIcmsDestino(AValue: Double): IResultadoCalculoDifal; overload;

    function ValorIcmsOrigem: Double; overload;
    function ValorIcmsOrigem(AValue: Double): IResultadoCalculoDifal; overload;

    function AliquotaInterestadualCalc: Double; overload;
    function AliquotaInterestadualCalc(AValue: Double): IResultadoCalculoDifal; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IResultadoCalculoDifal; overload;
  end;

  ICalculoImpostosDifal = interface
    ['{BB65AB87-2D9D-40F8-BB19-9010E3A9A08C}']
    function CalcularValorDifal(AParametros: IParametrosCalculoDifal): IResultadoCalculoDifal; overload;
  end;

implementation

end.
