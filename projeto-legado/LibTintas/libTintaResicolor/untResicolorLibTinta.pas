unit untResicolorLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TResicolorLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TResicolorTintadeMaquina }

function TResicolorLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'RSI_CADCOL';
end;

function TResicolorLibTinta.GetIdePro: string;
begin
  Result := 'RSI';
end;

end.
