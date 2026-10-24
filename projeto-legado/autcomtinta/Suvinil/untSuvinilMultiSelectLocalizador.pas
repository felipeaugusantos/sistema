unit untSuvinilMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador,  SysUtils;

const
  MAX_QTD_BAS = 15;

type
  TSuvinilMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private
    function fGetSQLTin(strTabela: String): String;
    function fGetFields(strAbr: String): String;
    function fGetUnionTin: String;
  public
    constructor Create(); override;
  end;

  TSuvinilMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private
    function fGetSQLTin(strTabela: String): String;
    function fGetFields(strAbr: String): String;
    function fGetUnionTin: String;
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory,untFuncoesSimples;

{ TSuvinilMultiSelectLocalizador }

constructor TSuvinilMultiSelectLocalizador.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   SUV_CADSUV               ' +
    ' WHERE SUV_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   SUV_CADSUV     ' +
    ' WHERE CONCAT(    ' +
    '     SUV_REFERE   ' +
    '     , " "        ' +
    '     , SUV_CODBAS ' +
    '     , " "        ' +
    '     , SUV_CODFML ' +
    '     , SUV_UNIDAD ' +
    '     , SUV_DESCRI ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   SUV_CADSUV     ' +
    ' WHERE CONCAT(    ' +
    '     SUV_REFERE   ' +
    '     , SUV_UNIDAD ' +
    '     , SUV_DESCRI ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   SUV_CADSUV     ' +
    ' WHERE CONCAT(    ' +
    '     SUV_DESCRI   ' +
    '     , " "        ' +
    '     , SUV_CODBAS ' +
    '     , " "        ' +
    '     , SUV_CODFML ' +
    '     , SUV_UNIDAD ' +
    '     , SUV_REFERE ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT                             ' +
    '   *                                ' +
    ' FROM                               ' +
    '   SUV_CADSUV                       ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(       ' +
    '           IFNULL(SUV_DESCRI, "")   ' +
    '           , IFNULL(SUV_REFERE, "") ' +
    '           , IFNULL(SUV_UNIDAD, "") ' +
    '           , IFNULL(SUV_CODFML, "") ' +
    '           , IFNULL(SUV_CODBAS, "") ' +
    '           , IFNULL(SUV_CODUNI, "") ' +
    '           , IFNULL(SUV_NOMCOR, "") ' +
    '         )) AS CHAR)) = :ITETIN     ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   SUV_CADSUV                   ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(   ' +
    '           SUV_REFERE           ' +
    '           , " "                ' +
    '           , SUV_CODBAS         ' +
    '           , " "                ' +
    '           , SUV_CODFML         ' +
    '           , SUV_UNIDAD         ' +
    '           , SUV_DESCRI         ' +
    '         )) AS CHAR)) = :ITETIN ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   *                                                        ' +
    ' FROM                                                       ' +
    '   SUV_CADSUV                                               ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(SUV_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB15, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add( fGetUnionTin );
end;

function TSuvinilMultiSelectLocalizador.fGetFields(strAbr: String): String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 1 To MAX_QTD_BAS Do
  Begin
    Result := Result + strAbr + 'FORM' + fStrZero(IntToStr(intCnt),2) + ' AS SUV_FORM' + fStrZero(IntToStr(intCnt),2) + ', ';
    Result := Result + '( (' + strAbr + 'QTDB' + fStrZero(IntToStr(intCnt),2) + ' / ' + strAbr + 'QTDITE) / 0.154) AS SUV_QTDB' + fStrZero(IntToStr(intCnt),2) + ', ';
  End;
  Result := Result + strAbr + 'DTAENT DTAENT, ' + strAbr + 'HORENT HORENT, ' + strAbr + 'DESCRI SUV_DESCRI ';
end;

function TSuvinilMultiSelectLocalizador.fGetSQLTin(strTabela: String): String;
  Var
    strSQL : String;
    strAbr : String;
begin
  strSQL := '';
  If (strTabela = 'TINDET') Or (strTabela = 'TINDETX') Then
    strAbr := 'DET_'
  Else
    strAbr := 'FDO_';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + fGetFields(strAbr);
  strSQL := strSQL + '   FROM ' + strTabela;
  strSQL := strSQL + '  WHERE ' + strAbr + 'ITETIN = :ITETIN ';
  Result := strSQL; 
end;

function TSuvinilMultiSelectLocalizador.fGetUnionTin: String;

  function fGetFields: String;
    Var
      intCnt : Integer;
  begin
    Result := '';
    For intCnt := 1 To MAX_QTD_BAS Do
    Begin
      Result := Result + ' SUV_QTDB' + fStrZero(IntToStr(intCnt),2) + ', ' ;
      Result := Result + ' SUV_FORM' + fStrZero(IntToStr(intCnt),2) + ', ' ;
    End;
    Result := Result + 'DTAENT, HORENT, SUV_DESCRI ';
  end;

  Var
    strSQL : String;
begin
  strSQL :=          ' SELECT ';
  strSQL := strSQL + fGetFields;
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + ' ( ';
  strSQL := strSQL + fGetSQLTin('TINDET') + ' UNION ALL ';
  strSQL := strSQL + fGetSQLTin('TINDETX') + ' UNION ALL ';
  strSQL := strSQL + fGetSQLTin('TINDOR') + '  ';
  strSQL := strSQL + ' ) TMPUNION ';
  strSQL := strSQL + ' ORDER BY DTAENT DESC, HORENT DESC ';
  strSQL := strSQL + ' LIMIT 1 ';
  Result := strSQL;
end;

{ TSuvinilMultiSelectLocalizadorBase }

constructor TSuvinilMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.SUV_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   SUV_CADBAS B                      ' +
    '   INNER JOIN SUV_CADSUV S           ' +
    '     ON B.SUV_CODFML = S.SUV_CODFML  ' +
    '     AND B.SUV_CODBAS = S.SUV_CODBAS ' +
    '     AND B.SUV_CODUNI = S.SUV_CODUNI ' +
    ' WHERE SUV_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.SUV_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   SUV_CADBAS B                      ' +
    '   INNER JOIN SUV_CADSUV S           ' +
    '     ON B.SUV_CODFML = S.SUV_CODFML  ' +
    '     AND B.SUV_CODBAS = S.SUV_CODBAS ' +
    '     AND B.SUV_CODUNI = S.SUV_CODUNI ' +
    ' WHERE CONCAT(                       ' +
    '     S.SUV_REFERE                    ' +
    '     , " "                           ' +
    '     , S.SUV_CODBAS                  ' +
    '     , " "                           ' +
    '     , S.SUV_CODFML                  ' +
    '     , S.SUV_UNIDAD                  ' +
    '     , S.SUV_DESCRI                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.SUV_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   SUV_CADBAS B                      ' +
    '   INNER JOIN SUV_CADSUV S           ' +
    '     ON B.SUV_CODFML = S.SUV_CODFML  ' +
    '     AND B.SUV_CODBAS = S.SUV_CODBAS ' +
    '     AND B.SUV_CODUNI = S.SUV_CODUNI ' +
    ' WHERE CONCAT(                       ' +
    '     S.SUV_REFERE                    ' +
    '     , S.SUV_UNIDAD                  ' +
    '     , S.SUV_DESCRI                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.SUV_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   SUV_CADBAS B                      ' +
    '   INNER JOIN SUV_CADSUV S           ' +
    '     ON B.SUV_CODFML = S.SUV_CODFML  ' +
    '     AND B.SUV_CODBAS = S.SUV_CODBAS ' +
    '     AND B.SUV_CODUNI = S.SUV_CODUNI ' +
    ' WHERE CONCAT(                       ' +
    '     S.SUV_DESCRI                    ' +
    '     , " "                           ' +
    '     , S.SUV_CODBAS                  ' +
    '     , " "                           ' +
    '     , S.SUV_CODFML                  ' +
    '     , S.SUV_UNIDAD                  ' +
    '     , S.SUV_REFERE                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                               ' +
    '   B.SUV_CODITE AS CODITE             ' +
    ' FROM                                 ' +
    '   SUV_CADBAS B                       ' +
    '   INNER JOIN SUV_CADSUV S            ' +
    '     ON B.SUV_CODFML = S.SUV_CODFML   ' +
    '     AND B.SUV_CODBAS = S.SUV_CODBAS  ' +
    '     AND B.SUV_CODUNI = S.SUV_CODUNI  ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(         ' +
    '           IFNULL(S.SUV_DESCRI, "")   ' +
    '           , IFNULL(S.SUV_REFERE, "") ' +
    '           , IFNULL(S.SUV_UNIDAD, "") ' +
    '           , IFNULL(S.SUV_CODFML, "") ' +
    '           , IFNULL(S.SUV_CODBAS, "") ' +
    '           , IFNULL(S.SUV_CODUNI, "") ' +
    '           , IFNULL(S.SUV_NOMCOR, "") ' +
    '         )) AS CHAR)) = :ITETIN       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.SUV_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   SUV_CADBAS B                      ' +
    '   INNER JOIN SUV_CADSUV S           ' +
    '     ON B.SUV_CODFML = S.SUV_CODFML  ' +
    '     AND B.SUV_CODBAS = S.SUV_CODBAS ' +
    '     AND B.SUV_CODUNI = S.SUV_CODUNI ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(        ' +
    '           S.SUV_REFERE              ' +
    '           , " "                     ' +
    '           , S.SUV_CODBAS            ' +
    '           , " "                     ' +
    '           , S.SUV_CODFML            ' +
    '           , S.SUV_UNIDAD            ' +
    '           , S.SUV_DESCRI            ' +
    '         )) AS CHAR)) = :ITETIN      ');
  Sqls.Add(
    ' SELECT                                                     ' +
    '   B.SUV_CODITE AS CODITE                                   ' +
    ' FROM                                                       ' +
    '   SUV_CADBAS B                                             ' +
    '   INNER JOIN SUV_CADSUV S                                  ' +
    '     ON B.SUV_CODFML = S.SUV_CODFML                         ' +
    '     AND B.SUV_CODBAS = S.SUV_CODBAS                        ' +
    '     AND B.SUV_CODUNI = S.SUV_CODUNI                        ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(SUV_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(SUV_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(SUV_QTDB15, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add( fGetUnionTin );  
end;

function TSuvinilMultiSelectLocalizadorBase.fGetFields(strAbr: String): String;
begin
  Result :=          strAbr  + 'CODITE AS CODITE, ';
  Result := Result + strAbr  + 'DTAENT AS DTAENT, ';
  Result := Result + strAbr  + 'HORENT AS HORENT  ';
end;

function TSuvinilMultiSelectLocalizadorBase.fGetSQLTin(
  strTabela: String): String;
  Var
    strSQL : String;
    strAbr : String;
begin
  strSQL := '';
  If (strTabela = 'TINDET') Or (strTabela = 'TINDETX') Then
    strAbr := 'DET_'
  Else
    strAbr := 'FDO_';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + fGetFields(strAbr);
  strSQL := strSQL + '   FROM ' + strTabela;
  strSQL := strSQL + '  WHERE ' + strAbr + 'ITETIN = :ITETIN ';
  Result := strSQL;
end;

function TSuvinilMultiSelectLocalizadorBase.fGetUnionTin: String;
  Var
    strSQL : String;
begin
  strSQL :=          ' SELECT * ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + ' ( ';
  strSQL := strSQL + fGetSQLTin('TINDET') + ' UNION ALL ';
  strSQL := strSQL + fGetSQLTin('TINDETX') + ' UNION ALL ';
  strSQL := strSQL + fGetSQLTin('TINDOR') + '  ';
  strSQL := strSQL + ' ) TMPUNION ';
  strSQL := strSQL + ' ORDER BY DTAENT DESC, HORENT DESC ';
  strSQL := strSQL + ' LIMIT 1 ';
  Result := strSQL;
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SUV', TSuvinilMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('SUVBAS', TSuvinilMultiSelectLocalizadorBase);

end.
