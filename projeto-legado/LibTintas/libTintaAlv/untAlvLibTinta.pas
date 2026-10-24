unit untAlvLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TAlvLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TAlvTintadeMaquina }

function TAlvLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'ALV_CADCOL';
end;

function TAlvLibTinta.GetIdePro: string;
begin
  Result := 'ALV';
end;

end.
