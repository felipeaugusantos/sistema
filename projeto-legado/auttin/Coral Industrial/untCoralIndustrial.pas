unit untCoralIndustrial;

interface

uses Windows, SysUtils, Classes, StrUtils, Uni, Forms;

Type
  TCorForMul = Record
    strCodCol: String;
    fltQtdCol: Double;
End;

Type
  TCorArrCol = Array[1..10] Of TCorForMul;

  function fRetornaUnidade(strCodEmb: String): String;
  function fBaseCadastrada(strCodBas, strUnidad, strDescri: String;
    qryCadBas: TUniQuery): Boolean;

  function fGravaBase(strCodBas, strUnidad, strDescri: String;
    Var intAutIncCadBas: Integer; qryCadBas: TUniQuery): Boolean;

  function fCarregaItem(strCodIte: String; qryCadIte: TUniQuery): Boolean;

  function fGravaCarCor(strCodSeq,
                        strCodEmp,
                        strCodIte,
                        strDescri,
                        strCodigo,
                        strUnidad,
                        strColId1,
                        strColId2,
                        strDesPro,
                        strCodBas: String;
                        fltPreVen,
                        fltPreCus,
                        fltColVen,
                        fltColCus: Double;
                        strForm01,
                        strForm02,
                        strForm03,
                        strForm04,
                        strForm05,
                        strForm06,
                        strForm07,
                        strForm08,
                        strForm09,
                        strForm10: String;
                        fltQtdC01,
                        fltQtdC02,
                        fltQtdC03,
                        fltQtdC04,
                        fltQtdC05,
                        fltQtdC06,
                        fltQtdC07,
                        fltQtdC08,
                        fltQtdC09,
                        fltQtdC10: Double;
                        Var intAutInc: Integer;
                        strAutoIncrem: String): Boolean;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;

  function fCoralIndustrialGeraArquivo(blnGerBas: Boolean): Boolean;

  procedure pDeletaNovaFormula(strCodigo: String);

implementation

uses untFuncoes, DB,  untModulo,
  untModuloTinta, untFuncoesSimples;

function fRetornaUnidade(strCodEmb: String): String;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMB_UNIDAD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIND_CADEMB ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMB_CODEMB = :CODEMB ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMB').AsString := strCodEmb;
    Open;
    Result := FieldByName('EMB_UNIDAD').AsString;
    Close;
  End;

end;

function fBaseCadastrada(strCodBas, strUnidad, strDescri: String;
  qryCadBas: TUniQuery): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIND_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_BASE__ = :CODBAS AND ';
  strSQL := strSQL + '  BAS_UNIDAD = :UNIDAD AND ';
  strSQL := strSQL + '  BAS_DESCRI = :DESCRI ';

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAS').AsString := strCodBas;
    ParamByName('UNIDAD').AsString := strUnidad;
    ParamByName('DESCRI').AsString := strDescri;
    Open;
    Result := (Not IsEmpty);
  End;

end;

function fGravaBase(strCodBas, strUnidad, strDescri: String;
  Var intAutIncCadBas: Integer; qryCadBas: TUniQuery): Boolean;
  Var
    strSQL: String;
    blnGravar: Boolean;
begin

  blnGravar := (Not fBaseCadastrada(strCodBas, strUnidad, strDescri, qryCadBas));

  Result := True;
  If (blnGravar) Then
  Begin

    Try
      strSQL := '';
      strSQL := strSQL + 'INSERT DELAYED INTO CORIND_CADBAS ';
      strSQL := strSQL + '( ';
      strSQL := strSQL + '  BAS_BASE__, ';
      strSQL := strSQL + '  BAS_CODITE, ';
      strSQL := strSQL + '  BAS_DESCRI, ';
      strSQL := strSQL + '  BAS_UNIDAD, ';
      strSQL := strSQL + '  BAS_CODEMP, ';
      strSQL := strSQL + '  AUTOINCREM ) ';
      strSQL := strSQL + 'VALUES ( ';
      strSQL := strSQL + '  :BASE__, ';
      strSQL := strSQL + '  :CODITE, ';
      strSQL := strSQL + '  :DESCRI, ';
      strSQL := strSQL + '  :UNIDAD, ';
      strSQL := strSQL + '  :CODEMP, ';
      strSQL := strSQL + '  :AUTINC) ';

      With frmModuloTinta.qryGen001 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('BASE__').AsString  := strCodBas;
        ParamByName('CODITE').AsString  := '';
        ParamByName('DESCRI').AsString  := strDescri;
        ParamByName('UNIDAD').AsString  := strUnidad;
        ParamByName('CODEMP').AsString  := VS_strCodEmp;
        ParamByName('AUTINC').AsString  := fFormataAutInc(intAutIncCadBas, VS_strCodEmp);
        ExecSQL;
        Close;
      End;

      Inc(intAutIncCadBas);

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaBase]');
      End;
    End;

  End;

end;

function fCarregaItem(strCodIte: String; qryCadIte: TUniQuery): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_PREVE1, ';
  strSQL := strSQL + '  ITE_PRECUS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

  With qryCadIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    Result := (Not IsEmpty);
  End;

end;

function fGravaCarCor(strCodSeq,
                      strCodEmp,
                      strCodIte,
                      strDescri,
                      strCodigo,
                      strUnidad,
                      strColId1,
                      strColId2,
                      strDesPro,
                      strCodBas: String;
                      fltPreVen,
                      fltPreCus,
                      fltColVen,
                      fltColCus: Double;
                      strForm01,
                      strForm02,
                      strForm03,
                      strForm04,
                      strForm05,
                      strForm06,
                      strForm07,
                      strForm08,
                      strForm09,
                      strForm10: String;
                      fltQtdC01,
                      fltQtdC02,
                      fltQtdC03,
                      fltQtdC04,
                      fltQtdC05,
                      fltQtdC06,
                      fltQtdC07,
                      fltQtdC08,
                      fltQtdC09,
                      fltQtdC10: Double;
                      Var intAutInc: Integer;
                      strAutoIncrem: String): Boolean;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'INSERT DELAYED INTO CORIND_CADCOR ';
  strSQL := strSQL + '( ';
  strSQL := strSQL + '  COR_CODSEQ, ';
  strSQL := strSQL + '  COR_CODEMP, ';
  strSQL := strSQL + '  COR_CODITE, ';
  strSQL := strSQL + '  COR_DESCRI, ';
  strSQL := strSQL + '  COR_CODIGO, ';
  strSQL := strSQL + '  COR_UNIDAD, ';
  strSQL := strSQL + '  COR_COLID1, ';
  strSQL := strSQL + '  COR_COLID2, ';
  strSQL := strSQL + '  COR_DESPRO, ';
  strSQL := strSQL + '  COR_CODBAS, ';
  strSQL := strSQL + '  COR_PREVEN, ';
  strSQL := strSQL + '  COR_PRECUS, ';
  strSQL := strSQL + '  COR_COLVEN, ';
  strSQL := strSQL + '  COR_COLCUS, ';
  strSQL := strSQL + '  COR_FORM01, ';
  strSQL := strSQL + '  COR_FORM02, ';
  strSQL := strSQL + '  COR_FORM03, ';
  strSQL := strSQL + '  COR_FORM04, ';
  strSQL := strSQL + '  COR_FORM05, ';
  strSQL := strSQL + '  COR_FORM06, ';
  strSQL := strSQL + '  COR_FORM07, ';
  strSQL := strSQL + '  COR_FORM08, ';
  strSQL := strSQL + '  COR_FORM09, ';
  strSQL := strSQL + '  COR_FORM10, ';
  strSQL := strSQL + '  COR_QTDC01, ';
  strSQL := strSQL + '  COR_QTDC02, ';
  strSQL := strSQL + '  COR_QTDC03, ';
  strSQL := strSQL + '  COR_QTDC04, ';
  strSQL := strSQL + '  COR_QTDC05, ';
  strSQL := strSQL + '  COR_QTDC06, ';
  strSQL := strSQL + '  COR_QTDC07, ';
  strSQL := strSQL + '  COR_QTDC08, ';
  strSQL := strSQL + '  COR_QTDC09, ';
  strSQL := strSQL + '  COR_QTDC10, ';
  strSQL := strSQL + '  AUTOINCREM ) ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :CODSEQ, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :CODITE, ';
  strSQL := strSQL + '  :DESCRI, ';
  strSQL := strSQL + '  :CODIGO, ';
  strSQL := strSQL + '  :UNIDAD, ';
  strSQL := strSQL + '  :COLID1, ';
  strSQL := strSQL + '  :COLID2, ';
  strSQL := strSQL + '  :DESPRO, ';
  strSQL := strSQL + '  :CODBAS, ';
  strSQL := strSQL + '  :PREVEN, ';
  strSQL := strSQL + '  :PRECUS, ';
  strSQL := strSQL + '  :COLVEN, ';
  strSQL := strSQL + '  :COLCUS, ';
  strSQL := strSQL + '  :FORM01, ';
  strSQL := strSQL + '  :FORM02, ';
  strSQL := strSQL + '  :FORM03, ';
  strSQL := strSQL + '  :FORM04, ';
  strSQL := strSQL + '  :FORM05, ';
  strSQL := strSQL + '  :FORM06, ';
  strSQL := strSQL + '  :FORM07, ';
  strSQL := strSQL + '  :FORM08, ';
  strSQL := strSQL + '  :FORM09, ';
  strSQL := strSQL + '  :FORM10, ';
  strSQL := strSQL + '  :QTDC01, ';
  strSQL := strSQL + '  :QTDC02, ';
  strSQL := strSQL + '  :QTDC03, ';
  strSQL := strSQL + '  :QTDC04, ';
  strSQL := strSQL + '  :QTDC05, ';
  strSQL := strSQL + '  :QTDC06, ';
  strSQL := strSQL + '  :QTDC07, ';
  strSQL := strSQL + '  :QTDC08, ';
  strSQL := strSQL + '  :QTDC09, ';
  strSQL := strSQL + '  :QTDC10, ';
  strSQL := strSQL + '  :AUTINC) ';

  Try

    Result := True;

    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODSEQ').AsString  := strCodSeq;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('DESCRI').AsString  := strDescri;
      ParamByName('CODIGO').AsString  := strCodigo;
      ParamByName('UNIDAD').AsString  := strUnidad;
      ParamByName('COLID1').AsString  := strColId1;
      ParamByName('COLID2').AsString  := strColId2;
      ParamByName('DESPRO').AsString  := strDesPro;
      ParamByName('CODBAS').AsString  := strCodBas;
      ParamByName('PREVEN').AsFloat   := fltPreVen;
      ParamByName('PRECUS').AsFloat   := fltPreCus;
      ParamByName('COLVEN').AsFloat   := fltColVen;
      ParamByName('COLCUS').AsFloat   := fltColCus;
      ParamByName('FORM01').AsString  := strForm01;
      ParamByName('FORM02').AsString  := strForm02;
      ParamByName('FORM03').AsString  := strForm03;
      ParamByName('FORM04').AsString  := strForm04;
      ParamByName('FORM05').AsString  := strForm05;
      ParamByName('FORM06').AsString  := strForm06;
      ParamByName('FORM07').AsString  := strForm07;
      ParamByName('FORM08').AsString  := strForm08;
      ParamByName('FORM09').AsString  := strForm09;
      ParamByName('FORM10').AsString  := strForm10;
      ParamByName('QTDC01').AsFloat   := fltQtdC01;
      ParamByName('QTDC02').AsFloat   := fltQtdC02;
      ParamByName('QTDC03').AsFloat   := fltQtdC03;
      ParamByName('QTDC04').AsFloat   := fltQtdC04;
      ParamByName('QTDC05').AsFloat   := fltQtdC05;
      ParamByName('QTDC06').AsFloat   := fltQtdC06;
      ParamByName('QTDC07').AsFloat   := fltQtdC07;
      ParamByName('QTDC08').AsFloat   := fltQtdC08;
      ParamByName('QTDC09').AsFloat   := fltQtdC09;
      ParamByName('QTDC10').AsFloat   := fltQtdC10;
      If (intAutInc > 0) Then
        ParamByName('AUTINC').AsString  := fFormataAutInc(intAutInc, VS_strCodEmp)
      Else
        ParamByName('AUTINC').AsString  := strAutoIncrem;

      ExecSQL;
      Close;
    End;

    Inc(intAutInc);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaCarCor]');
    End;
  End;

End;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    intContador: Integer;
    strAutInc: String;
    fltCusCol: Double;
    fltVenCol: Double;
    fltPreCus: Double;
    fltPreVen: Double;

    strSQL: String;
    strCodSeq: String;
begin

  fltCusCol := 0.0;
  fltVenCol := 0.0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

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
  strSQL := strSQL + '  CORIMO_CADCOL ';
  strSQL := strSQL + '  JOIN ITEGER ON ITE_CODITE = COL_CODITE ';
  strSQL := strSQL + '              AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL = :CODCOL ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL)
  End;

  For intContador := 1 To 10 Do
  Begin

    frmModuloTinta.qryGen001.Close;
    frmModuloTinta.qryGen001.ParamByName('CODCOL').AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intContador, 2)).AsString;
    frmModuloTinta.qryGen001.Open;

    {***********************************************************}
    {* CUSTO DO COLORANTE = CUSTO DO -> ML <- VEZES QUANTIDADE *}
    {********************************************************MV*}
    fltCusCol := fltCusCol + qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsFloat *
                             (frmModuloTinta.qryGen001.FieldByName('ITE_PRECUS').AsFloat / 1000.0);

    {*******************************************************************}
    {* PR. VENDA DO COLORANTE = PR. VENDA DO -> ML <- VEZES QUANTIDADE *}
    {****************************************************************MV*}
    fltVenCol := fltVenCol + qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsFloat *
                             (frmModuloTinta.qryGen001.FieldByName('ITE_PREVEN').AsFloat / 1000.0);

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + 'CORIMO_CADBAS.*, ';
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
  strSQL := strSQL + '  CORIMO_CADBAS ';
  strSQL := strSQL + '  JOIN ITEGER ON ITE_CODITE = BAS_CODITE ';
  strSQL := strSQL + '              AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODITE = :CODITE AND ';
  strSQL := strSQL + '  BAS_BASE__ = :CODBAS ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := qryCadNfm.FieldByName('NFM_CODITE').AsString;
    ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;;
    Open;

    fltPreCus := FieldByName('ITE_PRECUS').AsFloat + fltCusCol;
    fltPreVen := FieldByName('ITE_PREVEN').AsFloat + fltVenCol;
  End;

  pDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODIGO').AsString);

  strAutInc := fRetAutoIncrem('CORIND_CADCOR', VS_strCodEmp);
  strCodSeq := fAtualizaProCod('CORIND_CADCOR');

  Result := fGravaCarCor(strCodSeq,
                         VS_strCodEmp,
                         qryCadNfm.FieldByName('NFM_CODITE').AsString,
                         qryCadNfm.FieldByName('NFM_DESCRI').AsString,
                         qryCadNfm.FieldByName('NFM_CODIGO').AsString,
                         qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                         '',
                         '',
                         '',
                         qryCadNfm.FieldByName('NFM_CODBAS').AsString,
                         fltPreVen,
                         fltPreCus,
                         fltVenCol,
                         fltCusCol,
                         qryCadNfm.FieldByName('NFM_FORM01').AsString,
                         qryCadNfm.FieldByName('NFM_FORM02').AsString,
                         qryCadNfm.FieldByName('NFM_FORM03').AsString,
                         qryCadNfm.FieldByName('NFM_FORM04').AsString,
                         qryCadNfm.FieldByName('NFM_FORM05').AsString,
                         qryCadNfm.FieldByName('NFM_FORM06').AsString,
                         qryCadNfm.FieldByName('NFM_FORM07').AsString,
                         qryCadNfm.FieldByName('NFM_FORM08').AsString,
                         qryCadNfm.FieldByName('NFM_FORM09').AsString,
                         qryCadNfm.FieldByName('NFM_FORM10').AsString,
                         qryCadNfm.FieldByName('NFM_QTDC01').AsFloat,
                         qryCadNfm.FieldByName('NFM_QTDC02').AsFloat,
                         qryCadNfm.FieldByName('NFM_QTDC03').AsFloat,
                         qryCadNfm.FieldByName('NFM_QTDC04').AsFloat,
                         qryCadNfm.FieldByName('NFM_QTDC05').AsFloat,
                         qryCadNfm.FieldByName('NFM_QTDC06').AsFloat,
                         qryCadNfm.FieldByName('NFM_QTDC07').AsFloat,
                         qryCadNfm.FieldByName('NFM_QTDC08').AsFloat,
                         qryCadNfm.FieldByName('NFM_QTDC09').AsFloat,
                         qryCadNfm.FieldByName('NFM_QTDC10').AsFloat,
                         intContador,
                         strAutInc);

  frmModuloTinta.qryGen001.Close;

end;

function fCoralIndustrialGeraArquivo(blnGerBas: Boolean): Boolean;
  Var
    strPatCor: String;
    arquivos:  TSearchRec;
    stlArquivos: TStringList;
    stlArqTxt: TStringList;
    intContador: Integer;
    intContador2: Integer;
    intLinhaAtu: Integer;

    {*******************************************}
    {* DADOS DO TXT                            *}
    {****************************************MV*}
    strLinha: String;
    strRecId: String;
    strColId1: String;
    strColId2: String;
    strCodBas: String;
    strCodEmb: String;
    strDesPro: String;

    arrColCor: TCorArrCol;

    fltPreVen: Double;
    fltPreCus: Double;
    strUnidad: String;

    fltFatMar: Double;
    fltMarCol: Double;
    fltVenCol: Double;
    fltCusCol: Double;

    intAutIncCadBas: Integer;
    intAutIncCadCor: Integer;

    intCodSeq: Integer;

    qryCadBas: TUniQuery;
    qryCadIte: TUniQuery;

    strSQL: String;
    qryCadNfm: TUniQuery;
begin

  stlArquivos := TStringList.Create;
  stlArqTxt   := TStringList.Create;
  strPatCor   := fArqIniTinta(0, 'Coral Industrial', 'TXTCOR', '');

  intAutIncCadBas := 1;
  intAutIncCadCor := 1;
  intCodSeq       := 1;

  qryCadBas := TUniQuery.Create(Nil);
  qryCadBas.Connection := frmModulo.Database;

  qryCadIte := TUniQuery.Create(Nil);
  qryCadIte.Connection := frmModulo.Database;

  If (FindFirst(strPatCor + '\*.txt', faAnyFile, arquivos) = 0) Then
  Begin

    Repeat
      stlArquivos.Add(strPatCor  + '\' + arquivos.Name);
    Until (FindNext(arquivos) <> 0);

  End;
  FindClose(arquivos);

  If (stlArquivos.Count <= 0) Then
  Begin
    fMensagem('', 'Não foi encontrado nenhum arquivo para geração!', ['&Ok']);
    FreeAndNil(stlArquivos);
    Result := False;
    Exit;
  End;

  pZapTable('CORIND_CADCOR');

  Result := True;

  For intContador := 0 To stlArquivos.Count -1 Do
  Begin

    stlArqTxt.LoadFromFile(stlArquivos[intContador]);

    For intLinhaAtu := 0 To stlArqTxt.Count -1 Do
    Begin

      Application.ProcessMessages;

      {*******************************************}
      {* LIMPA MATRIZ DE COLORANTES              *}
      {****************************************MV*}
      For intContador2 := Low(arrColCor) To High(arrColCor) Do
      Begin
        arrColCor[intContador2].strCodCol := '';
        arrColCor[intContador2].fltQtdCol := 0.0;
      End;

      strLinha := stlArqTxt[intLinhaAtu];

      strRecId  := Trim(Copy(strLinha, 001, 009));

      If (fEmptyStr(strRecId)) Or (Not fIsNumber(strRecId)) Then
      Begin
        Continue;
      End;

      strColId1 := Trim(Copy(strLinha, 011, 030));
      strColId2 := Trim(Copy(strLinha, 042, 050));
      strCodBas := Trim(Copy(strLinha, 144, 010));
      strCodEmb := Trim(Copy(strLinha, 155, 010));
      strDesPro := Trim(Copy(strLinha, 166, 050));

      If (fArqIniTinta(0, 'USA_FORMUL', 'CID', 'S') = 'S') Then
      Begin

        arrColCor[01].strCodCol := Trim(Copy(strLinha, 217, 009));
        arrColCor[01].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 267, 012)), '.', ','));
        arrColCor[02].strCodCol := Trim(Copy(strLinha, 227, 009));
        arrColCor[02].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 280, 012)), '.', ','));
        arrColCor[03].strCodCol := Trim(Copy(strLinha, 237, 009));
        arrColCor[03].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 293, 012)), '.', ','));
        arrColCor[04].strCodCol := Trim(Copy(strLinha, 247, 009));
        arrColCor[04].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 306, 012)), '.', ','));
        arrColCor[05].strCodCol := Trim(Copy(strLinha, 257, 009));
        arrColCor[05].fltQtdCol := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 319, 012)), '.', ','));

      End;

      For intContador2 := Low(arrColCor) To High(arrColCor) Do
        If (arrColCor[intContador2].strCodCol = '0') Then
          arrColCor[intContador2].strCodCol := '';

      fltPreVen := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 517, 012)), '.', ','));
      fltPreCus := fStrToFloat(AnsiReplaceStr(Trim(Copy(strLinha, 541, 012)), '.', ','));

      strUnidad := fRetornaUnidade(strCodEmb);

      If (blnGerBas) Then
      Begin
        fGravaBase(strCodBas, strUnidad, strDesPro, intAutIncCadBas, qryCadBas);
      End;

      {*******************************************}
      {* SE A BASE NÃO EXISTE, NAO GERA A TINTA  *}
      {****************************************MV*}
      If (Not fBaseCadastrada(strCodBas, strUnidad, strDesPro, qryCadBas)) Then
      Begin
        Continue;
      End;

      If (Not fCarregaItem(qryCadBas.FieldByName('BAS_CODITE').AsString,
                           qryCadIte)) Then
      Begin
        Continue;
      End;

      fltMarCol := fStrToFloat(fArqIniTinta(0, 'Coral Industrial', 'MARCOR', ''));
      fltFatMar := 1 - (fltMarCol / 100.0);

      fltVenCol := fltPreVen - qryCadIte.FieldByName('ITE_PREVE1').AsFloat;
      fltCusCol := fltVenCol * fltFatMar;

      Result := fGravaCarCor(fStrZero(intCodSeq, 6),
                             VS_strCodEmp,
                             qryCadBas.FieldByName('BAS_CODITE').AsString,
                             Trim(strColId2 + ' ' + strDesPro + ' ' + strCodBas),
                             strColId1,
                             strUnidad,
                             strColId1,
                             strColId2,
                             strDesPro,
                             strCodBas,
                             fltPreVen,
                             fltPreCus,
                             fltVenCol,
                             fltCusCol,
                             arrColCor[01].strCodCol,
                             arrColCor[02].strCodCol,
                             arrColCor[03].strCodCol,
                             arrColCor[04].strCodCol,
                             arrColCor[05].strCodCol,
                             arrColCor[06].strCodCol,
                             arrColCor[07].strCodCol,
                             arrColCor[08].strCodCol,
                             arrColCor[09].strCodCol,
                             arrColCor[10].strCodCol,
                             arrColCor[01].fltQtdCol,
                             arrColCor[02].fltQtdCol,
                             arrColCor[03].fltQtdCol,
                             arrColCor[04].fltQtdCol,
                             arrColCor[05].fltQtdCol,
                             arrColCor[06].fltQtdCol,
                             arrColCor[07].fltQtdCol,
                             arrColCor[08].fltQtdCol,
                             arrColCor[09].fltQtdCol,
                             arrColCor[10].fltQtdCol,
                             intAutIncCadCor,
                             '');
      If (Result) Then
      Begin
        Inc(intCodSeq);
      End
      Else
        Break;

    End;

    If (Not Result) Then
      Break;

  End;

  {*******************************************}
  {* ATUALIZA CADCOR                         *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  PROCOD ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  PRO_CODSEQ = LPAD(:CODSEQ + 1, PRO_TAMCOD, "0"), ';
  strSQL := strSQL + '  PRO_AUTINC = :AUTINC + 1 ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_NOMARQ = "CORIND_CADCOR" ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsInteger := intCodSeq;
    ParamByName('AUTINC').AsInteger := intAutIncCadCor;
    ExecSQL;
    Close;
  End;

  {*******************************************}
  {* ATUALIZA CADBAS                         *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  PROCOD ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  PRO_AUTINC = :AUTINC + 1 ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_NOMARQ = "CORIND_CADBAS" ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('AUTINC').AsInteger := intAutIncCadBas;
    ExecSQL;
    Close;
  End;

  {*******************************************}
  {* PROCESSA CADASTRO DE NOVAS FORUMULAS    *}
  {****************************************MV*}
  qryCadNfm := fCriaQuery(Nil);
  With qryCadNfm Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CORIND_CADNFM');
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

  FreeAndNil(qryCadNfm);

end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM CORIND_CADCOR WHERE COR_CODIGO = :CODIGO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODIGO').AsString := strCodigo;
    ExecSQL;
    Close;
  End;
end;

end.
