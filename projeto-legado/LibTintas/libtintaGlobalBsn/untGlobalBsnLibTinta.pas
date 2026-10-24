unit untGlobalBsnLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TGlobalBsnLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TGlobalBsnTintadeMaquina }

function TGlobalBsnLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'BSN_CADCOL';
end;

function TGlobalBsnLibTinta.GetIdePro: string;
begin
  Result := 'BSN';
end;

end.
