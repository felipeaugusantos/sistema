unit untInkorMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TInkorMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TInkorMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TInkorMultiSelectLocalizador }

constructor TInkorMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT INK_MD5KEY FROM INK_CADINK WHERE FALSE', 'INK_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   INK_CADINK            ' +
      ' WHERE INK_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   INK_CADINK                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(INK_CODIGO, '''')   ' +
    '     , IFNULL(INK_BASE__, '''') ' +
    '     , IFNULL(INK_PRODUT, '''') ' +
    '     , IFNULL(INK_UNIDAD, '''') ' +
    '     , IFNULL(INK_DESCRI, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TInkorMultiSelectLocalizadorBase }

constructor TInkorMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   INK_CADINK C                   ' +
    '   INNER JOIN INK_CADBAS B        ' +
    '     ON C.INK_BASE__ = B.BAS_BASE__  ' +
    '     AND C.INK_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.INK_PRODUT = B.BAS_DESCRI ' +
    ' WHERE C.INK_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE  AS CODITE           ' +
    ' FROM                                ' +
    '   INK_CADINK C                   ' +
    '   INNER JOIN INK_CADBAS B        ' +
    '     ON C.INK_BASE__ = B.BAS_BASE__  ' +
    '     AND C.INK_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.INK_PRODUT = B.BAS_DESCRI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.INK_CODIGO, '''')      ' +
    '     , IFNULL(C.INK_BASE__, '''')    ' +
    '     , IFNULL(C.INK_PRODUT, '''')    ' +
    '     , IFNULL(C.INK_UNIDAD, '''')    ' +
    '     , IFNULL(C.INK_DESCRI, '''')    ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('INK', TInkorMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('INKBAS', TInkorMultiSelectLocalizadorBase);

end.
