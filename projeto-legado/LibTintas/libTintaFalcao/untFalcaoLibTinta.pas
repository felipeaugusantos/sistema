unit untFalcaoLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TFalcaoLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TFalcaoTintadeMaquina }

function TFalcaoLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'FAL_CADCOL';
end;

function TFalcaoLibTinta.GetIdePro: string;
begin
  Result := 'FAL';
end;

end.
