unit untAlterPlusLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TAlterPlusLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TAlterPlusTintadeMaquina }

function TAlterPlusLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'ALP_CADCOL';
end;

function TAlterPlusLibTinta.GetIdePro: string;
begin
  Result := 'ALP';
end;

end.
