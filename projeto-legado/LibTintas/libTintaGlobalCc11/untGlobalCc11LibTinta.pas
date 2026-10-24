unit untGlobalCc11LibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TGlobalCc11LibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TGlobalCc11TintadeMaquina }

function TGlobalCc11LibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'C11_CADCOL';
end;

function TGlobalCc11LibTinta.GetIdePro: string;
begin
  Result := 'C11';
end;

end.
