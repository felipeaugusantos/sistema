unit untSherwinWilliams2LibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TSherwinWilliams2LibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TSherwinWilliams2TintadeMaquina }

function TSherwinWilliams2LibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'SHW_CADCOL';
end;

function TSherwinWilliams2LibTinta.GetIdePro: string;
begin
  Result := 'SHW';
end;

end.
