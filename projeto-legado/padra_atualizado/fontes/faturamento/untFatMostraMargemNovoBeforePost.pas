unit untFatMostraMargemNovoBeforePost;

interface

uses System.SysUtils, untIFatMostraMargemNovo, UniClientDataSet, untFuncFat, untFuncFatTypes,
  untFuncoesSimples, DB;

type
  TFatMostraMargemNovoBeforePost = class(TInterfacedObject, IFatMostraMargemNovoBeforePost)
  private
    function fIncluirElementoDIFAL(fatVenda: TFatVenda): Boolean;
    function fIncluirElementoFCP(fatVenda: TFatVenda): Boolean;
    function fEhCampoDeMargemBruta(const strCampoMargem : String) : Boolean;
    function fEhMargemComPrecoMedio(const strCampoMargem : String) : Boolean;
  public
    function RetornarValorUnitario(DataSet: TDataSet; cdsItens: TUniClientDataSet; fatVenda: TFatVenda; cdsVenda: TUniClientDataSet; strCampoMargem: String): Double;
    function RetornarValorPrecoCusto(DataSet: TDataSet; cdsItens: TUniClientDataSet; fatVenda: TFatVenda ): Double; overload;
    function RetornarValorPrecoCusto(DataSet: TDataSet; cdsItens: TUniClientDataSet; fatVenda: TFatVenda; cdsDados: TUniClientDataSet): Double; overload;
    function RetornarValorTotalDoItem(DataSet: TDataSet; fatVenda: TFatVenda): Double;
    function RetornarValorUnitarioDolar(DataSet: TDataSet): Double;
    function RetornarValorUnitarioComPercentualDeDesconto(DataSet: TDataSet): Double;
    function RetornarPercentualDaMargem(cdsItens: TUniClientDataSet; fatVenda: TFatVenda; strCampoMargem: String): Double;

    class function New(): IFatMostraMargemNovoBeforePost;
  end;

implementation

{ TFatMostraMargemNovoBeforePost }

class function TFatMostraMargemNovoBeforePost.New: IFatMostraMargemNovoBeforePost;
begin
  Result := Self.Create;
end;

function TFatMostraMargemNovoBeforePost.RetornarValorPrecoCusto(DataSet: TDataSet;
  cdsItens: TUniClientDataSet; fatVenda: TFatVenda): Double;
var
  calcCustoReal: TCalcCustoReal;
begin
  calcCustoReal := TCalcCustoReal.Create;
  calcCustoReal.fltUnitar := DataSet.FieldByName('ITE_UNITAR').AsFloat;
  calcCustoReal.fltPreCus := DataSet.FieldByName('ITE_CUSITE').AsFloat;
  calcCustoReal.fltOutVal := DataSet.FieldByName('ITE_OUTVAL').AsFloat;
  calcCustoReal.fltIcmSai := IIF(fCfgSis('IMPCF4', varBoolean) And (DataSet.FieldByName('ITE_IDEPRO').AsString = 'NOR'),
                             fatVenda.fCalculaAliquota(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('ITE_EMPITE').AsString, DataSet.FieldByName('ITE_IMPDIR').AsString),
                             DataSet.FieldByName('ITE_ICMSAI').AsFloat);
  calcCustoReal.fltImpFed := DataSet.FieldByName('ITE_IMPFED').AsFloat;
  calcCustoReal.fltDesOpe := DataSet.FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli;
  calcCustoReal.fltDifal  := fatVenda.fGetAlqDifal(cdsItens.FieldByName('ITE_CODITE').AsString,
                                                   cdsItens.FieldByName('ITE_EMPITE').AsString,
                                                   cdsItens.FieldByName('ITE_CODABF').AsString,
                                                   cdsItens.FieldByName('ITE_CODSIT').AsString);

  If (cdsItens.FieldByName('ITE_VAL_ST').AsFloat = 0) and (cdsItens.FieldByName('ITE_BASICM').AsFloat <> 0) Then
    calcCustoReal.fltFcp := fatVenda.fGetAlqFcpIcms(cdsItens.FieldByName('ITE_CODITE').AsString,
                                                    cdsItens.FieldByName('ITE_EMPITE').AsString,
                                                    cdsItens.FieldByName('ITE_CODABF').AsString,
                                                    cdsItens.FieldByName('ITE_CODSIT').AsString,
                                                    fatVenda.fCalculaAliquota(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('ITE_EMPITE').AsString, DataSet.FieldByName('ITE_IMPDIR').AsString),
                                                    calcCustoReal.fltUnitar);

  Result :=
     fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                 DataSet.FieldByName('ITE_CODITE').AsString,
                                 DataSet.FieldByName('ITE_EMPITE').AsString,
                                 DataSet.FieldByName('ITE_CUSITE').AsFloat,
                                 '',
                                 calcCustoReal,
                                (Pos('ITEM ESPECIAL', DataSet.FieldByName('ITE_DESITE').AsString) > 0));

  FreeAndNil(calcCustoReal);
end;

function TFatMostraMargemNovoBeforePost.RetornarPercentualDaMargem(
  cdsItens: TUniClientDataSet; fatVenda: TFatVenda;
  strCampoMargem: String): Double;
begin
  Result := (cdsItens.FieldByName('ITE_IMPFED').AsFloat +
             cdsItens.FieldByName('ITE_ICMSAI').AsFloat +
             cdsItens.FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli +
             cdsItens.FieldByName(strCampoMargem).AsFloat +
             cdsItens.FieldByName('ITE_COMTBL').AsFloat);
end;

function TFatMostraMargemNovoBeforePost.RetornarValorPrecoCusto(DataSet: TDataSet;
  cdsItens: TUniClientDataSet; fatVenda: TFatVenda;
  cdsDados: TUniClientDataSet): Double;
var
  calcCustoReal: TCalcCustoReal;
begin
  calcCustoReal := TCalcCustoReal.Create;
  calcCustoReal.fltUnitar := DataSet.FieldByName('ITE_UNITAR').AsFloat;
  calcCustoReal.fltPreCus := DataSet.FieldByName('ITE_CUSITE').AsFloat;
  calcCustoReal.fltOutVal := DataSet.FieldByName('ITE_OUTVAL').AsFloat;
  calcCustoReal.fltIcmSai := IIF(fCfgSis('IMPCF4', varBoolean) And (DataSet.FieldByName('ITE_IDEPRO').AsString = 'NOR'),
                             fatVenda.fCalculaAliquota(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('ITE_EMPITE').AsString, DataSet.FieldByName('ITE_IMPDIR').AsString),
                             DataSet.FieldByName('ITE_ICMSAI').AsFloat);
  calcCustoReal.fltImpFed := DataSet.FieldByName('ITE_IMPFED').AsFloat;
  calcCustoReal.fltDesOpe := DataSet.FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli;
  calcCustoReal.fltDifal  := fatVenda.fGetAlqDifal(cdsItens.FieldByName('ITE_CODITE').AsString,
                                                   cdsItens.FieldByName('ITE_EMPITE').AsString,
                                                   cdsDados.FieldByName('ITE_CODABF').AsString,
                                                   cdsDados.FieldByName('ITE_CODSIT').AsString);

  If (cdsItens.FieldByName('ITE_VAL_ST').AsFloat = 0) and (cdsItens.FieldByName('ITE_BASICM').AsFloat <> 0) Then
    calcCustoReal.fltFcp := fatVenda.fGetAlqFcpIcms(cdsItens.FieldByName('ITE_CODITE').AsString,
                                                    cdsItens.FieldByName('ITE_EMPITE').AsString,
                                                    cdsDados.FieldByName('ITE_CODABF').AsString,
                                                    cdsDados.FieldByName('ITE_CODSIT').AsString,
                                                    fatVenda.fCalculaAliquota(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('ITE_EMPITE').AsString, DataSet.FieldByName('ITE_IMPDIR').AsString),
                                                    calcCustoReal.fltUnitar);

  Result :=
     fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                 DataSet.FieldByName('ITE_CODITE').AsString,
                                 DataSet.FieldByName('ITE_EMPITE').AsString,
                                 DataSet.FieldByName('ITE_CUSITE').AsFloat,
                                 '',
                                 calcCustoReal,
                                (Pos('ITEM ESPECIAL', DataSet.FieldByName('ITE_DESITE').AsString) > 0));

  FreeAndNil(calcCustoReal);
end;

function TFatMostraMargemNovoBeforePost.RetornarValorTotalDoItem(DataSet: TDataSet; fatVenda: TFatVenda): Double;
begin
  Result := fatVenda.fCalculaTotalItem(DataSet.FieldByName('ITE_IDEPRO').AsString,
                                       DataSet.FieldByName('ITE_UNITAR').AsFloat,
                                       DataSet.FieldByName('ITE_QTDITE').AsFloat,
                                       DataSet.FieldByName('ITE_PREEMB').AsFloat,
                                       DataSet.FieldByName('ITE_QTDEMB').AsFloat);
end;

function TFatMostraMargemNovoBeforePost.fIncluirElementoDIFAL(fatVenda: TFatVenda): Boolean;
begin
  Result := True;
  If Not fCfgSis('IMPCF4', varBoolean) Then
    Result := Not fatVenda.fRestringirElementoDIFAL;
end;

function TFatMostraMargemNovoBeforePost.fIncluirElementoFCP(fatVenda: TFatVenda): Boolean;
begin
  Result := True;
  If Not fCfgSis('IMPCF4', varBoolean) Then
    Result := Not fatVenda.fRestringirElementoFCP;
end;

function TFatMostraMargemNovoBeforePost.RetornarValorUnitario(DataSet: TDataSet; cdsItens: TUniClientDataSet; fatVenda: TFatVenda; cdsVenda: TUniClientDataSet; strCampoMargem: String): Double;
var
  fltIcmCal : Double;
  fltImcSTPV : Double;
  blnCalcST : Boolean;
  fltCustoParaMargem : Double;
begin
  if fCfgSis('IMPCF4', varBoolean) and (DataSet.FieldByName('ITE_IDEPRO').AsString = 'NOR') then
  begin
    fltIcmCal := IIF( ( fCfgSis('SIMPAU') = 'S') And fCfgSis('ZERSIM', varBoolean, fatVenda.GetEmpCfg(DataSet.FieldByName('ITE_EMPITE').AsString)), 0,  fatVenda.fCalculaAliquota(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('ITE_EMPITE').AsString, DataSet.FieldByName('ITE_IMPDIR').AsString));

    if (cdsItens.FieldByName('ITE_RICMPR').AsString = 'S') then
      fltIcmCal := fFormataFloat(fltIcmCal * fMultiplicadorReducaoRICMS(cdsItens.FieldByName('ITE_PERRIC').AsFloat), 2);
  end
  else
    fltIcmCal := cdsItens.FieldByName('ITE_ICMSAI').AsFloat;

  fatVenda.objIcStPv.pAdd(DataSet.FieldByName('ITE_CODITE').AsString,
                          fatVenda.fGetEmpCalculoItem(DataSet.FieldByName('ITE_EMPITE').AsString),
                          fatVenda.GetTipAbf(DataSet.FieldByName('ITE_EMPITE').AsString),
                          fatVenda.fUFDestTrib(DataSet.FieldByName('ITE_EMPITE').AsString),
                          cdsVenda.FieldByName('ABF_CODSIT').AsString,
                          fltImcSTPV,
                          blnCalcST);

  If (Not fEhCampoDeMargemBruta(strCampoMargem)) Then
  Begin
    If fEhMargemComPrecoMedio(strCampoMargem) Then
      fltCustoParaMargem := cdsItens.FieldByName('ITE_PREMED').AsFloat + cdsItens.FieldByName('ITE_OUTVAL').AsFloat
    Else
      fltCustoParaMargem := cdsItens.FieldByName('ITE_CUSITE').AsFloat + cdsItens.FieldByName('ITE_OUTVAL').AsFloat;

    Result := fCalculaPrecoVenda(1,
                  fltCustoParaMargem,
                  0,
                  cdsItens.FieldByName(strCampoMargem).AsFloat,
                  fltIcmCal + fatVenda.fAlqDifIcmsPrecoDinamico(DataSet.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('ITE_EMPITE').AsString, cdsVenda.FieldByName('ABF_CODABF').AsString, cdsVenda.FieldByName('ABF_CODSIT').AsString, fltIcmCal),
                  cdsItens.FieldByName('ITE_IMPFED').AsFloat,
                  cdsItens.FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli,
                  cdsItens.FieldByName('ITE_COMTBL').AsFloat,
                  fMarMpkParaVenda,
                  '',
                  -1,
                  fltImcSTPV,
                  blnCalcST,
                  IIF((fIncluirElementoDIFAL(fatVenda)) And (Not fCfgSis('CLPVDI', varBoolean)) ,
                    fatVenda.fGetAlqDifal(cdsItens.FieldByName('ITE_CODITE').AsString,
                                          cdsItens.FieldByName('ITE_EMPITE').AsString,
                                          cdsItens.FieldByName('ITE_CODABF').AsString,
                                          cdsItens.FieldByName('ITE_CODSIT').AsString), 0),
                  IIF((fIncluirElementoFCP(fatVenda)) And (Not fCfgSis('CLPVDI', varBoolean)) and (cdsItens.FieldByName('ITE_VAL_ST').AsFloat = 0) and (cdsItens.FieldByName('ITE_BASICM').AsFloat <> 0),
                    fatVenda.fGetAlqFcpIcms(cdsItens.FieldByName('ITE_CODITE').AsString,
                                            cdsItens.FieldByName('ITE_EMPITE').AsString,
                                            cdsItens.FieldByName('ITE_CODABF').AsString,
                                            cdsItens.FieldByName('ITE_CODSIT').AsString,
                                            fatVenda.fCalculaAliquota(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('ITE_EMPITE').AsString, DataSet.FieldByName('ITE_IMPDIR').AsString),
                                            DataSet.FieldByName('ITE_UNITAR').AsFloat), 0 ) );
  End
  Else
  Begin
    If fEhMargemComPrecoMedio(strCampoMargem) Then
      fltCustoParaMargem := cdsItens.FieldByName('ITE_PREMED').AsFloat
    Else
      fltCustoParaMargem := cdsItens.FieldByName('ITE_CUSITE').AsFloat;

    Result := fCalculaPrecoVenda(1,
                   fltCustoParaMargem,
                   0,
                   cdsItens.FieldByName(strCampoMargem).AsFloat,
                   0,
                   0,
                   0,
                   cdsItens.FieldByName('ITE_COMTBL').AsFloat,
                   fMarMpkParaVenda,
                   '',
                   -1,
                   fltImcSTPV,
                   blnCalcST,
                   0,
                   0 );
  End;
end;

function TFatMostraMargemNovoBeforePost.RetornarValorUnitarioComPercentualDeDesconto(
  DataSet: TDataSet): Double;
begin
  Result := DataSet.FieldByName('ITE_UNIORI').AsFloat - ((DataSet.FieldByName('ITE_UNIORI').AsFloat * DataSet.FieldByName('ITE_PERDES').AsFloat) / 100);
end;

function TFatMostraMargemNovoBeforePost.RetornarValorUnitarioDolar(
  DataSet: TDataSet): Double;
begin
  Result := DataSet.FieldByName('ITE_UNITAR').AsFloat / DataSet.FieldByName('ITE_VLCTVN').AsFloat;
end;

function TFatMostraMargemNovoBeforePost.fEhCampoDeMargemBruta(
  const strCampoMargem: String): Boolean;
begin
  Result := True;
  If (strCampoMargem = 'ITE_MARPRA_CUSITE') Then
    Exit;
  If (strCampoMargem = 'ITE_MRPRBT_PREMED') Then
    Exit;
  If (strCampoMargem = 'ITE_MARBRU_PREMED') Then
    Exit;
  Result := False;
end;

function TFatMostraMargemNovoBeforePost.fEhMargemComPrecoMedio(
  const strCampoMargem: String): Boolean;
begin
  Result := True;
  If (strCampoMargem = 'ITE_MARLIQ_PREMED') Then
    Exit;
  If (strCampoMargem = 'ITE_MRPRBT_PREMED') Then
    Exit;
  If (strCampoMargem = 'ITE_MARBRU_PREMED') Then
    Exit;
  Result := False;
end;

end.
