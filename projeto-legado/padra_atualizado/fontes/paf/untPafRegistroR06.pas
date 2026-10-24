unit untPafRegistroR06;

interface

uses SysUtils, Uni, StrUtils;

  procedure pCriarRegistroR06(strNumSer,
                              strMfADic,
                              strModEcf,
                              strNumUsu,
                              strNumCoo,
                              strNumGnf,
                              strNumGrg,
                              strNumCdc,
                              strDeNomi: String);

  procedure pAtualizarRegistroR06(strNumSer,
                                  strMfADic,
                                  strModEcf,
                                  strNumUsu,
                                  strNumCoo: String;
                                  dtaDtaEmi,
                                  dtaHorEmi: TDateTime);

implementation

uses untFuncoesSimples;

procedure pCriarRegistroR06(strNumSer,
                            strMfADic,
                            strModEcf,
                            strNumUsu,
                            strNumCoo,
                            strNumGnf,
                            strNumGrg,
                            strNumCdc,
                            strDeNomi: String);
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT * FROM PAFR06 WHERE FALSE');
  qryAux.Open;

  fStartTransaction;
  Try
    qryAux.Append;
    qryAux.FieldByName('PAF_NUMSER').AsString := fTrataStr(strNumSer);
    qryAux.FieldByName('PAF_MFADIC').AsString := fTrataStr(strMfADic);
    qryAux.FieldByName('PAF_MODECF').AsString := fTrataStr(strModEcf);
    qryAux.FieldByName('PAF_NUMUSU').AsString := RightStr(fTrataStr(strNumUsu), 2);
    qryAux.FieldByName('PAF_NUMCOO').AsString := fTrataStr(strNumCoo);
    qryAux.FieldByName('PAF_NUMGNF').AsString := fTrataStr(strNumGnf);
    qryAux.FieldByName('PAF_NUMGRG').AsString := fTrataStr(strNumGrg);
    qryAux.FieldByName('PAF_NUMCDC').AsString := fTrataStr(strNumCdc);
    qryAux.FieldByName('PAF_DENOMI').AsString := fTrataStr(strDeNomi);
    qryAux.Post;
    fCommit;
  Except
    fRollBack;
    Raise;
  End;

  FreeAndNil(qryAux);

end;

procedure pAtualizarRegistroR06(strNumSer,
                                strMfADic,
                                strModEcf,
                                strNumUsu,
                                strNumCoo: String;
                                dtaDtaEmi,
                                dtaHorEmi: TDateTime);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  PAFR06 ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  PAF_DTAEMI = :DTAEMI, ');
  qryAux.SQL.Add('  PAF_HOREMI = :HOREMI ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PAF_NUMSER = :NUMSER AND ');
  qryAux.SQL.Add('  PAF_MFADIC = :MFADIC AND ');
  qryAux.SQL.Add('  PAF_MODECF = :MODECF AND ');
  qryAux.SQL.Add('  PAF_NUMUSU = :NUMUSU AND ');
  qryAux.SQL.Add('  PAF_NUMCOO = :NUMCOO     ');

  qryAux.ParamByName('DTAEMI').AsDateTime := dtaDtaEmi;
  qryAux.ParamByName('HOREMI').AsDateTime := dtaHorEmi;

  qryAux.ParamByName('NUMSER').AsString := fTrataStr(strNumSer);
  qryAux.ParamByName('MFADIC').AsString := fTrataStr(strMfADic);
  qryAux.ParamByName('MODECF').AsString := fTrataStr(strModEcf);
  qryAux.ParamByName('NUMUSU').AsString := RightStr(fTrataStr(strNumUsu), 2);
  qryAux.ParamByName('NUMCOO').AsString := fTrataStr(strNumCoo);

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

end.
