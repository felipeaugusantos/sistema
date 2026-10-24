unit untAnjoSinteticaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAnjoSinteticaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TAnjoSinteticaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TAnjoSinteticaMultiSelectLocalizador }

constructor TAnjoSinteticaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT AJA_MD5KEY FROM AJA_CADAJA WHERE FALSE', 'AJA_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   AJA_CADAJA               ' +
      ' WHERE AJA_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   AJA_CADAJA                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(AJA_DESCRI, '''')   ' +
    '     , IFNULL(AJA_BASE__, '''') ' +
    '     , IFNULL(AJA_CODIGO, '''') ' +
    '     , IFNULL(AJA_CODIG2, '''') ' +
    '     , IFNULL(AJA_UNIDAD, '''') ' +
    '     , IFNULL(AJA_PROKEY, '''') ' +
    '     , IFNULL(AJA_SUBKEY, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TAnjoSinteticaMultiSelectLocalizadorBase }

constructor TAnjoSinteticaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   AJA_CADAJA C                   ' +
    '   INNER JOIN AJA_CADBAS B        ' +
    '     ON C.AJA_BASE__ = B.BAS_BASE__  ' +
    '     AND C.AJA_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.AJA_PROKEY = B.BAS_PROKEY ' +
    '     AND C.AJA_SUBKEY = B.BAS_SUBKEY ' +
    ' WHERE C.AJA_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   AJA_CADAJA C                   ' +
    '   INNER JOIN AJA_CADBAS B        ' +
    '     ON C.AJA_BASE__ = B.BAS_BASE__  ' +
    '     AND C.AJA_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.AJA_PROKEY = B.BAS_PROKEY ' +
    '     AND C.AJA_SUBKEY = B.BAS_SUBKEY ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.AJA_DESCRI, '''')      ' +
    '     , IFNULL(C.AJA_BASE__, '''')    ' +
    '     , IFNULL(C.AJA_CODIGO, '''')    ' +
    '     , IFNULL(C.AJA_CODIG2, '''')    ' +
    '     , IFNULL(C.AJA_UNIDAD, '''')    ' +
    '     , IFNULL(C.AJA_PROKEY, '''')    ' +
    '     , IFNULL(C.AJA_SUBKEY, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('AJA', TAnjoSinteticaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('AJABAS', TAnjoSinteticaMultiSelectLocalizadorBase);

end.
