unit untSinteplastLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TSinteplastLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TSinteplastTintadeMaquina }

function TSinteplastLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'SIN_CADCOL';
end;

function TSinteplastLibTinta.GetIdePro: string;
begin
  Result := 'SIN';
end;

end.
