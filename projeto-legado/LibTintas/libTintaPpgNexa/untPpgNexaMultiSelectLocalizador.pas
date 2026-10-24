unit untPpgNexaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TPpgNexaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TPpgNexaMultiSelectLocalizador }

constructor TPpgNexaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   PPX_CADPPX               ' +
      ' WHERE PPX_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   PPX_CADPPX               ' +
    ' WHERE PPX_CODSEQ = :ITETIN ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('PPX', TPpgNexaMultiSelectLocalizador);

end.
