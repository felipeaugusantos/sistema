unit untFatAltValorFreteSugestaoDao;

interface

uses DB, UniClientDataSet, untFatAltValorFreteSugestaoIntf, SysUtils,
     Uni, Variants, StrUtils;

type
  TAltValorFreteSugestaoDao = class(TObject)
  private
    class function fInsertLogFre(AltValorFreteSugestao: IAltValorFreteSugestao): Boolean;
  public
    class function fUpdateByLoteTransportadora(AltValorFreteSugestao: IAltValorFreteSugestao): Boolean;
    class function fUpdateByValorFreteSugestao(AltValorFreteSugestao: IAltValorFreteSugestao): Boolean;
    class function fUpdateByValorFreteSugestaoPelaExpedicao(AltValorFreteSugestao: IAltValorFreteSugestao): Boolean;
    class function fFindByDocumento(strNumDoc, strEspDoc, strCodEmp: String; blnInformaFreteNaFreCot: Boolean = False): IAltValorFreteSugestao;
  end;
  AltValorFreteSugestaoDao = TAltValorFreteSugestaoDao;


implementation

uses untFuncoesSimples, untFactoryClass;

{ TAltValorFreteSugestaoDao }

class function TAltValorFreteSugestaoDao.fFindByDocumento(strNumDoc, strEspDoc,
  strCodEmp: String; blnInformaFreteNaFreCot: Boolean = False): IAltValorFreteSugestao;
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  Result := nil;

  Try

    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   "MOVGER" AS GER_NOMTAB, ';
    strSQL := strSQL + '   GER_CODCLI, ';
    strSQL := strSQL + '   COALESCE(GER_NOMCON, CLI_NOMCLI) AS GER_NOMCLI, ';
    strSQL := strSQL + '   GER_DTAENT, ';
    strSQL := strSQL + '   GER_CONPAG, ';
    strSQL := strSQL + '   GER_CODVEN, ';
    strSQL := strSQL + '   A.OPE_NOMOPE AS GER_NOMVEN, ';
    strSQL := strSQL + '   (SELECT DET_CODREP ';
    strSQL := strSQL + '    FROM MOVDET ';
    strSQL := strSQL + '    WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM LIMIT 1) GER_CODREP, ';
    strSQL := strSQL + '   (SELECT OPE_NOMOPE ';
    strSQL := strSQL + '    FROM MOVDET ';
    strSQL := strSQL + '    JOIN CADOPE ON (OPE_CODOPE = MOVDET.DET_CODREP) ';
    strSQL := strSQL + '    WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM LIMIT 1) GER_NOMREP, ';
    strSQL := strSQL + '   GER_CODTRA, ';
    strSQL := strSQL + '   T.TRA_NOMTRA AS GER_NOMTRA, ';
    strSQL := strSQL + '   GER_BASICM, ';
    strSQL := strSQL + '   GER_TOTICM, ';
    strSQL := strSQL + '   GER_BASIPI, ';
    strSQL := strSQL + '   GER_TOTIPI, ';
    strSQL := strSQL + '   GER_TOTPRO, ';
    strSQL := strSQL + '   GER_VLRCON, ';
    strSQL := strSQL + '   GER_TOTFRE, ';
    strSQL := strSQL + '   GER_BASRET, ';
    strSQL := strSQL + '   GER_TOTRET, ';
    strSQL := strSQL + '   GER_DESACE, ';
    strSQL := strSQL + '   AUX_FRECOT, ';
    strSQL := strSQL + '  (SELECT SUM(DET_FRESUG) FROM MOVDET ';
    strSQL := strSQL + '   JOIN MOVTRI ON (MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER) ';
    strSQL := strSQL + '   WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM) AS GER_FRESUG, ';
    strSQL := strSQL + '   AUX_TRALOT, ';
    strSQL := strSQL + '   MOVGER.AUTOINCREM AS AUTOINCREM ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVGER ';
    strSQL := strSQL + ' JOIN AUXMOV ON (AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM) ';
    strSQL := strSQL + ' LEFT JOIN CADCLI ON (CLI_CODCLI = GER_CODCLI) ';
    strSQL := strSQL + ' LEFT JOIN CADOPE A ON (A.OPE_CODOPE = MOVGER.GER_CODVEN) ';
    strSQL := strSQL + ' LEFT JOIN CADTRA T ON (T.TRA_CODTRA = MOVGER.GER_CODTRA) ';
    strSQL := strSQL + ' WHERE GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '       GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '       GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '       LEFT(GER_CLAFIS, 1) >= 5 ';

    strSQL := strSQL + ' UNION ALL ' +
                       AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER'), 'MOVDET', 'NOTDET'), 'AUXMOV', 'AUXNOT');

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      If Not IsEmpty Then
      begin
        Result := Factory.Create('AltValorFreteSugestao') as IAltValorFreteSugestao;
        Result.strNumDoc    := strNumDoc;
        Result.strEspDoc    := strEspDoc;
        Result.strCodEmp    := strCodEmp;
        Result.strNomEmp    := fRetNomeEmpresa(strCodEmp);
        Result.strCodCli    := FieldByName('GER_CODCLI').AsString;
        Result.strNomCli    := FieldByName('GER_NOMCLI').AsString;
        Result.dtaDtEmis    := FieldByName('GER_DTAENT').AsDateTime;
        Result.strCndPgt    := FieldByName('GER_CONPAG').AsString;
        Result.strCodVen    := FieldByName('GER_CODVEN').AsString;
        Result.strNomVen    := FieldByName('GER_NOMVEN').AsString;
        Result.strCodRep    := FieldByName('GER_CODREP').AsString;
        Result.strNomRep    := FieldByName('GER_NOMREP').AsString;
        Result.strCodTra    := FieldByName('GER_CODTRA').AsString;
        Result.strNomTra    := FieldByName('GER_NOMTRA').AsString;
        Result.fltBasIcm    := FieldByName('GER_BASICM').AsFloat;
        Result.fltValIcm    := FieldByName('GER_TOTICM').AsFloat;
        Result.fltDesAce    := FieldByName('GER_DESACE').AsFloat;
        Result.fltBasTri    := FieldByName('GER_BASRET').AsFloat;
        Result.fltValTri    := FieldByName('GER_TOTRET').AsFloat;
        Result.fltValFre    := FieldByName('GER_TOTFRE').AsFloat;
        Result.fltValPro    := FieldByName('GER_TOTPRO').AsFloat;
        Result.fltBasIpi    := FieldByName('GER_BASIPI').AsFloat;
        Result.fltValIpi    := FieldByName('GER_TOTIPI').AsFloat;
        Result.fltTotNf     := FieldByName('GER_VLRCON').AsFloat;
        Result.AutoIncrem   := FieldByName('AUTOINCREM').AsString;
        Result.strNomTab    := FieldByName('GER_NOMTAB').AsString;
        Result.strTraLot    := FieldByName('AUX_TRALOT').AsString;
        Result.fltValFreOld := IIF(blnInformaFreteNaFreCot, FieldByName('AUX_FRECOT').AsFloat, FieldByName('GER_FRESUG').AsFloat);
        Result.strCodTraNew := '';
        Result.strTraLotNew := '';
        Result.fltValFreNew := 0;
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fFindByDocumento]');
    End;
  end;

  FreeAndNil(qryGen);
end;

class function TAltValorFreteSugestaoDao.fInsertLogFre(
  AltValorFreteSugestao: IAltValorFreteSugestao): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  Result := False;

  Try
    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO LOGFRE ( ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   LOG_NUMDOC, ';
    strSQL := strSQL + '   LOG_ESPDOC, ';
    strSQL := strSQL + '   LOG_CODCLI, ';
    strSQL := strSQL + '   LOG_CODEMP, ';
    strSQL := strSQL + '   LOG_DTAALT, ';
    strSQL := strSQL + '   LOG_HRAALT, ';
    strSQL := strSQL + '   LOG_OPEALT, ';
    strSQL := strSQL + '   LOG_TRAANT, ';
    strSQL := strSQL + '   LOG_TRANOV, ';
    strSQL := strSQL + '   LOG_LOTANT, ';
    strSQL := strSQL + '   LOG_LOTNOV, ';
    strSQL := strSQL + '   LOG_FREANT, ';
    strSQL := strSQL + '   LOG_FRENOV) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '   :AUTOIN, ';
    strSQL := strSQL + '   :NUMDOC, ';
    strSQL := strSQL + '   :ESPDOC, ';
    strSQL := strSQL + '   :CODCLI, ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :DTAALT, ';
    strSQL := strSQL + '   :HRAALT, ';
    strSQL := strSQL + '   :OPEALT, ';
    strSQL := strSQL + '   :TRAANT, ';
    strSQL := strSQL + '   :TRANOV, ';
    strSQL := strSQL + '   :LOTANT, ';
    strSQL := strSQL + '   :LOTNOV, ';
    strSQL := strSQL + '   :FREANT, ';
    strSQL := strSQL + '   :FRENOV ) ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGFRE', VS_strCodEmp);
      ParamByName('NUMDOC').AsString := AltValorFreteSugestao.strNumDoc;
      ParamByName('ESPDOC').AsString := AltValorFreteSugestao.strEspDoc;
      ParamByName('CODCLI').AsString := AltValorFreteSugestao.strCodCli;
      ParamByName('CODEMP').AsString := AltValorFreteSugestao.strCodEmp;
      ParamByName('DTAALT').AsDate   := VS_Date;
      ParamByName('HRAALT').AsTime   := fTime();
      ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
      ParamByName('TRAANT').AsString := AltValorFreteSugestao.strCodTra;
      ParamByName('TRANOV').AsString := AltValorFreteSugestao.strCodTraNew;
      ParamByName('LOTANT').AsString := AltValorFreteSugestao.strTraLot;
      ParamByName('LOTNOV').AsString := AltValorFreteSugestao.strTraLotNew;
      ParamByName('FREANT').AsFloat  := AltValorFreteSugestao.fltValFreOld;
      ParamByName('FRENOV').AsFloat  := AltValorFreteSugestao.fltValFreNew;

      ExecSQL;

      Result := RowsAffected > 0;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fInsertLogFre]');
    End;
  end;

  FreeAndNil(qryGen);
end;

class function TAltValorFreteSugestaoDao.fUpdateByLoteTransportadora(
  AltValorFreteSugestao: IAltValorFreteSugestao): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL,
    strAuxMov: String;

begin
  Result := False;
  strAuxMov := IIF(SameText(AltValorFreteSugestao.strNomTab, 'MOVGER'), 'AUXMOV', 'AUXNOT');

  Try
    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' UPDATE ' + AltValorFreteSugestao.strNomTab;
    strSQL := strSQL + '   JOIN ' + strAuxMov + ' ON AUX_SEQGER = ' + AltValorFreteSugestao.strNomTab + '.AUTOINCREM ';
    strSQL := strSQL + '    SET AUX_TRALOT = :TRALOT ';
    strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTINC').AsString := AltValorFreteSugestao.AutoIncrem;
      ParamByName('TRALOT').AsString := AltValorFreteSugestao.strTraLotNew;

      ExecSQL;

      Result := RowsAffected > 0;

      If Result Then
        Result := fInsertLogFre(AltValorFreteSugestao);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fUpdateByValorFreteSugestao]');
    End;
  end;

  FreeAndNil(qryGen);
end;

class function TAltValorFreteSugestaoDao.fUpdateByValorFreteSugestao(
  AltValorFreteSugestao: IAltValorFreteSugestao): Boolean;
  Var
    qryGen,
    qryItens,
    qryUpdate: TUniQuery;
    strSQL,
    strMovTri,
    strAuxMov,
    strMovDet: String;
    fltValFreIte: Double;
    intCont: Integer;

  function fAtualizaFreteItens: Boolean;
  Begin
    intCont := 0;
    Result  := False;

    Try
      qryItens := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ';
      strSQL := strSQL + strMovDet;
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   DET_SEQGER = :AUTINC ';

      With qryItens Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTINC').AsString := AltValorFreteSugestao.AutoIncrem;

        Open;

        If Not IsEmpty Then
        Begin
          First;

          strSQL := '';
          strSQL := strSQL + ' UPDATE ' + strMovTri;
          strSQL := strSQL + '   SET ';
          strSQL := strSQL + '     DET_FRESUG = :FRESUG  ';
          strSQL := strSQL + ' WHERE DET_SEQGER = :AUTINC ';

          While Not Eof Do
          Begin
            If AltValorFreteSugestao.fltTotNf <> 0 Then
              fltValFreIte := ((AltValorFreteSugestao.fltValFreNew * FieldByName('DET_VLRCON').AsFloat) / AltValorFreteSugestao.fltTotNf)
            Else
              fltValFreIte := 0;

            qryUpdate := fCriaQuery(Nil);

            qryUpdate.Close;
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add(strSQL);

            qryUpdate.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
            qryUpdate.ParamByName('FRESUG').AsFloat  := fltValFreIte;

            qryUpdate.ExecSQL;

            If (qryUpdate.RowsAffected > 0) Then
              Inc(intCont);

            FreeAndNil(qryUpdate);
            Next;
          End;

          Result := (RecordCount = intCont);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fAtualizaFreteItens]');
      End;
    end;

    FreeAndNil(qryItens);
  End;
begin
  Result := False;
  strMovTri := IIF(SameText(AltValorFreteSugestao.strNomTab, 'MOVGER'), 'MOVTRI', 'NOTTRI');
  strAuxMov := IIF(SameText(AltValorFreteSugestao.strNomTab, 'MOVGER'), 'AUXMOV', 'AUXNOT');
  strMovDet := IIF(SameText(AltValorFreteSugestao.strNomTab, 'MOVGER'), 'MOVDET', 'NOTDET');

  Try
    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' UPDATE ' + AltValorFreteSugestao.strNomTab;

    If SameText(AltValorFreteSugestao.strNomTab, 'MOVGER') Then
      strSQL := strSQL + ' JOIN ' + strAuxMov + ' ON AUX_SEQGER = ' + AltValorFreteSugestao.strNomTab + '.AUTOINCREM ';

    strSQL := strSQL + '   SET ';
    strSQL := strSQL + '     GER_CODTRA = :CODTRA  ';

    If SameText(AltValorFreteSugestao.strNomTab, 'MOVGER') Then
      strSQL := strSQL + '    , AUX_FRESUG = :FRESUG   ';

    strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTINC').AsString := AltValorFreteSugestao.AutoIncrem;
      ParamByName('CODTRA').AsString := AltValorFreteSugestao.strCodTraNew;

      If SameText(AltValorFreteSugestao.strNomTab, 'MOVGER') Then
        ParamByName('FRESUG').AsFloat  := AltValorFreteSugestao.fltValFreNew;

      ExecSQL;

      Result := RowsAffected > 0;

      If Result Then
        Result := fAtualizaFreteItens;

      If Result Then
        Result := fInsertLogFre(AltValorFreteSugestao);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fUpdateByValorFreteSugestao]');
    End;
  end;

  FreeAndNil(qryGen);
end;

class function TAltValorFreteSugestaoDao.fUpdateByValorFreteSugestaoPelaExpedicao(
  AltValorFreteSugestao: IAltValorFreteSugestao): Boolean;
  Var
    qryGen,
    qryItens,
    qryUpdate: TUniQuery;
    strSQL,
    strMovTri,
    strAuxMov,
    strMovDet: String;
    fltValFreIte: Double;
    intCont: Integer;

  function fAtualizaFreteItensPelaExpedicao: Boolean;
  Begin
    intCont := 0;
    Result  := False;
    qryItens := fCriaQuery(Nil);
    qryUpdate := fCriaQuery(Nil);

    Try
      Try
        strSQL := '';
        strSQL := strSQL + ' SELECT AUTOINCREM, DET_VLRCON FROM ';
        strSQL := strSQL + strMovDet;
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   DET_SEQGER = :AUTINC ';

        With qryItens Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('AUTINC').AsString := AltValorFreteSugestao.AutoIncrem;

          Open;

          If Not IsEmpty Then
          Begin
            First;

            strSQL := '';
            strSQL := strSQL + ' UPDATE ' + strMovTri;
            strSQL := strSQL + '   SET ';
            strSQL := strSQL + '     DET_FRECOT = :FRECOT  ';
            strSQL := strSQL + ' WHERE DET_SEQGER = :AUTINC ';

            qryUpdate.Close;
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add(strSQL);

            While Not Eof Do
            Begin
              If AltValorFreteSugestao.fltTotNf <> 0 Then
                fltValFreIte := ((AltValorFreteSugestao.fltValFreNew * FieldByName('DET_VLRCON').AsFloat) / AltValorFreteSugestao.fltTotNf)
              Else
                fltValFreIte := 0;

              qryUpdate.Close;

              qryUpdate.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
              qryUpdate.ParamByName('FRECOT').AsFloat  := fltValFreIte;

              qryUpdate.ExecSQL;

              If (qryUpdate.RowsAffected > 0) Then
                Inc(intCont);

              Next;
            End;

            Result := (RecordCount = intCont);
          End;
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[fAtualizaFreteItens]');
        End;
      end;
    Finally
      FreeAndNil(qryItens);
      FreeAndNil(qryUpdate);
    End;
  End;
begin
  Result := False;
  strMovTri := IIF(SameText(AltValorFreteSugestao.strNomTab, 'MOVGER'), 'MOVTRI', 'NOTTRI');
  strAuxMov := IIF(SameText(AltValorFreteSugestao.strNomTab, 'MOVGER'), 'AUXMOV', 'AUXNOT');
  strMovDet := IIF(SameText(AltValorFreteSugestao.strNomTab, 'MOVGER'), 'MOVDET', 'NOTDET');

  qryGen := fCriaQuery(Nil);

  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' UPDATE ' + AltValorFreteSugestao.strNomTab;
      strSQL := strSQL + ' JOIN ' + strAuxMov + ' ON AUX_SEQGER = ' + AltValorFreteSugestao.strNomTab + '.AUTOINCREM ';
      strSQL := strSQL + '   SET ';
      strSQL := strSQL + '     AUX_FRECOT = :FRECOT,  ';
      strSQL := strSQL + '     GER_CODTRA = :CODTRA   ';
      strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTINC').AsString := AltValorFreteSugestao.AutoIncrem;
        ParamByName('CODTRA').AsString := AltValorFreteSugestao.strCodTraNew;
        ParamByName('FRECOT').AsFloat := AltValorFreteSugestao.fltValFreNew;

        ExecSQL;

        Result := RowsAffected > 0;

        If Result Then
          Result := fAtualizaFreteItensPelaExpedicao;

        If Result Then
          Result := fInsertLogFre(AltValorFreteSugestao);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fUpdateByValorFreteSugestaoPelaExpedicao]');
      End;
    end;
  Finally
    FreeAndNil(qryGen);
  End;
end;

end.
