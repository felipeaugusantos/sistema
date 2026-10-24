unit untRecoaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TRecoaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TRecoaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TRecoaMultiSelectLocalizador }

constructor TRecoaMultiSelectLocalizador.Create;
begin
  inherited Create();

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   REC_CADREC               ' +
    ' WHERE REC_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   REC_CADREC                   ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(REC_DESCRI, '''')   ' +
    '     , IFNULL(REC_CODIGO, '''') ' +
    '     , IFNULL(REC_UNIDAD, '''') ' +
    '     , IFNULL(REC_CODBAS, '''') ' +
    '     , IFNULL(REC_CODEMB, '''') ' +
    '     , IFNULL(REC_CODUNI, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   REC_CADREC                   ' +
    ' WHERE CONCAT(                  ' +
    '       IFNULL(REC_CODBAS, '''') ' +
    '     , IFNULL(REC_CODIGO, '''') ' +
    '     , IFNULL(REC_UNIDAD, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   REC_CADREC               ' +
    ' WHERE REC_CODSEQ = :ITETIN ');
end;

{ TRecoaMultiSelectLocalizadorBase }

constructor TRecoaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   REC_CADREC C                      ' +
    '   INNER JOIN REC_CADBAS B        ' +
    '     ON C.REC_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REC_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.REC_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   REC_CADREC C                   ' +
    '   INNER JOIN REC_CADBAS B        ' +
    '     ON C.REC_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REC_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.REC_DESCRI, '''')      ' +
    '     , IFNULL(C.REC_CODIGO, '''')    ' +
    '     , IFNULL(C.REC_UNIDAD, '''')    ' +
    '     , IFNULL(C.REC_CODBAS, '''')    ' +
    '     , IFNULL(C.REC_CODEMB, '''')    ' +
    '     , IFNULL(C.REC_CODUNI, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   REC_CADREC C                      ' +
    '   INNER JOIN REC_CADBAS B        ' +
    '     ON C.REC_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REC_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '       IFNULL(C.REC_CODBAS, '''')    ' +
    '     , IFNULL(C.REC_CODIGO, '''')    ' +
    '     , IFNULL(C.REC_UNIDAD, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   REC_CADREC C                      ' +
    '   INNER JOIN REC_CADBAS B        ' +
    '     ON C.REC_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REC_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE C.REC_CODSEQ = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('REC', TRecoaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('RECBAS', TRecoaMultiSelectLocalizadorBase);

end.

