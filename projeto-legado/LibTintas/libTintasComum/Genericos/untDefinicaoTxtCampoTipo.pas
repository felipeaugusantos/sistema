unit untDefinicaoTxtCampoTipo;

interface

type
  TDefinicaoTxtCampoTipo = class(TInterfacedObject)
  public
    type Tipo = (dtctBit, dtctByte, dtctShort, dtctLong, dtctCurrency,
      dtctSingle, dtctDouble, dtctDateTime, dtctText, dtctMemo,
      dtctFloat, dtctInteger, dtctLongChar, dtctDate);
    class function GetAsString(const dtctTipo: TDefinicaoTxtCampoTipo.Tipo): string;
  end;

implementation

{ TDefinicaoTxtCampoTipo }

class function TDefinicaoTxtCampoTipo.GetAsString(const dtctTipo: TDefinicaoTxtCampoTipo.Tipo): string;
begin
  case dtctTipo of
    dtctBit: Result := 'Bit';
    dtctByte: Result := 'Byte';
    dtctShort: Result := 'Short';
    dtctLong: Result := 'Long';
    dtctCurrency: Result := 'Currency';
    dtctSingle: Result := 'Single';
    dtctDouble: Result := 'Double';
    dtctDateTime: Result := 'DateTime';
    dtctText: Result := 'Text';
    dtctMemo: Result := 'Memo';
    dtctFloat: Result := 'Float';
    dtctInteger: Result := 'Integer';
    dtctLongChar: Result := 'LongChar';
    dtctDate: Result := 'Date';
  end;
end;

end.
