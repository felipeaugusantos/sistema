unit untAutoluksMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TAutoluksMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TAutoluksMultiSelectLocalizador }

constructor TAutoluksMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ALK_CADALK               ' +
      ' WHERE ALK_MD5KEY = :ITETIN ');
  Except
    //
  End;


end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALK', TAutoluksMultiSelectLocalizador);

end.
