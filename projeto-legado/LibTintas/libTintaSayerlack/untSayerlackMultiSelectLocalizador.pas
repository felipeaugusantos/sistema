unit untSayerlackMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TSayerlackMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TSayerlackMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TSayerlackMultiSelectLocalizador }

constructor TSayerlackMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT SAY_MD5KEY FROM SAY_CADSAY WHERE FALSE', 'SAY_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   SAY_CADSAY            ' +
      ' WHERE SAY_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   SAY_CADSAY                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(SAY_BASE__, '''')   ' +
    '     , IFNULL(SAY_CODBAS, '''') ' +
    '     , IFNULL(SAY_PRODUT, '''') ' +
    '     , IFNULL(SAY_CODIGO, '''') ' +
    '     , IFNULL(SAY_DESEMB, '''') ' +
    '   ) = :ITETIN                  ');

end;

{ TSayerlackMultiSelectLocalizadorBase }

constructor TSayerlackMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   SAY_CADSAY C                   ' +
    '   INNER JOIN SAY_CADBAS B        ' +
    '     ON C.SAY_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.SAY_DESEMB = B.BAS_DESEMB' +
    '     AND C.SAY_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.SAY_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   SAY_CADSAY C                   ' +
    '   INNER JOIN SAY_CADBAS B        ' +
    '     ON C.SAY_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.SAY_DESEMB = B.BAS_DESEMB ' +
    '     AND C.SAY_PRODUT = B.BAS_PRODUT ' +
    ' WHERE CONCAT(                       ' +
    '     IFNULL(C.SAY_BASE__, '''')  ,  ' +
    '     IFNULL(C.SAY_CODBAS, '''')  ,  ' +
    '     IFNULL(C.SAY_PRODUT, '''')  ,  ' +
    '     IFNULL(C.SAY_CODIGO, '''')  ,  ' +
    '     IFNULL(C.SAY_DESEMB, '''')     ' +
    '   ) = :ITETIN                       ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SAY', TSayerlackMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('SAYBAS', TSayerlackMultiSelectLocalizadorBase);

end.
