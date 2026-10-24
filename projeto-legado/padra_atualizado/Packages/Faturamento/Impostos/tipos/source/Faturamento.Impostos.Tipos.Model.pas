unit Faturamento.Impostos.Tipos.Model;

interface

uses Faturamento.Impostos.Interfaces.Model, Shared.Functions.Types;

  //Model novo com fcampotabelaarray
type
  TResultadoFaturamentoImpostosModelClienteFornecedor = class(TInterfacedObject, IResultadoFaturamentoImpostosModelClienteFornecedor)
  private
    FCodigo: String;
    FSituacaoDoIpi: String;
    FZonaFranca: Boolean;
    FOrgaoPublico: Boolean;
    FClienteExterior: Boolean;
    FClienteEstado: String;
    FClienteEstadoEntrega: String;
    FClienteAtividade: String;
    FClienteRegraFiscal: String;
    FSomarIpiBaseIcms : Boolean;
    FClienteInscricaoEstadual: String;
    FClienteMicroEmpreendedor : Boolean;
    FValorIVAEspecialClienteMT : Double;
    FValorIVASimClienteMT : Double;
    FCalcularDescontoIcmsOrgaoPublico : Boolean;
    FSujeitoPassivoSTRegimeEspecial: Boolean;
    FReducaoDeBaseDeIcmsTributados: Double;
    FUtilizarDiferimetoST: Boolean;
    FTipoDeDescontoRateioDescEspecial: String;
    FValorIVANacClienteMT: Double;
    FAplicarDescontoPisCofinsOrgaoPublico: Boolean;
    FBeneficioREIDI: Boolean;
    FDeduzirIcmsDoBeneficioREIDI: Boolean;
    FValorAliquotaIRF: Double;
    FValorAliquotaPIS: Double;
    FValorAliquotaCOF: Double;
    FValorAliquotaCSL: Double;
    FRetencaoDeIRPF: String;
    FRetencaoDePisCofins: String;
    FClienteC_G_C_: String;
    FClienteFisJur: String;
    FConsumidorFinal: Boolean;
    FClienteProdutorRural: String;
    FClienteNaoContribuinteDeIcms: String;
    FClienteOrgaoPublicoDifal: Boolean;
    FValorIVAEspecialClienteMTCedem: Double;
    FValorIVASimClienteMTCedem: Double;
    FValorIVANacClienteMTCedem: Double;
    FCodigoDaEmpresaTransferencia: String;
    FAtoDeclaratorioDF: Boolean;
    FClienteZonaFrancaComDescontoEspecial: Boolean;
    FClienteReducaoCargaLiquida: Boolean;
    FFornecedorSimples: Boolean;
    FSuframa: String;
    FClienteIbgeEntrega: String;
    FOrgaoPublicoForaDoEstado: Boolean;
  public
    function Codigo: String; overload;
    function Codigo(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function SituacaoDoIpi: String; overload;
    function SituacaoDoIpi(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ZonaFranca: Boolean; overload;
    function ZonaFranca(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function OrgaoPublico: Boolean; overload;
    function OrgaoPublico(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteExterior: Boolean; overload;
    function ClienteExterior(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteEstadoEntrega: String; overload;
    function ClienteEstadoEntrega(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteAtividade: String;overload;
    function ClienteAtividade(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteC_G_C_: String;overload;
    function ClienteC_G_C_(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteRegraFiscal: String;overload;
    function ClienteRegraFiscal(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function SomarIpiBaseIcms: Boolean; overload;
    function SomarIpiBaseIcms(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteInscricaoEstadual: String;overload;
    function ClienteInscricaoEstadual(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteMicroEmpreendedor: Boolean; overload;
    function ClienteMicroEmpreendedor(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorIVAEspecialClienteMT : Double; overload;
    function ValorIVAEspecialClienteMT(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorIVASimClienteMT : Double; overload;
    function ValorIVASimClienteMT(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function SujeitoPassivoSTRegimeEspecial: Boolean; overload;
    function SujeitoPassivoSTRegimeEspecial(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ReducaoDeBaseDeIcmsTributados: Double; overload;
    function ReducaoDeBaseDeIcmsTributados(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function UtilizarDiferimetoST: Boolean; overload;
    function UtilizarDiferimetoST(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function TipoDeDescontoRateioDescEspecial: String; overload;
    function TipoDeDescontoRateioDescEspecial(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorIVANacClienteMT: Double; overload;
    function ValorIVANacClienteMT(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function AplicarDescontoPisCofinsOrgaoPublico: Boolean; overload;
    function AplicarDescontoPisCofinsOrgaoPublico(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function BeneficioREIDI: Boolean; overload;
    function BeneficioREIDI(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function DeduzirIcmsDoBeneficioREIDI: Boolean; overload;
    function DeduzirIcmsDoBeneficioREIDI(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorAliquotaIRF: Double;overload;
    function ValorAliquotaIRF(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorAliquotaPIS: Double;overload;
    function ValorAliquotaPIS(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorAliquotaCOF: Double;overload;
    function ValorAliquotaCOF(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorAliquotaCSL: Double;overload;
    function ValorAliquotaCSL(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function RetencaoDeIRPF: String;overload;
    function RetencaoDeIRPF(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function RetencaoDePisCofins: String;overload;
    function RetencaoDePisCofins(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteFisJur: String; overload;
    function ClienteFisJur(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ConsumidorFinal: Boolean; overload;
    function ConsumidorFinal(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;
    function ClienteProdutorRural: String; overload;
    function ClienteProdutorRural(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteNaoContribuinteDeIcms: String; overload;
    function ClienteNaoContribuinteDeIcms(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteOrgaoPublicoDifal: Boolean; overload;
    function ClienteOrgaoPublicoDifal(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorIVAEspecialClienteMTCedem: Double; overload;
    function ValorIVAEspecialClienteMTCedem(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorIVASimClienteMTCedem: Double; overload;
    function ValorIVASimClienteMTCedem(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorIVANacClienteMTCedem: Double; overload;
    function ValorIVANacClienteMTCedem(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function CodigoDaEmpresaTransferencia: String; overload;
    function CodigoDaEmpresaTransferencia(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function AtoDeclaratorioDF: Boolean; overload;
    function AtoDeclaratorioDF(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteZonaFrancaComDescontoEspecial: Boolean; overload;
    function ClienteZonaFrancaComDescontoEspecial(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteReducaoCargaLiquida: Boolean; overload;
    function ClienteReducaoCargaLiquida(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function FornecedorSimples: Boolean; overload;
    function FornecedorSimples(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function Suframa: String; overload;
    function Suframa(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteIbgeEntrega: String; overload;
    function ClienteIbgeEntrega(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function OrgaoPublicoForaDoEstado: Boolean; overload;
    function OrgaoPublicoForaDoEstado(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    class function New(): IResultadoFaturamentoImpostosModelClienteFornecedor;
  end;

type
  TResultadoFaturamentoImpostosModelProduto = class(TInterfacedObject, IResultadoFaturamentoImpostosModelProduto)
  private
    FIpiDeSaida  : Double;
    FItemConcreto: String;
    FCodigoDaAbreviacaoFiscal: String;
    FImportacaoDireta: String;
    FUtilizaAmpara: String;
    FCodigoDoFornecedor: String;
    FIpiDeEntrada: Double;
    FFreteDeEntrada: Double;
    FIndustrializacaoOuRevenda: TOpcIndustrializacaoOuRevenda;
    FCodigoDoFornecedorDaUltimaCompra: String;
    FTipoDoFornecedorDaUltimaCompra: String;
    FAtoDeclaratorioDF: Boolean;
  public
    function IpiDeSaida: Double; overload;
    function IpiDeSaida(AValue: Double): IResultadoFaturamentoImpostosModelProduto; overload;

    function ItemConcreto: String; overload;
    function ItemConcreto(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;

    function CodigoDaAbreviacaoFiscal: String; overload;
    function CodigoDaAbreviacaoFiscal(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;

    function ImportacaoDireta: String; overload;
    function ImportacaoDireta(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;

    function UtilizaAmpara: String; overload;
    function UtilizaAmpara(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;

    function CodigoDoFornecedor: String; overload;
    function CodigoDoFornecedor(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;

    function IpiDeEntrada: Double; overload;
    function IpiDeEntrada(AValue: Double): IResultadoFaturamentoImpostosModelProduto; overload;

    function FreteDeEntrada: Double; overload;
    function FreteDeEntrada(AValue: Double): IResultadoFaturamentoImpostosModelProduto; overload;

    function IndustrializacaoOuRevenda: TOpcIndustrializacaoOuRevenda; overload;
    function IndustrializacaoOuRevenda(AValue: TOpcIndustrializacaoOuRevenda): IResultadoFaturamentoImpostosModelProduto; overload;

    function CodigoDoFornecedorDaUltimaCompra: String; overload;
    function CodigoDoFornecedorDaUltimaCompra(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;

    function TipoDoFornecedorDaUltimaCompra: String; overload;
    function TipoDoFornecedorDaUltimaCompra(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;

    function AtoDeclaratorioDF: Boolean; overload;
    function AtoDeclaratorioDF(AValue: Boolean): IResultadoFaturamentoImpostosModelProduto; overload;

    class function New(): IResultadoFaturamentoImpostosModelProduto;
  end;

type
  TResultadoFaturamentoImpostosModelEmpresa = class(TInterfacedObject, IResultadoFaturamentoImpostosModelEmpresa)
  private
    FEmpresaEstado: String;
    FEmpresaIbge: String;
  public
    function EmpresaEstado: String; overload;
    function EmpresaEstado(AValue: String): IResultadoFaturamentoImpostosModelEmpresa; overload;

    function EmpresaIbge: String; overload;
    function EmpresaIbge(AValue: String): IResultadoFaturamentoImpostosModelEmpresa; overload;

    class function New(): IResultadoFaturamentoImpostosModelEmpresa;
  end;


  //Abreviacao Icms
type
  TParametrosFaturamentoImpostosModelAbreviacaoIcms = class(TInterfacedObject, IParametrosFaturamentoImpostosModelAbreviacaoIcms)
  private
    FCodigoDoItem: String;
    FCodigoDaAbreviacaoFiscal: String;
    FEstado: String;
    FCodigoDaEmpresaTE: String;
    FCodigoDaEmpresa: String;
    FTipoDaAbreviacaoFiscal: String;
    FCodigoDaEmpresaAbf: String;
    FCalculandoPrecoDeVendaComDifal: Boolean;
  public
    function CodigoDoItem: String; overload;
    function CodigoDoItem(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CodigoDaAbreviacaoFiscal: String; overload;
    function CodigoDaAbreviacaoFiscal(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms; overload;

    function Estado: String; overload;
    function Estado(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CodigoDaEmpresaTE: String; overload;
    function CodigoDaEmpresaTE(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CodigoDaEmpresaAbf: String; overload;
    function CodigoDaEmpresaAbf(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CalculandoPrecoDeVendaComDifal: Boolean; overload;
    function CalculandoPrecoDeVendaComDifal(AValue: Boolean): IParametrosFaturamentoImpostosModelAbreviacaoIcms; overload;

    class function New(): IParametrosFaturamentoImpostosModelAbreviacaoIcms;
  end;

type
  TResultadoFaturamentoImpostosModelAbreviacaoIcms = class(TInterfacedObject, IResultadoFaturamentoImpostosModelAbreviacaoIcms)
  private
    FAliquotaDeIcms: Double;
    FPercentualDaBaseDeIcms: Double;
    FCodigoDaSituacaoTributaria: String;
    FAliquotaDeSt: Double;
    FPercentualDeIva: Double;
    FPercentualDaBaseDeSt: Double;
    FCalcularSTSaiCCO: String;
    FCalcularSTSaiPRU: String;
    FCodigoDaAbreviacaoFiscal: String;
    FAliquotaDeFcp: Double;
    FAliquotaInternaEstadoDestino: Double;
    FPercentualBaseDifalOrigem: Double;
    FPercentualBaseDifalDestino: Double;
    FAliquotaEfetivaOrigem: Double;
    FRegistroExiste: Boolean;
    FDecretoReducaoRICMPR: Boolean;
    FAliquotaDiferenciadaRICMPR: Double;
    FAliquotaReduzidaDeSt: Double;
  public
    function AliquotaDeIcms: Double; overload;
    function AliquotaDeIcms(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function AliquotaDeSt: Double; overload;
    function AliquotaDeSt(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function PercentualDeIva: Double; overload;
    function PercentualDeIva(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function PercentualDaBaseDeSt: Double; overload;
    function PercentualDaBaseDeSt(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CalcularSTSaiCCO: String; overload;
    function CalcularSTSaiCCO(AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CodigoDaAbreviacaoFiscal: String; overload;
    function CodigoDaAbreviacaoFiscal(AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function AliquotaDeFcp: Double; overload;
    function AliquotaDeFcp(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function AliquotaInternaEstadoDestino: Double; overload;
    function AliquotaInternaEstadoDestino(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function PercentualBaseDifalOrigem: Double; overload;
    function PercentualBaseDifalOrigem(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function PercentualBaseDifalDestino: Double; overload;
    function PercentualBaseDifalDestino(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function AliquotaEfetivaOrigem: Double; overload;
    function AliquotaEfetivaOrigem(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function RegistroExiste: Boolean; overload;
    function RegistroExiste(AValue: Boolean): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function DecretoReducaoRICMPR: Boolean; overload;
    function DecretoReducaoRICMPR(AValue: Boolean): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function AliquotaDiferenciadaRICMPR: Double; overload;
    function AliquotaDiferenciadaRICMPR(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function AliquotaReduzidaDeSt: Double; overload;
    function AliquotaReduzidaDeSt(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CalcularSTSaiPRU: String; overload;
    function CalcularSTSaiPRU(AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    class function New(): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
  end;

type
  //Abreviacao Icms fornecedor
  TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor = class(TInterfacedObject, IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor)
  private
    FCodigoDaAbreviacaoFiscal: String;
    FEstado: String;
    FTipoDaAbreviacaoFiscal: String;
  public
    function CodigoDaAbreviacaoFiscal: String; overload;
    function CodigoDaAbreviacaoFiscal(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    function Estado: String; overload;
    function Estado(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    class function New(): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
  end;

type
  TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor = class(TInterfacedObject, IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor)
  private
    FPercentualDeIvaFornecedor: Double;
    FAliquotaFatorNegativo: Double;
    FAliquotaOperacoesProprias: Double;
    FPercentualDaBaseDeIcmsFornecedor: Double;
    FPercentualDaBaseDeStFornecedor: Double;
  public
    function PercentualDeIvaFornecedor: Double; overload;
    function PercentualDeIvaFornecedor(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    function AliquotaFatorNegativo: Double; overload;
    function AliquotaFatorNegativo(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    function AliquotaOperacoesProprias: Double; overload;
    function AliquotaOperacoesProprias(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    function PercentualDaBaseDeIcmsFornecedor: Double; overload;
    function PercentualDaBaseDeIcmsFornecedor(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    function PercentualDaBaseDeStFornecedor: Double; overload;
    function PercentualDaBaseDeStFornecedor(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    class function New(): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
  end;


type
  TParametrosFaturamentoImpostosClienteConsumidor = class(TInterfacedObject, IParametrosFaturamentoImpostosClienteConsumidor)
  private
    FClienteEstado                    : String;
    FClienteInscricaoEstadual         : String;
    FClienteFisicoOuJuridico          : String;
    FClienteAtividade                 : String;
    FCalcularDescontoIcmsOrgaoPublico : Boolean;
    FCodigoDaEmpresaTransferencia     : String;
  public
    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function ClienteInscricaoEstadual: String; overload;
    function ClienteInscricaoEstadual(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function ClienteFisicoOuJuridico: String; overload;
    function ClienteFisicoOuJuridico(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function ClienteAtividade: String; overload;
    function ClienteAtividade(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function CalcularDescontoIcmsOrgaoPublico : Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue : Boolean): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function CodigoDaEmpresaTransferencia: String; overload;
    function CodigoDaEmpresaTransferencia(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    class function New(): IParametrosFaturamentoImpostosClienteConsumidor;
  End;


implementation

{ TResultadoFaturamentoImpostosModelClienteFornecedor }

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteAtividade: String;
begin
  Result := FClienteAtividade;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.CalcularDescontoIcmsOrgaoPublico: Boolean;
begin
  Result := FCalcularDescontoIcmsOrgaoPublico;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.AplicarDescontoPisCofinsOrgaoPublico: Boolean;
begin
  Result := FAplicarDescontoPisCofinsOrgaoPublico;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.AplicarDescontoPisCofinsOrgaoPublico(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FAplicarDescontoPisCofinsOrgaoPublico := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.AtoDeclaratorioDF: Boolean;
begin
  Result := FAtoDeclaratorioDF;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.AtoDeclaratorioDF(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FAtoDeclaratorioDF := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.BeneficioREIDI: Boolean;
begin
  Result := FBeneficioREIDI;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.BeneficioREIDI(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FBeneficioREIDI := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.CalcularDescontoIcmsOrgaoPublico(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FCalcularDescontoIcmsOrgaoPublico := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteAtividade(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteAtividade := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteC_G_C_: String;
begin
  Result := FClienteC_G_C_;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteC_G_C_(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteC_G_C_ := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteEstado(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteEstadoEntrega: String;
begin
  Result := FClienteEstadoEntrega;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteEstadoEntrega(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteEstadoEntrega := AValue;
end;


function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteExterior(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteExterior := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteFisJur: String;
begin
  Result := FClienteFisJur;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteFisJur(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteFisJur := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.CodigoDaEmpresaTransferencia: String;
begin
  Result := FCodigoDaEmpresaTransferencia;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.CodigoDaEmpresaTransferencia(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FCodigoDaEmpresaTransferencia := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteInscricaoEstadual: String;
begin
  Result := FClienteInscricaoEstadual;
end;


function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteRegraFiscal: String;
begin
  Result := FClienteRegraFiscal;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteReducaoCargaLiquida: Boolean;
begin
  Result := FClienteReducaoCargaLiquida;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteReducaoCargaLiquida(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteReducaoCargaLiquida := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.FornecedorSimples: Boolean;
begin
  Result := FFornecedorSimples;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.FornecedorSimples(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FFornecedorSimples := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteRegraFiscal(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteRegraFiscal := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ConsumidorFinal: Boolean;
begin
  Result := FConsumidorFinal;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.Codigo: String;
begin
  Result := FCodigo;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.Codigo(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FCodigo := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ConsumidorFinal(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FConsumidorFinal := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.DeduzirIcmsDoBeneficioREIDI: Boolean;
begin
  Result := FDeduzirIcmsDoBeneficioREIDI;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.DeduzirIcmsDoBeneficioREIDI(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FDeduzirIcmsDoBeneficioREIDI := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteIbgeEntrega: String;
begin
  Result := FClienteIbgeEntrega;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteIbgeEntrega(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteIbgeEntrega := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.OrgaoPublicoForaDoEstado: Boolean;
begin
  Result := FOrgaoPublicoForaDoEstado;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.OrgaoPublicoForaDoEstado(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FOrgaoPublicoForaDoEstado := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteInscricaoEstadual(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteInscricaoEstadual := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteMicroEmpreendedor: Boolean;
begin
  Result := FClienteMicroEmpreendedor;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteMicroEmpreendedor(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteMicroEmpreendedor := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteNaoContribuinteDeIcms: String;
begin
  Result := FClienteNaoContribuinteDeIcms;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteNaoContribuinteDeIcms(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteNaoContribuinteDeIcms := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteOrgaoPublicoDifal: Boolean;
begin
  Result := FClienteOrgaoPublicoDifal;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteOrgaoPublicoDifal(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteOrgaoPublicoDifal := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteProdutorRural: String;
begin
  Result := FClienteProdutorRural;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteProdutorRural(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteProdutorRural := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteExterior: Boolean;
begin
  Result := FClienteExterior;
end;

class function TResultadoFaturamentoImpostosModelClienteFornecedor.New: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self.Create;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.OrgaoPublico: Boolean;
begin
  Result := FOrgaoPublico;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.OrgaoPublico(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FOrgaoPublico := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados: Double;
begin
  Result := FReducaoDeBaseDeIcmsTributados;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ReducaoDeBaseDeIcmsTributados(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FReducaoDeBaseDeIcmsTributados := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.RetencaoDeIRPF: String;
begin
  Result := FRetencaoDeIRPF;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.RetencaoDeIRPF(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FRetencaoDeIRPF := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.RetencaoDePisCofins: String;
begin
  Result := FRetencaoDePisCofins;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.RetencaoDePisCofins(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FRetencaoDePisCofins := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.SituacaoDoIpi(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FSituacaoDoIpi := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.SomarIpiBaseIcms: Boolean;
begin
  Result := FSomarIpiBaseIcms;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.SomarIpiBaseIcms(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FSomarIpiBaseIcms := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.SujeitoPassivoSTRegimeEspecial: Boolean;
begin
  Result := FSujeitoPassivoSTRegimeEspecial;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.Suframa: String;
begin
  Result := FSuframa;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.Suframa(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FSuframa := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.SujeitoPassivoSTRegimeEspecial(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FSujeitoPassivoSTRegimeEspecial := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.TipoDeDescontoRateioDescEspecial: String;
begin
  Result := FTipoDeDescontoRateioDescEspecial;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.TipoDeDescontoRateioDescEspecial(
  AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FTipoDeDescontoRateioDescEspecial := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.UtilizarDiferimetoST: Boolean;
begin
  Result := FUtilizarDiferimetoST;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.UtilizarDiferimetoST(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FUtilizarDiferimetoST := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVAEspecialClienteMT: Double;
begin
  Result := FValorIVAEspecialClienteMT;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorAliquotaCOF(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorAliquotaCOF := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorAliquotaCOF: Double;
begin
  Result := FValorAliquotaCOF;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorAliquotaCSL: Double;
begin
  Result := FValorAliquotaCSL;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorAliquotaCSL(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorAliquotaCSL := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorAliquotaIRF: Double;
begin
  result := FValorAliquotaIRF;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorAliquotaIRF(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorAliquotaIRF := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorAliquotaPIS(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorAliquotaPIS := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorAliquotaPIS: Double;
begin
  Result := FValorAliquotaPIS;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVAEspecialClienteMT(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVAEspecialClienteMT := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVAEspecialClienteMTCedem: Double;
begin
  Result := FValorIVAEspecialClienteMTCedem;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVAEspecialClienteMTCedem(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVAEspecialClienteMTCedem := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVANacClienteMT: Double;
begin
  Result := FValorIVANacClienteMT;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVANacClienteMT(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVANacClienteMT := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVANacClienteMTCedem(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVANacClienteMTCedem := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVANacClienteMTCedem: Double;
begin
  Result := FValorIVANacClienteMTCedem;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVASimClienteMT: Double;
begin
  Result := FValorIVASimClienteMT;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVASimClienteMT(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVASimClienteMT := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVASimClienteMTCedem(
  AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FValorIVASimClienteMTCedem := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ValorIVASimClienteMTCedem: Double;
begin
  Result := FValorIVASimClienteMTCedem;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.SituacaoDoIpi: String;
begin
  Result := FSituacaoDoIpi;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ZonaFranca(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FZonaFranca := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ZonaFranca: Boolean;
begin
  Result := FZonaFranca;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteZonaFrancaComDescontoEspecial(
  AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Self;
  FClienteZonaFrancaComDescontoEspecial := AValue;
end;

function TResultadoFaturamentoImpostosModelClienteFornecedor.ClienteZonaFrancaComDescontoEspecial: Boolean;
begin
  Result := FClienteZonaFrancaComDescontoEspecial;
end;

{ TResultadoFaturamentoImpostosModelProduto }

function TResultadoFaturamentoImpostosModelProduto.IpiDeSaida: Double;
begin
  Result := FIpiDeSaida;
end;

function TResultadoFaturamentoImpostosModelProduto.CodigoDaAbreviacaoFiscal: String;
begin
  Result := FCodigoDaAbreviacaoFiscal;
end;

function TResultadoFaturamentoImpostosModelProduto.AtoDeclaratorioDF: Boolean;
begin
  Result := FAtoDeclaratorioDF;
end;

function TResultadoFaturamentoImpostosModelProduto.AtoDeclaratorioDF(
  AValue: Boolean): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FAtoDeclaratorioDF := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.CodigoDaAbreviacaoFiscal(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FCodigoDaAbreviacaoFiscal := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

function TResultadoFaturamentoImpostosModelProduto.CodigoDoFornecedor(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.FreteDeEntrada: Double;
begin
  Result := FFreteDeEntrada;
end;

function TResultadoFaturamentoImpostosModelProduto.FreteDeEntrada(
  AValue: Double): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FFreteDeEntrada := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.ImportacaoDireta: String;
begin
  Result := FImportacaoDireta;
end;

function TResultadoFaturamentoImpostosModelProduto.ImportacaoDireta(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FImportacaoDireta := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.CodigoDoFornecedorDaUltimaCompra: String;
begin
  Result := FCodigoDoFornecedorDaUltimaCompra;
end;

function TResultadoFaturamentoImpostosModelProduto.CodigoDoFornecedorDaUltimaCompra(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FCodigoDoFornecedorDaUltimaCompra := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.TipoDoFornecedorDaUltimaCompra: String;
begin
  Result := FTipoDoFornecedorDaUltimaCompra;
end;

function TResultadoFaturamentoImpostosModelProduto.TipoDoFornecedorDaUltimaCompra(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FTipoDoFornecedorDaUltimaCompra := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.IndustrializacaoOuRevenda: TOpcIndustrializacaoOuRevenda;
begin
  Result := FIndustrializacaoOuRevenda;
end;

function TResultadoFaturamentoImpostosModelProduto.IndustrializacaoOuRevenda(
  AValue: TOpcIndustrializacaoOuRevenda): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FIndustrializacaoOuRevenda := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.IpiDeEntrada: Double;
begin
  Result := FIpiDeEntrada;
end;

function TResultadoFaturamentoImpostosModelProduto.IpiDeEntrada(
  AValue: Double): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FIpiDeEntrada := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.IpiDeSaida(
  AValue: Double): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FIpiDeSaida := AValue;
end;

function TResultadoFaturamentoImpostosModelProduto.ItemConcreto: String;
begin
  Result := FItemConcreto;
end;

function TResultadoFaturamentoImpostosModelProduto.ItemConcreto(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FItemConcreto := AValue;
end;

class function TResultadoFaturamentoImpostosModelProduto.New: IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self.Create;
end;

function TResultadoFaturamentoImpostosModelProduto.UtilizaAmpara: String;
begin
  Result := FUtilizaAmpara;
end;

function TResultadoFaturamentoImpostosModelProduto.UtilizaAmpara(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FUtilizaAmpara := AValue;
end;

{ TResultadoFaturamentoImpostosModelEmpresa }

function TResultadoFaturamentoImpostosModelEmpresa.EmpresaEstado: String;
begin
  Result := FEmpresaEstado;
end;

function TResultadoFaturamentoImpostosModelEmpresa.EmpresaEstado(
  AValue: String): IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := Self;
  FEmpresaEstado := AValue;
end;

function TResultadoFaturamentoImpostosModelEmpresa.EmpresaIbge: String;
begin
  Result := FEmpresaIbge;
end;

function TResultadoFaturamentoImpostosModelEmpresa.EmpresaIbge(
  AValue: String): IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := Self;
  FEmpresaIbge := AValue;
end;

class function TResultadoFaturamentoImpostosModelEmpresa.New: IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := Self.Create;
end;

{ TParametrosFaturamentoImpostosModelAbreviacaoIcms }

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDaAbreviacaoFiscal: String;
begin
  Result := FCodigoDaAbreviacaoFiscal;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CalculandoPrecoDeVendaComDifal: Boolean;
begin
  Result := FCalculandoPrecoDeVendaComDifal;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CalculandoPrecoDeVendaComDifal(
  AValue: Boolean): IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCalculandoPrecoDeVendaComDifal := AValue;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDaAbreviacaoFiscal(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCodigoDaAbreviacaoFiscal := AValue;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDaEmpresa(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDaEmpresaAbf: String;
begin
  Result := FCodigoDaEmpresaAbf;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDaEmpresaAbf(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCodigoDaEmpresaAbf := AValue;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDaEmpresaTE(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCodigoDaEmpresaTE := AValue;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDaEmpresaTE: String;
begin
  Result := FCodigoDaEmpresaTE;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDoItem: String;
begin
  Result := FCodigoDoItem;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.CodigoDoItem(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCodigoDoItem := AValue;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.Estado: String;
begin
  Result := FEstado;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.Estado(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FEstado := AValue;
end;

class function TParametrosFaturamentoImpostosModelAbreviacaoIcms.New: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self.Create;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.TipoDaAbreviacaoFiscal: String;
begin
  Result := FTipoDaAbreviacaoFiscal;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcms.TipoDaAbreviacaoFiscal(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

{ TResultadoFaturamentoImpostosModelAbreviacaoIcms }

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaDeFcp: Double;
begin
  Result := FAliquotaDeFcp;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaDeFcp(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaDeFcp := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaDeIcms(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaDeIcms := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaDeSt: Double;
begin
  Result := FAliquotaDeSt;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaDeSt(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaDeSt := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaDiferenciadaRICMPR: Double;
begin
  Result := FAliquotaDiferenciadaRICMPR;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaDiferenciadaRICMPR(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaDiferenciadaRICMPR := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaEfetivaOrigem: Double;
begin
  Result := FAliquotaEfetivaOrigem;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaEfetivaOrigem(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaEfetivaOrigem := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaInternaEstadoDestino: Double;
begin
  Result := FAliquotaInternaEstadoDestino;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaInternaEstadoDestino(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaInternaEstadoDestino := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaReduzidaDeSt: Double;
begin
  Result := FAliquotaReduzidaDeSt;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaReduzidaDeSt(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaReduzidaDeSt := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.CodigoDaSituacaoTributaria: String;
begin
  Result := FCodigoDaSituacaoTributaria;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.CalcularSTSaiCCO: String;
begin
  Result := FCalcularSTSaiCCO;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.CalcularSTSaiCCO(
  AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCalcularSTSaiCCO := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.CalcularSTSaiPRU: String;
begin
  Result := FCalcularSTSaiPRU;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.CalcularSTSaiPRU(
  AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCalcularSTSaiPRU := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.CodigoDaAbreviacaoFiscal: String;
begin
  Result := FCodigoDaAbreviacaoFiscal;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.CodigoDaAbreviacaoFiscal(
  AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCodigoDaAbreviacaoFiscal := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.CodigoDaSituacaoTributaria(
  AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.DecretoReducaoRICMPR: Boolean;
begin
  Result := FDecretoReducaoRICMPR;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.DecretoReducaoRICMPR(
  AValue: Boolean): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FDecretoReducaoRICMPR := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.AliquotaDeIcms: Double;
begin
  Result := FAliquotaDeIcms;
end;

class function TResultadoFaturamentoImpostosModelAbreviacaoIcms.New: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self.Create;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualBaseDifalDestino(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualBaseDifalDestino := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualBaseDifalDestino: Double;
begin
  Result := FPercentualBaseDifalDestino;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualBaseDifalOrigem(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualBaseDifalOrigem := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualBaseDifalOrigem: Double;
begin
  Result := FPercentualBaseDifalOrigem;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualDaBaseDeIcms(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualDaBaseDeIcms := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualDaBaseDeSt: Double;
begin
  Result := FPercentualDaBaseDeSt;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualDaBaseDeSt(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualDaBaseDeSt := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualDeIva: Double;
begin
  Result := FPercentualDeIva;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualDeIva(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualDeIva := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.RegistroExiste: Boolean;
begin
  Result := FRegistroExiste;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.RegistroExiste(
  AValue: Boolean): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FRegistroExiste := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcms.PercentualDaBaseDeIcms: Double;
begin
  Result := FPercentualDaBaseDeIcms;
end;

{ TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor }

function TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor.CodigoDaAbreviacaoFiscal(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self;
  FCodigoDaAbreviacaoFiscal := AValue;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor.CodigoDaAbreviacaoFiscal: String;
begin
  Result := FCodigoDaAbreviacaoFiscal;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor.Estado(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self;
  FEstado := AValue;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor.Estado: String;
begin
  Result := FEstado;
end;

class function TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor.New: IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self.Create;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor.TipoDaAbreviacaoFiscal: String;
begin
  Result := FTipoDaAbreviacaoFiscal;
end;

function TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor.TipoDaAbreviacaoFiscal(
  AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

{ TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor }

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.AliquotaFatorNegativo: Double;
begin
  Result := FAliquotaFatorNegativo;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.AliquotaFatorNegativo(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self;
  FAliquotaFatorNegativo := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.AliquotaOperacoesProprias: Double;
begin
  Result := FAliquotaOperacoesProprias;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.AliquotaOperacoesProprias(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self;
  FAliquotaOperacoesProprias := AValue;
end;

class function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.New: IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self.Create;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.PercentualDaBaseDeIcmsFornecedor(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self;
  FPercentualDaBaseDeIcmsFornecedor := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.PercentualDaBaseDeIcmsFornecedor: Double;
begin
  Result := FPercentualDaBaseDeIcmsFornecedor;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.PercentualDaBaseDeStFornecedor: Double;
begin
  Result := FPercentualDaBaseDeStFornecedor;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.PercentualDaBaseDeStFornecedor(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self;
  FPercentualDaBaseDeStFornecedor := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.PercentualDeIvaFornecedor(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self;
  FPercentualDeIvaFornecedor := AValue;
end;

function TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.PercentualDeIvaFornecedor: Double;
begin
  Result := FPercentualDeIvaFornecedor;
end;

{ TParametrosFaturamentoImpostosClienteConsumidor }

function TParametrosFaturamentoImpostosClienteConsumidor.CalcularDescontoIcmsOrgaoPublico: Boolean;
begin
  Result := FCalcularDescontoIcmsOrgaoPublico;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.CalcularDescontoIcmsOrgaoPublico(
  AValue: Boolean): IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := Self;
  FCalcularDescontoIcmsOrgaoPublico := AValue;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.ClienteAtividade: String;
begin
  Result := FClienteAtividade;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.ClienteAtividade(
  AValue: String): IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := Self;
  FClienteAtividade := AValue;
end;


function TParametrosFaturamentoImpostosClienteConsumidor.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.ClienteEstado(
  AValue: String): IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.CodigoDaEmpresaTransferencia: String;
begin
  Result := FCodigoDaEmpresaTransferencia;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.CodigoDaEmpresaTransferencia(
  AValue: String): IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := Self;
  FCodigoDaEmpresaTransferencia := AValue;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.ClienteFisicoOuJuridico: String;
begin
  Result := FClienteFisicoOuJuridico;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.ClienteFisicoOuJuridico(
  AValue: String): IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := Self;
  FClienteFisicoOuJuridico := AValue;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.ClienteInscricaoEstadual(
  AValue: String): IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := Self;
  FClienteInscricaoEstadual := AValue;
end;

class function TParametrosFaturamentoImpostosClienteConsumidor.New: IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := Self.Create;
end;

function TParametrosFaturamentoImpostosClienteConsumidor.ClienteInscricaoEstadual: String;
begin
  Result := FClienteInscricaoEstadual;
end;

end.
