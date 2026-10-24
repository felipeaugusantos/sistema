unit untFactoryFornecedorMemory;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  TFactoryFornecedorMemory = class
  private
    class var FModel: IResultadoFaturamentoImpostosModelClienteFornecedor;
  public
    class function Create: IResultadoFaturamentoImpostosModelClienteFornecedor;
    class procedure SetModel(const AModel: IResultadoFaturamentoImpostosModelClienteFornecedor);
  end;

implementation

{ TFactoryFornecedorMemory }

class function TFactoryFornecedorMemory.Create: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := Nil;
  If (Assigned(Self.FModel)) Then
    Result := Self.FModel;
end;

class procedure TFactoryFornecedorMemory.SetModel(
  const AModel: IResultadoFaturamentoImpostosModelClienteFornecedor);
begin
  Self.FModel := AModel;
end;

initialization
  TFactoryFornecedorMemory.SetModel(Nil);

end.
