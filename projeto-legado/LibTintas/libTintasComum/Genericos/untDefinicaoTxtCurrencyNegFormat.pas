unit untDefinicaoTxtCurrencyNegFormat;

interface

type
  TDefinicaoTxtCurrencyNegFormat = class(TInterfacedObject)
  public
    type Tipo = (dtcnfDefault, dtcnfPS1P, dtcnfNS1, dtcnfSN1, dtcnfS1N, dtcnfP1SP, dtcnfN1S, dtcnf1NS,
      dtcnf1SN, dtcnfN1_S, dtcnfNS_1, dtcnf1_SN, dtcnfS_1N, dtcnfS_N1, dtcnf1N_S, dtcnfPS_1P, dtcnfP1_SP);
    class function GetAsInteger(const dtcnfTipo: TDefinicaoTxtCurrencyNegFormat.Tipo): Integer;
  end;


implementation

{ TDefinicaoTxtCurrencyNegFormat }

class function TDefinicaoTxtCurrencyNegFormat.GetAsInteger(const dtcnfTipo: TDefinicaoTxtCurrencyNegFormat.Tipo): Integer;
begin
  case dtcnfTipo of
    dtcnfDefault: Result := -1;
    dtcnfPS1P: Result := 0;
    dtcnfNS1: Result := 1;
    dtcnfSN1: Result := 2;
    dtcnfS1N: Result := 3;
    dtcnfP1SP: Result := 4;
    dtcnfN1S: Result := 5;
    dtcnf1NS: Result := 6;
    dtcnf1SN: Result := 7;
    dtcnfN1_S: Result := 8;
    dtcnfNS_1: Result := 9;
    dtcnf1_SN: Result := 10;
    dtcnfS_1N: Result := 11;
    dtcnfS_N1: Result := 12;
    dtcnf1N_S: Result := 13;
    dtcnfPS_1P: Result := 14;
    dtcnfP1_SP: Result := 15;
  else
    Result := -1;
  end;
end;

end.
