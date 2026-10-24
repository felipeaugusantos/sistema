unit untLogGor;

interface

uses Uni, System.Classes, System.SysUtils, DB, Variants, Forms;

type
  TLogGor = Class(TComponent)
  private
    class var qryItensExcluidos: TUniQuery;
    class function fHouveAlteracaoGor(var strIncGor: String; qryTabOri: TUniQuery): Boolean;
    class function fHouveAlteracaoDor(strCodIte: String; Var strSituac: String; qryTabOri: TUniQuery): Boolean;
    class function fNomeForm: String;
    class function fCamposDiferentes(qryTabLog, qryTabOri: TUniQuery): Boolean;
    class procedure pSetaValoresTabela(qryTabLog, qryTabOri: TUniQuery);
    class procedure pGravaLogItensExcluidos;
  protected
    class var strSeqGor : String; // Incremento da LOGGOR
    class var strSeqFgo : String; // Incremento da FATGOR
  public
    class var strNumDoc: String;
    class var strEspDoc: String;
    class var strCodEmp: String;
    class var blnExecutaLog : Boolean;
    class var strEntRet : String;
    class var strEmpCar : String;
    class var strCodPor : String;
    class var strComplementoFrmLogGor : String;
    class procedure pLog(qryTabOri: TUniQuery; strTabela: String; strAutLdg: String='');
    class procedure pLogDel(strNumDoc, strEspDoc, strCodEmp: String);
    class procedure pLimpar;
    class procedure pBuscaDadosItensExcluidos(strAutIncIteDel: String);
  End;

implementation

{ TLogGor }

uses untFuncoesSimples;

class function TLogGor.fCamposDiferentes(qryTabLog, qryTabOri: TUniQuery): Boolean;
  Var
    intCnt : Integer;
begin
  Result := False;

  If Not blnExecutaLog Then
    Exit;

  For intCnt := 0 To qryTabLog.FieldCount-1 Do
  Begin
    If qryTabLog.Fields[intCnt].FieldName = 'AUTOINCREM' Then
      Continue;

    If qryTabOri.FindField( qryTabLog.Fields[intCnt].FieldName ) <> Nil Then
    Begin
      If (qryTabOri.FindField( qryTabLog.Fields[intCnt].FieldName ).Value <>
          qryTabLog.Fields[intCnt].Value) Then
      Begin
        Result := True;
        Exit;
      End;
    End
    Else If qryTabOri.FindParam( qryTabLog.Fields[intCnt].FieldName ) <> Nil Then
    Begin
      If (qryTabOri.FindParam( qryTabLog.Fields[intCnt].FieldName ).Value <>
          qryTabLog.Fields[intCnt].Value) Then
      Begin
        Result := True;
        Exit;
      End;
    End;
  End;
end;

class function TLogGor.fHouveAlteracaoDor(strCodIte: String; var strSituac: String;
  qryTabOri: TUniQuery): Boolean;
  Var
    qryDados : TUniQuery;
begin
  Result := False;

  If Not blnExecutaLog Then
    Exit;

  strSituac := '';
  qryDados := fCriaQuery(Nil);
  Try
    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT LOGDOR.* FROM LOGDOR ');
      SQL.Add(' JOIN LOGGOR ON LOGGOR.AUTOINCREM = FDO_SEQGOR ');
      SQL.Add(' WHERE FGO_NUMDOC = :NUMDOC ');
      SQL.Add('   AND FGO_ESPDOC = :ESPDOC ');
      SQL.Add('   AND FGO_CODEMP = :CODEMP ');
      SQL.Add('   AND FDO_CODITE = :CODITE ');
      SQL.Add(' ORDER BY DTALOG DESC, HORLOG DESC ');
      SQL.Add(' LIMIT 1 ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If IsEmpty Or (FieldByName('FDO_SITUAC').AsString = 'E') Then
      Begin
        Result := True;
        strSituac := 'I';
      End
      Else
      Begin
        If (strEntRet <> qryDados.FieldByName('FDO_ENTRET').AsString) Or
           (strEmpCar <> qryDados.FieldByName('FDO_EMPCAR').AsString) Or
           (fCamposDiferentes(qryDados, qryTabOri)) Then
        Begin
          Result := True;
          strSituac := 'A';
        End;
      End;

      Close;
    End;
  Finally
    FreeANdNil(qryDados);
  End;
end;

class function TLogGor.fHouveAlteracaoGor(var strIncGor: String; qryTabOri: TUniQuery): Boolean;
  Var
    qryDados : TUniQuery;
begin
  Result := False;

  If Not blnExecutaLog Then
    Exit;

  strIncGor := '';
  qryDados := fCriaQuery(Nil);
  Try
    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM LOGGOR ');
      SQL.Add('  WHERE FGO_NUMDOC = :NUMDOC ');
      SQL.Add('    AND FGO_ESPDOC = :ESPDOC ');
      SQL.Add('    AND FGO_CODEMP = :CODEMP ');
      SQL.Add('  ORDER BY DTALOG DESC, HORLOG DESC ');
      SQL.Add('  LIMIT 1 ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If IsEmpty Then
        Result := True
      Else
      Begin
        strIncGor := FieldByName('AUTOINCREM').AsString;
        Result := (strCodPor <> qryDados.FieldByName('FGO_CODPOR').AsString) Or
                  (fCamposDiferentes(qryDados, qryTabOri));
      End;

      Close;
    End;
  Finally
    FreeANdNil(qryDados);
  End;
end;

class function TLogGor.fNomeForm: String;
begin
  Result := '';

  If Not blnExecutaLog Then
    Exit;

  Result := fGetFormsAtivos();

  If (Not fEmptyStr(strComplementoFrmLogGor)) Then
    Result := Result + ' ' + strComplementoFrmLogGor;
end;

class procedure TLogGor.pLog(qryTabOri: TUniQuery; strTabela: String; strAutLdg: String='');
  Var
    blnGrvGor : Boolean;
    blnGrvDor : Boolean;
    qryTabLog : TUniQuery;
    qryFatGor : TUniQuery;
    strSituac : String;
begin
  If Not blnExecutaLog Then
    Exit;

  blnGrvGor := False;
  blnGrvDor := False;
  qryTabLog := fCriaQuery(Nil);
  Try
    If (strTabela = 'FATGOR') Then
      blnGrvGor := fHouveAlteracaoGor(strSeqFgo, qryTabOri);

    If (Not fEmptyStr(strSeqFgo)) Then
    Begin
      If (strTabela = 'FATDOR') Then
      Begin
        blnGrvDor := fHouveAlteracaoDor(qryTabOri.FieldByName('FDO_CODITE').AsString,
                                        strSituac,
                                        qryTabOri);
      End;
    End
    Else If (strTabela = 'FATDOR') Then
    begin
      strSituac := 'I';
      blnGrvDor := True;
    End;

    If (blnGrvGor Or blnGrvDor) And (fEmptyStr(strSeqGor)) Then
    Begin
      With qryTabLog Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * ');
        SQL.Add('   FROM LOGGOR ');
        SQL.Add('  WHERE FALSE ');
        Open;
      End;
  
      qryTabLog.Append;

      If (blnGrvDor) Then
      Begin
        qryFatGor := fCriaQuery(Nil);
        Try
          With qryFatGor Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' SELECT * ');
            SQL.Add('   FROM FATGOR ');
            SQL.Add('  WHERE FGO_NUMDOC = :NUMDOC ');
            SQL.Add('    AND FGO_ESPDOC = :ESPDOC ');
            SQL.Add('    AND FGO_CODEMP = :CODEMP ');
            ParamByName('NUMDOC').AsString := strNumDoc;
            ParamByName('ESPDOC').AsString := strEspDoc;
            ParamByName('CODEMP').AsString := strCodEmp;
            Open;
            pSetaValoresTabela(qryTabLog, qryFatGor);
            Close;
          End;
        Finally
          FreeAndNil(qryFatGor);
        End;
      End
      Else
        pSetaValoresTabela(qryTabLog, qryTabOri);

      qryTabLog.FieldByName('DTALOG').AsDateTime := VS_Date;
      qryTabLog.FieldByName('HORLOG').AsDateTime := fTime();
      qryTabLog.FieldByName('OPELOG').AsString := strLoginUsuarioLogado;
      qryTabLog.FieldByName('FRMLOG').AsString := fNomeForm;
      qryTabLog.FieldByName('WTSMAQ').AsString := VS_WorkstationID;
      qryTabLog.FieldByName('WTS_IP').AsString := VS_WorkStationIP;
      qryTabLog.FieldByName('FGO_SITUAC').AsString := IIF(fEmptyStr(strSeqFgo), 'I', 'A');
      If Not fEmptyStr(strCodPor) Then
        qryTabLog.FieldByName('FGO_CODPOR').AsString := strCodPor;
      qryTabLog.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGGOR', VS_strCodEmp);
      qryTabLog.Post;

      strSeqGor := qryTabLog.FieldByName('AUTOINCREM').AsString;

      If Assigned(qryItensExcluidos) Then
        pGravaLogItensExcluidos;
    End;

    If (blnGrvDor) And (Not fEmptyStr(strSeqGor)) Then
    Begin
      With qryTabLog Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * ');
        SQL.Add('   FROM LOGDOR ');
        SQL.Add('  WHERE FALSE ');
        Open;
      End;

      qryTabLog.Append;

      pSetaValoresTabela(qryTabLog, qryTabOri);

      qryTabLog.FieldByName('FDO_ENTRET').AsString := strEntRet;
      qryTabLog.FieldByName('FDO_SEQGOR').AsString := strSeqGor;
      qryTabLog.FieldByName('FDO_SITUAC').AsString := strSituac;

      If Not fEmptyStr(strEmpCar) Then
        qryTabLog.FieldByName('FDO_EMPCAR').AsString := strEmpCar;

      If fEmptyStr(strAutLdg) Then
        strAutLdg := fRetAutoIncrem('LOGDOR', VS_strCodEmp);

      qryTabLog.FieldByName('AUTOINCREM').AsString := strAutLdg;
      qryTabLog.Post;
    End;  
  Finally    
    FreeAndNil(qryTabLog);
    If Assigned(qryItensExcluidos) Then
      FreeAndNil(qryItensExcluidos);
  End;  
end;

class procedure TLogGor.pLogDel(strNumDoc, strEspDoc, strCodEmp: String);
  Var
    qryFatGor : TUniQuery;
    qryFatDor : TUniQuery;
    qryTabLog : TUniQuery;
    strTmpInc : String;
begin
  If Not blnExecutaLog Then
    Exit;

  qryFatGor := fCriaQuery();
  qryFatDor := fCriaQuery();
  qryTabLog := fCriaQuery();
  Try
    qryFatGor.Close;
    qryFatGor.SQL.Clear;
    qryFatGor.SQL.Add(' SELECT * ');
    qryFatGor.SQL.Add('   FROM FATGOR ');
    qryFatGor.SQL.Add('  WHERE FGO_NUMDOC = :NUMDOC ');
    qryFatGor.SQL.Add('    AND FGO_ESPDOC = :ESPDOC ');
    qryFatGor.SQL.Add('    AND FGO_CODEMP = :CODEMP ');
    qryFatGor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryFatGor.ParamByName('ESPDOC').AsString := strEspDoc;
    qryFatGor.ParamByName('CODEMP').AsString := strCodEmp;
    qryFatGor.Open;

    qryFatDor.Close;
    qryFatDor.SQL.Clear;
    qryFatDor.SQL.Add(' SELECT * ');
    qryFatDor.SQL.Add('   FROM FATDOR ');
    qryFatDor.SQL.Add('  LEFT JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryFatDor.SQL.Add('  WHERE FDO_NUMDOC = :NUMDOC ');
    qryFatDor.SQL.Add('    AND FDO_ESPDOC = :ESPDOC ');
    qryFatDor.SQL.Add('    AND FDO_CODEMP = :CODEMP ');
    qryFatDor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryFatDor.ParamByName('ESPDOC').AsString := strEspDoc;
    qryFatDor.ParamByName('CODEMP').AsString := strCodEmp;
    qryFatDor.Open;

    qryTabLog.Close;
    qryTabLog.SQL.Text := 'SELECT * FROM LOGGOR WHERE FALSE';
    qryTabLog.Open;

    If (Not qryFatGor.IsEmpty) Then
    Begin
      qryTabLog.Append;
      pSetaValoresTabela(qryTabLog, qryFatGor);
      qryTabLog.FieldByName('DTALOG').AsDateTime := VS_Date;
      qryTabLog.FieldByName('HORLOG').AsDateTime := fTime();
      qryTabLog.FieldByName('OPELOG').AsString := strLoginUsuarioLogado;
      qryTabLog.FieldByName('FRMLOG').AsString := fNomeForm;
      qryTabLog.FieldByName('FGO_SITUAC').AsString := 'E';
      qryTabLog.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGGOR', VS_strCodEmp);
      qryTabLog.FieldByName('WTSMAQ').AsString :=  VS_WorkstationID;
      qryTabLog.FieldByName('WTS_IP').AsString := VS_WorkStationIP;
      qryTabLog.Post;

      strTmpInc := qryTabLog.FieldByName('AUTOINCREM').AsString;

      qryTabLog.Close;
      qryTabLog.SQL.Text := 'SELECT * FROM LOGDOR WHERE FALSE';
      qryTabLog.Open;

      qryFatDor.First;
      While Not qryFatDor.Eof Do
      Begin

        qryTabLog.Append;
        pSetaValoresTabela(qryTabLog, qryFatDor);
        qryTabLog.FieldByName('FDO_SEQGOR').AsString := strTmpInc;
        qryTabLog.FieldByName('FDO_SITUAC').AsString := 'E';
        qryTabLog.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGDOR', VS_strCodEmp);
        qryTabLog.Post;

        qryFatDor.Next;
      End;
    End;
  Finally
    FreeAndNil(qryFatGor);
    FreeAndNil(qryFatDor);
    FreeAndNil(qryTabLog);
  End;
end;

class procedure TLogGor.pBuscaDadosItensExcluidos(strAutIncIteDel: String);
begin
  If Not Assigned(qryItensExcluidos) Then
    qryItensExcluidos := fCriaQuery;

  qryItensExcluidos.Close;
  qryItensExcluidos.SQL.Clear;
  qryItensExcluidos.SQL.Add('SELECT * FROM FATDOR');
  qryItensExcluidos.SQL.Add('LEFT JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM');
  qryItensExcluidos.SQL.Add('WHERE FATDOR.AUTOINCREM IN ('+ strAutIncIteDel +')');
  qryItensExcluidos.Open;
end;

class procedure TLogGor.pGravaLogItensExcluidos;
  Var
    qryLogDor: TUniQuery;
begin
  qryLogDor := fCriaQuery;
  Try
    qryLogDor.SQL.Add('SELECT * FROM LOGDOR WHERE FALSE');
    qryLogDor.Open;

    qryItensExcluidos.First;
    While Not qryItensExcluidos.Eof Do
    Begin
      If Concat(qryItensExcluidos.FieldByName('FDO_NUMDOC').AsString,
                qryItensExcluidos.FieldByName('FDO_ESPDOC').AsString,
                qryItensExcluidos.FieldByName('FDO_CODEMP').AsString) =
         Concat(strNumDoc, strEspDoc, strCodEmp) Then
      Begin
        qryLogDor.Append;
        pSetaValoresTabela(qryLogDor, qryItensExcluidos);

        qryLogDor.FieldByName('FDO_SEQGOR').AsString := strSeqGor;
        qryLogDor.FieldByName('FDO_SITUAC').AsString := 'E';
        qryLogDor.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGDOR', VS_strCodEmp);
        qryLogDor.Post;
      End;

      qryItensExcluidos.Next;
    End;
  Finally
    FreeAndNil(qryLogDor);
  End;
end;

class procedure TLogGor.pLimpar;
begin
  If Not blnExecutaLog Then
    Exit;

  strSeqGor := '';
  strSeqFgo := '';
  strEntRet := '';
  strEmpCar := '';
  strCodPor := '';
  strComplementoFrmLogGor := '';
end;

class procedure TLogGor.pSetaValoresTabela(qryTabLog, qryTabOri: TUniQuery);
  Var
    intCnt : Integer;
begin
  If Not blnExecutaLog Then
    Exit;

  For intCnt := 0 To qryTabLog.FieldCount-1 Do
  Begin
    If (qryTabOri.FindField( qryTabLog.Fields[intCnt].FieldName ) <> Nil) And
       (Not qryTabOri.FindField( qryTabLog.Fields[intCnt].FieldName ).IsNull) Then
    Begin
      qryTabLog.Fields[intCnt].Value := qryTabOri.FindField(qryTabLog.Fields[intCnt].FieldName).Value;
    End
    Else If (qryTabOri.FindParam( qryTabLog.Fields[intCnt].FieldName ) <> Nil) And
            (Not qryTabOri.FindParam( qryTabLog.Fields[intCnt].FieldName ).IsNull) Then
    Begin
      qryTabLog.Fields[intCnt].Value := qryTabOri.FindParam( qryTabLog.Fields[intCnt].FieldName ).Value;
    End;
  End;
end;

initialization
  TLogGor.strSeqGor := '';
  TLogGor.strSeqFgo := '';
  TLogGor.strEntRet := '';
  TLogGor.strEmpCar := '';
  TLogGor.strCodPor := '';
  TLogGor.strComplementoFrmLogGor := '';
  TLogGor.blnExecutaLog := False;

end.
