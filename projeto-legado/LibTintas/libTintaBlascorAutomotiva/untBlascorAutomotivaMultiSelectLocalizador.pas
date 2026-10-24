unit untBlascorAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TBlascorAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TBlascorAutomotivaMultiSelectLocalizador }

constructor TBlascorAutomotivaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   BLA_CADBLA               ' +
      ' WHERE BLA_MD5KEY = :ITETIN ');
  Except
    //
  End;


end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('BLA', TBlascorAutomotivaMultiSelectLocalizador);

end.
