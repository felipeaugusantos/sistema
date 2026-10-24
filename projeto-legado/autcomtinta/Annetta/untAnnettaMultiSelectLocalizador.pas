unit untAnnettaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TAnnettaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TAnnettaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TAnnettaMultiSelectLocalizador }

constructor TAnnettaMultiSelectLocalizador.Create;
begin
  inherited Create();

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   ANN_CADANN               ' +
    ' WHERE ANN_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   ANN_CADANN                   ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(ANN_DESCRI, '''')   ' +
    '     , IFNULL(ANN_CODIGO, '''') ' +
    '     , IFNULL(ANN_UNIDAD, '''') ' +
    '     , IFNULL(ANN_CODBAS, '''') ' +
    '     , IFNULL(ANN_CODEMB, '''') ' +
    '     , IFNULL(ANN_CODUNI, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   ANN_CADANN                   ' +
    ' WHERE CONCAT(                  ' +
    '       IFNULL(ANN_CODBAS, '''') ' +
    '     , IFNULL(ANN_CODIGO, '''') ' +
    '     , IFNULL(ANN_UNIDAD, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   ANN_CADANN               ' +
    ' WHERE ANN_CODSEQ = :ITETIN ');
end;

{ TAnnettaMultiSelectLocalizadorBase }

constructor TAnnettaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   ANN_CADANN C                      ' +
    '   INNER JOIN ANN_CADBAS B        ' +
    '     ON C.ANN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.ANN_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.ANN_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   ANN_CADANN C                   ' +
    '   INNER JOIN ANN_CADBAS B        ' +
    '     ON C.ANN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.ANN_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.ANN_DESCRI, '''')      ' +
    '     , IFNULL(C.ANN_CODIGO, '''')    ' +
    '     , IFNULL(C.ANN_UNIDAD, '''')    ' +
    '     , IFNULL(C.ANN_CODBAS, '''')    ' +
    '     , IFNULL(C.ANN_CODEMB, '''')    ' +
    '     , IFNULL(C.ANN_CODUNI, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   ANN_CADANN C                      ' +
    '   INNER JOIN ANN_CADBAS B        ' +
    '     ON C.ANN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.ANN_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '       IFNULL(C.ANN_CODBAS, '''')    ' +
    '     , IFNULL(C.ANN_CODIGO, '''')    ' +
    '     , IFNULL(C.ANN_UNIDAD, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   ANN_CADANN C                      ' +
    '   INNER JOIN ANN_CADBAS B        ' +
    '     ON C.ANN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.ANN_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.ANN_CODSEQ = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ANN', TAnnettaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ANNBAS', TAnnettaMultiSelectLocalizadorBase);

end.

