unit Faturamento.Impostos.Tipos.IcmsEfetivo;

interface

uses
  Faturamento.Impostos.Interfaces.IcmsEfetivo,
  Faturamento.Impostos.Interfaces.Model,
  Shared.Functions.Types;

type
  TParametrosCalculoIcmsEfetivo = class(TInterfacedObject, IParametrosCalculoIcmsEfetivo)
  private
    FEncontrouDocumento                           : Boolean;
    FQuantidade                                   : Double;
    FQuantidadeItem                               : Double;
    FClienteConsumidorFinal                       : Boolean;
    FPercentualReducaoBaseCalcEfetiva             : Double;
    FValorBaseCalculoEfetiva                      : Double;
    FAliquotaIcmsEfetiva                          : Double;
    FValorBaseRetida                              : Double;
    FValorRetido                                  : Double;
    FValorIcmsSubstitutoItem                      : Double;
    FIcmsEfetivoSemUltimaNota                     : Boolean;
    FValorBaseOperacaoPropriaICMSEntrada          : Double;
    FAliquotaOperacaoPropriaICMSEntrada           : Double;
    FValorOperacaoPropriaICMSEntrada              : Double;
    FEncontrouDocumentoOperacaoPropriaICMSEntrada : Boolean;
    FValorOperacaoPropriaICMSSaida : Double;
  public
    function EncontrouDocumento : Boolean ; overload;
    function EncontrouDocumento(AValue : Boolean): IParametrosCalculoIcmsEfetivo; overload;

    function Quantidade : Double; overload;
    function Quantidade(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function QuantidadeItem: Double; overload;
    function QuantidadeItem(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ClienteConsumidorFinal: Boolean ; overload;
    function ClienteConsumidorFinal(AValue : Boolean): IParametrosCalculoIcmsEfetivo; overload;

    function PercentualReducaoBaseCalcEfetiva: Double; overload;
    function PercentualReducaoBaseCalcEfetiva(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorBaseCalculoEfetiva: Double; overload;
    function ValorBaseCalculoEfetiva(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function AliquotaIcmsEfetiva: Double; overload;
    function AliquotaIcmsEfetiva(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorBaseRetida: Double; overload;
    function ValorBaseRetida(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorRetido: Double; overload;
    function ValorRetido(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorIcmsSubstitutoItem : Double; overload;
    function ValorIcmsSubstitutoItem (AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function IcmsEfetivoSemUltimaNota : Boolean; overload;
    function IcmsEfetivoSemUltimaNota (AValue : Boolean): IParametrosCalculoIcmsEfetivo; overload;

    function ValorBaseOperacaoPropriaICMSEntrada: Double; overload;
    function ValorBaseOperacaoPropriaICMSEntrada(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function AliquotaOperacaoPropriaICMSEntrada : Double; overload;
    function AliquotaOperacaoPropriaICMSEntrada (AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorOperacaoPropriaICMSEntrada: Double; overload;
    function ValorOperacaoPropriaICMSEntrada(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function EncontrouDocumentoOperacaoPropriaICMSEntrada : Boolean; overload;
    function EncontrouDocumentoOperacaoPropriaICMSEntrada(AValue : Boolean): IParametrosCalculoIcmsEfetivo; overload;

    function ValorOperacaoPropriaICMSSaida : Double; overload;
    function ValorOperacaoPropriaICMSSaida(const AValue : Double) : IParametrosCalculoIcmsEfetivo; overload;

    class function New(): IParametrosCalculoIcmsEfetivo;
  end;

type
  TResultadoCalculoIcmsEfetivo = class(TInterfacedObject, IResultadoCalculoIcmsEfetivo)
  private
    FPercentualReducaoBaseCalcEfetivaItem : Double;
    FValorBaseCalculoEfetivaItem          : Double;
    FValorIcmsEfetivaItem                 : Double;
    FAliquotaIcmsEfetivaItem              : Double;
    FValorBaseCalculoIcmsStRetidoItem     : Double;
    FValorIcmsStRetidoItem                : Double;
    FValorIcmsSubstitutoItem              : Double;
    FValorBaseOperacaoPropriaICMSEntrada  : Double;
    FAliquotaOperacaoPropriaICMSEntrada   : Double;
    FValorOperacaoPropriaICMSEntrada      : Double;

  public
    function PercentualReducaoBaseCalcEfetivaItem: Double; overload;
    function PercentualReducaoBaseCalcEfetivaItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorBaseCalculoEfetivaItem: Double; overload;
    function ValorBaseCalculoEfetivaItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorIcmsEfetivaItem: Double; overload;
    function ValorIcmsEfetivaItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function AliquotaIcmsEfetivaItem: Double; overload;
    function AliquotaIcmsEfetivaItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorBaseCalculoIcmsStRetidoItem: Double; overload;
    function ValorBaseCalculoIcmsStRetidoItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorIcmsStRetidoItem: Double; overload;
    function ValorIcmsStRetidoItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorIcmsSubstitutoItem : Double; overload;
    function ValorIcmsSubstitutoItem (AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorBaseOperacaoPropriaICMSEntrada: Double; overload;
    function ValorBaseOperacaoPropriaICMSEntrada(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function AliquotaOperacaoPropriaICMSEntrada : Double; overload;
    function AliquotaOperacaoPropriaICMSEntrada (AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorOperacaoPropriaICMSEntrada: Double; overload;
    function ValorOperacaoPropriaICMSEntrada(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    class function New(): IResultadoCalculoIcmsEfetivo;
  end;


Type
  TParametrosServicoIcmsEfetivo = Class(TInterfacedObject, IParametrosServicoIcmsEfetivo)
  private
    FMatItensIcmsEfetivo         : TMatrizFechamentoIcmsEfetivo;
    FCodigoDaEmpresa             : String;
    FCodigoDaEmpresaTE           : String;
    FCodigoDoCliente             : String;
    FOpcaoDoDocumento            : String;
    FCodigoDoFornecedor          : String;
    FClienteConsumidorFinal      : Boolean;
    FSequencialEnderecoEntrega   : String;
    FNotaComplementoFornecedor   : Boolean;
    FNotaEspecialFornecedor      : Boolean;
    FVendaPresencial             : Boolean;
    FBaixaDeEntregaFutura        : Boolean;
    FGerandoCasosTestes          : Boolean;
    FParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
    FClienteComercializacao      : Boolean;
    FClienteIndustria            : Boolean;
    FEspecieDocumento            : String;
    FTipoOperacaoPedidoVenda     : String;
    FCalcularSatEcf              : Boolean;
    FUtilizaSat                  : Boolean;
    FCodigoDaFazenda             : String;
  public
    function MatItensIcmsEfetivo : TMatrizFechamentoIcmsEfetivo; Overload;
    function MatItensIcmsEfetivo(AValue : TMatrizFechamentoIcmsEfetivo) : IParametrosServicoIcmsEfetivo; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosServicoIcmsEfetivo; overload;

    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosServicoIcmsEfetivo; overload;

    function OpcaoDoDocumento : String; Overload;
    function OpcaoDoDocumento(AValue : String) : IParametrosServicoIcmsEfetivo; overload;

    function CodigoDaEmpresa : String; Overload;
    function CodigoDaEmpresa(AValue : String) : IParametrosServicoIcmsEfetivo; overload;

    function CodigoDaEmpresaTE : String; Overload;
    function CodigoDaEmpresaTE(AValue : String) : IParametrosServicoIcmsEfetivo; overload;

    function CodigoDoFornecedor : String; Overload;
    function CodigoDoFornecedor(AValue : String) : IParametrosServicoIcmsEfetivo; overload;

    function ClienteConsumidorFinal : Boolean; Overload;
    function ClienteConsumidorFinal(AValue : Boolean) : IParametrosServicoIcmsEfetivo; overload;

    function SequencialEnderecoEntrega: String; overload;
    function SequencialEnderecoEntrega(AValue: String): IParametrosServicoIcmsEfetivo; overload;

    function NotaComplementoFornecedor : Boolean; overload;
    function NotaComplementoFornecedor(AValue : Boolean): IParametrosServicoIcmsEfetivo; overload;

    function NotaEspecialFornecedor : Boolean; overload;
    function NotaEspecialFornecedor(AValue : Boolean): IParametrosServicoIcmsEfetivo; overload;

    function BaixaDeEntregaFutura : Boolean; overload;
    function BaixaDeEntregaFutura(AValue : Boolean): IParametrosServicoIcmsEfetivo; overload;

    function GerandoCasosTestes: Boolean; overload;
    function GerandoCasosTestes(AValue: boolean): IParametrosServicoIcmsEfetivo; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue : Boolean): IParametrosServicoIcmsEfetivo; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue : Boolean): IParametrosServicoIcmsEfetivo; overload;

    function EspecieDocumento: String; overload;
    function EspecieDocumento(AValue: String): IParametrosServicoIcmsEfetivo; overload;

    function TipoOperacaoPedidoVenda: String; overload;
    function TipoOperacaoPedidoVenda(AValue: String): IParametrosServicoIcmsEfetivo; overload;

    function CalcularSatEcf: Boolean; overload;
    function CalcularSatEcf(AValue: Boolean): IParametrosServicoIcmsEfetivo; overload;

    function UtilizaSat: Boolean; overload;
    function UtilizaSat(AValue: Boolean): IParametrosServicoIcmsEfetivo; overload;

    function ParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue : IParametrosFaturamentoImpostosClienteConsumidor) : IParametrosServicoIcmsEfetivo; overload;

    function CodigoDaFazenda: String; overload;
    function CodigoDaFazenda(AValue: String): IParametrosServicoIcmsEfetivo; overload;

    class function New(): IParametrosServicoIcmsEfetivo;
  End;

type
  TResultadoServicosClasseIcmsEfetivo = class(TInterfacedObject, IResultadoServicosClasseIcmsEfetivo)
  private
    FResultadoCalculoIcmsEfetivo : TMatrizFechamentoIcmsEfetivo;
    FParametrosCalculoIcmsEfetivo: IParametrosCalculoIcmsEfetivo;
  public
    function ResultadoCalculoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo; overload;
    function ResultadoCalculoIcmsEfetivo(AValue: TMatrizFechamentoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo; overload;

    function ParametrosCalculoIcmsEfetivo: IParametrosCalculoIcmsEfetivo; overload;
    function ParametrosCalculoIcmsEfetivo(AValue: IParametrosCalculoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo; overload;

    class function New(): IResultadoServicosClasseIcmsEfetivo;
  end;


implementation

function TParametrosServicoIcmsEfetivo.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosServicoIcmsEfetivo.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosServicoIcmsEfetivo.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosServicoIcmsEfetivo.ClienteComercializacao: Boolean;
begin
  Result := FClienteComercializacao;
end;

function TParametrosServicoIcmsEfetivo.CalcularSatEcf: Boolean;
begin
  Result := FCalcularSatEcf;
end;

function TParametrosServicoIcmsEfetivo.CalcularSatEcf(
  AValue: Boolean): IParametrosServicoIcmsEfetivo;
begin
  result := Self;
  FCalcularSatEcf := AValue;
end;

function TParametrosServicoIcmsEfetivo.ClienteComercializacao(
  AValue: Boolean): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FClienteComercializacao := AValue;
end;

function TParametrosServicoIcmsEfetivo.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosServicoIcmsEfetivo.ClienteIndustria: Boolean;
begin
  Result := FClienteIndustria;
end;

function TParametrosServicoIcmsEfetivo.ClienteIndustria(
  AValue: Boolean): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FClienteIndustria := Avalue;
end;

function TParametrosServicoIcmsEfetivo.CodigoDaEmpresa(
  AValue: String): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TParametrosServicoIcmsEfetivo.CodigoDaEmpresaTE: String;
begin
  Result := FCodigoDaEmpresaTE;
end;

function TParametrosServicoIcmsEfetivo.CodigoDaEmpresaTE(
  AValue: String): IParametrosServicoIcmsEfetivo;
begin
  result := Self;
  FCodigoDaEmpresaTE := Avalue;
end;

function TParametrosServicoIcmsEfetivo.CodigoDaFazenda: String;
begin
  Result := FCodigoDaFazenda;
end;

function TParametrosServicoIcmsEfetivo.CodigoDaFazenda(
  AValue: String): IParametrosServicoIcmsEfetivo;
begin
  result := Self;
  FCodigoDaFazenda := Avalue;
end;

function TParametrosServicoIcmsEfetivo.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosServicoIcmsEfetivo.CodigoDoCliente: String;
begin
  result := FCodigoDoCliente;
end;

function TParametrosServicoIcmsEfetivo.CodigoDoCliente(
  AValue: String): IParametrosServicoIcmsEfetivo;
begin
  result := Self;
  FCodigoDoCliente := Avalue;
end;

function TParametrosServicoIcmsEfetivo.CodigoDoFornecedor(
  AValue: String): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TParametrosServicoIcmsEfetivo.EspecieDocumento(
  AValue: String): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FEspecieDocumento := Avalue;
end;

function TParametrosServicoIcmsEfetivo.EspecieDocumento: String;
begin
  Result := FEspecieDocumento;
end;

function TParametrosServicoIcmsEfetivo.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

function TParametrosServicoIcmsEfetivo.GerandoCasosTestes: Boolean;
begin
  Result := FGerandoCasosTestes;
end;

function TParametrosServicoIcmsEfetivo.GerandoCasosTestes(
  AValue: boolean): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FGerandoCasosTestes := AValue;
end;

function TParametrosServicoIcmsEfetivo.MatItensIcmsEfetivo: TMatrizFechamentoIcmsEfetivo;
begin
  Result := FMatItensIcmsEfetivo;
end;

function TParametrosServicoIcmsEfetivo.MatItensIcmsEfetivo(
  AValue: TMatrizFechamentoIcmsEfetivo): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FMatItensIcmsEfetivo := Avalue;
end;

class function TParametrosServicoIcmsEfetivo.New: IParametrosServicoIcmsEfetivo;
begin
  Result := Self.Create;
end;

function TParametrosServicoIcmsEfetivo.NotaComplementoFornecedor: Boolean;
begin
  Result := FNotaComplementoFornecedor;
end;

function TParametrosServicoIcmsEfetivo.NotaComplementoFornecedor(
  AValue: Boolean): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FNotaComplementoFornecedor := AValue;
end;

function TParametrosServicoIcmsEfetivo.NotaEspecialFornecedor(
  AValue: Boolean): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FNotaEspecialFornecedor := AValue;
end;

function TParametrosServicoIcmsEfetivo.NotaEspecialFornecedor: Boolean;
begin
  Result := FNotaEspecialFornecedor;
end;

function TParametrosServicoIcmsEfetivo.OpcaoDoDocumento: String;
begin
  Result := FOpcaoDoDocumento;
end;


function TParametrosServicoIcmsEfetivo.OpcaoDoDocumento(
  AValue: String): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FOpcaoDoDocumento := AValue;
end;

function TParametrosServicoIcmsEfetivo.ParametrosClienteConsumidor(
  AValue: IParametrosFaturamentoImpostosClienteConsumidor): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FParametrosClienteConsumidor := AValue;
end;

function TParametrosServicoIcmsEfetivo.ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := FParametrosClienteConsumidor;
end;


function TParametrosServicoIcmsEfetivo.SequencialEnderecoEntrega(
  AValue: String): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FSequencialEnderecoEntrega := AValue;
end;

function TParametrosServicoIcmsEfetivo.TipoOperacaoPedidoVenda(
  AValue: String): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FTipoOperacaoPedidoVenda := Avalue;
end;

function TParametrosServicoIcmsEfetivo.TipoOperacaoPedidoVenda: String;
begin
  Result := FTipoOperacaoPedidoVenda;
end;

function TParametrosServicoIcmsEfetivo.UtilizaSat: Boolean;
begin
  Result := FUtilizaSat;
end;

function TParametrosServicoIcmsEfetivo.UtilizaSat(
  AValue: Boolean): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FUtilizaSat := AValue;
end;

function TParametrosServicoIcmsEfetivo.SequencialEnderecoEntrega: String;
begin
  Result := FSequencialEnderecoEntrega;
end;

function TParametrosServicoIcmsEfetivo.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

function TParametrosServicoIcmsEfetivo.VendaPresencial(
  AValue: Boolean): IParametrosServicoIcmsEfetivo;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

{ TParametrosCalculoIcmsEfetivo }


function TParametrosCalculoIcmsEfetivo.AliquotaIcmsEfetiva(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FAliquotaIcmsEfetiva := AValue;
end;

function TParametrosCalculoIcmsEfetivo.AliquotaOperacaoPropriaICMSEntrada(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FAliquotaOperacaoPropriaICMSEntrada := AValue;
end;

function TParametrosCalculoIcmsEfetivo.AliquotaOperacaoPropriaICMSEntrada: Double;
begin
  Result := FAliquotaOperacaoPropriaICMSEntrada;
end;

function TParametrosCalculoIcmsEfetivo.AliquotaIcmsEfetiva: Double;
begin
  Result := FAliquotaIcmsEfetiva;
end;

function TParametrosCalculoIcmsEfetivo.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosCalculoIcmsEfetivo.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosCalculoIcmsEfetivo.EncontrouDocumento(
  AValue: Boolean): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FEncontrouDocumento := AValue;
end;

function TParametrosCalculoIcmsEfetivo.EncontrouDocumentoOperacaoPropriaICMSEntrada: Boolean;
begin
  Result := FEncontrouDocumentoOperacaoPropriaICMSEntrada;
end;

function TParametrosCalculoIcmsEfetivo.EncontrouDocumentoOperacaoPropriaICMSEntrada(
  AValue: Boolean): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FEncontrouDocumentoOperacaoPropriaICMSEntrada := AValue;
end;

function TParametrosCalculoIcmsEfetivo.EncontrouDocumento: Boolean;
begin
  Result := FEncontrouDocumento;
end;

class function TParametrosCalculoIcmsEfetivo.New: IParametrosCalculoIcmsEfetivo;
begin
  Result := Self.Create;
end;

function TParametrosCalculoIcmsEfetivo.PercentualReducaoBaseCalcEfetiva(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FPercentualReducaoBaseCalcEfetiva := AValue;
end;

function TParametrosCalculoIcmsEfetivo.PercentualReducaoBaseCalcEfetiva: Double;
begin
  Result := FPercentualReducaoBaseCalcEfetiva;
end;

function TParametrosCalculoIcmsEfetivo.Quantidade(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FQuantidade := AValue;
end;

function TParametrosCalculoIcmsEfetivo.Quantidade: Double;
begin
  Result := FQuantidade;
end;

function TParametrosCalculoIcmsEfetivo.QuantidadeItem: Double;
begin
  Result := FQuantidadeItem;
end;

function TParametrosCalculoIcmsEfetivo.QuantidadeItem(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FQuantidadeItem := AValue;
end;

function TParametrosCalculoIcmsEfetivo.ValorBaseCalculoEfetiva: Double;
begin
  Result := FValorBaseCalculoEfetiva;
end;

function TParametrosCalculoIcmsEfetivo.ValorBaseCalculoEfetiva(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseCalculoEfetiva := AValue;
end;

function TParametrosCalculoIcmsEfetivo.ValorBaseOperacaoPropriaICMSEntrada(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseOperacaoPropriaICMSEntrada := AValue;
end;

function TParametrosCalculoIcmsEfetivo.ValorBaseOperacaoPropriaICMSEntrada: Double;
begin
  Result := FValorBaseOperacaoPropriaICMSEntrada;
end;

function TParametrosCalculoIcmsEfetivo.ValorBaseRetida(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseRetida := AValue;
end;

function TParametrosCalculoIcmsEfetivo.ValorBaseRetida: Double;
begin
  Result := FValorBaseRetida;
end;

function TParametrosCalculoIcmsEfetivo.ValorRetido(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorRetido := AValue;
end;

function TParametrosCalculoIcmsEfetivo.ValorRetido: Double;
begin
  Result := FValorRetido;
end;

function TParametrosCalculoIcmsEfetivo.ValorIcmsSubstitutoItem: Double;
begin
  Result := FValorIcmsSubstitutoItem;
end;

function TParametrosCalculoIcmsEfetivo.ValorIcmsSubstitutoItem(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorIcmsSubstitutoItem := AValue;
end;

function TParametrosCalculoIcmsEfetivo.ValorOperacaoPropriaICMSEntrada: Double;
begin
  Result := FValorOperacaoPropriaICMSEntrada;
end;

function TParametrosCalculoIcmsEfetivo.ValorOperacaoPropriaICMSEntrada(
  AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorOperacaoPropriaICMSEntrada := AValue;
end;

function TParametrosCalculoIcmsEfetivo.ValorOperacaoPropriaICMSSaida: Double;
begin
  Result := FValorOperacaoPropriaICMSSaida;
end;

function TParametrosCalculoIcmsEfetivo.ValorOperacaoPropriaICMSSaida(
  const AValue: Double): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorOperacaoPropriaICMSSaida := AValue;
end;

function TParametrosCalculoIcmsEfetivo.IcmsEfetivoSemUltimaNota: Boolean;
begin
  Result := FIcmsEfetivoSemUltimaNota;
end;

function TParametrosCalculoIcmsEfetivo.IcmsEfetivoSemUltimaNota(
  AValue: Boolean): IParametrosCalculoIcmsEfetivo;
begin
  Result := Self;
  FIcmsEfetivoSemUltimaNota := AValue;
end;

{ TResultadoCalculoIcmsEfetivo }


function TResultadoCalculoIcmsEfetivo.AliquotaIcmsEfetivaItem(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FAliquotaIcmsEfetivaItem := AValue;
end;

function TResultadoCalculoIcmsEfetivo.AliquotaOperacaoPropriaICMSEntrada(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FAliquotaOperacaoPropriaICMSEntrada := AValue;
end;

function TResultadoCalculoIcmsEfetivo.AliquotaOperacaoPropriaICMSEntrada: Double;
begin
  Result := FAliquotaOperacaoPropriaICMSEntrada
end;

function TResultadoCalculoIcmsEfetivo.AliquotaIcmsEfetivaItem: Double;
begin
  Result := FAliquotaIcmsEfetivaItem;
end;

class function TResultadoCalculoIcmsEfetivo.New: IResultadoCalculoIcmsEfetivo;
begin
  Result := Self.Create;
end;

function TResultadoCalculoIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem: Double;
begin
  Result := FPercentualReducaoBaseCalcEfetivaItem;
end;

function TResultadoCalculoIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FPercentualReducaoBaseCalcEfetivaItem := AValue;
end;

function TResultadoCalculoIcmsEfetivo.ValorBaseCalculoEfetivaItem(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseCalculoEfetivaItem := AValue;
end;

function TResultadoCalculoIcmsEfetivo.ValorBaseCalculoEfetivaItem: Double;
begin
  Result := FValorBaseCalculoEfetivaItem;
end;

function TResultadoCalculoIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem: Double;
begin
  Result := FValorBaseCalculoIcmsStRetidoItem;
end;

function TResultadoCalculoIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseCalculoIcmsStRetidoItem := AValue;
end;

function TResultadoCalculoIcmsEfetivo.ValorBaseOperacaoPropriaICMSEntrada(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorBaseOperacaoPropriaICMSEntrada := AValue;
end;

function TResultadoCalculoIcmsEfetivo.ValorBaseOperacaoPropriaICMSEntrada: Double;
begin
  Result := FValorBaseOperacaoPropriaICMSEntrada;
end;

function TResultadoCalculoIcmsEfetivo.ValorIcmsEfetivaItem(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorIcmsEfetivaItem := AValue;
end;

function TResultadoCalculoIcmsEfetivo.ValorIcmsEfetivaItem: Double;
begin
  Result := FValorIcmsEfetivaItem;
end;

function TResultadoCalculoIcmsEfetivo.ValorIcmsStRetidoItem(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorIcmsStRetidoItem := AValue;
end;

function TResultadoCalculoIcmsEfetivo.ValorIcmsStRetidoItem: Double;
begin
  Result := FValorIcmsStRetidoItem;
end;

function TResultadoCalculoIcmsEfetivo.ValorIcmsSubstitutoItem(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorIcmsSubstitutoItem := AValue;
end;

function TResultadoCalculoIcmsEfetivo.ValorOperacaoPropriaICMSEntrada: Double;
begin
  Result := FValorOperacaoPropriaICMSEntrada;
end;

function TResultadoCalculoIcmsEfetivo.ValorOperacaoPropriaICMSEntrada(
  AValue: Double): IResultadoCalculoIcmsEfetivo;
begin
  Result := Self;
  FValorOperacaoPropriaICMSEntrada := AValue;
end;

function TResultadoCalculoIcmsEfetivo.ValorIcmsSubstitutoItem: Double;
begin
  Result := FValorIcmsSubstitutoItem;
end;


{ TResultadoServicosClasseIcmsEfetivo }

class function TResultadoServicosClasseIcmsEfetivo.New: IResultadoServicosClasseIcmsEfetivo;
begin
  result := Self.Create;
end;

function TResultadoServicosClasseIcmsEfetivo.ParametrosCalculoIcmsEfetivo: IParametrosCalculoIcmsEfetivo;
begin
  Result := FParametrosCalculoIcmsEfetivo;
end;

function TResultadoServicosClasseIcmsEfetivo.ParametrosCalculoIcmsEfetivo(
  AValue: IParametrosCalculoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo;
begin
  Result := Self;
  FParametrosCalculoIcmsEfetivo := Avalue;
end;

function TResultadoServicosClasseIcmsEfetivo.ResultadoCalculoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo;
begin
  result := FResultadoCalculoIcmsEfetivo;
end;

function TResultadoServicosClasseIcmsEfetivo.ResultadoCalculoIcmsEfetivo(
  AValue: TMatrizFechamentoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo;
begin
  result := self;
  FResultadoCalculoIcmsEfetivo := AValue;
end;

end.
