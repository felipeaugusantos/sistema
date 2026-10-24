unit untLazzumixMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TLazzumixMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TLazzumixMultiSelectLocalizador }

constructor TLazzumixMultiSelectLocalizador.Create;
begin
  inherited Create;

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
