unit untMapperProcessValuePedidoVenda;

interface

uses untMapperDataSet;

type
  TMapperProcessValuePedidoVenda = class
    class function GetMapperProcessValue(const intDecUni: Integer): TMapperProcessValue;
  end;

implementation

uses untFuncoesSimples;

{ TMapperProcessValuePedidoVenda }

class function TMapperProcessValuePedidoVenda.GetMapperProcessValue(const intDecUni: Integer): TMapperProcessValue;
begin
  Result := TMapperProcessValue.Create;
  Result.Add('ITE_UNIEMB', (function (Value: Variant): Variant
                            begin
                              Result := fFormataFloat(Value, intDecUni);
                            end));
end;

end.
