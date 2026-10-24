unit untSalcomix;

interface

uses SysUtils, Uni, StrUtils, DateUtils, Forms;

  function fSalcomixGeraArquivo: Boolean;
  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  procedure pDeletaNovaFormula(strCodPro: String);

implementation

uses untInkLayoutReader, untFuncoes, DB,
  untModuloTinta, untFuncoesSimples,untIConfTinta,untFuncTinta;

function fSalcomixGeraArquivo: Boolean;
  Var
    ilrSalcomix: TAutomotiveInkLayoutReader;
    strPatSal: String;
    intAutInc: Integer;
    qryCadSal: TUniQuery;
    qryCadNfm: TUniQuery;
    intContador: Integer;
    conf: IConfTinta;
    strMd5: String;
begin
  conf      := fGetConfTinta('SAL');
  strPatSal := conf.fGet('PATSAL');

  If (Not FileExists(strPatSal)) Then
  Begin
    Result := False;
    fMensagem('', 'O arquivo ' + strPatSal + ' não existe!', ['&Ok']);
    Exit;
  End;

  intAutInc := 0;
  pZapTable('SAL_CADSAL');

  qryCadNfm := fCriaQuery(Nil);
  qryCadNfm.SQL.Add('SELECT * FROM SAL_CADNFM');
  qryCadNfm.Open;

  qryCadSal := fCriaQuery(Nil);
  qryCadSal.SQL.Clear;
  qryCadSal.SQL.Add('SELECT * FROM SAL_CADSAL');
  qryCadSal.Open;

  ilrSalcomix := TAutomotiveInkLayoutReader.Create;
  ilrSalcomix.strNomArq := strPatSal;

  While (Not ilrSalcomix.Eof) Do
  Begin

    qryCadSal.Append;
    qryCadSal.FieldByName('SAL_CODSEQ').AsString := fStrZero(intAutInc, 6);
    qryCadSal.FieldByName('SAL_LINHA_').AsString := Trim(ilrSalcomix['LINHA_']);
    qryCadSal.FieldByName('SAL_MONTAD').AsString := Trim(ilrSalcomix['MONTAD']);
    qryCadSal.FieldByName('SAL_DESCRI').AsString := Trim(ilrSalcomix['DESCRI']) + IIF(Not fEmptyStr(Trim(ilrSalcomix['INFCHA'])), ' ' + Trim(ilrSalcomix['INFCHA']), '');
    qryCadSal.FieldByName('SAL_CODPRO').AsString := Trim(ilrSalcomix['SUBCHA']);
    qryCadSal.FieldByName('SAL_PRECUS').AsFloat  := ilrSalcomix['CONCUS'];
    qryCadSal.FieldByName('SAL_PREVEN').AsFloat  := ilrSalcomix['CONVEN'];
    qryCadSal.FieldByName('SAL_ANOCOR').AsString := Trim(ilrSalcomix['ANOINI']);
    qryCadSal.FieldByName('SAL_VARIAC').AsString := Trim(ilrSalcomix['REFERE']);

    For intContador := 1 To 20 Do
    Begin
      qryCadSal.FieldByName('SAL_FORM' + fStrZero(intContador, 2)).AsString := Trim(ilrSalcomix['COL' + fStrZero(intContador, 3)]);
      qryCadSal.FieldByName('SAL_QTDB' + fStrZero(intContador, 2)).AsFloat  := ilrSalcomix['QCON' + fStrZero(intContador, 2)];
    End;

    qryCadSal.FieldByName('SAL_CODEMP').AsString := VS_strCodEmp;
    qryCadSal.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp);

    strMd5 := '';
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODSEQ').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODPRO').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_LINHA_').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_DESCRI').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_MONTAD').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_ANOCOR').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_VARIAC').AsString;

    qryCadSal.FieldByName('SAL_MD5KEY').AsString := GetMD5(strMd5);

    qryCadSal.Post;

    ilrSalcomix.Next;
    Inc(intAutInc);

    Application.ProcessMessages;
  End;

  fGravaAutoIncrem('SAL_CADSAL', intAutInc);

  Result := True;
  While (Not qryCadNfm.Eof) Do
  Begin
    Result := fGeraNovasFormulas(qryCadNfm);
    qryCadNfm.Next;
  End;

end;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadSal: TUniQuery;
    qryCadBas: TUniQuery;
    strAutInc: String;
    intContador: Integer;
    strCodBas: String;
    fltPreCus: Double;
    conf: IConfTinta;
    strMd5: String;
begin
  conf := fGetConfTinta('SAL');
  pDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODNFM').AsString);

  qryCadBas := fCriaQuery(Nil);
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add('SELECT ');
  qryCadBas.SQL.Add('  SAL_CADBAS.*, ');

  If (fCfgSis('PREGER') = '0') Then
  Begin
    qryCadBas.SQL.Add('  BAS_VALBAS AS ITE_PREVEN ');
  End
  Else
  Begin
    qryCadBas.SQL.Add('  ITE_PREVE' + fCfgSis('TABPRE') + ' AS ITE_PREVEN ');
  End;

  qryCadBas.SQL.Add('FROM ');
  qryCadBas.SQL.Add('  SAL_CADBAS ');
  qryCadBas.SQL.Add('WHERE ');
  qryCadBas.SQL.Add('  BAS_CODBAS = :CODBAS');

  qryCadSal := fCriaQuery(Nil);
  qryCadSal.SQL.Clear;
  qryCadSal.SQL.Add('SELECT * FROM SAL_CADSAL WHERE AUTOINCREM = -1');
  qryCadSal.Open;

  strAutInc := fRetAutoIncrem('SAL_CADSAL', VS_strCodEmp);

  qryCadSal.Append;
  qryCadSal.FieldByName('SAL_CODSEQ').AsString := RightStr(LeftStr(strAutInc, 17), 6);
  qryCadSal.FieldByName('SAL_LINHA_').AsString := '****';
  qryCadSal.FieldByName('SAL_MONTAD').AsString := 'GERAL';
  qryCadSal.FieldByName('SAL_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadSal.FieldByName('SAL_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadSal.FieldByName('SAL_ANOCOR').AsString := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime));
  qryCadSal.FieldByName('SAL_VARIAC').AsString := '';

  fltPreCus := 0.0;
  For intContador := 1 To 20 Do
  Begin
    strCodBas := qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intContador, 2)).AsString;
    If (fEmptyStr(strCodBas)) Then
      Break;

    qryCadBas.Close;
    qryCadBas.ParamByName('CODBAS').AsString := strCodBas;
    qryCadBas.Open;
    If (qryCadBas.IsEmpty) Then
      Continue;

    fltPreCus := fltPreCus + fFormataFloat(qryCadBas.FieldByName('ITE_PREVEN').AsFloat /
                                           qryCadBas.FieldByName('BAS_PESBAS').AsFloat *
                                           qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intContador, 2)).AsFloat, 2);


    qryCadSal.FieldByName('SAL_FORM' + fStrZero(intContador, 2)).AsString := strCodBas;
    qryCadSal.FieldByName('SAL_QTDB' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intContador, 2)).AsFloat;
  End;

  qryCadSal.FieldByName('SAL_PRECUS').AsFloat  := fltPreCus;
  qryCadSal.FieldByName('SAL_PREVEN').AsFloat  := fltPreCus * conf.fGetDouble('FVESAL');
  qryCadSal.FieldByName('SAL_CODEMP').AsString := VS_strCodEmp;
  qryCadSal.FieldByName('AUTOINCREM').AsString := strAutInc;

  strMd5 := '';
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODSEQ').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODPRO').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_LINHA_').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_DESCRI').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_MONTAD').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_ANOCOR').AsString;
  strMd5 := strMd5 + qryCadSal.FieldByName('SAL_VARIAC').AsString;

  qryCadSal.FieldByName('SAL_MD5KEY').AsString := GetMD5(strMd5);

  qryCadSal.Post;

  Result := True;
end;

procedure pDeletaNovaFormula(strCodPro: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  SAL_CADSAL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SAL_CODPRO = :CODPRO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPRO').AsString := strCodPro;
    ExecSQL;
    Close;
  End;
end;

end.
