unit Faturamento.Impostos.Tipos.ZerarImpostos.Fcp;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos.Fcp;

type
  TParametrosRegraZerarImpostosFcp = class(TInterfacedObject, IParametrosRegraZerarImpostosFcp)
  private
    FProdutoST: Boolean;
    FCodigoDaSubstituicaoTributariaDoItem: String;
    FBaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
    FValorDaSubstituicaoTributariaDoItem: Double;
    FEntregaFuturaDoItem: Boolean;
    FBaixaDeEntregaFutura: Boolean;
    FEspecieDoDocumento: String;
    FClienteOrgaoPublico: Boolean;
    FClienteOrgaoPublicoDifal: Boolean;
    FVendaPresencial: Boolean;
    FClassificacaoFiscalDoItem : String;
    FValorDaSTDoItemNoFatuamentoConsignacao : Double;
    FSTAtribuidaPorRegimeEspecial: Boolean;
    FDentroDoEstado: Boolean;
  public
    function ProdutoST: Boolean; overload;
    function ProdutoST(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostosFcp; overload;

    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosRegraZerarImpostosFcp; overload;

    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosRegraZerarImpostosFcp; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostosFcp; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function ClienteOrgaoPublicoDifal: Boolean; overload;
    function ClienteOrgaoPublicoDifal(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostosFcp; overload;

    function ValorDaSTDoItemNoFatuamentoConsignacao: Double; overload;
    function ValorDaSTDoItemNoFatuamentoConsignacao(AValue: Double): IParametrosRegraZerarImpostosFcp; overload;

    function STAtribuidaPorRegimeEspecial: Boolean; overload;
    function STAtribuidaPorRegimeEspecial(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosFcp; overload;

    class function New(): IParametrosRegraZerarImpostosFcp;
  end;

implementation

{ TParametrosRegraZerarImpostosFcp }

function TParametrosRegraZerarImpostosFcp.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosRegraZerarImpostosFcp.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosRegraZerarImpostosFcp.BaseDeCalculoDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FBaseDeCalculoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegraZerarImpostosFcp.BaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FBaseDeCalculoDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegraZerarImpostosFcp.ClienteOrgaoPublico: Boolean;
begin
  Result := FClienteOrgaoPublico;
end;

function TParametrosRegraZerarImpostosFcp.ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosRegraZerarImpostosFcp.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosRegraZerarImpostosFcp.ClienteOrgaoPublico(
  AValue: Boolean): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FClienteOrgaoPublico := AValue;
end;

function TParametrosRegraZerarImpostosFcp.ClienteOrgaoPublicoDifal(
  AValue: Boolean): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FClienteOrgaoPublicoDifal := AValue;
end;

function TParametrosRegraZerarImpostosFcp.ClienteOrgaoPublicoDifal: Boolean;
begin
  Result := FClienteOrgaoPublicoDifal;
end;

function TParametrosRegraZerarImpostosFcp.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegraZerarImpostosFcp.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

function TParametrosRegraZerarImpostosFcp.DentroDoEstado(
  AValue: Boolean): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosRegraZerarImpostosFcp.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegraZerarImpostosFcp.EntregaFuturaDoItem: Boolean;
begin
  Result := FEntregaFuturaDoItem;
end;

function TParametrosRegraZerarImpostosFcp.EntregaFuturaDoItem(
  AValue: Boolean): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FEntregaFuturaDoItem := AValue;
end;

function TParametrosRegraZerarImpostosFcp.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosRegraZerarImpostosFcp.EspecieDoDocumento(
  AValue: String): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

class function TParametrosRegraZerarImpostosFcp.New: IParametrosRegraZerarImpostosFcp;
begin
  Result := Self.Create;
end;

function TParametrosRegraZerarImpostosFcp.ProdutoST(
  AValue: Boolean): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FProdutoST := AValue;
end;

function TParametrosRegraZerarImpostosFcp.STAtribuidaPorRegimeEspecial: Boolean;
begin
  Result := FSTAtribuidaPorRegimeEspecial;
end;

function TParametrosRegraZerarImpostosFcp.STAtribuidaPorRegimeEspecial(
  AValue: Boolean): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FSTAtribuidaPorRegimeEspecial := AValue;
end;

function TParametrosRegraZerarImpostosFcp.ProdutoST: Boolean;
begin
  Result := FProdutoST;
end;

function TParametrosRegraZerarImpostosFcp.ValorDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FValorDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegraZerarImpostosFcp.ValorDaSTDoItemNoFatuamentoConsignacao(AValue: Double): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FValorDaSTDoItemNoFatuamentoConsignacao := AValue;
end;

function TParametrosRegraZerarImpostosFcp.ValorDaSTDoItemNoFatuamentoConsignacao: Double;
begin
  Result := FValorDaSTDoItemNoFatuamentoConsignacao;
end;

function TParametrosRegraZerarImpostosFcp.ValorDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegraZerarImpostosFcp.VendaPresencial(
  AValue: Boolean): IParametrosRegraZerarImpostosFcp;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

function TParametrosRegraZerarImpostosFcp.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

end.
