unit untResicolor2LibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TResicolor2LibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TResicolor2TintadeMaquina }

function TResicolor2LibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'PRO_CADCOL';
end;

function TResicolor2LibTinta.GetIdePro: string;
begin
  Result := 'PRO';
end;

end.
