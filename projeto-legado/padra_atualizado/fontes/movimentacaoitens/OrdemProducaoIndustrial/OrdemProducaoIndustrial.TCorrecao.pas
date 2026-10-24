unit OrdemProducaoIndustrial.TCorrecao;

interface

uses
  Classes;

Type
  TCorrecao = class
    private
      FCodigo     : String;
      FDescricao  : String;
      FCusto      : double;
      FQuantidade : double;
      FPrcMedio   : double;
    public
      property strCodigo: String     read FCodigo     write FCodigo;
      property strDescricao: String  read FDescricao  write FDescricao;
      property fltCusto: double      read FCusto      write FCusto;
      property fltQuantidade: double read FQuantidade write FQuantidade;
      property fltPrcMedio: double   read FPrcMedio   write FPrcMedio;

      constructor Create;

      function fRetornaCustoTotal : double;
      function fRetornaPrcMedioTotal: double;
  End;

implementation

uses
  OrdemProducaoIndustrial.Funcoes;

{ TCorrecao }

constructor TCorrecao.Create;
begin
  FCodigo     := '';
  FDescricao  := '';
  FCusto      := 0;
  FQuantidade := 0;
  FPrcMedio   := 0;
end;

function TCorrecao.fRetornaCustoTotal : double;
begin
  Result := FQuantidade * FCusto;
  Result := fRetornaValorArredondado(Result);
end;

function TCorrecao.fRetornaPrcMedioTotal : double;
begin
  Result := FQuantidade * FPrcMedio;
  Result := fRetornaValorArredondado(Result);
end;

end.

