unit untFatAltTipoAtendimentoDao;

interface

uses DB, UniClientDataSet, untFatAltTipoAtendimentoIntf, SysUtils,
     Uni, Variants;

type
  TAltTipoAtendimentoDao = class(TObject)
  private
    class function fInsertLogTpa(AltTipoAntendimento: IAltTipoAtendimento): Boolean;
  public
    class function fUpdateByTipoAtendimento(AltTipoAntendimento: IAltTipoAtendimento): Boolean;
    class function fFindByDocumento(strNumDoc, strEspDoc, strCodEmp: String): IAltTipoAtendimento;
  end;

  AltTipoAtendimentoDao = TAltTipoAtendimentoDao;

implementation

uses untFuncoesSimples, untFactoryClass;

{ TAltTipoAtendimentoDao }


class function TAltTipoAtendimentoDao.fFindByDocumento(strNumDoc, strEspDoc,
  strCodEmp: String): IAltTipoAtendimento;
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  Result := nil;

  Try

    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   FGO_CODCLI, ';
    strSQL := strSQL + '   COALESCE(FGO_NOMCON, CLI_NOMCLI) AS FGO_NOMCLI, ';
    strSQL := strSQL + '   FGO_DTAENT, ';
    strSQL := strSQL + '   FGO_CONPAG, ';
    strSQL := strSQL + '   FGO_CODVEN, ';
    strSQL := strSQL + '   A.OPE_NOMOPE AS FGO_NOMVEN, ';
    strSQL := strSQL + '   (SELECT FDO_CODREP ';
    strSQL := strSQL + '      FROM FATDOR ';
    strSQL := strSQL + '    WHERE FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM LIMIT 1) FGO_CODREP, ';
    strSQL := strSQL + '   (SELECT OPE_NOMOPE ';
    strSQL := strSQL + '      FROM FATDOR ';
    strSQL := strSQL + '    JOIN CADOPE ON (OPE_CODOPE = FATDOR.FDO_CODREP) ';
    strSQL := strSQL + '    WHERE FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM LIMIT 1) FGO_NOMREP, ';
    strSQL := strSQL + '   FGO_VLRCON, ';
    strSQL := strSQL + '   FGO_CODTPA, ';
    strSQL := strSQL + '   (SELECT TPA_DESCRI ';
    strSQL := strSQL + '      FROM CADTPA ';
    strSQL := strSQL + '    WHERE TPA_CODIGO = FGO_CODTPA LIMIT 1) FGO_DESTPA, ';
    strSQL := strSQL + '   FATGOR.AUTOINCREM AS AUTOINCREM ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   FATGOR ';
    strSQL := strSQL + '   JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSQL := strSQL + '   LEFT JOIN CADCLI   ON (CLI_CODCLI   = FGO_CODCLI) ';
    strSQL := strSQL + '   LEFT JOIN CADOPE A ON (A.OPE_CODOPE = FATGOR.FGO_CODVEN) ';
    strSQL := strSQL + ' WHERE FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '       FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '       FGO_CODEMP = :CODEMP ';

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
        Result := Factory.Create('AltTipoAtendimento') as IAltTipoAtendimento;
        Result.strNumDoc    := strNumDoc;
        Result.strEspDoc    := strEspDoc;
        Result.strCodEmp    := strCodEmp;
        Result.strNomEmp    := fRetNomeEmpresa(strCodEmp);
        Result.strCodCli    := FieldByName('FGO_CODCLI').AsString;
        Result.strNomCli    := FieldByName('FGO_NOMCLI').AsString;
        Result.dtaDtEmis    := FieldByName('FGO_DTAENT').AsDateTime;
        Result.strCndPgt    := FieldByName('FGO_CONPAG').AsString;
        Result.strCodVen    := FieldByName('FGO_CODVEN').AsString;
        Result.strNomVen    := FieldByName('FGO_NOMVEN').AsString;
        Result.strCodRep    := FieldByName('FGO_CODREP').AsString;
        Result.strNomRep    := FieldByName('FGO_NOMREP').AsString;
        Result.fltValDoc    := FieldByName('FGO_VLRCON').AsFloat;
        Result.strCodAteAtu := FieldByName('FGO_CODTPA').AsString;
        Result.strTipAteAtu := FieldByName('FGO_DESTPA').AsString;
        Result.AutoIncrem   := FieldByName('AUTOINCREM').AsString;
        Result.strTipAteNew := '';
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


class function TAltTipoAtendimentoDao.fInsertLogTpa(
  AltTipoAntendimento: IAltTipoAtendimento): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  Result := False;

  Try
    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO LOGTPA ( ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   LOG_NUMDOC, ';
    strSQL := strSQL + '   LOG_ESPDOC, ';
    strSQL := strSQL + '   LOG_CODCLI, ';
    strSQL := strSQL + '   LOG_CODEMP, ';
    strSQL := strSQL + '   LOG_DTAALT, ';
    strSQL := strSQL + '   LOG_HRAALT, ';
    strSQL := strSQL + '   LOG_OPEALT, ';
    strSQL := strSQL + '   LOG_INFANT, ';
    strSQL := strSQL + '   LOG_INFNOV) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '   :AUTOIN, ';
    strSQL := strSQL + '   :NUMDOC, ';
    strSQL := strSQL + '   :ESPDOC, ';
    strSQL := strSQL + '   :CODCLI, ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :DTAALT, ';
    strSQL := strSQL + '   :HRAALT, ';
    strSQL := strSQL + '   :OPEALT, ';
    strSQL := strSQL + '   :INFANT, ';
    strSQL := strSQL + '   :INFNOV ) ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGTPA', VS_strCodEmp);
      ParamByName('NUMDOC').AsString := AltTipoAntendimento.strNumDoc;
      ParamByName('ESPDOC').AsString := AltTipoAntendimento.strEspDoc;
      ParamByName('CODCLI').AsString := AltTipoAntendimento.strCodCli;
      ParamByName('CODEMP').AsString := AltTipoAntendimento.strCodEmp;
      ParamByName('DTAALT').AsDate   := VS_Date;
      ParamByName('HRAALT').AsTime   := fTime();
      ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
      ParamByName('INFANT').AsString := AltTipoAntendimento.strCodAteAtu;
      ParamByName('INFNOV').AsString := AltTipoAntendimento.strTipAteNew;

      ExecSQL;

      Result := RowsAffected > 0;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fInsertLogTpa]');
    End;
  end;

  FreeAndNil(qryGen);
end;

class function TAltTipoAtendimentoDao.fUpdateByTipoAtendimento(
  AltTipoAntendimento: IAltTipoAtendimento): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  Result := False;

  Try
    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' UPDATE EXTGOR ';
    strSQL := strSQL + '   SET ';
    strSQL := strSQL + '     FGO_CODTPA = :CODTPA ';
    strSQL := strSQL + ' WHERE FGO_SEQFGO = :AUTINC ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTINC').AsString := AltTipoAntendimento.AutoIncrem;

      If fEmptyStr(AltTipoAntendimento.strTipAteNew) Then
        ParamByName('CODTPA').Value := Null
      Else
        ParamByName('CODTPA').AsString := AltTipoAntendimento.strTipAteNew;

      ExecSQL;

      Result := RowsAffected > 0;

      If Result Then
        Result := fInsertLogTpa(AltTipoAntendimento);

      fLock_Unlock('FATGOR' +
                   AltTipoAntendimento.strNumDoc +
                   AltTipoAntendimento.strEspDoc +
                   AltTipoAntendimento.strCodEmp, False, False);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fUpdateByTipoAtendimento]');
    End;
  end;

  FreeAndNil(qryGen);
end;

end.
