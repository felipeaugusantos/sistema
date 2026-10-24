unit untLikoMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TLikoMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TLikoMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TLikoMultiSelectLocalizador }

constructor TLikoMultiSelectLocalizador.Create;
begin
  inherited Create();

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   LIK_CADLIK               ' +
    ' WHERE LIK_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   LIK_CADLIK                   ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(LIK_DESCRI, '''')   ' +
    '     , IFNULL(LIK_CODIGO, '''') ' +
    '     , IFNULL(LIK_UNIDAD, '''') ' +
    '     , IFNULL(LIK_CODBAS, '''') ' +
    '     , IFNULL(LIK_CODEMB, '''') ' +
    '     , IFNULL(LIK_CODUNI, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   LIK_CADLIK                   ' +
    ' WHERE CONCAT(                  ' +
    '       IFNULL(LIK_CODBAS, '''') ' +
    '     , IFNULL(LIK_CODIGO, '''') ' +
    '     , IFNULL(LIK_UNIDAD, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   LIK_CADLIK               ' +
    ' WHERE LIK_CODSEQ = :ITETIN ');
end;

{ TLikoMultiSelectLocalizadorBase }

constructor TLikoMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   LIK_CADLIK C                      ' +
    '   INNER JOIN LIK_CADBAS B        ' +
    '     ON C.LIK_CODBAS = B.BAS_BASE__  ' +
    '     AND C.LIK_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.LIK_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   LIK_CADLIK C                   ' +
    '   INNER JOIN LIK_CADBAS B        ' +
    '     ON C.LIK_CODBAS = B.BAS_BASE__  ' +
    '     AND C.LIK_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.LIK_DESCRI, '''')      ' +
    '     , IFNULL(C.LIK_CODIGO, '''')    ' +
    '     , IFNULL(C.LIK_UNIDAD, '''')    ' +
    '     , IFNULL(C.LIK_CODBAS, '''')    ' +
    '     , IFNULL(C.LIK_CODEMB, '''')    ' +
    '     , IFNULL(C.LIK_CODUNI, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   LIK_CADLIK C                      ' +
    '   INNER JOIN LIK_CADBAS B        ' +
    '     ON C.LIK_CODBAS = B.BAS_BASE__  ' +
    '     AND C.LIK_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '       IFNULL(C.LIK_CODBAS, '''')    ' +
    '     , IFNULL(C.LIK_CODIGO, '''')    ' +
    '     , IFNULL(C.LIK_UNIDAD, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   LIK_CADLIK C                      ' +
    '   INNER JOIN LIK_CADBAS B        ' +
    '     ON C.LIK_CODBAS = B.BAS_BASE__  ' +
    '     AND C.LIK_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.LIK_CODSEQ = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('LIK', TLikoMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('LIKBAS', TLikoMultiSelectLocalizadorBase);

end.

