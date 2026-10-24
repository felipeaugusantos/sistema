unit untAlvAutomotivaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TAlvAutomotivaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TAlvAutomotivaTintadeMaquina }

function TAlvAutomotivaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'ALA_CADCOL';
end;

function TAlvAutomotivaLibTinta.GetIdePro: string;
begin
  Result := 'ALA';
end;

end.
