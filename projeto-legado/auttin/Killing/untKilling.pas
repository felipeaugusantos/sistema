unit untKilling;

interface

  uses SysUtils, Classes, Uni, StrUtils, Variants,
        Dialogs, Forms;

Type

  TKilForMul = Record
    strCodCol: String;
    fltQtdCol: Double;

End;

Type
  TArrayKilForMul = Array Of TKilForMul;

  function fKillingGeraArquivo: Boolean;

  function fKillingGravaCadKil(qryCadBas,
                               qryCadCol,
                               qryCadKil: TUniQuery;
                               strCodigo,
                               strCodBas,
                               strDesIte, 
                               strRefere,
                               strCorIte,
                               strUnidad,
                               strCodEmp: String;
                               blnDelExi,
                               blnGerNfm: Boolean;
                               arrForMul: TArrayKilForMul;
                               Var intAutInc: Integer;
                               strAutoIncrem: String): Boolean;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  procedure pDeletaNovaFormula(strCodigo: String);

implementation

uses DB, untInkLayoutReader, untFuncoes, untIConfTinta,
    untModuloTinta, untFuncTinta, untFuncoesSimples;

function fKillingGeraArquivo: Boolean;
  Var
    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadKil: TUniQuery;
    strPathTxt: String;
    strCodEmp: String;

    strCodigo: String;
    strCodBas: String;
    strDescri: String;
    strRefere: String;
    strCodCor: String;

    strCodCol: String;
    strQtdCol: String;

    intTamMat: Integer;
    intColorante: Integer;
    arrForMul: TArrayKilForMul;

    intAutInc: Integer;
    strSQL: String;
    intErro: Integer;

    ilrKilling: TInkLayoutReader;
    qryCadNfm: TUniQuery;
    conf: IConfTinta;
begin

  Result    := True;
  conf      := fGetConfTinta('KIL');
  intAutInc := 1;

  ilrKilling := TInkLayoutReader.Create;

  qryCadBas := fCriaQuery;
  qryCadCol := fCriaQuery;
  qryCadKil := fCriaQuery;
  qryCadNfm := fCriaQuery;

  qryCadBas.SQL.Add('SELECT ');
  qryCadBas.SQL.Add('  KIL_CADBAS.*, ');

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
  qryCadBas.SQL.Add('  KIL_CADBAS ');
  qryCadBas.SQL.Add('JOIN CADUNI ON UNI_CODUNI = BAS_CODUNI ');
  qryCadBas.SQL.Add('JOIN ITEGER ON ITE_CODITE = BAS_CODITE  ');
  qryCadBas.SQL.Add('            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryCadBas.SQL.Add('ORDER BY ');
  qryCadBas.SQL.Add('  BAS_CODFML, BAS_CODBAS');
  qryCadBas.Open;

  qryCadCol.SQL.Add('SELECT ');
  qryCadCol.SQL.Add('  KIL_CADCOL.*, ');

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
  qryCadCol.SQL.Add('  KIL_CADCOL');
  qryCadCol.SQL.Add('JOIN ITEGER ON ITE_CODITE = COL_CODITE ');
  qryCadCol.SQL.Add('            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryCadCol.Open;

  qryCadKil.SQL.Add('SELECT * FROM KIL_CADKIL WHERE AUTOINCREM = -1');
  qryCadKil.Open;

  strCodEmp := VS_strCodEmp;

  pZapTable('KIL_CADKIL');

  strPathTxt := conf.fGet('PATKIL'); //fArqIniTinta(0, 'KILLING', 'PATKIL', '');

  If (RightStr(strPathTxt, 1) = '\') Then
    strPathTxt := Copy(strPathTxt, 1, Length(strPathTxt)-1);

  If (Not FileExists(strPathTxt)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo: ' + strPathTxt, ['&Ok']);
    Result := False;
    Exit;
  End;

  intErro := 0;
  ilrKilling.strNomArq := strPathTxt;

  Try

    While (Not ilrKilling.Eof) Do
    Begin

      SetLength(arrForMul, 0);
      Application.ProcessMessages;

      Inc(intErro);

      strCodigo := AnsiUpperCase(ilrKilling['CODPRO']); // SEEK NO CADBAS
      strCodBas := AnsiUpperCase(ilrKilling['CODBAS']); // SEEK NO CADBAS
      strDescri := AnsiUpperCase(ilrKilling['DESCRI']);
      strRefere := AnsiUpperCase(ilrKilling['SUBCH1']);
      strCodCor := AnsiUpperCase(ilrKilling['CHAVE2']);

      For intColorante := 1 To 10 Do
      Begin

        strCodCol := ilrKilling['COL00' + IntToStr(intColorante)];
        strQtdCol := ilrKilling['QTD00' + IntToStr(intColorante)];

        If (fEmptyStr(strCodCol)) Then
          Break;

        intTamMat := Length(arrForMul);
        SetLength(arrForMul, intTamMat+1);
        arrForMul[intTamMat].strCodCol := strCodCol;
        arrForMul[intTamMat].fltQtdCol := fStrToFloat(strQtdCol);

      End;

      If (qryCadBas.Locate('BAS_CODFML;BAS_CODBAS', VarArrayOf([strCodigo, strCodBas]), [])) Then
      Begin

        fKillingGravaCadKil(qryCadBas,
                            qryCadCol,
                            qryCadKil,
                            strCodigo,
                            strCodBas,
                            strDescri,
                            strRefere,
                            strCodCor,
                            '',
                            strCodEmp,
                            False,
                            False,
                            arrForMul,
                            intAutInc,
                            '');

      End;

      ilrKilling.Next;

    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  PRO_AUTINC = :AUTINC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = "KIL_CADKIL" ';

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
    strSQL := strSQL + '  KIL_CADNFM ';

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

end;

function fKillingGravaCadKil(qryCadBas,
                             qryCadCol,
                             qryCadKil: TUniQuery;
                             strCodigo,
                             strCodBas,
                             strDesIte,
                             strRefere,
                             strCorIte,
                             strUnidad,
                             strCodEmp: String;
                             blnDelExi,
                             blnGerNfm: Boolean;
                             arrForMul: TArrayKilForMul;
                             Var intAutInc: Integer;
                             strAutoIncrem: String): Boolean;
  Var
    intContador: Integer;    
    fltFatLat: Double;
    fltFatGal: Double;
    fltCusCol: Double;
    fltVenCol: Double;

    fltQtdGra: Double;

    strCodCol: String;
    fltQtdCol: Double;

    fltCusUti: Double;
    fltVenUti: Double;
    fltPreCus: Double;
    fltPreVen: Double;

begin

  If blnDelExi Then
  Begin
    pDeletaNovaFormula(strRefere);
  End;

  fltCusCol := 0.0;
  fltVenCol := 0.0;
  {*****************************************}
  {* CALCULA PREÇO DO COLORANTE            *}
  {**************************************MV*}
  For intContador := 0 To Length(arrFormul) -1 Do
  Begin

    strCodCol := arrFormul[intContador].strCodCol;
    fltQtdCol := arrFormul[intContador].fltQtdCol;

    qryCadCol.First;
    qryCadCol.Locate('COL_CODCOL', strCodCol, []);

    fltCusCol := fltCusCol + fltQtdCol * (qryCadCol.FieldByName('ITE_PRECUS').AsFloat / 1000);
    fltVenCol := fltVenCol + fltQtdCol * (qryCadCol.FieldByName('ITE_PREVEN').AsFloat / 1000);

  End;

  fltFatGal := 04;
  fltFatLat := 18;

  {*****************************************}
  {* PROCESSA CADBAS GRAVANDO TODAS AS     *}
  {* UNIDADES DO PRODUTO + BASE            *}
  {**************************************MV*}
  While (Not qryCadBas.Eof)                                        And
        (qryCadBas.FieldByName('BAS_CODFML').AsString = strCodigo) And
        (qryCadBas.FieldByName('BAS_CODBAS').AsString = strCodBas) Do
  Begin

    Application.ProcessMessages;

    strUnidad := qryCadBas.FieldByName('BAS_SIGUNI').AsString;

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
    {* GRAVA NO CADKIL                       *}
    {**************************************MV*}
    If (Not qryCadKil.Active) Then
      qryCadKil.Open;

    qryCadKil.Insert;

    If (intAutInc > 0) Then
      qryCadKil.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intAutInc, VS_strCodEmp)
    Else
      qryCadKil.FieldByName('AUTOINCREM').AsString := strAutoIncrem;

    qryCadKil.FieldByName('KIL_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
    qryCadKil.FieldByName('KIL_CODEMP').AsString := strCodEmp;
    qryCadKil.FieldByName('KIL_DESCRI').AsString := strDesIte;
    qryCadKil.FieldByName('KIL_REFERE').AsString := strRefere;
    qryCadKil.FieldByName('KIL_CORITE').AsString := strCorIte;
    qryCadKil.FieldByName('KIL_UNIDAD').AsString := strUnidad;
    qryCadKil.FieldByName('KIL_PREVEN').AsFloat  := fltPreVen;
    qryCadKil.FieldByName('KIL_PRECUS').AsFloat  := fltPreCus;

    If (fArqIniTinta(0, 'USA_FORMUL', 'KIL', 'S') = 'S') Then
    Begin

      For intContador := 1 To Length(arrForMul) Do
      Begin
        qryCadKil.FieldByName('KIL_CODC' + fStrZero(IntToStr(intContador), 2)).AsString := arrForMul[intContador-1].strCodCol;

        fltQtdGra := 0.0;
        If (strUnidad = 'LT') Then
          fltQtdGra := arrForMul[intContador-1].fltQtdCol

        Else If (strUnidad = 'GL') Then
          fltQtdGra := arrForMul[intContador-1].fltQtdCol * fltFatGal

        Else If (strUnidad = 'LA') Then
          fltQtdGra := arrForMul[intContador-1].fltQtdCol * fltFatLat;

        qryCadKil.FieldByName('KIL_QTDC' + fStrZero(IntToStr(intContador), 2)).AsFloat := fltQtdGra;
      End;

    End;


    If (strUnidad = 'LT') Then
    Begin
      qryCadKil.FieldByName('KIL_COLCUS').AsFloat := fltCusCol;
      qryCadKil.FieldByName('KIL_COLVEN').AsFloat := fltVenCol;
    End
    Else If (strUnidad = 'GL') Then
    Begin
      qryCadKil.FieldByName('KIL_COLCUS').AsFloat := fltCusCol * fltFatGal;
      qryCadKil.FieldByName('KIL_COLVEN').AsFloat := fltVenCol * fltFatGal;
    End
    Else If (strUnidad = 'LA') Then
    Begin
      qryCadKil.FieldByName('KIL_COLCUS').AsFloat := fltCusCol * fltFatLat;
      qryCadKil.FieldByName('KIL_COLVEN').AsFloat := fltVenCol * fltFatLat;
    End;

    qryCadKil.Post;

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
    blnDelCadKil: Boolean;

    intTamMat: Integer;
    arrForMul: TArrayKilForMul;

    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadKil: TUniQuery;
begin

  qryCadBas := fCriaQuery;
  qryCadCol := fCriaQuery;
  qryCadKil := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  KIL_CADBAS.*, ';

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
  strSQL := strSQL + '  KIL_CADBAS ';
  strSQL := strSQL + 'JOIN CADUNI ON UNI_CODUNI = BAS_CODUNI ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = BAS_CODITE ';
  strSQL := strSQL + '            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
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
  strSQL := strSQL + '  KIL_CADCOL.*, ';

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
  strSQL := strSQL + '  KIL_CADCOL ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = COL_CODITE ';
  strSQL := strSQL + '            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  With qryCadCol Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  qryCadKil.SQL.Add('SELECT * FROM KIL_CADKIL WHERE AUTOINCREM = -1');
  qryCadKil.Open;

  For intContador := 1 To 10 Do
  Begin

    If (fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intContador, 2)).AsString)) Then
    Begin
      Break;
    End;

    intTamMat := Length(arrForMul);

    SetLength(arrFormul, intTamMat+1);
    arrForMul[intTamMat].strCodCol := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intContador, 2)).AsString;
    arrForMul[intTamMat].fltQtdCol := qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsFloat;

  End;

  blnDelCadKil := True;
  Result       := True;

  While not qryCadBas.Eof do
  Begin
    intContador := 0;
    strAutInc   := fRetAutoIncrem('KIL_CADKIL', VS_strCodEmp);

    Result := fKillingGravaCadKil(qryCadBas,
                                  qryCadCol,
                                  qryCadKil,
                                  qryCadNfm.FieldByName('NFM_CODPRO').AsString,
                                  qryCadNfm.FieldByName('NFM_BASE__').AsString,
                                  qryCadNfm.FieldByName('NFM_DESCRI').AsString,
                                  qryCadNfm.FieldByName('NFM_CODNFM').AsString,
                                  '',
                                  '',
                                  VS_strCodEmp,
                                  blnDelCadKil, //True,
                                  True,
                                  arrForMul,
                                  intContador,
                                  strAutInc);

    qryCadBas.Next;
    blnDelCadKil := False;
  End;

  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadCol);

end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  KIL_CADKIL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  KIL_REFERE = :REFERE ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('REFERE').AsString := strCodigo;
    ExecSQL;
    Close;
  End;
end;

end.
