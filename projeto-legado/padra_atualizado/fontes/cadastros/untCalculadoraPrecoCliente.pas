unit untCalculadoraPrecoCliente;

interface

Uses
  Classes, SysUtils, DB, Uni, System.JSON;

Type
  TCalculadoraPrecoCliente = Class(TObject)
  Private
    FCBS,
    FIBS,
    FImpostoIS: Double;
  Public
    Constructor Create;

    Procedure pCarregaAliquotas(strCodIte, strCodEmp, strNcm, strNcmExc: String; strAbfRef: String = '');

    Function fCalculaPrecoComImpostos(fltPreVen, fltIcmsAi: Double): Double;
    Function fAtualizaPrecoVenda(fltPrecoComImpostos, fltIcmsAi: Double): Double;

    property CBS: Double Read FCBS;
    property IBS: Double Read FIBS;
    property ImpostoIS: Double Read FImpostoIS;
  End;

implementation

Uses
  Math,
  untFuncoesSimples;

Constructor TCalculadoraPrecoCliente.Create;
Begin
  Inherited Create;

  FCBS       := 0;
  FIBS       := 0;
  FImpostoIS := 0;
End;

Procedure TCalculadoraPrecoCliente.pCarregaAliquotas(strCodIte, strCodEmp, strNcm, strNcmExc: String; strAbfRef: String = '');
  Var
    qryDados: TUniQuery;
    objItens: TJSONArray;
    objItem: TJSONObject;
Begin
  FCBS       := 0;
  FIBS       := 0;
  FImpostoIS := 0;

  If fEmptyStr(strCodIte + strNcm + strNcmExc) then
    Exit;
  objItens := TJSONArray.Create;

  Try
    objItem := TJSONObject.Create;
    objItem.AddPair('empresa', strCodEmp);
    objItem.AddPair('id_item', strCodIte);
    objItem.AddPair('codigo_item', strCodIte);
    objItem.AddPair('ncm', strNcm);
    objItem.AddPair('ncm_excecao', strNcmExc);


    If not fEmptyStr(strAbfRef) Then
      objItem.AddPair('codabf', strAbfRef);

    objItens.AddElement(objItem);

    qryDados := fCriaQuery;

    Try
      qryDados.SQL.Text := 'CALL pRefTrib_CalculaAliquotasEfetivasItens(CAST(:PITENS AS JSON))';
      qryDados.ParamByName('PITENS').AsString := objItens.ToJSON;

      qryDados.Open;

      If Not qryDados.IsEmpty Then
      Begin
        If qryDados.FieldByName('RET_STATUS').AsString <> 'CALCULADO' Then
          fMensagem('ATENÇÃO!', qryDados.FieldByName('RET_MENSAGEM').AsString, ['&Ok'])
        Else
        Begin
          FCBS       := qryDados.FieldByName('ALQ_CBS_EFETIVA').AsFloat;
          FIBS       := qryDados.FieldByName('ALQ_IBS_TOTAL_EFETIVA').AsFloat;
          FImpostoIS := qryDados.FieldByName('RTE_ALIQIS').AsFloat;
        End;
      End;
    Finally
      FreeAndNil(qryDados);
    End;
  Finally
    FreeAndNil(objItens);
  End;
End;

Function TCalculadoraPrecoCliente.fCalculaPrecoComImpostos(fltPreVen, fltIcmsAi: Double): Double;
Begin
  Result := RoundTo(fltPreVen + fltPreVen * (1 - fltIcmsAi / 100) *
                     ((FCBS + FIBS + FImpostoIS) / 100), -4);
End;

Function TCalculadoraPrecoCliente.fAtualizaPrecoVenda(fltPrecoComImpostos, fltIcmsAi: Double): Double;
Begin
  Result := RoundTo(fltPrecoComImpostos /
                     (1 + (1 - fltIcmsAi / 100) * ((FCBS + FIBS + FImpostoIS) / 100)), -4);
End;

end.