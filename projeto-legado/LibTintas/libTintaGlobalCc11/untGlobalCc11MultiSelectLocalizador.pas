unit untGlobalCc11MultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TGlobalCc11MultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TGlobalCc11MultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TGlobalCc11MultiSelectLocalizador }

constructor TGlobalCc11MultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT C11_MD5KEY FROM C11_CADC11 WHERE FALSE', 'C11_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   C11_CADC11               ' +
      ' WHERE C11_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   C11_CADC11                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(C11_DESCOR, '''')   ' +
    '     , IFNULL(C11_CODIGO, '''') ' +
    '     , IFNULL(C11_UNIDAD, '''') ' +
    '     , IFNULL(C11_CODBAS, '''') ' +
    '     , IFNULL(C11_PRODUT, '''') ' +
    '     , IFNULL(C11_COLECA, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TGlobalCc11MultiSelectLocalizadorBase }

constructor TGlobalCc11MultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   C11_CADC11 C                   ' +
    '   INNER JOIN C11_CADBAS B        ' +
    '     ON C.C11_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.C11_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.C11_PRODUT = B.BAS_PRODUT ' +
    '     AND C.C11_VOLUME = B.BAS_EMBALA ' +
    ' WHERE C.C11_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   C11_CADC11 C                   ' +
    '   INNER JOIN C11_CADBAS B        ' +
    '     ON C.C11_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.C11_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.C11_PRODUT = B.BAS_PRODUT ' +
    '     AND C.C11_VOLUME = B.BAS_EMBALA ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.C11_DESCOR, '''')      ' +
    '     , IFNULL(C.C11_CODIGO, '''')    ' +
    '     , IFNULL(C.C11_UNIDAD, '''')    ' +
    '     , IFNULL(C.C11_CODBAS, '''')    ' +
    '     , IFNULL(C.C11_PRODUT, '''')    ' +
    '     , IFNULL(C.C11_COLECA, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('C11', TGlobalCc11MultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('C11BAS', TGlobalCc11MultiSelectLocalizadorBase);

end.
