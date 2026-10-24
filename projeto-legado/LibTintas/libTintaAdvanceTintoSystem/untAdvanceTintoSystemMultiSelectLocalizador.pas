unit untAdvanceTintoSystemMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAdvanceTintoSystemMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TAdvanceTintoSystemMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TAdvanceTintoSystemMultiSelectLocalizador }

constructor TAdvanceTintoSystemMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ADT_MD5KEY FROM ADT_CADADT WHERE FALSE', 'ADT_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ADT_CADADT            ' +
      ' WHERE ADT_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   ADT_CADADT                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(ADT_IDFORM, '''')   ' +
    '     , IFNULL(ADT_CODCOR, '''') ' +
    '     , IFNULL(ADT_CODTEC, '''') ' +
    '     , IFNULL(ADT_CODBAS, '''') ' +
    '     , IFNULL(ADT_PRODUT, '''') ' +
    '     , IFNULL(ADT_CODEMB, '''') ' +
    '     , IFNULL(ADT_CODCAT, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TAdvanceTintoSystemMultiSelectLocalizadorBase }

constructor TAdvanceTintoSystemMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   ADT_CADADT C                   ' +
    '   INNER JOIN ADT_CADBAS B        ' +
    '     ON C.ADT_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.ADT_CODEMB = B.BAS_CODEMB' +
    '     AND C.ADT_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.ADT_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE  AS CODITE           ' +
    ' FROM                                ' +
    '   ADT_CADADT C                   ' +
    '   INNER JOIN ADT_CADBAS B        ' +
    '     ON C.ADT_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.ADT_CODEMB = B.BAS_CODEMB ' +
    '     AND C.ADT_PRODUT = B.BAS_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.ADT_IDFORM, '''')        ' +
    '     , IFNULL(C.ADT_CODCOR, '''')      ' +
    '     , IFNULL(C.ADT_CODTEC, '''')      ' +
    '     , IFNULL(C.ADT_CODBAS, '''')      ' +
    '     , IFNULL(C.ADT_PRODUT, '''')      ' +
    '     , IFNULL(C.ADT_CODEMB, '''')      ' +
    '     , IFNULL(C.ADT_CODCAT, '''')      ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ADT', TAdvanceTintoSystemMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ADTBAS', TAdvanceTintoSystemMultiSelectLocalizadorBase);

end.
