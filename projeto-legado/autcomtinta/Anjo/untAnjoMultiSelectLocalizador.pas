unit untAnjoMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TAnjoMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TAnjoMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation
uses untMultiSelectLocalizadorFactory;
{ TAnjoMultiSelectLocalizadorBase }

constructor TAnjoMultiSelectLocalizadorBase.Create;
begin
  inherited;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
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
    '   B.BAS_CODITE                      ' +
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
    '   B.BAS_CODITE                                                           ' +
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
end;

{ TAnjoMultiSelectLocalizador }

constructor TAnjoMultiSelectLocalizador.Create;
begin
  inherited;
  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   ANJ_CADANJ               ' +
    ' WHERE ANJ_MD5KEY = :ITETIN ');
    
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
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ANJ', TAnjoMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ANJBAS', TAnjoMultiSelectLocalizadorBase);

end.

