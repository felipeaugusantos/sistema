unit untWegMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TWegMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TWegMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TWegMultiSelectLocalizador }

constructor TWegMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT WEG_MD5KEY FROM WEG_CADWEG WHERE FALSE', 'WEG_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   WEG_CADWEG               ' +
      ' WHERE WEG_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   WEG_CADWEG                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(WEG_DESCRI, '''')   ' +
    '     , IFNULL(WEG_CODIGO, '''') ' +
    '     , IFNULL(WEG_CODIG2, '''') ' +
    '     , IFNULL(WEG_BASE__, '''') ' +
    '     , IFNULL(WEG_UNIDAD, '''') ' +
    '     , IFNULL(WEG_PROKEY, '''') ' +
    '     , IFNULL(WEG_SUBKEY, '''') ' +
    '     , IFNULL(WEG_NOMCOR, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TWegMultiSelectLocalizadorBase }

constructor TWegMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   WEG_CADWEG C                   ' +
    '   INNER JOIN WEG_CADBAS B        ' +
    '     ON C.WEG_BASE__ = B.BAS_BASE__  ' +
    '     AND C.WEG_PROKEY = B.BAS_PROKEY ' +
    '     AND C.WEG_SUBKEY = B.BAS_SUBKEY ' +
    '     AND C.WEG_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE C.WEG_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   WEG_CADWEG C                   ' +
    '   INNER JOIN WEG_CADBAS B        ' +
    '     ON C.WEG_BASE__ = B.BAS_BASE__  ' +
    '     AND C.WEG_PROKEY = B.BAS_PROKEY ' +
    '     AND C.WEG_SUBKEY = B.BAS_SUBKEY ' +
    '     AND C.WEG_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.WEG_DESCRI, '''')      ' +
    '     , IFNULL(C.WEG_CODIGO, '''')    ' +
    '     , IFNULL(C.WEG_CODIG2, '''')    ' +
    '     , IFNULL(C.WEG_BASE__, '''')    ' +
    '     , IFNULL(C.WEG_UNIDAD, '''')    ' +
    '     , IFNULL(C.WEG_PROKEY, '''')    ' +
    '     , IFNULL(C.WEG_SUBKEY, '''')    ' +
    '     , IFNULL(C.WEG_NOMCOR, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('WEG', TWegMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('WEGBAS', TWegMultiSelectLocalizadorBase);

end.
