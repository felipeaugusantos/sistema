unit untRennerIndustrialLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TRennerIndustrialLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TRennerIndustrialTintadeMaquina }

function TRennerIndustrialLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'REN_CADCOL';
end;

function TRennerIndustrialLibTinta.GetIdePro: string;
begin
  Result := 'REN';
end;

end.
