unit untGlobalColorMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TGlobalColorMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TGlobalColorMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TGlobalColorMultiSelectLocalizador }

constructor TGlobalColorMultiSelectLocalizador.Create;
begin
  inherited Create();

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   GLO_CADGLO               ' +
    ' WHERE GLO_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   GLO_CADGLO                   ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(GLO_DESCRI, '''')   ' +
    '     , IFNULL(GLO_CODIGO, '''') ' +
    '     , IFNULL(GLO_UNIDAD, '''') ' +
    '     , IFNULL(GLO_CODBAS, '''') ' +
    '     , IFNULL(GLO_CODEMB, '''') ' +
    '     , IFNULL(GLO_CODUNI, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   GLO_CADGLO                   ' +
    ' WHERE CONCAT(                  ' +
    '       IFNULL(GLO_CODBAS, '''') ' +
    '     , IFNULL(GLO_CODIGO, '''') ' +
    '     , IFNULL(GLO_UNIDAD, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   GLO_CADGLO               ' +
    ' WHERE GLO_CODSEQ = :ITETIN ');
end;

{ TGlobalColorMultiSelectLocalizadorBase }

constructor TGlobalColorMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   GLO_CADGLO C                      ' +
    '   INNER JOIN GLO_CADBAS B        ' +
    '     ON C.GLO_CODBAS = B.BAS_BASE__  ' +
    '     AND C.GLO_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.GLO_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   GLO_CADGLO C                   ' +
    '   INNER JOIN GLO_CADBAS B        ' +
    '     ON C.GLO_CODBAS = B.BAS_BASE__  ' +
    '     AND C.GLO_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.GLO_DESCRI, '''')      ' +
    '     , IFNULL(C.GLO_CODIGO, '''')    ' +
    '     , IFNULL(C.GLO_UNIDAD, '''')    ' +
    '     , IFNULL(C.GLO_CODBAS, '''')    ' +
    '     , IFNULL(C.GLO_CODEMB, '''')    ' +
    '     , IFNULL(C.GLO_CODUNI, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   GLO_CADGLO C                      ' +
    '   INNER JOIN GLO_CADBAS B        ' +
    '     ON C.GLO_CODBAS = B.BAS_BASE__  ' +
    '     AND C.GLO_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '       IFNULL(C.GLO_CODBAS, '''')    ' +
    '     , IFNULL(C.GLO_CODIGO, '''')    ' +
    '     , IFNULL(C.GLO_UNIDAD, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   GLO_CADGLO C                      ' +
    '   INNER JOIN GLO_CADBAS B        ' +
    '     ON C.GLO_CODBAS = B.BAS_BASE__  ' +
    '     AND C.GLO_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.GLO_CODSEQ = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('GLO', TGlobalColorMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('GLOBAS', TGlobalColorMultiSelectLocalizadorBase);

end.

