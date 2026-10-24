unit untZynamix;

interface

uses SysUtils, Windows, Classes,  StrUtils, Forms;

  function fDescartarLinha(strLinha: String): Boolean;

  function fGravaCadZynamix(strDesCor,
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

  function fZynamixGeraArquivo: Boolean;

implementation

uses untModuloTinta, Uni, DB,  untFuncoesSimples,untIConfTinta,
     untFuncTinta,untFuncoes;

function fZynamixGeraArquivo: Boolean;
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
    strPreVen: String;
    fltPreVen: Double;
    fltPreCus: Double;

    fltMarZyn: Double;
    conf: IConfTinta;
begin
  Result      := False;
  conf        := fGetConfTinta('ZYN');
  strPatTxt   := conf.fGet('PATZYN') + '\'; //fArqIniTinta(0, 'ZYNAMIX', 'PATZYN', '') + '\';
  fltMarZyn   := conf.fGetDouble('MARZYN'); //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'MARZYN', '0'));
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

  pZapTable('ZYN_CADZYN');

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

        If (Length(strLinha) = 180) Then
        Begin
          strMontad := AnsiUpperCase(Trim(Copy(strLinha, 004, 003)));
          strCodCor := AnsiUpperCase(Trim(Copy(strLinha, 075, 010)));
          strDesCor := AnsiUpperCase(Trim(Copy(strLinha, 033, 032)));
          strCodAtc := AnsiUpperCase(Trim(Copy(strLinha, 009, 024)));
          strTipo   := AnsiUpperCase(Trim(Copy(strLinha, 065, 010)));
          strVeicul := AnsiUpperCase(Trim(Copy(strLinha, 106, 028)));
          strAno    := AnsiUpperCase(Trim(Copy(strLinha, 136, 008)));
          strPreVen := AnsiReplaceStr(Trim(Copy(strLinha, 147, 012)), '.', ',');
          fltPreVen := fFormataFloat(fStrToFloat(strPreVen), 2);
          fltPreCus := fFormataFloat(fltPreVen / (1 + fltMarZyn / 100.0), 2);
        End
        Else
        Begin
          strMontad := AnsiUpperCase(Trim(Copy(strLinha, 004, 005)));
          strCodCor := AnsiUpperCase(Trim(Copy(strLinha, 051, 010)));
          strDesCor := AnsiUpperCase(Trim(Copy(strLinha, 014, 032)));
          strCodAtc := AnsiUpperCase(Trim(Copy(strLinha, 009, 007)));
          strTipo   := AnsiUpperCase(Trim(Copy(strLinha, 046, 005)));
          strVeicul := AnsiUpperCase(Trim(Copy(strLinha, 083, 028)));
          strAno    := AnsiUpperCase(Trim(Copy(strLinha, 113, 008)));
          strPreVen := AnsiReplaceStr(Trim(Copy(strLinha, 135, 012)), '.', ',');
          fltPreVen := fFormataFloat(fStrToFloat(strPreVen), 2);
          fltPreCus := fFormataFloat(fltPreVen / (1 + fltMarZyn / 100.0), 2);
        End;

        Result := fGravaCadZynamix(strDesCor,
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
    strSQL := strSQL + '  PRO_NOMARQ = "ZYN_CADZYN" ';

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

function fGravaCadZynamix(strDesCor,
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

    With frmModuloTinta.qryZyn_CadZyn Do
    Begin

      If (Not Active) Then
        Open;

      Insert;
      FieldByName('ZYN_CODSEQ').AsString := fAtualizaProCod('ZYN_CADZYN');
      FieldByName('ZYN_DESCOR').AsString := strDesCor;
      FieldByName('ZYN_VEICUL').AsString := strVeicul;
      FieldByName('ZYN_MONTAD').AsString := strMontad;
      FieldByName('ZYN_TIPO__').AsString := strTipo;
      FieldByName('ZYN_A_N_O_').AsString := strAno;
      FieldByName('ZYN_CODCOR').AsString := strCodCor;
      FieldByName('ZYN_CODATC').AsString := strCodAtc;
      FieldByName('ZYN_PRECUS').AsFloat  := fltPreCus;
      FieldByName('ZYN_PREVEN').AsFloat  := fltPreVen;
      FieldByName('ZYN_CODEMP').AsString := strCodEmp;
      FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp);
      Post;

      Inc(intAutInc);
      Result := True;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaCadZyn]');
    End;
  End;

end;

end.
