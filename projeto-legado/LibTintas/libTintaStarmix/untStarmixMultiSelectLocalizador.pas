unit untStarmixMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TStarmixMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TStarmixMultiSelectLocalizador }

constructor TStarmixMultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   STA_CADSTA               ' +
    ' WHERE STA_MD5KEY = :ITETIN ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('STA', TStarmixMultiSelectLocalizador);

end.
