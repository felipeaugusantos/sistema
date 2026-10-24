unit untAdvanceMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TAdvanceMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TAdvanceMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation
uses untMultiSelectLocalizadorFactory;
{ TAdvanceMultiSelectLocalizador }

constructor TAdvanceMultiSelectLocalizador.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   ADV_CADADV               ' +
    ' WHERE ADV_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                       ' +
    '   *                          ' +
    ' FROM                         ' +
    '   ADV_CADADV                 ' +
    ' WHERE CONCAT(                ' +
    '     IFNULL(ADV_CARTA_, "")   ' +
    '     , IFNULL(ADV_PRODUT, "") ' +
    '     , IFNULL(ADV_FORMUL, "") ' +
    '     , IFNULL(ADV_UNIDAD, "") ' +
    '   ) = :ITETIN                ');

  Sqls.Add(
    ' SELECT                                             ' +
    '   *                                                ' +
    ' FROM                                               ' +
    '   ADV_CADADV                                       ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                       ' +
    '     IFNULL(ADV_CARTA_, "")                         ' +
    '     , IFNULL(ADV_PRODUT, "")                       ' +
    '     , IFNULL(ADV_FORMUL, "")                       ' +
    '     , IFNULL(ADV_UNIDAD, ""))) AS CHAR)) = :ITETIN ');
end;

{ TAdvanceMultiSelectLocalizadorBase }

constructor TAdvanceMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   ADV_CADBAS B                      ' +
    '   INNER JOIN ADV_CADADV A           ' +
    '     ON B.BAS_CODBAS = A.ADV_BASE01  ' +
    '     AND B.BAS_UNIDAD = A.ADV_UNIDAD ' +
    ' WHERE ADV_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   ADV_CADBAS B                      ' +
    '   INNER JOIN ADV_CADADV A           ' +
    '     ON B.BAS_CODBAS = A.ADV_BASE01  ' +
    '     AND B.BAS_UNIDAD = A.ADV_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(ADV_CARTA_, "")          ' +
    '     , IFNULL(ADV_PRODUT, "")        ' +
    '     , IFNULL(ADV_FORMUL, "")        ' +
    '     , IFNULL(ADV_UNIDAD, "")        ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   ADV_CADBAS B                      ' +
    '   INNER JOIN ADV_CADADV A           ' +
    '     ON B.BAS_CODBAS = A.ADV_BASE01  ' +
    '     AND B.BAS_UNIDAD = A.ADV_UNIDAD ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(        ' +
    '           IFNULL(ADV_CARTA_, "")    ' +
    '           , IFNULL(ADV_PRODUT, "")  ' +
    '           , IFNULL(ADV_FORMUL, "")  ' +
    '           , IFNULL(ADV_UNIDAD, "")  ' +
    '         )) AS CHAR)) = :ITETIN      ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ADV', TAdvanceMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ADVBAS', TAdvanceMultiSelectLocalizadorBase);

end.
