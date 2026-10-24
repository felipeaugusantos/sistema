unit untHydronorthImobiliariaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  THydronorthImobiliariaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  THydronorthImobiliariaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ THydronorthImobiliariaMultiSelectLocalizador }

constructor THydronorthImobiliariaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT HYD_MD5KEY FROM HYD_CADHYD WHERE FALSE', 'HYD_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   HYD_CADHYD            ' +
      ' WHERE HYD_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   HYD_CADHYD                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(HYD_COLECA, '''')   ' +
    '     , IFNULL(HYD_PRODUT, '''') ' +
    '     , IFNULL(HYD_C_O_R_, '''') ' +
    '     , IFNULL(HYD_CORLON, '''') ' +
    '     , IFNULL(HYD_BASE__, '''') ' +
    '     , IFNULL(HYD_CODEMB, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ THydronorthImobiliariaMultiSelectLocalizadorBase }

constructor THydronorthImobiliariaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   HYD_CADHYD C                   ' +
    '   INNER JOIN HYD_CADBAS B        ' +
    '     ON C.HYD_CODBAS = B.BAS_BASE__  ' +
    '     AND C.HYD_CODEMB = B.BAS_CODEMB' +
    '     AND C.HYD_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.HYD_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   HYD_CADHYD C                   ' +
    '   INNER JOIN HYD_CADBAS B        ' +
    '     ON C.HYD_CODBAS = B.BAS_BASE__  ' +
    '     AND C.HYD_CODEMB = B.BAS_CODEMB ' +
    '     AND C.HYD_PRODUT = B.BAS_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.HYD_PRODUT, '''')        ' +
    '     , IFNULL(C.HYD_BASE__, '''')      ' +
    '     , IFNULL(C.HYD_CODEMB, '''')      ' +
    '     , IFNULL(C.HYD_CODNFM, '''')      ' +
    '     , IFNULL(C.HYD_COLECA, '''')      ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('HYD', THydronorthImobiliariaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('HYDBAS', THydronorthImobiliariaMultiSelectLocalizadorBase);

end.
