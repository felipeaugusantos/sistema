unit Faturamento.Margem.Calculos.MargemBruta;

interface

uses Faturamento.Margem.Interfaces.MargemBruta,
     Faturamento.Margem.Tipos.MargemBruta,
     System.SysUtils,
     System.Math,
     Shared.Functions.Core;

type
  TCalculoMargemMargemBruta = class(TInterfacedObject, ICalculoMargemMargemBruta)
  private
    FParametros: IParametrosCalculoMargemBruta;

    Function ValidarSeConverteMargem(const AValorDaMargem : Double) : Boolean;

    function RetornarSomaValores : Double;

    function ValidarCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo  : Boolean;
    function RetornarValorCalculoSobrePrecoVendaBrutoOuCalculoNovo: double;

    function ValidarCalculoSobreMarkupCalculoAntigo : Boolean;
    function RetornarValorCalculoSobreMarkupCalculoAntigo: double;
    function RetornarValorPrecoCustoSobreMarkupCalculoAntigo: double;

    function ValidarCalculoSobreMarkupPrecoVendaliquido  : Boolean;
    function RetornarValorCalculoSobreMarkupPrecoVendaliquido: double;
    function RetornarValorDeVendaParaCalcularMarkupPrecoVendaliquido: double;
    procedure ZerarValorVendaOuIcmsStParaCaluloSobreMarkupPrecoVendaliquido;

    function ValidarCalculoSobreMarkupPrecoVendaliquidoNovo : Boolean;
    function RetornarValorCalculoSobreMarkupPrecoVendaliquidoNovo: double;
    function fCalculMargem(fltPreVen, fltSoma ,fltCusto: Currency) : Currency;

    function RetornarPrecoDeCustoParaCalcularMarkupPrecoVendaLiquidoNovo : Double;


    function CalculaMargemParaMarkup(const AValorDaMargem : Double  ): Double; Overload;

  public
    function CalculaMargemParaMarkup(const AParametros: IParametrosCalculoMargemParaMarkup): IResultadoCalculoMargemParaMarkup; Overload;

    function CalculaMargemBruta(const AParametros: IParametrosCalculoMargemBruta): IResultadoCalculoMargemBruta;


    class function New(): ICalculoMargemMargemBruta;
  end;

implementation

{ TCalculoMargemMargemBruta}

function TCalculoMargemMargemBruta.CalculaMargemBruta(
  const AParametros: IParametrosCalculoMargemBruta): IResultadoCalculoMargemBruta;
begin
  FParametros := AParametros;

  If ( ValidarCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo ) Then
  Begin
    Result :=
      TResultadoCalculoMargemBruta.New
        .ValorMargemBruta(RetornarValorCalculoSobrePrecoVendaBrutoOuCalculoNovo);
    Exit;
  End;

  If ( ValidarCalculoSobreMarkupCalculoAntigo ) Then
  Begin
    Result :=
      TResultadoCalculoMargemBruta.New
        .ValorMargemBruta(RetornarValorCalculoSobreMarkupCalculoAntigo);
    Exit;
  End;

  If ( ValidarCalculoSobreMarkupPrecoVendaliquido ) Then
  Begin
    Result :=
      TResultadoCalculoMargemBruta.New
        .ValorMargemBruta(RetornarValorCalculoSobreMarkupPrecoVendaliquido);
    Exit;
  End;

  if (ValidarCalculoSobreMarkupPrecoVendaliquidoNovo ) Then
  begin
    Result :=
      TResultadoCalculoMargemBruta.New
        .ValorMargemBruta(RetornarValorCalculoSobreMarkupPrecoVendaliquidoNovo);
    Exit;
  end;

end;

function TCalculoMargemMargemBruta.CalculaMargemParaMarkup(
  const AParametros: IParametrosCalculoMargemParaMarkup): IResultadoCalculoMargemParaMarkup;
Var
  LValorMarkup : Double;
begin
  LValorMarkup := 0;

  If ValidarSeConverteMargem(AParametros.ValorDaMargem) Then
    LValorMarkup := ((AParametros.ValorDaMargem/ 100) / (1 - AParametros.ValorDaMargem/ 100)) * 100;

  Result :=
   TResultadoCalculoMargemParaMarkup.New
     .ValorMarkup(LValorMarkup);
end;

function TCalculoMargemMargemBruta.CalculaMargemParaMarkup(
  const AValorDaMargem: Double): Double;
Var
  LParametros: IParametrosCalculoMargemParaMarkup;
begin
  LParametros :=
    TParametrosCalculoMargemParaMarkup.new
      .ValorDaMargem(AValorDaMargem);

  Result := CalculaMargemParaMarkup(LParametros).ValorMarkup;
end;

class function TCalculoMargemMargemBruta.New: ICalculoMargemMargemBruta;
begin
  Result := Self.Create;
end;

function TCalculoMargemMargemBruta.RetornarValorCalculoSobreMarkupCalculoAntigo: double;
Var
  LValorPrecoCusto : Double;
begin

  Result := 0.0;

  LValorPrecoCusto := RetornarValorPrecoCustoSobreMarkupCalculoAntigo;

  If LValorPrecoCusto <> 0 Then
    Result := ( ( FParametros.PrecoDeVenda / LValorPrecoCusto ) * 100 ) - 100;

  Result := objCore.fStrToFloat( FormatFloat( objCore.fMskDigitos(objCore.fRetPrecisaoMargemItem), Result ) );
end;

function TCalculoMargemMargemBruta.RetornarValorCalculoSobreMarkupPrecoVendaliquido: double;
begin
  result := 0.0;

  ZerarValorVendaOuIcmsStParaCaluloSobreMarkupPrecoVendaliquido;

  If (FParametros.PrecoDeCusto <> 0) Then
     result := ((RetornarValorDeVendaParaCalcularMarkupPrecoVendaliquido/ FParametros.PrecoDeCusto ) - 1) * 100;

  Result := objCore.fStrToFloat( FormatFloat( objCore.fMskDigitos(objCore.fRetPrecisaoMargemItem), Result ) );
end;

function TCalculoMargemMargemBruta.RetornarValorCalculoSobreMarkupPrecoVendaliquidoNovo: double;
begin
  Result := 0;

  If FParametros.PrecoDeVenda <> 0 Then
    Result := ((FParametros.PrecoDeVenda - RetornarPrecoDeCustoParaCalcularMarkupPrecoVendaLiquidoNovo) / FParametros.PrecoDeVenda) * 100;

  Result := objCore.fStrToFloat( FormatFloat( objCore.fMskDigitos(objCore.fRetPrecisaoMargemItem), Result ) );
end;


function TCalculoMargemMargemBruta.fCalculMargem( fltPreVen, fltSoma ,fltCusto: Currency ) : Currency;
begin
  Result := fltPreVen * (1 - (( fltSoma)/100)) - fltCusto;
  Result := (Result / fltPreVen) * 100;
End;

function TCalculoMargemMargemBruta.RetornarValorCalculoSobrePrecoVendaBrutoOuCalculoNovo : double;
  var fltPreVen,
      fltSoma,
      fltCusto: Currency;
begin
  Result := 0.0;
  fltPreVen := FParametros.PrecoDeVenda;
  fltSoma   := RetornarSomaValores;
  fltCusto  := FParametros.PrecoDeCusto;

  If FParametros.PrecoDeVenda <> 0 Then
  Begin
    Result := fCalculMargem(fltPreVen, fltSoma, fltCusto);


  End;

  If ( FParametros.ConfiguracaoMargemMarkup  = '2' ) Then
    Result := CalculaMargemParaMarkup(Result);

  Result := objCore.fStrToFloat( FormatFloat( objCore.fMskDigitos(objCore.fRetPrecisaoMargemItem), Result ) );
end;

function TCalculoMargemMargemBruta.RetornarValorDeVendaParaCalcularMarkupPrecoVendaliquido: double;
begin
  result := (FParametros.PrecoDeVenda * (1 - ((RetornarSomaValores )/100))) -  FParametros.ValorIcmsSt;
end;

function TCalculoMargemMargemBruta.RetornarValorPrecoCustoSobreMarkupCalculoAntigo: double;
begin
  Result := FParametros.PrecoDeCusto;

  If FParametros.PrecoDeCusto / (1 - (( RetornarSomaValores )/100)) = 0 Then
    Exit;

  Result := FParametros.PrecoDeCusto / (1 - (( RetornarSomaValores )/100));
end;

function TCalculoMargemMargemBruta.RetornarPrecoDeCustoParaCalcularMarkupPrecoVendaLiquidoNovo: Double;
begin
  Result := FParametros.PrecoDeCusto;

  If FParametros.PrecoDeCusto / (1 - ((RetornarSomaValores )/100)) > 0 Then
    Result := FParametros.PrecoDeCusto / (1 - ((RetornarSomaValores )/100));
end;

function TCalculoMargemMargemBruta.RetornarSomaValores: Double;
begin
  Result :=
    ( FParametros.IcmsDeSaida + FParametros.ImpostosFederais + FParametros.DespesasOperacionais +
      FParametros.PrecoDeCompra + FParametros.ValorDifal + FParametros.ValorFCP);
end;

function TCalculoMargemMargemBruta.ValidarCalculoSobreMarkupCalculoAntigo: Boolean;
begin
  result := true;

  If ( FParametros.ConfiguracaoMargemMarkup = '3' ) Then
    Exit;

  result := false;
end;

function TCalculoMargemMargemBruta.ValidarCalculoSobreMarkupPrecoVendaliquido: Boolean;
begin
  Result := true;

  if FParametros.ConfiguracaoMargemMarkup = '4' then
    Exit;

  Result := false;
end;

function TCalculoMargemMargemBruta.ValidarCalculoSobreMarkupPrecoVendaliquidoNovo: Boolean;
begin
  Result := false;

  If ( FParametros.ConfiguracaoMargemMarkup <> '5' )  Then
    Exit;

  Result := true;
end;

function TCalculoMargemMargemBruta.ValidarCalculoSobrePrecoVendaBrutoOuMarkupCalculoNovo: Boolean;
begin
  Result := true;

  If ( FParametros.ConfiguracaoMargemMarkup = '1' )  Then
    Exit;

  If ( FParametros.ConfiguracaoMargemMarkup = '2' ) Then
    Exit;

  Result := false;
end;

function TCalculoMargemMargemBruta.ValidarSeConverteMargem(
  const AValorDaMargem: Double): Boolean;
Var
  LPrecision: Integer;
begin
  Result := false;

  LPrecision := Max(4, objCore.fRetPrecisaoMargemItem);

  If RoundTo(AValorDaMargem, -LPrecision) = RoundTo(100, -LPrecision) Then
    Exit;

  Result := true;
end;

procedure TCalculoMargemMargemBruta.ZerarValorVendaOuIcmsStParaCaluloSobreMarkupPrecoVendaliquido;
begin
  If (FParametros.CalcularST) Then
  begin
    FParametros.IcmsDeSaida(0);
    Exit;
  end;

  FParametros.ValorIcmsSt(0);

end;

end.
