unit untAdvanceLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TAdvanceLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TAdvanceTintadeMaquina }

function TAdvanceLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'ADVCOR_CADCOL';
end;

function TAdvanceLibTinta.GetIdePro: string;
begin
  Result := 'ADV';
end;

end.
