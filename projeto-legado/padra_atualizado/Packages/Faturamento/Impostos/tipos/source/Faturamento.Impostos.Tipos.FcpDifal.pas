unit Faturamento.Impostos.Tipos.FcpDifal;

interface

uses Faturamento.Impostos.Interfaces.FcpDifal, Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Model, Faturamento.Impostos.Interfaces.Fcp,
  Faturamento.Impostos.Interfaces.Difal;

type
  TParametrosServicoFcpDifal = class(TInterfacedObject, IParametrosServicoFcpDifal)
  private
    FCodigoDoItemDaAbreviacaoFiscal: String;
    FCodigoDaAbreviacaoFiscal: String;
    FSequencialEnderecoEntrega: String;
    FTipoDaAbreviacaoFiscal: String;
    FVendaPresencial: Boolean;
    FClienteConsumidorFinal: Boolean;
    FOpcaoDeDocumento: String;
    FNotaComplementoFornecedor: Boolean;
    FNotaEspecialFornecedor: Boolean;
    FCodigoDoCliente: String;
    FCodigoDoFornecedor: String;
    FClienteFilial: Boolean;
    FCodigoDaSituacaoTributaria: String;
    FBaseDeCalculoDoIcmsDoItem: Double;
    FDocumentoDeDevolucao: Boolean;
    FDiferencaFCPST: Boolean;
    FBaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
    FCodigoDaSubstituicaoTributariaDoItem: String;
    FRecordDifalFCP: TRecDifalFCP;
    FProdutoIndustrializado: Boolean;
    FParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
    FCodigoDaEmpresa: String;
    FClassificacaoFiscalDoItem: String;
    FGerandoCasosTestes: Boolean;
    FCodigoDaEmpresaTE: String;
    FAliquotaDeIcmsDoItem: Double;
    FDataDoSistema: TDateTime;
    FClienteIndustria: Boolean;
    FClassificacaoFiscalRecebimentoGarantia: String;
    FAliquotaFCPST: Double;
    FBaixaDeEntregaFutura: Boolean;
    FEspecieDoDocumento: String;
    FValorDaSubstituicaoTributariaDoItem: Double;
    FEntregaFuturaDoItem: Boolean;
    FNumeroDoDocumentoDeDevolucao: String;
    FEspecieDoDocumentoDeDevolucao: String;
    FEmpresaDoDocumentoDeDevolucao: String;
    FCodigoDoItem: String;
    FQuantidadeDoItem: Double;
    FOpcaoDeItemNfEspiritoSanto: TOpcItensNFespTinta;
    FValorDoIpi: Double;
    FValorDoFrete: Double;
    FValorTotalDoItem: Double;
    FDescontoEspecial: Double;
    FDespesasAcessorias: Double;
    FPercentualBaseDoIcmsDoItem: Double;
    FOpcaoDeDocumentoVerdadeira: String;
    FEntraIPInaBaseIcms: Boolean;
    FValorDaSTDoItemNoFatuamentoConsignacao : Double;
    FClassificacaoFiscal: String;
    FProdutoEmbalagem: String;
    FHabilitarNovoCalculoDifalComPercentualBase: Boolean;
    FProdutoRevenda: Boolean;
    FProdutoImportacaoDireta: Boolean;
    FSTAtribuidaPorRegimeEspecial: Boolean;
    FBaseDeCalculoDoIcmsDoItemBenST: Double;
    FCodigoDaEmpresaAbf: String;
    FCalculandoPrecoDeVendaComDifal: Boolean;
    FCodigoDaFazenda: String;
    FCalculaDifalParaCombustiveis_e_LubrificantesNaoTributados: Boolean;
  public
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

    function OpcaoDeItemNfEspiritoSanto: TOpcItensNFespTinta; overload;
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

    class function New(): IParametrosServicoFcpDifal;
  end;

type
  TResultadoCalculoFcpDifalFinal = class(TInterfacedObject, IResultadoCalculoFcpDifalFinal)
  private
    FBaseDestino: Double;
    FAliquotaFCP: Double;
    FAliquotaInternaEstadoDestino: Double;
    FAlqInterestadualCalc: Double;
    FPercentualProvisorioPartilha: Double;
    FValorFCP: Double;
    FIcmsDestino: Double;
    FIcmsOrigem: Double;
    FDevolucaoOuEntradaGarantia: Boolean;
    FBaseFCP: Double;
    FAliquotaFCPST: Double;
    FRecordDifalFCP: TRecDifalFCP;
    FGravarOsRegistros: Boolean;
    FSairDoProcedimento: Boolean;
    FExibirMensagemAliquotaInternaEstadoDestino: Boolean;
    FValorCalculadoFCPSTConsignacao : Double;
  public
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

    class function New(): IResultadoCalculoFcpDifalFinal;
  end;

type
  TResultadoServicosClasseFcpDifal = class(TInterfacedObject, IResultadoServicosClasseFcpDifal)
  private
    FResultadoCalculoFcp: IResultadoCalculoFCP;
    FParametrosCalculoFcp: IParametrosCalculoFCP;
    FResultadoCalculoDifal: IResultadoCalculoDifal;
    FParametrosCalculoDifal: IParametrosCalculoDifal;
    FResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
    FParametrosCalculoDifalFcp: IParametrosCalculoDifalFCP;
    FResultadoCalculoFcpDifalFinal: IResultadoCalculoFcpDifalFinal;
  public
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

    class function New(): IResultadoServicosClasseFcpDifal;
  end;


implementation

{ TParametrosServicoFcpDifal }

function TParametrosServicoFcpDifal.BaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FBaseDeCalculoDaSubstituicaoTributariaDoItem;
end;

function TParametrosServicoFcpDifal.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosServicoFcpDifal.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosServicoFcpDifal.AliquotaFCPST: Double;
begin
  Result := FAliquotaFCPST;
end;

function TParametrosServicoFcpDifal.AliquotaFCPST(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FAliquotaFCPST := AValue;
end;

function TParametrosServicoFcpDifal.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosServicoFcpDifal.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosServicoFcpDifal.BaseDeCalculoDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FBaseDeCalculoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosServicoFcpDifal.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

function TParametrosServicoFcpDifal.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TParametrosServicoFcpDifal.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosServicoFcpDifal.ClassificacaoFiscalDoItem(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosServicoFcpDifal.ClassificacaoFiscalRecebimentoGarantia: String;
begin
  Result := FClassificacaoFiscalRecebimentoGarantia;
end;

function TParametrosServicoFcpDifal.ClassificacaoFiscalRecebimentoGarantia(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FClassificacaoFiscalRecebimentoGarantia := AValue;
end;

function TParametrosServicoFcpDifal.ClassificacaoFiscal: String;
begin
  Result := FClassificacaoFiscal;
end;

function TParametrosServicoFcpDifal.CalculandoPrecoDeVendaComDifal: Boolean;
begin
  Result := FCalculandoPrecoDeVendaComDifal;
end;

function TParametrosServicoFcpDifal.CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados: Boolean;
begin
  Result := FCalculaDifalParaCombustiveis_e_LubrificantesNaoTributados;
end;

function TParametrosServicoFcpDifal.CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados(AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCalculaDifalParaCombustiveis_e_LubrificantesNaoTributados := AValue;
end;

function TParametrosServicoFcpDifal.CalculandoPrecoDeVendaComDifal(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCalculandoPrecoDeVendaComDifal := AValue;
end;

function TParametrosServicoFcpDifal.ClassificacaoFiscal(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FClassificacaoFiscal := AValue;
end;

function TParametrosServicoFcpDifal.ProdutoEmbalagem: String;
begin
  Result := FProdutoEmbalagem;
end;

function TParametrosServicoFcpDifal.ProdutoEmbalagem(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FProdutoEmbalagem := AValue;
end;

function TParametrosServicoFcpDifal.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosServicoFcpDifal.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosServicoFcpDifal.ClienteFilial(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FClienteFilial := AValue;
end;

function TParametrosServicoFcpDifal.ClienteIndustria: Boolean;
begin
  Result := FClienteIndustria;
end;

function TParametrosServicoFcpDifal.ClienteIndustria(
  AValue: boolean): IParametrosServicoFcpDifal;
begin
  Result:= Self;
  FClienteIndustria := AValue;
end;

function TParametrosServicoFcpDifal.ClienteFilial: Boolean;
begin
  Result := FClienteFilial;
end;

function TParametrosServicoFcpDifal.CodigoDaAbreviacaoFiscal(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDaAbreviacaoFiscal := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosServicoFcpDifal.CodigoDaEmpresa(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDaEmpresaAbf: String;
begin
  Result := FCodigoDaEmpresaAbf;
end;

function TParametrosServicoFcpDifal.CodigoDaEmpresaAbf(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDaEmpresaAbf := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDaEmpresaTE: String;
begin
  Result := FCodigoDaEmpresaTE;
end;

function TParametrosServicoFcpDifal.CodigoDaEmpresaTE(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDaEmpresaTE := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDaFazenda: String;
begin
  Result := FCodigoDaFazenda;
end;

function TParametrosServicoFcpDifal.CodigoDaFazenda(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDaFazenda := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDaAbreviacaoFiscal: String;
begin
  Result := FCodigoDaAbreviacaoFiscal;
end;

function TParametrosServicoFcpDifal.CodigoDaSituacaoTributaria(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDaSituacaoTributaria: String;
begin
  Result := FCodigoDaSituacaoTributaria;
end;

function TParametrosServicoFcpDifal.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TParametrosServicoFcpDifal.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDoCliente(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TParametrosServicoFcpDifal.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

function TParametrosServicoFcpDifal.CodigoDoFornecedor(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDoItem: String;
begin
  Result := FCodigoDoItem;
end;

function TParametrosServicoFcpDifal.CodigoDoItem(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDoItem := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDoItemDaAbreviacaoFiscal(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FCodigoDoItemDaAbreviacaoFiscal := AValue;
end;

function TParametrosServicoFcpDifal.CodigoDoItemDaAbreviacaoFiscal: String;
begin
  Result := FCodigoDoItemDaAbreviacaoFiscal;
end;

function TParametrosServicoFcpDifal.DataDoSistema: TDateTime;
begin
  Result := FDataDoSistema;
end;

function TParametrosServicoFcpDifal.DataDoSistema(
  AValue: TDateTime): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FDataDoSistema := AValue;
end;

function TParametrosServicoFcpDifal.DescontoEspecial(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FDescontoEspecial := AValue;
end;

function TParametrosServicoFcpDifal.DescontoEspecial: Double;
begin
  Result := FDescontoEspecial;
end;

function TParametrosServicoFcpDifal.DespesasAcessorias(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FDespesasAcessorias := AValue;
end;

function TParametrosServicoFcpDifal.DespesasAcessorias: Double;
begin
  Result := FDespesasAcessorias;
end;

function TParametrosServicoFcpDifal.DiferencaFCPST(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FDiferencaFCPST := AValue;
end;

function TParametrosServicoFcpDifal.DiferencaFCPST: Boolean;
begin
  Result := FDiferencaFCPST;
end;

function TParametrosServicoFcpDifal.DocumentoDeDevolucao: Boolean;
begin
  Result := FDocumentoDeDevolucao;
end;

function TParametrosServicoFcpDifal.DocumentoDeDevolucao(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FDocumentoDeDevolucao := AValue;
end;

function TParametrosServicoFcpDifal.EmpresaDoDocumentoDeDevolucao: String;
begin
  Result := FEmpresaDoDocumentoDeDevolucao;
end;

function TParametrosServicoFcpDifal.EmpresaDoDocumentoDeDevolucao(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FEmpresaDoDocumentoDeDevolucao := AValue;
end;

function TParametrosServicoFcpDifal.EntregaFuturaDoItem(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FEntregaFuturaDoItem := AValue;
end;

function TParametrosServicoFcpDifal.EntregaFuturaDoItem: Boolean;
begin
  Result := FEntregaFuturaDoItem;
end;

function TParametrosServicoFcpDifal.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosServicoFcpDifal.EspecieDoDocumento(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosServicoFcpDifal.EspecieDoDocumentoDeDevolucao: String;
begin
  Result := FEspecieDoDocumentoDeDevolucao;
end;

function TParametrosServicoFcpDifal.EspecieDoDocumentoDeDevolucao(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FEspecieDoDocumentoDeDevolucao := AValue;
end;

function TParametrosServicoFcpDifal.GerandoCasosTestes: Boolean;
begin
  Result := FGerandoCasosTestes;
end;

function TParametrosServicoFcpDifal.GerandoCasosTestes(
  AValue: boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FGerandoCasosTestes := AValue;
end;

class function TParametrosServicoFcpDifal.New: IParametrosServicoFcpDifal;
begin
  Result := Self.Create;
end;

function TParametrosServicoFcpDifal.NotaComplementoFornecedor(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FNotaComplementoFornecedor := AValue;
end;

function TParametrosServicoFcpDifal.NotaComplementoFornecedor: Boolean;
begin
  Result := FNotaComplementoFornecedor;
end;

function TParametrosServicoFcpDifal.NotaEspecialFornecedor: Boolean;
begin
  Result := FNotaEspecialFornecedor;
end;

function TParametrosServicoFcpDifal.NotaEspecialFornecedor(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FNotaEspecialFornecedor := AValue;
end;

function TParametrosServicoFcpDifal.NumeroDoDocumentoDeDevolucao: String;
begin
  Result := FNumeroDoDocumentoDeDevolucao;
end;

function TParametrosServicoFcpDifal.NumeroDoDocumentoDeDevolucao(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FNumeroDoDocumentoDeDevolucao := AValue;
end;

function TParametrosServicoFcpDifal.OpcaoDeDocumento: String;
begin
  Result := FOpcaoDeDocumento;
end;

function TParametrosServicoFcpDifal.OpcaoDeDocumento(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FOpcaoDeDocumento := AValue;
end;

function TParametrosServicoFcpDifal.OpcaoDeItemNfEspiritoSanto: TOpcItensNFespTinta;
begin
  Result := FOpcaoDeItemNfEspiritoSanto;
end;

function TParametrosServicoFcpDifal.OpcaoDeItemNfEspiritoSanto(
  AValue: TOpcItensNFespTinta): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FOpcaoDeItemNfEspiritoSanto := AValue;
end;

function TParametrosServicoFcpDifal.ParametrosClienteConsumidor(
  AValue: IParametrosFaturamentoImpostosClienteConsumidor): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FParametrosClienteConsumidor := AValue;
end;

function TParametrosServicoFcpDifal.PercentualBaseDoIcmsDoItem(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FPercentualBaseDoIcmsDoItem := AValue;
end;

function TParametrosServicoFcpDifal.PercentualBaseDoIcmsDoItem: Double;
begin
  Result := FPercentualBaseDoIcmsDoItem;
end;

function TParametrosServicoFcpDifal.OpcaoDeDocumentoVerdadeira(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FOpcaoDeDocumentoVerdadeira := AValue;
end;

function TParametrosServicoFcpDifal.OpcaoDeDocumentoVerdadeira: String;
begin
  Result := FOpcaoDeDocumentoVerdadeira;
end;

function TParametrosServicoFcpDifal.ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := FParametrosClienteConsumidor;
end;

function TParametrosServicoFcpDifal.ProdutoIndustrializado(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FProdutoIndustrializado := AValue;
end;

function TParametrosServicoFcpDifal.QuantidadeDoItem: Double;
begin
  Result := FQuantidadeDoItem;
end;

function TParametrosServicoFcpDifal.QuantidadeDoItem(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FQuantidadeDoItem := AValue;
end;

function TParametrosServicoFcpDifal.ProdutoIndustrializado: Boolean;
begin
  Result := FProdutoIndustrializado;
end;

function TParametrosServicoFcpDifal.RecordDifalFCP(
  AValue: TRecDifalFCP): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FRecordDifalFCP := AValue;
end;

function TParametrosServicoFcpDifal.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TParametrosServicoFcpDifal.SequencialEnderecoEntrega(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FSequencialEnderecoEntrega := AValue;
end;

function TParametrosServicoFcpDifal.STAtribuidaPorRegimeEspecial: Boolean;
begin
  Result := FSTAtribuidaPorRegimeEspecial;
end;

function TParametrosServicoFcpDifal.STAtribuidaPorRegimeEspecial(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FSTAtribuidaPorRegimeEspecial := AValue;
end;

function TParametrosServicoFcpDifal.SequencialEnderecoEntrega: String;
begin
  Result := FSequencialEnderecoEntrega;
end;

function TParametrosServicoFcpDifal.TipoDaAbreviacaoFiscal(
  AValue: String): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

function TParametrosServicoFcpDifal.TipoDaAbreviacaoFiscal: String;
begin
  Result := FTipoDaAbreviacaoFiscal;
end;

function TParametrosServicoFcpDifal.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

function TParametrosServicoFcpDifal.ValorDaSTDoItemNoFatuamentoConsignacao: Double;
begin
  Result := FValorDaSTDoItemNoFatuamentoConsignacao;
end;

function TParametrosServicoFcpDifal.ValorDaSTDoItemNoFatuamentoConsignacao(AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FValorDaSTDoItemNoFatuamentoConsignacao := AValue;
end;

function TParametrosServicoFcpDifal.BaseDeCalculoDoIcmsDoItemBenST: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItemBenST;
end;

function TParametrosServicoFcpDifal.BaseDeCalculoDoIcmsDoItemBenST(AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItemBenST := AValue;
end;

function TParametrosServicoFcpDifal.ValorDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosServicoFcpDifal.ValorDoFrete: Double;
begin
  Result := FValorDoFrete;
end;

function TParametrosServicoFcpDifal.ValorDoFrete(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FValorDoFrete := AValue;
end;

function TParametrosServicoFcpDifal.ValorDoIpi(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FValorDoIpi := AValue;
end;

function TParametrosServicoFcpDifal.ValorDoIpi: Double;
begin
  Result := FValorDoIpi;
end;

function TParametrosServicoFcpDifal.ValorTotalDoItem: Double;
begin
  Result := FValorTotalDoItem;
end;

function TParametrosServicoFcpDifal.ValorTotalDoItem(
  AValue: Double): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FValorTotalDoItem := AValue;
end;

function TParametrosServicoFcpDifal.ValorDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FValorDaSubstituicaoTributariaDoItem;
end;

function TParametrosServicoFcpDifal.VendaPresencial(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

function TParametrosServicoFcpDifal.EntraIPInaBaseIcms(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FEntraIPInaBaseIcms := AValue;
end;

function TParametrosServicoFcpDifal.EntraIPInaBaseIcms: Boolean;
begin
  Result := FEntraIPInaBaseIcms;
end;

function TParametrosServicoFcpDifal.HabilitarNovoCalculoDifalComPercentualBase(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FHabilitarNovoCalculoDifalComPercentualBase := AValue;
end;

function TParametrosServicoFcpDifal.HabilitarNovoCalculoDifalComPercentualBase: Boolean;
begin
  Result := FHabilitarNovoCalculoDifalComPercentualBase;
end;

function TParametrosServicoFcpDifal.ProdutoRevenda(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FProdutoRevenda := AValue;
end;

function TParametrosServicoFcpDifal.ProdutoRevenda: Boolean;
begin
  Result := FProdutoRevenda;
end;

function TParametrosServicoFcpDifal.ProdutoImportacaoDireta(
  AValue: Boolean): IParametrosServicoFcpDifal;
begin
  Result := Self;
  FProdutoImportacaoDireta := AValue;
end;

function TParametrosServicoFcpDifal.ProdutoImportacaoDireta: Boolean;
begin
  Result := FProdutoImportacaoDireta;
end;

{ TResultadoCalculoFcpDifalFinal }

function TResultadoCalculoFcpDifalFinal.AliquotaFCP: Double;
begin
  Result := FAliquotaFCP;
end;

function TResultadoCalculoFcpDifalFinal.AliquotaFCP(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FAliquotaFCP := AValue;
end;

function TResultadoCalculoFcpDifalFinal.AliquotaFCPST(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FAliquotaFCPST := AValue;
end;

function TResultadoCalculoFcpDifalFinal.AliquotaFCPST: Double;
begin
  Result := FAliquotaFCPST;
end;

function TResultadoCalculoFcpDifalFinal.AliquotaInternaEstadoDestino: Double;
begin
  Result := FAliquotaInternaEstadoDestino;
end;

function TResultadoCalculoFcpDifalFinal.AliquotaInternaEstadoDestino(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FAliquotaInternaEstadoDestino := AValue;
end;

function TResultadoCalculoFcpDifalFinal.AlqInterestadualCalc: Double;
begin
  Result := FAlqInterestadualCalc;
end;

function TResultadoCalculoFcpDifalFinal.AlqInterestadualCalc(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FAlqInterestadualCalc := AValue;
end;

function TResultadoCalculoFcpDifalFinal.BaseDestino: Double;
begin
  Result := FBaseDestino;
end;

function TResultadoCalculoFcpDifalFinal.BaseDestino(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FBaseDestino := AValue;
end;

function TResultadoCalculoFcpDifalFinal.BaseFCP: Double;
begin
  Result := FBaseFCP;
end;

function TResultadoCalculoFcpDifalFinal.BaseFCP(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FBaseFCP := AValue;
end;

function TResultadoCalculoFcpDifalFinal.DevolucaoOuEntradaGarantia: Boolean;
begin
  Result := FDevolucaoOuEntradaGarantia;
end;

function TResultadoCalculoFcpDifalFinal.DevolucaoOuEntradaGarantia(
  AValue: Boolean): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FDevolucaoOuEntradaGarantia := AValue;
end;

function TResultadoCalculoFcpDifalFinal.ExibirMensagemAliquotaInternaEstadoDestino: Boolean;
begin
  Result := FExibirMensagemAliquotaInternaEstadoDestino;
end;

function TResultadoCalculoFcpDifalFinal.ExibirMensagemAliquotaInternaEstadoDestino(
  AValue: Boolean): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FExibirMensagemAliquotaInternaEstadoDestino := AValue;
end;

function TResultadoCalculoFcpDifalFinal.GravarOsRegistros: Boolean;
begin
  Result := FGravarOsRegistros;
end;

function TResultadoCalculoFcpDifalFinal.GravarOsRegistros(
  AValue: Boolean): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FGravarOsRegistros := AValue;
end;

class function TResultadoCalculoFcpDifalFinal.New: IResultadoCalculoFcpDifalFinal;
begin
  Result := Self.Create;
end;

function TResultadoCalculoFcpDifalFinal.PercentualProvisorioPartilha(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FPercentualProvisorioPartilha := AValue;
end;

function TResultadoCalculoFcpDifalFinal.RecordDifalFCP(
  AValue: TRecDifalFCP): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FRecordDifalFCP := AValue;
end;

function TResultadoCalculoFcpDifalFinal.SairDoProcedimento: Boolean;
begin
  Result := FSairDoProcedimento;
end;

function TResultadoCalculoFcpDifalFinal.SairDoProcedimento(
  AValue: Boolean): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FSairDoProcedimento := AValue;
end;

function TResultadoCalculoFcpDifalFinal.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TResultadoCalculoFcpDifalFinal.PercentualProvisorioPartilha: Double;
begin
  Result := FPercentualProvisorioPartilha;
end;

function TResultadoCalculoFcpDifalFinal.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

function TResultadoCalculoFcpDifalFinal.ValorCalculadoFCPSTConsignacao: Double;
begin
  Result := FValorCalculadoFCPSTConsignacao;
end;

function TResultadoCalculoFcpDifalFinal.ValorCalculadoFCPSTConsignacao(AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FValorCalculadoFCPSTConsignacao := AValue;
end;

function TResultadoCalculoFcpDifalFinal.ValorFCP(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FValorFCP := AValue;
end;

function TResultadoCalculoFcpDifalFinal.IcmsDestino: Double;
begin
  Result := FIcmsDestino;
end;

function TResultadoCalculoFcpDifalFinal.IcmsDestino(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FIcmsDestino := AValue;
end;

function TResultadoCalculoFcpDifalFinal.IcmsOrigem(
  AValue: Double): IResultadoCalculoFcpDifalFinal;
begin
  Result := Self;
  FIcmsOrigem := AValue;
end;

function TResultadoCalculoFcpDifalFinal.IcmsOrigem: Double;
begin
  Result := FIcmsOrigem;
end;

{ TResultadoServicosClasseFcpDifal }

class function TResultadoServicosClasseFcpDifal.New: IResultadoServicosClasseFcpDifal;
begin
  Result := Self.Create;
end;

function TResultadoServicosClasseFcpDifal.ParametrosCalculoFcp: IParametrosCalculoFCP;
begin
  Result := FParametrosCalculoFcp;
end;

function TResultadoServicosClasseFcpDifal.ParametrosCalculoDifal: IParametrosCalculoDifal;
begin
  Result := FParametrosCalculoDifal;
end;

function TResultadoServicosClasseFcpDifal.ParametrosCalculoDifal(
  AValue: IParametrosCalculoDifal): IResultadoServicosClasseFcpDifal;
begin
  Result := Self;
  FParametrosCalculoDifal := AValue;
end;

function TResultadoServicosClasseFcpDifal.ParametrosCalculoDifalFcp(
  AValue: IParametrosCalculoDifalFCP): IResultadoServicosClasseFcpDifal;
begin
  Result := Self;
  FParametrosCalculoDifalFcp := AValue;
end;

function TResultadoServicosClasseFcpDifal.ParametrosCalculoDifalFcp: IParametrosCalculoDifalFCP;
begin
  Result := FParametrosCalculoDifalFcp;
end;

function TResultadoServicosClasseFcpDifal.ParametrosCalculoFcp(
  AValue: IParametrosCalculoFCP): IResultadoServicosClasseFcpDifal;
begin
  Result := Self;
  FParametrosCalculoFcp := AValue;
end;

function TResultadoServicosClasseFcpDifal.ResultadoCalculoFcp: IResultadoCalculoFCP;
begin
  Result := FResultadoCalculoFcp;
end;

function TResultadoServicosClasseFcpDifal.ResultadoCalculoDifal: IResultadoCalculoDifal;
begin
  Result := FResultadoCalculoDifal;
end;

function TResultadoServicosClasseFcpDifal.ResultadoCalculoDifal(
  AValue: IResultadoCalculoDifal): IResultadoServicosClasseFcpDifal;
begin
  Result := Self;
  FResultadoCalculoDifal := AValue;
end;

function TResultadoServicosClasseFcpDifal.ResultadoCalculoDifalFcp(
  AValue: IResultadoCalculoDifalFCP): IResultadoServicosClasseFcpDifal;
begin
  Result := Self;
  FResultadoCalculoDifalFcp := AValue;
end;

function TResultadoServicosClasseFcpDifal.ResultadoCalculoDifalFcp: IResultadoCalculoDifalFCP;
begin
  Result := FResultadoCalculoDifalFcp;
end;

function TResultadoServicosClasseFcpDifal.ResultadoCalculoFcp(
  AValue: IResultadoCalculoFCP): IResultadoServicosClasseFcpDifal;
begin
  Result := Self;
  FResultadoCalculoFcp := AValue;
end;

function TResultadoServicosClasseFcpDifal.ResultadoCalculoFcpDifalFinal(
  AValue: IResultadoCalculoFcpDifalFinal): IResultadoServicosClasseFcpDifal;
begin
  Result := Self;
  FResultadoCalculoFcpDifalFinal := AValue;
end;

function TResultadoServicosClasseFcpDifal.ResultadoCalculoFcpDifalFinal: IResultadoCalculoFcpDifalFinal;
begin
  Result := FResultadoCalculoFcpDifalFinal;
end;

end.
