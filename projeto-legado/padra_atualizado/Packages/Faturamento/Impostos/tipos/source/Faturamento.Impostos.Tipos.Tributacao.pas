unit Faturamento.Impostos.Tipos.Tributacao;

interface

uses Faturamento.Impostos.Interfaces.Tributacao, Faturamento.Impostos.Interfaces.Model;

type
  TParametrosRegrasTributacao = class(TInterfacedObject, IParametrosRegrasTributacao)
  private
    FModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelProduto: IResultadoFaturamentoImpostosModelProduto;
    FModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
    FModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
    FDentroDoEstado: Boolean;
    FNotaDeImportacao: Boolean;
    FCodigoDaSituacaoTributaria: String;
    FAliquotaDeIcmsDoItem: Double;
    FEspecieDoDocumento: String;
    FUtilizaSat: Boolean;
    FCalcularSatEcf: Boolean;
    FDentroDoEstadoCFOP: Boolean;
    FAtividadeConstrutora: Boolean;
    FTipoOperacaoPedidoVenda: String;
    FAlqIcmEstEmpFaturamento: Double;
    FAlqIcmEstEmpSimples: Double;
    FValorDeIpiDoItem: Double;
    FDocumentoParaFornecedor: Boolean;
    FTotalGeralDoItem : Double;
    FImportacaoDiretaDoItem: String;
    FValorUnitarioDoItem: Double;
    FQuantidadeDoItem: Double;
    FTipoDaAbreviacaoFiscal: String;
    FTotalGeralDoItemST_Simulado: Double;
    FClienteComercializacao: Boolean;
    FExisteNaTabelaCEDEM: Boolean;
    FUtilizaDecretoReducaoRICMSdaAbreviacao: Boolean;
    FVendaDeProducao: Boolean;
  public
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

    function UtilizaSat: Boolean; overload;
    function UtilizaSat(AValue : Boolean): IParametrosRegrasTributacao; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue : Boolean): IParametrosRegrasTributacao; overload;

    function CalcularSatEcf: Boolean; overload;
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

    class function New(): IParametrosRegrasTributacao;
  end;

type
  TResultadoRegrasTributacaoIcmsSt = class(TInterfacedObject, IResultadoRegrasTributacaoIcmsSt)
  private
    FAliquotaDeIcms: Double;
    FPercentualDaBaseDeIcms: Double;
    FValorIVAEspecialClienteMTIcms: Double;
    FAliquotaDeIcmsAnterior: Double;
    FBaseDeCalculoDoIcmsAnterior: Double;
    FValorDoIcmsAnterior: Double;
    FPercentualDeReducaoDaBaseDeIcms: Double;
    FReducaoRICMPR : String;
    FAliquotaDaSubstituicaoTributaria: Double;
    FValorDoIva: Double;
    FValorDoIvaMatriz: Double;
    FValorDoIvaStMatriz: Double;
    FValorIVAEspecialClienteMTSt: Double;
    FValorIcmsEstado: Double;
    FPercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
    FBaseDaSubstituicaoTributariaSimulada: Double;
    FAliquotaDaSubstituicaoTributariaSimulada: Double;
    FValorDaSubstituicaoTributariaSimulada: Double;
    FCodigoDaSubstituicaoTributariaDoItem: String;
    FAtendeRegrasAtoDeclaratorioDF: Boolean;
    FAliquotaReduzidaDaSt: Double;
    FSTAtribuidaPorRegimeEspecial: Boolean;
  public
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

    Function ReducaoRICMPR : String; Overload;
    Function ReducaoRICMPR(AValue : String): IResultadoRegrasTributacaoIcmsSt; overload;

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

    class function New(): IResultadoRegrasTributacaoIcmsSt;
  end;

type
  TResultadoRegrasTributacao = class(TInterfacedObject, IResultadoRegrasTributacao)
  private
    FAliquotaDeIcms: Double;
    FPercentualDaBaseDeIcms: Double;
    FCodigoDaSubstituicaoTributaria: String;
    FValorIVAEspecialClienteMTIcms: Double;
    FAliquotaDeIcmsAnterior: Double;
    FBaseDeCalculoDoIcmsAnterior: Double;
    FValorDoIcmsAnterior: Double;
    FPercentualDeReducaoDaBaseDeIcms: Double;
    FReducaoRICMPR: String;
    FAliquotaDaSubstituicaoTributaria: Double;
    FAliquotaDeIcmsEfetivoDoItem: Double;
    FValorDoIva: Double;
    FValorDoIvaMatriz: Double;
    FValorDoIvaStMatriz: Double;
    FValorIVAEspecialClienteMTSt: Double;
    FValorIcmsEstado: Double;
    FPercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
    FBaseDaSubstituicaoTributariaSimulada: Double;
    FAliquotaDaSubstituicaoTributariaSimulada: Double;
    FValorDaSubstituicaoTributariaSimulada: Double;
    FAtendeRegrasAtoDeclaratorioDF: Boolean;
    FAliquotaReduzidaDaSt: Double;
    FSTAtribuidaPorRegimeEspecial: Boolean;
  public
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
    function ReducaoRICMPR(AValue : String):IResultadoRegrasTributacao; overload;

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

    class function New(): IResultadoRegrasTributacao;
  end;

implementation



{ TResultadoRegrasTributacao }

function TResultadoRegrasTributacao.AliquotaDeIcms: Double;
begin
  Result := FAliquotaDeIcms;
end;

function TResultadoRegrasTributacao.AliquotaDaSubstituicaoTributaria: Double;
begin
  Result := FAliquotaDaSubstituicaoTributaria;
end;

function TResultadoRegrasTributacao.AliquotaDaSubstituicaoTributaria(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributaria := AValue;
end;

function TResultadoRegrasTributacao.AliquotaDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoRegrasTributacao.AliquotaDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaSimulada;
end;

function TResultadoRegrasTributacao.AliquotaDeIcms(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FAliquotaDeIcms := AValue;
end;

function TResultadoRegrasTributacao.AliquotaDeIcmsAnterior: Double;
begin
  Result := FAliquotaDeIcmsAnterior;
end;

function TResultadoRegrasTributacao.AliquotaDeIcmsAnterior(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FAliquotaDeIcmsAnterior := AValue;
end;

function TResultadoRegrasTributacao.AliquotaDeIcmsEfetivoDoItem(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FAliquotaDeIcmsEfetivoDoItem := AValue;
end;

function TResultadoRegrasTributacao.AliquotaReduzidaDaSt: Double;
begin
  Result := FAliquotaReduzidaDaSt;
end;

function TResultadoRegrasTributacao.AliquotaReduzidaDaSt(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FAliquotaReduzidaDaSt := AValue;
end;

function TResultadoRegrasTributacao.AtendeRegrasAtoDeclaratorioDF: Boolean;
begin
  Result := FAtendeRegrasAtoDeclaratorioDF;
end;

function TResultadoRegrasTributacao.AtendeRegrasAtoDeclaratorioDF(
  AValue: Boolean): IResultadoRegrasTributacao;
begin
  Result := Self;
  FAtendeRegrasAtoDeclaratorioDF := AValue;
end;

function TResultadoRegrasTributacao.AliquotaDeIcmsEfetivoDoItem: Double;
begin
  Result := FAliquotaDeIcmsEfetivoDoItem;
end;

function TResultadoRegrasTributacao.BaseDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FBaseDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoRegrasTributacao.BaseDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FBaseDaSubstituicaoTributariaSimulada;
end;

function TResultadoRegrasTributacao.BaseDeCalculoDoIcmsAnterior(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsAnterior := AValue;
end;

function TResultadoRegrasTributacao.BaseDeCalculoDoIcmsAnterior: Double;
begin
  Result := FBaseDeCalculoDoIcmsAnterior;
end;

function TResultadoRegrasTributacao.CodigoDaSubstituicaoTributaria: String;
begin
  Result := FCodigoDaSubstituicaoTributaria;
end;

function TResultadoRegrasTributacao.CodigoDaSubstituicaoTributaria(
  AValue: String): IResultadoRegrasTributacao;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributaria := AValue;
end;

class function TResultadoRegrasTributacao.New: IResultadoRegrasTributacao;
begin
  Result := Self.Create;
end;

function TResultadoRegrasTributacao.PercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FPercentualDaBaseDaSubstituicaoTributariaDoItem;
end;

function TResultadoRegrasTributacao.PercentualDaBaseDaSubstituicaoTributariaDoItem(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := AValue;
end;

function TResultadoRegrasTributacao.PercentualDaBaseDeIcms(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FPercentualDaBaseDeIcms := AValue;
end;

function TResultadoRegrasTributacao.PercentualDeReducaoDaBaseDeIcms: Double;
begin
  Result := FPercentualDeReducaoDaBaseDeIcms;
end;

function TResultadoRegrasTributacao.PercentualDeReducaoDaBaseDeIcms(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FPercentualDeReducaoDaBaseDeIcms := AValue;
end;

function TResultadoRegrasTributacao.ReducaoRICMPR: String;
begin
  Result := FReducaoRICMPR;
end;

function TResultadoRegrasTributacao.ReducaoRICMPR(
  AValue: String): IResultadoRegrasTributacao;
begin
  Result := Self;
  FReducaoRICMPR := AValue;
end;

function TResultadoRegrasTributacao.STAtribuidaPorRegimeEspecial: Boolean;
begin
  Result := FSTAtribuidaPorRegimeEspecial;
end;

function TResultadoRegrasTributacao.STAtribuidaPorRegimeEspecial(
  AValue: Boolean): IResultadoRegrasTributacao;
begin
  Result := Self;
  FSTAtribuidaPorRegimeEspecial := AValue;
end;

function TResultadoRegrasTributacao.ValorIVAEspecialClienteMTIcms: Double;
begin
  Result := FValorIVAEspecialClienteMTIcms;
end;

function TResultadoRegrasTributacao.ValorDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FValorDaSubstituicaoTributariaSimulada;
end;

function TResultadoRegrasTributacao.ValorDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoRegrasTributacao.ValorDoIcmsAnterior(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FValorDoIcmsAnterior := AValue;
end;

function TResultadoRegrasTributacao.ValorDoIva(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FValorDoIva := AValue;
end;

function TResultadoRegrasTributacao.ValorDoIva: Double;
begin
  Result := FValorDoIva;
end;

function TResultadoRegrasTributacao.ValorDoIvaMatriz: Double;
begin
  Result := FValorDoIvaMatriz;
end;

function TResultadoRegrasTributacao.ValorDoIvaMatriz(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FValorDoIvaMatriz := AValue;
end;

function TResultadoRegrasTributacao.ValorDoIvaStMatriz: Double;
begin
  Result := FValorDoIvaStMatriz;
end;

function TResultadoRegrasTributacao.ValorDoIvaStMatriz(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FValorDoIvaStMatriz := AValue;
end;

function TResultadoRegrasTributacao.ValorDoIcmsAnterior: Double;
begin
  Result := FValorDoIcmsAnterior;
end;

function TResultadoRegrasTributacao.ValorIcmsEstado: Double;
begin
  Result := FValorIcmsEstado;
end;

function TResultadoRegrasTributacao.ValorIcmsEstado(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FValorIcmsEstado := AValue;
end;

function TResultadoRegrasTributacao.ValorIVAEspecialClienteMTIcms(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FValorIVAEspecialClienteMTIcms := AValue;
end;

function TResultadoRegrasTributacao.ValorIVAEspecialClienteMTSt(
  AValue: Double): IResultadoRegrasTributacao;
begin
  Result := Self;
  FValorIVAEspecialClienteMTSt := AValue;
end;

function TResultadoRegrasTributacao.ValorIVAEspecialClienteMTSt: Double;
begin
  Result := FValorIVAEspecialClienteMTSt;
end;

function TResultadoRegrasTributacao.PercentualDaBaseDeIcms: Double;
begin
  Result := FPercentualDaBaseDeIcms;
end;

{ TParametrosRegrasTributacao }

function TParametrosRegrasTributacao.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosRegrasTributacao.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosRegrasTributacao;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosRegrasTributacao.AlqIcmEstEmpFaturamento: Double;
begin
  Result := FAlqIcmEstEmpFaturamento;
end;

function TParametrosRegrasTributacao.AlqIcmEstEmpFaturamento(
  AValue: Double): IParametrosRegrasTributacao;
begin
  Result := Self;
  FAlqIcmEstEmpFaturamento := AValue;
end;

function TParametrosRegrasTributacao.AlqIcmEstEmpSimples: Double;
begin
  Result := FAlqIcmEstEmpSimples;
end;

function TParametrosRegrasTributacao.AlqIcmEstEmpSimples(
  AValue: Double): IParametrosRegrasTributacao;
begin
  Result := Self;
  FAlqIcmEstEmpSimples := AValue;
end;

function TParametrosRegrasTributacao.AtividadeConstrutora: Boolean;
begin
  Result := FAtividadeConstrutora;
end;

function TParametrosRegrasTributacao.AtividadeConstrutora(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FAtividadeConstrutora := AValue;
end;

function TParametrosRegrasTributacao.CalcularSatEcf: Boolean;
begin
  Result := FCalcularSatEcf;
end;

function TParametrosRegrasTributacao.CalcularSatEcf(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FCalcularSatEcf := AValue;
end;

function TParametrosRegrasTributacao.ClienteComercializacao: Boolean;
begin
  Result := FClienteComercializacao;
end;

function TParametrosRegrasTributacao.ExisteNaTabelaCEDEM: Boolean;
begin
  Result := FExisteNaTabelaCEDEM;
end;

function TParametrosRegrasTributacao.ExisteNaTabelaCEDEM(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FExisteNaTabelaCEDEM := AValue;
end;

function TParametrosRegrasTributacao.ClienteComercializacao(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FClienteComercializacao := AValue;
end;

function TParametrosRegrasTributacao.CodigoDaSituacaoTributaria(
  AValue: String): IParametrosRegrasTributacao;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TParametrosRegrasTributacao.CodigoDaSituacaoTributaria: String;
begin
  Result := FCodigoDaSituacaoTributaria;
end;

function TParametrosRegrasTributacao.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

function TParametrosRegrasTributacao.DentroDoEstado(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosRegrasTributacao.DentroDoEstadoCFOP: Boolean;
begin
  Result := FDentroDoEstadoCFOP;
end;

function TParametrosRegrasTributacao.DentroDoEstadoCFOP(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FDentroDoEstadoCFOP := AValue;
end;

function TParametrosRegrasTributacao.DocumentoParaFornecedor: Boolean;
begin
  Result := FDocumentoParaFornecedor;
end;

function TParametrosRegrasTributacao.DocumentoParaFornecedor(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FDocumentoParaFornecedor := AValue;
end;

function TParametrosRegrasTributacao.EspecieDoDocumento(
  AValue: String): IParametrosRegrasTributacao;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosRegrasTributacao.ImportacaoDiretaDoItem: String;
begin
  Result := FImportacaoDiretaDoItem;
end;

function TParametrosRegrasTributacao.ImportacaoDiretaDoItem(
  AValue: String): IParametrosRegrasTributacao;
begin
  Result := Self;
  FImportacaoDiretaDoItem := AValue;
end;

function TParametrosRegrasTributacao.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosRegrasTributacao.ModelAbreviacaoIcms(
  AValue: IResultadoFaturamentoImpostosModelAbreviacaoIcms): IParametrosRegrasTributacao;
begin
  Result := Self;
  FModelAbreviacaoIcms := AValue;
end;

function TParametrosRegrasTributacao.ModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := FModelAbreviacaoIcms;
end;

function TParametrosRegrasTributacao.ModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := FModelClienteFornecedor;
end;

function TParametrosRegrasTributacao.ModelClienteFornecedor(
  AValue: IResultadoFaturamentoImpostosModelClienteFornecedor): IParametrosRegrasTributacao;
begin
  Result := Self;
  FModelClienteFornecedor := AValue;
end;

function TParametrosRegrasTributacao.ModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := FModelEmpresa;
end;

function TParametrosRegrasTributacao.ModelEmpresa(
  AValue: IResultadoFaturamentoImpostosModelEmpresa): IParametrosRegrasTributacao;
begin
  Result := Self;
  FModelEmpresa := AValue;
end;

function TParametrosRegrasTributacao.ModelProduto(
  AValue: IResultadoFaturamentoImpostosModelProduto): IParametrosRegrasTributacao;
begin
  Result := Self;
  FModelProduto := AValue;
end;

function TParametrosRegrasTributacao.ModelProduto: IResultadoFaturamentoImpostosModelProduto;
begin
  Result := FModelProduto;
end;

class function TParametrosRegrasTributacao.New: IParametrosRegrasTributacao;
begin
  Result := Self.Create;
end;

function TParametrosRegrasTributacao.NotaDeImportacao(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FNotaDeImportacao := AValue;
end;

function TParametrosRegrasTributacao.QuantidadeDoItem(
  AValue: Double): IParametrosRegrasTributacao;
begin
  Result := Self;
  FQuantidadeDoItem := AValue;
end;

function TParametrosRegrasTributacao.QuantidadeDoItem: Double;
begin
  Result := FQuantidadeDoItem;
end;

function TParametrosRegrasTributacao.TipoOperacaoPedidoVenda: String;
begin
  Result := FTipoOperacaoPedidoVenda;
end;

function TParametrosRegrasTributacao.TipoDaAbreviacaoFiscal: String;
begin
  Result := FTipoDaAbreviacaoFiscal;
end;

function TParametrosRegrasTributacao.TipoDaAbreviacaoFiscal(
  AValue: String): IParametrosRegrasTributacao;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

function TParametrosRegrasTributacao.TipoOperacaoPedidoVenda(
  AValue: String): IParametrosRegrasTributacao;
begin
  Result := Self;
  FTipoOperacaoPedidoVenda := AValue;
end;

function TParametrosRegrasTributacao.TotalGeralDoItem(
  AValue: Double): IParametrosRegrasTributacao;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosRegrasTributacao.TotalGeralDoItemST_Simulado: Double;
begin
  Result := FTotalGeralDoItemST_Simulado;
end;

function TParametrosRegrasTributacao.TotalGeralDoItemST_Simulado(
  AValue: Double): IParametrosRegrasTributacao;
begin
  Result := Self;
  FTotalGeralDoItemST_Simulado := AValue;
end;

function TParametrosRegrasTributacao.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

function TParametrosRegrasTributacao.UtilizaSat: Boolean;
begin
  Result := FUtilizaSat;
end;

function TParametrosRegrasTributacao.UtilizaDecretoReducaoRICMSdaAbreviacao: Boolean;
begin
  Result := FUtilizaDecretoReducaoRICMSdaAbreviacao;
end;

function TParametrosRegrasTributacao.UtilizaDecretoReducaoRICMSdaAbreviacao(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FUtilizaDecretoReducaoRICMSdaAbreviacao := AValue;
end;

function TParametrosRegrasTributacao.VendaDeProducao: Boolean;
begin
  Result := FVendaDeProducao;
end;

function TParametrosRegrasTributacao.VendaDeProducao(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FVendaDeProducao := AValue;
end;

function TParametrosRegrasTributacao.UtilizaSat(
  AValue: Boolean): IParametrosRegrasTributacao;
begin
  Result := Self;
  FUtilizaSat := AValue;
end;

function TParametrosRegrasTributacao.ValorDeIpiDoItem: Double;
begin
  Result := FValorDeIpiDoItem;
end;

function TParametrosRegrasTributacao.ValorDeIpiDoItem(
  AValue: Double): IParametrosRegrasTributacao;
begin
  Result := Self;
  FValorDeIpiDoItem := AValue;
end;

function TParametrosRegrasTributacao.ValorUnitarioDoItem(
  AValue: Double): IParametrosRegrasTributacao;
begin
  Result := Self;
  FValorUnitarioDoItem := AValue;
end;

function TParametrosRegrasTributacao.ValorUnitarioDoItem: Double;
begin
  Result := FValorUnitarioDoItem;
end;

function TParametrosRegrasTributacao.NotaDeImportacao: Boolean;
begin
  Result := FNotaDeImportacao;
end;

{ TResultadoRegrasTributacaoIcms }

function TResultadoRegrasTributacaoIcmsSt.AliquotaDaSubstituicaoTributaria: Double;
begin
  Result := FAliquotaDaSubstituicaoTributaria;
end;

function TResultadoRegrasTributacaoIcmsSt.AliquotaDaSubstituicaoTributaria(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributaria := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.AliquotaDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.AliquotaDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaSimulada;
end;

function TResultadoRegrasTributacaoIcmsSt.AliquotaDeIcms(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FAliquotaDeIcms := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.AliquotaDeIcmsAnterior: Double;
begin
  Result := FAliquotaDeIcmsAnterior;
end;

function TResultadoRegrasTributacaoIcmsSt.AliquotaDeIcmsAnterior(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FAliquotaDeIcmsAnterior := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.AliquotaReduzidaDaSt: Double;
begin
  Result := FAliquotaReduzidaDaSt;
end;

function TResultadoRegrasTributacaoIcmsSt.AliquotaReduzidaDaSt(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FAliquotaReduzidaDaSt := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.AtendeRegrasAtoDeclaratorioDF: Boolean;
begin
  Result := FAtendeRegrasAtoDeclaratorioDF;
end;

function TResultadoRegrasTributacaoIcmsSt.AtendeRegrasAtoDeclaratorioDF(
  AValue: Boolean): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FAtendeRegrasAtoDeclaratorioDF := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.BaseDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FBaseDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.BaseDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FBaseDaSubstituicaoTributariaSimulada;
end;

function TResultadoRegrasTributacaoIcmsSt.BaseDeCalculoDoIcmsAnterior(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsAnterior := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TResultadoRegrasTributacaoIcmsSt.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.BaseDeCalculoDoIcmsAnterior: Double;
begin
  Result := FBaseDeCalculoDoIcmsAnterior;
end;

function TResultadoRegrasTributacaoIcmsSt.AliquotaDeIcms: Double;
begin
  Result := FAliquotaDeIcms;
end;

class function TResultadoRegrasTributacaoIcmsSt.New: IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self.Create;
end;

function TResultadoRegrasTributacaoIcmsSt.PercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FPercentualDaBaseDaSubstituicaoTributariaDoItem;
end;

function TResultadoRegrasTributacaoIcmsSt.PercentualDaBaseDaSubstituicaoTributariaDoItem(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.PercentualDaBaseDeIcms(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FPercentualDaBaseDeIcms := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.PercentualDeReducaoDaBaseDeIcms: Double;
begin
  Result := FPercentualDeReducaoDaBaseDeIcms;
end;

function TResultadoRegrasTributacaoIcmsSt.PercentualDeReducaoDaBaseDeIcms(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FPercentualDeReducaoDaBaseDeIcms := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ReducaoRICMPR: String;
begin
  Result := FReducaoRICMPR;
end;

function TResultadoRegrasTributacaoIcmsSt.ReducaoRICMPR(
  AValue: String): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FReducaoRICMPR := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.STAtribuidaPorRegimeEspecial: Boolean;
begin
  Result := FSTAtribuidaPorRegimeEspecial;
end;

function TResultadoRegrasTributacaoIcmsSt.STAtribuidaPorRegimeEspecial(
  AValue: Boolean): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FSTAtribuidaPorRegimeEspecial := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorIVAEspecialClienteMTIcms: Double;
begin
  Result := FValorIVAEspecialClienteMTIcms;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FValorDaSubstituicaoTributariaSimulada;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDoIcmsAnterior(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FValorDoIcmsAnterior := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDoIva(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FValorDoIva := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDoIva: Double;
begin
  Result := FValorDoIva;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDoIvaMatriz: Double;
begin
  Result := FValorDoIvaMatriz;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDoIvaMatriz(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FValorDoIvaMatriz := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDoIvaStMatriz: Double;
begin
  Result := FValorDoIvaStMatriz;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDoIvaStMatriz(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FValorDoIvaStMatriz := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorDoIcmsAnterior: Double;
begin
  Result := FValorDoIcmsAnterior;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorIcmsEstado: Double;
begin
  Result := FValorIcmsEstado;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorIcmsEstado(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FValorIcmsEstado := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorIVAEspecialClienteMTIcms(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FValorIVAEspecialClienteMTIcms := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorIVAEspecialClienteMTSt(
  AValue: Double): IResultadoRegrasTributacaoIcmsSt;
begin
  Result := Self;
  FValorIVAEspecialClienteMTSt := AValue;
end;

function TResultadoRegrasTributacaoIcmsSt.ValorIVAEspecialClienteMTSt: Double;
begin
  Result := FValorIVAEspecialClienteMTSt;
end;

function TResultadoRegrasTributacaoIcmsSt.PercentualDaBaseDeIcms: Double;
begin
  Result := FPercentualDaBaseDeIcms;
end;

end.
