unit untStarmixWebMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TStarmixWebMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TStarmixWebMultiSelectLocalizador }

constructor TStarmixWebMultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   STW_CADSTW               ' +
    ' WHERE STW_MD5KEY = :ITETIN ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('STW', TStarmixWebMultiSelectLocalizador);

end.
