unit untLimiteComprasFornecedor;

interface

Uses
  Uni, DB, Classes,
  CxProgressBar,
  untZClient;

Type

  TLimiteComprasFornecedor = Class(TZClient)
  Private

    FNomArq: String;

    Function fSQLDados(strCodFor: String): String;

    Function fSQLDadosImportacao: String;

    Function fSQLUpdateLimFor: String;
    Function fSQLInsertLimFor: String;

    Function fImportaCSVPrg(prgProgessBar: TCxProgressBar): Boolean;
    Function fSalvaCSVPrg(prgProgessBar: TCxProgressBar): Boolean;

  Public

    cdsDadosImportacao: TZClient;

    constructor Create(Owner: TComponent); Reintroduce;

    Destructor  Destroy; Override;

    Function fCarregaDados(strCodFor: String): Boolean;

    Function fSalvaDados(strCodFor: String = ''): Boolean;

    Function fIncluiRegistro(strCodFor, strNomFor: String; intAno, intMes: Integer; fltValor: Double): Boolean;
    Function fExcluiRegistro: Boolean;

    Function fImportaCSV: Boolean;
    Function fSalvaCSV: Boolean;

    Procedure pImportaArqCSV;

  End;

implementation

Uses
  SysUtils,
  StrUtils,
  Forms,
  untGravando,
  untImportaCSV,
  untFuncoesSimples,
  untImportaLimiteComprasFornecedor;

constructor TLimiteComprasFornecedor.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');

  cdsDadosImportacao := TZClient.Create(Self, fSQLDadosImportacao);
End;

Destructor TLimiteComprasFornecedor.Destroy;
Begin
  inherited Destroy;
End;

Function TLimiteComprasFornecedor.fSQLDados(strCodFor: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   L.*, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   LIMFOR L ';
  strSQL := strSQL + ' INNER JOIN CADFOR ON FOR_CODFOR = LIM_CODFOR ';

  If Not strCodFor.IsEmpty Then
    strSQL := strSQL + ' WHERE LIM_CODFOR = :CODFOR ';

  Result := strSQL;
End;

Function TLimiteComprasFornecedor.fCarregaDados(strCodFor: String): Boolean;
Begin
  qryQuery.SQL.Text := fSQLDados(strCodFor);

  If Not strCodFor.IsEmpty Then
    qryQuery.ParamByName('CODFOR').AsString := strCodFor;

  Result := fLeDados('TLimiteComprasFornecedor.fCarregaDados');

  IndexFieldNames := 'LIM_CODFOR;LIM_NROANO;LIM_NROMES';

  pAlinhaCampoCentro('LIM_NROMES');
  pAlinhaCampoCentro('LIM_NROANO');
End;

Function TLimiteComprasFornecedor.fSalvaDados(strCodFor: String = ''): Boolean;
  Var
    strAutInc: String;
Begin
  Result := False;

  If Not Active Then
    Exit;

  DisableControls;

  Try
    If State In dsEditModes Then
      Post;

    Filter   := 'AUTOINCREM IS NULL';
    Filtered := True;

    If RecordCount > 0 Then
      strAutInc := fRetAutoIncrem('LIMFOR', VS_strCodEmp, RecordCount);

    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('AUTOINCREM').AsString := strAutInc;

      If Not strCodFor.IsEmpty Then
        FieldByName('LIM_CODFOR').AsString := strCodFor;

      Post;

      strAutInc := fNextAutoIncrem(strAutInc);
    End;

  Finally

    Filtered := False;
    EnableControls;

  End;

  Result := fSalva;
End;

Function TLimiteComprasFornecedor.fIncluiRegistro(strCodFor, strNomFor: String; intAno, intMes: Integer; fltValor: Double): Boolean;
Begin
  Result := False;

  If intAno = 0 Then
    Exit;

  If intMes = 0 Then
    Exit;

  If FindKey([strCodFor, intAno, intMes]) Then
    Edit
  Else
    Append;

  FieldByName('LIM_CODFOR').AsString  := strCodFor;
  FieldByName('NOMFOR').AsString      := strNomFor;
  FieldByName('LIM_NROMES').AsInteger := intMes;
  FieldByName('LIM_NROANO').AsInteger := intAno;
  FieldByName('LIM_VALPED').AsFloat   := fltValor;

  Post;

  Result := True;
End;

Function TLimiteComprasFornecedor.fExcluiRegistro: Boolean;
Begin
  Result := False;

  If (Not Self.IsEmpty) And
      fPergunta('Confirma a exclusão do mês ' + FieldByName('LIM_NROMES').AsString + '/' +
                    FieldByName('LIM_NROANO').AsString + ' do fornecedor ' + FieldByName('NOMFOR').AsString + ' ?') Then
  Begin
    Self.Delete;
    Result := True;
  End

End;

Function TLimiteComprasFornecedor.fSQLDadosImportacao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   FOR_CODFOR               AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR               AS NOMFOR, ';
  strSQL := strSQL + '   CAST("" AS CHAR(4))      AS NROANO, ';
  strSQL := strSQL + '   CAST("" AS CHAR(2))      AS NROMES, ';

  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS VALANT, ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(12,2)) AS VALPED, ';

  strSQL := strSQL + '   CAST("" AS CHAR(20))     AS AUTREG, ';
  strSQL := strSQL + '   0                        AS COMERR, ';
  strSQL := strSQL + '   CAST("" AS CHAR(255))    AS MSGERR  ';
  strSQL := strSQL + ' FROM                                  ';
  strSQL := strSQL + '   CADFOR                              ';
  strSQL := strSQL + ' WHERE FALSE                           ';

  Result := strSQL;
End;

Function TLimiteComprasFornecedor.fImportaCSV: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TImportaCSV.fPedeArquivo(FNomArq) And
            TfrmGravando.fExecuta(fImportaCSVPrg, frmGravando, 'Carregando dados...');
End;

Function TLimiteComprasFornecedor.fImportaCSVPrg(prgProgessBar: TCxProgressBar): Boolean;

  Var
    objCSV: TImportaCSV;
    intContador: Integer;
    qryLimFor: TUniQuery;
    strValPed: String;
Begin
  Result := cdsDadosImportacao.fLeDados('TLimiteComprasFornecedor.fImportaCSV');

  If Result Then
  Begin
    cdsDadosImportacao.pAlinhaCampoCentro('CODFOR');
    cdsDadosImportacao.pAlinhaCampoCentro('NROANO');
    cdsDadosImportacao.pAlinhaCampoCentro('NROMES');

    qryLimFor := fCriaQuery;
    qryLimFor.SQL.Text := 'SELECT * FROM LIMFOR WHERE LIM_CODFOR = :CODFOR AND LIM_NROANO = :NROANO AND LIM_NROMES = :NROMES ';

    objCSV := TImportaCSV.Create(FNomArq, True);

    prgProgessBar.Properties.Max := objCSV.stlArqCsv.Count;

    For intContador := 0 To objCSV.stlArqCsv.Count - 1 Do
    Begin

      If (intContador = objCSV.stlArqCsv.Count -1) And objCSV.fGetDado(intContador, 0).IsEmpty Then
        Break;

      cdsDadosImportacao.Append;
      cdsDadosImportacao.FieldByName('COMERR').AsInteger := 0;
      cdsDadosImportacao.FieldByName('CODFOR').AsString  := fStrZero(objCSV.fGetDado(intContador, 0), 8);
      cdsDadosImportacao.FieldByName('NROANO').AsString  := objCSV.fGetDado(intContador, 1);
      cdsDadosImportacao.FieldByName('NROMES').AsString  := objCSV.fGetDado(intContador, 2);

      strValPed := objCSV.fGetDado(intContador, 3);

      If StrToIntDef(cdsDadosImportacao.FieldByName('NROANO').AsString, 0) <= 0 Then
      Begin
        cdsDadosImportacao.FieldByName('MSGERR').AsString  := Trim(cdsDadosImportacao.FieldByName('MSGERR').AsString + ' Ano inválido: ' +
                                                                   cdsDadosImportacao.FieldByName('NROANO').AsString + '.');
        cdsDadosImportacao.FieldByName('COMERR').AsInteger := 1;
      End;

      If Not (StrToIntDef(cdsDadosImportacao.FieldByName('NROMES').AsString, 0) In [1..12]) Then
      Begin
        cdsDadosImportacao.FieldByName('MSGERR').AsString  := Trim(cdsDadosImportacao.FieldByName('MSGERR').AsString + ' Mês inválido: ' +
                                                                   cdsDadosImportacao.FieldByName('NROMES').AsString + '.');
        cdsDadosImportacao.FieldByName('COMERR').AsInteger := 1;
      End;

      If cdsDadosImportacao.FieldByName('COMERR').AsInteger = 0 Then
      Begin
        qryLimFor.Close;
        qryLimFor.ParamByName('CODFOR').AsString  := cdsDadosImportacao.FieldByName('CODFOR').AsString;
        qryLimFor.ParamByName('NROANO').AsInteger := cdsDadosImportacao.FieldByName('NROANO').AsInteger;
        qryLimFor.ParamByName('NROMES').AsInteger := cdsDadosImportacao.FieldByName('NROMES').AsInteger;
        qryLimFor.Open;

        If Not qryLimFor.IsEmpty Then
        Begin
          cdsDadosImportacao.FieldByName('VALANT').AsFloat  := qryLimFor.FieldByName('LIM_VALPED').AsFloat;
          cdsDadosImportacao.FieldByName('AUTREG').AsString := qryLimFor.FieldByName('AUTOINCREM').AsString;
        End;

      End;

      If StrToFloatDef(AnsiReplaceStr(strValPed,'.',','), -1) < 0 Then
      Begin
        cdsDadosImportacao.FieldByName('MSGERR').AsString  := Trim(cdsDadosImportacao.FieldByName('MSGERR').AsString + ' Valor inválido: ' + strValPed + '.');
        cdsDadosImportacao.FieldByName('COMERR').AsInteger := 1;
      End
      Else cdsDadosImportacao.FieldByName('VALPED').AsFloat := StrToFloatDef(AnsiReplaceStr(strValPed,'.',','), 0);

      cdsDadosImportacao.FieldByName('NOMFOR').AsString := fRetNomFornecedor(cdsDadosImportacao.FieldByName('CODFOR').AsString);

      If fEmptyStr(cdsDadosImportacao.FieldByName('NOMFOR').AsString) Then
      Begin
        cdsDadosImportacao.FieldByName('MSGERR').AsString  := Trim(cdsDadosImportacao.FieldByName('MSGERR').AsString + ' Fornecedor inválido: ' +
                                                                   cdsDadosImportacao.FieldByName('CODFOR').AsString + '.');
        cdsDadosImportacao.FieldByName('COMERR').AsInteger := 1;
      End;

      cdsDadosImportacao.Post;

      prgProgessBar.Position := prgProgessBar.Position + 1;
      Application.ProcessMessages;
    End;

    FreeAndNil(qryLimFor);
  End;

End;

Function TLimiteComprasFornecedor.fSQLInsertLimFor: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO LIMFOR                                           ';
  strSQL := strSQL + ' (AUTOINCREM, LIM_CODFOR, LIM_NROANO, LIM_NROMES, LIM_VALPED) ';
  strSQL := strSQL + ' VALUES                                                       ';
  strSQL := strSQL + ' (:AUTINC, :CODFOR, :NROANO, :NROMES, :VALPED)                ';
  Result := strSQL;
End;

Function TLimiteComprasFornecedor.fSQLUpdateLimFor: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE LIMFOR SET      ';
  strSQL := strSQL + '   LIM_VALPED = :VALPED ';
  strSQL := strSQL + ' WHERE                  ';
  strSQL := strSQL + '   LIM_CODFOR = :CODFOR AND LIM_NROANO = :NROANO AND LIM_NROMES = :NROMES ';
  Result := strSQL;
End;

Function TLimiteComprasFornecedor.fSalvaCSV: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result :=  TfrmGravando.fExecuta(fSalvaCSVPrg, frmGravando, 'Gravando dados...');
End;

Function TLimiteComprasFornecedor.fSalvaCSVPrg(prgProgessBar: TCxProgressBar): Boolean;
  Var
    strAutInc: String;
    qryUpdate,
    qryInsert: TUniQuery;
Begin
  Try
    cdsDadosImportacao.DisableControls;

    Try
      qryUpdate := fCriaQuery;
      qryInsert := fCriaQuery;

      qryUpdate.SQL.Text := fSQLUpdateLimFor;
      qryInsert.SQL.Text := fSQLInsertLimFor;

      cdsDadosImportacao.Filter   := 'COMERR = 0 AND AUTREG IS NULL';
      cdsDadosImportacao.Filtered := True;

      If Not cdsDadosImportacao.IsEmpty Then
        strAutInc := fRetAutoIncrem('LIMFOR', VS_strCodEmp, cdsDadosImportacao.RecordCount);

      cdsDadosImportacao.Filter   := 'COMERR = 0';

      prgProgessBar.Properties.Max := cdsDadosImportacao.RecordCount;

      cdsDadosImportacao.First;

      While Not cdsDadosImportacao.Eof Do
      Begin

        If cdsDadosImportacao.FieldByName('AUTREG').IsNull Then
        Begin
          qryInsert.Close;
          qryInsert.ParamByName('CODFOR').AsString  := cdsDadosImportacao.FieldByName('CODFOR').AsString;
          qryInsert.ParamByName('NROANO').AsInteger := cdsDadosImportacao.FieldByName('NROANO').AsInteger;
          qryInsert.ParamByName('NROMES').AsInteger := cdsDadosImportacao.FieldByName('NROMES').AsInteger;
          qryInsert.ParamByName('VALPED').AsFloat   := cdsDadosImportacao.FieldByName('VALPED').AsFloat;
          qryInsert.ParamByName('AUTINC').AsString  := strAutInc;
          qryInsert.ExecSQL;

          strAutInc := fNextAutoIncrem(strAutInc);
        End Else
        Begin
          qryUpdate.Close;
          qryUpdate.ParamByName('CODFOR').AsString  := cdsDadosImportacao.FieldByName('CODFOR').AsString;
          qryUpdate.ParamByName('NROANO').AsInteger := cdsDadosImportacao.FieldByName('NROANO').AsInteger;
          qryUpdate.ParamByName('NROMES').AsInteger := cdsDadosImportacao.FieldByName('NROMES').AsInteger;
          qryUpdate.ParamByName('VALPED').AsFloat   := cdsDadosImportacao.FieldByName('VALPED').AsFloat;
          qryUpdate.ExecSQL;
        End;

        cdsDadosImportacao.Next;

        prgProgessBar.Position := prgProgessBar.Position + 1;
        Application.ProcessMessages;
      End;

      Result := True;

    Except
      on E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TLimiteComprasFornecedor.fSalvaCSV]');
        Result := False;
      End;

    End;

    FreeAndNil(qryUpdate);
    FreeAndNil(qryInsert);

  Finally

    cdsDadosImportacao.Filtered := False;
    cdsDadosImportacao.EnableControls;

  End;
End;

Procedure TLimiteComprasFornecedor.pImportaArqCSV;
  Var
    frmImportaLimiteComprasFornecedor: TfrmImportaLimiteComprasFornecedor;
Begin
  If fImportaCSV Then
  Begin
    pCriarFormularios(TfrmImportaLimiteComprasFornecedor, frmImportaLimiteComprasFornecedor);

    frmImportaLimiteComprasFornecedor.objLimite := Self;
    frmImportaLimiteComprasFornecedor.ShowModal;

    pFreeAndNil(frmImportaLimiteComprasFornecedor);
  End;
End;

end.
