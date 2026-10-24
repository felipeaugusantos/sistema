unit untPafRegistroR04;

interface

uses Uni, StrUtils;

  procedure pCriaRegistroR04(strNumSer,
                             strMfaDic,
                             strModEcf,
                             strNumUsu,
                             strNumCcf,
                             strNumCoo,
                             strNomCli,
                             strNumCpf: String;
                             dtaDtaIni: TDateTime);

  procedure pFecharRegistroR04(strNumSer,
                               strMfaDic,
                               strModEcf,
                               strNumUsu,
                               strNumCoo: String;
                               fltSubTot,
                               fltDesSub: Double;
                               strTipDes: String;
                               fltAcrSub: Double;
                               strTipAcr: String;
                               fltTotLiq,
                               fltCanAcr: Double;
                               strOrdApl: String);

  procedure pCancelarRegistroR04(strNumSer,
                                strMfaDic,
                                strModEcf,
                                strNumUsu,
                                strNumCoo: String);

implementation

uses untFuncoesSimples, SysUtils;

procedure pCriaRegistroR04(strNumSer,
                           strMfaDic,
                           strModEcf,
                           strNumUsu,
                           strNumCcf,
                           strNumCoo,
                           strNomCli,
                           strNumCpf: String;
                           dtaDtaIni: TDateTime);
  Var
    qryR04: TUniQuery;
begin

  qryR04 := fCriaQuery;
  qryR04.SQL.Add('SELECT * FROM PAFR04 WHERE FALSE');
  qryR04.Open;

  fStartTransaction;
  Try
    qryR04.Append;
    qryR04.FieldByName('PAF_NUMSER').AsString   := fTrataStr(strNumSer);
    qryR04.FieldByName('PAF_MFADIC').AsString   := fTrataStr(strMfaDic);
    qryR04.FieldByName('PAF_MODECF').AsString   := fTrataStr(strModEcf);
    qryR04.FieldByName('PAF_NUMUSU').AsString   := RightStr(strNumUsu, 2);
    qryR04.FieldByName('PAF_NUMCCF').AsString   := fTrataStr(strNumCcf);
    qryR04.FieldByName('PAF_NUMCOO').AsString   := fTrataStr(strNumCoo);
    qryR04.FieldByName('PAF_DTAINI').AsDateTime := dtaDtaIni;
    qryR04.FieldByName('PAF_CANCEL').AsString   := 'N';
    qryR04.FieldByName('PAF_NOMCLI').AsString   := strNomCli;
    qryR04.FieldByName('PAF_NUMCPF').AsString   := fTiraCaracEspeciais(strNumCpf, True, True, True);
    qryR04.Post;
    fCommit;
  Except
    fRollBack;
    Raise;
  End;

  FreeAndNil(qryR04);
end;

procedure pFecharRegistroR04(strNumSer,
                             strMfaDic,
                             strModEcf,
                             strNumUsu,
                             strNumCoo: String;
                             fltSubTot,
                             fltDesSub: Double;
                             strTipDes: String;
                             fltAcrSub: Double;
                             strTipAcr: String;
                             fltTotLiq,
                             fltCanAcr: Double;
                             strOrdApl: String);
  Var
    qryR04: TUniQuery;
begin
  qryR04 := fCriaQuery;
  qryR04.SQL.Add('UPDATE ');
  qryR04.SQL.Add('  PAFR04 ');
  qryR04.SQL.Add('SET ');
  qryR04.SQL.Add('  PAF_SUBTOT = :SUBTOT, ');
  qryR04.SQL.Add('  PAF_DESSUB = :DESSUB, ');
  qryR04.SQL.Add('  PAF_TIPDES = :TIPDES, ');
  qryR04.SQL.Add('  PAF_ACRSUB = :ACRSUB, ');
  qryR04.SQL.Add('  PAF_TIPACR = :TIPACR, ');
  qryR04.SQL.Add('  PAF_TOTLIQ = :TOTLIQ, ');
  qryR04.SQL.Add('  PAF_CANACR = :CANACR, ');
  qryR04.SQL.Add('  PAF_ORDAPL = :ORDAPL  ');
  qryR04.SQL.Add('WHERE ');
  qryR04.SQL.Add('  PAF_NUMSER = :NUMSER AND ');
  qryR04.SQL.Add('  PAF_MFADIC = :MFADIC AND ');
  qryR04.SQL.Add('  PAF_MODECF = :MODECF AND ');
  qryR04.SQL.Add('  PAF_NUMUSU = :NUMUSU AND ');
  qryR04.SQL.Add('  PAF_NUMCOO = :NUMCOO ');

  qryR04.ParamByName('NUMSER').AsString := fTrataStr(strNumSer);
  qryR04.ParamByName('MFADIC').AsString := fTrataStr(strMfaDic);
  qryR04.ParamByName('MODECF').AsString := fTrataStr(strModEcf);
  qryR04.ParamByName('NUMUSU').AsString := RightStr(strNumUsu, 2);
  qryR04.ParamByName('NUMCOO').AsString := fTrataStr(strNumCoo);

  qryR04.ParamByName('SUBTOT').AsFloat  := fltSubTot;
  qryR04.ParamByName('DESSUB').AsFloat  := fltDesSub;
  qryR04.ParamByName('TIPDES').AsString := strTipDes;
  qryR04.ParamByName('ACRSUB').AsFloat  := fltAcrSub;
  qryR04.ParamByName('TIPACR').AsString := strTipAcr;
  qryR04.ParamByName('TOTLIQ').AsFloat  := fltTotLiq;
  qryR04.ParamByName('CANACR').AsFloat  := fltCanAcr;
  qryR04.ParamByName('ORDAPL').AsString := strOrdApl;

  qryR04.ExecSQL;

  FreeAndNil(qryR04);
end;

procedure pCancelarRegistroR04(strNumSer,
                               strMfaDic,
                               strModEcf,
                               strNumUsu,
                               strNumCoo: String);
  Var
    qryR04: TUniQuery;
begin
  qryR04 := fCriaQuery;
  qryR04.SQL.Add('UPDATE ');
  qryR04.SQL.Add('  PAFR04 ');
  qryR04.SQL.Add('SET ');
  qryR04.SQL.Add('  PAF_CANCEL = "S" ');
  qryR04.SQL.Add('WHERE ');
  qryR04.SQL.Add('  PAF_NUMSER = :NUMSER AND ');
  qryR04.SQL.Add('  PAF_MFADIC = :MFADIC AND ');
  qryR04.SQL.Add('  PAF_MODECF = :MODECF AND ');
  qryR04.SQL.Add('  PAF_NUMUSU = :NUMUSU AND ');
  qryR04.SQL.Add('  PAF_NUMCOO = :NUMCOO ');

  qryR04.ParamByName('NUMSER').AsString := fTrataStr(strNumSer);
  qryR04.ParamByName('MFADIC').AsString := fTrataStr(strMfaDic);
  qryR04.ParamByName('MODECF').AsString := fTrataStr(strModEcf);
  qryR04.ParamByName('NUMUSU').AsString := RightStr(strNumUsu, 2);
  qryR04.ParamByName('NUMCOO').AsString := fTrataStr(strNumCoo);

  qryR04.ExecSQL;

  FreeAndNil(qryR04);


end;

end.
