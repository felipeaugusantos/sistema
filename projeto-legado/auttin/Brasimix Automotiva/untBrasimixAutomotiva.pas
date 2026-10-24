unit untBrasimixAutomotiva;

interface

uses SysUtils, Classes, Forms, Uni;

Type
  TBzaForMul = Record
    strCodBas: String;
    fltQtdBas: Double;
End;

Type
  TBzaArrBas = Array[1..15] Of TBzaForMul;

  function fGravaBzaCadBza(strCodEmp,
                           strCodSeq,
                           strMonTad,
                           strA_n_o_,
                           strDesCri,
                           strCodUni: String;
                           fltPreCus,
                           fltPreVen: Double;
                           strArqTxt,
                           strCodB01: String;
                           fltQtdB01: Double;
                           strCodB02: String;
                           fltQtdB02: Double;
                           strCodB03: String;
                           fltQtdB03: Double;
                           strCodB04: String;
                           fltQtdB04: Double;
                           strCodB05: String;
                           fltQtdB05: Double;
                           strCodB06: String;
                           fltQtdB06: Double;
                           strCodB07: String;
                           fltQtdB07: Double;
                           strCodB08: String;
                           fltQtdB08: Double;
                           strCodB09: String;
                           fltQtdB09: Double;
                           strCodB10: String;
                           fltQtdB10: Double;
                           strCodB11: String;
                           fltQtdB11: Double;
                           strCodB12: String;
                           fltQtdB12: Double;
                           strCodB13: String;
                           fltQtdB13: Double;
                           strCodB14: String;
                           fltQtdB14: Double;
                           strCodB15: String;
                           fltQtdB15: Double): Boolean;

  function fBrasimixAutomotivaGeraArquivo(Var stlTinNaoGeradas,
    stlBasesNaoCad: TStringList): Boolean;

  function fBaseCadastrada(strCodBas: String): Boolean;

implementation

uses  untFuncoes, untModuloTinta,
      untIConfTinta, untFuncTinta, untFuncoesSimples;

function fGravaBzaCadBza(strCodEmp,
                         strCodSeq,
                         strMonTad,
                         strA_n_o_,
                         strDesCri,
                         strCodUni: String;
                         fltPreCus,
                         fltPreVen: Double;
                         strArqTxt,
                         strCodB01: String;
                         fltQtdB01: Double;
                         strCodB02: String;
                         fltQtdB02: Double;
                         strCodB03: String;
                         fltQtdB03: Double;
                         strCodB04: String;
                         fltQtdB04: Double;
                         strCodB05: String;
                         fltQtdB05: Double;
                         strCodB06: String;
                         fltQtdB06: Double;
                         strCodB07: String;
                         fltQtdB07: Double;
                         strCodB08: String;
                         fltQtdB08: Double;
                         strCodB09: String;
                         fltQtdB09: Double;
                         strCodB10: String;
                         fltQtdB10: Double;
                         strCodB11: String;
                         fltQtdB11: Double;
                         strCodB12: String;
                         fltQtdB12: Double;
                         strCodB13: String;
                         fltQtdB13: Double;
                         strCodB14: String;
                         fltQtdB14: Double;
                         strCodB15: String;
                         fltQtdB15: Double): Boolean;
  Var
    strSQL: String;
    qryGen002: TUniQuery;
Begin

  qryGen002 := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'INSERT DELAYED INTO BZA_CADBZA ';
  strSQL := strSQL + '( ';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  BZA_CODEMP, ';
  strSQL := strSQL + '  BZA_CODSEQ, ';
  strSQL := strSQL + '  BZA_MONTAD, ';
  strSQL := strSQL + '  BZA_A_N_O_, ';
  strSQL := strSQL + '  BZA_DESCRI, ';
  strSQL := strSQL + '  BZA_CODUNI, ';
  strSQL := strSQL + '  BZA_PRECUS, ';
  strSQL := strSQL + '  BZA_PREVEN, ';
  strSQL := strSQL + '  BZA_ARQTXT, ';
  strSQL := strSQL + '  BZA_CODB01, ';
  strSQL := strSQL + '  BZA_QTDB01, ';
  strSQL := strSQL + '  BZA_CODB02, ';
  strSQL := strSQL + '  BZA_QTDB02, ';
  strSQL := strSQL + '  BZA_CODB03, ';
  strSQL := strSQL + '  BZA_QTDB03, ';
  strSQL := strSQL + '  BZA_CODB04, ';
  strSQL := strSQL + '  BZA_QTDB04, ';
  strSQL := strSQL + '  BZA_CODB05, ';
  strSQL := strSQL + '  BZA_QTDB05, ';
  strSQL := strSQL + '  BZA_CODB06, ';
  strSQL := strSQL + '  BZA_QTDB06, ';
  strSQL := strSQL + '  BZA_CODB07, ';
  strSQL := strSQL + '  BZA_QTDB07, ';
  strSQL := strSQL + '  BZA_CODB08, ';
  strSQL := strSQL + '  BZA_QTDB08, ';
  strSQL := strSQL + '  BZA_CODB09, ';
  strSQL := strSQL + '  BZA_QTDB09, ';
  strSQL := strSQL + '  BZA_CODB10, ';
  strSQL := strSQL + '  BZA_QTDB10, ';
  strSQL := strSQL + '  BZA_CODB11, ';
  strSQL := strSQL + '  BZA_QTDB11, ';
  strSQL := strSQL + '  BZA_CODB12, ';
  strSQL := strSQL + '  BZA_QTDB12, ';
  strSQL := strSQL + '  BZA_CODB13, ';
  strSQL := strSQL + '  BZA_QTDB13, ';
  strSQL := strSQL + '  BZA_CODB14, ';
  strSQL := strSQL + '  BZA_QTDB14, ';
  strSQL := strSQL + '  BZA_CODB15, ';
  strSQL := strSQL + '  BZA_QTDB15) ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :AUTINC, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :CODSEQ, ';
  strSQL := strSQL + '  :MONTAD, ';
  strSQL := strSQL + '  :A_N_O_, ';
  strSQL := strSQL + '  :DESCRI, ';
  strSQL := strSQL + '  :CODUNI, ';
  strSQL := strSQL + '  :PRECUS, ';
  strSQL := strSQL + '  :PREVEN, ';
  strSQL := strSQL + '  :ARQTXT, ';
  strSQL := strSQL + '  :CODB01, ';
  strSQL := strSQL + '  :QTDB01, ';
  strSQL := strSQL + '  :CODB02, ';
  strSQL := strSQL + '  :QTDB02, ';
  strSQL := strSQL + '  :CODB03, ';
  strSQL := strSQL + '  :QTDB03, ';
  strSQL := strSQL + '  :CODB04, ';
  strSQL := strSQL + '  :QTDB04, ';
  strSQL := strSQL + '  :CODB05, ';
  strSQL := strSQL + '  :QTDB05, ';
  strSQL := strSQL + '  :CODB06, ';
  strSQL := strSQL + '  :QTDB06, ';
  strSQL := strSQL + '  :CODB07, ';
  strSQL := strSQL + '  :QTDB07, ';
  strSQL := strSQL + '  :CODB08, ';
  strSQL := strSQL + '  :QTDB08, ';
  strSQL := strSQL + '  :CODB09, ';
  strSQL := strSQL + '  :QTDB09, ';
  strSQL := strSQL + '  :CODB10, ';
  strSQL := strSQL + '  :QTDB10, ';
  strSQL := strSQL + '  :CODB11, ';
  strSQL := strSQL + '  :QTDB11, ';
  strSQL := strSQL + '  :CODB12, ';
  strSQL := strSQL + '  :QTDB12, ';
  strSQL := strSQL + '  :CODB13, ';
  strSQL := strSQL + '  :QTDB13, ';
  strSQL := strSQL + '  :CODB14, ';
  strSQL := strSQL + '  :QTDB14, ';
  strSQL := strSQL + '  :CODB15, ';
  strSQL := strSQL + '  :QTDB15) ';

  Try
    With qryGen002 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString  := fRetAutoIncrem('BZA_CADBZA', VS_strCodEmp);
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODSEQ').AsString  := strCodSeq;
      ParamByName('MONTAD').AsString  := strMonTad;
      ParamByName('A_N_O_').AsString  := strA_n_o_;
      ParamByName('DESCRI').AsString  := strDesCri;
      ParamByName('CODUNI').AsString  := strCodUni;
      ParamByName('PRECUS').AsFloat   := fltPreCus;
      ParamByName('PREVEN').AsFloat   := fltPreVen;
      ParamByName('ARQTXT').AsString  := strArqTxt;
      ParamByName('CODB01').AsString  := strCodB01;
      ParamByName('QTDB01').AsFloat   := fltQtdB01;
      ParamByName('CODB02').AsString  := strCodB02;
      ParamByName('QTDB02').AsFloat   := fltQtdB02;
      ParamByName('CODB03').AsString  := strCodB03;
      ParamByName('QTDB03').AsFloat   := fltQtdB03;
      ParamByName('CODB04').AsString  := strCodB04;
      ParamByName('QTDB04').AsFloat   := fltQtdB04;
      ParamByName('CODB05').AsString  := strCodB05;
      ParamByName('QTDB05').AsFloat   := fltQtdB05;
      ParamByName('CODB06').AsString  := strCodB06;
      ParamByName('QTDB06').AsFloat   := fltQtdB06;
      ParamByName('CODB07').AsString  := strCodB07;
      ParamByName('QTDB07').AsFloat   := fltQtdB07;
      ParamByName('CODB08').AsString  := strCodB08;
      ParamByName('QTDB08').AsFloat   := fltQtdB08;
      ParamByName('CODB09').AsString  := strCodB09;
      ParamByName('QTDB09').AsFloat   := fltQtdB09;
      ParamByName('CODB10').AsString  := strCodB10;
      ParamByName('QTDB10').AsFloat   := fltQtdB10;
      ParamByName('CODB11').AsString  := strCodB11;
      ParamByName('QTDB11').AsFloat   := fltQtdB11;
      ParamByName('CODB12').AsString  := strCodB12;
      ParamByName('QTDB12').AsFloat   := fltQtdB12;
      ParamByName('CODB13').AsString  := strCodB13;
      ParamByName('QTDB13').AsFloat   := fltQtdB13;
      ParamByName('CODB14').AsString  := strCodB14;
      ParamByName('QTDB14').AsFloat   := fltQtdB14;
      ParamByName('CODB15').AsString  := strCodB15;
      ParamByName('QTDB15').AsFloat   := fltQtdB15;
      ExecSQL;
      Close;

    End;
    Result := True;

    FreeAndNil(qryGen002);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaBzaCadBza]');
    End;
  End;

End;

function fBrasimixAutomotivaGeraArquivo(Var stlTinNaoGeradas,
  stlBasesNaoCad: TStringList): Boolean;
  Var
    strArqTxt: String;
    stlArqTxt: TStringList;
    intPosAtual: Integer;
    intTamArq: Integer;
    strLinha: String;
    arrBases: TBzaArrBas;

    intContador: Integer;

    strTipTin: String;
    strCodSeq: String;
    strMontad: String;
    strAno   : String;
    strDescri: String;
    strCodUni: String;
    fltPreVen: Double;
    fltPreCus: Double;

    strBases: String;
    strSQL: String;
    intPosBas: Integer;

    blnGravar: Boolean;
    conf: IConfTinta;
begin

  conf  := fGetConfTinta('BZA');
  stlTinNaoGeradas.Sorted     := True;
  stlTinNaoGeradas.Duplicates := dupIgnore;

  stlBasesNaoCad.Sorted       := True;
  stlBasesNaoCad.Duplicates   := dupIgnore;

  strArqTxt := conf.fGet('PATBZA'); //fArqIniTinta(0, 'Brasimix Automotiva', 'PATBZA', '');

  If (Not FileExists(strArqTxt)) Then
  Begin
    fMensagem('', 'Não foi encontrado o TXT para geração.' + #13#10 +
                  'Caminho: ' + strArqTxt, ['&Ok']);
    Result := False;
    Exit;
  End;

  stlArqTxt   := TStringList.Create;
  stlArqTxt.LoadFromFile(strArqTxt);
  intTamArq   := stlArqTxt.Count;

  intPosAtual := 0;

  pZapTable('BZA_CADBZA');

  Result := True;

  strSQL := '';
  strSQL := strSQL + 'UPDATE PROCOD SET PRO_AUTINC = 1 WHERE PRO_NOMARQ = "BZA_CADBZA" ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  While (intPosAtual < intTamArq) Do
  Begin

    Application.ProcessMessages;

    blnGravar := True;

    For intContador := Low(arrBases) To High(arrBases) Do
    Begin
      arrBases[intContador].strCodBas := '';
      arrBases[intContador].fltQtdBas := 0.0;
    End;

    strLinha := stlArqTxt[intPosAtual];

    strTipTin := Copy(strLinha, 007, 002);
    strCodSeq := Copy(strLinha, 001, 006);
    strMontad := Copy(strLinha, 009, 050);
    strAno    := Copy(strLinha, 059, 004);
    strDescri := Copy(strLinha, 063, 050);
    strCodUni := Copy(strLinha, 113, 050);
    fltPreVen := fStrToFloat(Copy(strLinha, 163, 009)) / 100;
    fltPreCus := fltPreVen * conf.fGetDouble('MARBZA'); //fStrToFloat(fArqIniTinta(0, 'Brasimix Automotiva', 'MARBZA', '0'));

    If (strTipTin = 'PE') Then
      strTipTin := 'POLIESTER'

    Else If (strTipTin = 'PU') Then
      strTipTin := 'POLIURETANO FLEET 3X1'

    Else If (strTipTin = 'PH') Then
      strTipTin := 'POLIURETANO H.S. 2X1'

    Else If (strTipTin = 'SR') Then
      strTipTin := 'SINT. EXTRA-RAPIDO'

    Else If (strTipTin = 'ST') Then
      strTipTin := 'SINT. AUTOMOTIVO'

    Else If (strTipTin = 'SB') Then
      strTipTin := 'SINT. RAPIDO BRASILIAR'

    Else If (strTipTin = 'SI') Then
      strTipTin := 'SINT. RODOAGROINDUSTRIAL'

    Else If (strTipTin = 'LC') Then
      strTipTin := 'LACA NITRO-CELULOSE'

    Else If (strTipTin = 'LA') Then
      strTipTin := 'LACA NITRO AUTOMOTIVA'

    Else If (strTipTin = 'EP') Then
      strTipTin := 'EPOXI';

    strBases  := Copy(strLinha, 172, Length(strLinha));
    intPosBas   := 1;
    intContador := 1;

    If (fArqIniTinta(0, 'USA_FORMUL', 'BZA', 'S') = 'S') Then
    Begin

      While (intContador < Length(strBases)) Do
      Begin

        arrBases[intPosBas].strCodBas := Copy(strBases, intContador, 7);
        arrBases[intPosBas].fltQtdBas := fStrToFloat(Copy(strBases, intContador + 7, 9)) / 100;

        Inc(intContador, 16);
        If (fEmptyStr(arrBases[intPosBas].strCodBas)) Then
        Begin
          Continue;
        End;

        If (Not fBaseCadastrada(arrBases[intPosBas].strCodBas)) Then
        Begin
          stlBasesNaoCad.Add(arrBases[intPosBas].strCodBas);
          blnGravar := False;
        End;

        Inc(intPosBas);

      End;

    End;

    Inc(intPosAtual);

    If (blnGravar) Then
    Begin
      Result := fGravaBzaCadBza(VS_strCodEmp,
                                strCodSeq,
                                strMontad,
                                strAno,
                                strDescri,
                                strCodUni,
                                fltPreCus,
                                fltPreVen,
                                strTipTin,
                                arrBases[01].strCodBas,
                                arrBases[01].fltQtdBas,
                                arrBases[02].strCodBas,
                                arrBases[02].fltQtdBas,
                                arrBases[03].strCodBas,
                                arrBases[03].fltQtdBas,
                                arrBases[04].strCodBas,
                                arrBases[04].fltQtdBas,
                                arrBases[05].strCodBas,
                                arrBases[05].fltQtdBas,
                                arrBases[06].strCodBas,
                                arrBases[06].fltQtdBas,
                                arrBases[07].strCodBas,
                                arrBases[07].fltQtdBas,
                                arrBases[08].strCodBas,
                                arrBases[08].fltQtdBas,
                                arrBases[09].strCodBas,
                                arrBases[09].fltQtdBas,
                                arrBases[10].strCodBas,
                                arrBases[10].fltQtdBas,
                                arrBases[11].strCodBas,
                                arrBases[11].fltQtdBas,
                                arrBases[12].strCodBas,
                                arrBases[12].fltQtdBas,
                                arrBases[13].strCodBas,
                                arrBases[13].fltQtdBas,
                                arrBases[14].strCodBas,
                                arrBases[14].fltQtdBas,
                                arrBases[15].strCodBas,
                                arrBases[15].fltQtdBas);
    End
    Else
    Begin
      stlTinNaoGeradas.Add(strCodSeq + ' - ' + strDescri);
    End;

    If (Not Result) Then
      Break;

  End;

end;

function fBaseCadastrada(strCodBas: String): Boolean;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);


  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZA_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS ';

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAS').AsString := strCodBas;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;

end;

end.


