unit untFactoryEmpresaMemory;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  TFactoryEmpresaMemory = class
  private
    class var FModel: IResultadoFaturamentoImpostosModelEmpresa;
  public
    class function Create: IResultadoFaturamentoImpostosModelEmpresa;
    class procedure SetModel(const AModel: IResultadoFaturamentoImpostosModelEmpresa);
  End;

implementation

{ TFactoryEmpresaMemory }

class function TFactoryEmpresaMemory.Create: IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := Nil;
  If (Assigned(Self.FModel)) Then
  Begin
    Result := Self.FModel;
    Self.SetModel(Nil);
  End;
end;

class procedure TFactoryEmpresaMemory.SetModel(
  const AModel: IResultadoFaturamentoImpostosModelEmpresa);
begin
  Self.FModel := AModel;
end;

initialization
  TFactoryEmpresaMemory.SetModel(Nil);

end.
