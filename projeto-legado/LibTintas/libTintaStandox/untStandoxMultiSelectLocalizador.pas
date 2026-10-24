unit untStandoxMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TStandoxMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TStandoxMultiSelectLocalizador }

constructor TStandoxMultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   DOX_CADDOX               ' +
    ' WHERE DOX_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT * FROM DOX_CADDOX                                         ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                                     ' +
    ' 	  IFNULL(CAST(DOX_MONTAD AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_CODDOX AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_DESCRI AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_VERSAO AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_ANOINI AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_ANOFIN AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_PAINEL AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_CATEGO AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_PAIS__ AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_VARIAN AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_QUALID AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_INFCOR AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DOX_BASE01 AS CHAR), '''')                       ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC01, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE02, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC02, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE03, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC03, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE04, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC04, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE05, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC05, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE06, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC06, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE07, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC07, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE08, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC08, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE09, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC09, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE10, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC10, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE11, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC11, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE12, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC12, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE13, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC13, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE14, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC14, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE15, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC15, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE16, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC16, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE17, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC17, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE18, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC18, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE19, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC19, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DOX_BASE20, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DOX_QTDC20, 0.00000), 5), '','', '''') ' +
    ' 	)) AS CHAR)) = :ITETIN               ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('DOX', TStandoxMultiSelectLocalizador);

end.
