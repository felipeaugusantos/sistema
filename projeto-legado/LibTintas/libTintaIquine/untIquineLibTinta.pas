unit untIquineLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TIquineLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TIquineTintadeMaquina }

function TIquineLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'IQU_CADCOL';
end;

function TIquineLibTinta.GetIdePro: string;
begin
  Result := 'IQU';
end;

end.
