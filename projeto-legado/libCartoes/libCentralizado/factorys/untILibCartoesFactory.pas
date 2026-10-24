unit untILibCartoesFactory;

interface

uses
  untILibCartoesWrapper;

type
  TLibCartoesFactory = class(TInterfacedObject)
  private
    class var autcomLibCartoes: ILibCartoes;
  public
    class procedure Registrar(AautcomLibCartoes: ILibCartoes);
    class function Get: ILibCartoes;
  end;

implementation

{ TLibCartoesFactory }

class function TLibCartoesFactory.Get: ILibCartoes;
begin
  Result := Self.autcomLibCartoes;
end;

class procedure TLibCartoesFactory.Registrar(AautcomLibCartoes: ILibCartoes);
begin
  If Not Assigned(Self.autcomLibCartoes) Then
    Self.autcomLibCartoes := AautcomLibCartoes;
end;

initialization
  TLibCartoesFactory.autcomLibCartoes := nil;

finalization
  TLibCartoesFactory.autcomLibCartoes := nil;

end.
