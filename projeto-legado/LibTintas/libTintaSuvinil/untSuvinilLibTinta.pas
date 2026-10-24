unit untSuvinilLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TSuvinilLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TSuvinilTintadeMaquina }

function TSuvinilLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'SUV_CADCOL';
end;

function TSuvinilLibTinta.GetIdePro: string;
begin
  Result := 'SUV';
end;

end.
