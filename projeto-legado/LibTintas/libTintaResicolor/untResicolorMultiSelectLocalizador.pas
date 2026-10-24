unit untResicolorMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TResicolorMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TResicolorMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TResicolorMultiSelectLocalizador }

constructor TResicolorMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT RSI_MD5KEY FROM RSI_CADRSI WHERE FALSE', 'RSI_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   RSI_CADRSI               ' +
      ' WHERE RSI_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   RSI_CADRSI                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(RSI_DESCRI, '''')   ' +
    '     , IFNULL(RSI_BASE__, '''') ' +
    '     , IFNULL(RSI_CODIGO, '''') ' +
    '     , IFNULL(RSI_CODIG2, '''') ' +
    '     , IFNULL(RSI_PROKEY, '''') ' +
    '     , IFNULL(RSI_SUBKEY, '''') ' +
    '     , IFNULL(RSI_UNIDAD, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TResicolorMultiSelectLocalizadorBase }

constructor TResicolorMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   RSI_CADRSI C                   ' +
    '   INNER JOIN RSI_CADBAS B        ' +
    '     ON C.RSI_BASE__ = B.BAS_BASE__  ' +
    '     AND C.RSI_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.RSI_PROKEY = B.BAS_PROKEY ' +
    '     AND C.RSI_SUBKEY = B.BAS_SUBKEY ' +
    ' WHERE C.RSI_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   RSI_CADRSI C                   ' +
    '   INNER JOIN RSI_CADBAS B        ' +
    '     ON C.RSI_BASE__ = B.BAS_BASE__  ' +
    '     AND C.RSI_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.RSI_PROKEY = B.BAS_PROKEY ' +
    '     AND C.RSI_SUBKEY = B.BAS_SUBKEY ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.RSI_DESCRI, '''')      ' +
    '     , IFNULL(C.RSI_BASE__, '''')    ' +
    '     , IFNULL(C.RSI_CODIGO, '''')    ' +
    '     , IFNULL(C.RSI_CODIG2, '''')    ' +
    '     , IFNULL(C.RSI_PROKEY, '''')    ' +
    '     , IFNULL(C.RSI_SUBKEY, '''')    ' +
    '     , IFNULL(C.RSI_UNIDAD, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('RSI', TResicolorMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('RSIBAS', TResicolorMultiSelectLocalizadorBase);

end.
