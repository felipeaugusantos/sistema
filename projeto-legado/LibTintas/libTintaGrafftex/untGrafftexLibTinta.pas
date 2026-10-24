unit untGrafftexLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TGrafftexLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TGrafftexTintadeMaquina }

function TGrafftexLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'GRA_CADCOL';
end;

function TGrafftexLibTinta.GetIdePro: string;
begin
  Result := 'GRA';
end;

end.
