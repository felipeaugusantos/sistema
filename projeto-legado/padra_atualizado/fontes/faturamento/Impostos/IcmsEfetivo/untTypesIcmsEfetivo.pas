unit untTypesIcmsEfetivo;

interface

uses untTypesGenericosImpostos, Shared.Functions.Types;

type
  TParametrosServicoIcmsEfetivo = record
    MatItensIcmsEfetivo : TMatrizFechamentoIcmsEfetivo;
    VendaPresencial: Boolean;
    CodigoDoCliente: String;
    OpcaoDoDocumento : String;
    CodigoDaEmpresa : String;
    CodigoDaEmpresaTE : String;
    CodigoDoFornecedor : String;
    ClienteConsumidorFinal : Boolean;
    SequencialEnderecoEntrega: String;
    NotaComplementoFornecedor : Boolean;
    EspecieDocumento: String;
    TipoOperacaoPedidoVenda: String;
    CalcularSatEcf: Boolean;
    UtilizaSat: Boolean;
    NotaEspecialFornecedor : Boolean;
    BaixaDeEntregaFutura : Boolean;
    GerandoCasosTestes: Boolean;
    ClienteIndustria: Boolean;
    ClienteComercializacao: Boolean;
    ParametrosClienteConsumidor : TFaturamentoImpostosClienteConsumidor;
  end;

  TParametrosCalculoIcmsEfetivo = record
    EncontrouDocumento : Boolean ;
    Quantidade : Double;
    QuantidadeItem: Double;
    ClienteConsumidorFinal: Boolean ;
    PercentualReducaoBaseCalcEfetiva: Double;
    ValorBaseCalculoEfetiva: Double;
    AliquotaIcmsEfetiva: Double;
    ValorBaseRetida: Double;
    ValorRetido: Double;
    ValorIcmsSubstitutoItem : Double;
    IcmsEfetivoSemUltimaNota : Boolean;
    ValorBaseOperacaoPropriaICMSEntrada: Double;
    AliquotaOperacaoPropriaICMSEntrada : Double;
    ValorOperacaoPropriaICMSEntrada: Double;
    EncontrouDocumentoOperacaoPropriaICMSEntrada : Boolean;
  end;

  TResultadoServicosClasseIcmsEfetivo = record
    ResultadoCalculoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo;
    ParametrosCalculoIcmsEfetivo: TParametrosCalculoIcmsEfetivo;
  end;

  TResultadoCalculoIcmsEfetivo = record
    PercentualReducaoBaseCalcEfetivaItem: Double;
    ValorBaseCalculoEfetivaItem: Double;
    ValorIcmsEfetivaItem: Double;
    AliquotaIcmsEfetivaItem: Double;
    ValorBaseCalculoIcmsStRetidoItem: Double;
    ValorIcmsStRetidoItem: Double;
    ValorIcmsSubstitutoItem : Double;
    ValorBaseOperacaoPropriaICMSEntrada: Double;
    AliquotaOperacaoPropriaICMSEntrada : Double;
    ValorOperacaoPropriaICMSEntrada: Double;
  end;

implementation

end.
