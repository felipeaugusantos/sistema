unit untKillingLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TKillingLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TKillingTintadeMaquina }

function TKillingLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'KILD_CADCOL';
end;

function TKillingLibTinta.GetIdePro: string;
begin
  Result := 'KIL';
end;

end.
