unit Tipos.Processar.Dados.Icms;

interface

uses Interfaces.Processar.Dados.Icms, Shared.Functions.Types, untParametrosResultadoIcms;

type
  TParametrosProcessarDadosIcms = class(TInterfacedObject, IParametrosProcessarDadosIcms)
  private
    //Calculo icms
    FVendaDentroDoEstado: Boolean;
    FSubstituicaoTributariaDoItem: Boolean;
    FUtilizaImportacaoDireta: Boolean;
    FItemImportacaoDireta: Boolean;
    FCalculaBeneficioReducaoBaseIcmsST: Boolean;
    FSimplesNacional: Boolean;
    FTotalGeralDoItem: Double;
    FEntraIPINaBaseIcms: Boolean;
    FAliquotaDeIcmsDoItem: Double;
    FValorDoIpiDoItem: Double;
    FPercentualDaBaseDeIcmsDoItem: Double;
    FUtilizarReducaoRICMPR: Boolean;

    //Zerar impostos
    FBaseDeCalculoDoIcmsDoItem: Double;
    FValorDoIcmsDoItem: Double;
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
    FEmpresaOptanteSimples: Boolean;
    FItemTributado: Boolean;
    FConfiguradoParaTrocarParaX41: Boolean;

    //Parametros para comparacao no checktrue do log
    FParametrosResultadoIcms: IParametrosResultadoIcms;
  public
    //Calculo icms
    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function SubstituicaoTributariaDoItem: Boolean; overload;
    function SubstituicaoTributariaDoItem(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function UtilizaImportacaoDireta: Boolean; overload;
    function UtilizaImportacaoDireta(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ItemImportacaoDireta: Boolean; overload;
    function ItemImportacaoDireta(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function CalculaBeneficioReducaoBaseIcmsST: Boolean; overload;
    function CalculaBeneficioReducaoBaseIcmsST(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function EntraIPINaBaseIcms: Boolean; overload;
    function EntraIPINaBaseIcms(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function ValorDoIpiDoItem: Double; overload;
    function ValorDoIpiDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function PercentualDaBaseDeIcmsDoItem: Double; overload;
    function PercentualDaBaseDeIcmsDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function UtilizarReducaoRICMPR: Boolean; overload;
    function UtilizarReducaoRICMPR(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    //Zerar impostos
    function BaseDeCalculoDoIcmsDoItem: Double; overload;
    function BaseDeCalculoDoIcmsDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosProcessarDadosIcms; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosProcessarDadosIcms; overload;

    function OpcaoDeDocumento: String; overload;
    function OpcaoDeDocumento(AValue: String): IParametrosProcessarDadosIcms; overload;

    function TaxaBombeamentoPedidoOrcamento: Boolean; overload;
    function TaxaBombeamentoPedidoOrcamento(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ClassificacaoFiscal: String; overload;
    function ClassificacaoFiscal(AValue: String): IParametrosProcessarDadosIcms; overload;

    function OpcaoItensNFEspTinta: TOpcItensNFespTinta; overload;
    function OpcaoItensNFEspTinta(AValue: TOpcItensNFespTinta): IParametrosProcessarDadosIcms; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function EntregaFuturaDoItem: Boolean; overload;
    function EntregaFuturaDoItem(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function EstadoDaEmpresa: String; overload;
    function EstadoDaEmpresa(AValue: String): IParametrosProcessarDadosIcms; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String): IParametrosProcessarDadosIcms; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue: String): IParametrosProcessarDadosIcms; overload;

    function ClassificacaoDeVenda: String; overload;
    function ClassificacaoDeVenda(AValue: String): IParametrosProcessarDadosIcms; overload;

    function EmpresaOptanteSimples: Boolean; overload;
    function EmpresaOptanteSimples(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ItemTributado: Boolean; overload;
    function ItemTributado(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ConfiguradoParaTrocarParaX41: Boolean; overload;
    function ConfiguradoParaTrocarParaX41(AValue: Boolean): IParametrosProcessarDadosIcms; overload;

    function ParametrosResultadoIcms: IParametrosResultadoIcms; overload;
    function ParametrosResultadoIcms(AValue: IParametrosResultadoIcms): IParametrosProcessarDadosIcms; overload;

    class function New(): IParametrosProcessarDadosIcms; overload;
  end;

type
  TResultadoProcessarDadosIcms = class(TInterfacedObject, IResultadoProcessarDadosIcms)
  private
    FAliquotaDoIcms: Double;
    FBaseDeCalculoDoIcms: Double;
    FValorCalculadoDoIcms: Double;
    FPercentualDaBaseDeIcms: Double;
    FValorDaDiferencaDeIcms: Double;
  public
    function AliquotaDoIcms: Double; overload;
    function AliquotaDoIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;

    function BaseDeCalculoDoIcms: Double; overload;
    function BaseDeCalculoDoIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;

    function ValorCalculadoDoIcms: Double; overload;
    function ValorCalculadoDoIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;

    function ValorDaDiferencaDeIcms: Double; overload;
    function ValorDaDiferencaDeIcms(AValue: Double): IResultadoProcessarDadosIcms; overload;

    class function New(): IResultadoProcessarDadosIcms;
  end;

implementation

{ TParametrosProcessarDadosIcms }

function TParametrosProcessarDadosIcms.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosProcessarDadosIcms.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.BaixaDeEntregaFutura: Boolean;
begin
  Result := FBaixaDeEntregaFutura;
end;

function TParametrosProcessarDadosIcms.BaixaDeEntregaFutura(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FBaixaDeEntregaFutura := AValue;
end;

function TParametrosProcessarDadosIcms.BaseDeCalculoDoIcmsDoItem: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItem;
end;

function TParametrosProcessarDadosIcms.BaseDeCalculoDoIcmsDoItem(
  AValue: Double): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.CalculaBeneficioReducaoBaseIcmsST(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FCalculaBeneficioReducaoBaseIcmsST := AValue;
end;

function TParametrosProcessarDadosIcms.CalculaBeneficioReducaoBaseIcmsST: Boolean;
begin
  Result := FCalculaBeneficioReducaoBaseIcmsST;
end;

function TParametrosProcessarDadosIcms.ClassificacaoDeVenda: String;
begin
  Result := FClassificacaoDeVenda;
end;

function TParametrosProcessarDadosIcms.ClassificacaoDeVenda(
  AValue: String): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FClassificacaoDeVenda := AValue;
end;

function TParametrosProcessarDadosIcms.ClassificacaoFiscal: String;
begin
  Result := FClassificacaoFiscal;
end;

function TParametrosProcessarDadosIcms.ClassificacaoFiscal(
  AValue: String): IParametrosProcessarDadosIcms;
begin
   Result := Self;
   FClassificacaoFiscal := AValue;
end;

function TParametrosProcessarDadosIcms.ClassificacaoFiscalDoItem(
  AValue: String): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosProcessarDadosIcms.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TParametrosProcessarDadosIcms.ConfiguradoParaTrocarParaX41: Boolean;
begin
  Result := FConfiguradoParaTrocarParaX41;
end;

function TParametrosProcessarDadosIcms.ConfiguradoParaTrocarParaX41(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FConfiguradoParaTrocarParaX41 := AValue;
end;

function TParametrosProcessarDadosIcms.VendaDentroDoEstado(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FVendaDentroDoEstado := AValue;
end;

function TParametrosProcessarDadosIcms.VendaDentroDoEstado: Boolean;
begin
  Result := FVendaDentroDoEstado;
end;

function TParametrosProcessarDadosIcms.EmpresaOptanteSimples(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FEmpresaOptanteSimples := AValue;
end;

function TParametrosProcessarDadosIcms.EmpresaOptanteSimples: Boolean;
begin
  Result := FEmpresaOptanteSimples;
end;

function TParametrosProcessarDadosIcms.EntraIPINaBaseIcms(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FEntraIPINaBaseIcms := AValue;
end;

function TParametrosProcessarDadosIcms.EntraIPINaBaseIcms: Boolean;
begin
  Result := FEntraIPINaBaseIcms;
end;

function TParametrosProcessarDadosIcms.EntregaFuturaDoItem(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FEntregaFuturaDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.EntregaFuturaDoItem: Boolean;
begin
  Result := FEntregaFuturaDoItem;
end;

function TParametrosProcessarDadosIcms.EspecieDoDocumento(
  AValue: String): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosProcessarDadosIcms.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosProcessarDadosIcms.EstadoDaEmpresa(
  AValue: String): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FEstadoDaEmpresa := AValue;
end;

function TParametrosProcessarDadosIcms.EstadoDaEmpresa: String;
begin
  Result := FEstadoDaEmpresa;
end;

function TParametrosProcessarDadosIcms.ItemImportacaoDireta: Boolean;
begin
  Result := FItemImportacaoDireta;
end;

function TParametrosProcessarDadosIcms.ItemImportacaoDireta(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FItemImportacaoDireta := AValue;
end;

function TParametrosProcessarDadosIcms.ItemTributado: Boolean;
begin
  Result := FItemTributado;
end;

function TParametrosProcessarDadosIcms.ItemTributado(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FItemTributado := AValue;
end;

class function TParametrosProcessarDadosIcms.New: IParametrosProcessarDadosIcms;
begin
  Result := Self.Create;
end;

function TParametrosProcessarDadosIcms.OpcaoDeDocumento: String;
begin
  Result := FOpcaoDeDocumento;
end;

function TParametrosProcessarDadosIcms.OpcaoDeDocumento(
  AValue: String): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FOpcaoDeDocumento := AValue;
end;

function TParametrosProcessarDadosIcms.OpcaoItensNFEspTinta(
  AValue: TOpcItensNFespTinta): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FOpcaoItensNFEspTinta := AValue;
end;

function TParametrosProcessarDadosIcms.OpcaoItensNFEspTinta: TOpcItensNFespTinta;
begin
  Result := FOpcaoItensNFEspTinta;
end;

function TParametrosProcessarDadosIcms.ParametrosResultadoIcms: IParametrosResultadoIcms;
begin
  Result := FParametrosResultadoIcms;
end;

function TParametrosProcessarDadosIcms.ParametrosResultadoIcms(
  AValue: IParametrosResultadoIcms): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FParametrosResultadoIcms := AValue;
end;

function TParametrosProcessarDadosIcms.PercentualDaBaseDeIcmsDoItem(
  AValue: Double): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FPercentualDaBaseDeIcmsDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.PercentualDaBaseDeIcmsDoItem: Double;
begin
  Result := FPercentualDaBaseDeIcmsDoItem;
end;

function TParametrosProcessarDadosIcms.SimplesNacional(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

function TParametrosProcessarDadosIcms.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

function TParametrosProcessarDadosIcms.SubstituicaoTributariaDoItem(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.SubstituicaoTributariaDoItem: Boolean;
begin
  Result := FSubstituicaoTributariaDoItem;
end;

function TParametrosProcessarDadosIcms.TaxaBombeamentoPedidoOrcamento(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FTaxaBombeamentoPedidoOrcamento := AValue;
end;

function TParametrosProcessarDadosIcms.TaxaBombeamentoPedidoOrcamento: Boolean;
begin
  Result := FTaxaBombeamentoPedidoOrcamento;
end;

function TParametrosProcessarDadosIcms.TotalGeralDoItem(
  AValue: Double): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

function TParametrosProcessarDadosIcms.UtilizaImportacaoDireta: Boolean;
begin
  Result := FUtilizaImportacaoDireta;
end;

function TParametrosProcessarDadosIcms.UtilizaImportacaoDireta(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FUtilizaImportacaoDireta := AValue;
end;

function TParametrosProcessarDadosIcms.UtilizarReducaoRICMPR: Boolean;
begin
  Result := FUtilizarReducaoRICMPR;
end;

function TParametrosProcessarDadosIcms.UtilizarReducaoRICMPR(
  AValue: Boolean): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FUtilizarReducaoRICMPR := AValue;
end;

function TParametrosProcessarDadosIcms.ValorDoIcmsDoItem: Double;
begin
  Result := FValorDoIcmsDoItem;
end;

function TParametrosProcessarDadosIcms.ValorDoIcmsDoItem(
  AValue: Double): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FValorDoIcmsDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.ValorDoIpiDoItem(
  AValue: Double): IParametrosProcessarDadosIcms;
begin
  Result := Self;
  FValorDoIpiDoItem := AValue;
end;

function TParametrosProcessarDadosIcms.ValorDoIpiDoItem: Double;
begin
  Result := FValorDoIpiDoItem;
end;

{ TResultadoProcessarDadosIcms }

function TResultadoProcessarDadosIcms.AliquotaDoIcms: Double;
begin
  Result := FAliquotaDoIcms;
end;

function TResultadoProcessarDadosIcms.AliquotaDoIcms(
  AValue: Double): IResultadoProcessarDadosIcms;
begin
  Result := Self;
  FAliquotaDoIcms := AValue;
end;

function TResultadoProcessarDadosIcms.BaseDeCalculoDoIcms: Double;
begin
  Result := FBaseDeCalculoDoIcms;
end;

function TResultadoProcessarDadosIcms.BaseDeCalculoDoIcms(
  AValue: Double): IResultadoProcessarDadosIcms;
begin
  Result := Self;
  FBaseDeCalculoDoIcms := AValue;
end;

class function TResultadoProcessarDadosIcms.New: IResultadoProcessarDadosIcms;
begin
  Result := Self.Create;
end;

function TResultadoProcessarDadosIcms.PercentualDaBaseDeIcms: Double;
begin
  Result := FPercentualDaBaseDeIcms;
end;

function TResultadoProcessarDadosIcms.PercentualDaBaseDeIcms(
  AValue: Double): IResultadoProcessarDadosIcms;
begin
  Result := Self;
  FPercentualDaBaseDeIcms := AValue;
end;

function TResultadoProcessarDadosIcms.ValorCalculadoDoIcms: Double;
begin
  Result := FValorCalculadoDoIcms;
end;

function TResultadoProcessarDadosIcms.ValorCalculadoDoIcms(
  AValue: Double): IResultadoProcessarDadosIcms;
begin
  Result := Self;
  FValorCalculadoDoIcms := AValue;
end;

function TResultadoProcessarDadosIcms.ValorDaDiferencaDeIcms: Double;
begin
  Result := FValorDaDiferencaDeIcms;
end;

function TResultadoProcessarDadosIcms.ValorDaDiferencaDeIcms(
  AValue: Double): IResultadoProcessarDadosIcms;
begin
  Result := Self;
  FValorDaDiferencaDeIcms := AValue;
end;

end.
