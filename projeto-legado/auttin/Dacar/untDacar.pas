unit untDacar;

interface

uses SysUtils, Classes,  Uni, Variants, Forms, ADODB;

  function fOncasParaMl(Oncas : String): Double;

  procedure pLimparTabela(Tabela : String);

  function fGravaCadDac(strCodSeq,
                        strDesCri,
                        strRefEre,
                        strCodUni,
                        strDesUni: String;
                        fltPreCus,
                        fltPreVen: Double;
                        strCodIte: String;
                        fltEmbala: Double;
                        strForM01,
                        strForM02,
                        strForM03,
                        strForM04: String;
                        intQtdZ01,
                        intQtdZ02,
                        intQtdZ03,
                        intQtdZ04: Integer;
                        fltQtdB01,
                        fltQtdB02,
                        fltQtdB03,
                        fltQtdB04: Double;
                        strProCod,
                        strCodBas,
                        strCodEmp: String): Boolean;


implementation

uses untFuncoesSimples, DB,
     StrUtils;

function fGravaCadDac(strCodSeq,
                      strDesCri,
                      strRefEre,
                      strCodUni,
                      strDesUni: String;
                      fltPreCus,
                      fltPreVen: Double;
                      strCodIte: String;
                      fltEmbala: Double;
                      strForM01,
                      strForM02,
                      strForM03,
                      strForM04: String;
                      intQtdZ01,
                      intQtdZ02,
                      intQtdZ03,
                      intQtdZ04: Integer;
                      fltQtdB01,
                      fltQtdB02,
                      fltQtdB03,
                      fltQtdB04: Double;
                      strProCod,
                      strCodBas,
                      strCodEmp: String): Boolean;
  Var
    strSQL: String;
    qryGen002: TUniQuery;
Begin

  Try

    qryGen002 := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'INSERT DELAYED INTO DAC_CADDAC ( ';
    strSQL := strSQL + '  DAC_CODSEQ, ';
    strSQL := strSQL + '  DAC_DESCRI, ';
    strSQL := strSQL + '  DAC_REFERE, ';
    strSQL := strSQL + '  DAC_CODUNI, ';
    strSQL := strSQL + '  DAC_DESUNI, ';
    strSQL := strSQL + '  DAC_PRECUS, ';
    strSQL := strSQL + '  DAC_PREVEN, ';
    strSQL := strSQL + '  DAC_CODITE, ';
    strSQL := strSQL + '  DAC_EMBALA, ';
    strSQL := strSQL + '  DAC_FORM01, ';
    strSQL := strSQL + '  DAC_FORM02, ';
    strSQL := strSQL + '  DAC_FORM03, ';
    strSQL := strSQL + '  DAC_FORM04, ';
    strSQL := strSQL + '  DAC_QTDZ01, ';
    strSQL := strSQL + '  DAC_QTDZ02, ';
    strSQL := strSQL + '  DAC_QTDZ03, ';
    strSQL := strSQL + '  DAC_QTDZ04, ';
    strSQL := strSQL + '  DAC_QTDB01, ';
    strSQL := strSQL + '  DAC_QTDB02, ';
    strSQL := strSQL + '  DAC_QTDB03, ';
    strSQL := strSQL + '  DAC_QTDB04, ';
    strSQL := strSQL + '  DAC_PROCOD, ';
    strSQL := strSQL + '  DAC_CODBAS, ';
    strSQL := strSQL + '  DAC_CODEMP, ';
    strSQL := strSQL + '  AUTOINCREM) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :CODSEQ, ';
    strSQL := strSQL + '  :DESCRI, ';
    strSQL := strSQL + '  :REFERE, ';
    strSQL := strSQL + '  :CODUNI, ';
    strSQL := strSQL + '  :DESUNI, ';
    strSQL := strSQL + '  :PRECUS, ';
    strSQL := strSQL + '  :PREVEN, ';
    strSQL := strSQL + '  :CODITE, ';
    strSQL := strSQL + '  :EMBALA, ';
    strSQL := strSQL + '  :FORM01, ';
    strSQL := strSQL + '  :FORM02, ';
    strSQL := strSQL + '  :FORM03, ';
    strSQL := strSQL + '  :FORM04, ';
    strSQL := strSQL + '  :QTDZ01, ';
    strSQL := strSQL + '  :QTDZ02, ';
    strSQL := strSQL + '  :QTDZ03, ';
    strSQL := strSQL + '  :QTDZ04, ';
    strSQL := strSQL + '  :QTDB01, ';
    strSQL := strSQL + '  :QTDB02, ';
    strSQL := strSQL + '  :QTDB03, ';
    strSQL := strSQL + '  :QTDB04, ';
    strSQL := strSQL + '  :PROCOD, ';
    strSQL := strSQL + '  :CODBAS, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :AUTINC) ';

    With qryGen002 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODSEQ').AsString  := strCodSeq;
      ParamByName('DESCRI').AsString  := strDesCri;
      ParamByName('REFERE').AsString  := strRefEre;
      ParamByName('CODUNI').AsString  := strCodUni;
      ParamByName('DESUNI').AsString  := strDesUni;
      ParamByName('PRECUS').AsFloat   := fltPreCus;
      ParamByName('PREVEN').AsFloat   := fltPreVen;
      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('EMBALA').AsFloat   := fltEmbala;
      ParamByName('FORM01').AsString  := strForM01;
      ParamByName('FORM02').AsString  := strForM02;
      ParamByName('FORM03').AsString  := strForM03;
      ParamByName('FORM04').AsString  := strForM04;
      ParamByName('QTDZ01').AsInteger := intQtdZ01;
      ParamByName('QTDZ02').AsInteger := intQtdZ02;
      ParamByName('QTDZ03').AsInteger := intQtdZ03;
      ParamByName('QTDZ04').AsInteger := intQtdZ04;
      ParamByName('QTDB01').AsFloat   := fltQtdB01;
      ParamByName('QTDB02').AsFloat   := fltQtdB02;
      ParamByName('QTDB03').AsFloat   := fltQtdB03;
      ParamByName('QTDB04').AsFloat   := fltQtdB04;
      ParamByName('PROCOD').AsString  := strProCod;
      ParamByName('CODBAS').AsString  := strCodBas;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('AUTINC').AsString  := fFormataAutInc(StrToInt(strCodSeq), VS_strCodEmp); //fRetAutoIncrem('DAC_CADDAC', strCodEmp);
      ExecSQL;
      Close;
    End;
    Result := True;

    FreeAndNil(qryGen002);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaCadDac]');
      Result := False;
    End;
  End;

End;



function fOncasParaMl(Oncas : String): Double;
  Var
    strInteira  : String;
    strFracao   : String;
    strOncas    : String;
begin
  strOncas := AnsiReplaceStr(Oncas,'.',',');
  strInteira := Copy(strOncas, 0, Pos('Y', strOncas) - 1);
  strFracao := Copy(strOncas, Pos('Y', strOncas) + 1, Length(strOncas));
  Result := fStrToFloat(FormatFloat('0.000000', fStrToFloat(strInteira) * 29.5735295625 + fStrToFloat(strFracao) * 0.61611520));
end;

procedure pLimparTabela(Tabela : String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'TRUNCATE TABLE ' + Tabela;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

end.
