unit untMegaTintasLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TMegaTintasLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TMegaTintasTintadeMaquina }

function TMegaTintasLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'MEG_CADCOL';
end;

function TMegaTintasLibTinta.GetIdePro: string;
begin
  Result := 'MEG';
end;

end.
