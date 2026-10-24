unit untBellaCorTintavelMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TBellaCorTintavelMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TBellaCorTintavelMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TBellaCorTintavelMultiSelectLocalizador }

constructor TBellaCorTintavelMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT BLT_MD5KEY FROM BLT_CADBLT WHERE FALSE', 'BLT_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   BLT_CADBLT               ' +
      ' WHERE BLT_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   BLT_CADBLT                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(BLT_DESCOR, '''')   ' +
    '     , IFNULL(BLT_CODIGO, '''') ' +
    '     , IFNULL(BLT_UNIDAD, '''') ' +
    '     , IFNULL(BLT_CODBAS, '''') ' +
    '     , IFNULL(BLT_PRODUT, '''') ' +
    '     , IFNULL(BLT_COLECA, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TBellaCorTintavelMultiSelectLocalizadorBase }

constructor TBellaCorTintavelMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BLT_CADBLT C                   ' +
    '   INNER JOIN BLT_CADBAS B        ' +
    '     ON C.BLT_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.BLT_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.BLT_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.BLT_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BLT_CADBLT C                   ' +
    '   INNER JOIN BLT_CADBAS B        ' +
    '     ON C.BLT_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.BLT_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.BLT_PRODUT = B.BAS_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.BLT_DESCOR, '''')      ' +
    '     , IFNULL(C.BLT_CODIGO, '''')    ' +
    '     , IFNULL(C.BLT_UNIDAD, '''')    ' +
    '     , IFNULL(C.BLT_CODBAS, '''')    ' +
    '     , IFNULL(C.BLT_PRODUT, '''')    ' +
    '     , IFNULL(C.BLT_COLECA, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('BLT', TBellaCorTintavelMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('BLTBAS', TBellaCorTintavelMultiSelectLocalizadorBase);

end.
