unit untGeneralMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TGeneralMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TGeneralMultiSelectLocalizador }

constructor TGeneralMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   GEN_CADGEN               ' +
      ' WHERE GEN_MD5KEY = :ITETIN ');
  Except
    //
  End;

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('GEN', TGeneralMultiSelectLocalizador);

end.
