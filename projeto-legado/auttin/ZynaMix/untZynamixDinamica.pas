unit untZynamixDinamica;

interface

uses SysUtils, Classes, Uni, Forms;

function fZynamixGeraArquivoDinamica: Boolean;

procedure pAtualizaAutInc(strTabela: String; intValor: Integer);
procedure pCadastrarBase(strLinha: String);
procedure pCadastrarCor(qryCadZyn: TUniQuery; strLinha: String; Var intCodSeq: Integer);

function fGravaNovaFormula(qryCadNfm: TUniQuery): Boolean;
function fApagaCadZynNfm(strCodZyn: String): Boolean;

procedure pCadastrarNovasFormulas;

implementation

uses untFuncoesSimples, StrUtils, Data.DB, untIConfTinta, untFuncTinta;

function fZynamixGeraArquivoDinamica: Boolean;
  Var
    strPatTxt: String;
    txtArquivo: TextFile;
    strLinha: String;
    strComeco: String;
    intCodSeq: Integer;
    qryCadZyn: TUniQuery;
    conf: IConfTinta;
begin
  Result    := False;
  conf      := fGetConfTinta('ZYN');
  strPatTxt := conf.fGet('PATZYN') + '\TCUSTO.TXT'; //fArqIniTinta(0, 'ZYNAMIX', 'PATZYN', '') + '\TCUSTO.TXT';
  intCodSeq := 1;

  If (Not FileExists(strPatTxt)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O arquivo ' + strPatTxt + ' não existe.', ['&Ok']);
    Exit;
  End;

  qryCadZyn := fCriaQuery(Nil);
  qryCadZyn.SQL.Add('DELETE FROM ZYN_CADZYN');
  qryCadZyn.ExecSQL;

  qryCadZyn.SQL.Clear;
  qryCadZyn.SQL.Add('SELECT * FROM ZYN_CADZYN');
  qryCadZyn.Open;

  AssignFile(txtArquivo, strPatTxt);
  Reset(txtArquivo);

  pValidaProCod('ZYN_CADBAS');
  pValidaProCod('ZYN_CADZYN');

  While Not Eof(txtArquivo) Do
  Begin
    Readln(txtArquivo, strLinha);
    
    If (Not fEmptyStr(strLinha)) Then
    Begin
      strComeco := Trim(LeftStr(strLinha, 8));

      {*********************************}
      {* CADASTRA BASES.               *}
      {******************************MV*}
      If strComeco = 'ZYN' Then
      Begin
        pCadastrarBase(strLinha);
      End

      {*********************************}
      {* CADASTRA AS FORMULAS BASES.   *}
      {******************************MV*}
      Else If strComeco <> 'EMB' Then
      Begin
        pCadastrarCor(qryCadZyn, strLinha, intCodSeq);
      End;

      Application.ProcessMessages;
    End;

  End;

  pAtualizaAutInc('ZYN_CADZYN', intCodSeq);

  pCadastrarNovasFormulas;

  FreeAndNil(qryCadZyn);
end;

procedure pCadastrarBase(strLinha: String);
  Var
    qryCadBas: TUniQuery;
    strCodBas: String;
    strDesBas: String;
    strPesEsp: String;
    fltPesEsp: Double;
begin

  strCodBas := Copy(strLinha, 75, 6);
  strDesBas := Copy(strLinha, 33, 32);
  strPesEsp := Copy(strLinha, 173, 8);
  fltPesEsp := fStrToFloat(AnsiReplaceStr(strPesEsp, '.', ','));

  qryCadBas := fCriaQuery(Nil);
  qryCadBas.SQL.Add('SELECT * FROM ZYN_CADBAS WHERE BAS_CODBAS = :CODBAS');
  qryCadBas.ParamByName('CODBAS').AsString := strCodBas;
  qryCadBas.Open;

  If (qryCadBas.IsEmpty) Then
  Begin
    qryCadBas.Append;
    qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ZYN_CADBAS', VS_strCodEmp);
    qryCadBas.FieldByName('BAS_CODBAS').AsString := strCodBas;
    qryCadBas.FieldByName('BAS_DESBAS').AsString := strDesBas;
    qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := 900;
  End
  Else
    qryCadBas.Edit;

  qryCadBas.FieldByName('BAS_PESPEC').AsFloat := fltPesEsp;
  qryCadBas.Post;

  FreeAndNil(qryCadBas);
end;

procedure pCadastrarCor(qryCadZyn: TUniQuery; strLinha: String; Var intCodSeq: Integer);
  Var
    strDesCor: String;
    strMontad: String;
    strTipo: String;
    strAno: String;
    strCodCor: String;
    strLinZyn: String;
    strVeicul: String;

    intPosBas: Integer;
    arrBases: Array[1..10] Of String;
    arrQtds: Array[1..10] Of Double;
    intContador: Integer;

    strCodBas: String;
begin
  strDesCor := Trim(Copy(strLinha, 14, 32));
  strVeicul := Trim(Copy(strLinha, 83, 10));
  strMontad := '';
  strTipo   := Trim(Copy(strLinha, 46, 10));
  strAno    := Trim(Copy(strLinha, 113, 8));
  strCodCor := Trim(Copy(strLinha, 9, 5));
  strLinZyn := Trim(Copy(strLinha, 1, 8));

  intPosBas := 157;
  For intContador := Low(arrBases) To High(arrBases) Do
  Begin
    arrBases[intContador] := '';
    arrQtds[intContador] := 0;
  End;

  For intContador := Low(arrBases) To High(arrBases) Do
  Begin
    strCodBas := Copy(strLinha, intPosBas, 6);
    If Not fEmptyStr(strCodBas) Then
    Begin
      arrBases[intContador] := strCodBas;
      arrQtds[intContador] := fStrToFloat(AnsiReplaceStr(Copy(strLinha, intPosBas+6, 11), '.', ','));
      Inc(intPosBas, 18);
    End
    Else
      Break;
  End;

  qryCadZyn.Append;

  qryCadZyn.FieldByName('ZYN_CODSEQ').AsString := fStrZero(intCodSeq, 6);
  qryCadZyn.FieldByName('ZYN_DESCOR').AsString := strDesCor;
  qryCadZyn.FieldByName('ZYN_VEICUL').AsString := strVeicul;
  qryCadZyn.FieldByName('ZYN_MONTAD').AsString := strMontad;
  qryCadZyn.FieldByName('ZYN_TIPO__').AsString := strTipo;
  qryCadZyn.FieldByName('ZYN_A_N_O_').AsString := strAno;
  qryCadZyn.FieldByName('ZYN_CODCOR').AsString := strCodCor;
  qryCadZyn.FieldByName('ZYN_CODATC').AsString := '';
  qryCadZyn.FieldByName('ZYN_CODEMP').AsString := VS_strCodEmp;
  qryCadZyn.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intCodSeq, VS_strCodEmp, VS_strCodEmp);
  qryCadZyn.FieldByName('ZYN_LINHA_').AsString := strLinha;
  qryCadZyn.FieldByName('ZYN_CODB01').AsString := arrBases[01];
  qryCadZyn.FieldByName('ZYN_QTDC01').AsFloat  := arrQtds[01];
  qryCadZyn.FieldByName('ZYN_CODB02').AsString := arrBases[02];
  qryCadZyn.FieldByName('ZYN_QTDC02').AsFloat  := arrQtds[02];
  qryCadZyn.FieldByName('ZYN_CODB03').AsString := arrBases[03];
  qryCadZyn.FieldByName('ZYN_QTDC03').AsFloat  := arrQtds[03];
  qryCadZyn.FieldByName('ZYN_CODB04').AsString := arrBases[04];
  qryCadZyn.FieldByName('ZYN_QTDC04').AsFloat  := arrQtds[04];
  qryCadZyn.FieldByName('ZYN_CODB05').AsString := arrBases[05];
  qryCadZyn.FieldByName('ZYN_QTDC05').AsFloat  := arrQtds[05];
  qryCadZyn.FieldByName('ZYN_CODB06').AsString := arrBases[06];
  qryCadZyn.FieldByName('ZYN_QTDC06').AsFloat  := arrQtds[06];
  qryCadZyn.FieldByName('ZYN_CODB07').AsString := arrBases[07];
  qryCadZyn.FieldByName('ZYN_QTDC07').AsFloat  := arrQtds[07];
  qryCadZyn.FieldByName('ZYN_CODB08').AsString := arrBases[08];
  qryCadZyn.FieldByName('ZYN_QTDC08').AsFloat  := arrQtds[08];
  qryCadZyn.FieldByName('ZYN_CODB09').AsString := arrBases[09];
  qryCadZyn.FieldByName('ZYN_QTDC09').AsFloat  := arrQtds[09];
  qryCadZyn.FieldByName('ZYN_CODB10').AsString := arrBases[10];
  qryCadZyn.FieldByName('ZYN_QTDC10').AsFloat  := arrQtds[10]; 

  qryCadZyn.Post;

  Inc(intCodSeq);

end;

procedure pAtualizaAutInc(strTabela: String; intValor: Integer);
begin
  fExecutaSQL('UPDATE PROCOD SET PRO_AUTINC = ' + IntToStr(intValor) + ' WHERE PRO_NOMARQ = ' + QuotedStr(strTabela));
end;

function fGravaNovaFormula(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadZyn: TUniQuery;
    intCodSeq: Integer;
    intContador: Integer;
    strIndice: String;
begin
  fApagaCadZynNfm(qryCadNfm.FieldByName('NFM_CODNFM').AsString);

  qryCadZyn := fCriaQuery(Nil);
  qryCadZyn.SQL.Add('SELECT * FROM ZYN_CADZYN ORDER BY ZYN_CODSEQ DESC LIMIT 1');
  qryCadZyn.Open;

  If qryCadZyn.IsEmpty Then
    intCodSeq := 1
  Else
    intCodSeq := qryCadZyn.FieldByName('ZYN_CODSEQ').AsInteger+1;

  qryCadZyn.Append;

  qryCadZyn.FieldByName('ZYN_CODSEQ').AsString := fStrZero(intCodSeq, 6);
  qryCadZyn.FieldByName('ZYN_DESCOR').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadZyn.FieldByName('ZYN_VEICUL').AsString := qryCadNfm.FieldByName('NFM_VEICUL').AsString;
  qryCadZyn.FieldByName('ZYN_MONTAD').AsString := '';
  qryCadZyn.FieldByName('ZYN_TIPO__').AsString := qryCadNfm.FieldByName('NFM_TIPO__').AsString;;
  qryCadZyn.FieldByName('ZYN_A_N_O_').AsString := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
  qryCadZyn.FieldByName('ZYN_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadZyn.FieldByName('ZYN_CODATC').AsString := '';
  qryCadZyn.FieldByName('ZYN_CODEMP').AsString := VS_strCodEmp;
  qryCadZyn.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ZYN_CADZYN', VS_strCodEmp);
  qryCadZyn.FieldByName('ZYN_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;

  For intContador := 1 To 10 Do
  Begin
    strIndice := fStrZero(intContador, 2);
    qryCadZyn.FieldByName('ZYN_CODB' + strIndice).AsString := qryCadNfm.FieldByName('NFM_CODB' + strIndice).AsString;
    qryCadZyn.FieldByName('ZYN_QTDC' + strIndice).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + strIndice).AsFloat;
  End;

  qryCadZyn.Post;

  FreeAndNil(qryCadZyn);

  Result := True;
end;

function fApagaCadZynNfm(strCodZyn: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM ZYN_CADZYN WHERE ZYN_CODCOR = :CODCOR');
  qryAux.ParamByName('CODCOR').AsString := strCodZyn;
  qryAux.ExecSQL;
  FreeAndNil(qryAux);

  Result := True;
end;

procedure pCadastrarNovasFormulas;
  Var
    qryCadNfm: TUniQuery;
begin
  qryCadNfm := fCriaQuery(Nil);
  qryCadNfm.SQL.Add('SELECT * FROM ZYN_CADNFM');
  qryCadNfm.Open;

  While (Not qryCadNfm.Eof) Do
  Begin
    fGravaNovaFormula(qryCadNfm);
    qryCadNfm.Next;
  End;

  FreeAndNil(qryCadNfm);
end;

end.
