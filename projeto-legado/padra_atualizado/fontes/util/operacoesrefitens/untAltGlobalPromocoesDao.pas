unit untAltGlobalPromocoesDao;

interface

uses DB, UniClientDataSet, untAltGlobalPromocoesIntf, SysUtils, Uni, Variants, untConstantes,
  System.StrUtils;

type
  TAltGlobalPromocoesDao = class(TObject)
  private
    class function fInsertLogPro(qryDados: TUniClientDataSet; strTipCam: String; VS_HorLog: TTime): Boolean;
  public
    class function fUpdatePromocoes(qryDados: TUniClientDataSet): Boolean;
    class function fFindByPromocoes(objAltGloPro: IAltGlobalPromocoes;
      strWhere: String = ''; pSetaParam: TGenericProcedureWithQuery = Nil): TUniQuery;
  end;

  AltGlobalPromocoesDao = TAltGlobalPromocoesDao;

implementation

uses untFuncoesSimples, untFactoryClass;

{ TAltGlobalPromocoesDao }

class function TAltGlobalPromocoesDao.fFindByPromocoes(objAltGloPro: IAltGlobalPromocoes;
  strWhere: String = ''; pSetaParam: TGenericProcedureWithQuery = Nil): TUniQuery;
  Var
    qryTmp: TUniQuery;
    strSQL: String;

  function fGetTabPre(strTabPre: String): String;
    Var
      intCont: Integer;
  Begin
    Result := '';

    For intCont := 1 To Length(strTabPre) Do
    Begin
      If strTabPre[intCont] = 'S' Then
        Result := Result + IntToStr(intCont) + ',';
    End;

    If Not fEmptyStr(Result) Then
    Begin
      If Result[Length(Result)] = ',' Then
      Begin
        Result[Length(Result)] := ' ';
        Result := Trim(Result);
      End;
    End;
  End;
begin
  Try
    qryTmp := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT                                              ';
    strSQL := strSQL + '   P.AUTOINCREM AS PRO_AUTINC,                       ';
    strSQL := strSQL + '   P.PRO_CODPRO,                                     ';
    strSQL := strSQL + '   CONCAT(P.PRO_CODPRO, "-", P.PRO_DESPRO) AS PRO_DESPRO, ';
    strSQL := strSQL + '   I.AUTOINCREM AS IPR_AUTINC,                       ';
    strSQL := strSQL + '   I.IPR_PRECUS AS IPR_PRECUS_ATU,                   ';

    If objAltGloPro.blnPreCus Then
    Begin
      strSQL := strSQL + IfThen(objAltGloPro.taTipAlt = taFator, 'IPR_PRECUS * ', '') + AnsiReplaceStr(AnsiReplaceStr(FloatToStr(objAltGloPro.fltPreCus), '.', ''), ',', '.') + ' AS IPR_PRECUS_NOV, ';
      strSQL := strSQL + '   "S"          AS IPR_PRECUS_ALT,                 ';
    End
    Else
    Begin
      strSQL := strSQL + '   0.00         AS IPR_PRECUS_NOV,                 ';
      strSQL := strSQL + '   "N"          AS IPR_PRECUS_ALT,                 ';
    End;

    strSQL := strSQL + '   I.IPR_PREVEN AS IPR_PREVEN_ATU,                   ';

    If objAltGloPro.blnPreVen Then
    Begin
      strSQL := strSQL + IfThen(objAltGloPro.taTipAlt = taFator, 'IPR_PREVEN * ', '') + AnsiReplaceStr(AnsiReplaceStr(FloatToStr(objAltGloPro.fltPreVen), '.', ''), ',', '.') + ' AS IPR_PREVEN_NOV, ';
      strSQL := strSQL + '   "S"          AS IPR_PREVEN_ALT,                 ';
    End
    Else
    Begin
      strSQL := strSQL + '   0.00         AS IPR_PREVEN_NOV,                 ';
      strSQL := strSQL + '   "N"          AS IPR_PREVEN_ALT,                 ';
    End;

    strSQL := strSQL + '   I.IPR_PERDES AS IPR_PERDES_ATU,                   ';

    If objAltGloPro.blnPerDes Then
    Begin
      strSQL := strSQL + IfThen(objAltGloPro.taTipAlt = taFator, 'IPR_PERDES * ', '') + AnsiReplaceStr(AnsiReplaceStr(FloatToStr(objAltGloPro.fltPerDes), '.', ''), ',', '.') + ' AS IPR_PERDES_NOV, ';
      strSQL := strSQL + '   "S"          AS IPR_PERDES_ALT,                 ';
    End
    Else
    Begin
      strSQL := strSQL + '   0.00         AS IPR_PERDES_NOV,                 ';
      strSQL := strSQL + '   "N"          AS IPR_PERDES_ALT,                 ';
    End;

    strSQL := strSQL + '   I.IPR_COMVAR AS IPR_COMVAR_ATU,                   ';

    If objAltGloPro.blnComInt Then
    Begin
      strSQL := strSQL + IfThen(objAltGloPro.taTipAlt = taFator, 'IPR_COMVAR * ', '') + AnsiReplaceStr(AnsiReplaceStr(FloatToStr(objAltGloPro.fltComInt), '.', ''), ',', '.') + ' AS IPR_COMVAR_NOV, ';
      strSQL := strSQL + '   "S"          AS IPR_COMVAR_ALT,                 ';
    End
    Else
    Begin
      strSQL := strSQL + '   0.00         AS IPR_COMVAR_NOV,                 ';
      strSQL := strSQL + '   "N"          AS IPR_COMVAR_ALT,                 ';
    End;

    strSQL := strSQL + '   I.IPR_COMATA AS IPR_COMATA_ATU,                   ';

    If objAltGloPro.blnComLoj Then
    Begin
      strSQL := strSQL + IfThen(objAltGloPro.taTipAlt = taFator, 'IPR_COMATA * ', '') + AnsiReplaceStr(AnsiReplaceStr(FloatToStr(objAltGloPro.fltComLoj), '.', ''), ',', '.') + ' AS IPR_COMATA_NOV, ';
      strSQL := strSQL + '   "S"          AS IPR_COMATA_ALT,                 ';
    End
    Else
    Begin
      strSQL := strSQL + '   0.00         AS IPR_COMATA_NOV,                 ';
      strSQL := strSQL + '   "N"          AS IPR_COMATA_ALT,                 ';
    End;

    strSQL := strSQL + '   I.IPR_COMDIS AS IPR_COMDIS_ATU,                   ';

    If objAltGloPro.blnComDis Then
    Begin
      strSQL := strSQL + IfThen(objAltGloPro.taTipAlt = taFator, 'IPR_COMDIS * ', '') + AnsiReplaceStr(AnsiReplaceStr(FloatToStr(objAltGloPro.fltComDis), '.', ''), ',', '.') + ' AS IPR_COMDIS_NOV, ';
      strSQL := strSQL + '   "S"          AS IPR_COMDIS_ALT,                 ';
    End
    Else
    Begin
      strSQL := strSQL + '   0.00         AS IPR_COMDIS_NOV,                 ';
      strSQL := strSQL + '   "N"          AS IPR_COMDIS_ALT,                 ';
    End;

    strSQL := strSQL + '"' + objAltGloPro.strTabPre + '" AS IPR_TABPRE,      ';
    strSQL := strSQL + '"' + fGetTabPre(objAltGloPro.strTabPre) + '" AS IPR_TABGRI, ';
    strSQL := strSQL + '   "N"          AS IPR_MARCAD,                       ';
    strSQL := strSQL + '   C.ITE_CODITE,                                     ';
    strSQL := strSQL + '   C.ITE_DESITE,                                     ';
    strSQL := strSQL + '   C.ITE_REFERE,                                     ';
    strSQL := strSQL + '   U.UNI_SIGUNI                                      ';
    strSQL := strSQL + ' FROM                                                ';
    strSQL := strSQL + '   ITEPRO I                                          ';
    strSQL := strSQL + '      JOIN CADPRO P ON (P.AUTOINCREM = I.IPR_SEQGER) ';
    strSQL := strSQL + '      JOIN CADITE C ON (C.ITE_CODITE = I.IPR_CODITE) ';
    strSQL := strSQL + ' LEFT JOIN CADUNI U ON (U.UNI_CODUNI = C.ITE_CODUNI) ';
    strSQL := strSQL + ' WHERE TRUE ';
    strSQL := strSQL + strWhere;
    strSQL := strSQL + ' AND PRO_PREDES = :TIPPRO ';

    If Not fEmptyStr(objAltGloPro.strCodPro) Then
      strSQL := strSQL + ' AND PRO_CODPRO = :CODPRO ';

    If objAltGloPro.dtaValIni > 0 Then
      strSQL := strSQL + ' AND PRO_DTAINI = :VALINI ';

    If objAltGloPro.dtaValFim > 0 Then
      strSQL := strSQL + ' AND PRO_DTAFIN = :VALFIM ';

    If Not fEmptyStr(objAltGloPro.strRefere) Then
      strSQL := strSQL + ' AND ITE_REFERE = :REFERE ';

    If Not fEmptyStr(objAltGloPro.strDesIni) Then
    Begin
      If (Not fEmptyStr(objAltGloPro.strDesFim)) Then
        strSQL := strSQL + ' AND LEFT(C.ITE_DESITE, LENGTH(:MAIORDES)) BETWEEN :DESINI AND :DESFIN '
      Else
        strSQL := strSQL + ' AND C.ITE_DESITE LIKE :DESITE ';
    End;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Assigned(pSetaParam) Then
        pSetaParam(qryTmp);

      If Not fEmptyStr(objAltGloPro.strCodPro) Then
        ParamByName('CODPRO').AsString := objAltGloPro.strCodPro;

      If objAltGloPro.tpTipPro = tpPreco Then
        ParamByName('TIPPRO').AsString := 'P'
      Else
        ParamByName('TIPPRO').AsString := 'D';

      If objAltGloPro.dtaValIni > 0 Then
        ParamByName('VALINI').AsDateTime := objAltGloPro.dtaValIni;

      If objAltGloPro.dtaValFim > 0 Then
        ParamByName('VALFIM').AsDateTime := objAltGloPro.dtaValFim;

      If Not fEmptyStr(objAltGloPro.strRefere) Then
        ParamByName('REFERE').AsString := objAltGloPro.strRefere;

      If Not fEmptyStr(objAltGloPro.strDesIni) Then
      Begin
        If (Not fEmptyStr(objAltGloPro.strDesFim)) Then
        Begin
          ParamByName('DESINI').AsString := objAltGloPro.strDesIni;
          ParamByName('DESFIN').AsString := objAltGloPro.strDesFim;

          If Length(objAltGloPro.strDesIni) > Length(objAltGloPro.strDesFim) Then
            ParamByName('MAIORDES').AsString := objAltGloPro.strDesIni
          Else
            ParamByName('MAIORDES').AsString := objAltGloPro.strDesFim;
        End
        Else
          ParamByName('DESITE').AsString := objAltGloPro.strDesIni + '%';
      End;

      Open;

      Result := qryTmp;
    End;
  Except
    On E: Exception Do
    Begin
      Result := Nil;
      pMensagensErro(E.Message, '[fFindByPromocoes]');
    End;
  End;
end;


class function TAltGlobalPromocoesDao.fInsertLogPro(qryDados: TUniClientDataSet; strTipCam: String;
  VS_HorLog: TTime): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  Result := False;

  Try
    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO LOGPRO ( ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   LOG_DTALOG, ';
    strSQL := strSQL + '   LOG_HORLOG, ';
    strSQL := strSQL + '   LOG_CODOPE, ';
    strSQL := strSQL + '   LOG_CODEMP, ';
    strSQL := strSQL + '   LOG_CODPRO, ';
    strSQL := strSQL + '   LOG_SEQITE, ';
    strSQL := strSQL + '   LOG_TIPCAM, ';
    strSQL := strSQL + '   LOG_VALATU, ';
    strSQL := strSQL + '   LOG_VALNOV) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '   :AUTOIN, ';
    strSQL := strSQL + '   :DTACAD, ';
    strSQL := strSQL + '   :HORCAD, ';
    strSQL := strSQL + '   :CODOPE, ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :CODPRO, ';
    strSQL := strSQL + '   :SEQITE, ';
    strSQL := strSQL + '   :TIPCAM, ';
    strSQL := strSQL + '   :VALATU, ';
    strSQL := strSQL + '   :VALNOV) ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGPRO', VS_strCodEmp);
      ParamByName('DTACAD').AsDate   := VS_Date;
      ParamByName('HORCAD').AsTime   := VS_HorLog;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      ParamByName('CODPRO').AsString := qryDados.FieldByName('PRO_CODPRO').AsString;
      ParamByName('SEQITE').AsString := qryDados.FieldByName('IPR_AUTINC').AsString;
      ParamByName('TIPCAM').AsString := strTipCam;

      If SameText(strTipCam, 'IPR_PRECUS') Then
      Begin
        ParamByName('VALATU').AsFloat  := qryDados.FieldByName('IPR_PRECUS_ATU').AsFloat;
        ParamByName('VALNOV').AsFloat  := qryDados.FieldByName('IPR_PRECUS_NOV').AsFloat;
      End
      Else If SameText(strTipCam, 'IPR_PREVEN') Then
      Begin
        ParamByName('VALATU').AsFloat  := qryDados.FieldByName('IPR_PREVEN_ATU').AsFloat;
        ParamByName('VALNOV').AsFloat  := qryDados.FieldByName('IPR_PREVEN_NOV').AsFloat;
      End
      Else If SameText(strTipCam, 'IPR_PERDES') Then
      Begin
        ParamByName('VALATU').AsFloat  := qryDados.FieldByName('IPR_PERDES_ATU').AsFloat;
        ParamByName('VALNOV').AsFloat  := qryDados.FieldByName('IPR_PERDES_NOV').AsFloat;
      End
      Else If SameText(strTipCam, 'IPR_COMVAR') Then
      Begin
        ParamByName('VALATU').AsFloat  := qryDados.FieldByName('IPR_COMVAR_ATU').AsFloat;
        ParamByName('VALNOV').AsFloat  := qryDados.FieldByName('IPR_COMVAR_NOV').AsFloat;
      End
      Else If SameText(strTipCam, 'IPR_COMATA') Then
      Begin
        ParamByName('VALATU').AsFloat  := qryDados.FieldByName('IPR_COMATA_ATU').AsFloat;
        ParamByName('VALNOV').AsFloat  := qryDados.FieldByName('IPR_COMATA_NOV').AsFloat;
      End
      Else If SameText(strTipCam, 'IPR_COMDIS') Then
      Begin
        ParamByName('VALATU').AsFloat  := qryDados.FieldByName('IPR_COMDIS_ATU').AsFloat;
        ParamByName('VALNOV').AsFloat  := qryDados.FieldByName('IPR_COMDIS_NOV').AsFloat;
      End;

      ExecSQL;

      Result := RowsAffected > 0;;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fInsertLogPro]');
  End;

  FreeAndNil(qryGen);
end;

class function TAltGlobalPromocoesDao.fUpdatePromocoes(qryDados: TUniClientDataSet): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
    VS_HorLog: TTime;

    procedure pUpdateTabPre;
      Var
        qryTmp: TUniQuery;
    Begin
      strSQL := '';
      strSQL := strSQL + ' UPDATE CADPRO ';
      strSQL := strSQL + '   SET ';
      strSQL := strSQL + '     PRO_TABPRE = :TABPRE ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   AUTOINCREM = :AUTINC ';

      qryTmp := fCriaQuery(Nil);

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('TABPRE').AsString := qryDados.FieldByName('IPR_TABPRE').AsString;
        ParamByName('AUTINC').AsString := qryDados.FieldByName('PRO_AUTINC').AsString;

        ExecSQL;
      End;

      FreeAndNil(qryTmp);
    End;
begin
  Result    := False;
  VS_HorLog := fTime();

  Try
    If qryDados.FieldByName('IPR_TABPRE').AsString <> 'NNNNNNN' Then
      pUpdateTabPre;

    If SameText(qryDados.FieldByName('IPR_PRECUS_ALT').AsString, 'S') Or
       SameText(qryDados.FieldByName('IPR_PREVEN_ALT').AsString, 'S') Or
       SameText(qryDados.FieldByName('IPR_PERDES_ALT').AsString, 'S') Or
       SameText(qryDados.FieldByName('IPR_COMVAR_ALT').AsString, 'S') Or
       SameText(qryDados.FieldByName('IPR_COMATA_ALT').AsString, 'S') Or
       SameText(qryDados.FieldByName('IPR_COMDIS_ALT').AsString, 'S') Then
    Begin
      qryGen := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + ' UPDATE ITEPRO ';
      strSQL := strSQL + '   SET ';

      If SameText(qryDados.FieldByName('IPR_PRECUS_ALT').AsString, 'S') Then
        strSQL := strSQL + '   IPR_PRECUS = :PRECUS,';

      If SameText(qryDados.FieldByName('IPR_PREVEN_ALT').AsString, 'S') Then
        strSQL := strSQL + '   IPR_PREVEN = :PREVEN,';

      If SameText(qryDados.FieldByName('IPR_PERDES_ALT').AsString, 'S') Then
        strSQL := strSQL + '   IPR_PERDES = :PERDES,';

      If SameText(qryDados.FieldByName('IPR_COMVAR_ALT').AsString, 'S') Then
        strSQL := strSQL + '   IPR_COMVAR = :COMVAR,';

      If SameText(qryDados.FieldByName('IPR_COMATA_ALT').AsString, 'S') Then
        strSQL := strSQL + '   IPR_COMATA = :COMATA,';

      If SameText(qryDados.FieldByName('IPR_COMDIS_ALT').AsString, 'S') Then
        strSQL := strSQL + '   IPR_COMDIS = :COMDIS';

      If strSQL[Length(strSQL)] = ',' Then
      Begin
        strSQL[Length(strSQL)] := ' ';
        strSQL := Trim(strSQL);
      End;

      strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTINC').AsString := qryDados.FieldByName('IPR_AUTINC').AsString;

        If SameText(qryDados.FieldByName('IPR_PRECUS_ALT').AsString, 'S') Then
        Begin
          ParamByName('PRECUS').AsFloat := qryDados.FieldByName('IPR_PRECUS_NOV').AsFloat;
          fInsertLogPro(qryDados, 'IPR_PRECUS', VS_HorLog);
        End;

        If SameText(qryDados.FieldByName('IPR_PREVEN_ALT').AsString, 'S') Then
        Begin
          ParamByName('PREVEN').AsFloat := qryDados.FieldByName('IPR_PREVEN_NOV').AsFloat;
          fInsertLogPro(qryDados, 'IPR_PREVEN', VS_HorLog);
        End;

        If SameText(qryDados.FieldByName('IPR_PERDES_ALT').AsString, 'S') Then
        Begin
          ParamByName('PERDES').AsFloat := qryDados.FieldByName('IPR_PERDES_NOV').AsFloat;
          fInsertLogPro(qryDados, 'IPR_PERDES', VS_HorLog);
        End;

        If SameText(qryDados.FieldByName('IPR_COMVAR_ALT').AsString, 'S') Then
        Begin
          ParamByName('COMVAR').AsFloat := qryDados.FieldByName('IPR_COMVAR_NOV').AsFloat;
          fInsertLogPro(qryDados, 'IPR_COMVAR', VS_HorLog);
        End;

        If SameText(qryDados.FieldByName('IPR_COMATA_ALT').AsString, 'S') Then
        Begin
          ParamByName('COMATA').ASFloat := qryDados.FieldByName('IPR_COMATA_NOV').AsFloat;
          fInsertLogPro(qryDados, 'IPR_COMATA', VS_HorLog);
        End;

        If SameText(qryDados.FieldByName('IPR_COMDIS_ALT').AsString, 'S') Then
        Begin
          ParamByName('COMDIS').ASFloat := qryDados.FieldByName('IPR_COMDIS_NOV').AsFloat;
          fInsertLogPro(qryDados, 'IPR_COMDIS', VS_HorLog);
        End;

        ExecSQL;

        Result := RowsAffected > 0;
      End;
    End
    Else
      Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fUpdatePromocoes]');
    End;
  end;

  FreeAndNil(qryGen);
end;

end.
