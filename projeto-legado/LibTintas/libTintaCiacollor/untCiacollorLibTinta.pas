unit untCiacollorLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TCiacollorLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TCiacollorTintadeMaquina }

function TCiacollorLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'CIA_CADCOL';
end;

function TCiacollorLibTinta.GetIdePro: string;
begin
  Result := 'CIA';
end;

end.
