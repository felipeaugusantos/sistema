unit untInkorLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TInkorLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TInkorTintadeMaquina }

function TInkorLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'INK_CADCOL';
end;

function TInkorLibTinta.GetIdePro: string;
begin
  Result := 'INK';
end;

end.
