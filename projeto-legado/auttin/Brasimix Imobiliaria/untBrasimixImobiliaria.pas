unit untBrasimixImobiliaria;

interface

uses SysUtils, Classes, Uni, StrUtils, Forms,
     untTintadeMaquina;

Type
  TBziForMul = Record
    strCodCol: String;
    fltQtdCol: Double;
End;

Type
  TBrasimixImobiliaria = class(TTintadeMaquina)
    public
      function fGravaNovasFormulas(): Boolean;
    function fGravarNovasFormulas: Boolean; override;
  End;

  TBziArrCol = Array[1..10] Of TBziForMul;

  procedure pBuscaBaseBasimixImobiliaria(qryCadBas: TUniQuery; strLinha, strCodBas: String);
  procedure pPosicionaItem(qryCadIte: TUniQuery; strCodIte: String);

  function fRetornaPrecoColorante(fltQtdCol, fltPreCad, fltPesEsp: Double): Double;
  function fRetornaPrecoTinta(strUnidad: String; fltPreIte, fltPreCol: Double): Double;

  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;

  function fGravaBziCadBzi(strCodIte,
                           strCodigo,
                           strDescri,
                           strRefere,
                           strUnidad: String;
                           fltPreVen,
                           fltPreCus: Double;
                           strCodEmp,
                           strCodC01: String;
                           fltQtdC01: Double;
                           strCodC02: String;
                           fltQtdC02: Double;
                           strCodC03: String;
                           fltQtdC03: Double;
                           strCodC04: String;
                           fltQtdC04: Double;
                           strCodC05: String;
                           fltQtdC05: Double;
                           strCodC06: String;
                           fltQtdC06: Double;
                           strCodC07: String;
                           fltQtdC07: Double;
                           strCodC08: String;
                           fltQtdC08: Double;
                           strCodC09: String;
                           fltQtdC09: Double;
                           strCodC10: String;
                           fltQtdC10,
                           fltColCus,
                           fltColVen: Double;
                           Var intAutInc: Integer;
                           strAutoIncrem,
                           strLinha,
                           strCodBas,
                           strCodUni: String): Boolean;

  function fBrasimixGeraArquivo(blnGerarBases: Boolean): Boolean;
  procedure pDeletaNovaFormula(strCodigo: String);

  function fGravarCadBas(strLinha, strCodBas, strDesBas: String): Boolean;
  function fGravarCadCol(arrColBzi: TBziArrCol): Boolean;

implementation

uses untModuloSPR, untModulo,  untModuloTinta, Data.DB,
     untFuncoes, untIConfTinta, untFuncTinta, untFuncoesSimples;

function fBrasimixGeraArquivo(blnGerarBases: Boolean): Boolean;
  Var
    strArqTxt: String;
    strSQL: String;
    stlArqTxt: TStringList;
    intPosAtual: Integer;
    intTamArq: Integer;

    strLinhaAtual: String;
    strColorantes: String;
    strCodigo: String;
    strLinha: String;
    strDesCri: String;
    strRefere: String;
    strCodBas: String;
    strColAtu: String;
    strUnidad: String;

    intContador: Integer;
    intPosCol: Integer;

    fltCusCol: Double;
    fltVenCol: Double;
    fltPreCus: Double;
    fltPreVen: Double;

    intAutInc: Integer;

    arrColBzi: TBziArrCol;
    qryCadCol: TUniQuery;
    qryCadBas: TUniQuery;

    qryCadNfm: TUniQuery;

    strDesBas: String;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('BZI');
  strArqTxt := conf.fGet('TXTBRI'); //fArqIniTinta(0, 'Brasimix Imobiliaria', 'TXTBRI', '');
  intAutInc := 1;

  If (Not FileExists(strArqTxt)) Then
  Begin
    fMensagem('', 'Não foi encontrado o TXT para geração.' + #13#10 +
                  'Caminho: ' + strArqTxt, ['&Ok']);
    Result := False;
    Exit;
  End;

  pZapTable('BZI_CADBZI');

  qryCadCol := TUniQuery.Create(Nil);
  qryCadBas := TUniQuery.Create(Nil);

  qryCadNfm := fCriaQuery(Nil);

  qryCadCol.Connection := frmModulo.Database;
  qryCadBas.Connection := frmModulo.Database;

  qryCadCol.SQL.Add('SELECT                                                                                    ');
  qryCadCol.SQL.Add('  BZI_CADCOL.*,                                                                           ');
  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    qryCadCol.SQL.Add('  COL_PRECUS AS ITE_PRECUS, ');
    qryCadCol.SQL.Add('  COL_PREVEN AS ITE_PREVEN  ');
  End
  Else
  Begin
    qryCadCol.SQL.Add('  ITEGER.ITE_PRECUS,                                                                      ');
    qryCadCol.SQL.Add('  ITEGER.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
  End;
  qryCadCol.SQL.Add('FROM                                                                                      ');
  qryCadCol.SQL.Add('  BZI_CADCOL                                                                              ');
  qryCadCol.SQL.Add('JOIN ITEGER ON ITEGER.ITE_CODITE = BZI_CADCOL.COL_CODITE                                  ');
  qryCadCol.SQL.Add('            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ');
  qryCadCol.Open;

  stlArqTxt := TStringList.Create;
  stlArqTxt.LoadFromFile(strArqTxt);
  intTamArq := stlArqTxt.Count;
  intPosAtual := 2;

  Result := False;

  While (intPosAtual < intTamArq) Do
  Begin

    Application.ProcessMessages;

    For intContador := Low(arrColBzi) To High(arrColBzi) Do
    Begin
      arrColBzi[intContador].strCodCol := '';
      arrColBzi[intContador].fltQtdCol := 0.0;
    End;

    strLinhaAtual := stlArqTxt[intPosAtual];

    strCodigo     := Trim(Copy(strLinhaAtual, 01, 10));
    strLinha      := Trim(Copy(strLinhaAtual, 51, 05));
    strDesCri     := Trim(AnsiUpperCase(fTiraCaracEspeciais(Copy(strLinhaAtual, 57, 44))));
    strRefere     := Trim(AnsiUpperCase(fTiraCaracEspeciais(Copy(strLinhaAtual, 101, 15))));
    strCodBas     := Trim(fPadR(AnsiUpperCase(fTiraCaracEspeciais(Copy(strLinhaAtual, 116, 10))), 5));
    strDesBas     := Trim(AnsiUpperCase(fTiraCaracEspeciais(Copy(strLinhaAtual, 057, 044))));

    If (Not blnGerarBases) Then
    Begin
      pBuscaBaseBasimixImobiliaria(qryCadBas, strLinha, strCodBas);

      If (qryCadBas.IsEmpty) Then
      Begin
        Inc(intPosAtual);
        Continue;
      End;
    End;

    {*******************************************}
    {* GERA COLORANTES                         *}
    {****************************************MV*}
    strColorantes := Copy(strLinhaAtual, 126, Length(strLinhaAtual));

    intPosCol   := 1;
    intContador := 1;

    fltCusCol := 0.0;
    fltVenCol := 0.0;

    While (intContador < Length(strColorantes)) Do
    Begin

      strColAtu := Copy(strColorantes, intContador, 20);

      arrColBzi[intPosCol].strCodCol := Trim(LeftStr(strColAtu, 10));
      arrColBzi[intPosCol].fltQtdCol := fStrToFloat(Trim(RightStr(strColAtu, 10)));

      Inc(intContador, 20);

      If (fEmptyStr(arrColBzi[intPosCol].strCodCol)) Then
      Begin
        Continue;
      End;

      If (Not blnGerarBases) Then
      Begin
        qryCadCol.Locate('COL_CODCOL', arrColBzi[intPosCol].strCodCol, []);
        //fltCusCol := fltCusCol + (arrColBzi[intPosCol].fltQtdCol / 18925.00) * (qryCadCol.FieldByName('COL_PRECUS').AsFloat / 1000);
        //fltVenCol := fltVenCol + (arrColBzi[intPosCol].fltQtdCol / 18925.00) * (qryCadCol.FieldByName('COL_PREVEN').AsFloat / 1000);
        fltCusCol := fltCusCol + fRetornaPrecoColorante(arrColBzi[intPosCol].fltQtdCol,
                                                        qryCadCol.FieldByName('ITE_PRECUS').AsFloat,
                                                        qryCadCol.FieldByName('COL_PESESP').AsFloat);

        fltVenCol := fltVenCol + fRetornaPrecoColorante(arrColBzi[intPosCol].fltQtdCol,
                                                        qryCadCol.FieldByName('ITE_PREVEN').AsFloat,
                                                        qryCadCol.FieldByName('COL_PESESP').AsFloat);
      End;

      Inc(intPosCol);

    End;

    Result := False;

    If (blnGerarBases) Then
    Begin
      Result := fGravarCadBas(strLinha, strCodBas, strDesBas) And fGravarCadCol(arrColBzi);
    End
    Else
    Begin
      While (Not qryCadBas.Eof) Do
      Begin

        If (fArqIniTinta(0, 'USA_FORMUL', 'BZI', 'S') <> 'S') Then
        Begin

          For intContador := Low(arrColBzi) To High(arrColBzi) Do
          Begin
            arrColBzi[intContador].strCodCol := '';
            arrColBzi[intContador].fltQtdCol := 0.0;
          End;

        End;

        strUnidad := qryCadBas.FieldByName('BAS_SIGUNI').AsString;

        fltPreCus := fRetornaPrecoTinta(strUnidad, qryCadBas.FieldByName('ITE_PRECUS').AsFloat, fltCusCol);
        fltPreVen := fRetornaPrecoTinta(strUnidad, qryCadBas.FieldByName('ITE_PREVEN').AsFloat, fltVenCol);

        Application.ProcessMessages;

        Result := fGravaBziCadBzi(qryCadBas.FieldByName('BAS_CODITE').AsString,
                                  strCodigo,
                                  strDesCri + ' ' + strCodBas,
                                  strRefere,
                                  strUnidad,
                                  fltPreVen,
                                  fltPreCus,
                                  VS_strCodEmp,
                                  arrColBzi[01].strCodCol,
                                  arrColBzi[01].fltQtdCol,
                                  arrColBzi[02].strCodCol,
                                  arrColBzi[02].fltQtdCol,
                                  arrColBzi[03].strCodCol,
                                  arrColBzi[03].fltQtdCol,
                                  arrColBzi[04].strCodCol,
                                  arrColBzi[04].fltQtdCol,
                                  arrColBzi[05].strCodCol,
                                  arrColBzi[05].fltQtdCol,
                                  arrColBzi[06].strCodCol,
                                  arrColBzi[06].fltQtdCol,
                                  arrColBzi[07].strCodCol,
                                  arrColBzi[07].fltQtdCol,
                                  arrColBzi[08].strCodCol,
                                  arrColBzi[08].fltQtdCol,
                                  arrColBzi[09].strCodCol,
                                  arrColBzi[09].fltQtdCol,
                                  arrColBzi[10].strCodCol,
                                  arrColBzi[10].fltQtdCol,
                                  fltCusCol,
                                  fltVenCol,
                                  intAutInc,
                                  '',
                                  qryCadBas.FieldByName('BAS_LINHA_').AsString,
                                  qryCadBas.FieldByName('BAS_BASE__').AsString,
                                  qryCadBas.FieldByName('BAS_UNIDAD').AsString);

        If (Not Result) Then
          Break;

        qryCadBas.Next;

      End;
    End;

    If (Not Result) Then
      Break;

    Inc(intPosAtual);
  End;

  If (Not blnGerarBases) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  PRO_AUTINC = :AUTINC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = "BZI_CADBZI" ';

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
      SQL.Add('SELECT * FROM BZI_CADNFM');
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
  End;

  FreeAndNil(stlArqTxt);
  FreeAndNil(qryCadCol);
  FreeAndNil(qryCadBas);

end;

procedure pBuscaBaseBasimixImobiliaria(qryCadBas: TUniQuery; strLinha, strCodBas: String);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BZI_CADBAS.*, ';

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    strSQL := strSQL + '  BAS_PRECUS AS ITE_PRECUS, ';
    strSQL := strSQL + '  BAS_PREVEN AS ITE_PREVEN, ';
  End
  Else
  Begin
    strSQL := strSQL + '  ITEGER.ITE_PRECUS, ';
    strSQL := strSQL + '  ITEGER.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN, ';
  End;

  strSQL := strSQL + '  UNI_SIGUNI AS BAS_SIGUNI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZI_CADBAS ';
  strSQL := strSQL + 'JOIN CADUNI ON BAS_UNIDAD = UNI_CODUNI ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = BAS_CODITE ';
  strSQL := strSQL + '               AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_LINHA_ = :LINHA AND ';
  strSQL := strSQL + '  BAS_BASE__ = :BASE ';

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('LINHA').AsString := strLinha;
    ParamByName('BASE').AsString  := strCodBas;
    Open;
  End;

end;

procedure pPosicionaItem(qryCadIte: TUniQuery; strCodIte: String);
  Var
    strSQL: String;
begin

{  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADITE.*, ';
  strSQL := strSQL + '  ITEGER.* ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE, ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ';
  strSQL := strSQL + '  CADITE.ITE_CODEMP = ITEGER.ITE_CODEMP AND ';
  strSQL := strSQL + '  CADITE.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  CADITE.ITE_CODEMP = :CODEMP ';}

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
  End;

end;

function fGravaBziCadBzi(strCodIte,
                         strCodigo,
                         strDescri,
                         strRefere,
                         strUnidad: String;
                         fltPreVen,
                         fltPreCus: Double;
                         strCodEmp,
                         strCodC01: String;
                         fltQtdC01: Double;
                         strCodC02: String;
                         fltQtdC02: Double;
                         strCodC03: String;
                         fltQtdC03: Double;
                         strCodC04: String;
                         fltQtdC04: Double;
                         strCodC05: String;
                         fltQtdC05: Double;
                         strCodC06: String;
                         fltQtdC06: Double;
                         strCodC07: String;
                         fltQtdC07: Double;
                         strCodC08: String;
                         fltQtdC08: Double;
                         strCodC09: String;
                         fltQtdC09: Double;
                         strCodC10: String;
                         fltQtdC10,
                         fltColCus,
                         fltColVen: Double;
                         Var intAutInc: Integer;
                         strAutoIncrem,
                         strLinha,
                         strCodBas,
                         strCodUni: String): Boolean;
  Var
    strSQL: String;
    qryGen002: TUniQuery;
Begin

  Try

    qryGen002 := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'INSERT DELAYED INTO BZI_CADBZI ';
    strSQL := strSQL + '( ';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  BZI_CODITE, ';
    strSQL := strSQL + '  BZI_CODIGO, ';
    strSQL := strSQL + '  BZI_DESCRI, ';
    strSQL := strSQL + '  BZI_REFERE, ';
    strSQL := strSQL + '  BZI_UNIDAD, ';
    strSQL := strSQL + '  BZI_PREVEN, ';
    strSQL := strSQL + '  BZI_PRECUS, ';
    strSQL := strSQL + '  BZI_CODEMP, ';
    strSQL := strSQL + '  BZI_CODC01, ';
    strSQL := strSQL + '  BZI_QTDC01, ';
    strSQL := strSQL + '  BZI_CODC02, ';
    strSQL := strSQL + '  BZI_QTDC02, ';
    strSQL := strSQL + '  BZI_CODC03, ';
    strSQL := strSQL + '  BZI_QTDC03, ';
    strSQL := strSQL + '  BZI_CODC04, ';
    strSQL := strSQL + '  BZI_QTDC04, ';
    strSQL := strSQL + '  BZI_CODC05, ';
    strSQL := strSQL + '  BZI_QTDC05, ';
    strSQL := strSQL + '  BZI_CODC06, ';
    strSQL := strSQL + '  BZI_QTDC06, ';
    strSQL := strSQL + '  BZI_CODC07, ';
    strSQL := strSQL + '  BZI_QTDC07, ';
    strSQL := strSQL + '  BZI_CODC08, ';
    strSQL := strSQL + '  BZI_QTDC08, ';
    strSQL := strSQL + '  BZI_CODC09, ';
    strSQL := strSQL + '  BZI_QTDC09, ';
    strSQL := strSQL + '  BZI_CODC10, ';
    strSQL := strSQL + '  BZI_QTDC10, ';
    strSQL := strSQL + '  BZI_COLCUS, ';
    strSQL := strSQL + '  BZI_MD5KEY, ';
    strSQL := strSQL + '  BZI_COLVEN) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :AUTINC, ';
    strSQL := strSQL + '  :CODITE, ';
    strSQL := strSQL + '  :CODIGO, ';
    strSQL := strSQL + '  :DESCRI, ';
    strSQL := strSQL + '  :REFERE, ';
    strSQL := strSQL + '  :UNIDAD, ';
    strSQL := strSQL + '  :PREVEN, ';
    strSQL := strSQL + '  :PRECUS, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :CODC01, ';
    strSQL := strSQL + '  :QTDC01, ';
    strSQL := strSQL + '  :CODC02, ';
    strSQL := strSQL + '  :QTDC02, ';
    strSQL := strSQL + '  :CODC03, ';
    strSQL := strSQL + '  :QTDC03, ';
    strSQL := strSQL + '  :CODC04, ';
    strSQL := strSQL + '  :QTDC04, ';
    strSQL := strSQL + '  :CODC05, ';
    strSQL := strSQL + '  :QTDC05, ';
    strSQL := strSQL + '  :CODC06, ';
    strSQL := strSQL + '  :QTDC06, ';
    strSQL := strSQL + '  :CODC07, ';
    strSQL := strSQL + '  :QTDC07, ';
    strSQL := strSQL + '  :CODC08, ';
    strSQL := strSQL + '  :QTDC08, ';
    strSQL := strSQL + '  :CODC09, ';
    strSQL := strSQL + '  :QTDC09, ';
    strSQL := strSQL + '  :CODC10, ';
    strSQL := strSQL + '  :QTDC10, ';
    strSQL := strSQL + '  :COLCUS, ';
    strSQL := strSQL + '  :MD5KEY, ';
    strSQL := strSQL + '  :COLVEN) ';

    With qryGen002 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If (intAutInc > 0)  Then
        ParamByName('AUTINC').AsString  := fFormataAutInc(intAutInc, VS_strCodEmp)
      Else
        ParamByName('AUTINC').AsString  := strAutoIncrem;

      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('CODIGO').AsString  := strCodigo;
      ParamByName('DESCRI').AsString  := strDescri;
      ParamByName('REFERE').AsString  := strRefere;
      ParamByName('UNIDAD').AsString  := strUnidad;
      ParamByName('PREVEN').AsFloat   := fFormataFloat(fltPreVen, 2);
      ParamByName('PRECUS').AsFloat   := fFormataFloat(fltPreCus, 2);
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODC01').AsString  := strCodC01;
      ParamByName('QTDC01').AsFloat   := fltQtdC01;
      ParamByName('CODC02').AsString  := strCodC02;
      ParamByName('QTDC02').AsFloat   := fltQtdC02;
      ParamByName('CODC03').AsString  := strCodC03;
      ParamByName('QTDC03').AsFloat   := fltQtdC03;
      ParamByName('CODC04').AsString  := strCodC04;
      ParamByName('QTDC04').AsFloat   := fltQtdC04;
      ParamByName('CODC05').AsString  := strCodC05;
      ParamByName('QTDC05').AsFloat   := fltQtdC05;
      ParamByName('CODC06').AsString  := strCodC06;
      ParamByName('QTDC06').AsFloat   := fltQtdC06;
      ParamByName('CODC07').AsString  := strCodC07;
      ParamByName('QTDC07').AsFloat   := fltQtdC07;
      ParamByName('CODC08').AsString  := strCodC08;
      ParamByName('QTDC08').AsFloat   := fltQtdC08;
      ParamByName('CODC09').AsString  := strCodC09;
      ParamByName('QTDC09').AsFloat   := fltQtdC09;
      ParamByName('CODC10').AsString  := strCodC10;
      ParamByName('QTDC10').AsFloat   := fltQtdC10;
      ParamByName('COLCUS').AsFloat   := fFormataFloat(fltColCus, 2);
      ParamByName('COLVEN').AsFloat   := fFormataFloat(fltColVen, 2);
      ParamByName('MD5KEY').AsString  := GetMD5(ParamByName('CODIGO').AsString +
                                              ParamByName('DESCRI').AsString +
                                              ParamByName('REFERE').AsString +
                                              ParamByName('UNIDAD').AsString +
                                              ParamByName('CODBAS').AsString +
                                              ParamByName('CODUNI').AsString);
      ExecSQL;
      Close;
    End;

    Result := True;
    Inc(intAutInc);

    FreeAndNil(qryGen002);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaBziCadBzi]');
      Result := False;
    End;
  End;

End;

{*******************************************}
{* CALCULA O PRECO DE CUSTO E VENDA DE 1   *}
{* COLORANTE                               *}
{****************************************MV*}
function fRetornaPrecoColorante(fltQtdCol, fltPreCad, fltPesEsp: Double): Double;
Begin
  //Result := (fltQtdCol / 18925.00) * (fltPreCad / 1000);
  Result := (((fltQtdCol / 100.0) / 20.0) / fltPesEsp) * (fltPreCad / 1000);
End;

function fRetornaPrecoTinta(strUnidad: String; fltPreIte, fltPreCol: Double): Double;
begin
  Result := 0.0;

  If (strUnidad = 'LT') Then
  Begin
    Result := fltPreIte + fltPreCol;
  End

  Else If (strUnidad = 'GL') Then
  Begin
    Result := (fltPreIte) + (fltPreCol * 4);
  End

  Else If (strUnidad = 'LA') Then
  Begin
    Result := (fltPreIte) + (fltPreCol * 18);
  End;
end;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    intContador: Integer;
    strAutInc: String;
    fltCusCol: Double;
    fltVenCol: Double;

    strSQL: String;
    qryCadBas: TUniQuery;
begin

  qryCadBas := TUniQuery.Create(Nil);
  qryCadBas.Connection := frmModulo.Database;

  fltCusCol := 0.0;
  fltVenCol := 0.0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COL_PESESP, ';
  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    strSQL := strSQL + ' COL_PRECUS AS ITE_PRECUS, ';
    strSQL := strSQL + ' COL_PREVEN AS ITE_PREVEN  ';
  End
  Else
  Begin
    strSQL := strSQL + ' ITEGER.ITE_PRECUS,                                                                      ';
    strSQL := strSQL + ' ITEGER.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZI_CADCOL ';
  strSQL := strSQL + 'JOIN ITEGER ON ITEGER.ITE_CODITE = BZI_CADCOL.COL_CODITE                                  ';
  strSQL := strSQL + '            AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
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

    If (fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + fStrZero(intContador, 2)).AsString)) Then
      Break;

    frmModuloTinta.qryGen001.Close;
    frmModuloTinta.qryGen001.ParamByName('CODCOL').AsString := qryCadNfm.FieldByName('NFM_CODC' + fStrZero(intContador, 2)).AsString;
    frmModuloTinta.qryGen001.Open;

    fltCusCol := fltCusCol + fRetornaPrecoColorante(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsFloat,
                                                    frmModuloTinta.qryGen001.FieldByName('ITE_PRECUS').AsFloat,
                                                    frmModuloTinta.qryGen001.FieldByName('COL_PESESP').AsFloat);

    fltVenCol := fltVenCol + fRetornaPrecoColorante(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intContador, 2)).AsFloat,
                                                    frmModuloTinta.qryGen001.FieldByName('ITE_PREVEN').AsFloat,
                                                    frmModuloTinta.qryGen001.FieldByName('COL_PESESP').AsFloat);

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BZI_CADBAS.*, ';

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    strSQL := strSQL + '  BAS_PRECUS AS ITE_PRECUS, ';
    strSQL := strSQL + '  BAS_PREVEN AS ITE_PREVEN, ';
  End
  Else
  Begin
    strSQL := strSQL + '  ITEGER.ITE_PRECUS, ';
    strSQL := strSQL + '  ITEGER.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN, ';
  End;

  strSQL := strSQL + '  UNI_SIGUNI AS BAS_SIGUNI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZI_CADBAS ';
  strSQL := strSQL + 'JOIN CADUNI ON UNI_CODUNI = BAS_UNIDAD ';
  strSQL := strSQL + 'JOIN ITEGER ON ITE_CODITE = BAS_CODITE ';
  strSQL := strSQL + '               AND ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_LINHA_ = :LINHA_ AND ';
  strSQL := strSQL + '  BAS_BASE__ = :BASE__ AND ';
  strSQL := strSQL + '  UNI_SIGUNI IN ("LT","GL","LA") AND ';
  strSQL := strSQL + '  BAS_CODEMP = :CODEMP ';

  With qryCadBas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
    ParamByName('BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  pDeletaNovaFormula(qryCadNfm.FieldByName('NFM_CODIGO').AsString);

  Result := True;

  While not qryCadBas.Eof Do
  Begin

    strAutInc := fRetAutoIncrem('BZI_CADBZI', VS_strCodEmp);
    {*******************************************}
    {* USA INCCONTADOR APENAS PARA SINALIZAR   *}
    {* QUE NAO VAI GERAR O AUTOINCREMENTO      *}
    {****************************************MV*}
    intContador := 0;

    Result := fGravaBziCadBzi('', //qryCadBas.FieldByName('BAS_CODITE').AsString,
                              qryCadNfm.FieldByName('NFM_CODIGO').AsString,
                              qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_BASE__').AsString,
                              qryCadNfm.FieldByName('NFM_CODIGO').AsString,
                              qryCadBas.FieldByName('BAS_UNIDAD').AsString,//qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                              0, //fltPreVen,
                              0, //fltPreCus,
                              VS_strCodEmp,
                              qryCadNfm.FieldByName('NFM_CODC01').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC01').AsFloat,
                              qryCadNfm.FieldByName('NFM_CODC02').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC02').AsFloat,
                              qryCadNfm.FieldByName('NFM_CODC03').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC03').AsFloat,
                              qryCadNfm.FieldByName('NFM_CODC04').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC04').AsFloat,
                              qryCadNfm.FieldByName('NFM_CODC05').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC05').AsFloat,
                              qryCadNfm.FieldByName('NFM_CODC06').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC06').AsFloat,
                              qryCadNfm.FieldByName('NFM_CODC07').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC07').AsFloat,
                              qryCadNfm.FieldByName('NFM_CODC08').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC08').AsFloat,
                              qryCadNfm.FieldByName('NFM_CODC09').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC09').AsFloat,
                              qryCadNfm.FieldByName('NFM_CODC10').AsString,
                              qryCadNfm.FieldByName('NFM_QTDC10').AsFloat,
                              0, //fltCusCol,
                              0, //fltVenCol,
                              intContador,
                              strAutInc,
                              qryCadBas.FieldByName('BAS_LINHA_').AsString,
                              qryCadBas.FieldByName('BAS_BASE__').AsString,
                              qryCadBas.FieldByName('BAS_UNIDAD').AsString);
    qryCadBas.Next;
  End;

  frmModuloTinta.qryGen001.Close;

  FreeAndNil(qryCadBas);
end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM BZI_CADBZI WHERE BZI_CODIGO = :CODIGO ';

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

{ TBrasimixImobiliaria }

function TBrasimixImobiliaria.fGravaNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM BZI_CADBZI WHERE BZI_CODIGO IN (SELECT NFM_CODIGO FROM BZI_CADNFM);';
  qryGen.ExecSQL;

  qryGen.SQL.Text := 'SELECT * FROM BZI_CADNFM';
  qryGen.Open;

  qryGen.First;

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    Result := fGeraNovasFormulas(qryGen);

    If Not Result Then Break;

    qryGen.Next;
    pRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');
  FreeAndNil(qryGen);
  Result := True;
end;

function TBrasimixImobiliaria.fGravarNovasFormulas: Boolean;
begin
  Result := fGravaNovasFormulas;
end;

function fGravarCadBas(strLinha, strCodBas, strDesBas: String): Boolean;
  Var
    qryCadBas: TUniQuery;
    strUnidad: String;
    intContador: Integer;
begin
  qryCadBas := fCriaQuery(Nil);
  qryCadBas.SQL.Add('SELECT * FROM BZI_CADBAS WHERE BAS_LINHA_= :LINHA_ AND BAS_BASE__ = :CODBAS');
  qryCadBas.ParamByName('LINHA_').AsString := strLinha;
  qryCadBas.ParamByName('CODBAS').AsString := strCodBas;
  qryCadBas.Open;

  If (qryCadBas.IsEmpty) Then
  Begin
    For intContador := 1 To 3 Do
    Begin

           If intContador = 1 Then strUnidad := 'LT'
      Else If intContador = 2 Then strUnidad := 'GL'
      Else If intContador = 3 Then strUnidad := 'LA';

      qryCadBas.Append;
      qryCadBas.FieldByName('BAS_LINHA_').AsString := strLinha;
      qryCadBas.FieldByName('BAS_BASE__').AsString := strCodBas;
      qryCadBas.FieldByName('BAS_UNIDAD').AsString := strUnidad;
      qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryCadBas.FieldByName('BAS_DESCRI').AsString := strDesBas;
      qryCadBas.FieldByName('BAS_PRECUS').AsFloat  := 0;
      qryCadBas.FieldByName('BAS_PREVEN').AsFloat  := 0;
      qryCadBas.FieldByName('BAS_MARGEM').AsFloat  := 0;
      qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BZI_CADBAS', VS_strCodEmp);
      qryCadBas.Post;
    End;
  End;

  FreeAndNil(qryCadBas);
  Result := True;
end;

function fGravarCadCol(arrColBzi: TBziArrCol): Boolean;
  Var
    qryCadCol: TUniQuery;
    intContador: Integer;
begin
  qryCadCol := fCriaQuery(Nil);
  qryCadCol.SQL.Add('SELECT * FROM BZI_CADCOL WHERE COL_CODCOL = :CODCOL');

  For intContador := Low(arrColBzi) To High(arrColBzi) Do
  Begin

    If (fEmptyStr(arrColBzi[intContador].strCodCol)) Then
      Break;
      
    qryCadCol.Close;
    qryCadCol.ParamByName('CODCOL').AsString := arrColBzi[intContador].strCodCol;
    qryCadCol.Open;

    If (qryCadCol.IsEmpty) Then
    Begin
      qryCadCol.Append;
      qryCadCol.FieldByName('COL_CODCOL').AsString := arrColBzi[intContador].strCodCol;
      qryCadCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
      qryCadCol.FieldByName('COL_PRECUS').AsFloat  := 0;
      qryCadCol.FieldByName('COL_MARGEM').AsFloat  := 0;
      qryCadCol.FieldByName('COL_PREVEN').AsFloat  := 0;
      qryCadCol.FieldByName('COL_PESESP').AsFloat  := 1;
      qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BZI_CADCOL', VS_strCodEmp);
      qryCadCol.Post;
    End;

  End;

  FreeAndNil(qryCadCol);
  Result := True;
end;

end.


