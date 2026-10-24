unit untAnnettaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAnnettaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TAnnettaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TAnnettaMultiSelectLocalizador }

constructor TAnnettaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ANN_MD5KEY FROM ANN_CADANN WHERE FALSE', 'ANN_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ANN_CADANN            ' +
      ' WHERE ANN_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   ANN_CADANN                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(ANN_DESCRI, '''')   ' +
    '     , IFNULL(ANN_CODIGO, '''') ' +
    '     , IFNULL(ANN_UNIDAD, '''') ' +
    '     , IFNULL(ANN_CODBAS, '''') ' +
    '     , IFNULL(ANN_CODEMB, '''') ' +
    '     , IFNULL(ANN_CODUNI, '''') ' +
    '     , IFNULL(ANN_PRODUT, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TAnnettaMultiSelectLocalizadorBase }

constructor TAnnettaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   ANN_CADANN C                   ' +
    '   INNER JOIN ANN_CADBAS B        ' +
    '     ON C.ANN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.ANN_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.ANN_PRODUT = B.BAS_DESCRI ' +
    ' WHERE C.ANN_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE  AS CODITE           ' +
    ' FROM                                ' +
    '   ANN_CADANN C                   ' +
    '   INNER JOIN ANN_CADBAS B        ' +
    '     ON C.ANN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.ANN_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.ANN_PRODUT = B.BAS_DESCRI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.ANN_DESCRI, '''')      ' +
    '     , IFNULL(C.ANN_CODIGO, '''')    ' +
    '     , IFNULL(C.ANN_UNIDAD, '''')    ' +
    '     , IFNULL(C.ANN_CODBAS, '''')    ' +
    '     , IFNULL(C.ANN_CODEMB, '''')    ' +
    '     , IFNULL(C.ANN_CODUNI, '''')    ' +
    '     , IFNULL(C.ANN_PRODUT, '''')    ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ANN', TAnnettaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ANNBAS', TAnnettaMultiSelectLocalizadorBase);

end.
