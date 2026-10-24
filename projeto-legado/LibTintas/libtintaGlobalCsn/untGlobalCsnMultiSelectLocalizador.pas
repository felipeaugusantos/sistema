unit untGlobalCsnMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TGlobalCsnMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TGlobalCsnMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TGlobalCsnMultiSelectLocalizador }

constructor TGlobalCsnMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT CSN_MD5KEY FROM CSN_CADCSN WHERE FALSE', 'CSN_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   CSN_CADCSN               ' +
      ' WHERE CSN_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   CSN_CADCSN                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(CSN_DESCOR, '''')   ' +
    '     , IFNULL(CSN_CODIGO, '''') ' +
    '     , IFNULL(CSN_UNIDAD, '''') ' +
    '     , IFNULL(CSN_CODBAS, '''') ' +
    '     , IFNULL(CSN_PRODUT, '''') ' +
    '     , IFNULL(CSN_COLECA, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TGlobalCsnMultiSelectLocalizadorBase }

constructor TGlobalCsnMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CSN_CADCSN C                   ' +
    '   INNER JOIN CSN_CADBAS B        ' +
    '     ON C.CSN_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.CSN_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.CSN_PRODUT = B.BAS_PRODUT ' +
    '     AND C.CSN_EMBALA = B.BAS_EMBALA ' +
    ' WHERE C.CSN_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CSN_CADCSN C                   ' +
    '   INNER JOIN CSN_CADBAS B        ' +
    '     ON C.CSN_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.CSN_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.CSN_PRODUT = B.BAS_PRODUT ' +
    '     AND C.CSN_EMBALA = B.BAS_EMBALA ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.CSN_DESCOR, '''')      ' +
    '     , IFNULL(C.CSN_CODIGO, '''')    ' +
    '     , IFNULL(C.CSN_UNIDAD, '''')    ' +
    '     , IFNULL(C.CSN_CODBAS, '''')    ' +
    '     , IFNULL(C.CSN_PRODUT, '''')    ' +
    '     , IFNULL(C.CSN_COLECA, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('CSN', TGlobalCsnMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('CSNBAS', TGlobalCsnMultiSelectLocalizadorBase);

end.
