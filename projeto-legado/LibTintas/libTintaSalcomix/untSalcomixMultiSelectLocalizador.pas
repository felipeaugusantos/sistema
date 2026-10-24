unit untSalcomixMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TSalcomixMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TSalcomixMultiSelectLocalizador }

constructor TSalcomixMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   SAL_CADSAL               ' +
    ' WHERE SAL_MD5KEY = :ITETIN ');
  Except
    //
  End;


  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   SAL_CADSAL               ' +
    ' WHERE SAL_CODSEQ = :ITETIN ');

  Sqls.Add(
  '       SELECT                 ' +
  '         *                    ' +
  '       FROM                   ' +
  '         SAL_CADSAL           ' +
  '       WHERE                  ' +
  '         UPPER(CAST(MD5(CONCAT(IFNULL(SAL_LINHA_, ''''),                   ' +
  '         IFNULL(SAL_MONTAD, ''''), IFNULL(SAL_DESCRI, ''''),               ' +
  '         IFNULL(SAL_CODPRO, ''''), IFNULL(SAL_ANOCOR, ''''),               ' +
  '         IFNULL(SAL_VARIAC, ''''), IFNULL(SAL_FORM01, ''''),               ' +
  '         IFNULL(SAL_QTDB01, ''0.0''), IFNULL(SAL_FORM02, ''''),            ' +
  '         IFNULL(SAL_QTDB02, ''0.0''), IFNULL(SAL_FORM03, ''''),            ' +
  '         IFNULL(SAL_QTDB03, ''0.0''), IFNULL(SAL_FORM04, ''''),            ' +
  '         IFNULL(SAL_QTDB04, ''0.0''), IFNULL(SAL_FORM05, ''''),            ' +
  '         IFNULL(SAL_QTDB05, ''0.0''), IFNULL(SAL_FORM06, ''''),            ' +
  '         IFNULL(SAL_QTDB06, ''0.0''), IFNULL(SAL_FORM07, ''''),            ' +
  '         IFNULL(SAL_QTDB07, ''0.0''), IFNULL(SAL_FORM08, ''''),            ' +
  '         IFNULL(SAL_QTDB08, ''0.0''), IFNULL(SAL_FORM09, ''''),            ' +
  '         IFNULL(SAL_QTDB09, ''0.0''), IFNULL(SAL_FORM10, ''''),            ' +
  '         IFNULL(SAL_QTDB10, ''0.0''), IFNULL(SAL_FORM11, ''''),            ' +
  '         IFNULL(SAL_QTDB11, ''0.0''), IFNULL(SAL_FORM12, ''''),            ' +
  '         IFNULL(SAL_QTDB12, ''0.0''), IFNULL(SAL_FORM13, ''''),            ' +
  '         IFNULL(SAL_QTDB13, ''0.0''), IFNULL(SAL_FORM14, ''''),            ' +
  '         IFNULL(SAL_QTDB14, ''0.0''), IFNULL(SAL_FORM15, ''''),            ' +
  '         IFNULL(SAL_QTDB15, ''0.0''), IFNULL(SAL_FORM16, ''''),            ' +
  '         IFNULL(SAL_QTDB16, ''0.0''), IFNULL(SAL_FORM17, ''''),            ' +
  '         IFNULL(SAL_QTDB17, ''0.0''), IFNULL(SAL_FORM18, ''''),            ' +
  '         IFNULL(SAL_QTDB18, ''0.0''), IFNULL(SAL_FORM19, ''''),            ' +
  '         IFNULL(SAL_QTDB19, ''0.0''), IFNULL(SAL_FORM20, ''''),            ' +
  '         IFNULL(SAL_QTDB20, ''0.0''))) AS CHAR)) = :ITETIN                 ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SAL', TSalcomixMultiSelectLocalizador);

end.
