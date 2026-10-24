unit untGlobalCsnLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TGlobalCsnLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TGlobalCsnTintadeMaquina }

function TGlobalCsnLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'CSN_CADCOL';
end;

function TGlobalCsnLibTinta.GetIdePro: string;
begin
  Result := 'CSN';
end;

end.
