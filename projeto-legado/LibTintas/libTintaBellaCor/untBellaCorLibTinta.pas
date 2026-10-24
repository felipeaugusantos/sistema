unit untBellaCorLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TBellaCorLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TBellaCorTintadeMaquina }

function TBellaCorLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'BEL_CADCOL';
end;

function TBellaCorLibTinta.GetIdePro: string;
begin
  Result := 'BEL';
end;

end.
