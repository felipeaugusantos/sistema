unit untSuvinilImobiliaria;

interface

  uses SysUtils,  Classes, Uni, StrUtils, Variants,
    Dialogs, Forms ,untTintadeMaquina,
    untIConfTinta;

Type

  TSuvForMul = Record
    strCodCol: String;
    fltQtdCol: Double;

End;

Type
  TArraySuvForMul = Array Of TSuvForMul;

  TSuvinilImobiliariaDinamica = class(TTintadeMaquina)
  public
    function fGravarNovasFormulas(): Boolean; override;
  end;


  function fSuvinilGeraArquivo: Boolean;

  function fSuvinilGravaCadSuv(qryCadBas,
                               qryCadCol: TUniQuery;
                               strCodFor,
                               strCodPro,
                               strCodBas,
                               strCodEmp: String;
                               fltQtdEmb: Double;
                               stlQtdCol,
                               stlCodCol: TStringList;
                               blnDelExi: Boolean;
                               blnGerNfm: Boolean;
                               strDesIte,
                               strUnidad: String;
                               arrForMul: TArraySuvForMul;
                               Var intAutInc: Integer;
                               strAutoIncrem: String;
                               strNomCor: String;
                               conf: IConfTinta): Boolean;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  function fTemEmbalagensDiferenciadas(strCodNfm: String): Boolean;

  procedure pDeletaNovaFormula(strCodNfm, strCodBas, strCodFml: String);


implementation

uses DB, untFuncoesSimples,
  untFuncTinta,untModulo,untFuncoes,untModuloTinta;

function fSuvinilGeraArquivo: Boolean;
  Var
    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    stlQtdCol: TStringList;
    stlCodCol: TStringlist;
    arqSuvinil: TextFile;
    strPathTxt: String;
    strLinha: String;
    strCodEmp: String;

    strCodPro: String;
    strCodFor: String;
    strCodBas: String;
    fltQtdEmb: Double;
    strNomCor: String;

    strCodCol: String;
    strQtdCol: String;

    intTamMat: Integer;
    intPosMat: Integer;
    intColunaLinha: Integer;
    arrForMul: TArraySuvForMul;

    intAutInc: Integer;
    strSQL: String;
    intErro: Integer;
    strLinhaTmp: String;
    intPosTmp: Integer;

    qryCadNfm: TUniQuery;
    qrySuv_CadSuv: TUniQuery;
    conf: IConfTinta;
begin
  Result    := True;
  intAutInc := 1;
  conf := fGetConfTinta('SUV');

  qryCadBas := TUniQuery.Create(Nil);
  qryCadCol := TUniQuery.Create(Nil);

  qryCadNfm := fCriaQuery(Nil);

  qrySuv_CadSuv := fCriarQuery('SELECT * FROM SUV_CADSUV LIMIT 0');

  qryCadBas.Connection := frmModulo.Database;
  qryCadCol.Connection := frmModulo.Database;

  qryCadBas.SQL.Add('SELECT                                 ');
  qryCadBas.SQL.Add('  *                                    ');
  qryCadBas.SQL.Add('FROM                                   ');
  qryCadBas.SQL.Add('  SUV_CADBAS                           ');
  qryCadBas.SQL.Add('LEFT JOIN CADUNI ON UNI_CODUNI = SUV_CODUNI ');
  qryCadBas.SQL.Add('LEFT JOIN ITEGER ON ITE_CODITE = SUV_CODITE ');
  qryCadBas.SQL.Add('     AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
  qryCadBas.SQL.Add('ORDER BY                               ');
  qryCadBas.SQL.Add('  SUV_CODFML, SUV_CODBAS               ');
  qryCadBas.Open;

  qryCadCol.SQL.Add('SELECT                                 ');
  qryCadCol.SQL.Add('  *                                    ');
  qryCadCol.SQL.Add('FROM                                   ');
  qryCadCol.SQL.Add('  SUV_CADCOL                           ');
  qryCadCol.SQL.Add('LEFT JOIN ITEGER ON ITE_CODITE = COL_CODITE ');
  qryCadCol.SQL.Add('     AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
  qryCadCol.Open;

  strCodEmp := VS_strCodEmp;

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM SUV_CADSUV');
    ExecSQL;
    Close;
  End;

  qrySuv_CadSuv.Open;

  stlQtdCol := TStringList.Create;
  stlCodCol := TStringList.Create;

  strPathTxt := fGetConfTinta('SUV').fGet('PATSUV');

  If (RightStr(strPathTxt, 1) = '\') Then
    strPathTxt := Copy(strPathTxt, 1, Length(strPathTxt)-1);

  If (Not FileExists(strPathTxt)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo: ' + strPathTxt, ['&Ok']);
    Result := False;
    Exit;
  End;

  intErro := 0;

  AssignFile(arqSuvinil, strPathTxt);
  Reset(arqSuvinil);

  Try

    While (Not Eof(arqSuvinil)) Do
    Begin

      SetLength(arrForMul, 0);
      Application.ProcessMessages;

      stlQtdCol.Clear;
      stlCodCol.Clear;

      ReadLn(arqSuvinil, strLinha);
      If (fEmptyStr(strLinha)) Then
      Begin
        Continue;
      End;

      {If (RightStr(strLinha, 1) <> ';') Then
        strLinha := strLinha + ';';

      While (Pos(';;', strLinha) > 0) Do
      Begin
        strLinha := AnsiReplaceStr(strLinha, ';;', ';');
      End;}

      Inc(intErro);

      strCodPro := fGetValorLinha(strLinha, ';', 1);
      strCodFor := Trim(fGetValorLinha(strLinha, ';', 2)) + ' ' + Trim(fGetValorLinha(strLinha, ';', 3));
      strCodBas := fGetValorLinha(strLinha, ';', 4);
      fltQtdEmb := fStrToFloat(fGetValorLinha(strLinha, ';', 5));
      strNomCor := fGetValorLinha(strLinha, ';', 6);

      If (RightStr(strLinha, 1) <> ';') Then
        strLinha := strLinha + ';';

      intPosTmp := fGetPosLinha(strLinha, ';', 6);
      strLinhaTmp := Copy(strLinha, intPosTmp, Length(strLinha));

      While (Pos(';;', strLinhaTmp) > 0) Do
      Begin
        strLinhaTmp := AnsiReplaceStr(strLinhaTmp, ';;', ';');
      End;
      strLinha := Copy(strLinha, 1, intPosTmp-1) + strLinhaTmp;

      intColunaLinha := 7;
      strCodCol := fGetValorLinha(strLinha, ';', intColunaLinha);

      While (Not (fIsNumber(AnsiReplaceStr(strCodCol,',','.')))) And (Not fEmptyStr(strCodCol)) Do
      Begin

        intTamMat := Length(arrForMul);
        SetLength(arrForMul, intTamMat+1);
        arrForMul[intTamMat].strCodCol := strCodCol;

        stlCodCol.Add(strCodCol);
        Inc(intColunaLinha);
        strCodCol := fGetValorLinha(strLinha, ';', intColunaLinha);
      End;

      intPosMat := 0;
      strQtdCol := fGetValorLinha(strLinha, ';', intColunaLinha);

      While (Not fEmptyStr(strQtdCol)) Do
      Begin

        arrForMul[intPosMat].fltQtdCol := fStrToFloat(strQtdCol);
        Inc(intPosMat);

        stlQtdCol.Add(Trim(strQtdCol));
        Inc(intColunaLinha);
        strQtdCol := fGetValorLinha(strLinha, ';', intColunaLinha);
      End;

      If (qryCadBas.Locate('SUV_CODFML;SUV_CODBAS', VarArrayOf([strCodPro, strCodBas]), [])) Then
      Begin

        fSuvinilGravaCadSuv(qryCadBas,
                            qryCadCol,
                            strCodFor,
                            strCodPro,
                            strCodBas,
                            strCodEmp,
                            fltQtdEmb,
                            stlQtdCol,
                            stlCodCol,
                            False,
                            False,
                            '',
                            '',
                            arrForMul,
                            intAutInc,
                            '',
                            strNomCor,
                            conf);

      End;

    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  PRO_AUTINC = :AUTINC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = "SUV_CADSUV" ';

    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsInteger := intAutInc;
      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  SUV_CADNFM ';

    With qryCadNfm Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      While (Not Eof) Do
      Begin
        Result := fGeraNovasFormulas(qryCadNfm);
        If (Not Result) Then
          Break;

        Next;
      End;

      Close;
    End;

  Except
    On E: Exception Do
    Begin
      fMensagem('ATENÇÃO!', 'Erro Linha: ' + IntToStr(intErro) + ' ' + E.Message, ['&Ok']);
      Result := False;
    End;
  End;

  FreeAndNil(stlCodCol);
  FreeAndNil(stlQtdCol);
  FreeAndNil(qrySuv_CadSuv);
end;

function fSuvinilGravaCadSuv(qryCadBas,
                             qryCadCol: TUniQuery;
                             strCodFor,
                             strCodPro,
                             strCodBas,
                             strCodEmp: String;
                             fltQtdEmb: Double;
                             stlQtdCol,
                             stlCodCol: TStringList;
                             blnDelExi: Boolean;
                             blnGerNfm: Boolean;
                             strDesIte,
                             strUnidad: String;
                             arrForMul: TArraySuvForMul;
                             Var intAutInc: Integer;
                             strAutoIncrem: String;
                             strNomCor: String;
                             conf: IConfTinta): Boolean;
  Var
    intContador: Integer;
    fltFatLat: Double;
    fltFatGal: Double;
    fltFatLit: Double;
    fltCusCol: Double;
    fltVenCol: Double;

    fltQtdGra: Double;

    strCodCol: String;
    fltQtdCol: Double;

    fltCusUti: Double;
    fltVenUti: Double;
    fltPreCus: Double;
    fltPreVen: Double;

    fltFatPreCol: Double;
    fltPreCusColorante: Double;
    fltPreVenColorante: Double;

    qrySuv_CadSuv: TUniQuery;
    strMd5: string;    
begin
  qrySuv_CadSuv := fCriarQuery('SELECT * FROM SUV_CADSUV LIMIT 0');

  If blnDelExi Then
  Begin

    pDeletaNovaFormula(strDesIte,
                       qryCadBas.FieldByName('SUV_CODBAS').AsString,
                       qryCadBas.FieldByName('SUV_CODFML').AsString);

  End;

  fltQtdEmb := fFormataFloat(fltQtdEmb, 3);

  If (fltQtdEmb = fFormataFloat(0.203, 3)) Then
  Begin
    fltFatGal := 00;
    fltFatLat := 00;
    fltFatLit := 1;
  End
  Else If (fltQtdEmb = fFormataFloat(0.81, 3)) Then
  Begin
    fltFatGal := 04;
    fltFatLat := 20;
    fltFatLit := 01;
  End
  Else If (fltQtdEmb = fFormataFloat(0.90, 3)) Then
  Begin
    fltFatGal := 04;
    fltFatLat := 00;
    fltFatLit := 01;
  End
  Else If (fltQtdEmb = fFormataFloat(2.88, 3)) Then
  Begin
    fltFatGal := 01;
    fltFatLat := 00;
    fltFatLit := 00;
  End
  Else If (fltQtdEmb = fFormataFloat(3.24, 3)) Then
  Begin
    fltFatGal := 01;
    fltFatLat := 05;

    If Pos(strCodPro + '=' + strCodBas, conf.fGet('BASANT')) > 0 Then
    Begin
      fltFatLat := fltFatLat * 14 / 16.2;
    End;

    fltFatLit := 00;
  End
  Else If (fltQtdEmb = fFormataFloat(16.2, 3)) Then
  Begin
    fltFatGal := 01 / 05;
    fltFatLat := 01;
    fltFatLit := 00;
  End
  Else If (fltQtdEmb = fFormataFloat(14.0, 3)) Then
  Begin
    fltFatGal := 00;
    fltFatLat := 01;
    fltFatLit := 00;
  End
  Else If (fltQtdEmb = fFormataFloat(4.8, 3)) Then
  Begin
    fltFatLit := 00;
    fltFatGal := 01;
    fltFatLat := 05;
  End
  Else If (fltQtdEmb = fFormataFloat(24, 3)) Then
  Begin
    fltFatLit := 00;
    fltFatGal := 01 / 05;
    fltFatLat := 01;
  End
  Else If (fltQtdEmb = fFormataFloat(5.8, 3)) Then
  Begin
    fltFatLit := 00;
    fltFatGal := 01;
    fltFatLat := 05;
  End
  Else If (fltQtdEmb = fFormataFloat(29, 3)) Then
  Begin
    fltFatLit := 00;
    fltFatGal := 01 / 05;
    fltFatLat := 01;
  End
  Else If (fltQtdEmb = fFormataFloat(5.2, 3)) Then
  Begin
    fltFatLit := 00;
    fltFatGal := 01;
    fltFatLat := 05;
  End
  Else If (fltQtdEmb = fFormataFloat(26, 3)) Then
  Begin
    fltFatLit := 00;
    fltFatGal := 01 / 05;
    fltFatLat := 01;
  End
  Else If (fltQtdEmb = fFormataFloat(2.7, 3)) Then
  Begin
    fltFatLit := 00;
    fltFatGal := 01;
    fltFatLat := 00;
  End
  Else If (fltQtdEmb = fFormataFloat(4.6, 3)) Then
  Begin
    fltFatLit := 00;
    fltFatGal := 01;
    fltFatLat := 00;
  End
  Else
  Begin
    fltFatGal := 00;
    fltFatLat := 00;
    fltFatLit := 00;
  End;

  fltCusCol := 0.0;
  fltVenCol := 0.0;
  {*****************************************}
  {* CALCULA PREÇO DO COLORANTE            *}
  {**************************************MV*}
  For intContador := 0 To stlCodCol.Count -1 Do
  Begin

    strCodCol := stlCodCol.Strings[intContador];
    fltQtdCol := fStrToFloat(stlQtdCol.Strings[intContador]);

    qryCadCol.Locate('COL_CODCOL', strCodCol, []);


    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
    Begin
      fltPreCusColorante := qryCadCol.FieldByName('COL_PRECUS').AsFloat;
      fltPreVenColorante := qryCadCol.FieldByName('COL_PREVEN').AsFloat;
    End
    Else
    Begin
      fltPreCusColorante := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenColorante := qryCadCol.FieldByName('ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1')).AsFloat;
    End;

    fltCusCol := fltCusCol + (fltQtdCol * 0.154) * (fltPreCusColorante / 1000);
    fltVenCol := fltVenCol + (fltQtdCol * 0.154) * (fltPreVenColorante / 1000);

  End;

  {*****************************************}
  {* PROCESSA CADBAS GRAVANDO TODAS AS     *}
  {* UNIDADES DO PRODUTO + BASE            *}
  {**************************************MV*}
  While (Not qryCadBas.Eof)                                        And
        (qryCadBas.FieldByName('SUV_CODFML').AsString = strCodPro) And
        (qryCadBas.FieldByName('SUV_CODBAS').AsString = strCodBas) Do
  Begin

    Application.ProcessMessages;

    If (Not blnGerNfm) Then
    Begin
      strDesIte := qryCadBas.FieldByName('SUV_DESCRI').AsString;
      strUnidad := qryCadBas.FieldByName('UNI_SIGUNI').AsString;
    End;

    fltPreCus := 0.0;
    fltPreVen := 0.0;

    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
    Begin
      fltCusUti := qryCadBas.FieldByName('SUV_PRECUS').AsFloat;
      fltVenUti := qryCadBas.FieldByName('SUV_PREVEN').AsFloat;
    End
    Else
    Begin
      fltCusUti := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
      fltVenUti := qryCadBas.FieldByName('ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '0')).AsFloat;
    End;

    If (Assigned(qryCadBas.FindField('NFM_VOLUME'))) Then
    Begin
      fltPreCus := fltCusUti + (fltCusCol * qryCadBas.FieldByName('NFM_VOLUME').AsFloat);
      fltPreVen := fltVenUti + (fltVenCol * qryCadBas.FieldByName('NFM_VOLUME').AsFloat);
    End

    Else If (strUnidad = 'LT') Then
    Begin
      fltPreCus := fltCusUti + fltCusCol;
      fltPreVen := fltVenUti + fltVenCol;
    End
    Else If (strUnidad = 'GL') Then
    Begin
      fltPreCus := fltCusUti + (fltCusCol * fltFatGal);
      fltPreVen := fltVenUti + (fltVenCol * fltFatGal);
    End
    Else If (strUnidad = 'LA') Then
    Begin
      fltPreCus := fltCusUti + (fltCusCol * fltFatLat);
      fltPreVen := fltVenUti + (fltVenCol * fltFatLat);
    End;

    {*****************************************}
    {* GRAVA NO CADSUV                       *}
    {**************************************MV*}
    If (Not qrySuv_CadSuv.Active) Then
      qrySuv_CadSuv.Open;

    qrySuv_CadSuv.Insert;

    If (intAutInc > 0) Then
      qrySuv_CadSuv.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp)
    Else
      qrySuv_CadSuv.FieldByName('AUTOINCREM').AsString := strAutoIncrem;

    qrySuv_CadSuv.FieldByName('SUV_CODEMP').AsString := strCodEmp;
    qrySuv_CadSuv.FieldByName('SUV_DESCRI').AsString := strDesIte;
    qrySuv_CadSuv.FieldByName('SUV_REFERE').AsString := strCodFor;
    qrySuv_CadSuv.FieldByName('SUV_NOMCOR').AsString := strNomCor;

    qrySuv_CadSuv.FieldByName('SUV_UNIDAD').AsString := strUnidad;

    If Not conf.fGetBoolean('VENDIN') Then
    Begin
      qrySuv_CadSuv.FieldByName('SUV_CODITE').AsString := qryCadBas.FieldByName('SUV_CODITE').AsString;
      qrySuv_CadSuv.FieldByName('SUV_PREVEN').AsFloat  := fltPreVen;
      qrySuv_CadSuv.FieldByName('SUV_PRECUS').AsFloat  := fltPreCus;
    End;

    qrySuv_CadSuv.FieldByName('SUV_CODFML').AsString := qryCadBas.FieldByName('SUV_CODFML').AsString;
    qrySuv_CadSuv.FieldByName('SUV_CODBAS').AsString := qryCadBas.FieldByName('SUV_CODBAS').AsString;
    qrySuv_CadSuv.FieldByName('SUV_CODUNI').AsString := qryCadBas.FieldByName('SUV_CODUNI').AsString;

    For intContador := 1 To Length(arrForMul) Do
    Begin
      qrySuv_CadSuv.FieldByName('SUV_FORM' + fStrZero(IntToStr(intContador), 2)).AsString := arrForMul[intContador-1].strCodCol;

      fltQtdGra := 0.0;

      If (Assigned(qryCadBas.FindField('NFM_VOLUME'))) Then
        fltQtdGra := arrForMul[intContador-1].fltQtdCol * qryCadBas.FieldByName('NFM_VOLUME').AsFloat

      Else If (strUnidad = 'LT') Then
        fltQtdGra := arrForMul[intContador-1].fltQtdCol * fltFatLit

      Else If (strUnidad = 'GL') Then
        fltQtdGra := arrForMul[intContador-1].fltQtdCol * fltFatGal

      Else If (strUnidad = 'LA') Then
        fltQtdGra := arrForMul[intContador-1].fltQtdCol * fltFatLat;

      qrySuv_CadSuv.FieldByName('SUV_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat := fltQtdGra;
    End;

    strMd5 := '';
    for intContador := 1 to 15 do
    begin
      strMd5 := strMd5 + qrySuv_CadSuv.FieldByName('SUV_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qrySuv_CadSuv.FieldByName('SUV_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat),
        ',', '.', [rfReplaceAll]);
    end;

    strMd5 := GetMD5(strMd5);

    fltFatPreCol := 1;
    If (Assigned(qryCadBas.FindField('NFM_VOLUME'))) Then
      fltFatPreCol := qryCadBas.FieldByName('NFM_VOLUME').AsFloat
    Else If (strUnidad = 'LT') Then
      fltFatPreCol := fltFatLit
    Else If (strUnidad = 'GL') Then
      fltFatPreCol := fltFatGal
    Else If (strUnidad = 'LA') Then
      fltFatPreCol := fltFatLat;

    If Not conf.fGetBoolean('VENDIN') Then
    Begin
      qrySuv_CadSuv.FieldByName('SUV_COLCUS').AsFloat := fltCusCol * fltFatPreCol;
      qrySuv_CadSuv.FieldByName('SUV_COLVEN').AsFloat := fltVenCol * fltFatPreCol;
    End;

    qrySuv_CadSuv.FieldByName('SUV_MD5KEY').AsString := strMd5;
    qrySuv_CadSuv.Post;

    Inc(intAutInc);

    If (blnGerNfm) Then
      Break;

    qryCadBas.Next;
  End;

  FreeAndNil(qrySuv_CadSuv);
  Result := True;
end;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    strSQL      : String;
    intContador : Integer;
    strAutInc   : String;
    blnDelCadSuv: Boolean;

    intTamMat: Integer;

    stlCodCol: TStringList;
    stlQtdCol: TStringList;
    arrForMul: TArraySuvForMul;

    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('SUV');
  stlCodCol := TStringList.Create;
  stlQtdCol := TStringList.Create;

  qryCadBas := TUniQuery.Create(Nil);
  qryCadCol := TUniQuery.Create(Nil);

  qryCadBas.Connection := frmModulo.Database;
  qryCadCol.Connection := frmModulo.Database;

  strSQL := '';
  strSQL := strSQL + 'SELECT                                 ';
  strSQL := strSQL + '  *                                    ';
  strSQL := strSQL + 'FROM                                   ';
  strSQL := strSQL + '  SUV_CADBAS                           ';
  strSQL := strSQL + 'JOIN CADUNI ON UNI_CODUNI = SUV_CODUNI ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = SUV_CODITE ';
  strSQL := strSQL + '     AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  If (fTemEmbalagensDiferenciadas(qryCadNfm.FieldByName('NFM_CODNFM').AsString)) Then
  Begin
    strSQL := strSQL + 'JOIN SUV_NFMEMB ON SUV_CODFML = NFM_CODFML AND ';
    strSQL := strSQL + '                   SUV_CODBAS = NFM_CODBAS AND ';
    strSQL := strSQL + '                   SUV_CODUNI = NFM_UNIDAD AND ';
    strSQL := strSQL + '                   NFM_CODNFM = :CODNFM    AND ';
    strSQL := strSQL + '                   IFNULL(NFM_VOLUME, 0) > 0   ';
  End;

  strSQL := strSQL + 'WHERE                                  ';
  strSQL := strSQL + '  SUV_CODFML = :CODFML AND             ';
  strSQL := strSQL + '  SUV_CODBAS = :CODBAS AND             ';
  strSQL := strSQL + '  UNI_SIGUNI IN ("LT","GL","LA")       ';
  strSQL := strSQL + 'ORDER BY                               ';
  strSQL := strSQL + '  SUV_CODFML, SUV_CODBAS               ';

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
    ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

    If (Assigned(Params.FindParam('CODNFM'))) Then
    Begin
      ParamByName('CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    End;

    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SUV_CADCOL ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = COL_CODITE ';
  strSQL := strSQL + '     AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  With qryCadCol Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  For intContador := 1 To 10 Do
  Begin

    If (fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intContador, 2)).AsString)) Then
    Begin
      Break;
    End;

    intTamMat := Length(arrForMul);

    stlCodCol.Add(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intContador, 2)).AsString);
    stlQtdCol.Add(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsString);
    SetLength(arrFormul, intTamMat+1);
    arrForMul[intTamMat].strCodCol := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intContador, 2)).AsString;
    arrForMul[intTamMat].fltQtdCol := qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsFloat;

  End;

  blnDelCadSuv := True;
  Result := True;
  
  TTintadeMaquina.fAjustaInicialAutoIncremento('SUV_CADSUV', VS_strCodEmp);

  While not qryCadBas.Eof do
  Begin
    intContador := 0;
    strAutInc   := fRetAutoIncrem('SUV_CADSUV', VS_strCodEmp);

    Result := fSuvinilGravaCadSuv(qryCadBas,
                                  qryCadCol,
                                  qryCadNfm.FieldByName('NFM_DESCRI').AsString,
                                  qryCadNfm.FieldByName('NFM_CODPRO').AsString,
                                  qryCadNfm.FieldByName('NFM_BASE__').AsString,
                                  VS_strCodEmp,
                                  0.810,
                                  stlQtdCol,
                                  stlCodCol,
                                  blnDelCadSuv, //True,
                                  True,
                                  qryCadNfm.FieldByName('NFM_CODNFM').AsString,
                                  qryCadBas.FieldByName('UNI_SIGUNI').AsString,//qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                                  arrForMul,
                                  intContador,
                                  strAutInc,
                                  qryCadNfm.FieldByName('NFM_CODNFM').AsString,
                                  conf);

    qryCadBas.Next;
    blnDelCadSuv := False;
  End;
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadCol);

  FreeAndNil(stlCodCol);
  FreeAndNil(stlQtdCol);

end;

procedure pDeletaNovaFormula(strCodNfm, strCodBas, strCodFml: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  SUV_CADSUV ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LEFT(SUV_DESCRI, 12) = :REFERE ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('REFERE').AsString := strCodNfm;
    ExecSQL;
    Close;
  End;
end;

function fTemEmbalagensDiferenciadas(strCodNfm: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM SUV_NFMEMB WHERE NFM_CODNFM = :CODNFM');
  qryAux.ParamByName('CODNFM').AsString := strCodNfm;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);
end;

function TSuvinilImobiliariaDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin

  {******************************************************}
  {* APAGA TODAS AS TINTAS ORIGINADAS DE NOVAS FORMULAS *}
  {***************************************************PH*}
  pRegistraAcao('Atualizando cadastro de tintas...');

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM SUV_CADSUV WHERE SUV_DESCRI IN (SELECT NFM_CODNFM FROM SUV_CADNFM);';
  qryGen.ExecSQL;

  pRegistraAcao('Cadastro de tintas realizado com sucesso!');

  {*******************************************}
  {* SELECTIONA TODAS AS NOVAS FORMULAS      *}
  {****************************************PH*}
  qryGen.SQL.Text := 'SELECT * FROM SUV_CADNFM;';
  qryGen.Open;

  qryGen.First;

  pRegistraAcao('Cadastrando novas formulas');

  {**************************************************************************************}
  {* PERCORRE TODAS AS NOVAS FORMULAS CADASTRANDO EM VARIAS UNIDADES DEPENDENDO DA BASE *}
  {***********************************************************************************PH*}
  While Not qryGen.Eof Do
  Begin
    fGeraNovasFormulas(qryGen);

    qryGen.Next;
    pRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
  End;

  pRegistraAcao('novas formulas cadastradas com sucesso!');

  Result := True;
end;

end.

