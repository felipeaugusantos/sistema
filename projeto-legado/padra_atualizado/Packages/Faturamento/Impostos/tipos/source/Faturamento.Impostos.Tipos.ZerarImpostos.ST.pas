unit Faturamento.Impostos.Tipos.ZerarImpostos.ST;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos.ST, Shared.Functions.Types;

type
  TParametrosRegraZerarImpostosST = class(TInterfacedObject, IParametrosRegraZerarImpostosST)
  private
    FSimplesNacional: Boolean;
    FClassificacaoFiscalDoItem: String;
    FOpcaoDeDocumento: String;
    FTaxaBombeamentoPedidoOrcamento: Boolean;
    FOpcaoItensNFEspTinta: TOpcItensNFespTinta;
    FBaixaDeEntregaFutura: Boolean;
    FEntregaFuturaDoItem: Boolean;
    FEstadoDaEmpresa: String;
    FCodigoDaSubstituicaoTributariaDoItem: String;
    FEspecieDoDocumento: String;
    FClassificacaoDeVenda: String;
    FDentroDoEstado: Boolean;
    FEmpresaOptanteSimples: Boolean;
    FItemTributado: Boolean;
    FConfiguradoParaTrocarParaX41: Boolean;
    FClienteOrgaoPublico: Boolean;
    FCalcularDescontoIcmsOrgaoPublico: Boolean;
    FClienteZonaFranca: Boolean;
    FClienteConsumidorFinal: Boolean;
    FClienteEstado: String;
    FClienteTARE: String;
    FClienteDEFIT: String;
    FDesmembrarMeiaNotaComNotaNormal: Boolean;
    FMeiaNotaFatorExpedicao: Boolean;
    FTipoDePedidoFaturamento: String;
    FDesmembrarNotaProdutosServicos: Boolean;
    FEhItemConcreto: Boolean;
    FConfiguradoParaTrocarParaX41noParana: Boolean;
    FTipoDeBaixaEntregaFutura: String;
    FTemMIFFEntreOsDevolvidos: Boolean;
    FTributaZonaFrancaManausUsoConsumo: Boolean;
  public
    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostosST; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function ClienteTARE: String; overload;
    function ClienteTARE(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function ClienteDEFIT: String; overload;
    function ClienteDEFIT(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function DesmembrarMeiaNotaComNotaNormal: Boolean; overload;
    function DesmembrarMeiaNotaComNotaNormal(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function MeiaNotaFatorExpedicao : Boolean; overload;
    function MeiaNotaFatorExpedicao(AValue : Boolean): IParametrosRegraZerarImpostosST; overload;

    function TipoDePedidoFaturamento: String; overload;
    function TipoDePedidoFaturamento(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function DesmembrarNotaProdutosServicos: Boolean; overload;
    function DesmembrarNotaProdutosServicos(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function EhItemConcreto: Boolean; overload;
    function EhItemConcreto(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function ConfiguradoParaTrocarParaX41noParana: Boolean; overload;
    function ConfiguradoParaTrocarParaX41noParana(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function TipoDeBaixaEntregaFutura: String; overload;
    function TipoDeBaixaEntregaFutura(AValue: String): IParametrosRegraZerarImpostosST; overload;

    function TemMIFFEntreOsDevolvidos: Boolean; overload;
    function TemMIFFEntreOsDevolvidos(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    function TributaClienteZonaFranca: Boolean; overload;
    function TributaClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosST; overload;

    class function New(): IParametrosRegraZerarImpostosST;
  end;

implementation

{ TParametrosRegraZerarImpostosST }

function TParametrosRegraZerarImpostosST.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosRegraZerarImpostosST.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosRegraZerarImpostosST.CalcularDescontoIcmsOrgaoPublico(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FCalcularDescontoIcmsOrgaoPublico := AValue;
end;

function TParametrosRegraZerarImpostosST.CalcularDescontoIcmsOrgaoPublico: Boolean;
begin
  Result := FCalcularDescontoIcmsOrgaoPublico;
end;

function TParametrosRegraZerarImpostosST.ClassificacaoDeVenda: String;
begin
  Result := FClassificacaoDeVenda;
end;

function TParametrosRegraZerarImpostosST.ClassificacaoDeVenda(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FClassificacaoDeVenda := AValue;
end;

function TParametrosRegraZerarImpostosST.ClassificacaoFiscalDoItem(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosRegraZerarImpostosST.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosRegraZerarImpostosST.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosRegraZerarImpostosST.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosRegraZerarImpostosST.ClienteDEFIT(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FClienteDEFIT := AValue;
end;

function TParametrosRegraZerarImpostosST.ClienteDEFIT: String;
begin
  Result := FClienteDEFIT;
end;

function TParametrosRegraZerarImpostosST.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TParametrosRegraZerarImpostosST.ClienteEstado(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TParametrosRegraZerarImpostosST.ClienteOrgaoPublico: Boolean;
begin
  Result := FClienteOrgaoPublico;
end;

function TParametrosRegraZerarImpostosST.ClienteOrgaoPublico(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FClienteOrgaoPublico := AValue;
end;

function TParametrosRegraZerarImpostosST.ClienteTARE: String;
begin
  Result := FClienteTARE;
end;

function TParametrosRegraZerarImpostosST.ClienteTARE(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FClienteTARE := AValue;
end;

function TParametrosRegraZerarImpostosST.ClienteZonaFranca(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FClienteZonaFranca := AValue;
end;

function TParametrosRegraZerarImpostosST.ClienteZonaFranca: Boolean;
begin
  Result := FClienteZonaFranca;
end;

function TParametrosRegraZerarImpostosST.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegraZerarImpostosST.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegraZerarImpostosST.ConfiguradoParaTrocarParaX41: Boolean;
begin
  Result := FConfiguradoParaTrocarParaX41;
end;

function TParametrosRegraZerarImpostosST.ConfiguradoParaTrocarParaX41(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FConfiguradoParaTrocarParaX41 := AValue;
end;

function TParametrosRegraZerarImpostosST.DentroDoEstado(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosRegraZerarImpostosST.DesmembrarMeiaNotaComNotaNormal(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FDesmembrarMeiaNotaComNotaNormal := AValue;
end;

function TParametrosRegraZerarImpostosST.DesmembrarNotaProdutosServicos: Boolean;
begin
  Result := FDesmembrarNotaProdutosServicos;
end;

function TParametrosRegraZerarImpostosST.DesmembrarNotaProdutosServicos(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FDesmembrarNotaProdutosServicos := AValue;
end;

function TParametrosRegraZerarImpostosST.DesmembrarMeiaNotaComNotaNormal: Boolean;
begin
  Result := FDesmembrarMeiaNotaComNotaNormal;
end;

function TParametrosRegraZerarImpostosST.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

function TParametrosRegraZerarImpostosST.EmpresaOptanteSimples: Boolean;
begin
  Result := FEmpresaOptanteSimples;
end;

function TParametrosRegraZerarImpostosST.EhItemConcreto: Boolean;
begin
  Result := FEhItemConcreto;
end;

function TParametrosRegraZerarImpostosST.EhItemConcreto(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FEhItemConcreto := AValue;
end;

function TParametrosRegraZerarImpostosST.EmpresaOptanteSimples(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FEmpresaOptanteSimples := AValue;
end;

function TParametrosRegraZerarImpostosST.EntregaFuturaDoItem: Boolean;
begin
  Result := FEntregaFuturaDoItem;
end;

function TParametrosRegraZerarImpostosST.EntregaFuturaDoItem(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FEntregaFuturaDoItem := AValue;
end;

function TParametrosRegraZerarImpostosST.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosRegraZerarImpostosST.EspecieDoDocumento(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosRegraZerarImpostosST.EstadoDaEmpresa(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FEstadoDaEmpresa := AValue;
end;

function TParametrosRegraZerarImpostosST.EstadoDaEmpresa: String;
begin
  Result := FEstadoDaEmpresa;
end;

function TParametrosRegraZerarImpostosST.ItemTributado(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FItemTributado := AValue;
end;

function TParametrosRegraZerarImpostosST.MeiaNotaFatorExpedicao(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FMeiaNotaFatorExpedicao := AValue;
end;

function TParametrosRegraZerarImpostosST.MeiaNotaFatorExpedicao: Boolean;
begin
  Result := FMeiaNotaFatorExpedicao;
end;

function TParametrosRegraZerarImpostosST.ConfiguradoParaTrocarParaX41noParana: Boolean;
begin
  Result := FConfiguradoParaTrocarParaX41noParana;
end;

function TParametrosRegraZerarImpostosST.ConfiguradoParaTrocarParaX41noParana(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FConfiguradoParaTrocarParaX41noParana := AValue;
end;

function TParametrosRegraZerarImpostosST.ItemTributado: Boolean;
begin
  Result := FItemTributado;
end;

class function TParametrosRegraZerarImpostosST.New: IParametrosRegraZerarImpostosST;
begin
  Result := Self.Create;
end;

function TParametrosRegraZerarImpostosST.OpcaoDeDocumento(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FOpcaoDeDocumento := AValue;
end;

function TParametrosRegraZerarImpostosST.OpcaoDeDocumento: String;
begin
  Result := FOpcaoDeDocumento;
end;

function TParametrosRegraZerarImpostosST.OpcaoItensNFEspTinta: TOpcItensNFespTinta;
begin
  Result := FOpcaoItensNFEspTinta;
end;

function TParametrosRegraZerarImpostosST.OpcaoItensNFEspTinta(
  AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FOpcaoItensNFEspTinta := AValue;
end;

function TParametrosRegraZerarImpostosST.SimplesNacional(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

function TParametrosRegraZerarImpostosST.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

function TParametrosRegraZerarImpostosST.TaxaBombeamentoPedidoOrcamento: Boolean;
begin
  Result := FTaxaBombeamentoPedidoOrcamento;
end;

function TParametrosRegraZerarImpostosST.TaxaBombeamentoPedidoOrcamento(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FTaxaBombeamentoPedidoOrcamento := AValue;
end;

function TParametrosRegraZerarImpostosST.TemMIFFEntreOsDevolvidos: Boolean;
begin
  Result := FTemMIFFEntreOsDevolvidos;
end;

function TParametrosRegraZerarImpostosST.TemMIFFEntreOsDevolvidos(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FTemMIFFEntreOsDevolvidos := AValue;
end;

function TParametrosRegraZerarImpostosST.TipoDeBaixaEntregaFutura: String;
begin
  Result := FTipoDeBaixaEntregaFutura;
end;

function TParametrosRegraZerarImpostosST.TipoDeBaixaEntregaFutura(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FTipoDeBaixaEntregaFutura := AValue;
end;

function TParametrosRegraZerarImpostosST.TipoDePedidoFaturamento: String;
begin
  Result := FTipoDePedidoFaturamento;
end;

function TParametrosRegraZerarImpostosST.TipoDePedidoFaturamento(
  AValue: String): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FTipoDePedidoFaturamento := AValue;
end;

function TParametrosRegraZerarImpostosST.TributaClienteZonaFranca: Boolean;
begin
  Result := FTributaZonaFrancaManausUsoConsumo;
end;

function TParametrosRegraZerarImpostosST.TributaClienteZonaFranca(
  AValue: Boolean): IParametrosRegraZerarImpostosST;
begin
  Result := Self;
  FTributaZonaFrancaManausUsoConsumo := AValue;
end;

end.
