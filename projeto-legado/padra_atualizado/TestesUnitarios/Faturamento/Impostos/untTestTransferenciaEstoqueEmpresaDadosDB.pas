unit untTestTransferenciaEstoqueEmpresaDadosDB;

interface

uses Faturamento.Impostos.Interfaces.ClassificacaoItem.TransferenciaEstoqueEmpresa,
  Faturamento.Impostos.Tipos.ClassificacaoItem.TransferenciaEstoqueEmpresa;

type
  TTestTransferenciaEstoqueEmpresaDadosDB = class(TInterfacedObject, ITransferenciaEstoqueEmpresaDadosDB)
  private
    FTipoDeOperacao: string;
    FClassificacaoDeTransferenciaTributadoEntrada: string;
    FClassificacaoDeVendaSubstDemaisProdutosSaida: string;
    FClassificacaoDeVendaTributadoSaida: string;
    FClassificacaoDeTransferenciaSubstDemaisProdutosSaida: string;
    FClassificacaoDeVendaSubstCombLubrificanteSaida: string;
    FClassificacaoDeTransferenciaTributadoSaida: string;
    FClassificacaoDeCompraSubstDemaisProdutosEntrada: string;
    FClassificacaoDeTransferenciaSubstDemaisProdutosEntrada: string;
    FClassificacaoDeTransferenciaSubstCombLubrificanteSaida: string;
    FClassificacaoDeCompraTributadoEntrada: string;
    FRetornouInformacoes: boolean;
    FCodigoDaEmpresa: string;
  public
    property TipoDeOperacao: string write FTipoDeOperacao;
    property ClassificacaoDeVendaTributadoSaida: string write FClassificacaoDeVendaTributadoSaida;
    property ClassificacaoDeVendaSubstCombLubrificanteSaida: string write FClassificacaoDeVendaSubstCombLubrificanteSaida;
    property ClassificacaoDeVendaSubstDemaisProdutosSaida: string write FClassificacaoDeVendaSubstDemaisProdutosSaida;
    property ClassificacaoDeTransferenciaTributadoSaida: string write FClassificacaoDeTransferenciaTributadoSaida;
    property ClassificacaoDeTransferenciaSubstCombLubrificanteSaida: string write FClassificacaoDeTransferenciaSubstCombLubrificanteSaida;
    property ClassificacaoDeTransferenciaSubstDemaisProdutosSaida: string write FClassificacaoDeTransferenciaSubstDemaisProdutosSaida;
    property ClassificacaoDeCompraSubstDemaisProdutosEntrada: string write FClassificacaoDeCompraSubstDemaisProdutosEntrada;
    property ClassificacaoDeCompraTributadoEntrada: string write FClassificacaoDeCompraTributadoEntrada;
    property ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada: string write FClassificacaoDeTransferenciaSubstDemaisProdutosEntrada;
    property ClassificacaoDeTransferenciaTributadoEntrada: string write FClassificacaoDeTransferenciaTributadoEntrada;
    property CodigoDaEmpresa: string write FCodigoDaEmpresa;
    property RetornouInformacoes: boolean write FRetornouInformacoes;

    function TransferenciaEstoqueEmpresa(ASQL: String; ACodigoDoCliente:
      String; ACodigoDaEmpresa: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
    class function New: ITransferenciaEstoqueEmpresaDadosDB;
  end;

implementation

uses
  SysUtils;

{ TTestTransferenciaEstoqueEmpresaDadosDB }

class function TTestTransferenciaEstoqueEmpresaDadosDB.New: ITransferenciaEstoqueEmpresaDadosDB;
begin
  Result := Self.Create;
end;

function TTestTransferenciaEstoqueEmpresaDadosDB.TransferenciaEstoqueEmpresa(ASQL,
  ACodigoDoCliente, ACodigoDaEmpresa: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
begin
  Result :=
    TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.New
      .TipoDeOperacao(FTipoDeOperacao)
      .ClassificacaoDeVendaTributadoSaida(FClassificacaoDeVendaTributadoSaida)
      .ClassificacaoDeVendaSubstCombLubrificanteSaida(FClassificacaoDeVendaSubstCombLubrificanteSaida)
      .ClassificacaoDeVendaSubstDemaisProdutosSaida(FClassificacaoDeVendaSubstDemaisProdutosSaida)

      .ClassificacaoDeTransferenciaTributadoSaida(FClassificacaoDeTransferenciaTributadoSaida)
      .ClassificacaoDeTransferenciaSubstCombLubrificanteSaida(FClassificacaoDeTransferenciaSubstCombLubrificanteSaida)
      .ClassificacaoDeTransferenciaSubstDemaisProdutosSaida(FClassificacaoDeTransferenciaSubstDemaisProdutosSaida)

      .ClassificacaoDeCompraSubstDemaisProdutosEntrada(FClassificacaoDeCompraSubstDemaisProdutosEntrada)
      .ClassificacaoDeCompraTributadoEntrada(FClassificacaoDeCompraTributadoEntrada)

      .ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada(FClassificacaoDeTransferenciaSubstDemaisProdutosEntrada)
      .ClassificacaoDeTransferenciaTributadoEntrada(FClassificacaoDeTransferenciaTributadoEntrada)
      .CodigoDaEmpresa(FCodigoDaEmpresa)
      .RetornouInformacoes(FRetornouInformacoes);
end;

initialization

SetObjTransferenciaEstoqueEmpresaDadosDB(TTestTransferenciaEstoqueEmpresaDadosDB.New());

end.

