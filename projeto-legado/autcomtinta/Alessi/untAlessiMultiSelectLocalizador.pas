unit untAlessiMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, Dialogs;

type
  TAlessiMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TAlessiMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TAlessiMultiSelectLocalizador }

constructor TAlessiMultiSelectLocalizador.Create;
begin
  inherited Create();
  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   ALE_CADALE                   ' +
    '   INNER JOIN ALE_CADEMB        ' +
    '     ON ALE_EMBALA = EMB_NOME__ ' +
    ' WHERE ALE_MD5KEY = :ITETIN     ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   ALE_CADALE                   ' +
    '   INNER JOIN ALE_CADEMB        ' +
    '     ON ALE_EMBALA = EMB_NOME__ ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(ALE_PRODUT, "")     ' +
    '     , IFNULL(ALE_BASE__, "")   ' +
    '     , IFNULL(ALE_CODUNI, "")   ' +
    '     , IFNULL(ALE_NOMCOR, "")   ' +
    '     , IFNULL(ALE_NOMLON, "")   ' +
    '     , IFNULL(ALE_CODNFM, "")   ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                                                   ' +
    '   *                                                      ' +
    ' FROM                                                     ' +
    '   ALE_CADALE                                             ' +
    '   INNER JOIN ALE_CADEMB                                  ' +
    '     ON ALE_EMBALA = EMB_NOME__                           ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                             ' +
    '           IFNULL(ALE_PRODUT, "")                         ' +
    '           , IFNULL(ALE_BASE__, "")                       ' +
    '           , IFNULL(ALE_CODUNI, "")                       ' +
    '           , IFNULL(ALE_NOMCOR, "")                       ' +
    '           , IFNULL(ALE_NOMLON, "")                       ' +
    '           , IFNULL(ALE_CODNFM, ""))) AS CHAR)) = :ITETIN ');
end;

{ TAlessiMultiSelectLocalizadorBase }

constructor TAlessiMultiSelectLocalizadorBase.Create;
begin
  inherited Create();
  Sqls.Add(
    ' SELECT                                ' +
    '   B.BAS_CODITE                        ' +
    ' FROM                                  ' +
    '   ALE_CADALE A                        ' +
    '   INNER JOIN ALE_CADBAS B             ' +
    '     ON A.ALE_PRODUT = B.BAS_PRODUT    ' +
    '     AND A.ALE_BASE__ = B.BAS_BASE__   ' +
    '     AND A.ALE_EMBALA = B.BAS_EMBALA   ' +
    ' WHERE ALE_MD5KEY = :ITETIN            ');

  Sqls.Add(
    ' SELECT                                ' +
    '   B.BAS_CODITE                        ' +
    ' FROM                                  ' +
    '   ALE_CADALE A                        ' +
    '   INNER JOIN ALE_CADBAS B             ' +
    '     ON A.ALE_PRODUT = B.BAS_PRODUT    ' +
    '     AND A.ALE_BASE__ = B.BAS_BASE__   ' +
    '     AND A.ALE_EMBALA = B.BAS_EMBALA   ' +
    ' WHERE CONCAT(                         ' +
    '     IFNULL(ALE_PRODUT, '''')          ' +
    '     , IFNULL(ALE_BASE__, '''')        ' +
    '     , IFNULL(ALE_CODUNI, '''')        ' +
    '     , IFNULL(ALE_NOMCOR, '''')        ' +
    '     , IFNULL(ALE_NOMLON, '''')        ' +
    '     , IFNULL(ALE_CODNFM, '''')        ' +
    '   ) = :ITETIN                         ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   ALE_CADALE A                      ' +
    '   INNER JOIN ALE_CADBAS B           ' +
    '     ON A.ALE_PRODUT = B.BAS_PRODUT  ' +
    '     AND A.ALE_BASE__ = B.BAS_BASE__ ' +
    '     AND A.ALE_EMBALA = B.BAS_EMBALA ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(        ' +
    '           IFNULL(ALE_PRODUT, "")    ' +
    '           , IFNULL(ALE_BASE__, "")  ' +
    '           , IFNULL(ALE_CODUNI, "")  ' +
    '           , IFNULL(ALE_NOMCOR, "")  ' +
    '           , IFNULL(ALE_NOMLON, "")  ' +
    '           , IFNULL(ALE_CODNFM, "")  ' +
    '         )) AS CHAR)) = :ITETIN      ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALE', TAlessiMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALEBAS', TAlessiMultiSelectLocalizadorBase);

end.

