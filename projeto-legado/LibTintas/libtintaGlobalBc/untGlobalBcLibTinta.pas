unit untGlobalBcLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TGlobalBcLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TGlobalBcTintadeMaquina }

function TGlobalBcLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'GBC_CADCOL';
end;

function TGlobalBcLibTinta.GetIdePro: string;
begin
  Result := 'GBC';
end;

end.
