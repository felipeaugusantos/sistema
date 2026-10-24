unit untLeinertexLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TLeinertexLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TLeinertexTintadeMaquina }

function TLeinertexLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'LEI_CADCOL';
end;

function TLeinertexLibTinta.GetIdePro: string;
begin
  Result := 'LEI';
end;

end.
