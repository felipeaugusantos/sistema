unit OrdemProducaoIndustrial.Tipos;

interface

uses
  StrUtils,
  OrdemProducaoIndustrial.Funcoes;

  Type
    TTipoMedidaUnidade = (tmNull, tmKilo, tmLitro);
    TTipoArredondamentoComposicao = (taNaoArredonda, taAcima, taAbaixo);

    //conversões
    function fStrToTipoMedidaUnidade(strTipoMedida : String) : TTipoMedidaUnidade;
    function fTipoMedidaUnidadeToStr(enuTipoMedida : TTipoMedidaUnidade) : String;

    function fStrToTipoArredondamentoComposicao(strTipoArredondamento : String) : TTipoArredondamentoComposicao;
    function fTipoArredondamentoComposicaoToStr(enuTipoArredondamento : TTipoArredondamentoComposicao) : String;
    function fRetornaPesoUnitarioProdutoAcabado(enuTipoMedida : TTipoMedidaUnidade; fltPesoReal, fltPesoLitro : real) : real;

implementation


function fStrToTipoMedidaUnidade(strTipoMedida : String) : TTipoMedidaUnidade;
begin
  case AnsiIndexStr(strTipoMedida, ['K', 'L']) of
    0:   Result := tmKilo;
    1:   Result := tmLitro;
    else Result := tmNull;
  end;
end;

function fTipoMedidaUnidadeToStr(enuTipoMedida : TTipoMedidaUnidade) : String;
begin
  case enuTipoMedida of
    tmKilo : Result := 'K';
    tmLitro: Result := 'L';
    else     Result := '';
  end;
end;

function fStrToTipoArredondamentoComposicao(strTipoArredondamento : String) : TTipoArredondamentoComposicao;
begin
  case AnsiIndexStr(strTipoArredondamento, ['?', '+', '-']) of
    1:   Result := taAcima;
    2:   Result := taAbaixo
    Else Result := taNaoArredonda;
  end;
end;

function fTipoArredondamentoComposicaoToStr(enuTipoArredondamento : TTipoArredondamentoComposicao) : String;
begin
  case enuTipoArredondamento of
    taNaoArredonda : Result := '?';
    taAcima        : Result := '+';
    taAbaixo       : Result := '-';
  end;
end;

function fRetornaPesoUnitarioProdutoAcabado(enuTipoMedida : TTipoMedidaUnidade; fltPesoReal, fltPesoLitro : real) : real;
begin
  case enuTipoMedida of
    tmKilo : Result := fltPesoLitro;
    tmLitro: Result := fConverteLitroParaKilo(fltPesoReal, fltPesoLitro);
    else      Result := 0;
  end;
end;


end.
