unit Faturamento.Margem.Servicos.Classe.MargemVenda;

interface

uses System.SysUtils,
     Faturamento.Margem.Interfaces.Servicos.Classe.MargemVenda,
     Faturamento.Margem.Interfaces.MargemVenda,
     Faturamento.Margem.Tipos.MargemVenda,
     Shared.Functions.Configuracoes,
     Shared.Functions.Types,
     Shared.Functions.Core,
     System.StrUtils,
     Faturamento.Margem.Calculos.MargemVenda,
     Faturamento.Margem.Servicos.Classe.MargemBruta,
     Faturamento.Margem.Tipos.MargemBruta,
     Faturamento.Margem.Interfaces.MargemBruta,
     System.Generics.Collections;

type
  TFaturamentoMargemServicosClasseMargemVenda= class(TInterfacedObject, IFaturamentoMargemServicosClasseMargemVenda)
  private
    FParametros : IParametrosServicoMargemVenda;
    FPrecoVendaDinamicoInfluenciadoPorImpostos : Boolean;
    FConfiguracaoMargemMarkup : String;

    FIcmsSaida            : Double;
    FImpostosFederais     : Double;
    FDespesasOperacionais : Double;
    FValorComissaoTabela  : Double;
    FValorDifal           : Double;
    FValorFcp             : Double;
    FIcmsSTPV             : Double;
    FCasasDecimais        : Integer;

    FListaResultadosCalculoMargem: TList<IResultadoServicosClasseMargemVenda>;

    function RetornarResultadoServicosClasseMargemVenda(const AParametros: IParametrosCalculoMargemVenda) : IResultadoServicosClasseMargemVenda;

    function RetonarParametrosCalculoMargemVenda(const AParametros: IParametrosServicoMargemVenda):IParametrosCalculoMargemVenda;

    function CalcularMargemInterna(Const APrecoVenda, APrecoCusto: Double; Const ACalcularMargemLiquida: Boolean): Double;

    function retornarCalculoMargem(
        Const AConfiguracaoMargemMarkup :String ;
        Const APrecoDeCusto: Double;
        Const APrecoDeVenda: Double;
        Const AValorDaMargem: Double;
        Const AIcmsDeSaida: Double;
        Const AImpostosFederais: Double;
        Const ADespesasOperacionais: Double;
        Const APrecoDeCompra: Double;
        Const AValorIcmsSt: Double;
        Const ACalcularST : Boolean;
        Const AValorDifal : Double;
        Const AValorFCP   : Double) : Double;




    procedure ZerarImpostos(Const ACalcularMargemLiquida : Boolean);

    function RetornarValorFcpNoCalculoDaMargem : Boolean;

    function BaseIcmsDoItemOuEntregaFuturaOuPedidoOrcamentoParaEntregaFutura: Boolean;

    function retornarValorDifalMargemInterna: Double;
    function retornarValorFCPMargemInterna: Double;


    function retornarValorDifalCalculo: Double;
    function retornarValorFCPCalculo  : Double;

    function retornarValorMarkup : Double;
    function retornarValorMargemCat17 : Double;
    function RetornarValorDaDiferencaParaSomarIcms(
      const ACalcularMargemLiquida: Boolean;
      const AValorDaAliquotaDiferenca: Double): Double;

  public
    function CalculaMargemVenda(const AParametros: TList<IParametrosServicoMargemVenda>; AstrConfiguracaoMargemMarkup: String=''): TList<IResultadoServicosClasseMargemVenda>;

    destructor Destroy; override;
    constructor Create;

    class function New(): IFaturamentoMargemServicosClasseMargemVenda;
  end;

implementation

{ TFaturamentoMargemServicosClasseMargemVenda}

function TFaturamentoMargemServicosClasseMargemVenda.CalculaMargemVenda(
  const AParametros: TList<IParametrosServicoMargemVenda>; AstrConfiguracaoMargemMarkup: String=''): TList<IResultadoServicosClasseMargemVenda>;
var
  Contador: Integer;
Var
  LValorCalculoImpostosAliquota    : Double;
//  LCustoMargem                     : Double;
  LMargemPraticadaPrecoCusto       : Double;
  LMargemPraticadaPrecoCustoBruta  : Double;
  LMargemPropostaPrecoCusto        : Double;
  LMargemPropostaCustoItem         : Double;
  LMargemPraticadaCustoItem        : Double;
  LMargemBrutaPrecoMedio           : Double;
  LMargemLiquidaPrecoMedio         : Double;
  LMargemLiquidaPrecoMedioBruta    : Double;
  LMargemBrutaPrecoUltimaCompra    : Double;
  LMargemLiquidaPrecoUltimaCompra  : Double;
  LMargemBrutaImpostoUltimaCompra  : Double;
  LMargemLiquidaImpostoUltimaCompra: Double;
  LMargemMedia                     : Double;
  LMargemImpostos                  : Double;
  LMargemItem                      : Double;
  LMargemLucro                     : Double;
  LValorMargemCat17                : Double;
  LMargemPraticadaPrecoCustoReal   : Double;
  LMargemPropostaPrecoCustoReal    : Double;
  LConfigMargemPrecoUltimaCompraImpostos : String;
  LConsiderarConfigMargemPrecoUltimaCompraImpostos : boolean;
  LParametrosServicoMargemVenda : IParametrosServicoMargemVenda;
  LblnConsideraImpostos: Boolean;
begin
  For Contador := 0 To Pred(AParametros.Count) Do
  Begin
    FParametros := AParametros[Contador];

    If (AstrConfiguracaoMargemMarkup <> '') Then
    Begin
      FConfiguracaoMargemMarkup := AstrConfiguracaoMargemMarkup;
      LblnConsideraImpostos := FConfiguracaoMargemMarkup<>'5';
    End
    Else  
    Begin
      FConfiguracaoMargemMarkup := objConfiguracoes.fGetValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP);
      LblnConsideraImpostos := FConfiguracaoMargemMarkup<>'5';
    End;

    LValorCalculoImpostosAliquota    := retornarValorMarkup;
//    LCustoMargem                     := (FParametros.ValorCustoDoItem + FParametros.OutrosValores) / retornarValorMarkup;

    LMargemPraticadaPrecoCusto       := CalcularMargemInterna(FParametros.ValorUnitario, (FParametros.ValorDoCustoPraticado + FParametros.OutrosValores ), LblnConsideraImpostos); // ITE_MARPRA_PRECUS

    LMargemPropostaPrecoCusto        := CalcularMargemInterna(FParametros.ValorUnitarioOriginal, (FParametros.ValorCustoDoItem + FParametros.OutrosValoresValOri), True); // ITE_MARPRO_PRECUS

    LMargemPraticadaPrecoCustoBruta  := CalcularMargemInterna(FParametros.ValorUnitario, (FParametros.ValorCustoDoItem + FParametros.OutrosValores), True); // ITE_MRPRBT_PRECUS

    LMargemPropostaCustoItem         := CalcularMargemInterna(FParametros.ValorUnitarioOriginal, FParametros.ValorCustoDoItem, False); // ITE_MARPRO_CUSITE

    LMargemPraticadaCustoItem        := CalcularMargemInterna(FParametros.ValorUnitario, FParametros.ValorCustoDoItem , False); // ITE_MARPRA_CUSITE

    LMargemPraticadaPrecoCustoReal   := CalcularMargemInterna(FParametros.ValorUnitario, (FParametros.ValorCustoRealPraticado), False);

    LMargemPropostaPrecoCustoReal    := CalcularMargemInterna(FParametros.ValorUnitarioOriginal, (FParametros.ValorCustoRealPraticado), False);

    If FConfiguracaoMargemMarkup='5' Then
    Begin
      LMargemBrutaPrecoMedio           := CalcularMargemInterna(FParametros.ValorUnitarioOriginal, objCore.fFormataFloat(FParametros.PrecoMedio, FCasasDecimais), True); // ITE_MARBRU_PREMED
      LMargemLiquidaPrecoMedioBruta    := CalcularMargemInterna(FParametros.ValorUnitario, objCore.fFormataFloat(FParametros.PrecoMedio, FCasasDecimais), True); // ITE_MRPRBT_PREMED
      LMargemLiquidaPrecoMedio         := CalcularMargemInterna(FParametros.ValorUnitario, FParametros.PrecoMedioPraticado + FParametros.OutrosValores, LblnConsideraImpostos); // ITE_MARLIQ_PREMED
    End
    Else
    Begin
      LMargemBrutaPrecoMedio           := CalcularMargemInterna(FParametros.ValorUnitario, objCore.fFormataFloat(FParametros.PrecoMedio, FCasasDecimais), False); // ITE_MARBRU_PREMED
      LMargemLiquidaPrecoMedioBruta    := 0;
      LMargemLiquidaPrecoMedio         := CalcularMargemInterna(FParametros.ValorUnitario, FParametros.PrecoMedio + FParametros.OutrosValores, LblnConsideraImpostos); // ITE_MARLIQ_PREMED
    End;

    LMargemBrutaPrecoUltimaCompra    := CalcularMargemInterna(FParametros.ValorUnitario, FParametros.PrecoUltimaCompra, False); // ITE_MARBRU_PREULT
    LMargemLiquidaPrecoUltimaCompra  := CalcularMargemInterna(FParametros.ValorUnitario, FParametros.PrecoUltimaCompra + FParametros.OutrosValores, LblnConsideraImpostos); //ITE_MARLIQ_PREULT

    LMargemBrutaImpostoUltimaCompra  := CalcularMargemInterna(FParametros.ValorUnitario, FParametros.ValorUltimaCompraImpostos, False); // ITE_MARBRU_IMPULT
    LMargemLiquidaImpostoUltimaCompra:= CalcularMargemInterna(FParametros.ValorUnitario, objCore.IIF(FConfiguracaoMargemMarkup='5', FParametros.ValorUltimaCompraImpostosPraticado, FParametros.ValorUltimaCompraImpostos) + FParametros.OutrosValores , LblnConsideraImpostos); // ITE_MARLIQ_IMPULT

    LMargemMedia :=
      retornarCalculoMargem( FConfiguracaoMargemMarkup
                           , FParametros.PrecoMedio
                           , FParametros.ValorUnitario
                           , 0
                           , FParametros.ValorDoIcms + FParametros.ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia
                           , FParametros.ImpostosFederais
                           , FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente
                           , FParametros.ValorComissaoTabelaDeitens
                           , FParametros.ValorDoIcmsStParteDaVenda
                           , FParametros.CalcularST
                           , retornarValorDifalCalculo
                           , retornarValorFCPCalculo);

    LValorMargemCat17 := retornarValorMargemCat17;


    LConfigMargemPrecoUltimaCompraImpostos           := objConfiguracoes.fGetValorConfiguracao(CFG_CALCULO_MARGEM_PRECO_ULTIMA_COMPRA_MAIS_IMPOSTOS_CONSIDERAR, varString);
    LConsiderarConfigMargemPrecoUltimaCompraImpostos := (LConfigMargemPrecoUltimaCompraImpostos = '1');

    LMargemImpostos :=
      retornarCalculoMargem( FConfiguracaoMargemMarkup
                           , FParametros.ValorUltimaCompraImpostos + objCore.IIF(LConsiderarConfigMargemPrecoUltimaCompraImpostos, FParametros.OutrosValores, 0)
                           , FParametros.ValorUnitario
                           , 0
                           , objCore.IIF(LConsiderarConfigMargemPrecoUltimaCompraImpostos, FParametros.ValorDoIcms, 0) + FParametros.ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos
                           , objCore.IIF(LConsiderarConfigMargemPrecoUltimaCompraImpostos, FParametros.ImpostosFederais, 0)
                           , objCore.IIF(LConsiderarConfigMargemPrecoUltimaCompraImpostos, FParametros.DespesasOperacionais  + FParametros.DespesaOperacionalCliente, 0)
                           , objCore.IIF(LConsiderarConfigMargemPrecoUltimaCompraImpostos, FParametros.ValorComissaoTabelaDeitens, 0)
                           , FParametros.ValorDoIcmsStParteDaVenda
                           , FParametros.CalcularST
                           , retornarValorDifalCalculo
                           , retornarValorFCPCalculo);

    LMargemItem :=
      retornarCalculoMargem( FConfiguracaoMargemMarkup
                           , FParametros.ValorCustoDoItem + FParametros.OutrosValores
                           , FParametros.ValorUnitarioOriginal
                           , 0
                           , FParametros.ValorDoIcms + FParametros.ValorDaAliquotaDiferencaPrecoDinamicoMargemItem
                           , FParametros.ImpostosFederais
                           , FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente
                           , FParametros.ValorComissaoTabelaDeitens
                           , FParametros.ValorDoIcmsStParteDaVenda
                           , FParametros.CalcularST
                           , retornarValorDifalCalculo
                           , retornarValorFCPCalculo);

    LMargemLucro :=
      retornarCalculoMargem( FConfiguracaoMargemMarkup
                           , FParametros.ValorCustoDoItem + FParametros.OutrosValores
                           , FParametros.ValorUnitario
                           , 0
                           , FParametros.ValorDoIcms + FParametros.ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro
                           , FParametros.ImpostosFederais
                           , FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente
                           , FParametros.ValorComissaoTabelaDeitens
                           , FParametros.ValorDoIcmsStParteDaVenda
                           , FParametros.CalcularST
                           , retornarValorDifalCalculo
                           , retornarValorFCPCalculo);


    LParametrosServicoMargemVenda :=
      TParametrosServicoMargemVenda.New
      .ImpostosFederais(FParametros.ImpostosFederais)
      .PrecoMedio(FParametros.PrecoMedio)
      .CalcularST(FParametros.CalcularST)
      .ValorUnitarioOriginal(FParametros.ValorUnitarioOriginal)
      .ValorUnitario(FParametros.ValorUnitario)
      .ValorDoIcms(FParametros.ValorDoIcms)
      .ValorDoDifal(FParametros.ValorDoDifal)
      .ValorDoFCP(FParametros.ValorDoFCP)
      .DespesasOperacionais(FParametros.DespesasOperacionais)
      .DespesaOperacionalCliente(FParametros.DespesaOperacionalCliente)
      .ValorComissaoTabelaDeitens(FParametros.ValorComissaoTabelaDeitens)
      .ValorDoCustoPraticado(FParametros.ValorDoCustoPraticado)
      .ValorCustoDoItem(FParametros.ValorCustoDoItem)
      .OutrosValores(FParametros.OutrosValores)
      .ConsiderarMargemDePrecoUltimaCompraNoCalculo(LConsiderarConfigMargemPrecoUltimaCompraImpostos)
      .ValorUltimaCompraImpostos(FParametros.ValorUltimaCompraImpostos)
      .ValorDoIcmsStParteDaVenda(FParametros.ValorDoIcmsStParteDaVenda)
      .ConfiguracaoMargemMarkup(FConfiguracaoMargemMarkup)
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(FParametros.ValorDaAliquotaDiferencaPrecoDinamicoIcms)
      .ValorUnitarioMargemMinima(FParametros.ValorUnitarioMargemMinima)
      .ValorUnitarioMargemPraticadaCustoReal(LMargemPraticadaPrecoCusto)
      .ValorUnitarioMargemPropostaCustoReal(LMargemPropostaPrecoCusto)
      .ValorUnitarioMargemPropostaCusto(LMargemPropostaCustoItem)
      .ValorUnitarioMargemPraticadaCusto(LMargemPraticadaCustoItem)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(LMargemBrutaPrecoMedio)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(LMargemLiquidaPrecoMedio)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(LMargemBrutaPrecoUltimaCompra)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(LMargemLiquidaPrecoUltimaCompra)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(LMargemBrutaImpostoUltimaCompra)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(LMargemLiquidaImpostoUltimaCompra)
      .ValorCalculoImpostosAliquota(LValorCalculoImpostosAliquota)
      .ValorUnitarioItemMargemPrecoMedio(LMargemMedia)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(LMargemImpostos)
      .ValorUnitarioItemMargemProposta(LMargemItem)
      .ValorUnitarioItemMargemPraticadaLucro(LMargemLucro)
      .ValorMargemCat17(LValorMargemCat17)
      .CalcularPrecoIdeal(FParametros.CalcularPrecoIdeal)
      .ValorPrecoIdeal(FParametros.ValorPrecoIdeal)
      .AliquotaIcmsPrecoIdeal(FParametros.AliquotaIcmsPrecoIdeal)
      .ValorUnitarioMargemPraticadaCustoRealBruta(LMargemPraticadaPrecoCustoBruta)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta(LMargemLiquidaPrecoMedioBruta)
      .ValorMargemPraticadaCustoReal(LMargemPraticadaPrecoCustoReal)
      .ValorMargemPropostaCustoReal(LMargemPropostaPrecoCustoReal)
      .ValorCustoRealPraticado(FParametros.ValorCustoRealPraticado)
      .MargemMinimaLiquidaPorPrecoMedio(FParametros.MargemMinimaLiquidaPorPrecoMedio)
      .OutrosValoresValOri(FParametros.OutrosValoresValOri);

    FListaResultadosCalculoMargem.Add(
      RetornarResultadoServicosClasseMargemVenda(
      RetonarParametrosCalculoMargemVenda(LParametrosServicoMargemVenda))
    );
  End;

  Result := FListaResultadosCalculoMargem;
end;

function TFaturamentoMargemServicosClasseMargemVenda.RetornarValorDaDiferencaParaSomarIcms( Const ACalcularMargemLiquida: Boolean;  Const AValorDaAliquotaDiferenca : Double) : Double;
begin
  Result := 0;

  If Not ACalcularMargemLiquida Then
    Exit;

  Result := AValorDaAliquotaDiferenca;
end;

function TFaturamentoMargemServicosClasseMargemVenda.CalcularMargemInterna(Const APrecoVenda, APrecoCusto: Double; Const ACalcularMargemLiquida: Boolean): Double;
Var
  LParametrosServicoMargemBruta: IParametrosServicoMargemBruta;
//  LValorDaAliquotaDiferenca    : Double;
begin
  FIcmsSaida            := FParametros.ValorDoIcms;
  FImpostosFederais     := FParametros.ImpostosFederais;
  FDespesasOperacionais := FParametros.DespesasOperacionais;
  FValorComissaoTabela  := FParametros.ValorComissaoTabelaDeitens;
  FValorDifal           := FParametros.ValorDoDifal;
  FIcmsSTPV             := FParametros.ValorDoIcmsStParteDaVenda;

 { LValorDaAliquotaDiferenca :=
    objCore.IIF(
      ACalcularMargemLiquida,
        FParametros.ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida,
          FParametros.ValorDaAliquotaDiferencaPrecoDinamicoMargem);
          }

  FPrecoVendaDinamicoInfluenciadoPorImpostos := objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_ROTINA_PRECO_VENDA_DINAMICO_INFLUENCIADO_POR_IMPOSTOS, varBoolean);


  FValorFcp := 0;

  If RetornarValorFcpNoCalculoDaMargem Then
  begin
    FValorFcp := FParametros.ValorDoFCP;
  end;


  ZerarImpostos(ACalcularMargemLiquida);

    LParametrosServicoMargemBruta :=
      TParametrosServicoMargemBruta.New
        .ConfiguracaoMargemMarkup(FConfiguracaoMargemMarkup )
        .PrecoDeCusto(APrecoCusto)
        .PrecoDeVenda(APrecoVenda)
        .ValorDaMargem(0)
        .IcmsDeSaida(FIcmsSaida +  RetornarValorDaDiferencaParaSomarIcms( ACalcularMargemLiquida , FParametros.ValorDaAliquotaDiferencaPrecoDinamicoMargem))
        .ImpostosFederais(FImpostosFederais)
        .DespesasOperacionais(FDespesasOperacionais)
        .PrecoDeCompra(FValorComissaoTabela)
        .ValorIcmsSt(FIcmsSTPV)
        .CalcularST(FParametros.CalcularST)
        .ValorDifal(retornarValorDifalMargemInterna)
        .ValorFCP(retornarValorFCPMargemInterna);


  Result :=
    TFaturamentoMargemServicosClasseMargemBruta.New
      .CalculaMargemBruta(LParametrosServicoMargemBruta)
        .ResultadoCalculoMargemBruta
          .ValorMargemBruta;
end;

constructor TFaturamentoMargemServicosClasseMargemVenda.Create;
begin
  FListaResultadosCalculoMargem := TList<IResultadoServicosClasseMargemVenda>.Create;

  FCasasDecimais := objConfiguracoes.fGetValorConfiguracao(CFG_QUANTIDADE_CASAS_DECIMAIS_VALOR_UNITARIO, varInteger);
end;

destructor TFaturamentoMargemServicosClasseMargemVenda.Destroy;
begin
//  FreeAndNil(FListaResultadosCalculoMargem);

  inherited;
end;

function TFaturamentoMargemServicosClasseMargemVenda.BaseIcmsDoItemOuEntregaFuturaOuPedidoOrcamentoParaEntregaFutura: Boolean;
begin
  Result := true;

  If FParametros.ValorBaseDoIcms <> 0 Then
    Exit;

  if (AnsiRightStr(FParametros.ClassificacaoFiscal, 3) = '922') Then
    Exit;

  if FParametros.CarregarPedidoOrcamentoEntradaFutura Then
    Exit;

  Result := false;
end;


class function TFaturamentoMargemServicosClasseMargemVenda.New: IFaturamentoMargemServicosClasseMargemVenda;
begin
  Result := Self.Create;
end;

function TFaturamentoMargemServicosClasseMargemVenda.RetonarParametrosCalculoMargemVenda(
  const AParametros: IParametrosServicoMargemVenda): IParametrosCalculoMargemVenda;
begin
  Result :=
    TParametrosCalculoMargemVenda.New
      .ImpostosFederais(AParametros.ImpostosFederais)
      .PrecoMedio(AParametros.PrecoMedio)
      .ValorCalculoImpostosAliquota(AParametros.ValorCalculoImpostosAliquota)
      .CalcularST(AParametros.CalcularST)
      .ValorUnitarioOriginal(AParametros.ValorUnitarioOriginal)
      .ValorUnitario(AParametros.ValorUnitario)
      .ValorDoIcms(AParametros.ValorDoIcms)
      .ValorDoDifal(AParametros.ValorDoDifal)
      .ValorDoFCP(AParametros.ValorDoFCP)
      .DespesasOperacionais(AParametros.DespesasOperacionais)
      .DespesaOperacionalCliente(AParametros.DespesaOperacionalCliente)
      .ValorComissaoTabelaDeitens(AParametros.ValorComissaoTabelaDeitens)
      .ValorDoCustoPraticado(AParametros.ValorDoCustoPraticado)
      .ValorCustoDoItem(AParametros.ValorCustoDoItem)
      .OutrosValores(AParametros.OutrosValores)
      .OutrosValoresValOri(AParametros.OutrosValoresValOri)
      .ValorUltimaCompraImpostos(AParametros.ValorUltimaCompraImpostos)
      .ConsiderarMargemDePrecoUltimaCompraNoCalculo(AParametros.ConsiderarMargemDePrecoUltimaCompraNoCalculo)
      .ValorDoIcmsStParteDaVenda(AParametros.ValorDoIcmsStParteDaVenda)
      .ConfiguracaoMargemMarkup(FConfiguracaoMargemMarkup)
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(AParametros.ValorDaAliquotaDiferencaPrecoDinamicoIcms)
      .ValorUnitarioMargemMinima(AParametros.ValorUnitarioMargemMinima)
      .ValorUnitarioMargemPraticadaCustoReal(AParametros.ValorUnitarioMargemPraticadaCustoReal)
      .ValorUnitarioMargemPropostaCustoReal(AParametros.ValorUnitarioMargemPropostaCustoReal)
      .ValorUnitarioMargemPropostaCusto(AParametros.ValorUnitarioMargemPropostaCusto)
      .ValorUnitarioMargemPraticadaCusto(AParametros.ValorUnitarioMargemPraticadaCusto)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(AParametros.ValorUnitarioMargemBrutaPraticadaPrecoMedio)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(AParametros.ValorUnitarioMargemLiquidaPraticadaPrecoMedio)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(AParametros.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(AParametros.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(AParametros.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(AParametros.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos)
      .ValorUnitarioItemMargemPrecoMedio(AParametros.ValorUnitarioItemMargemPrecoMedio)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(AParametros.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos)
      .ValorUnitarioItemMargemProposta(AParametros.ValorUnitarioItemMargemProposta)
      .ValorUnitarioItemMargemPraticadaLucro(AParametros.ValorUnitarioItemMargemPraticadaLucro)
      .CalcularPrecoIdeal(AParametros.CalcularPrecoIdeal)
      .ValorPrecoIdeal(AParametros.ValorPrecoIdeal)
      .AliquotaIcmsPrecoIdeal(AParametros.AliquotaIcmsPrecoIdeal)
      .ValorMargemCat17(AParametros.ValorMargemCat17)
      .ValorUnitarioMargemPraticadaCustoRealBruta(AParametros.ValorUnitarioMargemPraticadaCustoRealBruta)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta(AParametros.ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta)
      .ValorMargemPraticadaCustoReal(AParametros.ValorMargemPraticadaCustoReal)
      .ValorMargemPropostaCustoReal(AParametros.ValorMargemPropostaCustoReal)
      .ValorCustoRealFrete(AParametros.ValorCustoRealPraticado)
      .MargemMinimaLiquidaPorPrecoMedio(AParametros.MargemMinimaLiquidaPorPrecoMedio);
end;

function TFaturamentoMargemServicosClasseMargemVenda.retornarCalculoMargem(
  const AConfiguracaoMargemMarkup: String; const APrecoDeCusto, APrecoDeVenda,
  AValorDaMargem, AIcmsDeSaida, AImpostosFederais, ADespesasOperacionais,
  APrecoDeCompra, AValorIcmsSt: Double; const ACalcularST: Boolean;
  const AValorDifal, AValorFCP: Double): Double;
Var
  LParametrosServicoMargemBruta: IParametrosServicoMargemBruta;
begin
    LParametrosServicoMargemBruta :=
      TParametrosServicoMargemBruta.New
        .ConfiguracaoMargemMarkup(AConfiguracaoMargemMarkup)
        .PrecoDeCusto(APrecoDeCusto)
        .PrecoDeVenda(APrecoDeVenda)
        .ValorDaMargem(AValorDaMargem)
        .IcmsDeSaida(AIcmsDeSaida)
        .ImpostosFederais(AImpostosFederais)
        .DespesasOperacionais(ADespesasOperacionais)
        .PrecoDeCompra(APrecoDeCompra)
        .ValorIcmsSt(AValorIcmsSt)
        .CalcularST(ACalcularST)
        .ValorDifal(AValorDifal)
        .ValorFCP(AValorFCP);

  Result :=
    TFaturamentoMargemServicosClasseMargemBruta.New
      .CalculaMargemBruta(LParametrosServicoMargemBruta)
        .ResultadoCalculoMargemBruta
          .ValorMargemBruta;
end;

function TFaturamentoMargemServicosClasseMargemVenda.RetornarResultadoServicosClasseMargemVenda(
  const AParametros: IParametrosCalculoMargemVenda): IResultadoServicosClasseMargemVenda;
Var
  LResultadoCalculoMargemVenda : IResultadoCalculoMargemVenda;
begin
  LResultadoCalculoMargemVenda:=
    TCalculoMargemMargemVenda.New()
      .CalculaMargemVenda(AParametros);

  Result :=
    TResultadoServicosClasseMargemVenda.New()
      .ParametrosCalculoMargemVenda(AParametros)
      .ResultadoCalculoMargemVenda(LResultadoCalculoMargemVenda);
end;

function TFaturamentoMargemServicosClasseMargemVenda.RetornarValorFcpNoCalculoDaMargem: Boolean;
begin
  Result := false;

  if Not BaseIcmsDoItemOuEntregaFuturaOuPedidoOrcamentoParaEntregaFutura then
    Exit;

  Result := true;
end;

function TFaturamentoMargemServicosClasseMargemVenda.retornarValorMargemCat17: Double;
begin
  Result :=
    objCore.IIF( FParametros.ValorCat17  > 0,
      CalcularMargemInterna(FParametros.ValorUnitario, (FParametros.ValorCat17 + FParametros.OutrosValores), True),0);
end;

function TFaturamentoMargemServicosClasseMargemVenda.retornarValorMarkup: Double;
begin
  Result := (1 - (( FParametros.ValorDoIcms +  FParametros.ImpostosFederais + FParametros.ValorDoDifal +
	  FParametros.ValorDoFCP + FParametros.DespesasOperacionais + FParametros.DespesaOperacionalCliente +
    FParametros.ValorComissaoTabelaDeitens)/100));
end;


function TFaturamentoMargemServicosClasseMargemVenda.retornarValorDifalCalculo: Double;
begin
  Result := 0;

  If  FPrecoVendaDinamicoInfluenciadoPorImpostos Then
    Exit;

  Result := FParametros.ValorDoDifal;
end;

function TFaturamentoMargemServicosClasseMargemVenda.retornarValorDifalMargemInterna: Double;
begin
  Result := 0;

  If  FPrecoVendaDinamicoInfluenciadoPorImpostos Then
    Exit;

  Result := FValorDifal;
end;


function TFaturamentoMargemServicosClasseMargemVenda.retornarValorFCPCalculo: Double;
begin
  Result := 0;

  If  FPrecoVendaDinamicoInfluenciadoPorImpostos Then
    Exit;

  Result := FParametros.ValorDoFCP;

end;

function TFaturamentoMargemServicosClasseMargemVenda.retornarValorFCPMargemInterna: Double;
begin
  Result := 0;

  If  FPrecoVendaDinamicoInfluenciadoPorImpostos Then
    Exit;

  Result := FValorFcp;

end;

procedure TFaturamentoMargemServicosClasseMargemVenda.ZerarImpostos(Const ACalcularMargemLiquida : Boolean);
begin
  If (Not ACalcularMargemLiquida) Then
  begin
    FIcmsSaida            := 0;
    FImpostosFederais     := 0;
    FDespesasOperacionais := 0;
    FValorComissaoTabela  := 0;
    FValorDifal           := 0;
    FValorFcp             := 0;
    FIcmsSTPV             := 0;
  end;
end;

end.
