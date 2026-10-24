unit untGlobalBsnMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TGlobalBsnMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TGlobalBsnMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TGlobalBsnMultiSelectLocalizador }

constructor TGlobalBsnMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT BSN_MD5KEY FROM BSN_CADBSN WHERE FALSE', 'BSN_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   BSN_CADBSN               ' +
      ' WHERE BSN_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   BSN_CADBSN                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(BSN_DESCOR, '''')   ' +
    '     , IFNULL(BSN_CODIGO, '''') ' +
    '     , IFNULL(BSN_UNIDAD, '''') ' +
    '     , IFNULL(BSN_CODBAS, '''') ' +
    '     , IFNULL(BSN_PRODUT, '''') ' +
    '     , IFNULL(BSN_COLECA, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TGlobalBsnMultiSelectLocalizadorBase }

constructor TGlobalBsnMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BSN_CADBSN C                   ' +
    '   INNER JOIN BSN_CADBAS B        ' +
    '     ON C.BSN_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.BSN_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.BSN_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.BSN_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BSN_CADBSN C                   ' +
    '   INNER JOIN BSN_CADBAS B        ' +
    '     ON C.BSN_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.BSN_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.BSN_PRODUT = B.BAS_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.BSN_DESCOR, '''')      ' +
    '     , IFNULL(C.BSN_CODIGO, '''')    ' +
    '     , IFNULL(C.BSN_UNIDAD, '''')    ' +
    '     , IFNULL(C.BSN_CODBAS, '''')    ' +
    '     , IFNULL(C.BSN_PRODUT, '''')    ' +
    '     , IFNULL(C.BSN_COLECA, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('BSN', TGlobalBsnMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('BSNBAS', TGlobalBsnMultiSelectLocalizadorBase);

end.
