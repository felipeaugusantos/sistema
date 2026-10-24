unit untAlessiImobiliariaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAlessiImobiliariaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TAlessiImobiliariaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TAlessiImobiliariaMultiSelectLocalizador }

constructor TAlessiImobiliariaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ALE_MD5KEY FROM ALE_CADALE WHERE FALSE', 'ALE_MD5KEY', []);

    Sqls.Add(
      ' SELECT                         ' +
      '   *                            ' +
      ' FROM                           ' +
      '   ALE_CADALE                   ' +
      '   INNER JOIN ALE_CADEMB        ' +
      '     ON ALE_EMBALA = EMB_NOME__ ' +
      ' WHERE ALE_MD5KEY = :ITETIN     ');
  Except
    //
  End;

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

{ TAlessiImobiliariaMultiSelectLocalizadorBase }

constructor TAlessiImobiliariaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                                ' +
    '   B.BAS_CODITE AS CODITE              ' +
    ' FROM                                  ' +
    '   ALE_CADALE A                        ' +
    '   INNER JOIN ALE_CADBAS B             ' +
    '     ON A.ALE_PRODUT = B.BAS_PRODUT    ' +
    '     AND A.ALE_BASE__ = B.BAS_BASE__   ' +
    '     AND A.ALE_EMBALA = B.BAS_EMBALA   ' +
    ' WHERE ALE_MD5KEY = :ITETIN            ');

  Sqls.Add(
    ' SELECT                                ' +
    '   B.BAS_CODITE AS CODITE              ' +
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
    '   B.BAS_CODITE AS CODITE            ' +
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
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALE', TAlessiImobiliariaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALEBAS', TAlessiImobiliariaMultiSelectLocalizadorBase);

end.
