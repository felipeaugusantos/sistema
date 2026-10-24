unit untRecoaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TRecoaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TRecoaTintadeMaquina }

function TRecoaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'REC_CADCOL';
end;

function TRecoaLibTinta.GetIdePro: string;
begin
  Result := 'REC';
end;

end.
