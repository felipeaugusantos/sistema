unit untRennerPerformanceLibTinta;

interface

uses
  untAbstractLibTintaImobiliaria, untILibTinta, untTipoTinta;

type
  TRennerPerformanceLibTinta = class(TAbstractLibTintaImobiliaria)
  public
    function GetIdePro: string; override;
    function fRetornaTabelaColoranteTinta(): String; override;
  end;

implementation

{ TRennerPerformanceTintadeMaquina }

function TRennerPerformanceLibTinta.fRetornaTabelaColoranteTinta: String;
begin
  Result := 'REP_CADCOL';
end;

function TRennerPerformanceLibTinta.GetIdePro: string;
begin
  Result := 'REP';
end;

end.
