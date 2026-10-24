unit untRoberloLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TRoberloLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TRoberloTintadeMaquina }

function TRoberloLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'ROB_CADCOL';
end;

function TRoberloLibTinta.GetIdePro: string;
begin
  Result := 'ROB';
end;

end.
