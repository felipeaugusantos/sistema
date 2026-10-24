unit untRennerImobiliaria;

interface

uses SysUtils, Classes, Uni, Forms, Variants, StrUtils, Dialogs;

Type
  TColorantes = Record
    strUnidad: String;
    strCodPig: String;
    fltTotUni: Double;
  End;

Type
  TValUni = Record
    strUnidad: String;
    fltTotCus: Double;
    fltTotVen: Double;
  End;

Type TArrayColorantes = Array Of TColorantes;
Type TArrayValUni = Array Of TValUni;

  function fGravaCadRei(strCodSeq,
                        strDesCri,
                        strRefEre,
                        strUniDad: String;
                        fltPreCus,
                        fltPreVen: Double;
                        strCodIte,
                        strDesCor,
                        strCodPro,
                        strCodBas,
                        strCodEmp: String): Boolean;

  function fGravaFmlRei(intOpcao: Integer;
                        strCodPro,
                        strCodBas,
                        strCodCol,
                        strUniDad: String;
                        fltQtd_01,
                        fltQtd_02,
                        fltQtd_03: Double;
                        strCodEmp,
                        strAutInc: String;
                        Var strValores: String): Boolean;

  function fRennerImobGeraArquivo: Boolean;

  function fGravaArquivos(Var intCodSeq: Integer; qryCadBas, qryCadCol: TUniQuery;
    strCodBas, strCodPro: String; arrMatCol: TArrayColorantes): Boolean;

  function fPosicionaBase(qryCadBas: TUniQuery; strCodBas, strCodUni: String): Boolean;
  function fPosicionaColorante(qryCadCol: TUniQuery; strCodCol: String): Boolean;
  function fRetornaDesCor(strCodPro: String): String;


implementation

uses   untFuncoes, DB, untModuloTinta,
  untFuncoesSimples, untIConfTinta, untFuncTinta;

function fGravaCadRei(strCodSeq,
                      strDesCri,
                      strRefEre,
                      strUniDad: String;
                      fltPreCus,
                      fltPreVen: Double;
                      strCodIte,
                      strDesCor,
                      strCodPro,
                      strCodBas,
                      strCodEmp: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'INSERT DELAYED INTO REI_CADREI ( ';
  strSQL := strSQL + '  REI_CODSEQ, ';
  strSQL := strSQL + '  REI_DESCRI, ';
  strSQL := strSQL + '  REI_REFERE, ';
  strSQL := strSQL + '  REI_UNIDAD, ';
  strSQL := strSQL + '  REI_PRECUS, ';
  strSQL := strSQL + '  REI_PREVEN, ';
  strSQL := strSQL + '  REI_CODITE, ';
  strSQL := strSQL + '  REI_DESCOR, ';
  strSQL := strSQL + '  REI_CODPRO, ';
  strSQL := strSQL + '  REI_CODBAS, ';
  strSQL := strSQL + '  REI_CODEMP, ';
  strSQL := strSQL + '  AUTOINCREM ) ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :CODSEQ, ';
  strSQL := strSQL + '  :DESCRI, ';
  strSQL := strSQL + '  :REFERE, ';
  strSQL := strSQL + '  :UNIDAD, ';
  strSQL := strSQL + '  :PRECUS, ';
  strSQL := strSQL + '  :PREVEN, ';
  strSQL := strSQL + '  :CODITE, ';
  strSQL := strSQL + '  :DESCOR, ';
  strSQL := strSQL + '  :CODPRO, ';
  strSQL := strSQL + '  :CODBAS, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :AUTINC ) ';

  Try

    With frmModuloTinta.qryGen001 Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODSEQ').AsString := strCodSeq;
      ParamByName('DESCRI').AsString := strDesCri;
      ParamByName('REFERE').AsString := strRefEre;
      ParamByName('UNIDAD').AsString := strUniDad;
      ParamByName('PRECUS').AsFloat  := fltPreCus;
      ParamByName('PREVEN').AsFloat  := fltPreVen;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('DESCOR').AsString := strDesCor;
      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODBAS').AsString := strCodBas;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('AUTINC').AsString := fFormataAutInc(StrToInt(strCodSeq), strCodEmp);
      ExecSQL;
      Close;

    End;
    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaCadRei]');
    End;
  End;


end;

function fGravaFmlRei(intOpcao: Integer;
                      strCodPro,
                      strCodBas,
                      strCodCol,
                      strUniDad: String;
                      fltQtd_01,
                      fltQtd_02,
                      fltQtd_03: Double;
                      strCodEmp,
                      strAutInc: String;
                      Var strValores: String): Boolean;
  Var
    strSQL: String;
begin

  Try

    If (intOpcao = 1) Then
    Begin

      strValores := strValores + '(';
      strValores := strValores + QuotedStr(strCodPro) + ', ';
      strValores := strValores + QuotedStr(strCodBas) + ', ';
      strValores := strValores + QuotedStr(strCodCol) + ', ';
      strValores := strValores + QuotedStr(strUniDad) + ', ';
      strValores := strValores + AnsiReplaceStr(FloatToStr(fltQtd_01), ',', '.') + ', ';
      strValores := strValores + AnsiReplaceStr(FloatToStr(fltQtd_02), ',', '.') + ', ';
      strValores := strValores + AnsiReplaceStr(FloatToStr(fltQtd_02), ',', '.') + ', ';
      strValores := strValores + QuotedStr(strCodEmp) + ', ';
      strValores := strValores + QuotedStr(strAutInc) + ') ';

    End
    Else
    Begin

      strSQL := '';
      strSQL := strSQL + 'INSERT DELAYED INTO REI_FMLREI ( ';
      strSQL := strSQL + '	FRI_CODPRO, ';
      strSQL := strSQL + '	FRI_CODBAS, ';
      strSQL := strSQL + '	FRI_CODCOL, ';
      strSQL := strSQL + '	FRI_UNIDAD, ';
      strSQL := strSQL + '	FRI_QTD_01, ';
      strSQL := strSQL + '	FRI_QTD_02, ';
      strSQL := strSQL + '	FRI_QTD_03, ';
      strSQL := strSQL + '	FRI_CODEMP, ';
      strSQL := strSQL + '	AUTOINCREM ) ';
      strSQL := strSQL + 'VALUES ' + strValores;
      strSQL := AnsiReplaceStr(strSQL, #9, '');
      strSQL := AnsiReplaceStr(strSQL, #13#10, '');

      strSQL := Trim(strSQL);
      If (RightStr(strSQL, 1) = ',') Then
        strSQL := Copy(strSQL, 1, Length(strSQL)-1);

      With frmModuloTinta.qryGen001 Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;

    End;

    Result := True;
  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaFmlRei]');
    End;

  End;

end;

function fRennerImobGeraArquivo: Boolean;
  Var
    strPatTxt: String;
    stlArqTxt: TStringList;
    intContador: Integer;
    intContador2: Integer;
    strLinha: String;

    strCodBas: String;
    strCodPro: String;

    strCodBasAtu: String;
    strCodProAtu: String;

    strSigUni: String;
    strCodPig: String;
    intQtdCo1: Integer;
    intQtdCo2: Integer;
    intQtdCo3: Integer;
    fltTotUni: Double;

    intSeqFml: Integer;

    arrMatCol: TArrayColorantes;

    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    intCodSeq: Integer;

    strSQL: String;
    strValores: String;
    conf: IConfTinta;
begin
  conf      := fGetConfTinta('REI');
  intSeqFml := 0;
  intCodSeq := 0;

  strPatTxt := conf.fGet('TXTREI'); //fArqIniTinta(0, 'RENNER IMOBILIÁRIA', 'TXTREI', '');

  If (Not FileExists(strPatTxt)) Then
  Begin
    Result := False;
    fMensagem('', 'Não encontrei o arquivo ' + strPatTxt + '.' + #13#10 + 'Verifique!', ['&Ok']);
    Exit;
  End;

  qryCadBas := fCriaQuery;
  qryCadCol := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  REI_CADBAS.*, ';
  strSQL := strSQL + '  UNI_SIGUNI AS BAS_SIGUNI, ';

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    strSQL := strSQL + '  BAS_PRECUS AS ITE_PRECUS, ';
    strSQL := strSQL + '  BAS_PREVEN AS ITE_PREVEN ';
  End
  Else
  Begin
    strSQL := strSQL + '  ITE_PRECUS, ';
    strSQL := strSQL + '  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  REI_CADBAS ';
  strSQL := strSQL + 'JOIN CADUNI ON UNI_CODUNI = BAS_UNIDAD ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = BAS_CODITE ';
  strSQL := strSQL + '            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  REI_CADCOL.*, ';

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
  strSQL := strSQL + '  REI_CADCOL ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = COL_CODITE  ';
  strSQL := strSQL + '            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  With qryCadCol Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  stlArqTxt := TStringList.Create;
  stlArqTxt.LoadFromFile(strPatTxt);

  pZapTable('REI_CADREI');
  pZapTable('REI_FMLREI');

  intContador := 0;
  strLinha := stlArqTxt[intContador];
  While (intContador < stlArqTxt.Count) Do
  Begin

    strCodBas := fGetValorLinha(strLinha, ';', 3);
    strCodPro := fGetValorLinha(strLinha, ';', 1);
    SetLength(arrMatCol, 0);

    strValores := '';
    strCodPig := fGetValorLinha(strLinha, ';', 2);

    Repeat

      For intContador2 := 1 To 3 Do
      Begin

        strSigUni := '';
        intQtdCo1 := 0;
        intQtdCo2 := 0;
        intQtdCo3 := 0;

        If (intContador2 = 1) Then
        Begin
          strSigUni := 'LT';
          intQtdCo1 := StrToInt(fGetValorLinha(strLinha, ';', 4));
          intQtdCo2 := StrToInt(fGetValorLinha(strLinha, ';', 5));
          intQtdCo3 := StrToInt(fGetValorLinha(strLinha, ';', 6));
        End

        Else If (intContador2 = 2) Then
        Begin
          strSigUni := 'GL';
          intQtdCo1 := StrToInt(fGetValorLinha(strLinha, ';', 7));
          intQtdCo2 := StrToInt(fGetValorLinha(strLinha, ';', 8));
          intQtdCo3 := StrToInt(fGetValorLinha(strLinha, ';', 9));
        End

        Else If (intContador2 = 3) Then
        Begin
          strSigUni := 'LA';
          intQtdCo1 := StrToInt(fGetValorLinha(strLinha, ';', 10));
          intQtdCo2 := StrToInt(fGetValorLinha(strLinha, ';', 11));
          intQtdCo3 := StrToInt(fGetValorLinha(strLinha, ';', 12));
        End;

        fltTotUni := intQtdCo1 + ((intQtdCo2 * 2) / 48) + ((intQtdCo3 * 3) / 96);

        If (fFormataFloat(fltTotUni, 2) = fFormataFloat(0.0, 22)) Then
          Continue;

        If (Not fEmptyStr(strValores)) Then
          strValores := strValores + ', ';

        SetLength(arrMatCol, Length(arrMatCol)+1);
        arrMatCol[Length(arrMatCol)-1].strUnidad := strSigUni;
        arrMatCol[Length(arrMatCol)-1].strCodPig := strCodPig;
        arrMatCol[Length(arrMatCol)-1].fltTotUni := fltTotUni;

        If (Not fGravaFmlRei(1,
                             strCodPro,
                             strCodBas,
                             strCodPig,
                             strSigUni,
                             intQtdCo1,
                             intQtdCo2,
                             intQtdCo3,
                             VS_strCodEmp,
                             fFormataAutInc(intSeqFml, VS_strCodEmp),
                             strValores)) Then
        Begin
          Result := False;
          Exit;
        End;

        Inc(intSeqFml);

      End;

      Inc(intContador);

      If (intContador >= stlArqTxt.Count) Then
        Break;

      strLinha := stlArqTxt[intContador];
      strCodBasAtu := fGetValorLinha(strLinha, ';', 3);
      strCodProAtu := fGetValorLinha(strLinha, ';', 1);

    Until ((strCodBas <> strCodBasAtu) Or (strCodPro <> strCodProAtu));

    strValores := AnsiReplaceStr(strValores, #13#10, '');
    strValores := Trim(strValores);
    If (RightStr(strValores, 1) = ',') Then
      strValores := Copy(strValores, 1, Length(strValores)-1);

    If (Not fEmptyStr(strValores)) Then
    Begin

      If (Not fGravaFmlRei(2,
                           strCodPro,
                           strCodBas,
                           strCodPig,
                           strSigUni,
                           intQtdCo1,
                           intQtdCo2,
                           intQtdCo3,
                           VS_strCodEmp,
                           fFormataAutInc(intSeqFml, VS_strCodEmp),
                           strValores)) Then
      Begin
        Result := False;
        Exit;
      End;

    End;

    If (Length(arrMatCol) > 0) Then
      fGravaArquivos(intCodSeq, qryCadBas, qryCadCol, strCodBas, strCodPro, arrMatCol);



    Application.ProcessMessages;

  End;

  FreeAndNil(stlArqTxt);
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadCol);

  Result := True;

end;

function fGravaArquivos(Var intCodSeq: Integer; qryCadBas, qryCadCol: TUniQuery;
  strCodBas, strCodPro: String; arrMatCol: TArrayColorantes): Boolean;
  Var
   strUnidad: String;
   strCodCol: String;
   fltQtdCol: Double;

   arrValUni: TArrayValUni;
   intContador: Integer;
   intContPesq: Integer;

   fltCusCol: Double;
   fltVenCol: Double;

   fltPreCus: Double;
   fltPreVen: Double;
   strDesCor: String;

begin

  If (Not fPosicionaBase(qryCadBas, strCodBas, '')) Then
  Begin
    Result := False;
    Exit;
  End;

  SetLength(arrValUni, 0);

  For intContador := 0 To Length(arrMatCol) -1 Do
  Begin

    strUnidad := arrMatCol[intContador].strUnidad;
    strCodCol := arrMatCol[intContador].strCodPig;
    fltQtdCol := arrMatCol[intContador].fltTotUni;

    If (fEmptyStr(strCodCol)) Then
    Begin
      Continue;
    End;

    If (Not fPosicionaColorante(qryCadCol, strCodCol)) Then
      Continue;

    fltCusCol := (fltQtdCol * 33.82) * (qryCadCol.FieldByName('ITE_PRECUS').AsFloat / 1000.0);
    fltVenCol := (fltQtdCol * 33.82) * (qryCadCol.FieldByName('ITE_PREVEN').AsFloat / 1000.0);

    For intContPesq := 0 To Length(arrValUni) -1 Do
    Begin
      If (strUnidad = arrValUni[intContPesq].strUnidad) Then
        Break;

    End;

    If (intContPesq = Length(arrValUni)) Then
    Begin
      SetLength(arrValUni, Length(arrValUni)+1);
      arrValUni[Length(arrValUni)-1].strUnidad := strUnidad;
      arrValUni[Length(arrValUni)-1].fltTotCus := fltCusCol;
      arrValUni[Length(arrValUni)-1].fltTotVen := fltVenCol;
    End
    Else
    Begin
      arrValUni[intContPesq].fltTotCus := arrValUni[intContPesq].fltTotCus + fltCusCol;
      arrValUni[intContPesq].fltTotVen := arrValUni[intContPesq].fltTotVen + fltVenCol;
    End;

  End;

  For intContador := 0 To Length(arrValUni) -1 Do
  Begin
    If (Not fPosicionaBase(qryCadBas, strCodBas, arrValUni[intContador].strUnidad)) Then
    Begin
      Continue;
    End;

    fltPreCus := qryCadBas.FieldByName('ITE_PRECUS').AsFloat + arrValUni[intContador].fltTotCus;
    fltPreVen := qryCadBas.FieldByName('ITE_PREVEN').AsFloat + arrValUni[intContador].fltTotVen;

    strDesCor := fRetornaDesCor(strCodPro);

    If (Not fGravaCadRei(fStrZero(intCodSeq, 6),
                         qryCadBas.FieldByName('BAS_DESCRI').AsString + ' ' + strCodPro,
                         strCodPro + ' ' + qryCadBas.FieldByName('BAS_CODBAS').AsString + ' ' + arrValUni[intContador].strUnidad,
                         arrValUni[intContador].strUnidad,
                         fltPreCus,
                         fltPreVen,
                         qryCadBas.FieldByName('BAS_CODITE').AsString,
                         strDesCor,
                         strCodPro,
                         strCodBas,
                         VS_strCodEmp)) Then
    Begin
      Result := False;
      Exit;
    End;

    Inc(intCodSeq);

  End;

  Result := True;

end;

function fPosicionaBase(qryCadBas: TUniQuery; strCodBas, strCodUni: String): Boolean;
begin

  If (fEmptyStr(strCodUni)) Then
    Result := qryCadBas.Locate('BAS_CODBAS', strCodBas, [])
  Else
    Result := qryCadBas.Locate('BAS_CODBAS;BAS_SIGUNI', VarArrayOf([strCodBas, strCodUni]), []);

end;

function fPosicionaColorante(qryCadCol: TUniQuery; strCodCol: String): Boolean;
begin

  Result := qryCadCol.Locate('COL_CODCOL', strCodCol, []);

end;

function fRetornaDesCor(strCodPro: String): String;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COR_DESCRI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  REI_CADCOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COR_CODPRO = :CODPRO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPRO').AsString := strCodPro;
    Open;
    Result := Fields[0].AsString;
    Close;
  End;

end;

end.

