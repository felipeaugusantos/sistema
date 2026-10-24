unit untQualyVinilLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TQualyVinilLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TQualyVinilTintadeMaquina }

function TQualyVinilLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'QUA_CADCOL';
end;

function TQualyVinilLibTinta.GetIdePro: string;
begin
  Result := 'QUA';
end;

end.
