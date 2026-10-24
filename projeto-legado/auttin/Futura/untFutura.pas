unit untFutura;

interface

  uses SysUtils,  Classes, Uni, StrUtils, Variants,
     Dialogs, Forms;


Type

  TFutForMul = Record
    strCodCol: String;
    fltQtdCol: Double;

End;

Type
  TArrayFutForMul = Array Of TFutForMul;

  function fFuturaGeraArquivo: Boolean;

  function fFuturaGravaCadFut(qryCadBas,
                              qryCadCol,
                              qryCadFut: TUniQuery;
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
                              arrForMul: TArrayFutForMul;
                              Var intAutInc: Integer;
                              strAutoIncrem: String): Boolean;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  procedure pDeletaNovaFormula(strCodNfm: String);

implementation

uses DB,   untIConfTinta, untFuncTinta, untInkLayoutReader,
    untModuloTinta, untFuncoesSimples;

function fFuturaGeraArquivo: Boolean;
  Var
    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadFut: TUniQuery;
    stlQtdCol: TStringList;
    stlCodCol: TStringlist;
    strPathTxt: String;
    strCodEmp: String;

    strCodPro: String;
    strCodFor: String;
    strCodBas: String;
    fltQtdEmb: Double;

    strCodCol: String;
    strQtdCol: String;

    intTamMat: Integer;
    intColorante: Integer;
    arrForMul: TArrayFutForMul;

    intAutInc: Integer;
    strSQL: String;
    intErro: Integer;

    ilrFutura: TInkLayoutReader;
    qryCadNfm: TUniQuery;
    conf: IConfTinta;
begin

  Result    := True;
  intAutInc := 1;
  conf      := fGetConfTinta('FUT');

  ilrFutura := TInkLayoutReader.Create;

  qryCadBas := fCriaQuery;
  qryCadCol := fCriaQuery;
  qryCadFut := fCriaQuery;
  qryCadNfm := fCriaQuery;

  qryCadBas.SQL.Add('SELECT ');
  qryCadBas.SQL.Add('  FUT_CADBAS.*, ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    qryCadBas.SQL.Add('  BAS_PRECUS AS ITE_PRECUS, ');
    qryCadBas.SQL.Add('  BAS_PREVEN AS ITE_PREVEN, ');
  End
  Else
  Begin
    qryCadBas.SQL.Add('  ITE_PRECUS, ');
    qryCadBas.SQL.Add('  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN, ');
  End;

  qryCadBas.SQL.Add('  UNI_SIGUNI AS BAS_SIGUNI ');
  qryCadBas.SQL.Add('FROM ');
  qryCadBas.SQL.Add('  FUT_CADBAS ');
  qryCadBas.SQL.Add('JOIN CADUNI ON UNI_CODUNI = BAS_CODUNI ');
  qryCadBas.SQL.Add('JOIN ITEGER ON ITE_CODITE = BAS_CODITE ');
  qryCadBas.SQL.Add('            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryCadBas.SQL.Add('ORDER BY ');
  qryCadBas.SQL.Add('  BAS_CODFML, BAS_CODBAS ');
  qryCadBas.Open;

  qryCadCol.SQL.Add('SELECT ');
  qryCadCol.SQL.Add('  FUT_CADCOL.*, ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    qryCadCol.SQL.Add('  COL_PRECUS AS ITE_PRECUS, ');
    qryCadCol.SQL.Add('  COL_PREVEN AS ITE_PREVEN ');
  End
  Else
  Begin
    qryCadCol.SQL.Add('  ITE_PRECUS, ');
    qryCadCol.SQL.Add('  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
  End;

  qryCadCol.SQL.Add('FROM ');
  qryCadCol.SQL.Add('  FUT_CADCOL ');
  qryCadCol.SQL.Add('JOIN ITEGER ON ITE_CODITE = COL_CODITE ');
  qryCadCol.SQL.Add('            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryCadCol.Open;

  qryCadFut.SQL.Add('SELECT * FROM FUT_CADFUT WHERE AUTOINCREM = -1');
  qryCadFut.Open;

  strCodEmp := VS_strCodEmp;

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM FUT_CADFUT');
    ExecSQL;
    Close;
  End;

  stlQtdCol := TStringList.Create;
  stlCodCol := TStringList.Create;

  strPathTxt := conf.fGet('PATFUT'); //fArqIniTinta(0, 'FUTURA', 'PATFUT', '');

  If (RightStr(strPathTxt, 1) = '\') Then
    strPathTxt := Copy(strPathTxt, 1, Length(strPathTxt)-1);

  If (Not FileExists(strPathTxt)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo: ' + strPathTxt, ['&Ok']);
    Result := False;
    Exit;
  End;

  intErro := 0;
  ilrFutura.strNomArq := strPathTxt;

  Try

    While (Not ilrFutura.Eof) Do
    Begin

      SetLength(arrForMul, 0);
      Application.ProcessMessages;

      stlQtdCol.Clear;
      stlCodCol.Clear;

      Inc(intErro);

      strCodPro := ilrFutura['CODPRO'];
      strCodFor := ilrFutura['CODFOR'];
      strCodBas := ilrFutura['CODBAS'];
      fltQtdEmb := ilrFutura['EMBALA'];

      For intColorante := 1 To 10 Do
      Begin

        strCodCol := ilrFutura['COL00' + IntToStr(intColorante)];
        strQtdCol := ilrFutura['QTD00' + IntToStr(intColorante)];

        If (fEmptyStr(strCodCol)) Then
          Break;

        stlCodCol.Add(strCodCol);
        stlQtdCol.Add(strQtdCol);

        intTamMat := Length(arrForMul);
        SetLength(arrForMul, intTamMat+1);
        arrForMul[intTamMat].strCodCol := strCodCol;
        arrForMul[intTamMat].fltQtdCol := fStrToFloat(strQtdCol);

      End;

      If (qryCadBas.Locate('BAS_CODFML;BAS_CODBAS', VarArrayOf([strCodPro, LeftStr(strCodBas, 1)]), [])) Then
      Begin

        fFuturaGravaCadFut(qryCadBas,
                           qryCadCol,
                           qryCadFut,
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
                           '');

      End;

      ilrFutura.Next;

    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  PRO_AUTINC = :AUTINC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = "FUT_CADFUT" ';

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
    strSQL := strSQL + '  FUT_CADNFM ';

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

end;

function fFuturaGravaCadFut(qryCadBas,
                            qryCadCol,
                            qryCadFut: TUniQuery;
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
                            arrForMul: TArrayFutForMul;
                            Var intAutInc: Integer;
                            strAutoIncrem: String): Boolean;
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
begin

  If blnDelExi Then
  Begin

    pDeletaNovaFormula(strCodFor,
                       qryCadBas.FieldByName('BAS_CODBAS').AsString,
                       qryCadBas.FieldByName('BAS_CODFML').AsString);

  End;

  fltQtdEmb := fFormataFloat(fltQtdEmb, 3);
  If (fltQtdEmb = fFormataFloat(0.81, 3)) Then
  Begin
    fltFatGal := 04;
    fltFatLat := 20;
    fltFatLit := 0.81 / 0.90;
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
    fltFatLit := 0.25;
  End
  Else If (fltQtdEmb = fFormataFloat(14.0, 3)) Then
  Begin
    fltFatGal := 00;
    fltFatLat := 01;
    fltFatLit := 00;
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

    qryCadCol.First;
    qryCadCol.Locate('COL_CODCOL', strCodCol, []);

    fltCusCol := fltCusCol + (fltQtdCol * 0.077) * (qryCadCol.FieldByName('ITE_PRECUS').AsFloat / 946);
    fltVenCol := fltVenCol + (fltQtdCol * 0.077) * (qryCadCol.FieldByName('ITE_PREVEN').AsFloat / 946);

  End;

  {*****************************************}
  {* PROCESSA CADBAS GRAVANDO TODAS AS     *}
  {* UNIDADES DO PRODUTO + BASE            *}
  {**************************************MV*}
  While (Not qryCadBas.Eof)                                        And
        (qryCadBas.FieldByName('BAS_CODFML').AsString = strCodPro) And
        (qryCadBas.FieldByName('BAS_CODBAS').AsString = strCodBas) Do
  Begin

    Application.ProcessMessages;

    If (Not blnGerNfm) Then
    Begin
      strDesIte := qryCadBas.FieldByName('BAS_DESCRI').AsString;
      strUnidad := qryCadBas.FieldByName('BAS_SIGUNI').AsString;
    End;

    fltPreCus := 0.0;
    fltPreVen := 0.0;

    fltCusUti := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
    fltVenUti := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;

    If (strUnidad = 'LT') Then
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
    {* GRAVA NO CADFUT                       *}
    {**************************************MV*}
    If (Not qryCadFut.Active) Then
      qryCadFut.Open;

    qryCadFut.Insert;

    If (intAutInc > 0) Then
      qryCadFut.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp)
    Else
      qryCadFut.FieldByName('AUTOINCREM').AsString := strAutoIncrem;

    qryCadFut.FieldByName('FUT_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
    qryCadFut.FieldByName('FUT_CODEMP').AsString := strCodEmp;
    qryCadFut.FieldByName('FUT_DESCRI').AsString := strDesIte;
    qryCadFut.FieldByName('FUT_REFERE').AsString := strCodFor + ' ' +
                                                    qryCadBas.FieldByName('BAS_CODBAS').AsString + ' ' +
                                                    qryCadBas.FieldByName('BAS_CODFML').AsString;
    qryCadFut.FieldByName('FUT_UNIDAD').AsString := strUnidad;
    qryCadFut.FieldByName('FUT_PREVEN').AsFloat  := fltPreVen;
    qryCadFut.FieldByName('FUT_PRECUS').AsFloat  := fltPreCus;

    If (fArqIniTinta(0, 'USA_FORMUL', 'FUT', 'S') = 'S') Then
    Begin

      For intContador := 1 To Length(arrForMul) Do
      Begin
        qryCadFut.FieldByName('FUT_FORM' + fStrZero(IntToStr(intContador), 2)).AsString := arrForMul[intContador-1].strCodCol;

        fltQtdGra := 0.0;
        If (strUnidad = 'LT') Then
          fltQtdGra := arrForMul[intContador-1].fltQtdCol * fltFatLit

        Else If (strUnidad = 'GL') Then
          fltQtdGra := arrForMul[intContador-1].fltQtdCol * fltFatGal

        Else If (strUnidad = 'LA') Then
          fltQtdGra := arrForMul[intContador-1].fltQtdCol * fltFatLat;

        qryCadFut.FieldByName('FUT_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat := fltQtdGra;
      End;

    End;

    fltFatPreCol := 1;
    If (strUnidad = 'LT') Then
      fltFatPreCol := fltFatLit
    Else If (strUnidad = 'GL') Then
      fltFatPreCol := fltFatGal
    Else If (strUnidad = 'LA') Then
      fltFatPreCol := fltFatLat;

    qryCadFut.FieldByName('FUT_COLCUS').AsFloat := fltCusCol * fltFatPreCol;
    qryCadFut.FieldByName('FUT_COLVEN').AsFloat := fltVenCol * fltFatPreCol;

    qryCadFut.Post;

    Inc(intAutInc);

    If (blnGerNfm) Then
      Break;

    qryCadBas.Next;
  End;

  Result := True;

end;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    strSQL      : String;
    intContador : Integer;
    strAutInc   : String;
    blnDelCadFut: Boolean;

    intTamMat: Integer;

    stlCodCol: TStringList;
    stlQtdCol: TStringList;
    arrForMul: TArrayFutForMul;

    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadFut: TUniQuery;
begin

  stlCodCol := TStringList.Create;
  stlQtdCol := TStringList.Create;

  qryCadBas := fCriaQuery;
  qryCadCol := fCriaQuery;
  qryCadFut := fCriaQuery;


  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FUT_CADBAS.*, ';

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    strSQL := strSQL + '  BAS_PRECUS AS ITE_PRECUS, ';
    strSQL := strSQL + '  BAS_PREVEN AS ITE_PREVEN, ';
  End
  Else
  Begin
    strSQL := strSQL + '  ITE_PRECUS, ';
    strSQL := strSQL + '  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN, ';
  End;

  strSQL := strSQL + '  UNI_SIGUNI AS BAS_SIGUNI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADBAS ';
  strSQL := strSQL + '  JOIN CADUNI ON UNI_CODUNI = BAS_CODUNI ';
  strSQL := strSQL + '  JOIN ITEGER ON ITE_CODITE = BAS_CODITE ';
  strSQL := strSQL + '              AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODFML = :CODFML AND ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS AND ';
  strSQL := strSQL + '  UNI_SIGUNI IN ("LT","GL","LA") ';

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
    ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FUT_CADCOL.*, ';

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    strSQL := strSQL + '  COL_PRECUS AS ITE_PRECUS, ';
    strSQL := strSQL + '  COL_PREVEN AS ITE_PREVEN ';
  End
  Else
  Begin
    strSQL := strSQL + '  ITE_PRECUS, ';
    strSQL := strSQL + '  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADCOL ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = COL_CODITE ';
  strSQL := strSQL + '            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  With qryCadCol Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  qryCadFut.SQL.Add('SELECT * FROM FUT_CADFUT WHERE AUTOINCREM = -1');
  qryCadFut.Open;

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

  blnDelCadFut := True;
  Result       := True;
  While not qryCadBas.Eof do
  Begin
    intContador := 0;
    strAutInc   := fRetAutoIncrem('FUT_CADFUT', VS_strCodEmp);

    Result := fFuturaGravaCadFut(qryCadBas,
                                 qryCadCol,
                                 qryCadFut,
                                 qryCadNfm.FieldByName('NFM_CODNFM').AsString,
                                 qryCadNfm.FieldByName('NFM_CODPRO').AsString,
                                 qryCadNfm.FieldByName('NFM_BASE__').AsString,
                                 VS_strCodEmp,
                                 0.810,
                                 stlQtdCol,
                                 stlCodCol,
                                 blnDelCadFut, //True,
                                 True,
                                 qryCadNfm.FieldByName('NFM_DESCRI').AsString,
                                 qryCadBas.FieldByName('BAS_SIGUNI').AsString,//qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                                 arrForMul,
                                 intContador,
                                 strAutInc);

    qryCadBas.Next;
    blnDelCadFut := False;
  End;
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadCol);

  FreeAndNil(stlCodCol);
  FreeAndNil(stlQtdCol);

end;

procedure pDeletaNovaFormula(strCodNfm : String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  FUT_CADFUT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FUT_REFERE = :REFERE ';

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

end.
