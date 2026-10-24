unit untBellaCorTintavelLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TBellaCorTintavelLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TBellaCorTintavelTintadeMaquina }

function TBellaCorTintavelLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'BLT_CADCOL';
end;

function TBellaCorTintavelLibTinta.GetIdePro: string;
begin
  Result := 'BLT';
end;

end.
