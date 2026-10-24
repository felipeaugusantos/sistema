unit untSkymixMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador;

type
  TSkymixMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation
uses untMultiSelectLocalizadorFactory;
{ TSkymixMultiSelectLocalizador }

constructor TSkymixMultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   SKY_CADSKY                   ' +
    '   LEFT JOIN SKY_CADMON         ' +
    '     ON SKY_CODMON = MON_CODMON ' +
    ' WHERE SKY_MD5KEY = :ITETIN     ');

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   SKY_CADSKY                   ' +
    '   LEFT JOIN SKY_CADMON         ' +
    '     ON SKY_CODMON = MON_CODMON ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(SKY_CODPRO, "")     ' +
    '     , IFNULL(SKY_DESCRI, "")   ' +
    '     , IFNULL(SKY_ANOFAB, "")   ' +
    '     , IFNULL(SKY_ANUANC, "")   ' +
    '     , IFNULL(SKY_CORPAI, "")   ' +
    '     , IFNULL(SKY_NACIMP, "")   ' +
    '     , IFNULL(SKY_CODMON, "")   ' +
    '     , IFNULL(SKY_CODGRU, "")   ' +
    '     , IFNULL(SKY_CODSGR, "")   ' +
    '     , IFNULL(SKY_VERSAO, "")   ' +
    '   ) = :ITETIN                  ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SKY', TSkymixMultiSelectLocalizador);

end.


