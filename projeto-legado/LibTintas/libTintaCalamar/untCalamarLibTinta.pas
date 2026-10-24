unit untCalamarLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TCalamarLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TCalamarTintadeMaquina }

function TCalamarLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'CAL_CADCOL';
end;

function TCalamarLibTinta.GetIdePro: string;
begin
  Result := 'CIM';
end;

end.
