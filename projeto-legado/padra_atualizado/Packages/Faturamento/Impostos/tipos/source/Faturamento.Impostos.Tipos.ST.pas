unit Faturamento.Impostos.Tipos.ST;

interface

uses
  Faturamento.Impostos.Interfaces.ST;

type
  TParametrosCalculoST = class (TInterfacedObject, IParametrosCalculoST)
  private
    FVendaDentroDoEstado: Boolean;
    FSubstituicaoTributariaDoItem: Boolean;
    FCalculaSubstituicaoTributariaSimples: Boolean;
    FCalcularSTSomenteParaNaoConsumidorFinal: Boolean;
    FClienteConsumidorFinal: Boolean;
    FUtilizaImportacaoDireta: Boolean;
    FItemImportacaoDireta: Boolean;
    FCalculaBeneficioReducaoBaseIcmsST: Boolean;
    FSimplesNacional: Boolean;
    FValorDoIcmsDoItem: Double;
    FValorDoIcmsDoEstado: Double;
    FAliquotaDaSubstituicaoTributariaDoItem: Double;
//    FValorDaSubstituicaoTributariaDoItem: Double;
//    FBaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
    FTotalGeralDoItemPreUlt: Double;
    FValorDoIpiDoItem: Double;
    FValorDoIva: Double;
    FUtilizarReducaoDeBaseDeCalculoDeSTNaVenda: Boolean;
    FPercentualDaBaseDeCalculoDaSTDoItem: Double;
    FPercentualMinimoReducaoDeBaseDeCalculoDosImpostos: Double;
    FTotalGeralDoItem: Double;
    FCalculaSTClienteConsumidorFinalNCOEspiritoSanto: Boolean;

    FUtilizaAmpara: Boolean; //ampara
    FEncontrouAbreviacaoDeIcms: Boolean; //ampara
    FAmparaAliquotaFCP: Double; //ampara

    FTipoDeAbreviacaoFiscal: String;
    FPercentualDoFCPDoItem: Double;
    FValorDoFCPDoItem: Double;
    FCalculaSubstituicaoTributariaPorDentro: Boolean;
    FContribuinteDeIpi: Boolean;
    FClienteIVAEspecialMT: Boolean;
    FAliquotaDeIcmsDoItem: Double;
    FClienteOrgaoPublico: Boolean;
    FCalcularDescontoIcmsOrgaoPublico: Boolean;
    FClienteZonaFranca: Boolean;
    FAliquotaOriginalDeIcmsDoItem: Double;
    FValorDoIpiDeEntrada: Double;
    FModeloBeneficioReducaoBaseIcmsST: Integer;
    FClassificacaoFiscalDoItem : String;
    FAliquotaCalculoDesoneracaoDeSubstituicaoTributaria: Double;
    FCalculaDesoneracaoDeSubstituicaoTributaria: Boolean;
    FAliquotaReducaoDeSt: Double;
    FAplicaCargaLiquidaCE: Boolean;
  public
    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosCalculoST; overload;

    function SubstituicaoTributariaDoItem: Boolean; overload;
    function SubstituicaoTributariaDoItem(AValue: Boolean): IParametrosCalculoST; overload;

    function CalculaSubstituicaoTributariaSimples: Boolean; overload;
    function CalculaSubstituicaoTributariaSimples(AValue: Boolean): IParametrosCalculoST; overload;

    function CalcularSTSomenteParaNaoConsumidorFinal: Boolean; overload;
    function CalcularSTSomenteParaNaoConsumidorFinal(AValue: Boolean): IParametrosCalculoST; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoST; overload;

    function CalculaSTClienteConsumidorFinalNCOEspiritoSanto: Boolean; overload;
    function CalculaSTClienteConsumidorFinalNCOEspiritoSanto(AValue: Boolean): IParametrosCalculoST; overload;

    function UtilizaImportacaoDireta: Boolean; overload;
    function UtilizaImportacaoDireta(AValue: Boolean): IParametrosCalculoST; overload;

    function ItemImportacaoDireta: Boolean; overload;
    function ItemImportacaoDireta(AValue: Boolean): IParametrosCalculoST; overload;

    function CalculaBeneficioReducaoBaseIcmsST: Boolean; overload;
    function CalculaBeneficioReducaoBaseIcmsST(AValue: Boolean): IParametrosCalculoST; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosCalculoST; overload;

    function ValorDoIcmsDoItem: Double; overload;
    function ValorDoIcmsDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoIcmsDoEstado: Double; overload;
    function ValorDoIcmsDoEstado(AValue: Double): IParametrosCalculoST; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoST; overload;

//    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
//    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoST; overload;
//
//    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
//    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosCalculoST; overload;

    function TotalGeralDoItemPreUlt: Double; overload;
    function TotalGeralDoItemPreUlt(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoIpiDoItem: Double; overload;
    function ValorDoIpiDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoIva: Double; overload;
    function ValorDoIva(AValue: Double): IParametrosCalculoST; overload;

    function UtilizarReducaoDeBaseDeCalculoDeSTNaVenda: Boolean; overload;
    function UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(AValue: Boolean): IParametrosCalculoST; overload;

    function PercentualDaBaseDeCalculoDaSTDoItem: Double; overload;
    function PercentualDaBaseDeCalculoDaSTDoItem(AValue: Double): IParametrosCalculoST; overload;

    function PercentualMinimoReducaoDeBaseDeCalculoDosImpostos: Double; overload;
    function PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(AValue: Double): IParametrosCalculoST; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoST; overload;

    function UtilizaAmpara: Boolean; overload; //ampara
    function UtilizaAmpara(AValue: Boolean): IParametrosCalculoST; overload;

    function EncontrouAbreviacaoDeIcms: Boolean; overload; //ampara
    function EncontrouAbreviacaoDeIcms(AValue: Boolean): IParametrosCalculoST; overload;

    function AmparaAliquotaFCP: Double; overload; //ampara
    function AmparaAliquotaFCP(AValue: Double): IParametrosCalculoST; overload;

    function TipoDeAbreviacaoFiscal: String; overload;
    function TipoDeAbreviacaoFiscal(AValue: String): IParametrosCalculoST; overload;

    function PercentualDoFCPDoItem: Double; overload;
    function PercentualDoFCPDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoFCPDoItem: Double; overload;
    function ValorDoFCPDoItem(AValue: Double): IParametrosCalculoST; overload;

    function CalculaSubstituicaoTributariaPorDentro: Boolean; overload;
    function CalculaSubstituicaoTributariaPorDentro(AValue: Boolean): IParametrosCalculoST; overload;

    function ContribuinteDeIpi: Boolean; overload;
    function ContribuinteDeIpi(AValue: Boolean): IParametrosCalculoST; overload;

    function ClienteIVAEspecialMT: Boolean; overload;
    function ClienteIVAEspecialMT(AValue: Boolean): IParametrosCalculoST; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosCalculoST; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosCalculoST; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosCalculoST; overload;

    function AliquotaOriginalDeIcmsDoItem: Double; overload;
    function AliquotaOriginalDeIcmsDoItem(AValue: Double): IParametrosCalculoST; overload;

    function ValorDoIpiDeEntrada: Double; overload;
    function ValorDoIpiDeEntrada(AValue: Double): IParametrosCalculoST; overload;

    function ModeloBeneficioReducaoBaseIcmsST: Integer; overload;
    function ModeloBeneficioReducaoBaseIcmsST(AValue: Integer): IParametrosCalculoST; overload;

    function ClassificacaoFiscalDoItem: String; overload;
    function ClassificacaoFiscalDoItem(AValue: String): IParametrosCalculoST; overload;

    function AliquotaCalculoDesoneracaoDeSubstituicaoTributaria: Double; overload;
    function AliquotaCalculoDesoneracaoDeSubstituicaoTributaria(AValue: Double): IParametrosCalculoST; overload;

    function CalculaDesoneracaoDeSubstituicaoTributaria: Boolean; overload;
    function CalculaDesoneracaoDeSubstituicaoTributaria(AValue: Boolean): IParametrosCalculoST; overload;

    function AliquotaReducaoDeSt: Double; overload;
    function AliquotaReducaoDeSt(AValue: Double): IParametrosCalculoST; overload;

    function AplicaCargaLiquidaCE: Boolean; overload;
    function AplicaCargaLiquidaCE(AValue: Boolean): IParametrosCalculoST; overload;

    class function New: IParametrosCalculoST;
  end;

type
  TResultadoCalculoST = class(TInterfacedObject, IResultadoCalculoST)
  private
    FBaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
    FValorDaSubstituicaoTributariaDoItem: Double;
    FPercentualDaSubstituicaoDaBase : Double;
    FPercentualDoFCPDoItem: Double;
    FValorDoFCPDoItem: Double;
    FBaseDaSubstituicaoTributariaSimulada: Double;
    FAliquotaDaSubstituicaoTributariaSimulada: Double;
    FValorDaSubstituicaoTributariaSimulada: Double;
    FValorDoIvaMatriz: Double;
    FValorDoIvaStMatriz: Double;
    FValorCalculadoSTConsignacao : Double;
    FValorDesoneradoDaSubstituicaoTributariaDoItem: Double;
  public
    function BaseDeCalculoDaSubstituicaoTributariaDoItem: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoCalculoST; overload;

    function ValorDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoCalculoST; overload;

    function PercentualDaSubstituicaoDaBase : Double; overload;
    function PercentualDaSubstituicaoDaBase(AValue : Double) : IResultadoCalculoST; overload;

    function PercentualDoFCPDoItem: Double; overload;
    function PercentualDoFCPDoItem(AValue: Double): IResultadoCalculoST; overload;

    function ValorDoFCPDoItem: Double; overload;
    function ValorDoFCPDoItem(AValue: Double): IResultadoCalculoST; overload;

    function BaseDaSubstituicaoTributariaSimulada: Double; overload;
    function BaseDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoCalculoST; overload;

    function AliquotaDaSubstituicaoTributariaSimulada: Double; overload;
    function AliquotaDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoCalculoST; overload;

    function ValorDaSubstituicaoTributariaSimulada: Double; overload;
    function ValorDaSubstituicaoTributariaSimulada(AValue: Double): IResultadoCalculoST; overload;

    function ValorDoIvaMatriz: Double; overload;
    function ValorDoIvaMatriz(AValue: Double): IResultadoCalculoST; overload;

    function ValorDoIvaStMatriz: Double; overload;
    function ValorDoIvaStMatriz(AValue: Double): IResultadoCalculoST; overload;

    function ValorCalculadoSTConsignacao: Double; overload;
    function ValorCalculadoSTConsignacao(AValue: Double): IResultadoCalculoST; overload;

    function ValorDesoneradoDaSubstituicaoTributariaDoItem: Double; overload;
    function ValorDesoneradoDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoCalculoST; overload;

    class function New: IResultadoCalculoST;
  end;

implementation

{ TParametrosCalculoST }

function TParametrosCalculoST.AliquotaDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaDoItem;
end;

function TParametrosCalculoST.AliquotaDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosCalculoST.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosCalculoST.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosCalculoST.AliquotaOriginalDeIcmsDoItem: Double;
begin
  Result := FAliquotaOriginalDeIcmsDoItem;
end;

function TParametrosCalculoST.AliquotaOriginalDeIcmsDoItem(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FAliquotaOriginalDeIcmsDoItem := AValue;
end;

function TParametrosCalculoST.AliquotaReducaoDeSt: Double;
begin
  Result := FAliquotaReducaoDeSt;
end;

function TParametrosCalculoST.AliquotaReducaoDeSt(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FAliquotaReducaoDeSt := AValue;
end;

function TParametrosCalculoST.AliquotaCalculoDesoneracaoDeSubstituicaoTributaria: Double;
begin
  Result := FAliquotaCalculoDesoneracaoDeSubstituicaoTributaria;
end;

function TParametrosCalculoST.AliquotaCalculoDesoneracaoDeSubstituicaoTributaria(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FAliquotaCalculoDesoneracaoDeSubstituicaoTributaria := AValue;
end;

function TParametrosCalculoST.AmparaAliquotaFCP: Double;
begin
  Result := FAmparaAliquotaFCP;
end;

function TParametrosCalculoST.AmparaAliquotaFCP(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FAmparaAliquotaFCP := AValue;
end;

function TParametrosCalculoST.AplicaCargaLiquidaCE: Boolean;
begin
  Result := FAplicaCargaLiquidaCE;
end;

function TParametrosCalculoST.AplicaCargaLiquidaCE(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FAplicaCargaLiquidaCE := AValue;
end;

//function TParametrosCalculoST.BaseDeCalculoDaSubstituicaoTributariaDoItem(
//  AValue: Double): IParametrosCalculoST;
//begin
//  Result := Self;
//  FBaseDeCalculoDaSubstituicaoTributariaDoItem := AValue;
//end;
//
//function TParametrosCalculoST.BaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
//begin
//  Result := FBaseDeCalculoDaSubstituicaoTributariaDoItem;
//end;

function TParametrosCalculoST.CalculaBeneficioReducaoBaseIcmsST: Boolean;
begin
  Result := FCalculaBeneficioReducaoBaseIcmsST;
end;

function TParametrosCalculoST.CalculaBeneficioReducaoBaseIcmsST(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FCalculaBeneficioReducaoBaseIcmsST := AValue;
end;

function TParametrosCalculoST.CalcularSTSomenteParaNaoConsumidorFinal: Boolean;
begin
  Result := FCalcularSTSomenteParaNaoConsumidorFinal;
end;

function TParametrosCalculoST.CalcularDescontoIcmsOrgaoPublico: Boolean;
begin
  Result := FCalcularDescontoIcmsOrgaoPublico;
end;

function TParametrosCalculoST.CalcularDescontoIcmsOrgaoPublico(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FCalcularDescontoIcmsOrgaoPublico := AValue;
end;

function TParametrosCalculoST.CalcularSTSomenteParaNaoConsumidorFinal(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FCalcularSTSomenteParaNaoConsumidorFinal := AValue;
end;

function TParametrosCalculoST.CalculaSTClienteConsumidorFinalNCOEspiritoSanto(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FCalculaSTClienteConsumidorFinalNCOEspiritoSanto := AValue;
end;

function TParametrosCalculoST.CalculaSTClienteConsumidorFinalNCOEspiritoSanto: Boolean;
begin
  Result := FCalculaSTClienteConsumidorFinalNCOEspiritoSanto;
end;

function TParametrosCalculoST.CalculaSubstituicaoTributariaPorDentro(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FCalculaSubstituicaoTributariaPorDentro := AValue;
end;

function TParametrosCalculoST.CalculaSubstituicaoTributariaPorDentro: Boolean;
begin
  Result := FCalculaSubstituicaoTributariaPorDentro;
end;

function TParametrosCalculoST.CalculaSubstituicaoTributariaSimples(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FCalculaSubstituicaoTributariaSimples := AValue;
end;

function TParametrosCalculoST.CalculaSubstituicaoTributariaSimples: Boolean;
begin
  Result := FCalculaSubstituicaoTributariaSimples;
end;

function TParametrosCalculoST.ClienteIVAEspecialMT(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FClienteIVAEspecialMT := AValue;
end;

function TParametrosCalculoST.ClienteOrgaoPublico(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FClienteOrgaoPublico := AValue;
end;

function TParametrosCalculoST.ClienteOrgaoPublico: Boolean;
begin
  Result := FClienteOrgaoPublico;
end;

function TParametrosCalculoST.ClienteZonaFranca(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FClienteZonaFranca := AValue;
end;

function TParametrosCalculoST.ClienteZonaFranca: Boolean;
begin
  Result := FClienteZonaFranca;
end;

function TParametrosCalculoST.ClienteIVAEspecialMT: Boolean;
begin
  Result := FClienteIVAEspecialMT;
end;

function TParametrosCalculoST.ContribuinteDeIpi: Boolean;
begin
  Result := FContribuinteDeIpi;
end;

function TParametrosCalculoST.ContribuinteDeIpi(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FContribuinteDeIpi := AValue;
end;

function TParametrosCalculoST.CalculaDesoneracaoDeSubstituicaoTributaria: Boolean;
begin
  Result := FCalculaDesoneracaoDeSubstituicaoTributaria;
end;

function TParametrosCalculoST.CalculaDesoneracaoDeSubstituicaoTributaria(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FCalculaDesoneracaoDeSubstituicaoTributaria := AValue;
end;

function TParametrosCalculoST.EncontrouAbreviacaoDeIcms: Boolean;
begin
  Result := FEncontrouAbreviacaoDeIcms;
end;

function TParametrosCalculoST.EncontrouAbreviacaoDeIcms(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FEncontrouAbreviacaoDeIcms := AValue;
end;

function TParametrosCalculoST.ItemImportacaoDireta: Boolean;
begin
  Result := FItemImportacaoDireta;
end;

function TParametrosCalculoST.ItemImportacaoDireta(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FItemImportacaoDireta := AValue;
end;

function TParametrosCalculoST.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosCalculoST.ClassificacaoFiscalDoItem: String;
begin
  Result := FClassificacaoFiscalDoItem;
end;

function TParametrosCalculoST.ClassificacaoFiscalDoItem(AValue: String): IParametrosCalculoST;
begin
  Result := Self;
  FClassificacaoFiscalDoItem := AValue;
end;

function TParametrosCalculoST.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

class function TParametrosCalculoST.New: IParametrosCalculoST;
begin
  Result := Self.Create;
end;

function TParametrosCalculoST.PercentualDaBaseDeCalculoDaSTDoItem(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FPercentualDaBaseDeCalculoDaSTDoItem := AValue;
end;

function TParametrosCalculoST.PercentualDoFCPDoItem: Double;
begin
  Result := FPercentualDoFCPDoItem;
end;

function TParametrosCalculoST.PercentualDoFCPDoItem(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FPercentualDoFCPDoItem := AValue;
end;

function TParametrosCalculoST.PercentualDaBaseDeCalculoDaSTDoItem: Double;
begin
  Result := FPercentualDaBaseDeCalculoDaSTDoItem;
end;

function TParametrosCalculoST.PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FPercentualMinimoReducaoDeBaseDeCalculoDosImpostos := AValue;
end;

function TParametrosCalculoST.PercentualMinimoReducaoDeBaseDeCalculoDosImpostos: Double;
begin
  Result := FPercentualMinimoReducaoDeBaseDeCalculoDosImpostos;
end;

function TParametrosCalculoST.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

function TParametrosCalculoST.SimplesNacional(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

function TParametrosCalculoST.SubstituicaoTributariaDoItem: Boolean;
begin
  Result := FSubstituicaoTributariaDoItem;
end;

function TParametrosCalculoST.SubstituicaoTributariaDoItem(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosCalculoST.TipoDeAbreviacaoFiscal(
  AValue: String): IParametrosCalculoST;
begin
  Result := Self;
  FTipoDeAbreviacaoFiscal := AValue;
end;

function TParametrosCalculoST.TipoDeAbreviacaoFiscal: String;
begin
  Result := FTipoDeAbreviacaoFiscal;
end;

function TParametrosCalculoST.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

function TParametrosCalculoST.TotalGeralDoItem(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosCalculoST.TotalGeralDoItemPreUlt: Double;
begin
  Result := FTotalGeralDoItemPreUlt;
end;

function TParametrosCalculoST.TotalGeralDoItemPreUlt(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FTotalGeralDoItemPreUlt := AValue;
end;

function TParametrosCalculoST.UtilizaAmpara: Boolean;
begin
  Result := FUtilizaAmpara;
end;

function TParametrosCalculoST.UtilizaAmpara(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FUtilizaAmpara := AValue;
end;

function TParametrosCalculoST.UtilizaImportacaoDireta(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FUtilizaImportacaoDireta := AValue;
end;

function TParametrosCalculoST.UtilizaImportacaoDireta: Boolean;
begin
  Result := FUtilizaImportacaoDireta;
end;

function TParametrosCalculoST.UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FUtilizarReducaoDeBaseDeCalculoDeSTNaVenda := AValue;
end;

function TParametrosCalculoST.UtilizarReducaoDeBaseDeCalculoDeSTNaVenda: Boolean;
begin
  Result := FUtilizarReducaoDeBaseDeCalculoDeSTNaVenda;
end;

function TParametrosCalculoST.ValorDoFCPDoItem: Double;
begin
  Result := FValorDoFCPDoItem;
end;

//function TParametrosCalculoST.ValorDaSubstituicaoTributariaDoItem(
//  AValue: Double): IParametrosCalculoST;
//begin
//  Result := Self;
//  FValorDaSubstituicaoTributariaDoItem := AValue;
//end;
//
//function TParametrosCalculoST.ValorDaSubstituicaoTributariaDoItem: Double;
//begin
//  Result := FValorDaSubstituicaoTributariaDoItem;
//end;

function TParametrosCalculoST.ValorDoFCPDoItem(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FValorDoFCPDoItem := AValue;
end;

function TParametrosCalculoST.ValorDoIcmsDoEstado(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FValorDoIcmsDoEstado := AValue;
end;

function TParametrosCalculoST.ValorDoIcmsDoEstado: Double;
begin
  Result := FValorDoIcmsDoEstado;
end;

function TParametrosCalculoST.ValorDoIcmsDoItem(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FValorDoIcmsDoItem := AValue;
end;

function TParametrosCalculoST.ValorDoIcmsDoItem: Double;
begin
  Result := FValorDoIcmsDoItem;
end;

function TParametrosCalculoST.ValorDoIpiDoItem: Double;
begin
  Result := FValorDoIpiDoItem;
end;

function TParametrosCalculoST.ValorDoIpiDoItem(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FValorDoIpiDoItem := AValue;
end;

function TParametrosCalculoST.ValorDoIva: Double;
begin
  Result := FValorDoIva;
end;

function TParametrosCalculoST.ValorDoIva(AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FValorDoIva := AValue;
end;

function TParametrosCalculoST.VendaDentroDoEstado(
  AValue: Boolean): IParametrosCalculoST;
begin
  Result := Self;
  FVendaDentroDoEstado := AValue;
end;

function TParametrosCalculoST.VendaDentroDoEstado: Boolean;
begin
  Result := FVendaDentroDoEstado;
end;

function TParametrosCalculoST.ValorDoIpiDeEntrada: Double;
begin
  Result := FValorDoIpiDeEntrada;
end;

function TParametrosCalculoST.ValorDoIpiDeEntrada(
  AValue: Double): IParametrosCalculoST;
begin
  Result := Self;
  FValorDoIpiDeEntrada := AValue;
end;

function TParametrosCalculoST.ModeloBeneficioReducaoBaseIcmsST: Integer;
begin
  Result := FModeloBeneficioReducaoBaseIcmsST;
end;

function TParametrosCalculoST.ModeloBeneficioReducaoBaseIcmsST(
  AValue: Integer): IParametrosCalculoST;
begin
  Result := Self;
  FModeloBeneficioReducaoBaseIcmsST := AValue;
end;


{ TResultadoCalculoST }

function TResultadoCalculoST.AliquotaDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoCalculoST.AliquotaDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaSimulada;
end;

function TResultadoCalculoST.BaseDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FBaseDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoCalculoST.BaseDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FBaseDaSubstituicaoTributariaSimulada;
end;

function TResultadoCalculoST.BaseDeCalculoDaSubstituicaoTributariaDoItem(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FBaseDeCalculoDaSubstituicaoTributariaDoItem := AValue;
end;

function TResultadoCalculoST.BaseDeCalculoDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FBaseDeCalculoDaSubstituicaoTributariaDoItem;
end;

class function TResultadoCalculoST.New: IResultadoCalculoST;
begin
  Result := Self.Create;
end;

function TResultadoCalculoST.PercentualDoFCPDoItem: Double;
begin
  Result := FPercentualDoFCPDoItem;
end;

function TResultadoCalculoST.PercentualDaSubstituicaoDaBase: Double;
begin
  Result := FPercentualDaSubstituicaoDaBase;
end;

function TResultadoCalculoST.PercentualDaSubstituicaoDaBase(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FPercentualDaSubstituicaoDaBase := AValue;
end;

function TResultadoCalculoST.PercentualDoFCPDoItem(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FPercentualDoFCPDoItem := AValue;
end;

function TResultadoCalculoST.ValorDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FValorDaSubstituicaoTributariaDoItem;
end;

function TResultadoCalculoST.ValorCalculadoSTConsignacao(AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FValorCalculadoSTConsignacao := AValue;
end;

function TResultadoCalculoST.ValorCalculadoSTConsignacao: Double;
begin
  Result := FValorCalculadoSTConsignacao;
end;

function TResultadoCalculoST.ValorDaSubstituicaoTributariaDoItem(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaDoItem := AValue;
end;

function TResultadoCalculoST.ValorDaSubstituicaoTributariaSimulada: Double;
begin
  Result := FValorDaSubstituicaoTributariaSimulada;
end;

function TResultadoCalculoST.ValorDaSubstituicaoTributariaSimulada(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FValorDaSubstituicaoTributariaSimulada := AValue;
end;

function TResultadoCalculoST.ValorDoFCPDoItem: Double;
begin
  Result := FValorDoFCPDoItem;
end;

function TResultadoCalculoST.ValorDoFCPDoItem(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FValorDoFCPDoItem := AValue;
end;

function TResultadoCalculoST.ValorDesoneradoDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FValorDesoneradoDaSubstituicaoTributariaDoItem;
end;

function TResultadoCalculoST.ValorDesoneradoDaSubstituicaoTributariaDoItem(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FValorDesoneradoDaSubstituicaoTributariaDoItem := AValue;
end;

function TResultadoCalculoST.ValorDoIvaMatriz(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FValorDoIvaMatriz := AValue;
end;

function TResultadoCalculoST.ValorDoIvaMatriz: Double;
begin
  Result := FValorDoIvaMatriz;
end;

function TResultadoCalculoST.ValorDoIvaStMatriz(
  AValue: Double): IResultadoCalculoST;
begin
  Result := Self;
  FValorDoIvaStMatriz := AValue;
end;

function TResultadoCalculoST.ValorDoIvaStMatriz: Double;
begin
  Result := FValorDoIvaStMatriz;
end;

end.
