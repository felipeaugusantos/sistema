unit untLechlerLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TLechlerLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TLechlerTintadeMaquina }

function TLechlerLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'LEC_CADCOL';
end;

function TLechlerLibTinta.GetIdePro: string;
begin
  Result := 'LEC';
end;

end.
