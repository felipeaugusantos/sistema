unit untGlobalBcMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TGlobalBcMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TGlobalBcMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TGlobalBcMultiSelectLocalizador }

constructor TGlobalBcMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT GBC_MD5KEY FROM GBC_CADGBC WHERE FALSE', 'GBC_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   GBC_CADGBC               ' +
      ' WHERE GBC_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   GBC_CADGBC                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(GBC_DESCOR, '''')   ' +
    '     , IFNULL(GBC_CODIGO, '''') ' +
    '     , IFNULL(GBC_UNIDAD, '''') ' +
    '     , IFNULL(GBC_CODBAS, '''') ' +
    '     , IFNULL(GBC_PRODUT, '''') ' +
    '     , IFNULL(GBC_COLECA, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TGlobalBcMultiSelectLocalizadorBase }

constructor TGlobalBcMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   GBC_CADGBC C                   ' +
    '   INNER JOIN GBC_CADBAS B        ' +
    '     ON C.GBC_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.GBC_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.GBC_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.GBC_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   GBC_CADGBC C                   ' +
    '   INNER JOIN GBC_CADBAS B        ' +
    '     ON C.GBC_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.GBC_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.GBC_PRODUT = B.BAS_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.GBC_DESCOR, '''')      ' +
    '     , IFNULL(C.GBC_CODIGO, '''')    ' +
    '     , IFNULL(C.GBC_UNIDAD, '''')    ' +
    '     , IFNULL(C.GBC_CODBAS, '''')    ' +
    '     , IFNULL(C.GBC_PRODUT, '''')    ' +
    '     , IFNULL(C.GBC_COLECA, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('GBC', TGlobalBcMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('GBCBAS', TGlobalBcMultiSelectLocalizadorBase);

end.
