unit untTypesIPI;

interface

uses Shared.Functions.Types, untTypesGenericosImpostos;

Const
  IPITributado = 'T';
  IPIIsento = 'I';

type
  TResultadoAbreviacaoIpi = record
    BaseDeCalculoIPI: Double;
    AliquotaDeCalculoIPI: Double;
  end;

  TParametrosCalculoValorIpi = record
    CodigoDoCliente: String;
    CodigoDoProduto: String;
    CodigoDaEmpresa: String;
    TotalGeralDoItem: Double;
    BaixaDeEntregaFutura: Boolean;
    ClienteConsumidorFinal: Boolean;
    TipoDeBaixaEntregaFutura: String;
  end;

  TParametrosCalculoIPI = record
    ClienteZonaFranca: Boolean;
    ClienteOrgaoPublico: Boolean;
    VendaDentroDoEstado: Boolean;
    ClienteDoExterior: Boolean;
    SituacaoTributariaIPI: string;
    BaseDoIpi: Double;
    AliquotaDeCalculoIPI: Double;
  end;

  TResultadoCalculoIPI = record
    ValorCalculadoIPI: Double;
    BaseDeCalculoIPI: Double;
    AliquotaDeCalculoIPI: Double;
    ValorCalculadoIPIConsignacao: Double;
  end;

  TResultadoServicosClasseIpi = record
    ResultadoCalculoIPI: TResultadoCalculoIPI;
    ParametrosCalculoIPI: TParametrosCalculoIPI;
  end;

  TParametrosServicoIPI = record
    CodigoDoCliente: String;
    CodigoDoProduto: String;
    CodigoDaEmpresa: String;
    ClassificacaoFiscalDoItem: String;
    VendaPresencial: Boolean;
    EspecieDoDocumento: String;
    DesmembrarNotaProdutosServicos: Boolean;
    OpcaoDoDocumento: String;
    OpcaoDeItemNfEspiritoSanto : TOpcItensNFespTinta;
    EspecieDeDevolucao: String;
    DesmembrarMeiaNotaComNotaNormal: Boolean;
    BaixaDeEntregaFutura : Boolean;
    EntregaFutura : Boolean;
    MeiaNotaFatorExpedicao : Boolean;
    TotalGeralDoItem : Double;
    ValorFreteDoItem : Double;
    DespesaAcessoriaDoItem : Double;
    DescontoEspecial : Double;
    NotaComplementoFornecedor : Boolean;
    NotaEspecialFornecedor : Boolean;
    CodigoDoFornecedor : String;
    SequencialEnderecoEntrega: String;
    GerandoCasosTestes: Boolean;
    ClienteConsumidorFinal: Boolean;
    ParametrosClienteConsumidor : TFaturamentoImpostosClienteConsumidor;
    TotalGeralDoItemPreUlt : Double;
    TipoDePedidoFaturamento : String;
    TipoDeBaixaEntregaFutura: String;
    OpcaoDoDocumentoVerdadeira: String;
    CodigoDaFazenda: String;
  end;

implementation

end.
