unit untProfissionalTintasLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TProfissionalTintasLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TProfissionalTintasTintadeMaquina }

function TProfissionalTintasLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'PRO_CADCOL';
end;

function TProfissionalTintasLibTinta.GetIdePro: string;
begin
  Result := 'PRO';
end;

end.
