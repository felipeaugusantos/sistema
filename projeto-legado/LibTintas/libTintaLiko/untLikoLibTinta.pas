unit untLikoLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TLikoLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TLikoTintadeMaquina }

function TLikoLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'LIK_CADCOL';
end;

function TLikoLibTinta.GetIdePro: string;
begin
  Result := 'LIK';
end;

end.
