unit untDacasaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TDacasaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TDacasaTintadeMaquina }

function TDacasaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'DCA_CADCOL';
end;

function TDacasaLibTinta.GetIdePro: string;
begin
  Result := 'DCA';
end;

end.
