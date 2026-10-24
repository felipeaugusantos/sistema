unit untFactoryProdutoMemory;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  TFactoryProdutoMemory = class
  private
    class var FModel: IResultadoFaturamentoImpostosModelProduto;
  public
    class function Create(const ACodigoProduto: String): IResultadoFaturamentoImpostosModelProduto;
    class procedure SetModel(const AModel: IResultadoFaturamentoImpostosModelProduto);
  end;

implementation

uses untConsultaModelProdutoMemory;

{ TFactoryProdutoMemory }

class function TFactoryProdutoMemory.Create(
  const ACodigoProduto: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Nil;
  If (Assigned(Self.FModel)) Then
  Begin
    Result := Self.FModel;
    Self.SetModel(Nil);
  End;
end;

class procedure TFactoryProdutoMemory.SetModel(
  const AModel: IResultadoFaturamentoImpostosModelProduto);
begin
  Self.FModel := AModel;
end;

end.
