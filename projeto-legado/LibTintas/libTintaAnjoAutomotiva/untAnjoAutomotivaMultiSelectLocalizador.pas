unit untAnjoAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TAnjoAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TAnjoAutomotivaMultiSelectLocalizador }

constructor TAnjoAutomotivaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   AJT_CADAJT               ' +
      ' WHERE AJT_MD5KEY = :ITETIN ');
  Except
    //
  End;


end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('AJT', TAnjoAutomotivaMultiSelectLocalizador);

end.
