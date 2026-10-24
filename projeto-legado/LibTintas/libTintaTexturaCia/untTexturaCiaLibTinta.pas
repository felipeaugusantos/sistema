unit untTexturaCiaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TTexturaCiaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TTexturaCiaTintadeMaquina }

function TTexturaCiaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'TEX_CADCOL';
end;

function TTexturaCiaLibTinta.GetIdePro: string;
begin
  Result := 'TEX';
end;

end.
