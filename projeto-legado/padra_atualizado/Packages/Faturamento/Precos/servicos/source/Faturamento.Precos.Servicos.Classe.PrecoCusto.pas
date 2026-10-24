unit Faturamento.Precos.Servicos.Classe.PrecoCusto;

interface

uses System.SysUtils,
     Faturamento.Precos.Interfaces.Servicos.Classe.PrecoCusto,
     Faturamento.Precos.Interfaces.PrecoCusto,
     Faturamento.Precos.Tipos.PrecoCusto,
     Shared.Functions.Configuracoes,
     Shared.Functions.Types,
     Shared.Functions.FormulaPrecoCusto,
     Faturamento.Precos.Servicos.Funcoes,
     Faturamento.Precos.Calculos.PrecoCusto;


type
  TFaturamentoPrecosServicosClassePrecoCusto = class(TInterfacedObject, IFaturamentoPrecosServicosClassePrecoCusto)
  private
    FPrecoCompra   : Double;
    FCasasDecimais : Integer;

    FOperacaoComposicaoPrecoCusto : String;
    FFormulaParaCalculoPrecoCusto : String;

    procedure SetarConfiguracoesCalculaPrecoCusto;

    function RetonarParametrosCalculoPrecoCusto(const AParametros: IParametrosServicoPrecoCusto):IParametrosCalculoPrecoCusto;

    function RetornarResultadoServicosClassePrecoCusto(const AParametros: IParametrosCalculoPrecoCusto) : IResultadoServicosClassePrecoCusto;

  public
    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto; overload;

    function CalculaPrecoCustoConversorMoeda(const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto;

    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCustoMargemMarkup): IResultadoServicosClassePrecoCusto; overload;

    function CalculaPrecoCustoRealVenda(const AParametros: IParametrosCalculoPrecoCustoRealVenda): IResultadoServicosClassePrecoCusto;

    function CalculaCustoReal(const AParametros: IParametrosCalculoCustoReal): IResultadoServicosClassePrecoCusto;

    class function New(): IFaturamentoPrecosServicosClassePrecoCusto;
  end;

implementation

{ TFaturamentoPrecosServicosClassePrecoCusto }

function TFaturamentoPrecosServicosClassePrecoCusto.CalculaPrecoCusto(
  const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto;
begin
  SetarConfiguracoesCalculaPrecoCusto;

  FPrecoCompra := AParametros.PrecoDeCompra;

  Result :=
    RetornarResultadoServicosClassePrecoCusto(
      RetonarParametrosCalculoPrecoCusto(AParametros));
end;

function TFaturamentoPrecosServicosClassePrecoCusto.CalculaCustoReal(
  const AParametros: IParametrosCalculoCustoReal): IResultadoServicosClassePrecoCusto;
var
  LResultadoCustoReal: IResultadoCalculoPrecoCusto;
begin
  LResultadoCustoReal :=
    TCalculoPrecosPrecoCusto.New()
      .CalculaCustoReal(AParametros);

  Result :=
    TResultadoServicosClassePrecoCusto.New()
      .ResultadoCalculoPrecoCusto(LResultadoCustoReal)
      .ParametrosCalculoCustoReal(AParametros);
end;

function TFaturamentoPrecosServicosClassePrecoCusto.CalculaPrecoCusto(
  const AParametros: IParametrosServicoPrecoCustoMargemMarkup): IResultadoServicosClassePrecoCusto;
Var
  LResultadoCustoMargem     : IResultadoCalculoPrecoCusto;
  LParametros               : IParametrosCalculoPrecoCustoMargemMarkup;
  LConfiguracaoMargemMarkup : String;
begin
  LConfiguracaoMargemMarkup :=
    objConfiguracoes.fGetValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, varString);

  LParametros :=
    TParametrosCalculoPrecoCustoMargemMarkup.New
      .PrecoDeVenda(AParametros.PrecoDeVenda)
      .Margem(AParametros.Margem)
      .DecUni(AParametros.DecUni)
      .MargemMarkup(LConfiguracaoMargemMarkup);

  LResultadoCustoMargem :=
    TCalculoPrecosPrecoCusto.New()
      .CalculaPrecoCusto(LParametros);

  Result :=
    TResultadoServicosClassePrecoCusto.New
      .ParametrosCalculoPrecoCustoMargemMarkup(LParametros)
      .ResultadoCalculoPrecoCusto(LResultadoCustoMargem);
end;

function TFaturamentoPrecosServicosClassePrecoCusto.CalculaPrecoCustoConversorMoeda(
  const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto;
begin

  SetarConfiguracoesCalculaPrecoCusto;

  FPrecoCompra :=
    TFaturamentoPrecosServicosFuncoes.
      ConvertePrecos(AParametros.PrecoDeCompra, AParametros.TipoMoeda, FCasasDecimais);

  Result :=
    RetornarResultadoServicosClassePrecoCusto(
      RetonarParametrosCalculoPrecoCusto(AParametros));

end;

function TFaturamentoPrecosServicosClassePrecoCusto.CalculaPrecoCustoRealVenda(
  const AParametros: IParametrosCalculoPrecoCustoRealVenda): IResultadoServicosClassePrecoCusto;
Var
  LResutladoCustoRealVenda: IResultadoCalculoPrecoCusto;
begin
  LResutladoCustoRealVenda :=
    TCalculoPrecosPrecoCusto.New()
      .CalculaPrecoCustoRealVenda(AParametros);

  Result :=
    TResultadoServicosClassePrecoCusto.New
      .ParametrosCalculoPrecoCustoRealVenda(AParametros)
      .ResultadoCalculoPrecoCusto(LResutladoCustoRealVenda);
end;

class function TFaturamentoPrecosServicosClassePrecoCusto.New: IFaturamentoPrecosServicosClassePrecoCusto;
begin
  Result := Self.Create;
end;

function TFaturamentoPrecosServicosClassePrecoCusto.RetonarParametrosCalculoPrecoCusto(
  const AParametros: IParametrosServicoPrecoCusto): IParametrosCalculoPrecoCusto;
begin
  Result :=
    TParametrosCalculoPrecoCusto.New
      .PrecoDeCompra(FPrecoCompra)
      .Desconto01(AParametros.Desconto01)
      .Desconto02(AParametros.Desconto02)
      .Desconto03(AParametros.Desconto03)
      .Desconto04(AParametros.Desconto04)
      .Desconto05(AParametros.Desconto05)
      .Desconto06(AParametros.Desconto06)
      .Desconto07(AParametros.Desconto07)
      .IcmsDeEntrada(AParametros.IcmsDeEntrada)
      .ImpostoFederal(AParametros.ImpostoFederal)
      .IpiDeEntrada(AParametros.IpiDeEntrada)
      .PercentualFreteDeEntrada(AParametros.PercentualFreteDeEntrada)
      .ValorDoFrete(AParametros.ValorDoFrete)
      .AcrescimoFinal(AParametros.AcrescimoFinal)
      .SubstituicaoTributaria(AParametros.SubstituicaoTributaria)
      .DescontosAdicionais(AParametros.DescontosAdicionais)
      .OperadorAdicaoDescontosAdicionais(SameText(FOperacaoComposicaoPrecoCusto, '+'))
      .FormulaParaCalculo(FFormulaParaCalculoPrecoCusto)
      .QuantidadeCasasDecimais(FCasasDecimais)
      .TaxaDeControleDeIncentivosFiscaisSuframa(AParametros.TaxaDeControleDeIncentivosFiscaisSuframa)
      .TaxaDeServicoSuframa(AParametros.TaxaDeServicoSuframa)
      .DescontoPISCOFINS(AParametros.DescontoPISCOFINS)
      .DescontoDeIcms(AParametros.DescontoDeIcms)
      .FatorRegional(AParametros.FatorRegional)
      .CalculandoTintaDeMaquina(AParametros.CalculandoTintaDeMaquina);
end;

function TFaturamentoPrecosServicosClassePrecoCusto.RetornarResultadoServicosClassePrecoCusto(
  const AParametros: IParametrosCalculoPrecoCusto): IResultadoServicosClassePrecoCusto;
begin
  Result :=
    TResultadoServicosClassePrecoCusto.New()
      .ParametrosCalculoPrecoCusto(AParametros)
      .ResultadoCalculoPrecoCusto(TCalculoPrecosPrecoCusto.New()
                                   .CalculaPrecoCusto(AParametros));
end;

procedure TFaturamentoPrecosServicosClassePrecoCusto.SetarConfiguracoesCalculaPrecoCusto;
begin
  FOperacaoComposicaoPrecoCusto := objConfiguracoes.fGetValorConfiguracao(CFG_OPERACAO_COMPOSICAO_PRECO_PRODUTO, varString);
  FFormulaParaCalculoPrecoCusto := objConfiguracoes.fGetValorConfiguracao(CFG_FORMULA_PARA_CALCULO_PRECO_CUSTO, varString);
  FCasasDecimais := objConfiguracoes.fGetValorConfiguracao(CFG_QUANTIDADE_CASAS_DECIMAIS_VALOR_UNITARIO, varInteger);

end;

end.
