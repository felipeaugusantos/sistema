unit untTCalculaImpostosIVA;

interface

uses untTCalculaImpostos;

type
  TCalculaImpostosIVA = class(TCalculaImpostos)
  private
    function fRetN15VbcMaiorN21VbcSt: Boolean;
    function fRetValorProporcional(fltQuantidade, fltQuantidadeUtilizada, fltValor: Double): Double;
  public
    function fRetBaseStUnitaria: double; override;
    function fRetBaseSt: double; override;
    function fRetAlqSt: double; override;
    function fRetValorSt: double; override;
  end;

implementation

uses untFuncoes, untFuncoesSimples, untFuncoesConsulta, untConsultas, untFuncoesRelatorios, untZClient;

{ TCalculaImpostosIVA }

function TCalculaImpostosIVA.fRetAlqSt: double;
begin
  Result := fFormataFloat((FValorSt / FBaseSt) * 100, 4);

  if FValorSt = 0 then
    Result := FDadosAdicionais.fGetAlqInterna;
end;

function TCalculaImpostosIVA.fRetBaseSt: double;
begin
  Result := (FBaseSt / FQuantidadeComprada) * FQuantidadeUtilizada;

  if FValorSt = 0 then
  begin
    // VALOR ((((PRODUTO + IPI) * IVA) / QUANTIDADE COMPRADA) * QUANTIDADE UTILIZADA)
    Result := FDadosAdicionais.fGetTotalProdutoIpi * FDadosAdicionais.fGetValorIVA;
    Result := fFormataFloat((Result / FQuantidadeComprada) * FQuantidadeUtilizada, 2);
  end;
end;

function TCalculaImpostosIVA.fRetN15VbcMaiorN21VbcSt: Boolean;
begin
  Result := ((FValorN21VbcSt > 0) and (FValorN15Vbc > FValorN21VbcSt));
end;

function TCalculaImpostosIVA.fRetBaseStUnitaria: double;
begin
  Result := FBaseStUnitaria;

  if FValorSt = 0 then
  begin
    // VALOR (((PRODUTO + IPI) * IVA) / QUANTIDADE COMPRADA)
    Result := FDadosAdicionais.fGetTotalProdutoIpi * FDadosAdicionais.fGetValorIVA;
    Result := fFormataFloat(Result / FQuantidadeComprada , 2);
  end;
end;

function TCalculaImpostosIVA.fRetValorProporcional(fltQuantidade, fltQuantidadeUtilizada, fltValor: Double): Double;
begin
  if fltQuantidade = fltQuantidadeUtilizada then
  begin
    Result := fltValor;
    Exit;
  end;

  Result := fFormataFloat((fltValor / fltQuantidade), 003);
  Result := fFormataFloat(Result * fltQuantidadeUtilizada, 003);
end;

function TCalculaImpostosIVA.fRetValorSt: double;
begin
  if fRetN15VbcMaiorN21VbcSt then
    Result := fFormataFloat((((fFormataFloat(((FBaseIcmsStEntrada * FAlqIcmsStEntrada)/100), 003) / FQuantidadeComprada) - FValorIcmUnitar) * FQuantidadeUtilizada), 003)
  else
    Result := fFormataFloat(fFormataFloat((FValorSt / FQuantidadeComprada), 003) * FQuantidadeUtilizada, 003);

  if FValorSt = 0 then
  begin
    Result := fFormataFloat(((fFormataFloat((FDadosAdicionais.fGetTotalProdutoIpi * FDadosAdicionais.fGetValorIVA), 003) * FDadosAdicionais.fGetAlqInterna) / 100), 003);
    Result := fFormataFloat(fFormataFloat((Result / FQuantidadeComprada), 003) * FQuantidadeUtilizada, 003);
    Result := fFormataFloat(Result - fRetValorProporcional(FQuantidadeComprada, FQuantidadeUtilizada, FDadosAdicionais.fGetValorIcms), 003);
  end;

  if Result < 0 then
    Result := 0;
end;

end.
