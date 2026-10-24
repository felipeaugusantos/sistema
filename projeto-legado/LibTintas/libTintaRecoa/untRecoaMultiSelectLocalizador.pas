unit untRecoaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TRecoaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TRecoaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TRecoaMultiSelectLocalizador }

constructor TRecoaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT REC_MD5KEY FROM REC_CADREC WHERE FALSE', 'REC_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   REC_CADREC               ' +
      ' WHERE REC_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   REC_CADREC                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(REC_DESCRI, '''')   ' +
    '     , IFNULL(REC_CODIGO, '''') ' +
    '     , IFNULL(REC_UNIDAD, '''') ' +
    '     , IFNULL(REC_CODBAS, '''') ' +
    '     , IFNULL(REC_CODEMB, '''') ' +
    '     , IFNULL(REC_CODUNI, '''') ' +
    '   ) = :ITETIN                  ');
end;

{ TRecoaMultiSelectLocalizadorBase }

constructor TRecoaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   REC_CADREC C                   ' +
    '   INNER JOIN REC_CADBAS B        ' +
    '     ON C.REC_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REC_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.REC_DESCRI = B.BAS_DESCRI ' +
    ' WHERE C.REC_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   REC_CADREC C                   ' +
    '   INNER JOIN REC_CADBAS B        ' +
    '     ON C.REC_CODBAS = B.BAS_BASE__  ' +
    '     AND C.REC_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.REC_DESCRI = B.BAS_DESCRI ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.REC_DESCRI, '''')      ' +
    '     , IFNULL(C.REC_CODIGO, '''')    ' +
    '     , IFNULL(C.REC_UNIDAD, '''')    ' +
    '     , IFNULL(C.REC_CODBAS, '''')    ' +
    '     , IFNULL(C.REC_CODEMB, '''')    ' +
    '     , IFNULL(C.REC_CODUNI, '''')    ' +
    '   ) = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('REC', TRecoaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('RECBAS', TRecoaMultiSelectLocalizadorBase);

end.
