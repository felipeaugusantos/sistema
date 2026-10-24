unit Faturamento.Impostos.Tipos.Ipi;

interface

uses
  Faturamento.Impostos.Interfaces.Ipi,
  Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Model;

type
  TParametrosCalculoIPI = class(TInterfacedObject, IParametrosCalculoIPI)
  private
    FClienteZonaFranca      : Boolean;
    FClienteOrgaoPublico    : Boolean;
    FVendaDentroDoEstado    : Boolean;
    FClienteDoExterior      : Boolean;
    FSituacaoTributariaIPI  : string;
    FAliquotaDeCalculoIPI   : Double;
    FBaseDoIpi              : Double;
  public
    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosCalculoIPI; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosCalculoIPI; overload;

    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosCalculoIPI; overload;

    function ClienteDoExterior: Boolean; overload;
    function ClienteDoExterior(AValue: Boolean): IParametrosCalculoIPI; overload;

    function SituacaoTributariaIPI: string; overload;
    function SituacaoTributariaIPI(AValue: string): IParametrosCalculoIPI; overload;

    function BaseDoIpi: Double; overload;
    function BaseDoIpi(AValue: Double): IParametrosCalculoIPI; overload;

    function AliquotaDeCalculoIPI: Double; overload;
    function AliquotaDeCalculoIPI(AValue: Double): IParametrosCalculoIPI; overload;

    class function New(): IParametrosCalculoIPI;
  end;

type
  TResultadoCalculoIPI = class(TInterfacedObject, IResultadoCalculoIPI)
  private
    FValorCalculadoIPI   : Double;
    FBaseDeCalculoIPI    : Double;
    FAliquotaDeCalculoIPI: Double;
    FValorCalculadoIPIConsignacao: Double;

  public
    function ValorCalculadoIPI: Double; overload;
    function ValorCalculadoIPI(AValue: Double): IResultadoCalculoIPI; overload;

    function BaseDeCalculoIPI: Double; overload;
    function BaseDeCalculoIPI(AValue: Double): IResultadoCalculoIPI; overload;

    function AliquotaDeCalculoIPI: Double; overload;
    function AliquotaDeCalculoIPI(AValue: Double): IResultadoCalculoIPI; overload;

    function ValorCalculadoIPIConsignacao: Double; overload;
    function ValorCalculadoIPIConsignacao(AValue: Double): IResultadoCalculoIPI; overload;

    class function New(): IResultadoCalculoIPI;
  end;

type
  TParametrosServicoIPI = class(TInterfacedObject, IParametrosServicoIPI)
  private
    FCodigoDoCliente: String;
    FCodigoDoProduto: String;
    FCodigoDaEmpresa: String;
    FClassificacaoFiscalDoItem: String;
    FVendaPresencial: Boolean;
    FEspecieDoDocumento: String;
    FDesmembrarNotaProdutosServicos: Boolean;
    FOpcaoDoDocumento: String;
    FOpcaoDeItemNfEspiritoSanto: TOpcItensNFespTinta;
    FEspecieDeDevolucao: String;
    FDesmembrarMeiaNotaComNotaNormal: Boolean;
    FBaixaDeEntregaFutura: Boolean;
    FEntregaFutura: Boolean;
    FMeiaNotaFatorExpedicao: Boolean;
    FTotalGeralDoItem : Double;
    FValorFreteDoItem : Double;
    FDespesaAcessoriaDoItem : Double;
    FDescontoEspecial : Double;
    FNotaComplementoFornecedor : Boolean;
    FNotaEspecialFornecedor : Boolean;
    FCodigoDoFornecedor : String;
    FSequencialEnderecoEntrega : String;
    FGerandoCasosTestes: Boolean;
    FClienteConsumidorFinal: Boolean;
    FParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
    FTotalGeralDoItemPreUlt : Double;
    FTipoDePedidoFaturamento: String;
    FTipoDeBaixaEntregaFutura: String;
    FOpcaoDoDocumentoVerdadeira: String;
    FCodigoDaFazenda: String;
  public
    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosServicoIPI; overload;

    function CodigoDoProduto: String; overload;
    function CodigoDoProduto(AValue: String): IParametrosServicoIPI; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IParametrosServicoIPI; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosServicoIPI; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosServicoIPI; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosServicoIPI; overload;

    function DesmembrarNotaProdutosServicos : Boolean; overload;
    function DesmembrarNotaProdutosServicos(AValue: Boolean): IParametrosServicoIPI; overload;

    function OpcaoDoDocumento: String; overload;
    function OpcaoDoDocumento(AValue: String): IParametrosServicoIPI; overload;

    function OpcaoDeItemNfEspiritoSanto : TOpcItensNFespTinta; overload;
    function OpcaoDeItemNfEspiritoSanto(AValue: TOpcItensNFespTinta): IParametrosServicoIPI; overload;

    function EspecieDeDevolucao: String; overload;
    function EspecieDeDevolucao(AValue: String): IParametrosServicoIPI; overload;

    function DesmembrarMeiaNotaComNotaNormal: Boolean; overload;
    function DesmembrarMeiaNotaComNotaNormal(AValue: Boolean): IParametrosServicoIPI; overload;

    function BaixaDeEntregaFutura : Boolean; overload;
    function BaixaDeEntregaFutura(AValue : Boolean): IParametrosServicoIPI; overload;

    function EntregaFutura : Boolean; overload;
    function EntregaFutura(AValue : Boolean): IParametrosServicoIPI; overload;

    function MeiaNotaFatorExpedicao : Boolean; overload;
    function MeiaNotaFatorExpedicao(AValue : Boolean): IParametrosServicoIPI; overload;

    function TotalGeralDoItem : Double;overload;
    function TotalGeralDoItem(AValue : Double): IParametrosServicoIPI; overload;

    function ValorFreteDoItem : Double;overload;
    function ValorFreteDoItem(AValue : Double): IParametrosServicoIPI; overload;

    function DespesaAcessoriaDoItem : Double;overload;
    function DespesaAcessoriaDoItem(AValue : Double): IParametrosServicoIPI; overload;

    function DescontoEspecial : Double;overload;
    function DescontoEspecial(AValue : Double): IParametrosServicoIPI; overload;

    function NotaComplementoFornecedor : Boolean; overload;
    function NotaComplementoFornecedor(AValue : Boolean): IParametrosServicoIPI; overload;

    function NotaEspecialFornecedor : Boolean; overload;
    function NotaEspecialFornecedor(AValue : Boolean): IParametrosServicoIPI; overload;

    function CodigoDoFornecedor : String; overload;
    function CodigoDoFornecedor(AValue: String): IParametrosServicoIPI; overload;

    function SequencialEnderecoEntrega : String; overload;
    function SequencialEnderecoEntrega(AValue: String): IParametrosServicoIPI; overload;

    function GerandoCasosTestes: Boolean; overload;
    function GerandoCasosTestes(AValue: boolean): IParametrosServicoIPI; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: boolean): IParametrosServicoIPI; overload;

    function ParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue : IParametrosFaturamentoImpostosClienteConsumidor) : IParametrosServicoIPI; overload;

    function TotalGeralDoItemPreUlt : Double;overload;
    function TotalGeralDoItemPreUlt(AValue : Double): IParametrosServicoIPI; overload;

    function TipoDePedidoFaturamento : String;overload;
    function TipoDePedidoFaturamento(AValue : String): IParametrosServicoIPI; overload;

    function TipoDeBaixaEntregaFutura: String; overload;
    function TipoDeBaixaEntregaFutura(AValue: String): IParametrosServicoIPI; overload;

    function OpcaoDoDocumentoVerdadeira: String; overload;
    function OpcaoDoDocumentoVerdadeira(AValue: String): IParametrosServicoIPI; overload;

    function CodigoDaFazenda: String; overload;
    function CodigoDaFazenda(AValue: String): IParametrosServicoIPI; overload;

    class function New(): IParametrosServicoIPI;
  end;

type
  TResultadoServicosClasseIpi = class(TInterfacedObject, IResultadoServicosClasseIpi)
  private
    FResultadoCalculoIPI: IResultadoCalculoIPI;
    FParametrosCalculoIPI: IParametrosCalculoIPI;
  public
    function ResultadoCalculoIPI: IResultadoCalculoIPI; overload;
    function ResultadoCalculoIPI(AValue: IResultadoCalculoIPI): IResultadoServicosClasseIpi; overload;

    function ParametrosCalculoIPI: IParametrosCalculoIPI; overload;
    function ParametrosCalculoIPI(AValue: IParametrosCalculoIPI): IResultadoServicosClasseIpi; overload;

    class function New(): IResultadoServicosClasseIpi;
  end;


Type
  TResultadoAbreviacaoIpi =  class(TInterfacedObject, IResultadoAbreviacaoIpi)
  private
    FBaseDeCalculoIPI    : Double;
    FAliquotaDeCalculoIPI: Double;
  public
    function BaseDeCalculoIPI: Double; overload;
    function BaseDeCalculoIPI(AValue: Double): IResultadoAbreviacaoIpi; overload;

    function AliquotaDeCalculoIPI: Double; overload;
    function AliquotaDeCalculoIPI(AValue: Double): IResultadoAbreviacaoIpi; overload;

    class function New(): IResultadoAbreviacaoIpi;
  end;

implementation

{ TParametrosCalculoIPI }

function TParametrosCalculoIPI.AliquotaDeCalculoIPI: Double;
begin
  Result := FAliquotaDeCalculoIPI;
end;

function TParametrosCalculoIPI.AliquotaDeCalculoIPI(
  AValue: Double): IParametrosCalculoIPI;
begin
  Result := Self;
  FAliquotaDeCalculoIPI := AValue;
end;

function TParametrosCalculoIPI.BaseDoIpi: Double;
begin
  Result := FBaseDoIpi;
end;

function TParametrosCalculoIPI.BaseDoIpi(AValue: Double): IParametrosCalculoIPI;
begin
  Result := Self;
  FBaseDoIpi := AValue;
end;

function TParametrosCalculoIPI.ClienteOrgaoPublico(
  AValue: Boolean): IParametrosCalculoIPI;
begin
  Result := Self;
  FClienteOrgaoPublico := AValue;
end;

function TParametrosCalculoIPI.ClienteOrgaoPublico: Boolean;
begin
  Result := FClienteOrgaoPublico;
end;

function TParametrosCalculoIPI.ClienteZonaFranca(
  AValue: Boolean): IParametrosCalculoIPI;
begin
  Result := Self;
  FClienteZonaFranca := AValue;
end;


function TParametrosCalculoIPI.ClienteZonaFranca: Boolean;
begin
  Result := FClienteZonaFranca;
end;

function TParametrosCalculoIPI.ClienteDoExterior: Boolean;
begin
  Result := FClienteDoExterior;
end;

function TParametrosCalculoIPI.ClienteDoExterior(
  AValue: Boolean): IParametrosCalculoIPI;
begin
  Result := Self;
  FClienteDoExterior := AValue;
end;

class function TParametrosCalculoIPI.New: IParametrosCalculoIPI;
begin
  Result := Self.Create;
end;

function TParametrosCalculoIPI.SituacaoTributariaIPI: string;
begin
  Result := FSituacaoTributariaIPI;
end;


function TParametrosCalculoIPI.SituacaoTributariaIPI(
  AValue: string): IParametrosCalculoIPI;
begin
  Result := Self;
  FSituacaoTributariaIPI := AValue;
end;

function TParametrosCalculoIPI.VendaDentroDoEstado(
  AValue: Boolean): IParametrosCalculoIPI;
begin
  Result := Self;
  FVendaDentroDoEstado := AValue;
end;

function TParametrosCalculoIPI.VendaDentroDoEstado: Boolean;
begin
  Result := FVendaDentroDoEstado;
end;

{ TResultadoCalculoIPI }

function TResultadoCalculoIPI.BaseDeCalculoIPI: Double;
begin
  Result := FBaseDeCalculoIPI;
end;

function TResultadoCalculoIPI.AliquotaDeCalculoIPI: Double;
begin
  Result := FAliquotaDeCalculoIPI;
end;

function TResultadoCalculoIPI.AliquotaDeCalculoIPI(
  AValue: Double): IResultadoCalculoIPI;
begin
  Result := Self;
  FAliquotaDeCalculoIPI := AValue;
end;

function TResultadoCalculoIPI.BaseDeCalculoIPI(
  AValue: Double): IResultadoCalculoIPI;
begin
  Result := Self;
  FBaseDeCalculoIPI := AValue;
end;

class function TResultadoCalculoIPI.New: IResultadoCalculoIPI;
begin
  Result := Self.Create;
end;

function TResultadoCalculoIPI.ValorCalculadoIPI: Double;
begin
  Result := FValorCalculadoIPI;
end;

function TResultadoCalculoIPI.ValorCalculadoIPI(
  AValue: Double): IResultadoCalculoIPI;
begin
  Result := Self;
  FValorCalculadoIPI := AValue;
end;

function TResultadoCalculoIPI.ValorCalculadoIPIConsignacao: Double;
begin
  Result := FValorCalculadoIPIConsignacao;
end;

function TResultadoCalculoIPI.ValorCalculadoIPIConsignacao(
  AValue: Double): IResultadoCalculoIPI;
begin
  Result := Self;
  FValorCalculadoIPIConsignacao := AValue;
end;

{ TParametrosServicoIPI }
function TParametrosServicoIPI.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosServicoIPI.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosServicoIPI.ClassificacaoFiscalDoItem(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosServicoIPI.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosServicoIPI.ClienteConsumidorFinal(
  AValue: boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosServicoIPI.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosServicoIPI.CodigoDaEmpresa(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TParametrosServicoIPI.CodigoDaFazenda: String;
begin
  Result := FCodigoDaFazenda;
end;

function TParametrosServicoIPI.CodigoDaFazenda(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FCodigoDaFazenda := AValue;
end;

function TParametrosServicoIPI.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosServicoIPI.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TParametrosServicoIPI.CodigoDoCliente(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TParametrosServicoIPI.CodigoDoFornecedor(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TParametrosServicoIPI.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

function TParametrosServicoIPI.CodigoDoProduto(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FCodigoDoProduto := AValue;
end;

function TParametrosServicoIPI.DesmembrarMeiaNotaComNotaNormal: Boolean;
begin
  Result := FDesmembrarMeiaNotaComNotaNormal;
end;

function TParametrosServicoIPI.DescontoEspecial: Double;
begin
  Result := FDescontoEspecial;
end;

function TParametrosServicoIPI.DescontoEspecial(
  AValue: Double): IParametrosServicoIPI;
begin
  Result := Self;
  FDescontoEspecial := AValue;
end;

function TParametrosServicoIPI.DesmembrarMeiaNotaComNotaNormal(
  AValue: Boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FDesmembrarMeiaNotaComNotaNormal := AValue;
end;

function TParametrosServicoIPI.DesmembrarNotaProdutosServicos: Boolean;
begin
  Result := FDesmembrarNotaProdutosServicos;
end;

function TParametrosServicoIPI.DesmembrarNotaProdutosServicos(
  AValue: Boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FDesmembrarNotaProdutosServicos := AValue;
end;

function TParametrosServicoIPI.DespesaAcessoriaDoItem: Double;
begin
  Result := FDespesaAcessoriaDoItem;
end;

function TParametrosServicoIPI.DespesaAcessoriaDoItem(
  AValue: Double): IParametrosServicoIPI;
begin
  Result := Self;
  FDespesaAcessoriaDoItem := AValue;
end;

function TParametrosServicoIPI.CodigoDoProduto: String;
begin
  Result := FCodigoDoProduto;
end;

function TParametrosServicoIPI.EntregaFutura(
  AValue: Boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FEntregaFutura := AValue;
end;

function TParametrosServicoIPI.EntregaFutura: Boolean;
begin
  Result := FEntregaFutura;
end;

function TParametrosServicoIPI.EspecieDeDevolucao(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FEspecieDeDevolucao := AValue;
end;

function TParametrosServicoIPI.EspecieDeDevolucao: String;
begin
  Result := FEspecieDeDevolucao;
end;

function TParametrosServicoIPI.EspecieDoDocumento(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosServicoIPI.GerandoCasosTestes: Boolean;
begin
  result := FGerandoCasosTestes;
end;

function TParametrosServicoIPI.GerandoCasosTestes(
  AValue: boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FGerandoCasosTestes := AValue;
end;

function TParametrosServicoIPI.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

//function TParametrosServicoIPI.EstadoDeEntrega(
//  AValue: String): IParametrosServicoIPI;
//begin
//  Result := Self;
//  FEstadoDeEntrega := AValue;
//end;

function TParametrosServicoIPI.MeiaNotaFatorExpedicao: Boolean;
begin
  Result := FMeiaNotaFatorExpedicao;
end;

function TParametrosServicoIPI.MeiaNotaFatorExpedicao(
  AValue: Boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FMeiaNotaFatorExpedicao := AValue;
end;

//function TParametrosServicoIPI.EstadoDeEntrega: String;
//begin
//  Result := FEstadoDeEntrega;
//end;

class function TParametrosServicoIPI.New: IParametrosServicoIPI;
begin
  Result := Self.Create;
end;

function TParametrosServicoIPI.NotaComplementoFornecedor(
  AValue: Boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FNotaComplementoFornecedor := AValue;
end;

function TParametrosServicoIPI.NotaComplementoFornecedor: Boolean;
begin
  Result := FNotaComplementoFornecedor;
end;

function TParametrosServicoIPI.NotaEspecialFornecedor: Boolean;
begin
  Result := FNotaEspecialFornecedor;
end;

function TParametrosServicoIPI.NotaEspecialFornecedor(
  AValue: Boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FNotaEspecialFornecedor := AValue;
end;

function TParametrosServicoIPI.OpcaoDeItemNfEspiritoSanto: TOpcItensNFespTinta;
begin
  Result := FOpcaoDeItemNfEspiritoSanto;
end;

function TParametrosServicoIPI.OpcaoDeItemNfEspiritoSanto(
  AValue: TOpcItensNFespTinta): IParametrosServicoIPI;
begin
  Result := Self;
  FOpcaoDeItemNfEspiritoSanto := AValue;
end;

function TParametrosServicoIPI.OpcaoDoDocumento(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FOpcaoDoDocumento := AValue;
end;

function TParametrosServicoIPI.ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := FParametrosClienteConsumidor;
end;

function TParametrosServicoIPI.ParametrosClienteConsumidor(
  AValue: IParametrosFaturamentoImpostosClienteConsumidor): IParametrosServicoIPI;
begin
  Result := Self;
  FParametrosClienteConsumidor := AValue;
end;

function TParametrosServicoIPI.SequencialEnderecoEntrega: String;
begin
  Result := FSequencialEnderecoEntrega;
end;

function TParametrosServicoIPI.SequencialEnderecoEntrega(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FSequencialEnderecoEntrega := AValue;
end;

function TParametrosServicoIPI.TotalGeralDoItem(
  AValue: Double): IParametrosServicoIPI;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosServicoIPI.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

function TParametrosServicoIPI.OpcaoDoDocumento: String;
begin
  Result := FOpcaoDoDocumento;
end;

function TParametrosServicoIPI.ValorFreteDoItem(
  AValue: Double): IParametrosServicoIPI;
begin
  Result := Self;
  FValorFreteDoItem := AValue;
end;

function TParametrosServicoIPI.ValorFreteDoItem: Double;
begin
  Result := FValorFreteDoItem;
end;

function TParametrosServicoIPI.VendaPresencial(
  AValue: Boolean): IParametrosServicoIPI;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

function TParametrosServicoIPI.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

function TParametrosServicoIPI.TotalGeralDoItemPreUlt: Double;
begin
  Result := FTotalGeralDoItemPreUlt;
end;

function TParametrosServicoIPI.TotalGeralDoItemPreUlt(
  AValue: Double): IParametrosServicoIPI;
begin
  Result := Self;
  FTotalGeralDoItemPreUlt := AValue;
end;

function TParametrosServicoIPI.TipoDeBaixaEntregaFutura: String;
begin
  Result := FTipoDeBaixaEntregaFutura;
end;

function TParametrosServicoIPI.TipoDeBaixaEntregaFutura(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FTipoDeBaixaEntregaFutura := AValue;
end;

function TParametrosServicoIPI.TipoDePedidoFaturamento: String;
begin
  Result := FTipoDePedidoFaturamento;
end;

function TParametrosServicoIPI.TipoDePedidoFaturamento(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FTipoDePedidoFaturamento := AValue;
end;

function TParametrosServicoIPI.OpcaoDoDocumentoVerdadeira: String;
begin
  Result := FOpcaoDoDocumentoVerdadeira;
end;

function TParametrosServicoIPI.OpcaoDoDocumentoVerdadeira(
  AValue: String): IParametrosServicoIPI;
begin
  Result := Self;
  FOpcaoDoDocumentoVerdadeira := AValue;
end;

{ TResultadoServicosClasseIpi }

class function TResultadoServicosClasseIpi.New: IResultadoServicosClasseIpi;
begin
  Result := Self.Create;
end;

function TResultadoServicosClasseIpi.ParametrosCalculoIPI(
  AValue: IParametrosCalculoIPI): IResultadoServicosClasseIpi;
begin
  Result := Self;
  FParametrosCalculoIPI := AValue;
end;

function TResultadoServicosClasseIpi.ParametrosCalculoIPI: IParametrosCalculoIPI;
begin
  Result := FParametrosCalculoIPI;
end;

function TResultadoServicosClasseIpi.ResultadoCalculoIPI: IResultadoCalculoIPI;
begin
  Result := FResultadoCalculoIPI;
end;

function TResultadoServicosClasseIpi.ResultadoCalculoIPI(
  AValue: IResultadoCalculoIPI): IResultadoServicosClasseIpi;
begin
  Result := Self;
  FResultadoCalculoIPI := AValue;
end;

{ TResultadoAbreviacaoIpi }

function TResultadoAbreviacaoIpi.AliquotaDeCalculoIPI: Double;
begin
  Result := FAliquotaDeCalculoIPI;
end;

function TResultadoAbreviacaoIpi.AliquotaDeCalculoIPI(
  AValue: Double): IResultadoAbreviacaoIpi;
begin
  Result := Self;
  FAliquotaDeCalculoIPI := AValue;
end;

function TResultadoAbreviacaoIpi.BaseDeCalculoIPI: Double;
begin
  Result := FBaseDeCalculoIPI;
end;

function TResultadoAbreviacaoIpi.BaseDeCalculoIPI(
  AValue: Double): IResultadoAbreviacaoIpi;
begin
  Result := Self;
  FBaseDeCalculoIPI := AValue;
end;

class function TResultadoAbreviacaoIpi.New: IResultadoAbreviacaoIpi;
begin
  Result := Self.Create;
end;

end.
