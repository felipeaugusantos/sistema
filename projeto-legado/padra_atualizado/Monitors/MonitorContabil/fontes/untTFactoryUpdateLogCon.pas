unit untTFactoryUpdateLogCon;

interface

uses untIContabilidade, System.Generics.Collections;

type
  TFactoryUpdateLogCon = Class(TInterfacedObject, IFactoryUpdateLogCon)
  public
    procedure Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
    class function New: IFactoryUpdateLogCon;
  end;

implementation

uses untTUpdateLogConER, untTUpdateLogConOK, untTUpdateLogConWN, untContabilidadeConstantes;

{ TFactoryUpdateLogCon }

procedure TFactoryUpdateLogCon.Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
begin
  if AParams[0].Status = STATUS_OK then
  begin
    TUpdateLogConOK.New.Execute(AParams, AFiltroExcecao);
  end
  else if AParams[0].Status = STATUS_ERRO then
  begin
    TUpdateLogConEr.New.Execute(AParams, AFiltroExcecao);
  end
  else if AParams[0].Status = STATUS_WARNING then
  begin
    TUpdateLogConWN.New.Execute(AParams, AFiltroExcecao);
  end;
end;

class function TFactoryUpdateLogCon.New: IFactoryUpdateLogCon;
begin
  Result := Self.Create;
end;

end.
