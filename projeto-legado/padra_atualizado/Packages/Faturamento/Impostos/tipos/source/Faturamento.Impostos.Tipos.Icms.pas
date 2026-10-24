unit Faturamento.Impostos.Tipos.Icms;

interface

uses
  Faturamento.Impostos.Interfaces.Icms,
  Shared.Functions.Types;

type
  TParametrosCalculoIcms = class(TInterfacedObject, IParametrosCalculoIcms)
  private
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
    FMetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF;
    FUtilizarReducaoRICMPR: Boolean;
    FClienteOrgaoPublico: Boolean;
    FCalcularDescontoIcmsOrgaoPublico: Boolean;
    FClienteZonaFranca: Boolean;
    FClienteConsumidorFinal: Boolean;
    FPercentualDeReducaoDaBaseDeIcms: Double;
    FTipoDaAbreviacaoFiscal: string;
  public
    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosCalculoIcms; overload;

    function SubstituicaoTributariaDoItem: Boolean; overload;
    function SubstituicaoTributariaDoItem(AValue: Boolean): IParametrosCalculoIcms; overload;

    function UtilizaImportacaoDireta: Boolean; overload;
    function UtilizaImportacaoDireta(AValue: Boolean): IParametrosCalculoIcms; overload;

    function ItemImportacaoDireta: Boolean; overload;
    function ItemImportacaoDireta(AValue: Boolean): IParametrosCalculoIcms; overload;

    function CalculaBeneficioReducaoBaseIcmsST: Boolean; overload;
    function CalculaBeneficioReducaoBaseIcmsST(AValue: Boolean): IParametrosCalculoIcms; overload;

    function SimplesNacional: Boolean; overload;
    function SimplesNacional(AValue: Boolean): IParametrosCalculoIcms; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoIcms; overload;

    function EntraIPINaBaseIcms: Boolean; overload;
    function EntraIPINaBaseIcms(AValue: Boolean): IParametrosCalculoIcms; overload;

    function AliquotaDeIcmsDoItem: Double; overload;
    function AliquotaDeIcmsDoItem(AValue: Double): IParametrosCalculoIcms; overload;

    function ValorDoIpiDoItem: Double; overload;
    function ValorDoIpiDoItem(AValue: Double): IParametrosCalculoIcms; overload;

    function PercentualDaBaseDeIcmsDoItem: Double; overload;
    function PercentualDaBaseDeIcmsDoItem(AValue: Double): IParametrosCalculoIcms; overload;

    function MetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF; overload;
    function MetodoArredondamentoICMSECF(AValue: TMetodoArredondamentoICMSECF): IParametrosCalculoIcms; overload;
    function MetodoArredondamentoICMSECF(AValue: Double): Double; overload;

    function UtilizarReducaoRICMPR: Boolean; overload;
    function UtilizarReducaoRICMPR(AValue: Boolean): IParametrosCalculoIcms; overload;

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosCalculoIcms; overload;

    function CalcularDescontoIcmsOrgaoPublico: Boolean; overload;
    function CalcularDescontoIcmsOrgaoPublico(AValue: Boolean): IParametrosCalculoIcms; overload;

    function ClienteZonaFranca: Boolean; overload;
    function ClienteZonaFranca(AValue: Boolean): IParametrosCalculoIcms; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoIcms; overload;

    function PercentualDeReducaoDaBaseDeIcms: Double; overload;
    function PercentualDeReducaoDaBaseDeIcms(AValue: Double): IParametrosCalculoIcms; overload;

    function TipoDaAbreviacaoFiscal : String; Overload;
    function TipoDaAbreviacaoFiscal(AValue : String) : IParametrosCalculoIcms; Overload;

    class function New(): IParametrosCalculoIcms;
  end;

type
  TResultadoCalculoIcms = class(TInterfacedObject, IResultadoCalculoIcms)
  private
    FAliquotaDoIcms: Double;
    FBaseDeCalculoDoIcms: Double;
    FValorCalculadoDoIcms: Double;
    FPercentualDaBaseDeIcms: Double;
    FValorDaDiferencaDeIcms: Double;
    FAliquotaDeIcmsAnterior: Double;
    FBaseDeCalculoDoIcmsAnterior: Double;
    FValorDoIcmsAnterior: Double;
    FPercentualDeReducaoDaBaseDeIcms: Double;
    FReducaoRICMPR : String;
    FTipoDaAbreviacaoFiscal: String;
    FEntraIPINaBaseIcms: Boolean;
    FBaseDeCalculoDoIcmsDoItemBenST: Double;
  public
    function AliquotaDoIcms: Double; overload;
    function AliquotaDoIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function BaseDeCalculoDoIcms: Double; overload;
    function BaseDeCalculoDoIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function ValorCalculadoDoIcms: Double; overload;
    function ValorCalculadoDoIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function ValorDaDiferencaDeIcms: Double; overload;
    function ValorDaDiferencaDeIcms(AValue: Double): IResultadoCalculoIcms; overload;

    function AliquotaDeIcmsAnterior: Double; overload;
    function AliquotaDeIcmsAnterior(AValue : Double): IResultadoCalculoIcms; overload;

    function BaseDeCalculoDoIcmsAnterior: Double; overload;
    function BaseDeCalculoDoIcmsAnterior(AValue : Double): IResultadoCalculoIcms; overload;

    function ValorDoIcmsAnterior: Double; overload;
    function ValorDoIcmsAnterior(AValue : Double): IResultadoCalculoIcms; overload;

    function PercentualDeReducaoDaBaseDeIcms: Double; overload;
    function PercentualDeReducaoDaBaseDeIcms(AValue : Double): IResultadoCalculoIcms; overload;

    function ReducaoRICMPR : String; Overload;
    function ReducaoRICMPR(AValue : String) : IResultadoCalculoIcms; Overload;

    function TipoDaAbreviacaoFiscal : String; Overload;
    function TipoDaAbreviacaoFiscal(AValue : String) : IResultadoCalculoIcms; Overload;

    function EntraIPINaBaseIcms : Boolean; Overload;
    function EntraIPINaBaseIcms(AValue : Boolean) : IResultadoCalculoIcms; Overload;

    function BaseDeCalculoDoIcmsDoItemBenST: Double; overload;
    function BaseDeCalculoDoIcmsDoItemBenST(AValue : Double): IResultadoCalculoIcms; overload;

    destructor Destroy; override;

    class function New(): IResultadoCalculoIcms;
  end;

implementation

{ TResultadoCalculoIcms }

function TResultadoCalculoIcms.AliquotaDeIcmsAnterior: Double;
begin
  Result := FAliquotaDeIcmsAnterior;
end;

function TResultadoCalculoIcms.AliquotaDeIcmsAnterior(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FAliquotaDeIcmsAnterior := AValue;
end;

function TResultadoCalculoIcms.AliquotaDoIcms(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FAliquotaDoIcms := AValue;
end;

function TResultadoCalculoIcms.AliquotaDoIcms: Double;
begin
  Result := FAliquotaDoIcms;
end;

function TResultadoCalculoIcms.BaseDeCalculoDoIcms: Double;
begin
  Result := FBaseDeCalculoDoIcms;
end;

function TResultadoCalculoIcms.BaseDeCalculoDoIcms(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FBaseDeCalculoDoIcms := AValue;
end;

function TResultadoCalculoIcms.BaseDeCalculoDoIcmsAnterior(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsAnterior := AValue;
end;

destructor TResultadoCalculoIcms.Destroy;
begin

  inherited;
end;

function TResultadoCalculoIcms.BaseDeCalculoDoIcmsAnterior: Double;
begin
  Result := FBaseDeCalculoDoIcmsAnterior;
end;

class function TResultadoCalculoIcms.New: IResultadoCalculoIcms;
begin
  Result := Self.Create;
end;

function TResultadoCalculoIcms.PercentualDaBaseDeIcms: Double;
begin
  Result := FPercentualDaBaseDeIcms;
end;

function TResultadoCalculoIcms.PercentualDaBaseDeIcms(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FPercentualDaBaseDeIcms := AValue;
end;

function TResultadoCalculoIcms.BaseDeCalculoDoIcmsDoItemBenST: Double;
begin
  Result := FBaseDeCalculoDoIcmsDoItemBenST;
end;

function TResultadoCalculoIcms.BaseDeCalculoDoIcmsDoItemBenST(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FBaseDeCalculoDoIcmsDoItemBenST := AValue;
end;

function TResultadoCalculoIcms.PercentualDeReducaoDaBaseDeIcms: Double;
begin
  Result := FPercentualDeReducaoDaBaseDeIcms;
end;

function TResultadoCalculoIcms.PercentualDeReducaoDaBaseDeIcms(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FPercentualDeReducaoDaBaseDeIcms := AValue;
end;

function TResultadoCalculoIcms.ReducaoRICMPR: String;
begin
  Result := FReducaoRICMPR;
end;

function TResultadoCalculoIcms.ReducaoRICMPR(
  AValue: String): IResultadoCalculoIcms;
begin
  Result := Self;
  FReducaoRICMPR := AValue;
end;

function TResultadoCalculoIcms.TipoDaAbreviacaoFiscal: String;
begin
  result := FTipoDaAbreviacaoFiscal;
end;

function TResultadoCalculoIcms.TipoDaAbreviacaoFiscal(
  AValue: String): IResultadoCalculoIcms;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

function TResultadoCalculoIcms.ValorCalculadoDoIcms: Double;
begin
  Result := FValorCalculadoDoIcms;
end;

function TResultadoCalculoIcms.ValorCalculadoDoIcms(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FValorCalculadoDoIcms := AValue;
end;

function TResultadoCalculoIcms.ValorDaDiferencaDeIcms: Double;
begin
  Result := FValorDaDiferencaDeIcms;
end;

function TResultadoCalculoIcms.ValorDaDiferencaDeIcms(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FValorDaDiferencaDeIcms := AValue;
end;

function TResultadoCalculoIcms.ValorDoIcmsAnterior(
  AValue: Double): IResultadoCalculoIcms;
begin
  Result := Self;
  FValorDoIcmsAnterior := AValue;
end;

function TResultadoCalculoIcms.ValorDoIcmsAnterior: Double;
begin
  Result := FValorDoIcmsAnterior;
end;

function TResultadoCalculoIcms.EntraIPINaBaseIcms: Boolean;
begin
  result := FEntraIPINaBaseIcms;
end;

function TResultadoCalculoIcms.EntraIPINaBaseIcms(
  AValue: Boolean): IResultadoCalculoIcms;
begin
  Result := Self;
  FEntraIPINaBaseIcms := AValue;
end;

{ TParametrosCalculoIcms }

function TParametrosCalculoIcms.AliquotaDeIcmsDoItem(
  AValue: Double): IParametrosCalculoIcms;
begin
  Result := Self;
  FAliquotaDeIcmsDoItem := AValue;
end;

function TParametrosCalculoIcms.AliquotaDeIcmsDoItem: Double;
begin
  Result := FAliquotaDeIcmsDoItem;
end;

function TParametrosCalculoIcms.CalculaBeneficioReducaoBaseIcmsST: Boolean;
begin
  Result := FCalculaBeneficioReducaoBaseIcmsST;
end;

function TParametrosCalculoIcms.CalculaBeneficioReducaoBaseIcmsST(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FCalculaBeneficioReducaoBaseIcmsST := AValue;
end;

function TParametrosCalculoIcms.CalcularDescontoIcmsOrgaoPublico: Boolean;
begin
  Result := FCalcularDescontoIcmsOrgaoPublico;
end;

function TParametrosCalculoIcms.CalcularDescontoIcmsOrgaoPublico(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FCalcularDescontoIcmsOrgaoPublico := AValue;
end;

function TParametrosCalculoIcms.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosCalculoIcms.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosCalculoIcms.ClienteOrgaoPublico(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FClienteOrgaoPublico := AValue;
end;

function TParametrosCalculoIcms.ClienteOrgaoPublico: Boolean;
begin
  Result := FClienteOrgaoPublico;
end;

function TParametrosCalculoIcms.ClienteZonaFranca(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FClienteZonaFranca := AValue;
end;

function TParametrosCalculoIcms.ClienteZonaFranca: Boolean;
begin
  Result := FClienteZonaFranca;
end;

function TParametrosCalculoIcms.EntraIPINaBaseIcms(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FEntraIPINaBaseIcms := AValue;
end;

function TParametrosCalculoIcms.ItemImportacaoDireta: Boolean;
begin
  Result := FItemImportacaoDireta;
end;

function TParametrosCalculoIcms.ItemImportacaoDireta(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FItemImportacaoDireta := AValue;
end;

function TParametrosCalculoIcms.MetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF;
begin
  Result := FMetodoArredondamentoICMSECF;
end;

function TParametrosCalculoIcms.MetodoArredondamentoICMSECF(
  AValue: TMetodoArredondamentoICMSECF): IParametrosCalculoIcms;
begin
  Result := Self;
  FMetodoArredondamentoICMSECF := AValue;
end;

function TParametrosCalculoIcms.EntraIPINaBaseIcms: Boolean;
begin
  Result := FEntraIPINaBaseIcms;
end;

function TParametrosCalculoIcms.PercentualDaBaseDeIcmsDoItem: Double;
begin
  Result := FPercentualDaBaseDeIcmsDoItem;
end;

function TParametrosCalculoIcms.PercentualDaBaseDeIcmsDoItem(
  AValue: Double): IParametrosCalculoIcms;
begin
  Result := Self;
  FPercentualDaBaseDeIcmsDoItem := AValue;
end;

function TParametrosCalculoIcms.PercentualDeReducaoDaBaseDeIcms: Double;
begin
  Result := FPercentualDeReducaoDaBaseDeIcms;
end;

function TParametrosCalculoIcms.PercentualDeReducaoDaBaseDeIcms(
  AValue: Double): IParametrosCalculoIcms;
begin
  Result := Self;
  FPercentualDeReducaoDaBaseDeIcms := AValue;
end;

function TParametrosCalculoIcms.SimplesNacional(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FSimplesNacional := AValue;
end;

function TParametrosCalculoIcms.SimplesNacional: Boolean;
begin
  Result := FSimplesNacional;
end;

function TParametrosCalculoIcms.SubstituicaoTributariaDoItem: Boolean;
begin
  Result := FSubstituicaoTributariaDoItem;
end;

function TParametrosCalculoIcms.SubstituicaoTributariaDoItem(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosCalculoIcms.TipoDaAbreviacaoFiscal: String;
begin
  Result := FTipoDaAbreviacaoFiscal;
end;

function TParametrosCalculoIcms.TipoDaAbreviacaoFiscal(
  AValue: String): IParametrosCalculoIcms;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

function TParametrosCalculoIcms.TotalGeralDoItem(
  AValue: Double): IParametrosCalculoIcms;
begin
  Result := Self;
  FTotalGeralDoItem := AValue;
end;

function TParametrosCalculoIcms.UtilizaImportacaoDireta: Boolean;
begin
  Result := FUtilizaImportacaoDireta;
end;

function TParametrosCalculoIcms.UtilizaImportacaoDireta(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FUtilizaImportacaoDireta := AValue;
end;

function TParametrosCalculoIcms.UtilizarReducaoRICMPR: Boolean;
begin
  Result := FUtilizarReducaoRICMPR;
end;

function TParametrosCalculoIcms.UtilizarReducaoRICMPR(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FUtilizarReducaoRICMPR := AValue;
end;

function TParametrosCalculoIcms.TotalGeralDoItem: Double;
begin
  Result := FTotalGeralDoItem;
end;

function TParametrosCalculoIcms.ValorDoIpiDoItem: Double;
begin
  Result := FValorDoIpiDoItem;
end;

function TParametrosCalculoIcms.ValorDoIpiDoItem(
  AValue: Double): IParametrosCalculoIcms;
begin
  Result := Self;
  FValorDoIpiDoItem := AValue;
end;

function TParametrosCalculoIcms.VendaDentroDoEstado: Boolean;
begin
  Result := FVendaDentroDoEstado;
end;

function TParametrosCalculoIcms.VendaDentroDoEstado(
  AValue: Boolean): IParametrosCalculoIcms;
begin
  Result := Self;
  FVendaDentroDoEstado := AValue;
end;


class function TParametrosCalculoIcms.New: IParametrosCalculoIcms;
begin
  Result := Self.Create;
end;

function TParametrosCalculoIcms.MetodoArredondamentoICMSECF(
  AValue: Double): Double;
begin
  Result := FMetodoArredondamentoICMSECF(AValue);
end;

end.
