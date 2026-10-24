unit untAnjoImobiliariaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAnjoImobiliariaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private
    function fGetSQLTin(strTabela: String): String;
    function fGetFields(strAbr: String): String;
    function fGetUnionTin: String;
  public
    constructor Create(); override;
  end;

  TAnjoImobiliariaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
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

{ TAnjoImobiliariaMultiSelectLocalizador }

constructor TAnjoImobiliariaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ANJ_MD5KEY FROM ANJ_CADANJ WHERE FALSE', 'ANJ_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ANJ_CADANJ               ' +
      ' WHERE ANJ_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   ANJ_CADANJ     ' +
    ' WHERE CONCAT(    ' +
    '     ANJ_DESCRI   ' +
    '     , " "        ' +
    '     , ANJ_CODIGO ' +
    '     , " "        ' +
    '     , ANJ_CODIG2 ' +
    '     , " "        ' +
    '     , ANJ_UNIDAD ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT                                                                   ' +
    '   *                                                                      ' +
    ' FROM                                                                     ' +
    '   ANJ_CADANJ                                                             ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                                             ' +
    '       CAST(IFNULL(ANJ_DESCRI, "") AS CHAR)                               ' +
    '       , CAST(IFNULL(ANJ_CODIGO, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_CODIG2, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_UNIDAD, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_PROKEY, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_SUBKEY, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_BASE__, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_FORM01, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB01, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM02, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB02, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM03, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB03, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM04, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB04, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM05, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB05, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM06, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB06, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM07, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB07, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM08, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB08, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM09, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB09, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM10, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB10, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM11, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB11, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM12, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB12, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM13, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB13, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM14, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB14, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM15, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB15, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM16, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB16, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM17, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB17, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM18, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB18, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM19, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB19, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM20, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB20, 0), 4) AS CHAR), ",", "") ' +
    '     )                                                                    ' +
    '   ) AS CHAR)) = :ITETIN                                                  ');


  Sqls.Add( fGetUnionTin );
end;

function TAnjoImobiliariaMultiSelectLocalizador.fGetFields(strAbr: String): String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 1 To MAX_QTD_BAS Do
  Begin
    Result := Result + strAbr + 'FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ' AS ANJ_FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ';
    Result := Result + '(' + strAbr + 'QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ' / ' + strAbr + 'QTDITE) AS ANJ_QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ';
  End;
  Result := Result + strAbr + 'DTAENT DTAENT, ' + strAbr + 'HORENT HORENT ';
end;

function TAnjoImobiliariaMultiSelectLocalizador.fGetSQLTin(strTabela: String): String;
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

function TAnjoImobiliariaMultiSelectLocalizador.fGetUnionTin: String;

  function fGetFields: String;
    Var
      intCnt : Integer;
  begin
    Result := '';
    For intCnt := 1 To MAX_QTD_BAS Do
    Begin
      Result := Result + ' ANJ_QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ' ;
      Result := Result + ' ANJ_FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ' ;
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

{ TAnjoImobiliariaMultiSelectLocalizadorBase }

constructor TAnjoImobiliariaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   ANJ_CADANJ A                      ' +
    '   INNER JOIN ANJ_CADBAS B           ' +
    '     ON A.ANJ_BASE__ = B.BAS_BASE__  ' +
    '     AND A.ANJ_PROKEY = B.BAS_PROKEY ' +
    '     AND A.ANJ_SUBKEY = B.BAS_SUBKEY ' +
    '     AND A.ANJ_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE ANJ_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   ANJ_CADANJ A                      ' +
    '   INNER JOIN ANJ_CADBAS B           ' +
    '     ON A.ANJ_BASE__ = B.BAS_BASE__  ' +
    '     AND A.ANJ_PROKEY = B.BAS_PROKEY ' +
    '     AND A.ANJ_SUBKEY = B.BAS_SUBKEY ' +
    '     AND A.ANJ_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     ANJ_DESCRI                      ' +
    '     , " "                           ' +
    '     , ANJ_CODIGO                    ' +
    '     , " "                           ' +
    '     , ANJ_CODIG2                    ' +
    '     , " "                           ' +
    '     , ANJ_UNIDAD                    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                                                                   ' +
    '   B.BAS_CODITE AS CODITE                                                 ' +
    ' FROM                                                                     ' +
    '   ANJ_CADANJ A                                                           ' +
    '   INNER JOIN ANJ_CADBAS B                                                ' +
    '     ON A.ANJ_BASE__ = B.BAS_BASE__                                       ' +
    '     AND A.ANJ_PROKEY = B.BAS_PROKEY                                      ' +
    '     AND A.ANJ_SUBKEY = B.BAS_SUBKEY                                      ' +
    '     AND A.ANJ_UNIDAD = B.BAS_UNIDAD                                      ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                                             ' +
    '       CAST(IFNULL(ANJ_DESCRI, "") AS CHAR)                               ' +
    '       , CAST(IFNULL(ANJ_CODIGO, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_CODIG2, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_UNIDAD, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_PROKEY, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_SUBKEY, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_BASE__, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(ANJ_FORM01, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB01, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM02, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB02, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM03, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB03, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM04, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB04, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM05, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB05, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM06, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB06, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM07, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB07, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM08, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB08, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM09, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB09, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM10, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB10, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM11, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB11, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM12, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB12, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM13, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB13, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM14, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB14, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM15, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB15, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM16, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB16, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM17, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB17, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM18, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB18, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM19, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB19, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(ANJ_FORM20, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB20, 0), 4) AS CHAR), ",", "") ' +
    '     )                                                                    ' +
    '   ) AS CHAR)) = :ITETIN                                                  ');

  Sqls.Add( fGetUnionTin );
end;

function TAnjoImobiliariaMultiSelectLocalizadorBase.fGetFields(strAbr: String): String;
begin
  Result :=          strAbr  + 'CODITE AS CODITE, ';
  Result := Result + strAbr  + 'DTAENT AS DTAENT, ';
  Result := Result + strAbr  + 'HORENT AS HORENT  ';
end;

function TAnjoImobiliariaMultiSelectLocalizadorBase.fGetSQLTin(
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

function TAnjoImobiliariaMultiSelectLocalizadorBase.fGetUnionTin: String;
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
  TMultiSelectLocalizadorFactory.RegistrarClasse('ANJ', TAnjoImobiliariaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ANJBAS', TAnjoImobiliariaMultiSelectLocalizadorBase);

end.
