unit untGarantiaPropriaEmpresaTypes;

interface

type
  {SCOPEDENUMS ON}
  TFinalidade = (NaoDefinido, Aproveitamento, Perda, ProdutoAcabado);
  {SCOPEDENUMS OFF}
  TFinalidadeHelper = record Helper for TFinalidade
    procedure pSetAsString(Value: String);
    function fGetAsString: String;
    function fGetText: String;
  end;

Type
  {$SCOPEDENUMS ON}
  TOrigemPedido = (NaoDefinido, RecebimentoCliente, EnvioCliente, AvaliacaoGarantia);
  {$SCOPEDENUMS OFF}
  TOrigemPedidoHelper = record helper for TOrigemPedido
    function GetAsString: String;
    procedure SetAsString(Value: String);
  end;


implementation
uses
  System.SysUtils;

{ TFinalidadeHelper }

function TFinalidadeHelper.fGetAsString: String;
begin
  Result := IntToStr(Ord(Self));
end;

function TFinalidadeHelper.fGetText: String;
begin
  case Self of
    Aproveitamento: Result := 'Aproveitamento';
    Perda: Result := 'Perda' ;
    ProdutoAcabado: Result := 'Aprov. Prod Acabado';
    else
      Result := EmptyStr;
  end;
end;

procedure TFinalidadeHelper.pSetAsString(Value: String);
Var
  intAux: Integer;
begin
  intAux := strToInTDef(Value,0);
  if TFinalidade(Ord(intAux)) = TFinalidade.Aproveitamento then
    Self := TFinalidade.Aproveitamento
  else if  TFinalidade(Ord(intAux)) = TFinalidade.Perda then
    Self := TFinalidade.Perda
  else if  TFinalidade(Ord(intAux)) = TFinalidade.ProdutoAcabado then
    Self := TFinalidade.ProdutoAcabado
  else
    Self := TFinalidade.NaoDefinido;
end;

{ TOrigemPedidoHelper }

function TOrigemPedidoHelper.GetAsString: String;
begin
  Result := IntToStr(ord(Self));
end;

procedure TOrigemPedidoHelper.SetAsString(Value: String);

begin
  if (Value = '1') then
    Self := TOrigemPedido.RecebimentoCliente
  else if Value = '2' then
    Self := TOrigemPedido.EnvioCliente
  else if Value = '3' then
    Self := TOrigemPedido.AvaliacaoGarantia
  else
    Self := TOrigemPedido.NaoDefinido;
end;

end.
