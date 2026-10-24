unit Faturamento.Impostos.Tipos.ClassificacaoItem.TransferenciaEstoqueEmpresa;

interface

uses Faturamento.Impostos.Interfaces.ClassificacaoItem.TransferenciaEstoqueEmpresa;

type
  TResultadoClassificacaoItemTransferenciaEstoqueEmpresa = class(TInterfacedObject, IResultadoClassificacaoItemTransferenciaEstoqueEmpresa)
  private
    FTipoDeOperacao: String;
    FClassificacaoDeVendaTributadoSaida: String;
    FClassificacaoDeVendaSubstCombLubrificanteSaida: String;
    FClassificacaoDeVendaSubstDemaisProdutosSaida: String;
    FClassificacaoDeTransferenciaTributadoSaida: String;
    FClassificacaoDeTransferenciaSubstCombLubrificanteSaida: String;
    FClassificacaoDeTransferenciaSubstDemaisProdutosSaida: String;
    FClassificacaoDeCompraSubstDemaisProdutosEntrada: String;
    FClassificacaoDeCompraTributadoEntrada: String;
    FClassificacaoDeTransferenciaSubstDemaisProdutosEntrada: String;
    FClassificacaoDeTransferenciaTributadoEntrada: String;
    FRetornouInformacoes: Boolean;
    FCodigoDaEmpresa: String;
    FClassificacaoDeVendaSubstImpDiretaSaida: String;
  public
    function TipoDeOperacao: String; overload;
    function TipoDeOperacao(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Classificao de venda
    function ClassificacaoDeVendaTributadoSaida: String; overload;
    function ClassificacaoDeVendaTributadoSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeVendaSubstCombLubrificanteSaida: String; overload;
    function ClassificacaoDeVendaSubstCombLubrificanteSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeVendaSubstDemaisProdutosSaida: String; overload;
    function ClassificacaoDeVendaSubstDemaisProdutosSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Classificao de transferencia
    function ClassificacaoDeTransferenciaTributadoSaida: String; overload;
    function ClassificacaoDeTransferenciaTributadoSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeTransferenciaSubstCombLubrificanteSaida: String; overload;
    function ClassificacaoDeTransferenciaSubstCombLubrificanteSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeTransferenciaSubstDemaisProdutosSaida: String; overload;
    function ClassificacaoDeTransferenciaSubstDemaisProdutosSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Classificao de compra
    function ClassificacaoDeCompraSubstDemaisProdutosEntrada: String; overload;
    function ClassificacaoDeCompraSubstDemaisProdutosEntrada(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeCompraTributadoEntrada: String; overload;
    function ClassificacaoDeCompraTributadoEntrada(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Classificao de transferecia
    function ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada: String; overload;
    function ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeTransferenciaTributadoEntrada: String; overload;
    function ClassificacaoDeTransferenciaTributadoEntrada(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function RetornouInformacoes: Boolean; overload;
    function RetornouInformacoes(AValue: Boolean): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Cont. Classificao de venda
    function ClassificacaoDeVendaSubstImpDiretaSaida: String; overload;
    function ClassificacaoDeVendaSubstImpDiretaSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    class function New(): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
  end;

implementation

{ TResultadoClassificacaoItemTransferenciaEstoqueEmpresa }

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeCompraSubstDemaisProdutosEntrada: String;
begin
  Result := FClassificacaoDeCompraSubstDemaisProdutosEntrada;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeCompraSubstDemaisProdutosEntrada(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeCompraSubstDemaisProdutosEntrada := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeCompraTributadoEntrada(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeCompraTributadoEntrada := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeCompraTributadoEntrada: String;
begin
  Result := FClassificacaoDeCompraTributadoEntrada;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaSubstCombLubrificanteSaida(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeTransferenciaSubstCombLubrificanteSaida := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaSubstCombLubrificanteSaida: String;
begin
  Result := FClassificacaoDeTransferenciaSubstCombLubrificanteSaida;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeTransferenciaSubstDemaisProdutosEntrada := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada: String;
begin
  Result := FClassificacaoDeTransferenciaSubstDemaisProdutosEntrada;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaSubstDemaisProdutosSaida: String;
begin
  Result := FClassificacaoDeTransferenciaSubstDemaisProdutosSaida;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaSubstDemaisProdutosSaida(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeTransferenciaSubstDemaisProdutosSaida := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaTributadoEntrada(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeTransferenciaTributadoEntrada := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaTributadoEntrada: String;
begin
  Result := FClassificacaoDeTransferenciaTributadoEntrada;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaTributadoSaida(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeTransferenciaTributadoSaida := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeTransferenciaTributadoSaida: String;
begin
  Result := FClassificacaoDeTransferenciaTributadoSaida;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaSubstCombLubrificanteSaida(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeVendaSubstCombLubrificanteSaida := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaSubstCombLubrificanteSaida: String;
begin
  Result := FClassificacaoDeVendaSubstCombLubrificanteSaida;
end;


function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaSubstImpDiretaSaida(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeVendaSubstImpDiretaSaida := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaSubstImpDiretaSaida: String;
begin
  Result := FClassificacaoDeVendaSubstImpDiretaSaida;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaSubstDemaisProdutosSaida(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeVendaSubstDemaisProdutosSaida := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaSubstDemaisProdutosSaida: String;
begin
  Result := FClassificacaoDeVendaSubstDemaisProdutosSaida;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaTributadoSaida: String;
begin
  Result := FClassificacaoDeVendaTributadoSaida;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.ClassificacaoDeVendaTributadoSaida(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FClassificacaoDeVendaTributadoSaida := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.CodigoDaEmpresa(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

class function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.New: IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self.Create;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.RetornouInformacoes: Boolean;
begin
  Result := FRetornouInformacoes;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.RetornouInformacoes(
  AValue: Boolean): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FRetornouInformacoes := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.TipoDeOperacao(
  AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result := Self;
  FTipoDeOperacao := AValue;
end;

function TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.TipoDeOperacao: String;
begin
  Result := FTipoDeOperacao;
end;

end.
