unit untTypesCFOP;

interface

uses Shared.Functions.Configuracoes, Shared.Functions.Types, untFuncFatTypes;

type
  TFunctionRegraCFOP = reference to function : Boolean;

  TClassificacaoClass = Class Of TAbstractClassificacao;

  TInputDefineClassificacaoFiscal = record
    Operacao : String;
    OpcaoDeDocumento : String;
    ReposicaoGarantiaPropriaEmpresa : Boolean;
    NotaEspecialVendaABaseDeTroca : Boolean;
    DentroDoEstado : Boolean;
    DentroDoEstadoCFOP : Boolean;
    VendaPresencial : Boolean;
    ClienteEstado : String;
    FatGorOrigem : String;
    TipoDeOperacaoDoPedidoDeVenda : String;
    EspecieDoDocumento : String;
    ClienteConsumidorFinal : Boolean;
    ClassificacaoDeServico : String;
    SituacaoTributaria : String;
    TipoDeEmprestimo : String;
    TaxaBombeamentoPedidoOrcamento : Boolean;
    SimplesRemessaConcretoDadosCliente : Boolean;
    ItemConcreto : Boolean;
    SimplesRemessaConcreto : Boolean;
    RemessaEstoqueExterno : Boolean;
    RemessaEstoqueExternoClassificacao : String;
    BaixaRefugo : Boolean;
    EntradaOuSaidaDoItem : String;
    EntregaFuturaDoItem : Boolean;
    EhEspelhoDevolucaoClienteGarantia : Boolean;
    ClassificacaoFiscalDoItem : String;
    ClassificacaoDoItem : String;
    IndustrializacaoOuRevenda : String;
    EhOperacaoDeVendaInternaDeProdutosDoDecretoDoCeara : Boolean;
    UtilizaDecretoReducaoRICMSdaAbreviacao : Boolean;
    TipoDaAbreviacaoFiscal : String;
    ItemSubstituido : Boolean;
    ItemBrinde : Boolean;
    BaixaDeEntregaFutura : Boolean;
    ClienteZonaFranca : Boolean;
    CodigoDoItem : String;
    DesmembrarNotaProdutosServicos : Boolean;
    ConfirmandoNotaFiscalConcreto : Boolean;
    ClienteFilial : Boolean;
    ConfirmacaoDevolucaoRegimeEspecial : Boolean;
    ClassificacaoDeVendaTributadoTransferencia : String;
    ClassificacaoDeIndustrializacaoTributadoTransferencia : String;
    ClassificacaoDeVendaSubstImportacaoDireta : String;
    ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia : String;
    ClassificacaoDeIndustrializacaoSubstCombustivelELubrificanteTransferencia : String;
    ClassificacaoDeVendaSubstDemaisProdutosTransferencia : String;
    ClassificacaoDeIndustrializacaoSubstDemaisProdutosTransferencia : String;
    ClassificacaoDeTransferenciaDepositoFechadoTributado: String;
    ClassificacaoDeTransferenciaDepositoFechadoCombustivelELubrificanteTransferencia : String;
    ClassificacaoDeTransferenciaDepositoFechadoDemaisProdutosTransferencia : String;
    ImportacaoDiretaDoItem : Boolean;
    TipoDeEmissaoTE : String;
    TipoDeOperacaoTE: String;
    CombustivelLubrificanteDoItem : Boolean;
    CSTDeVendaTributadoTransferencia : String;
    CSTDeVendaSubstCombustivelELubrificanteTransferencia : String;
    CSTDeVendaSubstDemaisTransferencia : String;
    CSTDeVendaTributadoTransferenciaDepositoFechado : String;
    CSTDeVendaSubstCombustivelELubrificanteTransferenciaDepositoFechado : String;
    CSTDeVendaSubstDemaisTransferenciaDepositoFechado : String;
    ClienteExportacaoIndireta : Boolean;
    ComodatoCilindroVasilhame : Boolean;
    NotaDeComplementoDeClienteComplementandoValor : Boolean;
    NFeComplementoItens : TNfeComplementoItens;
    IncrementoItemAComplementar : String;
    NFComplementoFornecedorValor : Boolean;
    ConsertoDeEquipamento : Boolean;
    NotaDeImportacao : Boolean;
    ItemDrawback : Boolean;
    ClienteCodigo : String;
    CodigoDaEmpresa : String;
    RetornaClienteFilial : String;
    OpcaoItensNFespTinta : TopcItensNFespTinta;
    DocumentoDeComplementoDeValores : Boolean;
    ClassificacaoFiscalRecebimentoGarantia : String;
    ClassificacaoFiscalRecebimentoGarantiaST : String;
    ClassificacaoFiscalEnvioGarantia : String;
    ClassificacaoFiscalEnvioGarantiaST : String;
    PedidoDeRemessaParaGarantia : Boolean;
    ProdutoEmbalagem : Boolean;
    ClienteInscricaoEstadual : String;
    ClienteMicroEmpreendedor : Boolean;
    AtendeRegrasDifal : Boolean;
    ClassificacaoDeVendaInternaDeProdutosDoDecretoDoCeara : String;
    AtividadeConstrutora : Boolean;
    VendaDeProducao : Boolean;
    ClienteZonaFrancaComDescontoEspecial : Boolean;
    EstornoNotaFiscal : Boolean;
    TributaZonaFrancaManaus : Boolean;
    ItemPossuiSimilar: Boolean;
    EstornoNotaFiscalEntregaFutura : Boolean;
    MicroEmpreendedorIndividual: Boolean;
  End;

  TInputOutputClassificacaoFiscal = record
    Classificacao : String;
    PrefixoClassificacao : String;
    ClassificacaoDeServico : String;
    SituacaoTributaria : String;
    MensagemRetorno : String;
    AbortarProcedimento : Boolean;
  End;

  TAbstractClassificacao = class abstract
    function GetClassificacao: TInputOutputClassificacaoFiscal; virtual; abstract;
    constructor Create(const AInputDefine: TInputDefineClassificacaoFiscal; const AConfiguracoes: IConfiguracoes; const AInputOutputClassificacao: TInputOutputClassificacaoFiscal); virtual; abstract;
  End;

implementation

end.
