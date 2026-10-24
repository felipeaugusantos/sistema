unit untInternationalMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TInternationalMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TInternationalMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TInternationalMultiSelectLocalizador }

constructor TInternationalMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT INT_MD5KEY FROM INT_CADINT WHERE FALSE', 'INT_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   INT_CADINT            ' +
      ' WHERE INT_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   INT_CADINT                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(INT_LINHA_, '''')   ' +
    '     , IFNULL(INT_DESCOR, '''') ' +
    '     , IFNULL(INT_CODBAS, '''') ' +
    '     , IFNULL(INT_CODEMB, '''') ' +
    '     , IFNULL(INT_CODNFM, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TInternationalMultiSelectLocalizadorBase }

constructor TInternationalMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   INT_CADINT C                   ' +
    '   INNER JOIN INT_CADBAS B        ' +
    '     ON C.INT_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.INT_CODEMB = B.BAS_CODEMB' +
    ' WHERE C.INT_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   INT_CADINT C                   ' +
    '   INNER JOIN INT_CADBAS B        ' +
    '     ON C.INT_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.INT_CODEMB = B.BAS_CODEMB ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.INT_LINHA_, '''')        ' +
    '     , IFNULL(C.INT_DESCOR, '''')      ' +
    '     , IFNULL(C.INT_CODBAS, '''')      ' +
    '     , IFNULL(C.INT_CODEMB, '''')      ' +
    '     , IFNULL(C.INT_CODNFM, '''')      ' +
    '   ) = :ITETIN                         ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('INT', TInternationalMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('INTBAS', TInternationalMultiSelectLocalizadorBase);

end.
