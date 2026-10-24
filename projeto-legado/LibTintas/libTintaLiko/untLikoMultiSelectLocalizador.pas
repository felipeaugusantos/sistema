unit untLikoMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TLikoMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TLikoMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TLikoMultiSelectLocalizador }

constructor TLikoMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT LIK_MD5KEY FROM LIK_CADLIK WHERE FALSE', 'LIK_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   LIK_CADLIK            ' +
      ' WHERE LIK_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   LIK_CADLIK                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(LIK_DESCRI, '''')   ' +
    '     , IFNULL(LIK_CODIGO, '''') ' +
    '     , IFNULL(LIK_UNIDAD, '''') ' +
    '     , IFNULL(LIK_CODBAS, '''') ' +
    '     , IFNULL(LIK_CODEMB, '''') ' +
    '     , IFNULL(LIK_CODUNI, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TLikoMultiSelectLocalizadorBase }

constructor TLikoMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   LIK_CADLIK C                   ' +
    '   INNER JOIN LIK_CADBAS B        ' +
    '     ON C.LIK_CODBAS = B.BAS_BASE__  ' +
    '     AND C.LIK_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.LIK_DESCRI = B.BAS_DESCRI ' +
    ' WHERE C.LIK_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE  AS CODITE           ' +
    ' FROM                                ' +
    '   LIK_CADLIK C                   ' +
    '   INNER JOIN LIK_CADBAS B        ' +
    '     ON C.LIK_CODBAS = B.BAS_BASE__  ' +
    '     AND C.LIK_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.LIK_DESCRI = B.BAS_DESCRI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.LIK_DESCRI, '''')      ' +
    '     , IFNULL(C.LIK_CODIGO, '''')    ' +
    '     , IFNULL(C.LIK_UNIDAD, '''')    ' +
    '     , IFNULL(C.LIK_CODBAS, '''')    ' +
    '     , IFNULL(C.LIK_CODEMB, '''')    ' +
    '     , IFNULL(C.LIK_CODUNI, '''')    ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('LIK', TLikoMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('LIKBAS', TLikoMultiSelectLocalizadorBase);

end.
