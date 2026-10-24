unit untInternationalLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TInternationalLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TInternationalTintadeMaquina }

function TInternationalLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'INT_CADCOL';
end;

function TInternationalLibTinta.GetIdePro: string;
begin
  Result := 'INT';
end;

end.
