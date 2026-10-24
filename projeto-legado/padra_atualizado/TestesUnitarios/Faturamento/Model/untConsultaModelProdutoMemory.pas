unit untConsultaModelProdutoMemory;

interface

uses Faturamento.Impostos.Interfaces.Model, Shared.Functions.Types;

type
  TConsultaModelProdutoMemory = class(TInterfacedObject, IResultadoFaturamentoImpostosModelProduto)
  private
    FIpiDeSaida: Double;
    FItemConcreto: String;
    FCodigoDaAbreviacaoFiscal: String;
    FImportacaoDireta: String;
    FUtilizaAmpara: String;
    FCodigoDoFornecedor: String;
    FIpiDeEntrada: Double;
    FFreteDeEntrada: Double;
    FIndustrializacaoOuRevenda: TOpcIndustrializacaoOuRevenda;
    FCodigoDoFornecedorDaUltimaCompra: String;
    FTipoDoFornecedorDaUltimaCompra: String;
    FAtoDeclaratorioDF: Boolean;
  public
    function IpiDeSaida: Double; overload;
    function IpiDeSaida(AValue: Double): IResultadoFaturamentoImpostosModelProduto; overload;
    function ItemConcreto: String; overload;
    function ItemConcreto(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;
    function CodigoDaAbreviacaoFiscal: String; overload;
    function CodigoDaAbreviacaoFiscal(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;
    function ImportacaoDireta: String; overload;
    function ImportacaoDireta(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;
    function UtilizaAmpara: String; overload;
    function UtilizaAmpara(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;
    function CodigoDoFornecedor: String; overload;
    function CodigoDoFornecedor(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;
    function IpiDeEntrada: Double; overload;
    function IpiDeEntrada(AValue: Double): IResultadoFaturamentoImpostosModelProduto; overload;
    function FreteDeEntrada: Double; overload;
    function FreteDeEntrada(AValue: Double): IResultadoFaturamentoImpostosModelProduto; overload;
    function IndustrializacaoOuRevenda: TOpcIndustrializacaoOuRevenda; overload;
    function IndustrializacaoOuRevenda(AValue: TOpcIndustrializacaoOuRevenda): IResultadoFaturamentoImpostosModelProduto; overload;
    function CodigoDoFornecedorDaUltimaCompra: String; overload;
    function CodigoDoFornecedorDaUltimaCompra(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;
    function TipoDoFornecedorDaUltimaCompra: String; overload;
    function TipoDoFornecedorDaUltimaCompra(AValue: String): IResultadoFaturamentoImpostosModelProduto; overload;
    function AtoDeclaratorioDF: Boolean; overload;
    function AtoDeclaratorioDF(AValue: Boolean): IResultadoFaturamentoImpostosModelProduto; overload;
    class function New: IResultadoFaturamentoImpostosModelProduto;
  end;

implementation

{ TConsultaModelProdutoMemory }

function TConsultaModelProdutoMemory.AtoDeclaratorioDF(
  AValue: Boolean): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FAtoDeclaratorioDF := AValue;
end;

function TConsultaModelProdutoMemory.AtoDeclaratorioDF: Boolean;
begin
  Result := FAtoDeclaratorioDF;
end;

function TConsultaModelProdutoMemory.CodigoDaAbreviacaoFiscal(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FCodigoDaAbreviacaoFiscal := AValue;
end;

function TConsultaModelProdutoMemory.CodigoDaAbreviacaoFiscal: String;
begin
  Result := FCodigoDaAbreviacaoFiscal;
end;

function TConsultaModelProdutoMemory.CodigoDoFornecedor(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TConsultaModelProdutoMemory.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

function TConsultaModelProdutoMemory.CodigoDoFornecedorDaUltimaCompra(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FCodigoDoFornecedorDaUltimaCompra := AValue;
end;

function TConsultaModelProdutoMemory.CodigoDoFornecedorDaUltimaCompra: String;
begin
  Result := FCodigoDoFornecedorDaUltimaCompra;
end;

function TConsultaModelProdutoMemory.FreteDeEntrada(
  AValue: Double): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FFreteDeEntrada := AValue;
end;

function TConsultaModelProdutoMemory.FreteDeEntrada: Double;
begin
  Result := FFreteDeEntrada;
end;

function TConsultaModelProdutoMemory.ImportacaoDireta: String;
begin
  Result := FImportacaoDireta;
end;

function TConsultaModelProdutoMemory.ImportacaoDireta(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FImportacaoDireta := AValue;
end;

function TConsultaModelProdutoMemory.IndustrializacaoOuRevenda: TOpcIndustrializacaoOuRevenda;
begin
  Result := FIndustrializacaoOuRevenda;
end;

function TConsultaModelProdutoMemory.IndustrializacaoOuRevenda(
  AValue: TOpcIndustrializacaoOuRevenda): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FIndustrializacaoOuRevenda := AValue;
end;

function TConsultaModelProdutoMemory.IpiDeEntrada: Double;
begin
  Result := FIpiDeEntrada;
end;

function TConsultaModelProdutoMemory.IpiDeEntrada(
  AValue: Double): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FIpiDeEntrada := AValue;
end;

function TConsultaModelProdutoMemory.IpiDeSaida(
  AValue: Double): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FIpiDeSaida := AValue;
end;

function TConsultaModelProdutoMemory.IpiDeSaida: Double;
begin
  Result := FIpiDeSaida;
end;

function TConsultaModelProdutoMemory.ItemConcreto: String;
begin
  Result := FItemConcreto;
end;

function TConsultaModelProdutoMemory.ItemConcreto(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FItemConcreto := AValue;
end;

class function TConsultaModelProdutoMemory.New: IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self.Create;
end;

function TConsultaModelProdutoMemory.TipoDoFornecedorDaUltimaCompra: String;
begin
  Result := FTipoDoFornecedorDaUltimaCompra;
end;

function TConsultaModelProdutoMemory.TipoDoFornecedorDaUltimaCompra(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FTipoDoFornecedorDaUltimaCompra := AValue;
end;

function TConsultaModelProdutoMemory.UtilizaAmpara: String;
begin
  Result := FUtilizaAmpara;
end;

function TConsultaModelProdutoMemory.UtilizaAmpara(
  AValue: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := Self;
  FUtilizaAmpara := AValue;
end;

end.
