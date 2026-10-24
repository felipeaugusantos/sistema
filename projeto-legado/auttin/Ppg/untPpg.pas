unit untPpg;

interface

uses SysUtils, Windows, Classes,  StrUtils, Forms;

  function fDescartarLinha(strLinha: String): Boolean;

  function fGravaCadPpg(strDesCor,
                        strVeicul,
                        strMontad,
                        strTipo,
                        strAno,
                        strCodCor,
                        strCodAtc: String;
                        fltPreCus,
                        fltPreVen: Double;
                        strCodEmp: String;
                        Var intAutInc: Integer): Boolean;

  function fPpgGeraArquivo: Boolean;

implementation

uses untModuloTinta, untFuncoes, Uni, DB, untIConfTinta,
    untFuncTinta, untFuncoesSimples;

function fPpgGeraArquivo: Boolean;
  Var
    srcArquivos: TSearchRec;
    stlArquivos: TStringList;
    strPatTxt: String;
    strSQL: String;
    intContador: Integer;
    intAutInc: Integer;

    arqArqTxt: TextFile;
    strLinha: String;

    strMontad: String;
    strCodCor: String;
    strDesCor: String;
    strCodAtc: String;
    strTipo  : String;
    strVeicul: String;
    strAno   : String;
    strPreCus: String;
    strPreVen: String;
    fltPreVen: Double;
    fltPreCus: Double;
    conf: IConfTinta;
begin
  Result      := False;
  conf        := fGetConfTinta('PPG');
  strPatTxt   := conf.fGet('PATPPG') + '\'; //fArqIniTinta(0, 'PPG', 'PATPPG', '') + '\';
  stlArquivos := TStringList.Create;

  If (FindFirst(strPatTxt + '*.txt', faAnyFile, srcArquivos) = 0) Then
  Begin

    Repeat
      stlArquivos.Add(strPatTxt + srcArquivos.Name);
    Until (FindNext(srcArquivos) <> 0);

  End;
  SysUtils.FindClose(srcArquivos);

  If (stlArquivos.Count = 0) Then
  Begin
    fMensagem('', 'Não encontrei nenhum arquivo para a geração!', ['&Ok']);
    Exit;
  End;

  pZapTable('PPG_CADPPG');

  intAutInc := 1;

  For intContador := 0 To stlArquivos.Count -1 Do
  Begin

    AssignFile(arqArqTxt, stlArquivos[intContador]);
    Reset(arqArqTxt);

    While (Not Eof(arqArqTxt)) Do
    Begin

      Try
        Readln(arqArqTxt, strLinha);

        If (fDescartarLinha(strLinha)) Then
          Continue;

        strMontad := AnsiUpperCase(Trim(Copy(strLinha, 004, 003)));
        strCodCor := AnsiUpperCase(Trim(Copy(strLinha, 075, 010)));
        strDesCor := AnsiUpperCase(Trim(Copy(strLinha, 033, 032)));
        strCodAtc := AnsiUpperCase(Trim(Copy(strLinha, 009, 024)));
        strTipo   := AnsiUpperCase(Trim(Copy(strLinha, 065, 009)));
        strVeicul := AnsiUpperCase(Trim(Copy(strLinha, 106, 028)));
        strAno    := AnsiUpperCase(Trim(Copy(strLinha, 136, 008)));

        strPreVen := AnsiReplaceStr(Trim(Copy(strLinha, 159, 012)), '.', ',');
        fltPreVen := fFormataFloat(fStrToFloat(strPreVen), 2);

        strPreCus := AnsiReplaceStr(Trim(Copy(strLinha, 147, 012)), '.', ',');
        fltPreCus := fFormataFloat(fStrToFloat(strPreCus), 2);

        Result := fGravaCadPpg(strDesCor,
                               strVeicul,
                               strMontad,
                               strTipo,
                               strAno,
                               strCodCor,
                               strCodAtc,
                               fltPreCus,
                               fltPreVen,
                               VS_strCodEmp,
                               intAutInc);

        Application.ProcessMessages;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, 'Linha: ' + strLinha);
        End;
      End;

      If (Not Result) Then
        Break;

    End;

    CloseFile(arqArqTxt);

    If (Not Result) Then
      Break;

  End;


  FreeAndNil(stlArquivos);

  If (Result) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  PRO_AUTINC = :AUTINC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = "PPG_CADPPG" ';

    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsInteger := intAutInc;
      ExecSQL;
      Close;
    End;

  End;

end;

function fDescartarLinha(strLinha: String): Boolean;
begin

  Result := False;
  strLinha := AnsiLowerCase(strLinha);

  If (fEmptyStr(strLinha)) Then
    Result := True

  Else If (Pos('===', strLinha) > 0) Then
    Result := True

  Else If (Pos('montadora', strLinha) > 0) Then
    Result := True

  Else If (Pos('data:', strLinha) > 0) Then
    Result := True

  Else If (fEmptyStr(Copy(strLinha, 28, 33))) Then
    Result := True

  Else If (Pos('quantid', strLinha) > 0) Then
    Result := True;

end;

function fGravaCadPpg(strDesCor,
                      strVeicul,
                      strMontad,
                      strTipo,
                      strAno,
                      strCodCor,
                      strCodAtc: String;
                      fltPreCus,
                      fltPreVen: Double;
                      strCodEmp: String;
                      Var intAutInc: Integer): Boolean;
begin

  Try

    With frmModuloTinta.qryPpg_CadPpg Do
    Begin

      If (Not Active) Then
        Open;

      Insert;
      FieldByName('PPG_CODSEQ').AsString := fAtualizaProCod('PPG_CADPPG');
      FieldByName('PPG_DESCOR').AsString := strDesCor;
      FieldByName('PPG_VEICUL').AsString := strVeicul;
      FieldByName('PPG_MONTAD').AsString := strMontad;
      FieldByName('PPG_TIPO__').AsString := strTipo;
      FieldByName('PPG_A_N_O_').AsString := strAno;
      FieldByName('PPG_CODCOR').AsString := strCodCor;
      FieldByName('PPG_CODATC').AsString := strCodAtc;
      FieldByName('PPG_PRECUS').AsFloat  := fltPreCus;
      FieldByName('PPG_PREVEN').AsFloat  := fltPreVen;
      FieldByName('PPG_CODEMP').AsString := strCodEmp;
      FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp);
      Post;

      Inc(intAutInc);
      Result := True;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaCadPpg]');
    End;
  End;

end;

end.
