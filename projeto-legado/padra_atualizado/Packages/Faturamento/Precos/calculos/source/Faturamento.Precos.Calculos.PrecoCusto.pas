unit Faturamento.Precos.Calculos.PrecoCusto;

interface

uses Faturamento.Precos.Interfaces.PrecoCusto,
     Faturamento.Precos.Tipos.PrecoCusto,
     System.SysUtils,
     Shared.Functions.Core,
     Shared.Functions.FormulaPrecoCusto,
     Shared.Functions.Interfaces,
     Shared.Functions.Tipos,
     Shared.Functions.Configuracoes;


type
  TCalculoPrecosPrecoCusto = class(TInterfacedObject, ICalculoPrecosPrecoCusto)
  private
    FQuantidadeCasasDecimais : Integer;
    FValorCalculoInicio : Double;
    FAliquota1 : Double;
    FAliquota2 : Double;
    FAliquota3 : Double;
    FAliquota4 : Double;
    FAliquota5 : Double;
    FAliquota6 : Double;

    function RetornarValorCalculoOperacaoComposicaoPrecoCusto(Const AParametros: IParametrosCalculoPrecoCusto; Const AValor : double) : Double;
    function RetonarValorCalculoPrecoCustoInicial(Const AParametros: IParametrosCalculoPrecoCusto) : Double;
    function RetonarValorCalculoPrecoCustoOpcao_01(Const AParametros: IParametrosCalculoPrecoCusto) : Double;
    function RetonarValorCalculoPrecoCustoOpcao_02(Const AParametros: IParametrosCalculoPrecoCusto) : Double;
    function RetonarValorCalculoPrecoCustoOpcao_03(Const AParametros: IParametrosCalculoPrecoCusto) : Double;
    function RetonarValorCalculoPrecoCustoOpcao_04(Const AParametros: IParametrosCalculoPrecoCusto) : Double;
    function RetonarValorCalculoPrecoCustoOpcao_Boleto(Const AResult : Double; Const AParametros: IParametrosCalculoPrecoCusto) : Double;

    function FormatarValorPrecoCusto(Const AValor : Double) : Double;

    function RetornarValorPrecoVendaMkp(Const AParametros: IParametrosCalculoPrecoCustoMargemMarkup) :IResultadoCalculoPrecoCusto;
    function RetornarValorPrecoMargemMarkup(Const AParametros: IParametrosCalculoPrecoCustoMargemMarkup) :IResultadoCalculoPrecoCusto;
    function ExecutarCalculo4(const AParametros: IParametrosCalculoPrecoCusto): Boolean;
    function FormatarRetornoCalculo4TintaDeMaquina(const AParametros: IParametrosCalculoPrecoCusto): Boolean;
  public
    function CalculaPrecoCusto(const AParametros: IParametrosCalculoPrecoCusto): IResultadoCalculoPrecoCusto; overload;
    function CalculaPrecoCusto(const AParametros: IParametrosCalculoPrecoCustoMargemMarkup): IResultadoCalculoPrecoCusto; overload;
    function CalculaPrecoCustoRealVenda(const AParametros: IParametrosCalculoPrecoCustoRealVenda): IResultadoCalculoPrecoCusto;
    function CalculaCustoReal(const AParametros: IParametrosCalculoCustoReal): IResultadoCalculoPrecoCusto;

    class function New(): ICalculoPrecosPrecoCusto;
  end;

implementation

{ TCalculoPrecosPrecoCusto }

function TCalculoPrecosPrecoCusto.CalculaPrecoCusto(
  const AParametros: IParametrosCalculoPrecoCusto): IResultadoCalculoPrecoCusto;
begin
  FValorCalculoInicio := RetonarValorCalculoPrecoCustoInicial(AParametros);

  FQuantidadeCasasDecimais := AParametros.QuantidadeCasasDecimais;

  If (AParametros.FormulaParaCalculo = '1') Then
  begin
    Result :=
      TResultadoCalculoPrecoCusto.New
        .ValorCalculadoPrecoCusto(RetonarValorCalculoPrecoCustoOpcao_01(AParametros));

    Exit;
  end;

  If (AParametros.FormulaParaCalculo = '2') Then
  begin
    Result :=
      TResultadoCalculoPrecoCusto.New
        .ValorCalculadoPrecoCusto(RetonarValorCalculoPrecoCustoOpcao_02(AParametros));

    Exit;
  end;

  If (AParametros.FormulaParaCalculo = '3') Then
  begin
    Result :=
      TResultadoCalculoPrecoCusto.New
        .ValorCalculadoPrecoCusto(RetonarValorCalculoPrecoCustoOpcao_03(AParametros));

    Exit;
  end;

  If ExecutarCalculo4(AParametros) Then
  begin
    Result :=
      TResultadoCalculoPrecoCusto.New
        .ValorCalculadoPrecoCusto(RetonarValorCalculoPrecoCustoOpcao_04(AParametros));

    Exit;
  end;

  If (FormatarRetornoCalculo4TintaDeMaquina(AParametros)) Then
  Begin
    Result :=
      TResultadoCalculoPrecoCusto.New
        .ValorCalculadoPrecoCusto(FormatarValorPrecoCusto(FValorCalculoInicio));
  End;
end;

function TCalculoPrecosPrecoCusto.CalculaCustoReal(
  const AParametros: IParametrosCalculoCustoReal): IResultadoCalculoPrecoCusto;
var
  LPrecoDeCustoCalculado: Double;
  LImpostosCalculado: Double;
  LResultado: Double;
  LImpostosFederais: Double;
begin
  LImpostosFederais :=  AParametros.ImpostosFederais;
  If objConfiguracoes.fGetValorConfiguracao(CFG_DEDUZIR_ICMS_DO_PIS_COFINS_NA_PRECIFICAO, varString) = 'S' Then
    If objConfiguracoes.fGetValorConfiguracao(CFG_DEDUZIR_ICMS_PRODUTO_TRIBUTADO_DA_BASE_DE_CALCULO_DO_DEBITO, varString) = 'S' Then
      LImpostosFederais := (AParametros.ImpostosFederais * (1 - (AParametros.IcmsDeSaida/100)));

  LImpostosCalculado     := (1 - (AParametros.IcmsDeSaida + LImpostosFederais + AParametros.DespesasOperacionais) / 100);
  LPrecoDeCustoCalculado := AParametros.PrecoDeCusto + AParametros.OutrosValores;
  LResultado := (LPrecoDeCustoCalculado / LImpostosCalculado);

  Result :=
    TResultadoCalculoPrecoCusto.New()
      .ValorCalculadoPrecoCusto(LResultado);
end;



function TCalculoPrecosPrecoCusto.CalculaPrecoCusto(
  const AParametros: IParametrosCalculoPrecoCustoMargemMarkup): IResultadoCalculoPrecoCusto;
begin
  If Pos(AParametros.MargemMarkup, '1_5_') > 0 Then
  begin
    Result := RetornarValorPrecoMargemMarkup(AParametros);
    Exit;
  end;

  Result := RetornarValorPrecoVendaMkp(AParametros);
end;

function TCalculoPrecosPrecoCusto.CalculaPrecoCustoRealVenda(
  const AParametros: IParametrosCalculoPrecoCustoRealVenda): IResultadoCalculoPrecoCusto;
Var
  LResultado : Double;
begin
  LResultado :=
    AParametros.PrecoDeCusto * (1 + AParametros.TaxaDeJuros /100) + AParametros.OutrosValores +
                               ( AParametros.IcmsDeSaida          * (AParametros.PrecoDeVenda + AParametros.ValorFrete) / 100) +
                               ( AParametros.ImpostosFederais     * (AParametros.PrecoDeVenda + AParametros.ValorFrete) / 100) +
                               ( AParametros.DespesasOperacionais * (AParametros.PrecoDeVenda + AParametros.ValorFrete) / 100) +
                               ( AParametros.AliquotaDoDifal      * (AParametros.PrecoDeVenda + AParametros.ValorFrete) / 100) +
                               ( AParametros.AliquotaDoFcp        * (AParametros.PrecoDeVenda + AParametros.ValorFrete) / 100);

  Result :=
    TResultadoCalculoPrecoCusto.New
      .ValorCalculadoPrecoCusto(LResultado);
end;

function TCalculoPrecosPrecoCusto.ExecutarCalculo4(
  const AParametros: IParametrosCalculoPrecoCusto): Boolean;
begin
  Result := False;

  If (AParametros.FormulaParaCalculo <> '4') Then
    Exit;

  If (AParametros.CalculandoTintaDeMaquina) Then
    Exit;

  Result := True;
end;

function TCalculoPrecosPrecoCusto.FormatarRetornoCalculo4TintaDeMaquina(
  const AParametros: IParametrosCalculoPrecoCusto): Boolean;
begin
  Result := False;

  If (AParametros.FormulaParaCalculo <> '4') Then
    Exit;

  If (Not AParametros.CalculandoTintaDeMaquina) Then
    Exit;

  Result := True;
end;

function TCalculoPrecosPrecoCusto.FormatarValorPrecoCusto(
  const AValor: Double): Double;
begin
 Result := ObjCore.fStrToFloat( FormatFloat(ObjCore.fMskDigitos(FQuantidadeCasasDecimais), AValor));
end;

class function TCalculoPrecosPrecoCusto.New: ICalculoPrecosPrecoCusto;
begin
  Result := Self.Create;
end;

function TCalculoPrecosPrecoCusto.RetonarValorCalculoPrecoCustoInicial(
  Const AParametros: IParametrosCalculoPrecoCusto): Double;
begin
  Result := AParametros.PrecoDeCompra;

  Result := Result - ( Result * ( AParametros.Desconto01 / 100 ) );
  Result := Result - ( Result * ( AParametros.Desconto02 / 100 ) );
  Result := Result - ( Result * ( AParametros.Desconto03 / 100 ) );
  Result := Result - ( Result * ( AParametros.Desconto04 / 100 ) );
  Result := Result - ( Result * ( AParametros.Desconto05 / 100 ) );
  Result := Result - ( Result * ( AParametros.Desconto06 / 100 ) );
  Result := Result - ( Result * ( AParametros.Desconto07 / 100 ) );
end;

function TCalculoPrecosPrecoCusto.RetonarValorCalculoPrecoCustoOpcao_01(
  const AParametros: IParametrosCalculoPrecoCusto): Double;
begin
  Result := FValorCalculoInicio;

  Result   := Result + ( Result * ( AParametros.IpiDeEntrada  / 100 ) );
  Result   := Result + ( Result * ( AParametros.SubstituicaoTributaria  / 100 ) );

  FAliquota1 := ( Result * ( AParametros.IcmsDeEntrada  / 100 ) );
  FAliquota3 := ( Result * ( AParametros.PercentualFreteDeEntrada/ 100 ) );
  FAliquota4 := ( Result * ( AParametros.AcrescimoFinal / 100 ) );
  FAliquota6 := ( Result * ( AParametros.ImpostoFederal / 100 ) );

  Result :=  Result - FAliquota1 + FAliquota3 + FAliquota4 - FAliquota6;

  Result := RetonarValorCalculoPrecoCustoOpcao_Boleto(Result, AParametros);

end;

function TCalculoPrecosPrecoCusto.RetonarValorCalculoPrecoCustoOpcao_02(
  const AParametros: IParametrosCalculoPrecoCusto): Double;
Var
  LTotalFrete : Double;
begin
  Result := FValorCalculoInicio;

  FAliquota1  := ( Result * ( AParametros.IpiDeEntrada  / 100 ) );
  FAliquota2  := ( Result * ( AParametros.SubstituicaoTributaria  / 100 ) );

  LTotalFrete := Result + FAliquota1 + FAliquota2;
  FAliquota3  := LTotalFrete * ( AParametros.PercentualFreteDeEntrada / 100 );

  FAliquota4 := ( Result * ( AParametros.IcmsDeEntrada/ 100 ) );
  FAliquota6 := ( Result * ( AParametros.ImpostoFederal/ 100 ) );

  FAliquota5 := ( (Result + FAliquota1 + FAliquota2) * ( AParametros.AcrescimoFinal / 100 ) );

  Result    := Result + FAliquota1 + FAliquota2 + FAliquota3 - FAliquota4 + FAliquota5 - FAliquota6;

  Result := RetonarValorCalculoPrecoCustoOpcao_Boleto(Result, AParametros);
end;

function TCalculoPrecosPrecoCusto.RetonarValorCalculoPrecoCustoOpcao_03(
  const AParametros: IParametrosCalculoPrecoCusto): Double;
Var
  LICMSEntrada    : Double;
  LIPIEntrada     : Double;
  LFrete          : Double;
  LAcrescimoFinal : Double;
  LImpostoFederal : Double;
  LSubstituicao   : Double;
begin
  Result := FValorCalculoInicio;

  LICMSEntrada    := ( Result * ( AParametros.IcmsDeEntrada  / 100));
  LIPIEntrada     := ( Result * ( AParametros.IpiDeEntrada   / 100));
  LFrete          := ( Result * ( AParametros.PercentualFreteDeEntrada   / 100));
  LAcrescimoFinal := ( Result * ( AParametros.AcrescimoFinal / 100));
  LImpostoFederal := ( Result * ( AParametros.ImpostoFederal / 100));

  LSubstituicao  := (((Result + LIPIEntrada +  LFrete ) * AParametros.SubstituicaoTributaria) / 100 );
  Result         := Result - LICMSEntrada + LFrete + LSubstituicao + LIPIEntrada + LAcrescimoFinal - LImpostoFederal;

  Result := RetonarValorCalculoPrecoCustoOpcao_Boleto(Result, AParametros);

end;

function TCalculoPrecosPrecoCusto.RetonarValorCalculoPrecoCustoOpcao_04(
  const AParametros: IParametrosCalculoPrecoCusto): Double;
Var
  LParametros : IParametrosFormulaPrecoCustoSetarValores;
begin
  LParametros :=
    TParametrosFormulaPrecoCustoSetarValores.New
      .PrecoDeCompraLiquido(FValorCalculoInicio)
      .IcmEntrada(AParametros.IcmsDeEntrada)
      .ImpostosFederaisEntrada(AParametros.ImpostoFederal)
      .IpiEntrada(AParametros.IpiDeEntrada)
      .FreteEntrada(AParametros.PercentualFreteDeEntrada)
      .ValorFrete(AParametros.ValorDoFrete)
      .AcrescimoFinal(AParametros.AcrescimoFinal)
      .Substituicao(AParametros.SubstituicaoTributaria)
      .DescontoAdicionalBoleto(AParametros.DescontosAdicionais)
      .OutrosValores(0)
      .IcmSaida(0)
      .ImpostosFederaisSaida(0)
      .DespesaOperacional(0)
      .TaxaDeControleDeIncentivosFiscaisSuframa(AParametros.TaxaDeControleDeIncentivosFiscaisSuframa)
      .TaxaDeServicoSuframa(AParametros.TaxaDeServicoSuframa)
      .DescontoPisCofins(AParametros.DescontoPisCofins)
      .DescontoICMS(AParametros.DescontoDeIcms)
      .FatorRegional(AParametros.FatorRegional);

  Result := FormatarValorPrecoCusto(ObjFormulaPrecoCusto.RetonarValorCalculoPrecoCustoOpcao_04(LParametros));
end;

function TCalculoPrecosPrecoCusto.RetonarValorCalculoPrecoCustoOpcao_Boleto(
  Const AResult : Double;
  const AParametros: IParametrosCalculoPrecoCusto): Double;
Var
  LValor : Double;
begin
  LValor := AResult + AParametros.ValorDoFrete;

  Result := RetornarValorCalculoOperacaoComposicaoPrecoCusto(AParametros, LValor);

  Result := FormatarValorPrecoCusto(Result);
end;

function TCalculoPrecosPrecoCusto.RetornarValorCalculoOperacaoComposicaoPrecoCusto(
  const AParametros: IParametrosCalculoPrecoCusto;
  Const AValor : double): Double;
begin

  If AParametros.OperadorAdicaoDescontosAdicionais Then
  begin
    Result := AValor + ( AValor * ( AParametros.DescontosAdicionais / 100)) ;
    Exit;
  end;

  Result := AValor - ( AValor * ( AParametros.DescontosAdicionais / 100 ));
end;

function TCalculoPrecosPrecoCusto.RetornarValorPrecoMargemMarkup(
  const AParametros: IParametrosCalculoPrecoCustoMargemMarkup): IResultadoCalculoPrecoCusto;
Var
  LResultado : Double;
begin
  LResultado := AParametros.PrecoDeVenda * ((100.0 - AParametros.Margem ) / 100.0);
  LResultado := objCore.fFormataFloat(LResultado, AParametros.DecUni);

  Result :=
    TResultadoCalculoPrecoCusto.New
      .ValorCalculadoPrecoCusto(LResultado);

end;

function TCalculoPrecosPrecoCusto.RetornarValorPrecoVendaMkp(
  const AParametros: IParametrosCalculoPrecoCustoMargemMarkup): IResultadoCalculoPrecoCusto;
Var
  LResultado : Double;
begin
  LResultado := AParametros.PrecoDeVenda / (1.0 + (AParametros.Margem/ 100.0));
  LResultado := objCore.fFormataFloat(LResultado, AParametros.DecUni);

  Result :=
    TResultadoCalculoPrecoCusto.New
      .ValorCalculadoPrecoCusto(LResultado);
end;

end.
