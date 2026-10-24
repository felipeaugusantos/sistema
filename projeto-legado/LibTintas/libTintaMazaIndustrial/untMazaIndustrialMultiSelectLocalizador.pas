unit untMazaIndustrialMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TMazaIndustrialMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TMazaIndustrialMultiSelectLocalizador }

constructor TMazaIndustrialMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   MZD_CADMZD               ' +
      ' WHERE MZD_MD5KEY = :ITETIN ');
  Except
    //
  End;


  Sqls.Add(' SELECT *                '+
    ' FROM MZD_CADMZD                '+
    ' WHERE                          '+
    '    UPPER(CAST(MD5(CONCAT(      '+
    '       IFNULL(MZD_CODIGO, ""),  '+
    '       IFNULL(MZD_VARIAC, ""),  '+
    '       IFNULL(MZD_DESCRI, ""),  '+
    '       IFNULL(MZD_ANOCOR, ""),  '+
    '       IFNULL(MZD_DTAFOR, ""),  '+
    '       IFNULL(MZD_LINHA_, ""),  '+
    '       IFNULL(MZD_CODMON, ""),  '+
    '       IFNULL(MZD_CODNFM, ""),  '+
    '       IFNULL(MZD_UNIVER, "")))AS CHAR)) = :ITETIN ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('MZD', TMazaIndustrialMultiSelectLocalizador);

end.
