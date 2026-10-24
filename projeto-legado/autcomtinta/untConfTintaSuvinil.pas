unit untConfTintaSuvinil;

interface

uses
  untConfTinta;

Type
  TConfTintaSuvinil = class(TConfTinta)
  public
    constructor Create(); reintroduce;
  End;

implementation

{ TConfTintaSuvinil }

constructor TConfTintaSuvinil.Create;
begin
  Inherited Create('SUV');
end;

end.
