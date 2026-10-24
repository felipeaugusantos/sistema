unit Shared.Functions.Funcoes.Faturamento.Margem;

interface

uses
  Shared.Functions.Types,
  Shared.Functions.Core,
  Shared.Functions.DataSet,
  Shared.Functions.SQL,
  Shared.Functions.Interfaces,
  Faturamento.Margem.Servicos.Classe.MargemBruta,
  Shared.Functions.Configuracoes,
  Shared.Functions.Tipos,
  Faturamento.Margem.Calculos.MargemBruta,
  Faturamento.Margem.Interfaces.MargemBruta,
  Faturamento.Margem.Tipos.MargemBruta,
  System.StrUtils;

type
  TFunctionFuncoesFaturamentoMargem = class
  private
    FParametros           : IParametrosFuncaoCalcularMargemBruta;
    FIcmsSaida            : Double; // fltParIcmSai
    FImpostosFederais     : Double;
    FDespesasOperacionais : Double;
    FComissaoTabela       : Double;
    FValorDifal           : Double;
    FValorFcp             : Double;
    FIcmsStParteDaVenda   : Double;

    Class function RetornarValorDoFCP : Boolean;

    Class function ValorDoStZerado : Boolean;
    Class function BaseIcmsDoItemOuEntregaFuturaOuPedidoOrcamentoParaEntregaFutura : Boolean;

    Class function ValidarSeZeraValoresParaMargemBruta : Boolean;
    Class procedure ZerarValoresParaMargemBruta;

    Class function retornarValorDifal : Double;
    Class function retornarValorFCP : Double;
  public
    Class function CalcularMargemBruta(Const AParametros : IParametrosFuncaoCalcularMargemBruta) : Double;

  end;

implementation

{ TFaturamentoMargemServicosFuncoes }



Class function TFunctionFuncoesFaturamentoMargem.CalcularMargemBruta(Const AParametros : IParametrosFuncaoCalcularMargemBruta): Double;
var
  LParametrosMargemBruta : IParametrosServicoMargemBruta;
begin
  FParametros := AParametros;

  FValorFcp             := 0;
  FIcmsSaida            := AParametros.ValorBaseICMS;
  FImpostosFederais     := AParametros.ImpostosFederais;
  FDespesasOperacionais := AParametros.DespesasOperacionais;
  FComissaoTabela       := AParametros.ValorComissaoTabelaDeitens;
  FValorDifal           := AParametros.ValorDifal;
  FIcmsStParteDaVenda   := AParametros.ValorDoIcmsStParteDaVenda;

  If RetornarValorDoFCP Then
    FValorFcp := AParametros.ValorFCPDoItem;

  If (ValidarSeZeraValoresParaMargemBruta) Then
    ZerarValoresParaMargemBruta;

  LParametrosMargemBruta :=
    TParametrosServicoMargemBruta.New
      .ConfiguracaoMargemMarkup(objConfiguracoes.fGetValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP))
      .PrecoDeCusto(FParametros.ValorDoCusto)
      .PrecoDeVenda(FParametros.ValorDaVenda)
      .ValorDaMargem(0)
      .IcmsDeSaida(FParametros.ValorBaseICMS)
      .ImpostosFederais(FParametros.ImpostosFederais)
      .DespesasOperacionais(FParametros.DespesasOperacionais)
      .PrecoDeCompra(FParametros.ValorDaCompra)
      .ValorIcmsSt(FParametros.ValorIcmsSt)
      .CalcularST(FParametros.CalcularST)
      .ValorDifal(retornarValorDifal)
      .ValorFCP(retornarValorFCP);

  result :=
    TFaturamentoMargemServicosClasseMargemBruta.New
      .CalculaMargemBruta(LParametrosMargemBruta)
        .ResultadoCalculoMargemBruta
          .ValorMargemBruta;
end;



Class function TFunctionFuncoesFaturamentoMargem.retornarValorDifal: Double;
begin
  Result := 0;

  If objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_ROTINA_PRECO_VENDA_DINAMICO_INFLUENCIADO_POR_IMPOSTOS, varBoolean) Then
    Exit;

  Result := FParametros.ValorDifal;
end;

Class function TFunctionFuncoesFaturamentoMargem.ValidarSeZeraValoresParaMargemBruta: Boolean;
begin
  result := false;

  If FParametros.MargemLiquida Then
    Exit;

  result := true;
end;

Class function TFunctionFuncoesFaturamentoMargem.ValorDoStZerado: Boolean;
begin
  result := false;

  If ( FParametros.ValorST <> 0) Then
    Exit;

  result := true;
end;

Class procedure TFunctionFuncoesFaturamentoMargem.ZerarValoresParaMargemBruta;
begin
  FValorFcp             := 0;
  FIcmsSaida            := 0;
  FImpostosFederais     := 0;
  FDespesasOperacionais := 0;
  FComissaoTabela       := 0;
  FValorDifal           := 0;
  FIcmsStParteDaVenda   := 0;
end;

{ TFaturamentoMargemServicosFuncoes }

Class function TFunctionFuncoesFaturamentoMargem.BaseIcmsDoItemOuEntregaFuturaOuPedidoOrcamentoParaEntregaFutura: Boolean;
begin
  Result := true;

  If FParametros.ValorBaseICMS <> 0 Then
    Exit;

  if (AnsiRightStr(FParametros.ClassificacaoFiscal, 3) = '922') Then
    Exit;

  if FParametros.CarregarPedidoOrcamentoEntradaFutura Then
    Exit;

  Result := false;
end;

Class function TFunctionFuncoesFaturamentoMargem.RetornarValorDoFCP: Boolean;
begin
  result := false;

  If Not ValorDoStZerado Then
    Exit;

  If Not BaseIcmsDoItemOuEntregaFuturaOuPedidoOrcamentoParaEntregaFutura Then
    Exit;

  result := true;
end;

Class function TFunctionFuncoesFaturamentoMargem.retornarValorFCP : Double;
begin
  Result := 0;

  If objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_ROTINA_PRECO_VENDA_DINAMICO_INFLUENCIADO_POR_IMPOSTOS, varBoolean) Then
    Exit;

  Result := FParametros.ValorFCP;
end;

end.
