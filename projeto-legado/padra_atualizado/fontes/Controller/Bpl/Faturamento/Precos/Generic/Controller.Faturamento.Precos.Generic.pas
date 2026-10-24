unit Controller.Faturamento.Precos.Generic;

interface

uses Controller.Faturamento.Interfaces.Precos.Generic,
  Controller.Faturamento.Interfaces.Precos.PrecoCusto,
  Controller.Faturamento.Precos.PrecoCusto;

type
  TControllerFaturamentoPrecosGeneric = class sealed(TInterfacedObject, IControllerFaturamentoPrecosGeneric)
  private    
  public
    function PrecoCusto: IControllerFaturamentoPrecoCusto;    

    destructor Destroy; override;

    class function New(): IControllerFaturamentoPrecosGeneric;
  end;

implementation

{ TControllerFaturamentoPrecosGeneric }

destructor TControllerFaturamentoPrecosGeneric.Destroy;
begin
  
  inherited;
end;


function TControllerFaturamentoPrecosGeneric.PrecoCusto: IControllerFaturamentoPrecoCusto;
begin
  Result := TControllerFaturamentoPrecoCusto.New();
end;

class function TControllerFaturamentoPrecosGeneric.New: IControllerFaturamentoPrecosGeneric;
begin
  Result := Self.Create;
end;

end.
