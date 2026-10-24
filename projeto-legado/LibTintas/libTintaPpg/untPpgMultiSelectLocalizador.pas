unit untPpgMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TPpgMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TPpgMultiSelectLocalizador }

constructor TPpgMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   PPG_CADPPG               ' +
      ' WHERE PPG_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                     ' +
    '   *                        ' +
    ' FROM                       ' +
    '   PPG_CADPPG               ' +
    ' WHERE PPG_CODSEQ = :ITETIN ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('PPG', TPpgMultiSelectLocalizador);

end.
