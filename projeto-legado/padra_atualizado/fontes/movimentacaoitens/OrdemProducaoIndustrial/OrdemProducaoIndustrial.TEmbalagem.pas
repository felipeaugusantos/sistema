unit OrdemProducaoIndustrial.TEmbalagem;

interface

uses
  Classes,
  Math,
  SysUtils,
  OrdemProducaoIndustrial.Tipos;

Type
  TEmbalagem = class
    private
      FCodigo     : String;
      FDescricao  : String;
      FCusto      : double;
      FPeso       : double;
      FQuantidade : double;
      FFracionado : boolean;
      FTipoArredondamento: TTipoArredondamentoComposicao;
      FPrcMedio   : double;
    public
      property strCodigo: String                                     read FCodigo             write FCodigo;
      property strDescricao: String                                  read FDescricao          write FDescricao;
      property fltCusto: double                                      read FCusto              write FCusto;
      property fltPeso: double                                       read FPeso               write FPeso;
      property fltQuantidade: double                                 read FQuantidade         write FQuantidade;
      property enuTipoArredondamento : TTipoArredondamentoComposicao read FTipoArredondamento write FTipoArredondamento;
      property fltPrcMedio: double                                   read FPrcMedio           write FPrcMedio;

      constructor Create(enuTipoArredondamento : TTipoArredondamentoComposicao; blnFracionado : boolean);

      function fRetornaCusto(fltQuantidadeEnvasada: double) : double;
      function fRetornaPeso: double;
      function fRetornaQuantidadeUtilizada(fltQuantidadeEnvasada: double): double;
      function fRetornaPrcMedio(fltQuantidadeEnvasada: double): double;
  End;

implementation

uses
  OrdemProducaoIndustrial.Funcoes;

{ TEmbalagem }

constructor TEmbalagem.Create(enuTipoArredondamento : TTipoArredondamentoComposicao; blnFracionado : boolean);
begin
  FCodigo     := '';
  FDescricao  := '';
  FCusto      := 0;
  FPeso       := 0;
  FQuantidade := 0;
  FFracionado := blnFracionado;
  FTipoArredondamento := enuTipoArredondamento;

end;


function TEmbalagem.fRetornaCusto(fltQuantidadeEnvasada: double): double;
begin
  Result := (fRetornaQuantidadeUtilizada(fltQuantidadeEnvasada) * FCusto);
  Result := fRetornaValorArredondado(Result);
end;

function TEmbalagem.fRetornaQuantidadeUtilizada(fltQuantidadeEnvasada: double) : double;
begin
  Result := FQuantidade * fltQuantidadeEnvasada;

  if not FFracionado then
  begin
    if enuTipoArredondamento = taAcima then
      Result := Ceil(Result)
    else if enuTipoArredondamento = taAbaixo then
      Result := Floor(Result);
  end;

  Result := fRetornaValorArredondado(Result);
end;

function TEmbalagem.fRetornaPeso: double;
begin
  Result := FQuantidade * FPeso;
  Result := fRetornaValorArredondado(Result);
end;

function TEmbalagem.fRetornaPrcMedio(fltQuantidadeEnvasada: double): double;
begin
  Result := (fRetornaQuantidadeUtilizada(fltQuantidadeEnvasada) * FPrcMedio);
  Result := fRetornaValorArredondado(Result);
end;

end.

