unit Faturamento.Classes.TFaturador.EmitirNFCe;

interface

uses 
  Faturamento.Classes.TFaturador.Base;

type
  TEmitirNFCe = class(TFaturadorBase)
  protected
    procedure OnSetParametros; override;
  end;

implementation

{ TEmitirNFCe }
procedure TEmitirNFCe.OnSetParametros;
begin
  inherited;
  Self.SetEspFat('IF');
end;

end.
