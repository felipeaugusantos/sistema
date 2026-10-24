unit untLechlerAutomotivaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TLechlerAutomotivaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TLechlerAutomotivaTintadeMaquina }

function TLechlerAutomotivaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'LCA_CADCOL';
end;

function TLechlerAutomotivaLibTinta.GetIdePro: string;
begin
  Result := 'LCA';
end;

end.
