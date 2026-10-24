unit Faturamento.Impostos.Tipos.ZerarImpostos.Icms;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos.Icms,
  Faturamento.Impostos.Interfaces.ZerarImpostos.Types,
  Shared.Functions.Types;

type
  TParametrosRegraZerarImpostosIcms = class(TInterfacedObject, IParametrosRegraZerarImpostosIcms)
  private
    FAliquotaDeIcmsDoItem: Double;
    FBaseDeCalculoDoIcmsDoItem: Double;
    FValorDoIcmsDoItem: Double;
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
    FTipoZerarIcms: TTipoZerarIcms;
    FCodigoDaSituacaoTributaria: String;
    FConfiguradoParaTrocarParaX41noParana: Boolean;
    FTributaClienteZonaFranca: Boolean;
  public
    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcms; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcms; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcms; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostosIcms; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function TipoZerarIcms: TTipoZerarIcms; overload;
    function TipoZerarIcms(AValue: TTipoZerarIcms): IParametrosRegraZerarImpostosIcms; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosRegraZerarImpostosIcms; overload;

    function ConfiguradoParaTrocarParaX41noParana: Boolean; overload;
    function ConfiguradoParaTrocarParaX41noParana(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    function TributaClienteZonaFranca: Boolean; overload;
    function TributaClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosIcms; overload;

    class function New(): IParametrosRegraZerarImpostosIcms;
  end;

type
  TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico = class(TInterfacedObject, IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico)
  private
    FAliquotaDeIcmsDoItem: Double;
    FBaseDeCalculoDoIcmsDoItem: Double;
    FValorDoIcmsDoItem: Double;
    FDentroDoEstado: Boolean;
    FClienteOrgaoPublico: Boolean;
    FCalcularDescontoIcmsOrgaoPublico: Boolean;
    FClienteZonaFranca: Boolean;
    FClienteConsumidorFinal: Boolean;
  public
    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico; overload;

    class function New(): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
  end;

type
  TParametrosRegraZerarImpostosIcmsGeral = class(TInterfacedObject, IParametrosRegraZerarImpostosIcmsGeral)
  private
    FAliquotaDeIcmsDoItem: Double;
    FBaseDeCalculoDoIcmsDoItem: Double;
    FValorDoIcmsDoItem: Double;
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
    FEmpresaOptanteSimples: Boolean;
    FItemTributado: Boolean;
    FConfiguradoParaTrocarParaX41: Boolean;
    FClienteZonaFranca: Boolean;
    FClienteEstado: String;
    FCodigoDaSituacaoTributaria: String;
    FConfiguradoParaTrocarParaX41noParana: Boolean;
    FDentroDoEstado : Boolean;
  public
    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ClienteEstado: String; overload;
    function ClienteEstado(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function ConfiguradoParaTrocarParaX41noParana: Boolean; overload;
    function ConfiguradoParaTrocarParaX41noParana(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    function DentroDoEstado: Boolean; overload;
    function DentroDoEstado(AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral; overload;

    class function New(): IParametrosRegraZerarImpostosIcmsGeral;
  end;

type
  TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero = class(TInterfacedObject, IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero)
  private
    FAliquotaDeIcmsDoItem: Double;
    FBaseDeCalculoDoIcmsDoItem: Double;
    FValorDoIcmsDoItem: Double;
  public
    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero; overload;

    class function New(): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero;
  end;


type
  TResultadoRegraZerarImpostosIcms = class(TInterfacedObject, IResultadoRegraZerarImpostosIcms)
  private
    FAliquotaDeIcmsDoItem: Double;
    FBaseDeCalculoDoIcmsDoItem: Double;
    FValorDoIcmsDoItem: Double;
  public
    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IResultadoRegraZerarImpostosIcms; overload;

    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IResultadoRegraZerarImpostosIcms; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IResultadoRegraZerarImpostosIcms; overload;

    class function New(): IResultadoRegraZerarImpostosIcms;
  end;

implementation

{ TParametrosRegraZerarImpostosIcms }

function TParametrosRegraZerarImpostosIcms.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosRegraZerarImpostosIcms.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcms.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcms.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosRegraZerarImpostosIcms.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcms.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ClassificacaoDeVenda: String;
begin
  Result := FClassificacaoDeVenda;
end;

function TParametrosRegraZerarImpostosIcms.CalcularDescontoIcmsOrgaoPublico: Boolean;
begin
  Result := FCalcularDescontoIcmsOrgaoPublico;
end;

function TParametrosRegraZerarImpostosIcms.CalcularDescontoIcmsOrgaoPublico(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FCalcularDescontoIcmsOrgaoPublico := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ClassificacaoDeVenda(
  AValue: String): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FClassificacaoDeVenda := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosRegraZerarImpostosIcms.ClassificacaoFiscalDoItem(
  AValue: String): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosRegraZerarImpostosIcms.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TParametrosRegraZerarImpostosIcms.ClienteEstado(
  AValue: String): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ClienteOrgaoPublico(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FClienteOrgaoPublico := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ClienteOrgaoPublico: Boolean;
begin
  Result := FClienteOrgaoPublico;
end;

function TParametrosRegraZerarImpostosIcms.ClienteZonaFranca(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FClienteZonaFranca := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ClienteZonaFranca: Boolean;
begin
  Result := FClienteZonaFranca;
end;

function TParametrosRegraZerarImpostosIcms.CodigoDaSituacaoTributaria(AValue: String): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TParametrosRegraZerarImpostosIcms.CodigoDaSituacaoTributaria: String;
begin
  Result := FCodigoDaSituacaoTributaria;
end;

function TParametrosRegraZerarImpostosIcms.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ConfiguradoParaTrocarParaX41(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FConfiguradoParaTrocarParaX41 := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ConfiguradoParaTrocarParaX41: Boolean;
begin
  Result := FConfiguradoParaTrocarParaX41;
end;

function TParametrosRegraZerarImpostosIcms.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegraZerarImpostosIcms.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

function TParametrosRegraZerarImpostosIcms.DentroDoEstado(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosRegraZerarImpostosIcms.EntregaFuturaDoItem: Boolean;
begin
  Result := FEntregaFuturaDoItem;
end;

function TParametrosRegraZerarImpostosIcms.EmpresaOptanteSimples: Boolean;
begin
  Result := FEmpresaOptanteSimples;
end;

function TParametrosRegraZerarImpostosIcms.EmpresaOptanteSimples(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FEmpresaOptanteSimples := AValue;
end;

function TParametrosRegraZerarImpostosIcms.EntregaFuturaDoItem(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FEntregaFuturaDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcms.EstadoDaEmpresa: String;
begin
  Result := FEstadoDaEmpresa;
end;

function TParametrosRegraZerarImpostosIcms.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosRegraZerarImpostosIcms.EspecieDoDocumento(
  AValue: String): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosRegraZerarImpostosIcms.EstadoDaEmpresa(
  AValue: String): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FEstadoDaEmpresa := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ItemTributado: Boolean;
begin
  Result := FItemTributado;
end;

function TParametrosRegraZerarImpostosIcms.ItemTributado(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FItemTributado := AValue;
end;

class function TParametrosRegraZerarImpostosIcms.New: IParametrosRegraZerarImpostosIcms;
begin
  Result := Self.Create;
end;

function TParametrosRegraZerarImpostosIcms.OpcaoDeDocumento: String;
begin
  Result := FOpcaoDeDocumento;
end;

function TParametrosRegraZerarImpostosIcms.OpcaoDeDocumento(
  AValue: String): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FOpcaoDeDocumento := AValue;
end;

function TParametrosRegraZerarImpostosIcms.OpcaoItensNFEspTinta: TOpcItensNFespTinta;
begin
  Result := FOpcaoItensNFEspTinta;
end;

function TParametrosRegraZerarImpostosIcms.OpcaoItensNFEspTinta(
  AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FOpcaoItensNFEspTinta := AValue;
end;

function TParametrosRegraZerarImpostosIcms.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

function TParametrosRegraZerarImpostosIcms.SimplesNacional(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

function TParametrosRegraZerarImpostosIcms.TaxaBombeamentoPedidoOrcamento(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FTaxaBombeamentoPedidoOrcamento := AValue;
end;

function TParametrosRegraZerarImpostosIcms.TipoZerarIcms: TTipoZerarIcms;
begin
  Result := FTipoZerarIcms;
end;

function TParametrosRegraZerarImpostosIcms.TipoZerarIcms(
  AValue: TTipoZerarIcms): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FTipoZerarIcms := AValue;
end;

function TParametrosRegraZerarImpostosIcms.TributaClienteZonaFranca: Boolean;
begin
  Result := FTributaClienteZonaFranca;
end;

function TParametrosRegraZerarImpostosIcms.TributaClienteZonaFranca(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FTributaClienteZonaFranca := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ValorDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FValorDoIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ValorDoIcmsDoItem: Double;
begin
  Result := FValorDoIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcms.TaxaBombeamentoPedidoOrcamento: Boolean;
begin
  Result := FTaxaBombeamentoPedidoOrcamento;
end;

function TParametrosRegraZerarImpostosIcms.ConfiguradoParaTrocarParaX41noParana(
  AValue: Boolean): IParametrosRegraZerarImpostosIcms;
begin
  Result := Self;
  FConfiguradoParaTrocarParaX41noParana := AValue;
end;

function TParametrosRegraZerarImpostosIcms.ConfiguradoParaTrocarParaX41noParana: Boolean;
begin
  Result := FConfiguradoParaTrocarParaX41noParana;
end;


{ TResultadoRegraZerarImpostosIcms }

function TResultadoRegraZerarImpostosIcms.AliquotaDeIcmsDoItem(
  AValue: Double): IResultadoRegraZerarImpostosIcms;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TResultadoRegraZerarImpostosIcms.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TResultadoRegraZerarImpostosIcms.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TResultadoRegraZerarImpostosIcms.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IResultadoRegraZerarImpostosIcms;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

class function TResultadoRegraZerarImpostosIcms.New: IResultadoRegraZerarImpostosIcms;
begin
  Result := Self.Create;
end;

function TResultadoRegraZerarImpostosIcms.ValorDoIcmsDoItem(
  AValue: Double): IResultadoRegraZerarImpostosIcms;
begin
  Result := Self;
  FValorDoIcmsDoItem := AValue;
end;

function TResultadoRegraZerarImpostosIcms.ValorDoIcmsDoItem: Double;
begin
  Result := FValorDoIcmsDoItem;
end;

{ TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico }

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.CalcularDescontoIcmsOrgaoPublico: Boolean;
begin
  Result := FCalcularDescontoIcmsOrgaoPublico;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.CalcularDescontoIcmsOrgaoPublico(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result := Self;
  FCalcularDescontoIcmsOrgaoPublico := AValue;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.ClienteOrgaoPublico(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result := Self;
  FClienteOrgaoPublico := AValue;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.ClienteOrgaoPublico: Boolean;
begin
  Result := FClienteOrgaoPublico;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.ClienteZonaFranca(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result := Self;
  FClienteZonaFranca := AValue;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.ClienteZonaFranca: Boolean;
begin
  Result := FClienteZonaFranca;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.DentroDoEstado(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

class function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.New: IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result := Self.Create;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.ValorDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result := Self;
  FValorDoIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.ValorDoIcmsDoItem: Double;
begin
  Result := FValorDoIcmsDoItem;
end;

{ TParametrosRegraZerarImpostosIcmsGeral }

function TParametrosRegraZerarImpostosIcmsGeral.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcmsGeral.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosRegraZerarImpostosIcmsGeral.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ClassificacaoDeVenda: String;
begin
  Result := FClassificacaoDeVenda;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ClassificacaoDeVenda(
  AValue: String): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FClassificacaoDeVenda := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ClassificacaoFiscalDoItem(
  AValue: String): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ClienteEstado(
  AValue: String): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ClienteZonaFranca: Boolean;
begin
  Result := FClienteZonaFranca;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ClienteZonaFranca(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FClienteZonaFranca := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.CodigoDaSituacaoTributaria: String;
begin
  Result := FCodigoDaSituacaoTributaria;
end;

function TParametrosRegraZerarImpostosIcmsGeral.CodigoDaSituacaoTributaria(AValue: String): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ConfiguradoParaTrocarParaX41(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FConfiguradoParaTrocarParaX41 := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ConfiguradoParaTrocarParaX41: Boolean;
begin
  Result := FConfiguradoParaTrocarParaX41;
end;

function TParametrosRegraZerarImpostosIcmsGeral.EmpresaOptanteSimples(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FEmpresaOptanteSimples := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.EmpresaOptanteSimples: Boolean;
begin
  Result := FEmpresaOptanteSimples;
end;

function TParametrosRegraZerarImpostosIcmsGeral.EntregaFuturaDoItem: Boolean;
begin
  Result := FEntregaFuturaDoItem;
end;

function TParametrosRegraZerarImpostosIcmsGeral.EntregaFuturaDoItem(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FEntregaFuturaDoItem := AValue
end;

function TParametrosRegraZerarImpostosIcmsGeral.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosRegraZerarImpostosIcmsGeral.EspecieDoDocumento(
  AValue: String): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.EstadoDaEmpresa: String;
begin
  Result := FEstadoDaEmpresa;
end;

function TParametrosRegraZerarImpostosIcmsGeral.EstadoDaEmpresa(
  AValue: String): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FEstadoDaEmpresa := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ItemTributado: Boolean;
begin
  Result := FItemTributado;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ItemTributado(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FItemTributado := AValue;
end;

class function TParametrosRegraZerarImpostosIcmsGeral.New: IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self.Create;
end;

function TParametrosRegraZerarImpostosIcmsGeral.OpcaoDeDocumento(
  AValue: String): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FOpcaoDeDocumento := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.OpcaoDeDocumento: String;
begin
  Result := FOpcaoDeDocumento;
end;

function TParametrosRegraZerarImpostosIcmsGeral.OpcaoItensNFEspTinta: TOpcItensNFespTinta;
begin
  Result := FOpcaoItensNFEspTinta;
end;

function TParametrosRegraZerarImpostosIcmsGeral.OpcaoItensNFEspTinta(
  AValue: TOpcItensNFespTinta): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FOpcaoItensNFEspTinta := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.SimplesNacional(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

function TParametrosRegraZerarImpostosIcmsGeral.TaxaBombeamentoPedidoOrcamento: Boolean;
begin
  Result := FTaxaBombeamentoPedidoOrcamento;
end;

function TParametrosRegraZerarImpostosIcmsGeral.TaxaBombeamentoPedidoOrcamento(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FTaxaBombeamentoPedidoOrcamento := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ValorDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FValorDoIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ValorDoIcmsDoItem: Double;
begin
  Result := FValorDoIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ConfiguradoParaTrocarParaX41noParana(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FConfiguradoParaTrocarParaX41noParana := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.DentroDoEstado: Boolean;
begin
  Result := FDentroDoEstado;
end;

function TParametrosRegraZerarImpostosIcmsGeral.DentroDoEstado(
  AValue: Boolean): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result := Self;
  FDentroDoEstado := AValue;
end;

function TParametrosRegraZerarImpostosIcmsGeral.ConfiguradoParaTrocarParaX41noParana: Boolean;
begin
  Result := FConfiguradoParaTrocarParaX41noParana;
end;


{ TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero }

function TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

class function TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero.New: IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero;
begin
  Result := Self.Create;
end;

function TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero.ValorDoIcmsDoItem(
  AValue: Double): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero;
begin
  Result := Self;
  FValorDoIcmsDoItem := AValue;
end;

function TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero.ValorDoIcmsDoItem: Double;
begin
  Result := FValorDoIcmsDoItem;
end;

end.
