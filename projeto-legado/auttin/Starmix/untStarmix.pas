unit untStarmix;

interface

uses Windows, SysUtils, Classes, Uni, Forms, Dialogs;

type
  TVolGer = Record
    strUnidad: String;
    fltVolGer: Double;
  end;

Type
  TStaForMul = Record
    strCodBas: String;
    fltQtdBas: Double;
End;

Type
  TStaArrBas = Array[1..15] Of TStaForMul;

  function fStarmixGeraArquivo: Boolean;
  function fGravaCadSta(strCodSeq,
                        strNomCor,
                        strAnoCor,
                        strCodLin,
                        strCodMon,
                        strUniVer,
                        strUniDad,
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
                        fltQtdB15: Double;
                        fltPreCus: Double;
                        fltPreVen: Double): Boolean;

implementation

uses untFuncoes,untIConfTinta, untFuncTinta,
  untModulo, untModuloTinta, untFuncoesSimples;

function fStarmixGeraArquivo: Boolean;
  Var
    strSQL: String;
    strPatTxt: String;
    srcArquivos: TSearchRec;
    stlArquivos: TStringList;
    stlArqTxt: TStringList;

    intContador: Integer;
    intContador2: Integer;
    intContador3: Integer;
    strLinha: String;
    strTipReg: String;

    strNomCor: String;
    strAnoCor: String;
    fltPesCor: Double;
    fltPesFor: Double;
    strCodLin: String;
    strCodMon: String;
    strUniVer: String;

    strUnidad: String;
    fltVolGer: Double;

    arrVolGer: Array [1..1] Of TVolGer;
    arrBases: Array[1..15] Of TStaForMul;

    strLinBas: String;
    intContBas: Integer;

    strCodBas: String;
    fltQtdBas: Double;
    fltPesEsp: Double;
    fltPreBas: Double;
    fltVolume: Double;
    fltValBas: Double;
    fltPreCus: Double;
    fltPreVen: Double;
    fltQtdCal: Double;

    intPosFormul: Integer;
    intBases: Integer;

    fltTraImp: Double;
    fltFVesta: Double;
    fltStaPer: Double;

    qryCadTab: TUniQuery;
    qryCadLin: TUniQuery;
    qryCadBas: TUniQuery;

    intCodSeq: Integer;
    conf: IConfTinta;
begin

  Result      := False;
  conf        := fGetConfTinta('STA');
  strPatTxt   := conf.fGet('PATSTA') + '\'; //fArqIniTinta(0, 'STARMIX', 'PATSTA', '') + '\';

  intCodSeq   := 1;

  stlArquivos := TStringList.Create;
  stlArqTxt   := TStringList.Create;

  If (FindFirst(strPatTxt + '*.txt', faAnyFile, srcArquivos) = 0) Then
  Begin

    Repeat
      stlArquivos.Add(strPatTxt + srcArquivos.Name);
    Until (FindNext(srcArquivos) <> 0);

  End;
  SysUtils.FindClose(srcArquivos);

  If (stlArquivos.Count <= 0) Then
  Begin
    fMensagem('', 'Não encontrei nenhum arquivo para a geração!', ['&Ok']);
    Exit;
  End;

  arrVolGer[1].strUnidad := 'LT';
  arrVolGer[1].fltVolGer := 0.900;

  pZapTable('STA_CADSTA');

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE CADMON ( ';
  //strSQL := strSQL + 'CREATE TABLE CADMON ( ';
  strSQL := strSQL + '  MON_CODMON VARCHAR(03), ';
  strSQL := strSQL + '  MON_DESMON VARCHAR(40) ) ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE CADLIN ( ';
  //strSQL := strSQL + 'CREATE TABLE CADLIN ( ';
  strSQL := strSQL + '  LIN_CODSEQ VARCHAR(03), ';
  strSQL := strSQL + '  LIN_DESLIN VARCHAR(40), ';
  strSQL := strSQL + '  LIN_VOLUME NUMERIC(14, 4) ) ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE CADBAS ( ';
  //strSQL := strSQL + 'CREATE TABLE CADBAS ( ';
  strSQL := strSQL + '  BAS_CODSEQ VARCHAR(03), ';
  strSQL := strSQL + '  BAS_CODBAS VARCHAR(08), ';
  strSQL := strSQL + '  BAS_DESBAS VARCHAR(45), ';
  strSQL := strSQL + '  BAS_CODLIN VARCHAR(03), ';
  strSQL := strSQL + '  BAS_PESESP NUMERIC(14, 4) ) ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE CADTAB ( ';
  //strSQL := strSQL + 'CREATE TABLE CADTAB ( ';
  strSQL := strSQL + '  TAB_CODTAB VARCHAR(04), ';
  strSQL := strSQL + '  TAB_CODSEQ VARCHAR(03), ';
  strSQL := strSQL + '  TAB_VALOR_ NUMERIC(14, 4) )';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  qryCadBas := TUniQuery.Create(Nil);
  qryCadBas.Connection := frmModulo.Database;
  qryCadBas.SQL.Add('SELECT * FROM CADBAS');

  qryCadTab := TUniQuery.Create(Nil);
  qryCadTab.Connection := frmModulo.Database;
  qryCadTab.SQL.Add('SELECT * FROM CADTAB');

  qryCadLin := TUniQuery.Create(Nil);
  qryCadLin.Connection := frmModulo.Database;
  qryCadLin.SQL.Add('SELECT * FROM CADLIN');

  fltTraImp := conf.fGetDouble('STAIMP'); //fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAIMP', '0'));
  fltFVesta := conf.fGetDouble('FVESTA'); //fStrToFloat(fArqIniTinta(0, 'STARMIX', 'FVESTA', '0'));
  fltStaPer := conf.fGetDouble('STAPER'); //fStrToFloat(fArqIniTinta(0, 'STARMIX', 'STAPER', '0'));

  Try

    For intContador := 0 To stlArquivos.Count -1 Do
    Begin

      stlArqTxt.LoadFromFile(stlArquivos[intContador]);

      For intContador2 := 0 To stlArqTxt.Count -1 Do
      Begin
        strLinha := stlArqTxt[intContador2];

        strTipReg := Copy(strLinha, 299, 02);

        {*******************************************}
        {* CADASTRO DE MONTADORAS                  *}
        {****************************************MV*}
        If (strTipReg = '10') Then
        Begin

          strSQL := '';
          strSQL := strSQL + 'INSERT INTO CADMON ( ';
          strSQL := strSQL + '  MON_CODMON, ';
          strSQL := strSQL + '  MON_DESMON ) VALUES ( ';
          strSQL := strSQL + '  :CODMON, ';
          strSQL := strSQL + '  :DESMON ) ';

          With frmModuloTinta.qryGen001 Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODMON').AsString := Copy(strLinha, 01, 03);
            ParamByName('DESMON').AsString := Copy(strLinha, 04, 40);
            ExecSQL;
            Close;
          End;

        End

        {*******************************************}
        {* CADASTRO DE LINHAS                      *}
        {****************************************MV*}
        Else If (strTipReg = '20') Then
        Begin

          strSQL := '';
          strSQL := strSQL + 'INSERT INTO CADLIN ( ';
          strSQL := strSQL + '  LIN_CODSEQ, ';
          strSQL := strSQL + '  LIN_DESLIN, ';
          strSQL := strSQL + '  LIN_VOLUME ) VALUES ( ';
          strSQL := strSQL + '  :CODSEQ, ';
          strSQL := strSQL + '  :DESLIN, ';
          strSQL := strSQL + '  :VOLUME ) ';

          With frmModuloTinta.qryGen001 Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODSEQ').AsString := Copy(strLinha, 01, 03);
            ParamByName('DESLIN').AsString := Copy(strLinha, 04, 30);
            ParamByName('VOLUME').AsFloat  := fStrToFloat(Copy(strLinha, 34, 6));
            ExecSQL;
            Close;
          End;
        End

        {*******************************************}
        {* CADASTRO DE BASES                       *}
        {****************************************MV*}
        Else If (strTipReg = '30') Then
        Begin

          strSQL := '';
          strSQL := strSQL + 'INSERT INTO CADBAS ( ';
          strSQL := strSQL + '  BAS_CODSEQ, ';
          strSQL := strSQL + '  BAS_CODBAS, ';
          strSQL := strSQL + '  BAS_DESBAS, ';
          strSQL := strSQL + '  BAS_CODLIN, ';
          strSQL := strSQL + '  BAS_PESESP ) VALUES ( ';
          strSQL := strSQL + '  :CODSEQ, ';
          strSQL := strSQL + '  :CODBAS, ';
          strSQL := strSQL + '  :DESBAS, ';
          strSQL := strSQL + '  :CODLIN, ';
          strSQL := strSQL + '  :PESESP ) ';

          With frmModuloTinta.qryGen001 Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODSEQ').AsString := Copy(strLinha, 01, 03);
            ParamByName('CODBAS').AsString := Copy(strLinha, 04, 08);
            ParamByName('DESBAS').AsString := Copy(strLinha, 12, 45);
            ParamByName('CODLIN').AsString := Copy(strLinha, 57, 03);
            ParamByName('PESESP').AsFloat  := fStrToFloat(Copy(strLinha, 60, 08)) / 10000;
            ExecSQL;
            Close;
          End;

        End

        Else If (strTipReg = '50') Then
        Begin

          strSQL := '';
          strSQL := strSQL + 'INSERT INTO CADTAB ( ';
          strSQL := strSQL + '  TAB_CODTAB, ';
          strSQL := strSQL + '  TAB_CODSEQ, ';
          strSQL := strSQL + '  TAB_VALOR_ ) VALUES ( ';
          strSQL := strSQL + '  :CODTAB, ';
          strSQL := strSQL + '  :CODSEQ, ';
          strSQL := strSQL + '  :VALOR_ ) ';

          With frmModuloTinta.qryGen001 Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODTAB').AsString := Copy(strLinha, 01, 04);
            ParamByName('CODSEQ').AsString := Copy(strLinha, 05, 03);
            ParamByName('VALOR_').AsFloat  := fStrToFloat(Copy(strLinha, 08, 07)) / 1000;
            ExecSQL;
            Close;
          End;

        End

        Else If (strTipReg = '60') Then
        Begin

          Application.ProcessMessages;

          If (Not qryCadBas.Active) Then
            qryCadBas.Open;

          If (Not qryCadTab.Active) Then
            qryCadTab.Open;

          If (Not qryCadLin.Active) Then
            qryCadLin.Open;

          strNomCor := Trim(AnsiUpperCase(Copy(strLinha, 09, 45)));
          strAnoCor := Trim(AnsiUpperCase(Copy(strLinha, 88, 04)));
          fltPesCor := fStrToFloat(Copy(strLinha,  92, 08 )) / 10000.00;
          fltPesFor := fStrToFloat(Copy(strLinha, 100, 08 )) / 10000.00;
          strCodLin := Trim(AnsiUpperCase(Copy(strLinha, 116, 03)));
          strCodMon := Trim(AnsiUpperCase(Copy(strLinha, 119, 03)));
          strUniVer := Trim(AnsiUpperCase(Copy(strLinha, 122, 12)));

          strLinBas := fPadr( Copy(strLinha, 134, Length(strLinha)), 165);

          If (fltPesFor = 0.0) Then
          Begin
            fMensagem('', 'A cor ' + strNomCor + ' está com o peso da fórmula Zerado. Essa Cor não será gerada!', ['&Ok']);
            Continue;
          End;

          For intContador3 := Low(arrVolGer) To High(arrVolGer) Do
          Begin

            fltPreCus := 0.0;

            strUnidad := arrVolGer[intContador3].strUnidad;
            fltVolGer := arrVolGer[intContador3].fltVolGer;

            For intContBas := Low(arrBases) To High(arrBases) Do
            Begin
              arrBases[intContBas].strCodBas := '';
              arrBases[intContBas].fltQtdBas := 0.0;
            End;

            intContBas := 1;
            intPosFormul := Low(arrBases);
            While (intContBas < Length(strLinBas)) Do
            Begin

              strCodBas := Copy(strLinBas, intContBas, 3);
              fltQtdBas := fStrToFloat(Copy(strLinBas, intContBas+3, 8)) / 10000;

              fltPreBas := 0.0;
              fltVolume := 0.0;

              If (qryCadBas.Locate('BAS_CODSEQ', strCodBas, [])) Then
              Begin

                fltPesEsp := qryCadBas.FieldByName('BAS_PESESP').AsFloat;
                arrBases[intPosFormul].strCodBas := strCodBas;
                arrBases[intPosFormul].fltQtdBas := fltQtdBas;
                Inc(intPosFormul);

                If (qryCadTab.Locate('TAB_CODSEQ', qryCadBas.FieldByName('BAS_CODSEQ').AsString, [])) Then
                Begin
                  fltPreBas := qryCadTab.FieldByName('TAB_VALOR_').AsFloat;
                End;

                If (qryCadLin.Locate('LIN_CODSEQ', qryCadBas.FieldByName('BAS_CODLIN').AsString, [])) Then
                Begin
                  fltVolume := qryCadLin.FieldByName('LIN_VOLUME').AsFloat;
                End;

                fltQtdCal := fltVolGer * (((fltPesCor / fltPesFor) * 1000) * fltQtdBas);
                fltValBas := (fltPreBas / fltVolume) * (fltQtdCal / fltPesEsp);
                fltPreCus := fltPrecus + fltValBas;

              End;

              Inc(intContBas, 11);
            End;

            fltPreVen := fltPreCus;
            fltPreVen := fltPreVen + (fltPreVen / 100) * fltTraImp;
            fltPreVen := (fltPreVen * fltFVesta);
            fltPreVen := fltPreVen + (fltPreVen / 100) * fltStaPer;

            //fGrava..........
            fGravaCadSta(fStrZero(intCodSeq, 6),
                         strNomCor,
                         strAnoCor,
                         strCodLin,
                         strCodMon,
                         strUniVer,
                         strUnidad,
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
                         arrBases[15].fltQtdBas,
                         fltPreCus,
                         fltPreVen);


            Inc(intCodSeq);

          End;

        End;

      End;

    End;

  Except
    On E: EXception Do
    Begin
      fMensagem('', E.MEssage + #13#10 + strLinha, ['&Ok']);
    End;
  End;

  fDropTable('CADMON');
  fDropTable('CADLIN');
  fDropTable('CADBAS');
  fDropTable('CADTAB');

end;

function fGravaCadSta(strCodSeq,
                      strNomCor,
                      strAnoCor,
                      strCodLin,
                      strCodMon,
                      strUniVer,
                      strUniDad,
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
                      fltQtdB15: Double;
                      fltPreCus: Double;
                      fltPreVen: Double): Boolean;
  Var
    strSQL: String;
Begin

  Try
    strSQL := '';
    strSQL := strSQL + 'INSERT DELAYED INTO STA_CADSTA (' ;
    strSQL := strSQL + '  STA_CODSEQ, ';
    strSQL := strSQL + '  STA_NOMCOR, ';
    strSQL := strSQL + '  STA_ANOCOR, ';
    strSQL := strSQL + '  STA_CODLIN, ';
    strSQL := strSQL + '  STA_CODMON, ';
    strSQL := strSQL + '  STA_UNIVER, ';
    strSQL := strSQL + '  STA_UNIDAD, ';
    strSQL := strSQL + '  STA_CODB01, ';
    strSQL := strSQL + '  STA_QTDB01, ';
    strSQL := strSQL + '  STA_CODB02, ';
    strSQL := strSQL + '  STA_QTDB02, ';
    strSQL := strSQL + '  STA_CODB03, ';
    strSQL := strSQL + '  STA_QTDB03, ';
    strSQL := strSQL + '  STA_CODB04, ';
    strSQL := strSQL + '  STA_QTDB04, ';
    strSQL := strSQL + '  STA_CODB05, ';
    strSQL := strSQL + '  STA_QTDB05, ';
    strSQL := strSQL + '  STA_CODB06, ';
    strSQL := strSQL + '  STA_QTDB06, ';
    strSQL := strSQL + '  STA_CODB07, ';
    strSQL := strSQL + '  STA_QTDB07, ';
    strSQL := strSQL + '  STA_CODB08, ';
    strSQL := strSQL + '  STA_QTDB08, ';
    strSQL := strSQL + '  STA_CODB09, ';
    strSQL := strSQL + '  STA_QTDB09, ';
    strSQL := strSQL + '  STA_CODB10, ';
    strSQL := strSQL + '  STA_QTDB10, ';
    strSQL := strSQL + '  STA_CODB11, ';
    strSQL := strSQL + '  STA_QTDB11, ';
    strSQL := strSQL + '  STA_CODB12, ';
    strSQL := strSQL + '  STA_QTDB12, ';
    strSQL := strSQL + '  STA_CODB13, ';
    strSQL := strSQL + '  STA_QTDB13, ';
    strSQL := strSQL + '  STA_CODB14, ';
    strSQL := strSQL + '  STA_QTDB14, ';
    strSQL := strSQL + '  STA_CODB15, ';
    strSQL := strSQL + '  STA_QTDB15, ';
    strSQL := strSQL + '  STA_PRECUS, ';
    strSQL := strSQL + '  STA_PREVEN, ';
    strSQL := strSQL + '  AUTOINCREM) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :CODSEQ, ';
    strSQL := strSQL + '  :NOMCOR, ';
    strSQL := strSQL + '  :ANOCOR, ';
    strSQL := strSQL + '  :CODLIN, ';
    strSQL := strSQL + '  :CODMON, ';
    strSQL := strSQL + '  :UNIVER, ';
    strSQL := strSQL + '  :UNIDAD, ';
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
    strSQL := strSQL + '  :QTDB15, ';
    strSQL := strSQL + '  :PRECUS, ';
    strSQL := strSQL + '  :PREVEN, ';
    strSQL := strSQL + '  :AUTINC) ';

    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODSEQ').AsString := strCodSeq;
      ParamByName('NOMCOR').AsString := strNomCor;
      ParamByName('ANOCOR').AsString := strAnoCor;
      ParamByName('CODLIN').AsString := strCodLin;
      ParamByName('CODMON').AsString := strCodMon;
      ParamByName('UNIVER').AsString := strUniVer;
      ParamByName('UNIDAD').AsString := strUniDad;
      ParamByName('CODB01').AsString := strCodB01;
      ParamByName('QTDB01').AsFloat  := fltQtdB01;
      ParamByName('CODB02').AsString := strCodB02;
      ParamByName('QTDB02').AsFloat  := fltQtdB02;
      ParamByName('CODB03').AsString := strCodB03;
      ParamByName('QTDB03').AsFloat  := fltQtdB03;
      ParamByName('CODB04').AsString := strCodB04;
      ParamByName('QTDB04').AsFloat  := fltQtdB04;
      ParamByName('CODB05').AsString := strCodB05;
      ParamByName('QTDB05').AsFloat  := fltQtdB05;
      ParamByName('CODB06').AsString := strCodB06;
      ParamByName('QTDB06').AsFloat  := fltQtdB06;
      ParamByName('CODB07').AsString := strCodB07;
      ParamByName('QTDB07').AsFloat  := fltQtdB07;
      ParamByName('CODB08').AsString := strCodB08;
      ParamByName('QTDB08').AsFloat  := fltQtdB08;
      ParamByName('CODB09').AsString := strCodB09;
      ParamByName('QTDB09').AsFloat  := fltQtdB09;
      ParamByName('CODB10').AsString := strCodB10;
      ParamByName('QTDB10').AsFloat  := fltQtdB10;
      ParamByName('CODB11').AsString := strCodB11;
      ParamByName('QTDB11').AsFloat  := fltQtdB11;
      ParamByName('CODB12').AsString := strCodB12;
      ParamByName('QTDB12').AsFloat  := fltQtdB12;
      ParamByName('CODB13').AsString := strCodB13;
      ParamByName('QTDB13').AsFloat  := fltQtdB13;
      ParamByName('CODB14').AsString := strCodB14;
      ParamByName('QTDB14').AsFloat  := fltQtdB14;
      ParamByName('CODB15').AsString := strCodB15;
      ParamByName('QTDB15').AsFloat  := fltQtdB15;
      ParamByName('PRECUS').AsFloat  := fltPreCus;
      ParamByName('PREVEN').AsFloat  := fltPreVen;
      ParamByName('AUTINC').AsString := fFormataAutInc(StrToInt(strCodSeq), VS_strCodEmp);

      ExecSQL;
      Close;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaCadSta]');
      Result := False;
    End;
  End;

End;

end.
