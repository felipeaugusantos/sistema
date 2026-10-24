unit untCoralImobiliariaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TCoralImobiliariaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TCoralImobiliariaTintadeMaquina }

function TCoralImobiliariaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'CORIMO_CADCOL';
end;

function TCoralImobiliariaLibTinta.GetIdePro: string;
begin
  Result := 'CIM';
end;

end.
