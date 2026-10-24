unit Faturamento.Impostos.Regras.ZerarImpostos.ST;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos.ST,
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos,
  Shared.Functions.Core, Shared.Functions.Faturamento.Impostos.Regras,
  Shared.Functions.Funcoes.Faturamento;

type
  TRegraImpostosZerarImpostosST = class(TInterfacedObject, IRegraImpostosZerarImpostosST)
  private
    function ClienteZonaFrancaOuConfirmacaoDeCupomEmNota(const AParametros: IParametrosRegraZerarImpostosST): Boolean;
    function ClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(const AParametros: IParametrosRegraZerarImpostosST): Boolean;
    function ClienteTareDefit(const AParametros: IParametrosRegraZerarImpostosST): Boolean;
    function ZerarMeiaNotaParaDocumentosMIFF(const AParametros: IParametrosRegraZerarImpostosST): Boolean;
    function ZerarSubstituicaoTributariaMIFF(const AParametros: IParametrosRegraZerarImpostosST): Boolean;
    function ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto(const AParametros: IParametrosRegraZerarImpostosST): Boolean;
    function ZerarEspecie(const AParametros: IParametrosRegraZerarImpostosST): String;
  public
    function ZerarValorDoST(const AParametros: IParametrosRegraZerarImpostosST): Boolean;

    class function New(): IRegraImpostosZerarImpostosST;
  end;

implementation

{ TRegraImpostosZerarImpostosST }

function TRegraImpostosZerarImpostosST.ClienteTareDefit(
  const AParametros: IParametrosRegraZerarImpostosST): Boolean;
begin
  Result := True;

  If Not objCore.fEmptyStr(AParametros.ClienteTARE) Then
    Exit;

  If Not objCore.fEmptyStr(AParametros.ClienteDEFIT) Then
    Exit;

  Result := False;
end;

function TRegraImpostosZerarImpostosST.ClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(
  const AParametros: IParametrosRegraZerarImpostosST): Boolean;
begin
  Result := TFunctionsRegrasImpostosFaturamento.
    fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(AParametros.ClassificacaoFiscalDoItem);
end;

function TRegraImpostosZerarImpostosST.ClienteZonaFrancaOuConfirmacaoDeCupomEmNota(
  const AParametros: IParametrosRegraZerarImpostosST): Boolean;
begin
  Result := False;

  If Not TFunctionsZerarImpostosRegrasImpostosFaturamento.
    fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(AParametros.ClassificacaoFiscalDoItem,
      AParametros.OpcaoDeDocumento, AParametros.TaxaBombeamentoPedidoOrcamento,
      AParametros.ClassificacaoFiscalDoItem, AParametros.OpcaoItensNFEspTinta,
      AParametros.ClassificacaoDeVenda, AParametros.ClienteEstado, AParametros.ClienteZonaFranca, AParametros.DentroDoEstado) Then
    Exit;

  If AParametros.ClienteZonaFranca Then
    Exit;

  Result := True;
end;

class function TRegraImpostosZerarImpostosST.New: IRegraImpostosZerarImpostosST;
begin
  Result := Self.Create;
end;

function TRegraImpostosZerarImpostosST.ZerarEspecie(
  const AParametros: IParametrosRegraZerarImpostosST): String;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      IsentaImpostosEspeciesZerar(AParametros.DesmembrarMeiaNotaComNotaNormal);
end;

function TRegraImpostosZerarImpostosST.ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto(
  const AParametros: IParametrosRegraZerarImpostosST): Boolean;
begin
  Result := false;

  If Not TFunctionsRegrasImpostosFaturamento.
           IsentaImpostosEspeciesZerarBaixaEntregaFuturaVendaItemConcreto(AParametros.EspecieDoDocumento,
                                                                          ZerarEspecie(AParametros),
                                                                          AParametros.OpcaoDeDocumento,
                                                                          AParametros.ClienteOrgaoPublico ,
                                                                          AParametros.ClienteZonaFranca,
                                                                          AParametros.BaixaDeEntregaFutura,
                                                                          AParametros.EntregaFuturaDoItem,
                                                                          AParametros.EhItemConcreto,
                                                                          AParametros.DesmembrarNotaProdutosServicos)then
  Begin
    Exit;
  End;

  If Not ZerarSubstituicaoTributariaMIFF(AParametros) Then
    Exit;

  Result := true;
end;

function TRegraImpostosZerarImpostosST.ZerarMeiaNotaParaDocumentosMIFF(
  const AParametros: IParametrosRegraZerarImpostosST): Boolean;
begin
  Result := False;

  If Not TFunctionsZerarImpostosRegrasImpostosFaturamento.DesmembrarMeiaNotaComNotaNormalFatorExpedicao(
    AParametros.DesmembrarMeiaNotaComNotaNormal, AParametros.EspecieDoDocumento, AParametros.MeiaNotaFatorExpedicao) Then
    Exit;

  If Not ZerarSubstituicaoTributariaMIFF(AParametros) Then
    Exit;

  Result := true;
end;

function TRegraImpostosZerarImpostosST.ZerarSubstituicaoTributariaMIFF(
  const AParametros: IParametrosRegraZerarImpostosST): Boolean;
begin
  Result := TFunctionFuncoesFaturamento.
              ZerarSubstituicaoTributaria(AParametros.EspecieDoDocumento,
                                          AParametros.OpcaoDeDocumento,
                                          AParametros.TipoDePedidoFaturamento,
                                          AParametros.BaixaDeEntregaFutura,
                                          AParametros.TipoDeBaixaEntregaFutura,
                                          AParametros.TemMIFFEntreOsDevolvidos);
end;

function TRegraImpostosZerarImpostosST.ZerarValorDoST(
  const AParametros: IParametrosRegraZerarImpostosST): Boolean;
begin
  Result := True;

  If Self.ClienteZonaFrancaOuConfirmacaoDeCupomEmNota(AParametros) Then
    Exit;

  If Self.ClienteTareDefit(AParametros) Then
    Exit;

  If Self.ClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(AParametros)Then
    Exit;

  If ZerarMeiaNotaParaDocumentosMIFF(AParametros) Then
    Exit;

  If ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto(AParametros) Then
    Exit;

  Result := False;
end;

end.
