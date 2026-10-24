unit untILibContaBancariaFactory;

interface

uses
  untILibContaBancariaWrapper;

type
  TLibContaBancariaFactory = class(TInterfacedObject)
  private
    class var autcomLibContaBancaria: ILibContaBancaria;
  public
    class procedure Registrar(AautcomLibContaBancaria: ILibContaBancaria);
    class function Get: ILibContaBancaria;
  end;

implementation

{ TLibContaBancariaFactory }

class function TLibContaBancariaFactory.Get: ILibContaBancaria;
begin
  Result := Self.autcomLibContaBancaria;
end;

class procedure TLibContaBancariaFactory.Registrar(AautcomLibContaBancaria: ILibContaBancaria);
begin
  Self.autcomLibContaBancaria := AautcomLibContaBancaria;
end;

initialization
  TLibContaBancariaFactory.autcomLibContaBancaria := nil;

finalization
  TLibContaBancariaFactory.autcomLibContaBancaria := nil;

end.
