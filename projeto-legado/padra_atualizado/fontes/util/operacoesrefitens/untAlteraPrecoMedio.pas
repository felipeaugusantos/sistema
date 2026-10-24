unit untAlteraPrecoMedio;

interface

Uses

  Classes, Uni, Math,
  SysUtils, Data.DB;

Type
  TAlteraPrecoMedio = Class(TComponent)
    Private
      FDecUni: Integer;
      FCodIte: String;
      FConsul: TUniQuery;

     Function fSQLItem: String;
     Function fSQLLogMed: String;
     Procedure pGravaLog(fltPreMed, fltPreUlt, fltImpUlt: Double);

    Public

      constructor Create(Owner: TComponent); Reintroduce;

      Destructor Destroy; override;

      Function fAtualizaPrecos(fltPreMed, fltPreUlt, fltImpUlt: Double): Boolean;
      Function fLeDados(strCodIte: String): Boolean;

    published
      property qryCadIte: TUniQuery Read FConsul;

  End;


implementation
uses
    untFuncoesSimples;

constructor TAlteraPrecoMedio.Create(Owner: TComponent);
Begin
  Inherited Create(Owner);

  FDecUni := fCfgSis('DECUNI', varInteger);

  FConsul := fCriaQuery(Self);
  FConsul.SQL.Text := fSQLItem;
End;

Destructor TAlteraPrecoMedio.Destroy;
Begin
  Inherited;

End;

Function TAlteraPrecoMedio.fAtualizaPrecos(fltPreMed, fltPreUlt, fltImpUlt: Double): Boolean;
  Var
    qryIteger: TUniQuery;
    strSQL: String;
Begin
  Try
    If FConsul.IsEmpty Then
    Begin
      Result := False;
      Exit;
    End;

    strSQL := '';
    If (RoundTo(fltPreMed - FConsul.FieldByName('PREMED').AsFloat, -FDecUni) <> 0) Then
      strSQL := strSQL + ' ITE_PREMED = :PREMED ';

    If (RoundTo(fltPreUlt - FConsul.FieldByName('PREULT').AsFloat, -FDecUni) <> 0) Then
    Begin
      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ', ';

      strSQL := strSQL + ' ITE_PREULT = :PREULT ';
    End;

    If (RoundTo(fltImpUlt - FConsul.FieldByName('IMPULT').AsFloat, -FDecUni) <> 0) Then
    Begin
      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ', ';

      strSQL := strSQL + ' ITE_IMPULT = :IMPULT ';
    End;

    If fEmptyStr(strSQL) Then
    Begin
      pMensagemOk('Não há diferenças de preço digitadas!');
      Result := False;
    End Else
    Begin
      fStartTransaction;

      qryIteger := fCriaQuery(Self);
      With qryIteger, SQL Do
      Begin
        Add('UPDATE ITEGER SET');

        Add(strSQL);

        Add(' WHERE ');
        Add('   ITE_CODITE = :CODITE AND ');
        Add('   ITE_CODEMP = :CODEMP     ');

        If Params.FindParam('PREMED') <> Nil Then
          ParamByName('PREMED').AsFloat := fltPreMed;

        If Params.FindParam('PREULT') <> Nil Then
          ParamByName('PREULT').AsFloat := fltPreUlt;

        If Params.FindParam('IMPULT') <> Nil Then
          ParamByName('IMPULT').AsFloat := fltImpUlt;

        ParamByName('CODITE').AsString := FCodIte;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        ExecSQL;
      End;

      pGravaLog(fltPreMed, fltPreUlt, fltImpUlt);

      fCommit;

      FreeAndNil(qryIteger);

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TAlteraPrecoMedio.fAtualizaPrecos]');
    End;
  End;
End;

Function TAlteraPrecoMedio.fSQLLogMed: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '   *  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   LOGMED  ';
  strSQL := strSQL + ' WHERE FALSE ';

  Result := strSQL;
End;

Procedure TAlteraPrecoMedio.pGravaLog(fltPreMed, fltPreUlt, fltImpUlt: Double);
  Var
    qryLogMed: TUniQuery;
Begin
  qryLogMed := fCriaQuery(Self);
  With qryLogMed Do
  Begin
    SQL.text := fSQLLogMed;
    Open;

    Insert;
    FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGMED', VS_strCodEmp);
    FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
    FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
    FieldByName('LOG_HRAALT').AsDateTime := fTime();

    FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
    FieldByName('LOG_CODITE').AsString   := FCodIte;

    FieldByName('LOG_MEDATU').AsFloat    := FConsul.FieldByName('PREMED').AsFloat;
    FieldByName('LOG_MEDNOV').AsFloat    := fltPreMed;

    FieldByName('LOG_ULTATU').AsFloat    := FConsul.FieldByName('PREULT').AsFloat;
    FieldByName('LOG_ULTNOV').AsFloat    := fltPreUlt;

    FieldByName('LOG_IMPATU').AsFloat    := FConsul.FieldByName('IMPULT').AsFloat;
    FieldByName('LOG_IMPNOV').AsFloat    := fltImpUlt;

    Post;
  End;
  FreeAndNil(qryLogMed);
End;

Function TAlteraPrecoMedio.fSQLItem: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '   GRU_DESGRU AS DESGRU, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   ITE_CODMAR AS CODMAR, ';
  strSQL := strSQL + '   MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   ITE_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '   ITE_PREMED AS PREMED, ';
  strSQL := strSQL + '   ITE_PREULT AS PREULT, ';
  strSQL := strSQL + '   ITE_IMPULT AS IMPULT  ';

  strSQL := strSQL + ' FROM           ';
  strSQL := strSQL + '   CADITE C     ';
  strSQL := strSQL + ' INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '                   I.ITE_CODEMP = :CODEMP               ';

  strSQL := strSQL + ' LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ';
  strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR ';
  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   C.ITE_CODITE = :CODITE ';

  Result := strSQL;
End;

Function TAlteraPrecoMedio.fLeDados(strCodIte: String): Boolean;
Begin
  With FConsul Do
  Begin
    Close;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    Result := Not IsEmpty;
  End;  

  FCodIte := strCodIte;
End;

end.
