unit untMazaAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TMazaAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TMazaAutomotivaMultiSelectLocalizador }

constructor TMazaAutomotivaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   MZA_CADMZA               ' +
      ' WHERE MZA_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(' SELECT *                '+
    ' FROM MZA_CADMZA                '+
    ' WHERE                          '+
    '    UPPER(CAST(MD5(CONCAT(      '+
    '       IFNULL(MZA_CODIGO, ""),  '+
    '       IFNULL(MZA_VARIAC, ""),  '+
    '       IFNULL(MZA_DESCRI, ""),  '+
    '       IFNULL(MZA_ANOCOR, ""),  '+
    '       IFNULL(MZA_DTAFOR, ""),  '+
    '       IFNULL(MZA_LINHA_, ""),  '+
    '       IFNULL(MZA_CODMON, ""),  '+
    '       IFNULL(MZA_CODNFM, ""),  '+
    '       IFNULL(MZA_UNIVER, "")))AS CHAR)) = :ITETIN ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('MZA', TMazaAutomotivaMultiSelectLocalizador);

end.
