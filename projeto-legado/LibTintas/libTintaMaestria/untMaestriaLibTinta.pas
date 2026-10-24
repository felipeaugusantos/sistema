unit untMaestriaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TMaestriaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TMaestriaTintadeMaquina }

function TMaestriaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'MAE_CADCOL';
end;

function TMaestriaLibTinta.GetIdePro: string;
begin
  Result := 'MAE';
end;

end.
