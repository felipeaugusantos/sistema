unit untRennerIndustrialMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TRennerIndustrialMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TRennerIndustrialMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TRennerIndustrialMultiSelectLocalizador }

constructor TRennerIndustrialMultiSelectLocalizador.Create;
begin
  inherited Create();

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   REN_CADREN               ' +
    ' WHERE REN_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   REN_CADREN                   ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(REN_DESCRI, '''')   ' +
    '     , IFNULL(REN_CODIGO, '''') ' +
    '     , IFNULL(REN_UNIDAD, '''') ' +
    '     , IFNULL(REN_CODBAS, '''') ' +
    '     , IFNULL(REN_CODEMB, '''') ' +
    '     , IFNULL(REN_CODUNI, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   REN_CADREN                   ' +
    ' WHERE CONCAT(                  ' +
    '       IFNULL(REN_CODBAS, '''') ' +
    '     , IFNULL(REN_CODIGO, '''') ' +
    '     , IFNULL(REN_UNIDAD, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   REN_CADREN               ' +
    ' WHERE REN_CODSEQ = :ITETIN ');
end;

{ TRennerIndustrialMultiSelectLocalizadorBase }

constructor TRennerIndustrialMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   REN_CADREN C                      ' +
    '   INNER JOIN REN_CADBAS B        ' +
    '     ON C.REN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REN_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.REN_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   REN_CADREN C                   ' +
    '   INNER JOIN REN_CADBAS B        ' +
    '     ON C.REN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REN_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.REN_DESCRI, '''')      ' +
    '     , IFNULL(C.REN_CODIGO, '''')    ' +
    '     , IFNULL(C.REN_UNIDAD, '''')    ' +
    '     , IFNULL(C.REN_CODBAS, '''')    ' +
    '     , IFNULL(C.REN_CODEMB, '''')    ' +
    '     , IFNULL(C.REN_CODUNI, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   REN_CADREN C                      ' +
    '   INNER JOIN REN_CADBAS B        ' +
    '     ON C.REN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REN_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '       IFNULL(C.REN_CODBAS, '''')    ' +
    '     , IFNULL(C.REN_CODIGO, '''')    ' +
    '     , IFNULL(C.REN_UNIDAD, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   REN_CADREN C                      ' +
    '   INNER JOIN REN_CADBAS B        ' +
    '     ON C.REN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REN_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.REN_CODSEQ = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('REN', TRennerIndustrialMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('RENBAS', TRennerIndustrialMultiSelectLocalizadorBase);

end.

