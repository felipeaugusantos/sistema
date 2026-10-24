unit untNexaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TNexaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TNexaMultiSelectLocalizador }

constructor TNexaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   NEX_CADNEX               ' +
      ' WHERE NEX_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   NEX_CADNEX               ' +
    ' WHERE NEX_CODSEQ = :ITETIN ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('NEX', TNexaMultiSelectLocalizador);

end.
