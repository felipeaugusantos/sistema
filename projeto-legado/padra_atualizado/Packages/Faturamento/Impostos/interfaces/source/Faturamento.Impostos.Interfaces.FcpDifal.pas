unit Faturamento.Impostos.Interfaces.FcpDifal;

interface

uses Shared.Functions.Types, Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Interfaces.FCP, Faturamento.Impostos.Interfaces.Difal;

type
  IParametrosServicoFcpDifal = interface
    ['{2F4A20A4-CCDB-4CF7-837D-A83B22A0BCC3}']

    function CodigoDoItemDaAbreviacaoFiscal: String; overload;
    function CodigoDoItemDaAbreviacaoFiscal(AValue: String): IParametrosServicoFcpDifal; overload;

    function CodigoDaAbreviacaoFiscal: String; overload;
    function CodigoDaAbreviacaoFiscal(AValue: String): IParametrosServicoFcpDifal; overload;

    function SequencialEnderecoEntrega: String; overload;
    function SequencialEnderecoEntrega(AValue: String): IParametrosServicoFcpDifal; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IParametrosServicoFcpDifal; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function NotaComplementoFornecedor: Boolean; overload;
    function NotaComplementoFornecedor(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function NotaEspecialFornecedor: Boolean; overload;
    function NotaEspecialFornecedor(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosServicoFcpDifal; overload;

    function CodigoDoFornecedor: String; overload;
    function CodigoDoFornecedor(AValue: String): IParametrosServicoFcpDifal; overload;

    function ClienteFilial: Boolean; overload;
    function ClienteFilial(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosServicoFcpDifal; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosServicoFcpDifal; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosServicoFcpDifal; overload;

    function DocumentoDeDevolucao: Boolean; overload;
    function DocumentoDeDevolucao(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function DiferencaFCPST: Boolean; overload;
    function DiferencaFCPST(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosServicoFcpDifal; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosServicoFcpDifal; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosServicoFcpDifal; overload;

    function ProdutoIndustrializado: Boolean; overload;
    function ProdutoIndustrializado(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue: IParametrosFaturamentoImpostosClienteConsumidor): IParametrosServicoFcpDifal; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IParametrosServicoFcpDifal; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosServicoFcpDifal; overload;

    function GerandoCasosTestes: Boolean; overload;
    function GerandoCasosTestes(AValue: boolean): IParametrosServicoFcpDifal; overload;

    function CodigoDaEmpresaTE: String; overload;
    function CodigoDaEmpresaTE(AValue: String): IParametrosServicoFcpDifal; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosServicoFcpDifal; overload;

    function DataDoSistema: TDateTime; overload;
    function DataDoSistema(AValue: TDateTime): IParametrosServicoFcpDifal; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue: boolean): IParametrosServicoFcpDifal; overload;

    function ClassificacaoFiscalRecebimentoGarantia: String; overload;
    function ClassificacaoFiscalRecebimentoGarantia(AValue: String): IParametrosServicoFcpDifal; overload;

    function AliquotaFCPST: Double; overload;
    function AliquotaFCPST(AValue: Double): IParametrosServicoFcpDifal; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosServicoFcpDifal; overload;

    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosServicoFcpDifal; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function NumeroDoDocumentoDeDevolucao: String; overload;
    function NumeroDoDocumentoDeDevolucao(AValue: String): IParametrosServicoFcpDifal; overload;

    function EspecieDoDocumentoDeDevolucao: String; overload;
    function EspecieDoDocumentoDeDevolucao(AValue: String): IParametrosServicoFcpDifal; overload;

    function EmpresaDoDocumentoDeDevolucao: String; overload;
    function EmpresaDoDocumentoDeDevolucao(AValue: String): IParametrosServicoFcpDifal; overload;

    function CodigoDoItem: String; overload;
    function CodigoDoItem(AValue: String): IParametrosServicoFcpDifal; overload;

    function QuantidadeDoItem: Double; overload;
    function QuantidadeDoItem(AValue: Double): IParametrosServicoFcpDifal; overload;

    function OpcaoDeItemNfEspiritoSanto : TOpcItensNFespTinta; overload;
    function OpcaoDeItemNfEspiritoSanto(AValue: TOpcItensNFespTinta): IParametrosServicoFcpDifal; overload;

    function ValorDoIpi: Double; overload;
    function ValorDoIpi(AValue: Double): IParametrosServicoFcpDifal; overload;

    function ValorDoFrete: Double; overload;
    function ValorDoFrete(AValue: Double): IParametrosServicoFcpDifal; overload;

    function ValorTotalDoItem: Double; overload;
    function ValorTotalDoItem(AValue: Double): IParametrosServicoFcpDifal; overload;

    function DescontoEspecial: Double; overload;
    function DescontoEspecial(AValue: Double): IParametrosServicoFcpDifal; overload;

    function DespesasAcessorias: Double; overload;
    function DespesasAcessorias(AValue: Double): IParametrosServicoFcpDifal; overload;

    function PercentualBaseDoIcmsDoItem: Double; overload;
    function PercentualBaseDoIcmsDoItem(AValue: Double): IParametrosServicoFcpDifal; overload;

    function OpcaoDeDocumentoVerdadeira: String; overload;
    function OpcaoDeDocumentoVerdadeira(AValue: String): IParametrosServicoFcpDifal; overload;

    function EntraIPInaBaseIcms: Boolean; overload;
    function EntraIPInaBaseIcms(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function ValorDaSTDoItemNoFatuamentoConsignacao: Double; overload;
    function ValorDaSTDoItemNoFatuamentoConsignacao(AValue: Double): IParametrosServicoFcpDifal; overload;

    function ClassificacaoFiscal: String; overload;
    function ClassificacaoFiscal(AValue: String): IParametrosServicoFcpDifal; overload;

    function ProdutoEmbalagem: String; overload;
    function ProdutoEmbalagem(AValue: String): IParametrosServicoFcpDifal; overload;

    function HabilitarNovoCalculoDifalComPercentualBase: Boolean; overload;
    function HabilitarNovoCalculoDifalComPercentualBase(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function ProdutoRevenda: Boolean; overload;
    function ProdutoRevenda(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function ProdutoImportacaoDireta: Boolean; overload;
    function ProdutoImportacaoDireta(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function STAtribuidaPorRegimeEspecial: Boolean; overload;
    function STAtribuidaPorRegimeEspecial(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function BaseDeCalculoDoIcmsDoItemBenST: Double; overload;
    function BaseDeCalculoDoIcmsDoItemBenST(AValue: Double): IParametrosServicoFcpDifal; overload;

    function CodigoDaEmpresaAbf: String; overload;
    function CodigoDaEmpresaAbf(AValue: String): IParametrosServicoFcpDifal; overload;

    function CalculandoPrecoDeVendaComDifal: Boolean; overload;
    function CalculandoPrecoDeVendaComDifal(AValue: Boolean): IParametrosServicoFcpDifal; overload;

    function CodigoDaFazenda: String; overload;
    function CodigoDaFazenda(AValue: String): IParametrosServicoFcpDifal; overload;

    function CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados: Boolean; overload;
    function CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados(AValue: Boolean): IParametrosServicoFcpDifal; overload;

  end;

  IResultadoCalculoFcpDifalFinal = interface
    ['{12E96527-AD39-49A1-8FC6-7FE07315235C}']

    function BaseDestino: Double; overload;
    function BaseDestino(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function AliquotaFCP: Double; overload;
    function AliquotaFCP(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function AliquotaInternaEstadoDestino: Double; overload;
    function AliquotaInternaEstadoDestino(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function AlqInterestadualCalc: Double; overload;
    function AlqInterestadualCalc(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function PercentualProvisorioPartilha: Double; overload;
    function PercentualProvisorioPartilha(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function IcmsDestino: Double; overload;
    function IcmsDestino(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function IcmsOrigem: Double; overload;
    function IcmsOrigem(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function DevolucaoOuEntradaGarantia: Boolean; overload;
    function DevolucaoOuEntradaGarantia(AValue: Boolean): IResultadoCalculoFcpDifalFinal; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function AliquotaFCPST: Double; overload;
    function AliquotaFCPST(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IResultadoCalculoFcpDifalFinal; overload;

    function GravarOsRegistros: Boolean; overload;
    function GravarOsRegistros(AValue: Boolean): IResultadoCalculoFcpDifalFinal; overload;

    function SairDoProcedimento: Boolean; overload;
    function SairDoProcedimento(AValue: Boolean): IResultadoCalculoFcpDifalFinal; overload;

    function ExibirMensagemAliquotaInternaEstadoDestino: Boolean; overload;
    function ExibirMensagemAliquotaInternaEstadoDestino(AValue: Boolean): IResultadoCalculoFcpDifalFinal; overload;

    function ValorCalculadoFCPSTConsignacao : Double; overload;
    function ValorCalculadoFCPSTConsignacao(AValue: Double): IResultadoCalculoFcpDifalFinal; overload;
  end;

  IResultadoServicosClasseFcpDifal = interface
    ['{009ECA78-A7AF-416F-9A57-E68EAC18FDDF}']

    function ResultadoCalculoFcp: IResultadoCalculoFCP; overload;
    function ResultadoCalculoFcp(AValue: IResultadoCalculoFCP): IResultadoServicosClasseFcpDifal; overload;

    function ParametrosCalculoFcp: IParametrosCalculoFCP; overload;
    function ParametrosCalculoFcp(AValue: IParametrosCalculoFCP): IResultadoServicosClasseFcpDifal; overload;

    function ResultadoCalculoDifal: IResultadoCalculoDifal; overload;
    function ResultadoCalculoDifal(AValue: IResultadoCalculoDifal): IResultadoServicosClasseFcpDifal; overload;

    function ParametrosCalculoDifal: IParametrosCalculoDifal; overload;
    function ParametrosCalculoDifal(AValue: IParametrosCalculoDifal): IResultadoServicosClasseFcpDifal; overload;

    function ResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP; overload;
    function ResultadoCalculoDifalFcp(AValue: IResultadoCalculoDifalFCP): IResultadoServicosClasseFcpDifal; overload;

    function ParametrosCalculoDifalFcp: IParametrosCalculoDifalFCP; overload;
    function ParametrosCalculoDifalFcp(AValue: IParametrosCalculoDifalFCP): IResultadoServicosClasseFcpDifal; overload;

    function ResultadoCalculoFcpDifalFinal: IResultadoCalculoFcpDifalFinal; overload;
    function ResultadoCalculoFcpDifalFinal(AValue: IResultadoCalculoFcpDifalFinal): IResultadoServicosClasseFcpDifal; overload;
  end;

implementation

end.
