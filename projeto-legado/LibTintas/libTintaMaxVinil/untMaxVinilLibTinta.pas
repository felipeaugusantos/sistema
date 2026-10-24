unit untMaxVinilLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TMaxVinilLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TMaxVinilTintadeMaquina }

function TMaxVinilLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'MAX_CADCOL';
end;

function TMaxVinilLibTinta.GetIdePro: string;
begin
  Result := 'MAX';
end;

end.
