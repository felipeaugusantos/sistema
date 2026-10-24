unit PinPad.Classes.PinPadFactory;

interface

uses PinPad.Interfaces ;

type
  TPinPadFactory = Class(TInterfacedObject, IPinPadCitelFactory)
  public
    function fAcessa(const AstrPorta: String; const AFabricante: TPinPadCitelFabricantes; const AstrPath: String): IPinPadCitel ;
    class function New: IPinPadCitelFactory;
  end ;

implementation

uses PinPad.Classes.Gertec, PinPad.Classes.Scope ;

{ TPinPadFactory }

function TPinPadFactory.fAcessa(const AstrPorta: String; const AFabricante: TPinPadCitelFabricantes; const AstrPath: String): IPinPadCitel;
begin
  Result := Nil ;
  case AFabricante of
    ppcfGertec : Result := TPinPadCitelGertec.Create(AstrPorta, AstrPath);
    ppcfScope  : Result := TPinPadCitelScope.Create(AstrPorta, AstrPath);
  end ;
end;

class function TPinPadFactory.New: IPinPadCitelFactory;
begin
  Result := Self.Create;
end;

end.
