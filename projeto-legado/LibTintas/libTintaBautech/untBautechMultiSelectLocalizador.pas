unit untBautechMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TBautechMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private
    function fGetSQLTin(strTabela: String): String;
    function fGetFields(strAbr: String): String;
    function fGetUnionTin: String;
  public
    constructor Create(); override;
  end;

  TBautechMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private
    function fGetSQLTin(strTabela: String): String;
    function fGetFields(strAbr: String): String;
    function fGetUnionTin: String;
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TBautechMultiSelectLocalizador }

constructor TBautechMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT BAU_MD5KEY FROM BAU_CADBAU WHERE FALSE', 'BAU_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   BAU_CADBAU               ' +
      ' WHERE BAU_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   BAU_CADBAU     ' +
    ' WHERE CONCAT(    ' +
    '       BAU_CODBAS ' +
    '     , " "        ' +
    '     , BAU_UNIDAD ' +
    '     , BAU_DESCRI ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   BAU_CADBAU     ' +
    ' WHERE CONCAT(    ' +
    '      BAU_UNIDAD ' +
    '     , BAU_DESCRI ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   BAU_CADBAU     ' +
    ' WHERE CONCAT(    ' +
    '     BAU_DESCRI   ' +
    '     , " "        ' +
    '     , BAU_CODBAS ' +
    '     , " "        ' +
    '     , BAU_UNIDAD ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT                             ' +
    '   *                                ' +
    ' FROM                               ' +
    '   BAU_CADBAU                       ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(       ' +
    '           IFNULL(BAU_DESCRI, "")   ' +
    '           , IFNULL(BAU_UNIDAD, "") ' +
    '           , IFNULL(BAU_CODBAS, "") ' +
    '           , IFNULL(BAU_CODUNI, "") ' +
    '           , IFNULL(BAU_NOMCOR, "") ' +
    '         )) AS CHAR)) = :ITETIN     ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   BAU_CADBAU                   ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(   ' +
    '             BAU_CODBAS         ' +
    '           , " "                ' +
    '           , BAU_UNIDAD         ' +
    '           , BAU_DESCRI         ' +
    '         )) AS CHAR)) = :ITETIN ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   *                                                        ' +
    ' FROM                                                       ' +
    '   BAU_CADBAU                                               ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(BAU_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB15, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   *                                                        ' +
    ' FROM                                                       ' +
    '   BAU_CADBAU                                               ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(BAU_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB15, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM16, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB16, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM17, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB17, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM18, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB18, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM19, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB19, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM20, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB20, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add( fGetUnionTin );
end;

function TBautechMultiSelectLocalizador.fGetFields(strAbr: String): String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 1 To MAX_QTD_BAS Do
  Begin
    Result := Result + strAbr + 'FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ' AS BAU_FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ';
    Result := Result + '(' + strAbr + 'QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ' / ' + strAbr + 'QTDITE) AS BAU_QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ';
  End;
  Result := Result + strAbr + 'DTAENT DTAENT, ' + strAbr + 'HORENT HORENT ';
end;

function TBautechMultiSelectLocalizador.fGetSQLTin(strTabela: String): String;
  Var
    strSQL : String;
    strAbr : String;
begin
  strSQL := '';
  If (strTabela = 'TINDET') Then
    strAbr := 'DET_'
  Else
    strAbr := 'FDO_';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + fGetFields(strAbr);
  strSQL := strSQL + '   FROM ' + strTabela;
  strSQL := strSQL + '  WHERE ' + strAbr + 'ITETIN = :ITETIN ';
  Result := strSQL; 
end;

function TBautechMultiSelectLocalizador.fGetUnionTin: String;

  function fGetFields: String;
    Var
      intCnt : Integer;
  begin
    Result := '';
    For intCnt := 1 To MAX_QTD_BAS Do
    Begin
      Result := Result + ' BAU_QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ' ;
      Result := Result + ' BAU_FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ' ;
    End;
    Result := Result + 'DTAENT, HORENT ';
  end;

  Var
    strSQL : String;
begin
  strSQL :=          ' SELECT ';
  strSQL := strSQL + fGetFields;
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + ' ( ';
  strSQL := strSQL + fGetSQLTin('TINDET') + ' UNION ALL ';
  strSQL := strSQL + fGetSQLTin('TINDOR') + '  ';
  strSQL := strSQL + ' ) TMPUNION ';
  strSQL := strSQL + ' ORDER BY DTAENT DESC, HORENT DESC ';
  strSQL := strSQL + ' LIMIT 1 ';
  Result := strSQL;
end;

{ TBautechMultiSelectLocalizadorBase }

constructor TBautechMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAU_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BAU_CADBAS B                      ' +
    '   INNER JOIN BAU_CADBAU S           ' +
    '     ON  B.BAS_CODBAS = S.BAU_CODBAS ' +
    '     AND B.BAS_CODUNI = S.BAU_CODUNI ' +
    '     AND B.BAS_DESCRI = S.BAU_PRODUT ' +
    ' WHERE BAU_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAU_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BAU_CADBAS B                      ' +
    '   INNER JOIN BAU_CADBAU S           ' +
    '     ON  B.BAS_CODBAS = S.BAU_CODBAS ' +
    '     AND B.BAS_CODUNI = S.BAU_CODUNI ' +
    '     AND B.BAS_DESCRI = S.BAU_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '       S.BAU_CODBAS                  ' +
    '     , " "                           ' +
    '     , S.BAU_UNIDAD                  ' +
    '     , S.BAU_DESCRI                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAU_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BAU_CADBAS B                      ' +
    '   INNER JOIN BAU_CADBAU S           ' +
    '     ON  B.BAS_CODBAS = S.BAU_CODBAS ' +
    '     AND B.BAS_CODUNI = S.BAU_CODUNI ' +
    '     AND B.BAS_DESCRI = S.BAU_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     , S.BAU_UNIDAD                  ' +
    '     , S.BAU_DESCRI                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAU_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BAU_CADBAS B                      ' +
    '   INNER JOIN BAU_CADBAU S           ' +
    '     ON  B.BAS_CODBAS = S.BAU_CODBAS ' +
    '     AND B.BAS_CODUNI = S.BAU_CODUNI ' +
    '     AND B.BAS_DESCRI = S.BAU_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     S.BAU_DESCRI                    ' +
    '     , " "                           ' +
    '     , S.BAU_CODBAS                  ' +
    '     , " "                           ' +
    '     , S.BAU_UNIDAD                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                               ' +
    '   B.BAS_CODITE AS CODITE             ' +
    ' FROM                                 ' +
    '   BAU_CADBAS B                       ' +
    '   INNER JOIN BAU_CADBAU S            ' +
    '     ON B.BAS_CODBAS = S.BAU_CODBAS   ' +
    '     AND B.BAS_CODUNI = S.BAU_CODUNI  ' +
    '     AND B.BAS_DESCRI = S.BAU_PRODUT  ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(         ' +
    '           IFNULL(S.BAU_DESCRI, "")   ' +
    '           , IFNULL(S.BAU_UNIDAD, "") ' +
    '           , IFNULL(S.BAU_CODBAS, "") ' +
    '           , IFNULL(S.BAU_CODUNI, "") ' +
    '           , IFNULL(S.BAU_NOMCOR, "") ' +
    '         )) AS CHAR)) = :ITETIN       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BAU_CADBAS B                      ' +
    '   INNER JOIN BAU_CADBAU S           ' +
    '     ON  B.BAS_CODBAS = S.BAU_CODBAS ' +
    '     AND B.BAS_CODUNI = S.BAU_CODUNI ' +
    '     AND B.BAS_DESCRI = S.BAU_PRODUT ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(        ' +
    '             S.BAU_CODBAS            ' +
    '           , " "                     ' +
    '           , S.BAU_UNIDAD            ' +
    '           , S.BAU_DESCRI            ' +
    '         )) AS CHAR)) = :ITETIN      ');
  Sqls.Add(
    ' SELECT                                                     ' +
    '   B.BAS_CODITE AS CODITE                                   ' +
    ' FROM                                                       ' +
    '   BAU_CADBAS B                                             ' +
    '   INNER JOIN BAU_CADBAU S                                  ' +
    '     ON  B.BAS_CODBAS = S.BAU_CODBAS                        ' +
    '     AND B.BAS_CODUNI = S.BAU_CODUNI                        ' +
    '     AND B.BAS_DESCRI = S.BAU_PRODUT                        ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(BAU_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB15, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   B.BAU_CODITE AS CODITE                                   ' +
    ' FROM                                                       ' +
    '   BAU_CADBAS B                                             ' +
    '   INNER JOIN BAU_CADBAU S                                  ' +
    '     ON  B.BAS_CODBAS = S.BAU_CODBAS                        ' +
    '     AND B.BAS_CODUNI = S.BAU_CODUNI                        ' +
    '     AND B.BAS_DESCRI = S.BAU_PRODUT                        ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(BAU_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB15, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM16, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB16, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM17, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB17, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM18, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB18, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM19, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB19, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(BAU_FORM20, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(BAU_QTDB20, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add( fGetUnionTin );
end;

function TBautechMultiSelectLocalizadorBase.fGetFields(strAbr: String): String;
begin
  Result :=          strAbr  + 'CODITE AS CODITE, ';
  Result := Result + strAbr  + 'DTAENT AS DTAENT, ';
  Result := Result + strAbr  + 'HORENT AS HORENT  ';
end;

function TBautechMultiSelectLocalizadorBase.fGetSQLTin(
  strTabela: String): String;
  Var
    strSQL : String;
    strAbr : String;
begin
  strSQL := '';
  If (strTabela = 'TINDET') Then
    strAbr := 'DET_'
  Else
    strAbr := 'FDO_';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + fGetFields(strAbr);
  strSQL := strSQL + '   FROM ' + strTabela;
  strSQL := strSQL + '  WHERE ' + strAbr + 'ITETIN = :ITETIN ';
  Result := strSQL;
end;

function TBautechMultiSelectLocalizadorBase.fGetUnionTin: String;
  Var
    strSQL : String;
begin
  strSQL :=          ' SELECT * ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + ' ( ';
  strSQL := strSQL + fGetSQLTin('TINDET') + ' UNION ALL ';
  strSQL := strSQL + fGetSQLTin('TINDOR') + '  ';
  strSQL := strSQL + ' ) TMPUNION ';
  strSQL := strSQL + ' ORDER BY DTAENT DESC, HORENT DESC ';
  strSQL := strSQL + ' LIMIT 1 ';
  Result := strSQL;
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('BAU', TBautechMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('BAUBAS', TBautechMultiSelectLocalizadorBase);

end.
