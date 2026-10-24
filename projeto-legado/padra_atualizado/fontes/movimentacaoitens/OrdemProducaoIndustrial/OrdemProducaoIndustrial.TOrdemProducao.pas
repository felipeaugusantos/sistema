unit OrdemProducaoIndustrial.TOrdemProducao;

interface

uses
  Classes,
  SysUtils,
  DateUtils,
  Math,
  System.Generics.Collections,
  OrdemProducaoIndustrial.TFormula,
  OrdemProducaoIndustrial.TProdutoAcabado,
  OrdemProducaoIndustrial.TCorrecao;
Type
  TOrdemProducao = class
    private
      FAutoincrem       : String;
      FFormula          : TFormula;
      FProdutosAcabados : TObjectList<TProdutoAcabado>;
      FCorrecoes        : TObjectList<TCorrecao>;
      FDataBaixa        : TDateTime;
      FCodigoOperador   : string;
      FNomeOperador     : string;
      FNomeOpeBaixa     : string;
      FDataCadastro     : TDateTime;
      FCodigo           : string;
      FCodigoOpeBaixa   : string;

    public
      property objFormula: TFormula                              read FFormula          write FFormula;
      property lstProdutosAcabados: TObjectList<TProdutoAcabado> read FProdutosAcabados write FProdutosAcabados;
      property lstCorrecoes: TObjectList<TCorrecao>              read FCorrecoes        write FCorrecoes;
      property strAutoincrem : string                            read FAutoincrem       write FAutoincrem;
      property strCodigo : string                                read FCodigo           write FCodigo;
      property dtaDataCadastro : TDateTime                       read FDataCadastro     write FDataCadastro;
      property dtaDataBaixa : TDateTime                          read FDataBaixa        write FDataBaixa;
      property strCodigoOperador : string                        read FCodigoOperador   write FCodigoOperador;
      property strNomeOperador : string                          read FNomeOperador     write FNomeOperador;
      property strCodigoOpeBaixa : string                        read FCodigoOpeBaixa   write FCodigoOpeBaixa;
      property strNomeOpeBaixa : string                          read FNomeOpeBaixa     write FNomeOpeBaixa;

      constructor Create;
      destructor Destroy; override;

      function fRetornaPesoEnvasadoTotal: double;
      function fRetornaVolumeEnvasadoTotal: double;
      function fRetornaPesoProduzidoTotal: double;
      function fRetornaVolumeProduzidoTotal: double;
      function fRetornaCustoKilo: double;
      function fRetornaCustoLitro: double;
      function fRetornaCustoCorrecoesTotal: double;
      function fRetornaCustoTotalProducao: double;
      function fRetornaPrecoMedioKilo: double;
      function fRetornaPrcMedioCorrecoesTotal: double;

      procedure pSetaBaixaPerfeitaProdutosAcabados;

      procedure Clear;

  End;

implementation

uses
  OrdemProducaoIndustrial.Funcoes;

{ TOrdemProducao }
procedure TOrdemProducao.Clear;
begin
  FAutoincrem := '';
  FDataBaixa := 0;
  FCodigoOperador := '';
  FNomeOperador := '';
  FDataCadastro := 0;
  FCodigo := '';
  FCodigoOpeBaixa := '';
  FFormula.Clear;
  FProdutosAcabados.Clear;
  FCorrecoes.Clear;
end;

constructor TOrdemProducao.Create;
begin
  FFormula          := TFormula.Create;
  FProdutosAcabados := TObjectList<TProdutoAcabado>.Create;
  FCorrecoes        := TObjectList<TCorrecao>.Create;
  Clear;
end;

destructor TOrdemProducao.Destroy;
begin
  FreeAndNil(FFormula);
  FreeAndNil(FProdutosAcabados);
  FreeAndNil(FCorrecoes);

  inherited;
end;

function TOrdemProducao.fRetornaPesoEnvasadoTotal: double;
var
  objProdutoAcabado : TProdutoAcabado;
begin
  Result := 0;

  for objProdutoAcabado in FProdutosAcabados do
    Result := Result + objProdutoAcabado.fRetornaPesoEnvasado;

  Result := fRetornaValorArredondado(Result);
end;

function TOrdemProducao.fRetornaPesoProduzidoTotal: double;
var
  objProdutoAcabado : TProdutoAcabado;
begin
  Result := 0;

  for objProdutoAcabado in FProdutosAcabados do
    Result := Result + objProdutoAcabado.fRetornaPesoProduzido;

  Result := fRetornaValorArredondado(Result);
end;

function TOrdemProducao.fRetornaVolumeEnvasadoTotal: double;
var
  objProdutoAcabado : TProdutoAcabado;
begin
  Result := 0;

  for objProdutoAcabado in FProdutosAcabados do
    Result := Result + objProdutoAcabado.fRetornaVolumeEnvasado;

  Result := fRetornaValorArredondado(Result);
end;

function TOrdemProducao.fRetornaVolumeProduzidoTotal: double;
var
  objProdutoAcabado : TProdutoAcabado;
begin
  Result := 0;

  for objProdutoAcabado in FProdutosAcabados do
    Result := Result + objProdutoAcabado.fRetornaVolumeProduzido;

  Result := fRetornaValorArredondado(Result);
end;

procedure TOrdemProducao.pSetaBaixaPerfeitaProdutosAcabados;
var
  objProdutoAcabado : TProdutoAcabado;
begin
  for objProdutoAcabado in Self.lstProdutosAcabados do
  begin
    objProdutoAcabado.fltQuantidadeProduzida := 1;
    objProdutoAcabado.fltQuantidadeEnvasada  := 1;
  end;
end;

function TOrdemProducao.fRetornaCustoCorrecoesTotal: double;
var
  objCorrecao : TCorrecao;
begin
  Result := 0;

  for objCorrecao in FCorrecoes do
    Result := Result + objCorrecao.fRetornaCustoTotal;

  Result := fRetornaValorArredondado(Result);
end;

function TOrdemProducao.fRetornaPrcMedioCorrecoesTotal: double;
var
  objCorrecao : TCorrecao;
begin
  Result := 0;

  for objCorrecao in FCorrecoes do
    Result := Result + objCorrecao.fRetornaPrcMedioTotal;

  Result := fRetornaValorArredondado(Result);
end;

function TOrdemProducao.fRetornaCustoKilo: double;
var
  fltCustoProduzidoTotal  : double;
  fltCustoCorrecoesTotal : double;
  fltPesoEnvasadoTotal   : double;
begin

  fltCustoProduzidoTotal := FFormula.fRetornaCustoProducaoTotalKilo(fRetornaPesoProduzidoTotal);
  fltCustoCorrecoesTotal := fRetornaCustoCorrecoesTotal;
  fltPesoEnvasadoTotal   := fRetornaPesoEnvasadoTotal;

  if fltPesoEnvasadoTotal = 0 then
    Result := 0
  else
    Result := (fltCustoProduzidoTotal + fltCustoCorrecoesTotal) / fltPesoEnvasadoTotal;


  Result := fRetornaValorArredondado(Result);
end;

function TOrdemProducao.fRetornaCustoTotalProducao: double;
var
  fltCustoProduzidoTotal  : double;
  fltCustoCorrecoesTotal : double;
begin
  fltCustoProduzidoTotal := FFormula.fRetornaCustoProducaoTotalKilo(fRetornaPesoProduzidoTotal);
  fltCustoCorrecoesTotal := fRetornaCustoCorrecoesTotal;

  Result := (fltCustoProduzidoTotal + fltCustoCorrecoesTotal);
  Result := fRetornaValorArredondado(Result);
end;

function TOrdemProducao.fRetornaCustoLitro: double;
begin
  result := fRetornaCustoKilo * FFormula.fltPesoReal;
  Result := fRetornaValorArredondado(Result);
end;

function TOrdemProducao.fRetornaPrecoMedioKilo: double;
var
  fltPrcMedioProduzidoTotal  : double;
  fltPrcMedioCorrecoesTotal  : double;
  fltPesoEnvasadoTotal       : double;
begin

  fltPrcMedioProduzidoTotal := FFormula.fRetornaPrecoMedioProducaoTotalKilo(fRetornaPesoProduzidoTotal);
  fltPrcMedioCorrecoesTotal := fRetornaPrcMedioCorrecoesTotal;
  fltPesoEnvasadoTotal   := fRetornaPesoEnvasadoTotal;

  if fltPesoEnvasadoTotal = 0 then
    Result := 0
  else
    Result := (fltPrcMedioProduzidoTotal + fltPrcMedioCorrecoesTotal) / fltPesoEnvasadoTotal;


  Result := fRetornaValorArredondado(Result);
end;

end.

