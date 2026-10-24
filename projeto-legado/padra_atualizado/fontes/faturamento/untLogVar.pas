unit untLogVar;

interface

Uses
  Classes, SysUtils, Uni, StrUtils, UniClientDataSet, untFuncoes, untFuncoesSimples,
  DateUtils, untTypesSistema, Math, untWorkStationInfo;

function fGeraNumLiberacao(strDirAce: String): String;

function fObtemInfoLog(strNumLib: String; Var strInfLog: String; strCodCli: String = ''): Boolean;

function StringBuilder(const aString: string): string;

function fGravaLogVar(strNumLib, strInfLog, strCodOpe, strCodDig, strCodCli, strCodLib: String; cdsXmlTra: TUniClientDataSet = Nil; cdsXmlF4: TUniClientDataSet = Nil; cdsXmlLib: TUniClientDataSet = Nil): Boolean;

procedure pUpdateLogVar(strNumLib, strOpeLib: String; blnCodEmp: Boolean = True; strEmpDes: String = ''; horaEnv: TTime = 0; horalib: TTime = 0);

procedure pApagaLogVarNaoUtilizado(stlNumLib: TStringList; arrLogLib: Array Of TLogLib);

function fRetornaClienteDaLiberacao(const strNumLib: String): String;

function fRetornaXmlClientTravasMinimas(const strNumLib: String; const strCampo: String = 'AUX_DADOSC'): String;

procedure pGravarJustificativa(strNumLib, strJustif: String);

procedure pRegistraUltimoBloqueio(strMensag: String; strMsgLib: String = ''; blnNivel2: Boolean = False; blnNivel3: Boolean = False); overload;
procedure pRegistraUltimoBloqueio(arrMenSag: TStringArray; arrMsgLib: TStringArray = Nil); overload;

procedure pUpdateAuxVar(Const strSeqVar, strCodCli, strCodVen, strMsgJustificativaNegada: String);

const
  strCAMPOLIB = 'MSGLIB';
  cnstIntTamIniCodLib = 5;
  cnstIntTamFatorMult = 2;

implementation

uses Data.DB, Datasnap.DBClient, untFuncFat, untModulo, untConstantes;

function fObtemInfoLog(strNumLib: String; Var strInfLog: String; strCodCli: String = ''): Boolean;
  Var
    qryGen: TUniQuery;
    stlInfLog: TStringList;
Begin
  stlInfLog := TSTringList.Create;
  stlInfLog.Clear;

  If Not fEmptyStr(strCodCli) Then
    stlInfLog.Add('Cliente.....: ' + strCodCli);

  Result := FALSE;
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT                                           ');
    Add('  LOG_INFORM AS INFORM,                          ');
    Add('  LOG_JUSTIF AS JUSTIF,                          ');
    Add('  LOG_CODDIG,                                    ');
    Add('  CONCAT(LOG_CODVEN,"-",V.OPE_NOMOPE) AS NOMVEN, ');
    Add('  CONCAT(LOG_CODDIG,"-",D.OPE_NOMOPE) AS NOMDIG,  ');
    Add('  LOG_CODEMP AS CODEMP');
    Add('FROM LOGVAR           ');
    Add('LEFT JOIN CADOPE V ON V.OPE_CODOPE = LOG_CODVEN  ');
    Add('LEFT JOIN CADOPE D ON D.OPE_CODOPE = LOG_CODDIG  ');
    Add('WHERE                 ');
    Add('  LOG_NROLIB = :NROLIB');

    ParamByName('NROLIB').AsString := strNumLib;

    Open;

    If IsEmpty Then
    Begin
      stlInfLog.Add('REGISTRO DE PEDIDO DE LIBERAÇÃO NÃO ECONTRADO');
    End Else
    Begin
      If Not fEmptyStr(FieldByName('JUSTIF').AsString) Then
      Begin
        stlInfLog.Add(FieldByName('JUSTIF').AsString);
        stlInfLog.Add('');
      End;

      stlInfLog.Add('Vendedor........: ' + FieldByName('NOMVEN').AsString);

      If Not FieldByName('LOG_CODDIG').IsNull Then
        stlInfLog.Add('Digitador.......: ' + FieldByName('NOMDIG').AsString);

      stlInfLog.Add('Emp. Solicitante: ' + Copy(FieldByName('CODEMP').AsString+'-'+
                                           fRetNomeEmpresaSelec(FieldByName('CODEMP').AsString),1,50));

      stlInfLog.Add('');
      stlInfLog.Add(FieldByName('INFORM').AsString);

      Result := TRUE;
    End;

  End;

  strInfLog :=  stlInfLog.Text;

  FreeAndNil(qryGen);
  FreeAndNil(stlInfLog);
End;

function StringBuilder(const aString: string): string;
  Var
    sb: TStringBuilder;
begin
  sb := TStringBuilder.Create;
  Try
    sb.Append(aString);
    sb.Replace('"', '\''');
    Result := sb.ToString();
  Finally
    FreeAndNil(sb);
  End;
end;

Function fGravaLogVar(strNumLib, strInfLog, strCodOpe, strCodDig, strCodCli, strCodLib: String; cdsXmlTra: TUniClientDataSet = Nil; cdsXmlF4: TUniClientDataSet = Nil; cdsXmlLib: TUniClientDataSet = Nil): Boolean;
  Var
    qryGen: TUniQuery;
    strAutInc,
    strXmlTra: String;
    StringStream: TStringStream;
    blnCommit : Boolean;
    strXmlF4 : String;
    strXmlLib: String;
    blnGravaLogTransacao: Boolean;
Begin
  Result := True;
  blnGravaLogTransacao := VS_blnGravaLogTransacao;
  qryGen := fCriaQuery;

  strInfLog := fLimpaTagMsgOculta(strInfLog);
  Try
    Try
      VS_blnGravaLogTransacao := False;

      blnCommit := (Not frmModulo.GetCurrentConnection.InTransaction);

      If (blnCommit) Then
        fStartTransaction;

      StringStream := Nil;
      With qryGen, SQL Do
      Begin
        Close;
        Clear;
        Add('INSERT INTO LOGVAR (');
        Add('  AUTOINCREM,');
        Add('  LOG_NROLIB,');
        Add('  LOG_INFORM,');
        Add('  LOG_CODVEN,');
        Add('  LOG_CODDIG,');
        Add('  LOG_CODEMP,');
        Add('  LOG_DTAPED,');
        Add('  LOG_HORPED,');
        Add('  LOG_CODCLI, ');
        Add('  LOG_CODLIB ');
        Add(') VALUES (');
        Add('  :AUTOIN,');
        Add('  :NROLIB,');
        Add('  :INFORM,');
        Add('  :CODVEN,');
        Add('  :CODDIG,');
        Add('  :CODEMP,');
        Add('  :DTAPED,');
        Add('  :HORPED,');
        Add('  :CODCLI, ');
        Add('  :CODLIB ');
        Add(')');

        strAutInc := fRetAutoIncrem('LOGVAR',VS_strCodEmp);

        ParamByName('AUTOIN').AsString := strAutInc;
        ParamByName('NROLIB').AsString := strNumLib;
        ParamByName('INFORM').AsString := strInfLog;

        If Not fEmptyStr(strCodOpe) Then
          ParamByName('CODVEN').AsString := strCodOpe;

        If Not fEmptyStr(strCodDig) Then
          ParamByName('CODDIG').AsString := strCodDig;

        If fEmptyStr(strCodDig) Or (Not fCfgSis('USADIG', varBoolean)) Then
          ParamByName('CODDIG').Clear;
      
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('DTAPED').AsDate   := VS_Date;
        ParamByName('HORPED').AsTime   := fTime();
        ParamByName('CODCLI').AsString := strCodCli;

        If Not fEmptyStr(strCodLib) Then
          ParamByName('CODLIB').AsString := strCodLib;

        Try
          ExecSQL;

          If RowsAffected = 0 Then
          Begin
            fRollBack;
            Raise Exception.Create('Falha na gravação do Log da senha de liberação (LOGVAR). Por favor tente novamente.');
          End;

          Result := RowsAffected > 0;
        Except
          fRollBack;
          Raise Exception.Create('Falha na gravação do Log da senha de liberação (LOGVAR). Por favor tente novamente.');
        End;
      End;

      If Result Then
      Begin
        If Assigned(cdsXmlTra) Then
        Begin
          StringStream := TStringStream.Create('');
          cdsXmlTra.Cancel;
          cdsXmlTra.SaveToStream(StringStream, dfXML);
          strXmlTra := StringStream.DataString;
        End
        Else
          strXmlTra := '';

        If Assigned(cdsXmlF4) Then
        Begin
          If Assigned(StringStream) Then
            FreeAndNil(StringStream);

          StringStream := TStringStream.Create('');
          cdsXmlF4.Cancel;
          cdsXmlF4.SaveToStream(StringStream, dfXML);
          strXmlF4 := StringStream.DataString;
        End
        Else
          strXmlF4 := '';

        If Assigned(cdsXmlLib) Then
        Begin
          strXmlLib := AnsiReplaceStr(cdsXmlLib.FieldByName(strCAMPOLIB).AsString, #13#10, STRING_QUEBRA);
        End
        Else
          strXmlLib := '';

        strXmlLib := fLimpaTagMsgOculta(strXmlLib);

        FreeAndNil(qryGen);
        qryGen := fCriaQuery;

        With qryGen, SQL Do
        Begin
          Close;
          Clear;

          Add('INSERT INTO AUXVAR (');
          Add('  AUX_SEQVAR,');
          Add('  AUX_DADOSC,');
          Add('  AUX_INFOF4, ');
          Add('  AUX_INFLIB ');
          Add(') VALUES (');
          Add('  "' + strAutInc + '",');
          Add('  "' + StringBuilder(strXmlTra) + '", ');
          Add('  "' + StringBuilder(strXmlF4) + '", ');
          Add('  "' + StringBuilder(strXmlLib) + '") ');

          ExecSQL;

          If Assigned(StringStream) Then
            FreeAndNil(StringStream);

          If RowsAffected = 0 Then
            Raise Exception.Create('Falha na gravação do Log da senha de liberação (AUXVAR). Por favor tente novamente.');

          Result := RowsAffected > 0;
        End;

        If Result Then
        begin
          If (blnCommit) Then
            fCommit;
        end
        Else
          fRollBack;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'Falha na gravação do Log da senha de liberação (AUXVAR). Por favor tente novamente. [fGravaLogVar]');
      End;
    End;
  Finally
    VS_blnGravaLogTransacao := blnGravaLogTransacao;
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
End;

procedure pUpdateLogVar(strNumLib, strOpeLib: String; blnCodEmp: Boolean = True; strEmpDes: String = ''; horaEnv: TTime = 0; horalib: TTime = 0);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Close;
    Clear;

    Add('UPDATE LOGVAR ');
    Add('SET LOG_OPELIB = :OPELIB, ');
    Add('    LOG_HORLIB = :HORLIB, ');
    Add('    LOG_DTALIB = :DTALIB, ');
    Add('    LOG_HORENV = :HORENV, ');
    Add('    LOG_DTAENV = :DTAENV, ');
    Add('    LOG_NOMMAQ = :NOMMAQ, ');
    Add('    LOG_NOMUSU = :NOMUSU, ');
    If fExisteAlgumDestinatarioSemEsseDireitoAcesso('PVPMLR') Then
      Add('  LOG_INFORM = REPLACE(REPLACE(LOG_INFORM, "'+STRING_MENSAGEM_OCULTA_INI_REC+'", "  "),"'+STRING_MENSAGEM_OCULTA_FIM_REC+'","  "), ');
    Add('    LOG_NUM_IP = :NUM_IP, ');
    Add('    LOG_WTSMAQ = :WTSMAQ  ');
    Add('WHERE ');

    If blnCodEmp Then
      Add('  LOG_CODEMP = :CODEMP AND ');

    Add('  LOG_NROLIB = :NROLIB ');

    // EMPRESA DESTINO PARA O REPLICADOR
    If Not fEmptyStr(strEmpDes) Then
      Add('-- <EMPRESA DESTINO>=' + strEmpDes);

    ParamByName('NROLIB').AsString := strNumLib;
    ParamByName('OPELIB').AsString := strOpeLib;
    ParamByName('DTALIB').AsDate   := VS_Date;
    ParamByName('HORLIB').AsTime   := iif(horaLib = 0, fTime(), horaLib);
    ParamByName('HORENV').AsTime   := iif(horaEnv = 0, fTime(), horaEnv);
    ParamByName('DTAENV').AsDate   := VS_Date;
    ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
    ParamByName('NOMUSU').AsString := VS_UserFromWindows;
    ParamByName('NUM_IP').AsString := VS_IPAddressAsString;
    ParamByName('WTSMAQ').AsString := TWorkStationInfo.fGetWorkstationID;

    If blnCodEmp Then
      ParamByName('CODEMP').AsString := VS_strCodEmp;

    ExecSQL;
  End;
  FreeAndNil(qryGen);
End;

procedure pApagaLogVarNaoUtilizado(stlNumLib: TStringList; arrLogLib: Array Of TLogLib);
  Var
    intLogVar,
    intArrLog: Integer;
    strDelete: String;
    blnGravou: Boolean;
    qryGen   : TUniQuery;
Begin
  If Not Assigned(stlNumLib) Then
    Exit;

  If stlNumLib.Count = 0 then
    Exit;

  strDelete := '';
  For intLogVar := 0 To stlNumLib.Count - 1 Do
  Begin
    blnGravou := FALSE;

    If (Length(arrLogLib) > 0) then
    begin
      For intArrLog := Low(arrLogLib) To High(arrLogLib) Do
      Begin
        if SameText(stlNumLib[intLogVar],arrLogLib[intArrLog].strNumLib) Then
        Begin
          blnGravou := arrLogLib[intArrLog].blnInsLog;
          break;
        End;
      End;
    End;

    If (Not blnGravou) And (Not fEmptyStr(stlNumLib[intLogVar])) Then
      strDelete := strDelete + QuotedStr(stlNumLib[intLogVar]) + ', ';
  End;

  If Not fEmptyStr(strDelete) Then
  Begin
    strDelete := LeftStr(strDelete,Length(strDelete)-2);
    If (Not fEmptyStr(strDelete)) Then
    Begin
      qryGen := fCriaQuery;
      Try
        With qryGen, SQL Do
        Begin
          Close;
          Clear;

          Add('DELETE FROM LOGVAR ');
          Add('WHERE LOG_NROLIB IN (' + strDelete + ')');

          ExecSQL;
        End;
      Finally
        FreeAndNil(qryGen);
      End;
    End;
  End;

  stlNumLib.Clear;
End;

function fRetornaClienteDaLiberacao(const strNumLib: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  qryGen.SQL.Add('SELECT LOG_CODCLI FROM LOGVAR WHERE LOG_NROLIB = :NUMLIB');
  qryGen.ParamByName('NUMLIB').AsString := strNumLib;
  qryGen.Open;

  Result := qryGen.FieldByName('LOG_CODCLI').AsString;

  FreeAndNil(qryGen);
end;

function fRetornaXmlClientTravasMinimas(const strNumLib: String; const strCampo: String = 'AUX_DADOSC'): String;
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  Result := '';

  Try
    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   ' + strCampo + ' ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + '   AUXVAR ';
    strSQL := strSQL + ' JOIN LOGVAR ON (LOGVAR.AUTOINCREM = AUXVAR.AUX_SEQVAR) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   LOGVAR.LOG_NROLIB = :NUMLIB ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('NUMLIB').AsString := strNumLib;

      Open;

      If Not IsEmpty Then
        Result := FieldByName(strCampo).AsString;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fGeraNumLiberacao(strDirAce: String): String;
  Var
    intMilliSeconds: Int64;
    qryGenVar: TUniQuery;
    strFatorMultZerado: String;
Begin
  qryGenVar := fCriaQuery;

  With qryGenVar Do
  Begin

    Repeat
      strFatorMultZerado := fPadR('0', cnstIntTamFatorMult, '0');
      Repeat
        intMilliSeconds := MilliSecondOfTheDay(VS_Date + fTime());
        if intMilliSeconds <= 999999 then
          intMilliSeconds := StrToInt(IntToStr(intMilliSeconds) + IntToStr(Random(99)));
        Result := fPadR(IntToStr(intMilliSeconds), 8, '0');
      Until RightStr(Result, cnstIntTamFatorMult) <> strFatorMultZerado;

      Result := RightStr(Result, cnstIntTamIniCodLib);

      Result := Result + IntToStr(StrToInt(RightStr(Result, cnstIntTamFatorMult)) * fRetTagMenu(strDirAce));

      Close;
      SQL.Clear;

      SQL.Add('SELECT                  ');
      SQL.Add('  LOG_NROLIB AS NROLIB  ');
      SQL.Add('FROM                    ');
      SQL.Add('  LOGVAR                ');
      SQL.Add('WHERE                   ');
      SQL.Add('  LOG_NROLIB = :NROLIB  ');

      ParamByName('NROLIB').AsString := Result;
      Open;

      If SameText(FieldByName('NROLIB').AsString, Result) Then
        Sleep(1000);

    Until (Not SameText(FieldByName('NROLIB').AsString, Result));

  End;

  FreeAndNil(qryGenVar);

End;

procedure pGravarJustificativa(strNumLib, strJustif: String);
  Var
    qryGen : TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE LOGVAR ');
      SQL.Add('    SET LOG_JUSTIF = :JUSTIF ');
      SQL.Add('  WHERE LOG_NROLIB = :NROLIB ');
      SQL.Add('    AND LOG_CODEMP = :CODEMP ');
      ParamByName('JUSTIF').AsString := strJustif;
      ParamByName('NROLIB').AsString := strNumLib;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure pRegistraUltimoBloqueio(strMensag: String; strMsgLib: String = ''; blnNivel2: Boolean = False; blnNivel3: Boolean = False);
begin
  VS_strInfUltBlo := strMensag;
  VS_strInfUltLib := strMensag + #13#10 + strMsgLib;

  VS_blnNivel2 := blnNivel2 or VS_blnNivel2;
  VS_blnNivel3 := blnNivel3 or VS_blnNivel3;
end;

procedure pRegistraUltimoBloqueio(arrMenSag: TStringArray; arrMsgLib: TStringArray = Nil);
Var
  strInfo: String;
begin

  VS_strInfUltBlo := '';
  VS_strInfUltLib := '';

  For strInfo In arrMenSag Do
  Begin
    VS_strInfUltBlo := VS_strInfUltBlo + strInfo + #13#10;
    VS_strInfUltLib := VS_strInfUltLib + strInfo + #13#10;
  End;

  If Assigned(arrMsgLib) Then
    For strInfo In arrMsgLib Do
      VS_strInfUltLib := VS_strInfUltLib + strInfo + #13#10;
end;

procedure pUpdateAuxVar(Const strSeqVar, strCodCli, strCodVen, strMsgJustificativaNegada: String);
  Var
    qryAuxVar: TUniQuery;
begin
  If fEmptyStr(strSeqVar) Then
    Exit;

  qryAuxVar := fCriaQuery;
  Try
    qryAuxVar.Close;
    qryAuxVar.SQL.Clear;

    qryAuxVar.SQL.Add('UPDATE AUXVAR ');
    qryAuxVar.SQL.Add('INNER JOIN LOGVAR ON AUTOINCREM = AUX_SEQVAR ');
    qryAuxVar.SQL.Add('SET AUX_INFLIB = :INFLIB ');
    qryAuxVar.SQL.Add('WHERE LOG_NROLIB = :NROLIB');
    qryAuxVar.SQL.Add(' AND LOG_CODEMP = :CODEMP');
    qryAuxVar.SQL.Add(' AND LOG_CODVEN = :CODVEN');
    qryAuxVar.SQL.Add(' AND LOG_CODCLI = :CODCLI');

    qryAuxVar.ParamByName('NROLIB').AsString := strSeqVar;
    qryAuxVar.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAuxVar.ParamByName('CODVEN').AsString := strCodVen;
    qryAuxVar.ParamByName('CODCLI').AsString := strCodCli;
    qryAuxVar.ParamByName('INFLIB').AsString := fLimpaTagMsgOculta(AnsiReplaceStr(strMsgJustificativaNegada, #13#10, STRING_QUEBRA), omlMsgParaQuemReceb);

    qryAuxVar.ExecSQL;
  Finally
    FreeAndNil(qryAuxVar);
  End;
end;

end.

