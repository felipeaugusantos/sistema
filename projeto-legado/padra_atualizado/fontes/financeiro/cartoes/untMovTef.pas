unit untMovTef;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Uni;

function fGravaMovTef(intSeqCon: Integer;
                      strEmpBai: String;
                      strNumDupCar: String;
                      strCodEmpCar: String;
                      strCodCli: String;
                      strConteudoArquivo: String;
                      strTpParc: String = ''): Boolean;

implementation

uses
  untFuncoesSimples, untMovCar;

function fGetSqlInsertMovTef(intSeqCon: Integer;
                             strEmpBai: String;
                             strNumDup: String;
                             strCodEmp: String;
                             strCodCli: String;
                             strCodReg: String;
                             strDesReg: String;
                             strAutInc: String;
                             strTpParc: String = ''): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO MOVTEF( ';
  strSQL := strSQL + '  TEF_SEQCON, ';
  strSQL := strSQL + '  TEF_EMPBAI, ';
  strSQL := strSQL + '  TEF_DUPCAR, ';
  strSQL := strSQL + '  TEF_EMPCAR, ';
  strSQL := strSQL + '  TEF_CLICAR, ';
  strSQL := strSQL + '  TEF_CODREG, ';
  strSQL := strSQL + '  TEF_DESREG, ';
  strSQL := strSQL + '  AUTOINCREM) ';
  strSQL := strSQL + 'VALUES( ';
  strSQL := strSQL + intSeqCon.ToString     + ',';
  strSQL := strSQL + strEmpBai.QuotedString + ',';
  strSQL := strSQL + strNumDup.QuotedString + ',';
  strSQL := strSQL + strCodEmp.QuotedString + ',';
  strSQL := strSQL + strCodCli.QuotedString + ',';
  strSQL := strSQL + strCodReg.QuotedString + ',';
  strSQL := strSQL + strDesReg.QuotedString + ',';
  strSQL := strSQL + strAutInc.QuotedString + ');';

  if Trim(strTpParc) = '' then
  begin
    {***********************************************}
    {* Tipo de parcelamento: [L]ojista/[O]peradora *}
    {*Req.164824*********************************RP*}
    If Trim(strCodReg) = '017-000' Then
    Begin
      strTpParc := EmptyStr;
      If Trim(strDesReg) = '0' Then
        strTpParc := 'L'
      Else If Trim(strDesReg) = '1' Then
        strTpParc := 'O';

      If strTpParc <> EmptyStr Then
        strSQL := strSQL + fGetSqlAtualizaTipoParcelamentoTEF(strNumDup, strCodCli, strCodEmp, strTpParc, intSeqCon);
    End
  end
  else
  begin
    if strTpParc = '02' then
      strTpParc := 'L';

    if strTpParc = '03' then
      strTpParc := 'O';

    strSQL := strSQL + fGetSqlAtualizaTipoParcelamentoTEF(strNumDup, strCodCli, strCodEmp, strTpParc, intSeqCon);
  end;

  Result := strSQL;
end;

procedure pExtraiCodReg_DesRegFromString(strLinha : String; var stlValores : TStringList);
begin
  if not fEmptyStr(strLinha) then
  begin
    stlValores.Add(LeftStr(strLinha, 7));
    stlValores.Add(Copy(strLinha, 9, Length(strLinha)));
  end;
end;


procedure pAtribuiCodReg_DesReg(Const strLinha: String;
                                Out strCodReg: String;
                                Out strDesReg: String);
  Var
    stlValores: TStringList;
begin
  stlValores := TStringList.Create;

  if not VS_blnTefCitel then
    ExtractStrings(['='], [], PWideChar(strLinha), stlValores)
  else
    pExtraiCodReg_DesRegFromString(strLinha, stlValores);

  strCodReg := fRemoveBarraInvertidaFinalDaLinha(stlValores[0]);
  strDesReg := fRemoveBarraInvertidaFinalDaLinha(AnsiReplaceStr(stlValores[1], '"', ''));

  stlValores.Free;
end;

function fGravaMovTef(intSeqCon: Integer;
                      strEmpBai: String;
                      strNumDupCar: String;
                      strCodEmpCar: String;
                      strCodCli: String;
                      strConteudoArquivo: String;
                      strTpParc: String = ''): Boolean;
  Var
    qryAux: TUniQuery;
    stlArquivo: TStringList;
    strCfgGMT1SQ: Boolean;
    strAutoIncremTef,
    strLinha,
    strCodReg,
    strDesReg: String;
begin
  stlArquivo := TStringList.Create;
  qryAux := fCriaQuery;
  Try
    Try
      strCfgGMT1SQ := fCfgSis('GMT1SQ', varBoolean);
      stlArquivo.Text := strConteudoArquivo;

      If stlArquivo.Count > 0 Then
      Begin
        If strCfgGMT1SQ Then
          strAutoIncremTef := fRetAutoIncrem('MOVTEF', VS_strCodEmp, stlArquivo.Count);

        For strLinha In stlArquivo Do
        Begin
          pAtribuiCodReg_DesReg(strLinha, strCodReg, strDesReg);

          If strCfgGMT1SQ Then
          Begin
            qryAux.SQL.Add(fGetSqlInsertMovTef(intSeqCon,
                                               strEmpBai,
                                               strNumDupCar,
                                               strCodEmpCar,
                                               strCodCli,
                                               strCodReg,
                                               strDesReg,
                                               strAutoIncremTef,
                                               strTpParc));

            strAutoIncremTef := fNextAutoIncrem(strAutoIncremTef);
          End
          Else
          Begin
            qryAux.SQL.Clear;
            qryAux.SQL.Add(fGetSqlInsertMovTef(intSeqCon,
                                               strEmpBai,
                                               strNumDupCar,
                                               strCodEmpCar,
                                               strCodCli,
                                               strCodReg,
                                               strDesReg,
                                               fRetAutoIncrem('MOVTEF', VS_strCodEmp),
                                               strTpParc));

            qryAux.ExecSQL;
          End;
        End;

        If strCfgGMT1SQ Then
          qryAux.ExecSQL;
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaMovTef]');
      End;
    End;
  Finally
    FreeAndNil(stlArquivo);
    FreeAndNil(qryAux);
  End;
end;

end.
