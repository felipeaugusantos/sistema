unit untPafRegistroR05;

interface

uses Uni, StrUtils, System.Math;

  procedure pCriaRegistroR05(strNumSer,
                             strMfaDic,
                             strModEcf,
                             strNumUsu,
                             strNumCcf,
                             strNumCoo,
                             strNumIte,
                             strCodIte,
                             strDesIte: String;
                             fltQtdIte: Double;
                             strUnidad: String;
                             fltUnitar,
                             fltDescon,
                             fltAcresc,
                             fltTotLiq: Double;
                             strTotali: String;
                             intDecQtd,
                             intDecUni: Integer;
                             dtaDtaEmi: TDateTime;
                             strI_PP_T: String);

  procedure pCancelarRegistroR05(strNumSer,
                                 strMfaDic,
                                 strModEcf,
                                 strNumUsu,
                                 strNumCoo,
                                 strNumIte: String;
                                 blnUsaCCF: Boolean;
                                 strNumCCF: String);

  procedure pRateioAcrDescNosRetistrosR05(strNumser, strNumCoo, strAcrDes: String; fltVlrAcrDesc: Double);
  function fRetornarTotalDosItens(qryAux: TUniQuery): Double;
  procedure pExecutaRateioDescAcres(qryAux: TUniQuery; var fltTotAcrDes: Double; fltVlrAcrDesc: Double; strAcrDes: string; fltTotItens: Double);
  procedure pSeRateioTemRestoSomaNoMaiorValor(qryAux: TUniQuery; fltTotAcrDes: Double; fltVlrAcrDesc: Double; strAcrDes: string);
  function fRetornaSQLRateio: String;
  function fValorInsuficienteRateio(const fltVlrAcrDesc: Double; qryAux:TUniQuery; const strAcrDes: string): Boolean;
implementation

uses  TypInfo, SysUtils, untFuncoesSimples;

procedure pCriaRegistroR05(strNumSer,
                           strMfaDic,
                           strModEcf,
                           strNumUsu,
                           strNumCcf,
                           strNumCoo,
                           strNumIte,
                           strCodIte,
                           strDesIte: String;
                           fltQtdIte: Double;
                           strUnidad: String;
                           fltUnitar,
                           fltDescon,
                           fltAcresc,
                           fltTotLiq: Double;
                           strTotali: String;
                           intDecQtd,
                           intDecUni: Integer;
                           dtaDtaEmi: TDateTime;
                           strI_PP_T: String);
  Var
    qryAux: TUniQuery;
begin
  fStartTransaction;
  Try
    qryAux := fCriaQuery;
    qryAux.SQL.Add('INSERT INTO PAFR05 ( ');
    qryAux.SQL.Add(' PAF_NUMSER, ');
    qryAux.SQL.Add(' PAF_MFADIC, ');
    qryAux.SQL.Add(' PAF_MODECF, ');
    qryAux.SQL.Add(' PAF_NUMUSU, ');
    qryAux.SQL.Add(' PAF_NUMCCF, ');
    qryAux.SQL.Add(' PAF_NUMCOO, ');
    qryAux.SQL.Add(' PAF_NUMITE, ');
    qryAux.SQL.Add(' PAF_CODITE, ');
    qryAux.SQL.Add(' PAF_DESITE, ');
    qryAux.SQL.Add(' PAF_QTDITE, ');
    qryAux.SQL.Add(' PAF_UNIDAD, ');
    qryAux.SQL.Add(' PAF_UNITAR, ');
    qryAux.SQL.Add(' PAF_DESCON, ');
    qryAux.SQL.Add(' PAF_ACRESC, ');
    qryAux.SQL.Add(' PAF_TOTLIQ, ');
    qryAux.SQL.Add(' PAF_TOTALI, ');
    qryAux.SQL.Add(' PAF_DECQTD, ');
    qryAux.SQL.Add(' PAF_DECUNI, ');
    qryAux.SQL.Add(' PAF_CANCEL, ');
    qryAux.SQL.Add(' PAF_INDA_T, ');
    qryAux.SQL.Add(' PAF_I_PP_T, ');
    qryAux.SQL.Add(' PAF_DTAEMI) ');

    qryAux.SQL.Add(' VALUES ( ');

    qryAux.SQL.Add(' :PAF_NUMSER, ');
    qryAux.SQL.Add(' :PAF_MFADIC, ');
    qryAux.SQL.Add(' :PAF_MODECF, ');
    qryAux.SQL.Add(' :PAF_NUMUSU, ');
    qryAux.SQL.Add(' :PAF_NUMCCF, ');
    qryAux.SQL.Add(' :PAF_NUMCOO, ');
    qryAux.SQL.Add(' :PAF_NUMITE, ');
    qryAux.SQL.Add(' :PAF_CODITE, ');
    qryAux.SQL.Add(' :PAF_DESITE, ');
    qryAux.SQL.Add(' :PAF_QTDITE, ');
    qryAux.SQL.Add(' :PAF_UNIDAD, ');
    qryAux.SQL.Add(' :PAF_UNITAR, ');
    qryAux.SQL.Add(' :PAF_DESCON, ');
    qryAux.SQL.Add(' :PAF_ACRESC, ');
    qryAux.SQL.Add(' :PAF_TOTLIQ, ');
    qryAux.SQL.Add(' :PAF_TOTALI, ');
    qryAux.SQL.Add(' :PAF_DECQTD, ');
    qryAux.SQL.Add(' :PAF_DECUNI, ');
    qryAux.SQL.Add(' :PAF_CANCEL, ');
    qryAux.SQL.Add(' :PAF_INDA_T, ');
    qryAux.SQL.Add(' :PAF_I_PP_T, ');
    qryAux.SQL.Add(' :PAF_DTAEMI) ');

    qryAux.ParamByName('PAF_NUMSER').AsString   := fTrataStr(strNumSer);
    qryAux.ParamByName('PAF_MFADIC').AsString   := fTrataStr(strMfaDic);
    qryAux.ParamByName('PAF_MODECF').AsString   := fTrataStr(strModEcf);
    qryAux.ParamByName('PAF_NUMUSU').AsString   := RightStr(strNumUsu, 2);
    qryAux.ParamByName('PAF_NUMCCF').AsString   := fTrataStr(strNumCcf);
    qryAux.ParamByName('PAF_NUMCOO').AsString   := fTrataStr(strNumCoo);
    qryAux.ParamByName('PAF_NUMITE').AsString   := fStrZero(strNumIte, 4);
    qryAux.ParamByName('PAF_CODITE').AsString   := strCodIte;
    qryAux.ParamByName('PAF_DESITE').AsString   := strDesIte;
    qryAux.ParamByName('PAF_QTDITE').AsFloat    := fltQtdIte;
    qryAux.ParamByName('PAF_UNIDAD').AsString   := strUnidad;
    qryAux.ParamByName('PAF_UNITAR').AsFloat    := fltUnitar;
    qryAux.ParamByName('PAF_DESCON').AsFloat    := fltDescon;
    qryAux.ParamByName('PAF_ACRESC').AsFloat    := fltAcresc;
    qryAux.ParamByName('PAF_TOTLIQ').AsFloat    := fltTotLiq;
    qryAux.ParamByName('PAF_TOTALI').AsString   := strTotali;
    qryAux.ParamByName('PAF_DECQTD').AsInteger  := intDecQtd;
    qryAux.ParamByName('PAF_DECUNI').AsInteger  := intDecUni;
    qryAux.ParamByName('PAF_CANCEL').AsString   := 'N';
    qryAux.ParamByName('PAF_INDA_T').AsString   := 'T';
    qryAux.ParamByName('PAF_I_PP_T').AsString   := strI_PP_T;
    qryAux.ParamByName('PAF_DTAEMI').AsDateTime := dtaDtaEmi;

    qryAux.ExecSQL;
    fCommit;
  Except;
    fRollBack;
    Raise;
  End;

  FreeAndNil(qryAux);
end;

procedure pCancelarRegistroR05(strNumSer,
                               strMfaDic,
                               strModEcf,
                               strNumUsu,
                               strNumCoo,
                               strNumIte: String;
                               blnUsaCCF: Boolean;
                               strNumCCF: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  PAFR05 ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  PAF_CANCEL = "S", ');
  {*****************************************}
  {* CASO TENHA SIDO TRIBUTADO, MUDA PARA  *}
  {* "CAN-T"                               *}
  {**************************************MV*}
  qryAux.SQL.Add('  PAF_QTDCAN = PAF_QTDITE, ');
  qryAux.SQL.Add('  PAF_VALCAN = PAF_TOTLIQ, ');
  qryAux.SQL.Add('  PAF_CANACR = 0.00 ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PAF_NUMSER = :NUMSER AND ');
  qryAux.SQL.Add('  PAF_MFADIC = :MFADIC AND ');
  qryAux.SQL.Add('  PAF_MODECF = :MODECF AND ');
  qryAux.SQL.Add('  PAF_NUMUSU = :NUMUSU AND ');

  If (Not blnUsaCCF) Then
  Begin
    qryAux.SQL.Add('  PAF_NUMCOO = :NUMCOO AND ');
    qryAux.SQL.Add('  PAF_NUMITE = :NUMITE ');
  End
  Else
  Begin
    qryAux.SQL.Add('  PAF_NUMCCF = :NUMCCF ');
  End;

  qryAux.ParamByName('NUMSER').AsString := fTrataStr(strNumSer);
  qryAux.ParamByName('MFADIC').AsString := fTrataStr(strMfAdic);
  qryAux.ParamByName('MODECF').AsString := fTrataStr(strModEcf);
  qryAux.ParamByName('NUMUSU').AsString := RightStr(strNumUsu, 2);

  If (Not blnUsaCCF) Then
  Begin
    qryAux.ParamByName('NUMCOO').AsString := fTrataStr(strNumCoo);
    qryAux.ParamByName('NUMITE').AsString := fStrZero(strNumIte, 4);
  End
  Else
  Begin
    qryAux.ParamByName('NUMCCF').AsString := fTrataStr(strNumCCF);
  End;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure pExecutaRateioDescAcres(qryAux: TUniQuery; var fltTotAcrDes: Double; fltVlrAcrDesc: Double; strAcrDes: string; fltTotItens: Double);
var
  fltAcrDesItem: Double;
begin
  qryAux.First;
  while (not qryAux.Eof) do
  begin
    fltAcrDesItem := RoundTo(qryAux.FieldByName('VLRITEM').AsFloat * fltVlrAcrDesc / fltTotItens, -2);
    qryAux.Edit;
    if (strAcrDes = 'D') then
      qryAux.FieldByName('PAF_DESCON').AsFloat := fltAcrDesItem
    else
      qryAux.FieldByName('PAF_ACRESC').AsFloat := fltAcrDesItem;
    qryAux.Post;
    fltTotAcrDes := fltTotAcrDes + fltAcrDesItem;
    qryAux.Next;
  end;
end;

function fRetornaSQLRateio: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  ROUND(PAF_QTDITE * PAF_UNITAR, 2) AS VLRITEM, ';
  Result := Result + '  PAFR05.* ';
  Result := Result + 'FROM ';
  Result := Result + '  PAFR05 ';
  Result := Result + 'WHERE ';
  Result := Result + '  PAF_NUMSER = :NUMSER ';
  Result := Result + '  AND PAF_NUMCOO = :NUMCOO ';
  Result := Result + 'ORDER BY ';
  Result := Result + '  ROUND(PAF_QTDITE * PAF_UNITAR, 2) DESC ';
  Result := Result + 'FOR UPDATE';
end;

procedure pSeRateioTemRestoSomaNoMaiorValor(qryAux: TUniQuery; fltTotAcrDes: Double; fltVlrAcrDesc: Double; strAcrDes: string);
begin
  if (fltTotAcrDes <> fltVlrAcrDesc) then
  begin
    qryAux.First;
    qryAux.Edit;
    if (strAcrDes = 'D') then
      qryAux.FieldByName('PAF_DESCON').AsFloat := qryAux.FieldByName('PAF_DESCON').AsFloat + (fltVlrAcrDesc - fltTotAcrDes)
    else
      qryAux.FieldByName('PAF_ACRESC').AsFloat := qryAux.FieldByName('PAF_ACRESC').AsFloat + (fltVlrAcrDesc - fltTotAcrDes);
    qryAux.Post;
  end;
end;

procedure pRateioAcrDescNosRetistrosR05(strNumser, strNumCoo, strAcrDes: String; fltVlrAcrDesc: Double);
  var
    qryAux: TUniQuery;
    fltTotItens: Double;
    fltTotAcrDes: Double;
begin
  qryAux := fCriaQuery();
  try
    try
      fltTotAcrDes := 0;

      qryAux.SQL.Add(fRetornaSQLRateio);
      qryAux.ParamByName('NUMSER').AsString := strNumSer;
      qryAux.ParamByName('NUMCOO').AsString := strNumCoo;
      qryAux.Open;

      if fValorInsuficienteRateio(fltVlrAcrDesc, qryAux, strAcrDes) then
      begin
        qryAux.Edit;
        if (strAcrDes = 'D') then
          qryAux.FieldByName('PAF_DESCON').AsFloat := fltVlrAcrDesc
        else
          qryAux.FieldByName('PAF_ACRESC').AsFloat := fltVlrAcrDesc;

        qryAux.Post;
        fCommit();
        Exit;
      end;

      fltTotItens := fRetornarTotalDosItens(qryAux);

      pExecutaRateioDescAcres(qryAux, fltTotAcrDes, fltVlrAcrDesc, strAcrDes, fltTotItens);

      pSeRateioTemRestoSomaNoMaiorValor(qryAux, fltTotAcrDes, fltVlrAcrDesc, strAcrDes);

      fCommit();
    except
      fRollBack;
      Raise;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function fValorInsuficienteRateio(const fltVlrAcrDesc: Double; qryAux:TUniQuery; const strAcrDes: string): Boolean;
begin
  Result := False;

  if (fltVlrAcrDesc >= RoundTo(qryAux.RecordCount / 100, -2)) then
    Exit;

  if (strAcrDes = 'D') then
    if (qryAux.FieldByName('VLRITEM').AsFloat <= fltVlrAcrDesc) then
      Exit;

  Result := True;
end;

function fRetornarTotalDosItens(qryAux: TUniQuery): Double;
begin
  Result := 0;
  qryAux.First;
  while (not qryAux.Eof) do
  begin
    Result := Result + qryAux.FieldByName('VLRITEM').AsFloat;
    qryAux.Next;
  end;
end;

end.
