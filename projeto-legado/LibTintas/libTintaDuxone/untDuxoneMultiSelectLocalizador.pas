unit untDuxoneMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TDuxoneMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TDuxoneMultiSelectLocalizador }

constructor TDuxoneMultiSelectLocalizador.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   DUX_CADDUX               ' +
    ' WHERE DUX_MD5KEY = :ITETIN ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('DUX', TDuxoneMultiSelectLocalizador);

end.
