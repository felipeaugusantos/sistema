unit untValidaCondicaoPagamento;

interface

uses
  SysUtils;

Type
  TValidaCondicaoPagamento = class
    public
      class function fValidaConPagMaiorPrazo(strConPagAtual, strConPagNova: String):Boolean; static;
  End;


implementation

{ TValidaCondicaoPagamento }

class function TValidaCondicaoPagamento.fValidaConPagMaiorPrazo(strConPagAtual, strConPagNova: String): Boolean;
Var
  intParcAtual,
  intParcNova:Integer;
begin
  Result := False;

  If (strConPagAtual = strConPagNova) Then
    Exit;

  intParcAtual := StrToIntDef(Copy(strConPagAtual, Length(strConPagAtual)-2, 3), 0);
  intParcNova := StrToIntDef(Copy(strConPagNova, Length(strConPagNova)-2, 3), 0);

  If (intParcNova = intParcAtual) Then
  Begin
    intParcAtual := StrToIntDef(Copy(strConPagAtual, 1, 2), 0);
    intParcNova := StrToIntDef(Copy(strConPagNova, 1, 2), 0);
  End;

  Result := (intParcNova > intParcAtual);
end;

end.
