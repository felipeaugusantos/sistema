unit untDefinicaoTxtFormato;

interface

type
  TDefinicaoTxtFormato = class(TInterfacedObject)
  public
    type Tipo = (dtfTab, dtfCsv, dtfCustom, dtfFixed);
    class function GetAsString(const dtfTipo: TDefinicaoTxtFormato.Tipo): string;
  end;


implementation

{ TDefinicaoTxtFormato }

class function TDefinicaoTxtFormato.GetAsString(const dtfTipo: TDefinicaoTxtFormato.Tipo): string;
begin
  case dtfTipo of
    dtfTab: Result := 'TabDelimited';
    dtfCsv: Result := 'CSVDelimited';
    dtfCustom: Result := 'Delimited(%c)';
    dtfFixed: Result := 'FixedLength'; 
  end;
end;

end.
