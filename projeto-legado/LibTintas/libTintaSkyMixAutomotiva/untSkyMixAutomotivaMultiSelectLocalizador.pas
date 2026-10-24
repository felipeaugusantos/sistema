unit untSkyMixAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TSkyMixAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TSkyMixAutomotivaMultiSelectLocalizador }

constructor TSkyMixAutomotivaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   SKY_CADSKY               ' +
      ' WHERE SKY_MD5KEY = :ITETIN ');

    Sqls.Add(
      ' SELECT                          ' +
      '   * FROM                        ' +
      ' SKY_CADSKY                      ' +
      '   WHERE UPPER(CAST(MD5(CONCAT(  ' +
      '         IFNULL(SKY_CODPRO, ""), ' +
      '         IFNULL(SKY_DESCRI, ""), ' +
      '         IFNULL(SKY_ANOFAB, ""), ' +
      '         IFNULL(SKY_ANUANC, ""), ' +
      '         IFNULL(SKY_CORPAI, ""), ' +
      '         IFNULL(SKY_NACIMP, ""), ' +
      '         IFNULL(SKY_CODMON, ""), ' +
      '         IFNULL(SKY_CODGRU, ""), ' +
      '         IFNULL(SKY_CODSGR, ""), ' +
      '         IFNULL(SKY_VERSAO, "")  ' +
      ' )) AS CHAR)) = :ITETIN          ');

  Except
    //
  End;

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SKY', TSkyMixAutomotivaMultiSelectLocalizador);

end.
