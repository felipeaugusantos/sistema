unit Faturamento.Impostos.Tipos.ZerarImpostos;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos.Types,
  Faturamento.Impostos.Interfaces.ZerarImpostos, Shared.Functions.Types;

type
  TParametrosRegraZerarImpostos = class(TInterfacedObject, IParametrosRegraZerarImpostos)
  private
    FAliquotaDeIcmsDoItem: Double;
    FBaseDeCalculoDoIcmsDoItem: Double;
    FValorDoIcmsDoItem: Double;
    FSimplesNacional: Boolean;
    FClassificacaoFiscalDoItem: String;
    FOpcaoDeDocumento: String;
    FTaxaBombeamentoPedidoOrcamento: Boolean;
    FClassificacaoFiscal: String;
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
    FTipoZerarIcms: TTipoZerarIcms;
    FCodigoDaSituacaoTributaria: String;
    FConfiguradoParaTrocarParaX41noParana: Boolean;
    FTributaClienteZonaFranca: Boolean;
  public
    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostos; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostos; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostos; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostos; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosRegraZerarImpostos; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function ClassificacaoFiscal: String; overload;
    function ClassificacaoFiscal(AValue: String): IParametrosRegraZerarImpostos; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostos; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosRegraZerarImpostos; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostos; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostos; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosRegraZerarImpostos; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function TipoZerarIcms: TTipoZerarIcms; overload;
    function TipoZerarIcms(AValue: TTipoZerarIcms): IParametrosRegraZerarImpostos; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosRegraZerarImpostos; overload;

    function ConfiguradoParaTrocarParaX41noParana: Boolean; overload;
    function ConfiguradoParaTrocarParaX41noParana(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    function TributaClienteZonaFranca: Boolean; overload;
    function TributaClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostos; overload;

    class function New(): IParametrosRegraZerarImpostos;
  end;


implementation

{ TParametrosRegraZerarImpostos }

function TParametrosRegraZerarImpostos.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosRegraZerarImpostos.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostos.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosRegraZerarImpostos.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosRegraZerarImpostos.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TParametrosRegraZerarImpostos.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostos.ClassificacaoFiscal: String;
begin
  Result := FClassificacaoFiscal;
end;

function TParametrosRegraZerarImpostos.ClassificacaoDeVenda: String;
begin
  Result := FClassificacaoDeVenda;
end;

function TParametrosRegraZerarImpostos.ClassificacaoDeVenda(
  AValue: String): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FClassificacaoDeVenda := AValue;
end;

function TParametrosRegraZerarImpostos.ClassificacaoFiscal(
  AValue: String): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FClassificacaoFiscal := AValue;
end;

function TParametrosRegraZerarImpostos.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosRegraZerarImpostos.ClassificacaoFiscalDoItem(
  AValue: String): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosRegraZerarImpostos.CodigoDaSituacaoTributaria: String;
begin
  Result :=  FCodigoDaSituacaoTributaria;
end;

function TParametrosRegraZerarImpostos.CodigoDaSituacaoTributaria(AValue: String): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TParametrosRegraZerarImpostos.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegraZerarImpostos.ConfiguradoParaTrocarParaX41(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FConfiguradoParaTrocarParaX41 := AValue;
end;

function TParametrosRegraZerarImpostos.ConfiguradoParaTrocarParaX41: Boolean;
begin
  Result := FConfiguradoParaTrocarParaX41;
end;

function TParametrosRegraZerarImpostos.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegraZerarImpostos.DentroDoEstado(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosRegraZerarImpostos.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

function TParametrosRegraZerarImpostos.EmpresaOptanteSimples: Boolean;
begin
  Result := FEmpresaOptanteSimples;
end;

function TParametrosRegraZerarImpostos.EmpresaOptanteSimples(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FEmpresaOptanteSimples := AValue;
end;

function TParametrosRegraZerarImpostos.EntregaFuturaDoItem(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FEntregaFuturaDoItem := AValue;
end;

function TParametrosRegraZerarImpostos.EntregaFuturaDoItem: Boolean;
begin
  Result := FEntregaFuturaDoItem;
end;

function TParametrosRegraZerarImpostos.EspecieDoDocumento(
  AValue: String): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosRegraZerarImpostos.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosRegraZerarImpostos.EstadoDaEmpresa(
  AValue: String): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FEstadoDaEmpresa := AValue;
end;

function TParametrosRegraZerarImpostos.ItemTributado: Boolean;
begin
  Result := FItemTributado;
end;

function TParametrosRegraZerarImpostos.ItemTributado(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FItemTributado := AValue;
end;

function TParametrosRegraZerarImpostos.EstadoDaEmpresa: String;
begin
  Result := FEstadoDaEmpresa;
end;

function TParametrosRegraZerarImpostos.ConfiguradoParaTrocarParaX41noParana(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FConfiguradoParaTrocarParaX41noParana := AValue;
end;

function TParametrosRegraZerarImpostos.ConfiguradoParaTrocarParaX41noParana: Boolean;
begin
  Result := FConfiguradoParaTrocarParaX41noParana;
end;

class function TParametrosRegraZerarImpostos.New: IParametrosRegraZerarImpostos;
begin
  Result := Self.Create;
end;

function TParametrosRegraZerarImpostos.OpcaoDeDocumento: String;
begin
  Result := FOpcaoDeDocumento;
end;

function TParametrosRegraZerarImpostos.OpcaoDeDocumento(
  AValue: String): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FOpcaoDeDocumento := AValue;
end;

function TParametrosRegraZerarImpostos.OpcaoItensNFEspTinta: TOpcItensNFespTinta;
begin
  Result := FOpcaoItensNFEspTinta;
end;

function TParametrosRegraZerarImpostos.OpcaoItensNFEspTinta(
  AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FOpcaoItensNFEspTinta := AValue;
end;

function TParametrosRegraZerarImpostos.SimplesNacional(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

function TParametrosRegraZerarImpostos.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

function TParametrosRegraZerarImpostos.TaxaBombeamentoPedidoOrcamento(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FTaxaBombeamentoPedidoOrcamento := AValue;
end;

function TParametrosRegraZerarImpostos.TipoZerarIcms: TTipoZerarIcms;
begin
  Result := FTipoZerarIcms;
end;

function TParametrosRegraZerarImpostos.TipoZerarIcms(
  AValue: TTipoZerarIcms): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FTipoZerarIcms := AValue;
end;

function TParametrosRegraZerarImpostos.TributaClienteZonaFranca: Boolean;
begin
  Result := FTributaClienteZonaFranca;
end;

function TParametrosRegraZerarImpostos.TributaClienteZonaFranca(
  AValue: Boolean): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FTributaClienteZonaFranca := AValue;
end;

function TParametrosRegraZerarImpostos.TaxaBombeamentoPedidoOrcamento: Boolean;
begin
  Result := FTaxaBombeamentoPedidoOrcamento;
end;

function TParametrosRegraZerarImpostos.ValorDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostos;
begin
  Result := Self;
  FValorDoIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostos.ValorDoIcmsDoItem: Double;
begin
  Result := FValorDoIcmsDoItem;
end;

end.
