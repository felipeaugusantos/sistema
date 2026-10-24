unit untKillingIndustrialMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TKillingIndustrialMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TKillingIndustrialMultiSelectLocalizador }

constructor TKillingIndustrialMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   KIN_CADKIN               ' +
      ' WHERE KIN_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('KIN', TKillingIndustrialMultiSelectLocalizador);

end.
