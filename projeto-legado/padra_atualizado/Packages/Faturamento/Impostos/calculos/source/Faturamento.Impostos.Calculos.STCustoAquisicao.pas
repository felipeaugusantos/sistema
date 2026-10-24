unit Faturamento.Impostos.Calculos.STCustoAquisicao;

interface

uses Faturamento.Impostos.Interfaces.STCustoAquisicao,
  Faturamento.Impostos.Tipos.STCustoAquisicao, Shared.Functions.Core,
  Shared.Functions.Constantes;

type
  TCalculoImpostosSTCustoAquisicao = class(TInterfacedObject, ICalculoImpostosSTCustoAquisicao)
  private
    FValorDaSTCustoAquisicao: Double;
    FValorDoIcmsOperacoesProprias: Double;
    FBaseCalculoSt: Double;
    FFatorPositivo: Double;
    FFatorNegativo: Double;

    function ResultadoCalculoSTCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
    function RetornarBaseCalculoSt(AParametros: IParametrosCalculoSTCustoAquisicao): Double;
    function RetornarBaseSTOperacoesProprias(AParametros: IParametrosCalculoSTCustoAquisicao): Double;
    function RetornarFatorNegativo(AParametros: IParametrosCalculoSTCustoAquisicao): Double;
    function GetIvaFornecedor(AParametros: IParametrosCalculoSTCustoAquisicao): Double;
  public
    function CalcularValorSTCustoAquisicao(
      AParametros: IParametrosCalculoSTCustoAquisicao): IResultadoCalculoSTCustoAquisicao;

    class function New(): ICalculoImpostosSTCustoAquisicao;
  end;

implementation

{ TCalculoImpostosSTCustoAquisicao }

function TCalculoImpostosSTCustoAquisicao.CalcularValorSTCustoAquisicao(
  AParametros: IParametrosCalculoSTCustoAquisicao): IResultadoCalculoSTCustoAquisicao;
var
  LBaseSTOperacoesProprias,
  LBaseCalculoIcmsOperacoesProprias: Double;
begin
  FBaseCalculoSt := 0;
  FFatorPositivo := 0;
  FFatorNegativo := 0;

  FValorDaSTCustoAquisicao      := 0;
  FValorDoIcmsOperacoesProprias := 0;

  If (Not AParametros.VendaDentroDoEstado) Then
  Begin
    Result := ResultadoCalculoSTCustoAquisicao;
    Exit;
  End;

  If (Not AParametros.SubstituicaoTributaria) Then
  Begin
    Result := ResultadoCalculoSTCustoAquisicao;
    Exit;
  End;

  FBaseCalculoSt := RetornarBaseCalculoSt(AParametros);
  LBaseSTOperacoesProprias := RetornarBaseSTOperacoesProprias(AParametros);

  LBaseCalculoIcmsOperacoesProprias := objCore.fFormataFloat(LBaseSTOperacoesProprias * AParametros.PercetualBaseIcmsDoFornecedor / 100, 2);

  FBaseCalculoSt := objCore.fFormataFloat((((FBaseCalculoSt * GetIvaFornecedor(AParametros) ) * AParametros.PercetualBaseSTDoFornecedor) / 100), 2);

  FFatorPositivo := objCore.fFormataFloat(((FBaseCalculoSt * AParametros.AliquotaDeSubstituicaoTributaria)/100), 2);

  //somente parte positiva pela aliquota interna
  FFatorNegativo := RetornarFatorNegativo(AParametros);

  If (FFatorPositivo - FFatorNegativo) < 0 Then
  Begin
    FFatorPositivo := 0;
    FFatorNegativo := 0;
  End;

  FValorDaSTCustoAquisicao := objCore.fFormataFloat((FFatorPositivo - FFatorNegativo), 2);
  FValorDoIcmsOperacoesProprias := objCore.fFormataFloat(LBaseCalculoIcmsOperacoesProprias * AParametros.AliquotaDeOperacoesProprias / 100, 2);

  Result := ResultadoCalculoSTCustoAquisicao;
end;

function TCalculoImpostosSTCustoAquisicao.GetIvaFornecedor(
  AParametros: IParametrosCalculoSTCustoAquisicao): Double;
begin
  Result := AParametros.IvaDoFornecedor;

  If (Not AParametros.ClienteConsumidorFinal) Then
    Exit;

  If AParametros.CalculaSTClienteConsumidorFinalNotaEspiritoSanto Then
    Exit;

  If (AParametros.ModeloCalculoSubstituicaoDeOperacoesProprias = PRECO_ESCOLHIDO_SOMENTE_PARTE_POSITIVA) Then
    Exit;

  Result := 1;
end;

class function TCalculoImpostosSTCustoAquisicao.New: ICalculoImpostosSTCustoAquisicao;
begin
  Result := Self.Create;
end;

function TCalculoImpostosSTCustoAquisicao.ResultadoCalculoSTCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
begin
  Result :=
    TResultadoCalculoSTCustoAquisicao.New
      .BaseDaSTCustoAquisicao(FBaseCalculoSt)
      .ValorDaSTCustoAquisicao(FValorDaSTCustoAquisicao)
      .ValorDoIcmsOperacoesProprias(FValorDoIcmsOperacoesProprias)
      .FatorPositivo(FFatorPositivo)
      .FatorNegativo(FFatorNegativo);
end;

function TCalculoImpostosSTCustoAquisicao.RetornarBaseCalculoSt(
  AParametros: IParametrosCalculoSTCustoAquisicao): Double;
begin
  Result := AParametros.PrecoDeCompraComDescontos;

  If (AParametros.ModeloCalculoSubstituicaoDeOperacoesProprias = PRECO_ESCOLHIDO_SOMENTE_PARTE_POSITIVA) Then
    Exit;

  Result := (AParametros.PrecoDeCompraComDescontos +
            (AParametros.PrecoDeCompraComDescontos * AParametros.IpiDeEntrada / 100) +
            (AParametros.PrecoDeCompraComDescontos * AParametros.FreteDeEntrada / 100));
end;

function TCalculoImpostosSTCustoAquisicao.RetornarBaseSTOperacoesProprias(
  AParametros: IParametrosCalculoSTCustoAquisicao): Double;
begin
  Result := AParametros.PrecoDeCompraComDescontos;

  If (AParametros.ModeloCalculoSubstituicaoDeOperacoesProprias = PRECO_ESCOLHIDO_SOMENTE_PARTE_POSITIVA) Then
    Exit;

  Result := (AParametros.PrecoDeCompraComDescontos + (AParametros.PrecoDeCompraComDescontos * AParametros.FreteDeEntrada / 100));
end;

function TCalculoImpostosSTCustoAquisicao.RetornarFatorNegativo(
  AParametros: IParametrosCalculoSTCustoAquisicao): Double;
begin
  Result := 0;

  If (AParametros.ModeloCalculoSubstituicaoDeOperacoesProprias = PRECO_ESCOLHIDO_SOMENTE_PARTE_POSITIVA) Then
    Exit;

  Result := objCore.fFormataFloat(((AParametros.PrecoDeCompraComDescontos * AParametros.AliquotaDeIcms) /100), 2);
end;

end.
