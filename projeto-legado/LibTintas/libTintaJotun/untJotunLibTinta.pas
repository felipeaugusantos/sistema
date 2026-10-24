unit untJotunLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TJotunLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TJotunTintadeMaquina }

function TJotunLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'JOT_CADCOL';
end;

function TJotunLibTinta.GetIdePro: string;
begin
  Result := 'JOT';
end;

end.
