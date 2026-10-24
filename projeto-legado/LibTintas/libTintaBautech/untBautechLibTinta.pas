unit untBautechLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TBautechLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TBautechTintadeMaquina }

function TBautechLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'BAU_CADCOL';
end;

function TBautechLibTinta.GetIdePro: string;
begin
  Result := 'BAU';
end;

end.
