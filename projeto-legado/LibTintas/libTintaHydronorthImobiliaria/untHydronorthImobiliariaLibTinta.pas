unit untHydronorthImobiliariaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  THydronorthImobiliariaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ THydronorthImobiliariaTintadeMaquina }

function THydronorthImobiliariaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'HYD_CADCOL';
end;

function THydronorthImobiliariaLibTinta.GetIdePro: string;
begin
  Result := 'CIM';
end;

end.
