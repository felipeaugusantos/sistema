unit untAdvanceTintoSystemLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TAdvanceTintoSystemLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TAdvanceTintoSystemTintadeMaquina }

function TAdvanceTintoSystemLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'ADT_CADCOL';
end;

function TAdvanceTintoSystemLibTinta.GetIdePro: string;
begin
  Result := 'CIM';
end;

end.
