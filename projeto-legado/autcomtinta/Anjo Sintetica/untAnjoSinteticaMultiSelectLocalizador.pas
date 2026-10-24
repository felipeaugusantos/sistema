unit untAnjoSinteticaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TAnjoSinteticaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TAnjoSinteticaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation
uses untMultiSelectLocalizadorFactory;
{ TAnjoSinteticaMultiSelectLocalizadorBase }

constructor TAnjoSinteticaMultiSelectLocalizadorBase.Create;
begin
  inherited;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   AJA_CADAJA A                      ' +
    '   INNER JOIN AJA_CADBAS B           ' +
    '     ON A.AJA_BASE__ = B.BAS_BASE__  ' +
    '     AND A.AJA_PROKEY = B.BAS_PROKEY ' +
    '     AND A.AJA_SUBKEY = B.BAS_SUBKEY ' +
    '     AND A.AJA_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE AJA_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   AJA_CADAJA A                      ' +
    '   INNER JOIN AJA_CADBAS B           ' +
    '     ON A.AJA_BASE__ = B.BAS_BASE__  ' +
    '     AND A.AJA_PROKEY = B.BAS_PROKEY ' +
    '     AND A.AJA_SUBKEY = B.BAS_SUBKEY ' +
    '     AND A.AJA_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     AJA_DESCRI                      ' +
    '     , " "                           ' +
    '     , AJA_CODIGO                    ' +
    '     , " "                           ' +
    '     , AJA_CODIG2                    ' +
    '     , " "                           ' +
    '     , AJA_UNIDAD                    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                                                                   ' +
    '   B.BAS_CODITE                                                           ' +
    ' FROM                                                                     ' +
    '   AJA_CADAJA A                                                           ' +
    '   INNER JOIN AJA_CADBAS B                                                ' +
    '     ON A.AJA_BASE__ = B.BAS_BASE__                                       ' +
    '     AND A.AJA_PROKEY = B.BAS_PROKEY                                      ' +
    '     AND A.AJA_SUBKEY = B.BAS_SUBKEY                                      ' +
    '     AND A.AJA_UNIDAD = B.BAS_UNIDAD                                      ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                                             ' +
    '       CAST(IFNULL(AJA_DESCRI, "") AS CHAR)                               ' +
    '       , CAST(IFNULL(AJA_CODIGO, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_CODIG2, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_UNIDAD, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_PROKEY, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_SUBKEY, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_BASE__, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_FORM01, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB01, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM02, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB02, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM03, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB03, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM04, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB04, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM05, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB05, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM06, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB06, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM07, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB07, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM08, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB08, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM09, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB09, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM10, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB10, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM11, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB11, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM12, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB12, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM13, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB13, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM14, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB14, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM15, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB15, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM16, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB16, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM17, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB17, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM18, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB18, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM19, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB19, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM20, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB20, 0), 4) AS CHAR), ",", "") ' +
    '     )                                                                    ' +
    '   ) AS CHAR)) = :ITETIN                                                  ');
end;

{ TAnjoSinteticaMultiSelectLocalizador }

constructor TAnjoSinteticaMultiSelectLocalizador.Create;
begin
  inherited;
  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   AJA_CADAJA               ' +
    ' WHERE AJA_MD5KEY = :ITETIN ');
    
  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   AJA_CADAJA     ' +
    ' WHERE CONCAT(    ' +
    '     AJA_DESCRI   ' +
    '     , " "        ' +
    '     , AJA_CODIGO ' +
    '     , " "        ' +
    '     , AJA_CODIG2 ' +
    '     , " "        ' +
    '     , AJA_UNIDAD ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT                                                                   ' +
    '   *                                                                      ' +
    ' FROM                                                                     ' +
    '   AJA_CADAJA                                                             ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                                             ' +
    '       CAST(IFNULL(AJA_DESCRI, "") AS CHAR)                               ' +
    '       , CAST(IFNULL(AJA_CODIGO, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_CODIG2, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_UNIDAD, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_PROKEY, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_SUBKEY, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_BASE__, "") AS CHAR)                             ' +
    '       , CAST(IFNULL(AJA_FORM01, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB01, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM02, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB02, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM03, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB03, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM04, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB04, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM05, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB05, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM06, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB06, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM07, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB07, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM08, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB08, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM09, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB09, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM10, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB10, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM11, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB11, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM12, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB12, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM13, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB13, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM14, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB14, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM15, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB15, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM16, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB16, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM17, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB17, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM18, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB18, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM19, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB19, 0), 4) AS CHAR), ",", "") ' +
    '       , CAST(IFNULL(AJA_FORM20, "") AS CHAR)                             ' +
    '       , REPLACE(CAST(FORMAT(IFNULL(AJA_QTDB20, 0), 4) AS CHAR), ",", "") ' +
    '     )                                                                    ' +
    '   ) AS CHAR)) = :ITETIN                                                  ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('AJA', TAnjoSinteticaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('AJABAS', TAnjoSinteticaMultiSelectLocalizadorBase);

end.

