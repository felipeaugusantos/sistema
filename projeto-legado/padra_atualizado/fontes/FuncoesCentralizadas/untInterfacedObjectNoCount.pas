unit untInterfacedObjectNoCount;

interface

uses
  System.SysUtils;

type
  TInterfacedObjectNoCount = class(TObject, IInterface)
  protected
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read FRefCount;
  end;

implementation

{ TInterfacedObjectNoCount }

procedure TInterfacedObjectNoCount.AfterConstruction;
begin
  System.AtomicExchange(FRefCount, 1);
end;

procedure TInterfacedObjectNoCount.BeforeDestruction;
begin
  inherited;

end;

class function TInterfacedObjectNoCount.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TInterfacedObjectNoCount(Result).FRefCount := 1;
end;

function TInterfacedObjectNoCount.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TInterfacedObjectNoCount._AddRef: Integer;
begin
  Result := 1;
end;

function TInterfacedObjectNoCount._Release: Integer;
begin
  Result := 1;
end;

end.
