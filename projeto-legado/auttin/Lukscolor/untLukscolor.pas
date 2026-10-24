unit untLukscolor;

interface

  uses SysUtils, Classes, Uni, StrUtils, Variants,
       Dialogs, Forms;

Type

  TLksForMul = Record
    strCodCol: String;
    fltQtdCol: Double;

End;

Type
  TArrayLksForMul = Array Of TLksForMul;

  function fGeraArqCol(strNomArq: String; Var stlColCad: TStringList): Boolean;
  function fGeraArqBas(strNomArq: String; Var stlBasCad: TStringList): Boolean;

  function fCadastraColorante(strCodCol: String): Boolean;
  function fCadastraBase(strCodBas, strCodPro, strDesBas: String): Boolean;

  function fLukscolorGeraArquivo(Var stlColCad, stlBasCad, stlTintasNaoGer: TStringList;
      Var strMensagem: String): Boolean;

  function fLukscolorGravaCadLks(qryCadBas,
                                 qryCadCol: TUniQuery;
                                 strDescri,
                                 strRefere,
                                 strCodBas,
                                 strCodPro,
                                 strCodEmp: String;
                                 stlQtdCol,
                                 stlCodCol: TStringList;
                                 blnDelExi: Boolean;
                                 blnGerNfm: Boolean;
                                 arrForMul: TArrayLksForMul;
                                 Var intAutInc: Integer): Boolean;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;

  procedure pDeletaNovaFormula(strRefere: String);

  function fLukscolorImportaCorOB(): Boolean;

  function fprocessaTagsCorOB(Texto: String): String;

  procedure pDeletarLinhasStringList(var StringList: TStringList; nLinhas: Integer);

  procedure fProcessa(StringList: TStringList; Prefixo: String);

  function fProximoCodSeq: String;

implementation

uses DB,  untFuncoesSimples, untModulo,
     untModuloTinta, untFuncoes, untFuncTinta, untIConfTinta;

function fGeraArqCol(strNomArq: String; Var stlColCad: TStringList): Boolean;
  Var
    arqTxtCol: TextFile;
    strSQL: String;

    strLinha: String;
    strCodCol: String;
    strDesCol: String;
begin

  Result := True;

  AssignFile(arqTxtCol, strNomArq);
  Reset(arqTxtCol);

  While (Not Eof(arqTxtCol)) Do
  Begin

    ReadLn(arqTxtCol, strLinha);
    strCodCol := Copy(strLinha, 01, 02);
    strDesCol := Trim(Copy(strLinha, 04, 40));

    With frmModuloTinta.qryGen001 Do
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  LKS_CADCOL ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  COL_CODCOL = :CODCOL ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCOL').AsString := strCodCol;
      Open;
      If (IsEmpty) Then
      Begin
        Result := False;
      End;
      Close;

    End;

    If (Not Result) Then
    Begin
      fCadastraColorante(strCodCol);
      stlColCad.Add(strCodCol + ' - ' + strDesCol);
    End;

  End;

  CloseFile(arqTxtCol);

end;

function fGeraArqBas(strNomArq: String; Var stlBasCad: TStringList): Boolean;
  Var
    arqTxtBas: TextFile;
    strSQL: String;

    strLinha: String;
    strCodBas: String;
    strCodPro: String;
    strDesBas: String;
begin

  Result := True;

  AssignFile(arqTxtBas, strNomArq);
  Reset(arqTxtBas);

  While (Not Eof(arqTxtBas)) Do
  Begin

    ReadLn(arqTxtBas, strLinha);
    strCodBas := Copy(strLinha, 01, 02);
    strCodPro := Copy(strLinha, 04, 02);
    strDesBas := Trim(Copy(strLinha, 07, 40));

    With frmModuloTinta.qryGen001 Do
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  LKS_CADBAS ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  BAS_CODBAS = :CODBAS AND ';
      strSQL := strSQL + '  BAS_CODPRO = :CODPRO ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBAS').AsString := strCodBas;
      ParamByName('CODPRO').AsString := strCodPro;
      Open;
      If (IsEmpty) Then
      Begin
        Result := False;
      End;
      Close;

    End;

    If (Not Result) Then
    Begin
      fCadastraBase(strCodBas, strCodPro, strDesBas);
      stlBasCad.Add(strCodBas + ' - ' + strCodPro + ' - ' + strDesBas);
    End;

  End;

  CloseFile(arqTxtBas);

end;

function fCadastraColorante(strCodCol: String): Boolean;
  Var
    strSQL: String;
    qryGen002: TUniQuery;
begin

  Try

    qryGen002 := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'INSERT DELAYED INTO LKS_CADCOL ';
    strSQL := strSQL + '( ';
    strSQL := strSQL + '  COL_CODCOL, ';
    strSQL := strSQL + '  COL_CODEMP, ';
    strSQL := strSQL + '  AUTOINCREM) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :CODCOL, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :AUTINC) ';

    With qryGen002 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCOL').AsString := strCodCol;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('AUTINC').AsString := fRetAutoIncrem('LKS_CADCOL', VS_strCodEmp);
      ExecSQL;
      Close;
    End;
    Result := True;

    FreeAndNil(qryGen002);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCadastraColorante]');
    End;
  End;

end;

function fCadastraBase(strCodBas, strCodPro, strDesBas: String): Boolean;
  Const
    arrUnidades: Array[1..3] Of String = ('LT', 'GL', 'LA');
  Var
    strSQL: String;
    intContador: Integer;
    qryGen002: TUniQuery;
begin

  qryGen002 := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'INSERT DELAYED INTO LKS_CADBAS ';
  strSQL := strSQL + '( ';
  strSQL := strSQL + '  BAS_CODBAS, ';
  strSQL := strSQL + '  BAS_CODPRO, ';
  strSQL := strSQL + '  BAS_DESCRI, ';
  strSQL := strSQL + '  BAS_CODEMP, ';
  strSQL := strSQL + '  BAS_UNIDAD, ';
  strSQL := strSQL + '  AUTOINCREM) ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :CODBAS, ';
  strSQL := strSQL + '  :CODPRO, ';
  strSQL := strSQL + '  :DESCRI, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :UNIDAD, ';
  strSQL := strSQL + '  :AUTINC) ';

  Try

    For intContador := Low(arrUnidades) To High(arrUnidades) Do
    Begin

      With qryGen002 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBAS').AsString := strCodBas;
        ParamByName('CODPRO').AsString := strCodPro;
        ParamByName('DESCRI').AsString := AnsiUpperCase(strDesBas);
        ParamByName('UNIDAD').AsString := arrUnidades[intContador];
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('AUTINC').AsString := fRetAutoIncrem('LKS_CADBAS', VS_strCodEmp);
        ExecSQL;
        Close;
      End;

    End;
    Result := True;

    FreeAndNil(qryGen002);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCadastraBase]');
    End;
  End;

end;

function fLukscolorGeraArquivo(Var stlColCad, stlBasCad, stlTintasNaoGer: TStringList;
    Var strMensagem: String): Boolean;
  Var
    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    stlQtdCol: TStringList;
    stlCodCol: TStringlist;
    arqLukscolor: TextFile;
    strPathTxt: String;
    strArqCol: String;
    strArqBas: String;
    strArqLks: String;
    strLinha: String;
    strCodEmp: String;

    strCodBas: String;
    strCodPro: String;
    strDescri: String;
    strRefere: String;
    strCodCor: String;

    strCodCol: String;
    strQtdCol: String;

    intTamMat: Integer;
    intColRefere: Integer;
    intContador: Integer;
    arrForMul: TArrayLksForMul;

    blnNovosCol: Boolean;
    blnNovasBas: Boolean;

    intAutInc: Integer;
    strSQL: String;
    qryCadNfm: TUniQuery;
begin

  Result    := True;
  intAutInc := 1;

  strMensagem := '';

  strCodEmp := VS_strCodEmp;

  pZapTable('LKS_CADLKS');

  qryCadNfm := fCriaQuery(Nil);

  frmModuloTinta.qryLks_CadLks.Open;

  stlQtdCol := TStringList.Create;
  stlCodCol := TStringList.Create;

  stlColCad.Clear;
  stlBasCad.Clear;
  stlTintasNaoGer.Clear;

  stlColCad.Sorted       := True;
  stlBasCad.Sorted       := True;
  stlTintasNaoGer.Sorted := True;

  stlColCad.Duplicates       := dupIgnore;
  stlBasCad.Duplicates       := dupIgnore;
  stlTintasNaoGer.Duplicates := dupIgnore;

  strPathTxt := fGetConfTinta('LKS').fGet('PATLKS');

  strArqCol  := strPathTxt + '\coranteslks.txt';
  strArqBas  := strPathTxt + '\baseslks.txt';
  strArqLks  := strPathTxt + '\formulaslks.txt';

  If (Not FileExists(strArqCol)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo: ' + strArqCol, ['&Ok']);
    Result := False;
    Exit;
  End;

  If (Not FileExists(strArqBas)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo: ' + strArqBas, ['&Ok']);
    Result := False;
    Exit;
  End;

  If (Not FileExists(strArqLks)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo: ' + strArqLks, ['&Ok']);
    Result := False;
    Exit;
  End;

  {*******************************************}
  {* GERA ARQUIVO DE COLORANTES              *}
  {****************************************MV*}
  blnNovosCol := fGeraArqCol(strArqCol, stlColCad);

  {*******************************************}
  {* GERA ARQUIVO DE BASES                   *}
  {****************************************MV*}
  blnNovasBas := fGeraArqBas(strArqBas, stlBasCad);

  If (Not blnNovosCol) Or (Not blnNovasBas) Then
  Begin

    strMensagem := 'Atenção foram cadastrados algumas bases e/ou alguns colorantes.' + #13#10 +
                   'Para que a geração do arquivo ocorra corretamente, é necessário ajustar os ' +
                   'preços dos mesmos.';

    Result := False;
    Exit;
  End;

  qryCadBas := TUniQuery.Create(Nil);
  qryCadCol := TUniQuery.Create(Nil);

  qryCadBas.Connection := frmModulo.Database;
  qryCadCol.Connection := frmModulo.Database;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LKS_CADBAS.*, ';
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
  strSQL := strSQL + '  LKS_CADBAS, ';
  strSQL := strSQL + '  ITEGER, ';
  strSQL := strSQL + '  CADUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_UNIDAD = UNI_CODUNI AND ';
  strSQL := strSQL + '  BAS_CODITE = ITE_CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

  qryCadBas.Close;
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(strSQL);
  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadBas.Open;

  qryCadCol.SQL.Add('SELECT                                                                                      ');
  qryCadCol.SQL.Add('  LKS_CADCOL.*,                                                                             ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    qryCadCol.SQL.Add('  COL_PRECUS AS ITE_PRECUS,                                                               ');
    qryCadCol.SQL.Add('  COL_PREVEN AS ITE_PREVEN                                                                ');
  End
  Else
  Begin
    qryCadCol.SQL.Add('  ITEGER.ITE_PRECUS,                                                                      ');
    qryCadCol.SQL.Add('  ITEGER.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
  End;

  qryCadCol.SQL.Add('FROM                                                                                        ');
  qryCadCol.SQL.Add('  LKS_CADCOL                                                                                ');
  qryCadCol.SQL.Add('JOIN ITEGER ON ITE_CODITE = COL_CODITE                                                      ');
  qryCadCol.SQL.Add('            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
  qryCadCol.Open;

  AssignFile(arqLukscolor, strArqLks);
  Reset(arqLukscolor);

  Try

    While (Not Eof(arqLukscolor)) Do
    Begin

      SetLength(arrForMul, 0);
      Application.ProcessMessages;

      stlQtdCol.Clear;
      stlCodCol.Clear;

      ReadLn(arqLukscolor, strLinha);

      If (fEmptyStr(strLinha)) Then
      Begin
        Continue;
      End;

      strRefere := Trim(fGetValorLinha(strLinha, ';', 1));
      strCodCor := Trim(fGetValorLinha(strLinha, ';', 6));
      strDescri := AnsiUpperCase(strCodCor + ' ' + Trim(fGetValorLinha(strLinha, ';', 3))); 
      strCodBas := Trim(fGetValorLinha(strLinha, ';', 4));
      strCodPro := Trim(fGetValorLinha(strLinha, ';', 2));

      intColRefere := 7;
      intContador  := 0;

      Repeat

        strCodCol := Trim(fGetValorLinha(strLinha, ';', (intColRefere + intContador)));
        Inc(intContador);

        strQtdCol := Trim(fGetValorLinha(strLinha, ';', (intColRefere + intContador)));
        Inc(intContador);

        If (fEmptyStr(strCodCol)) Then
          Break;

        stlCodCol.Add(strCodCol);
        stlQtdCol.Add(strQtdCol);

        intTamMat := Length(arrForMul);
        SetLength(arrForMul, intTamMat+1);
        arrForMul[intTamMat].strCodCol := strCodCol;
        arrForMul[intTamMat].fltQtdCol := fFormataFloat(fStrToFloat(stlQtdCol[stlQtdCol.Count-1]) / 100, 02);

      Until (False);

      If (qryCadBas.Locate('BAS_CODBAS;BAS_CODPRO', VarArrayOf([strCodBas, strCodPro]), [])) Then
      Begin

        fLukscolorGravaCadLks(qryCadBas,
                              qryCadCol,
                              strDescri,
                              strRefere,
                              strCodBas,
                              strCodPro,
                              strCodEmp,
                              stlQtdCol,
                              stlCodCol,
                              False,
                              False,
                              arrForMul,
                              intAutInc);
      End
      Else
      Begin
        stlTintasNaoGer.Add(strRefere + ' - ' + strDescri);
      End;

    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  PRO_AUTINC = :AUTINC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = "LKS_CADLKS" ';

    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsInteger := intAutInc;
      ExecSQL;
      Close;
    End;

    {*******************************************}
    {* PROCESSA CADASTRO DE NOVAS FORUMULAS    *}
    {****************************************MV*}
    With qryCadNfm Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM LKS_CADNFM');
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
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
      Result := False;
    End;
  End;

  FreeAndNil(stlCodCol);
  FreeAndNil(stlQtdCol);



end;

function fLukscolorGravaCadLks(qryCadBas,
                               qryCadCol: TUniQuery;
                               strDescri,
                               strRefere,
                               strCodBas,
                               strCodPro,
                               strCodEmp: String;
                               stlQtdCol,
                               stlCodCol: TStringList;
                               blnDelExi: Boolean;
                               blnGerNfm: Boolean;
                               arrForMul: TArrayLksForMul;
                               Var intAutInc: Integer): Boolean;
  Var
    intContador: Integer;
    fltCusCol: Double;
    fltVenCol: Double;

    fltQtdGra: Double;

    strCodCol: String;
    fltQtdCol: Double;

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
  For intContador := 0 To stlCodCol.Count -1 Do
  Begin

    strCodCol := stlCodCol.Strings[intContador];
    fltQtdCol := fStrToFloat(stlQtdCol.Strings[intContador]);
    fltQtdCol := fFormataFloat(fltQtdCol / 100, 02);

    qryCadCol.Locate('COL_CODCOL', strCodCol, []);

    fltCusCol := fltCusCol + (fltQtdCol * 0.154) * (qryCadCol.FieldByName('ITE_PRECUS').AsFloat / 1000);
    fltVenCol := fltVenCol + (fltQtdCol * 0.154) * (qryCadCol.FieldByName('ITE_PREVEN').AsFloat / 1000);

  End;

  {*****************************************}
  {* PROCESSA CADBAS GRAVANDO TODAS AS     *}
  {* UNIDADES DO PRODUTO + BASE            *}
  {**************************************MV*}
  While (Not qryCadBas.Eof)                                        And
        (qryCadBas.FieldByName('BAS_CODBAS').AsString = strCodBas) And
        (qryCadBas.FieldByName('BAS_CODPRO').AsString = strCodPro) Do
  Begin

    Application.ProcessMessages;

    fltPreCus := 0.0;
    fltPreVen := 0.0;

    If (qryCadBas.FieldByName('BAS_SIGUNI').AsString = 'LT') Then
    Begin
      fltPreCus := qryCadBas.FieldByName('ITE_PRECUS').AsFloat + (fltCusCol * 0.9);
      fltPreVen := qryCadBas.FieldByName('ITE_PREVEN').AsFloat + (fltVenCol * 0.9);
    End
    Else If (qryCadBas.FieldByName('BAS_SIGUNI').AsString = 'GL') Then
    Begin
      fltPreCus := qryCadBas.FieldByName('ITE_PRECUS').AsFloat + (fltCusCol * 3.6);
      fltPreVen := qryCadBas.FieldByName('ITE_PREVEN').AsFloat + (fltVenCol * 3.6);
    End
    Else If (qryCadBas.FieldByName('BAS_SIGUNI').AsString = 'LA') Then
    Begin
      fltPreCus := qryCadBas.FieldByName('ITE_PRECUS').AsFloat + (fltCusCol * 18.0);
      fltPreVen := qryCadBas.FieldByName('ITE_PREVEN').AsFloat + (fltVenCol * 18.0);
    End;

    {*****************************************}
    {* GRAVA NO CADLKS                       *}
    {**************************************MV*}
    If (Not frmModuloTinta.qryLks_CadLks.Active) Then
      frmModuloTinta.qryLks_CadLks.Open;

    frmModuloTinta.qryLks_CadLks.Insert;

    If (intAutInc > 0) Then
      frmModuloTinta.qryLks_CadLks.FieldByName('AUTOINCREM').AsString  := fFormataAutInc(intAutInc, VS_strCodEmp)
    Else
      frmModuloTinta.qryLks_CadLks.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('LKS_CADLKS', VS_strCodEmp);

    frmModuloTinta.qryLks_CadLks.FieldByName('LKS_CODSEQ').AsString  := fAtualizaProCod('LKS_CADLKS');
    frmModuloTinta.qryLks_CadLks.FieldByName('LKS_CODITE').AsString  := qryCadBas.FieldByName('BAS_CODITE').AsString;
    frmModuloTinta.qryLks_CadLks.FieldByName('LKS_CODEMP').AsString  := strCodEmp;
    frmModuloTinta.qryLks_CadLks.FieldByName('LKS_DESCRI').AsString  := strDescri;
    frmModuloTinta.qryLks_CadLks.FieldByName('LKS_REFERE').AsString  := strRefere;
    frmModuloTinta.qryLks_CadLks.FieldByName('LKS_UNIDAD').AsString  := qryCadBas.FieldByName('BAS_SIGUNI').AsString;
    frmModuloTinta.qryLks_CadLks.FieldByName('LKS_PREVEN').AsFloat   := fltPreVen;
    frmModuloTinta.qryLks_CadLks.FieldByName('LKS_PRECUS').AsFloat   := fltPreCus;

    If (fArqIniTinta(0, 'USA_FORMUL', 'LKS', 'S') = 'S') Then
    Begin

      For intContador := 1 To Length(arrForMul) Do
      Begin
        frmModuloTinta.qryLks_CadLks.FieldByName('LKS_FORM' + fStrZero(IntToStr(intContador), 2)).AsString := arrForMul[intContador-1].strCodCol;

        fltQtdGra := 0.0;
        If (qryCadBas.FieldByName('BAS_SIGUNI').AsString = 'LT') Then
          fltQtdGra := arrForMul[intContador-1].fltQtdCol * 0.9

        Else If (qryCadBas.FieldByName('BAS_SIGUNI').AsString = 'GL') Then
          fltQtdGra := arrForMul[intContador-1].fltQtdCol * 3.6

        Else If (qryCadBas.FieldByName('BAS_SIGUNI').AsString = 'LA') Then
          fltQtdGra := arrForMul[intContador-1].fltQtdCol * 18.0;

        frmModuloTinta.qryLks_CadLks.FieldByName('LKS_QTDC' + fStrZero(IntToStr(intContador), 2)).AsFloat := fltQtdGra;
      End;

    End;

    If (qryCadBas.FieldByName('BAS_SIGUNI').AsString = 'LT') Then
    Begin
      frmModuloTinta.qryLks_CadLks.FieldByName('LKS_COLCUS').AsFloat := fltCusCol * 0.9;
      frmModuloTinta.qryLks_CadLks.FieldByName('LKS_COLVEN').AsFloat := fltVenCol * 0.9;
    End
    Else If (qryCadBas.FieldByName('BAS_SIGUNI').AsString = 'GL') Then
    Begin
      frmModuloTinta.qryLks_CadLks.FieldByName('LKS_COLCUS').AsFloat := fltCusCol * 3.6;
      frmModuloTinta.qryLks_CadLks.FieldByName('LKS_COLVEN').AsFloat := fltVenCol * 3.6;
    End
    Else If (qryCadBas.FieldByName('BAS_SIGUNI').AsString = 'LA') Then
    Begin
      frmModuloTinta.qryLks_CadLks.FieldByName('LKS_COLCUS').AsFloat := fltCusCol * 18.0;
      frmModuloTinta.qryLks_CadLks.FieldByName('LKS_COLVEN').AsFloat := fltVenCol * 18.0;
    End;

    frmModuloTinta.qryLks_CadLks.Post;

    If (Not blnGerNfm) Then
      Inc(intAutInc)
    Else
      Break;

    qryCadBas.Next;
  End;

  Result := True;

end;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    intContador : Integer;
    intTamMat   : Integer;
    strQtdCol   : String;
    blnDelCadLks: Boolean;

    stlCodCol: TStringList;
    stlQtdCol: TStringList;

    strSQL: String;

    qryCadBas: TUniQuery;
    qryCadCol: TUniQuery;
    arrForMul: TArrayLksForMul;
begin

  qryCadBas := TUniQuery.Create(Nil);
  qryCadCol := TUniQuery.Create(Nil);

  qryCadBas.Connection := frmModulo.Database;
  qryCadCol.Connection := frmModulo.Database;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LKS_CADBAS.*, ';
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
  strSQL := strSQL + '  LKS_CADBAS, ';
  strSQL := strSQL + '  ITEGER, ';
  strSQL := strSQL + '  CADUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_UNIDAD = UNI_CODUNI AND ';
  strSQL := strSQL + '  BAS_CODITE = ITE_CODITE AND ';
  strSQL := strSQL + '  BAS_CODBAS = :CODBAS    AND ';
  strSQL := strSQL + '  BAS_CODPRO = :CODPRO    AND ';
  strSQL := strSQL + '  UNI_SIGUNI IN ("LT","GL","LA") AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

  qryCadBas.Close;
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(strSQL);
  qryCadBas.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
  qryCadBas.ParamByName('CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadBas.Open;

  qryCadCol.SQL.Add('SELECT                                                                                      ');
  qryCadCol.SQL.Add('  LKS_CADCOL.*,                                                                             ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    qryCadCol.SQL.Add('  COL_PRECUS AS ITE_PRECUS,                                                               ');
    qryCadCol.SQL.Add('  COL_PREVEN AS ITE_PREVEN                                                                ');
  End
  Else
  Begin
    qryCadCol.SQL.Add('  ITEGER.ITE_PRECUS,                                                                      ');
    qryCadCol.SQL.Add('  ITEGER.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
  End;

  qryCadCol.SQL.Add('FROM                                                                                        ');
  qryCadCol.SQL.Add('  LKS_CADCOL                                                                                ');
  qryCadCol.SQL.Add('JOIN ITEGER ON ITE_CODITE = COL_CODITE                                                      ');
  qryCadCol.SQL.Add('            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
  qryCadCol.Open;

  stlCodCol := TStringList.Create;
  stlQtdCol := TStringList.Create;

  SetLength(arrForMul, 0);

  For intContador := 1 To 10 Do
  Begin

    strQtdCol := FloatToStrF(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsFloat, ffFixed, 12, 2);
    strQtdCol := AnsiReplaceStr(strQtdCol, ',', '');
    strQtdCol := AnsiReplaceStr(strQtdCol, '.', '');

    If (fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intContador, 2)).AsString)) Then
      Break;

    intTamMat := Length(arrForMul);
    SetLength(arrForMul, intTamMat+1);
    arrForMul[intTamMat].strCodCol := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intContador, 2)).AsString;
    arrForMul[intTamMat].fltQtdCol := fFormataFloat(fStrToFloat(strQtdCol) / 100, 02);

    stlCodCol.Add(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intContador, 2)).AsString);
    stlQtdCol.Add(strQtdCol);

  End;

  {*******************************************}
  {* USA INCCONTADOR APENAS PARA SINALIZAR   *}
  {* QUE NAO VAI GERAR O AUTOINCREMENTO      *}
  {****************************************MV*}
  blnDelCadLks := True;
  While not qryCadBas.Eof Do
  Begin
    intContador := 0;

    fLukscolorGravaCadLks(qryCadBas,
                          qryCadCol,
                          qryCadNfm.FieldByName('NFM_DESCRI').AsString,
                          qryCadNfm.FieldByName('NFM_CODIGO').AsString,
                          qryCadNfm.FieldByName('NFM_CODBAS').AsString,
                          qryCadNfm.FieldByName('NFM_CODPRO').AsString,
                          VS_strCodEmp,
                          stlQtdCol,
                          stlCodCol,
                          blnDelCadLks,//True,
                          True,
                          arrForMul,
                          intContador);
    qryCadBas.Next;
    blnDelCadLks := False;
  End;

  frmModuloTinta.qryGen001.Close;

  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadCol);

  FreeAndNil(stlCodCol);
  FreeAndNil(stlQtdCol);

  Result := True;

end;

procedure pDeletaNovaFormula(strRefere: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  LKS_CADLKS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LKS_REFERE = :REFERE ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('REFERE').AsString := strRefere;
    ExecSQL;
    Close;
  End;
End;

  {*******************************************}
  {*PROCESSA OS DADOS DO ARQUIVO DA COROB    *}
  {****************************************PH*}

function fLukscolorImportaCorOB(): Boolean;
var
  strNomeArquivo: String;
  mArquivo : TStringList;
  mAux: TStringList;
  mFinal : TStringList;
  inicio, fim, tamanho: Integer;
  strPrefixo: String;
Begin

  {*******************************************}
  {* SOMENTE PARA PARAR OS WARNINGS          *}
  {****************************************PH*}
  mArquivo := Nil;
  mFinal := Nil;
  

  try
    mArquivo := TStringList.Create;
    mArquivo.Clear;
    mAux := TStringList.Create;
    mAux.Clear;
    mFinal := TStringList.Create;
    mFinal.Clear;

    strNomeArquivo :=  fGetConfTinta('LKS').fGet('PATLKS') + '\pricefrm.txt';
    mArquivo.LoadFromFile(strNomeArquivo);

    inicio := fPosEx('2.10  LUKSCOLOR SYSTEM ', mArquivo.Text, 1);
    fim := fPosEx('2.10  LUKSCOLOR SYSTEM ', mArquivo.Text, inicio + 1) - inicio;
    tamanho := fim - inicio;

    while (fim > 0) do
    begin
      Application.ProcessMessages;
      mAux.Text := Trim(copy(mArquivo.Text, inicio, tamanho));
      pDeletarLinhasStringList(mAux, 5);
      mAux.Delete(mAux.Count - 1);
      mAux.Text := Trim(mAux.Text);
      strPrefixo := mAux.Strings[0];
      pDeletarLinhasStringList(mAux, 9);

      fProcessa(mAux, strPrefixo);


      inicio := fPosEx('2.10  LUKSCOLOR SYSTEM ', mArquivo.Text, fim - 1);
      fim := fPosEx('2.10  LUKSCOLOR SYSTEM ', mArquivo.Text, inicio + 1);
      tamanho := fim - inicio;
    end;

    fim := fPosEx('----------------------------------------------------------------------------------', mArquivo.Text, inicio + fim + 400);
    if fim > 0 then
    begin
      tamanho := fim - inicio;
      mAux.Text := Trim(copy(mArquivo.Text, inicio, tamanho));
      pDeletarLinhasStringList(mAux, 5);
      mAux.Delete(mAux.Count - 1);
      mAux.Text := Trim(mAux.Text);
      strPrefixo := mAux.Strings[0];
      pDeletarLinhasStringList(mAux, 9);
      fProcessa(mAux, strPrefixo);
    end;

    inicio := fim;
    fim := length(mArquivo.Text);
    tamanho := fim - inicio;
    if tamanho > 0 then
    begin
      mAux.Text := Trim(copy(mArquivo.Text, inicio, tamanho));
      strPrefixo := 'Personalizada';
      pDeletarLinhasStringList(mAux, 9);
      mAux.Text := Trim(mAux.Text);
      fProcessa(mAux, strPrefixo);
    end;



  finally
    mArquivo.Free;
    mAux.Free;
    mFinal.Free;
    Result := True;
  end;
End;

  {*******************************************}
  {*função para separar os tags do arquivo   *}
  {*da máquina CorOB, cada tag em uma linha  *}
  {****************************************PH*}

function fprocessaTagsCorOB(Texto: String): String;
var
  mResultado: TStringList;
begin
  mResultado := TStringList.Create;
  mResultado.Clear;
  mResultado.Add(Trim(Copy(Texto,0,24)));                                 //Key 1
  mResultado.Add(Trim(Copy(Texto,24,24)));                                //Key 2
  if not fEmptyStr(Trim(Copy(Texto,109,18))) then
    mResultado.Add(Trim(Copy(Texto,109,18)))                              //Unidade (LT)QUARTO
  else
    mResultado.Add('0');
  if not fEmptyStr(Trim(Copy(Texto,127,17))) then
    mResultado.Add(Trim(Copy(Texto,127,17)))                             //Unidade (GL)GALAO
  else
    mResultado.Add('0');
  if not fEmptyStr(Trim(Copy(Texto,144,19))) then
    mResultado.Add(Trim(Copy(Texto,144,19)))                             //Unidade (LA)LATA
  else
    mResultado.Add('0');
  Result := (mResultado.Text);
  mResultado.Free;
end;

procedure pDeletarLinhasStringList(var StringList: TStringList; nLinhas: Integer);
var
  i: Integer;
begin
  for i := 0 to nLinhas - 1 do
    StringList.Delete(0);
end;

procedure fProcessa(StringList: TStringList; Prefixo: String);
var
  mProcessa: TStringList;
  mQuery: TStringList;
  Query: TUniQuery;
  intCont1, intCont2: Integer;

  strKey1: String;
  strKey2: String;

  fltTaxaCusto: Double;
  fltValorcusto: Double;
  strITE_CODITE: String;
  conf: IConfTinta;
begin
  {*******************************************}
  {*  SOMENTE PARA PARAR OS WARNINGS         *}
  {****************************************PH*}
  mProcessa := Nil;
  mQuery := Nil;
  conf := fGetConfTinta('LKS');

  try
    mProcessa := TStringList.Create;
    mProcessa.Clear;
    mQuery := TStringList.Create;
    mQuery.Clear;
    Query := fCriaQuery();

    strITE_CODITE := conf.fGet('CODITE');

    mQuery.Clear;
    mQuery.Add('SELECT DISTINCT');
    mQuery.Add('   ITE_CODITE');
    mQuery.Add('FROM CADITE');
    mQuery.Add('WHERE ITE_CODITE = "' + strITE_CODITE + '"');

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add(mQuery.Text);
    Query.Open;

    fltTaxaCusto := conf.fGetDouble('FATCALC');

    mQuery.Clear;
    mQuery.Add('INSERT INTO ');
    mQuery.Add('	LKS_CADLKS');
    mQuery.Add('	(LKS_CODSEQ, LKS_CODEMP, ');
    mQuery.Add('	LKS_CODITE, LKS_DESCRI, LKS_UNIDAD,');
    mQuery.Add('	LKS_PREVEN,	LKS_PRECUS,	LKS_COLVEN,');
    mQuery.Add('	LKS_COLCUS,	AUTOINCREM,	LKS_FORM01,');
    mQuery.Add('	LKS_QTDC01,	LKS_FORM02,	LKS_QTDC02,');
    mQuery.Add('	LKS_FORM03,	LKS_QTDC03,	LKS_FORM04,');
    mQuery.Add('	LKS_QTDC04,	LKS_FORM05,	LKS_QTDC05,');
    mQuery.Add('	LKS_FORM06,	LKS_QTDC06,	LKS_FORM07,');
    mQuery.Add('	LKS_QTDC07,	LKS_FORM08,	LKS_QTDC08,');
    mQuery.Add('	LKS_FORM09,	LKS_QTDC09,	LKS_FORM10,');
    mQuery.Add('	LKS_QTDC10,	LKS_REFERE)');
    mQuery.Add('VALUES');
    mQuery.Add('	(:CODSEQ, :CODEMP, ');
    mQuery.Add('	:CODITE, :DESCRI, :UNIDAD,');
    mQuery.Add('	:PREVEN, :PRECUS, 0,');
    mQuery.Add('	0, :AUTOINCREM, NULL,');
    mQuery.Add('	NULL,NULL,NULL,');
    mQuery.Add('	NULL,NULL,NULL,');
    mQuery.Add('	NULL,NULL,NULL,');
    mQuery.Add('	NULL,NULL,NULL,');
    mQuery.Add('	NULL,NULL,NULL,');
    mQuery.Add('	NULL,NULL,NULL,');
    mQuery.Add('	NULL, :REFERE);');

    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Text := mQuery.Text;

    for intCont1 := 0 to StringList.Count - 1 do
    begin
      mProcessa.Clear;
      mProcessa.Text :=  fprocessaTagsCorOB(StringList.Strings[intCont1]);
      strKey1   := mProcessa.Strings[0];
      strKey2   := mProcessa.Strings[1];
      for intCont2 := 2 to 4 do
      begin
        Application.ProcessMessages;
        Query.ParamByName('CODSEQ').AsString := fProximoCodSeq;
        Query.ParamByName('CODEMP').AsString := VS_strCodEmp;
        Query.ParamByName('CODITE').AsString := strITE_CODITE;
        Query.ParamByName('DESCRI').AsString := strKey1 + ' ' + Prefixo + ' ' + strKey2;

        case intCont2 of
          2: Query.ParamByName('UNIDAD').AsString := 'LT';
          3: Query.ParamByName('UNIDAD').AsString := 'GL';
          4: Query.ParamByName('UNIDAD').AsString := 'LA';
        end;

        Query.ParamByName('PREVEN').AsString := mProcessa.Strings[intCont2];

        fltValorcusto := fStrToFloat(StringReplace(mProcessa.Strings[intCont2], '.', ',', []));
        fltValorcusto := fltValorcusto * fltTaxaCusto;

        Query.ParamByName('PRECUS').AsFloat := fltValorcusto;
        Query.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LKS_CADLKS', VS_strCodEmp);
        Query.ParamByName('REFERE').AsString := strKey1;
        
        Query.ExecSQL;
      end;
    end;
  finally
    mQuery.Free;
    mProcessa.Free;
    FreeAndNil(Query);
  end;
end;


function fProximoCodSeq: String;
var
  Query: TUniQuery;
begin
  Query := fCriaQuery();
  Query.Close;
  Query.SQL.Text := 'SELECT CAST(LKS_CODSEQ AS UNSIGNED INT) AS LKS_CODSEQ FROM LKS_CADLKS ORDER BY LKS_CODSEQ DESC';
  Query.Open;
  if Query.FieldByName('LKS_CODSEQ').IsNull then
    Result := fStrZero(1, 6)
  else
    Result := fStrZero(Query.FieldByName('LKS_CODSEQ').AsInteger + 1, 6);
  FreeAndNil(Query);
end;


end.
