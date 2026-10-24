unit untWegLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TWegLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TWegTintadeMaquina }

function TWegLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'WEGCADCOL';
end;

function TWegLibTinta.GetIdePro: string;
begin
  Result := 'WEG';
end;

end.
