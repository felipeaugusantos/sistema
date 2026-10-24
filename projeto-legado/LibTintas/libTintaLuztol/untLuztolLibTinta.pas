unit untLuztolLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TLuztolLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TLuztolTintadeMaquina }

function TLuztolLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'LUZ_CADCOL';
end;

function TLuztolLibTinta.GetIdePro: string;
begin
  Result := 'LUZ';
end;

end.
