unit untEucatexImobiliariaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TEucatexImobiliariaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TEucatexImobiliariaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TEucatexImobiliariaMultiSelectLocalizador }

constructor TEucatexImobiliariaMultiSelectLocalizador.Create;
begin
  inherited Create;
  Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   EUC_CADEUC               ' +
      ' WHERE EUC_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT       ' +
    '   *          ' +
    ' FROM         ' +
    '   EUC_CADEUC ' +
    ' WHERE        ' +
    '   CONCAT(IFNULL(EUC_CODCOR, ""), ' +
    '          IFNULL(EUC_DESCOR, ""), ' +
    '          IFNULL(EUC_PRODUT, ""), ' +
    '          IFNULL(EUC_DESBAS, ""), ' +
    '          IFNULL(EUC_UNIDAD, ""), ' +
    '          IFNULL(EUC_CODNFM, "")) = :ITETIN ');
end;

{ TEucatexImobiliariaMultiSelectLocalizadorBase }

constructor TEucatexImobiliariaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   EUC_CADEUC E                      ' +
    '   INNER JOIN EUC_CADBAS B           ' +
    '     ON E.EUC_DESBAS = B.BAS_DESCRI  ' +
    '     AND E.EUC_PRODUT = B.BAS_PRODUT ' +
    '     AND E.EUC_UNIDAD = B.BAS_CODUNI ' +
    '     AND E.EUC_EMBALA = B.BAS_EMBALA ' +
    ' WHERE EUC_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   EUC_CADEUC E                      ' +
    '   INNER JOIN EUC_CADBAS B           ' +
    '     ON E.EUC_DESBAS = B.BAS_DESCRI  ' +
    '     AND E.EUC_PRODUT = B.BAS_PRODUT ' +
    '     AND E.EUC_UNIDAD = B.BAS_CODUNI ' +
    '     AND E.EUC_EMBALA = B.BAS_EMBALA ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(E.EUC_CODCOR, '''')      ' +
    '     , IFNULL(E.EUC_DESCOR, '''')    ' +
    '     , IFNULL(E.EUC_PRODUT, '''')    ' +
    '     , IFNULL(E.EUC_DESBAS, '''')    ' +
    '     , IFNULL(E.EUC_UNIDAD, '''')    ' +
    '     , IFNULL(E.EUC_CODNFM, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('EUC', TEucatexImobiliariaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('EUCBAS', TEucatexImobiliariaMultiSelectLocalizadorBase);

end.
