unit Faturamento.Impostos.Interfaces.ZerarImpostos.Fcp;

interface

type
  IParametrosRegraZerarImpostosFcp = interface
    ['{DF86893D-9E7B-4C09-A93D-6BFACB80B5DB}']

    function ProdutoST: Boolean; overload;
    function ProdutoST(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostosFcp; overload;

    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosRegraZerarImpostosFcp; overload;

    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosRegraZerarImpostosFcp; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostosFcp; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function ClienteOrgaoPublicoDifal: Boolean; overload;
    function ClienteOrgaoPublicoDifal(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostosFcp; overload;

    function ValorDaSTDoItemNoFatuamentoConsignacao: Double; overload;
    function ValorDaSTDoItemNoFatuamentoConsignacao(AValue: Double): IParametrosRegraZerarImpostosFcp; overload;

    function STAtribuidaPorRegimeEspecial: Boolean; overload;
    function STAtribuidaPorRegimeEspecial(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

  end;

  IRegraImpostosZerarImpostosFcp = interface
    ['{FA5D1B3B-2E86-4242-8A62-710BD20DA3A1}']

    function ZerarValorDoFcp(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
  end;

implementation

end.
