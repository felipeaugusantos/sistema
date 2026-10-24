unit untFatMostraMargemNovoAdicionarTinta;

interface

uses System.SysUtils, untIFatMostraMargemNovo, UniClientDataSet, untFuncoesSimples,
  untFuncFatTypes, untFuncFat;

type
  TFatMostraMargemNovoAdicionarTinta = class(TInterfacedObject, IFatMostraMargemNovoAdicionarTinta)
  private
    FDecUni: Integer;

    function fGetMargem(const fltPreVen, fltIcmsSaida, fltImpostosFederais,
      fltDespesasOperacionais, fltOutrosValores, fltPrecoCusto, fltImpDifal, fltImpFcp: Double; strMarMkp: String = ''): Double;
  public
    function RetornarValorMargemPropostaCustoDoItem(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemPraticadaCustoDoItem(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemPropostaPrecoDeCusto(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemPraticadaPrecoDeCusto(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemBrutaPrecoMedio(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemLiquidaPrecoMedio(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemBrutaPrecoDeUltimaCompra(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemLiquidaPrecoDeUltimaCompra(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemBrutaPrecoDeUltimaCompraComImpostos(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemLiquidaPrecoDeUltimaCompraComImpostos(cdsItens: TUniClientDataSet): Double;

    function fRetornaPrecoCustoRealSub(fltParPrecoCusto: Double; fltParPrecoVenda : Double; cdsItens: TUniClientDataSet; fatVenda: TFatVenda): Double;

    procedure SetDecUni(intDecUni: Integer);

    function RetornarValorMargemPraticadaPrecoDeCustoBruta(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemLiquidaPrecoMedioBruta(cdsItens: TUniClientDataSet): Double;

    class function New(): IFatMostraMargemNovoAdicionarTinta;
  end;

implementation

{ TFatMostraMargemNovoAdicionarTinta }

function TFatMostraMargemNovoAdicionarTinta.fGetMargem(const fltPreVen, fltIcmsSaida, fltImpostosFederais,
      fltDespesasOperacionais, fltOutrosValores, fltPrecoCusto, fltImpDifal, fltImpFcp: Double; strMarMkp: String = ''): Double;
  Var
    fltMargem: Double;
    fltIcmsai: Double;
    fltImpFed: Double;
    fltDesOpe: Double;
    fltDifal : Double;
    fltFcp   : Double;
begin
  Result    := 0.0;
  fltMargem := 0.0;

  If fEmptyStr(strMarMkp) Then
    strMarMkp := fCfgSis('MARMKP');

  Try
    Try
      if fltPreVen > 0 then
      begin
        fltIcmsai := 100 * (fltIcmsSaida / fltPreVen);
        fltImpFed := 100 * (fltImpostosFederais / fltPreVen);
        fltDesOpe := 100 * (fltDespesasOperacionais / fltPreVen);
        fltDifal  := 100 * (fltImpDifal / fltPreVen);
        fltFcp    := 100 * (fltImpFcp / fltPreVen);

        fltMargem := fCalculaPrecoVenda(2,
          fltPrecoCusto + fltOutrosValores,
          fltPreVen,
          0,
          fltIcmsai,
          fltImpFed,
          fltDesOpe,
          0,
          strMarMkp,
          fCfgSis('PCMPRO'),
          FDecUni,
          0,
          False,
          fltDifal,
          fltFcp);
      end;

      Result := fltMargem;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFatMostraMargemNovoAdicionarTinta.fRetornaPrecoCustoRealSub(fltParPrecoCusto: Double; fltParPrecoVenda : Double; cdsItens: TUniClientDataSet; fatVenda: TFatVenda): Double;
  Var
    calcCustoReal : TCalcCustoReal;
begin
  calcCustoReal := TCalcCustoReal.Create;
  Try
    calcCustoReal.fltUnitar := fltParPrecoVenda;
    calcCustoReal.fltPreCus := fltParPrecoCusto;
    calcCustoReal.fltOutVal := cdsItens.FieldByName('ITE_OUTVAL').AsFloat;

    If fFormataFloat(fltParPrecoVenda, FDecUni) <> 0 Then
    Begin
      calcCustoReal.fltIcmSai := 100*(cdsItens.FieldByName('ITE_ICMSAI').AsFloat/fltParPrecoVenda);
      calcCustoReal.fltImpFed := 100*(cdsItens.FieldByName('ITE_IMPFED').AsFloat/fltParPrecoVenda);
      calcCustoReal.fltDesOpe := 100*((cdsItens.FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli)/fltParPrecoVenda);
      calcCustoReal.fltDifal  := 100*(cdsItens.FieldByName('ITE_VDIFAL').AsFloat/fltParPrecoVenda);

      If (cdsItens.FieldByName('ITE_VAL_ST').AsFloat = 0) Then
        calcCustoReal.fltFcp  := 100*(cdsItens.FieldByName('ITE_VALFCP').AsFloat/fltParPrecoVenda);
    End;

    Result := fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                          cdsItens.FieldByName('ITE_CODITE').AsString,
                                          cdsItens.FieldByName('ITE_EMPITE').AsString,
                                          fltParPrecoCusto,
                                          '',
                                          calcCustoReal,
                                          (Pos('ITEM ESPECIAL', cdsItens.FieldByName('ITE_DESITE').AsString) > 0));
  Finally
    FreeAndNil(calcCustoReal);
  End;
end;

class function TFatMostraMargemNovoAdicionarTinta.New: IFatMostraMargemNovoAdicionarTinta;
begin
  Result := Self.Create;
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemBrutaPrecoDeUltimaCompra(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat, 0, 0, 0, 0, cdsItens.FieldByName('ITE_PREULT').AsFloat, 0, 0);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemBrutaPrecoDeUltimaCompraComImpostos(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat, 0, 0, 0, 0, cdsItens.FieldByName('ITE_IMPULT').AsFloat, 0, 0);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemBrutaPrecoMedio(cdsItens: TUniClientDataSet): Double;
begin
  If (fCfgSis('MARMKP') = '5') Then
  Begin
    Result := fGetMargem(cdsItens.FieldByName('ITE_UNIORI').AsFloat,
                         cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                         cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                         cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                         cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                         cdsItens.FieldByName('ITE_PREMED').AsFloat,
                         cdsItens.FieldByName('ITE_VDIFAL').AsFloat,
                         cdsItens.FieldByName('ITE_VALFCP').AsFloat);
  End
  Else
  Begin
    Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat, 0, 0, 0, 0, cdsItens.FieldByName('ITE_PREMED').AsFloat, 0, 0);
  End;
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemLiquidaPrecoDeUltimaCompra(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat,
                       cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                       cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                       cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                       cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                       cdsItens.FieldByName('ITE_PREULT').AsFloat,
                       cdsItens.FieldByName('ITE_VDIFAL').AsFloat,
                       cdsItens.FieldByName('ITE_VALFCP').AsFloat);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemLiquidaPrecoDeUltimaCompraComImpostos(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat,
                       cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                       cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                       cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                       cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                       cdsItens.FieldByName('ITE_IMPULT').AsFloat,
                       cdsItens.FieldByName('ITE_VDIFAL').AsFloat,
                       cdsItens.FieldByName('ITE_VALFCP').AsFloat);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemLiquidaPrecoMedio(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat,
                       cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                       cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                       cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                       cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                       cdsItens.FieldByName('ITE_PREMED').AsFloat,
                       cdsItens.FieldByName('ITE_VDIFAL').AsFloat,
                       cdsItens.FieldByName('ITE_VALFCP').AsFloat);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemLiquidaPrecoMedioBruta(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat,
                       cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                       cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                       cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                       cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                       cdsItens.FieldByName('ITE_PREMED').AsFloat,
                       cdsItens.FieldByName('ITE_VDIFAL').AsFloat,
                       cdsItens.FieldByName('ITE_VALFCP').AsFloat);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemPraticadaCustoDoItem(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat, 0, 0, 0, 0, cdsItens.FieldByName('ITE_CUSITE').AsFloat, 0, 0);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemPraticadaPrecoDeCusto(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat,
                       cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                       cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                       cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                       cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                       cdsItens.FieldByName('ITE_CUSITE').AsFloat,
                       cdsItens.FieldByName('ITE_VDIFAL').AsFloat,
                       cdsItens.FieldByName('ITE_VALFCP').AsFloat);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemPraticadaPrecoDeCustoBruta(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNITAR').AsFloat,
                       cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                       cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                       cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                       cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                       cdsItens.FieldByName('ITE_CUSITE').AsFloat,
                       cdsItens.FieldByName('ITE_VDIFAL').AsFloat,
                       cdsItens.FieldByName('ITE_VALFCP').AsFloat);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemPropostaCustoDoItem(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNIORI').AsFloat, 0, 0, 0, 0, cdsItens.FieldByName('ITE_CUSITE').AsFloat, 0, 0);
end;

function TFatMostraMargemNovoAdicionarTinta.RetornarValorMargemPropostaPrecoDeCusto(cdsItens: TUniClientDataSet): Double;
begin
  Result := fGetMargem(cdsItens.FieldByName('ITE_UNIORI').AsFloat,
                       cdsItens.FieldByName('ITE_ICMSAI').AsFloat,
                       cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                       cdsItens.FieldByName('ITE_DESOPE').AsFloat,
                       cdsItens.FieldByName('ITE_OUTVAL').AsFloat,
                       cdsItens.FieldByName('ITE_CUSITE').AsFloat,
                       cdsItens.FieldByName('ITE_VDIFAL').AsFloat,
                       cdsItens.FieldByName('ITE_VALFCP').AsFloat);
end;

procedure TFatMostraMargemNovoAdicionarTinta.SetDecUni(intDecUni: Integer);
begin
  FDecUni := intDecUni;
end;

end.
