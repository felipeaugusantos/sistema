unit untBrasimixAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TBrasimixAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TBrasimixAutomotivaMultiSelectLocalizador }

constructor TBrasimixAutomotivaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   BZA_CADBZA               ' +
      ' WHERE BZA_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                                                                                       ' +
    '   *                                                                                          ' +
    ' FROM                                                                                         ' +
    '   BZA_CADBZA                                                                                 ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                                                                 ' +
    '           IFNULL(BZA_MONTAD, "")                                                             ' +
    '           , IFNULL(BZA_A_N_O_, "")                                                           ' +
    '           , IFNULL(BZA_DESCRI, "")                                                           ' +
    '           , IFNULL(BZA_CODUNI, "")                                                           ' +
    '           , IFNULL(BZA_ARQTXT, "")                                                           ' +
    '           , IFNULL(BZA_CODB01, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB01, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB02, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB02, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB03, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB03, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB04, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB04, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB05, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB05, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB06, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB06, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB07, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB07, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB08, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB08, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB09, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB09, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB10, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB10, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB11, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB11, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB12, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB12, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB13, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB13, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB14, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB14, 0.00000), 5), ",", "") ' +
    '           , IFNULL(BZA_CODB15, ""), REPLACE(FORMAT(IFNULL(BZA_QTDB15, 0.00000), 5), ",", "") ' +
    '         )) AS CHAR)) = :ITETIN                                                               ');

  Sqls.Add(
    ' SELECT                                         ' +
    '   *                                            ' +
    ' FROM                                           ' +
    '   BZA_CADBZA                                   ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                   ' +
    '           IFNULL(BZA_MONTAD, "")               ' +
    '           , IFNULL(BZA_A_N_O_, "")             ' +
    '           , IFNULL(BZA_DESCRI, "")             ' +
    '           , IFNULL(BZA_CODUNI, "")             ' +
    '           , IFNULL(BZA_ARQTXT, "")             ' +
    '           , IFNULL(BZA_CODB01, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB01, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB02, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB02, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB03, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB03, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB04, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB04, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB05, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB05, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB06, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB06, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB07, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB07, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB08, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB08, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB09, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB09, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB10, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB10, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB11, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB11, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB12, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB12, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB13, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB13, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB14, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB14, 0.0), 1) ' +
    '           , IFNULL(BZA_CODB15, "")             ' +
    '           , FORMAT(IFNULL(BZA_QTDB15, 0.0), 1) ' +
    '         )) AS CHAR)) = :ITETIN                 ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   BZA_CADBZA               ' +
    ' WHERE BZA_CODSEQ = :ITETIN ');

  Sqls.Add(
    ' SELECT                                                                             ' +
    '   *                                                                                ' +
    ' FROM                                                                               ' +
    '   BZA_CADBZA                                                                       ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                                                       ' +
    '           CAST(IFNULL(BZA_MONTAD, "") AS CHAR)                                     ' +
    '           , CAST(IFNULL(BZA_A_N_O_, "") AS CHAR)                                   ' +
    '           , CAST(IFNULL(BZA_DESCRI, "") AS CHAR)                                   ' +
    '           , CAST(IFNULL(BZA_CODUNI, "") AS CHAR)                                   ' +
    '           , CAST(IFNULL(BZA_ARQTXT, "") AS CHAR)                                   ' +
    '           , CAST(IFNULL(BZA_CODB01, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB01, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB02, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB02, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB03, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB03, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB04, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB04, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB05, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB05, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB06, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB06, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB07, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB07, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB08, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB08, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB09, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB09, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB10, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB10, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB11, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB11, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB12, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB12, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB13, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB13, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB14, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB14, 0.00000), 5), ",", "") AS CHAR) ' +
    '           , CAST(IFNULL(BZA_CODB15, "") AS CHAR)                                   ' +
    '           , CAST(REPLACE(FORMAT(IFNULL(BZA_QTDB15, 0.00000), 5), ",", "") AS CHAR) ' +
    '         )) AS CHAR)) = :ITETIN');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('BZA', TBrasimixAutomotivaMultiSelectLocalizador);

end.
