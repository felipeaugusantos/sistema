unit untSherwinWilliamsMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TSherwinWilliamsMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TSherwinWilliamsMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TSherwinWilliamsMultiSelectLocalizador }

constructor TSherwinWilliamsMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT SHE_MD5KEY FROM SHE_CADSHE WHERE FALSE', 'SHE_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   SHE_CADSHE               ' +
      ' WHERE SHE_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                       ' +
    '   *                          ' +
    ' FROM                         ' +
    '   SHE_CADSHE                 ' +
    ' WHERE                        ' +
    '   CONCAT(SHE_DESCRI, " ", SHE_CODIGO, " ", SHE_CODIG2, " ", SHE_UNIDAD) = :ITETIN ');
end;

{ TSherwinWilliamsMultiSelectLocalizadorBase }

constructor TSherwinWilliamsMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   SHE_CADSHE C                      ' +
    '   INNER JOIN SHE_CADBAS B           ' +
    '     ON C.SHE_BASE__ = B.BAS_BASE__  ' +
    '     AND C.SHE_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.SHE_PROKEY = B.BAS_PROKEY ' +
    '     AND C.SHE_SUBKEY = B.BAS_SUBKEY ' +
    ' WHERE C.SHE_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   SHE_CADSHE C                      ' +
    '   INNER JOIN SHE_CADBAS B           ' +
    '     ON C.SHE_BASE__ = B.BAS_BASE__  ' +
    '     AND C.SHE_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.SHE_PROKEY = B.BAS_PROKEY ' +
    '     AND C.SHE_SUBKEY = B.BAS_SUBKEY ' +
    ' WHERE CONCAT(SHE_DESCRI, " ", SHE_CODIGO, " ", SHE_CODIG2, " ", SHE_UNIDAD) = :ITETIN ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SHE', TSherwinWilliamsMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('SHEBAS', TSherwinWilliamsMultiSelectLocalizadorBase);

end.

