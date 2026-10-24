unit untFatMostraMargemNovoValidaUnitario;

interface

uses untIFatMostraMargemNovo, untFuncFat, DB, untFuncoesSimples;

type
  TFatMostraMargemNovoValidaUnitario = class(TInterfacedObject, IFatMostraMargemNovoValidaUnitario)
  private
  public
    function RetornarAPorcentagemDoDescontoMaximoGerente(fatVenda: TFatVenda; DataSet: TDataSet): Double;
    function RetornarAPorcentagemDoDescontoMaximoSubGerente(fatVenda: TFatVenda; DataSet: TDataSet): Double;

    class function New(): IFatMostraMargemNovoValidaUnitario;
  end;

implementation

{ TFatMostraMargemNovoValidaUnitario }

class function TFatMostraMargemNovoValidaUnitario.New: IFatMostraMargemNovoValidaUnitario;
begin
  Result := Self.Create;
end;

function TFatMostraMargemNovoValidaUnitario.RetornarAPorcentagemDoDescontoMaximoGerente(
  fatVenda: TFatVenda; DataSet: TDataSet): Double;
begin
  Result := DataSet.FieldByName('ITE_DESMGE').AsFloat;

  If fCfgSis('ITETBP', VarBoolean) Then
  Begin
    Result := fatVenda.fGetDesMaxTabPre(DataSet.FieldByName('ITE_CODITE').AsString,
                                           VS_strCodEmp,
                                           IIF(fEmptyStr(DataSet.FieldByName('ITE_TABPRE').AsString),
                                                         fatVenda.strTabPre,
                                                         DataSet.FieldByName('ITE_TABPRE').AsString),
                                           5);
  End
  Else If fCfgSis('DMVFQV', VarBoolean) Then
  Begin
    Result := fatVenda.GetDesMaxFaixaQtde(DataSet.FieldByName('ITE_CODITE').AsString,
                                             VS_strCodEmp, 3, DataSet.FieldByName('ITE_QTDITE').AsFloat);

  End;
end;

function TFatMostraMargemNovoValidaUnitario.RetornarAPorcentagemDoDescontoMaximoSubGerente(
  fatVenda: TFatVenda; DataSet: TDataSet): Double;
begin
  Result := DataSet.FieldByName('ITE_DESMSU').AsFloat;

  If fCfgSis('ITETBP', VarBoolean) Then
  Begin
    Result := fatVenda.fGetDesMaxTabPre(DataSet.FieldByName('ITE_CODITE').AsString,
                                           VS_strCodEmp,
                                           IIF(fEmptyStr(DataSet.FieldByName('ITE_TABPRE').AsString),
                                                         fatVenda.strTabPre,
                                                         DataSet.FieldByName('ITE_TABPRE').AsString),
                                           3);
  End
  Else If fCfgSis('DMVFQV', VarBoolean) Then
  Begin
    Result := fatVenda.GetDesMaxFaixaQtde(DataSet.FieldByName('ITE_CODITE').AsString,
                                             VS_strCodEmp, 1, DataSet.FieldByName('ITE_QTDITE').AsFloat);
  End;
end;

end.
