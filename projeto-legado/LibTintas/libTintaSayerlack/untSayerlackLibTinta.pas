unit untSayerlackLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TSayerlackLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TSayerlackTintadeMaquina }

function TSayerlackLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'SAY_CADCOL';
end;

function TSayerlackLibTinta.GetIdePro: string;
begin
  Result := 'SAY';
end;

end.
