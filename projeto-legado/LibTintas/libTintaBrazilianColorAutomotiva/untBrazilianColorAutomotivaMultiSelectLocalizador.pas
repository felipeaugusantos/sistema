unit untBrazilianColorAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TBrazilianColorAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TBrazilianColorAutomotivaMultiSelectLocalizador }

constructor TBrazilianColorAutomotivaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   BZC_CADBZC               ' +
    ' WHERE BZC_MD5KEY = :ITETIN ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('BZC', TBrazilianColorAutomotivaMultiSelectLocalizador);

end.
