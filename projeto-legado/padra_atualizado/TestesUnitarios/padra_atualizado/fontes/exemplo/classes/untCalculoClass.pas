unit untCalculoClass;

interface

type
  TCalculo = class
    public
      function Soma(const pnValor1, pnValor2: double): double;
      function Divisao(const pnValor1, pnValor2: double): double;
  end;

implementation

{ TCalculo }

function TCalculo.Divisao(const pnValor1, pnValor2: double): double;
begin
  if (pnValor2 = 0) then
  begin
    result := 0;
    Exit;
  end;

  result := pnValor1 / pnValor2;
end;

function TCalculo.Soma(const pnValor1, pnValor2: double): double;
begin
  result := pnValor1 + pnValor2;
end;

end.
