unit untGlasurit;

interface

uses SysUtils, Uni, StrUtils, DateUtils, Forms;

  function fGlasuritGeraArquivo: Boolean;
  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  procedure pDeletaNovaFormula(strCodPro: String);

implementation

uses  untIConfTinta, untFuncTinta, untInkLayoutReader, untFuncoes,  DB,
  untModuloTinta, untFuncoesSimples;

function fGlasuritGeraArquivo: Boolean;
  Var
    ilrGlasurit: TAutomotiveInkLayoutReader;
    strPatGla: String;
    intAutInc: Integer;
    qryCadGla: TUniQuery;
    qryCadNfm: TUniQuery;
    intContador: Integer;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('GLA');
  strPatGla := conf.fGet('PATGLA');

  If (Not FileExists(strPatGla)) Then
  Begin
    Result := False;
    fMensagem('', 'O arquivo ' + strPatGla + ' não existe!', ['&Ok']);
    Exit;
  End;

  intAutInc := 0;
  pZapTable('GLA_CADGLA');

  qryCadNfm := fCriaQuery(Nil);
  qryCadNfm.SQL.Add('SELECT * FROM GLA_CADNFM');
  qryCadNfm.Open;

  qryCadGla := fCriaQuery(Nil);
  qryCadGla.SQL.Clear;
  qryCadGla.SQL.Add('SELECT * FROM GLA_CADGLA');
  qryCadGla.Open;

  ilrGlasurit := TAutomotiveInkLayoutReader.Create;
  ilrGlasurit.strNomArq := strPatGla;

  While (Not ilrGlasurit.Eof) Do
  Begin

    qryCadGla.Append;
    qryCadGla.FieldByName('GLA_CODSEQ').AsString := fStrZero(intAutInc, 6);
    qryCadGla.FieldByName('GLA_LINHA_').AsString := Trim(ilrGlasurit['LINHA_']);
    qryCadGla.FieldByName('GLA_MONTAD').AsString := Trim(ilrGlasurit['MONTAD']);
    qryCadGla.FieldByName('GLA_DESCRI').AsString := Trim(ilrGlasurit['DESCRI']) + IIF(Not fEmptyStr(Trim(ilrGlasurit['INFCHA'])), ' ' + Trim(ilrGlasurit['INFCHA']), '');
    qryCadGla.FieldByName('GLA_CODPRO').AsString := Trim(ilrGlasurit['SUBCHA']);
    qryCadGla.FieldByName('GLA_PRECUS').AsFloat  := ilrGlasurit['CONCUS'];
    qryCadGla.FieldByName('GLA_PREVEN').AsFloat  := ilrGlasurit['CONVEN'];
    qryCadGla.FieldByName('GLA_ANOCOR').AsString := Trim(ilrGlasurit['ANOINI']);
    qryCadGla.FieldByName('GLA_VARIAC').AsString := Trim(ilrGlasurit['REFERE']);

    For intContador := 1 To 20 Do
    Begin
      qryCadGla.FieldByName('GLA_FORM' + fStrZero(intContador, 2)).AsString := Trim(ilrGlasurit['COL' + fStrZero(intContador, 3)]);
      qryCadGla.FieldByName('GLA_QTDB' + fStrZero(intContador, 2)).AsFloat  := ilrGlasurit['QCON' + fStrZero(intContador, 2)];
    End;

    qryCadGla.FieldByName('GLA_CODEMP').AsString := VS_strCodEmp;
    qryCadGla.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp);

    qryCadGla.Post;

    ilrGlasurit.Next;
    Inc(intAutInc);

    Application.ProcessMessages;
  End;

  fGravaAutoIncrem('GLA_CADGLA', intAutInc);

  Result := True;
  While (Not qryCadNfm.Eof) Do
  Begin
    Result := fGeraNovasFormulas(qryCadNfm);
    qryCadNfm.Next;
  End;

end;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadGla: TUniQuery;
    qryCadBas: TUniQuery;
    strAutInc: String;
    intContador: Integer;
    strCodBas: String;
    fltPreCus: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('GLA');
  pDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODNFM').AsString);

  qryCadBas := fCriaQuery(Nil);
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add('SELECT ');
  qryCadBas.SQL.Add('  GLA_CADBAS.*, ');

  If (fCfgSis('PREGER') = '0') Then
  Begin
    qryCadBas.SQL.Add('  BAS_VALBAS AS ITE_PREVEN ');
  End
  Else
  Begin
    qryCadBas.SQL.Add('  ITE_PREVE' + fCfgSis('TABPRE') + ' AS ITE_PREVEN ');
  End;

  qryCadBas.SQL.Add('FROM ');
  qryCadBas.SQL.Add('  GLA_CADBAS ');
  qryCadBas.SQL.Add('WHERE ');
  qryCadBas.SQL.Add('  BAS_CODBAS = :CODBAS');

  qryCadGla := fCriaQuery(Nil);
  qryCadGla.SQL.Clear;
  qryCadGla.SQL.Add('SELECT * FROM GLA_CADGLA WHERE AUTOINCREM = -1');
  qryCadGla.Open;

  strAutInc := fRetAutoIncrem('GLA_CADGLA', VS_strCodEmp);

  qryCadGla.Append;
  qryCadGla.FieldByName('GLA_CODSEQ').AsString := RightStr(LeftStr(strAutInc, 17), 6);
  qryCadGla.FieldByName('GLA_LINHA_').AsString := '****';
  qryCadGla.FieldByName('GLA_MONTAD').AsString := 'GERAL';
  qryCadGla.FieldByName('GLA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadGla.FieldByName('GLA_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadGla.FieldByName('GLA_ANOCOR').AsString := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime));
  qryCadGla.FieldByName('GLA_VARIAC').AsString := '';

  fltPreCus := 0.0;
  For intContador := 1 To 18 Do
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


    qryCadGla.FieldByName('GLA_FORM' + fStrZero(intContador, 2)).AsString := strCodBas;
    qryCadGla.FieldByName('GLA_QTDB' + fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intContador, 2)).AsFloat;
  End;

  qryCadGla.FieldByName('GLA_PRECUS').AsFloat  := fltPreCus;
  qryCadGla.FieldByName('GLA_PREVEN').AsFloat  := fltPreCus * conf.fGetDouble('FVEGLA');
  qryCadGla.FieldByName('GLA_CODEMP').AsString := VS_strCodEmp;
  qryCadGla.FieldByName('AUTOINCREM').AsString := fFormataAutInc(StrToInt(strAutInc), VS_strCodEmp);

  qryCadGla.Post;

  Result := True;
end;

procedure pDeletaNovaFormula(strCodPro: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  GLA_CADGLA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GLA_CODPRO = :CODPRO ';

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
