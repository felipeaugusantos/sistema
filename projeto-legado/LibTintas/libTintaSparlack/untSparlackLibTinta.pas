unit untSparlackLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TSparlackLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TSparlackTintadeMaquina }

function TSparlackLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'SPA_CADCOL';
end;

function TSparlackLibTinta.GetIdePro: string;
begin
  Result := 'SPA';
end;

end.
