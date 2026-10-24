unit untTValidacaoSaldoCat42Factory;

interface

uses System.Generics.Collections,
     untTDadosAberturaExportacaoCat42,
     untTValidacaoSaldoTotalCat42,
     untTEstoqueCat42,
     untTipo;

type
  TValidacaoSaldoCat42Factory = class
  public
    class function fRetValidacaoSaldo(listaSaldoEstoque: TObjectList<TEstoqueCat42>; abertura: TDadosAberturaExportacaoCat42; tipo: TTipoConferenciaCat): TValidacaoSaldoTotalCat42;
  end;

implementation

uses untTValidacaoSaldoTotalNegativoCat42,
     untTValidacaoSaldoTotalPositivoCat42;

{ TValidacaoSaldoCat42Factory }

class function TValidacaoSaldoCat42Factory.fRetValidacaoSaldo(listaSaldoEstoque: TObjectList<TEstoqueCat42>; abertura: TDadosAberturaExportacaoCat42; tipo: TTipoConferenciaCat): TValidacaoSaldoTotalCat42;
begin
  Result := nil;

  if tipo = tccSim then
    Result := TValidacaoSaldoTotalPositivoCat42.Create(listaSaldoEstoque, abertura)
  else if tipo = tccConf then
    Result := TValidacaoSaldoTotalNegativoCat42.Create(listaSaldoEstoque, abertura);
end;

end.
