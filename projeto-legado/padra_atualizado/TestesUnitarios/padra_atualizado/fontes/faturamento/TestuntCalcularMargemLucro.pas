unit TestuntCalcularMargemLucro;

interface

Uses
  Data.DB,
  TestFramework,
  untTestConfiguracoes,
  UniClientDataSet,
  System.Generics.Collections,
  Shared.Functions.Configuracoes,
  untCalcularMargemLucro,
  untFuncoes,
  Faturamento.Margem.Interfaces.MargemVenda,
  Faturamento.Margem.Tipos.MargemVenda,
  Controller.Faturamento.Margem.MargemVenda,
  System.SysUtils, Shared.Functions.Core,
  Faturamento.Margem.Interfaces.Servicos.Disponiveis.MargemVenda,
  Faturamento.Margem.Servicos.Disponiveis.MargemVenda;

type
  // Test methods for class TCalculoImpostosFCP

  TestTCalcularMargemLucro = class(TTestCase)
  strict private
    cdsDados : TUniClientDataSet;
  private

    procedure pCriarCdsDados;

    procedure pCarregarCdsCaso01;
    procedure pCarregarCdsCaso02;
    procedure pCarregarCdsCaso03;
    function RetornarMargemCaso02: TList<IResultadoCalculoMargemVenda>;


  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalcularMargemVendaApenasUmRegistros;
    procedure TestCalcularMargemVendaVariosRegistros;
//    procedure TestCalcularMargemVendaSemRegistros;
  end;

implementation

{ TestTCalcularMargemLucro }

procedure TestTCalcularMargemLucro.pCarregarCdsCaso01;
begin
  cdsDados.Append;
  cdsDados.FieldByName('ITE_CLAFIS').AsString := '6403';
  cdsDados.FieldByName('PED_ORC_ENT_FUT').AsBoolean := False;
  cdsDados.FieldByName('ITE_IMPFED').AsFloat := 1;
  cdsDados.FieldByName('ITE_PREMED').AsFloat := 0;
  cdsDados.FieldByName('ITE_PREULT').AsFloat := 0;
  cdsDados.FieldByName('ITE_CALCST_MARGEM').AsBoolean := False;
  cdsDados.FieldByName('ITE_UNIORI').AsFloat := 692.908;
  cdsDados.FieldByName('ITE_UNITAR').AsFloat := 692.908;
  cdsDados.FieldByName('ITE_ICMCAL').AsFloat := 18;
  cdsDados.FieldByName('ITE_BASICM').AsFloat := 18;
  cdsDados.FieldByName('ITE_VDIFAL').AsFloat := 0;
  cdsDados.FieldByName('ITE_VALFCP').AsFloat := 0;
  cdsDados.FieldByName('ITE_DESOPE').AsFloat := 2;
  cdsDados.FieldByName('ITE_DESOPE_CLI').AsFloat := 0;
  cdsDados.FieldByName('ITE_COMTBL').AsFloat := 0;
  cdsDados.FieldByName('ITE_CUSPRA').AsFloat := 375.218;
  cdsDados.FieldByName('ITE_CUSITE').AsFloat := 375.218;
  cdsDados.FieldByName('ITE_OUTVAL').AsFloat := 1;
  cdsDados.FieldByName('ITE_IMPULT').AsFloat := 0;
  cdsDados.FieldByName('ITE_VAL_ST').AsFloat := 124.73;
  cdsDados.FieldByName('ITE_ICMPAV_MARGEM').AsFloat := 0;
  cdsDados.FieldByName('ITE_CUSCAT').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MKPMAR4').AsFloat := 0;
  cdsDados.FieldByName('ITE_CALMAR_PREDIN_MAR').AsFloat := 0;
  cdsDados.FieldByName('ITE_CALMAR_PREDIN_MARLIQ').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARMED').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARIMP').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARITE').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARLUC').AsFloat := 0;
  cdsDados.FieldByName('ITE_MARMIN').AsFloat := 40;
  cdsDados.FieldByName('ITE_PREIDE').AsFloat := 476.225;
  cdsDados.FieldByName('ITE_ICMSAI_PREIDE').AsFloat := 18;
  cdsDados.FieldByName('ITE_CUSREA').AsFloat := 0;
  cdsDados.Post;
end;

procedure TestTCalcularMargemLucro.pCarregarCdsCaso02;
begin
  cdsDados.Append;
  cdsDados.FieldByName('ITE_CLAFIS').AsString := '6403';
  cdsDados.FieldByName('PED_ORC_ENT_FUT').AsBoolean := False;
  cdsDados.FieldByName('ITE_IMPFED').AsFloat := 1;
  cdsDados.FieldByName('ITE_PREMED').AsFloat := 0;
  cdsDados.FieldByName('ITE_PREULT').AsFloat := 0;
  cdsDados.FieldByName('ITE_CALCST_MARGEM').AsBoolean := False;
  cdsDados.FieldByName('ITE_UNIORI').AsFloat := 692.908;
  cdsDados.FieldByName('ITE_UNITAR').AsFloat := 692.908;
  cdsDados.FieldByName('ITE_ICMCAL').AsFloat := 0;
  cdsDados.FieldByName('ITE_BASICM').AsFloat := 0;
  cdsDados.FieldByName('ITE_VDIFAL').AsFloat := 0;
  cdsDados.FieldByName('ITE_VALFCP').AsFloat := 0;
  cdsDados.FieldByName('ITE_DESOPE').AsFloat := 2;
  cdsDados.FieldByName('ITE_DESOPE_CLI').AsFloat := 0;
  cdsDados.FieldByName('ITE_COMTBL').AsFloat := 0;
  cdsDados.FieldByName('ITE_CUSPRA').AsFloat := 375.218;
  cdsDados.FieldByName('ITE_CUSITE').AsFloat := 375.218;
  cdsDados.FieldByName('ITE_OUTVAL').AsFloat := 1;
  cdsDados.FieldByName('ITE_IMPULT').AsFloat := 0;
  cdsDados.FieldByName('ITE_VAL_ST').AsFloat := 0;
  cdsDados.FieldByName('ITE_ICMPAV_MARGEM').AsFloat := 0;
  cdsDados.FieldByName('ITE_CUSCAT').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MKPMAR4').AsFloat := 0;
  cdsDados.FieldByName('ITE_CALMAR_PREDIN_MAR').AsFloat := 0;
  cdsDados.FieldByName('ITE_CALMAR_PREDIN_MARLIQ').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARMED').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARIMP').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARITE').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARLUC').AsFloat := 0;
  cdsDados.FieldByName('ITE_MARMIN').AsFloat := 40;
  cdsDados.FieldByName('ITE_PREIDE').AsFloat := 476.225;
  cdsDados.FieldByName('ITE_ICMSAI_PREIDE').AsFloat := 18;
  cdsDados.FieldByName('ITE_CUSREA').AsFloat := 0;
  cdsDados.Post;
end;

procedure TestTCalcularMargemLucro.pCarregarCdsCaso03;
begin
  cdsDados.Append;
  cdsDados.FieldByName('ITE_CLAFIS').AsString := '6403';
  cdsDados.FieldByName('PED_ORC_ENT_FUT').AsBoolean := False;
  cdsDados.FieldByName('ITE_IMPFED').AsFloat := 1;
  cdsDados.FieldByName('ITE_PREMED').AsFloat := 0;
  cdsDados.FieldByName('ITE_PREULT').AsFloat := 0;
  cdsDados.FieldByName('ITE_CALCST_MARGEM').AsBoolean := False;
  cdsDados.FieldByName('ITE_UNIORI').AsFloat := 692.908;
  cdsDados.FieldByName('ITE_UNITAR').AsFloat := 692.908;
  cdsDados.FieldByName('ITE_ICMCAL').AsFloat := 0;
  cdsDados.FieldByName('ITE_BASICM').AsFloat := 0;
  cdsDados.FieldByName('ITE_VDIFAL').AsFloat := 0;
  cdsDados.FieldByName('ITE_VALFCP').AsFloat := 0;
  cdsDados.FieldByName('ITE_DESOPE').AsFloat := 2;
  cdsDados.FieldByName('ITE_DESOPE_CLI').AsFloat := 0;
  cdsDados.FieldByName('ITE_COMTBL').AsFloat := 0;
  cdsDados.FieldByName('ITE_CUSPRA').AsFloat := 375.218;
  cdsDados.FieldByName('ITE_CUSITE').AsFloat := 375.218;
  cdsDados.FieldByName('ITE_OUTVAL').AsFloat := 1;
  cdsDados.FieldByName('ITE_IMPULT').AsFloat := 0;
  cdsDados.FieldByName('ITE_VAL_ST').AsFloat := 0;
  cdsDados.FieldByName('ITE_ICMPAV_MARGEM').AsFloat := 0;
  cdsDados.FieldByName('ITE_CUSCAT').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MKPMAR4').AsFloat := 0;
  cdsDados.FieldByName('ITE_CALMAR_PREDIN_MAR').AsFloat := 0;
  cdsDados.FieldByName('ITE_CALMAR_PREDIN_MARLIQ').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARMED').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARIMP').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARITE').AsFloat := 0;
  cdsDados.FieldByName('ITE_ALQDIFICM_MARLUC').AsFloat := 0;
  cdsDados.FieldByName('ITE_MARMIN').AsFloat := 40;
  cdsDados.FieldByName('ITE_PREIDE').AsFloat := 476.225;
  cdsDados.FieldByName('ITE_ICMSAI_PREIDE').AsFloat := 18;
  cdsDados.FieldByName('ITE_CUSREA').AsFloat := 375.218;
  cdsDados.Post;
end;

procedure TestTCalcularMargemLucro.pCriarCdsDados;
begin

  cdsDados := TUniClientDataSet.Create(Nil);
  cdsDados.Close;

  cdsDados.FieldDefs.Clear;
  cdsDados.FieldDefs.add('ITE_CLAFIS',ftString,100);
  cdsDados.FieldDefs.add('PED_ORC_ENT_FUT',ftBoolean);
  cdsDados.FieldDefs.add('ITE_IMPFED', ftFloat);
  cdsDados.FieldDefs.add('ITE_PREMED', ftFloat);
  cdsDados.FieldDefs.add('ITE_PREULT', ftFloat);
  cdsDados.FieldDefs.add('ITE_CALCST_MARGEM',ftBoolean);
  cdsDados.FieldDefs.add('ITE_UNIORI', ftFloat);
  cdsDados.FieldDefs.add('ITE_UNITAR', ftFloat);
  cdsDados.FieldDefs.add('ITE_ICMCAL', ftFloat);
  cdsDados.FieldDefs.add('ITE_BASICM', ftFloat);
  cdsDados.FieldDefs.add('ITE_VDIFAL', ftFloat);
  cdsDados.FieldDefs.add('ITE_VALFCP', ftFloat);
  cdsDados.FieldDefs.add('ITE_DESOPE', ftFloat);
  cdsDados.FieldDefs.add('ITE_DESOPE_CLI', ftFloat);
  cdsDados.FieldDefs.add('ITE_COMTBL', ftFloat);
  cdsDados.FieldDefs.add('ITE_CUSPRA', ftFloat);
  cdsDados.FieldDefs.add('ITE_MEDPRA', ftFloat);
  cdsDados.FieldDefs.add('ITE_IMPULTPRA', ftFloat);
  cdsDados.FieldDefs.add('ITE_CUSITE', ftFloat);
  cdsDados.FieldDefs.add('ITE_OUTVAL', ftFloat);
  cdsDados.FieldDefs.add('ITE_IMPULT', ftFloat);
  cdsDados.FieldDefs.add('ITE_VAL_ST', ftFloat);
  cdsDados.FieldDefs.add('ITE_ICMPAV_MARGEM', ftFloat);
  cdsDados.FieldDefs.add('ITE_CUSCAT', ftFloat);
  cdsDados.FieldDefs.add('ITE_ALQDIFICM_MKPMAR4', ftFloat);
  cdsDados.FieldDefs.add('ITE_CALMAR_PREDIN_MAR', ftFloat);
  cdsDados.FieldDefs.add('ITE_CALMAR_PREDIN_MARLIQ', ftFloat);
  cdsDados.FieldDefs.add('ITE_ALQDIFICM_MARMED', ftFloat);
  cdsDados.FieldDefs.add('ITE_ALQDIFICM_MARIMP', ftFloat);
  cdsDados.FieldDefs.add('ITE_ALQDIFICM_MARITE', ftFloat);
  cdsDados.FieldDefs.add('ITE_ALQDIFICM_MARLUC', ftFloat);
  cdsDados.FieldDefs.add('ITE_MARMIN', ftFloat);
  cdsDados.FieldDefs.add('ITE_PREIDE', ftFloat);
  cdsDados.FieldDefs.add('ITE_ICMSAI_PREIDE', ftFloat);
  cdsDados.FieldDefs.add('ITE_CUSREA', ftFloat);


  cdsDados.CreateDataSet;
end;

function TestTCalcularMargemLucro.RetornarMargemCaso02: TList<IResultadoCalculoMargemVenda>;
var
  LResultadoCalculoMargemvendaLista1 : IResultadoCalculoMargemvenda;
  LResultadoCalculoMargemvendaLista2 : IResultadoCalculoMargemvenda;
  LResultadoCalculoMargemvendaLista3 : IResultadoCalculoMargemvenda;
begin

  LResultadoCalculoMargemvendaLista1 :=
    TResultadoCalculoMargemVenda.New
      .ValorUnitarioMargemPrecoIdeal(-0.00024999999999975)
      .ValorUnitarioMargemPraticada(171.17932)
      .ValorUnitarioMargemPraticadaSemDespesasOperacionais(185.03748)
      .ValorUnitarioMargemPrecoMedio(547.39732)
      .ValorUnitarioMargemPrecoUltimaCompraComImpostos(546.39732)
      .ValorUnitarioMargemProposta(171.17932)
      .ValorUnitarioMargemMinima(40)
      .ValorUnitarioCustoRealComMargemZero(476.225316455696)
      .ValorUnitarioMargemPraticadaCustoReal(45.5)
      .ValorUnitarioMargemPropostaCustoReal(45.5)
      .ValorUnitarioMargemPropostaCusto(84.67)
      .ValorUnitarioMargemPraticadaCusto(84.67)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(0)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(54639.73)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(0)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(54639.73)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(0)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(54639.73)
      .ValorUnitarioMarkupPraticado(547.39732)
      .ValorUnitarioMarkupPraticadoSemDespesasOperacionais(561.25548)
      .ValorUnitarioMarkupProposto(547.39732)
      .ValorUnitarioMarkupPrecoMedio(547.39732)
      .ValorUnitarioMarkupPrecoUltimaCompraComImpostos(1.26582278481013)
      .ValorUnitarioItemMargemPrecoMedio(0)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(54639.73)
      .ValorUnitarioItemMargemProposta(45.5)
      .ValorUnitarioItemMargemPraticadaLucro(45.5)
      .ValorMargemCat17(0)
      .ValorMargemPraticadaCustoReal(0)
      .ValorMargemPropostaCustoReal(0)
      .ValorUnitarioMargemPraticadaCustoRealFrete(692.908)
      .ValorUnitarioMargemPropostaCustoRealFrete(692.908);

  LResultadoCalculoMargemvendaLista2 :=
    TResultadoCalculoMargemVenda.New
      .ValorUnitarioMargemPrecoIdeal(-0.00024999999999975)
      .ValorUnitarioMargemPraticada(295.90276)
      .ValorUnitarioMargemPraticadaSemDespesasOperacionais(309.76092)
      .ValorUnitarioMargemPrecoMedio(672.12076)
      .ValorUnitarioMargemPrecoUltimaCompraComImpostos(671.12076)
      .ValorUnitarioMargemProposta(295.90276)
      .ValorUnitarioMargemMinima(40)
      .ValorUnitarioCustoRealComMargemZero(387.853608247423)
      .ValorUnitarioMargemPraticadaCustoReal(78.65)
      .ValorUnitarioMargemPropostaCustoReal(78.65)
      .ValorUnitarioMargemPropostaCusto(84.67)
      .ValorUnitarioMargemPraticadaCusto(84.67)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(0)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(67112.08)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(0)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(67112.08)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(0)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(67112.08)
      .ValorUnitarioMarkupPraticado(672.12076)
      .ValorUnitarioMarkupPraticadoSemDespesasOperacionais(685.97892)
      .ValorUnitarioMarkupProposto(672.12076)
      .ValorUnitarioMarkupPrecoMedio(672.12076)
      .ValorUnitarioMarkupPrecoUltimaCompraComImpostos(1.03092783505155)
      .ValorUnitarioItemMargemPrecoMedio(0)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(67112.08)
      .ValorUnitarioItemMargemProposta(78.65)
      .ValorUnitarioItemMargemPraticadaLucro(78.65)
      .ValorMargemCat17(0)
      .ValorMargemPraticadaCustoReal(0)
      .ValorMargemPropostaCustoReal(0)
      .ValorUnitarioMargemPraticadaCustoRealFrete(692.908)
      .ValorUnitarioMargemPropostaCustoRealFrete(692.908);

  LResultadoCalculoMargemvendaLista3 :=
    TResultadoCalculoMargemVenda.New
      .ValorUnitarioMargemPrecoIdeal(-0.00024999999999975)
      .ValorUnitarioMargemPraticada(295.90276)
      .ValorUnitarioMargemPraticadaSemDespesasOperacionais(309.76092)
      .ValorUnitarioMargemPrecoMedio(672.12076)
      .ValorUnitarioMargemPrecoUltimaCompraComImpostos(671.12076)
      .ValorUnitarioMargemProposta(295.90276)
      .ValorUnitarioMargemMinima(40)
      .ValorUnitarioCustoRealComMargemZero(387.853608247423)
      .ValorUnitarioMargemPraticadaCustoReal(78.65)
      .ValorUnitarioMargemPropostaCustoReal(78.65)
      .ValorUnitarioMargemPropostaCusto(84.67)
      .ValorUnitarioMargemPraticadaCusto(84.67)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(0)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(67112.08)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(0)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(67112.08)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(0)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(67112.08)
      .ValorUnitarioMarkupPraticado(672.12076)
      .ValorUnitarioMarkupPraticadoSemDespesasOperacionais(685.97892)
      .ValorUnitarioMarkupProposto(672.12076)
      .ValorUnitarioMarkupPrecoMedio(672.12076)
      .ValorUnitarioMarkupPrecoUltimaCompraComImpostos(1.03092783505155)
      .ValorUnitarioItemMargemPrecoMedio(0)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(67112.08)
      .ValorUnitarioItemMargemProposta(78.65)
      .ValorUnitarioItemMargemPraticadaLucro(78.65)
      .ValorMargemCat17(0)
      .ValorMargemPraticadaCustoReal(84.67)
      .ValorMargemPropostaCustoReal(84.67)
      .ValorUnitarioMargemPraticadaCustoRealFrete(317.69)
      .ValorUnitarioMargemPropostaCustoRealFrete(317.69);


  Result := TList<IResultadoCalculoMargemVenda>.Create;

  Result.Add(LResultadoCalculoMargemvendaLista1);
  Result.Add(LResultadoCalculoMargemvendaLista2);
  Result.Add(LResultadoCalculoMargemvendaLista3);

end;

procedure TestTCalcularMargemLucro.SetUp;
begin
  inherited;

end;

procedure TestTCalcularMargemLucro.TearDown;
begin
  inherited;

end;

procedure TestTCalcularMargemLucro.TestCalcularMargemVendaApenasUmRegistros;
Var
  ReturnValue      : TList<IResultadoCalculoMargemVenda>;
  LContador        : Integer;
begin
  LContador := 0;

  pCriarCdsDados;
  pCarregarCdsCaso01;

  ReturnValue :=
    TCalcularMargemLucro.New(false)
      .MontarListaDeParamatrosParaCalculoDaMargemDeLucro(cdsDados)
        .CalcularMargemDeLucro;

  CheckTrue(
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemPrecoIdeal, objCore.fStrToFloat('-0,00024999999999975')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemPraticada, objCore.fStrToFloat('171,17932')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemPraticadaSemDespesasOperacionais, objCore.fStrToFloat('185,03748')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemPrecoMedio, objCore.fStrToFloat('547,39732')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemPrecoUltimaCompraComImpostos, objCore.fStrToFloat('546,39732')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemProposta, objCore.fStrToFloat('171,17932')) And

    CompararValores(ReturnValue[LContador].ValorUnitarioMargemMinima, 40) And
    CompararValores(ReturnValue[LContador].ValorUnitarioCustoRealComMargemZero, objCore.fStrToFloat('476,225316455696')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemPraticadaCustoReal, objCore.fStrToFloat('45,5')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemPropostaCustoReal, objCore.fStrToFloat('45,5')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemPropostaCusto, objCore.fStrToFloat('84,67')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemPraticadaCusto, objCore.fStrToFloat('84,67')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemBrutaPraticadaPrecoMedio, 0) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemLiquidaPraticadaPrecoMedio, objCore.fStrToFloat('54639,73')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra, 0) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra, objCore.fStrToFloat('54639,73')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos, 0) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos, objCore.fStrToFloat('54639,73')) And

    CompararValores(ReturnValue[LContador].ValorUnitarioMarkupPraticado, objCore.fStrToFloat('547,39732')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMarkupPraticadoSemDespesasOperacionais, objCore.fStrToFloat('561,25548')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMarkupProposto, objCore.fStrToFloat('547,39732')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioMarkupPrecoMedio, objCore.fStrToFloat('547,39732')) And

    CompararValores(ReturnValue[LContador].ValorUnitarioMarkupPrecoUltimaCompraComImpostos, objCore.fStrToFloat('1,26582278481013')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioItemMargemPrecoMedio, 0) And
    CompararValores(ReturnValue[LContador].ValorUnitarioItemMargemPrecoUltimaCompraComImpostos, objCore.fStrToFloat('54639,73')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioItemMargemProposta, objCore.fStrToFloat('45,5')) And
    CompararValores(ReturnValue[LContador].ValorUnitarioItemMargemPraticadaLucro, objCore.fStrToFloat('45,5')) And

    CompararValores(ReturnValue[LContador].ValorMargemCat17, 0)
  );


  if Assigned(cdsDados) Then
    FreeAndNil(cdsDados);
end;



{procedure TestTCalcularMargemLucro.TestCalcularMargemVendaSemRegistros;
Var
  ReturnValue      : TList<IResultadoCalculoMargemVenda>;
  ComparacaoValue  : TList<IResultadoCalculoMargemVenda>;
begin
  pCriarCdsDados;

  ComparacaoValue := TList<IResultadoCalculoMargemVenda>.Create;

  ReturnValue :=
    TCalcularMargemLucro.New(false)
      .MontarListaDeParamatrosParaCalculoDaMargemDeLucro(cdsDados)
        .CalcularMargemDeLucro;

  CheckTrue((ReturnValue.List = ComparacaoValue.List));
end;
}

procedure TestTCalcularMargemLucro.TestCalcularMargemVendaVariosRegistros;
Var
  ReturnValue      : TList<IResultadoCalculoMargemVenda>;
  ReturnComparacao : TList<IResultadoCalculoMargemVenda>;

  LValidado   : Boolean;
  LContador   : Integer;
begin
  pCriarCdsDados;

  pCarregarCdsCaso01;
  pCarregarCdsCaso02;
  pCarregarCdsCaso03;

  ReturnValue :=
    TCalcularMargemLucro.New(true)
      .MontarListaDeParamatrosParaCalculoDaMargemDeLucro(cdsDados)
        .CalcularMargemDeLucro;


  ReturnComparacao := RetornarMargemCaso02;

  LValidado := true;

  For LContador := 0 to Pred(ReturnValue.Count) do
  begin
    If LContador > 0 Then
      objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONFIGURACAO_PARA_MARGEM_MARKUP, '4');

    LValidado :=
    (
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPrecoIdeal                                  , ReturnComparacao[LContador].ValorUnitarioMargemPrecoIdeal) And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemMinima                                      , ReturnComparacao[LContador].ValorUnitarioMargemMinima)And
      CompararValores(ReturnValue[LContador].ValorUnitarioCustoRealComMargemZero                            , ReturnComparacao[LContador].ValorUnitarioCustoRealComMargemZero)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPraticadaCustoReal                          , ReturnComparacao[LContador].ValorUnitarioMargemPraticadaCustoReal)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPropostaCustoReal                           , ReturnComparacao[LContador].ValorUnitarioMargemPropostaCustoReal)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPropostaCusto                               , ReturnComparacao[LContador].ValorUnitarioMargemPropostaCusto)And

      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPraticadaCusto                              , ReturnComparacao[LContador].ValorUnitarioMargemPraticadaCusto ) And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemBrutaPraticadaPrecoMedio                    , ReturnComparacao[LContador].ValorUnitarioMargemBrutaPraticadaPrecoMedio)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemLiquidaPraticadaPrecoMedio                  , ReturnComparacao[LContador].ValorUnitarioMargemLiquidaPraticadaPrecoMedio)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra             , ReturnComparacao[LContador].ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra           , ReturnComparacao[LContador].ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos  , ReturnComparacao[LContador].ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos, ReturnComparacao[LContador].ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos)And


      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPraticada                                   , ReturnComparacao[LContador].ValorUnitarioMargemPraticada)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPraticadaSemDespesasOperacionais            , ReturnComparacao[LContador].ValorUnitarioMargemPraticadaSemDespesasOperacionais)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPrecoMedio                                  , ReturnComparacao[LContador].ValorUnitarioMargemPrecoMedio)And

      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPrecoUltimaCompraComImpostos                , ReturnComparacao[LContador].ValorUnitarioMargemPrecoUltimaCompraComImpostos)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemProposta                                    , ReturnComparacao[LContador].ValorUnitarioMargemProposta)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMarkupProposto                                    , ReturnComparacao[LContador].ValorUnitarioMarkupProposto )And

      CompararValores(ReturnValue[LContador].ValorUnitarioMarkupPraticado                                   , ReturnComparacao[LContador].ValorUnitarioMarkupPraticado)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMarkupPraticadoSemDespesasOperacionais            , ReturnComparacao[LContador].ValorUnitarioMarkupPraticadoSemDespesasOperacionais)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMarkupPrecoMedio                                  , ReturnComparacao[LContador].ValorUnitarioMarkupPrecoMedio)And
      CompararValores(ReturnValue[LContador].ValorUnitarioItemMargemPrecoMedio                              , ReturnComparacao[LContador].ValorUnitarioItemMargemPrecoMedio)And

      CompararValores(ReturnValue[LContador].ValorUnitarioItemMargemPrecoUltimaCompraComImpostos            , ReturnComparacao[LContador].ValorUnitarioItemMargemPrecoUltimaCompraComImpostos)And
      CompararValores(ReturnValue[LContador].ValorUnitarioItemMargemProposta                                , ReturnComparacao[LContador].ValorUnitarioItemMargemProposta)And
      CompararValores(ReturnValue[LContador].ValorUnitarioItemMargemPraticadaLucro                          , ReturnComparacao[LContador].ValorUnitarioItemMargemPraticadaLucro)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMarkupPrecoUltimaCompraComImpostos                , ReturnComparacao[LContador].ValorUnitarioMarkupPrecoUltimaCompraComImpostos)And
      CompararValores(ReturnValue[LContador].ValorMargemCat17                                               , ReturnComparacao[LContador].ValorMargemCat17)And
      CompararValores(ReturnValue[LContador].ValorMargemPraticadaCustoReal                                  , ReturnComparacao[LContador].ValorMargemPraticadaCustoReal)And
      CompararValores(ReturnValue[LContador].ValorMargemPropostaCustoReal                                   , ReturnComparacao[LContador].ValorMargemPropostaCustoReal)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPraticadaCustoRealFrete                     , ReturnComparacao[LContador].ValorUnitarioMargemPraticadaCustoRealFrete)And
      CompararValores(ReturnValue[LContador].ValorUnitarioMargemPropostaCustoRealFrete                      , ReturnComparacao[LContador].ValorUnitarioMargemPropostaCustoRealFrete));

     If Not LValidado Then
       Break;
  end;

  CheckTrue(LValidado);

  if Assigned(cdsDados) Then
    FreeAndNil(cdsDados);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTCalcularMargemLucro.Suite);

end.
