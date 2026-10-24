unit Faturamento.Impostos.Interfaces.Model;

interface

uses Shared.Functions.DataSet, Shared.Functions.Types;

type
  //Model novo com fcampotabelaarray

  //Cliente E Fornecedor
  IResultadoFaturamentoImpostosModelClienteFornecedor = interface
    ['{26CCBB8C-7A72-4E72-8A3A-6E3C9E75C78F}']

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

    function ClienteRegraFiscal: String;overload;
    function ClienteRegraFiscal(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function SomarIpiBaseIcms: Boolean; overload;
    function SomarIpiBaseIcms(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteInscricaoEstadual: String;overload;
    function ClienteInscricaoEstadual(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ClienteMicroEmpreendedor: Boolean; overload;
    function ClienteMicroEmpreendedor(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

//    function ClienteComercializacao: Boolean; overload;
//    function ClienteComercializacao(AValue: Boolean): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorIVAEspecialClienteMT : Double; overload;
    function ValorIVAEspecialClienteMT(AValue: Double): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;

    function ValorIVASimClienteMT: Double; overload;
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

    function ClienteC_G_C_: String;overload;
    function ClienteC_G_C_(AValue: String): IResultadoFaturamentoImpostosModelClienteFornecedor; overload;


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

  end;


  IParametrosFaturamentoImpostosClienteConsumidor = Interface
  ['{6018DBD6-8589-4597-A7CE-F7A50A1CD13A}']
    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function ClienteFisicoOuJuridico: String; overload;
    function ClienteFisicoOuJuridico(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function ClienteInscricaoEstadual: String; overload;
    function ClienteInscricaoEstadual(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function ClienteAtividade: String; overload;
    function ClienteAtividade(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function CalcularDescontoIcmsOrgaoPublico : Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue : Boolean): IParametrosFaturamentoImpostosClienteConsumidor; overload;

    function CodigoDaEmpresaTransferencia: String; overload;
    function CodigoDaEmpresaTransferencia(AValue: String): IParametrosFaturamentoImpostosClienteConsumidor; overload;

  End;

  //Cliente
  IFaturamentoImpostosModelCliente = interface
    ['{81DB7FE1-A50D-491F-99DA-D7DF185095C8}']
    function Consultar(const ACodigoDoCliente: String; const ASequencialEnderecoEntrega :
      String; const AGerandoCasosTestes: boolean; const AClienteConsumidorFinal: boolean;
      const AParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor = Nil; const ACodigoDaFazenda: String = ''): IResultadoFaturamentoImpostosModelClienteFornecedor;
  end;

  //Produto
  IResultadoFaturamentoImpostosModelProduto = interface
    ['{26CCBB8C-7A72-4E72-8A3A-6E3C9E75C78F}']

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
  end;

  IFaturamentoImpostosModelProduto = interface
    ['{81DB7FE1-A50D-491F-99DA-D7DF185095C8}']

    function Consultar(const ACodigoDoProduto: String; const ACodigoDaEmpresa: String;
      const ACodigoDaEmpresaTE, ACodigoDoFornecedorDoItem: String;
      const AGerandoCasosTestes: Boolean; const ACodigoDaEmpresaAbf: String = ''): IResultadoFaturamentoImpostosModelProduto;
  end;

  //Empresa
  IResultadoFaturamentoImpostosModelEmpresa = interface
    ['{88AEE6BE-B469-408D-8CDB-A020DD1CA2F9}']

    function EmpresaEstado: String; overload;
    function EmpresaEstado(AValue: String): IResultadoFaturamentoImpostosModelEmpresa; overload;

    function EmpresaIbge: String; overload;
    function EmpresaIbge(AValue: String): IResultadoFaturamentoImpostosModelEmpresa; overload;
  end;

  IFaturamentoImpostosModelEmpresa = interface
    ['{EA1F1FFC-1490-40D3-A261-872FC7F18CBE}']

    function Consultar(const ACodigoDaEmpresa: String): IResultadoFaturamentoImpostosModelEmpresa;
  end;

  //Fornecedor
  IFaturamentoImpostosModelFornecedor = interface
    ['{551515EE-BD96-4F24-B544-D99D329AF04C}']

    function Consultar(const ACodigoDoFornecedor: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
  end;

  //Abreviacao Icms
  IParametrosFaturamentoImpostosModelAbreviacaoIcms = interface
    ['{1204096C-74DD-4C33-9F41-B77C7ECCA69D}']

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
  end;

  IResultadoFaturamentoImpostosModelAbreviacaoIcms = interface
    ['{DAF259A4-8A61-4036-893C-F5107706DBC9}']

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

  end;

  IFaturamentoImpostosModelAbreviacaoIcms = interface
    ['{7A03DECC-6205-4AA8-8CB5-BA500F31739F}']

    function Consultar(const AParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
  end;

  //Abreviacao Icms Fornecedor
  IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor = interface
    ['{361E58CD-A07F-4CC9-A1C9-91D5CBE1CC76}']

    function CodigoDaAbreviacaoFiscal: String; overload;
    function CodigoDaAbreviacaoFiscal(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    function Estado: String; overload;
    function Estado(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;

    function TipoDaAbreviacaoFiscal: String; overload;
    function TipoDaAbreviacaoFiscal(AValue: String): IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor; overload;
  end;

  IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor = interface
   ['{8CF0E242-2AF6-4A4C-8099-72C922B46782}']

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
  end;

  IFaturamentoImpostosModelAbreviacaoIcmsFornecedor = interface
   ['{B8558F1F-31B5-4ACF-BDEB-770ADD58CE7C}']

    function Consultar(const AParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
  end;

implementation

end.
