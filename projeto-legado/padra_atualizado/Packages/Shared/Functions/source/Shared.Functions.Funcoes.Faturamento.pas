unit Shared.Functions.Funcoes.Faturamento;


interface

Uses System.StrUtils,
     System.SysUtils,
     Shared.Functions.Configuracoes,
     Shared.Functions.Core,
     Shared.Functions.Constantes,
     System.DateUtils,
     Shared.Functions.Types,
     System.Classes,
     Shared.Functions.Tipos,
     Shared.Functions.Interfaces;

Type
  TFunctionFuncoesFaturamento = Class
  Private
    Class function RetornarValorDoFrete(Const AValorFreteItem : Double; Const AOpcaoDocumento : String;
      Const AOrgaoPublico, AZonaFranca, ADentroDoEstado, ACalcularSubstituido, ACalcularIPI: Boolean): Double;

    Class function ZerarFreteParaOrgaoPublicoZonaFrancaDentroDoEstado(Const AOrgaoPublico : Boolean;
      Const AZonaFranca : Boolean; Const ADentroDoEstado : Boolean) : Boolean;

    Class function ZerarFreteParaContribuinteIpi : Boolean;

    Class function CalcularParaItemSubstituidoIpi(Const ACalcularSubstituido, ACalcularIPI : Boolean) : Boolean;

    Class function ValidarZonaFrancaEClienteNaoConsumidor(Const AZonaFranca, AClienteConsumidorFinal: Boolean) : Boolean;
    Class function AjustarDescontoEspecialZonaFrancaEClienteNaoConsumidor(Const ADescontoEspecial: double; const AZonaFranca, AClienteConsumidorFinal, ACalcularSubstituido, ACalcularIPI, AClienteZonaFrancaComDescontoEspecial: boolean): Double;
    Class function RetornarValorDescontoTotalGeralItem(Const ADescontoEspecial: double; const AZonaFranca, AClienteConsumidorFinal, ACalcularSubstituido, ACalcularIPI, AClienteZonaFrancaComDescontoEspecial: boolean): Double;
    Class function ValidarOrgaoPublicoOuZonaFranca(const AOrgaoPublico, AZonaFranca: boolean): boolean;
    Class function RetornarValorDespesaAcessoria(const ADespesaAcessoria: double; const ACalcularSubstituido: boolean): double;

    Class function ValidarOpcaoDeDocumentoEntradaFornecedor(Const AOpcaoDocumento : String) : Boolean;
    Class function ValidarOpcaoDeDocumentoOutrasSaidasFornecedor(Const AOpcaoDocumento : String) : Boolean;
    Class function ValidarOpcaoDeDocumentoEnvioGarantiaFornecedor(Const AOpcaoDocumento : String) : Boolean;
    Class function ValidarOpcaoDeDocumentoNotaComplementoFornecedor(Const AOpcaoDocumento : String; Const ANCFornecedor : Boolean) : Boolean;
    Class function ValidarOpcaoDeDocumentoNotaEspecialFornecedor(Const AOpcaoDocumento : String; Const ANEFornecedor: Boolean) : Boolean;
    Class function ValidarOpcaoDeDocumentoVendaNormalFornecedor(Const AOpcaoDocumento : String; Const ACodigoCliente : String; Const ACodigoFornecedor : String) : Boolean;
    Class function ValidarOpcaoDeDocumentoRegimeEspecialConfTE(Const AOpcaoDocumento: String; Const ARegimeEspecialPorEmpresa: Boolean): Boolean;

    class function RetornarEspecieDocumento(const AEspecieDocumento,
      AOpcaoDocumento: string): string; static;

    class function ZerarIpiSubstituicaoTributariaParaMIeFF(
      const AEspecieDocumento, AOpcaoDocumento: string): Boolean;
    class function ZerarIpiSubstituicaoTributariaParaTE(
      const AEspecieDocumento, AOpcaoDocumento: string): Boolean;

    class function ZerarSubstituicaoTributariaEspecies(const AEspecieDocumento, AOpcaoDocumento: string; ATemMIFFEntreOsDevolvidos: Boolean = False): Boolean;
    class function ZerarSubstituicaoTributariaPedidoOrcamento(const AEspecieDocumento, AOpcaoDocumento: string): Boolean;
    class function ZerarSubstituicaoTributariaPedidoDeBonificacao(const AEspecieDocumento, AOpcaoDocumento, ATipoDoPedido: string): Boolean;
    class function DefinePrecoDeCustoASerUtilizado(const APrecoCusto, APrecoUltimaCompra, APrecoEImpostosUltimaCompra: Double): Double;
    class function ConfiguracaoImportacaoDiretaEItemImportacaoDireta(Const AItemImportacaoDireta : Boolean): Boolean;

    class function RetornarRegrasAtendeDifal(const AClienteConsumidorFinal,
      ADocumentoParaFornecedor, ADentroDoEstado, AClienteFilial,
      AClientePermitidoNaRegra: Boolean;
      const AOpcaoDocumento: String): Boolean;

    class function ClientePermitidoNaRegra(
      const AChecagemVendaPresencial: Boolean; Const AClienteNaoContribuinte : Boolean; const ATipoAbfCliente : String): Boolean;

    class function ClienteNaoContribuinteVendaPresencial(
      const ATipoAbfCliente: String;
      const AClienteNaoContribuinte: Boolean): Boolean;

    class function ClienteNaoContribuinte(const AClienteInscricaoEstadual,
      AClienteIesUni: String; const AAtividadeConstrutora,
      AClienteProdRuralPermiteConsumidorFinal: Boolean): Boolean;

    class function ClienteInscricaoEstadualEAClienteIesUni(
      const AClienteInscricaoEstadual, AClienteIesUni: String): Boolean;

    class function AtividadeConstrutoraOuProdRuralNaoContribuinte(
      const AAtividadeConstrutora: Boolean;
      Const AClienteProdRuralNaoContribuinte: Boolean): Boolean;

    class function ClienteProdutorRuralPermiteConsulmidorFinal(const AClienteIesUni: String;
      const AEhProdutorRural: Boolean): Boolean;

    class function CalcularPreComMenosDescFornUltimaCompra(AParametros: IParametrosCalculoPreComMenosDescForn): Double;

    class function CalcularPreComMenosDescFornPrecoCompra(AParametros: IParametrosCalculoPreComMenosDescForn): Double;

    class function fTexto(const AQuoted, ASeQuotedUseAspas: Boolean; ATexto: String): String;

    class function MicroEmpreendedorOuPossuiIES(const AClienteIes: String;
      const AMicroEmpreendedor: Boolean): Boolean;

    class function ClienteOrgaoPublico(
      const AClienteOrgaoPublico,
      ACalcularDescontoIcmsOrgaoPublico: Boolean): Boolean;

    class function ClienteZonaFranca(const AClienteZonaFranca,
      AClienteConsumidorFinal: Boolean): Boolean;

    class function SomarIPIClienteConsumidorFinalIVAEspecialMT(const AClienteConsumidorFinal, AClienteIVAEspecialMT, ASomarIPI: Boolean): Boolean;
    class function ServicoTerceirizado(const ACodigoDoItem: String; ACodigoEmpresa: String = ''): Boolean; static;

    class function BaixaDeEntregaFuturaComImpostosNosCamposProprios(const ABaixaEntFut: Boolean; const AEntFutOpc: String): Boolean;
    class function BaixaDeEntregaFuturaComImpostosNaVenda(const ABaixaEntFut: Boolean; const AEntFutOpc: String): Boolean;
    class function DeveCalcularSTParaPedidoDeRetiraParaDevolucao (const AEspecieDocumento, AOpcaoDocumento : String): Boolean;
    class function EhRotinaDePedidoDeRetiraParaDevolucao (const AEspecieDocumento, AOpcaoDocumento : String): Boolean;
  Public
    Class function fEhItemSimplesRemessaConcreto(AOpcaoDocumento                     : String;
                                                 ATaxaBombeamentoPedidoOrcamento     : Boolean;
                                                 ASimplesRemessaConcretoDadosCliente : Boolean;
                                                 AEhItemConcreto                     : Boolean;
                                                 ASimplesRemessaConcreto             : Boolean): Boolean;

    Class function fEhItemConcreto(ASimplesRemessaConcretoDadosCliente : Boolean; AItemConcreto: Boolean): Boolean;

    Class function fEhRecGarantia(AOpcaoDocumento : String; AClassificacaoFiscalRecebimentoGarantia : String):Boolean;
    class function fEhDocumentoEnvioFornecedor(const pstrOpcDoc: String): Boolean;
    Class function fDocumentoParaFornecedor(AOpcaoDocumento: String; ANCFornecedor: Boolean; ANEFornecedor: Boolean; ANotaImportacao: Boolean;
      ACodigoCliente: String; ACodigoFornecedor: String; ARegimeEspecialPorEmpresa: Boolean = False): Boolean;

    Class function fAtendeRegraFiscalEndEntrega(AOpcaoDocumento : String; AAtividadeConstrutora : Boolean; ADocumentoParaFornecedor : Boolean;  ARegraFiscal : String ):Boolean;

    Class function fCalcBeneficioReducaoBaseIcmsST(ATipoAbreviacaoFiscal : String; ACodigoFiscal : String; ADentroDoEstado : Boolean) : Boolean;
    class function AtendeuRegrasUF(const AUFDaEmpresa, AUFEnderecoDeEntrega: string): Boolean;

    Class function fDentroDoEstado(AClienteEstado: String; AClienteEstadoBD : String) :Boolean;

    Class function fDentroDoEstadoFaturamento(AClienteEstado: Boolean; AVendaPresencial: Boolean): Boolean;

    Class function fTrocaUFEndEntrega(AAtendeRegraFiscalEndEntrega: Boolean; AEstadoEntrega: String; AClienteEstado: String): String;

    Class function fDentroDoEstadoCFOP(AVendaPresencial :Boolean; AClienteEstado : String; ADentroDoEstado : Boolean ):Boolean;

    Class function fAtendeRegrasDifal(
      AClienteInscricaoEstadual : String;
      AChecagemVendaPresencial : Boolean; AClienteConsumidorFinal : Boolean; ADocumentoParaFornecedor,
      ADentroDoEstado, AClienteFilial: Boolean; AOpcaoDocumento: String;
      AEhProdutorRural: Boolean; AClienteIesUni: String; AAtividadeConstrutora: Boolean;
      ATipoAbfCliente: String) : Boolean;

    Class function fPodeTerReducaoRICMPRDefinidaNoCadastroAbreviacao: Boolean;

    Class function fItemPossuiReducaoBaseConfRICMPR(ADentroDoEstado: Boolean;
      AClienteConsumidorFinal: Boolean; AClienteIes: String; AMicroEmpreendedor: Boolean;
      ACodigoDaSubstituicaoTributariaDoItem: String; AUtilizaDecretoReducaoRICMSdaAbreviacao: Boolean;
      ATipoDeAbrevicaoDoCliente : String): Boolean;

    Class function fItemConcreto(AEhItemEstrutura : Boolean; AItemPorEmpresa, AProdutoConcreto : String) : Boolean;

    Class function fItemRevInd(const AIndustrializacaoRevendaCADITE, AIndustrializacaoRevendaITEGER: String) : String;

    Class function RetornarClienteIndustria(Const AClienteTipoOperacao : String; AClienteIndustria : String) : Boolean;


    Class function fAtividadeConstrutora(ACodigoAtividade : String; ACodigoAtividadeBD : String ) : Boolean;
    class function fAtendeuAsCondicoes(const ATipoAbreviacaoFiscal: string; const ACodigoFiscal: String; const ADentroDoEstado: Boolean): Boolean;

    Class function fEhItemServico(ACodigoDoItem : String; ACodigoEmpresa: String = '') : Boolean;

    Class function fRetornaClienteFilial( ACodigoEmpEmpresa: String; ACodigoClienteFilial : String;
      ACodigoFornecedorFilial : String; AForncedorOuCliente : String = 'C'): String;

    Class function fClientSelectEhClientFilialEmpLogada(ACodigoCliente : String; AClienteFilial : String ) : Boolean;

    class function fEhProdutorRural(strProRur: String): Boolean;

    class function fRetornaIesUni(strIesUni: String): String;

    Class function fGetTipoAbfCliente(const ACodigoCliente: String;
      APessoaFisicaOuJuridica, AInscricaoEstadual, AConsumidorFinal, ACodigoAtividade,
      AProdutorRural, AMicroEmpreendedor, ARegimeTributacao, ATipoFornecedor, AIndustria,
      AClientesFilial: String; AAtividadeConstrutora : Boolean): String;

    class function fGetTipoAbf(AClienteOuFornecedor, APessoaFisicaOuJuridica,
      AInscricaoEstadual, AConsumidorFinal, ACodigoAtividade, AProdutorRural,
      AMicroEmpreendedor, ARegimeTributacao, ATipoFornecedor, AIndustria,
      AFilial: String; AAtividadeConstrutora : Boolean): String;

    class function fRetClienteFilial(const ACodigoCliente, AClientesFilial: string): String;

    class function fItemEstrutura(ACount: Integer): Boolean;

    class function fRetSelectCodEmpClienteFilial: String;
    class function fRetCodEmpClienteFilial(strCodEmp: String): String;
    class function fGetSelectTipoAbfCliente : String;
    class function fGetSelectTipoAbfFornecedor : String;

    Class function GetSelectClienteFilial : String;
    Class function GetSelectFornecedorFilial : String;

    Class function RetornarListaDeClienteFilial(Const AListaClienteFilial: String) : String;

    Class function RetornarListaDeFornecedorFilial(Const AListaClienteFilial: String; Const AApresentarComVirgula : Boolean = false) : String;

    Class procedure IncrementaListaStr(
      Const ATexto: String; Var strLista: String; Const AQuoted: Boolean = False; Const ASeQuotedUseAspas: Boolean = True;
      Const AchrSepara: Char = ','; Const AEspaca: Boolean = True; Const AIgnoraRepetido: Boolean = True);

    class function fRetUFEmpresa(AUFDaEmpresa: String): String;

    class function fCalculaAliquotaInterestadual(
      ACodigoDaSubistituicaoTributaria: String; AUFDaEmpresa: String;
      AUFEnderecoDeEntrega: String): Double;

    class function ProdutoSubstituidoFaturamento(ACodigoFiscal : String) : Boolean;

    Class function PercentualProvisorioPartilha(AExercicio : TDateTime) : Double;

    class function SqlAbfIcm(const ACodigoDaEmpresaTE: String; const ACodigoDaEmpresa: String): String;

    class function SqlBuscaAbfIcm(const ACodigoDaEmpresaTE: String; const ACodigoDaEmpresa: String): String;

    Class function fGetCodAbf(ACodigoAbreviacaoTodasEmpresas : String; ACodigoAbreviacaoPorEmpresas : String; ACodigoDaEmpresa: String = '') : String;

    class function ClienteIVAEspecialMT(const AClienteEstado, AEstadoEmpresa: String; const AValorClienteIVAEspecialMT: Double): Boolean;

    class function EntraIPInaBaseIcms(const AClienteConsumidorFinal: Boolean; const AClienteIVAEspecialMT: Boolean; const AComercializacao: Boolean; const ASomarIPI: Boolean; const ABaixaDeEntregaFutura: Boolean): Boolean;

    class function EmpresaOptanteSimples(const ASimplesNacional: String): Boolean;

    class function ConfiguradoParaTrocarParaX41: Boolean;

    class function ConfiguradoParaTrocarParaX41noParana: Boolean;

    class function GetCliIVAEspMT(const ADocumentoParaFornecedor: Boolean;
      const AClienteIES, AClienteEstado: String; const AClienteIVAESP: Double; const AExisteNaTabelaCEDEM: Boolean;
      const AClienteIVAESPCedem: Double): Double;

    class function GetCliIVANacMT(const ADocumentoParaFornecedor: Boolean;
      const AClienteIES, AClienteEstado: String; const AClienteIVANAC: Double; const AExisteNaTabelaCEDEM: Boolean;
      const AClienteIVANACCedem: Double): Double;

    class function ItemTributado(const ACodigoDaSubstituicaoTributariaDoItem: String): Boolean;

    class function ClienteZonaFrancaOrgaoPublico(const AClienteOrgaoPublico: Boolean;
      const ACalcularDescontoIcmsOrgaoPublico: Boolean; const AClienteZonaFranca: Boolean;
      const AClienteConsumidorFinal: Boolean ): Boolean;

    class function CalculaSubsTribSimples: Boolean;

    class function CalcSTCliConNCOEspSto(const AUFEmpresa: String; const ATipoAbreviacao: String;
      const AClienteConsumidorFinal: Boolean; const ADentroDoEstado: Boolean; const AItemImportacaoDireta: Boolean;
      const ACodigoDaSubstituicaoTributariaDoItem: String): Boolean;

    Class Function Transform(AConteudo: String; AStep: Shortint; AChar: String = '_'): String;

    Class Function CodificaChaveNota(ANumeroDocumento, AEspecieDococumento, ACodigoEmpresa, ASerieNota, ACodigoFornecedor : String): String;

    Class function InserirEspaco(AString :String; ATamanho:Integer; APosicao:Integer = 1):String;

    Class function CalculaSubTributariaPorDentro(ATipoAbreviacaoFiscal : String; AAbreviacaoFiscalICM : Boolean; AAbreviacaoCalculoSt  : String) : Boolean;

    class function UtilizaAmpara(const AClienteEstado: String; const AItemAmpara: Boolean): Boolean;

    class function ItemAmpara(const AItemUtilizaAmpara: String): Boolean;

    Class function LocalizarOpcaoDeDocumento(Const AOpcaoDocumentoItem : String; Const ADocumentoParaLocalizar: String) : Boolean;

    Class function LocalizarEstado(Const AOpcaoEstadoItem: String; Const AEstadoParaLocalizar: String) : Boolean;

    class function ZerarIpi(const AEspecieDoDocumento: String; const ATemMIFFEntreOsDevolvidos: Boolean; const AOpcaoDocumento: String;
                            const ATipoDoPedido: String; const ABaixaEntFut: Boolean = False;
                            const AEntFutOpc: String = ''; const AOpcaoDocumentoVerdadeira: String = ''): Boolean;

    class function IsentaImpostosEspeciesZerar(const ADesmembrarMeiaNotaComNotaNormal: Boolean): String;

    class function ZerarIpiEspeciesMIFF(const AEspecieDoDocumento: String): Boolean;

    class function ZerarIpiEspeciesTE(const AEspecieDoDocumento: String): Boolean;

    class function ZerarIpiNaoContribuiteIpiUsarORPDMIFFouMIFF(const AUsarMIFF: Boolean; const ATemMIFFEntreOsDevolvidos: Boolean): String;

    class function ZerarIpiNaoContribuiteIpiEspeciesNaoORPDMIFF(const AEspecieDoDocumento: String; AUsarMIFF: Boolean; const ATemMIFFEntreOsDevolvidos: Boolean): Boolean;

    class function ZerarIpiEspecieDV(const AEspecieDoDocumento: String; const ATemMIFFEntreOsDevolvidos: Boolean): Boolean;

    class function ZerarIpiPedidoEspeciesMIFF(const AEspecieDocumento, AOpcaoDocumento, ATipoDoPedido: string): Boolean;

    class function ZerarIpiPedidoEspeciesMIFFQuandoDefineTipoDeDocumentoNoPedido(const AEspecieDocumento, AOpcaoDocumento, ATipoDoPedido: string): Boolean;

    Class Function GetSelectAbreviacaoIpi(const AClassificacaoFiscal: String) : String;

    Class Function ValidarIpiSaida(const AEspecieDocumento : String) : Boolean;

    Class Function ValidarSituacaoDoIpi(const ASituacaoIpi : String) : Integer;

    Class Function ValidarConfirmacaoNotaFiscalConcreto(const AVendaItemConcreto              : Boolean;
                                                        const ADesmembrarNotaProdutosServicos : Boolean;
                                                        const AOpcaoDocumento                 : String): Boolean;

    Class Function TaxaBombeamentoPedidoOrcamento(const AOpcaoDocumento                : String;
                                                  const AConfirmandoNotaFiscalConcreto : Boolean;
                                                  const AItemConcreto                  : Boolean) : Boolean;

    Class Function ValidarDocumentosMIFF(const AOpcaoDocumento: String): Boolean;

    Class function ValorFreteDespesaAcessoriaItem(Const AValorFrete,
      ADespesaAcessoria: Double; Const AOrgaoPublico, AZonaFranca,
      ADentroDoEstado: Boolean; Const AOpcaoDocumento: String; Const ACalcularSubstituido,
      ACalcularIPI: Boolean): Double;

    class function TotalGeralItem(Const AClienteConsumidorFinal: Boolean;
      Const ADescontoEspecial: Double;
      Const AValorFrete, AValorTotalItem : Double;
      Const ADespesaAcessoria: Double;
      Const AOrgaoPublico, AZonaFranca, ADentroDoEstado: Boolean;
      Const AOpcaoDocumento: String; Const ACalcularSubstituido,
      ACalcularIPI: Boolean; Const AClienteZonaFrancaComDescontoEspecial: Boolean): Double;

    Class function ImportacaoDireta( Const AImportacaoDiretaItem : String ) : Boolean;

    Class function CalcularValorDoIVA( Const ATotalGeralDoItem, AAliquotaIcms, AValorIpi, AValorClienteIvaMT, AValorAliquotaSts : Double): Double;
//    Class Function ValidarCodigoFiscalSubstituicaotributaria(Const ACodigoFiscal : String) : Boolean;
    Class Function ValidarImportacaoDiretaClienteIvaSimMT(Const AImportacaoDireta : Boolean;  Const AClienteIVASimMT : Double;  Const ATotalGeralItem : Double) : Boolean;

    class function GetCliIVASimMT(const ADocumentoParaFornecedor: Boolean;
      const AClienteIES, AClienteEstado: String;
      const AClienteIVASIM: Double; const AExisteNaTabelaCEDEM: Boolean;
      const AClienteIVASIMCedem: Double): Double; static;

    class function ProdutoComOrigemDaMercadoriaEstrangeira(const ACodigoDaSubstituicaoTributaria: String): Boolean;
    class function SubstituicaoTributaria(const ACodigoDaSubstituicaoTributaria: String): Boolean;
    class function GetSelectTemAliquotaEcf: String;
    class function ResultadoCamparacaoAliquotaEcf(const AAliquotaEcf, AAliquotaCalculada: Double): Boolean;
    class function TributarNaAliquotaInternaDoEstado(const AClienteEstado, AEstadoDaEmpresa, AClienteIes: String): Boolean;

    class function CadastroDeAbreviacaoFiscalIgualParaTodasAsEmpresas(const ACodigoDaEmpresaTE: String; const ACodigoDaEmpresa: String): Boolean;
    class function RetornarCodigoEmpresa(const ACodigoDaEmpresaTE: String; const ACodigoDaEmpresa: String): String;
    class function GetSelectAlqIcmEstEmp: String;
    class function ImportacaoDiretaDoItem(const AImportacaoDiretaCadIte, AImportacaoDiretaIteGer: String): String;

    Class function DevolucaoComSubstituicaoTributariaParaMIeFF(const AEspecieDocumento, AOpcaoDocumento: string; ATemMIFFEntreOsDevolvidos: Boolean): Boolean;
    class function ZerarSubstituicaoTributaria(const AEspecieDocumento, AOpcaoDocumento, ATipoDoPedido: string;
                                               const ABaixaEntFut: Boolean = False; const AEntFutOpc: String = '';
                                               const ATemMIFFEntreOsDevolvidos: Boolean = False): Boolean;
    class function ValidarDocumentoParaClienteTare(const ADocumentoParaFornecedor: boolean; const AInscricaoEstadualCliente, AEstadoCliente: String): Boolean;
    class function RetornarSQLClienteTare: string;
    class function ValidarDocumentoParaClienteDefit(const ADocumentoParaFornecedor: boolean; const AInscricaoEstadualCliente, AEstadoCliente: String): Boolean;
    class function RetornarSQLClienteDefit: string;
    class function OptantePorSimplesNacional(const strCodEmp : String = ''): String;

    class function CalcularImpostosUtilizandoCadFornecedoresFormacaoPreco : Boolean;

    class function TotalGeralItemPreUlt(Const AClienteConsumidorFinal : Boolean;
      Const ADescontoEspecial, APrecoCusto, APrecoUltimaCompra,
        APrecoEImpostosUltimaCompra, AQuantidadeItem: Double;
      Const AValorFrete: Double;
      Const ADespesaAcessoria: Double;
      Const AOrgaoPublico, AZonaFranca, ADentroDoEstado: Boolean;
      Const AOpcaoDocumento: String; Const ACalcularSubstituido,
      ACalcularIPI: Boolean): Double;

    class function DocumentosDeConfirmacaoClienteOrgaoPublicoNaoCalcularIcms(const OpcaoDeDocumento: String; const ClienteOrgaoPublico, CalcularDescontoIcmsOrgaoPublico: Boolean): Boolean;

    class function ProdutoAliquotaPis: Double;
    class function ProdutoAliquotaCofins: Double;
    class function EhItemVendaVidro(ACodigo: String; AItemVidro: String = '-1'): Boolean;
    class function OrcamentoOutraLojaF11(const AOrigemF11: Boolean; const ACodigoEmpresaOriginal: String; const ACodigoEmpresa: String; const ANumeroOrcamento: String): Boolean;
    class function GetDadosAbf: String;

    class function SqlCdsIteger(ATabPre: String; out ATabUti: String): String;

    class function CalcularPreComMenosDescForn(AParametros: IParametrosCalculoPreComMenosDescForn): Double;

    Class function RetornarSQLRetencaoPisCofins(Const AMostrarColunaCDESPI : Boolean) : String;

    Class function RetornarColunasCadastroClienteRetencaoPisCofins(Const AMostrarColunaCDESPI : Boolean) : String;
    Class function RetornarColunasCadastroClienteRetencaoPisCofinsDefault(Const AMostrarColunaCDESPI : Boolean) : String;

    Class Function ValidarEmpresaSimplesParaRetencaoPisCofins : Boolean;

    Class Function ValidarDescontoDeICMSOrgaoPublico(Const AOpcaoDocumento : String; Const AClienteDescontoDeICMSOrgaoPublico : String) : String;

    Class Function DecodificaChaveNota(Const AParametros : IParametrosDecodificaChaveNota) :IResultadoDecodificaChaveNota;

    Class Function RetornarClienteFisicoOuJuridico(Const AOpcaoDigitadaClienteConsumidor : Integer) : String;

    class function RetornaAliquotaIcmConformeRegraMatoGrosso(const AAlqIcmSimples, AAlqIcmAbr: Double;
      const ADentroDoEstado: Boolean; const ClienteConsumidor: Boolean; const blnVerificaClienteConsumidor: Boolean = False): Double;

    class function AliquotaIcmsConformeRegraMatoGrossoAbreviacao(const AClienteConsumidor, blnVerificaClienteConsumidor: Boolean): Boolean;

    class function UtilizaDecretoReducaoRICMSdaAbreviacao(const blnCheckBoxMarcadoOuAliquotaMaiorQueZero: Boolean): Boolean;

    class function ZerarIpiNaoContribuiteIpiUsarMIFF(const AOpcaoDocumentoVerdadeira: String = ''; const AEspecieDoDocumento: String = ''): Boolean;

    class function fAtendeuAsCondicoesDeFCPComReducaoBaseIcmsST(const ATipoAbreviacaoFiscal: string; const ACodigoFiscal: String; const ADentroDoEstado: Boolean): Boolean;

    class function fCalculaFCPComReducaoBaseIcmsST(ATipoAbreviacaoFiscal : String; ACodigoFiscal : String; ADentroDoEstado: Boolean): Boolean;
    class function PerfilAbreviacaoNaoConsumidorOuIndustria(const ATipoAbreviacaoFiscal: String): Boolean;
    class function fAplicaCargaLiquidaCE(const AEstadoCliente: String; const AClienteCargaLiquida: Boolean): Boolean;
    class function ItemProvenienteDeIndustrializacao(const AIndustrializacaoOuRevenda : String): Boolean;
    class function ItemSubstituido(const ADentroDoEstado: Boolean; const ACodigoDaSubstituicaoTributariaDoItem: String;
      const AUtilizaDecretoReducaoRICMSdaAbreviacao: Boolean; const ACodigoAbreviacaoFiscal : String; const AConsumidorFinal: Boolean; const AClienteInscricaoEstadual: String; const AClienteMicroEmpreendedor : Boolean): Boolean;
    class function EhDevolucaoOuOutrasEntradas(const AOpcaoDocumento, AEntradaOuSaidaDoItem: String): Boolean;
    class function fEhIbgeRegraZonaFranca(ACodigoIbge: String): Boolean;
    class function fCalculaIpiParaClienteZonaFranca(AIbgeEmpresa: String; AIbgeEntrega: String; ASuframa: String; AZonaFranca: Boolean; AVendaPresencial: Boolean): Boolean;
  End;

implementation

{ TFunctionFuncoesFaturamento }

class function TFunctionFuncoesFaturamento.AjustarDescontoEspecialZonaFrancaEClienteNaoConsumidor(
  const ADescontoEspecial: double; const AZonaFranca, AClienteConsumidorFinal, ACalcularSubstituido, ACalcularIPI, AClienteZonaFrancaComDescontoEspecial: boolean): Double;
begin
  result := ADescontoEspecial;

  If AClienteZonaFrancaComDescontoEspecial Then
  begin
    Result := 0;
    Exit;
  end;

  If not ValidarZonaFrancaEClienteNaoConsumidor(AZonaFranca, AClienteConsumidorFinal) Then
    Exit;

  if not CalcularParaItemSubstituidoIpi(ACalcularSubstituido, ACalcularIPI) Then
  begin
    Result := 0;
    Exit;
  end;

  If objConfiguracoes.fGetValorConfiguracao(CFG_DEDUZIR_DESCONTO_ICMS_ZONA_FRANCA_BASE_CALCULO_ST_IPI, VarBoolean) Then
    Exit;

  result := 0;
end;

class function TFunctionFuncoesFaturamento.CadastroDeAbreviacaoFiscalIgualParaTodasAsEmpresas(
  const ACodigoDaEmpresaTE, ACodigoDaEmpresa: String): Boolean;
begin
  Result :=
    objConfiguracoes.
      fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, varString, RetornarCodigoEmpresa(ACodigoDaEmpresaTE, ACodigoDaEmpresa)) = IGUAL_PARA_TODAS_AS_EMPRESAS;
end;

class function TFunctionFuncoesFaturamento.CalcSTCliConNCOEspSto(
  const AUFEmpresa, ATipoAbreviacao: String; const AClienteConsumidorFinal,
  ADentroDoEstado, AItemImportacaoDireta: Boolean;
  const ACodigoDaSubstituicaoTributariaDoItem: String): Boolean;
begin
  Result := false;

  If Not (AUFEmpresa = 'ES') then
    Exit;

  if Not (ATipoAbreviacao = '_SAI_NCO') Then
    Exit;

  If Not (AClienteConsumidorFinal) Then
    Exit;

  If Not (ADentroDoEstado) Then
    Exit;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, varString) <> SUBSTITUTO_TRIBUTARIO)Then
    Exit;

  if not ConfiguracaoImportacaoDiretaEItemImportacaoDireta(AItemImportacaoDireta) Then
    Exit;

  If Not (Pos(ACodigoDaSubstituicaoTributariaDoItem, objConstantes.fGetCstSubstituicao) > 0)Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.ConfiguracaoImportacaoDiretaEItemImportacaoDireta(Const AItemImportacaoDireta : Boolean) : Boolean;
begin
  Result := false;

  If Not AItemImportacaoDireta Then
    Exit;

  if Not (objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, varBoolean)) then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.ZerarIpiEspecieDV(
  const AEspecieDoDocumento: String;
  const ATemMIFFEntreOsDevolvidos: Boolean): Boolean;
begin
  Result := False;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) Then
    Exit;

  If (Not objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean)) Then
    Exit;

  If (Pos(AEspecieDoDocumento, DEVOLUCAO_POS) <= 0) Then
    Exit;

  If (Not ATemMIFFEntreOsDevolvidos) Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.ZerarIpiEspeciesMIFF(
  const AEspecieDoDocumento: String): Boolean;
begin
  Result := False;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) Then
    Exit;

  If (Pos(AEspecieDoDocumento, MOVIMENTACAO_ITENS_FATURAMENTO_FUTURO) <= 0) Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.ZerarIpiEspeciesTE(
  const AEspecieDoDocumento: String): Boolean;
begin
  Result := False;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_TE, varBoolean)) Then
    Exit;

  If (Pos(AEspecieDoDocumento, TRANSFERENCIA_ESTOQUE) <= 0) Then
    Exit;

  Result := True;
end;

Class function TFunctionFuncoesFaturamento.ZerarIpiPedidoEspeciesMIFF(const AEspecieDocumento, AOpcaoDocumento, ATipoDoPedido: string): Boolean;
begin
  result := False;

  if (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) then
    Exit;

  If (Not objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean)) Then
    Exit;

  if (Pos(RetornarEspecieDocumento(AEspecieDocumento, AOpcaoDocumento), PEDIDO_ORCAMENTO) <= 0) then
    Exit;

  if (ATipoDoPedido <> TIPO_PEDIDO_BONIFICACAO) then
    Exit;

  result := True;
end;

class function TFunctionFuncoesFaturamento.ZerarIpiPedidoEspeciesMIFFQuandoDefineTipoDeDocumentoNoPedido(
  const AEspecieDocumento, AOpcaoDocumento, ATipoDoPedido: string): Boolean;
begin
  result := False;

  if (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) then
    Exit;

  if (Pos(RetornarEspecieDocumento(AEspecieDocumento, AOpcaoDocumento), PEDIDO_ORCAMENTO) <= 0) then
    Exit;

  if (ATipoDoPedido <> TIPO_PEDIDO_BONIFICACAO) then
    Exit;

  if (objConfiguracoes.fGetValorConfiguracao(CFG_DEFINE_TIPO_DOCUMENTO_PEDIDO_EXPEDICAO, varBoolean) <> DEFINE_TIPO_DOCUMENTO_NO_PEDIDO) then
    Exit;

  result := True;
end;

class function TFunctionFuncoesFaturamento.CalcularImpostosUtilizandoCadFornecedoresFormacaoPreco: Boolean;
begin
  Result := (objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_CAD_FORNECEDORES_FORMACAO_PRECO, varBoolean));
end;

Class function TFunctionFuncoesFaturamento.CalcularParaItemSubstituidoIpi(Const ACalcularSubstituido, ACalcularIPI : Boolean): Boolean;
begin
  Result := True;

  If ACalcularSubstituido Then
    Exit;

  If ACalcularIPI Then
   Exit;

  Result := False;
end;

class function TFunctionFuncoesFaturamento.CalcularPreComMenosDescForn(
  AParametros: IParametrosCalculoPreComMenosDescForn): Double;
begin
  If AParametros.CalculoSubstituicaoOperacoesProprias = SUBSTITUICAO_OPERACOES_PROPRIAS_ULTIMA_COMPRA Then
  Begin
    Result := CalcularPreComMenosDescFornUltimaCompra(AParametros);
    Exit;
  End;

  Result := CalcularPreComMenosDescFornPrecoCompra(AParametros);
end;

class function TFunctionFuncoesFaturamento.CalcularPreComMenosDescFornPrecoCompra(
  AParametros: IParametrosCalculoPreComMenosDescForn): Double;
begin
  Result := AParametros.PrecoDeCompra;

  Result := Result - ((Result / 100) * AParametros.Desconto01);
  Result := Result - ((Result / 100) * AParametros.Desconto02);
  Result := Result - ((Result / 100) * AParametros.Desconto03);
  Result := Result - ((Result / 100) * AParametros.Desconto04);
  Result := Result - ((Result / 100) * AParametros.Desconto05);
  Result := Result - ((Result / 100) * AParametros.Desconto06);
end;

class function TFunctionFuncoesFaturamento.CalcularPreComMenosDescFornUltimaCompra(
  AParametros: IParametrosCalculoPreComMenosDescForn): Double;
begin
  If AParametros.PrecoDeUltimaCompra = 0 Then
  Begin
    Result := CalcularPreComMenosDescFornPrecoCompra(AParametros);
    Exit;
  End;

  Result := AParametros.PrecoDeUltimaCompra;
end;

class function TFunctionFuncoesFaturamento.CalcularValorDoIVA(
  const ATotalGeralDoItem, AAliquotaIcms, AValorIpi, AValorClienteIvaMT,
  AValorAliquotaSts: Double): Double;
begin
  Result :=
     (((ATotalGeralDoItem * AAliquotaIcms) / 100) +
        (((ATotalGeralDoItem + AValorIpi) * AValorClienteIvaMT) /100)) /
        (((ATotalGeralDoItem + AValorIpi) * AValorAliquotaSts) / 100) ;
end;

class function TFunctionFuncoesFaturamento.CalculaSubsTribSimples: Boolean;
begin
  Result := True;

  If (Self.OptantePorSimplesNacional <> 'S') Then
    Exit;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, varString) <> SUBSTITUIDO_TRIBUTARIO) Then
    Exit;

  Result := False;
end;

class function TFunctionFuncoesFaturamento.CalculaSubTributariaPorDentro(
  ATipoAbreviacaoFiscal: String; AAbreviacaoFiscalICM: Boolean;
  AAbreviacaoCalculoSt: String): Boolean;
begin
  Result := False;

  If Not (Pos(ATipoAbreviacaoFiscal, '_'+PERFIL_DE_CONTRIBUINTE_CONSUMIDOR+
                                     PERFIL_DE_PRODUTOR_RURAL+'_') > 0) Then
    Exit;

  If (Pos(ATipoAbreviacaoFiscal, '_'+PERFIL_DE_CONTRIBUINTE_CONSUMIDOR+
                                     PERFIL_DE_PRODUTOR_RURAL+'_') > 0) And
     (Not(objConfiguracoes.fGetValorConfiguracao(CFG_PERFIL_ICMS_CCO_CONTRIBUINTE_CONSUMIDOR_CALCULO_NORMAL_E_CALCULO_POR_DENTRO, varBoolean))) Then
    Exit;

  If Not (AAbreviacaoFiscalICM) Then
    Exit;

  If (AAbreviacaoCalculoSt <> '2') Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.ClienteIVAEspecialMT(const AClienteEstado, AEstadoEmpresa: String; const AValorClienteIVAEspecialMT: Double): Boolean;
begin
  Result := false;

  If Not (AClienteEstado <> AEstadoEmpresa) Then
    Exit;

  If (Pos(AClienteEstado, MATO_GROSSO + '_' + CEARA + '_') <= 0) Then
    Exit;

  If Not(AValorClienteIVAEspecialMT > 0)Then
    Exit;

  Result := true;
end;

Class function TFunctionFuncoesFaturamento.ClienteOrgaoPublico(
  const AClienteOrgaoPublico, ACalcularDescontoIcmsOrgaoPublico: Boolean) : Boolean;
begin
  Result := false;

  If Not(AClienteOrgaoPublico) Then
    Exit;

  If Not (ACalcularDescontoIcmsOrgaoPublico) Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.ClienteZonaFranca(Const AClienteZonaFranca, AClienteConsumidorFinal: Boolean): Boolean;
begin
  Result := false;

  If Not (AClienteZonaFranca) Then
    Exit;

  If (AClienteConsumidorFinal) Then
    Exit;

  Result := true;
end;


class function TFunctionFuncoesFaturamento.ClienteZonaFrancaOrgaoPublico(
  const AClienteOrgaoPublico, ACalcularDescontoIcmsOrgaoPublico,
  AClienteZonaFranca, AClienteConsumidorFinal: Boolean): Boolean;
begin
  Result := True;

  if ClienteOrgaoPublico(AClienteOrgaoPublico, ACalcularDescontoIcmsOrgaoPublico) Then
    Exit;

  If ClienteZonaFranca(AClienteZonaFranca, AClienteConsumidorFinal) Then
    Exit;

  Result := False;
end;


Class function TFunctionFuncoesFaturamento.TotalGeralItem(Const AClienteConsumidorFinal: Boolean;
  Const ADescontoEspecial: Double; Const AValorFrete : Double; Const AValorTotalItem : Double;
  Const ADespesaAcessoria : Double; Const AOrgaoPublico : Boolean;
  Const AZonaFranca : Boolean; Const ADentroDoEstado : Boolean;
  Const AOpcaoDocumento : String; Const ACalcularSubstituido : Boolean;
  Const ACalcularIPI : Boolean; Const AClienteZonaFrancaComDescontoEspecial: Boolean): Double;
Var
  LDesconto: Double;
  LFreteDespesaAcessoria: Double;
begin
  LDesconto := RetornarValorDescontoTotalGeralItem(ADescontoEspecial,
                                                   AZonaFranca,
                                                   AClienteConsumidorFinal,
                                                   ACalcularSubstituido,
                                                   ACalcularIPI,
                                                   AClienteZonaFrancaComDescontoEspecial);

  LFreteDespesaAcessoria := ValorFreteDespesaAcessoriaItem(AValorFrete,
                                                           ADespesaAcessoria,
                                                           AOrgaoPublico,
                                                           AZonaFranca,
                                                           ADentroDoEstado,
                                                           AOpcaoDocumento,
                                                           ACalcularSubstituido,
                                                           ACalcularIPI);

  Result := AValorTotalItem + LFreteDespesaAcessoria - LDesconto;
end;

class function TFunctionFuncoesFaturamento.TotalGeralItemPreUlt(
  const AClienteConsumidorFinal: Boolean; const ADescontoEspecial, APrecoCusto,
  APrecoUltimaCompra, APrecoEImpostosUltimaCompra, AQuantidadeItem, AValorFrete,
  ADespesaAcessoria: Double; const AOrgaoPublico, AZonaFranca,
  ADentroDoEstado: Boolean; const AOpcaoDocumento: String;
  const ACalcularSubstituido, ACalcularIPI: Boolean): Double;
Var
  LDesconto: Double;
  LFreteDespesaAcessoria: Double;
  LValorCustoVenda: Double;
begin
  LDesconto := RetornarValorDescontoTotalGeralItem(ADescontoEspecial,
                                                   AZonaFranca,
                                                   AClienteConsumidorFinal,
                                                   ACalcularSubstituido,
                                                   ACalcularIPI,
                                                   False);

  LFreteDespesaAcessoria := ValorFreteDespesaAcessoriaItem(AValorFrete,
                                                           ADespesaAcessoria,
                                                           AOrgaoPublico,
                                                           AZonaFranca,
                                                           ADentroDoEstado,
                                                           AOpcaoDocumento,
                                                           ACalcularSubstituido,
                                                           ACalcularIPI);

  LValorCustoVenda := DefinePrecoDeCustoASerUtilizado(APrecoCusto, APrecoUltimaCompra, APrecoEImpostosUltimaCompra);

  Result := objCore.fFormataFloat((LValorCustoVenda * AQuantidadeItem), 2) + LFreteDespesaAcessoria - LDesconto;
end;

class function TFunctionFuncoesFaturamento.ValorFreteDespesaAcessoriaItem(Const AValorFrete : Double;
  Const ADespesaAcessoria : Double; Const AOrgaoPublico : Boolean; Const AZonaFranca : Boolean;
  Const ADentroDoEstado : Boolean; Const AOpcaoDocumento : String;
  Const ACalcularSubstituido : Boolean; Const ACalcularIPI : Boolean): Double;
Var
  LFrete           : Double;
  LDespesa         : Double;
begin
  LDespesa := RetornarValorDespesaAcessoria(ADespesaAcessoria, ACalcularSubstituido);
  LFrete   := RetornarValorDoFrete(AValorFrete,
                                   AOpcaoDocumento,
                                   AOrgaoPublico,
                                   AZonaFranca,
                                   ADentroDoEstado,
                                   ACalcularSubstituido,
                                   ACalcularIPI);
  Result := LFrete + LDespesa;
end;

class function TFunctionFuncoesFaturamento.CodificaChaveNota(ANumeroDocumento, AEspecieDococumento, ACodigoEmpresa, ASerieNota, ACodigoFornecedor : String) : String;
begin
  Result := ANumeroDocumento + AEspecieDococumento + ACodigoEmpresa + InserirEspaco(ASerieNota, 3) + ACodigoFornecedor;
end;

class function TFunctionFuncoesFaturamento.ConfiguradoParaTrocarParaX41: Boolean;
begin
  Result :=
    objConfiguracoes.
      fGetValorConfiguracao(CFG_SIMPLES_NACIONAL_CST41_PRODUTOS_TRIBUTADOS_E_VALOR_ICMS_ZERO, varBoolean);
end;

class function TFunctionFuncoesFaturamento.ItemProvenienteDeIndustrializacao(const AIndustrializacaoOuRevenda : String): Boolean;
begin
  Result := False;

  If (Not objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean)) Then
    Exit;

  If (AIndustrializacaoOuRevenda <> 'I') Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.ConfiguradoParaTrocarParaX41noParana: Boolean;
begin
  Result :=
    objConfiguracoes.
      fGetValorConfiguracao(CFG_SIMPLES_NACIONAL_CST41_PRODUTOS_TRIBUTADOS_E_VALOR_ICMS_ZERO_NO_PARANA, varBoolean);
end;

class function TFunctionFuncoesFaturamento.DecodificaChaveNota(
  const AParametros: IParametrosDecodificaChaveNota): IResultadoDecodificaChaveNota;
Var
  LTamanhoDocumento : Integer;
Begin
  LTamanhoDocumento := AParametros.TamanhoCampoDocumento;

  Result :=
    TResultadoDecodificaChaveNota.New
      .NumeroDoDocumento(LeftStr(AParametros.Chave, LTamanhoDocumento))
      .Serie(Trim(Copy(AParametros.Chave, LTamanhoDocumento + 6, 3)))
      .CodigoDoFornecedor(RightStr(AParametros.Chave, 8))
      .CodigoDaEmpresa(Copy(AParametros.Chave, LTamanhoDocumento + 3, 3))
      .EspecieDoDocumento(Copy(AParametros.Chave, LTamanhoDocumento + 1, 2));
end;

class function TFunctionFuncoesFaturamento.DefinePrecoDeCustoASerUtilizado(const APrecoCusto, APrecoUltimaCompra, APrecoEImpostosUltimaCompra: Double): Double;
begin
  If objConfiguracoes.fGetValorConfiguracao(CFG_CAMPO_PRECO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS) = CUSTO_DE_VENDA Then
  Begin
    Result := APrecoCusto;
    Exit;
  End;

  If objConfiguracoes.fGetValorConfiguracao(CFG_CAMPO_PRECO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS) = CUSTO_DA_ULTIMA_COMPRA Then
  Begin
    Result := APrecoUltimaCompra;
    Exit;
  End;

  Result := APrecoEImpostosUltimaCompra;
end;

class function TFunctionFuncoesFaturamento.DocumentosDeConfirmacaoClienteOrgaoPublicoNaoCalcularIcms(
  const OpcaoDeDocumento: String; const ClienteOrgaoPublico,
  CalcularDescontoIcmsOrgaoPublico: Boolean): Boolean;
begin
  Result := False;

  If (Pos(OpcaoDeDocumento, CONFIRMACAO_CUPOM_FISCAL) <= 0) Then
    Exit;

  If (Not ClienteOrgaoPublico) Then
    Exit;

  If CalcularDescontoIcmsOrgaoPublico Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.ZerarIpiNaoContribuiteIpiUsarORPDMIFFouMIFF(const AUsarMIFF: Boolean; const ATemMIFFEntreOsDevolvidos: Boolean): String;
begin
  Result := ORCAMENTO_PEDIDO_MOVIMENTACAO_ITENS_FATURAMENTO_FUTURO;

  if ATemMIFFEntreOsDevolvidos then
    if (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) then
      Result := Result + DEVOLUCAO;
  
  If not AUsarMIFF Then
    Exit;

  Result := MOVIMENTACAO_ITENS_FATURAMENTO_FUTURO;
end;

class function TFunctionFuncoesFaturamento.ZerarIpiNaoContribuiteIpiEspeciesNaoORPDMIFF(
  const AEspecieDoDocumento: String; AUsarMIFF: Boolean; const ATemMIFFEntreOsDevolvidos: Boolean): Boolean;
begin
  Result := False;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean)) Then
    Exit;

  If (Pos(AEspecieDoDocumento, ZerarIpiNaoContribuiteIpiUsarORPDMIFFouMIFF(AUsarMIFF, ATemMIFFEntreOsDevolvidos)) > 0) Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.EhItemVendaVidro(ACodigo: String; AItemVidro: String = '-1'): Boolean;
begin
  If AItemVidro = '-1' Then
    AItemVidro := objConfiguracoes.fGetValorConfiguracao(CFG_VIDRO_PRODUTO_PARA_VENDA_DE_ESTRUTURAS);

  Result := False;

  If objCore.fEmptyStr(ACodigo) Then
    Exit;

  If (ACodigo <> AItemVidro) Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.EmpresaOptanteSimples(
  const ASimplesNacional: String): Boolean;
begin
  Result := ASimplesNacional = 'S';
end;

class function TFunctionFuncoesFaturamento.SomarIPIClienteConsumidorFinalIVAEspecialMT(const AClienteConsumidorFinal  : Boolean; const AClienteIVAEspecialMT : Boolean; const ASomarIPI: Boolean) : Boolean;
begin
  Result := true;

  if AClienteConsumidorFinal Then
    Exit;

  Result := false;

  If Not (AClienteIVAEspecialMT) Then
    Exit;

 If Not (ASomarIPI) Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.EntraIPInaBaseIcms(const AClienteConsumidorFinal: Boolean; const AClienteIVAEspecialMT: Boolean; const AComercializacao: Boolean; const ASomarIPI: Boolean; const ABaixaDeEntregaFutura: Boolean): Boolean;
begin
  Result := False;

  If ABaixaDeEntregaFutura Then
    Exit;

  If SomarIPIClienteConsumidorFinalIVAEspecialMT(AClienteConsumidorFinal, AClienteIVAEspecialMT, ASomarIPI) Then
  Begin
    If objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean) Then { Contribuinte de IPI }
    Begin
      Result := True;
      Exit;
    End;

    If objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, varBoolean) Then { Usa Importacao Direta }
    Begin
      Result := True;

      If objConfiguracoes.fGetValorConfiguracao(CFG_INDUSTRIALIZACAO_OU_COMERCIALIZACAO_IPI_NA_BASE_CALCULO_DO_ICMS, varBoolean) Then { Pergunta "Industrialização" ou "Comercialização"  }
      Begin
        Result := AComercializacao; { Selecionou Comercialização }
      End
    End;
  End;
end;

class function TFunctionFuncoesFaturamento.fAplicaCargaLiquidaCE(
  const AEstadoCliente: String; const AClienteCargaLiquida: Boolean): Boolean;
Var
  LEstadosConfigurados: String;
begin
  Result := False;

  LEstadosConfigurados := objConfiguracoes.fGetValorConfiguracao(CFG_ESTADOS_QUE_CONSIDERAM_REDUCAO_DE_CARGA_LIQUIDA, varString);

  If objCore.fEmptyStr(LEstadosConfigurados) Then
    Exit;

  If (Pos(AEstadoCliente, LEstadosConfigurados) <= 0) Then
    Exit;

  If Not AClienteCargaLiquida Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.fAtendeRegraFiscalEndEntrega(
  AOpcaoDocumento: String; AAtividadeConstrutora, ADocumentoParaFornecedor: Boolean;
  ARegraFiscal: String): Boolean;
begin
  Result := False;

  If (Pos(AOpcaoDocumento, VENDA_NORMAL_CUPOM_FISCAL_CONDICAO_PAGAMENTO_PEDIDO_ORCAMENTO_DEVOLUCAO_EXPEDICAO_ITENS ) <= 0) Then
    Exit;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_REGRA_FISCAL, varString) = REGFIS_APENAS_ATIVIDADES_CONSTRUTORAS) Then
    If Not AAtividadeConstrutora Then
      Exit;

  If ADocumentoParaFornecedor Then
    Exit;

  If (ARegraFiscal <> REGRA_FISCAL_IMPOSTOS) Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.fAtendeRegrasDifal(
  AClienteInscricaoEstadual : String;
  AChecagemVendaPresencial : Boolean; AClienteConsumidorFinal : Boolean; ADocumentoParaFornecedor,
  ADentroDoEstado, AClienteFilial: Boolean; AOpcaoDocumento: String;
  AEhProdutorRural: Boolean; AClienteIesUni: String; AAtividadeConstrutora: Boolean;
  ATipoAbfCliente: String): Boolean;
Var
  LClienteProdRuralPermiteConsumidorFinal : Boolean;
  LClienteNaoContribuinte          : Boolean;
  LClientePermitidoNaRegra         : Boolean;
begin
  LClienteProdRuralPermiteConsumidorFinal :=
    ClienteProdutorRuralPermiteConsulmidorFinal(AClienteIesUni,
                               AEhProdutorRural);

  LClienteNaoContribuinte :=
    ClienteNaoContribuinte( AClienteInscricaoEstadual,
                            AClienteIesUni,
                            AAtividadeConstrutora,
                            LClienteProdRuralPermiteConsumidorFinal);

  LClientePermitidoNaRegra :=
    ClientePermitidoNaRegra(AChecagemVendaPresencial,
                            LClienteNaoContribuinte,
                            ATipoAbfCliente);

  Result :=
    RetornarRegrasAtendeDifal(AClienteConsumidorFinal,
                              ADocumentoParaFornecedor,
                              ADentroDoEstado,
                              AClienteFilial,
                              LClientePermitidoNaRegra,
                              AOpcaoDocumento);
end;


class function TFunctionFuncoesFaturamento.ClienteProdutorRuralPermiteConsulmidorFinal
 (Const AClienteIesUni : String;
  Const AEhProdutorRural : Boolean) : Boolean;
begin
  Result := false;

  If Not AEhProdutorRural Then
    Exit;

  if (objConfiguracoes.fGetValorConfiguracao(CFG_DIFAL_PRODUTOR_RURAL, varBoolean)) then
    Exit(True);

  If Not(AClienteIesUni = 'S') Then
    Exit;

  Result := True;
end;


class function TFunctionFuncoesFaturamento.ClienteNaoContribuinte(
  Const AClienteInscricaoEstadual : String;
  Const AClienteIesUni : String;
  Const AAtividadeConstrutora : Boolean;
  Const AClienteProdRuralPermiteConsumidorFinal : Boolean):Boolean;
begin
  Result := true;

  If ClienteInscricaoEstadualEAClienteIesUni(AClienteInscricaoEstadual, AClienteIesUni)Then
    Exit;

  If AtividadeConstrutoraOuProdRuralNaoContribuinte(AAtividadeConstrutora, AClienteProdRuralPermiteConsumidorFinal)Then
    Exit;

  Result := false;
end;

class function TFunctionFuncoesFaturamento.AliquotaIcmsConformeRegraMatoGrossoAbreviacao(
  const AClienteConsumidor, blnVerificaClienteConsumidor: Boolean): Boolean;
begin
  Result := True;

  If (Not blnVerificaClienteConsumidor) Then
    Exit;

  If (Not AClienteConsumidor) Then
    Exit;

  Result := False;
end;

Class function TFunctionFuncoesFaturamento.AtividadeConstrutoraOuProdRuralNaoContribuinte(
 Const AAtividadeConstrutora : Boolean;
 Const AClienteProdRuralNaoContribuinte : Boolean) : Boolean;
begin
  Result := true;

  If AAtividadeConstrutora Then
    Exit;

  if AClienteProdRuralNaoContribuinte Then
    Exit;

  Result := false;
end;

Class function TFunctionFuncoesFaturamento.ClienteInscricaoEstadualEAClienteIesUni
(Const AClienteInscricaoEstadual : String;
 Const AClienteIesUni : String) : Boolean;
begin
  Result := false;

  If Not objCore.fEmptyStr(AClienteInscricaoEstadual) Then
    Exit;

  If Not (AClienteIesUni = 'S') Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.ClienteNaoContribuinteVendaPresencial(
  const ATipoAbfCliente : String;
  const AClienteNaoContribuinte : Boolean) : Boolean;
begin
  Result := true;

  If AClienteNaoContribuinte Then
    Exit;

  If (ATipoAbfCliente = PERFIL_DE_CONTRIBUINTE_CONSUMIDOR) Then
    Exit;

  Result := false;
end;

class function TFunctionFuncoesFaturamento.ClientePermitidoNaRegra(
 Const AChecagemVendaPresencial : Boolean;
 Const AClienteNaoContribuinte : Boolean;
 const ATipoAbfCliente : String) : Boolean;
begin

  Result := AClienteNaoContribuinte;

  If Not(AChecagemVendaPresencial) Then
    Exit;

  Result := ClienteNaoContribuinteVendaPresencial(ATipoAbfCliente, AClienteNaoContribuinte);
end;

class function TFunctionFuncoesFaturamento.RetornarRegrasAtendeDifal
 (Const AClienteConsumidorFinal : Boolean; Const ADocumentoParaFornecedor : Boolean;
  Const ADentroDoEstado : Boolean; Const AClienteFilial : Boolean;
  Const AClientePermitidoNaRegra : Boolean; Const AOpcaoDocumento : String ) : Boolean;
begin
  Result := false;

  If Not (AClienteConsumidorFinal) Then
    Exit;

  If (ADocumentoParaFornecedor) Then
    Exit;

  if (ADentroDoEstado) Then
    Exit;

  If (AClienteFilial) Then
    Exit;

  if Not (AClientePermitidoNaRegra) Then
    Exit;

  if Not (Pos(AOpcaoDocumento, CONTA_E_ORDEM) <= 0) Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.fAtividadeConstrutora(
  ACodigoAtividade, ACodigoAtividadeBD: String): Boolean;
begin
  Result := false;

  If (ACodigoAtividade = EmptyStr) Then
    Exit;

  If (ACodigoAtividade <> ACodigoAtividadeBD) Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.fAtendeuAsCondicoes(const ATipoAbreviacaoFiscal: string; const ACodigoFiscal: String; const ADentroDoEstado: Boolean): Boolean;
begin
  Result := false;

  if Not objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_DECRETO_REDUCAO_BASE_IMPOSTOS, varBoolean) Then
    Exit;

  if Not (objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, varString) = SUBSTITUTO_TRIBUTARIO) Then
    Exit;

  If (ATipoAbreviacaoFiscal <> CONTRIBUINTE_NAO_CONSUMIDOR) And (ATipoAbreviacaoFiscal <> SAIDAS_TRANSFERENCIAS_ENTRE_LOJAS) Then
    Exit;

  If Not ADentroDoEstado Then
    Exit;

  If (RightStr(ACodigoFiscal, 2) <> CODIGO_FISCAL_VALOR_BASE_CALCULO_ICMS) Then
    Exit;

  Result := true;

end;

class function TFunctionFuncoesFaturamento.fCalcBeneficioReducaoBaseIcmsST(ATipoAbreviacaoFiscal : String; ACodigoFiscal : String; ADentroDoEstado: Boolean): Boolean;
Var
  LTipoAbreviacaoFiscal : String;
begin
  LTipoAbreviacaoFiscal :=
    AnsiReplaceStr(AnsiReplaceStr(ATipoAbreviacaoFiscal,ABREVIACAO_FISCAL_ENTRADA,''),ABREVIACAO_FISCAL_SAIDA,'');

  Result := fAtendeuAsCondicoes(LTipoAbreviacaoFiscal, ACodigoFiscal, ADentroDoEstado);
end;

class function TFunctionFuncoesFaturamento.AtendeuRegrasUF(const AUFDaEmpresa, AUFEnderecoDeEntrega: string): Boolean;
begin
  Result := false;

  If (Pos(AUFDaEmpresa, 'RS,SC,SP,MG,RJ,PR') <= 0) Then
    Exit;

  if (Pos(AUFEnderecoDeEntrega, 'RS,SC,SP,MG,RJ,PR') > 0) Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.fCalculaAliquotaInterestadual(
  ACodigoDaSubistituicaoTributaria, AUFDaEmpresa,
  AUFEnderecoDeEntrega: String): Double;
begin
  Result := 12;

  If Pos(LeftStr(ACodigoDaSubistituicaoTributaria, 1), '1,2,3,8') > 0 Then
  Begin
    Result := 4;
    Exit;
  End;

  If AtendeuRegrasUF(AUFDaEmpresa, AUFEnderecoDeEntrega) Then
  Begin
    Result := 7;
  End;
end;

class function TFunctionFuncoesFaturamento.fClientSelectEhClientFilialEmpLogada(
  ACodigoCliente, AClienteFilial: String): Boolean;
begin
  Result := false;

  If (objCore.fEmptyStr(ACodigoCliente)) Then
    Exit;

  If (AClienteFilial <> ACodigoCliente) Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.fDentroDoEstadoFaturamento(AClienteEstado: Boolean;
  AVendaPresencial: Boolean): Boolean;
begin
  Result := true;

  if AClienteEstado Then
    Exit;


  if  AVendaPresencial then
    Exit;

  Result := false;
end;

class function TFunctionFuncoesFaturamento.fDentroDoEstado(
  AClienteEstado: String; AClienteEstadoBD : String): Boolean;
begin
  Result := (AClienteEstado = AClienteEstadoBD);
end;

class function TFunctionFuncoesFaturamento.fDentroDoEstadoCFOP(
  AVendaPresencial: Boolean; AClienteEstado: String;
  ADentroDoEstado: Boolean): Boolean;
begin
  Result := ADentroDoEstado;

  If Not AVendaPresencial Then
    Exit;

  Result := true;

  if (objConfiguracoes.fGetValorConfiguracao(CFG_VENDA_PRESENCIAL_UTILIZAR_CFOP) = UTILIZAR_CFOP_INTERNO_VENDA_PRESENCIAL) Then
    Exit;


  If (AClienteEstado= EXTERIOR) Then
    Exit;

  Result := false;
end;

class function TFunctionFuncoesFaturamento.fDocumentoParaFornecedor(
  AOpcaoDocumento: String; ANCFornecedor, ANEFornecedor, ANotaImportacao: Boolean;
  ACodigoCliente, ACodigoFornecedor: String; ARegimeEspecialPorEmpresa: Boolean = False): Boolean;
begin
  Result := true;

  If ValidarOpcaoDeDocumentoEntradaFornecedor(AOpcaoDocumento) Then
    Exit;

  If ValidarOpcaoDeDocumentoOutrasSaidasFornecedor(AOpcaoDocumento) Then
    Exit;

  If ValidarOpcaoDeDocumentoEnvioGarantiaFornecedor(AOpcaoDocumento) Then
    Exit;

  If ValidarOpcaoDeDocumentoNotaComplementoFornecedor(AOpcaoDocumento, ANCFornecedor) Then
    Exit;

  if ANotaImportacao then
    Exit;

  If ValidarOpcaoDeDocumentoNotaEspecialFornecedor(AOpcaoDocumento, ANEFornecedor) Then
    Exit;

  If ValidarOpcaoDeDocumentoVendaNormalFornecedor(AOpcaoDocumento, ACodigoCliente, ACodigoFornecedor) Then
    Exit;

  If ValidarOpcaoDeDocumentoRegimeEspecialConfTE(AOpcaoDocumento, ARegimeEspecialPorEmpresa) Then
    Exit;

  Result := false;
end;

class function TFunctionFuncoesFaturamento.fEhItemConcreto(ASimplesRemessaConcretoDadosCliente : Boolean; AItemConcreto: Boolean): Boolean;
begin
  Result := AItemConcreto;

  If Not (objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = CONCREMASSA) Then
    Exit;

  Result := false;

  If not AItemConcreto Then
    Exit;

  If (ASimplesRemessaConcretoDadosCliente)Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.fEhItemServico(
  ACodigoDoItem: String; ACodigoEmpresa: String = ''): Boolean;
begin
  Result := false;

  If objCore.fEmptyStr(ACodigoEmpresa) Then
    ACodigoEmpresa := objCore.fCodigoDaEmpresa;

  If objCore.fEmptyStr(ACodigoDoItem) Then
    Exit;

  If Not ServicoTerceirizado(ACodigoDoItem, ACodigoEmpresa) Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.ServicoTerceirizado(Const ACodigoDoItem: String; ACodigoEmpresa: String = ''): Boolean;
begin
  Result := true;

  If objCore.fEmptyStr(ACodigoEmpresa) Then
    ACodigoEmpresa := objCore.fCodigoDaEmpresa;

  If ACodigoDoItem = objConfiguracoes.fGetValorConfiguracao(CFG_ITEM_SERVICO_NAO_TERCEIRIZADO, varString, ACodigoEmpresa) Then
    Exit;

  If ACodigoDoItem = objConfiguracoes.fGetValorConfiguracao(CFG_ITEM_SERVICO_TERCEIRIZADO_AUTOCENTER, varString, ACodigoEmpresa)Then
    Exit;

  Result := false;
end;

class function TFunctionFuncoesFaturamento.fEhItemSimplesRemessaConcreto(AOpcaoDocumento                     : String;
                                                                         ATaxaBombeamentoPedidoOrcamento     : Boolean;
                                                                         ASimplesRemessaConcretoDadosCliente : Boolean;
                                                                         AEhItemConcreto                     : Boolean;
                                                                         ASimplesRemessaConcreto             : Boolean): Boolean;
begin

  If (objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = J_A_MASSA_CONCRETO) Then
  Begin

    Result := False;

    If (AEhItemConcreto) Then
    Begin

      If (AOpcaoDocumento = REMESSA_CONCRETO) Then
        Exit;

      If (ATaxaBombeamentoPedidoOrcamento) Then
        Exit;

    End
    Else
    Begin

      If Not ASimplesRemessaConcreto Then
        Exit;

    End;

    Result := True;

  End
  Else
  Begin

    Result := false;

    If Not AEhItemConcreto Then
      Exit;

    Result := ASimplesRemessaConcretoDadosCliente;

    If Not MatchStr(objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL),[PRESTCON,SECOL]) Then
      Exit;

    Result := false;

    If (AOpcaoDocumento = COMPRA_CENTRALIZADA) Then
      Exit;

    If ATaxaBombeamentoPedidoOrcamento Then
      Exit;

    Result := true;

  End;

end;

class function TFunctionFuncoesFaturamento.fEhProdutorRural(
  strProRur: String): Boolean;
begin
  Result := (strProRur = 'S');
end;

class function TFunctionFuncoesFaturamento.fEhRecGarantia(AOpcaoDocumento : String;
  AClassificacaoFiscalRecebimentoGarantia : String): Boolean;
begin
  Result := false;

  If Not(Pos(AOpcaoDocumento, OUTRAS_ENTRADAS_ENTREGA_FUTURA_OUTRAS_SAIDAS_DEVOLUCAO) > 0) Then
    Exit;

  If objCore.fEmptyStr(AClassificacaoFiscalRecebimentoGarantia) Then
    Exit;

  Result :=  true;
end;

class function TFunctionFuncoesFaturamento.fEhDocumentoEnvioFornecedor(const pstrOpcDoc: String): Boolean;
begin
  Result := pstrOpcDoc = ENVIO_GARANTIA_FORNECEDOR;
end;

class function TFunctionFuncoesFaturamento.GetSelectAbreviacaoIpi(const AClassificacaoFiscal: String): String;
Var
  LSQL : String;
  LAbreviacaoPorEmpresa : Boolean;
begin
  LAbreviacaoPorEmpresa := (objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_PIS_COFINS_IPI) = '2');

  LSQL := '';
  LSQL := LSQL + ' SELECT ';

  If (AClassificacaoFiscal < '5000') Then
  begin
    LSQL := LSQL + ' APC_CSTENT AS CST, ';
    LSQL := LSQL + ' APC_ENQIPI AS ENQIPI, ';
    LSQL := LSQL + ' APC_BASENT AS BASE, ';
    LSQL := LSQL + ' APC_ALQENT AS ALQ ';
  end
  else
  begin
    LSQL := LSQL + '  APC_CSTSAI AS CST, ';
    LSQL := LSQL + '  APC_ENQIPI AS ENQIPI, ';
    LSQL := LSQL + '  APC_BASSAI AS BASE, ';
    LSQL := LSQL + '  APC_ALQSAI AS ALQ ';
  end;

  LSQL := LSQL +' FROM ';

  If LAbreviacaoPorEmpresa Then
    LSQL := LSQL +'  ITEGER JOIN '
  Else
    LSQL := LSQL +'  CADITE JOIN ';

  If AClassificacaoFiscal < '5000' Then
    LSQL := LSQL + '  IPIENT '
  Else
    LSQL := LSQL +'  IPISAI ';

  LSQL := LSQL + ' ON APC_CODAPC = ITE_ABFIPI ';

  LSQL := LSQL + ' WHERE ';

  LSQL := LSQL + '  ITE_CODITE = :CODITE  AND ';

  If LAbreviacaoPorEmpresa Then
    LSQL := LSQL + '  ITE_CODEMP = :CODEMP  AND ';

  If AClassificacaoFiscal < '5000' Then
    LSQL := LSQL + '  LOCATE(:CFOP, APC_CFOENT) > 0 '
  Else
    LSQL := LSQL + '  LOCATE(:CFOP, APC_CFOSAI) > 0 ';

  Result := LSQL;
end;

class function TFunctionFuncoesFaturamento.GetSelectAlqIcmEstEmp: String;
begin
  Result := '';
  Result := Result + 'SELECT ABF_ALQICM_SAI_NCO ';
  Result := Result + '  FROM ABFICM ';
  Result := Result + ' WHERE ABF_CODABF = :CODABF ';
  Result := Result + '   AND ABF_ESTADO = :ESTADO ';
end;

class function TFunctionFuncoesFaturamento.GetSelectClienteFilial: String;
begin
  Result := 'SELECT GROUP_CONCAT(EMP_CLIFIL) '+
            '  FROM '+
            '    CADEMP ';
end;

class function TFunctionFuncoesFaturamento.GetSelectFornecedorFilial: String;
begin
  Result := 'SELECT GROUP_CONCAT(EMP_FORFIL) '+
            '  FROM '+
            '    CADEMP ';

end;

class function TFunctionFuncoesFaturamento.GetSelectTemAliquotaEcf: String;
begin
  Result := '';
  Result := Result + ' SELECT * ';
  Result := Result + ' FROM ';
  Result := Result + '   ECFALQ ';
  Result := Result + ' WHERE ';
  Result := Result + '   ECF_CODECF = :CODECF ';
end;

class function TFunctionFuncoesFaturamento.fGetSelectTipoAbfCliente: String;
begin
  Result := ' SELECT '+
            '   CASE '+
            '     WHEN CLI_CGCCPF = 1 THEN "J" '+
            '     ELSE "F"                     '+
            '   END AS FISJUR,                 '+
            '   CLI_I_E_S_ AS I_E_S_,'+
            '   CLI_CODATI AS CODATI,'+
            '   CLI_CONSUM AS CONSUM,'+
            '   CLI_PRORUR AS PRORUR,'+
            '   CLI_MICEMP AS MICEMP,'+
            '   CLI_INDUST AS INDUST,'+
            '   CLI_REGTRI AS REGTRI '+
            ' FROM'+
            '   CADCLI'+
            ' WHERE'+
            '   CLI_CODCLI = :CODCLI';
end;

class function TFunctionFuncoesFaturamento.fGetSelectTipoAbfFornecedor: String;
begin
  Result := ' SELECT ' +
            '   CASE '+
            '     WHEN FOR_CGCCPF = 1 THEN "J" '+
            '     ELSE "F"                     '+
            '   END AS FISJUR,                 '+
            '   FOR_I_E_S_ AS I_E_S_, ' +
            '   FOR_SIMPAU AS SIMPAU, ' +
            '   FOR_MATREV AS TIPFOR  ' +
            ' FROM ' +
            '   CADFOR ' +
            ' WHERE ' +
            '   FOR_CODFOR = :CODFOR';
end;

class function TFunctionFuncoesFaturamento.fGetTipoAbf(AClienteOuFornecedor, APessoaFisicaOuJuridica,
  AInscricaoEstadual, AConsumidorFinal, ACodigoAtividade, AProdutorRural, AMicroEmpreendedor, ARegimeTributacao, ATipoFornecedor,
  AIndustria, AFilial: String; AAtividadeConstrutora : Boolean): String;
begin
  //(F)ornecedor
  If AClienteOuFornecedor = 'F' Then //(F)ornecedor ou (C)(C)liente
  Begin
    Result := '_ENT_';

    If ARegimeTributacao = 'S' Then
    Begin
      If (ATipoFornecedor = 'I') Or (ATipoFornecedor = 'Y') Then
        Result := Result + 'PSI' //PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)
      Else
        Result := Result + 'PES' //PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)
    End
    Else If objCore.fEmptyStr(AInscricaoEstadual) Or (APessoaFisicaOuJuridica = 'F') Then//(F)isica ou (J)uridica
      Result := Result + 'PEF' //PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)
    Else If ATipoFornecedor = 'I' Then
      Result := Result + 'PEJ' //PEJ - PESSOA JURIDICA (INDUSTRIA)
    Else If ATipoFornecedor = 'Y' Then
      Result := Result + 'PII' //ENTRADAS PESSOA JURIDICA ( INDUSTRIA INCENTIVADA )
    Else
      Result := Result + 'PER';//PER - PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZACAO)
  End
  //(C)(C)liente
  Else
  Begin
    Result := '_SAI_';

    If AFilial = 'S' Then
      Result := Result + 'TRS'//TRS - SAIDAS TRANSFERENCIAS ENTRE LOJAS

    Else If AProdutorRural = 'S' Then
      Result := Result + 'PRU'//PRU - PRODUTOR RURAL

    Else If AIndustria = 'S' Then
      Result := Result + 'IND'//IND - SAIDA INDUSTRIA

    Else If ARegimeTributacao = 'S' Then
      Result := Result + 'SNA'//SNA - SIMPLES NACIONAL

    Else If AAtividadeConstrutora Then
      Result := Result + 'CTA'//CTA - CONSTRUTORA

    Else If (APessoaFisicaOuJuridica = 'F') And (AMicroEmpreendedor = 'S') And (not objCore.fEmptyStr(AInscricaoEstadual)) Then
      Result := Result + 'CCO'//CCO - CONTRIBUINTE CONSUMIDOR MICRO EMPREENDEDOR INDIVIDUAL

    Else If (objCore.fEmptyStr(AInscricaoEstadual) And (AMicroEmpreendedor <> 'S')) Or (APessoaFisicaOuJuridica = 'F') Then//(F)isica ou (J)uridica
      Result := Result + 'NCO'//NCO - NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)

    Else If AConsumidorFinal = 'S' Then
      Result := Result + 'CCO'//CCO - CONTRIBUINTE CONSUMIDOR

    Else
      Result := Result + 'CNC';//CNC - CONTRIBUINTE NAO CONSUMIDOR
  End;

end;

class function TFunctionFuncoesFaturamento.fRetClienteFilial(const ACodigoCliente, AClientesFilial: string): String;
begin
  Result := 'N';

  If Pos(ACodigoCliente, AClientesFilial) > 0 Then
    Result := 'S';
end;

class function TFunctionFuncoesFaturamento.fGetTipoAbfCliente(
  const ACodigoCliente: String; APessoaFisicaOuJuridica, AInscricaoEstadual,
  AConsumidorFinal, ACodigoAtividade, AProdutorRural, AMicroEmpreendedor,
  ARegimeTributacao, ATipoFornecedor, AIndustria, AClientesFilial: String;
  AAtividadeConstrutora : Boolean): String;
var
  LClienteFilial: string;
begin
  LClienteFilial := fRetClienteFilial(ACodigoCliente, AClientesFilial);

  Result := Self.fGetTipoAbf('C', APessoaFisicaOuJuridica, AInscricaoEstadual, AConsumidorFinal, ACodigoAtividade, AProdutorRural,
    AMicroEmpreendedor, ARegimeTributacao, ATipoFornecedor, AIndustria, LClienteFilial, AAtividadeConstrutora);
end;

class function TFunctionFuncoesFaturamento.fItemConcreto(
  AEhItemEstrutura: Boolean; AItemPorEmpresa,
  AProdutoConcreto: String): Boolean;
begin
 Result :=
   objConfiguracoes.
     fGetValorConfiguracao(CFG_UTILIZAR_NOTA_FISCAL_CONCRETO, varBoolean, AItemPorEmpresa) And AEhItemEstrutura;

  If Result Then
  Begin
    If objConfiguracoes.
      fGetValorConfiguracao(CFG_QUANTO_UTILIZAR_NOTA_CONCRETO_IDENTIFICAR_CADASTRO_PRODUTO_CONCRETO, varBoolean, AItemPorEmpresa) Then
    begin
      Result := AProdutoConcreto = 'S';
    end;
  End;
end;

class function TFunctionFuncoesFaturamento.fItemEstrutura(
  ACount: Integer): Boolean;
begin
  Result := ACount > 0;
end;

class function TFunctionFuncoesFaturamento.MicroEmpreendedorOuPossuiIES(
  Const AClienteIes : String;
  Const AMicroEmpreendedor : Boolean) : Boolean;
begin
  result := true;

  If Not objCore.fEmptyStr(AClienteIes)  Then
    Exit;

  If AMicroEmpreendedor Then
    Exit;

  result := false;
end;

class function TFunctionFuncoesFaturamento.PerfilAbreviacaoNaoConsumidorOuIndustria(
  const ATipoAbreviacaoFiscal: String): Boolean;
begin
  If SameText(ATipoAbreviacaoFiscal, ABREVIACAO_FISCAL_SAIDA + CONTRIBUINTE_NAO_CONSUMIDOR) Then
    Exit(True);

  If SameText(ATipoAbreviacaoFiscal, ABREVIACAO_FISCAL_SAIDA + SAIDAS_INDUSTRIA) Then
    Exit(True);

  Result := False;
end;

Class function TFunctionFuncoesFaturamento.fPodeTerReducaoRICMPRDefinidaNoCadastroAbreviacao: Boolean;
begin
  Result := False;

  If objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICMS_DA_ABREVIACAO_FISCAL, varBoolean) Then
    Exit(True);

  If objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICMS_DA_ABREVIACAO_FISCAL_DIFERENCIADA, varBoolean) Then
    Exit(True);
end;

class function TFunctionFuncoesFaturamento.ItemSubstituido(const ADentroDoEstado: Boolean; const ACodigoDaSubstituicaoTributariaDoItem: String;
  const AUtilizaDecretoReducaoRICMSdaAbreviacao: Boolean; const ACodigoAbreviacaoFiscal : String; const AConsumidorFinal: Boolean; const AClienteInscricaoEstadual: String; const AClienteMicroEmpreendedor : Boolean): Boolean;
  Var
    LItemPossuiReducaoBaseConfRICMPR : Boolean;
begin
  LItemPossuiReducaoBaseConfRICMPR :=
    TFunctionFuncoesFaturamento.fItemPossuiReducaoBaseConfRICMPR(ADentroDoEstado,
                                                                 AConsumidorFinal,
                                                                 AClienteInscricaoEstadual,
                                                                 AClienteMicroEmpreendedor,
                                                                 ACodigoDaSubstituicaoTributariaDoItem,
                                                                 AUtilizaDecretoReducaoRICMSdaAbreviacao,
                                                                 ACodigoAbreviacaoFiscal);

  If LItemPossuiReducaoBaseConfRICMPR Then
    Result := (Pos(ACodigoDaSubstituicaoTributariaDoItem, objConstantes.fGetCstSubstituicao) > 0)
  Else
    Result := (Pos(ACodigoDaSubstituicaoTributariaDoItem, objConstantes.fGetCstSubstituicao + objConstantes.fGetCstAntecipacaoIcms) > 0);
end;

class function TFunctionFuncoesFaturamento.EhDevolucaoOuOutrasEntradas(const AOpcaoDocumento, AEntradaOuSaidaDoItem: String): Boolean;
begin
  Result := True;

  If (Pos(AOpcaoDocumento, OUTRAS_ENTRADAS_ENTREGA_FUTURA_DEVOLUCAO_PEDIDO_DEVOLUCAO_RETIRADA) > 0) Then
    Exit;

  If ((AOpcaoDocumento = TROCA_MERCADORIA) And (AEntradaOuSaidaDoItem = ENTRADA)) Then
    Exit;

  If ((AOpcaoDocumento = NOTA_COMPLEMENTO) And (AEntradaOuSaidaDoItem = ENTRADA)) Then
    Exit;

  Result := False;
end;

class function TFunctionFuncoesFaturamento.fItemPossuiReducaoBaseConfRICMPR(
  ADentroDoEstado, AClienteConsumidorFinal: Boolean; AClienteIes: String;
  AMicroEmpreendedor: Boolean;
  ACodigoDaSubstituicaoTributariaDoItem: String;
  AUtilizaDecretoReducaoRICMSdaAbreviacao: Boolean;
  ATipoDeAbrevicaoDoCliente : String): Boolean;
begin
  Result := false;

  If Not ADentroDoEstado Then
    Exit;

  if Not objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICM_PR, varBoolean)  Then
    Exit;

  If (AClienteConsumidorFinal) and (ATipoDeAbrevicaoDoCliente <> '_SAI_SNA') Then
    Exit;

  if Not MicroEmpreendedorOuPossuiIES(AClienteIes, AMicroEmpreendedor) Then
    Exit;

  If Not(Pos(ACodigoDaSubstituicaoTributariaDoItem, objConstantes.fGetCstSubstituicao) <= 0) Then
    Exit;

  If Not (Pos(ACodigoDaSubstituicaoTributariaDoItem, ISENTO_NAO_TRIBUTADO) <= 0) Then
    Exit;

  Result := true;

  If Not fPodeTerReducaoRICMPRDefinidaNoCadastroAbreviacao Then
    Exit;

  Result := AUtilizaDecretoReducaoRICMSdaAbreviacao;
end;

class function TFunctionFuncoesFaturamento.fItemRevInd(const AIndustrializacaoRevendaCADITE,
  AIndustrializacaoRevendaITEGER: String): String;
begin
  Result := AIndustrializacaoRevendaITEGER;

  If objConfiguracoes.fGetValorConfiguracao(CFG_INDUSTRIALIZACAO_OU_REVENDA) = '1' Then
    Result := AIndustrializacaoRevendaCADITE;
end;

class function TFunctionFuncoesFaturamento.fRetCodEmpClienteFilial(
  strCodEmp: String): String;
begin
  Result := strCodEmp;
end;

class function TFunctionFuncoesFaturamento.RetornaAliquotaIcmConformeRegraMatoGrosso(const AAlqIcmSimples, AAlqIcmAbr: Double;
      const ADentroDoEstado: Boolean; const ClienteConsumidor: Boolean; const blnVerificaClienteConsumidor: Boolean = False): Double;
begin
  Result := AAlqIcmSimples;

  If objConfiguracoes.fGetValorConfiguracao(CFG_QUANDO_SIMPLES_NACIONAL_DENTRO_ESTADO_CALCULAR_VALOR_ST_COM_ALIQUOTA_INTERNA_SIMPLES_NACIONAL, varBoolean) Then
    Exit;

  If (Self.OptantePorSimplesNacional <> 'S') Then
    Exit;

  If (Not ADentroDoEstado) Then
    Exit;

  If (Not objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean)) Then
    Exit;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA) <> SUBSTITUTO_TRIBUTARIO) Then
    Exit;

  If Not AliquotaIcmsConformeRegraMatoGrossoAbreviacao(ClienteConsumidor, blnVerificaClienteConsumidor) Then
    Exit;

  Result := AAlqIcmAbr;
end;

class function TFunctionFuncoesFaturamento.fRetornaClienteFilial(
  ACodigoEmpEmpresa: String; ACodigoClienteFilial : String;
  ACodigoFornecedorFilial : String; AForncedorOuCliente : String = 'C'): String;
begin
  Result := '';

  If objCore.fEmptyStr(ACodigoEmpEmpresa) Then
    Exit;

  Result := ACodigoClienteFilial;

  If AForncedorOuCliente = 'C' Then
    Exit;

  Result := ACodigoFornecedorFilial;
end;

class function TFunctionFuncoesFaturamento.fRetornaIesUni(
  strIesUni: String): String;
begin
  Result := strIesUni;
end;

class function TFunctionFuncoesFaturamento.ResultadoCamparacaoAliquotaEcf(
  const AAliquotaEcf, AAliquotaCalculada: Double): Boolean;
begin
  Result := (AAliquotaEcf = AAliquotaCalculada);
end;

class function TFunctionFuncoesFaturamento.RetornarClienteFisicoOuJuridico(
  const AOpcaoDigitadaClienteConsumidor: Integer): String;
begin
  Result := 'F';

  If AOpcaoDigitadaClienteConsumidor > 1 Then
    Exit;

  Result := 'J';
end;

class function TFunctionFuncoesFaturamento.RetornarClienteIndustria(
  const AClienteTipoOperacao: String;
  AClienteIndustria: String): Boolean;
begin
  Result := AClienteIndustria = 'S';

  If objConfiguracoes.fGetValorConfiguracao(CFG_DEFINIR_CONSUMO_OU_REVENDA_VENDAS, VarBoolean) Then
    Result := (AClienteTipoOperacao = INDUSTRIALIZACAO);
end;

class function TFunctionFuncoesFaturamento.RetornarCodigoEmpresa(
  const ACodigoDaEmpresaTE, ACodigoDaEmpresa: String): String;
begin
  Result := ACodigoDaEmpresaTE;

  If objCore.fEmptyStr(ACodigoDaEmpresaTE) Then
    Result := ACodigoDaEmpresa;
end;

class function TFunctionFuncoesFaturamento.RetornarColunasCadastroClienteRetencaoPisCofins(
  const AMostrarColunaCDESPI: Boolean): String;
begin
  Result :='  CLI_RETPCO AS RETPCO, ' +
           '  CLI_RETIRF AS RETIRF, ' ;

  If AMostrarColunaCDESPI Then
    Result := Result + '  CLI_CDESPI AS CDESPI, ';
end;

class function TFunctionFuncoesFaturamento.RetornarColunasCadastroClienteRetencaoPisCofinsDefault(
  const AMostrarColunaCDESPI: Boolean): String;
begin
  Result :='  "N" AS RETPCO, ' +
           '  "N" AS RETIRF, ' ;

  If AMostrarColunaCDESPI Then
    Result := Result + '  "N" AS CDESPI, ';
end;

class function TFunctionFuncoesFaturamento.RetornarListaDeClienteFilial(
 Const AListaClienteFilial: String): String;
Var
  LStringList : TStringList;
  LContador   : Integer;
  LLista      : String;
begin
  Try
    LStringList := TStringList.Create;
    LStringList.Delimiter := ',';
    LStringList.StrictDelimiter := true;
    LStringList.DelimitedText := AListaClienteFilial;

    for LContador := 0 To LStringList.Count -1 Do
      LLista := LLista + QuotedStr(LStringList[LContador]) + ',';

    Result := Copy( LLista, 1, Length( LLista ) - 1 );

    If objCore.fEmptyStr(Result) Then
      Result := '""';

  Finally
    FreeAndNil(LStringList);
  End;

end;

class function TFunctionFuncoesFaturamento.RetornarListaDeFornecedorFilial(
  const AListaClienteFilial: String;
  const AApresentarComVirgula: Boolean): String;
Var
  LStringList : TStringList;
  LContador   : Integer;
  LLista      : String;
begin
  Try
    LStringList := TStringList.Create;
    LStringList.Delimiter := ',';
    LStringList.StrictDelimiter := true;
    LStringList.DelimitedText := AListaClienteFilial;

    for LContador := 0 To LStringList.Count -1 Do
    begin
      If AApresentarComVirgula Then
        LLista := LLista+ '"' + LStringList[LContador] + '", '
      else
        LLista := LLista + LStringList[LContador] + '_'
    end;

    If AApresentarComVirgula Then
      Result := Copy( LLista, 1, Length( LLista ) - 2 )
    else
      Result := Copy( LLista, 1, Length( LLista ) - 1 );


    If objCore.fEmptyStr(Result) Then
      Result := '""';

  Finally
    FreeAndNil(LStringList);
  End;
end;

class function TFunctionFuncoesFaturamento.fRetSelectCodEmpClienteFilial: String;
begin
  Result := ' SELECT EMP_CODEMP ' +
            '   FROM CADEMP ' +
            '  WHERE EMP_CLIFIL = :CLIFIL';
end;

class function TFunctionFuncoesFaturamento.fRetUFEmpresa(
  AUFDaEmpresa: String): String;
begin
  Result := AUFDaEmpresa;
end;

class function TFunctionFuncoesFaturamento.TaxaBombeamentoPedidoOrcamento(const AOpcaoDocumento                : String;
                                                                          const AConfirmandoNotaFiscalConcreto : Boolean;
                                                                          const AItemConcreto                  : Boolean): Boolean;
begin

  If (objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = J_A_MASSA_CONCRETO) Then
  Begin

    Result := False;

    If Not AItemConcreto Then
      Exit;

    If Not (AOpcaoDocumento = ESPECIE_PEDIDO) Then
      Exit;

    Result := True;

  End
  Else
  Begin

    Result := false;

    If Not AConfirmandoNotaFiscalConcreto Then
      Exit;

    If Not (Pos(AOpcaoDocumento , PEDIDO_ORCAMENTO) > 0) Then
      Exit;

    If Not (objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = SECOL) Then
      Exit;

    Result := True;

  End;

end;

class function TFunctionFuncoesFaturamento.Transform(AConteudo: String;
  AStep: Shortint; AChar: String): String;
  Var
    LAux       : String;
    LPosicao   : Integer;
    LTamanho   : Integer;
begin
  LAux := '';

  LPosicao := 1;
  LTamanho := Length(AConteudo);

  If (AStep = 1) Then
    LTamanho := LTamanho + 1;

  While LPosicao < LTamanho Do
  Begin
    LAux := LAux + Copy(AConteudo, LPosicao, AStep) + AChar;
    Inc(LPosicao, AStep);
  End;

  Result := LAux;

end;

class function TFunctionFuncoesFaturamento.TributarNaAliquotaInternaDoEstado(
  const AClienteEstado, AEstadoDaEmpresa, AClienteIes: String): Boolean;
begin
  Result := False;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_VENDA_FORA_ESTADO_NAO_CONTRIBUINTE_TRIBUTAR_ALIQUOTA_INTERNA_ESTADO, varBoolean) Then
    Exit;

  If (AClienteEstado = AEstadoDaEmpresa) Then
    Exit;

  If (Not objCore.fEmptyStr(AClienteIes)) Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.fTrocaUFEndEntrega(
  AAtendeRegraFiscalEndEntrega: Boolean; AEstadoEntrega: String; AClienteEstado: String): String;
begin
  Result := AClienteEstado;

  If Not AAtendeRegraFiscalEndEntrega Then
    Exit;

  If objCore.fEmptyStr(AEstadoEntrega) Then
    Exit;

  Result := AEstadoEntrega
end;

class function TFunctionFuncoesFaturamento.GetCliIVAEspMT(
  const ADocumentoParaFornecedor: Boolean; const AClienteIES, AClienteEstado: String;
  const AClienteIVAESP: Double; const AExisteNaTabelaCEDEM: Boolean;
  const AClienteIVAESPCedem: Double): Double;
begin
  Result := 0.0000;

  If (ADocumentoParaFornecedor) Then
    Exit;

  If (objCore.fEmptyStr(AClienteIES)) Then
    Exit;

  If (Pos(AClienteEstado, MATO_GROSSO + '_' + CEARA + '_') <= 0) Then
    Exit;

  If AExisteNaTabelaCEDEM Then
  Begin
    Result := AClienteIVAESPCedem;
    Exit;
  End;

  Result := AClienteIVAESP;
end;


class function TFunctionFuncoesFaturamento.GetCliIVANacMT(const ADocumentoParaFornecedor: Boolean;
      const AClienteIES, AClienteEstado: String; const AClienteIVANAC: Double; const AExisteNaTabelaCEDEM: Boolean;
      const AClienteIVANACCedem: Double): Double;
begin
  Result := 0.0000;

  If ADocumentoParaFornecedor Then
    Exit;

  If objCore.fEmptyStr(AClienteIES) Then
    Exit;

  If (Pos(AClienteEstado, MATO_GROSSO + '_' + CEARA + '_') <= 0) Then
    Exit;

  If AExisteNaTabelaCEDEM Then
  Begin
    Result := AClienteIVANACCedem;
    Exit;
  End;

  Result := AClienteIVANAC;
end;

class function TFunctionFuncoesFaturamento.GetCliIVASimMT(const ADocumentoParaFornecedor: Boolean;
      const AClienteIES, AClienteEstado: String;
      const AClienteIVASIM: Double; const AExisteNaTabelaCEDEM: Boolean;
      const AClienteIVASIMCedem: Double): Double;
begin
  Result := 0.0000;

  If (ADocumentoParaFornecedor) Then
    Exit;

  If (objCore.fEmptyStr(AClienteIES)) Then
    Exit;

  If (Pos(AClienteEstado, MATO_GROSSO + '_' + CEARA + '_') <= 0) Then
    Exit;

  If AExisteNaTabelaCEDEM Then
  Begin
    Result := AClienteIVASIMCedem;
    Exit;
  End;

  Result := AClienteIVASIM;
end;

class function TFunctionFuncoesFaturamento.GetDadosAbf: String;
begin
  Result := 'SELECT SQL_NO_CACHE * FROM ABFICM ';
  Result := Result + 'WHERE ABF_CODABF = :CODABF AND ABF_ESTADO = :ESTADO';
end;

class function TFunctionFuncoesFaturamento.ImportacaoDireta(
  const AImportacaoDiretaItem: String): Boolean;
begin

  Result := false;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, varBoolean) Then
    Exit;

  If AImportacaoDiretaItem <> 'S' Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.ImportacaoDiretaDoItem(
  const AImportacaoDiretaCadIte, AImportacaoDiretaIteGer: String): String;
begin
  If objConfiguracoes.fGetValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS) = IGUAL_PARA_TODAS_AS_EMPRESAS Then
  Begin
    Result := AImportacaoDiretaCadIte;
    Exit;
  End;

  Result := AImportacaoDiretaIteGer;
end;

class function TFunctionFuncoesFaturamento.fTexto(Const AQuoted, ASeQuotedUseAspas :Boolean;  ATexto : String )   : String;
Begin
  Result := IfThen(AQuoted, IfThen(ASeQuotedUseAspas, '"'+ATexto+'"', QuotedStr(ATexto)), ATexto);
End;

class procedure TFunctionFuncoesFaturamento.IncrementaListaStr(
  const ATexto: String; Var strLista: String; const AQuoted, ASeQuotedUseAspas: Boolean;
  const AchrSepara: Char; const AEspaca, AIgnoraRepetido: Boolean);
Var
  SL: TStringList;
begin
  If AIgnoraRepetido Then
  Begin

    SL := TStringList.Create;

    Try
      ExtractStrings([AchrSepara], [' '], pChar(strLista), SL);

      If SL.IndexOf(fTexto(AQuoted, ASeQuotedUseAspas, ATexto) ) = -1 Then
        strLista := strLista + IfThen(strLista = '', '', AchrSepara + IfThen(AEspaca, ' ', '')) + fTexto(AQuoted, ASeQuotedUseAspas, ATexto);

    Finally
      FreeAndNil(SL)
    End;
  End
  Else
  Begin
    strLista := strLista + objCore.IIF(strLista = '', '', AchrSepara + objCore.IIF(AEspaca, ' ', '')) + fTexto(AQuoted, ASeQuotedUseAspas, ATexto);
  End;
end;

class function TFunctionFuncoesFaturamento.InserirEspaco(AString : String; ATamanho, APosicao: Integer): String;
Var
	LContador : integer;
Begin
  Case APosicao Of
  	1 : For LContador := Length(AString) To ATamanho -1 Do
		  	  AString := AString + ' ';

    2 : For LContador := Length(AString) To ATamanho -1 Do
    		  AString := ' ' + AString;
  End;

  InserirEspaco := AString;

end;

class function TFunctionFuncoesFaturamento.IsentaImpostosEspeciesZerar(
  const ADesmembrarMeiaNotaComNotaNormal: Boolean): String;
begin
  Result := ISENTA_IMPOSTOS_ESPECIES_ZERAR;

  If Not ADesmembrarMeiaNotaComNotaNormal Then
    Result := Result + MOVIMENTACAO_ITENS_FATURAMENTO_FUTURO;
end;

class function TFunctionFuncoesFaturamento.ItemAmpara(const AItemUtilizaAmpara: String): Boolean;
begin
  Result := (AItemUtilizaAmpara = 'S');
end;

class function TFunctionFuncoesFaturamento.ItemTributado(
  const ACodigoDaSubstituicaoTributariaDoItem: String): Boolean;
begin
  Result := (Pos(ACodigoDaSubstituicaoTributariaDoItem, objConstantes.fGetCstTributado) > 0);
end;

class function TFunctionFuncoesFaturamento.LocalizarEstado(
  const AOpcaoEstadoItem, AEstadoParaLocalizar: String): Boolean;
begin
  Result := Pos(AOpcaoEstadoItem, AEstadoParaLocalizar) > 0;
end;

class function TFunctionFuncoesFaturamento.LocalizarOpcaoDeDocumento(
  const AOpcaoDocumentoItem: String; const ADocumentoParaLocalizar: String): Boolean;
begin
  Result := Pos(AOpcaoDocumentoItem , ADocumentoParaLocalizar) > 0;
end;

class function TFunctionFuncoesFaturamento.OptantePorSimplesNacional(const strCodEmp : String = ''): String;
begin
  Result := objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, varString, strCodEmp);
end;

class function TFunctionFuncoesFaturamento.OrcamentoOutraLojaF11(
  const AOrigemF11: Boolean; const ACodigoEmpresaOriginal: String; const ACodigoEmpresa: String;
  const ANumeroOrcamento: String): Boolean;
begin
  Result := False;

  If Not AOrigemF11 Then
    Exit;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_FATURAR_ORCAMENTOS_OUTRAS_LOJAS_QUANTO_UTILIZAR_F11, varBoolean) Then
    Exit;

  If ACodigoEmpresaOriginal = ACodigoEmpresa Then
    Exit;

  If objCore.fEmptyStr(ANumeroOrcamento) Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.PercentualProvisorioPartilha(
  AExercicio: TDateTime): Double;
Var
  LExercicio : Word;
begin
  LExercicio := YearOf(AExercicio);

  Case LExercicio Of
    2015:
      Result := 20;
    2016:
      Result := 40;
    2017:
      Result := 60;
    2018:
      Result := 80;
    Else
      Result := 100;
  End;
end;

class function TFunctionFuncoesFaturamento.ProdutoAliquotaCofins: Double;
begin
  Result := (objConfiguracoes.fGetValorConfiguracao(CFG_PRODUTO_ALIQUOTA_COFINS, varDouble)); //fCfgSis('ALCOFP', varDouble)
end;

class function TFunctionFuncoesFaturamento.ProdutoAliquotaPis: Double;
begin
  Result := (objConfiguracoes.fGetValorConfiguracao(CFG_PRODUTO_ALIQUOTA_PIS, varDouble)); //fCfgSis('ALPISP', varDouble)
end;

class function TFunctionFuncoesFaturamento.ProdutoComOrigemDaMercadoriaEstrangeira(
  const ACodigoDaSubstituicaoTributaria: String): Boolean;
begin
  Result := Pos(LeftStr(ACodigoDaSubstituicaoTributaria, 1), '1_2_') > 0;
end;

class function TFunctionFuncoesFaturamento.ProdutoSubstituidoFaturamento(
  ACodigoFiscal: String): Boolean;
begin
  Result := Pos(RightStr(ACodigoFiscal, 2), PRODUTO_SUBSTITUIDO_FATURAMENTO) > 0;
end;

class function TFunctionFuncoesFaturamento.RetornarValorDescontoTotalGeralItem(
  const ADescontoEspecial: double; const AZonaFranca, AClienteConsumidorFinal,
  ACalcularSubstituido, ACalcularIPI, AClienteZonaFrancaComDescontoEspecial: boolean): Double;
begin
  result := ADescontoEspecial;
  result := AjustarDescontoEspecialZonaFrancaEClienteNaoConsumidor(result,
                                                                   AZonaFranca,
                                                                   AClienteConsumidorFinal,
                                                                   ACalcularSubstituido,
                                                                   ACalcularIPI,
                                                                   AClienteZonaFrancaComDescontoEspecial);
end;

class function TFunctionFuncoesFaturamento.RetornarValorDespesaAcessoria(const ADespesaAcessoria: double; const ACalcularSubstituido: boolean): double;
begin
  result := ADespesaAcessoria;

  If not ACalcularSubstituido Then
    Exit;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_DESPESAS_ACESSORIA, varBoolean)) Then
    Exit;

  result := 0;
end;

Class function TFunctionFuncoesFaturamento.RetornarValorDoFrete(Const AValorFreteItem : Double; Const AOpcaoDocumento : String;
  Const AOrgaoPublico, AZonaFranca, ADentroDoEstado, ACalcularSubstituido, ACalcularIPI: Boolean): Double;
begin
  Result := AValorFreteItem;

  If ZerarFreteParaOrgaoPublicoZonaFrancaDentroDoEstado(AOrgaoPublico, AZonaFranca, ADentroDoEstado)Then
    Result := 0;

  If (AOpcaoDocumento = REMESSA_POR_CONTA_E_ORDEM) Then
    Result := 0;

  If ACalcularSubstituido Then
  Begin
    If (Not objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_FRETE, varBoolean)) Then
      Result  := 0;
  End;

  If ACalcularIPI Then
  Begin
    If ZerarFreteParaContribuinteIpi Then
    Begin
      Result := 0;
    End;
  end;

end;

class function TFunctionFuncoesFaturamento.fGetCodAbf(ACodigoAbreviacaoTodasEmpresas,
  ACodigoAbreviacaoPorEmpresas: String; ACodigoDaEmpresa: String): String;
begin
  Result := ACodigoAbreviacaoTodasEmpresas;

  If objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, varString, ACodigoDaEmpresa) = '1' Then
    Exit;

  Result := ACodigoAbreviacaoPorEmpresas;
end;

class function TFunctionFuncoesFaturamento.SqlAbfIcm(const ACodigoDaEmpresaTE: String; const ACodigoDaEmpresa: String): String;
var
  LCodigoDaEmpresa: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  A.*, ';
  Result := Result + '  I.ITE_MENFIS, ';
  Result := Result + '  I.ITE_CODITE  ';
  Result := Result + 'FROM            ';
  Result := Result + '  CADITE I      ';

  LCodigoDaEmpresa := RetornarCodigoEmpresa(ACodigoDaEmpresaTE, ACodigoDaEmpresa);

  If objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, varString, LCodigoDaEmpresa) = IGUAL_PARA_TODAS_AS_EMPRESAS then
    Result := Result + '  JOIN ABFICM A ON A.ABF_CODABF = I.ITE_CODABF '
  Else
  Begin
    Result := Result + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE AND G.ITE_CODEMP = "' + LCodigoDaEmpresa + '" ';
    Result := Result + '  JOIN ABFICM A ON A.ABF_CODABF = G.ITE_CODABF ';
  End;
end;

class function TFunctionFuncoesFaturamento.SqlBuscaAbfIcm(const ACodigoDaEmpresaTE: String; const ACodigoDaEmpresa: String): String;
begin
  Result := Self.SqlAbfIcm(ACodigoDaEmpresaTE,  ACodigoDaEmpresa);

  Result := Result + 'WHERE ';
  Result := Result + '  I.ITE_CODITE = :CODITE AND ';
  Result := Result + '  A.ABF_CODABF = :CODABF AND ';
  Result := Result + '  A.ABF_ESTADO = :ESTADO ';
end;

class function TFunctionFuncoesFaturamento.SqlCdsIteger(ATabPre: String; out ATabUti: String): String;
begin
  If objCore.fEmptyStr(ATabPre) Then
    ATabPre := '-1';

  If (CalcularImpostosUtilizandoCadFornecedoresFormacaoPreco) And (Not ATabPre.IsEmpty) And (ATabPre <> '-1') Then
  Begin
    Result := '';
    Result := Result + 'SELECT          ';
    Result := Result + '  I.ITE_CODITE, ';
    Result := Result + '  I.ITE_CODEMP, ';
    Result := Result + '  I.ITE_PREULT, ';
    Result := Result + '  D.ITE_PRECOM / IF(IFNULL(F.ITE_CNVCUS, 0) = 0, 1, F.ITE_CNVCUS) ITE_PRECOM, ';
    Result := Result + '  D.ITE_DESF01, ';
    Result := Result + '  D.ITE_DESF02, ';
    Result := Result + '  D.ITE_DESF03, ';
    Result := Result + '  D.ITE_DESF04, ';
    Result := Result + '  D.ITE_DESF05, ';
    Result := Result + '  D.ITE_DESF06, ';
    Result := Result + '  D.ITE_ICMSAI, ';
    Result := Result + '  D.ITE_OUTVAL, ';
    Result := Result + '  D.ITE_DESOPE, ';
    Result := Result + '  D.ITE_ACRFIN, ';
    Result := Result + '  D.ITE_IMPFED, ';
    Result := Result + ATabPre.QuotedString + ' AS ITE_TABELA ';
    Result := Result + 'FROM            ';
    Result := Result + '  ITEGER I      ';
    Result := Result + '  INNER JOIN TABDET D ON (D.ITE_CODTAB = I.ITE_TABPR'+ATabPre+' AND ';
    Result := Result + '                          D.ITE_CODITE = I.ITE_CODITE AND ';
    Result := Result + '                          D.ITE_CODEMP = I.ITE_CODEMP)    ';
    Result := Result + '  LEFT JOIN ITEFOR F ON (            ';
    Result := Result + '        F.ITE_CODITE = D.ITE_CODITE  ';
    Result := Result + '    AND F.ITE_CODFOR = D.ITE_CODFOR  ';
    Result := Result + '    AND F.ITE_CODEMP = D.ITE_CODEMP  ';
    Result := Result + '    AND F.AUTOINCREM = D.ITE_SEQGER) ';
    Result := Result + 'WHERE                        ';
    Result := Result + '  I.ITE_CODITE = :CODITE AND ';
    Result := Result + '  I.ITE_CODEMP = :CODEMP     ';
  End
  Else
  Begin
    ATabPre := '-1';

    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   ITE_CODITE, ';
    Result := Result + '   ITE_CODEMP, ';
    Result := Result + '   ITE_PREULT, ';
    Result := Result + '   ITE_PRECOM, ';
    Result := Result + '   ITE_DESF01, ';
    Result := Result + '   ITE_DESF02, ';
    Result := Result + '   ITE_DESF03, ';
    Result := Result + '   ITE_DESF04, ';
    Result := Result + '   ITE_DESF05, ';
    Result := Result + '   ITE_DESF06, ';
    Result := Result + '   ITE_ICMSAI, ';
    Result := Result + '   ITE_OUTVAL, ';
    Result := Result + '   ITE_DESOPE, ';
    Result := Result + '   ITE_ACRFIN, ';
    Result := Result + '   ITE_IMPFED, ';
    Result := Result + ATabPre.QuotedString + ' AS ITE_TABELA ';
    Result := Result + ' FROM ';
    Result := Result + '   ITEGER ';
    Result := Result + ' WHERE ';
    Result := Result + '   ITE_CODITE = :CODITE AND ';
    Result := Result + '   ITE_CODEMP = :CODEMP ';
  End;

  ATabUti := ATabPre;
end;

class function TFunctionFuncoesFaturamento.SubstituicaoTributaria(
  const ACodigoDaSubstituicaoTributaria: String): Boolean;
begin
  Result := (Pos(ACodigoDaSubstituicaoTributaria, objConstantes.fGetCstSubstituicao) > 0);
end;

class function TFunctionFuncoesFaturamento.UtilizaAmpara(
  const AClienteEstado: String; const AItemAmpara: Boolean): Boolean;
begin
  Result := false;

  If Not (Pos(AClienteEstado, ESTADOS_AMPARA) > 0) Then
    Exit;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_LEGISLACAO_AMPARA_VENDA_PARA_OS_ESTADOS_MG_RS, varBoolean) Then
    Exit;

  If Not AItemAmpara Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.UtilizaDecretoReducaoRICMSdaAbreviacao(
  const blnCheckBoxMarcadoOuAliquotaMaiorQueZero: Boolean): Boolean;
begin
  Result := False;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICM_PR, varBoolean) Then
    Exit;

  If Not fPodeTerReducaoRICMPRDefinidaNoCadastroAbreviacao Then
    Exit;

  Result := blnCheckBoxMarcadoOuAliquotaMaiorQueZero;
end;

//class function TFunctionFuncoesFaturamento.ValidarCodigoFiscalSubstituicaotributaria(
//  const ACodigoFiscal: String): Boolean;
//begin
//  Result := Pos(ACodigoFiscal, CST_SUBSTITUICAO) > 0;
//end;

class function TFunctionFuncoesFaturamento.ValidarConfirmacaoNotaFiscalConcreto(const AVendaItemConcreto              : Boolean;
                                                                                const ADesmembrarNotaProdutosServicos : Boolean;
                                                                                const AOpcaoDocumento                 : String): Boolean;
begin

  Result := false;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = J_A_MASSA_CONCRETO) Then
  Begin

    If Not AVendaItemConcreto Then
      Exit;

    If Not (AOpcaoDocumento = REMESSA_CONCRETO) Then
      Exit;

    Result := true;

  End
  Else
  Begin

    If Not AVendaItemConcreto Then
      Exit;

    If Not ADesmembrarNotaProdutosServicos Then
      Exit;

    Result := true;

  End;

end;

class function TFunctionFuncoesFaturamento.ValidarDocumentosMIFF(
  const AOpcaoDocumento: String): Boolean;
begin
  Result := true;

  If TFunctionFuncoesFaturamento.
      LocalizarOpcaoDeDocumento(AOpcaoDocumento,MOVIMENTACAO_ITENS_FATURAMENTO_FUTURO) Then
  Begin
    Exit;
  End;

  Result := false;
end;

class function TFunctionFuncoesFaturamento.ValidarEmpresaSimplesParaRetencaoPisCofins: Boolean;
begin
  Result := false;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, VarBoolean) Then
    Exit;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_EXIBIR_NAO_SERA_REALIZADA_RETENCAO_CADASTRO_CLIENTE_EMPRESA_SIMPLES, VarBoolean) Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.ValidarImportacaoDiretaClienteIvaSimMT(
  const AImportacaoDireta: Boolean; const AClienteIVASimMT,
  ATotalGeralItem: Double): Boolean;
begin
  Result := false;

  If Not AImportacaoDireta Then
    Exit;

  If AClienteIVASimMT <= 0 Then
    Exit;

  if ATotalGeralItem <= 0 Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.ValidarIpiSaida(
const AEspecieDocumento: String): Boolean;
begin
  Result := true;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, varBoolean) Then
    Exit;

  If AEspecieDocumento =  ENVIO_GARANTIA_FORNECEDOR Then
    Exit;

  Result := false;
end;

class function TFunctionFuncoesFaturamento.ValidarOpcaoDeDocumentoEntradaFornecedor(
 Const AOpcaoDocumento: String): Boolean;
begin
  Result := True;

  if AOpcaoDocumento = ENTRADA_FORNECEDOR Then
    Exit;

  Result := False;
end;

class function TFunctionFuncoesFaturamento.ValidarOpcaoDeDocumentoEnvioGarantiaFornecedor(
 Const AOpcaoDocumento: String): Boolean;
begin
  Result := True;

  If (AOpcaoDocumento = ENVIO_GARANTIA_FORNECEDOR) Then
    Exit;

  Result := False;
end;

class function TFunctionFuncoesFaturamento.ValidarOpcaoDeDocumentoNotaComplementoFornecedor(
 Const AOpcaoDocumento: String; Const ANCFornecedor: Boolean): Boolean;
begin
  Result := False;

  if Not(AOpcaoDocumento = NOTA_COMPLEMENTO) Then
    Exit;

  if Not(ANCFornecedor)Then
    Exit;

  Result := true;

end;

class function TFunctionFuncoesFaturamento.ValidarOpcaoDeDocumentoNotaEspecialFornecedor(
 Const AOpcaoDocumento: String; Const ANEFornecedor: Boolean): Boolean;
begin
  Result := False;

  If Not (AOpcaoDocumento = NOTA_ESPECIAL) Then
    Exit;

  if Not(ANEFornecedor) Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.ValidarOpcaoDeDocumentoOutrasSaidasFornecedor(
 Const AOpcaoDocumento: String): Boolean;
begin
  Result := True;

  If AOpcaoDocumento = OUTRAS_SAIDAS_FORNECEDOR Then
    Exit;

  Result := False;
end;

class function TFunctionFuncoesFaturamento.ValidarOpcaoDeDocumentoRegimeEspecialConfTE(
  Const AOpcaoDocumento: String; Const ARegimeEspecialPorEmpresa: Boolean): Boolean;
begin
  Result := False;

  If AOpcaoDocumento <> CONF_TRANSF_ESTOQUE Then
    Exit;

  If Not ARegimeEspecialPorEmpresa Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.ValidarOpcaoDeDocumentoVendaNormalFornecedor(
  const AOpcaoDocumento, ACodigoCliente, ACodigoFornecedor: String): Boolean;
begin
  Result := False;

  If Not(AOpcaoDocumento = VENDA_NORMAL) Then
    Exit;

  If Not objCore.fEmptyStr(ACodigoCliente) Then
    Exit;

  If objCore.fEmptyStr(ACodigoFornecedor)Then
    Exit;

  Result := true;
end;

class function TFunctionFuncoesFaturamento.ValidarOrgaoPublicoOuZonaFranca(const AOrgaoPublico, AZonaFranca: boolean): boolean;
begin
  result := True;

  If (AOrgaoPublico) Then
    Exit;

  If (AZonaFranca) Then
    Exit;

  Result := False;
end;

class function TFunctionFuncoesFaturamento.ValidarSituacaoDoIpi(
const ASituacaoIpi: String): Integer;
begin
  Result := AnsiIndexStr(UpperCase(ASituacaoIpi), [TRIBUTADO, ISENTO, NAO_TRIBUTADO, IMUNE, SUSPENSO]);
end;

Class function TFunctionFuncoesFaturamento.ValidarZonaFrancaEClienteNaoConsumidor(
 Const AZonaFranca, AClienteConsumidorFinal: Boolean): Boolean;
begin
  Result := False;

  If Not(AZonaFranca)Then
    Exit;

  If AClienteConsumidorFinal Then
    Exit;

  Result := True;
end;

Class function TFunctionFuncoesFaturamento.ZerarFreteParaContribuinteIpi: Boolean;
begin
  Result := false;

  If Not (objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean)) Then
    Exit;

  If objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_SOBRE_FRETE, varBoolean) Then
    Exit;

  Result := true;
end;

Class function TFunctionFuncoesFaturamento.ZerarFreteParaOrgaoPublicoZonaFrancaDentroDoEstado(
  Const AOrgaoPublico, AZonaFranca, ADentroDoEstado: Boolean): Boolean;
begin
  Result := false;

  if not (ValidarOrgaoPublicoOuZonaFranca(AOrgaoPublico, AZonaFranca)) then
    Exit;

  If objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, varBoolean) Then
    Exit;

  If Not (ADentroDoEstado) Then
    Exit;

  result := True;
end;

class function TFunctionFuncoesFaturamento.BaixaDeEntregaFuturaComImpostosNosCamposProprios(
  const ABaixaEntFut: Boolean; const AEntFutOpc: String): Boolean;
begin
  Result := False;

  If Not ABaixaEntFut Then
    Exit;

  {******************************************************}
  {* CFG_ENFUOP no momento da emissão da entrega futura *}
  {*REQ.144458****************************************RP*}
  If AEntFutOpc <> '2' Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.BaixaDeEntregaFuturaComImpostosNaVenda(
  const ABaixaEntFut: Boolean; const AEntFutOpc: String): Boolean;
begin
  Result := False;

  If Not ABaixaEntFut Then
    Exit;

  {******************************************************}
  {* CFG_ENFUOP no momento da emissão da entrega futura *}
  {*REQ.144458****************************************RP*}
  If AEntFutOpc <> '1' Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.ZerarIpiNaoContribuiteIpiUsarMIFF(
  const AOpcaoDocumentoVerdadeira: String = '';
  const AEspecieDoDocumento: String = ''): Boolean;
begin
  Result := False;

  If not (AOpcaoDocumentoVerdadeira = 'BF') Then
    Exit;

  If not (AEspecieDoDocumento = 'PD') Then
    Exit;

  If objConfiguracoes.fGetValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, varBoolean) Then
    Exit;

  Result := True;
end;

class function TFunctionFuncoesFaturamento.ZerarIpi(
  const AEspecieDoDocumento: String;
  const ATemMIFFEntreOsDevolvidos: Boolean;
  const AOpcaoDocumento: String;
  const ATipoDoPedido: String;
  const ABaixaEntFut: Boolean = False;
  const AEntFutOpc: String = '';
  const AOpcaoDocumentoVerdadeira: String = ''): Boolean;
begin
  Result := True;

  If (AOpcaoDocumento = 'TR') then
    Exit;

  If BaixaDeEntregaFuturaComImpostosNosCamposProprios(ABaixaEntFut, AEntFutOpc) Then
    Exit(False);

  If ZerarIpiEspeciesMIFF(AEspecieDoDocumento) Then
    Exit;

  If ZerarIpiEspeciesTE(AEspecieDoDocumento) Then
    Exit;

  If ZerarIpiNaoContribuiteIpiEspeciesNaoORPDMIFF(AEspecieDoDocumento, ZerarIpiNaoContribuiteIpiUsarMIFF(AOpcaoDocumentoVerdadeira, AEspecieDoDocumento), ATemMIFFEntreOsDevolvidos) Then
    Exit;

  If ZerarIpiEspecieDV(AEspecieDoDocumento, ATemMIFFEntreOsDevolvidos) Then
    Exit;

  If ZerarIpiPedidoEspeciesMIFF(AEspecieDoDocumento, AOpcaoDocumento, ATipoDoPedido) Then
    Exit;

  If BaixaDeEntregaFuturaComImpostosNaVenda(ABaixaEntFut, AEntFutOpc) Then
    Exit;

  If ZerarIpiPedidoEspeciesMIFFQuandoDefineTipoDeDocumentoNoPedido(AEspecieDoDocumento, AOpcaoDocumento, ATipoDoPedido) Then
    Exit;

  Result := False;
end;

class function TFunctionFuncoesFaturamento.RetornarEspecieDocumento(const AEspecieDocumento, AOpcaoDocumento: string):string;
begin
  result := AEspecieDocumento;
  
  If (not objCore.fEmptyStr(result)) then
    Exit;

  result := AOpcaoDocumento;
end;

Class function TFunctionFuncoesFaturamento.ZerarIpiSubstituicaoTributariaParaMIeFF(const AEspecieDocumento, AOpcaoDocumento: string): Boolean;
begin
  result := False;

  if (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) then
    Exit;

  if (Pos(RetornarEspecieDocumento(AEspecieDocumento, AOpcaoDocumento), MOVIMENTACAO_ITENS_FATURAMENTO_FUTURO) <= 0) then
    Exit;

  result := True;
end;

class function TFunctionFuncoesFaturamento.ZerarIpiSubstituicaoTributariaParaTE(
  const AEspecieDocumento, AOpcaoDocumento: string): Boolean;
begin
  result := False;

  if (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_TE, varBoolean)) then
    Exit;

  if (Pos(RetornarEspecieDocumento(AEspecieDocumento, AOpcaoDocumento), TRANSFERENCIA_ESTOQUE) <= 0) then
    Exit;

  result := True;
end;

Class function TFunctionFuncoesFaturamento.ZerarSubstituicaoTributariaEspecies(const AEspecieDocumento, AOpcaoDocumento: string; ATemMIFFEntreOsDevolvidos: Boolean = False): Boolean;
  Var 
    strListaEspecie: String;
begin
  strListaEspecie := ORCAMENTO_PEDIDO_MOVIMENTACAO_ITENS_FATURAMENTO_FUTURO;

  if ATemMIFFEntreOsDevolvidos then
    if (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) then
      strListaEspecie := strListaEspecie + DEVOLUCAO;
  
  result := (Pos(RetornarEspecieDocumento(AEspecieDocumento, AOpcaoDocumento), strListaEspecie) <= 0);
end;

Class function TFunctionFuncoesFaturamento.ZerarSubstituicaoTributariaPedidoOrcamento(const AEspecieDocumento, AOpcaoDocumento: string): Boolean;
begin
  result := False;

  if (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_PARA_PEDIDO_ORCAMENTO, varBoolean)) then
    Exit;

  if (Pos(RetornarEspecieDocumento(AEspecieDocumento, AOpcaoDocumento), PEDIDO_ORCAMENTO) <= 0) then
    Exit;

  result := True;
end;

Class function TFunctionFuncoesFaturamento.ZerarSubstituicaoTributariaPedidoDeBonificacao(const AEspecieDocumento, AOpcaoDocumento, ATipoDoPedido: string): Boolean;
begin
  result := False;

  if (ATipoDoPedido <> TIPO_PEDIDO_BONIFICACAO) then
    Exit;

  if (RetornarEspecieDocumento(AEspecieDocumento, AOpcaoDocumento) <> ESPECIE_PEDIDO) then
    Exit;

  if (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) then
    Exit;

  if (not objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_PARA_PEDIDO_ORCAMENTO, varBoolean)) then
    Exit;

  result := True;
end;

Class function TFunctionFuncoesFaturamento.DevolucaoComSubstituicaoTributariaParaMIeFF(const AEspecieDocumento, AOpcaoDocumento: string; ATemMIFFEntreOsDevolvidos: Boolean): Boolean;
begin
  result := False;

  If not (RetornarEspecieDocumento(AEspecieDocumento, AOpcaoDocumento) = DEVOLUCAO) Then
    Exit;

  if not (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) then
    Exit;

  if not (objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean)) then
    Exit;

  If not ATemMIFFEntreOsDevolvidos Then
    Exit;

  result := True;
end;

class function TFunctionFuncoesFaturamento.ZerarSubstituicaoTributaria(
  const AEspecieDocumento, AOpcaoDocumento, ATipoDoPedido: string;
  const ABaixaEntFut: Boolean = False; const AEntFutOpc: String = '';
  const ATemMIFFEntreOsDevolvidos: Boolean = False): Boolean;
begin
  result := True;

  If DevolucaoComSubstituicaoTributariaParaMIeFF(AEspecieDocumento, AOpcaoDocumento, ATemMIFFEntreOsDevolvidos) Then
    Exit(False);

  If BaixaDeEntregaFuturaComImpostosNosCamposProprios(ABaixaEntFut, AEntFutOpc) Then
    Exit(False);

  if (ZerarIpiSubstituicaoTributariaParaMIeFF(AEspecieDocumento, AOpcaoDocumento)) then
    Exit;

  if (ZerarIpiSubstituicaoTributariaParaTE(AEspecieDocumento, AOpcaoDocumento)) then
    Exit;

  If (DeveCalcularSTParaPedidoDeRetiraParaDevolucao(AEspecieDocumento, AOpcaoDocumento)) Then
    Exit(False);

  if (ZerarSubstituicaoTributariaEspecies(AEspecieDocumento, AOpcaoDocumento, ATemMIFFEntreOsDevolvidos)) Then
    Exit;

  if (ZerarSubstituicaoTributariaPedidoOrcamento(AEspecieDocumento, AOpcaoDocumento)) then
    Exit;

  if (ZerarSubstituicaoTributariaPedidoDeBonificacao(AEspecieDocumento, AOpcaoDocumento, ATipoDoPedido)) then
    Exit;

  If BaixaDeEntregaFuturaComImpostosNaVenda(ABaixaEntFut, AEntFutOpc) Then
    Exit;

  result := False;
end;

class function TFunctionFuncoesFaturamento.ValidarDescontoDeICMSOrgaoPublico(
  const AOpcaoDocumento, AClienteDescontoDeICMSOrgaoPublico: String): String;
begin
  Result := AClienteDescontoDeICMSOrgaoPublico;

  If Pos(AOpcaoDocumento, CONFIRMACAO_CUPOM_FISCAL) > 0 Then
    Result := 'N';
end;

class function TFunctionFuncoesFaturamento.ValidarDocumentoParaClienteDefit(
  const ADocumentoParaFornecedor: boolean; const AInscricaoEstadualCliente,
  AEstadoCliente: String): Boolean;
begin
  result := False;

  If ADocumentoParaFornecedor then
    Exit;

  If (objCore.fEmptyStr(AInscricaoEstadualCliente)) then
    Exit;

  If (AEstadoCliente <> DISTRITO_FEDERAL) Then
    Exit;

  result := True;
end;

class function TFunctionFuncoesFaturamento.ValidarDocumentoParaClienteTare(const ADocumentoParaFornecedor: boolean; const AInscricaoEstadualCliente, AEstadoCliente: String): Boolean;
begin
  result := False;

  If ADocumentoParaFornecedor then
    Exit;

  If (objCore.fEmptyStr(AInscricaoEstadualCliente)) then
    Exit;

  If (AEstadoCliente <> GOIAS) Then
    Exit;

  result := True;
end;

class function TFunctionFuncoesFaturamento.RetornarSQLClienteDefit: string;
begin
  result := EmptyStr;
  result := result + 'SELECT                 ';
  result := result + '  CLI_DEFIT_           ';
  result := result + 'FROM                   ';
  result := result + '  CADCLI               ';
  result := result + 'WHERE                  ';
  result := result + '  CLI_CODCLI = :CODCLI ';
end;

class function TFunctionFuncoesFaturamento.RetornarSQLClienteTare: string;
begin
  result := EmptyStr;
  result := result + 'SELECT                 ';
  result := result + '  CLI_TARE__           ';
  result := result + 'FROM                   ';
  result := result + '  CADCLI               ';
  result := result + 'WHERE                  ';
  result := result + '  CLI_CODCLI = :CODCLI ';
end;

class function TFunctionFuncoesFaturamento.RetornarSQLRetencaoPisCofins(Const AMostrarColunaCDESPI : Boolean) : String;
begin
  If ValidarEmpresaSimplesParaRetencaoPisCofins Then
  begin
    Result := RetornarColunasCadastroClienteRetencaoPisCofinsDefault(AMostrarColunaCDESPI);
    Exit;
  end;

  Result := RetornarColunasCadastroClienteRetencaoPisCofins(AMostrarColunaCDESPI);
end;

class function TFunctionFuncoesFaturamento.fAtendeuAsCondicoesDeFCPComReducaoBaseIcmsST(const ATipoAbreviacaoFiscal: string; const ACodigoFiscal: String; const ADentroDoEstado: Boolean): Boolean;
begin
  Result := false;

  if Not objConfiguracoes.fGetValorConfiguracao(CFG_BENEFICIO_ICMSST_MODO_DE_CALCULO_FCP_ST , varString) = '2' Then
    Exit;

  if Not (objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, varString) = SUBSTITUTO_TRIBUTARIO) Then
    Exit;

  If (ATipoAbreviacaoFiscal <> CONTRIBUINTE_NAO_CONSUMIDOR) And (ATipoAbreviacaoFiscal <> SAIDAS_TRANSFERENCIAS_ENTRE_LOJAS) Then
    Exit;

  If Not ADentroDoEstado Then
    Exit;

  If (RightStr(ACodigoFiscal, 2) <> CODIGO_FISCAL_VALOR_BASE_CALCULO_ICMS) Then
    Exit;

  Result := true;

end;

class function TFunctionFuncoesFaturamento.fCalculaFCPComReducaoBaseIcmsST(ATipoAbreviacaoFiscal : String; ACodigoFiscal : String; ADentroDoEstado: Boolean): Boolean;
Var
  LTipoAbreviacaoFiscal : String;
begin
  LTipoAbreviacaoFiscal :=
    AnsiReplaceStr(AnsiReplaceStr(ATipoAbreviacaoFiscal,ABREVIACAO_FISCAL_ENTRADA,''),ABREVIACAO_FISCAL_SAIDA,'');

  Result := fAtendeuAsCondicoesDeFCPComReducaoBaseIcmsST(LTipoAbreviacaoFiscal, ACodigoFiscal, ADentroDoEstado);
end;

class function TFunctionFuncoesFaturamento.fEhIbgeRegraZonaFranca(ACodigoIbge: String): Boolean;
Begin
  Result := Pos(ACodigoIbge, IBGE_REGRA_ZONA_FRANCA) > 0;
End;

class function TFunctionFuncoesFaturamento.fCalculaIpiParaClienteZonaFranca(AIbgeEmpresa: String; AIbgeEntrega: String; ASuframa: String; AZonaFranca: Boolean; AVendaPresencial: Boolean): Boolean;
begin

  Result := True;

  If not fEhIbgeRegraZonaFranca(AIbgeEmpresa) Then
    Exit;

  If not AZonaFranca Then
    Exit(True);

  If ASuframa.IsEmpty Then
    Exit(True);

  If AVendaPresencial Then
    Exit(False);

  If AIbgeEntrega.IsEmpty Then
    Exit(False);

  If not fEhIbgeRegraZonaFranca(AIbgeEntrega) Then
    Exit(True);

  Result := False;

end;

class function TFunctionFuncoesFaturamento.DeveCalcularSTParaPedidoDeRetiraParaDevolucao(const AEspecieDocumento, AOpcaoDocumento : String): Boolean;
begin
  Result := False;
  If (Not EhRotinaDePedidoDeRetiraParaDevolucao(AEspecieDocumento, AOpcaoDocumento)) Then
    Exit;
  Result := (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_ST_PARA_DOCUMENTOS_COM_ESPECIE_PR, varString) = 'S');
end;

class function TFunctionFuncoesFaturamento.EhRotinaDePedidoDeRetiraParaDevolucao(const AEspecieDocumento, AOpcaoDocumento : String): Boolean;
begin
  Result := True;
  If (AEspecieDocumento = 'PR') Then
    Exit;
  If (AOpcaoDocumento = 'PR') Then
    Exit;
  Result := False;
end;

end.
