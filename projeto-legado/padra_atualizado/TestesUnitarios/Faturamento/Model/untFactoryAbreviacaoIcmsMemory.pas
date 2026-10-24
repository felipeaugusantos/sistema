unit untFactoryAbreviacaoIcmsMemory;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  TFactoryAbreviacaoIcmsMemory = class
  private
    class var FModel: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
  public
    class function Create: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
    class procedure SetModel(const AModel: IResultadoFaturamentoImpostosModelAbreviacaoIcms);
  end;

implementation

{ TFactoryAbreviacaoIcmsMemory }

class function TFactoryAbreviacaoIcmsMemory.Create: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Nil;
  If (Assigned(Self.FModel)) Then
    Result := Self.FModel;
end;

class procedure TFactoryAbreviacaoIcmsMemory.SetModel(
  const AModel: IResultadoFaturamentoImpostosModelAbreviacaoIcms);
begin
  Self.FModel := AModel;
end;

initialization
  TFactoryAbreviacaoIcmsMemory.SetModel(Nil);

end.
