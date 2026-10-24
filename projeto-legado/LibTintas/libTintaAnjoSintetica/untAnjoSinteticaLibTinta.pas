unit untAnjoSinteticaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TAnjoSinteticaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TAnjoSinteticaTintadeMaquina }

function TAnjoSinteticaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'AJA_CADCOL';
end;

function TAnjoSinteticaLibTinta.GetIdePro: string;
begin
  Result := 'AJA';
end;

end.
