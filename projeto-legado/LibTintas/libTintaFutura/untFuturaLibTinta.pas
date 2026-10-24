unit untFuturaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TFuturaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TFuturaTintadeMaquina }

function TFuturaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'FUT_CADCOL';
end;

function TFuturaLibTinta.GetIdePro: string;
begin
  Result := 'FUT';
end;

end.
