unit Faturamento.Precos.Tipos.PrecoCusto;

interface

uses Faturamento.Precos.Interfaces.PrecoCusto,
     Shared.Functions.Types;

type
  TParametrosServicoPrecoCusto = class(TInterfacedObject, IParametrosServicoPrecoCusto)
  private
    FPrecoDeCompra: Double;
    FDesconto01: Double;
    FDesconto02: Double;
    FDesconto03: Double;
    FDesconto04: Double;
    FDesconto05: Double;
    FDesconto06: Double;
    FDesconto07: Double;
    FIcmsDeEntrada: Double;
    FImpostoFederal: Double;
    FIpiDeEntrada: Double;
    FPercentualFreteDeEntrada: Double;
    FValorDoFrete: Double;
    FAcrescimoFinal: Double;
    FSubstituicaoTributaria: Double;
    FDescontosAdicionais: Double;
    FTipoMoeda : TTipoMoeda;
    FTaxaDeControleDeIncentivosFiscaisSuframa : Double;
    FTaxaDeServicoSuframa: Double;
    FDescontoPISCOFINS: Double;
    FDescontoDeIcms: Double;
    FFatorRegional: Double;
    FCalculandoTintaDeMaquina: Boolean;
    FPredol: Boolean;
  public
    function PrecoDeCompra: Double; overload;
    function PrecoDeCompra(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto01: Double; overload;
    function Desconto01(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto02: Double; overload;
    function Desconto02(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto03: Double; overload;
    function Desconto03(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto04: Double; overload;
    function Desconto04(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto05: Double; overload;
    function Desconto05(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto06: Double; overload;
    function Desconto06(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function Desconto07: Double; overload;
    function Desconto07(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function IcmsDeEntrada: Double; overload;
    function IcmsDeEntrada(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function ImpostoFederal: Double; overload;
    function ImpostoFederal(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function IpiDeEntrada: Double; overload;
    function IpiDeEntrada(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function PercentualFreteDeEntrada: Double; overload;
    function PercentualFreteDeEntrada(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function ValorDoFrete: Double; overload;
    function ValorDoFrete(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function AcrescimoFinal: Double; overload;
    function AcrescimoFinal(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function SubstituicaoTributaria: Double; overload;
    function SubstituicaoTributaria(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function DescontosAdicionais: Double; overload;
    function DescontosAdicionais(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function TipoMoeda : TTipoMoeda; overload;
    function TipoMoeda(AValue: TTipoMoeda): IParametrosServicoPrecoCusto; overload;

    function Predol : Boolean; overload;
    function Predol(AValue: Boolean): IParametrosServicoPrecoCusto; overload;

    function TaxaDeControleDeIncentivosFiscaisSuframa: Double; overload;
    function TaxaDeControleDeIncentivosFiscaisSuframa(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function TaxaDeServicoSuframa: Double; overload;
    function TaxaDeServicoSuframa(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function DescontoPISCOFINS: Double; overload;
    function DescontoPISCOFINS(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function DescontoDeIcms: Double; overload;
    function DescontoDeIcms(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function FatorRegional: Double; overload;
    function FatorRegional(AValue: Double): IParametrosServicoPrecoCusto; overload;

    function CalculandoTintaDeMaquina: Boolean; overload;
    function CalculandoTintaDeMaquina(AValue: Boolean): IParametrosServicoPrecoCusto; overload;

    class function New(): IParametrosServicoPrecoCusto;
  end;

type
  TParametrosCalculoPrecoCusto = class(TInterfacedObject, IParametrosCalculoPrecoCusto)
  strict private
    FPrecoDeCompra: Double;
    FDesconto01: Double;
    FDesconto02: Double;
    FDesconto03: Double;
    FDesconto04: Double;
    FDesconto05: Double;
    FDesconto06: Double;
    FDesconto07: Double;
    FIcmsDeEntrada: Double;
    FImpostoFederal: Double;
    FIpiDeEntrada: Double;
    FPercentualFreteDeEntrada: Double;
    FValorDoFrete: Double;
    FAcrescimoFinal: Double;
    FSubstituicaoTributaria: Double;
    FDescontosAdicionais: Double;
    FFormulaParaCalculo: String;
    FOperadorAdicaoDescontosAdicionais: Boolean;
    FQuantidadeCasasDecimais : Integer;
    FTaxaDeControleDeIncentivosFiscaisSuframa : Double;
    FTaxaDeServicoSuframa: Double;
    FDescontoPISCOFINS: Double;
    FDescontoDeIcms: Double;
    FFatorRegional: Double;
    FCalculandoTintaDeMaquina: Boolean;
  public
    function PrecoDeCompra: Double; overload;
    function PrecoDeCompra(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto01: Double; overload;
    function Desconto01(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto02: Double; overload;
    function Desconto02(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto03: Double; overload;
    function Desconto03(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto04: Double; overload;
    function Desconto04(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto05: Double; overload;
    function Desconto05(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto06: Double; overload;
    function Desconto06(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function Desconto07: Double; overload;
    function Desconto07(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function IcmsDeEntrada: Double; overload;
    function IcmsDeEntrada(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function ImpostoFederal: Double; overload;
    function ImpostoFederal(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function IpiDeEntrada: Double; overload;
    function IpiDeEntrada(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function PercentualFreteDeEntrada: Double; overload;
    function PercentualFreteDeEntrada(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function ValorDoFrete: Double; overload;
    function ValorDoFrete(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function AcrescimoFinal: Double; overload;
    function AcrescimoFinal(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function SubstituicaoTributaria: Double; overload;
    function SubstituicaoTributaria(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function DescontosAdicionais: Double; overload;
    function DescontosAdicionais(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function FormulaParaCalculo: String; overload;
    function FormulaParaCalculo(AValue: String): IParametrosCalculoPrecoCusto; overload;

    function OperadorAdicaoDescontosAdicionais: Boolean; overload;
    function OperadorAdicaoDescontosAdicionais(AValue: Boolean): IParametrosCalculoPrecoCusto; overload;

    function QuantidadeCasasDecimais: Integer; overload;
    function QuantidadeCasasDecimais(AValue : Integer) :IParametrosCalculoPrecoCusto; overload;

    function TaxaDeControleDeIncentivosFiscaisSuframa: Double; overload;
    function TaxaDeControleDeIncentivosFiscaisSuframa(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function TaxaDeServicoSuframa: Double; overload;
    function TaxaDeServicoSuframa(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function DescontoPISCOFINS: Double; overload;
    function DescontoPISCOFINS(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function DescontoDeIcms: Double; overload;
    function DescontoDeIcms(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function FatorRegional: Double; overload;
    function FatorRegional(AValue: Double): IParametrosCalculoPrecoCusto; overload;

    function CalculandoTintaDeMaquina: Boolean; overload;
    function CalculandoTintaDeMaquina(AValue: Boolean): IParametrosCalculoPrecoCusto; overload;

    class function New(): IParametrosCalculoPrecoCusto;
  end;

type
  TParametrosServicoPrecoCustoMargemMarkup = class(TInterfacedObject, IParametrosServicoPrecoCustoMargemMarkup)
  private
    FPrecoDeVenda: Double;
    FMargem: Double;
    FDecUni: Integer;
  public
    function PrecoDeVenda: Double; overload;
    function PrecoDeVenda(AValue: Double): IParametrosServicoPrecoCustoMargemMarkup; overload;

    function Margem: Double; overload;
    function Margem(AValue: Double): IParametrosServicoPrecoCustoMargemMarkup; overload;

    function DecUni: Integer; overload;
    function DecUni(AValue: Integer): IParametrosServicoPrecoCustoMargemMarkup; overload;

    class function New(): IParametrosServicoPrecoCustoMargemMarkup;
  end;

type
  TParametrosCalculoPrecoCustoMargemMarkup = class(TInterfacedObject, IParametrosCalculoPrecoCustoMargemMarkup)
  strict private
    FPrecoDeVenda: Double;
    FMargem: Double;
    FMargemMarkup: String;
    FDecUni: Integer;
  public
    function PrecoDeVenda: Double; overload;
    function PrecoDeVenda(AValue: Double): IParametrosCalculoPrecoCustoMargemMarkup; overload;

    function Margem: Double; overload;
    function Margem(AValue: Double): IParametrosCalculoPrecoCustoMargemMarkup; overload;

    function MargemMarkup: String; overload;
    function MargemMarkup(AValue: String): IParametrosCalculoPrecoCustoMargemMarkup; overload;

    function DecUni: Integer; overload;
    function DecUni(AValue: Integer): IParametrosCalculoPrecoCustoMargemMarkup; overload;

    class function New(): IParametrosCalculoPrecoCustoMargemMarkup;
  end;

type
  TParametrosCalculoPrecoCustoRealVenda = class(TInterfacedObject, IParametrosCalculoPrecoCustoRealVenda)
  strict private
    FPrecoDeVenda: Double;
    FPrecoDeCusto: Double;
    FOutrosValores: Double;
    FIcmsDeSaida: Double;
    FImpostosFederais: Double;
    FDespesasOperacionais: Double;
    FAliquotaDoDifal: Double;
    FAliquotaDoFcp: Double;
    FTaxaDeJuros: Double;
    FValorFrete: Double;
  public
    function PrecoDeVenda: Double; overload;
    function PrecoDeVenda(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function PrecoDeCusto: Double; overload;
    function PrecoDeCusto(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function OutrosValores: Double; overload;
    function OutrosValores(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function IcmsDeSaida: Double; overload;
    function IcmsDeSaida(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function ImpostosFederais: Double; overload;
    function ImpostosFederais(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function DespesasOperacionais: Double; overload;
    function DespesasOperacionais(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function AliquotaDoDifal: Double; overload;
    function AliquotaDoDifal(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function AliquotaDoFcp: Double; overload;
    function AliquotaDoFcp(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function TaxaDeJuros: Double; overload;
    function TaxaDeJuros(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    function ValorFrete: Double; overload;
    function ValorFrete(AValue: Double): IParametrosCalculoPrecoCustoRealVenda; overload;

    class function New(): IParametrosCalculoPrecoCustoRealVenda;
  end;

type
  TParametrosCalculoCustoReal = class(TInterfacedObject, IParametrosCalculoCustoReal)
  strict private
    FPrecoDeCusto: Double;
    FIcmsDeSaida: Double;
    FImpostosFederais: Double;
    FDespesasOperacionais: Double;
    FOutrosValores: Double;
  public
    function PrecoDeCusto: Double; overload;
    function PrecoDeCusto(AValue: Double): IParametrosCalculoCustoReal; overload;

    function IcmsDeSaida: Double; overload;
    function IcmsDeSaida(AValue: Double): IParametrosCalculoCustoReal; overload;

    function ImpostosFederais: Double; overload;
    function ImpostosFederais(AValue: Double): IParametrosCalculoCustoReal; overload;

    function DespesasOperacionais: Double; overload;
    function DespesasOperacionais(AValue: Double): IParametrosCalculoCustoReal; overload;

    function OutrosValores: Double; overload;
    function OutrosValores(AValue: Double): IParametrosCalculoCustoReal; overload;

    class function New(): IParametrosCalculoCustoReal;
  end;

type
  TResultadoCalculoPrecoCusto = class(TInterfacedObject, IResultadoCalculoPrecoCusto)
  strict private
    FValorCalculadoPrecoCusto: Double;
  public
    function ValorCalculadoPrecoCusto: Double; overload;
    function ValorCalculadoPrecoCusto(AValue: Double): IResultadoCalculoPrecoCusto; overload;

    class function New(): IResultadoCalculoPrecoCusto;
  end;

type
  TResultadoServicosClassePrecoCusto = class(TInterfacedObject, IResultadoServicosClassePrecoCusto)
  strict private
    FResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto;
    FParametrosCalculoPrecoCusto: IParametrosCalculoPrecoCusto;
    FParametrosCalculoPrecoCustoMargemMarkup: IParametrosCalculoPrecoCustoMargemMarkup;
    FParametrosCalculoPrecoCustoRealVenda: IParametrosCalculoPrecoCustoRealVenda;
    FParametrosCalculoCustoReal: IParametrosCalculoCustoReal;
  public
    function ResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto; overload;
    function ResultadoCalculoPrecoCusto(AValue: IResultadoCalculoPrecoCusto): IResultadoServicosClassePrecoCusto; overload;

    function ParametrosCalculoPrecoCusto: IParametrosCalculoPrecoCusto; overload;
    function ParametrosCalculoPrecoCusto(AValue: IParametrosCalculoPrecoCusto): IResultadoServicosClassePrecoCusto; overload;

    function ParametrosCalculoPrecoCustoMargemMarkup: IParametrosCalculoPrecoCustoMargemMarkup; overload;
    function ParametrosCalculoPrecoCustoMargemMarkup(AValue: IParametrosCalculoPrecoCustoMargemMarkup): IResultadoServicosClassePrecoCusto; overload;

    function ParametrosCalculoPrecoCustoRealVenda: IParametrosCalculoPrecoCustoRealVenda; overload;
    function ParametrosCalculoPrecoCustoRealVenda(AValue: IParametrosCalculoPrecoCustoRealVenda): IResultadoServicosClassePrecoCusto; overload;

    function ParametrosCalculoCustoReal: IParametrosCalculoCustoReal; overload;
    function ParametrosCalculoCustoReal(AValue: IParametrosCalculoCustoReal): IResultadoServicosClassePrecoCusto; overload;

    class function New(): IResultadoServicosClassePrecoCusto;
  end;

implementation

{ TParametrosCalculoPrecoCusto }

function TParametrosCalculoPrecoCusto.AcrescimoFinal: Double;
begin
  Result := FAcrescimoFinal;
end;

function TParametrosCalculoPrecoCusto.AcrescimoFinal(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FAcrescimoFinal := AValue;
end;

function TParametrosCalculoPrecoCusto.CalculandoTintaDeMaquina: Boolean;
begin
  Result := FCalculandoTintaDeMaquina;
end;

function TParametrosCalculoPrecoCusto.CalculandoTintaDeMaquina(
  AValue: Boolean): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FCalculandoTintaDeMaquina := AValue;
end;

function TParametrosCalculoPrecoCusto.Desconto01: Double;
begin
  Result := FDesconto01;
end;

function TParametrosCalculoPrecoCusto.Desconto01(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDesconto01 := AValue;
end;

function TParametrosCalculoPrecoCusto.Desconto02(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDesconto02 := AValue;
end;

function TParametrosCalculoPrecoCusto.Desconto02: Double;
begin
  Result := FDesconto02;
end;

function TParametrosCalculoPrecoCusto.Desconto03: Double;
begin
  Result := FDesconto03;
end;

function TParametrosCalculoPrecoCusto.Desconto03(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDesconto03 := AValue;
end;

function TParametrosCalculoPrecoCusto.Desconto04: Double;
begin
  Result := FDesconto04;
end;

function TParametrosCalculoPrecoCusto.Desconto04(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDesconto04 := AValue;
end;

function TParametrosCalculoPrecoCusto.Desconto05: Double;
begin
  Result := FDesconto05;
end;

function TParametrosCalculoPrecoCusto.Desconto05(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDesconto05 := AValue;
end;

function TParametrosCalculoPrecoCusto.Desconto06(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDesconto06 := AValue;
end;

function TParametrosCalculoPrecoCusto.Desconto06: Double;
begin
  Result := FDesconto06;
end;

function TParametrosCalculoPrecoCusto.Desconto07(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDesconto07 := AValue;
end;

function TParametrosCalculoPrecoCusto.DescontoDeIcms: Double;
begin
  Result := FDescontoDeIcms;
end;

function TParametrosCalculoPrecoCusto.DescontoDeIcms(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDescontoDeIcms := AValue;
end;

function TParametrosCalculoPrecoCusto.DescontoPISCOFINS(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDescontoPISCOFINS := AValue;
end;

function TParametrosCalculoPrecoCusto.DescontoPISCOFINS: Double;
begin
  Result := FDescontoPISCOFINS;
end;

function TParametrosCalculoPrecoCusto.Desconto07: Double;
begin
  Result := FDesconto07;
end;

function TParametrosCalculoPrecoCusto.DescontosAdicionais(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FDescontosAdicionais := AValue;
end;

function TParametrosCalculoPrecoCusto.FormulaParaCalculo: String;
begin
  Result := FFormulaParaCalculo;
end;

function TParametrosCalculoPrecoCusto.FatorRegional: Double;
begin
  Result := FFatorRegional;
end;

function TParametrosCalculoPrecoCusto.FatorRegional(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FFatorRegional := AValue;
end;

function TParametrosCalculoPrecoCusto.FormulaParaCalculo(
  AValue: String): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FFormulaParaCalculo := AValue;
end;

function TParametrosCalculoPrecoCusto.DescontosAdicionais: Double;
begin
  Result := FDescontosAdicionais;
end;

function TParametrosCalculoPrecoCusto.IcmsDeEntrada(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FIcmsDeEntrada := AValue;
end;

function TParametrosCalculoPrecoCusto.IcmsDeEntrada: Double;
begin
  Result := FIcmsDeEntrada;
end;

function TParametrosCalculoPrecoCusto.ImpostoFederal: Double;
begin
  Result := FImpostoFederal;
end;

function TParametrosCalculoPrecoCusto.ImpostoFederal(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FImpostoFederal := AValue;
end;

function TParametrosCalculoPrecoCusto.IpiDeEntrada(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FIpiDeEntrada := AValue;
end;

class function TParametrosCalculoPrecoCusto.New: IParametrosCalculoPrecoCusto;
begin
  Result := Self.Create;
end;

function TParametrosCalculoPrecoCusto.OperadorAdicaoDescontosAdicionais: Boolean;
begin
  Result := FOperadorAdicaoDescontosAdicionais;
end;

function TParametrosCalculoPrecoCusto.OperadorAdicaoDescontosAdicionais(
  AValue: Boolean): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FOperadorAdicaoDescontosAdicionais := AValue;
end;

function TParametrosCalculoPrecoCusto.IpiDeEntrada: Double;
begin
  Result := FIpiDeEntrada;
end;

function TParametrosCalculoPrecoCusto.PercentualFreteDeEntrada(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FPercentualFreteDeEntrada := AValue;
end;

function TParametrosCalculoPrecoCusto.PercentualFreteDeEntrada: Double;
begin
  Result := FPercentualFreteDeEntrada;
end;

function TParametrosCalculoPrecoCusto.PrecoDeCompra(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FPrecoDeCompra := AValue;
end;

function TParametrosCalculoPrecoCusto.QuantidadeCasasDecimais: Integer;
begin
  Result := FQuantidadeCasasDecimais;
end;

function TParametrosCalculoPrecoCusto.QuantidadeCasasDecimais(
  AValue: Integer): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FQuantidadeCasasDecimais := AValue;
end;

function TParametrosCalculoPrecoCusto.PrecoDeCompra: Double;
begin
  Result := FPrecoDeCompra;
end;

function TParametrosCalculoPrecoCusto.SubstituicaoTributaria(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FSubstituicaoTributaria := AValue;
end;

function TParametrosCalculoPrecoCusto.TaxaDeControleDeIncentivosFiscaisSuframa: Double;
begin
  Result := FTaxaDeControleDeIncentivosFiscaisSuframa;
end;

function TParametrosCalculoPrecoCusto.TaxaDeControleDeIncentivosFiscaisSuframa(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FTaxaDeControleDeIncentivosFiscaisSuframa := AValue;
end;

function TParametrosCalculoPrecoCusto.TaxaDeServicoSuframa(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FTaxaDeServicoSuframa := AValue;
end;

function TParametrosCalculoPrecoCusto.TaxaDeServicoSuframa: Double;
begin
  Result := FTaxaDeServicoSuframa;
end;

function TParametrosCalculoPrecoCusto.SubstituicaoTributaria: Double;
begin
  Result := FSubstituicaoTributaria;
end;

function TParametrosCalculoPrecoCusto.ValorDoFrete(
  AValue: Double): IParametrosCalculoPrecoCusto;
begin
  Result := Self;
  FValorDoFrete := AValue;
end;

function TParametrosCalculoPrecoCusto.ValorDoFrete: Double;
begin
  Result := FValorDoFrete;
end;

{ TResultadoCalculoPrecoCusto }

class function TResultadoCalculoPrecoCusto.New: IResultadoCalculoPrecoCusto;
begin
  Result := Self.Create;
end;

function TResultadoCalculoPrecoCusto.ValorCalculadoPrecoCusto: Double;
begin
  Result := FValorCalculadoPrecoCusto;
end;

function TResultadoCalculoPrecoCusto.ValorCalculadoPrecoCusto(
  AValue: Double): IResultadoCalculoPrecoCusto;
begin
  Result := Self;
  FValorCalculadoPrecoCusto := AValue;
end;

{ TResultadoServicosClassePrecoCusto }

class function TResultadoServicosClassePrecoCusto.New: IResultadoServicosClassePrecoCusto;
begin
  Result := Self.Create;
end;

function TResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCusto: IParametrosCalculoPrecoCusto;
begin
  Result := FParametrosCalculoPrecoCusto;
end;

function TResultadoServicosClassePrecoCusto.ParametrosCalculoCustoReal: IParametrosCalculoCustoReal;
begin
  Result := FParametrosCalculoCustoReal;
end;

function TResultadoServicosClassePrecoCusto.ParametrosCalculoCustoReal(
  AValue: IParametrosCalculoCustoReal): IResultadoServicosClassePrecoCusto;
begin
  Result := Self;
  FParametrosCalculoCustoReal := AValue;
end;

function TResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCusto(
  AValue: IParametrosCalculoPrecoCusto): IResultadoServicosClassePrecoCusto;
begin
  Result := Self;
  FParametrosCalculoPrecoCusto := AValue;
end;

function TResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCustoMargemMarkup(
  AValue: IParametrosCalculoPrecoCustoMargemMarkup): IResultadoServicosClassePrecoCusto;
begin
  Result := Self;
  FParametrosCalculoPrecoCustoMargemMarkup := AValue;
end;

function TResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCustoMargemMarkup: IParametrosCalculoPrecoCustoMargemMarkup;
begin
  Result := FParametrosCalculoPrecoCustoMargemMarkup;
end;

function TResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCustoRealVenda(
  AValue: IParametrosCalculoPrecoCustoRealVenda): IResultadoServicosClassePrecoCusto;
begin
  Result := Self;
  FParametrosCalculoPrecoCustoRealVenda := AValue;
end;

function TResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCustoRealVenda: IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := FParametrosCalculoPrecoCustoRealVenda;
end;

function TResultadoServicosClassePrecoCusto.ResultadoCalculoPrecoCusto(
  AValue: IResultadoCalculoPrecoCusto): IResultadoServicosClassePrecoCusto;
begin
  Result := Self;
  FResultadoCalculoPrecoCusto := AValue;
end;

function TResultadoServicosClassePrecoCusto.ResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto;
begin
  Result := FResultadoCalculoPrecoCusto;
end;

{ TParametrosCalculoPrecoCustoMargemMarkup }

function TParametrosCalculoPrecoCustoMargemMarkup.Margem: Double;
begin
  Result := FMargem;
end;

function TParametrosCalculoPrecoCustoMargemMarkup.DecUni: Integer;
begin
  Result := FDecUni ;
end;

function TParametrosCalculoPrecoCustoMargemMarkup.DecUni(
  AValue: Integer): IParametrosCalculoPrecoCustoMargemMarkup;
begin
  Result := Self ;
  FDecUni := AValue ;
end;

function TParametrosCalculoPrecoCustoMargemMarkup.Margem(
  AValue: Double): IParametrosCalculoPrecoCustoMargemMarkup;
begin
  Result := Self;
  FMargem := AValue;
end;

function TParametrosCalculoPrecoCustoMargemMarkup.MargemMarkup: String;
begin
  Result := FMargemMarkup;
end;

function TParametrosCalculoPrecoCustoMargemMarkup.MargemMarkup(
  AValue: String): IParametrosCalculoPrecoCustoMargemMarkup;
begin
  Result := Self;
  FMargemMarkup := AValue;
end;

class function TParametrosCalculoPrecoCustoMargemMarkup.New: IParametrosCalculoPrecoCustoMargemMarkup;
begin
  Result := Self.Create;
end;

function TParametrosCalculoPrecoCustoMargemMarkup.PrecoDeVenda: Double;
begin
  Result := FPrecoDeVenda;
end;

function TParametrosCalculoPrecoCustoMargemMarkup.PrecoDeVenda(
  AValue: Double): IParametrosCalculoPrecoCustoMargemMarkup;
begin
  Result := Self;
  FPrecoDeVenda := AValue;
end;

{ TParametrosCalculoPrecoCustoRealVenda }

function TParametrosCalculoPrecoCustoRealVenda.AliquotaDoDifal(
  AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FAliquotaDoDifal := AValue;
end;

function TParametrosCalculoPrecoCustoRealVenda.AliquotaDoDifal: Double;
begin
  Result := FAliquotaDoDifal;
end;

function TParametrosCalculoPrecoCustoRealVenda.AliquotaDoFcp: Double;
begin
  Result := FAliquotaDoFcp;
end;

function TParametrosCalculoPrecoCustoRealVenda.AliquotaDoFcp(
  AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FAliquotaDoFcp := AValue;
end;

function TParametrosCalculoPrecoCustoRealVenda.DespesasOperacionais(
  AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FDespesasOperacionais := AValue;
end;

function TParametrosCalculoPrecoCustoRealVenda.DespesasOperacionais: Double;
begin
  Result := FDespesasOperacionais;
end;

function TParametrosCalculoPrecoCustoRealVenda.IcmsDeSaida: Double;
begin
  Result := FIcmsDeSaida;
end;

function TParametrosCalculoPrecoCustoRealVenda.IcmsDeSaida(
  AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FIcmsDeSaida := AValue;
end;

function TParametrosCalculoPrecoCustoRealVenda.ImpostosFederais(
  AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FImpostosFederais := AValue;
end;

function TParametrosCalculoPrecoCustoRealVenda.ImpostosFederais: Double;
begin
  Result := FImpostosFederais;
end;

class function TParametrosCalculoPrecoCustoRealVenda.New: IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self.Create;
end;

function TParametrosCalculoPrecoCustoRealVenda.OutrosValores: Double;
begin
  Result := FOutrosValores;
end;

function TParametrosCalculoPrecoCustoRealVenda.OutrosValores(
  AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FOutrosValores := AValue;
end;

function TParametrosCalculoPrecoCustoRealVenda.PrecoDeCusto: Double;
begin
  Result := FPrecoDeCusto;
end;

function TParametrosCalculoPrecoCustoRealVenda.PrecoDeCusto(
  AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FPrecoDeCusto := AValue;
end;

function TParametrosCalculoPrecoCustoRealVenda.PrecoDeVenda: Double;
begin
  Result := FPrecoDeVenda;
end;

function TParametrosCalculoPrecoCustoRealVenda.PrecoDeVenda(
  AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FPrecoDeVenda := AValue;
end;

function TParametrosCalculoPrecoCustoRealVenda.TaxaDeJuros: Double;
begin
  Result := FTaxaDeJuros;
end;

function TParametrosCalculoPrecoCustoRealVenda.TaxaDeJuros(
  AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FTaxaDeJuros := AValue;
end;

function TParametrosCalculoPrecoCustoRealVenda.ValorFrete: Double;
begin
  Result := FValorFrete;
end;

function TParametrosCalculoPrecoCustoRealVenda.ValorFrete(AValue: Double): IParametrosCalculoPrecoCustoRealVenda;
begin
  Result := Self;
  FValorFrete := AValue;
end;

{ TParametrosCalculoCustoReal }

function TParametrosCalculoCustoReal.DespesasOperacionais(
  AValue: Double): IParametrosCalculoCustoReal;
begin
  Result := Self;
  FDespesasOperacionais := AValue;
end;

function TParametrosCalculoCustoReal.DespesasOperacionais: Double;
begin
  Result := FDespesasOperacionais;
end;

function TParametrosCalculoCustoReal.IcmsDeSaida: Double;
begin
  Result := FIcmsDeSaida;
end;

function TParametrosCalculoCustoReal.IcmsDeSaida(
  AValue: Double): IParametrosCalculoCustoReal;
begin
  Result := Self;
  FIcmsDeSaida := AValue;
end;

function TParametrosCalculoCustoReal.ImpostosFederais(
  AValue: Double): IParametrosCalculoCustoReal;
begin
  Result := Self;
  FImpostosFederais := AValue;
end;

function TParametrosCalculoCustoReal.ImpostosFederais: Double;
begin
  Result := FImpostosFederais;
end;

class function TParametrosCalculoCustoReal.New: IParametrosCalculoCustoReal;
begin
  Result := Self.Create;
end;

function TParametrosCalculoCustoReal.OutrosValores: Double;
begin
  Result := FOutrosValores;
end;

function TParametrosCalculoCustoReal.OutrosValores(
  AValue: Double): IParametrosCalculoCustoReal;
begin
  Result := Self;
  FOutrosValores := AValue;
end;

function TParametrosCalculoCustoReal.PrecoDeCusto: Double;
begin
  Result := FPrecoDeCusto;
end;

function TParametrosCalculoCustoReal.PrecoDeCusto(
  AValue: Double): IParametrosCalculoCustoReal;
begin
  Result := Self;
  FPrecoDeCusto := AValue;
end;

{ TParametrosServicoPrecoCusto }

function TParametrosServicoPrecoCusto.AcrescimoFinal: Double;
begin
  Result := FAcrescimoFinal;
end;

function TParametrosServicoPrecoCusto.AcrescimoFinal(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FAcrescimoFinal := AValue;
end;

function TParametrosServicoPrecoCusto.CalculandoTintaDeMaquina: Boolean;
begin
  Result := FCalculandoTintaDeMaquina;
end;

function TParametrosServicoPrecoCusto.CalculandoTintaDeMaquina(
  AValue: Boolean): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FCalculandoTintaDeMaquina := AValue;
end;

function TParametrosServicoPrecoCusto.Desconto01(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDesconto01 := AValue;
end;

function TParametrosServicoPrecoCusto.Desconto01: Double;
begin
  Result := FDesconto01;
end;

function TParametrosServicoPrecoCusto.Desconto02: Double;
begin
  Result := FDesconto02;
end;

function TParametrosServicoPrecoCusto.Desconto02(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDesconto02 := AValue;
end;

function TParametrosServicoPrecoCusto.Desconto03: Double;
begin
  Result := FDesconto03;
end;

function TParametrosServicoPrecoCusto.Desconto03(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDesconto03 := AValue;
end;

function TParametrosServicoPrecoCusto.Desconto04: Double;
begin
  Result := FDesconto04;
end;

function TParametrosServicoPrecoCusto.Desconto04(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDesconto04 := AValue;
end;

function TParametrosServicoPrecoCusto.Desconto05: Double;
begin
  Result := FDesconto05;
end;

function TParametrosServicoPrecoCusto.Desconto05(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDesconto05 := AValue;
end;

function TParametrosServicoPrecoCusto.Desconto06(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDesconto06 := AValue;
end;

function TParametrosServicoPrecoCusto.Desconto06: Double;
begin
  Result := FDesconto06;
end;

function TParametrosServicoPrecoCusto.Desconto07(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDesconto07 := AValue;
end;

function TParametrosServicoPrecoCusto.DescontoDeIcms: Double;
begin
  Result := FDescontoDeIcms;
end;

function TParametrosServicoPrecoCusto.DescontoDeIcms(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDescontoDeIcms := AValue;
end;

function TParametrosServicoPrecoCusto.DescontoPISCOFINS(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDescontoPISCOFINS := AValue;
end;

function TParametrosServicoPrecoCusto.DescontoPISCOFINS: Double;
begin
  Result := FDescontoPISCOFINS;
end;

function TParametrosServicoPrecoCusto.Desconto07: Double;
begin
  Result := FDesconto07;
end;

function TParametrosServicoPrecoCusto.DescontosAdicionais(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FDescontosAdicionais := AValue;
end;

function TParametrosServicoPrecoCusto.FatorRegional: Double;
begin
  Result := FFatorRegional;
end;

function TParametrosServicoPrecoCusto.FatorRegional(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FFatorRegional := AValue;
end;

function TParametrosServicoPrecoCusto.DescontosAdicionais: Double;
begin
  Result := FDescontosAdicionais;
end;

function TParametrosServicoPrecoCusto.IcmsDeEntrada(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FIcmsDeEntrada := AValue;
end;

function TParametrosServicoPrecoCusto.IcmsDeEntrada: Double;
begin
  Result := FIcmsDeEntrada;
end;

function TParametrosServicoPrecoCusto.ImpostoFederal: Double;
begin
  Result := FImpostoFederal;
end;

function TParametrosServicoPrecoCusto.ImpostoFederal(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FImpostoFederal := AValue;
end;

function TParametrosServicoPrecoCusto.IpiDeEntrada(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FIpiDeEntrada := AValue;
end;

class function TParametrosServicoPrecoCusto.New: IParametrosServicoPrecoCusto;
begin
  Result := Self.Create;
end;

function TParametrosServicoPrecoCusto.IpiDeEntrada: Double;
begin
  Result := FIpiDeEntrada;
end;

function TParametrosServicoPrecoCusto.PercentualFreteDeEntrada(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FPercentualFreteDeEntrada := AValue;
end;

function TParametrosServicoPrecoCusto.PercentualFreteDeEntrada: Double;
begin
  Result := FPercentualFreteDeEntrada;
end;

function TParametrosServicoPrecoCusto.PrecoDeCompra(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FPrecoDeCompra := AValue;
end;

function TParametrosServicoPrecoCusto.Predol: Boolean;
begin
  Result := FPredol;
end;

function TParametrosServicoPrecoCusto.Predol(
  AValue: Boolean): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FPredol := AValue;
end;

function TParametrosServicoPrecoCusto.PrecoDeCompra: Double;
begin
  Result := FPrecoDeCompra;
end;

function TParametrosServicoPrecoCusto.SubstituicaoTributaria(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FSubstituicaoTributaria := AValue;
end;

function TParametrosServicoPrecoCusto.TipoMoeda: TTipoMoeda;
begin
  Result := FTipoMoeda;
end;

function TParametrosServicoPrecoCusto.TaxaDeControleDeIncentivosFiscaisSuframa: Double;
begin
  Result := FTaxaDeControleDeIncentivosFiscaisSuframa;
end;

function TParametrosServicoPrecoCusto.TaxaDeControleDeIncentivosFiscaisSuframa(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FTaxaDeControleDeIncentivosFiscaisSuframa := AValue;
end;

function TParametrosServicoPrecoCusto.TaxaDeServicoSuframa(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FTaxaDeServicoSuframa:= AValue;
end;

function TParametrosServicoPrecoCusto.TaxaDeServicoSuframa: Double;
begin
  Result := FTaxaDeServicoSuframa;
end;

function TParametrosServicoPrecoCusto.TipoMoeda(
  AValue: TTipoMoeda): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FTipoMoeda := AValue;
end;

function TParametrosServicoPrecoCusto.SubstituicaoTributaria: Double;
begin
  Result := FSubstituicaoTributaria;
end;

function TParametrosServicoPrecoCusto.ValorDoFrete(
  AValue: Double): IParametrosServicoPrecoCusto;
begin
  Result := Self;
  FValorDoFrete := AValue;
end;

function TParametrosServicoPrecoCusto.ValorDoFrete: Double;
begin
  Result := FValorDoFrete;
end;

{ TParametrosServicoPrecoCustoMargemMarkup }

function TParametrosServicoPrecoCustoMargemMarkup.Margem: Double;
begin
  Result := FMargem;
end;

function TParametrosServicoPrecoCustoMargemMarkup.DecUni: Integer;
begin
  Result := FDecUni ;
end;

function TParametrosServicoPrecoCustoMargemMarkup.DecUni(
  AValue: Integer): IParametrosServicoPrecoCustoMargemMarkup;
begin
  Result := Self;
  FDecUni := AValue ;
end;

function TParametrosServicoPrecoCustoMargemMarkup.Margem(
  AValue: Double): IParametrosServicoPrecoCustoMargemMarkup;
begin
  Result := Self;
  FMargem := AValue;
end;

class function TParametrosServicoPrecoCustoMargemMarkup.New: IParametrosServicoPrecoCustoMargemMarkup;
begin
  Result := Self.Create;
end;

function TParametrosServicoPrecoCustoMargemMarkup.PrecoDeVenda: Double;
begin
  Result := FPrecoDeVenda;
end;

function TParametrosServicoPrecoCustoMargemMarkup.PrecoDeVenda(
  AValue: Double): IParametrosServicoPrecoCustoMargemMarkup;
begin
  Result := Self;
  FPrecoDeVenda := AValue;
end;

end.
