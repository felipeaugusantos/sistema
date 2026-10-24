unit untProfissionalAutomotivaLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TProfissionalAutomotivaLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TProfissionalAutomotivaTintadeMaquina }

function TProfissionalAutomotivaLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'PFA_CADCOL';
end;

function TProfissionalAutomotivaLibTinta.GetIdePro: string;
begin
  Result := 'PFA';
end;

end.
