unit untAdvanceStrLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TAdvanceStrLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TAdvanceStrTintadeMaquina }

function TAdvanceStrLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'ADS_CADCOL';
end;

function TAdvanceStrLibTinta.GetIdePro: string;
begin
  Result := 'ADS';
end;

end.
