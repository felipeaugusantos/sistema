unit untDuxone2MultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TDuxone2MultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TDuxone2MultiSelectLocalizador }

constructor TDuxone2MultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   DU2_CADDU2               ' +
    ' WHERE DU2_MD5KEY = :ITETIN ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('DU2', TDuxone2MultiSelectLocalizador);

end.
