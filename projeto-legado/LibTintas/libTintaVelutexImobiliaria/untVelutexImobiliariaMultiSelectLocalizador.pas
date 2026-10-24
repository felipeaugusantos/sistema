unit untVelutexImobiliariaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TVelutexImobiliariaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TVelutexImobiliariaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TVelutexImobiliariaMultiSelectLocalizador }

constructor TVelutexImobiliariaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT VEL_MD5KEY FROM VEL_CADVEL WHERE FALSE', 'VEL_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   VEL_CADVEL               ' +
      ' WHERE VEL_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT       ' +
    '   *          ' +
    ' FROM         ' +
    '   VEL_CADVEL ' +
    ' WHERE        ' +
    '   CONCAT(IFNULL(VEL_CORCOD, ""), ' +
    '          IFNULL(VEL_PRODUT, ""), ' +
    '          IFNULL(VEL_CODBAS, ""), ' +
    '          IFNULL(VEL_CODUNI, ""), ' +
    '          IFNULL(VEL_CODNFM, "")) = :ITETIN ');
end;

{ TVelutexImobiliariaMultiSelectLocalizadorBase }

constructor TVelutexImobiliariaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   VEL_CADVEL E                      ' +
    '   INNER JOIN VEL_CADBAS B           ' +
    '     ON E.VEL_CODBAS = B.BAS_CODBAS  ' +
    '     AND E.VEL_PRODUT = B.BAS_PRODUT ' +
    '     AND E.VEL_CODUNI = B.BAS_CODUNI ' +
    ' WHERE VEL_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   VEL_CADVEL E                      ' +
    '   INNER JOIN VEL_CADBAS B           ' +
    '     ON E.VEL_CODBAS = B.BAS_CODBAS  ' +
    '     AND E.VEL_PRODUT = B.BAS_PRODUT ' +
    '     AND E.VEL_CODUNI = B.BAS_CODUNI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(E.VEL_CORCOD, '''') ,    ' +
    '     IFNULL(E.VEL_CODBAS, '''') ,    ' +
    '     IFNULL(E.VEL_COLECA, '''') ,    ' +
    '     IFNULL(E.VEL_PRODUT, '''') ,    ' +
    '     IFNULL(E.VEL_CODUNI, '''') ,    ' +
    '     IFNULL(E.VEL_CODNOM, '''')      ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('VEL', TVelutexImobiliariaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('VELBAS', TVelutexImobiliariaMultiSelectLocalizadorBase);

end.
