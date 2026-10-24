unit untPafRegistroR02;

interface

uses Uni, StrUtils;

  procedure pCriarRegistroR02(strNumSer,
                              strMfAdic,
                              strModEcf,
                              strNumUsu,
                              strNumCrz,
                              strNumCoo,
                              strNumCro: String;
                              dtaDtaMov,
                              dtaDtaEmi,
                              dtaHorEmi: TDateTime;
                              fltVenBru: Double;
                              strIncIss: String);

implementation

uses  SysUtils, untFuncoesSimples;

procedure pCriarRegistroR02(strNumSer,
                            strMfAdic,
                            strModEcf,
                            strNumUsu,
                            strNumCrz,
                            strNumCoo,
                            strNumCro: String;
                            dtaDtaMov,
                            dtaDtaEmi,
                            dtaHorEmi: TDateTime;
                            fltVenBru: Double;
                            strIncIss: String);
  Var
    qryAux: TUniQuery;
begin
  fStartTransaction;
  Try
    qryAux := fCriaQuery;
    qryAux.SQL.Add('INSERT INTO PAFR02 (');
    qryAux.SQL.Add(' PAF_NUMSER, ');
    qryAux.SQL.Add(' PAF_MFADIC, ');
    qryAux.SQL.Add(' PAF_MODECF, ');
    qryAux.SQL.Add(' PAF_NUMUSU, ');
    qryAux.SQL.Add(' PAF_NUMCRZ, ');
    qryAux.SQL.Add(' PAF_NUMCOO, ');
    qryAux.SQL.Add(' PAF_NUMCRO, ');
    qryAux.SQL.Add(' PAF_DTAMOV, ');
    qryAux.SQL.Add(' PAF_DTAEMI, ');
    qryAux.SQL.Add(' PAF_HOREMI, ');
    qryAux.SQL.Add(' PAF_VENBRU, ');
    qryAux.SQL.Add(' PAF_INCISS) ');
    qryAux.SQL.Add('VALUES ( ');
    qryAux.SQL.Add(' :PAF_NUMSER, ');
    qryAux.SQL.Add(' :PAF_MFADIC, ');
    qryAux.SQL.Add(' :PAF_MODECF, ');
    qryAux.SQL.Add(' :PAF_NUMUSU, ');
    qryAux.SQL.Add(' :PAF_NUMCRZ, ');
    qryAux.SQL.Add(' :PAF_NUMCOO, ');
    qryAux.SQL.Add(' :PAF_NUMCRO, ');
    qryAux.SQL.Add(' :PAF_DTAMOV, ');
    qryAux.SQL.Add(' :PAF_DTAEMI, ');
    qryAux.SQL.Add(' :PAF_HOREMI, ');
    qryAux.SQL.Add(' :PAF_VENBRU, ');
    qryAux.SQL.Add(' :PAF_INCISS) ');

    qryAux.ParamByName('PAF_NUMSER').AsString   := fTrataStr(strNumSer);
    qryAux.ParamByName('PAF_MFADIC').AsString   := fTrataStr(strMfAdic);
    qryAux.ParamByName('PAF_MODECF').AsString   := fTrataStr(strModEcf);
    qryAux.ParamByName('PAF_NUMUSU').AsString   := RightStr(strNumUsu, 2);
    qryAux.ParamByName('PAF_NUMCRZ').AsString   := fTrataStr(strNumCrz);
    qryAux.ParamByName('PAF_NUMCOO').AsString   := fTrataStr(strNumCoo);
    qryAux.ParamByName('PAF_NUMCRO').AsString   := fTrataStr(strNumCro);
    qryAux.ParamByName('PAF_DTAMOV').AsDateTime := dtaDtaMov;
    qryAux.ParamByName('PAF_DTAEMI').AsDateTime := dtaDtaEmi;
    qryAux.ParamByName('PAF_HOREMI').AsDateTime := dtaHorEmi;
    qryAux.ParamByName('PAF_VENBRU').AsFloat    := fltVenBru;
    qryAux.ParamByName('PAF_INCISS').AsString   := strIncIss;
    qryAux.ExecSQL;
    fCommit;
  Except
    fRollBack;
    Raise;
  End;

  FreeAndNil(qryAux);

end;

end.
