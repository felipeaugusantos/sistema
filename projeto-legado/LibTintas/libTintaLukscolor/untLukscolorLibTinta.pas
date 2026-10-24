unit untLukscolorLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TLukscolorLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TLukscolorTintadeMaquina }

function TLukscolorLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'LKD_CADCOL';
end;

function TLukscolorLibTinta.GetIdePro: string;
begin
  Result := 'LKS';
end;

end.
