unit untInterfaceObjectWrapper;

interface

type
  TInterfaceObjectWrapper = class
  public
    referencia: IInterface;
    constructor Create(const referencia: IInterface);
  end;

implementation

{ TInterfaceObjectWrapper }

constructor TInterfaceObjectWrapper.Create(const referencia: IInterface);
begin
  inherited Create();
  Self.referencia := referencia;
end;

end.
