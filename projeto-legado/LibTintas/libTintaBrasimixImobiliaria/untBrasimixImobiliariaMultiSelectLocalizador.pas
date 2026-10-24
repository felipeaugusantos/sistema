unit untBrasimixImobiliariaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TBrasimixImobiliariaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TBrasimixImobiliariaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TBrasimixImobiliariaMultiSelectLocalizador }

constructor TBrasimixImobiliariaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT BZI_MD5KEY FROM BZI_CADBZI WHERE FALSE', 'BZI_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   BZI_CADBZI               ' +
      ' WHERE BZI_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT       ' +
    '   *          ' +
    ' FROM         ' +
    '   BZI_CADBZI ' +
    ' WHERE        ' +
    '   CONCAT(IFNULL(BZI_CODIGO, ""), ' +
    '          IFNULL(BZI_UNIDAD, ""), ' +
    '          IFNULL(BZI_DESCRI, ""), ' +
    '          IFNULL(BZI_REFERE, "")) = :ITETIN ');

  Sqls.Add(
    ' SELECT       ' +
    '   *          ' +
    ' FROM         ' +
    '   BZI_CADBZI ' +
    ' WHERE        ' +
    '   CONCAT(BZI_CODIGO, BZI_UNIDAD) = :ITETIN ');
end;

{ TBrasimixImobiliariaMultiSelectLocalizadorBase }

constructor TBrasimixImobiliariaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BZI_CADBZI A                      ' +
    '   INNER JOIN BZI_CADBAS B           ' +
    '     ON BZI_LINHA_ = B.BAS_LINHA_    ' +
    '     AND BZI_CODBAS = B.BAS_BASE__   ' +
    '     AND BZI_CODUNI = B.BAS_UNIDAD   ' +
    '     AND BZI_DESCRI = B.BAS_DESCRI   ' +
    '     AND BZI_EMBALA = B.BAS_EMBALA   ' +
    ' WHERE BZI_MD5KEY = :ITETIN          ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BZI_CADBZI A                      ' +
    '   INNER JOIN BZI_CADBAS B           ' +
    '     ON BZI_LINHA_ = B.BAS_LINHA_    ' +
    '     AND BZI_CODBAS = B.BAS_BASE__   ' +
    '     AND BZI_CODUNI = B.BAS_UNIDAD   ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(A.BZI_CODIGO, '''')      ' +
    '     , IFNULL(A.BZI_UNIDAD, '''')    ' +
    '     , IFNULL(A.BZI_DESCRI, '''')    ' +
    '     , IFNULL(A.BZI_REFERE, '''')    ' +
    '   ) = :ITETIN                       ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BZI_CADBZI A                      ' +
    '   INNER JOIN BZI_CADBAS B           ' +
    '     ON BZI_LINHA_ = B.BAS_LINHA_    ' +
    '     AND BZI_CODBAS = B.BAS_BASE__   ' +
    '     AND BZI_CODUNI = B.BAS_UNIDAD   ' +
    '     AND BZI_DESCRI = B.BAS_DESCRI   ' +
    '     AND BZI_EMBALA = B.BAS_EMBALA   ' +
    ' WHERE                               ' +
    '   CONCAT(BZI_CODIGO,                ' +
    '          BZI_UNIDAD) = :ITETIN      ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('BZI', TBrasimixImobiliariaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('BZIBAS', TBrasimixImobiliariaMultiSelectLocalizadorBase);

end.
