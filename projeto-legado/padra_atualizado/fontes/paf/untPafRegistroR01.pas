unit untPafRegistroR01;

interface

uses Uni, StrUtils;

  procedure pCriarRegistroR01(strNumSer,
                              strMfAdic,
                              strTipEcf,
                              strMarEcf,
                              strModEcf,
                              strVer_SB: String;
                              dtaDta_SB,
                              dtaHor_SB: TDateTime;
                              intNumCai: Integer;
                              strCnpjUS,
                              strI_E_US,
                              strCnpjDE,
                              strI_E_DE,
                              strI_M_DE,
                              strRazSoc,
                              strVerSao: String;
                              dtaDtaEmi: TDateTime);

implementation

uses  TypInfo, SysUtils, untFuncoesSimples;

procedure pCriarRegistroR01(strNumSer,
                            strMfAdic,
                            strTipEcf,
                            strMarEcf,
                            strModEcf,
                            strVer_SB: String;
                            dtaDta_SB,
                            dtaHor_SB: TDateTime;
                            intNumCai: Integer;
                            strCnpjUS,
                            strI_E_US,
                            strCnpjDE,
                            strI_E_DE,
                            strI_M_DE,
                            strRazSoc,
                            strVerSao: String;
                            dtaDtaEmi: TDateTime);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT * FROM PAFR01 WHERE FALSE ');
  qryAux.Open;

  fStartTransaction;
  Try
    qryAux.Append;
    qryAux.FieldByName('PAF_NUMSER').AsString   := fTrataStr(strNumSer);
    qryAux.FieldByName('PAF_MFADIC').AsString   := fTrataStr(strMfAdic);
    qryAux.FieldByName('PAF_TIPECF').AsString   := fTrataStr(strTipEcf);
    qryAux.FieldByName('PAF_MARECF').AsString   := fTrataStr(strMarEcf);
    qryAux.FieldByName('PAF_MODECF').AsString   := fTrataStr(strModEcf);
    qryAux.FieldByName('PAF_VER_SB').AsString   := fTrataStr(strVer_SB);
    qryAux.FieldByName('PAF_DTA_SB').AsDateTime := dtaDta_SB;
    qryAux.FieldByName('PAF_HOR_SB').AsDateTime := dtaHor_SB;
    qryAux.FieldByName('PAF_NUMCAI').AsInteger  := intNumCai;
    qryAux.FieldByName('PAF_CNPJUS').AsString   := fTiraCaracEspeciais(strCnpjUS, True, True, True);
    qryAux.FieldByName('PAF_I_E_US').AsString   := fTiraCaracEspeciais(strI_E_US, True, True, True);
    qryAux.FieldByName('PAF_CNPJDE').AsString   := fTiraCaracEspeciais(strCnpjDE, True, True, True);
    qryAux.FieldByName('PAF_I_E_DE').AsString   := fTiraCaracEspeciais(strI_E_DE, True, True, True);
    qryAux.FieldByName('PAF_I_M_DE').AsString   := fTiraCaracEspeciais(strI_M_DE, True, True, True);
    qryAux.FieldByName('PAF_RAZSOC').AsString   := fTrataStr(strRazSoc);
    qryAux.FieldByName('PAF_VERSAO').AsString   := fTrataStr(strVerSao);
    qryAux.FieldByName('PAF_DTAEMI').AsDateTime := dtaDtaEmi;
    qryAux.Post;
    fCommit;
  Except
    fRollBack;
    Raise;
  End;

  FreeAndNil(qryAux);
end;

end.
