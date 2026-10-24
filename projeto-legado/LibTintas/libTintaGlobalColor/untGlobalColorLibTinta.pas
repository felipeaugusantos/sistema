unit untGlobalColorLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TGlobalColorLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TGlobalColorTintadeMaquina }

function TGlobalColorLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'GLO_CADCOL';
end;

function TGlobalColorLibTinta.GetIdePro: string;
begin
  Result := 'GLO';
end;

end.
