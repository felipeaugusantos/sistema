unit untParametrosComparacaoMargemVenda;

interface

type
  IParametrosComparacaoMargemVenda = interface
    ['{01EDD774-0854-497F-AB43-B4E745EA2E58}']
    function ValorUnitarioMargemMinima: Double; overload;
    function ValorUnitarioMargemMinima(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioCustoRealComMargemZero: Double; overload;
    function ValorUnitarioCustoRealComMargemZero(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaCustoReal: Double; overload;
    function ValorUnitarioMargemPraticadaCustoReal(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPropostaCustoReal: Double; overload;
    function ValorUnitarioMargemPropostaCustoReal(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPropostaCusto: Double; overload;
    function ValorUnitarioMargemPropostaCusto(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaCusto: Double; overload;
    function ValorUnitarioMargemPraticadaCusto(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoMedio: Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio: Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra: Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra: Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPraticada: Double; overload;
    function ValorUnitarioMargemPraticada(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaSemDespesasOperacionais: Double; overload;
    function ValorUnitarioMargemPraticadaSemDespesasOperacionais(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPrecoMedio: Double; overload;
    function ValorUnitarioMargemPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemProposta: Double; overload;
    function ValorUnitarioMargemProposta(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorMargemCat17: Double; overload;
    function ValorMargemCat17(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupProposto: Double; overload;
    function ValorUnitarioMarkupProposto(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupPraticado: Double; overload;
    function ValorUnitarioMarkupPraticado(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupPraticadoSemDespesasOperacionais: Double; overload;
    function ValorUnitarioMarkupPraticadoSemDespesasOperacionais(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupPrecoMedio: Double; overload;
    function ValorUnitarioMarkupPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioItemMargemPrecoMedio: Double; overload;
    function ValorUnitarioItemMargemPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioItemMargemProposta: Double; overload;
    function ValorUnitarioItemMargemProposta(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioItemMargemPraticadaLucro: Double; overload;
    function ValorUnitarioItemMargemPraticadaLucro(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorMargemIdeal: Double; overload;
    function ValorMargemIdeal(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPrecoIdeal: Double; overload;
    function ValorUnitarioMargemPrecoIdeal(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMarkupPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;
  end;

type
  TParametrosComparacaoMargemVenda = class(TInterfacedObject, IParametrosComparacaoMargemVenda)
  private
    FValorUnitarioMargemMinima                                       : Double;
    FValorUnitarioCustoRealComMargemZero                             : Double;
    FValorUnitarioMargemPraticadaCustoReal                           : Double;
    FValorUnitarioMargemPropostaCustoReal                            : Double;
    FValorUnitarioMargemPropostaCusto                                : Double;
    FValorUnitarioMargemPraticadaCusto                               : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoMedio                     : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoMedio                   : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra              : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra            : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos   : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos : Double;
    FValorUnitarioMargemPraticada                                    : Double;
    FValorUnitarioMargemPraticadaSemDespesasOperacionais             : Double;
    FValorUnitarioMargemPrecoMedio                                   : Double;
    FValorUnitarioMargemPrecoUltimaCompraComImpostos                 : Double;
    FValorUnitarioMargemProposta                                     : Double;
    FValorUnitarioMarkupProposto                                     : Double;
    FValorUnitarioMarkupPraticado                                    : Double;
    FValorUnitarioMarkupPraticadoSemDespesasOperacionais             : Double;
    FValorUnitarioMarkupPrecoMedio                                   : Double;
    FValorUnitarioItemMargemPrecoMedio                               : Double;
    FValorUnitarioItemMargemPrecoUltimaCompraComImpostos             : Double;
    FValorUnitarioItemMargemProposta                                 : Double;
    FValorUnitarioItemMargemPraticadaLucro                           : Double;
    FValorMargemIdeal                                                : Double;
    FValorUnitarioMargemPrecoIdeal                                   : Double;
    FValorMargemCat17                                                : Double;
    FValorUnitarioMarkupPrecoUltimaCompraComImpostos                 : Double;
  public
    function ValorUnitarioMargemMinima: Double; overload;
    function ValorUnitarioMargemMinima(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioCustoRealComMargemZero: Double; overload;
    function ValorUnitarioCustoRealComMargemZero(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaCustoReal: Double; overload;
    function ValorUnitarioMargemPraticadaCustoReal(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPropostaCustoReal: Double; overload;
    function ValorUnitarioMargemPropostaCustoReal(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPropostaCusto: Double; overload;
    function ValorUnitarioMargemPropostaCusto(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaCusto: Double; overload;
    function ValorUnitarioMargemPraticadaCusto(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoMedio: Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio: Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra: Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra: Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPraticada: Double; overload;
    function ValorUnitarioMargemPraticada(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaSemDespesasOperacionais: Double; overload;
    function ValorUnitarioMargemPraticadaSemDespesasOperacionais(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPrecoMedio: Double; overload;
    function ValorUnitarioMargemPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemProposta: Double; overload;
    function ValorUnitarioMargemProposta(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorMargemCat17: Double; overload;
    function ValorMargemCat17(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupProposto: Double; overload;
    function ValorUnitarioMarkupProposto(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupPraticado: Double; overload;
    function ValorUnitarioMarkupPraticado(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupPraticadoSemDespesasOperacionais: Double; overload;
    function ValorUnitarioMarkupPraticadoSemDespesasOperacionais(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupPrecoMedio: Double; overload;
    function ValorUnitarioMarkupPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioItemMargemPrecoMedio: Double; overload;
    function ValorUnitarioItemMargemPrecoMedio(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioItemMargemProposta: Double; overload;
    function ValorUnitarioItemMargemProposta(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioItemMargemPraticadaLucro: Double; overload;
    function ValorUnitarioItemMargemPraticadaLucro(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorMargemIdeal: Double; overload;
    function ValorMargemIdeal(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMargemPrecoIdeal: Double; overload;
    function ValorUnitarioMargemPrecoIdeal(AValue: Double) : IParametrosComparacaoMargemVenda; overload;

    function ValorUnitarioMarkupPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMarkupPrecoUltimaCompraComImpostos(AValue: Double) : IParametrosComparacaoMargemVenda; overload;


    class function New(): IParametrosComparacaoMargemVenda;
  end;

implementation

{ TParametrosComparacaoPrecoCusto }

class function TParametrosComparacaoMargemVenda.New: IParametrosComparacaoMargemVenda;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioCustoRealComMargemZero(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  Result := Self;
  FValorUnitarioCustoRealComMargemZero := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioCustoRealComMargemZero: Double;
begin
  Result := FValorUnitarioCustoRealComMargemZero;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPrecoIdeal: Double;
begin
  Result := FValorUnitarioMargemPrecoIdeal;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPrecoIdeal(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMargemPrecoIdeal := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemProposta(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMargemProposta := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemProposta: Double;
begin
  result := FValorUnitarioMargemProposta;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemBrutaPraticadaPrecoMedio := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorMargemCat17: Double;
begin
  result := FValorMargemCat17;
end;

function TParametrosComparacaoMargemVenda.ValorMargemCat17(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := self;
  FValorMargemCat17 := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoMedio;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioItemMargemProposta: Double;
begin
  result := FValorUnitarioItemMargemProposta;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioItemMargemProposta(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemProposta := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorMargemIdeal: Double;
begin
  result := FValorMargemIdeal;
end;

function TParametrosComparacaoMargemVenda.ValorMargemIdeal(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorMargemIdeal := AValue;

end;

function TParametrosComparacaoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPrecoUltimaCompraComImpostos := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos: Double;
begin
  Result := FValorUnitarioItemMargemPrecoUltimaCompraComImpostos;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoMedio := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoMedio;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioItemMargemPraticadaLucro: Double;
begin
  result := FValorUnitarioItemMargemPraticadaLucro;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioItemMargemPraticadaLucro(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPraticadaLucro := Avalue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPrecoMedio: Double;
begin
  result := FValorUnitarioMargemPrecoMedio;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPrecoMedio(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPrecoMedio := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioItemMargemPrecoMedio: Double;
begin
  result := FValorUnitarioItemMargemPrecoMedio;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioItemMargemPrecoMedio(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPrecoMedio := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemMinima(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemMinima := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemMinima: Double;
begin
  result := FValorUnitarioMargemMinima;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPraticada: Double;
begin
  Result := FValorUnitarioMargemPraticada;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPraticada(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemPraticada := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPraticadaCusto: Double;
begin
  result := FValorUnitarioMargemPraticadaCusto;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPraticadaCusto(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPraticadaCusto := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPraticadaCustoReal(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPraticadaCustoReal := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPraticadaCustoReal: Double;
begin
  result := FValorUnitarioMargemPraticadaCustoReal;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioMargemPrecoUltimaCompraComImpostos;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemPrecoUltimaCompraComImpostos := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPropostaCusto(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPropostaCusto := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPropostaCusto: Double;
begin
  result := FValorUnitarioMargemPropostaCusto;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPropostaCustoReal(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPropostaCustoReal := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPropostaCustoReal: Double;
begin
  result := FValorUnitarioMargemPropostaCustoReal;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPraticadaSemDespesasOperacionais(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemPraticadaSemDespesasOperacionais := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMargemPraticadaSemDespesasOperacionais: Double;
begin
  result := FValorUnitarioMargemPraticadaSemDespesasOperacionais;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupPrecoMedio: Double;
begin
  result := FValorUnitarioMarkupPrecoMedio;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupPrecoMedio(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMarkupPrecoMedio := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupPrecoUltimaCompraComImpostos: Double;
begin
  Result := FValorUnitarioMarkupPrecoUltimaCompraComImpostos;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMarkupPrecoUltimaCompraComImpostos := AValue;

end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupPraticado: Double;
begin
  result := FValorUnitarioMarkupPraticado;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupPraticado(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMarkupPraticado := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupPraticadoSemDespesasOperacionais: Double;
begin
  result := FValorUnitarioMarkupPraticadoSemDespesasOperacionais;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupPraticadoSemDespesasOperacionais(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMarkupPraticadoSemDespesasOperacionais := AValue;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupProposto: Double;
begin
  result := FValorUnitarioMarkupProposto;
end;

function TParametrosComparacaoMargemVenda.ValorUnitarioMarkupProposto(
  AValue: Double): IParametrosComparacaoMargemVenda;
begin
  result := Self;
  FValorUnitarioMarkupProposto := AValue;
end;



end.
