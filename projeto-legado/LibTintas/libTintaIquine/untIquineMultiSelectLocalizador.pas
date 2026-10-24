unit untIquineMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TIquineMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TIquineMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TIquineMultiSelectLocalizador }

constructor TIquineMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT IQU_MD5KEY FROM IQU_CADIQU WHERE FALSE', 'IQU_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   IQU_CADIQU            ' +
      ' WHERE IQU_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   IQU_CADIQU                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(IQU_DESCRI, '''')   ' +
    '     , IFNULL(IQU_CODIGO, '''') ' +
    '     , IFNULL(IQU_UNIDAD, '''') ' +
    '     , IFNULL(IQU_CODBAS, '''') ' +
    '     , IFNULL(IQU_CODEMB, '''') ' +
    '     , IFNULL(IQU_CODUNI, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TIquineMultiSelectLocalizadorBase }

constructor TIquineMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   IQU_CADIQU C                   ' +
    '   INNER JOIN IQU_CADBAS B        ' +
    '     ON C.IQU_CODBAS = B.BAS_BASE__  ' +
    '     AND C.IQU_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.IQU_PRODUT = B.BAS_PRODUT ' +
    '     AND C.IQU_EMBALA = B.BAS_EMBALA ' +
    ' WHERE C.IQU_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   IQU_CADIQU C                   ' +
    '   INNER JOIN IQU_CADBAS B        ' +
    '     ON C.IQU_CODBAS = B.BAS_BASE__  ' +
    '     AND C.IQU_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.IQU_PRODUT = B.BAS_PRODUT ' +
    '     AND C.IQU_EMBALA = B.BAS_EMBALA ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.IQU_DESCRI, '''')      ' +
    '     , IFNULL(C.IQU_CODIGO, '''')    ' +
    '     , IFNULL(C.IQU_UNIDAD, '''')    ' +
    '     , IFNULL(C.IQU_CODBAS, '''')    ' +
    '     , IFNULL(C.IQU_CODEMB, '''')    ' +
    '     , IFNULL(C.IQU_CODUNI, '''')    ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('IQU', TIquineMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('IQUBAS', TIquineMultiSelectLocalizadorBase);

end.
