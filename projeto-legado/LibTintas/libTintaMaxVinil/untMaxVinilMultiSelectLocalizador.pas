unit untMaxVinilMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TMaxVinilMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TMaxVinilMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TMaxVinilMultiSelectLocalizador }

constructor TMaxVinilMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT MAX_MD5KEY FROM MAX_CADMAX WHERE FALSE', 'MAX_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   MAX_CADMAX            ' +
      ' WHERE MAX_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   MAX_CADMAX                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(MAX_CODIGO, '''')   ' +
    '     , IFNULL(MAX_CODBAS, '''') ' +
    '     , IFNULL(MAX_PRODUT, '''') ' +
    '     , IFNULL(MAX_COLECA, '''') ' +
    '     , IFNULL(MAX_UNIDAD, '''') ' +
    '     , IFNULL(MAX_NOMCOR, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TMaxVinilMultiSelectLocalizadorBase }

constructor TMaxVinilMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   MAX_CADMAX C                   ' +
    '   INNER JOIN MAX_CADBAS B        ' +
    '     ON C.MAX_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.MAX_PRODUT = B.BAS_PRODUT ' +
    '     AND C.MAX_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.MAX_EMBALA = B.BAS_CONTEU ' +
    ' WHERE C.MAX_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE  AS CODITE           ' +
    ' FROM                                ' +
    '   MAX_CADMAX C                   ' +
    '   INNER JOIN MAX_CADBAS B        ' +
    '     ON C.MAX_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.MAX_PRODUT = B.BAS_PRODUT ' +
    '     AND C.MAX_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.MAX_EMBALA = B.BAS_CONTEU ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.MAX_CODIGO, '''')      ' +
    '     , IFNULL(C.MAX_CODBAS, '''')    ' +
    '     , IFNULL(C.MAX_PRODUT, '''')    ' +
    '     , IFNULL(C.MAX_COLECA, '''')    ' +
    '     , IFNULL(C.MAX_UNIDAD, '''')    ' +
    '     , IFNULL(C.MAX_NOMCOR, '''')    ' +
    '     , IFNULL(C.MAX_EMBALA, '''')    ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('MAX', TMaxVinilMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('MAXBAS', TMaxVinilMultiSelectLocalizadorBase);

end.
