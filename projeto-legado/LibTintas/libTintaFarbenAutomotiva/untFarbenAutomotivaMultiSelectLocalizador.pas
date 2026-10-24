unit untFarbenAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TFarbenAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TFarbenAutomotivaMultiSelectLocalizador }

constructor TFarbenAutomotivaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   FAR_CADFAR               ' +
    ' WHERE FAR_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                                                               ' +
    '   *                                                                  ' +
    ' FROM                                                                 ' +
    '   FAR_CADFAR                                                         ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                                         ' +
    '           IFNULL(FAR_MONTAD, "")                                     ' +
    '           , IFNULL(FAR_O_E_M_, "")                                   ' +
    '           , IFNULL(FAR_A_N_O_, "")                                   ' +
    '           , IFNULL(FAR_DESCRI, "")                                   ' +
    '           , IFNULL(FAR_SETOR_, "")                                   ' +
    '           , IFNULL(FAR_LINHA_, "")                                   ' +
    '           , IFNULL(FAR_CODB01, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD01, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC01, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB02, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD02, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC02, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB03, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD03, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC03, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB04, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD04, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC04, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB05, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD05, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC05, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB06, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD06, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC06, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB07, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD07, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC07, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB08, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD08, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC08, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB09, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD09, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC09, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB10, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD10, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC10, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB11, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD11, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC11, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB12, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD12, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC12, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB13, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD13, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC13, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB14, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD14, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC14, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB15, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD15, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC15, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB16, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD16, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC16, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB17, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD17, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC17, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB18, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD18, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC18, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB19, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD19, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC19, 0.00000), 5), ",", "") ' +
    '           , IFNULL(FAR_CODB20, "")                                   ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDD20, 0.00000), 5), ",", "") ' +
    '           , REPLACE(FORMAT(IFNULL(FAR_QTDC20, 0.00000), 5), ",", "") ' +
    '         )) AS CHAR)) = :ITETIN                                       ');

  Sqls.Add(
    ' SELECT                                         ' +
    '   *                                            ' +
    ' FROM                                           ' +
    '   FAR_CADFAR                                   ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                   ' +
    '           IFNULL(FAR_MONTAD, "")               ' +
    '           , IFNULL(FAR_O_E_M_, "")             ' +
    '           , IFNULL(FAR_A_N_O_, "")             ' +
    '           , IFNULL(FAR_DESCRI, "")             ' +
    '           , IFNULL(FAR_SETOR_, "")             ' +
    '           , IFNULL(FAR_LINHA_, "")             ' +
    '           , IFNULL(FAR_CODB01, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD01, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC01, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB02, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD02, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC02, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB03, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD03, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC03, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB04, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD04, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC04, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB05, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD05, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC05, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB06, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD06, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC06, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB07, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD07, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC07, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB08, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD08, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC08, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB09, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD09, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC09, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB10, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD10, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC10, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB11, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD11, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC11, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB12, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD12, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC12, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB13, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD13, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC13, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB14, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD14, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC14, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB15, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD15, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC15, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB16, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD16, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC16, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB17, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD17, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC17, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB18, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD18, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC18, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB19, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD19, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC19, 0.0), 1) ' +
    '           , IFNULL(FAR_CODB20, "")             ' +
    '           , FORMAT(IFNULL(FAR_QTDD20, 0.0), 1) ' +
    '           , FORMAT(IFNULL(FAR_QTDC20, 0.0), 1) ' +
    '         )) AS CHAR)) = :ITETIN                 ');

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   FAR_CADFAR               ' +
    ' WHERE FAR_CODSEQ = :ITETIN ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('FAR', TFarbenAutomotivaMultiSelectLocalizador);

end.
