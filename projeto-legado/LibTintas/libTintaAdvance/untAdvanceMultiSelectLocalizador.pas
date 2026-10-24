unit untAdvanceMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAdvanceCorobMultiSelectLocalizador = Class(TMultiSelectLocalizador)
  Private

  Public
    Constructor Create(); Override;
  End;

  TAdvanceCorobMultiSelectLocalizadorBase = Class(TMultiSelectLocalizador)
  Private

  Public
    Constructor Create(); Override;
  End;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory, untIConfTinta;

{ TAdvanceCorobMultiSelectLocalizador }

constructor TAdvanceCorobMultiSelectLocalizador.Create;
begin
  inherited Create;
  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ADV_MD5KEY FROM ADVCOR_CADADV WHERE FALSE', 'ADV_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ADVCOR_CADADV            ' +
      ' WHERE ADV_MD5KEY = :ITETIN ');

    Sqls.Add(
      ' SELECT           ' +
      '   *              ' +
      ' FROM             ' +
      '   ADVCOR_CADADV  ' +
      ' WHERE CONCAT(    ' +
      '     ADV_DESCRI   ' +
      '     , " "        ' +
      '     , ADV_CODIGO ' +
      '     , " "        ' +
      '     , ADV_CODIG2 ' +
      '     , " "        ' +
      '     , ADV_UNIDAD ' +
      '   ) = :ITETIN    ');

    Sqls.Add(
      ' SELECT                                                     ' +
      '   *                                                        ' +
      ' FROM                                                       ' +
      '   ADVCOR_CADADV                                            ' +
      ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
      '     IFNULL(ADV_DESCRI, '''')                               ' +
      '   , IFNULL(ADV_CODIGO, '''')                               ' +
      '   , IFNULL(ADV_CODIG2, '''')                               ' +
      '   , IFNULL(ADV_UNIDAD, '''')                               ' +
      '   , IFNULL(ADV_FORM01, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB01, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM01, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB01, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM02, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB02, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM03, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB03, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM04, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB04, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM05, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB05, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM06, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB06, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM07, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB07, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM08, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB08, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM09, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB09, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM10, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB10, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM11, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB11, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM12, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB12, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM13, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB13, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM14, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB14, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM15, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB15, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM16, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB16, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM17, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB17, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM18, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB18, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM19, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB19, 0), 5), '','', '''') ' +
      '   , IFNULL(ADV_FORM20, '''')                               ' +
      '   , REPLACE(FORMAT(IFNULL(ADV_QTDB20, 0), 5), '','', '''') ' +
      '   )) AS CHAR)) = :ITETIN                                   ');
  Except
    //
  End;
end;

{ TAdvanceCorobMultiSelectLocalizadorBase }

constructor TAdvanceCorobMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE  AS CODITE           ' +
    ' FROM                                ' +
    '   ADVCOR_CADADV A                   ' +
    '   INNER JOIN ADVCOR_CADBAS B        ' +
    '     ON A.ADV_UNIDAD = B.BAS_UNIDAD  ' +
    '     AND A.ADV_BASE__ = B.BAS_BASE__ ' +
    '     AND A.ADV_PROKEY = B.BAS_PROKEY ' +
    '     AND A.ADV_SUBKEY = B.BAS_SUBKEY ' +
    ' WHERE ADV_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE   AS CODITE          ' +
    ' FROM                                ' +
    '   ADVCOR_CADADV A                   ' +
    '   INNER JOIN ADVCOR_CADBAS B        ' +
    '     ON A.ADV_UNIDAD = B.BAS_UNIDAD  ' +
    '     AND A.ADV_BASE__ = B.BAS_BASE__ ' +
    '     AND A.ADV_PROKEY = B.BAS_PROKEY ' +
    '     AND A.ADV_SUBKEY = B.BAS_SUBKEY ' +
    ' WHERE CONCAT(                       ' +
    '     ADV_DESCRI                      ' +
    '     , " "                           ' +
    '     , ADV_CODIGO                    ' +
    '     , " "                           ' +
    '     , ADV_CODIG2                    ' +
    '     , " "                           ' +
    '     , ADV_UNIDAD                    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                                                 ' +
    '   B.BAS_CODITE AS CODITE                               ' +
    ' FROM                                                   ' +
    '   ADVCOR_CADADV A                                      ' +
    '   INNER JOIN ADVCOR_CADBAS B                           ' +
    '     ON A.ADV_UNIDAD = B.BAS_UNIDAD                     ' +
    '     AND A.ADV_BASE__ = B.BAS_BASE__                    ' +
    '     AND A.ADV_PROKEY = B.BAS_PROKEY                    ' +
    '     AND A.ADV_SUBKEY = B.BAS_SUBKEY                    ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                           ' +
    '     IFNULL(ADV_DESCRI, "")                             ' +
    '   , IFNULL(ADV_CODIGO, "")                             ' +
    '   , IFNULL(ADV_CODIG2, "")                             ' +
    '   , IFNULL(ADV_UNIDAD, "")                             ' +
    '   , IFNULL(ADV_FORM01, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB01, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM01, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB01, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM02, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB02, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM03, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB03, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM04, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB04, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM05, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB05, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM06, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB06, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM07, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB07, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM08, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB08, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM09, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB09, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM10, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB10, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM11, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB11, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM12, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB12, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM13, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB13, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM14, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB14, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM15, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB15, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM16, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB16, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM17, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB17, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM18, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB18, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM19, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB19, 0), 5), ",", "") ' +
    '   , IFNULL(ADV_FORM20, "")                             ' +
    '   , REPLACE(FORMAT(IFNULL(ADV_QTDB20, 0), 5), ",", "") ' +
    '   )) AS CHAR)) = :ITETIN                               ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ADV', TAdvanceCorobMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ADVBAS', TAdvanceCorobMultiSelectLocalizadorBase);
end.
