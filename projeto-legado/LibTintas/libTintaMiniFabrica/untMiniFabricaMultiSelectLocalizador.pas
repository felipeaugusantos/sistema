unit untMiniFabricaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

type
  TMiniFabricaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory;

{ TMiniFabricaMultiSelectLocalizador }

constructor TMiniFabricaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   MIF_CADMIF               ' +
      ' WHERE MIF_MD5KEY = :ITETIN ');
  Except
    //
  End;


end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('MIF', TMiniFabricaMultiSelectLocalizador);

end.
