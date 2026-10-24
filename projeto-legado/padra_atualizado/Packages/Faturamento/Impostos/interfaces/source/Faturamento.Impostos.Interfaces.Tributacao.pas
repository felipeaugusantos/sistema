unit Faturamento.Impostos.Interfaces.Tributacao;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  IParametrosRegrasTributacao = interface
    ['{AC327AC8-6CDC-459D-BDE3-BB2688F3A896}']

    function ModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ModelClienteFornecedor(AValue: IResultadoFaturamentoImpostosModelClienteFornecedor): IParametrosRegrasTributacao; overload;

    function ModelProduto: IResultadoFaturamentoImpostosModelProduto; overload;
    function ModelProduto(AValue: IResultadoFaturamentoImpostosModelProduto): IParametrosRegrasTributacao; overload;

    function ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; overload;
    function ModelEmpresa(AValue: IResultadoFaturamentoImpostosModelEmpresa): IParametrosRegrasTributacao; overload;

    function ModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function ModelAbreviacaoIcms(AValue: IResultadoFaturamentoImpostosModelAbreviacaoIcms): IParametrosRegrasTributacao; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegrasTributacao; overload;

    function NotaDeImportacao: Boolean; overload;
    function NotaDeImportacao(AValue: Boolean): IParametrosRegrasTributacao; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosRegrasTributacao; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegrasTributacao; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegrasTributacao; overload;

    function UtilizaSat : Boolean; overload;
    function UtilizaSat(AValue : Boolean): IParametrosRegrasTributacao; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue : Boolean): IParametrosRegrasTributacao; overload;

    function CalcularSatEcf : Boolean; overload;
    function CalcularSatEcf(AValue : Boolean): IParametrosRegrasTributacao; overload;

    function DentroDoEstadoCFOP: Boolean; overload;
    function DentroDoEstadoCFOP(AValue: Boolean): IParametrosRegrasTributacao; overload;

    function AtividadeConstrutora: Boolean; overload;
    function AtividadeConstrutora(AValue: Boolean): IParametrosRegrasTributacao; overload;

    function TipoOperacaoPedidoVenda: String; overload;
    function TipoOperacaoPedidoVenda(AValue: String): IParametrosRegrasTributacao; overload;

    function AlqIcmEstEmpFaturamento: Double; overload;
    function AlqIcmEstEmpFaturamento(AValue: Double): IParametrosRegrasTributacao; overload;

    function AlqIcmEstEmpSimples: Double; overload;
    function AlqIcmEstEmpSimples(AValue: Double): IParametrosRegrasTributacao; overload;

    function ValorDeIpiDoItem: Double; overload;
    function ValorDeIpiDoItem(AValue: Double): IParametrosRegrasTributacao; overload;

    function DocumentoParaFornecedor: Boolean; overload;
    function DocumentoParaFornecedor(AValue: Boolean): IParametrosRegrasTributacao; overload;

	  function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosRegrasTributacao; overload;

    function ImportacaoDiretaDoItem: String; overload;
    function ImportacaoDiretaDoItem(AValue: String): IParametrosRegrasTributacao; overload;

    function ValorUnitarioDoItem: Double; overload;
    function ValorUnitarioDoItem(AValue: Double): IParametrosRegrasTributacao; overload;

    function QuantidadeDoItem: Double; overload;
    function QuantidadeDoItem(AValue: Double): IParametrosRegrasTributacao; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IParametrosRegrasTributacao; overload;

	  function TotalGeralDoItemST_Simulado: Double; overload;
    function TotalGeralDoItemST_Simulado(AValue: Double): IParametrosRegrasTributacao; overload;

    function ExisteNaTabelaCEDEM: Boolean; overload;
    function ExisteNaTabelaCEDEM(AValue: Boolean): IParametrosRegrasTributacao; overload;

    function UtilizaDecretoReducaoRICMSdaAbreviacao: Boolean; overload;
    function UtilizaDecretoReducaoRICMSdaAbreviacao(AValue: Boolean): IParametrosRegrasTributacao; overload;

    function VendaDeProducao: Boolean; overload;
    function VendaDeProducao(AValue: Boolean): IParametrosRegrasTributacao; overload;
  end;

  IResultadoRegrasTributacaoIcmsSt = interface
    ['{7479C14B-5B4B-43D2-B468-5AC939525583}']

    function AliquotaDeIcms: Double; overload;
    function AliquotaDeIcms(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function ValorIVAEspecialClienteMTIcms: Double; overload;
    function ValorIVAEspecialClienteMTIcms(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function AliquotaDeIcmsAnterior: Double; overload;
    function AliquotaDeIcmsAnterior(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function BaseDeCalculoDoIcmsAnterior: Double; overload;
    function BaseDeCalculoDoIcmsAnterior(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function ValorDoIcmsAnterior: Double; overload;
    function ValorDoIcmsAnterior(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function PercentualDeReducaoDaBaseDeIcms: Double; overload;
    function PercentualDeReducaoDaBaseDeIcms(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function ReducaoRICMPR : String; overload;
    function ReducaoRICMPR(AValue : String): IResultadoRegrasTributacaoIcmsSt; overload;

    function AliquotaDaSubstituicaoTributaria: Double; overload;
    function AliquotaDaSubstituicaoTributaria(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function ValorDoIva: Double; overload;
    function ValorDoIva(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function ValorDoIvaMatriz: Double; overload;
    function ValorDoIvaMatriz(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function ValorDoIvaStMatriz: Double; overload;
    function ValorDoIvaStMatriz(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function ValorIVAEspecialClienteMTSt: Double; overload;
    function ValorIVAEspecialClienteMTSt(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function ValorIcmsEstado: Double; overload;
    function ValorIcmsEstado(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function PercentualDaBaseDaSubstituicaoTributariaDoItem: Double; overload;
    function PercentualDaBaseDaSubstituicaoTributariaDoItem(AValue : Double): IResultadoRegrasTributacaoIcmsSt; overload;

	  function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasTributacaoIcmsSt; overload;

	  function AliquotaDaSubstituicaoTributariaSimulada: Double; overload;
    function AliquotaDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasTributacaoIcmsSt; overload;

	  function ValorDaSubstituicaoTributariaSimulada: Double; overload;
    function ValorDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue : String): IResultadoRegrasTributacaoIcmsSt; overload;

    function AtendeRegrasAtoDeclaratorioDF: Boolean; overload;
    function AtendeRegrasAtoDeclaratorioDF(AValue: Boolean): IResultadoRegrasTributacaoIcmsSt; overload;

    function AliquotaReduzidaDaSt: Double; overload;
    function AliquotaReduzidaDaSt(AValue: Double): IResultadoRegrasTributacaoIcmsSt; overload;

    function STAtribuidaPorRegimeEspecial: Boolean; overload;
    function STAtribuidaPorRegimeEspecial(AValue: Boolean): IResultadoRegrasTributacaoIcmsSt; overload;
  end;

  IFaturamentoImpostosRegrasTributacaoFactory = interface
    ['{A42411A1-880A-4A35-94C0-2820A5BB250E}']

    function Tributacao: IFaturamentoImpostosRegrasTributacaoFactory;
    function IcmsSt: IResultadoRegrasTributacaoIcmsSt;
  end;

  IResultadoRegrasTributacao = interface
    ['{7479C14B-5B4B-43D2-B468-5AC939525583}']

    function AliquotaDeIcms: Double; overload;
    function AliquotaDeIcms(AValue : Double): IResultadoRegrasTributacao; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue : Double): IResultadoRegrasTributacao; overload;

    function CodigoDaSubstituicaoTributaria: String; overload;
    function CodigoDaSubstituicaoTributaria(AValue : String): IResultadoRegrasTributacao; overload;

    function ValorIVAEspecialClienteMTIcms : Double; overload;
    function ValorIVAEspecialClienteMTIcms(AValue : Double): IResultadoRegrasTributacao; overload;

    function AliquotaDeIcmsAnterior: Double; overload;
    function AliquotaDeIcmsAnterior(AValue : Double): IResultadoRegrasTributacao; overload;

    function BaseDeCalculoDoIcmsAnterior: Double; overload;
    function BaseDeCalculoDoIcmsAnterior(AValue : Double): IResultadoRegrasTributacao; overload;

    function ValorDoIcmsAnterior: Double; overload;
    function ValorDoIcmsAnterior(AValue : Double): IResultadoRegrasTributacao; overload;

    function PercentualDeReducaoDaBaseDeIcms: Double; overload;
    function PercentualDeReducaoDaBaseDeIcms(AValue : Double): IResultadoRegrasTributacao; overload;

    function ReducaoRICMPR : String; overload;
    function ReducaoRICMPR(AValue : String): IResultadoRegrasTributacao; overload;

    function AliquotaDaSubstituicaoTributaria: Double; overload;
    function AliquotaDaSubstituicaoTributaria(AValue : Double): IResultadoRegrasTributacao; overload;

    function ValorDoIva: Double; overload;
    function ValorDoIva(AValue : Double): IResultadoRegrasTributacao; overload;

    function ValorDoIvaMatriz: Double; overload;
    function ValorDoIvaMatriz(AValue : Double): IResultadoRegrasTributacao; overload;

    function ValorDoIvaStMatriz: Double; overload;
    function ValorDoIvaStMatriz(AValue : Double): IResultadoRegrasTributacao; overload;

    function ValorIVAEspecialClienteMTSt: Double; overload;
    function ValorIVAEspecialClienteMTSt(AValue : Double): IResultadoRegrasTributacao; overload;

    function ValorIcmsEstado: Double; overload;
    function ValorIcmsEstado(AValue : Double): IResultadoRegrasTributacao; overload;

    function PercentualDaBaseDaSubstituicaoTributariaDoItem: Double; overload;
    function PercentualDaBaseDaSubstituicaoTributariaDoItem(AValue : Double): IResultadoRegrasTributacao; overload;

	  function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasTributacao; overload;

	  function AliquotaDaSubstituicaoTributariaSimulada: Double; overload;
    function AliquotaDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasTributacao; overload;

	  function ValorDaSubstituicaoTributariaSimulada: Double; overload;
    function ValorDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoRegrasTributacao; overload;

    function AliquotaDeIcmsEfetivoDoItem: Double; overload;
    function AliquotaDeIcmsEfetivoDoItem(AValue: Double): IResultadoRegrasTributacao; overload;

    function AtendeRegrasAtoDeclaratorioDF: Boolean; overload;
    function AtendeRegrasAtoDeclaratorioDF(AValue: Boolean): IResultadoRegrasTributacao; overload;

    function AliquotaReduzidaDaSt: Double; overload;
    function AliquotaReduzidaDaSt(AValue: Double): IResultadoRegrasTributacao; overload;

    function STAtribuidaPorRegimeEspecial: Boolean; overload;
    function STAtribuidaPorRegimeEspecial(AValue: Boolean): IResultadoRegrasTributacao; overload;
  end;


  IFaturamentoImpostosRegrasTributacao = interface
    ['{A42411A1-880A-4A35-94C0-2820A5BB250E}']

    function IniciarAliquotasEPercentuais: IFaturamentoImpostosRegrasTributacao;
    function DentroOuForaDoEstado: IFaturamentoImpostosRegrasTributacao;
    function ResultadoTributacao: IResultadoRegrasTributacao;
    function AliquotaDeIcmsEfetivoDoItem : Double;
  end;


implementation

end.
