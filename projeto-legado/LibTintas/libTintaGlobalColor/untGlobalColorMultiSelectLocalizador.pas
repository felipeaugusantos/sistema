unit untGlobalColorMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TGlobalColorMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TGlobalColorMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TGlobalColorMultiSelectLocalizador }

constructor TGlobalColorMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT GLO_MD5KEY FROM GLO_CADGLO WHERE FALSE', 'GLO_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   GLO_CADGLO               ' +
      ' WHERE GLO_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   GLO_CADGLO                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(GLO_DESCRI, '''')   ' +
    '     , IFNULL(GLO_CODIGO, '''') ' +
    '     , IFNULL(GLO_UNIDAD, '''') ' +
    '     , IFNULL(GLO_CODBAS, '''') ' +
    '     , IFNULL(GLO_CODEMB, '''') ' +
    '     , IFNULL(GLO_CODUNI, '''') ' +
    '     , IFNULL(GLO_PRODUT, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TGlobalColorMultiSelectLocalizadorBase }

constructor TGlobalColorMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   GLO_CADGLO C                   ' +
    '   INNER JOIN GLO_CADBAS B        ' +
    '     ON C.GLO_CODBAS = B.BAS_BASE__  ' +
    '     AND C.GLO_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.GLO_PRODUT = B.BAS_DESCRI ' +
    ' WHERE C.GLO_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   GLO_CADGLO C                   ' +
    '   INNER JOIN GLO_CADBAS B        ' +
    '     ON C.GLO_CODBAS = B.BAS_BASE__  ' +
    '     AND C.GLO_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.GLO_PRODUT = B.BAS_DESCRI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.GLO_DESCRI, '''')      ' +
    '     , IFNULL(C.GLO_CODIGO, '''')    ' +
    '     , IFNULL(C.GLO_UNIDAD, '''')    ' +
    '     , IFNULL(C.GLO_CODBAS, '''')    ' +
    '     , IFNULL(C.GLO_CODEMB, '''')    ' +
    '     , IFNULL(C.GLO_CODUNI, '''')    ' +
    '     , IFNULL(C.GLO_PRODUT, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('GLO', TGlobalColorMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('GLOBAS', TGlobalColorMultiSelectLocalizadorBase);

end.
