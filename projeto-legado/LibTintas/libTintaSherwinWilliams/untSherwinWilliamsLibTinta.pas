unit untSherwinWilliamsLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TSherwinWilliamsLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TSherwinWilliamsTintadeMaquina }

function TSherwinWilliamsLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'SHE_CADCOL';
end;

function TSherwinWilliamsLibTinta.GetIdePro: string;
begin
  Result := 'SHE';
end;

end.
