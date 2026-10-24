unit untUniversoMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TUniversoMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TUniversoMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TUniversoMultiSelectLocalizador }

constructor TUniversoMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT UNI_MD5KEY FROM UNI_CADUNI WHERE FALSE', 'UNI_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   UNI_CADUNI               ' +
      ' WHERE UNI_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT       ' +
    '   *          ' +
    ' FROM         ' +
    '   UNI_CADUNI ' +
    ' WHERE        ' +
    '   CONCAT(IFNULL(UNI_DESCOR, ""), ' +
    '         (IFNULL(UNI_GRUPO_, ""), ' +
    '          IFNULL(UNI_PRODUT, ""), ' +
    '          IFNULL(UNI_CODBAS, ""), ' +
    '          IFNULL(UNI_CODUNI, ""), ' +
    '          IFNULL(UNI_CODNFM, "")) = :ITETIN ');
end;

{ TUniversoMultiSelectLocalizadorBase }

constructor TUniversoMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   UNI_CADUNI E                      ' +
    '   INNER JOIN UNI_CADBAS B           ' +
    '     ON E.UNI_CODBAS = B.BAS_CODBAS  ' +
    '     AND E.UNI_PRODUT = B.BAS_PRODUT ' +
    '     AND E.UNI_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE UNI_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   UNI_CADUNI E                      ' +
    '   INNER JOIN UNI_CADBAS B           ' +
    '     ON E.UNI_CODBAS = B.BAS_CODBAS  ' +
    '     AND E.UNI_PRODUT = B.BAS_PRODUT ' +
    '     AND E.UNI_CODUNI = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(E.UNI_DESCOR, '''') ,    ' +
    '     IFNULL(E.UNI_CODBAS, '''') ,    ' +
    '     IFNULL(E.UNI_GRUPO_, '''') ,    ' +
    '     IFNULL(E.UNI_PRODUT, '''') ,    ' +
    '     IFNULL(E.UNI_CODUNI, '''') ,    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('UNI', TUniversoMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('UNIBAS', TUniversoMultiSelectLocalizadorBase);

end.
