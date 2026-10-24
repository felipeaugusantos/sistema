unit untDupontMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TDupontMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TDupontMultiSelectLocalizador }

constructor TDupontMultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   DUP_CADDUP               ' +
    ' WHERE DUP_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   DUP_CADDUP               ' +
    ' WHERE DUP_CODSEQ = :ITETIN ');

  Sqls.Add(
    ' SELECT * FROM DUP_CADDUP                                        ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                                    ' +
    ' 	IFNULL(CAST(DUP_CODDUP AS CHAR), '''')                         ' +
    ' 	, IFNULL(CAST(DUP_CODOEM AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DUP_LINHA_ AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DUP_QUALID AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DUP_ALTERN AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DUP_REGIAO AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DUP_DESCRI AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DUP_MONTAD AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DUP_ANOCOR AS CHAR), '''')                       ' +
    ' 	, IFNULL(CAST(DUP_BASE01 AS CHAR), '''')                       ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC01, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD01, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB01, ''''), IFNULL(DUP_BASE02, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC02, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD02, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB02, ''''), IFNULL(DUP_BASE03, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC03, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD03, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB03, ''''), IFNULL(DUP_BASE04, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC04, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD04, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB04, ''''), IFNULL(DUP_BASE05, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC05, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD05, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB05, ''''), IFNULL(DUP_BASE06, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC06, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD06, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB06, ''''), IFNULL(DUP_BASE07, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC07, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD07, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB07, ''''), IFNULL(DUP_BASE08, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC08, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD08, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB08, ''''), IFNULL(DUP_BASE09, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC09, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD09, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB09, ''''), IFNULL(DUP_BASE10, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC10, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD10, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB10, ''''), IFNULL(DUP_BASE11, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC11, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD11, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB11, ''''), IFNULL(DUP_BASE12, '''')           ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC12, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD12, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB12, '''')                                     ' +
    ' 	, IFNULL(DUP_BASE13, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC13, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD13, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB13, '''')                                     ' +
    ' 	, IFNULL(DUP_BASE14, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC14, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD14, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB14, '''')                                     ' +
    ' 	, IFNULL(DUP_BASE15, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC15, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD15, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB15, '''')                                     ' +
    ' 	, IFNULL(DUP_BASE16, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC16, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD16, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB16, '''')                                     ' +
    ' 	, IFNULL(DUP_BASE17, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC17, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD17, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB17, '''')                                     ' +
    ' 	, IFNULL(DUP_BASE18, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC18, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD18, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB18, '''')                                     ' +
    ' 	, IFNULL(DUP_BASE19, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC19, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD19, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB19, '''')                                     ' +
    ' 	, IFNULL(DUP_BASE20, '''')                                     ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDC20, 0.00000), 5), '','', '''') ' +
    ' 	, REPLACE(FORMAT(IFNULL(DUP_QTDD20, 0.00000), 5), '','', '''') ' +
    ' 	, IFNULL(DUP_TIPB20, ''''))) AS CHAR)) = :ITETIN               ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('DUP', TDupontMultiSelectLocalizador);

end.
