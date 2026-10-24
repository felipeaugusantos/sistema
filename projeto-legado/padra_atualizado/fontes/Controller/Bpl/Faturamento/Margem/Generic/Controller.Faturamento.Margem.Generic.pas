unit Controller.Faturamento.Margem.Generic;

interface

uses Controller.Faturamento.Interfaces.Margem.Generic,
  Controller.Faturamento.Interfaces.Margem.MargemBruta,
  Controller.Faturamento.Margem.MargemBruta,
  Controller.Faturamento.Interfaces.Margem.MargemVenda,
  Controller.Faturamento.Margem.MargemVenda;


type
  TControllerFaturamentoMargemGeneric = class sealed(TInterfacedObject, IControllerFaturamentoMargemGeneric)
  private    
  public
    function MargemBruta: IControllerFaturamentoMargemBruta;    
    function MargemVenda: IControllerFaturamentoMargemVenda;

    destructor Destroy; override;

    class function New(): IControllerFaturamentoMargemGeneric;
  end;

implementation

{ TControllerFaturamentoMargemGeneric }

destructor TControllerFaturamentoMargemGeneric.Destroy;
begin

  inherited;
end;


function TControllerFaturamentoMargemGeneric.MargemBruta: IControllerFaturamentoMargemBruta;
begin
  Result := TControllerFaturamentoMargemBruta.New();
end;


function TControllerFaturamentoMargemGeneric.MargemVenda: IControllerFaturamentoMargemVenda;
begin
  Result := TControllerFaturamentoMargemVenda.New();
end;

class function TControllerFaturamentoMargemGeneric.New: IControllerFaturamentoMargemGeneric;
begin
  Result := Self.Create;
end;

end.
