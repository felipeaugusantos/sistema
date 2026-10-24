unit Faturamento.Impostos.Regras.ZerarImpostos.Fcp;

interface

uses System.StrUtils, Faturamento.Impostos.Interfaces.ZerarImpostos.Fcp,
  Faturamento.Impostos.Tipos.ZerarImpostos.Fcp, Shared.Functions.Constantes,
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos,
  Shared.Functions.Configuracoes;

type
  TRegraImpostosZerarImpostosFcp = class(TInterfacedObject, IRegraImpostosZerarImpostosFcp)
  private
    function ZerarFcpProdutoStOuEntregaFutura(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
    function ProdutoSubstituicaoTributaria(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
    function SubstituicaoTributariaOuBaseOuValorZerados(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
    function BaseOuValorDeStZerados(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
    function EntregaFutura(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
    function EspecieFF(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
    function ClienteOrgaoPublico(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
    function FaturamentoConsignacaoComSTEnviadoParaDespesaAcesoria(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
    function ZerarFcpParaEspecieFF(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
    function EhSTAtribuidaPorRegimeEspecialForaDoEstado(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
  public
    function ZerarValorDoFcp(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;

    class function New(): IRegraImpostosZerarImpostosFcp;
  end;

implementation

{ TRegraImpostosZerarImpostosFcp }

function TRegraImpostosZerarImpostosFcp.BaseOuValorDeStZerados(
  const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
// ((item.fltBasRet = 0) Or (item.fltValRet = 0))
  Result := True;

  If AParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem = 0 Then
    Exit;

  If AParametros.ValorDaSubstituicaoTributariaDoItem = 0 Then
    Exit;

  Result := False;
end;

function TRegraImpostosZerarImpostosFcp.ClienteOrgaoPublico(
  const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
//  If (strCliOrg = 'S') And (strCliOrgDifal = 'N') Then
//  Begin
//    blnZeraFCP   := True;
//  End;

  Result := False;

  If Not AParametros.ClienteOrgaoPublico Then
    Exit;

  If AParametros.ClienteOrgaoPublicoDifal Then
    Exit;

  Result := True;
end;

function TRegraImpostosZerarImpostosFcp.EntregaFutura(
  const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
//(item.strEntFut = 'S') And (Not blnBaiEntFut)
  Result := False;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, varBoolean)) Then
    Exit;

  If AParametros.ProdutoST Then
    Exit;

  If Not AParametros.EntregaFuturaDoItem Then
    Exit;

  If AParametros.BaixaDeEntregaFutura Then
    Exit;

  Result := True;
end;

function TRegraImpostosZerarImpostosFcp.EspecieFF(
  const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
  Result := True;

  If (AParametros.EspecieDoDocumento = FATURAMENTO_FUTURO) Then
    Exit;

  Result := False;
end;

function TRegraImpostosZerarImpostosFcp.FaturamentoConsignacaoComSTEnviadoParaDespesaAcesoria(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
  Result := False;

  if not TFunctionsZerarImpostosRegrasImpostosFaturamento.fZerarSTFaturamentoConsignacao(AParametros.ClassificacaoFiscalDoItem) then
    Exit;

  if AParametros.ValorDaSTDoItemNoFatuamentoConsignacao <= 0 then
    Exit;

  Result := True;
end;

class function TRegraImpostosZerarImpostosFcp.New: IRegraImpostosZerarImpostosFcp;
begin
  Result := Self.Create;
end;

function TRegraImpostosZerarImpostosFcp.ProdutoSubstituicaoTributaria(
  const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
//  If (blnProdutoST) Then
//    blnZeraFCP := (Pos(RightStr(item.strCodFis, 2), '30,60') > 0) Or ((item.fltBasRet = 0) Or (item.fltValRet = 0))

  Result := False;

  If Not AParametros.ProdutoST Then
    Exit;

  If Not SubstituicaoTributariaOuBaseOuValorZerados(AParametros) Then
    Exit;

  Result := True;
end;

function TRegraImpostosZerarImpostosFcp.SubstituicaoTributariaOuBaseOuValorZerados(
  const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
// (Pos(RightStr(item.strCodFis, 2), '30,60') > 0) Or ((item.fltBasRet = 0) Or (item.fltValRet = 0))
  Result := True;

  If (RightStr(AParametros.CodigoDaSubstituicaoTributariaDoItem, 2) = '60') Then
    Exit;

  If BaseOuValorDeStZerados(AParametros) Then
    Exit;

  Result := False;
end;

function TRegraImpostosZerarImpostosFcp.ZerarFcpProdutoStOuEntregaFutura(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
  Result := True;

  If ProdutoSubstituicaoTributaria(AParametros) Then
    Exit;

  If EntregaFutura(AParametros) Then
    Exit;

  Result := False;
end;

function TRegraImpostosZerarImpostosFcp.ZerarFcpParaEspecieFF(
  const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
  Result := False;

  If Not EspecieFF(AParametros) Then
    Exit;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean)) Then
    Exit;

  Result := True;
end;

function TRegraImpostosZerarImpostosFcp.EhSTAtribuidaPorRegimeEspecialForaDoEstado(const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
  Result := False;

  If not AParametros.STAtribuidaPorRegimeEspecial Then
    Exit;

  If AParametros.DentroDoEstado Then
    Exit;

  Result := True;
end;

function TRegraImpostosZerarImpostosFcp.ZerarValorDoFcp(
  const AParametros: IParametrosRegraZerarImpostosFcp): Boolean;
begin
//  blnProdutoST :=
//    TFunctionFuncoesFaturamento.
//      ProdutoSubstituidoFaturamento(item.strCodFis);
//
//  If (blnProdutoST) Then
//    blnZeraFCP := (Pos(RightStr(item.strCodFis, 2), '30,60') > 0) Or ((item.fltBasRet = 0) Or (item.fltValRet = 0))
//  Else
//    blnZeraFCP := (item.strEntFut = 'S') And (Not blnBaiEntFut);
//
//  If strEspDoc = 'FF' Then
//    blnZeraFCP := True;
//
//  If (strCliOrg = 'S') And (strCliOrgDifal = 'N') Then
//  Begin
//    blnZeraFCP   := True;
//  End;
//
//  If blnVendaPresencial Then
//    blnZeraFCP := True;

  Result := True;

  if FaturamentoConsignacaoComSTEnviadoParaDespesaAcesoria(AParametros) then
    Exit(False);

  If ZerarFcpProdutoStOuEntregaFutura(AParametros) Then
    Exit;

  If ZerarFcpParaEspecieFF(AParametros) Then
    Exit;

  If ClienteOrgaoPublico(AParametros) Then
    Exit;

  If EhSTAtribuidaPorRegimeEspecialForaDoEstado(AParametros) Then
    Exit;

  Result := False;
end;

end.
