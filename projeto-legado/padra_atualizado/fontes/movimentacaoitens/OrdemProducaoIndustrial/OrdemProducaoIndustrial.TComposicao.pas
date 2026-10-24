unit OrdemProducaoIndustrial.TComposicao;

interface

uses
  Classes,
  SysUtils,
  Math,
  System.Generics.Collections,
  OrdemProducaoIndustrial.TEmbalagem;

Type
  TComposicao = class
    private
      FCodigo     : String;
      FDescricao  : String;
      FEmbalagens : TObjectList<TEmbalagem>;
    public
      property strCodigo: String                      read FCodigo     write FCodigo;
      property strDescricao: String                   read FDescricao  write FDescricao;
      property lstEmbalagens: TObjectList<TEmbalagem> read FEmbalagens write FEmbalagens;

      constructor Create;
      destructor Destroy; override;

      function fRetornaCustoTotal(fltQuantidadeEnvasada: double): double;
      function fRetornaCusto(fltQuantidadeEnvasada: double): double;
      function fRetornaPeso: double;
      function fRetornaPrcMedio(fltQuantidadeEnvasada: double): double;
      function fRetornaPrcMedioTotal(fltQuantidadeEnvasada: double): double;
  End;

implementation

uses
  OrdemProducaoIndustrial.Funcoes;

{ TComposicao }

constructor TComposicao.Create;
begin
  FCodigo     := '';
  FDescricao  := '';
  FEmbalagens := TObjectList<TEmbalagem>.Create;
end;

destructor TComposicao.Destroy;
begin
  FreeAndNil(FEmbalagens);
end;

function TComposicao.fRetornaCustoTotal(fltQuantidadeEnvasada : double): double;
var
  objEmbalagem : TEmbalagem;
begin
  result := 0;

  for objEmbalagem in FEmbalagens do
    Result := Result + objEmbalagem.fRetornaCusto(fltQuantidadeEnvasada);

  Result := fRetornaValorArredondado(Result);
end;

function TComposicao.fRetornaPeso: double;
var
  objEmbalagem : TEmbalagem;
begin
  result := 0;

  for objEmbalagem in FEmbalagens do
    Result := Result + objEmbalagem.fRetornaPeso;

  Result := fRetornaValorArredondado(Result);
end;

function TComposicao.fRetornaCusto(fltQuantidadeEnvasada : double): double;
begin
  Result := 0;

  If fltQuantidadeEnvasada <> 0 then
  begin
    Result := fRetornaCustoTotal(fltQuantidadeEnvasada)/fltQuantidadeEnvasada;
    Result := fRetornaValorArredondado(Result);
  end;

end;

function TComposicao.fRetornaPrcMedio(fltQuantidadeEnvasada : double): double;
begin
  Result := 0;

  If fltQuantidadeEnvasada <> 0 then
  begin
    Result := fRetornaPrcMedioTotal(fltQuantidadeEnvasada)/fltQuantidadeEnvasada;
    Result := fRetornaValorArredondado(Result);
  end;

end;

function TComposicao.fRetornaPrcMedioTotal(fltQuantidadeEnvasada : double): double;
var
  objEmbalagem : TEmbalagem;
begin
  result := 0;

  for objEmbalagem in FEmbalagens do
    Result := Result + objEmbalagem.fRetornaPrcMedio(fltQuantidadeEnvasada);

  Result := fRetornaValorArredondado(Result);
end;

end.

