unit Faturamento.Classes.TFaturador.EmitirNFe;

interface

uses
  Faturamento.Classes.TFaturador.Base;

type
  TEmitirNFe = class(TFaturadorBase)
  protected
    procedure OnSetParametros; override;
  end;

implementation

{ TEmitirNFe }

procedure TEmitirNFe.OnSetParametros;
begin
  inherited;
  Self.SetEspFat('NF');
end;

end.
