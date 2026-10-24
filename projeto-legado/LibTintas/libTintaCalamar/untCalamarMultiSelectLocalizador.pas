unit untCalamarMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TCalamarMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TCalamarMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TCalamarMultiSelectLocalizador }

constructor TCalamarMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT CAL_MD5KEY FROM CAL_CADCAL WHERE FALSE', 'CAL_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   CAL_CADCAL            ' +
      ' WHERE CAL_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   CAL_CADCAL                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(CAL_CODBAS, '''')   ' +
    '     , IFNULL(CAL_CODEMB, '''') ' +
    '     , IFNULL(CAL_KEY1__, '''') ' +
    '     , IFNULL(CAL_KEY2__, '''') ' +
    '     , IFNULL(CAL_KEY3__, '''') ' +
    '     , IFNULL(CAL_PRODUT, '''') ' +
    '     , IFNULL(CAL_COLECA, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TCalamarMultiSelectLocalizadorBase }

constructor TCalamarMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CAL_CADCAL C                   ' +
    '   INNER JOIN CAL_CADBAS B        ' +
    '     ON C.CAL_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.CAL_CODEMB = B.BAS_CODEMB' +
 //   '     AND C.CAL_PRODUT = B.BAS_DESCRI ' +
    ' WHERE C.CAL_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE  AS CODITE           ' +
    ' FROM                                ' +
    '   CAL_CADCAL C                   ' +
    '   INNER JOIN CAL_CADBAS B        ' +
    '     ON C.CAL_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.CAL_CODEMB = B.BAS_CODEMB ' +
   // '     AND C.CAL_PRODUT = B.BAS_DESCRI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.CAL_CODBAS, '''')        ' +
    '     , IFNULL(C.CAL_CODEMB, '''')      ' +
    '     , IFNULL(C.CAL_KEY1__, '''')      ' +
    '     , IFNULL(C.CAL_KEY2__, '''')      ' +
    '     , IFNULL(C.CAL_KEY3__, '''')      ' +
    '     , IFNULL(C.CAL_PRODUT, '''')      ' +
    '     , IFNULL(C.CAL_COLECA, '''')      ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('CAL', TCalamarMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('CALBAS', TCalamarMultiSelectLocalizadorBase);

end.
