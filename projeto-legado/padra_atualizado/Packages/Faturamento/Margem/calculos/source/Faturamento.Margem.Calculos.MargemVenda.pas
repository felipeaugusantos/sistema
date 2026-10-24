unit Faturamento.Margem.Calculos.MargemVenda;

interface

uses Faturamento.Margem.Interfaces.MargemVenda,
     Faturamento.Margem.Tipos.MargemVenda,
     Shared.Functions.Core,
     Shared.Functions.Tipos,
     Shared.Functions.Interfaces,
     System.SysUtils,
     System.StrUtils,
     System.Math;

type
  TCalculoMargemMargemVenda = class(TInterfacedObject, ICalculoMargemMargemVenda)
  private
    FParametros      : IParametrosCalculoMargemVenda;
    FValorIcmsAux    : Double;
    FValorIcmsSTPVAux: Double;

    // FUNCÃO RETORNAR MARGEM CALCULADA
//    function ValorDoStZerado : Boolean;
//    function retornarValorDifal : Double;
//    function retornarValorFCP : Double;

    // MARKUP
//    function RetornarValorMarkup : Double;
    function RetornarValorMarkupSemDespesasOrperacionais : Double;
    function RetornarValorUnitarioCustoRealComMargemZeroItem: Double;
    function RetornarValorUnitarioMargemPrecoIdeal : Double;
    function RetornarValorUnitarioMarkupPrecoUltimaCompraComImpostos: Double;

    // MARGEM
    function RetornarValorUnitarioMargemPraticada : Double;
    function RetornarValorMargemSemDespesasOrperacionais: Double;
    function RetornarValorUnitarioMargemPrecoMedio: Double;
    function RetornarValorUnitarioMargemPrecoUltimaCompraComImpostos: Double;
    function RetornarValorUnitarioMargemProposta: Double; // NOME ?
    function RetornarValorUnitarioMargemPraticadaCustoReal: Double;
    function RetornarValorUnitarioMargemPropostaCustoReal: Double;

    // Validações
    procedure ZerarValorParaCalculoDeST;
//    function RetornouValorIteProNumMkp  : Boolean;
//    function ValorCalculadoIteProNumMkp : Double;
    function ValidarMarkupSobrePrecoDeVendaLiquido : Boolean;

    // ProNumMKP
    function ResultadoProNumMKP : Double;
    function RetornarProNumMkpInicial : Double;
    function RetornarValorUnitarioMarkupProposto   : Double;

    // PraNumMKPS
    function ResultadoPraNumMKP : Double;
    function RetornarValorUnitarioMarkupPraticado : Double;

    // PraNumMkpSDO
    function ResultadoPraNumMkpSDO: Double;
    function RetornarPraNumMkpSDO : Double;

    // MedNumMkp
    function ResultadoMedNumMkp : Double;
    function RetornarMedNumMkp  : Double;



  public
    function CalculaMargemVenda(const AParametros: IParametrosCalculoMargemVenda): IResultadoCalculoMargemVenda;

    class function New(): ICalculoMargemMargemVenda;
  end;

implementation

{ TCalculoMargemMargemVenda}


function TCalculoMargemMargemVenda.CalculaMargemVenda(
  const AParametros: IParametrosCalculoMargemVenda): IResultadoCalculoMargemVenda;
begin
  FParametros := AParametros;

  FValorIcmsSTPVAux := FParametros.ValorDoIcmsStParteDaVenda;

  FValorIcmsAux := FParametros.ValorDoIcms + FParametros.ValorDaAliquotaDiferencaPrecoDinamicoIcms;

  ZerarValorParaCalculoDeST;

  Result :=
    TResultadoCalculoMargemVenda.New
      .ValorUnitarioMargemPrecoIdeal(RetornarValorUnitarioMargemPrecoIdeal)
      .ValorUnitarioMargemMinima(FParametros.ValorUnitarioMargemMinima)
      .ValorUnitarioCustoRealComMargemZero(RetornarValorUnitarioCustoRealComMargemZeroItem)
      .ValorUnitarioMargemPraticadaCustoReal(FParametros.ValorUnitarioMargemPraticadaCustoReal)
      .ValorUnitarioMargemPropostaCustoReal(FParametros.ValorUnitarioMargemPropostaCustoReal)
      .ValorUnitarioMargemPropostaCusto(FParametros.ValorUnitarioMargemPropostaCusto)
      .ValorUnitarioMargemPraticadaCusto(FParametros.ValorUnitarioMargemPraticadaCusto)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(FParametros.ValorUnitarioMargemBrutaPraticadaPrecoMedio)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(FParametros.ValorUnitarioMargemLiquidaPraticadaPrecoMedio)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(FParametros.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(FParametros.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(FParametros.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(FParametros.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos)
      .ValorUnitarioMargemPraticada(RetornarValorUnitarioMargemPraticada)
      .ValorUnitarioMargemPraticadaSemDespesasOperacionais(RetornarValorMargemSemDespesasOrperacionais)
      .ValorUnitarioMargemPrecoMedio(RetornarValorUnitarioMargemPrecoMedio)
      .ValorUnitarioMargemPrecoUltimaCompraComImpostos(RetornarValorUnitarioMargemPrecoUltimaCompraComImpostos)
      .ValorUnitarioMargemProposta(RetornarValorUnitarioMargemProposta)
      .ValorUnitarioMarkupProposto(ResultadoProNumMKP)
      .ValorUnitarioMarkupPraticado(ResultadoPraNumMKP)
      .ValorUnitarioMarkupPraticadoSemDespesasOperacionais(ResultadoPraNumMkpSDO)
      .ValorUnitarioMarkupPrecoMedio(ResultadoMedNumMkp)
      .ValorUnitarioItemMargemPrecoMedio(FParametros.ValorUnitarioItemMargemPrecoMedio)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(FParametros.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos)
      .ValorUnitarioItemMargemProposta(FParametros.ValorUnitarioItemMargemProposta)
      .ValorUnitarioItemMargemPraticadaLucro(FParametros.ValorUnitarioItemMargemPraticadaLucro)
      .ValorUnitarioMarkupPrecoUltimaCompraComImpostos(RetornarValorUnitarioMarkupPrecoUltimaCompraComImpostos)
      .ValorMargemCat17(FParametros.ValorMargemCat17)
      .ValorUnitarioMargemPraticadaCustoRealBruta(FParametros.ValorUnitarioMargemPraticadaCustoRealBruta)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta(FParametros.ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta)
      .ValorMargemPraticadaCustoReal(FParametros.ValorMargemPraticadaCustoReal)
      .ValorMargemPropostaCustoReal(FParametros.ValorMargemPropostaCustoReal)
      .ValorUnitarioMargemPraticadaCustoRealFrete(RetornarValorUnitarioMargemPraticadaCustoReal)
      .ValorUnitarioMargemPropostaCustoRealFrete(RetornarValorUnitarioMargemPropostaCustoReal);
end;

class function TCalculoMargemMargemVenda.New: ICalculoMargemMargemVenda;
begin
  Result := Self.Create;
end;


function TCalculoMargemMargemVenda.RetornarMedNumMkp: Double;
begin
  result := FParametros.PrecoMedio;

  If FParametros.ValorCalculoImpostosAliquota = 0 Then
    Exit;

  result := FParametros.PrecoMedio / FParametros.ValorCalculoImpostosAliquota;
end;

function TCalculoMargemMargemVenda.RetornarPraNumMkpSDO: Double;
begin
  result := (FParametros.ValorDoCustoPraticado + FParametros.OutrosValores);

  If RetornarValorMarkupSemDespesasOrperacionais = 0 Then
    Exit;

  result := (FParametros.ValorDoCustoPraticado + FParametros.OutrosValores) / RetornarValorMarkupSemDespesasOrperacionais;
end;

function TCalculoMargemMargemVenda.RetornarProNumMkpInicial: Double;
begin
  Result := (1 - (( FParametros.ValorDoIcms + FParametros.ImpostosFederais + FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente + FParametros.ValorComissaoTabelaDeitens)/100));
end;

function TCalculoMargemMargemVenda.RetornarValorUnitarioMargemPraticada: Double;
begin
  Result :=
    FParametros.ValorUnitario * (1 - (( FParametros.ValorDoIcms + FParametros.ImpostosFederais +
    FParametros.ValorDoDifal + FParametros.ValorDoFCP +
    FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente +
    FParametros.ValorComissaoTabelaDeitens )/100)) - (FParametros.ValorDoCustoPraticado + FParametros.OutrosValores);
end;

function TCalculoMargemMargemVenda.RetornarValorUnitarioMargemPraticadaCustoReal: Double;
begin
  Result := FParametros.ValorUnitario - FParametros.ValorCustoRealFrete;
end;

function TCalculoMargemMargemVenda.RetornarValorUnitarioMargemPrecoUltimaCompraComImpostos: Double; // ITE_IMPNUM_MAR
begin
  Result :=
    FParametros.ValorUnitario *
    objCore.IIF(FParametros.ConsiderarMargemDePrecoUltimaCompraNoCalculo,( 1-(( FParametros.ValorDoIcms + FParametros.ImpostosFederais +
    FParametros.ValorDoDifal + FParametros.ValorDoFCP + FParametros.DespesasOperacionais +
    FParametros.DespesaOperacionalCliente + FParametros.ValorComissaoTabelaDeitens)/100)), 1) -
    (FParametros.ValorUltimaCompraImpostos + objCore.IIF(FParametros.ConsiderarMargemDePrecoUltimaCompraNoCalculo, FParametros.OutrosValores, 0));
end;

{function TCalculoMargemMargemVenda.retornarValorDifal: Double;
begin
  Result := 0;

  If  FParametros.UtilizarPrecoVendaDinamicoInfluenciadoPorImpostos Then
    Exit;

  Result := FParametros.ValorDoDifal;
end;
}

{function TCalculoMargemMargemVenda.retornarValorFCP: Double;
begin
  Result := 0;

  If FParametros.UtilizarPrecoVendaDinamicoInfluenciadoPorImpostos Then
    Exit;

  Result := FParametros.ValorDoFCP;

end;
}

function TCalculoMargemMargemVenda.RetornarValorUnitarioCustoRealComMargemZeroItem: Double;
begin
  Result := (FParametros.ValorCustoDoItem + FParametros.OutrosValores) / FParametros.ValorCalculoImpostosAliquota;
end;


function TCalculoMargemMargemVenda.RetornarValorUnitarioMargemPrecoIdeal: Double;
begin
  result := 0;

  If Not FParametros.CalcularPrecoIdeal Then
    Exit;

  result := FParametros.ValorPrecoIdeal * (1 - (( FParametros.AliquotaIcmsPrecoIdeal + FParametros.ImpostosFederais +
        FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente + FParametros.ValorComissaoTabelaDeitens)/100)) -
        (FParametros.ValorCustoDoItem + FParametros.OutrosValores);
end;

function TCalculoMargemMargemVenda.RetornarValorUnitarioMarkupPrecoUltimaCompraComImpostos: Double;
begin
  Result := FParametros.ValorUltimaCompraImpostos;

  If Not FParametros.ConsiderarMargemDePrecoUltimaCompraNoCalculo Then
    Exit;

  Result := FParametros.ValorUltimaCompraImpostos + FParametros.OutrosValores;

  If FParametros.ValorCalculoImpostosAliquota = 0 Then
    Exit;

  Result := (FParametros.ValorUltimaCompraImpostos + FParametros.OutrosValores) / FParametros.ValorCalculoImpostosAliquota;

end;

function TCalculoMargemMargemVenda.RetornarValorUnitarioMargemProposta: Double;
begin
  Result :=
    FParametros.ValorUnitarioOriginal * (1-((FParametros.ValorDoIcms + FParametros.ImpostosFederais +
    FParametros.ValorDoDifal +  FParametros.ValorDoFCP + FParametros.DespesasOperacionais +
    FParametros.DespesaOperacionalCliente + FParametros.ValorComissaoTabelaDeitens )/100)) -
    (FParametros.ValorCustoDoItem + FParametros.OutrosValoresValOri);
end;

function TCalculoMargemMargemVenda.RetornarValorUnitarioMargemPropostaCustoReal: Double;
begin
  Result := FParametros.ValorUnitarioOriginal - FParametros.ValorCustoRealFrete;
end;

function TCalculoMargemMargemVenda.RetornarValorUnitarioMargemPrecoMedio: Double;
  Var
    LOutrosValores : Double;
begin
  LOutrosValores := 0;

  If (FParametros.MargemMinimaLiquidaPorPrecoMedio) Then
    LOutrosValores := FParametros.OutrosValores;

  Result :=
    FParametros.ValorUnitario * (1 - ((FParametros.ValorDoIcms + FParametros.ImpostosFederais +
    FParametros.ValorDoDifal + FParametros.ValorDoFCP + FParametros.DespesasOperacionais +
    FParametros.DespesaOperacionalCliente + FParametros.ValorComissaoTabelaDeitens)/100)) - (FParametros.PrecoMedio + LOutrosValores);
end;

function TCalculoMargemMargemVenda.RetornarValorMargemSemDespesasOrperacionais: Double; // ITE_PRANUM_MAR_SDO
begin
  Result :=
    FParametros.ValorUnitario * (1 - ((FParametros.ValorDoIcms +
    FParametros.ImpostosFederais + FParametros.ValorDoDifal + FParametros.ValorDoFCP +
    FParametros.ValorComissaoTabelaDeitens)/100)) - (FParametros.ValorDoCustoPraticado + FParametros.OutrosValores);
end;
{
function TCalculoMargemMargemVenda.RetornarValorMarkup: Double;
begin
  Result := (1 - (( FParametros.ValorDoIcms +  FParametros.ImpostosFederais + FParametros.ValorDoDifal +
	  FParametros.ValorDoFCP + FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente +
    FParametros.ValorComissaoTabelaDeitens)/100));
end;     }

function TCalculoMargemMargemVenda.RetornarValorMarkupSemDespesasOrperacionais: Double;
begin
  Result := (1 - (( FParametros.ValorDoIcms + FParametros.ImpostosFederais + FParametros.DespesaOperacionalCliente)/100));
end;

function TCalculoMargemMargemVenda.RetornarValorUnitarioMarkupPraticado: Double;
begin
  result := (FParametros.ValorDoCustoPraticado + FParametros.OutrosValores);

  If FParametros.ValorCalculoImpostosAliquota= 0 Then
    Exit;

  result := (FParametros.ValorDoCustoPraticado + FParametros.OutrosValores) / FParametros.ValorCalculoImpostosAliquota;
end;

function TCalculoMargemMargemVenda.ResultadoMedNumMkp: Double;
begin
  If (ValidarMarkupSobrePrecoDeVendaLiquido) Then
  begin
    result :=
        FParametros.ValorUnitario  * (1 - ((FValorIcmsAux + FParametros.ImpostosFederais +
        FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente + FParametros.ValorComissaoTabelaDeitens )/100)) -
        (FValorIcmsSTPVAux);

    Exit;
  end;

  result := RetornarMedNumMkp;
end;

function TCalculoMargemMargemVenda.ResultadoPraNumMkpSDO: Double;   // ITE_PRANUM_MKP_SDO
begin
  If (ValidarMarkupSobrePrecoDeVendaLiquido) Then
  begin
    Result :=
        FParametros.ValorUnitario * (1 - ((FValorIcmsAux + FParametros.ImpostosFederais +
        FParametros.ValorComissaoTabelaDeitens)/100)) - (FValorIcmsSTPVAux);

    Exit;
  end;

  result := RetornarPraNumMkpSDO;
end;

function TCalculoMargemMargemVenda.ResultadoPraNumMKP: Double;
begin
  If (ValidarMarkupSobrePrecoDeVendaLiquido) Then
  Begin
    result :=
        FParametros.ValorUnitario * (1 - ((FValorIcmsAux +  FParametros.ImpostosFederais +
        FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente + FParametros.ValorComissaoTabelaDeitens)/100)) -
        (FValorIcmsSTPVAux);

    Exit;
  End;

  result := RetornarValorUnitarioMarkupPraticado;
end;

function TCalculoMargemMargemVenda.RetornarValorUnitarioMarkupProposto: Double;
begin
  Result := (FParametros.ValorCustoDoItem + FParametros.OutrosValores);

  If RetornarProNumMkpInicial = 0 Then
    Exit;

  Result := (FParametros.ValorCustoDoItem + FParametros.OutrosValores) / RetornarProNumMkpInicial;
end;

function TCalculoMargemMargemVenda.ResultadoProNumMKP: Double;
begin
  If (ValidarMarkupSobrePrecoDeVendaLiquido) Then
  Begin
    result :=
        FParametros.ValorUnitarioOriginal * (1 - ((FValorIcmsAux + FParametros.ImpostosFederais +
        FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente + FParametros.ValorComissaoTabelaDeitens )/100)) -
        (FValorIcmsSTPVAux);

    Exit;
  End;

  result := RetornarValorUnitarioMarkupProposto;
end;

{function TCalculoMargemMargemVenda.RetornouValorIteProNumMkp: Boolean;
begin
  Result := true;

  If ValorCalculadoIteProNumMkp > 0 Then
    Exit;

  Result := false;
end;
}

function TCalculoMargemMargemVenda.ValidarMarkupSobrePrecoDeVendaLiquido: Boolean;
begin
  result := true;

  if FParametros.ConfiguracaoMargemMarkup = '4' Then
    Exit;

  result := false;
end;

{function TCalculoMargemMargemVenda.ValorCalculadoIteProNumMkp: Double;
begin
  Result := (1 - (( FParametros.ValorDoIcms + FParametros.ImpostosFederais + FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente + FParametros.ValorComissaoTabelaDeitens)/100));
end;

{function TCalculoMargemMargemVenda.ValorDoStZerado: Boolean;
begin
  result := false;

  If ( FParametros.ValorDaSubstituicao <> 0) Then
    Exit;

  result := true;
end;
}

procedure TCalculoMargemMargemVenda.ZerarValorParaCalculoDeST;
begin
  if FParametros.ConfiguracaoMargemMarkup <> '4' Then
    Exit;

  If (FParametros.CalcularST) Then
  begin
    FValorIcmsAux := 0;
    Exit;
  end;

  FValorIcmsSTPVAux := 0;
end;

end.
