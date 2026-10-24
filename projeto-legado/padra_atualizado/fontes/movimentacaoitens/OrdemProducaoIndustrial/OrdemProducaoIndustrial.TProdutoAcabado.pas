unit OrdemProducaoIndustrial.TProdutoAcabado;

interface

uses
  Classes,
  SysUtils,
  OrdemProducaoIndustrial.Tipos,
  OrdemProducaoIndustrial.TComposicao;

Type
  TProdutoAcabado = class
    private
      FCodigo              : String;
      FDescricao           : String;
      FMedidaUnidade       : TTipoMedidaUnidade;
      FPesoLitro           : double;
      FPesoReal            : double;
      FQuantidadeProduzida : double;
      FQuantidadeEnvasada  : double;
      FComposicao          : TComposicao;
      FNumeroLote: String;

    public

      property strCodigo: String                    read FCodigo              write FCodigo;
      property strDescricao: String                 read FDescricao           write FDescricao;
      property enuMedidaUnidade: TTipoMedidaUnidade read FMedidaUnidade       write FMedidaUnidade;
      property fltPesoLitro: double                 read FPesoLitro           write FPesoLitro;
      property fltPesoReal: double                  read FPesoReal            write FPesoReal;
      property fltQuantidadeProduzida: double       read FQuantidadeProduzida write FQuantidadeProduzida;
      property fltQuantidadeEnvasada: double        read FQuantidadeEnvasada  write FQuantidadeEnvasada;
      property objComposicao: TComposicao           read FComposicao          write FComposicao;
      property strNumeroLote: String                read FNumeroLote          write FNumeroLote;

      constructor Create;
      destructor Destroy; override;

      function fRetornaPesoUnitario: double;
      function fRetornaVolumeUnitario: double;
      function fRetornaPesoEnvasado: double;
      function fRetornaVolumeEnvasado: double;
      function fRetornaPesoProduzido: double;
      function fRetornaVolumeProduzido: double;
      function fRetornaCustoUnitario(fltCustoKilo: double): double;
      function fRetornaCustoUnitarioFormula(fltCustoKilo: double): double;
      function fRetornaCustoEnvasado(fltCustoKilo: double): double;
      function fRetornaCustoEnvasadoFormula(fltCustoKilo: double): double;
      function fRetornaCustoRelativoProducao(fltCustoTotalProducao, fltPesoTotalProducao: double): double;
      function fRetornaCustoComposicaoEnvasado: double;
      function fRetornaCustoUnitarioComposicao: double;
      function fRetornaPrcMedioUnitario(fltPrcMedioKilo: double): double;
      function fRetornaPrcMedioUnitarioComposicao: double;
      function fRetornaPrcMedioUnitarioFormula(fltPrcMedioKilo: double): double;
  End;

implementation

uses
  OrdemProducaoIndustrial.Funcoes;


{ TProdutoAcabado }

constructor TProdutoAcabado.Create;
begin
  FCodigo        := '';
  FDescricao     := '';
  FMedidaUnidade := tmNull;
  FPesoLitro     := 0;
  FPesoReal      := 0;
  FNumeroLote    := '';
  FQuantidadeProduzida := 0;
  FQuantidadeEnvasada := 0;
  FComposicao := TComposicao.Create;
end;

destructor TProdutoAcabado.Destroy;
begin
  FreeAndNil(FComposicao);
end;

function TProdutoAcabado.fRetornaPesoUnitario : double;
begin

  case FMedidaUnidade of
    tmLitro : Result := fConverteLitroParaKilo(FPesoReal, FPesoLitro);
    Else      Result := FPesoLitro;
  end;

end;

function TProdutoAcabado.fRetornaVolumeUnitario : double;
begin

  case FMedidaUnidade of
    tmLitro : Result := FPesoLitro;
    Else      Result := fConverteKiloParaLitro(FPesoReal, FPesoLitro);
  end;

end;

function TProdutoAcabado.fRetornaPesoEnvasado: double;
begin
  Result := fltQuantidadeEnvasada * fRetornaPesoUnitario;
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaVolumeEnvasado: double;
begin
  Result := fltQuantidadeEnvasada * fRetornaVolumeUnitario;
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaPesoProduzido: double;
begin
  Result := fltQuantidadeProduzida * fRetornaPesoUnitario;
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaVolumeProduzido: double;
begin
  Result := fltQuantidadeProduzida * fRetornaVolumeUnitario;
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaCustoEnvasado(fltCustoKilo: double): double;
begin
  Result := fRetornaCustoUnitario(fltCustoKilo) * fltQuantidadeEnvasada;
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaCustoEnvasadoFormula(fltCustoKilo: double): double;
begin
  Result := fRetornaCustoUnitarioFormula(fltCustoKilo) * fltQuantidadeEnvasada;
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaCustoRelativoProducao(fltCustoTotalProducao,
  fltPesoTotalProducao: double): double;
begin
  Result := 0;

  if FQuantidadeProduzida > 0 then
    Result := fltCustoTotalProducao * fRetornaPesoProduzido / fltPesoTotalProducao;

  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaCustoUnitario(fltCustoKilo : double) : double;
begin
  Result := fRetornaCustoUnitarioFormula(fltCustoKilo) + fRetornaCustoUnitarioComposicao;
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaCustoUnitarioFormula(
  fltCustoKilo: double): double;
begin
  Result := (fltCustoKilo * fRetornaPesoUnitario);
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaCustoUnitarioComposicao : double;
begin
  Result := FComposicao.fRetornaCusto(FQuantidadeEnvasada);
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaCustoComposicaoEnvasado : double;
begin
  Result := FComposicao.fRetornaCustoTotal(FQuantidadeEnvasada);
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaPrcMedioUnitario(fltPrcMedioKilo : double) : double;
begin
  Result := fRetornaPrcMedioUnitarioFormula(fltPrcMedioKilo) + fRetornaPrcMedioUnitarioComposicao;
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaPrcMedioUnitarioComposicao : double;
begin
  Result := FComposicao.fRetornaPrcMedio(FQuantidadeEnvasada);
  Result := fRetornaValorArredondado(Result);
end;

function TProdutoAcabado.fRetornaPrcMedioUnitarioFormula(fltPrcMedioKilo: double): double;
begin
  Result := (fltPrcMedioKilo * fRetornaPesoUnitario);
  Result := fRetornaValorArredondado(Result);
end;


end.
