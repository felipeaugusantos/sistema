unit untAnjoImobiliaria2LibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TAnjoImobiliaria2LibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TAnjoImobiliaria2TintadeMaquina }

function TAnjoImobiliaria2LibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'PRO_CADCOL';
end;

function TAnjoImobiliaria2LibTinta.GetIdePro: string;
begin
  Result := 'PRO';
end;

end.
