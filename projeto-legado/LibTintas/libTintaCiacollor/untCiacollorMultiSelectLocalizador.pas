unit untCiacollorMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TCiacollorMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TCiacollorMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TCiacollorMultiSelectLocalizador }

constructor TCiacollorMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT CIA_MD5KEY FROM CIA_CADCIA WHERE FALSE', 'CIA_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   CIA_CADCIA               ' +
      ' WHERE CIA_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   CIA_CADCIA     ' +
    ' WHERE CONCAT(    ' +
    '       CIA_CODBAS ' +
    '     , " "        ' +
    '     , CIA_UNIDAD ' +
    '     , CIA_DESCRI ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   CIA_CADCIA     ' +
    ' WHERE CONCAT(    ' +
    '      CIA_UNIDAD ' +
    '     , CIA_DESCRI ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   CIA_CADCIA     ' +
    ' WHERE CONCAT(    ' +
    '     CIA_DESCRI   ' +
    '     , " "        ' +
    '     , CIA_CODBAS ' +
    '     , " "        ' +
    '     , CIA_UNIDAD ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT                             ' +
    '   *                                ' +
    ' FROM                               ' +
    '   CIA_CADCIA                       ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(       ' +
    '           IFNULL(CIA_DESCRI, "")   ' +
    '           , IFNULL(CIA_UNIDAD, "") ' +
    '           , IFNULL(CIA_CODBAS, "") ' +
    '           , IFNULL(CIA_CODUNI, "") ' +
    '           , IFNULL(CIA_NOMCOR, "") ' +
    '         )) AS CHAR)) = :ITETIN     ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   CIA_CADCIA                   ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(   ' +
    '             CIA_CODBAS         ' +
    '           , " "                ' +
    '           , CIA_UNIDAD         ' +
    '           , CIA_DESCRI         ' +
    '         )) AS CHAR)) = :ITETIN ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   *                                                        ' +
    ' FROM                                                       ' +
    '   CIA_CADCIA                                               ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(CIA_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB15, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   *                                                        ' +
    ' FROM                                                       ' +
    '   CIA_CADCIA                                               ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(CIA_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB15, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM16, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB16, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM17, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB17, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM18, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB18, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM19, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB19, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM20, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB20, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');
end;

{ TCiacollorMultiSelectLocalizadorBase }

constructor TCiacollorMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.CIA_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CIA_CADBAS B                      ' +
    '   INNER JOIN CIA_CADCIA S           ' +
    '     ON  B.BAS_CODBAS = S.CIA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.CIA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.CIA_PRODUT ' +
    '     AND B.BAS_VOLUME = S.CIA_VOLUME ' +
    ' WHERE CIA_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.CIA_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CIA_CADBAS B                      ' +
    '   INNER JOIN CIA_CADCIA S           ' +
    '     ON  B.BAS_CODBAS = S.CIA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.CIA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.CIA_PRODUT ' +
    '     AND B.BAS_VOLUME = S.CIA_VOLUME ' +
    ' WHERE CONCAT(                       ' +
    '       S.CIA_CODBAS                  ' +
    '     , " "                           ' +
    '     , S.CIA_UNIDAD                  ' +
    '     , S.CIA_DESCRI                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.CIA_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CIA_CADBAS B                      ' +
    '   INNER JOIN CIA_CADCIA S           ' +
    '     ON  B.BAS_CODBAS = S.CIA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.CIA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.CIA_PRODUT ' +
    '     AND B.BAS_VOLUME = S.CIA_VOLUME ' +
    ' WHERE CONCAT(                       ' +
    '     , S.CIA_UNIDAD                  ' +
    '     , S.CIA_DESCRI                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.CIA_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CIA_CADBAS B                      ' +
    '   INNER JOIN CIA_CADCIA S           ' +
    '     ON  B.BAS_CODBAS = S.CIA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.CIA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.CIA_PRODUT ' +
    '     AND B.BAS_VOLUME = S.CIA_VOLUME ' +
    ' WHERE CONCAT(                       ' +
    '     S.CIA_DESCRI                    ' +
    '     , " "                           ' +
    '     , S.CIA_CODBAS                  ' +
    '     , " "                           ' +
    '     , S.CIA_UNIDAD                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                               ' +
    '   B.BAS_CODITE AS CODITE             ' +
    ' FROM                                 ' +
    '   CIA_CADBAS B                       ' +
    '   INNER JOIN CIA_CADCIA S            ' +
    '     ON B.BAS_CODBAS = S.CIA_CODBAS   ' +
    '     AND B.BAS_CODUNI = S.CIA_CODUNI  ' +
    '     AND B.BAS_PRODUT = S.CIA_PRODUT ' +
    '     AND B.BAS_VOLUME = S.CIA_VOLUME ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(         ' +
    '           IFNULL(S.CIA_DESCRI, "")   ' +
    '           , IFNULL(S.CIA_UNIDAD, "") ' +
    '           , IFNULL(S.CIA_CODBAS, "") ' +
    '           , IFNULL(S.CIA_CODUNI, "") ' +
    '           , IFNULL(S.CIA_NOMCOR, "") ' +
    '         )) AS CHAR)) = :ITETIN       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CIA_CADBAS B                      ' +
    '   INNER JOIN CIA_CADCIA S           ' +
    '     ON  B.BAS_CODBAS = S.CIA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.CIA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.CIA_PRODUT ' +
    '     AND B.BAS_VOLUME = S.CIA_VOLUME ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(        ' +
    '             S.CIA_CODBAS            ' +
    '           , " "                     ' +
    '           , S.CIA_UNIDAD            ' +
    '           , S.CIA_DESCRI            ' +
    '         )) AS CHAR)) = :ITETIN      ');
  Sqls.Add(
    ' SELECT                                                     ' +
    '   B.BAS_CODITE AS CODITE                                   ' +
    ' FROM                                                       ' +
    '   CIA_CADBAS B                                             ' +
    '   INNER JOIN CIA_CADCIA S                                  ' +
    '     ON  B.BAS_CODBAS = S.CIA_CODBAS                        ' +
    '     AND B.BAS_CODUNI = S.CIA_CODUNI                        ' +
    '     AND B.BAS_PRODUT = S.CIA_PRODUT                        ' +
    '     AND B.BAS_VOLUME = S.CIA_VOLUME                        ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(CIA_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB15, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   B.CIA_CODITE AS CODITE                                   ' +
    ' FROM                                                       ' +
    '   CIA_CADBAS B                                             ' +
    '   INNER JOIN CIA_CADCIA S                                  ' +
    '     ON  B.BAS_CODBAS = S.CIA_CODBAS                        ' +
    '     AND B.BAS_CODUNI = S.CIA_CODUNI                        ' +
    '     AND B.BAS_PRODUT = S.CIA_PRODUT                        ' +
    '     AND B.BAS_VOLUME = S.CIA_VOLUME                        ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(CIA_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB15, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM16, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB16, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM17, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB17, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM18, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB18, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM19, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB19, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(CIA_FORM20, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(CIA_QTDB20, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('CIA', TCiacollorMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('CIABAS', TCiacollorMultiSelectLocalizadorBase);

end.
