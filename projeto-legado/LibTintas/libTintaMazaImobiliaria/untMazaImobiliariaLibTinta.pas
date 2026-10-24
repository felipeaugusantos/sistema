unit untMazaImobiliariaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TMazaImobiliariaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TMazaImobiliariaTintadeMaquina }

function TMazaImobiliariaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'MZI_CADCOL';
end;

function TMazaImobiliariaLibTinta.GetIdePro: string;
begin
  Result := 'MZI';
end;

end.
