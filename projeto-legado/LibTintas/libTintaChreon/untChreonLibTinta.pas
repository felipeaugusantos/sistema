unit untChreonLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TChreonLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TChreonTintadeMaquina }

function TChreonLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'CHR_CADCOL';
end;

function TChreonLibTinta.GetIdePro: string;
begin
  Result := 'CHR';
end;

end.
