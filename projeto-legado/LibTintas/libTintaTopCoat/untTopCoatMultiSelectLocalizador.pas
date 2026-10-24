unit untTopCoatMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TTopCoatMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TTopCoatMultiSelectLocalizador }

constructor TTopCoatMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   COA_CADCOA               ' +
      ' WHERE COA_MD5KEY = :ITETIN ');
  Except
    //
  End;


end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('COA', TTopCoatMultiSelectLocalizador);

end.
