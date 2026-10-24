unit untStarmixDinamica;

interface

uses Windows, SysUtils, Classes, Uni, Forms, Dialogs, StrUtils,
  DateUtils, Math, Variants, untTintadeMaquina;

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

  TStarMixAutomotivaDinamica = class(TTintadeMaquina)
  private
    function fRetProCodSeq(): Integer;
  public
    constructor Create(Aowner: TComponent); override;
    function fGravarNovasFormulas(): Boolean; override;
  End;

  function fStarmixDinamicaGeraArquivo(blnGerarBases: Boolean): Boolean;
  function fGerarBases(strNomArq: String): Boolean;
  function fGravaCadStaDinamica(strCodSeq,
                                strNomCor,
                                strAnoCor,
                                strCodLin,
                                strCodMon,
                                strUniVer,
                                strUniDad: String;
                                fltPesFor,
                                fltPesCor: Double;
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

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
procedure pDeletaNovaFormula(strCodSeq: String);
function fRetProCodSeq: Integer;

implementation

uses untFuncoes,untIConfTinta, untFuncTinta,
   untModuloTinta, DB, untFuncoesSimples;

function fStarmixDinamicaGeraArquivo(blnGerarBases: Boolean): Boolean;
  Var
    strPatTxt: String;
    srcArquivos: TSearchRec;
    stlArquivos: TStringList;
    stlArqTxt: TStringList;

    intContador: Integer;
    intContador2: Integer;
    strLinha: String;
    strTipReg: String;

    strNomCor: String;
    strAnoCor: String;
    fltPesCor: Double;
    fltPesFor: Double;
    strCodLin: String;
    strCodMon: String;
    strUniVer: String;

    arrBases: Array[1..15] Of TStaForMul;

    strLinBas: String;
    intContBas: Integer;

    strCodBas: String;
    fltQtdBas: Double;

    intPosFormul: Integer;
    intCodSeq: Integer;

    stlMontadoras: TStringList;
    qryTMP_CADBAS: TUniQuery;
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

  If blnGerarBases Then
  Begin
    For intContador := 0 To stlArquivos.Count -1 Do
    Begin
      Result := fGerarBases(stlArquivos[intContador]);
    End;
    Exit;
  End;

  pZapTable('STA_CADSTA');
  stlMontadoras := TStringList.Create;
  qryTMP_CADBAS     := fCriaQuery(Nil);
  qryTMP_CADBAS.SQL.Add('SELECT * FROM STA_CADBAS');
  qryTMP_CADBAS.Open;

  Try

    For intContador := 0 To stlArquivos.Count -1 Do
    Begin

      stlArqTxt.LoadFromFile(stlArquivos[intContador]);

      For intContador2 := 0 To stlArqTxt.Count -1 Do
      Begin
        strLinha := stlArqTxt[intContador2];

        strTipReg := Copy(strLinha, 299, 02);

        If (strTipReg = '10') Then
        Begin
          stlMontadoras.Values[Trim(Copy(strLinha, 01, 03))] := Trim(Copy(strLinha, 04, 45));
        End

        Else If (strTipReg = '60') Then
        Begin

          Application.ProcessMessages;

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

            If Not fEmptyStr(strCodBas) Then
            Begin
              qryTMP_CADBAS.Locate('BAS_CODSEQ', strCodBas, []);

              arrBases[intPosFormul].strCodBas := qryTMP_CADBAS.FieldByName('BAS_CODBAS').AsString;
              arrBases[intPosFormul].fltQtdBas := fltQtdBas;
              Inc(intPosFormul);
            End;

            Inc(intContBas, 11);
          End;

          fGravaCadStaDinamica(fStrZero(intCodSeq, 6),
                               strNomCor,
                               strAnoCor,
                               strCodLin,
                               stlMontadoras.Values[strCodMon],
                               strUniVer,
                               'LT',
                               fltPesFor,
                               fltPesCor,
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


          Inc(intCodSeq);

        End;

      End;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fMensagem('', E.MEssage + #13#10 + strLinha, ['&Ok']);
    End;
  End;

  FreeAndNil(stlMontadoras);

  fDropTable('TMP_CADMON');
  fDropTable('TMP_CADLIN');
  fDropTable('TMP_CADBAS');
  fDropTable('TMP_CADTAB');

end;

function fGerarBases(strNomArq: String): Boolean;
  Var
    stlArqTxt: TStringList;
    intLinhaTxt: Integer;
    strLinhaTxt: String;

    strTipReg: String;

    qryStaTMP_CADBAS: TUniQuery;
    qryTMP_CADLIN: TUniQuery;
    qryTMP_CADBAS: TUniQuery;
    qryTMP_CADMON: TUniQuery;

    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_CADMON ( ';
  //strSQL := strSQL + 'CREATE TABLE TMP_CADMON ( ';
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
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_CADLIN ( ';
  //strSQL := strSQL + 'CREATE TABLE TMP_CADLIN ( ';
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
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_CADBAS ( ';
  //strSQL := strSQL + 'CREATE TABLE TMP_CADBAS ( ';
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

  stlArqTxt := TStringList.Create;
  stlArqTxt.LoadFromFile(strNomArq);

  For intLinhaTxt := 0 To stlArqTxt.Count-1 Do
  Begin
    strLinhaTxt := stlArqTxt[intLinhaTxt];
    strTipReg := Copy(strLinhaTxt, 299, 02);

    {*******************************************}
    {* CADASTRO DE LINHAS                      *}
    {****************************************MV*}
    If (strTipReg = '20') Then
    Begin

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO TMP_CADLIN ( ';
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
        ParamByName('CODSEQ').AsString := Copy(strLinhaTxt, 01, 03);
        ParamByName('DESLIN').AsString := Copy(strLinhaTxt, 04, 30);
        ParamByName('VOLUME').AsFloat  := fStrToFloat(Copy(strLinhaTxt, 34, 6));
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
      strSQL := strSQL + 'INSERT INTO TMP_CADBAS ( ';
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
        ParamByName('CODSEQ').AsString := Copy(strLinhaTxt, 01, 03);
        ParamByName('CODBAS').AsString := Copy(strLinhaTxt, 04, 08);
        ParamByName('DESBAS').AsString := Copy(strLinhaTxt, 12, 45);
        ParamByName('CODLIN').AsString := Copy(strLinhaTxt, 57, 03);
        ParamByName('PESESP').AsFloat  := fStrToFloat(Copy(strLinhaTxt, 60, 08)) / 10000;
        ExecSQL;
        Close;
      End;

    End

  End;

  qryTMP_CADBAS := fCriaQuery(Nil);
  qryTMP_CADBAS.SQL.Add('SELECT * FROM TMP_CADBAS');
  qryTMP_CADBAS.Open;

  qryTMP_CADLIN := fCriaQuery(Nil);
  qryTMP_CADLIN.SQL.Add('SELECT * FROM TMP_CADLIN');
  qryTMP_CADLIN.Open;

  qryTMP_CADMON := fCriaQuery(Nil);
  qryTMP_CADMON.SQL.Add('SELECT * FROM TMP_CADMON');
  qryTMP_CADMON.Open;

  qryStaTMP_CADBAS := fCriaQuery(Nil);
  qryStaTMP_CADBAS.SQL.Add('SELECT * FROM STA_CADBAS');
  qryStaTMP_CADBAS.Open;

  While (Not qryTMP_CADBAS.Eof) Do
  Begin

    If (Not qryTMP_CADLIN.Locate('LIN_CODSEQ', qryTMP_CADBAS.FieldByName('BAS_CODLIN').AsString, [])) Then
    Begin
      qryStaTMP_CADBAS.Next;
      Continue;
    End;

    If qryStaTMP_CADBAS.Locate('BAS_CODBAS', qryTMP_CADBAS.FieldByName('BAS_CODBAS').AsString, []) Then
    Begin
      qryStaTMP_CADBAS.Edit;
    End
    Else
    Begin
      qryStaTMP_CADBAS.Append;
      qryStaTMP_CADBAS.FieldByName('BAS_CODBAS').AsString := qryTMP_CADBAS.FieldByName('BAS_CODBAS').AsString;
      qryStaTMP_CADBAS.FieldByName('BAS_CODSEQ').AsString := qryTMP_CADBAS.FieldByName('BAS_CODSEQ').AsString;
      qryStaTMP_CADBAS.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('STA_CADBAS', VS_strCodEmp);
      qryStaTMP_CADBAS.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
    End;

    qryStaTMP_CADBAS.FieldByName('BAS_VOLUME').AsFloat  := qryTMP_CADLIN.FieldByName('LIN_VOLUME').AsFloat;
    qryStaTMP_CADBAS.FieldByName('BAS_PESESP').AsFloat  := qryTMP_CADBAS.FieldByName('BAS_PESESP').AsFloat;
    qryStaTMP_CADBAS.FieldByName('BAS_DESBAS').AsString := qryTMP_CADBAS.FieldByName('BAS_DESBAS').AsString;
    qryStaTMP_CADBAS.Post;

    qryTMP_CADBAS.Next;
  End;

  FreeAndNil(qryTMP_CADBAS);
  FreeAndNil(qryTMP_CADLIN);

  FreeAndNil(qryTMP_CADBAS);

  Result := True;

end;

function fGravaCadStaDinamica(strCodSeq,
                              strNomCor,
                              strAnoCor,
                              strCodLin,
                              strCodMon,
                              strUniVer,
                              strUniDad: String;
                              fltPesFor,
                              fltPesCor: Double;
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
Begin

  Try
    strSQL := '';
    strSQL := strSQL + 'INSERT DELAYED INTO STA_CADSTA (' ;
    strSQL := strSQL + '  STA_CODSEQ, ';
    strSQL := strSQL + '  STA_NOMCOR, ';
    strSQL := strSQL + '  STA_ANOCOR, ';
    strSQL := strSQL + '  STA_CODLIN, ';
    strSQL := strSQL + '  STA_MONTAD, ';
    strSQL := strSQL + '  STA_UNIVER, ';
    strSQL := strSQL + '  STA_UNIDAD, ';
    strSQL := strSQL + '  STA_PESFOR, ';
    strSQL := strSQL + '  STA_PESCOR, ';
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
    strSQL := strSQL + '  AUTOINCREM) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :CODSEQ, ';
    strSQL := strSQL + '  :NOMCOR, ';
    strSQL := strSQL + '  :ANOCOR, ';
    strSQL := strSQL + '  :CODLIN, ';
    strSQL := strSQL + '  :MONTAD, ';
    strSQL := strSQL + '  :UNIVER, ';
    strSQL := strSQL + '  :UNIDAD, ';
    strSQL := strSQL + '  :PESFOR, ';
    strSQL := strSQL + '  :PESCOR, ';
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
      ParamByName('MONTAD').AsString := strCodMon;
      ParamByName('UNIVER').AsString := strUniVer;
      ParamByName('UNIDAD').AsString := strUniDad;
      ParamByName('PESFOR').AsFloat  := fltPesFor;
      ParamByName('PESCOR').AsFloat  := fltPesCor;
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

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadSta: TUniQuery;
    strCodSeq: String;
    strAutInc: String;
    intContador: Integer;
    fltPesFor: Double;

    qryTMP_CADBAS: TUniQuery;
    strCamBas: String;
    strCamQtd: String;
begin

  fltPesFor := 0.0;

  qryTMP_CADBAS := fCriaQuery(Nil);

  pDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODNFM').AsString);

  qryTMP_CADBAS := fCriaQuery;
  qryTMP_CADBAS.SQL.Add('SELECT * FROM STA_CADBAS');
  qryTMP_CADBAS.Open;

  qryCadSta := fCriaQuery;
  qryCadSta.SQL.Add('SELECT * FROM STA_CADSTA ORDER BY AUTOINCREM DESC LIMIT 1');
  qryCadSta.Open;

//  strCodSeq := fStrZero(StrToIntDef(qryCadSta.FieldByName('STA_CODSEQ').AsString, 0) + 1, 6);
//  strAutInc := fStrZero((StrToIntDef(LeftStr(qryCadSta.FieldByName('AUTOINCREM').AsString, 17), 0) + 1), 17);
//  strAutInc := strAutInc + VS_strCodEmp;
  strCodSeq := fStrZero(fRetProCodSeq,6);
  strAutInc := fRetAutoIncrem('STA_CADSTA', VS_strCodEmp);

  qryCadSta.Append;
  qryCadSta.FieldByName('STA_CODSEQ').AsString := strCodSeq;
  qryCadSta.FieldByName('STA_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadSta.FieldByName('STA_ANOCOR').AsString := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
  qryCadSta.FieldByName('STA_CODLIN').AsString := qryCadNfm.FieldByName('NFM_CODLIN').AsString;
  qryCadSta.FieldByName('STA_DESLIN').AsString := '';
  qryCadSta.FieldByName('STA_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
  qryCadSta.FieldByName('STA_UNIVER').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadSta.FieldByName('STA_UNIDAD').AsString := 'LT';
  qryCadSta.FieldByName('AUTOINCREM').AsString := strAutInc;
  qryCadSta.FieldByName('STA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
  qryCadSta.FieldByName('STA_DTACAD').AsDateTime  := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

  For intContador := 1 To 10 Do
  Begin

    strCamBas := 'NFM_CODB' + fStrZero(intContador, 2);
    strCamQtd := 'NFM_QTDB' + fStrZero(intContador, 2);
    If fEmptyStr(qryCadNfm.FieldByName(strCamBas).AsString) Then
      Break;

    qryTMP_CADBAS.Locate('BAS_CODBAS', qryCadNfm.FieldByName(strCamBas).AsString, []);

    qryCadSta.FieldByName('STA_CODB' + fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName(strCamBas).AsString;
    qryCadSta.FieldByName('STA_QTDB' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName(strCamQtd).AsFloat / 9;

    fltPesFor := fltPesFor + qryCadNfm.FieldByName(strCamQtd).AsFloat / 9;
  End;

  qryCadSta.FieldByName('STA_PESCOR').AsFloat := fltPesFor / 100;
  qryCadSta.FieldByName('STA_PESFOR').AsFloat := fltPesFor;

  qryCadSta.Post;
  qryCadSta.Close;

  FreeAndNil(qryCadSta);
  FreeAndNil(qryTMP_CADBAS);

  Result := True;
end;

procedure pDeletaNovaFormula(strCodSeq: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  STA_CADSTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  STA_UNIVER = :CODSEQ ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsString := strCodSeq;
    ExecSQL;
    Close;
  End;
end;

{ TStarMixAutomotivaDinamica }

constructor TStarMixAutomotivaDinamica.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);
  NomeTinta := 'Starmix Automotiva';
end;

function TStarMixAutomotivaDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryCadNfm: TUniQuery;
    qryCadSta: TUniQuery;
    qryTMP_CADBAS: TUniQuery;

    intCodSeq: Integer;
    intCont: Integer;

    fltPesFor: Double;
begin
  qryCadNfm := fCriaQuery(Self);
  qryCadNfm.SQL.Text := 'SELECT * FROM STA_CADNFM';
  qryCadNfm.Open;

  qryCadSta := fCriaQuery(Self);
  qryCadSta.SQL.Text := 'DELETE FROM STA_CADSTA WHERE STA_UNIVER IN (SELECT DISTINCT NFM_CODNFM FROM STA_CADNFM);';
  qryCadSta.ExecSQL;

  qryCadSta.SQL.Text := 'SELECT * FROM STA_CADSTA';
  qryCadSta.Open;

  qryTMP_CADBAS := fCriaQuery(Self);
  qryTMP_CADBAS.SQL.Text := 'SELECT DISTINCT BAS_CODBAS,  BAS_PESESP FROM STA_CADBAS;';
  qryTMP_CADBAS.Open;

  intCodSeq := fRetProCodSeq();

  TTintadeMaquina.fAjustaInicialAutoIncremento('STA_CADSTA', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryCadNfm.Eof Do
  Begin
    fltPesFor := 0;

    qryCadSta.Insert;
    qryCadSta.FieldByName('STA_CODSEQ').AsString := fStrZero(intCodSeq, 6);
    qryCadSta.FieldByName('STA_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryCadSta.FieldByName('STA_ANOCOR').AsString := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
    qryCadSta.FieldByName('STA_CODLIN').AsString := qryCadNfm.FieldByName('NFM_CODLIN').AsString;
    qryCadSta.FieldByName('STA_UNIVER').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    qryCadSta.FieldByName('STA_UNIDAD').AsString := 'LT';

    For intCont := 1 To 10 Do
    Begin
      If fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString) Then
        Break;

      If Not qryTMP_CADBAS.Locate('BAS_CODBAS', qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString, []) Then
      begin
        pRegistraAcao(Format('Não foi possivel encontrar a base [%s]', [qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString]));
        break;
      end;

      qryCadSta.FieldByName('STA_CODB' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString;
      qryCadSta.FieldByName('STA_QTDB' + fStrZero(intCont, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsFloat / 9;

      fltPesFor := fltPesFor + qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsFloat / 9;
    End;

    if (fltPesFor > 0) then
    begin
      qryCadSta.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('STA_CADSTA', VS_strCodEmp);
      qryCadSta.FieldByName('STA_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
      qryCadSta.FieldByName('STA_PESCOR').AsFloat := fltPesFor / 100;
      qryCadSta.FieldByName('STA_PESFOR').AsFloat := fltPesFor;

      qryCadSta.Post;
    end
    else
    begin
      pRegistraAcao(Format('A nova fórmula [%s] não possui peso e não será cadastrada', [qryCadNfm.FieldByName('NFM_CODNFM').AsString]));
    end;  

    qryCadNfm.Next;
    intCodSeq := intCodSeq + 1;
    pRegistraProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
  End;
  pRegistraAcao('Novas formulas cadastradas com sucesso!');

  FreeAndNil(qryCadNfm);
  FreeAndNil(qryCadSta);
  FreeAndNil(qryTMP_CADBAS);

  Result := True;
end;

function TStarMixAutomotivaDinamica.fRetProCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT IFNULL(MAX(STA_CODSEQ),0) + 1 PROX FROM STA_CADSTA;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;

//  If qryGen.IsEmpty Then
//    Result := qryGen.FieldByName('MAX').AsInteger
//  Else
//    Result := 1;

  FreeAndNil(qryGen);
end;

function fRetProCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(STA_CODSEQ),0) + 1 PROX FROM STA_CADSTA;';
    qryGen.Open;

    Result := qryGen.FieldByName('PROX').AsInteger;
  Finally
    FreeAndNil(qryGen);
  End;
end;

end.
