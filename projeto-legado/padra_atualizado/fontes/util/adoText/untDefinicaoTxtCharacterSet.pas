unit untDefinicaoTxtCharacterSet;

interface

type
  TDefinicaoTxtCharacterSet = class(TInterfacedObject)
  public
    type Tipo = (dtcsDefault, dtcsAnsi, dtcsOem, dtcsUnicode);
    class function GetAsString(const dtcnfTipo: TDefinicaoTxtCharacterSet.Tipo): string;  
  end;


implementation

{ TDefinicaoTxtCharacterSet }

class function TDefinicaoTxtCharacterSet.GetAsString(const dtcnfTipo: TDefinicaoTxtCharacterSet.Tipo): string;
begin
  case dtcnfTipo of
    dtcsDefault: Result := '';
    dtcsAnsi: Result := 'ANSI';
    dtcsOem: Result := 'OEM';
    dtcsUnicode: Result := 'UNICODE';
  end;
end;

end.
