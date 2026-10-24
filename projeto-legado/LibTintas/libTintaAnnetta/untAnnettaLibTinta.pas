unit untAnnettaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TAnnettaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TAnnettaTintadeMaquina }

function TAnnettaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'ANN_CADCOL';
end;

function TAnnettaLibTinta.GetIdePro: string;
begin
  Result := 'ANN';
end;

end.
