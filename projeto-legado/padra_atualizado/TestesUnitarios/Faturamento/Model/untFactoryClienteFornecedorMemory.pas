unit untFactoryClienteFornecedorMemory;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  TFactoryClienteFornecedorMemory = class
  private
    class var FModel: IResultadoFaturamentoImpostosModelClienteFornecedor;
  public
    class function Create: IResultadoFaturamentoImpostosModelClienteFornecedor;
    class procedure SetModel(const AModel: IResultadoFaturamentoImpostosModelClienteFornecedor);
  end;

implementation

{ TClienteFornecedorMemory }

class function TFactoryClienteFornecedorMemory.Create: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Nil;
  If (Assigned(Self.FModel)) Then
  Begin
    Result := Self.FModel;
    Self.SetModel(Nil);
  End;
end;

class procedure TFactoryClienteFornecedorMemory.SetModel(
  const AModel: IResultadoFaturamentoImpostosModelClienteFornecedor);
begin
  Self.FModel := AModel;
end;

initialization
  TFactoryClienteFornecedorMemory.SetModel(Nil);

end.
