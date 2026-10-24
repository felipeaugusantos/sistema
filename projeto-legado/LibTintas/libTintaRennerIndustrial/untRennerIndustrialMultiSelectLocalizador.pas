unit untRennerIndustrialMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TRennerIndustrialMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TRennerIndustrialMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TRennerIndustrialMultiSelectLocalizador }

constructor TRennerIndustrialMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT REN_MD5KEY FROM REN_CADREN WHERE FALSE', 'REN_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   REN_CADREN            ' +
      ' WHERE REN_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   REN_CADREN                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(REN_DESCRI, '''')   ' +
    '     , IFNULL(REN_CODIGO, '''') ' +
    '     , IFNULL(REN_UNIDAD, '''') ' +
    '     , IFNULL(REN_CODBAS, '''') ' +
    '     , IFNULL(REN_CODEMB, '''') ' +
    '     , IFNULL(REN_CODUNI, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TRennerIndustrialMultiSelectLocalizadorBase }

constructor TRennerIndustrialMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   REN_CADREN C                   ' +
    '   INNER JOIN REN_CADBAS B        ' +
    '     ON C.REN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REN_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.REN_DESCRI = B.BAS_DESCRI ' +
    ' WHERE C.REN_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE  AS CODITE           ' +
    ' FROM                                ' +
    '   REN_CADREN C                   ' +
    '   INNER JOIN REN_CADBAS B        ' +
    '     ON C.REN_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REN_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.REN_DESCRI = B.BAS_DESCRI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.REN_DESCRI, '''')      ' +
    '     , IFNULL(C.REN_CODIGO, '''')    ' +
    '     , IFNULL(C.REN_UNIDAD, '''')    ' +
    '     , IFNULL(C.REN_CODBAS, '''')    ' +
    '     , IFNULL(C.REN_CODEMB, '''')    ' +
    '     , IFNULL(C.REN_CODUNI, '''')    ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('REN', TRennerIndustrialMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('RENBAS', TRennerIndustrialMultiSelectLocalizadorBase);

end.
