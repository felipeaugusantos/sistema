{*****************************************************************************************}
{* Factory resposável pela entrega da de um objeto IAutcomTintaWrapper para toda a tinta *}
{**************************************************************************************PH*}
unit untAutcomTintaFactory;

interface

uses
  untIAutcomTintaWrapper;

type
  TAutcomTintaFactory = class(TInterfacedObject)
  private
    class var autcomTinta: IAutcomTintaWrapper;
  public
    class procedure Registrar(autcomTinta: IAutcomTintaWrapper);
    class function Get(): IAutcomTintaWrapper;
  end;

implementation

{ TAutcomTintaFactory }

class function TAutcomTintaFactory.Get: IAutcomTintaWrapper;
begin
  Result := Self.autcomTinta;
end;

class procedure TAutcomTintaFactory.Registrar(autcomTinta: IAutcomTintaWrapper);
begin
  Self.autcomTinta := autcomTinta;
end;

initialization
  TAutcomTintaFactory.autcomTinta := nil;

finalization
  TAutcomTintaFactory.autcomTinta := nil;

end.
