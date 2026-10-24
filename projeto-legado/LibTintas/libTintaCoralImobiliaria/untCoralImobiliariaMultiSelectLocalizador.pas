unit untCoralImobiliariaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TCoralImobiliariaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TCoralImobiliariaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TCoralImobiliariaMultiSelectLocalizador }

constructor TCoralImobiliariaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT COR_MD5KEY FROM CORIMO_CADCOR WHERE FALSE', 'COR_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   CORIMO_CADCOR            ' +
      ' WHERE COR_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   CORIMO_CADCOR                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(COR_DESCRI, '''')   ' +
    '     , IFNULL(COR_CODIGO, '''') ' +
    '     , IFNULL(COR_UNIDAD, '''') ' +
    '     , IFNULL(COR_COLID1, '''') ' +
    '     , IFNULL(COR_COLID2, '''') ' +
    '     , IFNULL(COR_DESPRO, '''') ' +
    '     , IFNULL(COR_CODBAS, '''') ' +
    '     , IFNULL(COR_CODEMB, '''') ' +
    '     , IFNULL(COR_CODUNI, '''') ' +
    '     , IFNULL(COR_UNIVER, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   CORIMO_CADCOR                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(COR_COLID1, '''')   ' +
    '     , IFNULL(COR_COLID2, '''') ' +
    '     , IFNULL(COR_DESPRO, '''') ' +
    '     , IFNULL(COR_CODBAS, '''') ' +
    '     , IFNULL(COR_CODIGO, '''') ' +
    '     , IFNULL(COR_UNIDAD, '''') ' +
    '   ) = :ITETIN                  ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   CORIMO_CADCOR            ' +
    ' WHERE COR_CODSEQ = :ITETIN ');
end;

{ TCoralImobiliariaMultiSelectLocalizadorBase }

constructor TCoralImobiliariaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   CORIMO_CADCOR C                   ' +
    '   INNER JOIN CORIMO_CADBAS B        ' +
    '     ON C.COR_CODBAS = B.BAS_BASE__  ' +
    '     AND C.COR_CODUNI = B.BAS_UNIDAD ' +
    '     AND C.COR_DESPRO = B.BAS_DESCRI ' +
    ' WHERE C.COR_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   CORIMO_CADCOR C                   ' +
    '   INNER JOIN CORIMO_CADBAS B        ' +
    '     ON C.COR_CODBAS = B.BAS_BASE__  ' +
    '     AND C.COR_CODUNI = B.BAS_UNIDAD ' +
    '     AND C.COR_DESPRO = B.BAS_DESCRI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.COR_DESCRI, '''')      ' +
    '     , IFNULL(C.COR_CODIGO, '''')    ' +
    '     , IFNULL(C.COR_UNIDAD, '''')    ' +
    '     , IFNULL(C.COR_COLID1, '''')    ' +
    '     , IFNULL(C.COR_COLID2, '''')    ' +
    '     , IFNULL(C.COR_DESPRO, '''')    ' +
    '     , IFNULL(C.COR_CODBAS, '''')    ' +
    '     , IFNULL(C.COR_CODEMB, '''')    ' +
    '     , IFNULL(C.COR_CODUNI, '''')    ' +
    '     , IFNULL(C.COR_UNIVER, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   CORIMO_CADCOR C                   ' +
    '   INNER JOIN CORIMO_CADBAS B        ' +
    '     ON C.COR_CODBAS = B.BAS_BASE__  ' +
    '     AND C.COR_CODUNI = B.BAS_UNIDAD ' +
    '     AND C.COR_DESPRO = B.BAS_DESCRI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.COR_COLID1, '''')      ' +
    '     , IFNULL(C.COR_COLID2, '''')    ' +
    '     , IFNULL(C.COR_DESPRO, '''')    ' +
    '     , IFNULL(C.COR_CODBAS, '''')    ' +
    '     , IFNULL(C.COR_CODIGO, '''')    ' +
    '     , IFNULL(C.COR_UNIDAD, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   CORIMO_CADCOR C                   ' +
    '   INNER JOIN CORIMO_CADBAS B        ' +
    '     ON C.COR_CODBAS = B.BAS_BASE__  ' +
    '     AND C.COR_CODUNI = B.BAS_UNIDAD ' +
    '     AND C.COR_DESPRO = B.BAS_DESCRI ' +
    ' WHERE C.COR_CODSEQ = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('CIM', TCoralImobiliariaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('CIMBAS', TCoralImobiliariaMultiSelectLocalizadorBase);

end.
