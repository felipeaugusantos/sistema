unit ACBrDFeException;

interface

uses
  Classes, SysUtils ;


type
  { EACBrDFeException }

  EACBrDFeException = class(Exception)
  public
    constructor CreateDef(const Msg: String); overload;
  end;

  EACBrDFeExceptionNoPrivateKey = class(EACBrDFeException);

implementation

uses
  ACBrUtil;

{ EACBrDFeException }

constructor EACBrDFeException.CreateDef(const Msg: String);
begin
  inherited Create(Msg);
end;


end.

