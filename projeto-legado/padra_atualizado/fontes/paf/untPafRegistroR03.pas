unit untPafRegistroR03;

interface

uses Uni, StrUtils;

  procedure pCriarRegistroR03(strNumSer,
                              strMfaDic,
                              strModEcf,
                              strNumUsu,
                              strNumCrz,
                              strTotPar: String;
                              fltValAcu: Double;
                              dtaDtaMov: TDateTime);

implementation

uses  TypInfo, SysUtils, untFuncoesSimples;

procedure pCriarRegistroR03(strNumSer,
                            strMfaDic,
                            strModEcf,
                            strNumUsu,
                            strNumCrz,
                            strTotPar: String;
                            fltValAcu: Double;
                            dtaDtaMov: TDateTime);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT * FROM PAFR03 WHERE FALSE');
  qryAux.Open;

  fStartTransaction;
  Try
    qryAux.Append;
    qryAux.FieldByName('PAF_NUMSER').AsString   := fTrataStr(strNumSer);
    qryAux.FieldByName('PAF_MFADIC').AsString   := fTrataStr(strMfaDic);
    qryAux.FieldByName('PAF_MODECF').AsString   := fTrataStr(strModEcf);
    qryAux.FieldByName('PAF_NUMUSU').AsString   := RightStr(fTrataStr(strNumUsu), 2);
    qryAux.FieldByName('PAF_NUMCRZ').AsString   := fTrataStr(strNumCrz);
    qryAux.FieldByName('PAF_TOTPAR').AsString   := fTrataStr(strTotPar);
    qryAux.FieldByName('PAF_VALACU').AsFloat    := fltValAcu;
    qryAux.FieldByName('PAF_DTAMOV').AsDateTime := dtaDtaMov;
    qryAux.Post;
    fCommit;
  Except
    fRollBack;
    Raise;
  End;

  FreeAndNil(qryAux);
end;

end.
