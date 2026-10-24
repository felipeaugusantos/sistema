unit untPafRegistroR07;

interface

uses Uni, StrUtils;

  procedure pCriarRegistroR07(strNumSer,
                              strMfAdic,
                              strModEcf,
                              strNumUsu,
                              strNumCOO,
                              strNumCCF,
                              strNumGNF,
                              strMeiPag: String;
                              fltValPag: Double;
                              dtaDtaEmi: TDateTime);

  procedure pAtualizarRegistroR07(strNumSer,
                                  strMfAdic,
                                  strModEcf,
                                  strNumUsu,
                                  strNumCCF,
                                  strModali,
                                  strNumGNF: String);

  procedure pEstornarRegistroR07(strNumSer,
                                 strMfAdic,
                                 strModEcf,
                                 strNumUsu,
                                 strNumCCF: String);

implementation

uses  SysUtils, untFuncoesSimples;

procedure pCriarRegistroR07(strNumSer,
                            strMfAdic,
                            strModEcf,
                            strNumUsu,
                            strNumCOO,
                            strNumCCF,
                            strNumGNF,
                            strMeiPag: String;
                            fltValPag: Double;
                            dtaDtaEmi: TDateTime);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT * FROM PAFR07 WHERE FALSE');
  qryAux.Open;

  fStartTransaction;
  Try
    qryAux.Append;
    qryAux.FieldByName('PAF_NUMSER').AsString   := fTrataStr(strNumSer);
    qryAux.FieldByName('PAF_MFADIC').AsString   := fTrataStr(strMfAdic);
    qryAux.FieldByName('PAF_MODECF').AsString   := fTrataStr(strModEcf);
    qryAux.FieldByName('PAF_NUMUSU').AsString   := fTrataStr(RightStr(strNumUsu, 2));
    qryAux.FieldByName('PAF_NUMCOO').AsString   := strNumCOO;
    qryAux.FieldByName('PAF_NUMCCF').AsString   := strNumCCF;
    qryAux.FieldByName('PAF_NUMGNF').AsString   := strNumGNF;
    qryAux.FieldByName('PAF_MEIPAG').AsString   := strMeiPag;
    qryAux.FieldByName('PAF_VALPAG').AsFloat    := fltValPag;
    qryAux.FieldByName('PAF_ESTORN').AsString   := 'N';
    qryAux.FieldByName('PAF_VALEST').AsFloat    := 0.0;
    qryAux.FieldByName('PAF_DTAEMI').AsDateTime := dtaDtaEmi;
    qryAux.Post;
    fCommit;
  Except
    fRollBack;
    Raise;
  End;
  FreeAndNil(qryAux);
end;

procedure pAtualizarRegistroR07(strNumSer,
                                strMfAdic,
                                strModEcf,
                                strNumUsu,
                                strNumCCF,
                                strModali,
                                strNumGNF: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  PAFR07 ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  PAF_NUMGNF = :NUMGNF ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PAF_NUMSER = :NUMSER AND ');
  qryAux.SQL.Add('  PAF_MFADIC = :MFADIC AND ');
  qryAux.SQL.Add('  PAF_MODECF = :MODECF AND ');
  qryAux.SQL.Add('  PAF_NUMUSU = :NUMUSU AND ');
  qryAux.SQL.Add('  PAF_NUMCCF = :NUMCCF AND ');
  qryAux.SQL.Add('  PAF_MEIPAG = :MEIPAG ');

  qryAux.ParamByName('NUMGNF').AsString := strNumGNF;

  qryAux.ParamByName('NUMSER').AsString := fTrataStr(strNumSer);
  qryAux.ParamByName('MFADIC').AsString := fTrataStr(strMfAdic);
  qryAux.ParamByName('MODECF').AsString := fTrataStr(strModEcf);
  qryAux.ParamByName('NUMUSU').AsString := RightStr(strNumUsu, 2);
  qryAux.ParamByName('MEIPAG').AsString := strModali;
  qryAux.ParamByName('NUMCCF').AsString := strNumCCF;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure pEstornarRegistroR07(strNumSer,
                               strMfAdic,
                               strModEcf,
                               strNumUsu,
                               strNumCCF: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  PAFR07 ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  PAF_ESTORN = "S", ');
  qryAux.SQL.Add('  PAF_VALEST = PAF_VALPAG ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PAF_NUMSER = :NUMSER AND ');
  qryAux.SQL.Add('  PAF_MFADIC = :MFADIC AND ');
  qryAux.SQL.Add('  PAF_MODECF = :MODECF AND ');
  qryAux.SQL.Add('  PAF_NUMUSU = :NUMUSU AND ');
  qryAux.SQL.Add('  PAF_NUMCCF = :NUMCCF ');

  qryAux.ParamByName('NUMSER').AsString := fTrataStr(strNumSer);
  qryAux.ParamByName('MFADIC').AsString := fTrataStr(strMfAdic);
  qryAux.ParamByName('MODECF').AsString := fTrataStr(strModEcf);
  qryAux.ParamByName('NUMUSU').AsString := RightStr(strNumUsu, 2);
  qryAux.ParamByName('NUMCCF').AsString := strNumCCF;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

end.
