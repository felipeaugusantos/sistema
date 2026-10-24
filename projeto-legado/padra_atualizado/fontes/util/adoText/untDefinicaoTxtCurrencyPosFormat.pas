unit untDefinicaoTxtCurrencyPosFormat;

interface

type
  TDefinicaoTxtCurrencyPosFormat = class(TInterfacedObject)
  public
    type Tipo = (dtcpfDefault, dtcpfS1, dtcpf1S, dtcpfS_1, dtcpf1_S);
    class function GetAsInteger(const dtcnfTipo: TDefinicaoTxtCurrencyPosFormat.Tipo): Integer;
  end;


implementation

{ TDefinicaoTxtCurrencyPosFormat }

class function TDefinicaoTxtCurrencyPosFormat.GetAsInteger(const dtcnfTipo: TDefinicaoTxtCurrencyPosFormat.Tipo): Integer;
begin
  case dtcnfTipo of
    dtcpfDefault: Result := -1;
    dtcpfS1: Result := 0;
    dtcpf1S: Result := 1;
    dtcpfS_1: Result := 2;
    dtcpf1_S: Result := 3;
  else
    Result := -1;
  end;
end;

end.

