unit untQualyVinilMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TQualyVinilMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private
  public
    constructor Create(); override;
  end;

  TQualyVinilMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TQualyVinilMultiSelectLocalizador }

constructor TQualyVinilMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT QUA_MD5KEY FROM QUA_CADQUA WHERE FALSE', 'QUA_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   QUA_CADQUA               ' +
      ' WHERE QUA_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   QUA_CADQUA     ' +
    ' WHERE CONCAT(    ' +
    '       QUA_CODBAS ' +
    '     , " "        ' +
    '     , QUA_CODUNI ' +
    '     , QUA_PRODUT ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   QUA_CADQUA     ' +
    ' WHERE CONCAT(    ' +
    '      QUA_CODUNI  ' +
    '     , QUA_PRODUT ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT           ' +
    '   *              ' +
    ' FROM             ' +
    '   QUA_CADQUA     ' +
    ' WHERE CONCAT(    ' +
    '     QUA_PRODUT   ' +
    '     , " "        ' +
    '     , QUA_CODBAS ' +
    '     , " "        ' +
    '     , QUA_CODUNI ' +
    '   ) = :ITETIN    ');

  Sqls.Add(
    ' SELECT                             ' +
    '   *                                ' +
    ' FROM                               ' +
    '   QUA_CADQUA                       ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(       ' +
    '           IFNULL(QUA_PRODUT, "")   ' +
    '           , IFNULL(QUA_CODUNI, "") ' +
    '           , IFNULL(QUA_CODBAS, "") ' +
    '           , IFNULL(QUA_NOMCOR, "") ' +
    '         )) AS CHAR)) = :ITETIN     ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   QUA_CADQUA                   ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(   ' +
    '             QUA_CODBAS         ' +
    '           , " "                ' +
    '           , QUA_CODUNI         ' +
    '           , QUA_PRODUT         ' +
    '         )) AS CHAR)) = :ITETIN ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   *                                                        ' +
    ' FROM                                                       ' +
    '   QUA_CADQUA                                               ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(QUA_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB15, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   *                                                        ' +
    ' FROM                                                       ' +
    '   QUA_CADQUA                                               ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(QUA_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB15, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM16, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB16, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM17, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB17, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM18, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB18, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM19, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB19, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM20, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB20, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');
end;

{ TQualyVinilMultiSelectLocalizadorBase }

constructor TQualyVinilMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.QUA_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   QUA_CADBAS B                      ' +
    '   INNER JOIN QUA_CADQUA S           ' +
    '     ON  B.BAS_CODBAS = S.QUA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.QUA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.QUA_PRODUT ' +
    ' WHERE QUA_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.QUA_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   QUA_CADBAS B                      ' +
    '   INNER JOIN QUA_CADQUA S           ' +
    '     ON  B.BAS_CODBAS = S.QUA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.QUA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.QUA_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '       S.QUA_CODBAS                  ' +
    '     , " "                           ' +
    '     , S.QUA_CODUNI                  ' +
    '     , S.QUA_PRODUT                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.QUA_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   QUA_CADBAS B                      ' +
    '   INNER JOIN QUA_CADQUA S           ' +
    '     ON  B.BAS_CODBAS = S.QUA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.QUA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.QUA_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     , S.QUA_CODUNI                  ' +
    '     , S.QUA_PRODUT                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.QUA_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   QUA_CADBAS B                      ' +
    '   INNER JOIN QUA_CADQUA S           ' +
    '     ON  B.BAS_CODBAS = S.QUA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.QUA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.QUA_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     S.QUA_PRODUT                    ' +
    '     , " "                           ' +
    '     , S.QUA_CODBAS                  ' +
    '     , " "                           ' +
    '     , S.QUA_CODUNI                  ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                               ' +
    '   B.BAS_CODITE AS CODITE             ' +
    ' FROM                                 ' +
    '   QUA_CADBAS B                       ' +
    '   INNER JOIN QUA_CADQUA S            ' +
    '     ON B.BAS_CODBAS = S.QUA_CODBAS   ' +
    '     AND B.BAS_CODUNI = S.QUA_CODUNI  ' +
    '     AND B.BAS_PRODUT = S.QUA_PRODUT  ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(         ' +
    '           IFNULL(S.QUA_PRODUT, "")   ' +
    '           , IFNULL(S.QUA_CODUNI, "") ' +
    '           , IFNULL(S.QUA_CODBAS, "") ' +
    '           , IFNULL(S.QUA_CODUNI, "") ' +
    '           , IFNULL(S.QUA_NOMCOR, "") ' +
    '         )) AS CHAR)) = :ITETIN       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   QUA_CADBAS B                      ' +
    '   INNER JOIN QUA_CADQUA S           ' +
    '     ON  B.BAS_CODBAS = S.QUA_CODBAS ' +
    '     AND B.BAS_CODUNI = S.QUA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.QUA_PRODUT ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(        ' +
    '             S.QUA_CODBAS            ' +
    '           , " "                     ' +
    '           , S.QUA_CODUNI            ' +
    '           , S.QUA_PRODUT            ' +
    '         )) AS CHAR)) = :ITETIN      ');
  Sqls.Add(
    ' SELECT                                                     ' +
    '   B.BAS_CODITE AS CODITE                                   ' +
    ' FROM                                                       ' +
    '   QUA_CADBAS B                                             ' +
    '   INNER JOIN QUA_CADQUA S                                  ' +
    '     ON  B.BAS_CODBAS = S.QUA_CODBAS                        ' +
    '     AND B.BAS_CODUNI = S.QUA_CODUNI                        ' +
    '     AND B.BAS_PRODUT = S.QUA_PRODUT                        ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(QUA_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB15, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');

  Sqls.Add(
    ' SELECT                                                     ' +
    '   B.QUA_CODITE AS CODITE                                   ' +
    ' FROM                                                       ' +
    '   QUA_CADBAS B                                             ' +
    '   INNER JOIN QUA_CADQUA S                                  ' +
    '     ON  B.BAS_CODBAS = S.QUA_CODBAS                        ' +
    '     AND B.BAS_CODUNI = S.QUA_CODUNI                        ' +
    '     AND B.BAS_PRODUT = S.QUA_PRODUT                        ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                               ' +
    '           CAST(IFNULL(QUA_FORM01, '''') AS CHAR)           ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB01, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM02, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB02, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM03, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB03, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM04, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB04, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM05, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB05, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM06, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB06, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM07, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB07, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM08, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB08, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM09, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB09, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM10, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB10, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM11, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB11, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM12, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB12, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM13, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB13, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM14, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB14, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM15, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB15, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM16, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB16, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM17, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB17, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM18, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB18, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM19, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB19, 0), 4) AS CHAR) ' +
    '           , CAST(IFNULL(QUA_FORM20, '''') AS CHAR)         ' +
    '           , CAST(FORMAT(IFNULL(QUA_QTDB20, 0), 4) AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN                             ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('QUA', TQualyVinilMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('QUABAS', TQualyVinilMultiSelectLocalizadorBase);

end.
