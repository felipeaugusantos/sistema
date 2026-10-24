unit untLazzumixMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TLazzumixMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation
uses untMultiSelectLocalizadorFactory;
{ TLazzumixMultiSelectLocalizador }

constructor TLazzumixMultiSelectLocalizador.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   LAZ_CADMIX               ' +
    ' WHERE MIX_MD5KEY = :ITETIN ');

  Sqls.Add(
    ' SELECT                                       ' +
    '   *                                          ' +
    ' FROM                                         ' +
    '   LAZ_CADMIX                                 ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(                 ' +
    '           IFNULL(MIX_DESCRI, "")             ' +
    '           , IFNULL(MIX_REFERE, "")           ' +
    '           , IFNULL(MIX_MONTAD, "")           ' +
    '           , IFNULL(MIX_A_N_O_, "")           ' +
    '           , IFNULL(MIX_UNIVER, "")           ' +
    '           , IFNULL(MIX_BASE01, "")           ' +
    '           , IFNULL(MIX_QTDC01, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC01, 0), 5) ' +
    '           , IFNULL(MIX_QTDC02, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC02, 0), 5) ' +
    '           , IFNULL(MIX_QTDC03, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC03, 0), 5) ' +
    '           , IFNULL(MIX_QTDC04, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC04, 0), 5) ' +
    '           , IFNULL(MIX_QTDC05, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC05, 0), 5) ' +
    '           , IFNULL(MIX_QTDC06, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC06, 0), 5) ' +
    '           , IFNULL(MIX_QTDC07, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC07, 0), 5) ' +
    '           , IFNULL(MIX_QTDC08, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC08, 0), 5) ' +
    '           , IFNULL(MIX_QTDC09, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC09, 0), 5) ' +
    '           , IFNULL(MIX_QTDC10, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC10, 0), 5) ' +
    '           , IFNULL(MIX_QTDC11, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC11, 0), 5) ' +
    '           , IFNULL(MIX_QTDC12, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC12, 0), 5) ' +
    '           , IFNULL(MIX_QTDC13, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC13, 0), 5) ' +
    '           , IFNULL(MIX_QTDC14, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC14, 0), 5) ' +
    '           , IFNULL(MIX_QTDC15, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC15, 0), 5) ' +
    '           , IFNULL(MIX_QTDC16, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC16, 0), 5) ' +
    '           , IFNULL(MIX_QTDC17, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC17, 0), 5) ' +
    '           , IFNULL(MIX_QTDC18, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC18, 0), 5) ' +
    '           , IFNULL(MIX_QTDC19, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC19, 0), 5) ' +
    '           , IFNULL(MIX_QTDC20, "")           ' +
    '           , FORMAT(IFNULL(MIX_QTDC20, 0), 5) ' +
    '           , IFNULL(MIX_CODNFM, "")           ' +
    '         )) AS CHAR)) = :ITETIN               ' );

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   LAZ_CADMIX               ' +
    ' WHERE MIX_CODIGO = :ITETIN ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('LAZ', TLazzumixMultiSelectLocalizador);

end.

